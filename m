Return-Path: <bpf+bounces-48548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53682A08EAB
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 11:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295C03A9E22
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 10:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4000C20ADC2;
	Fri, 10 Jan 2025 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya5DnIDC"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1DC1C3BE7
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736506669; cv=none; b=Nh+k97G6BY+40rRt0niHX9Y3ubWeYF8xmBxuE8n1c9LpXfyfMCmqtXxcyZoudhnagJM/LZAcx6zhANEHtGVyAbprAX7s5pL3HpI6oO/TRsf5aFnn7j9MtISy2Z0qcoSPTDscOF9EiDUmOnnTt4SLKDFwzK6p+nPn+uUBnffu/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736506669; c=relaxed/simple;
	bh=J08jrPV1Tnjsks3FkDNgHe/lPdv6Q0IvGjCXuEqHoGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slDyO/xvXfBd/hCaO8G//i1+Er9qYoPNkU3R38kQlxROuudv7N82Hnqueb5KRzvdZqTfgDS7A2PIzXg32RcXP/DIWJR8D4HzeYFvCa8zYnuCpHKAbyosXq2Yttd/v7ZIrpMv1cpgInRsNiLUwVoLId8RCXkIcywaOCDNnOMo88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya5DnIDC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736506667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wTBki0vgAxfifXdgNeBVy0WzwbqroFsqKcMbO7Lm6Oc=;
	b=Ya5DnIDCPSRTMqHSHaqbFediVvJ04vNPm0FvcEpybFDWL5O2AmQklIF/uLpees45BKg6Bk
	xEIPusujuHFcehfT4qKyRKo/RpJ+EAq0sxeLRcedt+ydHYugcx+Jk0jAZyF9p9uulqAKRc
	QwrcCAWupTd2hnauVt/tA8C6/fi7rxs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-6eprUDxiMJSwHezt6cntxg-1; Fri, 10 Jan 2025 05:57:46 -0500
X-MC-Unique: 6eprUDxiMJSwHezt6cntxg-1
X-Mimecast-MFC-AGG-ID: 6eprUDxiMJSwHezt6cntxg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa67f18cb95so187854766b.1
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 02:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736506665; x=1737111465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTBki0vgAxfifXdgNeBVy0WzwbqroFsqKcMbO7Lm6Oc=;
        b=VZEsE0e68CEjjUhXytdgCZt5xFvW+qmsX8JSVlSzoOK2WmUVrlfiGD23b5diztqBtA
         0/v8SfXydYpD7YDq+zOUClAIr5wYZH8ubdXuAwjrxStN+T8wn8Njjh2H7gy6HBC/HUi0
         b1+6A3f0+zC9085fIxDN8jlnk/jILQxyNE9oIORQS2DfeZeKjRb9zWPuuvQiDtaPThUI
         qzLopQ+o6HOVUeWW+Z97MZuZMkVVsiKI/1ON41ExQqy+L8ACTumvWETjjZo6u4tO8SnQ
         tDRZpD82betgTEj4/kM4HZJcjHsVRfrtBVOlGWMbO0UpFil4/kU63bzXO9mmiakNrfUS
         6FuA==
X-Forwarded-Encrypted: i=1; AJvYcCV3My+0gyyijnanK2IxRyqfVUcNgDs16Qvq9tdwmXsbeSNC6XzjPINOjxWj3YJwbK8vftI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9GGSi3I6+tCrLae8NVxiBdQLh+n+O334eRiAvGS22bVbISPf
	00Gwjl1OkIcXYKro5e2SRjlo1zdWH/5nb5qXra9XSw7ia9lYEvwIjcFk7F0UpW5hf/agd2UbJzM
	BeRazmriBrasEeYnNjIYpqIV9Gjqqj8U3nNrz0FlXmjE8PCysSw==
X-Gm-Gg: ASbGnctwgRYTTp4t3GR5QkmqJsA38xOcDLPWhCXgDA1fR0lw7Fzp3CENlg+HIcCJoLR
	XZY3fF4A+fEtW/kxDc07hjQ+K8jAqTDXGRx6T3/cYzefcDyFzuFTgMuvrElsJ4D/ONPNGxfL/K8
	BjQwns67blYcQs8eU4FJknStSHSiDkIZyz4mbJJFQoGuIZGuM1zBQCA+DDwvkJU3lUN8LIaLPU0
	U4s7KtAdbcXe5jqO5/pK2GB2uUOIAuYLweCdnRTrjq5gGyAFI22TTxA1zNI
