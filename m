Return-Path: <bpf+bounces-43743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C019B951C
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 17:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4F91F22D66
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BD51CBE93;
	Fri,  1 Nov 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SAJctLQX"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1662AE74;
	Fri,  1 Nov 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477854; cv=none; b=o0j70w5eqirY/RokFq/dllkveEdgwTtGA1LhIWDZBzfMkiYe59x/LGGHZGHoTJ7QSqCwoZy7/FYWvHSgpLWmKoLaZophbcfr/lwBTzDtLHd0HLie6YuqEd3iARJ1ht8g0F6QD/ewDf+jsz4QP9aoPg+m1GT8+0edMNJX09GzJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477854; c=relaxed/simple;
	bh=t2o+uiPJnD4LCMsm8wLxx09k1Hk4Q3MQssh8C1lJ4VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKaEf0M66X51CvGmONBkIlBXNMPaUBMESGt/Ns0S1aMIolGy5svXGLy9y7bxp5hSgzZwrQRj61FtslFpucc4Khy+k4YE3dc9xZh/S1Ce/ok1yyFsUkFBL4UyFm2lUc1CxcNI5MVDAlMy1oyB4YeGEsstEjOERauLLLZBKlk4kAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SAJctLQX; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=ACSsa
	KsRcj8URgMILplUrfvR8FJT8Cc/8815tNBgurU=; b=SAJctLQXsuojXp1/bSjO4
	z2P/W5QerJjmFZQ9WcPDPwTYdqFpPZUornVnp6e9riIeSx/lLv7Y7g6LfhNyoHh4
	qellWi8P27ZjzA0Ep/B4qWHE6hAFH2oqcJLiq3ICUKCLNP6GxcPqYmzTQFltkpl5
	BoAZgMwqp53allaEXIz4Ow=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3H7Th_iRn6adKAA--.9355S3;
	Sat, 02 Nov 2024 00:16:46 +0800 (CST)
From: mrpre <mrpre@163.com>
To: yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mrpre <mrpre@163.com>
Subject: [PATCH v2 1/2] bpf: Introduce cpu affinity for sockmap
Date: Sat,  2 Nov 2024 00:16:23 +0800
Message-ID: <20241101161624.568527-2-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241101161624.568527-1-mrpre@163.com>
References: <20241101161624.568527-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H7Th_iRn6adKAA--.9355S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfJF1rtFyrJFyUXw43JrWxtFb_yoW8Jry5Co
	WSqan7AF4xJr1fJ34vq3s3tFy8ZayDGw4DAa1S9wnxuF1Yk3yUWw43Ww43u3W7Xa18tF48
	CF10y3yrG3Z5CFn5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTR6uWpDUUUU
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwKKp2ck9vdbhAADs+

Why we need cpu affinity:
Mainstream data planes, like Nginx and HAProxy, utilize CPU affinity
by binding user processes to specific CPUs. This avoids interference
between processes and prevents impact from other processes.

Sockmap, as an optimization to accelerate such proxy programs,
currently lacks the ability to specify CPU affinity. The current
implementation of sockmap handling backlog is based on workqueue,
which operates by calling 'schedule_delayed_work()'. It's current
implementation prefers to schedule on the local CPU, i.e., the CPU
that handled the packet under softirq.

For extremely high traffic with large numbers of packets,
'sk_psock_backlog' becomes a large loop.

For multi-threaded programs with only one map, we expect different
sockets to run on different CPUs. It is important to note that this
feature is not a general performance optimization. Instead, it
provides users with the ability to bind to specific CPU, allowing
them to enhance overall operating system utilization based on their
own system environments.

Implementation:
1.When updating the sockmap, support passing a CPU parameter and
save it to the psock.
2.When scheduling psock, determine which CPU to run on using the
psock's CPU information.
3.For thoes sockmap without CPU affinity, keep original logic by using
'schedule_delayed_work()'.

Performance Testing:
'client <-> sockmap proxy <-> server'

Using 'iperf3' tests, with the iperf server bound to CPU5 and the iperf
client bound to CPU6, performance without using CPU affinity is
around 34 Gbits/s, and CPU usage is concentrated on CPU5 and CPU6.
'''
[  5] local 127.0.0.1 port 57144 connected to 127.0.0.1 port 10000
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  3.95 GBytes  33.9 Gbits/sec
[  5]   1.00-2.00   sec  3.95 GBytes  34.0 Gbits/sec
......
'''

With using CPU affinity, the performnce is close to direct connection
(without any proxy).
'''
[  5] local 127.0.0.1 port 56518 connected to 127.0.0.1 port 10000
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  7.76 GBytes  66.6 Gbits/sec
[  5]   1.00-2.00   sec  7.76 GBytes  66.7 Gbits/sec
......
'''

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 include/linux/bpf.h      |  5 +++--
 include/linux/skmsg.h    |  8 ++++++++
 include/uapi/linux/bpf.h |  4 ++++
 kernel/bpf/syscall.c     | 23 +++++++++++++++++------
 net/core/skmsg.c         | 14 +++++++-------
 net/core/sock_map.c      | 13 ++++++-------
 6 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c3ba4d475174..648eaea2bb28 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3080,7 +3080,8 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 
 int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
 int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
