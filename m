Return-Path: <bpf+bounces-36167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B23943678
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C541F21B45
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 19:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697A15FA6D;
	Wed, 31 Jul 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI7OeYkn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773C3CF74
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454313; cv=none; b=PLDo8kGuP+mED3GEwc13zt/4VsfQJBLH6LFwBw196ZMBvzx9gshrX+W0kPTAsei7lVqmTimTht+WW9s8VNdhajKEDb1aaFHPDEHn9BRam9QnrV+MsZ8rc0gz6ibLQ1bmrlnvM1GeLB4GYRDdM+Qf4duU6tl3AUmHC3mXL/V1hLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454313; c=relaxed/simple;
	bh=y4uf3at/AZc0K35b29fw4wrPJj4LrED6wuLVlVhQhKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhrFySN8SsyxxtRcwwc6VkHbfZcHV7MDkoJ/SA4LsfKkzEpk8DdFCwbLLJ0FZ016++/rUo2A2OzIV46yEMoSu11xNI9DrLAQC6aRm0E+U75tDw9BeeWGpP7u+HHMcrKfyCfDUykjOCMd4M/jGUSYlGDYFs5FeljeHmXkhhMt4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI7OeYkn; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6694b50a937so57593557b3.0
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722454310; x=1723059110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb1IT8a2NRtJsOq6rWofW1mEzfnQIeoHlZepVA7unLc=;
        b=RI7OeYknL6I/nIKx2ZUZm4DQdN0FFOKKvnk0W1DUQO488JoyAmQf0MRKN+UhlwKulf
         OeU8ATBJRPJsydqekQis5LFBQ9WLyl+aBBslicprRXj0q3cdaPkRsEM56PHEwn1CcmRN
         Ob7o/h5WmbC1lh94Pxmhb7E19+uwm5gi3BcZ+HrT+pTTZ3xNNLNLdhKuDVivOSFifn5X
         PlI1kKDE+MCSIQeRvtkx2S34GW3cMS/EghqVItJLkJfn+HHkb1sfuA48ZXG+4bc3e4rF
         6/aDgWgraLS5ni2BIMyCRRicbRl828Btb1NLTzvkpggWWgpOSEe1h7mo+qbtDR4SdAw6
         rnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722454310; x=1723059110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb1IT8a2NRtJsOq6rWofW1mEzfnQIeoHlZepVA7unLc=;
        b=n8Yak2+3hJ4xSyeVsamGQnKG8NYVYSYZmAO7/ePUwLAlp3nkyjlS4Z7BigMjf2A/Ca
         e2aRKztReQwrEp+EfC6sa1KCpS9WqjmfBMDaUeoedNTqOMOk5raN4ZgxkrLrNAgvvrgk
         bemMkQAlBIS88nu+6D1T/sRRVIwmWMlrzPgrrcsdFgwHx+kvrGmzzz9IcjQQrBSQ0UUJ
         ePV+9Yg2PAX6MLNIJbu9V8T9UsPP3bERTmLbDkapXMnzhzb5BKiUoJix3RFI1KRqoWku
         ifUKTbpXXSyCr+8xLKZAyuicnKjiBltcYQMmXjoFAVcUUE+JJRDUI79X85HpmMccTykg
         PZ5w==
X-Gm-Message-State: AOJu0YzgCWYbqjNtF4QgfiHGP1wZStuF0jBZ+M0GKPRHewFk9ZeuAzCn
	rsKxWjAoejkjfguaE692A9zKXwKsI9fU3QZia1v8FzWntixea/IDb4JdrRMI
X-Google-Smtp-Source: AGHT+IE2uY2kV7xOpxIcB9XbX7br2ZlaVWzs5ay+0gR3S/+2oBLxqpkJZxq9MmyPIDj2rdm9BRyayg==
X-Received: by 2002:a81:c244:0:b0:664:5e22:21c0 with SMTP id 00721157ae682-6874cc21e06mr1931447b3.19.1722454310604;
        Wed, 31 Jul 2024 12:31:50 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c6db:9dfe:1d13:3b2e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024ab1sm30891597b3.91.2024.07.31.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:31:50 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me,
	geliang@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Monitor traffic for select_reuseport.
Date: Wed, 31 Jul 2024 12:31:40 -0700
Message-Id: <20240731193140.758210-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731193140.758210-1-thinker.li@gmail.com>
References: <20240731193140.758210-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable traffic monitoring for the subtests of select_reuseport.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/select_reuseport.c         | 39 +++++++------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 64c5f5eb2994..1bb29137cd0a 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -37,9 +37,7 @@ static int sk_fds[REUSEPORT_ARRAY_SIZE];
 static int reuseport_array = -1, outer_map = -1;
 static enum bpf_map_type inner_map_type;
 static int select_by_skb_data_prog;
-static int saved_tcp_syncookie = -1;
 static struct bpf_object *obj;
-static int saved_tcp_fo = -1;
 static __u32 index_zero;
 static int epfd;
 
@@ -193,14 +191,6 @@ static int write_int_sysctl(const char *sysctl, int v)
 	return 0;
 }
 
-static void restore_sysctls(void)
-{
-	if (saved_tcp_fo != -1)
-		write_int_sysctl(TCP_FO_SYSCTL, saved_tcp_fo);
-	if (saved_tcp_syncookie != -1)
-		write_int_sysctl(TCP_SYNCOOKIE_SYSCTL, saved_tcp_syncookie);
-}
-
 static int enable_fastopen(void)
 {
 	int fo;
@@ -795,6 +785,7 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 	};
 	char s[MAX_TEST_NAME];
 	const struct test *t;
+	struct netns_obj *netns;
 
 	for (t = tests; t < tests + ARRAY_SIZE(tests); t++) {
 		if (t->need_sotype && t->need_sotype != sotype)
@@ -808,9 +799,23 @@ static void test_config(int sotype, sa_family_t family, bool inany)
 		if (!test__start_subtest(s))
 			continue;
 
+		netns = netns_new("test", true);
+		if (!ASSERT_OK_PTR(netns, "netns_new"))
+			continue;
+
+		system("ip link set dev lo up");
+
+		if (CHECK_FAIL(enable_fastopen()))
+			goto out;
+		if (CHECK_FAIL(disable_syncookie()))
+			goto out;
+
 		setup_per_test(sotype, family, inany, t->no_inner_map);
 		t->fn(sotype, family);
 		cleanup_per_test(t->no_inner_map);
+
+out:
+		netns_free(netns);
 	}
 }
 
@@ -850,21 +855,7 @@ void test_map_type(enum bpf_map_type mt)
 
 void serial_test_select_reuseport(void)
 {
-	saved_tcp_fo = read_int_sysctl(TCP_FO_SYSCTL);
-	if (saved_tcp_fo < 0)
-		goto out;
-	saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
-	if (saved_tcp_syncookie < 0)
-		goto out;
-
-	if (enable_fastopen())
-		goto out;
-	if (disable_syncookie())
-		goto out;
-
 	test_map_type(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
 	test_map_type(BPF_MAP_TYPE_SOCKMAP);
 	test_map_type(BPF_MAP_TYPE_SOCKHASH);
-out:
-	restore_sysctls();
 }
-- 
2.34.1


