Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282F0405970
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348233AbhIIOqG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbhIIOqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 10:46:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F96C05BD24
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 07:33:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q3so2972542edt.5
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4qbj284OAUgjH/eZ0IYkKuS/yppytDEtIfwDnByJNQ=;
        b=OIeWv49h+qyBhB+ImkrgMnhE7s8fYK3KFVij3CyC4QIzwI5vHBjD8rKnMfOvNr7/7A
         PbMySTJlC1mV0TmfHqPQ1WL3P46vawRbb3ewqhSX/h2AmytEjMIA4Ee1rhlAHoGBDQ1g
         oh/RyH1aQPtot5EHwp+YCesQYBY1R3oZmgMlBRRdyKYfRpLepmevl/BQ0N21KHtFQmhq
         KpIVupLtozsAEo/XEF3fiVwZ+5bJFdYXLQR6U8CRkdRs3Dm6I/XpDM3LYLnGMEp8EW6W
         slLcnmjX9ppAKY8WCgeufkbbZ7qYVfo6mLRfAVzj0Uefi0ezZdEKOtspXdXEW3pY1OAt
         u4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4qbj284OAUgjH/eZ0IYkKuS/yppytDEtIfwDnByJNQ=;
        b=IOcjmOEvr2UYAful4BOp6z6OUwurKHYC8YLuJnKDtl4ZtBJJDzWrV6SR5AIu/UVQBE
         7lASznWTXN5dGD4zW5JGYoWAhoABjAiKhjS9ZKmTBrX7hG/WdmVK5girY/Dn3jWa52kR
         9Mnu0hMMYA22lF5bLvQ5LzHFouq+ldFbIeRaikq30/qmG0Z2BOFXjlyRSOq6jw1riLoH
         uLjX+s3lrx0POFLqg8T/l12+GfSaquv0RH4imv3VrC4SVD4zQhXkWSx/+6SXZsG7OL5e
         t5r/XgLjl2tcbIF3yPnXljSKjDCtZny2AWIIbv65nGGjQ49/1wD1dbvefIcXy5qkc8Ww
         FHVw==
X-Gm-Message-State: AOAM5302QJBtY16BkocvaldHqinQ3y/4cseqFVA5yeevfdgzSnhwK2Bm
        q6pkeVPDBCDmemluuhCLOxytcg==
X-Google-Smtp-Source: ABdhPJxpWw8hwqHycop/kMG1ozIfnzF63fiLYtDnqaYivEmvsvii8JMMBsagixnhDx2jexVFj/1vEQ==
X-Received: by 2002:a05:6402:5:: with SMTP id d5mr3525581edu.359.1631197995427;
        Thu, 09 Sep 2021 07:33:15 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bj10sm1030909ejb.17.2021.09.09.07.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:33:15 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v3 02/13] bpf/tests: Reduce memory footprint of test suite
Date:   Thu,  9 Sep 2021 16:32:52 +0200
Message-Id: <20210909143303.811171-3-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909143303.811171-1-johan.almbladh@anyfinetworks.com>
References: <20210909143303.811171-1-johan.almbladh@anyfinetworks.com>
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