-int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
+int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags,
+			     s32 target_cpu);
 int sock_map_bpf_prog_query(const union bpf_attr *attr,
 			    union bpf_attr __user *uattr);
 int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog);
@@ -3172,7 +3173,7 @@ static inline int sock_map_prog_detach(const union bpf_attr *attr,
 }
 
 static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
-					   u64 flags)
+					   u64 flags, s32 target_cpu)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index d9b03e0746e7..919425a92adf 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -117,6 +117,7 @@ struct sk_psock {
 	struct delayed_work		work;
 	struct sock			*sk_pair;
 	struct rcu_work			rwork;
+	s32				target_cpu;
 };
 
 int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
@@ -514,6 +515,13 @@ static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
 	return !!psock->saved_data_ready;
 }
 
+static inline int sk_psock_strp_get_cpu(struct sk_psock *psock)
+{
+	if (psock->target_cpu != -1)
+		return psock->target_cpu;
+	return WORK_CPU_UNBOUND;
+}
+
 #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
 
 #define BPF_F_STRPARSER	(1UL << 1)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f28b6527e815..2019a87b5d4a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1509,6 +1509,10 @@ union bpf_attr {
 			__aligned_u64 next_key;
 		};
 		__u64		flags;
+		union {
+			/* specify the CPU where the sockmap job run on */
+			__aligned_u64 target_cpu;
+		};
 	};
 
 	struct { /* struct used by BPF_MAP_*_BATCH commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8254b2973157..95f719b9c3f3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -239,10 +239,9 @@ static int bpf_obj_pin_uptrs(struct btf_record *rec, void *obj)
 }
 
 static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
-				void *key, void *value, __u64 flags)
+				void *key, void *value, __u64 flags, s32 target_cpu)
 {
 	int err;
-
 	/* Need to create a kthread, thus must support schedule */
 	if (bpf_map_is_offloaded(map)) {
 		return bpf_map_offload_update_elem(map, key, value, flags);
@@ -252,7 +251,7 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 		return map->ops->map_update_elem(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_SOCKHASH ||
 		   map->map_type == BPF_MAP_TYPE_SOCKMAP) {
-		return sock_map_update_elem_sys(map, key, value, flags);
+		return sock_map_update_elem_sys(map, key, value, flags, target_cpu);
 	} else if (IS_FD_PROG_ARRAY(map)) {
 		return bpf_fd_array_map_update_elem(map, map_file, key, value,
 						    flags);
@@ -1680,12 +1679,14 @@ static int map_lookup_elem(union bpf_attr *attr)
 }
 
 
-#define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
+#define BPF_MAP_UPDATE_ELEM_LAST_FIELD target_cpu
 
 static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 {
 	bpfptr_t ukey = make_bpfptr(attr->key, uattr.is_kernel);
 	bpfptr_t uvalue = make_bpfptr(attr->value, uattr.is_kernel);
+	bpfptr_t utarget_cpu = make_bpfptr(attr->target_cpu, uattr.is_kernel);
+	s64 target_cpu = 0;
 	struct bpf_map *map;
 	void *key, *value;
 	u32 value_size;
@@ -1723,7 +1724,17 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto free_key;
 	}
 
-	err = bpf_map_update_value(map, fd_file(f), key, value, attr->flags);
+	if (map->map_type == BPF_MAP_TYPE_SOCKMAP &&
+	    !bpfptr_is_null(utarget_cpu)) {
+		if (copy_from_bpfptr(&target_cpu, utarget_cpu, sizeof(target_cpu)) ||
+		    target_cpu > nr_cpu_ids) {
+			err = -EINVAL;
+			goto err_put;
+		}
+	} else {
+		target_cpu = -1;
+	}
+	err = bpf_map_update_value(map, fd_file(f), key, value, attr->flags, (s32)target_cpu);
 	if (!err)
 		maybe_wait_bpf_programs(map);
 
@@ -1947,7 +1958,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 			break;
 
 		err = bpf_map_update_value(map, map_file, key, value,
-					   attr->batch.elem_flags);
+					   attr->batch.elem_flags, -1);
 
 		if (err)
 			break;
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index b1dcbd3be89e..cc1dc17cd06c 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -530,7 +530,6 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 					struct sk_msg *msg)
 {
 	int num_sge, copied;
-
 	num_sge = skb_to_sgvec(skb, msg->sg.data, off, len);
 	if (num_sge < 0) {
 		/* skb linearize may fail with ENOMEM, but lets simply try again
@@ -679,7 +678,8 @@ static void sk_psock_backlog(struct work_struct *work)
 					 * other work that might be here.
 					 */
 					if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
-						schedule_delayed_work(&psock->work, 1);
+						schedule_delayed_work_on(sk_psock_strp_get_cpu(psock),
+									 &psock->work, 1);
 					goto end;
 				}
 				/* Hard errors break pipe and stop xmit. */
@@ -729,6 +729,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	psock->saved_destroy = prot->destroy;
 	psock->saved_close = prot->close;
 	psock->saved_write_space = sk->sk_write_space;
+	psock->target_cpu = -1;
 
 	INIT_LIST_HEAD(&psock->link);
 	spin_lock_init(&psock->link_lock);
@@ -843,7 +844,6 @@ void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
 	else if (psock->progs.stream_verdict || psock->progs.skb_verdict)
 		sk_psock_stop_verdict(sk, psock);
 	write_unlock_bh(&sk->sk_callback_lock);
-
 	sk_psock_stop(psock);
 
 	INIT_RCU_WORK(&psock->rwork, sk_psock_destroy);
@@ -934,7 +934,7 @@ static int sk_psock_skb_redirect(struct sk_psock *from, struct sk_buff *skb)
 	}
 
 	skb_queue_tail(&psock_other->ingress_skb, skb);
