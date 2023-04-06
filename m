Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB2D6DA639
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjDFXo2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDFXnv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:43:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0992A5E3
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:43:14 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 336LRniB020297
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:43:07 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3psfmg8yjs-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:43:07 -0700
Received: from twshared7331.15.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:43:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EF3F22D5BE58A; Thu,  6 Apr 2023 16:42:43 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 17/19] selftests/bpf: add tests to validate log_true_size feature
Date:   Thu, 6 Apr 2023 16:42:03 -0700
Message-ID: <20230406234205.323208-18-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hOfdJdicHfXHcL3zht6XcMQwgn9x4rBx
X-Proofpoint-ORIG-GUID: hOfdJdicHfXHcL3zht6XcMQwgn9x4rBx
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

Add additional test cases validating that log_true_size is consistent
between fixed and rotating log modes, and that log_true_size can be
used *exactly* without causing -ENOSPC, while using just 1 byte shorter
log buffer would cause -ENOSPC.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier_log.c   | 92 +++++++++++++++----
 1 file changed, 76 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
index 3284108a6ce8..2ec82fc60c03 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -18,25 +18,41 @@ static bool check_prog_load(int prog_fd, bool expect_err, const char *tag)
 		if (!ASSERT_GT(prog_fd, 0, tag))
 			return false;
 	}
+	if (prog_fd >= 0)
+		close(prog_fd);
 	return true;
 }
 
+static struct {
+	/* strategically placed before others to avoid accidental modification by kernel */
+	char filler[1024];
+	char buf[1024];
+	/* strategically placed after buf[] to catch more accidental corruptions */
+	char reference[1024];
+} logs;
+static const struct bpf_insn *insns;
+static size_t insn_cnt;
+
+static int load_prog(struct bpf_prog_load_opts *opts, bool expect_load_error)
+{
+	int prog_fd;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, "log_prog",
+				"GPL", insns, insn_cnt, opts);
+	check_prog_load(prog_fd, expect_load_error, "prog_load");
+
+	return prog_fd;
+}
+
 static void verif_log_subtest(const char *name, bool expect_load_error, int log_level)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts);
-	struct {
-		/* strategically placed before others to avoid accidental modification by kernel */
-		char filler[1024];
-		char buf[1024];
-		/* strategically placed after buf[] to catch more accidental corruptions */
-		char reference[1024];
-	} logs;
 	char *exp_log, prog_name[16], op_name[32];
 	struct test_log_buf *skel;
 	struct bpf_program *prog;
-	const struct bpf_insn *insns;
-	size_t insn_cnt, fixed_log_sz;
-	int i, mode, err, prog_fd;
+	size_t fixed_log_sz;
+	__u32 log_true_sz_fixed, log_true_sz_rolling;
+	int i, mode, err, prog_fd, res;
 
 	skel = test_log_buf__open();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
@@ -61,11 +77,7 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 	opts.log_buf = logs.reference;
 	opts.log_size = sizeof(logs.reference);
 	opts.log_level = log_level | 8 /* BPF_LOG_FIXED */;
-	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, "log_fixed",
-				"GPL", insns, insn_cnt, &opts);
-	if (!check_prog_load(prog_fd, expect_load_error, "fixed_buf_prog_load"))
-		goto cleanup;
-	close(prog_fd);
+	load_prog(&opts, expect_load_error);
 
 	fixed_log_sz = strlen(logs.reference) + 1;
 	if (!ASSERT_GT(fixed_log_sz, 50, "fixed_log_sz"))
@@ -89,7 +101,7 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 		opts.log_level = log_level | 8; /* fixed-length log */
 		opts.log_size = 25;
 
-		prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, "log_fixed50",
+		prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, "log_fixed25",
 					"GPL", insns, insn_cnt, &opts);
 		if (!ASSERT_EQ(prog_fd, -ENOSPC, "unexpected_log_fixed_prog_load_result")) {
 			if (prog_fd >= 0)
@@ -162,6 +174,54 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 		}
 	}
 
+	/* (FIXED) get actual log size */
+	opts.log_buf = logs.buf;
+	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
+	opts.log_size = sizeof(logs.buf);
+	res = load_prog(&opts, expect_load_error);
+	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_fixed");
+
+	log_true_sz_fixed = opts.log_true_size;
+	ASSERT_GT(log_true_sz_fixed, 0, "log_true_sz_fixed");
+
+	/* (ROLLING) get actual log size */
+	opts.log_buf = logs.buf;
+	opts.log_level = log_level;
+	opts.log_size = sizeof(logs.buf);
+	res = load_prog(&opts, expect_load_error);
+	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_rolling");
+
+	log_true_sz_rolling = opts.log_true_size;
+	ASSERT_EQ(log_true_sz_rolling, log_true_sz_fixed, "log_true_sz_eq");
+
+	/* (FIXED) expect -ENOSPC for one byte short log */
+	opts.log_buf = logs.buf;
+	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
+	opts.log_size = log_true_sz_fixed - 1;
+	res = load_prog(&opts, true /* should fail */);
+	ASSERT_EQ(res, -ENOSPC, "prog_load_res_too_short_fixed");
+
+	/* (FIXED) expect *not* -ENOSPC with exact log_true_size buffer */
+	opts.log_buf = logs.buf;
+	opts.log_level = log_level | 8; /* BPF_LOG_FIXED */
+	opts.log_size = log_true_sz_fixed;
+	res = load_prog(&opts, expect_load_error);
+	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_just_right_fixed");
+
+	/* (ROLLING) expect -ENOSPC for one byte short log */
+	opts.log_buf = logs.buf;
+	opts.log_level = log_level;
+	opts.log_size = log_true_sz_rolling - 1;
+	res = load_prog(&opts, true /* should fail */);
+	ASSERT_EQ(res, -ENOSPC, "prog_load_res_too_short_rolling");
+
+	/* (ROLLING) expect *not* -ENOSPC with exact log_true_size buffer */
+	opts.log_buf = logs.buf;
+	opts.log_level = log_level;
+	opts.log_size = log_true_sz_rolling;
+	res = load_prog(&opts, expect_load_error);
+	ASSERT_NEQ(res, -ENOSPC, "prog_load_res_just_right_rolling");
+
 cleanup:
 	test_log_buf__destroy(skel);
 }
-- 
2.34.1

