Return-Path: <bpf+bounces-43334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622A29B3B3E
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 21:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DC62824F4
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC931E0084;
	Mon, 28 Oct 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="PFARb7td";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="pEUOq71W"
X-Original-To: bpf@vger.kernel.org
Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9F1DFD80;
	Mon, 28 Oct 2024 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146796; cv=none; b=kHh1oMNgKljjuTNQYCiqnyVnXj0rRa1jmQjCgDsR9AGdsfTF6oK62rPZSlxOlSGP407WHIgFuIMTSNTVeXHcLdVfk9aR+W0fGp6M2OO5OANsmBzTyyn8qgwoFNgv5X9Ymm7B/aZ5/jqulj7JAUQphPL8c7AYA3jjQk/9GCILIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146796; c=relaxed/simple;
	bh=KQfRGJaZItq+ElLsUnWHrj/DYNU0ce2cUfiZVXRMGlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoQvWNfU4jE7CkIpFhb4itp4kl9bR/9Bw3ZHxBTqMOjn5SbeEAax74/kcif8WXQ4SHyTqeRDvvXLASN9UinnzbDowFM9ozH7iM/+lK8N0AJtf5X/uUOwcV7snEZl63nsJlUeE5cVPgGAIg5PRIKUjB9u+AvU64MmEIs+V80mAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=PFARb7td; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=pEUOq71W; arc=none smtp.client-ip=79.137.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=glnhhx+i6gKzxj9KLVHAVpZB1SnJxndwN/Hz4oC/Eu0=;
	t=1730146791;x=1730236791; 
	b=PFARb7td2gTb15KmnW+HTMA7CQVY67NXWKebNAtUxk1wImmpKMjImVlILDTPs1SAMB3wPvz7pdlLEOZUnS6AP/1OBGYRdlvvDF6evLcF1l1aGiAeBpgyJNPs+h5D+j2vM7ndJT7fi4vQngd48wZWdvYaj/sb5MCI1zGQ5SZmwsXm4g79OIPQGMZl9LOxuzKMtHK6iSwjhF+CCJoTbmyulEuUAGhh/gnd8WV3RVBYsL5iQfcnd1NvBsMJSYo0E1WnwWfEf6PED7XFkPdKxHxIVMZpC/GB59+VU2+XJ28zdtNbjlbszu3Azhj8GlLc+j1nL88mjNQoo2jgnOXqx5d2WA==;
Received: from [10.113.163.192] (port=51660 helo=smtp38.i.mail.ru)
	by fallback2.i.mail.ru with esmtp (envelope-from <rabbelkin@mail.ru>)
	id 1t5VoY-006bQF-TJ; Mon, 28 Oct 2024 22:54:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=glnhhx+i6gKzxj9KLVHAVpZB1SnJxndwN/Hz4oC/Eu0=; t=1730145250; x=1730235250; 
	b=pEUOq71WSmXiXHycGNaYnu5vhp9LBH4wyuG+7Vmhp1ugLAUcoIkuv/s+kXixri8BnCns4UHgjeu
	4HGD8sCxpSAoyyRe3SK3/bYIPQU9XFUaitPXaebkwFV0nB7Vv4rTFgcv+c0TCK0c7NtHKSb9yhu8X
	gRlROR0gVGhZafzD5hCAX5Jln+VeS3tRy+4I0wxHVcl0A9c58YU75lgzZVtky2CV+bpiMD2DGTfHF
	znegTscojtcPPCx0xPzcCmqRJsxznpzGbK4UCO+MwbkDW5zudu4GkU3/9fHYT3VL+T2u5bnFdXy54
	+TMEKs+ZsHDOKEHmYe1IjXHRQAFLbU5Rmksg==;
Received: by exim-smtp-7fbf7c596c-sbqxq with esmtpa (envelope-from <rabbelkin@mail.ru>)
	id 1t5VoJ-000000006rV-1VU2; Mon, 28 Oct 2024 22:53:55 +0300
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
Subject: [PATCH bpf v2 0/2] bpf: enhance validation of pointer formatting
Date: Mon, 28 Oct 2024 19:53:39 +0000
Message-ID: <20241028195343.2104-1-rabbelkin@mail.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 1
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9D07C974FC87D6B314BABF57FCFF4BA48415B9DBF7B44AECD182A05F5380850404C228DA9ACA6FE27ECE76EB95B0996643DE06ABAFEAF67051C7D1E226135B7DDA208E16B82CD5259C9EA2F84C7A79467
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A41A3668A00E2636EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375ABF1810CDE7D0E9EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BC08E230531AC9C908F9765B4BDBF53B3D80C89EF59173010023E86729ECF8D181DF9E95F17B0083B26EA987F6312C9EC1E561CDFBCA1751FC26CFBAC0749D213D2E47CDBA5A96583C09775C1D3CA48CFED8438A78DFE0A9E117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7E688A9D963DC14319FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE723D874C0A8C177C4D32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED6299176DF2183F8FC7C0EAC4A00730FBFA98CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8B8C7ADC89C2F0B2A5AAAE862A0553A39223F8577A6DFFEA7C001E7073F6295F9843847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5F96E5D7AC281F31F5002B1117B3ED6961372341F2A24DF61E99897350C7C491E823CB91A9FED034534781492E4B8EEADED8273DE7764599AC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7161D15182FF9C9CFDDC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D341E2D05735FCBECD1FFD14EBBD9AD9204A2FA6610A844BECE90923416B18908DB3D8169947BA46F231D7E09C32AA3244CC5E59EB96BD1BC8477DD89D51EBB77426BA2278A71D5C0DFEA455F16B58544A28250C654278CF0C25DA084F8E80FEBD30F6C96C8BECED5F88740F363FB76557E83DB18EBE73F7D69
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxgmIyQdMaRr2B/bqfXpxWg==
X-Mailru-Sender: 520A125C2F17F0B129A91D4D2C73336D0F53F26F5F54BC213DE06ABAFEAF67051C7D1E226135B7DD87BBD21BC54961EB7D4011A27D7B18D45A92E71CC7C3152D768DA86FCF4447625FD6419AF7853D25851DE5097B8401C6C89D8AF824B716EB3E16B1F6FB27E47C394C4C78ECC52E263DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4EB5CF5EDE64A1802999F17DC78C05B0033072310252532FE049FFFDB7839CE9E1556864DF1AA0A91F567D1B474046C6DB516BE179D9486FD4A68CAB822381144
X-7FA49CB5: 0D63561A33F958A5DDAA8DB7B43C6685C96FADB8E9047E391F16B5D62E3678B5CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637472278D6E477862C389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC86D54F496F0B06251F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7897BF32459B96943731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxgmIyQdMaRqPENFT768mVw==
X-Mailru-MI: 8002000000000800
X-Mras: Ok

This patch series enhances validation of pointer formatting to prevent same
exact issue happening again, as it happen before in [0] and happened now.

[0]: https://lkml.kernel.org/netdev/85a08645-453b-78ad-e401-55d2894fa64a@iogearbox.net/T/

Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
---
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


