Return-Path: <bpf+bounces-61927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCB8AEEBD9
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 03:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013313B72BD
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 01:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2701885B8;
	Tue,  1 Jul 2025 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYdN+8yv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A091AF0A4;
	Tue,  1 Jul 2025 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332352; cv=none; b=DN/LYkC1/x0GEejE0HFf89phHOdUk0A2NuK2nYjpaSwNGjtLi0h+YNwtWc+31crYliOxAkaOlzoiGtV5zHrLZojI+JNkKuAXQ6PsPIKq6NIa38kbG3K4I1On8iMVE6SDxUTvajWBbgzA7lzj+NU7SmWPHxYq15uuUOwN7cugsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332352; c=relaxed/simple;
	bh=K7G/YLKKQPSoC8p6mBHY8ugVB2mlUI73Gxx4Zfj24OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJ/KZN1RMlm6BF57h8qoH86CI9FwLfBlv4lHDcBUW4lfdAUAzTqD3MBq9bmGBbO6k4M47wYyUuYQqn0CwxpPQAtf4YEzvmRNAvMH335VkP8fWSdX1gvqXf6k1dKD8wJ80qKs65ze3/CS5NjdmxwzWAD4kL7mzoh3DKEQCKKi9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYdN+8yv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-236377f00easo31796135ad.1;
        Mon, 30 Jun 2025 18:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751332350; x=1751937150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujHYiNy9soaUs2ttqbgQcQCn7ciQ96lmVkPhRG5jDYw=;
        b=hYdN+8yv7GQWvSOeAhg5cj4xYnypTVYG8dj2FNQrs9gydOuhKBOfSN9xhRqBu+5yt4
         E872AgVF2qQIONHgw6xJMJN3W50jrj3R8Cay6KfaIbZAkeLDgu5yAVXT2Uo2NejV0mgk
         OaNDlu7JVmKc8B9K1HyXi/2OmuaNkPWjA0T0IPxitNbBzhvUboiS33OM3pXfPMkXz1gQ
         6qrnya0ekP/JnXGuqbNAVxjbYHRvXUI2FIhNGjLnOzukfVqZY4C/ipbupK8A2I4rSUfI
         qPC1WRl/Tti2SRqENtWDeIystchzWNyPCglMOrTe8U9snnnuLXYoBss8TrUhX2BtyUxy
         wO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751332350; x=1751937150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujHYiNy9soaUs2ttqbgQcQCn7ciQ96lmVkPhRG5jDYw=;
        b=wf0TZcd4gnvHB8YPy360TvTFAfTti/8vvv6XP8tme4iHEZNS4zhMu/nNtNQecU6nXF
         FFGnP/UDjyOfRDfStoh2v3yQU95g3GWZDeBv/BHZZmJ+g9CVjHMdDtL8tohuiFlIy7Du
         7flzq6Z0O19YVSyWIA0RRvq+XnVrVPYyVdl5wsdHm2D0IIOaY0GcI+3uprTdw8/e7zS/
         OQxPcZFj2LVrGYG9dWGSVJqq2IQ2Wg0Dv8nPcy/tk5VbgmulYyRuYQc7pRaYjjvOk4eN
         ejuO4uAJyqR3Dek3AAx1pkdpy237BqtxBedbJskiP0/1ETi6EU89FaQGoDhaTNswVk6E
         3+sg==
X-Gm-Message-State: AOJu0YxCFL7bKDQTChTWD4olzK2chX1BRGNw5bFLuCLdM9IPV8tMGAyj
	cbXx96sosR7Rci8aNPXdznAtLJvKVVDkbsX+SzhRATJiOTbDXYyWnuaFTZDl1w==
X-Gm-Gg: ASbGnctI8Y9s5608ltr2byS/fnP1US7nIe9nV1ti8cNl9Gjvpbuou53dKA73ln2QnW+
	wBKVrBxs2j/YAT40Hic3s4WYfLkE+8QFVTXvmyZfo5XNluv9WEvHi1jCBtFaAPDejE0/bC1GsLy
	YrDPCPv3ljOOcJKVjhYri20VRkNZkRh7VRId+m5FmVD43V0PnTT/xvDiqsohSVSHzVuWlbH1h/e
	ND5ax1hVFqBQ1JNi4nm6zM26n2q2FyZmPJwZTfoFXCBbdg5KjEPkFhw0bm8qRoMGEh4veuRN6Vv
	sUYfRlnOK+k/9RPj26Y5po1XRdCvPo+zs+3ABbD/M3tKr5d5Ft28Dq+CgM4IDAI/OzALOdpw
X-Google-Smtp-Source: AGHT+IE9EQDaNKF/TshxmRLVHl48sRBkqZ/sEnN3CM/8kE2NXdPOb8NpWA4RG6TapCpC1DAfvV4OWw==
X-Received: by 2002:a17:903:2a8d:b0:235:ef67:b595 with SMTP id d9443c01a7336-23ac4633c62mr258666725ad.35.1751332349625;
        Mon, 30 Jun 2025 18:12:29 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bfbesm100007455ad.109.2025.06.30.18.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:12:29 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	zhoufeng.zf@bytedance.com,
	Amery Hung <amery.hung@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v4 4/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Mon, 30 Jun 2025 18:12:01 -0700
