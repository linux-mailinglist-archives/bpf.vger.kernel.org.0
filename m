Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87126119AF
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 19:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJ1Rz5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJ1Rzz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 13:55:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D0198C84
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 10:55:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n12so14644856eja.11
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJLS2ziIJLJudMk9NMKzr0rUFYXOR6bo/iTdjHodBug=;
        b=qxwOkQ+9a7w380BVkHVDLE/V4QKPCaFg18S4EE6n5ise5sGHF3ziF+n5LJ0dlyLsKe
         7oV15uW//aKkkops2tqNQ3bqIErHtS96203MGAr06vBfC8xFJyy1Q4DvW2EoZiwB66XS
         F0sCuUbzOEZ6GgdwK5775IzoATj57nEtTlD8Gmwn8fkpFYYwD8UplfueOyzPAqU7opZN
         l7Cxch6p+ieHIcG1oSa/hewoMj84cTt8EwEPP6s2T9AdZHynrfoi0tcaND0Dt/rOM7++
         6LRhLHAipfqgjjGa0rnSVbfLxYR1ixIYUntGXIdvxki2hsiPS6xk9l4SxULzi9LfAgDg
         8Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJLS2ziIJLJudMk9NMKzr0rUFYXOR6bo/iTdjHodBug=;
        b=v3Ve+OCqmfaXISnSKTuJzbJVCURDRTxD5G1IvyNbp3LyewD6Kzg97oyN2AsZLHIWsh
         5Jub15/ryZtkatfmtVvmX/ekr//pPAk5jYOq1sqATeuVpiZR+F2rSsJtIvAmqOtn4rZa
         9+uW4HuG8hq5ymlhanKWuao/W/jHtwwrkPvhAkcYgYmqpX+zAulmWj4LyqqjHoFweIBx
         6rFTwP5CD++H7OHHDswEf4ZkztnJOJJ5IkbVaeWthYqiS4IJYhAXiMYIAzDV6CdmvAei
         xQjOOJsD2K603WTrT0H3G3FquVRaitojTqELVR1k06LbPVF14dp3MHLlRpmg1lnRljMN
         fnyQ==
X-Gm-Message-State: ACrzQf3X3g5ITu9FTa4VSMTqLdXgRUr9qKjfoQu8bC4WWB6g71ksuS1t
        soH95zjr1keINJik85kzjmm2CT/hmpButTEn
X-Google-Smtp-Source: AMsMyM7p3fssbWn3TtXsfuXNVZZM2lI7edFaaFWpOO65hHGwy/q3Y0kix8gPDczWDBnqKCO1VMA7sw==
X-Received: by 2002:a17:906:eec1:b0:782:6384:76be with SMTP id wu1-20020a170906eec100b00782638476bemr493691ejb.756.1666979750637;
        Fri, 28 Oct 2022 10:55:50 -0700 (PDT)
Received: from localhost (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id z19-20020a05640240d300b004617e880f52sm3135490edb.29.2022.10.28.10.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:55:50 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Subject: [PATCH bpf-next] selftests: fix test group SKIPPED result
Date:   Fri, 28 Oct 2022 10:55:30 -0700
Message-Id: <20221028175530.1413351-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Domenico Cerasuolo <dceras@meta.com>

When showing the result of a test group, if one
of the subtests was skipped, while still having
passing subtets, the group result was marked as
SKIPPED.

#223/1   usdt/basic:SKIP
#223/2   usdt/multispec:OK
#223     usdt:SKIP

With this change only if all of the subtests
were skipped the group test is marked as SKIPPED.

#223/1   usdt/basic:SKIP
#223/2   usdt/multispec:OK
#223     usdt:OK

Signed-off-by: Domenico Cerasuolo <dceras@meta.com>
---
 tools/testing/selftests/bpf/test_progs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 0e9a47f97890..14b70393018b 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -222,6 +222,11 @@ static char *test_result(bool failed, bool skipped)
 	return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
 }
 
+static char *test_group_result(int tests_count, bool failed, int skipped)
+{
+	return failed ? "FAIL" : (skipped == tests_count ? "SKIP" : "OK");
+}
+
 static void print_test_log(char *log_buf, size_t log_cnt)
 {
 	log_buf[log_cnt] = '\0';
@@ -308,7 +313,8 @@ static void dump_test_log(const struct prog_test_def *test,
 	}
 
 	print_test_name(test->test_num, test->test_name,
-			test_result(test_failed, test_state->skip_cnt));
+			test_group_result(test_state->subtest_num,
+				test_failed, test_state->skip_cnt));
 }
 
 static void stdio_restore(void);
@@ -1071,7 +1077,8 @@ static void run_one_test(int test_num)
 
 	if (verbose() && env.worker_id == -1)
 		print_test_name(test_num + 1, test->test_name,
-				test_result(state->error_cnt, state->skip_cnt));
+				test_group_result(state->subtest_num,
+					state->error_cnt, state->skip_cnt));
 
 	reset_affinity();
 	restore_netns();
-- 
2.30.2

