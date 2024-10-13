Return-Path: <bpf+bounces-41830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7B999BA5A
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 18:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F32BB2142F
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115BD1487ED;
	Sun, 13 Oct 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="yhHE+Jqm"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19362145B0C
	for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728836844; cv=none; b=lmjmwUi9XEqrD3+URtZZUTuqNQeOgPYKIuSGo685FasVsIYJPBG8GT9LuJr+Pnj07RAmIXTsbsTxuFjIoZEvUsF71R329a0W7boPfIJVPTCAGOoxpnNHRCDAv2yyzvD8VW+XKERaqggHK1yk/HEF2g+0U+S3epFlQIQ65hlOkMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728836844; c=relaxed/simple;
	bh=e3SrNTsK0dGD9xesl4OQqQipb7Tulhm6OyotiGyjymc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gop0ylNckG8NPTibkw+JKzIWdoed06No7X/mp4moisB0cbLdnz2s4uiRUKp0nay584gIBfZ/TCAl/oFr6ZWF9BRZQC24bAc3dJt5rsrz5dGdmv3zWoXuDsMUz8KPYWJ89p4OnjjoAtIrEx5Q8TKYlwnH+efJjJeJWA+4ZZlCHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=yhHE+Jqm; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1t01R6-00CydY-QE; Sun, 13 Oct 2024 18:27:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=F+RJd+JIpP4NiuqPuwFGdxJw5I73YccdWoYTGb3P+Vo=; b=yhHE+JqmMpgEhQ3KhAvJUPSfr6
	2dc6qE/7Y6UX7ylRucZ1qHklE3xOJ6oqBYbL5LmB3tl2WHaQ6VLBCVq6FnzLdggz9gcon/eYsTjp2
	y8o2xcnE5ulzQgGEGmVm5P5yck/06B5JXJg1+Sb/phghMZtXVCwfae+XJjEaPnRXlrngR3mupRZNF
	nwyCfy9obsTCKP2jS0Oy0xWD2aJNn8ACCNfksbUPeqgvVX3QIk0EUb8h6dVzvJog2q5rTxnFnEHoa
	C5cO8pR8vizF1D3waghnnSd22Hd7335AOI/g/yNniF/gMHCu7o7/aqTTb1+MsfEP8WnFZSdybHrWM
	wv3b8F8g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1t01R1-0007iv-AC; Sun, 13 Oct 2024 18:27:11 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1t01Qh-00GV5b-Sn; Sun, 13 Oct 2024 18:26:51 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Sun, 13 Oct 2024 18:26:42 +0200
Subject: [PATCH bpf v2 4/4] bpf, vsock: Drop static vsock_bpf_prot
 initialization
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-vsock-fixes-for-redir-v2-4-d6577bbfe742@rbox.co>
References: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
In-Reply-To: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
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


