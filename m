Return-Path: <bpf+bounces-60046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEEAAD1ECD
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3761416B466
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22969259CBD;
	Mon,  9 Jun 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhX9nzl7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42A258CD7;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475633; cv=none; b=C7g/ZWFOLIIvLUNYyw5p/jxFPNsQzzqhBT2vWqka+OpcFDp/hWhzMlifuMhV3ZI8lD9+GSBhjWeIjEij+oJzlna6aLN2JTjuIniuLu4ij1GthSY7HTVC3ttiOfcEHOePFnH7PINmjcucMNjKS3ImwsYaWlp8oXBkUdKCmUY8AbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475633; c=relaxed/simple;
	bh=bd28RMDpVZQPO8zhiZL5alci1mmKQS6KkrFNkLukEI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rY1ff3J00tPL6K6tkBmpE2gWkyN7lPdJOfoDwaEeik3M05woRdhdHg7hA/IoYYocqfZGy3xSzQSR2OrV3nEZwxBjAN9S804fgxMj/vuKJEBJ3EBK6q1yCzRFbbQisHzd+flOcqeL7WooyAvJ4KuQ51/aFRx+q/rVh/CmTfosfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhX9nzl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7640EC4CEF3;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749475633;
	bh=bd28RMDpVZQPO8zhiZL5alci1mmKQS6KkrFNkLukEI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rhX9nzl7v5hrtSjpnpjlAZdEXVKxofaGMDUxKi5MXWYIPqGQXH2CJ/BzlJTixsRYL
	 rJBRZgYCCjwnaShbVjDZfJQSiISN+tjR60FTZmLUbxcsNOgl2ywlp+PN67dTxJx7L6
	 998hOThYjOR7LbLrCpvNy/ZHJTfSS8O3+nuK6BopsRtozmvDjVYSTBHYi715cg+usB
	 t31NgY9+h71jwthuJiX7qVtGESBoGd+2NHgld7Na+r+O0e0sbDM6XYag8hv4MLYPk+
	 SYWb2D2KtpEJTbEEnsOMnoFpcq9b7C36ZSweFq0s/DaqLA41w5bCuyLEdVCRQRC50O
	 sXRtAW0nR2c7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C37C5B552;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Mon, 09 Jun 2025 15:26:58 +0200
Subject: [PATCH bpf-next v2 1/5] net: Add splice_read to prot
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-sockmap-splice-v2-1-9c50645cfa32@datadoghq.com>
References: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
In-Reply-To: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749475632; l=4154;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=cZsozpxhkHWdF5SCnmLFOr3YmMAJh8ZPo6yVbnm/VOQ=;
 b=Fz1X1XBvaQUC7BbXyXyvb3GWOf3D5G+Pzs81CoaKWMe4hxU6lEjFcydER5BouZ0j6pf8gQ/mq
 ZzzI+y6+08AATmdSdwohuze62cUIlpZWp8CnP28MiNoZG14nxZN+Y20
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
 net/ipv4/af_inet.c        | 13 ++++++++++++-
 net/ipv4/tcp_ipv4.c       |  1 +
 net/ipv6/af_inet6.c       |  2 +-
 net/ipv6/tcp_ipv6.c       |  1 +
 6 files changed, 21 insertions(+), 2 deletions(-)

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
index 92e7c1aae3cc..08f0acf1fce4 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1280,6 +1280,9 @@ struct proto {
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
index 76e38092cd8a..9c521d252f66 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -868,6 +868,17 @@ void inet_splice_eof(struct socket *sock)
 }
 EXPORT_SYMBOL_GPL(inet_splice_eof);
 
+ssize_t inet_splice_read(struct socket *sock, loff_t *ppos,
+			 struct pipe_inode_info *pipe, size_t len,
+			 unsigned int flags)
+{
+	struct sock *sk = sock->sk;
+
+	return INDIRECT_CALL_1(sk->sk_prot->splice_read, tcp_splice_read, sock,
+			       ppos, pipe, len, flags);
+}
+EXPORT_SYMBOL_GPL(inet_splice_read);
+
 INDIRECT_CALLABLE_DECLARE(int udp_recvmsg(struct sock *, struct msghdr *,
 					  size_t, int, int *));
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
@@ -1071,7 +1082,7 @@ const struct proto_ops inet_stream_ops = {
 	.mmap		   = tcp_mmap,
 #endif
 	.splice_eof	   = inet_splice_eof,
-	.splice_read	   = tcp_splice_read,
+	.splice_read	   = inet_splice_read,
 	.set_peek_off      = sk_set_peek_off,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..0391b6bef35b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3375,6 +3375,7 @@ struct proto tcp_prot = {
 	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
+	.splice_read		= tcp_splice_read,
 	.splice_eof		= tcp_splice_eof,
 	.backlog_rcv		= tcp_v4_do_rcv,
 	.release_cb		= tcp_release_cb,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index acaff1296783..2d6a1d669452 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -705,7 +705,7 @@ const struct proto_ops inet6_stream_ops = {
 #endif
 	.splice_eof	   = inet_splice_eof,
 	.sendmsg_locked    = tcp_sendmsg_locked,
-	.splice_read	   = tcp_splice_read,
+	.splice_read	   = inet_splice_read,
 	.set_peek_off      = sk_set_peek_off,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e8e68a142649..f7558e443de6 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2342,6 +2342,7 @@ struct proto tcpv6_prot = {
 	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
+	.splice_read		= tcp_splice_read,
 	.splice_eof		= tcp_splice_eof,
 	.backlog_rcv		= tcp_v6_do_rcv,
 	.release_cb		= tcp_release_cb,

-- 
2.34.1



