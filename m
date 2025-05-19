Return-Path: <bpf+bounces-58505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19013ABC889
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1275B1B66198
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104A21B9D3;
	Mon, 19 May 2025 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJPlmORc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2A219300;
	Mon, 19 May 2025 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687017; cv=none; b=IDc17Q48qcnMrlS3BT9HGsX9NMpIqDT9GYfWu3h96scijT1lXrDgQFgUgA/Mfbmaf6fTiw3zptsuKyJwSvBnLntHoHfAPxqDVvQ6RWoXIyNDE54I/d6VmspCujFTEWew6/3JSDexvoaIVxdWYGPp66hZ6lZEdrsp1XVziLDrq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687017; c=relaxed/simple;
	bh=rWluvyaegs5KftePNt5XPRw6qwYG6M2RBBRkTAO87A8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bstiiCK5qMeUWknHNK3n+pmsvdc0OtkncDV4kaYzw+QQpUjaW+fPiqk5tdHTMMQOtvSlCArf904VQlzBV6yn+2GHoMwPQyt+3ecAf3Qap3eH4hrHzpi4wn0/fXTB33ZIlU8Uf+32kslF+q00x3qIIeJ/TwVQOxWYjh9J5q9Kxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJPlmORc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c96af71dso2387150b3a.0;
        Mon, 19 May 2025 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747687014; x=1748291814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIDkOc2giy5sr5GxrCKllGAvHQ8eLrpyRe2Yfx9MFFg=;
        b=hJPlmORcgTrtu76fQKQkIWylg3dvOr6ivXG7aisvpLxESDJZg+LeLJzOhvr1z6Peh/
         x8bS0n90t3fZaMqciMq88kb1JTWhPsBtAtOfdzIXajYloAy7z1vBCo2Uy/bzMvplRsAd
         8qynmh1CLgI3WcPNFeegLBC3oTfMTd4ZHMvlk1armb8RSCQAXmlbsUb7aE22GOvL7/IF
         t+ssPV8Xj5Lzm/sVIo14AxyeYPu61tI01huGNoZxB8o6QbNeni6l/448NHfZ5H0lRp+H
         o4TDCXsyQVfft3SmLxB/8KBB0i2FZ6T0vq2FSLrVQI8T8zcN2swSzykvwqnh+rGidOKr
         Mghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687014; x=1748291814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIDkOc2giy5sr5GxrCKllGAvHQ8eLrpyRe2Yfx9MFFg=;
        b=hH+1TdoN4e0WLc+pbAiknrmbmTt6BnzQKratDenctw0gkS8n4Ub2Lw6eI/p9mL2bum
         RCf+FSTsjYSrNU35aIYkqJQni0vAPHAopSLZ9srNaXwz0AJmeDwDcdhQE/wBv6CM/PjP
         IuPbYcT/1tAKgkm/TiMgqm7hljJF2s/xaMmscx0ZpWbTbqfv8wchcUYkqxkHfOKOT4e5
         Xq6kawHS16d6JrG0Jyi2ZiKOXVh//XD+3uPGB9GWs4BKzwSRxp/B7uZxDIXGWyGnWh3Z
         cqaKkTSdjZrC/b2NFFDyGBt1oG5Jdajpg2ph9eVmfIneglS9/IEUFGK31+cnhkNOv8lS
         oyTQ==
X-Gm-Message-State: AOJu0Yyj1zpeWlJVsodc6oTBGzK5zo5P46Z25djzfYv05CGvVvkNvLfq
	RvfDXhUPHw4ntrzwv7YWvrbh+bjjhQ8o7vhcA0/W9yKaoMU6Q26p/n8ODVgY9g==
X-Gm-Gg: ASbGncvcMdNLcrBi8XoX8bvJ2jCQUeuqsyKN6A4Ak5f+RqGVww9mKtmO7cR7XBW6zPS
	jPISe6VM4CCYqVWXNjZE4hFjKG+sPs50dcspmRTenHOB+MebmCMFNcEEcm76B8UG0uK29rDkivY
	uQW87BD7tFxl3PGslwI4jLGIPRK/BMTudVa0gAx39Xi0pZ/D9DF/CVUWtsbNf6OfisLXRrT2/2f
	ai66wsLoTUd2T9fPLPMK8bswpySNoLHeQoRf5IybLZiLsCPqvdPKsFAMvW6yxghhnZdAoG0F685
	pJjgyab0ozzibJ4q/7Sg3lq3H+3OEdFfF0Cn/MutygNF7WeqCMr3hOegeOkiuw==
X-Google-Smtp-Source: AGHT+IGFm4HexkhFVs20W4PTSyqN1Xd8O9IL3BRa0hnfc/WjYlMXeG13PCsVdTgHN1Xb59yjxISbDQ==
X-Received: by 2002:a05:6a20:7f93:b0:215:fb74:2dc2 with SMTP id adf61e73a8af0-2162189f132mr19358336637.11.1747687014227;
        Mon, 19 May 2025 13:36:54 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970d5aasm6865112b3a.63.2025.05.19.13.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:36:53 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	zhoufeng.zf@bytedance.com,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	zijianzhang@bytedance.com,
	Amery Hung <amery.hung@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v3 4/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Mon, 19 May 2025 13:36:28 -0700
Message-Id: <20250519203628.203596-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
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
index 30220185fd45..d0bc1322ac8f 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -12,7 +12,7 @@
 
 struct kmem_cache *sk_msg_cachep;
 
-static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
+bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 {
 	if (msg->sg.end > msg->sg.start &&
 	    elem_first_coalesce < msg->sg.end)
@@ -713,6 +713,118 @@ static void sk_psock_backlog(struct work_struct *work)
 	mutex_unlock(&psock->work_mutex);
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
@@ -750,8 +862,11 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 
 	INIT_DELAYED_WORK(&psock->work, sk_psock_backlog);
 	mutex_init(&psock->work_mutex);
+	INIT_DELAYED_WORK(&psock->backlog_work, sk_psock_backlog_msg_work);
 	INIT_LIST_HEAD(&psock->ingress_msg);
 	spin_lock_init(&psock->ingress_lock);
+	INIT_LIST_HEAD(&psock->backlog_msg);
+	spin_lock_init(&psock->backlog_msg_lock);
 	skb_queue_head_init(&psock->ingress_skb);
 
 	sk_psock_set_state(psock, SK_PSOCK_TX_ENABLED);
@@ -805,6 +920,26 @@ static void __sk_psock_zap_ingress(struct sk_psock *psock)
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
@@ -834,7 +969,9 @@ static void sk_psock_destroy(struct work_struct *work)
 	sk_psock_done_strp(psock);
 
 	cancel_delayed_work_sync(&psock->work);
+	cancel_delayed_work_sync(&psock->backlog_work);
 	__sk_psock_zap_ingress(psock);
+	__sk_psock_purge_backlog_msg(psock);
 	mutex_destroy(&psock->work_mutex);
 
 	psock_progs_drop(&psock->progs);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index f0ef41c951e2..82d437210f6f 100644
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
+			ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
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


