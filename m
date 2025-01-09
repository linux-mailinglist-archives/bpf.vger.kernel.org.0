Return-Path: <bpf+bounces-48352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B450BA06C6C
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 04:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2EF1889992
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B517B500;
	Thu,  9 Jan 2025 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iAL/V3oz"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBD9156220;
	Thu,  9 Jan 2025 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394157; cv=none; b=opmPASbB1qYxcPRucaMueK3w8MjPytRBOuaVPnfDYdAiyvpklf9WgdJvfdyloKxxOEFFbNvMjPG0IaVs3d7fW7Nvw2kQ3SuclxZ7A6BKVkfhXHjLAFJgJ57MVeqhQlJn7/V+93ZDi0w48Q7noka0KpetzYeZjJPj5Q0iQaksAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394157; c=relaxed/simple;
	bh=z2xYO3y0igCEfiNwdk+8R6FcPF4v8W49Riu/f4H1nVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNDrn8GtgN0G7G4KAYDTHM0jTVhzdc8iFCUOymYt/PqAPl9oyNm5aEStj1xV1tkUHF7Mk1NLGLDJ9ADeHiGdwCVNH8bPx/ORXsLsA/Ee+TPC9VxlBuIafDbHSgEgalI2Ttl1LJ3uySRvum5ETcZD5frnJzC4vLs/l8U4eTzcfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iAL/V3oz; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=moooB
	DRrJ7DU5gYDSQRR/sXA2phBdA5xm1asQaYoUco=; b=iAL/V3ozLsGTf+vpAFAZh
	maRkK9HOa9Ols4PLr3/1eHVuDBOkEDzIR3FMJlgoskAIpXx7GGTUdbovAY1A1Lip
	qxK8gZjC4QdY2mNJC6KT7tf450lhZKeAJ+oALX5C0A/0U019g3JmGaWL/G9qinoK
	p56HvqP6P4nGOAPXItZRZw=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXYaYcRX9na6O1Jw--.42275S3;
	Thu, 09 Jan 2025 11:40:34 +0800 (CST)
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
Subject: [PATCH bpf v4 1/3] bpf: fix wrong copied_seq calculation
Date: Thu,  9 Jan 2025 11:40:03 +0800
Message-ID: <20250109034005.861063-2-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250109034005.861063-1-mrpre@163.com>
References: <20250109034005.861063-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXYaYcRX9na6O1Jw--.42275S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxKryrKFWrGF4UJry7tw1xuFg_yoWfZr1kpF
	1DA3yrGr47JFy7u3Z3Ar97Gr4agw4rKFW7Cry0v3yayrn7Kr1fXF95KF1ayF1UKr45ZFW3
	tr4DWw43uw1DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piWSoJUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwPPp2d-PonN1wAAsR

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

[1]: https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com
Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Co-developed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 include/linux/skmsg.h     |  2 ++
 include/net/strparser.h   |  2 ++
 include/net/tcp.h         |  3 +++
 net/core/skmsg.c          | 42 +++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c            | 31 ++++++++++++++++++++++++-----
 net/strparser/strparser.c | 11 ++++++++--
 6 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 2cbe0c22a32f..ed1fdb0aa044 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -85,6 +85,8 @@ struct sk_psock {
 	struct sock			*sk_redir;
 	u32				apply_bytes;
 	u32				cork_bytes;
+	u32				copied_seq;
+	u32				ingress_bytes;
 	u32				eval;
 	bool				redir_ingress; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
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
index e9b37b76e894..36db593984eb 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -729,6 +729,9 @@ void tcp_get_info(struct sock *, struct tcp_info *);
 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		  sk_read_actor_t recv_actor);
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, u32 noack,
+			u32 *copied_seq);
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq, u32 *off);
 void tcp_read_done(struct sock *sk, size_t len);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 61f3f3d4e528..c21c6886f747 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -549,6 +549,7 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 			return num_sge;
 	}
 
+	psock->ingress_bytes += len;
 	copied = len;
 	msg->sg.start = 0;
 	msg->sg.size = copied;
@@ -1092,6 +1093,43 @@ static int sk_psock_strp_read_done(struct strparser *strp, int err)
 	return err;
 }
 
+static int sk_psock_strp_read_sock(struct strparser *strp,
+				   read_descriptor_t *desc,
+				   sk_read_actor_t recv_actor)
+{
+	struct sock *sk = strp->sk;
+	struct sk_psock *psock;
+	struct tcp_sock *tp;
+	int copied;
+
+	if (WARN_ON(!sk_is_tcp(sk)))
+		return -EOPNOTSUPP;
+
+	/* caller already checked sk/psock != NULL */
+	tp = tcp_sk(sk);
+	psock = sk_psock(sk);
+	psock->ingress_bytes = 0;
+	/* We could easily add copied_seq and noack into desc then call
+	 * ops->read_sock without calling symbol directly. But unfortunately
+	 * most descriptors used by other modules are not inited with zero.
+	 * Also replacing ops->read_sock can't be workd without introducing
+	 * new ops as ops itself is located in rodata segment.
+	 */
+	copied = tcp_read_sock_noack(sk, desc, recv_actor, 1,
+				     &psock->copied_seq);
+	if (copied < 0)
+		return copied;
+	/* recv_actor may redirect skb to another socket(SK_REDIRECT) or
+	 * just put skb into ingress queue of current socket(SK_PASS).
+	 * For SK_REDIRECT, we need 'ack' the frame immediately but for
+	 * SK_PASS, the 'ack' was delay to tcp_bpf_recvmsg_parser()
+	 */
+	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
+	tcp_rcv_space_adjust(sk);
+	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
+	return copied;
+}
+
 static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 {
 	struct sk_psock *psock = container_of(strp, struct sk_psock, strp);
@@ -1136,6 +1174,7 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 
 	static const struct strp_callbacks cb = {
 		.rcv_msg	= sk_psock_strp_read,
+		.read_sock	= sk_psock_strp_read_sock,
 		.read_sock_done	= sk_psock_strp_read_done,
 		.parse_msg	= sk_psock_strp_parse,
 	};
@@ -1144,6 +1183,9 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 	if (!ret)
 		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
 
+	if (sk_is_tcp(sk))
+		psock->copied_seq = tcp_sk(sk)->copied_seq;
+
 	return ret;
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..32de16077ca7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1565,12 +1565,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
  *	  or for 'peeking' the socket using this routine
  *	  (although both would be easy to implement).
  */
-int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
-		  sk_read_actor_t recv_actor)
+static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor, u32 noack,
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
 
@@ -1635,10 +1639,27 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
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
+	return __tcp_read_sock(sk, desc, recv_actor,
+			       0, &tcp_sk(sk)->copied_seq);
+}
 EXPORT_SYMBOL(tcp_read_sock);
 
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, u32 noack,
+			u32 *copied_seq)
+{
+	return __tcp_read_sock(sk, desc, recv_actor,
+			       noack, copied_seq);
+}
+EXPORT_SYMBOL(tcp_read_sock_noack);
+
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
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


