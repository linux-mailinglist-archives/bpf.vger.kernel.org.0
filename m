Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542F348D4A4
	for <lists+bpf@lfdr.de>; Thu, 13 Jan 2022 10:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiAMJAy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 04:00:54 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30274 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiAMJAx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jan 2022 04:00:53 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JZJKl0vm6zbjtX;
        Thu, 13 Jan 2022 17:00:11 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 17:00:51 +0800
Received: from DESKTOP-9883QJJ.china.huawei.com (10.136.114.155) by
 dggpeml500011.china.huawei.com (7.185.36.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 17:00:50 +0800
From:   Di Zhu <zhudi2@huawei.com>
To:     <ast@kernel.org>, <davem@davemloft.net>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <jakub@cloudflare.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhudi2@huawei.com>, <luzhihao@huawei.com>, <rose.chen@huawei.com>
Subject: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs attached to sockmap
Date:   Thu, 13 Jan 2022 17:00:28 +0800
Message-ID: <20220113090029.1055-1-zhudi2@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.136.114.155]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
Acked-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h  |  9 +++++
 kernel/bpf/syscall.c |  5 +++
 net/core/sock_map.c  | 78 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6e947cd91152..c4ca14c9f838 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2071,6 +2071,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
 int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
 int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
+int sock_map_bpf_prog_query(const union bpf_attr *attr,
+			    union bpf_attr __user *uattr);
+
 void sock_map_unhash(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
 #else
@@ -2124,6 +2127,12 @@ static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
+					  union bpf_attr __user *uattr)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_BPF_SYSCALL */
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fa4505f9b611..9e0631f091a6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3318,6 +3318,11 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_FLOW_DISSECTOR:
 	case BPF_SK_LOOKUP:
 		return netns_bpf_prog_query(attr, uattr);
+	case BPF_SK_SKB_STREAM_PARSER:
+	case BPF_SK_SKB_STREAM_VERDICT:
+	case BPF_SK_MSG_VERDICT:
+	case BPF_SK_SKB_VERDICT:
+		return sock_map_bpf_prog_query(attr, uattr);
 	default:
 		return -EINVAL;
 	}
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 1827669eedd6..a424f51041ca 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1416,38 +1416,50 @@ static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
 	return NULL;
 }
 
-static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
-				struct bpf_prog *old, u32 which)
+static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
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
 
@@ -1455,6 +1467,58 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 	return 0;
 }
 
+int sock_map_bpf_prog_query(const union bpf_attr *attr,
+			    union bpf_attr __user *uattr)
+{
+	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	u32 prog_cnt = 0, flags = 0, ufd = attr->target_fd;
+	struct bpf_prog **pprog;
+	struct bpf_prog *prog;
+	struct bpf_map *map;
+	struct fd f;
+	u32 id = 0;
+	int ret;
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
+	prog_cnt = !prog ? 0 : 1;
+
+	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
+		goto end;
+
+	id = prog->aux->id;
+
+	/* we do not hold the refcnt, the bpf prog may be released
+	 * asynchronously and the id would be set to 0.
+	 */
+	if (id == 0)
+		prog_cnt = 0;
+
+end:
+	rcu_read_unlock();
+
+	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)) ||
+	    (id != 0 && copy_to_user(prog_ids, &id, sizeof(u32))) ||
+	    copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
+		ret = -EFAULT;
+
+	fdput(f);
+	return ret;
+}
+
 static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
 {
 	switch (link->map->map_type) {
-- 
2.27.0

