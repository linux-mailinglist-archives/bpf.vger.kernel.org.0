Return-Path: <bpf+bounces-45164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0439D2381
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84151F21E06
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAC71C5798;
	Tue, 19 Nov 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="P27YSLUJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="HIoW4cZr"
X-Original-To: bpf@vger.kernel.org
Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD41BE87C;
	Tue, 19 Nov 2024 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011813; cv=none; b=YdaOyJ66syqxsI3pkR+arraAmSu89lZRXao5b/K6ymqx5YaeHPpNoo4ByWgmDrbsQaJFY5NykH1Bbvgs2b1e3rgnP0Rij8rfpnG3QI+ZMV6iyVa0ZJSrvpR6LPzJZ/12SewjblFDMsgGIU+rE21jeTzOaUqsx+EBEr2Fsihwy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011813; c=relaxed/simple;
	bh=MtZNIjFYWVfKY3IxR2nSsTBBHd+br8tEg+e+Z8FWH48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EV7XNGG0LG5VhcAF16d/QxppLSCWTdNNTGFs2ezsj1Tx99HL9R60G7ZhgB4bbtkh5idFchWNJykioX2IL7XPKnqpndpGv3Z64XzAX5aXy0dVmI1aHLdOBjNYwuy15U9JvMSjWjdYnedzDXB2mMJoe/uh/IoBzJrjYrFJfzLPiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=P27YSLUJ; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=HIoW4cZr; arc=none smtp.client-ip=79.137.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=AB7yvSqkAES0vZHbCf+29jGm1KwF/8yAgU76MC1Seg4=;
	t=1732011810;x=1732101810; 
	b=P27YSLUJdNJ8evLYH0trHje5Muo/2eUcouPOrTf9O3TR8vNf7SmfuDHxrn2kDLUkEEOKGjB0Q8OaKigi5tlOj2qGF7td20y3q9Z0S3UDpQo0Gkqyi51cTjHd87co9XBwYC+/5pijRjoyfkTRX1hZSz07VJhFuEe2aZuotpW7KISKrTio76mvSmgSaegptL3trOMWVC0ajWfy6mad0YKRKGXLBXVJd5ZL4yUIZt9KmEeck82MYH4uOBk9T2eQodG1lZWp0tWOY3XjUWZ0uzPgFmBWZM7IO/nyPBKEmreo/EXXmxWf0hVrp/AVJ8wv4L9M6vKcHUmgL6uQA/9L4B7yOQ==;
Received: from [10.113.127.128] (port=59532 helo=smtp58.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <rabbelkin@mail.ru>)
	id 1tDLOD-00566w-Ec; Tue, 19 Nov 2024 13:23:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=AB7yvSqkAES0vZHbCf+29jGm1KwF/8yAgU76MC1Seg4=; t=1732011801; x=1732101801; 
	b=HIoW4cZr1gYdQz60miqGeK5FAGNGNNQF3tbpEnRRYShV6r5HvOSSqeRFU2SAvnEKseT/ru1hUea
	PE6N4Q/7sr9ovY6I0rz/50+swJB0L3uiJl7nHgdgxLv7eNzCAZm++u0Znwd4E45XXV+Mr52mD2C4C
	NxRDWB3PIHaIeq2MwIFiZAT7NziG5MAljuuxVS6J3bd5v+C2Jybhe81FSjT3mYHg3rirrvSzc+BbE
	uc5rHxjMEL6E0DossJZ09IMfDRTrbem22cGw2hscoaDsCd5WjObBWho6wZ7ijUFIMfEnG/ha525bA
	c6OR2PKLZ5ykmTzbtKNpUbfXt+dyz0xiysFw==;
Received: by exim-smtp-68dd957ff6-p9gt6 with esmtpa (envelope-from <rabbelkin@mail.ru>)
	id 1tDLNx-00000000CiI-3g1Y; Tue, 19 Nov 2024 13:23:06 +0300
