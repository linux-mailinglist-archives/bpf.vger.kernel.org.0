Return-Path: <bpf+bounces-79141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC13D28184
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E44B63087996
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B1C308F1D;
	Thu, 15 Jan 2026 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev/LKCbD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDB3081B8
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505283; cv=none; b=IIJ9D8WVndjROETDqCOq+MebFJGcKCLInO3Jp+T9RUCnErSjlChdMqKG5A/577Ay234bAzGN29CuJ4aI5KWlVJI2N1oF5I8S8/eIvB9fEOjIc41DJKtS7RnLr/xkkb5uGnmn7jCigASHJCX0HqJIsDjttDARx+ipRYmSHKVwl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505283; c=relaxed/simple;
	bh=8OCjzDtcvh5+Gh5QL0puYTtvA7VNAYoQwO3yTxG1qCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGF8w1dRfjUUWhjDNJaBNbzE9RWtIxzzg3S1QUG2vxLLK5Gk7MZeOr9shr5EB5GfiH9zK6/Bj2ZUNu02m11DSqkT0JWhDstgVugC/11gm31CLYmzKbZwoZiFa5fqpc2qU5v7u6fBwYyYFn42F0clzcUnazE6oLukixT542Rw0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev/LKCbD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a58f2e514eso8530875ad.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505275; x=1769110075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHXcC4xevnIGvbdh5i5FQSyBHud4Wfcg8rDe1fQK9QM=;
        b=Ev/LKCbDS6Gt2JpqJ7iMxI1vCIqT947Qg/8JZy45Qz0+BhmfnuOPzysJRbRg8Zf6A6
         4SHu3AH9D4E+pDKI1Ah0T36IHNTad5YebdYnxTd815WXXqD5yvcJTPV59MKX54Gn/lm5
         Zfm1cS57qr7tbLU/280PE6X8etCm56geKgEV5Y+EwazaoZDMoNr1xxuCWdp7rNOmDN3L
         44mbVAQzDVLlk1OD7S/HTVW7ls2lzk0LM6AZwCkyTkkQ5LDFjSJjRWwUc02L8e/fu4z3
         pgCD6bgOxKP1OuhifOyWHBLo4eLLlfx7ki2rT07/XBSxKeDOR4NM9D1R46ISI88C/J1m
         VBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505275; x=1769110075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tHXcC4xevnIGvbdh5i5FQSyBHud4Wfcg8rDe1fQK9QM=;
        b=sbSgqZLh+zhjGw+MtDOB9FMZ+uOykca3eLgf1/tQx5Xo6KFew3XufeK5bzYaJPX1V1
         gxQ6BTDFTQ20Ts95oU//gvjCDQiLU8jF3HXToGFrqKEIo4jW6eAJWZBjfVdh6FT5laI1
         xoYeyguzTIEjUtq3fXCSaF0qBf875wZHP/N7MrIFIC0yYfrsijk87wRQ4e/lY5ikXCxF
         v7CORPGXFe0JD6AudWK0e31hsKAM7ELY4TF2ha3xUDvPTiLpaFGphx+yp1DvxzW6MB/S
         y2c2yaLo2HBAmO2JfvEZG9Dhvos579Z+/ZoRstela61iMplkhiExeBsZEo2JQY78agkg
         z+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7e6gg/vYvYfrl5uoLeDwXnlVp+zecsna/8OEER3uiR6cICK1aIuiywuQ2U8pdNS4ZRtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQmzsK9KNwpMzSCJUsYJPfzlD/SJwy+Z5erpA30rsrgSCWGxlK
	oPYoRDjcz/HlIvh5az3ufO+CggF2DJSkJ8EfY+FJtB1p/kzlLcH7rAvY
X-Gm-Gg: AY/fxX7eLXpMhCNas8W50kZmaHWL0xIlyZ9loKo9GXDnfefoXXy7w+tTbxWGxMSHj+O
	Xo+SrxUyVk5yhpL2BaiKr/0+OIowGbF5/GQj2Z0o4Ey/qtD39ybYiN+A9EfSKVjZXfm8860bMmU
	kK3JvV45VsDTd3IDaaf72vO0/4/FZn5732+3vHeCvHWSg8umRHJElNZsjnIG0e3A3FK4L+t46l1
	g+TS7yPE+BqOPP+EdzMolNQE7+o2NjjfxTIPbk/IzA+m/qcnBNraciA5VBFlfEsF9F9OYOA6YTh
	NUQWtvVtrpyva0YlHlaR0Z79paZsHz0yWJkv0wb129P9ZfgDy78KA7CjSqBZxhY6Fal/1ClGVJB
	Rhl9ikMrEqa9Gl4sAhwC7XgF00g1sKqF7dx4kKX4aQxzzyTAgBzimxhkh8tTUSalP35Yb/JhVl3
	TnbMHBapD4IjSXNMcg
