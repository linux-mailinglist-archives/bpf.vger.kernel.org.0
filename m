Return-Path: <bpf+bounces-41829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BC99BA57
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 18:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932E4281781
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13581487DC;
	Sun, 13 Oct 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="oJXC59B8"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD5145B1F
	for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728836844; cv=none; b=UulqbkDSc4yzpc6SYhfmiPPDcdY5uTftiM9aY/HEJDNtF/bh53KvJ6ZwLVevEwCUgBuYGnAin7SdfL3JyElr/RuX6SHOm/wH3V5Baac/8u03HZUcVl5ENnbxzSSS7w/oRfbLN+2v4nGJ+pGjJ0cVY8UVzmJhSt9iIO6hcZIJUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728836844; c=relaxed/simple;
	bh=KhWoRD2H+BmWFgR1juH3zFWA2YBT95nUEwQS/ULNd4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cGY3tHFmXTL5RrE44BP461kok3ZYWolgc0sNydUX86TB++7FEUIh2BJM7Q719X8QZIV2VPJS8YVHbvIGJuGo74vWQBGu9kCNKq0Do5JxZqZOk8H8FXfsJTe0NQvAtWe9HBadXcksHp6NwMJYMSbtGEgdNq3uX8mXpnsJSZ5Tymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=oJXC59B8; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1t01R2-00CydA-Kw; Sun, 13 Oct 2024 18:27:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=4ZHKODsTHKVTvolB7Hhh4+kBDfGSvykMXekv9gZvMxU=; b=oJXC59B87d0uZ/LSPGnVfqXu9z
	8cEMtgRQkvAu9eT6Xwi8c5mWDj6usFWxz7tNNtFWC9O5IqlhCbtWnlSu4wO4Q5VeIfwes8PyxlTMu
	kH1PQdYzkO5MyeZeUP58awCjQqDE0q/9bh9EhcSsNscfFjWiRGBI8L9FUbFKr8DlMKlxBeFB0MZy8
	yiIg56KbaBDW0lQpBORThDQjlJQtB3pmSKSbdOgMlCb52OLKTGkcplrSrbMVZMYRQ5LO1Yph2LV3A
	mmwx6EJHzuh2UN+SMncB/c4HjpRplc66MrNLJc1I3eZXWiEkADBwFqCUg4ZpdmC0mP9gku64Htp1G
	65KR8K5Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1t01R2-0007HW-AV; Sun, 13 Oct 2024 18:27:12 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1t01Qh-00GV5b-9M; Sun, 13 Oct 2024 18:26:51 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Sun, 13 Oct 2024 18:26:41 +0200
Subject: [PATCH bpf v2 3/4] vsock: Update msg_count on read_skb()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-vsock-fixes-for-redir-v2-3-d6577bbfe742@rbox.co>
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

Dequeuing via vsock_transport::read_skb() left msg_count outdated, which
then confused SOCK_SEQPACKET recv(). Decrease the counter.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/virtio_transport_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 2e5ad96825cc0988c9e1b3f8a8bfcff2ef00a2b2..ccbd2bc0d2109aea4f19e79a0438f85893e1d89c 100644
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


