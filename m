Return-Path: <bpf+bounces-57234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC64AA75D4
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 17:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C509C59BC
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03B256C82;
	Fri,  2 May 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ortj5bYF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1602566;
	Fri,  2 May 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199004; cv=none; b=cEkvG2EZiO0d/hIr3Ir3pKCyL4Nr7Cc38hlwuLl9Mqg5pJ8DMJZDp5EsdTAxWfu7RkZRYE+k4X+bfLACnA9/98mW9S8xDDgz+dh1sNX+kzIoIgE91AciH/+PVxCnQMXDdE7iVC0VellSvq//VKJZUjqVoCJmQuneBl0R8ZRyumY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199004; c=relaxed/simple;
	bh=2VicIOPMP2xJsEXt+sniH6drz5d36f2f8Ph1n1lnsNw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=IVH4uOoCsQZG255cXa9Rz6zJjTfA1zJOtJnMxUxTMWVoJSLvh0GVUcoAYCE/ga6gjnTQ0qcklwmDRvED0kmJ5tuiCG/zZJiZrN+iNTzN8+kEHCemH8zFieXcq7csDRYy/rAtPAbHxYyOIGDbKooU7Dn0W7dQAXAEZ5Ai3tx+r4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ortj5bYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806E5C4CEE4;
	Fri,  2 May 2025 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746199002;
	bh=2VicIOPMP2xJsEXt+sniH6drz5d36f2f8Ph1n1lnsNw=;
	h=Subject:From:To:Cc:Date:From;
	b=Ortj5bYF1VeQ1XPjHkrFZLO+9wHvOwbnF19A/4rz4tncbWOIuy/MpJTg2kKXtiBns
	 JVBnh0kDqxJYp1jvTxlQU31Yl7OPail6Kwh0gbsMN+knkudVivDbDS6Aw911cXQoY8
	 Qct2FOd/zJ50ktB3IdrQ6bLEb/Nxlol8mjXkKV+ZZ5aSSLydIoqQoTv3xkE4Lshu5M
	 lyKepdbFBWblFLA2BO39vqGDxPPhR2XSoMpo35xn1jKC3Dxhu2NPVrinWD8Ngu074J
	 r10z5nLmKNmK+gCIbRRCxOhVLBWYDMP5R29ANEwnQy5Ze7Pe4rcVkvtW1UHFSye33V
	 zE9H7yH6UBgsw==
Subject: [PATCH net-next V1] net: track pfmemalloc drops via
 SKB_DROP_REASON_PFMEMALLOC
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 kernel-team@cloudflare.com, mfleming@cloudflare.com
Date: Fri, 02 May 2025 17:16:38 +0200
Message-ID: <174619899817.1075985.12078484570755125058.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a new SKB drop reason (SKB_DROP_REASON_PFMEMALLOC) to track packets
dropped due to memory pressure. In production environments, we've observed
memory exhaustion reported by memory layer stack traces, but these drops
were not properly tracked in the SKB drop reason infrastructure.

While most network code paths now properly report pfmemalloc drops, some
protocol-specific socket implementations still use sk_filter() without
drop reason tracking:
- Bluetooth L2CAP sockets
- CAIF sockets
- IUCV sockets
- Netlink sockets
- SCTP sockets
- Unix domain sockets

These remaining cases represent less common paths and could be converted
in a follow-up patch if needed. The current implementation provides
significantly improved observability into memory pressure events in the
network stack, especially for key protocols like TCP and UDP, helping to
diagnose problems in production environments.