X-Received: by 2002:a17:907:7b99:b0:aa6:2a17:b54c with SMTP id a640c23a62f3a-ab2ab16b1cbmr782664366b.6.1736506664813;
        Fri, 10 Jan 2025 02:57:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESv2FtstfmeRfNMDHjG83u1YYQu94Q31j0qdyPPj9UJSPP/WkoIPQIVfa4hgWYpj5Nmu9NKg==
X-Received: by 2002:a17:907:7b99:b0:aa6:2a17:b54c with SMTP id a640c23a62f3a-ab2ab16b1cbmr782662166b.6.1736506664375;
        Fri, 10 Jan 2025 02:57:44 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d7432sm153952766b.49.2025.01.10.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:57:44 -0800 (PST)
Date: Fri, 10 Jan 2025 11:57:41 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Wongi Lee <qwerty@theori.io>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, Jakub Kicinski <kuba@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 3/5] vsock/virtio: cancel close work in the
 destructor
Message-ID: <f6wv63x75ohn3s3isbbfggnvpfxwx5mbgnpmol4tnw5tthq4nf@wb62fpiplgs4>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250110083511.30419-4-sgarzare@redhat.com>

On Fri, Jan 10, 2025 at 09:35:09AM +0100, Stefano Garzarella wrote:
>During virtio_transport_release() we can schedule a delayed work to
>perform the closing of the socket before destruction.
>
>The destructor is called either when the socket is really destroyed
>(reference counter to zero), or it can also be called when we are
>de-assigning the transport.
>
>In the former case, we are sure the delayed work has completed, because
>it holds a reference until it completes, so the destructor will
>definitely be called after the delayed work is finished.
>But in the latter case, the destructor is called by AF_VSOCK core, just
>after the release(), so there may still be delayed work scheduled.
>
>Refactor the code, moving the code to delete the close work already in
>the do_close() to a new function. Invoke it during destruction to make
>sure we don't leave any pending work.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Cc: stable@vger.kernel.org
>Reported-by: Hyunwoo Kim <v4bel@theori.io>
>Closes: https://lore.kernel.org/netdev/Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX/
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++-------
> 1 file changed, 21 insertions(+), 8 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 51a494b69be8..7f7de6d88096 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -26,6 +26,9 @@
> /* Threshold for detecting small packets to copy */
> #define GOOD_COPY_LEN  128
>
>+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
>+					       bool cancel_timeout);
>+
> static const struct virtio_transport *
> virtio_transport_get_ops(struct vsock_sock *vsk)
> {
>@@ -1109,6 +1112,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
>
>+	virtio_transport_cancel_close_work(vsk, true);
>+
> 	kfree(vvs);
> 	vsk->trans = NULL;
> }
>@@ -1204,17 +1209,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
> 	}
> }
>
>-static void virtio_transport_do_close(struct vsock_sock *vsk,
>-				      bool cancel_timeout)
>+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
>+					       bool cancel_timeout)
> {
> 	struct sock *sk = sk_vsock(vsk);
>
>-	sock_set_flag(sk, SOCK_DONE);
>-	vsk->peer_shutdown = SHUTDOWN_MASK;
>-	if (vsock_stream_has_data(vsk) <= 0)
>-		sk->sk_state = TCP_CLOSING;
>-	sk->sk_state_change(sk);
>-
> 	if (vsk->close_work_scheduled &&
> 	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
> 		vsk->close_work_scheduled = false;
>@@ -1226,6 +1225,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
> 	}
> }
>
>+static void virtio_transport_do_close(struct vsock_sock *vsk,
>+				      bool cancel_timeout)
>+{
>+	struct sock *sk = sk_vsock(vsk);
>+
>+	sock_set_flag(sk, SOCK_DONE);
>+	vsk->peer_shutdown = SHUTDOWN_MASK;
>+	if (vsock_stream_has_data(vsk) <= 0)
>+		sk->sk_state = TCP_CLOSING;
>+	sk->sk_state_change(sk);
>+
>+	virtio_transport_cancel_close_work(vsk, cancel_timeout);
>+}
>+
> static void virtio_transport_close_timeout(struct work_struct *work)
> {
> 	struct vsock_sock *vsk =
>-- 
>2.47.1
>

Thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


