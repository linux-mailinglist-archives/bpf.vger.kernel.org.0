Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDCA6DEA9D
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 06:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDLEem convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 12 Apr 2023 00:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDLEeX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 00:34:23 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8364EDA
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:34:10 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNTgov016733
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:34:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pw088fcwe-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 21:34:09 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 21:33:32 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 11 Apr 2023 21:33:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 48FCF2DCF4531; Tue, 11 Apr 2023 21:33:23 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kpsingh@kernel.org>, <keescook@chromium.org>,
        <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 5/8] selftests/bpf: validate new bpf_map_create_security LSM hook
Date:   Tue, 11 Apr 2023 21:32:57 -0700
Message-ID: <20230412043300.360803-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412043300.360803-1-andrii@kernel.org>
References: <20230412043300.360803-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lBJeztPHPuRePuWwTCHy0uUyuNO6m-1v
X-Proofpoint-GUID: lBJeztPHPuRePuWwTCHy0uUyuNO6m-1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftests that goes over every known map type and validates that
a combination of privileged/unprivileged modes and allow/reject/pass-through
LSM policy decisions behave as expected.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/lsm_map_create.c | 143 ++++++++++++++++++
 .../selftests/bpf/progs/lsm_map_create.c      |  32 ++++
 tools/testing/selftests/bpf/test_progs.h      |   6 +
 3 files changed, 181 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_map_create.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_map_create.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_map_create.c b/tools/testing/selftests/bpf/prog_tests/lsm_map_create.c
