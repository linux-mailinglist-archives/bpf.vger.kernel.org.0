Return-Path: <bpf+bounces-45166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6724A9D2385
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE6CB24E7E
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99FC1C7B8E;
	Tue, 19 Nov 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="tn7fCRD3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="CIlW9iT1"
X-Original-To: bpf@vger.kernel.org
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8E1C75F3;
	Tue, 19 Nov 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011820; cv=none; b=TSx7MLO9mHKV16lI6wyw4A3M1FsPPRZwp+cefwrJSbTvqdn8qLyHJoofU9yPTpiS51xqiVsPAejX+22AuN2UEBPxU5t8XcBtJhCbm0TMZ9UbBazxzK5DSS4gOrqYr8bOP9AT6vs6TSMBY8SAoWrcI41ugigrzVJRw2IYAg6U0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011820; c=relaxed/simple;
	bh=YI335nCfl77muzcVzZnkN0d33X8H9ZX9EAEDnVRl474=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcCGy9RgyTKfTBADxBCDPSWKvhtFQFakG0CGuVzSadJMduYYFqLWcbjWOlKfYzJRyhCRBj/nKvjJ3Or35iEpW8Czg32iM7EZpc4jxobF3yBe2skq1aZvSnIoFCqMr3YlvPcfXFJJdzs4V/kHyMq8N72SrJoGZhHbP4/FTxyT2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=tn7fCRD3; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=CIlW9iT1; arc=none smtp.client-ip=79.137.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Bwio3iTRA70IppIhvk9WE1qJXC7mdmtUOn4t8OuSt2g=;
	t=1732011817;x=1732101817; 
	b=tn7fCRD3vru+QjG2ivcavtI0gso4cx2ZoFc0aGS/YcoKI1e3P32oeGrCFPYHJnnToCVkH9puG0vvf1uCPJDKQIsjlSoKgJZw99lekXPBn4z9thgjwALux1LxK0bTi8rdTa7CWHTTIE0Rk9XDYPlqHxKQmyDJDCXEgTJ1ZdlLwQHjv1BEXzcWa/0X+VuualYo2Nwx1kWzslQP6HAeYYe1HPpMEhZ8Xy2+I2//bM5FPulIKEYSYpUsmVeUK29LqueOqhTfxyp+XE1t1bhSlub/Ujsd4odWjNPg9tO382ECXPH/L1UCjGuDO8uZSqQ36IrEFGTbLQz7P7SYWwcDtt/Diw==;
Received: from [10.113.82.41] (port=54694 helo=smtp16.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <rabbelkin@mail.ru>)
	id 1tDLOL-00Er5J-Ol; Tue, 19 Nov 2024 13:23:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=Bwio3iTRA70IppIhvk9WE1qJXC7mdmtUOn4t8OuSt2g=; t=1732011809; x=1732101809; 
	b=CIlW9iT19Tf75SmenDiYbeBWH0xIHmGdCqYcS29sTA03oyGp1JzDITwRI6v1d3kXPXXDX2Ut1dC
	EU1Dwa9+Kpo3YXm0MfJ5pqY2K05eWcHveTNlO9RG/AXRopLiPYhU3DBDs1j7XJQuriHog55u01Zkx
	PCzwoV7fOBnP8cK6C+Y4VTdqAj9vusFnV64d2QhcIrg/jDdjKYrE3DBJm+fkmrdEh18Mm+NBaG7KE
	hHpKP3t7OI/Wm2mN5MTFSQ+TsZlBltE/b7Z1SR1dYKMH1SpRLdGHhrDI+5Y4UrLpbthSN9u47JAqz
	xbqxXOgKVOxvZplRqYZKUP/b6diLUipdCTMw==;
Received: by exim-smtp-68dd957ff6-p9gt6 with esmtpa (envelope-from <rabbelkin@mail.ru>)
	id 1tDLO7-00000000CiI-3pf1; Tue, 19 Nov 2024 13:23:16 +0300
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
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add test cases for various pointer specifiers
Date: Tue, 19 Nov 2024 10:22:13 +0000
Message-ID: <20241119102214.2145-3-rabbelkin@mail.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119102214.2145-1-rabbelkin@mail.ru>
References: <20241119102214.2145-1-rabbelkin@mail.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95367647A2C12583F07DF18CE56546FBA61FB4D74D5DEC7B9182A05F5380850404EA263F8E192F2A43DE06ABAFEAF6705F21D5096FF39102CFC233B5B959DB54AE4D98B9586BF5A92
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE716FAD50E497B9C14EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637BA5555A0C16230F4EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BC08E230531AC9C905932D1C3264F0C189F07E2BCE273AAC3BCB3A4AF767CD52C1DF9E95F17B0083B26EA987F6312C9EC33AC447995A7AD186FD1C55BDD38FC3FD2E47CDBA5A96583C09775C1D3CA48CFCAFEF312542AECBE117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE754B4581DB7A805049FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE72C863EFEC9FF6EE4D32BA5DBAC0009BE395957E7521B51C2330BD67F2E7D9AF1090A508E0FED6299176DF2183F8FC7C046629162691A9FFFCD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269176DF2183F8FC7C0D75EB778CE7D8A0C68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CC7B6046D9B34CB7443847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A53E46D75CAF507A025002B1117B3ED6961747DBD0187DA69AF09842853758E9E5823CB91A9FED034534781492E4B8EEADDFC043C56F70D752C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF1FB62DEA29AFBD59AD5D3D233C9FC33100A15DAABFA6A9D9A9E48E0B2704AFF9C419EA6F1489DB160C86AA3C630759CECBFA8F0E1C9D7F92803A5E51012C5D8C9ADF5B4EC52C9F88F59F2EA2782EDE9C02C26D483E81D6BE52C818B45C5DF227C6320D7D8A56C4C1F0A6D2C91ED28CB6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpjtgd3uP0q1jbj2GBkGIOQ==
X-Mailru-Sender: 520A125C2F17F0B129A91D4D2C73336D1A5788EA04FA926C3DE06ABAFEAF6705F21D5096FF39102C87BBD21BC54961EB7D4011A27D7B18D45A92E71CC7C3152D768DA86FCF4447625FD6419AF7853D25851DE5097B8401C6C89D8AF824B716EB3E16B1F6FB27E47C394C4C78ECC52E263DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B454E1DAF28AA7D56D7BEFEAADD8CAC7AC5ED8656E829CA206049FFFDB7839CE9EBEC99E045F597705F6E51C7CF0C7A794A3E2DCE75F5296CAA3F190F9B220F1E8
X-7FA49CB5: 0D63561A33F958A5CD87ED8CE2202CD2EFC6D3B9614D50B1EE044F9D500EDB87CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637B973D7F15157FFE0389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC818D8550C6557D092F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE77D11AC4126952D87731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpjtgd3uP0q0dGQBpkG9I/Q==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Extend snprintf negative tests to cover pointer specifiers to prevent
possible invalid handling of %p% from happening again.

 ./test_progs -t snprintf
 #302/1   snprintf/snprintf_positive:OK
 #302/2   snprintf/snprintf_negative:OK
 #302     snprintf:OK
 #303     snprintf_btf:OK
 Summary: 2/2 PASSED, 0 SKIPPED, 0 FAILED

Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Florent Revest <revest@chromium.org>
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


