Return-Path: <bpf+bounces-47196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE99F5E52
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 06:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB69416B5EB
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 05:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194E1154439;
	Wed, 18 Dec 2024 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BiLhFiZM"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E014143C72;
	Wed, 18 Dec 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734500162; cv=none; b=c7PMrxWdPsbGub29LvncWBuurqQBXWcqlfx2Q3jQ+zE1TylpC/QWxzgZpMpp7hWIdCDChlbouKja+5uhysysOky1/E2D/ES7WRFjDlz7WFCqFYnR5YN2H9JHF4SbifeFkia47bV2Tv72ku93RCs9vMvdvPxnADAtjRvXzw7jZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734500162; c=relaxed/simple;
	bh=8d7/b4+IrlPm1X5n1GPzLt0aJg11yahl6Jzx8D7r0eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ/AvL11co9/yZIzUKGJHevt9ZTMgZS/vtn9FsuFjDZuo6S1deAcRQTR3hivf/wfKkD66DJBtf3H1eEY7Lfe6A2naDqAErVK22w5AnZLyOrjZ/2hzT1RPZZ79w2VybeyJrArx6TAH56NALBAoI0lwLMpRkFekX2SejClvJzmBiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BiLhFiZM; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=qpPMu
	Z8hLVKWxvUDyYWXZWQnVfjNtTHkjFSiRr/hX0Y=; b=BiLhFiZMyJGtYbAP7oS21
	g/9TSYz+LGTu8lMD/duWjucVbz7fZo2lnQHQpMwOsTTW9yfoPt2MHelLRWQuEWjN
	x/kDOQpetWhjwdEV8wf7iN4mPDW/cID+Ginq3WqIz1KZS1eMpTO/ww0xVRouiFug
	sfkmk11ApP11cEIopSe9Qk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXf3juXmJn1VZZBQ--.30577S3;
	Wed, 18 Dec 2024 13:34:57 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v3 1/2] bpf: fix wrong copied_seq calculation
Date: Wed, 18 Dec 2024 13:34:07 +0800
Message-ID: <20241218053408.437295-2-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218053408.437295-1-mrpre@163.com>
References: <20241218053408.437295-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXf3juXmJn1VZZBQ--.30577S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxKryrKFW7tFyfXFW7CFyfZwb_yoWDJF47pF
	1DAw4fZF4DGFW7WanYyFZrXr1agw4rGayjk348W3ySyrsrKr1SyF95KFyayF1rGrZ5uw13
	ArWjgw45Gw1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piBHqfUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwe5p2diWzNk1wABsJ

'sk->copied_seq' was updated in the tcp_eat_skb() function when the
action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
the update logic for 'sk->copied_seq' was moved to
tcp_bpf_recvmsg_parser() to ensure the accuracy of the 'fionread' feature.

It works for a single stream_verdict scenario, as it also modified
'sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb'
to remove updating 'sk->copied_seq'.

However, for programs where both stream_parser and stream_verdict are
active(strparser purpose), tcp_read_sock() was used instead of
tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
updates.

In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
in both tcp_read_sock() and tcp_bpf_recvmsg_parser().

The issue causes incorrect copied_seq calculations, which prevent
correct data reads from the recv() interface in user-land.

Modifying tcp_read_sock() or strparser implementation directly is
unreasonable, as it is widely used in other modules.

Here, we introduce a method tcp_bpf_read_sock() to replace
'sk->sk_socket->ops->read_sock' (like 'tls_build_proto()' does in
tls_main.c). Such replacement action was also used in updating
tcp_bpf_prots in tcp_bpf.c, so it's not weird.
(Note that checkpatch.pl may complain missing 'const' qualifier when we
define the bpf-specified 'proto_ops', but we have to do because we need
update it).

Also we remove strparser check in tcp_eat_skb() since we implement custom
function tcp_bpf_read_sock() without copied_seq updating.

