Return-Path: <bpf+bounces-31489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D407D8FE2D9
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 11:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B3B283D3D
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2E178CC4;
	Thu,  6 Jun 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/w/T9mZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE2153821;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666083; cv=none; b=cGthl8DMGSTkoSJgfizd34cdUDapls+r/38uxoAvKLLrN0UAkBfiTrsjjGD8XEKXzbo9IqItJ+x1OJN08KP9RCOo9PNarcuKp4m8UAhj40s+Up+RGYMiDpjsWpHl7H2rspSzNyUUX6ZhYsIPz/BH7AKhmpZ/SbC3b6Rf7oZa3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666083; c=relaxed/simple;
	bh=jTAuNzNjM4epWY5GlgPSmj6dPtkN7YNSyxEk0NTyXYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2lalljdTx2MSGO71Q/jpqmIgavGF1JZtPrO6tUivh5s9Q4+4fyVEfIi6LTodGj26S0WgfnskD6CYbzPxkBtEYhSnIL2RpgFkYa4m7NSLS73zmCINAmJc7XW35VbBnAUFi5F5YTGsZtqlHSQm+lmKk3nOT/qOgz1/4M3EEeyO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/w/T9mZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B48ECC4AF09;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717666082;
	bh=jTAuNzNjM4epWY5GlgPSmj6dPtkN7YNSyxEk0NTyXYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d/w/T9mZH5AQmUDKy/5lxs+S4speiX7oeOsY+qBNq7xEiSjN0+ZKTxcGe3guFn+Ef
	 Bb6xtzv4gtLFmnr65erXY6bZGqAYEpgMbaJEs/zB3ugmzhDBI296mWCgQJAiCtSKAO
	 cS3rAn0tiGJSmSxnBwlDnYownzQ2HfofnvyTT4HGqTuMYdGx2jAW3IJJ93868uJD+a
	 0ycIdOyd1/sBXMT7vVyP7iKuvP79kpT6GYfLIxwrD9bZOWx/LZTHuSZefz5HAMxtdY
	 x+X1fI6NckPiQPR1Yr+pFaptZ/GnDY29woR6cYsjOQTQ3ltKB5FhV0OYJheEN6d3dl
	 VzI3KAYTV1Syg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2010C27C5E;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Thu, 06 Jun 2024 11:27:52 +0200
Subject: [PATCH bpf-next 1/5] net: Add splice_read to prot
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-sockmap-splice-v1-1-4820a2ab14b5@datadoghq.com>
References: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
In-Reply-To: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717666080; l=4514;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=pZE9EinrT662tvpjfHQU0BTohLUXGfT+F7BHx9Lnoqo=;
 b=lOfhiCUyWo3Un4cwL+KUmsxVMiglFpZb9vwVMTXMx+9Zbp/6/FB9vaGLU5mfwycDkQu6ipguo
 6oIhB1jWHdICgJfTdhUE3g9Ic+Iwc0S7BH5P28PgEsJJd+batWbQMU+
X-Developer-Key: i=vincent.whitchurch@datadoghq.com; a=ed25519;
 pk=GwUiPK96WuxbUAD4UjapyK7TOt+aX0EqABOZ/BOj+/M=
X-Endpoint-Received: by B4 Relay for
 vincent.whitchurch@datadoghq.com/20240606 with auth_id=170
X-Original-From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Reply-To: vincent.whitchurch@datadoghq.com

From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>

The TCP BPF code will need to override splice_read(), so add it to prot.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
---
 include/net/inet_common.h |  3 +++
 include/net/sock.h        |  3 +++
 net/ipv4/af_inet.c        | 18 +++++++++++++++++-
 net/ipv4/tcp_ipv4.c       |  1 +
 net/ipv6/af_inet6.c       |  2 +-
 net/ipv6/tcp_ipv6.c       |  1 +
 6 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index c17a6585d0b0..2a6480d0d575 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -35,6 +35,9 @@ void __inet_accept(struct socket *sock, struct socket *newsock,
 		   struct sock *newsk);
 int inet_send_prepare(struct sock *sk);
 int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size);
+ssize_t inet_splice_read(struct socket *sk, loff_t *ppos,
+			 struct pipe_inode_info *pipe, size_t len,
+			 unsigned int flags);
 void inet_splice_eof(struct socket *sock);
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags);
diff --git a/include/net/sock.h b/include/net/sock.h
index 5f4d0629348f..a152552a64a5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1238,6 +1238,9 @@ struct proto {
 					   size_t len);
 	int			(*recvmsg)(struct sock *sk, struct msghdr *msg,
 					   size_t len, int flags, int *addr_len);
+	ssize_t			(*splice_read)(struct socket *sock,  loff_t *ppos,
+					       struct pipe_inode_info *pipe, size_t len,
+					       unsigned int flags);
 	void			(*splice_eof)(struct socket *sock);
 	int			(*bind)(struct sock *sk,
 					struct sockaddr *addr, int addr_len);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index e03ba4a21c39..c9a23296ac82 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -870,6 +870,21 @@ void inet_splice_eof(struct socket *sock)
 }
 EXPORT_SYMBOL_GPL(inet_splice_eof);
 
+ssize_t inet_splice_read(struct socket *sock, loff_t *ppos,
+			 struct pipe_inode_info *pipe, size_t len,
+			 unsigned int flags)
+{
+	const struct proto *prot;
+	struct sock *sk = sock->sk;
+
+	prot = READ_ONCE(sk->sk_prot);
+	if (prot->splice_read)
+		return prot->splice_read(sock, ppos, pipe, len, flags);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(inet_splice_read);
+
 INDIRECT_CALLABLE_DECLARE(int udp_recvmsg(struct sock *, struct msghdr *,
 					  size_t, int, int *));
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
@@ -1073,7 +1088,7 @@ const struct proto_ops inet_stream_ops = {
 	.mmap		   = tcp_mmap,
 #endif
 	.splice_eof	   = inet_splice_eof,
-	.splice_read	   = tcp_splice_read,
+	.splice_read	   = inet_splice_read,
 	.set_peek_off      = sk_set_peek_off,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
@@ -1107,6 +1122,7 @@ const struct proto_ops inet_dgram_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.splice_eof	   = inet_splice_eof,
+	.splice_read	   = inet_splice_read,
 	.set_peek_off	   = udp_set_peek_off,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet_compat_ioctl,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8f70b8d1d1e5..c9715d4be30d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3343,6 +3343,7 @@ struct proto tcp_prot = {
 	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
+	.splice_read		= tcp_splice_read,
 	.splice_eof		= tcp_splice_eof,
 	.backlog_rcv		= tcp_v4_do_rcv,
 	.release_cb		= tcp_release_cb,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 8041dc181bd4..c41aef88ae8b 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -707,7 +707,7 @@ const struct proto_ops inet6_stream_ops = {
 #endif
 	.splice_eof	   = inet_splice_eof,
 	.sendmsg_locked    = tcp_sendmsg_locked,
-	.splice_read	   = tcp_splice_read,
+	.splice_read	   = inet_splice_read,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
 	.peek_len	   = tcp_peek_len,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 750aa681779c..45198bac1bc9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2340,6 +2340,7 @@ struct proto tcpv6_prot = {
 	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
+	.splice_read		= tcp_splice_read,
 	.splice_eof		= tcp_splice_eof,
 	.backlog_rcv		= tcp_v6_do_rcv,
 	.release_cb		= tcp_release_cb,

-- 
2.34.1



