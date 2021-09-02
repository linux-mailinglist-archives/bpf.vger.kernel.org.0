Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73EE3FF37D
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 20:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347191AbhIBSxm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347173AbhIBSxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 14:53:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F750C061575
        for <bpf@vger.kernel.org>; Thu,  2 Sep 2021 11:52:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t19so6678062ejr.8
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsJRd+5H/xBdXI0ewID2C2LPT2CelRazFOfPu6EBp7o=;
        b=P3d5tYezbV9rlxcEVG9kkNqueDq3anSojim399lE1MIf5+2w4dAF6Gy7Ta8ZZCH0/K
         L5yQ9C06n3CwBPddWtJRAmWNb/i/wfHHasftgI9GFg3kACZZrIkNf4d4+QOuR7N+5l3i
         3Xd8wkTuHNiNG/IGLZgcbbEp3fzZObFywifmOSxHSAlLLWXvRs1RfGcRD5AXYHVJcaqc
         sYar9JiXRQkZtB4plYNfRPlA1tbriqAsLEU09DYdRhJxuUxwRQql9zVsC9neL1XVThq5
         ayrNeWE3nQcr7pwPvtFF8l8UCDfsRPYcrw6C5T6oG70mlSXM0Wpj+8HTZ3Sf79jTX+WS
         CENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsJRd+5H/xBdXI0ewID2C2LPT2CelRazFOfPu6EBp7o=;
        b=F3+qc0jV6PIWtX7wlRTc2iXL0AsdfCApCf1P+kDg6NV2WNXL4h/uTmhTLFio/P5QU1
         tRv5IAQ5itPHkogk3mYADKU1b/jybJU0OiM8Mn/UNO/xJlLPFfFAn7JtMC0Fil0CC2ax
         uejePDOQ2oV0SbVlA7CxMX5I66+k6SL4FGbv1aoBRkbfxL2+v0yEoaK2HNApa/08Ua2P
         R9PNDYr3++dv1kbjZ4LdpbQ/jYwZs+YVCo56ZWSARZetxgaU+AcrhTFgTAHfuBo/tw5+
         SvQ43EHu29jwRAd4CgId047f5AR48br3pxG3LvaiD5UhAgzpeA8Jb/PMJywXVARhdSs3
         iD5w==
X-Gm-Message-State: AOAM531CGrVUoUih9pRyE5ICQFd5seEXe8WOa4pwK9wFY3fuZG9IX2G/
        Sjk6hQffoih5XXG8serquYZHqg==
X-Google-Smtp-Source: ABdhPJxKblGjciSaYmfnY3Q1A3EHUDemYzCPgZq//gpCQJrKkN9DULC5aE8ctkSXBrHytRDW+HVDJA==
X-Received: by 2002:a17:906:a382:: with SMTP id k2mr5350239ejz.454.1630608759760;
        Thu, 02 Sep 2021 11:52:39 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id mb14sm1592235ejb.81.2021.09.02.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 11:52:39 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        iii@linux.ibm.com
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 02/13] bpf/tests: Reduce memory footprint of test suite
Date:   Thu,  2 Sep 2021 20:52:18 +0200
Message-Id: <20210902185229.1840281-3-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902185229.1840281-1-johan.almbladh@anyfinetworks.com>
References: <20210902185229.1840281-1-johan.almbladh@anyfinetworks.com>
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
2.25.1

