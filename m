Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892706CCE5C
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 01:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjC1X5P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Mar 2023 19:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC1X5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 19:57:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1F13AB3
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:56:50 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SJUKUK026915
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:56:36 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pkxwuw9d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 16:56:36 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 28 Mar 2023 16:56:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id DDB3E2C400527; Tue, 28 Mar 2023 16:56:26 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 6/6] selftests/bpf: add fixed vs rotating verifier log tests
Date:   Tue, 28 Mar 2023 16:56:10 -0700
Message-ID: <20230328235610.3159943-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328235610.3159943-1-andrii@kernel.org>
References: <20230328235610.3159943-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1rVlsZZOy6XMspELQhc3hWpCrES5UcAr
X-Proofpoint-GUID: 1rVlsZZOy6XMspELQhc3hWpCrES5UcAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

For both fixed and rotating log modes we expect -ENOSPC if log contents
doesn't fit in user-supplied log buffer.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier_log.c   | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_log.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
new file mode 100644
index 000000000000..afe9e0384055
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#include "test_log_buf.skel.h"
+
+
+static bool check_prog_load(int prog_fd, bool expect_err, const char *tag)
+{
+	if (expect_err) {
+		if (!ASSERT_LT(prog_fd, 0, tag)) {
+			close(prog_fd);
+			return false;
+		}
+	} else /* !expect_err */ {
+		if (!ASSERT_GT(prog_fd, 0, tag))
+			return false;
+	}
+	return true;
+}
+
+static void verif_log_subtest(const char *name, bool expect_load_error, int log_level)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	struct {
+		/* strategically placed before others to avoid accidental modification by kernel */
+		char filler[1024];
+		char buf[1024];
+		/* strategically placed after buf[] to catch more accidental corruptions */
+		char reference[1024];
+	} logs;
+	char *exp_log, prog_name[16], op_name[32];
+	struct test_log_buf *skel;
+	struct bpf_program *prog;
+	const struct bpf_insn *insns;
+	size_t insn_cnt, fixed_log_sz;
+	int i, err, prog_fd;
+
+	skel = test_log_buf__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		if (strcmp(bpf_program__name(prog), name) == 0)
+			bpf_program__set_autoload(prog, true);
+		else
+			bpf_program__set_autoload(prog, false);
+	}
+
+	err = test_log_buf__load(skel);
+	if (!expect_load_error && !ASSERT_OK(err, "unexpected_load_failure"))
+		goto cleanup;
+	if (expect_load_error && !ASSERT_ERR(err, "unexpected_load_success"))
+		goto cleanup;
+
+	insns = bpf_program__insns(skel->progs.good_prog);
+	insn_cnt = bpf_program__insn_cnt(skel->progs.good_prog);
+
+	opts.log_buf = logs.reference;
+	opts.log_size = sizeof(logs.reference);
+	opts.log_level = log_level | 8 /* BPF_LOG_FIXED */;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, "log_fixed",
+				"GPL", insns, insn_cnt, &opts);
+	if (!check_prog_load(prog_fd, expect_load_error, "fixed_buf_prog_load"))
+		goto cleanup;
+	close(prog_fd);
+
+	fixed_log_sz = strlen(logs.reference) + 1;
+	if (!ASSERT_GT(fixed_log_sz, 50, "fixed_log_sz"))
+		goto cleanup;
+	memset(logs.reference + fixed_log_sz, 0, sizeof(logs.reference) - fixed_log_sz);
+
+	/* validate BPF_LOG_FIXED works as verifier log used to work, that is:
+	 * we get -ENOSPC and beginning of the full verifier log. This only
+	 * works for log_level 2 and log_level 1 + failed program. For log
+	 * level 2 we don't reset log at all. For log_level 1 + failed program
+	 * we don't get to verification stats output. With log level 1
+	 * for successful program  final result will be just verifier stats.
+	 * But if provided too short log buf, kernel will NULL-out log->ubuf
+	 * and will stop emitting further log. This means we'll never see
+	 * predictable verifier stats.
+	 * Long story short, we do the following -ENOSPC test only for
+	 * predictable combinations.
+	 */
+	if (log_level >= 2 || expect_load_error) {
+		opts.log_buf = logs.buf;
+		opts.log_level = log_level | 8; /* fixed-length log */
+		opts.log_size = 25;
+
+		prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, "log_fixed50",
+					"GPL", insns, insn_cnt, &opts);
+		if (!ASSERT_EQ(prog_fd, -ENOSPC, "unexpected_log_fixed_prog_load_result")) {
+			if (prog_fd >= 0)
+				close(prog_fd);
+			goto cleanup;
+		}
+		if (!ASSERT_EQ(strlen(logs.buf), 24, "log_fixed_25"))
+			goto cleanup;
+		if (!ASSERT_STRNEQ(logs.buf, logs.reference, 24, op_name))
+			goto cleanup;
+	}
+
+	/* validate rolling verifier log logic: try all variations of log buf
+	 * length to force various truncation scenarios
+	 */
+	opts.log_buf = logs.buf;
+	opts.log_level = log_level; /* rolling log */
+
+	/* prefill logs.buf with 'A's to detect any write beyond allowed length */
+	memset(logs.filler, 'A', sizeof(logs.filler));
+	logs.filler[sizeof(logs.filler) - 1] = '\0';
+	memset(logs.buf, 'A', sizeof(logs.buf));
+	logs.buf[sizeof(logs.buf) - 1] = '\0';
+
+	for (i = 1; i < fixed_log_sz; i++) {
+		opts.log_size = i;
+
+		snprintf(prog_name, sizeof(prog_name), "log_roll_%d", i);
+		prog_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, prog_name,
+					"GPL", insns, insn_cnt, &opts);
+
+		snprintf(op_name, sizeof(op_name), "log_roll_prog_load_%d", i);
+		if (!ASSERT_EQ(prog_fd, -ENOSPC, op_name)) {
+			if (prog_fd >= 0)
+				close(prog_fd);
+			goto cleanup;
+		}
+
+		exp_log = logs.reference + fixed_log_sz - i;
+		snprintf(op_name, sizeof(op_name), "log_roll_contents_%d", i);
+		if (!ASSERT_STREQ(logs.buf, exp_log, op_name)) {
+			printf("CMP:%d\nS1:'%s'\nS2:'%s'\n",
+				strcmp(logs.buf, exp_log),
+				logs.buf, exp_log);
+			goto cleanup;
+		}
+
+		/* check that unused portions of logs.buf is not overwritten */
+		snprintf(op_name, sizeof(op_name), "log_roll_unused_tail_%d", i);
+		if (!ASSERT_STREQ(logs.buf + i, logs.filler + i, op_name)) {
+			printf("CMP:%d\nS1:'%s'\nS2:'%s'\n",
+				strcmp(logs.buf + i, logs.filler + i),
+				logs.buf + i, logs.filler + i);
+			goto cleanup;
+		}
+	}
+
+cleanup:
+	test_log_buf__destroy(skel);
+}
+
+void test_verifier_log(void)
+{
+	if (test__start_subtest("good_prog-level1"))
+		verif_log_subtest("good_prog", false, 1);
+	if (test__start_subtest("good_prog-level2"))
+		verif_log_subtest("good_prog", false, 2);
+	if (test__start_subtest("bad_prog-level1"))
+		verif_log_subtest("bad_prog", true, 1);
+	if (test__start_subtest("bad_prog-level2"))
+		verif_log_subtest("bad_prog", true, 2);
+}
-- 
2.34.1

