Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7315A445DB1
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 02:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhKECAn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 22:00:43 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:27177 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhKECAm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 22:00:42 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HlkBk2DLwz8v7F;
        Fri,  5 Nov 2021 09:56:30 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 5 Nov 2021 09:58:01 +0800
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500011.china.huawei.com (7.185.36.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 5 Nov 2021 09:58:00 +0800
From:   Di Zhu <zhudi2@huawei.com>
To:     <davem@davemloft.net>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <jakub@cloudflare.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhudi2@huawei.com>
Subject: [PATCH bpf-next v5 2/2] selftests: bpf: test BPF_PROG_QUERY for progs attached to sockmap
Date:   Fri, 5 Nov 2021 09:57:30 +0800
Message-ID: <20211105015730.1605333-2-zhudi2@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211105015730.1605333-1-zhudi2@huawei.com>
References: <20211105015730.1605333-1-zhudi2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500011.china.huawei.com (7.185.36.84)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test for querying progs attached to sockmap. we use an existing
libbpf query interface to query prog cnt before and after progs
attaching to sockmap and check whether the queried prog id is right.

Signed-off-by: Di Zhu <zhudi2@huawei.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 70 +++++++++++++++++++
 .../bpf/progs/test_sockmap_progs_query.c      | 24 +++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1352ec104149..4d94b72f2d8d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -8,6 +8,7 @@
 #include "test_sockmap_update.skel.h"
 #include "test_sockmap_invalid_update.skel.h"
 #include "test_sockmap_skb_verdict_attach.skel.h"
+#include "test_sockmap_progs_query.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
@@ -315,6 +316,69 @@ static void test_sockmap_skb_verdict_attach(enum bpf_attach_type first,
 	test_sockmap_skb_verdict_attach__destroy(skel);
 }
 
+static __u32 query_prog_id(int prog_fd)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	int err;
+
+	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd") ||
+	    !ASSERT_EQ(info_len, sizeof(info), "bpf_obj_get_info_by_fd"))
+		return 0;
+
+	return info.id;
+}
+
+static void test_sockmap_progs_query(enum bpf_attach_type attach_type)
+{
+	struct test_sockmap_progs_query *skel;
+	int err, map_fd, verdict_fd, duration = 0;
+	__u32 attach_flags = 0;
+	__u32 prog_ids[3] = {};
+	__u32 prog_cnt = 3;
+
+	skel = test_sockmap_progs_query__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_sockmap_progs_query__open_and_load"))
+		return;
+
+	map_fd = bpf_map__fd(skel->maps.sock_map);
+
+	if (attach_type == BPF_SK_MSG_VERDICT)
+		verdict_fd = bpf_program__fd(skel->progs.prog_skmsg_verdict);
+	else
+		verdict_fd = bpf_program__fd(skel->progs.prog_skb_verdict);
+
+	err = bpf_prog_query(map_fd, attach_type, 0 /* query flags */,
+			     &attach_flags, prog_ids, &prog_cnt);
+	if (!ASSERT_OK(err, "bpf_prog_query failed"))
+		goto out;
+
+	if (!ASSERT_EQ(attach_flags,  0, "wrong attach_flags on query"))
+		goto out;
+
+	if (!ASSERT_EQ(prog_cnt, 0, "wrong program count on query"))
+		goto out;
+
+	err = bpf_prog_attach(verdict_fd, map_fd, attach_type, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach failed"))
+		goto out;
+
+	prog_cnt = 1;
+	err = bpf_prog_query(map_fd, attach_type, 0 /* query flags */,
+			     &attach_flags, prog_ids, &prog_cnt);
+
+	ASSERT_OK(err, "bpf_prog_query failed");
+	ASSERT_EQ(attach_flags, 0, "wrong attach_flags on query");
+	ASSERT_EQ(prog_cnt, 1, "wrong program count on query");
+	ASSERT_EQ(prog_ids[0], query_prog_id(verdict_fd),
+		  "wrong prog_ids on query");
+
+	bpf_prog_detach2(verdict_fd, map_fd, attach_type);
+out:
+	test_sockmap_progs_query__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -341,4 +405,10 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_attach(BPF_SK_SKB_STREAM_VERDICT,
 						BPF_SK_SKB_VERDICT);
 	}
+	if (test__start_subtest("sockmap progs query")) {
+		test_sockmap_progs_query(BPF_SK_MSG_VERDICT);
+		test_sockmap_progs_query(BPF_SK_SKB_STREAM_PARSER);
+		test_sockmap_progs_query(BPF_SK_SKB_STREAM_VERDICT);
+		test_sockmap_progs_query(BPF_SK_SKB_VERDICT);
+	}
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c b/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
new file mode 100644
index 000000000000..9d58d61c0dee
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} sock_map SEC(".maps");
+
+SEC("sk_skb")
+int prog_skb_verdict(struct __sk_buff *skb)
+{
+	return SK_PASS;
+}
+
+SEC("sk_msg")
+int prog_skmsg_verdict(struct sk_msg_md *msg)
+{
+	return SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.27.0

