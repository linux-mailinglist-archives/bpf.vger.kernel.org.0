Return-Path: <bpf+bounces-41832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD02699BA5D
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 18:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9349F1F213F8
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD341487E9;
	Sun, 13 Oct 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QuMww5de"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0214883B
	for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728836846; cv=none; b=DfEVvF7UyHzD7eXLm1eUKPlJL0H+mQDyg/Jornp0L6tePIsL4x1Qf8LkvH/QzKJqW2iWzRa0gUchXpcnOM9IDY+GjXFsBPDXjTefXMPkJoM0A3DgPqeOCSIRzXgMGjSSZLcW3OT0JCBnpB1eUDWxwoYPJm55KQDk0Xrnx3a6SCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728836846; c=relaxed/simple;
	bh=c8urhhkrh3im84WiUJdBLGvYIXdINOiccvuzrfKAq5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ao9uJVwR4Nm6R/yXUtjdp688GbVxkp1GdzweP3x34VMw2MPQ9O6tFBc0OTyFRdg7/4A+L2vpLQ7HUii11SSIRtg8VR0W/tWiHgGKQ3wYcPs7SCZ18bzHCwKg7qPPEk8SUeZoG8FX8jnSgIghza0HdcCnCpoy00MjOEWAqHRno6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QuMww5de; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1t01R0-00Cycr-2p; Sun, 13 Oct 2024 18:27:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=su6GWJCFM6wUFDXNdQn8Littg9ARRWP/+CEhpq66KDM=; b=QuMww5deJ0EyJiNlfwMgJq3T6u
	mF+6/lzDaje+9VgpdTNVnIpsKzfKpSYMn/ern8btp7/HQCh2qgpZnsPuFgKygjP2TS3zaNl66CmBf
	pC3m64MGyu22wmfABfn51JWpHt4m5/bDpoHfq0qmaas0RSoLH5rzOCn3SnFGsJTBwljWpeWtpLh2i
	rULpkJ2Bi6+IkIJafRaQRKMxfkvUT3cMsf0eD7kVQcVKlz1tjxa8SSZq+ca0hFo/qKSxLQJhMs/Iz
	YTXLnVlXj8sOYp7HFtqC0mrJ1UwUT/j1+jMhmecSavZVisAMOkwLZJ2G1IcFGp/GW1bRbxtUO+1Ml
	uqmVTJDA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1t01Qy-0007ie-S9; Sun, 13 Oct 2024 18:27:08 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1t01Qg-00GV5b-MY; Sun, 13 Oct 2024 18:26:50 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Sun, 13 Oct 2024 18:26:40 +0200
Subject: [PATCH bpf v2 2/4] vsock: Update rx_bytes on read_skb()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-vsock-fixes-for-redir-v2-2-d6577bbfe742@rbox.co>
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

Make sure virtio_transport_inc_rx_pkt() and virtio_transport_dec_rx_pkt()
calls are balanced (i.e. virtio_vsock_sock::rx_bytes doesn't lie) after
vsock_transport::read_skb().

While here, also inform the peer that we've freed up space and it has more
credit.

Failing to update rx_bytes after packet is dequeued leads to a warning on
SOCK_STREAM recv():

[  233.396654] rx_queue is empty, but rx_bytes is non-zero
[  233.396702] WARNING: CPU: 11 PID: 40601 at net/vmw_vsock/virtio_transport_common.c:589

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/virtio_transport_common.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 884ee128851e5ce8b01c78fcb95a408986f62936..2e5ad96825cc0988c9e1b3f8a8bfcff2ef00a2b2 100644
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
@@ -1716,10 +1717,16 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	 * works for types other than dgrams.
 	 */
 	skb = __skb_recv_datagram(sk, &vvs->rx_queue, MSG_DONTWAIT, &off, &err);
+	if (!skb) {
+		spin_unlock_bh(&vvs->rx_lock);
+		return err;
+	}
+
+	hdr = virtio_vsock_hdr(skb);
+	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
 	spin_unlock_bh(&vvs->rx_lock);
 
-	if (!skb)
-		return err;
+	virtio_transport_send_credit_update(vsk);
 
 	return recv_actor(sk, skb);
 }

-- 
2.46.2