X-Received: by 2002:a17:903:2343:b0:2a0:f83d:c321 with SMTP id d9443c01a7336-2a718896b3fmr2708435ad.23.1768505275370;
        Thu, 15 Jan 2026 11:27:55 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:3874:1cf7:603f:ecef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce692sm876115ad.36.2026.01.15.11.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 11:27:54 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	bpf@vger.kernel.org,
	Amery Hung <amery.hung@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v6 4/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Thu, 15 Jan 2026 11:27:37 -0800
Message-Id: <20260115192737.743857-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115192737.743857-1-xiyou.wangcong@gmail.com>
References: <20260115192737.743857-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

The TCP_BPF ingress redirection path currently lacks the message corking
mechanism found in standard TCP. This causes the sender to wake up the
receiver for every message, even when messages are small, resulting in
reduced throughput compared to regular TCP in certain scenarios.

This change introduces a kernel worker-based intermediate layer to provide
automatic message corking for TCP_BPF. While this adds a slight latency
overhead, it significantly improves overall throughput by reducing
unnecessary wake-ups and reducing the sock lock contention.

Reviewed-by: Amery Hung <amery.hung@bytedance.com>
Co-developed-by: Cong Wang <cong.wang@bytedance.com>
Tested-by: Hemanth Malla <hemanthmalla@gmail.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 include/linux/skmsg.h |  18 ++++
 net/core/skmsg.c      | 142 +++++++++++++++++++++++++++++-
 net/ipv4/tcp_bpf.c    | 198 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 350 insertions(+), 8 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 84657327b0ea..ee7166812197 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -15,6 +15,8 @@
 
 #define MAX_MSG_FRAGS			MAX_SKB_FRAGS
 #define NR_MSG_FRAG_IDS			(MAX_MSG_FRAGS + 1)
+/* GSO size for TCP BPF backlog processing */
+#define TCP_BPF_GSO_SIZE		65536
 
 enum __sk_action {
 	__SK_DROP = 0,
@@ -87,6 +89,7 @@ struct sk_psock {
 	u32				cork_bytes;
 	u8				eval;
 	bool				redir_ingress; /* undefined if sk_redir is null */
+	bool				backlog_work_delayed;
 	refcount_t			refcnt;
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
@@ -98,6 +101,9 @@ struct sk_psock {
 	struct sk_buff_head		ingress_skb;
 	struct list_head		ingress_msg;
 	spinlock_t			ingress_lock;
+	spinlock_t			backlog_msg_lock;
+	struct list_head		backlog_msg;
+	u32				backlog_since_notify;
 	unsigned long			state;
 	struct list_head		link;
 	spinlock_t			link_lock;
@@ -117,11 +123,13 @@ struct sk_psock {
 	struct mutex			work_mutex;
 	struct sk_psock_work_state	work_state;
 	struct delayed_work		work;
+	struct delayed_work		backlog_work;
 	struct sock			*sk_pair;
 	struct rcu_work			rwork;
 };
 
 struct sk_msg *sk_msg_alloc(gfp_t gfp);
+bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce);
 int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
 		  int elem_first_coalesce);
 int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
@@ -396,9 +404,19 @@ static inline void sk_psock_report_error(struct sk_psock *psock, int err)
 	sk_error_report(sk);
 }
 
+void sk_psock_backlog_msg(struct sk_psock *psock);
 struct sk_psock *sk_psock_init(struct sock *sk, int node);
 void sk_psock_stop(struct sk_psock *psock);
 
+static inline void sk_psock_run_backlog_work(struct sk_psock *psock,
+					     bool delayed)
+{
+	if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+		return;
+	WRITE_ONCE(psock->backlog_work_delayed, delayed);
+	schedule_delayed_work(&psock->backlog_work, delayed ? 1 : 0);
+}
+
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock);
 void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 45ff311ccf49..b9954cd2b8cc 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -12,7 +12,7 @@
 
 struct kmem_cache *sk_msg_cachep;
 
-static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
+bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 {
 	if (msg->sg.end > msg->sg.start &&
 	    elem_first_coalesce < msg->sg.end)
@@ -728,6 +728,118 @@ static void sk_psock_backlog(struct work_struct *work)
 	sk_psock_put(psock->sk, psock);
 }
 
