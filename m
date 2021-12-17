Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADCE47927C
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhLQRMR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 17 Dec 2021 12:12:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4356 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237090AbhLQRMQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Dec 2021 12:12:16 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BH9E9Y2011417
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 09:12:16 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d0qr1ts3w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 09:12:16 -0800
Received: from twshared5363.25.prn2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 09:12:14 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 27ADDD7374A1; Fri, 17 Dec 2021 09:12:08 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 2/3] selftests/bpf: add libbpf feature-probing API selftests
Date:   Fri, 17 Dec 2021 09:12:01 -0800
Message-ID: <20211217171202.3352835-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217171202.3352835-1-andrii@kernel.org>
References: <20211217171202.3352835-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tDe6ySycjF33ApoVNskyS9p0hJ_ObOBg
X-Proofpoint-ORIG-GUID: tDe6ySycjF33ApoVNskyS9p0hJ_ObOBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-17_07,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add selftests for prog/map/prog+helper feature probing APIs. Prog and
map selftests are designed in such a way that they will always test all
the possible prog/map types, based on running kernel's vmlinux BTF enum
definition. This way we'll always be sure that when adding new BPF
program types or map types, libbpf will be always updated accordingly to
be able to feature-detect them.

BPF prog_helper selftest will have to be manually extended with
interesting and important prog+helper combinations, it's easy, but can't
be completely automated.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 124 ++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_probes.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 5192305159ec..f6287132fa89 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -38,7 +38,9 @@ CONFIG_IPV6_SIT=m
 CONFIG_BPF_JIT=y
 CONFIG_BPF_LSM=y
 CONFIG_SECURITY=y
+CONFIG_RC_CORE=y
 CONFIG_LIRC=y
+CONFIG_BPF_LIRC_MODE2=y
 CONFIG_IMA=y
 CONFIG_SECURITYFS=y
 CONFIG_IMA_WRITE_POLICY=y
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
new file mode 100644
index 000000000000..9f766ddd946a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Facebook */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+void test_libbpf_probe_prog_types(void)
+{
+	struct btf *btf;
+	const struct btf_type *t;
+	const struct btf_enum *e;
+	int i, n, id;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+		return;
+
+	/* find enum bpf_prog_type and enumerate each value */
+	id = btf__find_by_name_kind(btf, "bpf_prog_type", BTF_KIND_ENUM);
+	if (!ASSERT_GT(id, 0, "bpf_prog_type_id"))
+		goto cleanup;
+	t = btf__type_by_id(btf, id);
+	if (!ASSERT_OK_PTR(t, "bpf_prog_type_enum"))
+		goto cleanup;
+
+	for (e = btf_enum(t), i = 0, n = btf_vlen(t); i < n; e++, i++) {
+		const char *prog_type_name = btf__str_by_offset(btf, e->name_off);
+		enum bpf_prog_type prog_type = (enum bpf_prog_type)e->val;
+		int res;
+
+		if (prog_type == BPF_PROG_TYPE_UNSPEC)
+			continue;
+
+		if (!test__start_subtest(prog_type_name))
+			continue;
+
+		res = libbpf_probe_bpf_prog_type(prog_type, NULL);
+		ASSERT_EQ(res, 1, prog_type_name);
+	}
+
+cleanup:
+	btf__free(btf);
+}
+
+void test_libbpf_probe_map_types(void)
+{
+	struct btf *btf;
+	const struct btf_type *t;
+	const struct btf_enum *e;
+	int i, n, id;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+		return;
+
+	/* find enum bpf_map_type and enumerate each value */
+	id = btf__find_by_name_kind(btf, "bpf_map_type", BTF_KIND_ENUM);
+	if (!ASSERT_GT(id, 0, "bpf_map_type_id"))
+		goto cleanup;
+	t = btf__type_by_id(btf, id);
+	if (!ASSERT_OK_PTR(t, "bpf_map_type_enum"))
+		goto cleanup;
+
+	for (e = btf_enum(t), i = 0, n = btf_vlen(t); i < n; e++, i++) {
+		const char *map_type_name = btf__str_by_offset(btf, e->name_off);
+		enum bpf_map_type map_type = (enum bpf_map_type)e->val;
+		int res;
+
+		if (map_type == BPF_MAP_TYPE_UNSPEC)
+			continue;
+
+		if (!test__start_subtest(map_type_name))
+			continue;
+
+		res = libbpf_probe_bpf_map_type(map_type, NULL);
+		ASSERT_EQ(res, 1, map_type_name);
+	}
+
+cleanup:
+	btf__free(btf);
+}
+
+void test_libbpf_probe_helpers(void)
+{
+#define CASE(prog, helper, supp) {			\
+	.prog_type_name = "BPF_PROG_TYPE_" # prog,	\
+	.helper_name = "bpf_" # helper,			\
+	.prog_type = BPF_PROG_TYPE_ ## prog,		\
+	.helper_id = BPF_FUNC_ ## helper,		\
+	.supported = supp,				\
+}
+	const struct case_def {
+		const char *prog_type_name;
+		const char *helper_name;
+		enum bpf_prog_type prog_type;
+		enum bpf_func_id helper_id;
+		bool supported;
+	} cases[] = {
+		CASE(KPROBE, unspec, false),
+		CASE(KPROBE, map_lookup_elem, true),
+		CASE(KPROBE, loop, true),
+
+		CASE(KPROBE, ktime_get_coarse_ns, false),
+		CASE(SOCKET_FILTER, ktime_get_coarse_ns, true),
+
+		CASE(KPROBE, sys_bpf, false),
+		CASE(SYSCALL, sys_bpf, true),
+	};
+	size_t case_cnt = ARRAY_SIZE(cases), i;
+	char buf[128];
+
+	for (i = 0; i < case_cnt; i++) {
+		const struct case_def *d = &cases[i];
+		int res;
+
+		snprintf(buf, sizeof(buf), "%s+%s", d->prog_type_name, d->helper_name);
+
+		if (!test__start_subtest(buf))
+			continue;
+
+		res = libbpf_probe_bpf_helper(d->prog_type, d->helper_id, NULL);
+		ASSERT_EQ(res, d->supported, buf);
+	}
+}
-- 
2.30.2

