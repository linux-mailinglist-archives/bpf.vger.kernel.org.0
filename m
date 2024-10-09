Return-Path: <bpf+bounces-41500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A852E99788E
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 00:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2D9B230AA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 22:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF31E1A1A;
	Wed,  9 Oct 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="uaGe1FLR"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103A18E740
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513451; cv=none; b=pxpGrM1jWpH9ofz5yuZx222c8EeGE/rJAdWeEctrV3HlyMdk3H99brjqxRFDcudHz2Bo9Id4lG8doUTYEEExpLzgxqKktIZiO1UePFZ6QtGXk2XT5WUvywpzjFKz+FUtNbdYiOSfP1pWxGRVU4OJwhB+rQUJH6ZS7hDNetxQOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513451; c=relaxed/simple;
	bh=fV85lYMYy13smen59u9frogrj+vjYHYqk6ZdBC4xwkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbWwftiyytgbUOhCdnr9PmmfMlIa9J0aoOpUXkSMuRKtJHBKOu6db0AOWh4VKaWfSutX208aGL7n67U9XwO8mkz+ZULbamuHV7S+4Z7iWQEha6EFH9xCbgzOScNPobWlnqx8xix+K1pbw0olhlhMpq3zqHRcjJQ9Y10dxfB47yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=uaGe1FLR; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sye8f-001jJJ-Lc; Wed, 09 Oct 2024 23:22:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=2Wj1YSIDs+wnKVPgrDjOMjQqZD7UYDf8qr64czFHjYA=; b=uaGe1FLRdC9s7yduJTCeq7DtZM
	zUTiN0PxbrIwot2draUqt9xzf13sUCamXX/YEVgV73mAc+QCUoVRB3NDNwTlZMNgALY3CZyuuXm2l
	syFt26Pdz22q/WJLILYiQcL6lPiK22Xc+nVyyDFlLJZv9Nj7SaTOKVhGOtLwT8djfEbZNHVtcLFnL
	hoTbfcawZQCsMRoTnQ2+gYcJgx24HpBZ8XXwNz/ndlS0KM8Bl/V/bjyfqZQ/bOVXA5CS/7HMhkkpC
	Mw7aI0hosRytELfZ5rlL5fzczDMWYGONq0aSqQQr6g528IQqKpsDpsGSx8/EPmJcI44j1XEZT4OaT
	bVyrFYKg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sye8f-0004hI-1D; Wed, 09 Oct 2024 23:22:33 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sye8S-00EL6w-05; Wed, 09 Oct 2024 23:22:20 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 09 Oct 2024 23:20:52 +0200
Subject: [PATCH bpf 3/4] vsock: Update msg_count on read_skb()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-vsock-fixes-for-redir-v1-3-e455416f6d78@rbox.co>
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

Dequeuing via vsock_transport::read_skb() left msg_count outdated, which
then confused SOCK_SEQPACKET recv(). Decrease the counter.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/virtio_transport_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ed1c1bed5700e5988a233cea146cf9fac95426e0..1d591b69ede3244a4f49aa44dc1f939d827dafc0 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1723,6 +1723,9 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	}
 
 	hdr = virtio_vsock_hdr(skb);
+	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
+		vvs->msg_count--;
+
 	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
 	spin_unlock_bh(&vvs->rx_lock);
 

-- 
2.46.2