-	schedule_delayed_work(&psock_other->work, 0);
+	schedule_delayed_work_on(sk_psock_strp_get_cpu(psock_other), &psock_other->work, 0);
 	spin_unlock_bh(&psock_other->ingress_lock);
 	return 0;
 }
@@ -980,7 +980,6 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 	struct sock *sk_other;
 	int err = 0;
 	u32 len, off;
-
 	switch (verdict) {
 	case __SK_PASS:
 		err = -EIO;
@@ -1012,7 +1011,8 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 			spin_lock_bh(&psock->ingress_lock);
 			if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 				skb_queue_tail(&psock->ingress_skb, skb);
-				schedule_delayed_work(&psock->work, 0);
+				schedule_delayed_work_on(sk_psock_strp_get_cpu(psock),
+							 &psock->work, 0);
 				err = 0;
 			}
 			spin_unlock_bh(&psock->ingress_lock);
@@ -1044,7 +1044,7 @@ static void sk_psock_write_space(struct sock *sk)
 	psock = sk_psock(sk);
 	if (likely(psock)) {
 		if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
-			schedule_delayed_work(&psock->work, 0);
+			schedule_delayed_work_on(sk_psock_strp_get_cpu(psock), &psock->work, 0);
 		write_space = psock->saved_write_space;
 	}
 	rcu_read_unlock();
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 07d6aa4e39ef..d74601024d6b 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -465,7 +465,7 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next)
 }
 
 static int sock_map_update_common(struct bpf_map *map, u32 idx,
-				  struct sock *sk, u64 flags)
+				  struct sock *sk, u64 flags, s32 target_cpu)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
 	struct sk_psock_link *link;
@@ -489,7 +489,7 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 
 	psock = sk_psock(sk);
 	WARN_ON_ONCE(!psock);
-
+	psock->target_cpu = target_cpu;
 	spin_lock_bh(&stab->lock);
 	osk = stab->sks[idx];
 	if (osk && flags == BPF_NOEXIST) {
@@ -548,13 +548,12 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 				   struct sock *sk, u64 flags);
 
 int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
-			     u64 flags)
+			     u64 flags, s32 target_cpu)
 {
 	struct socket *sock;
 	struct sock *sk;
 	int ret;
 	u64 ufd;
-
 	if (map->value_size == sizeof(u64))
 		ufd = *(u64 *)value;
 	else
@@ -579,7 +578,7 @@ int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
 	if (!sock_map_sk_state_allowed(sk))
 		ret = -EOPNOTSUPP;
 	else if (map->map_type == BPF_MAP_TYPE_SOCKMAP)
-		ret = sock_map_update_common(map, *(u32 *)key, sk, flags);
+		ret = sock_map_update_common(map, *(u32 *)key, sk, flags, target_cpu);
 	else
 		ret = sock_hash_update_common(map, key, sk, flags);
 	sock_map_sk_release(sk);
@@ -605,7 +604,7 @@ static long sock_map_update_elem(struct bpf_map *map, void *key,
 	if (!sock_map_sk_state_allowed(sk))
 		ret = -EOPNOTSUPP;
 	else if (map->map_type == BPF_MAP_TYPE_SOCKMAP)
-		ret = sock_map_update_common(map, *(u32 *)key, sk, flags);
+		ret = sock_map_update_common(map, *(u32 *)key, sk, flags, -1);
 	else
 		ret = sock_hash_update_common(map, key, sk, flags);
 	bh_unlock_sock(sk);
@@ -621,7 +620,7 @@ BPF_CALL_4(bpf_sock_map_update, struct bpf_sock_ops_kern *, sops,
 	if (likely(sock_map_sk_is_suitable(sops->sk) &&
 		   sock_map_op_okay(sops)))
 		return sock_map_update_common(map, *(u32 *)key, sops->sk,
-					      flags);
+					      flags, -1);
 	return -EOPNOTSUPP;
 }
 
-- 
2.43.5


