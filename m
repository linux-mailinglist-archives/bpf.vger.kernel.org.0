Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC89439527
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 13:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhJYLsi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 07:48:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13978 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhJYLsh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 07:48:37 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HdCm35sMFzZcLN;
        Mon, 25 Oct 2021 19:44:19 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 19:46:13 +0800
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500011.china.huawei.com (7.185.36.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 19:46:12 +0800
From:   Di Zhu <zhudi2@huawei.com>
To:     <davem@davemloft.net>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <jakub@cloudflare.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhudi2@huawei.com>
Subject: [PATCH v3] bpf: support BPF_PROG_QUERY for progs attached to sockmap
Date:   Mon, 25 Oct 2021 19:36:08 +0800
Message-ID: <20211025113608.1511504-1-zhudi2@huawei.com>
X-Mailer: git-send-email 2.27.0
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

Right now there is no way to query whether BPF programs are
attached to a sockmap or not.

we can use the standard interface in libbpf to query, such as:
bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
the mapFd is the fd of sockmap.

Signed-off-by: Di Zhu <zhudi2@huawei.com>
---
/* v2 */
- John Fastabend <john.fastabend@gmail.com>
  - add selftest code

/* v3 */
 - avoid sleeping caused by copy_to_user() in rcu critical zone
---
 include/linux/bpf.h                           |  9 ++
 kernel/bpf/syscall.c                          |  5 ++
 net/core/sock_map.c                           | 88 +++++++++++++++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 85 ++++++++++++++++++
 .../bpf/progs/test_sockmap_progs_query.c      | 25 ++++++
 5 files changed, 205 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d604c8251d88..db7d0e5115b7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1961,6 +1961,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
 int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
 int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
+int sockmap_bpf_prog_query(const union bpf_attr *attr,
+				 union bpf_attr __user *uattr);
+
 void sock_map_unhash(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
 #else
@@ -2014,6 +2017,12 @@ static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int sockmap_bpf_prog_query(const union bpf_attr *attr,
+					       union bpf_attr __user *uattr)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_BPF_SYSCALL */
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e50c0bfdb7d..17faeff8f85f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3275,6 +3275,11 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_FLOW_DISSECTOR:
 	case BPF_SK_LOOKUP:
 		return netns_bpf_prog_query(attr, uattr);
+	case BPF_SK_SKB_STREAM_PARSER:
+	case BPF_SK_SKB_STREAM_VERDICT:
+	case BPF_SK_MSG_VERDICT:
+	case BPF_SK_SKB_VERDICT:
+		return sockmap_bpf_prog_query(attr, uattr);
 	default:
 		return -EINVAL;
 	}
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index e252b8ec2b85..ca65ed0004d3 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1412,38 +1412,50 @@ static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
 	return NULL;
 }
 
-static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
-				struct bpf_prog *old, u32 which)
+static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog **pprog[],
+				u32 which)
 {
 	struct sk_psock_progs *progs = sock_map_progs(map);
-	struct bpf_prog **pprog;
 
 	if (!progs)
 		return -EOPNOTSUPP;
 
 	switch (which) {
 	case BPF_SK_MSG_VERDICT:
-		pprog = &progs->msg_parser;
+		*pprog = &progs->msg_parser;
 		break;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 	case BPF_SK_SKB_STREAM_PARSER:
-		pprog = &progs->stream_parser;
+		*pprog = &progs->stream_parser;
 		break;
 #endif
 	case BPF_SK_SKB_STREAM_VERDICT:
 		if (progs->skb_verdict)
 			return -EBUSY;
-		pprog = &progs->stream_verdict;
+		*pprog = &progs->stream_verdict;
 		break;
 	case BPF_SK_SKB_VERDICT:
 		if (progs->stream_verdict)
 			return -EBUSY;
-		pprog = &progs->skb_verdict;
+		*pprog = &progs->skb_verdict;
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
+	return 0;
+}
+
+static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
+				struct bpf_prog *old, u32 which)
+{
+	struct bpf_prog **pprog;
+	int ret;
+
+	ret = sock_map_prog_lookup(map, &pprog, which);
+	if (ret)
+		return ret;
+
 	if (old)
 		return psock_replace_prog(pprog, prog, old);
 
@@ -1451,6 +1463,68 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 	return 0;
 }
 
