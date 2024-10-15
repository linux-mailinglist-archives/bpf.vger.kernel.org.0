Return-Path: <bpf+bounces-41978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779E399E113
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240DE1F228D2
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3611CF7D0;
	Tue, 15 Oct 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8/iOtvv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39717335E
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980995; cv=none; b=Xxb2Fisnlwi4iN6e28PlGV592zCXE9JwqY9H7z9tmxbGKoKIGGwlqJxvNNK6X15qaruMu4xuIuwIMRUqGWpcXScg8TkgzwsVIHx2dUev9IBDf5GAJDlat2+b2B4+uP/ymKuV/wugvSR5e02d7a5028Ae6jrmqDpnDeMUyrYWW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980995; c=relaxed/simple;
	bh=jj/LmH7qLvgt4exl6wkE4mjEsmbw+w5cMUOrJUKHKk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM7poXYpzdc800ysM/f1W5PDupKHHCHos4H+WyTCF9ILo4gVxw57jPPBXxPZ+Pjln79bKgCP31MvZB04BXle3HDbvTqY9WQDABbhcPVq+p8gRbxb+TQX+zUaV/3RJIR5CGWKjneCHR2ZT3dPI6RMlXqueoGerHZzjxp8J0GFhN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8/iOtvv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728980993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+X3HJY57OoNbvtfOdWkdMD2px5S+qJ+6gnDSHv9a5fQ=;
	b=T8/iOtvvGrNOKGj4vPPl5FvVnE6nh5j1+t9vkAqoiGXg/Ulx0+zuC7KHzt2kuxyYN9S1yH
	0Xfh63WGTOrzvmUh7UIIrTPkTGv9A+3Y8+5He5jYTOC0njkYxRSb9m12h6dz0XcdoinRs7
	3sSTpMT5Z5M/dNcics90giyzTjdLGLs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-x7g8BZNrMkGixoVPmCJ5pQ-1; Tue, 15 Oct 2024 04:29:51 -0400
X-MC-Unique: x7g8BZNrMkGixoVPmCJ5pQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b117cdb27bso1025819885a.2
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 01:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980991; x=1729585791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X3HJY57OoNbvtfOdWkdMD2px5S+qJ+6gnDSHv9a5fQ=;
        b=QujSrjiZRPx+JERs5pSGfUomj4bGT4ugjUSc5Vw6dIRr+N1pz6CAdK7FXC/U/mfyku
         ohdHmqYwQ6BNm+NnWYMpYUx4lhuReaOZ5PSpmnt4V889AMYGiGB/Bi2CVIy+btA9iVFf
         4nu6NTfDsxHN/tH7ke/9COLoG+cvllinJNjH1gip0ti4z22rZABTw0MIQDQDMII0Tg+l
         i3IiNkBliu4R89NCdMcXkmeCBveRD2gRaaEZafzPBldPS3ufXJsHi26CBQN6URJ8ZWBz
         9uASva1BGQsOBkMNZ9GAgNwReT29e70qcy40JD/Vv0teWvkqHxQn1mgxbK03pk8xcciy
         2m7w==
X-Forwarded-Encrypted: i=1; AJvYcCX9C3ilqtNOsHBSZi3HLZ5vTmuHJTnRtAPb674SR3RJz4pFOIe0LpOxlPQ+ObDX6L1G49w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpgy2QhraL1USxZzW0+pBN1K6cJyjEeKxBU59u9VT8LGicZmI
	TXQ4t0JsLairj7v+iCh6rS/9vodv/ci4LQgHvAOjRMdvvO6JqcJ/InAqps31UEyN4EfOjDEE7/R
	lfGIdOQGpa+/Ki47jAICtasSIjSbLulwwMCvDGzo+gow/2AjPFA==
X-Received: by 2002:a0c:fe87:0:b0:6cb:faee:76bd with SMTP id 6a1803df08f44-6cbfaee77c9mr168514326d6.37.1728980990813;
        Tue, 15 Oct 2024 01:29:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbqXUDY/LzeEwx2rNA73Z6eW1a1VzKmXv3PC0F1n2oqrFc7NEweIEP7pk+3LRVAWTefnnlNA==
X-Received: by 2002:a0c:fe87:0:b0:6cb:faee:76bd with SMTP id 6a1803df08f44-6cbfaee77c9mr168514076d6.37.1728980990453;
        Tue, 15 Oct 2024 01:29:50 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2292293asm4011516d6.53.2024.10.15.01.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:29:50 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:29:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/4] vsock: Update rx_bytes on read_skb()
Message-ID: <beao3to2xe4h3ahidckfcf5upndl7vdeeb4dehqy2mpt42fa34@6d5n44gn3l35>
References: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
 <20241013-vsock-fixes-for-redir-v2-2-d6577bbfe742@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241013-vsock-fixes-for-redir-v2-2-d6577bbfe742@rbox.co>

On Sun, Oct 13, 2024 at 06:26:40PM +0200, Michal Luczaj wrote:
>Make sure virtio_transport_inc_rx_pkt() and virtio_transport_dec_rx_pkt()
>calls are balanced (i.e. virtio_vsock_sock::rx_bytes doesn't lie) after
>vsock_transport::read_skb().
>
>While here, also inform the peer that we've freed up space and it has more
>credit.
>
>Failing to update rx_bytes after packet is dequeued leads to a warning on
>SOCK_STREAM recv():
>
>[  233.396654] rx_queue is empty, but rx_bytes is non-zero
>[  233.396702] WARNING: CPU: 11 PID: 40601 at net/vmw_vsock/virtio_transport_common.c:589
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)

Thanks for fixing this!

LGTM:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 884ee128851e5ce8b01c78fcb95a408986f62936..2e5ad96825cc0988c9e1b3f8a8bfcff2ef00a2b2 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1707,6 +1707,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	struct sock *sk = sk_vsock(vsk);
>+	struct virtio_vsock_hdr *hdr;
> 	struct sk_buff *skb;
> 	int off = 0;
> 	int err;
>@@ -1716,10 +1717,16 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> 	 * works for types other than dgrams.
> 	 */
> 	skb = __skb_recv_datagram(sk, &vvs->rx_queue, MSG_DONTWAIT, &off, &err);
>+	if (!skb) {
>+		spin_unlock_bh(&vvs->rx_lock);
>+		return err;
>+	}
>+
>+	hdr = virtio_vsock_hdr(skb);
>+	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
> 	spin_unlock_bh(&vvs->rx_lock);
>
>-	if (!skb)
>-		return err;
>+	virtio_transport_send_credit_update(vsk);
>
> 	return recv_actor(sk, skb);
> }
>
>-- 
>2.46.2
>


