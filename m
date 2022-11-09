Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAFE6232B8
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKISlx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiKISl1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:41:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C532B61C
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:41:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r14so28435530edc.7
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=icmvnvtx+KCz4Zr8CSiA8WLUbt8/xrYgqKTONM/UPNM=;
        b=JLGXmPaSfkE1i653T4XFEBKFyE41/qxQ/wY6g10OzvK3z+jRdtBnkyQH7ty8RNwhk+
         +cJNJ+fcYOqIP4JAL6i+Q3jxcwv2vpS8eu6sTXttc5xUgQ7K/OCmWi51E7Q9ehpDMAoc
         HbSolApn7Myx2z//PJhraDh8IRhhMIJZlznBlkzoUQvNN3mtQrdyy/gc7FefWU4hkJ5B
         lK9OwPwuxNRBy9l5HQCEMaAuaZGe60vNUDe4FYEkkvccecFCTOH30a15EIsfp9Z0KixV
         ob6mkVeLNw+nR/K5VRuR/PX5N3ke9/GoVNDOxgW7g6VV3eTTd/sA0YUYfEdogKN2vwSE
         iJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icmvnvtx+KCz4Zr8CSiA8WLUbt8/xrYgqKTONM/UPNM=;
        b=wRmD+34pR/Rl0eVduiqESgRNhvyUTySDdaFtuG10SNWlRj3amuUKEdS245k2Mr4t6j
         vktDk/2a/1UUbOi7ec8QqZ+++fObE2SzJC4TOv1eHX/ZpUHnjZeLXLXGznwJgGnqZEpV
         C6fohiOCNn0UqZ8eR0lATXcQzJkVg3L86HeZ422BOZ4IqoGWT3BjIXrvXofH1N5QmChD
         9+LijzVsC9y8NEy1YNF6l02DJwU/SRwPYF56Q+bWm0KJIX9H2DygzJEqjHyVGzi7WP3x
         u0qw/zhuDwX2yK3oCrF6+HrT9tSDhLPjGgYtmcAmGWHo+nLFNNno7q2d1ERfF9ir0Xda
         XSiw==
X-Gm-Message-State: ACrzQf1vUaOWH4zSPDRkfozWZFh3KqXmBtxq7EbWJHFcru9mon2094lY
        zgsqCZfMa6n4RV8mWtX2hQW9aKak3e5Xy6II
X-Google-Smtp-Source: AMsMyM5axqB9OnwTys6LRfICRTZeaALHs82k8TBgTYlH4J7MMb0lsAMxOyzOWRAZ68BEPk4NgNEdgA==
X-Received: by 2002:a05:6402:b9e:b0:463:1a8f:820a with SMTP id cf30-20020a0564020b9e00b004631a8f820amr55706081edb.406.1668019278134;
        Wed, 09 Nov 2022 10:41:18 -0800 (PST)
Received: from localhost (fwdproxy-cln-027.fbsv.net. [2a03:2880:31ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b007adbd01c566sm6309815ejf.146.2022.11.09.10.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 10:41:17 -0800 (PST)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Subject: [PATCH bpf-next v2] selftests: fix test group SKIPPED result
Date:   Wed,  9 Nov 2022 10:40:39 -0800
Message-Id: <20221109184039.3514033-1-cerasuolodomenico@gmail.com>
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
passing subtests, the group result was marked as
SKIP. E.g.:

223/1   usdt/basic:SKIP
223/2   usdt/multispec:OK
223/3   usdt/urand_auto_attach:OK
223/4   usdt/urand_pid_attach:OK
223     usdt:SKIP

The test result of usdt in the example above
should be OK instead of SKIP, because the test
group did have passing tests and it would be
considered in "normal" state.

With this change, only if all of the subtests
were skipped, the group test is marked as SKIP.
When only some of the subtests are skipped, a
more detailed result is given, stating how
many of the subtests were skipped. E.g:

223/1   usdt/basic:SKIP
223/2   usdt/multispec:OK
223/3   usdt/urand_auto_attach:OK
223/4   usdt/urand_pid_attach:OK
223     usdt:OK (SKIP: 1/4)

changes from v1:
- added (SKIP: x/y) to OK tests that have
SKIP subtests
- merged print_test_name and test_result
functions as they were always called together

Signed-off-by: Domenico Cerasuolo <dceras@meta.com>
---
 tools/testing/selftests/bpf/test_progs.c | 38 ++++++++++++++----------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 0e9a47f97890..c34f37d7a523 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -222,6 +222,26 @@ static char *test_result(bool failed, bool skipped)
 	return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
 }
 
+#define TEST_NUM_WIDTH 7
+
+static void print_test_result(const struct prog_test_def *test, const struct test_state *test_state)
+{
+	int skipped_cnt = test_state->skip_cnt;
+	int subtests_cnt = test_state->subtest_num;
+
+	fprintf(env.stdout, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
+	if (test_state->error_cnt)
+		fprintf(env.stdout, "FAIL");
+	else if (!skipped_cnt)
+		fprintf(env.stdout, "OK");
+	else if (skipped_cnt == subtests_cnt || !subtests_cnt)
+		fprintf(env.stdout, "SKIP");
+	else
+		fprintf(env.stdout, "OK (SKIP: %d/%d)", skipped_cnt, subtests_cnt);
+
+	fprintf(env.stdout, "\n");
+}
+
 static void print_test_log(char *log_buf, size_t log_cnt)
 {
 	log_buf[log_cnt] = '\0';
@@ -230,18 +250,6 @@ static void print_test_log(char *log_buf, size_t log_cnt)
 		fprintf(env.stdout, "\n");
 }
 
-#define TEST_NUM_WIDTH 7
-
-static void print_test_name(int test_num, const char *test_name, char *result)
-{
-	fprintf(env.stdout, "#%-*d %s", TEST_NUM_WIDTH, test_num, test_name);
-
-	if (result)
-		fprintf(env.stdout, ":%s", result);
-
-	fprintf(env.stdout, "\n");
-}
-
 static void print_subtest_name(int test_num, int subtest_num,
 			       const char *test_name, char *subtest_name,
 			       char *result)
@@ -307,8 +315,7 @@ static void dump_test_log(const struct prog_test_def *test,
 					       subtest_state->skipped));
 	}
 
-	print_test_name(test->test_num, test->test_name,
-			test_result(test_failed, test_state->skip_cnt));
+	print_test_result(test, test_state);
 }
 
 static void stdio_restore(void);
@@ -1070,8 +1077,7 @@ static void run_one_test(int test_num)
 	state->tested = true;
 
 	if (verbose() && env.worker_id == -1)
-		print_test_name(test_num + 1, test->test_name,
-				test_result(state->error_cnt, state->skip_cnt));
+		print_test_result(test, state);
 
 	reset_affinity();
 	restore_netns();
-- 
2.30.2