new file mode 100644
index 000000000000..fee78b0448c3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_map_create.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include "linux/bpf.h"
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "cap_helpers.h"
+#include "lsm_map_create.skel.h"
+
+static int drop_priv_caps(__u64 *old_caps)
+{
+	return cap_disable_effective((1ULL << CAP_BPF) |
+				     (1ULL << CAP_PERFMON) |
+				     (1ULL << CAP_NET_ADMIN) |
+				     (1ULL << CAP_SYS_ADMIN), old_caps);
+}
+
+static int restore_priv_caps(__u64 old_caps)
+{
+	return cap_enable_effective(old_caps, NULL);
+}
+
+void test_lsm_map_create(void)
+{
+	struct btf *btf = NULL;
+	struct lsm_map_create *skel = NULL;
+	const struct btf_type *t;
+	const struct btf_enum *e;
+	int i, n, id, err, ret;
+
+	skel = lsm_map_create__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	skel->bss->my_tid = syscall(SYS_gettid);
+	skel->bss->decision = 0;
+
+	err = lsm_map_create__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+		goto cleanup;
+
+	/* find enum bpf_map_type and enumerate each value */
+	id = btf__find_by_name_kind(btf, "bpf_map_type", BTF_KIND_ENUM);
+	if (!ASSERT_GT(id, 0, "bpf_map_type_id"))
+		goto cleanup;
+
+	t = btf__type_by_id(btf, id);
+	e = btf_enum(t);
+	n = btf_vlen(t);
+	for (i = 0; i < n; e++, i++) {
+		enum bpf_map_type map_type = (enum bpf_map_type)e->val;
+		const char *map_type_name;
+		__u64 orig_caps;
+		bool is_map_priv;
+		bool needs_btf;
+
+		if (map_type == BPF_MAP_TYPE_UNSPEC)
+			continue;
+
+		/* this will show which map type we are working with in verbose log */
+		map_type_name = btf__str_by_offset(btf, e->name_off);
+		ASSERT_OK_PTR(map_type_name, map_type_name);
+
+		switch (map_type) {
+		case BPF_MAP_TYPE_ARRAY:
+		case BPF_MAP_TYPE_PERCPU_ARRAY:
+		case BPF_MAP_TYPE_PROG_ARRAY:
+		case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
+		case BPF_MAP_TYPE_CGROUP_ARRAY:
+		case BPF_MAP_TYPE_ARRAY_OF_MAPS:
+		case BPF_MAP_TYPE_HASH:
+		case BPF_MAP_TYPE_PERCPU_HASH:
+		case BPF_MAP_TYPE_HASH_OF_MAPS:
+		case BPF_MAP_TYPE_RINGBUF:
+		case BPF_MAP_TYPE_USER_RINGBUF:
+		case BPF_MAP_TYPE_CGROUP_STORAGE:
+		case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
+			is_map_priv = false;
+			needs_btf = false;
+			break;
+		case BPF_MAP_TYPE_SK_STORAGE:
+		case BPF_MAP_TYPE_INODE_STORAGE:
+		case BPF_MAP_TYPE_TASK_STORAGE:
+		case BPF_MAP_TYPE_CGRP_STORAGE:
+			is_map_priv = true;
+			needs_btf = true;
+			break;
+		default:
+			is_map_priv = true;
+			needs_btf = false;
+		}
+
+		/* make sure we delegate to kernel for final decision */
+		skel->bss->decision = 0;
+
+		/* we are normally under sudo, so all maps should succeed */
+		ret = libbpf_probe_bpf_map_type(map_type, NULL);
+		ASSERT_EQ(ret, 1, "default_priv_mode");
+
+		/* local storage needs custom BTF to be loaded, which we
+		 * currently can't do once we drop privileges, so skip few
+		 * checks for such maps
+		 */
+		if (needs_btf)
+			goto skip_if_needs_btf;
+
+		/* now let's drop privileges, and chech that unpriv maps are
+		 * still possible to create
+		 */
+		if (!ASSERT_OK(drop_priv_caps(&orig_caps), "drop_caps"))
+			goto cleanup;
+
+		ret = libbpf_probe_bpf_map_type(map_type, NULL);
+		ASSERT_EQ(ret, is_map_priv ? 0 : 1,  "default_unpriv_mode");
+
+		/* allow any map creation for our thread */
+		skel->bss->decision = 1;
+		ret = libbpf_probe_bpf_map_type(map_type, NULL);
+		ASSERT_EQ(ret, 1, "lsm_allow_unpriv_mode");
+
+		/* reject any map creation for our thread */
+		skel->bss->decision = -1;
+		ret = libbpf_probe_bpf_map_type(map_type, NULL);
+		ASSERT_EQ(ret, 0, "lsm_reject_unpriv_mode");
+
+		/* restore privileges, but keep reject LSM policy */
+		if (!ASSERT_OK(restore_priv_caps(orig_caps), "restore_caps"))
+			goto cleanup;
+
+skip_if_needs_btf:
+		/* even with all caps map create will fail */
+		skel->bss->decision = -1;
+		ret = libbpf_probe_bpf_map_type(map_type, NULL);
+		ASSERT_EQ(ret, 0, "lsm_reject_priv_mode");
+	}
+
+cleanup:
+	btf__free(btf);
+	lsm_map_create__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_map_create.c b/tools/testing/selftests/bpf/progs/lsm_map_create.c
new file mode 100644
index 000000000000..093825c68459
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_map_create.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+char _license[] SEC("license") = "GPL";
+
+int my_tid;
+/* LSM enforcement:
+ *   - 0, delegate to kernel;
+ *   - 1, allow;
+ *   - -1, reject.
+ */
+int decision;
+
+SEC("lsm/bpf_map_create_security")
+int BPF_PROG(allow_unpriv_maps, union bpf_attr *attr)
+{
+	if (!my_tid || (u32)bpf_get_current_pid_tgid() != my_tid)
+		return 0; /* keep processing LSM hooks */
+
+	if (decision == 0)
+		return 0;
+
+	if (decision > 0)
+		return 1; /* allow */
+
+	return -EPERM;
+}
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 10ba43250668..12f9c6652d40 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -23,6 +23,7 @@ typedef __u16 __sum16;
 #include <linux/perf_event.h>
 #include <linux/socket.h>
 #include <linux/unistd.h>
+#include <sys/syscall.h>
 
 #include <sys/ioctl.h>
 #include <sys/wait.h>
@@ -176,6 +177,11 @@ void test__skip(void);
 void test__fail(void);
 int test__join_cgroup(const char *path);
 
+static inline int gettid(void)
+{
+	return syscall(SYS_gettid);
+}
+
 #define PRINT_FAIL(format...)                                                  \
 	({                                                                     \
 		test__fail();                                                  \
-- 
2.34.1

