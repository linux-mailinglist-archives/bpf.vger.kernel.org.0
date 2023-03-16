Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7A6BD831
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 19:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCPSdV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 16 Mar 2023 14:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCPSdU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 14:33:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EEF7EEE
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:33:16 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GI6rG1000532
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:33:16 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pbpxspadw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:33:16 -0700
Received: from twshared33736.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 11:33:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 52BF42AC196F8; Thu, 16 Mar 2023 11:30:34 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 6/6] selftests/bpf: add fixed vs rotating verifier log tests
Date:   Thu, 16 Mar 2023 11:30:13 -0700
Message-ID: <20230316183013.2882810-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316183013.2882810-1-andrii@kernel.org>
References: <20230316183013.2882810-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I3CBZPMKv6Tm19JQp1lJA1H4kfzbA6Rd
X-Proofpoint-GUID: I3CBZPMKv6Tm19JQp1lJA1H4kfzbA6Rd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_12,2023-03-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftests validating BPF_LOG_FIXED behavior, which used to be the
only behavior, and now default rotating BPF verifier log, which returns
just up to last N bytes of full verifier log, instead of returning
-ENOSPC.

To stress test correctness of in-kernel verifier log logic, we force it
to truncate program's verifier log to all lengths from 1 all the way to
its full size (about 450 bytes today). This was a useful stress test
while developing the feature.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier_log.c   | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_log.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
new file mode 100644
index 000000000000..4d9630d74ae0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#include "test_log_buf.skel.h"
+
+void test_verifier_log(void)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	char full_log[1024], log_buf[1024], *exp_log;
+	char prog_name[16], op_name[32];
+	struct test_log_buf *skel;
+	const struct bpf_insn *insns;
+	size_t insn_cnt, fixed_log_sz;
+	int i, err, prog_fd;
+
+	skel = test_log_buf__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.bad_prog, false);
+
+	err = test_log_buf__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	insns = bpf_program__insns(skel->progs.good_prog);
+	insn_cnt = bpf_program__insn_cnt(skel->progs.good_prog);
+
+	opts.log_buf = full_log;
+	opts.log_size = sizeof(full_log);
+	opts.log_level = 2 | 8 /* BPF_LOG_FIXED */;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, "log_fixed",
+				"GPL", insns, insn_cnt, &opts);
+	if (!ASSERT_GT(prog_fd, 0, "fixed_log_prog_load"))
+		goto cleanup;
+	close(prog_fd);
+
+	fixed_log_sz = strlen(full_log) + 1;
+	if (!ASSERT_GT(fixed_log_sz, 100, "fixed_log_sz"))
+		goto cleanup;
+
+	/* validate BPF_LOG_FIXED works as verifier log used to work, that is:
+	 * we get -ENOSPC and beginning of the full verifier log
+	 */
+	opts.log_buf = log_buf;
+	opts.log_level = 2 | 8; /* verbose level 2, fixed-length log */
+	opts.log_size = 50;
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, "log_fixed50",
+				"GPL", insns, insn_cnt, &opts);
+	if (!ASSERT_EQ(prog_fd, -ENOSPC, "unexpected_log_fixed_prog_load_result")) {
+		if (prog_fd >= 0)
+			close(prog_fd);
+		goto cleanup;
+	}
+	if (!ASSERT_EQ(strlen(log_buf), 49, "log_fixed_50"))
+		goto cleanup;
+	if (!ASSERT_STRNEQ(log_buf, full_log, 49, op_name))
+		goto cleanup;
+
+	/* validate rolling verifier log logic: try all variations of log buf
+	 * length to force various truncation scenarios
+	 */
+	opts.log_buf = log_buf;
+	opts.log_level = 2; /* verbose level 2, rolling log */
+	for (i = 1; i <= fixed_log_sz; i++) {
+		opts.log_size = i;
+
+		snprintf(prog_name, sizeof(prog_name), "log_roll_%d", i);
+		prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, prog_name,
+					"GPL", insns, insn_cnt, &opts);
+
+		snprintf(op_name, sizeof(op_name), "log_roll_prog_load_%d", i);
+		if (!ASSERT_GT(prog_fd, 0, op_name))
+			goto cleanup;
+		close(prog_fd);
+
+		exp_log = full_log + fixed_log_sz - i;
+		snprintf(op_name, sizeof(op_name), "log_roll_contents_%d", i);
+		if (!ASSERT_STREQ(log_buf, exp_log, op_name))
+			goto cleanup;
+	}
+
+cleanup:
+	test_log_buf__destroy(skel);
+}
-- 
2.34.1

