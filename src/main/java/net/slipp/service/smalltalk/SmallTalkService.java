package net.slipp.service.smalltalk;

import java.util.List;

import javax.annotation.Resource;

import net.slipp.domain.smallTalk.SmallTalk;
import net.slipp.repository.smalltalk.SmallTalkRepository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service("smallTalkService")
public class SmallTalkService {

	private Logger logger = LoggerFactory.getLogger(SmallTalkService.class);

	@Resource (name = "smallTalkRepository")
	private SmallTalkRepository smallTalkRepository;

	public void save(SmallTalk smallTalk) {
		logger.debug("SmallTalk : {}", smallTalk);
		smallTalkRepository.save(smallTalk);
	}

	public List<SmallTalk> getLastTalks() {
		PageRequest pageSpecification = new PageRequest(0, 10, sortByIdDesc());
		Page<SmallTalk> pages = smallTalkRepository.findAll(pageSpecification);
		return pages.getContent();
	}

	private Sort sortByIdDesc() {
		return new Sort(Sort.Direction.DESC, "smallTalkId");
	}
}
