Return-Path: <bpf+bounces-48771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2039A107BB
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967841888182
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50633DAC1A;
	Tue, 14 Jan 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eokPvTjD"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71920236EB2;
	Tue, 14 Jan 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861139; cv=none; b=FFd5s/dT2YCHZIrTNWYjqMxMKy3eRwq+sXzfqbmD6TIfRnRmO4fMssoGA7lZgbu5VCKr/sTmKd2BHtIri/is1n0JYsCOyciKmGa8ikkU/FZOQyzc41rAuu9fJpsRhcVq/D+76w+hx37jF+OExHPEHontVyCpSv6Di6+zCGQYe5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861139; c=relaxed/simple;
	bh=7xdbFvsbV0fZyqY7NPwI/qJbMqSMKOaSrUNshbreG2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/jzZtNZf5WrLMlLHviIL78MrBYajNedGgUSgXxubTsuWKgJZgm4j4YZ4YTVbbpqUGx4KSV32OTbB62a4Be44x0wSdxMn7nc0Lxx2iBIfict5uceU7FNw+O6Xt09j9aFDY/WWX6cSHKktg8O+5EWl+x2ToyVxquCRWuuDe/dGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eokPvTjD; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=kRpuI
	VxmN84eeqWq+GuX5UoTOB1w6t2+6aXMn9xHBA8=; b=eokPvTjD37XdmvSiSwfZE
	UOiRkK5gBt/hr87FO00pkCOPsyAGMo5+RRTggw4cdtMcBn7PpCnlnJ3UnlW/BD6J
	fO2bunuu73thjbXB1dUFEEAki0rE8zom5SIQeLJN5zp7A+eAL0x1a/XU/PCjcCLQ
	cJrVUOJrwdNOvyaxf1hupk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCn_E1RZYZnl71AAw--.33013S3;
	Tue, 14 Jan 2025 21:23:53 +0800 (CST)
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
Subject: [PATCH bpf v6 1/3] bpf: fix wrong copied_seq calculation
Date: Tue, 14 Jan 2025 21:23:09 +0800
Message-ID: <20250114132312.49407-2-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250114132312.49407-1-mrpre@163.com>
References: <20250114132312.49407-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCn_E1RZYZnl71AAw--.33013S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3CFy3XFWkGF43WF4UGF4kWFg_yoWDZF13pF
	1DA3yrGr47JFyxuwn3Ar97Gr4agw4rKFW7Cr18Z3yayrn7Kr1fXFyrKF1ayF15Kr45ZFW3
	tr4DGwsxCw1DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piWSoJUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDx3Up2eGWhbnlwABs9

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

We add new callback for strparser for customized read operation.

[1]: https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com
Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 include/linux/skmsg.h     |  2 ++
 include/net/strparser.h   |  2 ++
 include/net/tcp.h         |  8 ++++++++
 net/core/skmsg.c          | 22 ++++++++++++++++++++-
 net/ipv4/tcp.c            | 29 ++++++++++++++++++++++-----
 net/ipv4/tcp_bpf.c        | 41 +++++++++++++++++++++++++++++++++++++++
 net/strparser/strparser.c | 11 +++++++++--
 7 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 2cbe0c22a32f..0b9095a281b8 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -91,6 +91,8 @@ struct sk_psock {
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 	struct strparser		strp;
+	u32				copied_seq;
+	u32				ingress_bytes;
 #endif
 	struct sk_buff_head		ingress_skb;
 	struct list_head		ingress_msg;
diff --git a/include/net/strparser.h b/include/net/strparser.h
index 41e2ce9e9e10..0a83010b3a64 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -43,6 +43,8 @@ struct strparser;
 struct strp_callbacks {
 	int (*parse_msg)(struct strparser *strp, struct sk_buff *skb);
 	void (*rcv_msg)(struct strparser *strp, struct sk_buff *skb);
+	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
+			 sk_read_actor_t recv_actor);
 	int (*read_sock_done)(struct strparser *strp, int err);
 	void (*abort_parser)(struct strparser *strp, int err);
 	void (*lock)(struct strparser *strp);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9b37b76e894..5a40bea15016 100644
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
@@ -2609,6 +2612,11 @@ static inline void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
 }
 #endif
 