From: Ilya Shchipletsov <rabbelkin@mail.ru>
To: bpf@vger.kernel.org
Cc: Ilya Shchipletsov <rabbelkin@mail.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Florent Revest <revest@chromium.org>,
	Nikita Marushkin <hfggklm@gmail.com>,
	lvc-project@linuxtesting.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf: enhance validation of pointer formatting
Date: Tue, 19 Nov 2024 10:22:11 +0000
Message-ID: <20241119102214.2145-1-rabbelkin@mail.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9EE4D1B4B9F585502BD3E32282AE66D936A431BD1617CBD59182A05F538085040E954BE02A139DF143DE06ABAFEAF67057B488DCED9258565FC233B5B959DB54AE93E1AEB4077C98C
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE707FD2F46D4FEEE7FC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7F6EE1C40B2E8BE15EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BC08E230531AC9C9037B526E81B5279CD9F07E2BCE273AAC362CF0BDAE02A677A1DF9E95F17B0083B26EA987F6312C9EC33AC447995A7AD18BDFBBEFFF4125B51D2E47CDBA5A96583C09775C1D3CA48CFED8438A78DFE0A9E117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7E688A9D963DC14319FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE71A9A9D07B6751A07D32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED6299176DF2183F8FC7C0F4A3654BDD83CEEBCD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B621AEC8D36C788AAE089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A58F566DBA3E67B5B95002B1117B3ED696A0DEEB10F689A237CCE9A60C8CB01D7C823CB91A9FED034534781492E4B8EEADE0C144949FACE77EC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34E318F287A436F24CD8E3CCCACD618061905ED190EEB347E765287F9C54148870F78C56F54F27A3261D7E09C32AA3244C8DD635B337DEDEC677DD89D51EBB7742D4C3C8F8670687B8EA455F16B58544A28250C654278CF0C25DA084F8E80FEBD30F6C96C8BECED5F88740F363FB76557E83DB18EBE73F7D69
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpjtgd3uP0q3OyoT5rihwYA==
X-Mailru-Sender: 520A125C2F17F0B129A91D4D2C73336DB7EFA1A06CBF6A653DE06ABAFEAF67057B488DCED925856587BBD21BC54961EB7D4011A27D7B18D45A92E71CC7C3152D768DA86FCF4447625FD6419AF7853D25851DE5097B8401C6C89D8AF824B716EB3E16B1F6FB27E47C394C4C78ECC52E263DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4627F043E32F6F38D6858A64E51D93CC603595D0356BF530EB647ED114AB003AC4F6C5ED74B3D22F6E8A37998CCF2C7D998D27A52FCD368BCADF1BBD469F3E3EF
X-7FA49CB5: 0D63561A33F958A500F162EE2AA5C4B7227921785FB16F1817316B3A2B70D3F5CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F790063703FA1A300AE80F73389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80C6F18EE27F98D4EF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7A5F6577D0D66DD99731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpjtgd3uP0q2oi4XUec7ILw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

This patch series enhances validation of pointer formatting to prevent same
exact issue happening again, as it happen before in [0] and happened now.

[0]: https://lkml.kernel.org/netdev/85a08645-453b-78ad-e401-55d2894fa64a@iogearbox.net/T/

Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
---
Changes in v3:
- Resend due to odd "Changes Requested" status in Patchwork, although
  there've been no additional comments posted on mailing lists explaining
  that status.
- Add Yonghong's and Florent's ACKs.
- Link to v2: https://lore.kernel.org/bpf/20241028195343.2104-1-rabbelkin@mail.ru/
Changes in v2:
- Added Reported-by for syzbot [Florent Revest]
- Added negative tests for snprintf [Florent Revest]
- Moved comment to first 'if' statement [Yonghong Song]
- Link to v1: https://lore.kernel.org/bpf/9679a031-3858-4fef-bb8e-1cf436696095@mail.ru/
---
Ilya Shchipletsov (2):
  bpf: fix %p% runtime check in bpf_bprintf_prepare
  selftests/bpf: Add test cases for various pointer specifiers

 kernel/bpf/helpers.c                              | 13 +++++++++----
 tools/testing/selftests/bpf/prog_tests/snprintf.c | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)
-- 
2.43.0