+int sockmap_bpf_prog_query(const union bpf_attr *attr,
+			   union bpf_attr __user *uattr)
+{
+	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	u32 prog_cnt = 0, flags = 0;
+	u32 ufd = attr->target_fd;
+	struct bpf_prog **pprog;
+	struct bpf_prog *prog;
+	struct bpf_map *map;
+	struct fd f;
+	int ret;
+	u32 id = 0;
+
+	if (attr->query.query_flags)
+		return -EINVAL;
+
+	f = fdget(ufd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	rcu_read_lock();
+
+	ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
+	if (ret)
+		goto end;
+
+	prog = *pprog;
+	prog_cnt = (!prog) ? 0 : 1;
+
+	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
+		goto end;
+
+	prog = bpf_prog_inc_not_zero(prog);
+	if (IS_ERR(prog)) {
+		ret = PTR_ERR(prog);
+		goto end;
+	}
+	id = prog->aux->id;
+	bpf_prog_put(prog);
+
+end:
+	rcu_read_unlock();
+
+	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags))) {
+		ret = -EFAULT;
+		goto err;
+	}
+	if (id != 0 && copy_to_user(prog_ids, &id, sizeof(u32))) {
+		ret = -EFAULT;
+		goto err;
+	}
+	if (copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt))) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+err:
+	fdput(f);
+	return ret;
+}
+
 static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
 {
 	switch (link->map->map_type) {
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1352ec104149..23fd89661ef5 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -8,6 +8,7 @@
 #include "test_sockmap_update.skel.h"
 #include "test_sockmap_invalid_update.skel.h"
 #include "test_sockmap_skb_verdict_attach.skel.h"
+#include "test_sockmap_progs_query.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
@@ -315,6 +316,84 @@ static void test_sockmap_skb_verdict_attach(enum bpf_attach_type first,
 	test_sockmap_skb_verdict_attach__destroy(skel);
 }
 
+static __u32 query_prog_id(int prog)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	int err;
+
+	err = bpf_obj_get_info_by_fd(prog, &info, &info_len);
+	if (CHECK_FAIL(err || info_len != sizeof(info))) {
+		perror("bpf_obj_get_info_by_fd");
+		return 0;
+	}
+
+	return info.id;
+}
+
+static void test_sockmap_progs_query(enum bpf_attach_type attach_type)
+{
+	struct test_sockmap_progs_query *skel;
+	int err, map, verdict, duration = 0;
+	__u32 attach_flags = 0;
+	__u32 prog_ids[3] = {};
+	__u32 prog_cnt = 3;
+
+	skel = test_sockmap_progs_query__open_and_load();
+	if (CHECK_FAIL(!skel)) {
+		perror("test_sockmap_progs_query__open_and_load");
+		return;
+	}
+
+	map = bpf_map__fd(skel->maps.sock_map);
+
+	if (attach_type == BPF_SK_MSG_VERDICT)
+		verdict = bpf_program__fd(skel->progs.prog_skmsg_verdict);
+	else
+		verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
+
+	err = bpf_prog_query(map, attach_type, 0 /* query flags */,
+			     &attach_flags, prog_ids, &prog_cnt);
+	if (CHECK(err, "bpf_prog_query", "failed\n"))
+		goto out;
+
+	if (CHECK(attach_flags != 0, "bpf_prog_query",
+		  "wrong attach_flags on query: %u", attach_flags))
+		goto out;
+
+	if (CHECK(prog_cnt != 0, "bpf_prog_query",
+		  "wrong program count on query: %u", prog_cnt))
+		goto out;
+
+	err = bpf_prog_attach(verdict, map, attach_type, 0);
+	if (CHECK(err, "bpf_prog_attach", "failed\n"))
+		goto out;
+
+	prog_cnt = 1;
+	err = bpf_prog_query(map, attach_type, 0 /* query flags */,
+			     &attach_flags, prog_ids, &prog_cnt);
+	if (CHECK(err, "bpf_prog_query", "failed\n"))
+		goto detach;
+
+	if (CHECK(attach_flags != 0, "bpf_prog_query",
+		  "wrong attach_flags on query: %u", attach_flags))
+		goto detach;
+
+	if (CHECK(prog_cnt != 1, "bpf_prog_query",
+		  "wrong program count on query: %u", prog_cnt))
+		goto detach;
+
+	if (CHECK(prog_ids[0] != query_prog_id(verdict), "bpf_prog_query",
+		  "wrong prog id on query: %u", prog_ids[0]))
+		goto detach;
+
+detach:
+	bpf_prog_detach2(verdict, map, attach_type);
+out:
+	test_sockmap_progs_query__destroy(skel);
+
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -341,4 +420,10 @@ void test_sockmap_basic(void)
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
index 000000000000..ec0da297cf80
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
@@ -0,0 +1,25 @@
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
+
-- 
2.27.0

