Return-Path: <bpf+bounces-44113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816AA9BE020
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 09:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44661C231FC
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 08:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E91D47B0;
	Wed,  6 Nov 2024 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2yU/3O8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939B1D0DE7
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880944; cv=none; b=HBz3FbuQweip5+tA6MJhm93daEPidLIXL72gkqENs2YspXKMIhIWpXCRj4HwfOO5KJeKtIDhdS/Y783hQQzVLZ0HZsaigwvliRN+B999D+vchZIxx7wkPPYW/muLJq8c6NWb8FiDqQ9KL9YRDQ16UosgCVZHyu+Y95FiHEyXKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880944; c=relaxed/simple;
	bh=HaLitbySmWv52naz4Gh5UROaphvNRd3TDJQH/NIJyyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eme1+xTzhdWii9Isz/dZxIyIEF5vgL52lCHB6HNKkqjvLqpnVwO0+5rhwDFZt1crfk4o1tY29aggy3nHAmFwIaTnhznYLq9qygm9z6AWLCUsQJqFZyJxWS4ztcTVMRnT3d+rLGNgiaXap8t/JxN0y2vV3t3D7/SRd/793tAV8Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2yU/3O8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730880942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/QB2JpiIOVzjMGSwElOtuDo7l4UxpuwpHC7fYdy2eI=;
	b=M2yU/3O8x1HXezNt6ZfDl1hKbXZAFD2qZrU2Fwy5//eXO630mbf9jcQigY+X4RSfbn6lAN
	x817oaKZH6vbNHKQETXJoLsDAZVkmUhH24nzWk3/03UyyznEW0rnhPnd8b8ICrFdEj2kvv
	Fs+d96YktCy0lUg0ClyAnWWe2gaJbdY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-tb6SqWGCOQ6UxGThpfsVdw-1; Wed, 06 Nov 2024 03:15:38 -0500
X-MC-Unique: tb6SqWGCOQ6UxGThpfsVdw-1
X-Mimecast-MFC-AGG-ID: tb6SqWGCOQ6UxGThpfsVdw
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-460b07774a7so143779221cf.2
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 00:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730880938; x=1731485738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/QB2JpiIOVzjMGSwElOtuDo7l4UxpuwpHC7fYdy2eI=;
        b=s2UrMHgvUD21OdqNXeAU3Pd/0h5nuBnzzDnXF+I2jCFFrnj2jcqlzSVuSwz5PplCK4
         lLkxCFj5Yi2ahurE9LIBf3jeAE0PPc95CdfcijtuyDOXyHXhuAVzDLwCa33cAAmhENlw
         FEpdcsiu9yjc1op7XqxnP7yOXTvXeM8XT1Km9iYel22NGnxyeNYie+Y/aEbx3fuE4/2p
         lZiZM+jGI0LIIqkHCXpJwSxdzowZmhaFpFYv966Cec9xxByIgwQPzs8w2wHOe0jCQHhx
         S5ZQQ6L69y2l1/T2+qoIgagv1ZpYztpIxP9GAFtKWXsM2G6b/qzKrTU4Jvr2Z/3sNu8R
         PK9g==
X-Gm-Message-State: AOJu0YxPMyEIX7uvcLF0qUfGTCmDD8uGNnYkL3RFCEhjv53MQuUgMld1
	bLqMQoI1ix71hQYP2ATLU2Dwb2a/DGWXQrDCJC2oE/DMIObR24y5Cgwqdz4txqmUt3jsyPF9qXR
	KrHJKP6WLbjl2utrTZXW6+f0sbbvBFvmP2Ncz/4BXSZhuKIEXYQ==
X-Received: by 2002:ac8:7dcc:0:b0:460:fb75:1373 with SMTP id d75a77b69052e-461716d9f45mr375083301cf.23.1730880938221;
        Wed, 06 Nov 2024 00:15:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8y+RA0rP/0qUztbF1wH73I48ad4+rSRdfXPZ1zD+w1HkI70BiawYuwH9MXc6zIyFTJZuHXw==
X-Received: by 2002:ac8:7dcc:0:b0:460:fb75:1373 with SMTP id d75a77b69052e-461716d9f45mr375083061cf.23.1730880937816;
        Wed, 06 Nov 2024 00:15:37 -0800 (PST)