+static bool backlog_notify(struct sk_psock *psock, bool m_sched_failed,
+			   bool ingress_empty)
+{
+	/* Notify if:
+	 * 1. We have corked enough bytes
+	 * 2. We have already delayed notification
+	 * 3. Memory allocation failed
+	 * 4. Ingress queue was empty and we're about to add data
+	 */
+	return psock->backlog_since_notify >= TCP_BPF_GSO_SIZE ||
+	       READ_ONCE(psock->backlog_work_delayed) ||
+	       m_sched_failed ||
+	       ingress_empty;
+}
+
+static bool backlog_xfer_to_local(struct sk_psock *psock, struct sock *sk_from,
+				  struct list_head *local_head, u32 *tot_size)
+{
+	struct sock *sk = psock->sk;
+	struct sk_msg *msg, *tmp;
+	u32 size = 0;
+
+	list_for_each_entry_safe(msg, tmp, &psock->backlog_msg, list) {
+		if (msg->sk != sk_from)
+			break;
+
+		if (!__sk_rmem_schedule(sk, msg->sg.size, false))
+			return true;
+
+		list_move_tail(&msg->list, local_head);
+		sk_wmem_queued_add(msg->sk, -msg->sg.size);
+		sock_put(msg->sk);
+		msg->sk = NULL;
+		psock->backlog_since_notify += msg->sg.size;
+		size += msg->sg.size;
+	}
+
+	*tot_size = size;
+	return false;
+}
+
+/* This function handles the transfer of backlogged messages from the sender
+ * backlog queue to the ingress queue of the peer socket. Notification of data
+ * availability will be sent under some conditions.
+ */
+void sk_psock_backlog_msg(struct sk_psock *psock)
+{
+	bool rmem_schedule_failed = false;
+	struct sock *sk_from = NULL;
+	struct sock *sk = psock->sk;
+	LIST_HEAD(local_head);
+	struct sk_msg *msg;
+	bool should_notify;
+	u32 tot_size = 0;
+
+	if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+		return;
+
+	lock_sock(sk);
+	spin_lock(&psock->backlog_msg_lock);
+
+	msg = list_first_entry_or_null(&psock->backlog_msg,
+				       struct sk_msg, list);
+	if (!msg) {
+		should_notify = !list_empty(&psock->ingress_msg);
+		spin_unlock(&psock->backlog_msg_lock);
+		goto notify;
+	}
+
+	sk_from = msg->sk;
+	sock_hold(sk_from);
+
+	rmem_schedule_failed = backlog_xfer_to_local(psock, sk_from,
+						     &local_head, &tot_size);
+	should_notify = backlog_notify(psock, rmem_schedule_failed,
+				       list_empty(&psock->ingress_msg));
+	spin_unlock(&psock->backlog_msg_lock);
+
+	spin_lock_bh(&psock->ingress_lock);
+	list_splice_tail_init(&local_head, &psock->ingress_msg);
+	spin_unlock_bh(&psock->ingress_lock);
+
+	atomic_add(tot_size, &sk->sk_rmem_alloc);
+	sk_mem_charge(sk, tot_size);
+
+notify:
+	if (should_notify) {
+		psock->backlog_since_notify = 0;
+		sk_psock_data_ready(sk, psock);
+		if (!list_empty(&psock->backlog_msg))
+			sk_psock_run_backlog_work(psock, rmem_schedule_failed);
+	} else {
+		sk_psock_run_backlog_work(psock, true);
+	}
+	release_sock(sk);
+
+	if (sk_from) {
+		bool slow = lock_sock_fast(sk_from);
+
+		sk_mem_uncharge(sk_from, tot_size);
+		unlock_sock_fast(sk_from, slow);
+		sock_put(sk_from);
+	}
+}
+
+static void sk_psock_backlog_msg_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+
+	sk_psock_backlog_msg(container_of(dwork, struct sk_psock, backlog_work));
+}
+
 struct sk_psock *sk_psock_init(struct sock *sk, int node)
 {
 	struct sk_psock *psock;
@@ -765,8 +877,11 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 
 	INIT_DELAYED_WORK(&psock->work, sk_psock_backlog);
 	mutex_init(&psock->work_mutex);
+	INIT_DELAYED_WORK(&psock->backlog_work, sk_psock_backlog_msg_work);
 	INIT_LIST_HEAD(&psock->ingress_msg);
 	spin_lock_init(&psock->ingress_lock);
+	INIT_LIST_HEAD(&psock->backlog_msg);
+	spin_lock_init(&psock->backlog_msg_lock);
 	skb_queue_head_init(&psock->ingress_skb);
 
 	sk_psock_set_state(psock, SK_PSOCK_TX_ENABLED);
@@ -820,6 +935,29 @@ static void __sk_psock_zap_ingress(struct sk_psock *psock)
 	__sk_psock_purge_ingress_msg(psock);
 }
 