Since strparser currently supports only TCP, it's sufficient for 'ops' to
inherit inet_stream_ops.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 include/linux/skmsg.h |   2 +
 include/net/tcp.h     |   1 +
 net/core/skmsg.c      |   3 ++
 net/ipv4/tcp.c        |   2 +-
 net/ipv4/tcp_bpf.c    | 108 ++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index d9b03e0746e7..7f91bc67e50f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -85,6 +85,7 @@ struct sk_psock {
 	struct sock			*sk_redir;
 	u32				apply_bytes;
 	u32				cork_bytes;
+	u32				strp_offset;
 	u32				eval;
 	bool				redir_ingress; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
@@ -112,6 +113,7 @@ struct sk_psock {
 	int  (*psock_update_sk_prot)(struct sock *sk, struct sk_psock *psock,
 				     bool restore);
 	struct proto			*sk_proto;
+	const struct proto_ops		*sk_proto_ops;
 	struct mutex			work_mutex;
 	struct sk_psock_work_state	work_state;
 	struct delayed_work		work;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9b37b76e894..fb3215936ece 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -353,6 +353,7 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			unsigned int flags);
 struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 				     bool force_schedule);
+void tcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb);
 
 static inline void tcp_dec_quickack_mode(struct sock *sk)
 {
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e90fbab703b2..99dd75c9e689 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -702,6 +702,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 {
 	struct sk_psock *psock;
 	struct proto *prot;
+	const struct proto_ops *proto_ops;
 
 	write_lock_bh(&sk->sk_callback_lock);
 
@@ -722,9 +723,11 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	}
 
 	prot = READ_ONCE(sk->sk_prot);
+	proto_ops = likely(sk->sk_socket) ? sk->sk_socket->ops : NULL;
 	psock->sk = sk;
 	psock->eval = __SK_NONE;
 	psock->sk_proto = prot;
+	psock->sk_proto_ops = proto_ops;
 	psock->saved_unhash = prot->unhash;
 	psock->saved_destroy = prot->destroy;
 	psock->saved_close = prot->close;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..6a07d98017f7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1517,7 +1517,7 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
 	__tcp_cleanup_rbuf(sk, copied);
 }
 
-static void tcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
+void tcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	__skb_unlink(skb, &sk->sk_receive_queue);
 	if (likely(skb->destructor == sock_rfree)) {
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 99cef92e6290..4a089afc09b7 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -19,9 +19,6 @@ void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
 	if (!skb || !skb->len || !sk_is_tcp(sk))
 		return;
 
-	if (skb_bpf_strparser(skb))
-		return;
-
 	tcp = tcp_sk(sk);
 	copied = tcp->copied_seq + skb->len;
 	WRITE_ONCE(tcp->copied_seq, copied);
@@ -578,6 +575,81 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	return copied > 0 ? copied : err;
 }
 
