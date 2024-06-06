Return-Path: <bpf+bounces-31486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689718FE2D6
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 11:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B8B285FAA
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8E178386;
	Thu,  6 Jun 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STg92nVd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A315357D;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666083; cv=none; b=MqW0mvYgPA6ENggmB43Y9MS222Bot3lM4sZz6kzIzbqPjQExJVmgf/L07sILLqi6Mw88MkDsL6W/3vya/D1va/fYBXTVy8InWfZ9E03ElGge/WfKjaKmZUQAyZIwbJ+CPpSJ8Q4/4TjehMVVXcCCaxQZ4MPimcYJwcz1F2WtQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666083; c=relaxed/simple;
	bh=NTLo/DeCQrzRkSDk9d2g9xUC7MUum/PNEd2yE6X68rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qdZuAAK5VIG256CaoiyW8giqPmDE0HC0iNJLnJ/zuG2T0x9vfEzxmIpxMrLrigYAvEWBbavdz8xvBCBzT811v5i27aXwZMd0+RTKhD5t94lVLjomMxBcWstShFMb+6wOfwGPTB3+e/UGodj258G65uemtoQheN1h/ryA6+lUVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STg92nVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0457C4AF48;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717666082;
	bh=NTLo/DeCQrzRkSDk9d2g9xUC7MUum/PNEd2yE6X68rY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=STg92nVd11OLwHySKA8nDsZ82krGrS0vJiUcjVYIV20AfrZtdJ8oIfB7cLnCoP7cP
	 iEXz56sMbSljR6B04u1/TuzopyB3abTC/QLP6IixD70KgM315duZyXwS6WxcgFXloD
	 QKJwAhfv4jP0BoYNkx5e+mcea6rUUlJfN8Cr23wSU16CH68V9tujF7xQYmE2vc/e/C
	 psQFeQ49682FOmScmB9adgJGqXMdwx7vTQyTIo4pC0US9Bb44fs5V9q7FTnlexaM7/
	 eRnVEzhqBT4qVlCjUgJnC1DTw/lochwOJ96bGK5b2tdU5IV+mFhkCczZBCLby+kHL+
	 bPPn0fuUaEgjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31C4C27C65;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Date: Thu, 06 Jun 2024 11:27:53 +0200
Subject: [PATCH bpf-next 2/5] tcp_bpf: Fix reading with splice(2)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-sockmap-splice-v1-2-4820a2ab14b5@datadoghq.com>
References: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
In-Reply-To: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717666080; l=2078;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=5PmgjmTWmIzMNFgYReeAdud4lLNptj4DS+QjXHC8+WA=;
 b=2u2whfWpWnMmKOgp3FMBDdS8cHVHB/yT0iLHNlIlhWwau7LT5upeZUbJwyjeMQD0FUHbqZojE
 wbi4DLbVaqNAcllN0lqZaJTysCj94AbTHEGkd4/8ezpIfR/vT7Z/3Zl
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
index 53b0d62fd2c2..b7c110dedd35 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -3,6 +3,7 @@
 
 #include <linux/skmsg.h>
 #include <linux/filter.h>
+#include <linux/fs.h>
 #include <linux/bpf.h>
 #include <linux/init.h>
 #include <linux/wait.h>
@@ -378,6 +379,13 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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