Reported-by: Matt Fleming <mfleming@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/tun.c             |    6 ++----
 include/linux/filter.h        |   13 +++++++++++--
 include/net/dropreason-core.h |    4 ++++
 include/net/tcp.h             |    2 +-
 net/core/dev.c                |    6 +++++-
 net/core/filter.c             |   13 ++++++++++---
 net/core/sock.c               |   20 +++++++++++++-------
 net/ipv4/tcp_ipv4.c           |   25 ++++++++++++++-----------
 net/ipv4/udp.c                |    8 +++-----
 net/ipv6/tcp_ipv6.c           |    9 +++------
 net/ipv6/udp.c                |    4 +---
 net/rose/rose_in.c            |    3 ++-
 12 files changed, 69 insertions(+), 44 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7babd1e9a378..bc47b6d112c3 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1000,8 +1000,8 @@ static unsigned int run_ebpf_filter(struct tun_struct *tun,
 /* Net device start xmit */
 static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct tun_struct *tun = netdev_priv(dev);
-	enum skb_drop_reason drop_reason;
 	int txq = skb->queue_mapping;
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
@@ -1030,10 +1030,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	if (tfile->socket.sk->sk_filter &&
-	    sk_filter(tfile->socket.sk, skb)) {
-		drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
+	    (sk_filter_reason(tfile->socket.sk, skb, &drop_reason)))
 		goto drop;
-	}
 
 	len = run_ebpf_filter(tun, skb, len);
 	if (len == 0) {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5cf4d35d83e..cb31be77dd7e 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1073,12 +1073,21 @@ bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 	return set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
 }
 
-int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
+int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap,
+		       enum skb_drop_reason *reason);
 static inline int sk_filter(struct sock *sk, struct sk_buff *skb)
 {
-	return sk_filter_trim_cap(sk, skb, 1);
+	enum skb_drop_reason ignore_reason;
+
+	return sk_filter_trim_cap(sk, skb, 1, &ignore_reason);
+}
+static inline int sk_filter_reason(struct sock *sk, struct sk_buff *skb,
+				   enum skb_drop_reason *reason)
+{
+	return sk_filter_trim_cap(sk, skb, 1, reason);
 }
 
+
 struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err);
 void bpf_prog_free(struct bpf_prog *fp);
 
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index bea77934a235..f33dfc93c759 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -570,6 +570,10 @@ enum skb_drop_reason {
 	 * ingress bridge port does not allow frames to be forwarded.
 	 */
 	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
+	/**
+	 * @SKB_DROP_REASON_PFMEMALLOC: dropped when under memory pressure
+	 */
+	SKB_DROP_REASON_PFMEMALLOC,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5078ad868fee..b6d72e1b4362 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1560,7 +1560,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 		     enum skb_drop_reason *reason);
 
 
-int tcp_filter(struct sock *sk, struct sk_buff *skb);
+int tcp_filter(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason *reason);
 void tcp_set_state(struct sock *sk, int state);
 void tcp_done(struct sock *sk);
 int tcp_abort(struct sock *sk, int err);
diff --git a/net/core/dev.c b/net/core/dev.c
index 03d20a98f8b7..a1e10a13f7c8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5910,7 +5910,11 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 			dev_core_stats_rx_dropped_inc(skb->dev);
 		else
 			dev_core_stats_rx_nohandler_inc(skb->dev);
-		kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);
+
+		if (pfmemalloc)
+			kfree_skb_reason(skb, SKB_DROP_REASON_PFMEMALLOC);
+		else
+			kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);
 		/* Jamal, now you will not able to escape explaining
 		 * me how you were going to use this. :-)
 		 */
diff --git a/net/core/filter.c b/net/core/filter.c
index bc6828761a47..65fea8b934b0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -122,6 +122,7 @@ EXPORT_SYMBOL_GPL(copy_bpf_fprog_from_user);
  *	@sk: sock associated with &sk_buff
  *	@skb: buffer to filter
  *	@cap: limit on how short the eBPF program may trim the packet
+ *	@reason: record drop reason on errors (negative return value)
  *
  * Run the eBPF program and then cut skb->data to correct size returned by
  * the program. If pkt_len is 0 we toss packet. If skb->len is smaller
@@ -130,7 +131,8 @@ EXPORT_SYMBOL_GPL(copy_bpf_fprog_from_user);
  * be accepted or -EPERM if the packet should be tossed.
  *
  */
-int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap)
+int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb,
+		       unsigned int cap, enum skb_drop_reason *reason)
 {
 	int err;
 	struct sk_filter *filter;
@@ -142,15 +144,20 @@ int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap)
 	 */
 	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
+		*reason = SKB_DROP_REASON_PFMEMALLOC;
 		return -ENOMEM;
 	}
 	err = BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb);
-	if (err)
+	if (err) {
+		*reason = SKB_DROP_REASON_SOCKET_FILTER;
 		return err;
+	}
 
 	err = security_sock_rcv_skb(sk, skb);