+static void sock_replace_proto_ops(struct sock *sk,
+				   const struct proto_ops *proto_ops)
+{
+	if (sk->sk_socket)
+		WRITE_ONCE(sk->sk_socket->ops, proto_ops);
+}
+
+/* The tcp_bpf_read_sock() is an alternative implementation
+ * of tcp_read_sock(), except that it does not update copied_seq.
+ */
+static int tcp_bpf_read_sock(struct sock *sk, read_descriptor_t *desc,
+			     sk_read_actor_t recv_actor)
+{
+	struct sk_psock *psock;
+	struct sk_buff *skb;
+	int offset;
+	int copied = 0;
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+
+	/* we are called from sk_psock_strp_data_ready() and
+	 * psock has already been checked and can't be NULL.
+	 */
+	psock = sk_psock_get(sk);
+	/* The offset keeps track of how much data was processed during
+	 * the last call.
+	 */
+	offset = psock->strp_offset;
+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
+		u8 tcp_flags;
+		int used;
+		size_t len;
+
+		len = skb->len - offset;
+		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
+		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
+		used = recv_actor(desc, skb, offset, len);
+		if (used <= 0) {
+			/* None of the data in skb has been consumed.
+			 * May -ENOMEM or other error happened
+			 */
+			if (!copied)
+				copied = used;
+			break;
+		}
+
+		if (WARN_ON_ONCE(used > len))
+			used = len;
+		copied += used;
+		if (used < len) {
+			/* Strparser clone and consume all input skb except
+			 * -ENOMEM happened and it will replay skb by it's
+			 * framework later. So We need to keep offset and
+			 * skb for next retry.
+			 */
+			offset += used;
+			break;
+		}
+
+		/* Entire skb was consumed, and we don't need this skb
+		 * anymore and clean the offset.
+		 */
+		offset = 0;
+		tcp_eat_recv_skb(sk, skb);
+		if (!desc->count)
+			break;
+		if (tcp_flags & TCPHDR_FIN)
+			break;
+	}
+
+	WRITE_ONCE(psock->strp_offset, offset);
+	return copied;
+}
+
 enum {
 	TCP_BPF_IPV4,
 	TCP_BPF_IPV6,
@@ -595,6 +667,10 @@ enum {
 static struct proto *tcpv6_prot_saved __read_mostly;
 static DEFINE_SPINLOCK(tcpv6_prot_lock);
 static struct proto tcp_bpf_prots[TCP_BPF_NUM_PROTS][TCP_BPF_NUM_CFGS];
+/* we do not use 'const' here because it will be polluted later.
+ * It may cause const check warning by script, just ignore it.
+ */
+static struct proto_ops tcp_bpf_proto_ops[TCP_BPF_NUM_PROTS];
 
 static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 				   struct proto *base)
@@ -615,6 +691,13 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 	prot[TCP_BPF_TXRX].recvmsg		= tcp_bpf_recvmsg_parser;
 }
 
+static void tcp_bpf_rebuild_proto_ops(struct proto_ops *ops,
+				      const struct proto_ops *base)
+{
+	*ops		= *base;
+	ops->read_sock	= tcp_bpf_read_sock;
+}
+
 static void tcp_bpf_check_v6_needs_rebuild(struct proto *ops)
 {
 	if (unlikely(ops != smp_load_acquire(&tcpv6_prot_saved))) {
@@ -627,6 +710,19 @@ static void tcp_bpf_check_v6_needs_rebuild(struct proto *ops)
 	}
 }
 
+static int __init tcp_bpf_build_proto_ops(void)
+{
+	/* We update ops separately for further scalability
+	 * although v4 and v6 use same ops.
+	 */
+	tcp_bpf_rebuild_proto_ops(&tcp_bpf_proto_ops[TCP_BPF_IPV4],
+				  &inet_stream_ops);
+	tcp_bpf_rebuild_proto_ops(&tcp_bpf_proto_ops[TCP_BPF_IPV6],
+				  &inet_stream_ops);
+	return 0;
+}
+late_initcall(tcp_bpf_build_proto_ops);
+
 static int __init tcp_bpf_v4_build_proto(void)
 {
 	tcp_bpf_rebuild_protos(tcp_bpf_prots[TCP_BPF_IPV4], &tcp_prot);
@@ -648,6 +744,7 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
 	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
 	int config = psock->progs.msg_parser   ? TCP_BPF_TX   : TCP_BPF_BASE;
+	bool strp = psock->progs.stream_verdict && psock->progs.stream_parser;
 
 	if (psock->progs.stream_verdict || psock->progs.skb_verdict) {
 		config = (config == TCP_BPF_TX) ? TCP_BPF_TXRX : TCP_BPF_RX;
@@ -666,6 +763,7 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 			sk->sk_write_space = psock->saved_write_space;
 			/* Pairs with lockless read in sk_clone_lock() */
 			sock_replace_proto(sk, psock->sk_proto);
+			sock_replace_proto_ops(sk, psock->sk_proto_ops);
 		}
 		return 0;
 	}
@@ -679,6 +777,10 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 
 	/* Pairs with lockless read in sk_clone_lock() */
 	sock_replace_proto(sk, &tcp_bpf_prots[family][config]);
+
+	if (strp)
+		sock_replace_proto_ops(sk, &tcp_bpf_proto_ops[family]);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tcp_bpf_update_proto);
-- 
2.43.5


