Return-Path: <bpf+bounces-43689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880FD9B895E
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 03:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DECE1F22A3F
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 02:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF5139CEF;
	Fri,  1 Nov 2024 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RMN/0boe"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B259A2B9A9;
	Fri,  1 Nov 2024 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428807; cv=none; b=SoSUmqkWsUonDF4wZqU+ByVQTnnIkxl5FFRMsSskEHFurPLCYENXnI+l4Og0V1B4SM9Ck4mCmo6d2l5iehG8/wCXcmiuAOxJldyMjli+qkogp+xhGDQWyNRSghqjjgs4dVwGJ4tOkLQ4S9VrVOT/jkAeYlNfjItl8RmFpk2B5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428807; c=relaxed/simple;
	bh=Z+ZkIB0RdM/+CPfXmsVZSiThc3L3iacF1dcFI3HhQo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gm7lQ8CTYUzuvPGHeL5N2gHb9Mx2bNDjJEYaI6U8SH00JrbbFt8CxgZYzRfZoGHBhO0PQfg1UFBeQN/geSEK8JbRih4GQ1xxBeEmFsktTkFAoz3q2s4tWkpUtYUZgjLNuOXE4SdbxrB1VVMoHPXUvEmWOuhjOFwdXi9ExuB0T4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RMN/0boe; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=H7+4E
	g8iqwnqiUSNdNxG+5d23N0V4b7WKti1AwEQikQ=; b=RMN/0boe6zwcC6oawUHuu
	9CwUlKyl7e/WmxFrfdewsU/Ymi0UAD30DXPoRIQ8fwY658AyjG6dsfW2YAe12Hld
	FcsZzwVHSUIQJFapW35cfNBuq3V2TZWJKWatY1QTDGXxHuIphWVeT3iMW38pR4RW
	Qj6iG+DGHvHtU2eEf2t91Y=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCXf_dEPyRnhWzQCQ--.1082S2;
	Fri, 01 Nov 2024 10:39:06 +0800 (CST)
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
Subject: [PATCH 1/2] bpf: Introduce cpu affinity for sockmap
Date: Fri,  1 Nov 2024 10:38:31 +0800
Message-ID: <20241101023832.32404-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXf_dEPyRnhWzQCQ--.1082S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfJF1rtFyrJFyUXw43JrWxtFb_yoWkXFWkpF
	Z0ka17CF4UJFW0qws0qaykZr4a9w18Kw1jkFZ3Ka4Syr92gr1FgFWrKF9ayF1Ykr4DCr4x
	ArsFgrWIy3yxZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piX4S7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWx6Kp2ckPncXwgAAs3

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
 include/linux/bpf.h      |  3 ++-
 include/linux/skmsg.h    |  8 ++++++++
 include/uapi/linux/bpf.h |  4 ++++
 kernel/bpf/syscall.c     | 23 +++++++++++++++++------
 net/core/skmsg.c         | 11 +++++++----
 net/core/sock_map.c      | 12 +++++++-----
 6 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c3ba4d475174..a56028c389e7 100644
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
index b1dcbd3be89e..d3b6f2468dab 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -679,7 +679,8 @@ static void sk_psock_backlog(struct work_struct *work)
 					 * other work that might be here.
 					 */
 					if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
-						schedule_delayed_work(&psock->work, 1);
+						schedule_delayed_work_on(sk_psock_strp_get_cpu(psock),
+									 &psock->work, 1);
 					goto end;
 				}
 				/* Hard errors break pipe and stop xmit. */
@@ -729,6 +730,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	psock->saved_destroy = prot->destroy;
 	psock->saved_close = prot->close;
 	psock->saved_write_space = sk->sk_write_space;
+	psock->target_cpu = -1;
 
 	INIT_LIST_HEAD(&psock->link);
 	spin_lock_init(&psock->link_lock);
@@ -934,7 +936,7 @@ static int sk_psock_skb_redirect(struct sk_psock *from, struct sk_buff *skb)
 	}
 
 	skb_queue_tail(&psock_other->ingress_skb, skb);
-	schedule_delayed_work(&psock_other->work, 0);
+	schedule_delayed_work_on(sk_psock_strp_get_cpu(psock_other), &psock_other->work, 0);
 	spin_unlock_bh(&psock_other->ingress_lock);
 	return 0;
 }
@@ -1012,7 +1014,8 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 			spin_lock_bh(&psock->ingress_lock);
 			if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 				skb_queue_tail(&psock->ingress_skb, skb);
-				schedule_delayed_work(&psock->work, 0);
+				schedule_delayed_work_on(sk_psock_strp_get_cpu(psock),
+							 &psock->work, 0);
 				err = 0;
 			}
 			spin_unlock_bh(&psock->ingress_lock);
@@ -1044,7 +1047,7 @@ static void sk_psock_write_space(struct sock *sk)
 	psock = sk_psock(sk);
 	if (likely(psock)) {
 		if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
-			schedule_delayed_work(&psock->work, 0);
+			schedule_delayed_work_on(sk_psock_strp_get_cpu(psock), &psock->work, 0);
 		write_space = psock->saved_write_space;
 	}
 	rcu_read_unlock();
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 07d6aa4e39ef..36e9787c60de 100644
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
@@ -490,6 +490,8 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 	psock = sk_psock(sk);
 	WARN_ON_ONCE(!psock);
 
+	psock->target_cpu = target_cpu;
+
 	spin_lock_bh(&stab->lock);
 	osk = stab->sks[idx];
 	if (osk && flags == BPF_NOEXIST) {
@@ -548,7 +550,7 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 				   struct sock *sk, u64 flags);
 
 int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
-			     u64 flags)
+			     u64 flags, s32 target_cpu)
 {
 	struct socket *sock;
 	struct sock *sk;
@@ -579,7 +581,7 @@ int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
 	if (!sock_map_sk_state_allowed(sk))
 		ret = -EOPNOTSUPP;
 	else if (map->map_type == BPF_MAP_TYPE_SOCKMAP)
-		ret = sock_map_update_common(map, *(u32 *)key, sk, flags);
+		ret = sock_map_update_common(map, *(u32 *)key, sk, flags, target_cpu);
 	else
 		ret = sock_hash_update_common(map, key, sk, flags);
 	sock_map_sk_release(sk);
@@ -605,7 +607,7 @@ static long sock_map_update_elem(struct bpf_map *map, void *key,
 	if (!sock_map_sk_state_allowed(sk))
 		ret = -EOPNOTSUPP;
 	else if (map->map_type == BPF_MAP_TYPE_SOCKMAP)
-		ret = sock_map_update_common(map, *(u32 *)key, sk, flags);
+		ret = sock_map_update_common(map, *(u32 *)key, sk, flags, -1);
 	else
 		ret = sock_hash_update_common(map, key, sk, flags);
 	bh_unlock_sock(sk);
@@ -621,7 +623,7 @@ BPF_CALL_4(bpf_sock_map_update, struct bpf_sock_ops_kern *, sops,
 	if (likely(sock_map_sk_is_suitable(sops->sk) &&
 		   sock_map_op_okay(sops)))
 		return sock_map_update_common(map, *(u32 *)key, sops->sk,
-					      flags);
+					      flags, -1);
 	return -EOPNOTSUPP;
 }
 
-- 
2.43.5


