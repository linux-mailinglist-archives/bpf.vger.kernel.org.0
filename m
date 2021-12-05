Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D01468D48
	for <lists+bpf@lfdr.de>; Sun,  5 Dec 2021 21:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbhLEUgd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 5 Dec 2021 15:36:33 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14326 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238690AbhLEUgd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 5 Dec 2021 15:36:33 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B5FE6LU002665
        for <bpf@vger.kernel.org>; Sun, 5 Dec 2021 12:33:05 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3crs872f19-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 05 Dec 2021 12:33:05 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 5 Dec 2021 12:33:03 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 86BFDBFD77BF; Sun,  5 Dec 2021 12:32:56 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 09/11] selftests/bpf: add test for libbpf's custom log_buf behavior
Date:   Sun, 5 Dec 2021 12:32:32 -0800
Message-ID: <20211205203234.1322242-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211205203234.1322242-1-andrii@kernel.org>
References: <20211205203234.1322242-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: RQVCtz5cidOx3Hd5Bvu_timSw8t0mIgX
X-Proofpoint-GUID: RQVCtz5cidOx3Hd5Bvu_timSw8t0mIgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-05_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112050123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest that validates that per-program and per-object log_buf
overrides work as expected.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/log_buf.c        | 137 ++++++++++++++++++
 .../selftests/bpf/progs/test_log_buf.c        |  24 +++
 2 files changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/log_buf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_log_buf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
