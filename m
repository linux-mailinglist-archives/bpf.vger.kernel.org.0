Return-Path: <bpf+bounces-62788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D63AFE95A
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8266B1C81779
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 12:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A282DC34E;
	Wed,  9 Jul 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d64VaCPO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDF22538F;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065286; cv=none; b=ZBHmEa9URid2z/GE6Kf28i+GLVIZ42bRuzX/5H5lCtoC8CHxyLBvsrD+Fk8pQsPH45oo4vO6ka2H05nvqxwD4bCkdGEX6HeyGGjhUPKpvPOgcFmyPZNpg53Uy6e5/lg5VGFBGYe9s0K5Q/FMkyB4X+E8+pCRT038J++dVWaVPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065286; c=relaxed/simple;
	bh=VoCxjRFxwdcHq6yIaNoIZ37DYtECkCL3JK5Kb9CAyxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T6p0nHet4lK2/5DjEsYBrjF72Oetob8EEcrnwp02728ATnLteZVPOEJqFT1c350pYNmGsYtfYVsi+9JJFBMeV1T3IqyQKT5FyWuRYV3LMlfyA7j4Tojp5I2VuR+Ff83faiTifI179tmAXbTG5TXPUOwPHLbqB12ze0/CBeLkJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d64VaCPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4A3CC4CEEF;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752065285;
	bh=VoCxjRFxwdcHq6yIaNoIZ37DYtECkCL3JK5Kb9CAyxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d64VaCPORgDRAAzf44oj/JvRqfqoCFv0beO84Gb4c7+HkWurG15FEe3ri9RMJ0D+O
	 pwwBi1klcMBEgN7/uC7Zgj4VcQ94KiWMn4yoo7yvj4ZqIUFbMBeZ6C+H/IAHTREbSJ
	 3AUQqU8IwKut9ajUWpRPn/HlP+FFMCiuE06oKRkRZgqXV4Yt+L7ttkiet3h821iETM
	 bEpzpLi/z6uxat8B8dsJEJLVt2Om2315L+A0EFVx2Pt+q0ABkwWE/e+W4T2z9uy3m0
	 A4XCDjf0LC4gkaAgZ70SIJ3PmbEUeWBT9n/WHKdyqm9cAYeI2oMAs3FQD93ljFPnkz
	 sPti1t36CLItw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9588FC83F09;
	Wed,  9 Jul 2025 12:48:05 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Wed, 09 Jul 2025 14:47:57 +0200
Subject: [PATCH bpf-next v3 1/5] net: Add splice_read to prot
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sockmap-splice-v3-1-b23f345a67fc@datadoghq.com>
References: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
In-Reply-To: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752065284; l=4154;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=MX07gpJft1w5h9XhrFFgz8O3lEqjXdCYvlOAyuF5jJw=;
 b=7e+7dZgosMa14Ks7QdouUpkxxgAByp1GnnTwqe37WK9LmQlZGpb9/ZXYaNczhnThqbjEeLgy7
 wXi0wzRgUDnBIDBd7VcIwASt/J0MqH/ExPsLBhKyQ+33wtwcysTTONy
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
index 4c37015b7cf7..4bdebcbcca38 100644
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



