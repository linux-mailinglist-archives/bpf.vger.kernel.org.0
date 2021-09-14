Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE3840AA91
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhINJUZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhINJUY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 05:20:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3763DC061764
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i6so18805674edu.1
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4qbj284OAUgjH/eZ0IYkKuS/yppytDEtIfwDnByJNQ=;
        b=u8jW1CQtx0/VlAZDXuxKkszJofHPh7T8+jarucuyySMNLsph8MBESF4HKn0Gu8vqej
         5hfzmuJqJ7rmSUPbTI3eZoywtwRqCYiMRaBm/fR/eLNVmjvnniu0ltQWCSpQB9gji8Dt
         TAX2eaCilrgDhBM8sru33CkOyuQsW9554X5BnDXvxEnvn/x28LuzgL4vW3hr7NYQzwxx
         tylULjeVeMt4WrYGEl1dCCO7474zbgFZ5SQMJobZ1usaXv6fOhtqkSepXwAhs7TMtXJ1
         hxmPocEA8icdsLpDnP6kbHVogATgVfYwhpX22TFLNWdU5h23l43I2qvd1t+6X6cLrS/S
         yncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4qbj284OAUgjH/eZ0IYkKuS/yppytDEtIfwDnByJNQ=;
        b=M50OTEqEqrPRbtV74F8aEDNAPuNOCNiJdLfDuYQrMbGN56S1Tr/E7XHew0W1SD7PHa
         BWt0QK0AHvYXO42YT1Ul7XpWf6PRrY8PlJZS96TwKtty3C2LadsTauLaXGTyBQqgUI5q
         k14s86Crx9rnWlGvdTQHj0EiOA8bObWNmbyK6lp1Qrv41Li7WfWQ6SOhLi7QfjBFciAt
         NcrNIopoe0sBVao6ntCcggOa9YW6laaYLnYYAbPCc+gQkFfczX/JfPRI5I13mthWz4SW
         2PT/HYlsosYgPFU/rGdQN2SFsUdLAmSSYqwyl4ZkJDA+gIoiin/+SeL+v8h4HgyZFB3q
         QYCg==
X-Gm-Message-State: AOAM531szxxL8M60iQIb3oBdBITfsov0Yn8vwpe2HmF/c3ipmi4H63xq
        DrRxO3LV0UF0GTlK+VMJ4IFN0g==
X-Google-Smtp-Source: ABdhPJwxJJaU0E29oVvIS2eH4VWw0gm38nkoDk3NDoz7pOSRX9E4viTBmR3SMnWAEOgIqQ8+WIBkvQ==
X-Received: by 2002:a50:8e06:: with SMTP id 6mr17832031edw.107.1631611145827;
        Tue, 14 Sep 2021 02:19:05 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id h10sm4615915ede.28.2021.09.14.02.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:05 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        paul@cilium.io, yangtiezhu@loongson.cn, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf v4 02/14] bpf/tests: Reduce memory footprint of test suite
Date:   Tue, 14 Sep 2021 11:18:30 +0200
Message-Id: <20210914091842.4186267-3-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
References: <20210914091842.4186267-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The test suite used to call any fill_helper callbacks to generate eBPF
program data for all test cases at once. This caused ballooning memory
requirements as more extensive test cases were added. Now the each
fill_helper is called before the test is run and the allocated memory
released afterwards, before the next test case is processed.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index c8bd3e9ab10a..f0651dc6450b 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -8694,8 +8694,6 @@ static __init int find_test_index(const char *test_name)
 
 static __init int prepare_bpf_tests(void)
 {
-	int i;
-
 	if (test_id >= 0) {
 		/*
 		 * if a test_id was specified, use test_range to
@@ -8739,23 +8737,11 @@ static __init int prepare_bpf_tests(void)
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		if (tests[i].fill_helper &&
-		    tests[i].fill_helper(&tests[i]) < 0)
-			return -ENOMEM;
-	}
-
 	return 0;
 }
 
 static __init void destroy_bpf_tests(void)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		if (tests[i].fill_helper)
-			kfree(tests[i].u.ptr.insns);
-	}
 }
 
 static bool exclude_test(int test_id)
@@ -8959,7 +8945,19 @@ static __init int test_bpf(void)
 
 		pr_info("#%d %s ", i, tests[i].descr);
 
+		if (tests[i].fill_helper &&
+		    tests[i].fill_helper(&tests[i]) < 0) {
+			pr_cont("FAIL to prog_fill\n");
+			continue;
+		}
+
 		fp = generate_filter(i, &err);
+
+		if (tests[i].fill_helper) {
+			kfree(tests[i].u.ptr.insns);
+			tests[i].u.ptr.insns = NULL;
+		}
+
 		if (fp == NULL) {
 			if (err == 0) {
 				pass_cnt++;
-- 
2.30.2

