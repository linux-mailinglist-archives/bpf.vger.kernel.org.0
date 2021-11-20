Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46804457A5D
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 02:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhKTBSq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 19 Nov 2021 20:18:46 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62686 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234335AbhKTBSq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Nov 2021 20:18:46 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJHkmQj010595
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 17:15:41 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ce68epxt8-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 17:15:41 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 19 Nov 2021 17:15:02 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3D57F9DD172B; Fri, 19 Nov 2021 17:14:58 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: mix legacy (maps) and modern (vars) BPF in one test
Date:   Fri, 19 Nov 2021 17:14:55 -0800
Message-ID: <20211120011455.3679237-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211120011455.3679237-1-andrii@kernel.org>
References: <20211120011455.3679237-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: XPOODZsQmk-C2sLKIx01xaKPbtwRoKyc
X-Proofpoint-ORIG-GUID: XPOODZsQmk-C2sLKIx01xaKPbtwRoKyc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_16,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111200006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftest that combines two BPF programs within single BPF object
file such that one of the programs is using global variables, but can be
skipped at runtime on old kernels that don't support global data.
Another BPF program is written with the goal to be runnable on very old
kernels and only relies on explicitly accessed BPF maps.

Such test, run against old kernels (e.g., libbpf CI will run it against 4.9
kernel that doesn't support global data), allows to test the approach
and ensure that libbpf doesn't make unnecessary assumption about
necessary kernel features.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/legacy_printk.c  | 65 +++++++++++++++++++
 .../selftests/bpf/progs/test_legacy_printk.c  | 65 +++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/legacy_printk.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_legacy_printk.c

diff --git a/tools/testing/selftests/bpf/prog_tests/legacy_printk.c b/tools/testing/selftests/bpf/prog_tests/legacy_printk.c
new file mode 100644
index 000000000000..ec6e45f2a644
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/legacy_printk.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include "test_legacy_printk.skel.h"
+
+static int execute_one_variant(bool legacy)
+{
+	struct test_legacy_printk *skel;
+	int err, zero = 0, my_pid = getpid(), res, map_fd;
+
+	skel = test_legacy_printk__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return -errno;
+
+	bpf_program__set_autoload(skel->progs.handle_legacy, legacy);
+	bpf_program__set_autoload(skel->progs.handle_modern, !legacy);
+
+	err = test_legacy_printk__load(skel);
+	/* no ASSERT_OK, we expect one of two variants can fail here */
+	if (err)
+		goto err_out;
+
+	if (legacy) {
+		map_fd = bpf_map__fd(skel->maps.my_pid_map);
+		err = bpf_map_update_elem(map_fd, &zero, &my_pid, BPF_ANY);
+		if (!ASSERT_OK(err, "my_pid_map_update"))
+			goto err_out;
+		err = bpf_map_lookup_elem(map_fd, &zero, &res);
+	} else {
+		skel->bss->my_pid_var = my_pid;
+	}
+
+	err = test_legacy_printk__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto err_out;
+
+	usleep(1); /* trigger */
+
+	if (legacy) {
+		map_fd = bpf_map__fd(skel->maps.res_map);
+		err = bpf_map_lookup_elem(map_fd, &zero, &res);
+		if (!ASSERT_OK(err, "res_map_lookup"))
+			goto err_out;
+	} else {
+		res = skel->bss->res_var;
+	}
+
+	if (!ASSERT_GT(res, 0, "res")) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+err_out:
+	test_legacy_printk__destroy(skel);
+	return err;
+}
+
+void test_legacy_printk(void)
+{
+	/* legacy variant should work everywhere */
+	ASSERT_OK(execute_one_variant(true /* legacy */), "legacy_case");
+
+	/* execute modern variant, can fail the load on old kernels */
+	execute_one_variant(false);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_legacy_printk.c b/tools/testing/selftests/bpf/progs/test_legacy_printk.c
new file mode 100644
index 000000000000..96d945781e77
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_legacy_printk.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bpf.h>
+#define BPF_NO_GLOBAL_DATA
+#include <bpf/bpf_helpers.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+} my_pid_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+} res_map SEC(".maps");
+
+volatile int my_pid_var = 0;
+volatile int res_var = 0;
+
+SEC("tp/raw_syscalls/sys_enter")
+int handle_legacy(void *ctx)
+{
+	int zero = 0, *my_pid, cur_pid, *my_res;
+
+	my_pid = bpf_map_lookup_elem(&my_pid_map, &zero);
+	if (!my_pid)
+		return 1;
+
+	cur_pid = bpf_get_current_pid_tgid() >> 32;
+	if (cur_pid != *my_pid)
+		return 1;
+
+	my_res = bpf_map_lookup_elem(&res_map, &zero);
+	if (!my_res)
+		return 1;
+
+	if (*my_res == 0)
+		bpf_printk("Legacy-case bpf_printk test, pid %d\n", cur_pid);
+	*my_res = 1;
+
+	return *my_res;
+}
+
+SEC("tp/raw_syscalls/sys_enter")
+int handle_modern(void *ctx)
+{
+	int zero = 0, cur_pid;
+
+	cur_pid = bpf_get_current_pid_tgid() >> 32;
+	if (cur_pid != my_pid_var)
+		return 1;
+
+	if (res_var == 0)
+		bpf_printk("Modern-case bpf_printk test, pid %d\n", cur_pid);
+	res_var = 1;
+
+	return res_var;
+}
-- 
2.30.2

