package net.slipp;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import net.slipp.qna.IndexPage;
import net.slipp.qna.NewTagsPage;
import net.slipp.qna.QuestionFixture;
import net.slipp.qna.QuestionPage;
import net.slipp.qna.QuestionsFormPage;
import net.slipp.support.AbstractATTest;

import org.junit.Before;
import org.junit.Test;

public class QnAAT extends AbstractATTest {
    private QuestionFixture questionFixture;
    private IndexPage indexPage;
    
    @Before
    public void setup() {
    	super.setup();
    	questionFixture = new QuestionFixture();
    	driver.get("http://localhost:8080");
    }
    
    @Test
    public void 질문이_정상적으로_등록() {
    	loginToFacebook();
    	createQuestion(questionFixture);
    }

    @Test
    public void 신규태그_정상적으로_등록() {
        loginToFacebook();
        QuestionsFormPage qnaFormPage = indexPage.goQuestionForm();
        questionFixture.setPlainTags("java javascript newtag");
        QuestionPage questionPage = qnaFormPage.question(questionFixture);
        NewTagsPage newTagsPage = questionPage.goNewTagsPage();
    	assertThat(newTagsPage.existNewTag("newtag"), is(true));
    }
    
    @Test
	public void 답변이_정상적으로_등록() throws Exception {
    	loginToFacebook();
    	createQuestion(questionFixture);
    	indexPage.logout();
    	loginToTwitter();
    	answerToQuestion();
	}
    
    @Test
	public void 로그인과_로그아웃_답변에_대한_공감() throws Exception {
    	loginToFacebook();
    	createQuestion(questionFixture);
    	indexPage.logout();
    	loginToTwitter();
    	QuestionPage questionPage = answerToQuestion();
    	questionPage.likeAnswer();
    	questionPage.verifyLikeCount("1");
    	
    	indexPage.logout();
    	indexPage.goTopQuestion();
    	questionPage.likeAnswer();
    	verifyLoginPage();
	}

	private void verifyLoginPage() {
		assertThat(driver.getTitle(), is("로그인 :: SLiPP"));
	}

	private QuestionPage answerToQuestion() {
		String answer = "정확히 내가 바라는 답변이다.";
    	QuestionPage questionPage = indexPage.goTopQuestion();
    	questionPage.answer(answer);
    	questionPage.verifyAnswer(answer);
    	questionPage.verifyAnswerCount("1");
    	return questionPage;
	}

    
	private void createQuestion(QuestionFixture questionFixture) {
        QuestionsFormPage qnaFormPage = indexPage.goQuestionForm();
        QuestionPage questionPage = qnaFormPage.question(questionFixture);
        questionPage.verify(questionFixture.getTitle(), questionFixture.getContents(), questionFixture.getPlainTags());
	}
    
    private void loginToFacebook() {
        indexPage = new IndexPage(driver);
        indexPage = indexPage.loginToFacebook(environment.getProperty("facebook.email"), environment.getProperty("facebook.password"));
    }
    
    private void loginToTwitter() {
        indexPage = new IndexPage(driver);
        indexPage = indexPage.loginToTwitter(environment.getProperty("twitter.username"), environment.getProperty("twitter.password"));
    }
}
