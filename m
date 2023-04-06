Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32596DA63C
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjDFXqC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 19:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbjDFXpx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 19:45:53 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2314D9C
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 16:45:52 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336MW9Id013462
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 16:45:51 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pt6y20apa-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 16:45:51 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 16:45:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1E0312D5BE617; Thu,  6 Apr 2023 16:42:48 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v4 bpf-next 19/19] selftests/bpf: add verifier log tests for BPF_BTF_LOAD command
Date:   Thu, 6 Apr 2023 16:42:05 -0700
Message-ID: <20230406234205.323208-20-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
References: <20230406234205.323208-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: v2AlsmZA-E6kvzfSAN_J5Qvp5_05MTyK
X-Proofpoint-GUID: v2AlsmZA-E6kvzfSAN_J5Qvp5_05MTyK
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

Add verifier log tests for BPF_BTF_LOAD command, which are very similar,
conceptually, to BPF_PROG_LOAD tests. These are two separate commands
dealing with verbose verifier log, so should be both tested separately.

Test that log_buf==NULL condition *does not* return -ENOSPC.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier_log.c   | 188 ++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier_log.c b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
index 9ae0ac6e3b25..475092a78deb 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier_log.c
@@ -249,6 +249,190 @@ static void verif_log_subtest(const char *name, bool expect_load_error, int log_
 	test_log_buf__destroy(skel);
 }
 
