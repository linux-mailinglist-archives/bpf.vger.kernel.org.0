Return-Path: <bpf+bounces-43331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525BE9B3ADC
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09641F227E9
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42B11DF75D;
	Mon, 28 Oct 2024 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="UMGho6vI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="akjZjtMG"
X-Original-To: bpf@vger.kernel.org
Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9518D65D;
	Mon, 28 Oct 2024 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145269; cv=none; b=b76xyRBNJLcUzGQZ3UrcKXFZi3tQO+tO3GQzfU22qyEkwP/Zu2Z5p1wJ+itM3bD6SubmxZO5yFZZAx3bRwJ/pa1AEAHlySyQkoGH6IfE7x0x6rHg4j4PHWeCcULOctK46HxlQC8CNp5ITDZoAoHlC+lFS4n4/qEwt8s4efwAHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145269; c=relaxed/simple;
	bh=Sojk6N7wnwWRlGdzWuCbA+vYrY8wNmzrWlgb7x5jdHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns+UMvjZx/c5Ad7TxTGp1SCcBpIYKnys4/PBHYjY4AuveBNkFZTd6P0fIOnJLcNiUg8sDF6NzzKAPPeModndYKbgLd6paj6Jznmuhg2OwikAbHmQkvVCujaIKTS97EFWHG+woXmtl0l8nvAz1UUaLfF8kRLRumOq9LxoFN7Z3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=UMGho6vI; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=akjZjtMG; arc=none smtp.client-ip=79.137.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=CXtGQsra+jGQcjm2CHPFPwXmSP8B/c+y+d6L5EVC1rk=;
	t=1730145266;x=1730235266; 
	b=UMGho6vI7gb+W7OEnWh4DvXyE/7H1egBNADM2Eg/vFa//qOfChglKMQCwAwmh67Kjba87BUtKdvoCDCX1eazq5mX3AXYqOO8SGSm+PPCzPlKKdIynyCkOwo7pgsXjyPX7rWL6YghYEIXhkLN2/nSr8IqwrrqICMuaz5aLLYYfm2hwbxJyXRU/D0itbIYH7GzqNOaOsPzC45v3RbhQLPlOLDay0lY+9opK7N0me+9WXyP45pdqFfeWjjIwVkK8+5RJW5xZaJV58n3TeDmor1VkgcHJPjl5OJcMr64wnCnHLbCtw1AcFcigSyJXtphCBA2l2kl9204+KGtRRlKe63Niw==;
Received: from [10.113.110.223] (port=54746 helo=smtp36.i.mail.ru)
	by fallback20.i.mail.ru with esmtp (envelope-from <rabbelkin@mail.ru>)
	id 1t5Vof-00A98b-Ek; Mon, 28 Oct 2024 22:54:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=CXtGQsra+jGQcjm2CHPFPwXmSP8B/c+y+d6L5EVC1rk=; t=1730145257; x=1730235257; 
	b=akjZjtMGa8IIZo/b5EFVieZ9a9hWJqCg3TxrikEz+cBjyy9b2wbi1cbV2E4iSPd5XNiLJqW5gQu
	hASch+vr9DB4H6lT6tNHAsMc5QDLNHVvcWU5QVQQCU/2/yUnb7J/P0XdDhkqyeLJjSItXAvgRFptc
	S5XzKoJLulWtiduqN9gLeYYrHAxNEVy5pbgnJal19Q4Ati8MzCj3GwSwMSpxPlEHOsP0c8NXZqR5S
	wUWRfm0XlK1+cnjnXSN+NZyfazsGqlX7SiwkjGrrGQlAsdIVErKVKDG9rGXd+hKlGg7vf8VJdIPy8
	+SserecpOtrPNNuZjg88MFz41qL4zZxqA0cg==;
