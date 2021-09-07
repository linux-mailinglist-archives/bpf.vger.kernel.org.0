Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F484030E8
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 00:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348390AbhIGWZG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 18:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347875AbhIGWZB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 18:25:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054CC0613D9
        for <bpf@vger.kernel.org>; Tue,  7 Sep 2021 15:23:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id mf2so5574ejb.9
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsJRd+5H/xBdXI0ewID2C2LPT2CelRazFOfPu6EBp7o=;
        b=KnQcCDG4joN/ogi3ID8wzVS6karwjlbEwsmI67W1We6ekzxA3sSe4MG1ZhP+xhqgyw
         cZanzYaFXh5Yf+Vulpsi9QJaER1febT1m84fhk8aor7I2gF026jU55KOMvl1X/29ixJs
         DYQr7J/6PZZTwGmaf6IR1g3GBroXDSzV9SNw0fkL/KoLy0K41fmRPL36YT069rAbNiop
         w6gjyJqZ8ON6Uu3m2K2tSF0wn8dMfG3FCwGNRQIm7SESUaISV5vfX8tT6bpj41che9cI
         RiRpW0vE4Lkyc1oaewfKsLW5ha0oUtkn8JGhzOPgujhTfDTS0WbIIgx/zjqkhjzA3fPD
         F5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsJRd+5H/xBdXI0ewID2C2LPT2CelRazFOfPu6EBp7o=;
        b=KeTUfqffrEG4ZhnA8ZsCNJnt16SvPekwArnqSlCwDYVlNsJqIL9iywjIjqLrlwhrVp
         iDWkLfE9DjglRRoDxx1aBaQfBPQ7n8lDuEFrJvsb11jLGJzcftCRRiN2o82Y7T7ZbsJ4
         BWZ9ngMUpEQsg74i1a46PnVhI4O21NmgY63qFdFmwDI38EJXhH+0YwWRyOpf3jknzh7r
         wjVW0Jut429jXXixMGFFdI7keCHq63OL03fXRj09roQ/SkiKHoneZHbz+LzqqiiDCt0R
         wab3u+n4H1v6HmQ1j6QPh8b0saFR8gvVD/YtpJP9ENGkOr5vdEMSlGApAPWW9QbC7/4b
         tpQg==
X-Gm-Message-State: AOAM533xqxBb0ptYeQBhFH6h7i7CwNHHgTuLxTSOUoDE7s/vWYVlkbQ7
        7BPf6Q1JczvlKWs3R18LR7dm9g==
X-Google-Smtp-Source: ABdhPJzSWwoZYW+9Of+HubxRBa+2Uw7JHyRAXZP30LZNmKsw14bmsUh43lowozO/j0JJTmMgynmOFA==
X-Received: by 2002:a17:906:4482:: with SMTP id y2mr621958ejo.484.1631053430981;
        Tue, 07 Sep 2021 15:23:50 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id gb24sm71772ejc.53.2021.09.07.15.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:23:50 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 02/13] bpf/tests: Reduce memory footprint of test suite
Date:   Wed,  8 Sep 2021 00:23:28 +0200
Message-Id: <20210907222339.4130924-3-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
References: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
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