-	if (err)
+	if (err) {
+		*reason = SKB_DROP_REASON_SECURITY_HOOK;
 		return err;
+	}
 
 	rcu_read_lock();
 	filter = rcu_dereference(sk->sk_filter);
diff --git a/net/core/sock.c b/net/core/sock.c
index b64df2463300..8cb6254cc56a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -524,11 +524,10 @@ int sock_queue_rcv_skb_reason(struct sock *sk, struct sk_buff *skb,
 	enum skb_drop_reason drop_reason;
 	int err;
 
-	err = sk_filter(sk, skb);
-	if (err) {
-		drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
+	err = sk_filter_reason(sk, skb, &drop_reason);
+	if (err)
 		goto out;
-	}
+
 	err = __sock_queue_rcv_skb(sk, skb);
 	switch (err) {
 	case -ENOMEM:
@@ -551,15 +550,18 @@ EXPORT_SYMBOL(sock_queue_rcv_skb_reason);
 int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 		     const int nested, unsigned int trim_cap, bool refcounted)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	int rc = NET_RX_SUCCESS;
+	int err;
 
-	if (sk_filter_trim_cap(sk, skb, trim_cap))
+	if (sk_filter_trim_cap(sk, skb, trim_cap, &reason))
 		goto discard_and_relse;
 
 	skb->dev = NULL;
 
 	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
+		reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
 		goto discard_and_relse;
 	}
 	if (nested)
@@ -575,8 +577,12 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 		rc = sk_backlog_rcv(sk, skb);
 
 		mutex_release(&sk->sk_lock.dep_map, _RET_IP_);
-	} else if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf))) {
+	} else if ((err = sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))) {
 		bh_unlock_sock(sk);
+		if (err == -ENOMEM)
+			reason = SKB_DROP_REASON_PFMEMALLOC;
+		if (err == -ENOBUFS)
+			reason = SKB_DROP_REASON_SOCKET_BACKLOG;
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
@@ -587,7 +593,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 		sock_put(sk);
 	return rc;
 discard_and_relse:
-	kfree_skb(skb);
+	sk_skb_reason_drop(sk, skb, reason);
 	goto out;
 }
 EXPORT_SYMBOL(__sk_receive_skb);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d5b5c32115d2..d0cf144b9bd5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2025,6 +2025,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	u32 gso_size;
 	u64 limit;
 	int delta;
+	int err;
 
 	/* In case all data was pulled from skb frags (in __pskb_pull_tail()),
 	 * we can fix skb->truesize to its real value to avoid future drops.
@@ -2135,21 +2136,26 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 
 	limit = min_t(u64, limit, UINT_MAX);
 
-	if (unlikely(sk_add_backlog(sk, skb, limit))) {
+	if (unlikely((err = sk_add_backlog(sk, skb, limit)))) {
 		bh_unlock_sock(sk);
-		*reason = SKB_DROP_REASON_SOCKET_BACKLOG;
-		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
+		if (err == -ENOMEM) {
+			*reason = SKB_DROP_REASON_PFMEMALLOC;
+			__NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
+		} else {
+			*reason = SKB_DROP_REASON_SOCKET_BACKLOG;
+			__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
+		}
 		return true;
 	}
 	return false;
 }
 EXPORT_IPV6_MOD(tcp_add_backlog);
 
-int tcp_filter(struct sock *sk, struct sk_buff *skb)
+int tcp_filter(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason *reason)
 {
 	struct tcphdr *th = (struct tcphdr *)skb->data;
 
-	return sk_filter_trim_cap(sk, skb, th->doff * 4);
+	return sk_filter_trim_cap(sk, skb, th->doff * 4, reason);
 }
 EXPORT_IPV6_MOD(tcp_filter);
 
@@ -2276,14 +2282,12 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		}
 		refcounted = true;
 		nsk = NULL;
-		if (!tcp_filter(sk, skb)) {
+		if (!tcp_filter(sk, skb, &drop_reason)) {
 			th = (const struct tcphdr *)skb->data;
 			iph = ip_hdr(skb);
 			tcp_v4_fill_cb(skb, iph, th);
 			nsk = tcp_check_req(sk, skb, req, false, &req_stolen,
 					    &drop_reason);
-		} else {
-			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 		}
 		if (!nsk) {
 			reqsk_put(req);
@@ -2339,10 +2343,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 
 	nf_reset_ct(skb);
 
-	if (tcp_filter(sk, skb)) {
-		drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
+	if (tcp_filter(sk, skb, &drop_reason))
 		goto discard_and_relse;
-	}
+
 	th = (const struct tcphdr *)skb->data;
 	iph = ip_hdr(skb);
 	tcp_v4_fill_cb(skb, iph, th);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f9f5b92cf4b6..bf5659f1f4e5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2345,7 +2345,7 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
  */
 static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 {
-	int drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
+	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct udp_sock *up = udp_sk(sk);
 	int is_udplite = IS_UDPLITE(sk);
 
@@ -2434,10 +2434,8 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	    udp_lib_checksum_complete(skb))
 			goto csum_error;
 
