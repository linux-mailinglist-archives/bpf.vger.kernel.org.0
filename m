Return-Path: <bpf+bounces-41546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C179980FC
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 10:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633F3281993
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C01B5808;
	Thu, 10 Oct 2024 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TD0D+S5r"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B357627446
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550177; cv=none; b=iCYj9vO53Y8rYRi/4PeHuPioS2qNljECQ+CFc4DW44SeHxqx0wzRWEvENESi+5KK3K3kuuo+YMnxSl8vqGd+oJvWujrvrvtOeIXERb7KD1izmFx/L4Ro77H/AVyGeTatIodePm1y98WRvyOrfR9qnDow5ct7ZipferdyCFJVSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550177; c=relaxed/simple;
	bh=68stV1OpW6b+DKiYGjzw+PqPRUZWqvm/GCbQHnNgX1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy+0eWeYDxv+KnMIpa85+zeiarcmQdefzUmlUGAGiTVqAHHPapIRswjKr7f5igvdX1qeXgKGXTEHu5F/JwAtik7spEPnUJdH9GIVWMoVtk4RUZyqYrvvNBGJodVu2XjhLQEk2GooWcND3Ir47CMQwmaZ4jC8cGYfF2jvWNuT50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TD0D+S5r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728550174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WTgUkKZySvZu+l2XKGcPyGoCj4q4zZnZ31rqscd6vJo=;
	b=TD0D+S5r1Fh3CQcbulIHgUCI6xqhx7TloUUf/ZBAKpQx6qEV8lTukvKN/CYK5rsaGCRILE
	nNAYOUYekxT8gncvGuFo8UA+YJIMiiZ5zVtA2nJQBvspmb/ZyemGRhF0BUnlNPuAmvkShO
	9kAGgZtpekTsir89ztXXZM4sPi8VDMs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-EqCCb2UgNIqJt3-BwOmpFA-1; Thu, 10 Oct 2024 04:49:33 -0400
X-MC-Unique: EqCCb2UgNIqJt3-BwOmpFA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fae0ab58ceso4180101fa.0
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550172; x=1729154972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTgUkKZySvZu+l2XKGcPyGoCj4q4zZnZ31rqscd6vJo=;
        b=rCEZworPu6ocMiQ8A+WUba+YCoJnVKDGmLVCLEysux9qyl2qq8UbaQhQyGqZ9LdGXv
         WZY5ZVXpnYXTmlWu0VMq1GQoPzoe6GWeV8RWhdJfRJdi9AaiVGSd9Nhvld4AZVFGDdCz
         Qo3vVkQ3xnh8LJtFGjg6/2xYfgDQ3vOayDGbSTnp7+jnm3MVa9VG+tboGNS7zvQxinHF
         t7p1AMLSjiSk4Bxuthj0PUa9mH7miI2gEOK3rY9uWLH+yzp2PpaaPnFBr9/GXgSktuGd
         dVCqq1Xe3/OuF4QfPLG90NXfDK364rpj1se7qhIk+2nEdTBAYm5d4Hg6yyZl+HzX7A1H
         p4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVttqFP8x5d6VKPyDkl7a5Xu5FT94nFRAHcMbXWLczVMVhuMkwmu/c2rJSD6VO/HhBwmiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpcF06QJ3O3xKwgmtbvHfvvvRCjaIyo3XpRnzDUNlJI6giSpdG
	9K8kt8L/7xYCgNbnPs6vzZKOT8E9uQNqV5Kq31cYlCJ8p9Wk+vf9jVLGffC55WZcgEsappqScoa
	B1J7fnFlIKOf8H7x2MvmW37JIPtqNhu4nr6M7VUFoCFLFBpZQSg==
X-Received: by 2002:a2e:bc0c:0:b0:2fa:cb44:7bde with SMTP id 38308e7fff4ca-2fb1871209dmr37374441fa.4.1728550172077;
        Thu, 10 Oct 2024 01:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh3c4fKyUkorKvGuaI1mTPxi1c7YQHi5OLwGxivpJhfR3vsBw4cdN68p2gBi+K23ol/4JvnA==
X-Received: by 2002:a2e:bc0c:0:b0:2fa:cb44:7bde with SMTP id 38308e7fff4ca-2fb1871209dmr37373911fa.4.1728550171329;
        Thu, 10 Oct 2024 01:49:31 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937153027sm484047a12.51.2024.10.10.01.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:49:30 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:49:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>, bobby.eshleman@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf 2/4] vsock: Update rx_bytes on read_skb()
Message-ID: <mwemnay5bb7ft5zvlrh5emdtkilqvkj42xnxnatnh3hmmtkhce@fqe64sbx6b2z>
References: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
 <20241009-vsock-fixes-for-redir-v1-2-e455416f6d78@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241009-vsock-fixes-for-redir-v1-2-e455416f6d78@rbox.co>

On Wed, Oct 09, 2024 at 11:20:51PM GMT, Michal Luczaj wrote:
>Make sure virtio_transport_inc_rx_pkt() and virtio_transport_dec_rx_pkt()
>calls are balanced (i.e. virtio_vsock_sock::rx_bytes doesn't lie) after
>vsock_transport::read_skb().
>
>Failing to update rx_bytes after packet is dequeued leads to a warning on
>SOCK_STREAM recv():
>
>[  233.396654] rx_queue is empty, but rx_bytes is non-zero
>[  233.396702] WARNING: CPU: 11 PID: 40601 at net/vmw_vsock/virtio_transport_common.c:589
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)


The modification looks good to me, but now that I'm looking at it 
better, I don't understand why we don't also call 
virtio_transport_send_credit_update().

This is to inform the peer that we've freed up space and it has more 
credit.

@Bobby do you remember?

I think we should try to unify the receiving path used through BPF or 
not (not for this series of course).

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 884ee128851e5ce8b01c78fcb95a408986f62936..ed1c1bed5700e5988a233cea146cf9fac95426e0 100644
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
>@@ -1716,10 +1717,14 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> 	 * works for types other than dgrams.
> 	 */
> 	skb = __skb_recv_datagram(sk, &vvs->rx_queue, MSG_DONTWAIT, &off, &err);
>-	spin_unlock_bh(&vvs->rx_lock);
>-
>-	if (!skb)
>+	if (!skb) {
>+		spin_unlock_bh(&vvs->rx_lock);
> 		return err;
>+	}
>+
>+	hdr = virtio_vsock_hdr(skb);
>+	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
>+	spin_unlock_bh(&vvs->rx_lock);
>
> 	return recv_actor(sk, skb);
> }
>
>-- 
>2.46.2
>


