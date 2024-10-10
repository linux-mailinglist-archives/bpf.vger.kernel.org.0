Return-Path: <bpf+bounces-41547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2AB998112
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 10:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F9A284645
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43051BD512;
	Thu, 10 Oct 2024 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmxAjgoj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB61B0109
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550323; cv=none; b=bQnGxGEmiurg9URAN784KE2w5Tn/0j+zqZTyx99W6EyFwqiY+2a57XiQDelQndrLW0seRCd6CwfqvW/L6xmOZEEus5Pp/56hdKbHgz6o7RLpDKQ5Djg4HYbcvy92zh9iVW+wE8P61aLf5Gx/2PeRmce6L9NvYmZWG6Va3HRQ7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550323; c=relaxed/simple;
	bh=5FkSym2zfh9gpYXqPQNVgOy2adJqzTdbKa/srQkqsak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L33lJrapzSVIZvSrIFWOq1VOYYoWIdCUpP8OC3FltfQkpEXF3rBadXBbQtw4L7Gf0d/Q77V7gaOX77wXkMerFrVYrFFfbA2Rwc+KgW4Ts5nf1gx7knzCqP3n2FgmdGRTITSPsQG5elmJqJbXPED4KP6YThDFNvSsRVfDD2hUPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmxAjgoj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728550320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y2dejue6pSAQvTnG44RkXYEK41uwAaKUcsc0phbjvy4=;
	b=TmxAjgojwCrRiLOOMFRzyKduwwmMv18ejzWQhPOdF5IadqEnhl0w1p4gviS3FwfNP7A6aH
	S9zX2H6VCk24aatUfroPSFvm4KRKYa+DW+ja5xCfhrS+Et9Y0hklTB2adQPxaEVcLcQ7ey
	P9Fyj88m8p5Tu/MYQ/TL8Xw75hxGpWA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255--YcL-uhxNOyBYA2san0Ovw-1; Thu, 10 Oct 2024 04:51:59 -0400
X-MC-Unique: -YcL-uhxNOyBYA2san0Ovw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9953730a3eso51223266b.3
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550318; x=1729155118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2dejue6pSAQvTnG44RkXYEK41uwAaKUcsc0phbjvy4=;
        b=gaNSjLm0dIc3sM127fDa2jhqKRBONI54DQFDMefh4sZ/H+CwY14pAW5hW+BXBjsRXE
         JqmVYmAbcJ7TZnjn1ShykO+xfO22ovMzLJJUn+ILLXWqGxv8DCkWX25lndLUUBr1cG2X
         1ldifTirfLaU12g4VmSWfp2bMU6wE899Pqp8LKCDbDP4PN0o7PqFPC4I8fJn6V2MqGGN
         Jr6IGaqJ/IDz+Po6ZBtrgpJ8qRHik8ba0foK17qco9aFkDRYfY13xX+4IlUq/mDgkLlT
         ut5SZaNlyMwzYp3bSORNwzpZxrk4Am/iyM0KMNDvBO+SUkvAoa52Uq3Hfa6zNzIJRaJf
         KEzg==
X-Forwarded-Encrypted: i=1; AJvYcCX+aX7nQWRAgSDau5D7F0QfSTk4fBYfvwtlrB+MNCj5Huko871A5huPIpFgkUIyNmrf7+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZw9MYLtCjbP9b1IPRTnshSYeDzu496H7HRAF+bzmB00L9eYw
	YbKV0fT30ILDUEhbaQ3KbddIZ1RppO7pKEAB20tNqK1M5/RSK02v/sbyI8XmCxN0wQLp1YPBOzv
	3KKyKb19W3Np1L2sOcED6XA8fT5CQCviL9oaf8WX8s35RIoY2KQ==
X-Received: by 2002:a17:907:f7a9:b0:a99:6b71:299b with SMTP id a640c23a62f3a-a998d21956cmr521641866b.37.1728550317922;
        Thu, 10 Oct 2024 01:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXkxqLEEjeO5KbJNC9njO1BJ1d6ufsRlRJNPu7hJZf3nJ1CQw+5JlosH5E/PJf49c0mNK58A==
X-Received: by 2002:a17:907:f7a9:b0:a99:6b71:299b with SMTP id a640c23a62f3a-a998d21956cmr521638466b.37.1728550317125;
        Thu, 10 Oct 2024 01:51:57 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dcdc3sm58131866b.172.2024.10.10.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:51:56 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:51:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf 3/4] vsock: Update msg_count on read_skb()
Message-ID: <cg4lmct3plkgdvuasxuorbs65qylkmgrezw77phahsxf24hqts@nmubxtsarqnl>
References: <20241009-vsock-fixes-for-redir-v1-0-e455416f6d78@rbox.co>
 <20241009-vsock-fixes-for-redir-v1-3-e455416f6d78@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241009-vsock-fixes-for-redir-v1-3-e455416f6d78@rbox.co>

On Wed, Oct 09, 2024 at 11:20:52PM GMT, Michal Luczaj wrote:
>Dequeuing via vsock_transport::read_skb() left msg_count outdated, which
>then confused SOCK_SEQPACKET recv(). Decrease the counter.
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 3 +++
> 1 file changed, 3 insertions(+)

Thanks for fixing this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ed1c1bed5700e5988a233cea146cf9fac95426e0..1d591b69ede3244a4f49aa44dc1f939d827dafc0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1723,6 +1723,9 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> 	}
>
> 	hdr = virtio_vsock_hdr(skb);
>+	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
>+		vvs->msg_count--;
>+
> 	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
> 	spin_unlock_bh(&vvs->rx_lock);
>
>
>-- 
>2.46.2
>