+#ifdef CONFIG_BPF_STREAM_PARSER
+int tcp_bpf_strp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor);
+#endif /* CONFIG_BPF_STREAM_PARSER */
+
 int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
 			  struct sk_msg *msg, u32 bytes, int flags);
 #endif /* CONFIG_NET_SOCK_MSG */
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 61f3f3d4e528..2e404caf10f2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -548,7 +548,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 		if (unlikely(num_sge < 0))
 			return num_sge;
 	}
-
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	psock->ingress_bytes += len;
+#endif
 	copied = len;
 	msg->sg.start = 0;
 	msg->sg.size = copied;
@@ -1092,6 +1094,20 @@ static int sk_psock_strp_read_done(struct strparser *strp, int err)
 	return err;
 }
 
+static int sk_psock_strp_read_sock(struct strparser *strp,
+				   read_descriptor_t *desc,
+				   sk_read_actor_t recv_actor)
+{
+	struct sock *sk = strp->sk;
+
+	if (WARN_ON(!sk_is_tcp(sk))) {
+		desc->error = -EINVAL;
+		return 0;
+	}
+
+	return tcp_bpf_strp_read_sock(sk, desc, recv_actor);
+}
+
 static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 {
 	struct sk_psock *psock = container_of(strp, struct sk_psock, strp);
@@ -1136,6 +1152,7 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 
 	static const struct strp_callbacks cb = {
 		.rcv_msg	= sk_psock_strp_read,
+		.read_sock	= sk_psock_strp_read_sock,
 		.read_sock_done	= sk_psock_strp_read_done,
 		.parse_msg	= sk_psock_strp_parse,
 	};
@@ -1144,6 +1161,9 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 	if (!ret)
 		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
 
+	if (sk_is_tcp(sk))
+		psock->copied_seq = tcp_sk(sk)->copied_seq;
+
 	return ret;
 }
 
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
index 47f65b1b70ca..d303486bfc59 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -698,3 +698,44 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
 		newsk->sk_prot = sk->sk_prot_creator;
 }
 #endif /* CONFIG_BPF_SYSCALL */
+
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+int tcp_bpf_strp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
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
+	 * Also replacing ops->read_sock can't be workd without introducing
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
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 8299ceb3e373..95696f42647e 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -347,7 +347,10 @@ static int strp_read_sock(struct strparser *strp)
 	struct socket *sock = strp->sk->sk_socket;
 	read_descriptor_t desc;
 
-	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
+	if (unlikely(!sock || !sock->ops))
+		return -EBUSY;
+
+	if (unlikely(!strp->cb.read_sock && !sock->ops->read_sock))
 		return -EBUSY;
 
 	desc.arg.data = strp;
@@ -355,7 +358,10 @@ static int strp_read_sock(struct strparser *strp)
 	desc.count = 1; /* give more than one skb per call */
 
 	/* sk should be locked here, so okay to do read_sock */
-	sock->ops->read_sock(strp->sk, &desc, strp_recv);
+	if (strp->cb.read_sock)
+		strp->cb.read_sock(strp, &desc, strp_recv);
+	else
+		sock->ops->read_sock(strp->sk, &desc, strp_recv);
 
 	desc.error = strp->cb.read_sock_done(strp, desc.error);
 
@@ -468,6 +474,7 @@ int strp_init(struct strparser *strp, struct sock *sk,
 	strp->cb.unlock = cb->unlock ? : strp_sock_unlock;
 	strp->cb.rcv_msg = cb->rcv_msg;
 	strp->cb.parse_msg = cb->parse_msg;
+	strp->cb.read_sock = cb->read_sock;
 	strp->cb.read_sock_done = cb->read_sock_done ? : default_read_sock_done;
 	strp->cb.abort_parser = cb->abort_parser ? : strp_abort_strp;
 
-- 
2.43.5