Received: from sgarzare-redhat ([5.77.86.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462b32234ddsm64533201cf.89.2024.11.06.00.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:15:37 -0800 (PST)
Date: Wed, 6 Nov 2024 09:15:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: zijianzhang@bytedance.com
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, borisp@nvidia.com, 
	john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, mst@redhat.com, bobby.eshleman@bytedance.com, 
	jakub@cloudflare.com, andrii@kernel.org, cong.wang@bytedance.com, 
	jiang.wang@bytedance.com, netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v3 bpf] bpf: Add sk_is_inet and IS_ICSK check in
 tls_sw_has_ctx_tx/rx
Message-ID: <3e3tptbbmznkwhmvgrtbi7jtybxchqoes32i5ddyk2qa5i2lfv@zsxx7x6sbytd>
References: <20241106003742.399240-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241106003742.399240-1-zijianzhang@bytedance.com>

On Wed, Nov 06, 2024 at 12:37:42AM +0000, zijianzhang@bytedance.com wrote:
>From: Zijian Zhang <zijianzhang@bytedance.com>
>
>As the introduction of the support for vsock and unix sockets in sockmap,
>tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be IS_ICSK.
>vsock and af_unix sockets have vsock_sock and unix_sock instead of
>inet_connection_sock. For these sockets, tls_get_ctx may return an invalid
>pointer and cause page fault in function tls_sw_ctx_rx.
>
>BUG: unable to handle page fault for address: 0000000000040030
>Workqueue: vsock-loopback vsock_loopback_work
>RIP: 0010:sk_psock_strp_data_ready+0x23/0x60
>Call Trace:
> ? __die+0x81/0xc3
> ? no_context+0x194/0x350
> ? do_page_fault+0x30/0x110
> ? async_page_fault+0x3e/0x50
> ? sk_psock_strp_data_ready+0x23/0x60
> virtio_transport_recv_pkt+0x750/0x800
> ? update_load_avg+0x7e/0x620
> vsock_loopback_work+0xd0/0x100
> process_one_work+0x1a7/0x360
> worker_thread+0x30/0x390
> ? create_worker+0x1a0/0x1a0
> kthread+0x112/0x130
> ? __kthread_cancel_work+0x40/0x40
> ret_from_fork+0x1f/0x40
>
>v2:
>  - Add IS_ICSK check
>v3:
>  - Update the commits in Fixes
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Fixes: 94531cfcbe79 ("af_unix: Add unix_stream_proto for sockmap")
>
>Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
>Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>Acked-by: Jakub Kicinski <kuba@kernel.org>
>Reviewed-by: Cong Wang <cong.wang@bytedance.com>
>---
> include/net/tls.h | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)

For the vsock point of view LGTM:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/include/net/tls.h b/include/net/tls.h
>index 3a33924db2bc..61fef2880114 100644
>--- a/include/net/tls.h
>+++ b/include/net/tls.h
>@@ -390,8 +390,12 @@ tls_offload_ctx_tx(const struct tls_context *tls_ctx)
>
> static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
> {
>-	struct tls_context *ctx = tls_get_ctx(sk);
>+	struct tls_context *ctx;
>+
>+	if (!sk_is_inet(sk) || !inet_test_bit(IS_ICSK, sk))
>+		return false;
>
>+	ctx = tls_get_ctx(sk);
> 	if (!ctx)
> 		return false;
> 	return !!tls_sw_ctx_tx(ctx);
>@@ -399,8 +403,12 @@ static inline bool tls_sw_has_ctx_tx(const struct sock *sk)
>
> static inline bool tls_sw_has_ctx_rx(const struct sock *sk)
> {
>-	struct tls_context *ctx = tls_get_ctx(sk);
>+	struct tls_context *ctx;
>+
>+	if (!sk_is_inet(sk) || !inet_test_bit(IS_ICSK, sk))
>+		return false;
>
>+	ctx = tls_get_ctx(sk);
> 	if (!ctx)
> 		return false;
> 	return !!tls_sw_ctx_rx(ctx);
>-- 
>2.20.1
>