+static const void *btf_data;
+static u32 btf_data_sz;
+
+static int load_btf(struct bpf_btf_load_opts *opts, bool expect_err)
+{
+	int fd;
+
+	fd = bpf_btf_load(btf_data, btf_data_sz, opts);
+	if (fd >= 0)
+		close(fd);
+	if (expect_err)
+		ASSERT_LT(fd, 0, "btf_load_failure");
+	else /* !expect_err */
+		ASSERT_GT(fd, 0, "btf_load_success");
+	return fd;
+}
+
+static void verif_btf_log_subtest(bool bad_btf)
+{
+	LIBBPF_OPTS(bpf_btf_load_opts, opts);
+	struct btf *btf;
+	struct btf_type *t;
+	char *exp_log, op_name[32];
+	size_t fixed_log_sz;
+	__u32 log_true_sz_fixed, log_true_sz_rolling;
+	int i, res;
+
+	/* prepare simple BTF contents */
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf_new_empty"))
+		return;
+	res = btf__add_int(btf, "whatever", 4, 0);
+	if (!ASSERT_GT(res, 0, "btf_add_int_id"))
+		goto cleanup;
+	if (bad_btf) {
+		/* btf__add_int() doesn't allow bad value of size, so we'll just
+		 * force-cast btf_type pointer and manually override size to invalid
+		 * 3 if we need to simulate failure
+		 */
+		t = (void *)btf__type_by_id(btf, res);
+		if (!ASSERT_OK_PTR(t, "int_btf_type"))
+			goto cleanup;
+		t->size = 3;
+	}
+
+	btf_data = btf__raw_data(btf, &btf_data_sz);
+	if (!ASSERT_OK_PTR(btf_data, "btf_data"))
+		goto cleanup;
+
+	load_btf(&opts, bad_btf);
+
+	opts.log_buf = logs.reference;
+	opts.log_size = sizeof(logs.reference);
+	opts.log_level = 1 | 8 /* BPF_LOG_FIXED */;
+	load_btf(&opts, bad_btf);
+
+	fixed_log_sz = strlen(logs.reference) + 1;
+	if (!ASSERT_GT(fixed_log_sz, 50, "fixed_log_sz"))
+		goto cleanup;
+	memset(logs.reference + fixed_log_sz, 0, sizeof(logs.reference) - fixed_log_sz);
+
+	/* validate BPF_LOG_FIXED truncation works as verifier log used to work */
+	opts.log_buf = logs.buf;
+	opts.log_level = 1 | 8; /* fixed-length log */
+	opts.log_size = 25;
+	res = load_btf(&opts, true);
+	ASSERT_EQ(res, -ENOSPC, "half_log_fd");
+	ASSERT_EQ(strlen(logs.buf), 24, "log_fixed_25");
+	ASSERT_STRNEQ(logs.buf, logs.reference, 24, op_name);
+
+	/* validate rolling verifier log logic: try all variations of log buf
+	 * length to force various truncation scenarios
+	 */
+	opts.log_buf = logs.buf;
+	opts.log_level = 1; /* rolling log */
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
+		snprintf(op_name, sizeof(op_name), "log_roll_btf_load_%d", i);
+		res = load_btf(&opts, true);
+		if (!ASSERT_EQ(res, -ENOSPC, op_name))
+			goto cleanup;
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
+		/* check that unused portions of logs.buf are not overwritten */
+		snprintf(op_name, sizeof(op_name), "log_roll_unused_tail_%d", i);
+		if (!ASSERT_STREQ(logs.buf + i, logs.filler + i, op_name)) {
+			printf("CMP:%d\nS1:'%s'\nS2:'%s'\n",
+				strcmp(logs.buf + i, logs.filler + i),
+				logs.buf + i, logs.filler + i);
+			goto cleanup;
+		}
+	}
+
+	/* (FIXED) get actual log size */
+	opts.log_buf = logs.buf;
+	opts.log_level = 1 | 8; /* BPF_LOG_FIXED */
+	opts.log_size = sizeof(logs.buf);
+	opts.log_true_size = 0;
+	res = load_btf(&opts, bad_btf);
+	ASSERT_NEQ(res, -ENOSPC, "btf_load_res_fixed");
+
+	log_true_sz_fixed = opts.log_true_size;
+	ASSERT_GT(log_true_sz_fixed, 0, "log_true_sz_fixed");
+
+	/* (FIXED, NULL) get actual log size */
+	opts.log_buf = NULL;
+	opts.log_level = 1 | 8; /* BPF_LOG_FIXED */
+	opts.log_size = 0;
+	opts.log_true_size = 0;
+	res = load_btf(&opts, bad_btf);
+	ASSERT_NEQ(res, -ENOSPC, "btf_load_res_fixed_null");
+	ASSERT_EQ(opts.log_true_size, log_true_sz_fixed, "log_sz_fixed_null_eq");
+
+	/* (ROLLING) get actual log size */
+	opts.log_buf = logs.buf;
+	opts.log_level = 1;
+	opts.log_size = sizeof(logs.buf);
+	opts.log_true_size = 0;
+	res = load_btf(&opts, bad_btf);
+	ASSERT_NEQ(res, -ENOSPC, "btf_load_res_rolling");
+
+	log_true_sz_rolling = opts.log_true_size;
+	ASSERT_EQ(log_true_sz_rolling, log_true_sz_fixed, "log_true_sz_eq");
+
+	/* (ROLLING, NULL) get actual log size */
+	opts.log_buf = NULL;
+	opts.log_level = 1;
+	opts.log_size = 0;
+	opts.log_true_size = 0;
+	res = load_btf(&opts, bad_btf);
+	ASSERT_NEQ(res, -ENOSPC, "btf_load_res_rolling_null");
+	ASSERT_EQ(opts.log_true_size, log_true_sz_rolling, "log_true_sz_null_eq");
+
+	/* (FIXED) expect -ENOSPC for one byte short log */
+	opts.log_buf = logs.buf;
+	opts.log_level = 1 | 8; /* BPF_LOG_FIXED */
+	opts.log_size = log_true_sz_fixed - 1;
+	opts.log_true_size = 0;
+	res = load_btf(&opts, true);
+	ASSERT_EQ(res, -ENOSPC, "btf_load_res_too_short_fixed");
+
+	/* (FIXED) expect *not* -ENOSPC with exact log_true_size buffer */
+	opts.log_buf = logs.buf;
+	opts.log_level = 1 | 8; /* BPF_LOG_FIXED */
+	opts.log_size = log_true_sz_fixed;
+	opts.log_true_size = 0;
+	res = load_btf(&opts, bad_btf);
+	ASSERT_NEQ(res, -ENOSPC, "btf_load_res_just_right_fixed");
+
+	/* (ROLLING) expect -ENOSPC for one byte short log */
+	opts.log_buf = logs.buf;
+	opts.log_level = 1;
+	opts.log_size = log_true_sz_rolling - 1;
+	res = load_btf(&opts, true);
+	ASSERT_EQ(res, -ENOSPC, "btf_load_res_too_short_rolling");
+
+	/* (ROLLING) expect *not* -ENOSPC with exact log_true_size buffer */
+	opts.log_buf = logs.buf;
+	opts.log_level = 1;
+	opts.log_size = log_true_sz_rolling;
+	opts.log_true_size = 0;
+	res = load_btf(&opts, bad_btf);
+	ASSERT_NEQ(res, -ENOSPC, "btf_load_res_just_right_rolling");
+
+cleanup:
+	btf__free(btf);
+}
+
 void test_verifier_log(void)
 {
 	if (test__start_subtest("good_prog-level1"))
@@ -259,4 +443,8 @@ void test_verifier_log(void)
 		verif_log_subtest("bad_prog", true, 1);
 	if (test__start_subtest("bad_prog-level2"))
 		verif_log_subtest("bad_prog", true, 2);
+	if (test__start_subtest("bad_btf"))
+		verif_btf_log_subtest(true /* bad btf */);
+	if (test__start_subtest("good_btf"))
+		verif_btf_log_subtest(false /* !bad btf */);
 }
-- 
2.34.1