Message-Id: <20250701011201.235392-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
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
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 include/linux/skmsg.h |  19 ++++
 net/core/skmsg.c      | 139 ++++++++++++++++++++++++++++-
 net/ipv4/tcp_bpf.c    | 197 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 347 insertions(+), 8 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 7620f170c4b1..2531428168ad 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -15,6 +15,8 @@
 
 #define MAX_MSG_FRAGS			MAX_SKB_FRAGS
 #define NR_MSG_FRAG_IDS			(MAX_MSG_FRAGS + 1)
+/* GSO size for TCP BPF backlog processing */
+#define TCP_BPF_GSO_SIZE		65536
 
 enum __sk_action {
 	__SK_DROP = 0,
@@ -85,8 +87,10 @@ struct sk_psock {
 	struct sock			*sk_redir;
 	u32				apply_bytes;
 	u32				cork_bytes;
+	u32				backlog_since_notify;
 	u8				eval;
 	u8 				redir_ingress : 1; /* undefined if sk_redir is null */
+	u8				backlog_work_delayed : 1;
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
@@ -97,6 +101,9 @@ struct sk_psock {
 	struct sk_buff_head		ingress_skb;
 	struct list_head		ingress_msg;
 	spinlock_t			ingress_lock;
+	struct list_head		backlog_msg;
+	/* spin_lock for backlog_msg and backlog_since_notify */
+	spinlock_t			backlog_msg_lock;
 	unsigned long			state;
 	struct list_head		link;
 	spinlock_t			link_lock;
@@ -117,11 +124,13 @@ struct sk_psock {
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
@@ -396,9 +405,19 @@ static inline void sk_psock_report_error(struct sk_psock *psock, int err)
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
+	psock->backlog_work_delayed = delayed;
+	schedule_delayed_work(&psock->backlog_work, delayed ? 1 : 0);
+}
+
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock);
 void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 5aafa5817394..29ac83fc05d8 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -12,7 +12,7 @@
 
 struct kmem_cache *sk_msg_cachep;
 
-static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
+bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 {
 	if (msg->sg.end > msg->sg.start &&
 	    elem_first_coalesce < msg->sg.end)
@@ -721,6 +721,118 @@ static void sk_psock_backlog(struct work_struct *work)
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
+	       psock->backlog_work_delayed ||
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
@@ -758,8 +870,11 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 
 	INIT_DELAYED_WORK(&psock->work, sk_psock_backlog);
 	mutex_init(&psock->work_mutex);
+	INIT_DELAYED_WORK(&psock->backlog_work, sk_psock_backlog_msg_work);
 	INIT_LIST_HEAD(&psock->ingress_msg);
 	spin_lock_init(&psock->ingress_lock);
+	INIT_LIST_HEAD(&psock->backlog_msg);
+	spin_lock_init(&psock->backlog_msg_lock);
 	skb_queue_head_init(&psock->ingress_skb);
 
 	sk_psock_set_state(psock, SK_PSOCK_TX_ENABLED);
@@ -813,6 +928,26 @@ static void __sk_psock_zap_ingress(struct sk_psock *psock)
 	__sk_psock_purge_ingress_msg(psock);
 }
 
+static void __sk_psock_purge_backlog_msg(struct sk_psock *psock)
+{
+	struct sk_msg *msg, *tmp;
+
+	spin_lock(&psock->backlog_msg_lock);
+	list_for_each_entry_safe(msg, tmp, &psock->backlog_msg, list) {
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
+	spin_unlock(&psock->backlog_msg_lock);
+}
+
 static void sk_psock_link_destroy(struct sk_psock *psock)
 {
 	struct sk_psock_link *link, *tmp;
@@ -842,7 +977,9 @@ static void sk_psock_destroy(struct work_struct *work)
 	sk_psock_done_strp(psock);
 
 	cancel_delayed_work_sync(&psock->work);
+	cancel_delayed_work_sync(&psock->backlog_work);
 	__sk_psock_zap_ingress(psock);
+	__sk_psock_purge_backlog_msg(psock);
 	mutex_destroy(&psock->work_mutex);
 
 	psock_progs_drop(&psock->progs);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index f0ef41c951e2..6f7359157205 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -381,6 +381,183 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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
+		goto error;
+	}
+
+	tmp->sk = sk;
+	sock_hold(tmp->sk);
+	tmp->sg.start = msg->sg.start;
+	tcp_bpf_xfer_msg(tmp, msg, &apply_bytes, &tot_size);
+
+	ingress_msg_empty = list_empty(&psock->ingress_msg);
+	list_add_tail(&tmp->list, &psock->backlog_msg);
+
+out_unlock:
+	spin_unlock(&psock->backlog_msg_lock);
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
+		psock->backlog_work_delayed = false;
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
@@ -442,18 +619,24 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
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


