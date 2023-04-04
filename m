Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC706D579C
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 06:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjDDEiC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 4 Apr 2023 00:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjDDEiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 00:38:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18731BC6
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 21:37:59 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333NMHlm023347
        for <bpf@vger.kernel.org>; Mon, 3 Apr 2023 21:37:59 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pqw3edr45-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 21:37:59 -0700
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 21:37:57 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BE8212D051B6F; Mon,  3 Apr 2023 21:37:37 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 18/19] selftests/bpf: add testing of log_buf==NULL condition for BPF_PROG_LOAD
Date:   Mon, 3 Apr 2023 21:36:58 -0700
Message-ID: <20230404043659.2282536-19-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404043659.2282536-1-andrii@kernel.org>
References: <20230404043659.2282536-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qfv0VjWbO_cBCqpWhO2HAeNaiWQuLyZ5
X-Proofpoint-ORIG-GUID: qfv0VjWbO_cBCqpWhO2HAeNaiWQuLyZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
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
to get log_size_actual without providing a buffer.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier_log.c   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
index 410bab151f1b..e22a4a4c9f1d 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -163,26 +163,49 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 	opts.log_buf = logs.buf;
 	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
 	opts.log_size = sizeof(logs.buf);
+	opts.log_size_actual = 0;
 	res = load_prog(&opts, expect_load_error);
 	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_fixed");
 
 	log_sz_actual_fixed = opts.log_size_actual;
 	ASSERT_GT(log_sz_actual_fixed, 0, "log_sz_actual_fixed");
 
+	/* (FIXED, NULL) get actual log size */
+	opts.log_buf = NULL;
+	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
+	opts.log_size = 0;
+	opts.log_size_actual = 0;
+	res = load_prog(&opts, true /* should fail */);
+	ASSERT_EQ(res, -ENOSPC, "prog_load_res_fixed_null");
+	ASSERT_EQ(opts.log_size_actual, log_sz_actual_fixed, "log_sz_fixed_null_eq");
+	printf("FIXED ACTUAL %u\n", opts.log_size_actual);
+
 	/* (ROLLING) get actual log size */
 	opts.log_buf = logs.buf;
 	opts.log_level = log_level;
 	opts.log_size = sizeof(logs.buf);
+	opts.log_size_actual = 0;
 	res = load_prog(&opts, expect_load_error);
 	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_rolling");
 
 	log_sz_actual_rolling = opts.log_size_actual;
 	ASSERT_EQ(log_sz_actual_rolling, log_sz_actual_fixed, "log_sz_actual_eq");
 
+	/* (ROLLING, NULL) get actual log size */
+	opts.log_buf = NULL;
+	opts.log_level = log_level;
+	opts.log_size = 0;
+	opts.log_size_actual = 0;
+	res = load_prog(&opts, true /* should fail */);
+	ASSERT_EQ(res, -ENOSPC, "prog_load_res_rolling_null");
+	ASSERT_EQ(opts.log_size_actual, log_sz_actual_rolling, "log_sz_actual_null_eq");
+	printf("ROLLING ACTUAL %u\n", opts.log_size_actual);
+
 	/* (FIXED) expect -ENOSPC for one byte short log */
 	opts.log_buf = logs.buf;
 	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
 	opts.log_size = log_sz_actual_fixed - 1;
+	opts.log_size_actual = 0;
 	res = load_prog(&opts, true /* should fail */);
 	ASSERT_EQ(res, -ENOSPC, "prog_load_res_too_short_fixed");
 
@@ -190,6 +213,7 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 	opts.log_buf = logs.buf;
 	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
 	opts.log_size = log_sz_actual_fixed;
+	opts.log_size_actual = 0;
 	res = load_prog(&opts, expect_load_error);
 	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_just_right_fixed");
 
@@ -204,6 +228,7 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 	opts.log_buf = logs.buf;
 	opts.log_level = log_level;
 	opts.log_size = log_sz_actual_rolling;
+	opts.log_size_actual = 0;
 	res = load_prog(&opts, expect_load_error);
 	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_just_right_rolling");
 
-- 
2.34.1