-	if (sk_filter_trim_cap(sk, skb, sizeof(struct udphdr))) {
-		drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
+	if (sk_filter_trim_cap(sk, skb, sizeof(struct udphdr), &drop_reason))
 		goto drop;
-	}
 
 	udp_csum_pull_header(skb);
 
@@ -2637,6 +2635,7 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		   int proto)
 {
+	enum skb_drop_reason drop_reason;
 	struct sock *sk = NULL;
 	struct udphdr *uh;
 	unsigned short ulen;
@@ -2644,7 +2643,6 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__be32 saddr, daddr;
 	struct net *net = dev_net(skb->dev);
 	bool refcounted;
-	int drop_reason;
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7dcb33f879ee..6af7a08f510c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1832,14 +1832,12 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		}
 		refcounted = true;
 		nsk = NULL;
-		if (!tcp_filter(sk, skb)) {
+		if (!tcp_filter(sk, skb, &drop_reason)) {
 			th = (const struct tcphdr *)skb->data;
 			hdr = ipv6_hdr(skb);
 			tcp_v6_fill_cb(skb, hdr, th);
 			nsk = tcp_check_req(sk, skb, req, false, &req_stolen,
 					    &drop_reason);
-		} else {
-			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 		}
 		if (!nsk) {
 			reqsk_put(req);
@@ -1895,10 +1893,9 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 
 	nf_reset_ct(skb);
 
-	if (tcp_filter(sk, skb)) {
-		drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
+	if (tcp_filter(sk, skb, &drop_reason))
 		goto discard_and_relse;
-	}
+
 	th = (const struct tcphdr *)skb->data;
 	hdr = ipv6_hdr(skb);
 	tcp_v6_fill_cb(skb, hdr, th);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 7317f8e053f1..ffef09631832 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -893,10 +893,8 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	    udp_lib_checksum_complete(skb))
 		goto csum_error;
 
-	if (sk_filter_trim_cap(sk, skb, sizeof(struct udphdr))) {
-		drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
+	if (sk_filter_trim_cap(sk, skb, sizeof(struct udphdr), &drop_reason))
 		goto drop;
-	}
 
 	udp_csum_pull_header(skb);
 
diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index 4d67f36dce1b..4603a9385a61 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -101,6 +101,7 @@ static int rose_state2_machine(struct sock *sk, struct sk_buff *skb, int framety
  */
 static int rose_state3_machine(struct sock *sk, struct sk_buff *skb, int frametype, int ns, int nr, int q, int d, int m)
 {
+	enum skb_drop_reason dr; /* ignored */
 	struct rose_sock *rose = rose_sk(sk);
 	int queued = 0;
 
@@ -162,7 +163,7 @@ static int rose_state3_machine(struct sock *sk, struct sk_buff *skb, int framety
 		rose_frames_acked(sk, nr);
 		if (ns == rose->vr) {
 			rose_start_idletimer(sk);
-			if (sk_filter_trim_cap(sk, skb, ROSE_MIN_LEN) == 0 &&
+			if (sk_filter_trim_cap(sk, skb, ROSE_MIN_LEN, &dr) == 0 &&
 			    __sock_queue_rcv_skb(sk, skb) == 0) {
 				rose->vr = (rose->vr + 1) % ROSE_MODULUS;
 				queued = 1;



