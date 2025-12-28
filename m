Return-Path: <bpf+bounces-77458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83298CE0382
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 01:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95BCE30361F5
	for <lists+bpf@lfdr.de>; Sun, 28 Dec 2025 00:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C8113635C;
	Sun, 28 Dec 2025 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9JS/6KM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6D3A1CD
	for <bpf@vger.kernel.org>; Sun, 28 Dec 2025 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766881366; cv=none; b=UazT+o00gS6vOeYKyhN0z2dMBDRBF0qPuG574xGmUZGNq7fvqMZySA1CC4TaB6GwYozUvTENiqulFqTnSZ2veS6b6rsCBth49gSg+YVTzw+c5MyqBU6q1ihafPnF4AjXPH8DyZnjN1WSOrgWEVq+lmAhItJderq3FU9m7/lCGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766881366; c=relaxed/simple;
	bh=0K6vNsGUbTPJ57SJ8LDwNu97C+PfxKrFWsz6qWUFkPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLJMKVhehjYw6TZ8EFZiydEJbZtWRh0uiia6fVGmiboJ1PdUedCvxT1iPljGu72zMIgnDkf9Lq+zJ/YEUTXYY6QaC4U3y2UUrlitLx1FGPgkxRyVEniSUwkQ/pb8lG+Rbe+Ds9thHBuTvL1McZ/K+/okzBHx2PkBCxDCGOfOtJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9JS/6KM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29f102b013fso100620875ad.2
        for <bpf@vger.kernel.org>; Sat, 27 Dec 2025 16:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766881364; x=1767486164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t56JAXxj8D0elYS8/CRp9/O5vk/sJWWuoUL8wWTQUfI=;
        b=F9JS/6KMbVGUgwULmLAIJAP08tTJf5p2ZwuN1+xokeuCYA+yB3BuIypwPnkfnqaqoU
         TRPKxsX+X8WcsYEe9HHYzhQgSPzQNYbSOqzlDsBxri4J79LIKImJzRge10fM9mdH5cll
         9CsC9iHp9ZErZiSP6qcqMlYZkbYLdxoGg72z/2R8SwWk4w2S+Mp7BxVk9PIDgVnr8am6
         apOxPcjuAAOegei5x/R67yxVTZyYixtdZFJyCb5JryOx0FHMgHS3UHMPy2yBkw4uYtdb
         Zn2CvKL8d28N7/IWkhlZbpNp9USihM2pC4NiVXg0x4YG2N4wmO3zvI45i3OQnAcIdEjb
         NKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766881364; x=1767486164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t56JAXxj8D0elYS8/CRp9/O5vk/sJWWuoUL8wWTQUfI=;
        b=m33mrxZFXkH5KVNLyy5Wwrlmw+BrN1ZO+YP1bGrrQv55wDoDVFjmWA2k6TcN/qslwq
         4MYBj8Uo0H4ASHc7nMpsHVHAWB6utP1uCwixIPblpci9Ai+HT43J/MJs1fw1m83bcC5i
         8jY2970lmIaX36M5iFc5nK0q0ZMjou7+tNB1xOVfges5aj08lZJSF0PMrzrqRWR9tmII
         t6uV9Yjv7xKMW5Kq+JV+mNr0sCcGxcwFiBIvOvHwoSXtpu2MXxGoPuKXVjP+XkV1ZwvL
         jL8LsPv8yw8gBd0pKnsUb/LNocmf8oN7Da50+pfcXNjnL5mbnnIYDsP/jPxSj/Ptx65l
         vQhw==
X-Forwarded-Encrypted: i=1; AJvYcCXUaIcgP9EL7oTXbcftXapwNddbLb5dxRCa/bSztSkPNlLGFnBmYwgT5XjsHaLoEjDHHq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PXANJ6W73Lttpw6vPFmCogbSZ7mIrcSnTWe71J6xs6UaVrG7
	xAlbIiAtGCAMMGn8t+H+H95kwSBpBQ3GHxOMVIbDX7UfQaaTugcTrtua
X-Gm-Gg: AY/fxX4sRqefDouNVG8P3BT+i8F8lD9QQAQ6JY8mdCFqu0WAnorpo+0MP8JpSYtCYEp
	28Mlrrf883Dz72NlGW1+d3tOwre+f0temrlENuWqkdKcnl7NBfMweg1CJlRDucTVYpFOPY4drax
	wzZvjCz8lFZw7L8fw9UnMKR/rpeuhSOTZAwU71lpZcnJ33F4s8ZH2V1n2s/ehklfIJ8yfoDIyJt
	rOH7wkhAUJuonAPMiNdRZJOlPiuKgqXatGLiteBvKhQdPUfVBDm5cGx2+iltltbqrI5lZK0Yts3
	y7OzJ6C6HmJGl7D65o7A3dkkMT8Y3BxaMOgWyke0lDaBGMDz0Aj7hQf82dfzI55HHx6LQZIVOUk
	rADayeqvRcMVyjCLZThMpxfNLMij7HgjHGqLzGknpTP370AWIuEGfA+MPI/pyFn8RivqFxK/yty
	LXwGru5VgPJgajdZiK
X-Google-Smtp-Source: AGHT+IGD/t6pzmx06HKCncV/t8S9gDadptXsVyhreJVZznCJjSnl6/DuhllVAQVripD1oItDVXrM3Q==
X-Received: by 2002:a17:902:db12:b0:29d:65ed:f481 with SMTP id d9443c01a7336-2a2f1f7698fmr262868585ad.0.1766881363747;
        Sat, 27 Dec 2025 16:22:43 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:70f5:5037:d004:a56e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm236533535ad.100.2025.12.27.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 16:22:43 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	bpf@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v5 4/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Sat, 27 Dec 2025 16:22:19 -0800
Message-Id: <20251228002219.1183459-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
References: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
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
index 99ef5d501b8f..3f78d12999af 100644
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
index 45ff311ccf49..2dd4ade35b11 100644
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
@@ -820,6 +935,26 @@ static void __sk_psock_zap_ingress(struct sk_psock *psock)
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
@@ -849,7 +984,9 @@ static void sk_psock_destroy(struct work_struct *work)
 	sk_psock_done_strp(psock);
 
 	cancel_delayed_work_sync(&psock->work);
+	cancel_delayed_work_sync(&psock->backlog_work);
 	__sk_psock_zap_ingress(psock);
+	__sk_psock_purge_backlog_msg(psock);
 	mutex_destroy(&psock->work_mutex);
 
 	psock_progs_drop(&psock->progs);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ed049a912a23..d0e03e7df8e3 100644
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
@@ -445,18 +622,24 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
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