new file mode 100644
index 000000000000..1d26e45b1973
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <test_progs.h>
+
+#include "test_log_buf.skel.h"
+
+static size_t libbpf_log_pos;
+static char libbpf_log_buf[1024 * 1024];
+static bool libbpf_log_error;
+
+static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt, va_list args)
+{
+	int emitted_cnt;
+	size_t left_cnt;
+
+	left_cnt = sizeof(libbpf_log_buf) - libbpf_log_pos;
+	emitted_cnt = vsnprintf(libbpf_log_buf + libbpf_log_pos, left_cnt, fmt, args);
+
+	if (emitted_cnt < 0 || emitted_cnt + 1 > left_cnt) {
+		libbpf_log_error = true;
+		return 0;
+	}
+
+	libbpf_log_pos += emitted_cnt;
+	return 0;
+}
+
+void test_log_buf(void)
+{
+	libbpf_print_fn_t old_print_cb = libbpf_set_print(libbpf_print_cb);
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	const size_t log_buf_sz = 1024 * 1024;
+	struct test_log_buf* skel;
+	char *obj_log_buf, *good_log_buf, *bad_log_buf;
+	int err;
+
+	obj_log_buf = malloc(3 *log_buf_sz);
+	if (!ASSERT_OK_PTR(obj_log_buf, "obj_log_buf"))
+		return;
+
+	good_log_buf = obj_log_buf + log_buf_sz;
+	bad_log_buf = obj_log_buf + 2 * log_buf_sz;
+	obj_log_buf[0] = good_log_buf[0] = bad_log_buf[0] = '\0';
+
+	opts.kernel_log_buf = obj_log_buf;
+	opts.kernel_log_size = log_buf_sz;
+	opts.kernel_log_level = 4; /* for BTF this will turn into 1 */
+
+	/* In the first round every prog has its own log_buf, so libbpf logs
+	 * don't have program failure logs
+	 */
+	skel = test_log_buf__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	/* set very verbose level for good_prog so we always get detailed logs */
+	bpf_program__set_log_buf(skel->progs.good_prog, good_log_buf, log_buf_sz);
+	bpf_program__set_log_level(skel->progs.good_prog, 2);
+
+	bpf_program__set_log_buf(skel->progs.bad_prog, bad_log_buf, log_buf_sz);
+	/* log_level 0 with custom log_buf means that verbose logs are not
+	 * requested if program load is successful, but libbpf should retry
+	 * with log_level 1 on error and put program's verbose load log into
+	 * custom log_buf
+	 */
+	bpf_program__set_log_level(skel->progs.bad_prog, 0);
+
+	err = test_log_buf__load(skel);
+	if (!ASSERT_ERR(err, "unexpected_load_success"))
+		goto cleanup;
+
+	ASSERT_FALSE(libbpf_log_error, "libbpf_log_error");
+
+	/* there should be no prog loading log because we specified per-prog log buf */
+	ASSERT_NULL(strstr(libbpf_log_buf, "-- BEGIN PROG LOAD LOG --"), "unexp_libbpf_log");
+	ASSERT_OK_PTR(strstr(libbpf_log_buf, "prog 'bad_prog': BPF program load failed"),
+		      "libbpf_log_not_empty");
+	ASSERT_OK_PTR(strstr(obj_log_buf, "DATASEC license"), "obj_log_not_empty");
+	ASSERT_OK_PTR(strstr(good_log_buf, "0: R1=ctx(id=0,off=0,imm=0) R10=fp0"),
+		      "good_log_verbose");
+	ASSERT_OK_PTR(strstr(bad_log_buf, "invalid access to map value, value_size=16 off=16000 size=4"),
+		      "bad_log_not_empty");
+
+	if (env.verbosity > VERBOSE_NONE) {
+		printf("LIBBPF LOG:   \n=================\n%s=================\n", libbpf_log_buf);
+		printf("OBJ LOG:      \n=================\n%s=================\n", obj_log_buf);
+		printf("GOOD_PROG LOG:\n=================\n%s=================\n", good_log_buf);
+		printf("BAD_PROG  LOG:\n=================\n%s=================\n", bad_log_buf);
+	}
+
+	/* reset everything */
+	test_log_buf__destroy(skel);
+	obj_log_buf[0] = good_log_buf[0] = bad_log_buf[0] = '\0';
+	libbpf_log_buf[0] = '\0';
+	libbpf_log_pos = 0;
+	libbpf_log_error = false;
+
+	/* In the second round we let bad_prog's failure be logged through print callback */
+	opts.kernel_log_buf = NULL; /* let everything through into print callback */
+	opts.kernel_log_size = 0;
+	opts.kernel_log_level = 1;
+
+	skel = test_log_buf__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	/* set normal verbose level for good_prog to check log_level is taken into account */
+	bpf_program__set_log_buf(skel->progs.good_prog, good_log_buf, log_buf_sz);
+	bpf_program__set_log_level(skel->progs.good_prog, 1);
+
+	err = test_log_buf__load(skel);
+	if (!ASSERT_ERR(err, "unexpected_load_success"))
+		goto cleanup;
+
+	ASSERT_FALSE(libbpf_log_error, "libbpf_log_error");
+
+	/* this time prog loading error should be logged through print callback */
+	ASSERT_OK_PTR(strstr(libbpf_log_buf, "libbpf: prog 'bad_prog': -- BEGIN PROG LOAD LOG --"),
+		      "libbpf_log_correct");
+	ASSERT_STREQ(obj_log_buf, "", "obj_log__empty");
+	ASSERT_STREQ(good_log_buf, "processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0\n",
+		     "good_log_ok");
+	ASSERT_STREQ(bad_log_buf, "", "bad_log_empty");
+
+	if (env.verbosity > VERBOSE_NONE) {
+		printf("LIBBPF LOG:   \n=================\n%s=================\n", libbpf_log_buf);
+		printf("OBJ LOG:      \n=================\n%s=================\n", obj_log_buf);
+		printf("GOOD_PROG LOG:\n=================\n%s=================\n", good_log_buf);
+		printf("BAD_PROG  LOG:\n=================\n%s=================\n", bad_log_buf);
+	}
+
+cleanup:
+	free(obj_log_buf);
+	test_log_buf__destroy(skel);
+	libbpf_set_print(old_print_cb);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_log_buf.c b/tools/testing/selftests/bpf/progs/test_log_buf.c
new file mode 100644
index 000000000000..199f459bd5ae
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_log_buf.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+int a[4];
+const volatile int off = 4000;
+
+SEC("raw_tp/sys_enter")
+int good_prog(const void *ctx)
+{
+	a[0] = (int)(long)ctx;
+	return a[1];
+}
+
+SEC("raw_tp/sys_enter")
+int bad_prog(const void *ctx)
+{
+	/* out of bounds access */
+	return a[off];
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