+static void __sk_psock_purge_backlog_msg(struct sk_psock *psock)
+{
+	struct sk_msg *msg, *tmp;
+	LIST_HEAD(tmp_list);
+
+	spin_lock(&psock->backlog_msg_lock);
+	list_splice_init(&psock->backlog_msg, &tmp_list);
+	spin_unlock(&psock->backlog_msg_lock);
+
+	list_for_each_entry_safe(msg, tmp, &tmp_list, list) {
+		struct sock *sk_from = msg->sk;
+		bool slow;
+
+		list_del(&msg->list);
+		slow = lock_sock_fast(sk_from);
+		sk_wmem_queued_add(sk_from, -msg->sg.size);
+		sock_put(sk_from);
+		sk_msg_free(sk_from, msg);
+		unlock_sock_fast(sk_from, slow);
+		kfree_sk_msg(msg);
+	}
+}
+
 static void sk_psock_link_destroy(struct sk_psock *psock)
 {
 	struct sk_psock_link *link, *tmp;
@@ -849,7 +987,9 @@ static void sk_psock_destroy(struct work_struct *work)
 	sk_psock_done_strp(psock);
 
 	cancel_delayed_work_sync(&psock->work);
+	cancel_delayed_work_sync(&psock->backlog_work);
 	__sk_psock_zap_ingress(psock);
+	__sk_psock_purge_backlog_msg(psock);
 	mutex_destroy(&psock->work_mutex);
 
 	psock_progs_drop(&psock->progs);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index e4dd5d098a31..426cf8c9661e 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -381,6 +381,184 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	return ret;
 }
 
