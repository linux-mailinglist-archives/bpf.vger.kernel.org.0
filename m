Return-Path: <bpf+bounces-49056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38476A13BC5
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5AA3AA767
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8F722C9F0;
	Thu, 16 Jan 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jGtj/hrb"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE822B5B5;
	Thu, 16 Jan 2025 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036499; cv=none; b=gI+Hr+o+qfqfeq79ZyoKg10j8h13y39ERK9ngh80uKpDKNF12J1o6qjOegHew7V/MQjnBCNAmj0efjdp4mqNswVBUAswhSeSVj3szUQm2CKLajEHhMWhwBAxzRNfxIiI4DuOVikLe6E8hPF2fhK1R6ttOLnNCtrK+3N1zyl1r8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036499; c=relaxed/simple;
	bh=NSZxgEEnYo4Ufbsw5XRzzlXlXyPfYSIDsx2iFz4XNg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNHg6GfIqD5trod3Bg7Y4+lTQw+0l31DyHOFr9HvYMXS04tv7Ngy4K02CS73sN8BRKoogZPI7zI1L4Ch5WUf81U/gbYN/ksUSwJBIdU8zq6FFuDL2K4Ns51V+S4GsZSJAAtSwawshDeu/qysYYBXWFgm6iXt8KUTUUP2+t0B1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jGtj/hrb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=lus7n
	XwCrJp6Yqu6exBguj1FRhZPoHxYKR7jSlkD8X0=; b=jGtj/hrbsBWia+OHb5gUV
	OV0W3Qi+kyhlwEucPdIe4jIGX5dZDmOO1321DcN8XssA05WnxnJ/SPBVeLGG5pZy
	FxBjjcP2sB97oTib/yTRQOD06AnG7qt4PD1NRG/c3dATX6zk+fZNq8NjguLBBwaz
	372twt6mIWi3AQtmJwOm6w=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3d5IwEolnR5IwGg--.20972S4;
	Thu, 16 Jan 2025 22:06:08 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	song@kernel.org,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	daniel@iogearbox.net,
	xiyou.wangcong@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	eddyz87@gmail.com,
	cong.wang@bytedance.com,
	shuah@kernel.org,
	mykolal@fb.com,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	linux-doc@vger.kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v7 2/5] bpf: fix wrong copied_seq calculation
Date: Thu, 16 Jan 2025 22:05:28 +0800
Message-ID: <20250116140531.108636-3-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250116140531.108636-1-mrpre@163.com>
References: <20250116140531.108636-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d5IwEolnR5IwGg--.20972S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKryrKFWrGFyUKw4rurWxZwb_yoWfGF18pF
	1kA3yrCF17GFy7uwn3AF97Gr1agw4rKFW7Cr18u3y3Zrs7Kr1fXFyrKF1ayFW5Kr45Cr13
	Jr4UGwsxCwnrAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE-eOgUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwPWp2eJEGskogAAsu

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

We do not want to add new proto_ops to implement a new version of
tcp_read_sock, as this would introduce code complexity [1].

We add new callback for strparser for customized read operation, also as
a wrapper function it provides abstraction use psock.

[1]: https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com
Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 include/linux/skmsg.h |  4 ++++
 include/net/tcp.h     |  3 +++
 net/core/skmsg.c      | 23 +++++++++++++++++++++
 net/ipv4/tcp.c        | 29 +++++++++++++++++++++-----
 net/ipv4/tcp_bpf.c    | 47 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 2cbe0c22a32f..c9343eeac8b3 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -91,6 +91,10 @@ struct sk_psock {
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 	struct strparser		strp;
+	int (*read_sock)(struct sock *sk, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
+	u32				copied_seq;
+	u32				ingress_bytes;
 #endif
 	struct sk_buff_head		ingress_skb;
 	struct list_head		ingress_msg;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9b37b76e894..88e55e62023c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -729,6 +729,9 @@ void tcp_get_info(struct sock *, struct tcp_info *);
 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		  sk_read_actor_t recv_actor);
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, bool noack,
+			u32 *copied_seq);
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq, u32 *off);
 void tcp_read_done(struct sock *sk, size_t len);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 61f3f3d4e528..6695659d3447 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -549,6 +549,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 			return num_sge;
 	}
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	psock->ingress_bytes += len;
+#endif
 	copied = len;
 	msg->sg.start = 0;
 	msg->sg.size = copied;
@@ -1092,6 +1095,25 @@ static int sk_psock_strp_read_done(struct strparser *strp, int err)
 	return err;
 }
 
