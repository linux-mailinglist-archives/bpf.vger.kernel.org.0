Return-Path: <bpf+bounces-60047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1570BAD1ED0
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 15:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6594616B9B9
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F15925A2CF;
	Mon,  9 Jun 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/zNU+s8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321A259C80;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475634; cv=none; b=P9XuRTTjpqe3YcnsfuxBOvkaZ/4YqyNLrjGBQfaCXNZrOsMvz1f//CnmiOtDlX0QsrWM2Vu7YVA12YIIlop+8kGcTfTc58hlWdgRbk0+Pp3QM0/sIvyC/GZdBBTxoDqksm+L+EK9ZXJXtg5WXqKB85dahJWgnUdiyXPErXsTerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475634; c=relaxed/simple;
	bh=LLq14NfQ6qP1jqDAZlejPOC5EKe/uhtCVVfk2KqwqLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MD2nI3sOc6qPoY8UnE8iRTBdLb5xUtiINpf15jKQj1oGgxaR5vpr+de1GYRhXi6rI8+2HSQq/GpVn0f3IP6pN1Kv50odqgOFqOnrPgnIextuBjxnOBt4SBD9ezaZgQRp68gs1yqX4DyvPK2N63cJ9cjG62xUoXnABkhGn6ZuK3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/zNU+s8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CD6BC4CEF5;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749475633;
	bh=LLq14NfQ6qP1jqDAZlejPOC5EKe/uhtCVVfk2KqwqLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n/zNU+s8V4+kYjUUf3cLXTgQuy0xWEPJt35QntpQf/eI9fAd16PcCTWYkoI2Yz9Aa
	 TaoLYH9brbjXkoFU/Rs6IWDZLtHY++TXerZ2KiF5PQqgG+Es9+7VSkl079eQpTl6ip
	 8JKrP9Ar8s1kNV4ZEeWqdUSl2O4Kue1R56vCTCNe8CRc+k8L2ERw393d8S8R+3pbaE
	 KZlQGeeUT4fmSTKXehq0O8k0ZvTuYfZntMcxau6bTRjSYV25FYoNaXScVERuLLLAew
	 fs8g0iD+pWVdj96wgK0JCEZrrhIGdAFbNMsxDVEcJN4Y0o3u10hpKYom+5HC/ooheY
	 IztyCWPN1LFcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7732AC67861;
	Mon,  9 Jun 2025 13:27:13 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Mon, 09 Jun 2025 15:26:59 +0200
Subject: [PATCH bpf-next v2 2/5] tcp_bpf: Fix reading with splice(2)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-sockmap-splice-v2-2-9c50645cfa32@datadoghq.com>
References: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
In-Reply-To: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749475632; l=2078;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=InhXGybr0db9Lk1NjNwJ/NeOyi7WHVAFjgQS5ZRfqY4=;
 b=oJ8HXYLPWoZXO7csNkUjoLc+mB71mQ0eZWRdwED+DnqRzstVaPf+M/+5niNZtws0ZGhgtKPr9
 yEyn6RRwrweDf4lAKGb0ryDSwgG90Z61YnRN7s+8T5Lo0xgg03fIKPn
X-Developer-Key: i=vincent.whitchurch@datadoghq.com; a=ed25519;
 pk=GwUiPK96WuxbUAD4UjapyK7TOt+aX0EqABOZ/BOj+/M=
X-Endpoint-Received: by B4 Relay for
 vincent.whitchurch@datadoghq.com/20240606 with auth_id=170
X-Original-From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Reply-To: vincent.whitchurch@datadoghq.com

From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>

If a socket is added to a sockmap with a verdict program which returns
SK_PASS, splice(2) is not able to read from the socket.

The verdict code removes skbs from the receive queue, checks them using
the bpf program, and then re-queues them onto a separate queue
(psock->ingress_msg).  The sockmap code modifies the TCP recvmsg hook to
check this second queue also so that works. But the splice_read hooks is
not modified and the default tcp_read_splice() only reads the normal
receive queue so it never sees the skbs which have been re-queued.

Fix it by using copy_splice_read() when replacing the proto for the
sockmap.  This could eventually be replaced with a more efficient custom
version.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
---
 net/ipv4/tcp_bpf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ba581785adb4..197429b6adae 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -3,6 +3,7 @@
 
 #include <linux/skmsg.h>
 #include <linux/filter.h>
+#include <linux/fs.h>
 #include <linux/bpf.h>
 #include <linux/init.h>
 #include <linux/wait.h>
@@ -381,6 +382,13 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	return ret;
 }
 
+static ssize_t tcp_bpf_splice_read(struct socket *sock, loff_t *ppos,
+				   struct pipe_inode_info *pipe, size_t len,
+				   unsigned int flags)
+{
+	return copy_splice_read(sock->file, ppos, pipe, len, flags);
+}
+
 static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 				struct sk_msg *msg, int *copied, int flags)
 {
@@ -605,6 +613,7 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 	prot[TCP_BPF_BASE].destroy		= sock_map_destroy;
 	prot[TCP_BPF_BASE].close		= sock_map_close;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
+	prot[TCP_BPF_BASE].splice_read		= tcp_bpf_splice_read;
 	prot[TCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
 
 	prot[TCP_BPF_TX]			= prot[TCP_BPF_BASE];

-- 
2.34.1



