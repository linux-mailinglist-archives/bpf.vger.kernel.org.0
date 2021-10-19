Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C148343367B
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJSNB2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 09:01:28 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29909 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbhJSNB1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 09:01:27 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HYYbz40RQzbnFn;
        Tue, 19 Oct 2021 20:54:39 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 19 Oct 2021 20:59:12 +0800
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500011.china.huawei.com (7.185.36.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 19 Oct 2021 20:59:11 +0800
From:   Di Zhu <zhudi2@huawei.com>
To:     <davem@davemloft.net>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhudi2@huawei.com>
Subject: [PATCH] bpf: support BPF_PROG_QUERY for progs attached to sockmap
Date:   Tue, 19 Oct 2021 20:58:56 +0800
Message-ID: <20211019125856.2566882-1-zhudi2@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
 include/linux/bpf.h  |  8 +++++
 kernel/bpf/syscall.c |  4 +++
 net/core/sock_map.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1c7fd7c4c6d3..69cf70b077d5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1959,6 +1959,8 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
 int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
 int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
+int sockmap_bpf_prog_query(const union bpf_attr *attr,
+			   union bpf_attr __user *uattr);
 void sock_map_unhash(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
 #else
@@ -2012,6 +2014,12 @@ static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int sockmap_bpf_prog_query(const union bpf_attr *attr,
+					 union bpf_attr __user *uattr)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_BPF_SYSCALL */
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e50c0bfdb7d..3049b9506583 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3275,6 +3275,10 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_FLOW_DISSECTOR:
 	case BPF_SK_LOOKUP:
 		return netns_bpf_prog_query(attr, uattr);
+	case BPF_SK_SKB_STREAM_PARSER:
+	case BPF_SK_SKB_STREAM_VERDICT:
+	case BPF_SK_MSG_VERDICT:
+		return sockmap_bpf_prog_query(attr, uattr);
 	default:
 		return -EINVAL;
 	}
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index e252b8ec2b85..32688a1b78c6 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1451,6 +1451,87 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
 	return 0;
 }
 
+static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog **prog,
+				u32 which)
+{
+	struct sk_psock_progs *progs = sock_map_progs(map);
+
+	if (!progs)
+		return -EOPNOTSUPP;
+
+	switch (which) {
+	case BPF_SK_MSG_VERDICT:
+		*prog = READ_ONCE(progs->msg_parser);
+		break;
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	case BPF_SK_SKB_STREAM_PARSER:
+		*prog = READ_ONCE(progs->skb_parser);
+		break;
+#endif
+	case BPF_SK_SKB_STREAM_VERDICT:
+		*prog = READ_ONCE(progs->skb_verdict);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int sockmap_bpf_prog_query(const union bpf_attr *attr,
+			   union bpf_attr __user *uattr)
+{
+	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	u32 prog_cnt = 0, flags = 0;
+	u32 ufd = attr->target_fd;
+	struct bpf_map *map;
+	struct bpf_prog *prog;
+	struct fd f;
+	int ret;
+
+	if (attr->query.query_flags)
+		return -EINVAL;
+
+	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
+		return -EFAULT;
+
+	f = fdget(ufd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	rcu_read_lock();
+
+	ret = sock_map_prog_lookup(map, &prog, attr->query.attach_type);
+	if (ret)
+		goto end;
+
+	prog_cnt = (!prog) ? 0 : 1;
+	if (copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt))) {
+		ret = -EFAULT;
+		goto end;
+	}
+
+	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
+		goto end;
+
+	prog = bpf_prog_inc_not_zero(prog);
+	if (IS_ERR(prog)) {
+		ret = PTR_ERR(prog);
+		goto end;
+	}
+
+	if (copy_to_user(prog_ids, &prog->aux->id, sizeof(u32)))
+		ret = -EFAULT;
+
+	bpf_prog_put(prog);
+
+end:
+	rcu_read_unlock();
+	fdput(f);
+	return ret;
+}
+
 static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
 {
 	switch (link->map->map_type) {
-- 
2.23.0

