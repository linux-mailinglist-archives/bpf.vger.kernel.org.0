Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A8A6DA644
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDFXqB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbjDFXpq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:45:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1561BE56
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:45:45 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 336L2roH020199
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:45:44 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3psym6kund-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:45:44 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:45:42 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 097CC2D5BE5AD; Thu,  6 Apr 2023 16:42:45 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 18/19] selftests/bpf: add testing of log_buf==NULL condition for BPF_PROG_LOAD
Date:   Thu, 6 Apr 2023 16:42:04 -0700
Message-ID: <20230406234205.323208-19-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3LSeYeTeC42VAJQwH29I-yEGcMnQN_Pe
X-Proofpoint-ORIG-GUID: 3LSeYeTeC42VAJQwH29I-yEGcMnQN_Pe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_13,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.4 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add few extra test conditions to validate that it's ok to pass
log_buf==NULL and log_size==0 to BPF_PROG_LOAD command with the intent
to get log_true_size without providing a buffer.

Test that log_buf==NULL condition *does not* return -ENOSPC.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier_log.c   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
index 2ec82fc60c03..9ae0ac6e3b25 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -178,26 +178,47 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 	opts.log_buf = logs.buf;
 	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
 	opts.log_size = sizeof(logs.buf);
+	opts.log_true_size = 0;
 	res = load_prog(&opts, expect_load_error);
 	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_fixed");
 
 	log_true_sz_fixed = opts.log_true_size;
 	ASSERT_GT(log_true_sz_fixed, 0, "log_true_sz_fixed");
 
+	/* (FIXED, NULL) get actual log size */
+	opts.log_buf = NULL;
+	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
+	opts.log_size = 0;
+	opts.log_true_size = 0;
+	res = load_prog(&opts, expect_load_error);
+	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_fixed_null");
+	ASSERT_EQ(opts.log_true_size, log_true_sz_fixed, "log_sz_fixed_null_eq");
+
 	/* (ROLLING) get actual log size */
 	opts.log_buf = logs.buf;
 	opts.log_level = log_level;
 	opts.log_size = sizeof(logs.buf);
+	opts.log_true_size = 0;
 	res = load_prog(&opts, expect_load_error);
 	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_rolling");
 
 	log_true_sz_rolling = opts.log_true_size;
 	ASSERT_EQ(log_true_sz_rolling, log_true_sz_fixed, "log_true_sz_eq");
 
+	/* (ROLLING, NULL) get actual log size */
+	opts.log_buf = NULL;
+	opts.log_level = log_level;
+	opts.log_size = 0;
+	opts.log_true_size = 0;
+	res = load_prog(&opts, expect_load_error);
+	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_rolling_null");
+	ASSERT_EQ(opts.log_true_size, log_true_sz_rolling, "log_true_sz_null_eq");
+
 	/* (FIXED) expect -ENOSPC for one byte short log */
 	opts.log_buf = logs.buf;
 	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
 	opts.log_size = log_true_sz_fixed - 1;
+	opts.log_true_size = 0;
 	res = load_prog(&opts, true /* should fail */);
 	ASSERT_EQ(res, -ENOSPC, "prog_load_res_too_short_fixed");
 
@@ -205,6 +226,7 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 	opts.log_buf = logs.buf;
 	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
 	opts.log_size = log_true_sz_fixed;
+	opts.log_true_size = 0;
 	res = load_prog(&opts, expect_load_error);
 	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_just_right_fixed");
 
@@ -219,6 +241,7 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 	opts.log_buf = logs.buf;
 	opts.log_level = log_level;
 	opts.log_size = log_true_sz_rolling;
+	opts.log_true_size = 0;
 	res = load_prog(&opts, expect_load_error);
 	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_just_right_rolling");
 
-- 
2.34.1