+static int sk_psock_strp_read_sock(struct strparser *strp,
+				   read_descriptor_t *desc,
+				   sk_read_actor_t recv_actor)
+{
+	struct sock *sk = strp->sk;
+	struct socket *sock = sk->sk_socket;
+	struct sk_psock *psock;
+	int rv = 0;
+
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (likely(psock && psock->read_sock))
+		rv = psock->read_sock(sk, desc, recv_actor);
+	else if (sock && sock->ops && sock->ops->read_sock)
+		rv = sock->ops->read_sock(sk, desc, recv_actor);
+	rcu_read_unlock();
+	return rv;
+}
+
 static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 {
 	struct sk_psock *psock = container_of(strp, struct sk_psock, strp);
@@ -1136,6 +1158,7 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 
 	static const struct strp_callbacks cb = {
 		.rcv_msg	= sk_psock_strp_read,
+		.read_sock	= sk_psock_strp_read_sock,
 		.read_sock_done	= sk_psock_strp_read_done,
 		.parse_msg	= sk_psock_strp_parse,
 	};
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..285678d8ce07 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1565,12 +1565,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
  *	  or for 'peeking' the socket using this routine
  *	  (although both would be easy to implement).
  */
-int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
-		  sk_read_actor_t recv_actor)
+static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor, bool noack,
+			   u32 *copied_seq)
 {
 	struct sk_buff *skb;
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 seq = tp->copied_seq;
+	u32 seq = *copied_seq;
 	u32 offset;
 	int copied = 0;
 
@@ -1624,9 +1625,12 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_eat_recv_skb(sk, skb);
 		if (!desc->count)
 			break;
-		WRITE_ONCE(tp->copied_seq, seq);
+		WRITE_ONCE(*copied_seq, seq);
 	}
-	WRITE_ONCE(tp->copied_seq, seq);
+	WRITE_ONCE(*copied_seq, seq);
+
+	if (noack)
+		goto out;
 
 	tcp_rcv_space_adjust(sk);
 
@@ -1635,10 +1639,25 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_recv_skb(sk, seq, &offset);
 		tcp_cleanup_rbuf(sk, copied);
 	}
+out:
 	return copied;
 }
+
+int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+		  sk_read_actor_t recv_actor)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, false,
+			       &tcp_sk(sk)->copied_seq);
+}
 EXPORT_SYMBOL(tcp_read_sock);
 
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, bool noack,
+			u32 *copied_seq)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, noack, copied_seq);
+}
+
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 47f65b1b70ca..6dcde3506a9b 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -646,6 +646,47 @@ static int tcp_bpf_assert_proto_ops(struct proto *ops)
 	       ops->sendmsg  == tcp_sendmsg ? 0 : -ENOTSUPP;
 }
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+static int tcp_bpf_strp_read_sock(struct sock *sk, read_descriptor_t *desc,
+				  sk_read_actor_t recv_actor)
+{
+	struct sk_psock *psock;
+	struct tcp_sock *tp;
+	int copied = 0;
+
+	tp = tcp_sk(sk);
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (WARN_ON(!psock)) {
+		desc->error = -EINVAL;
+		goto out;
+	}
+
+	psock->ingress_bytes = 0;
+	/* We could easily add copied_seq and noack into desc then call
+	 * ops->read_sock without calling symbol directly. But unfortunately
+	 * most descriptors used by other modules are not inited with zero.
+	 * Also it not work by replacing ops->read_sock without introducing
+	 * new ops as ops itself is located in rodata segment.
+	 */
+	copied = tcp_read_sock_noack(sk, desc, recv_actor, true,
+				     &psock->copied_seq);
+	if (copied < 0)
+		goto out;
+	/* recv_actor may redirect skb to another socket(SK_REDIRECT) or
+	 * just put skb into ingress queue of current socket(SK_PASS).
+	 * For SK_REDIRECT, we need 'ack' the frame immediately but for
+	 * SK_PASS, the 'ack' was delay to tcp_bpf_recvmsg_parser()
+	 */
+	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
+	tcp_rcv_space_adjust(sk);
+	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
+out:
+	rcu_read_unlock();
+	return copied;
+}
+#endif /* CONFIG_BPF_STREAM_PARSER */
+
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
 	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
@@ -681,6 +722,12 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 
 	/* Pairs with lockless read in sk_clone_lock() */
 	sock_replace_proto(sk, &tcp_bpf_prots[family][config]);
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	if (psock->progs.stream_parser && psock->progs.stream_verdict) {
+		psock->copied_seq = tcp_sk(sk)->copied_seq;
+		psock->read_sock = tcp_bpf_strp_read_sock;
+	}
+#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tcp_bpf_update_proto);
-- 
2.43.5


