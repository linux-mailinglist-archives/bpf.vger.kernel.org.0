Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B9241A59F
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 04:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhI1CkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 22:40:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13343 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbhI1CkN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 22:40:13 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HJNqR4LFCz8ywr;
        Tue, 28 Sep 2021 10:33:55 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 10:38:32 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 10:38:32 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: test return value handling for struct_ops prog
Date:   Tue, 28 Sep 2021 10:52:28 +0800
Message-ID: <20210928025228.88673-6-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928025228.88673-1-houtao1@huawei.com>
References: <20210928025228.88673-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Running a BPF_PROG_TYPE_STRUCT_OPS prog for dummy_st_ops::init()
through bpf_prog_test_run(). Three test cases are added:
(1) attach dummy_st_ops should fail
(2) function return value of bpf_dummy_ops::init() is expected
(3) pointer argument of bpf_dummy_ops::init() works as expected

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/dummy_st_ops.c   | 81 +++++++++++++++++++
 .../selftests/bpf/progs/dummy_st_ops.c        | 33 ++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/dummy_st_ops.c

diff --git a/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
new file mode 100644
index 000000000000..4b1b52b847e6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dummy_st_ops.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021. Huawei Technologies Co., Ltd */
+#include <test_progs.h>
+#include "dummy_st_ops.skel.h"
+
+/* Need to keep consistent with definitions in include/linux/bpf_dummy_ops.h */
+struct bpf_dummy_ops_state {
+	int val;
+};
+
+static void test_dummy_st_ops_attach(void)
+{
+	struct dummy_st_ops *skel;
+	struct bpf_link *link;
+
+	skel = dummy_st_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
+		goto out;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dummy_1);
+	if (!ASSERT_EQ(libbpf_get_error(link), -EOPNOTSUPP,
+		       "dummy_st_ops_attach"))
+		goto out;
+out:
+	dummy_st_ops__destroy(skel);
+}
+
+static void test_dummy_init_ret_value(void)
+{
+	struct dummy_st_ops *skel;
+	int err, fd;
+	__u32 duration = 0, retval = 0;
+
+	skel = dummy_st_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
+		goto out;
+
+	fd = bpf_program__fd(skel->progs.init_1);
+	err = bpf_prog_test_run(fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(retval, 0xf2f3f4f5, "test_ret");
+out:
+	dummy_st_ops__destroy(skel);
+}
+
+static void test_dummy_init_ptr_arg(void)
+{
+	struct dummy_st_ops *skel;
+	int err, fd;
+	__u32 duration = 0, retval = 0;
+	struct bpf_dummy_ops_state in_state, out_state;
+	__u32 state_size;
+
+	skel = dummy_st_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "dummy_st_ops_load"))
+		goto out;
+
+	fd = bpf_program__fd(skel->progs.init_1);
+	memset(&in_state, 0, sizeof(in_state));
+	in_state.val = 0xbeef;
+	memset(&out_state, 0, sizeof(out_state));
+	err = bpf_prog_test_run(fd, 1, &in_state, sizeof(in_state),
+				&out_state, &state_size, &retval, &duration);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(state_size, sizeof(out_state), "test_data_out");
+	ASSERT_EQ(out_state.val, 0x5a, "test_ptr_ret");
+	ASSERT_EQ(retval, in_state.val, "test_ret");
+out:
+	dummy_st_ops__destroy(skel);
+}
+
+void test_dummy_st_ops(void)
+{
+	if (test__start_subtest("dummy_st_ops_attach"))
+		test_dummy_st_ops_attach();
+	if (test__start_subtest("dummy_init_ret_value"))
+		test_dummy_init_ret_value();
+	if (test__start_subtest("dummy_init_ptr_arg"))
+		test_dummy_init_ptr_arg();
+}
diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops.c b/tools/testing/selftests/bpf/progs/dummy_st_ops.c
new file mode 100644
index 000000000000..133c328f082a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021. Huawei Technologies Co., Ltd */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct bpf_dummy_ops_state {
+	int val;
+} __attribute__((preserve_access_index));
+
+struct bpf_dummy_ops {
+	int (*init)(struct bpf_dummy_ops_state *state);
+};
+
+char _liencse[] SEC("license") = "GPL";
+
+SEC("struct_ops/init_1")
+int BPF_PROG(init_1, struct bpf_dummy_ops_state *state)
+{
+	int ret;
+
+	if (!state)
+		return 0xf2f3f4f5;
+
+	ret = state->val;
+	state->val = 0x5a;
+	return ret;
+}
+
+SEC(".struct_ops")
+struct bpf_dummy_ops dummy_1 = {
+	.init = (void *)init_1,
+};
-- 
2.29.2