+static int tcp_bpf_coalesce_msg(struct sk_msg *last, struct sk_msg *msg,
+				u32 *apply_bytes_ptr, u32 *tot_size)
+{
+	struct scatterlist *sge_from, *sge_to;
+	u32 apply_bytes = *apply_bytes_ptr;
+	bool apply = apply_bytes;
+	int i = msg->sg.start;
+	u32 size;
+
+	while (i != msg->sg.end) {
+		int last_sge_idx = last->sg.end;
+
+		if (sk_msg_full(last))
+			break;
+
+		sge_from = sk_msg_elem(msg, i);
+		sk_msg_iter_var_prev(last_sge_idx);
+		sge_to = &last->sg.data[last_sge_idx];
+
+		size = (apply && apply_bytes < sge_from->length) ?
+			apply_bytes : sge_from->length;
+		if (sk_msg_try_coalesce_ok(last, last_sge_idx) &&
+		    sg_page(sge_to) == sg_page(sge_from) &&
+		    sge_to->offset + sge_to->length == sge_from->offset) {
+			sge_to->length += size;
+		} else {
+			sge_to = &last->sg.data[last->sg.end];
+			sg_unmark_end(sge_to);
+			sg_set_page(sge_to, sg_page(sge_from), size,
+				    sge_from->offset);
+			get_page(sg_page(sge_to));
+			sk_msg_iter_next(last, end);
+		}
+
+		sge_from->length -= size;
+		sge_from->offset += size;
+
+		if (sge_from->length == 0) {
+			put_page(sg_page(sge_to));
+			sk_msg_iter_var_next(i);
+		}
+
+		msg->sg.size -= size;
+		last->sg.size += size;
+		*tot_size += size;
+
+		if (apply) {
+			apply_bytes -= size;
+			if (!apply_bytes)
+				break;
+		}
+	}
+
+	if (apply)
+		*apply_bytes_ptr = apply_bytes;
+
+	msg->sg.start = i;
+	return i;
+}
+
+static void tcp_bpf_xfer_msg(struct sk_msg *dst, struct sk_msg *msg,
+			     u32 *apply_bytes_ptr, u32 *tot_size)
+{
+	u32 apply_bytes = *apply_bytes_ptr;
+	bool apply = apply_bytes;
+	struct scatterlist *sge;
+	int i = msg->sg.start;
+	u32 size;
+
+	do {
+		sge = sk_msg_elem(msg, i);
+		size = (apply && apply_bytes < sge->length) ?
+			apply_bytes : sge->length;
+
+		sk_msg_xfer(dst, msg, i, size);
+		*tot_size += size;
+		if (sge->length)
+			get_page(sk_msg_page(dst, i));
+		sk_msg_iter_var_next(i);
+		dst->sg.end = i;
+		if (apply) {
+			apply_bytes -= size;
+			if (!apply_bytes) {
+				if (sge->length)
+					sk_msg_iter_var_prev(i);
+				break;
+			}
+		}
+	} while (i != msg->sg.end);
+
+	if (apply)
+		*apply_bytes_ptr = apply_bytes;
+	msg->sg.start = i;
+}
+
+static int tcp_bpf_ingress_backlog(struct sock *sk, struct sock *sk_redir,
+				   struct sk_msg *msg, u32 apply_bytes)
+{
+	bool ingress_msg_empty = false;
+	bool apply = apply_bytes;
+	struct sk_psock *psock;
+	struct sk_msg *tmp;
+	u32 tot_size = 0;
+	int ret = 0;
+	u8 nonagle;
+
+	psock = sk_psock_get(sk_redir);
+	if (unlikely(!psock))
+		return -EPIPE;
+
+	spin_lock(&psock->backlog_msg_lock);
+	/* If possible, coalesce the curr sk_msg to the last sk_msg from the
+	 * psock->backlog_msg.
+	 */
+	if (!list_empty(&psock->backlog_msg)) {
+		struct sk_msg *last;
+
+		last = list_last_entry(&psock->backlog_msg, struct sk_msg, list);
+		if (last->sk == sk) {
+			int i = tcp_bpf_coalesce_msg(last, msg, &apply_bytes,
+						     &tot_size);
+
+			if (i == msg->sg.end || (apply && !apply_bytes))
+				goto out_unlock;
+		}
+	}
+
+	/* Otherwise, allocate a new sk_msg and transfer the data from the
+	 * passed in msg to it.
+	 */
+	tmp = sk_msg_alloc(GFP_ATOMIC);
+	if (!tmp) {
+		ret = -ENOMEM;
+		spin_unlock(&psock->backlog_msg_lock);
+		sk_wmem_queued_add(sk, tot_size);
+		goto error;
+	}
+
+	tmp->sk = sk;
+	sock_hold(tmp->sk);
+	tmp->sg.start = msg->sg.start;
+	tcp_bpf_xfer_msg(tmp, msg, &apply_bytes, &tot_size);
+	list_add_tail(&tmp->list, &psock->backlog_msg);
+
+out_unlock:
+	spin_unlock(&psock->backlog_msg_lock);
+
+	ingress_msg_empty = list_empty_careful(&psock->ingress_msg);
+	sk_wmem_queued_add(sk, tot_size);
+
+	/* At this point, the data has been handled well. If one of the
+	 * following conditions is met, we can notify the peer socket in
+	 * the context of this system call immediately.
+	 * 1. If the write buffer has been used up;
+	 * 2. Or, the message size is larger than TCP_BPF_GSO_SIZE;
+	 * 3. Or, the ingress queue was empty;
+	 * 4. Or, the tcp socket is set to no_delay.
+	 * Otherwise, kick off the backlog work so that we can have some
+	 * time to wait for any incoming messages before sending a
+	 * notification to the peer socket.
+	 */
+	nonagle = tcp_sk(sk)->nonagle;
+	if (!sk_stream_memory_free(sk) ||
+	    tot_size >= TCP_BPF_GSO_SIZE || ingress_msg_empty ||
+	    (!(nonagle & TCP_NAGLE_CORK) && (nonagle & TCP_NAGLE_OFF))) {
+		release_sock(sk);
+		WRITE_ONCE(psock->backlog_work_delayed, false);
+		sk_psock_backlog_msg(psock);
+		lock_sock(sk);
+	} else {
+		sk_psock_run_backlog_work(psock, false);
+	}
+
+error:
+	sk_psock_put(sk_redir, psock);
+	return ret;
+}
+
 static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 				struct sk_msg *msg, int *copied, int flags)
 {
@@ -445,18 +623,24 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			cork = true;
 			psock->cork = NULL;
 		}
-		release_sock(sk);
 
-		origsize = msg->sg.size;
-		ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
-					    msg, tosend, flags);
-		sent = origsize - msg->sg.size;
+		if (redir_ingress) {
+			ret = tcp_bpf_ingress_backlog(sk, sk_redir, msg, tosend);
+		} else {
+			release_sock(sk);
+
+			origsize = msg->sg.size;
+			ret = tcp_bpf_sendmsg_redir(sk_redir, false,
+						    msg, tosend, flags);
+			sent = origsize - msg->sg.size;
+
+			lock_sock(sk);
+			sk_mem_uncharge(sk, sent);
+		}
 
 		if (eval == __SK_REDIRECT)
 			sock_put(sk_redir);
 
-		lock_sock(sk);
-		sk_mem_uncharge(sk, sent);
 		if (unlikely(ret < 0)) {
 			int free = sk_msg_free(sk, msg);
 
-- 
2.34.1


