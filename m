Return-Path: <bpf+bounces-41493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638079977C4
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 23:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932F21C224F7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 21:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51E41E132D;
	Wed,  9 Oct 2024 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lx3Sij3P"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132710E4;
	Wed,  9 Oct 2024 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510410; cv=none; b=Io6k1mzD3MXZx3HQpu5V0Lg0NgB4Jjlm+LAJa0yQcE5MYJP16jcRDJGuBkVyFZJOLE5RlYLZn1vnVYH2rlXwh8wPwFDVvB+SAdVEHIQRs4oNE+uuGNQa2/Hils7CUKmUk/zTD0A+VmK1fjhHUlkaEwOzFuuHubdyd3lGyaVZwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510410; c=relaxed/simple;
	bh=e3SrNTsK0dGD9xesl4OQqQipb7Tulhm6OyotiGyjymc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AD+Ye5FaKEQwsWNstJMxHFeA9yrRR+XyIjvOyXcm02CyayRnASj2lksCocLpNdPyg5WuCqmUushjbWuOR46KfaW3cNGlacJEckpfWPYFrCX7n7Ogb2iNzQFkeDojVd+o7dZeNVv8myq7yDrttWV924pxcReS2I67lM6t+4PP8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lx3Sij3P; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sye8e-001i73-AQ; Wed, 09 Oct 2024 23:22:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=F+RJd+JIpP4NiuqPuwFGdxJw5I73YccdWoYTGb3P+Vo=; b=lx3Sij3PRHC9LVPPD2VBO1LF6W
	YScFaPpOmYXnga6tKXoPUsc3aWpaaDeRYB2mMJgsEgXUL03orAgB5geetyqDbDQ2zc2EI+ePU5Rwd
	sbJrBtP/QwxBp7lbLF/8bfwytr5T68ZiEluzLwdSmblSo9vqA7eazq+G+uORbIzvrU0x6zYxfN5g+
	ZsPLMf2rgA8Yc/E+CnMiyle2e3EY/esZ+Ia7yl7lWpmNumaA2BponFJwYGY5RDBV/8TCYe32npQ+E
	b5ri6i4Miu8EtmLqzHZYkU9tMtzZQYMLWXWcth/vcLlNqR4v78JDhG4zI54YKNRrkj4fxmUs/VVAW
	M+ebBXhw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sye8d-0004h3-PV; Wed, 09 Oct 2024 23:22:32 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sye8S-00EL6w-Il; Wed, 09 Oct 2024 23:22:20 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 09 Oct 2024 23:20:53 +0200
Subject: [PATCH bpf 4/4] bpf, vsock: Drop static vsock_bpf_prot
 initialization
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-vsock-fixes-for-redir-v1-4-e455416f6d78@rbox.co>
References: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
In-Reply-To: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

vsock_bpf_prot is set up at runtime. Remove the superfluous init.

No functional change intended.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/vsock_bpf.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index c42c5cc18f324108e044772e957c8d42c92ead8c..4aa6e74ec2957b28b9e9d8ce0b5f4d5c289a9276 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -114,14 +114,6 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	return copied;
 }
 
-/* Copy of original proto with updated sock_map methods */
-static struct proto vsock_bpf_prot = {
-	.close = sock_map_close,
-	.recvmsg = vsock_bpf_recvmsg,
-	.sock_is_readable = sk_msg_is_readable,
-	.unhash = sock_map_unhash,
-};
-
 static void vsock_bpf_rebuild_protos(struct proto *prot, const struct proto *base)
 {
 	*prot        = *base;

-- 
2.46.2


