Return-Path: <bpf+bounces-41492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D761F9977BC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 23:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D1D2840ED
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 21:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC671E5729;
	Wed,  9 Oct 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="zyi2nk+k"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F601E3DDA;
	Wed,  9 Oct 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510261; cv=none; b=RE+027Sgaf/A3Czv+PCihZqM6IuMDKUMnOq4hGQJRGh1jN/5Pb4sn/DPUyQ9Dfb7460IXiDsK691BQ5LvWv9Ru5/UcCAwMhQBPB6vqE38eFmuN5rUaHUoanReixBIiK8I2XaxrJCyGp3p5rU9RSAquL7ziEeronhPpSTGP3BggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510261; c=relaxed/simple;
	bh=PosfPGgyDIM+i5UuEi8vug2xXbEiZxXUq1xAS9I9CUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SocFDfZIYDmXBn/wgnKhyd14tyzXjKwFtKtzK7f8idjJ/mlxX9GN4r3OzgL3EsECgWF0odAryszWXPRdmOjiF9cmeptEvuoHUwvAGMNE4X5XSOJUFX85KZhDIGkt9NOZP7Lqs4XkMVYC/kFjjoXaBLkppUDAplAP/EaPqwgERGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=zyi2nk+k; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sye8d-001jJ1-4K; Wed, 09 Oct 2024 23:22:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=Ug7QjyOWCGYi1g6HlAzPC/m0ijYnR0+zFZeDtU2E86U=; b=zyi2nk+kbk6zLs3NO7Yws8Gpzk
	+5+K3DlCwkOvL+MctOXn48whR+dcJiWYKq+7Kv+omM0jlPxT5en4f+md5MSEWP7VShMnFfCkzBoaR
	PDcBT7bL6makSufFE5jAcYy0GrF7aBw3BDoiAC6NnHNfmHKAeLrDR/FeqBcAOvTO0YpsPxDAK6AAn
	CbLauFsAL/b2RX6SjGGpbzYliAYjcppOS7MsSXmNq4NfaAvGLh/mc53A5dZ1ecIELjaxU7mBf0H/Q
	DK+iU1ggQJJLAZL/zBIXqdNm7AeuBIvVYW/fmtDiOuV6qsjmWaJIJ5atZrKvODdVKw8nhYVlo0coK
	FYhJ9BnQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sye8c-0000IQ-RH; Wed, 09 Oct 2024 23:22:30 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sye8R-00EL6w-Ck; Wed, 09 Oct 2024 23:22:19 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 09 Oct 2024 23:20:51 +0200
Subject: [PATCH bpf 2/4] vsock: Update rx_bytes on read_skb()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-vsock-fixes-for-redir-v1-2-e455416f6d78@rbox.co>
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

Make sure virtio_transport_inc_rx_pkt() and virtio_transport_dec_rx_pkt()
calls are balanced (i.e. virtio_vsock_sock::rx_bytes doesn't lie) after
vsock_transport::read_skb().

Failing to update rx_bytes after packet is dequeued leads to a warning on
SOCK_STREAM recv():

[  233.396654] rx_queue is empty, but rx_bytes is non-zero
[  233.396702] WARNING: CPU: 11 PID: 40601 at net/vmw_vsock/virtio_transport_common.c:589

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 884ee128851e5ce8b01c78fcb95a408986f62936..ed1c1bed5700e5988a233cea146cf9fac95426e0 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1707,6 +1707,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	struct sock *sk = sk_vsock(vsk);
+	struct virtio_vsock_hdr *hdr;
 	struct sk_buff *skb;
 	int off = 0;
 	int err;
@@ -1716,10 +1717,14 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	 * works for types other than dgrams.
 	 */
 	skb = __skb_recv_datagram(sk, &vvs->rx_queue, MSG_DONTWAIT, &off, &err);
-	spin_unlock_bh(&vvs->rx_lock);
-
-	if (!skb)
+	if (!skb) {
+		spin_unlock_bh(&vvs->rx_lock);
 		return err;
+	}
+
+	hdr = virtio_vsock_hdr(skb);
+	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
+	spin_unlock_bh(&vvs->rx_lock);
 
 	return recv_actor(sk, skb);
 }

-- 
2.46.2