Received: by exim-smtp-7fbf7c596c-sbqxq with esmtpa (envelope-from <rabbelkin@mail.ru>)
	id 1t5VoR-000000006rV-0o0p; Mon, 28 Oct 2024 22:54:03 +0300
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
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add test cases for various pointer specifiers
Date: Mon, 28 Oct 2024 19:53:41 +0000
Message-ID: <20241028195343.2104-3-rabbelkin@mail.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028195343.2104-1-rabbelkin@mail.ru>
References: <20241028195343.2104-1-rabbelkin@mail.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 1
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD93D9A9D6B1727919203E986ABC9713261204B89095A57F04B00894C459B0CD1B9568215A4BAEEE74E2EB5D77EF37489D192E38BE355DC526B1905FAAC1F16330F0DE140DF427568CF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78CB87876C5D626D4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637B997C8222C70C3D98638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FE72B00C5E033244E21390611866FCBA8F180F406BA0658820879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C09DFF8554865147A68941B15DA834481FA18204E546F3947C8ED1AC82D843A2BBF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063765D76192D7FB77C9389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637B775EF3F08B89AD9D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE70A00A20C944AFE51EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B64854413538E1713F75ECD9A6C639B01B78DA827A17800CE79178F0054B4A1A06731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5B872DB04080F9CAF5002B1117B3ED6966ECC317AAAB105878D59E407A97E9958823CB91A9FED034534781492E4B8EEADA3FB0D9844EF8EC5C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFF6B5B75E24BA7EBF81CA81DF586A8CD290030A42D67C25CC886D4A63DB510BC766971B16C155F0C962F6083D2AD86BCEE3427642E114ED56B13A1D2A028F3448B9E4FD7E1D165CABF59F2EA2782EDE9C02C26D483E81D6BE52C818B45C5DF227C6320D7D8A56C4C1F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxgmIyQdMaRrbAqndhKQjBA==
X-Mailru-Sender: 520A125C2F17F0B129A91D4D2C73336DE9C4242A76238EA83DE06ABAFEAF6705181C09B76A668D6B87BBD21BC54961EB7D4011A27D7B18D45A92E71CC7C3152D768DA86FCF4447625FD6419AF7853D25851DE5097B8401C6C89D8AF824B716EB3E16B1F6FB27E47C394C4C78ECC52E263DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4EB5CF5EDE64A1802999F17DC78C05B0033072310252532FE049FFFDB7839CE9E1556864DF1AA0A9177A516F59BF4FE68F40B670EE0ECBCA6A3C0A5EA3412347B
X-7FA49CB5: 0D63561A33F958A505C10219E8DBF734CB31C400650F64C9D0011A75FF71EC74CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006375AF8D92B4C156C50389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC88AC305E826530DECF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7897BF32459B96943731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojxgmIyQdMaRq9oEuoHmpBPQ==
X-Mailru-MI: 8002000000000800
X-Mras: Ok

Extend snprintf negative tests to cover pointer specifiers to prevent possible
invalid handling of %p% from happening again.

 ./test_progs -t snprintf
 #302/1   snprintf/snprintf_positive:OK
 #302/2   snprintf/snprintf_negative:OK
 #302     snprintf:OK
 #303     snprintf_btf:OK
 Summary: 2/2 PASSED, 0 SKIPPED, 0 FAILED

Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
---
 tools/testing/selftests/bpf/prog_tests/snprintf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
index 4be6fdb78c6a..b5b6371e09bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -116,6 +116,21 @@ static void test_snprintf_negative(void)
 	ASSERT_ERR(load_single_snprintf("%llc"), "invalid specifier 7");
 	ASSERT_ERR(load_single_snprintf("\x80"), "non ascii character");
 	ASSERT_ERR(load_single_snprintf("\x1"), "non printable character");
+
+	ASSERT_OK(load_single_snprintf("valid %p"), "valid usage");
+
+	ASSERT_ERR(load_single_snprintf("%p%"), "too many specifiers 1");
+	ASSERT_ERR(load_single_snprintf("%pK%"), "too many specifiers 2");
+	ASSERT_ERR(load_single_snprintf("%px%"), "too many specifiers 3");
+	ASSERT_ERR(load_single_snprintf("%ps%"), "too many specifiers 4");
+	ASSERT_ERR(load_single_snprintf("%pS%"), "too many specifiers 5");
+	ASSERT_ERR(load_single_snprintf("%pB%"), "too many specifiers 6");
+	ASSERT_ERR(load_single_snprintf("%pi4%"), "too many specifiers 7");
+	ASSERT_ERR(load_single_snprintf("%pI4%"), "too many specifiers 8");
+	ASSERT_ERR(load_single_snprintf("%pi6%"), "too many specifiers 9");
+	ASSERT_ERR(load_single_snprintf("%pI6%"), "too many specifiers 10");
+	ASSERT_ERR(load_single_snprintf("%pks%"), "too many specifiers 11");
+	ASSERT_ERR(load_single_snprintf("%pus%"), "too many specifiers 12");
 }
 
 void test_snprintf(void)
-- 
2.43.0


