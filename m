Return-Path: <bpf+bounces-59570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC5ACD0B3
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4FF1894CF4
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 00:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D2DDBC;
	Wed,  4 Jun 2025 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/o5wGeB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84B4C6E
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748997454; cv=none; b=EfmIgI5qmSkDfe5sQJwpIxutbSrFhCnXpo/VCNp4gYRer7lAEb22LwXBr7b2nhtD7oiwPU3JIazNbjB1z99PXUpKCT4JyTen59smmiCS6w2LHyDiGpmQ3qv4c2MHjlX0F0RLsxEcMX7maGMjbVdfFqXldgENelV+HwId4GygN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748997454; c=relaxed/simple;
	bh=FIhhwRMnEvPjuGUpf9qf+tqZDLEP9lZKLjQ3YYZd4as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHAsLGLSSXofxQ+XYWViEAjgoqpD7xaHGHGevWsPUBMksV/7SkGN5nkrUttys9x7hn/AwTG6j5wRvNEKLdTBFeJ+Jbm3SywXt2MI/ctKUG2oSX/Bzuu5gHzbd7uMvaYTjGXgFOtgx4EBvURFIrlWp2i7lXNZE7Hh06DpsgZ6XSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/o5wGeB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748997451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCJQT/kav5ff3pRxvzcaTAEwPIznqrXjhdq5yD+vQEE=;
	b=Z/o5wGeBme9/4XAfl5w58aOWuOBMRVmqHPSpYxc36VkyY5Ud/lu2TMiAd0tzpoYYH0HuPl
	IGO4weXHrhFKWa2LKl2b57lGfZhg091mdFk5Cv23hHRJRBWx1bqA6FMFkYgS/se8YKX8CX
	Ey7ddhiJpmkPQIcLzJJzdlAmFtgtDmI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-jMUONDk2PMi5p1xWzulNcA-1; Tue, 03 Jun 2025 20:37:30 -0400
X-MC-Unique: jMUONDk2PMi5p1xWzulNcA-1
X-Mimecast-MFC-AGG-ID: jMUONDk2PMi5p1xWzulNcA_1748997449
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30ea0e890ccso5957431a91.2
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 17:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748997449; x=1749602249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCJQT/kav5ff3pRxvzcaTAEwPIznqrXjhdq5yD+vQEE=;
        b=jvV6Teufi+OQFB6Q92hFIOnVTqkrhWp6mcc0ukMPubiNho0EzGMCdIsJPAMHkMw0R8
         EuQ1u0XI53zf9wZS4v07Snzw3a+Z9S5KHh27eW9htVCykIULagN+rDL7ceduHNAHkCGi
         QG7aRDquDWdi4Yv/rPflGiSH3KccO2YxDeNa1v73hSKACSsGVel00BMeOYBx/gDJcq5O
         /zt0pMdrE4WDc4gRkHci32OddZpEUl6NisHqiOKY1nVQtMdwlf861p54+Oth5Zdrv849
         /qNSA56k2YEWdMYThevVJW15U1TduHuna7D8wg9W5+zGJuxDbXuMLoWtW1iDEkMnnOez
         ukvg==
X-Forwarded-Encrypted: i=1; AJvYcCWmZrEW9HL5MZpeLUffYiE2qaqSE50FrBMLMx/NmOEZkzZp6DiY+BeHs5jAqJs3wamdJyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdr31lCPa9ooyYDGKRjUTuQVA9S300xqizHoz1w1U2z3psxNl1
	iBbbJLqu1mDLZ5d19Hz42mynlDo3epml+KCXgSR+0VRv6x7nbV9mz0NFzJEhZng6dhg49r3bgTH
	SGee6V5Teq13BGsglJRQyM3SkKkG15+1IonW11Opj+/EzODdyJk+SkSmGm46UxdMb/y072tTbT3
	DDN+F3/RipX6lvJG8dcPmDXR8+4Qvk
X-Gm-Gg: ASbGncvXhWtrxawoqMun5Li2xenLUFbWjO7JvYPVSl70Yw2lRyM4TVZm2n1iloo9U6J
	r3cI9KwggYMMEf560/m9W59NwHzmtg/eZ/MAAQfLKH7jjTlUPdfDJgaFZqKjutWZ/TaDYUWYXrc
	GB8pyb
X-Received: by 2002:a17:90b:51c4:b0:311:c1ec:7d0c with SMTP id 98e67ed59e1d1-3130cd65aaemr1426532a91.27.1748997449156;
        Tue, 03 Jun 2025 17:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQeODWbQfUbRlPw0j1gKXQJysD64GEXXnB2RuYnjq0y+PzQoFeIG5PN3PQdqbkgUndiDNUyG9oiwKSrJbbewE=
X-Received: by 2002:a17:90b:51c4:b0:311:c1ec:7d0c with SMTP id
 98e67ed59e1d1-3130cd65aaemr1426509a91.27.1748997448759; Tue, 03 Jun 2025
 17:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
In-Reply-To: <20250603150613.83802-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Jun 2025 08:37:16 +0800
X-Gm-Features: AX0GCFt_tMiNdtyDIBlXvuQJILPten36fjn0u2OKQnhU-6uwjA7mU6t1xM2SrDY
Message-ID: <CACGkMEuHDLJiw=VdX38xqkaS-FJPTAU6+XUNwfGkNZGfp+6tKg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in zerocopy
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 11:07=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> In virtio-net, we have not yet supported multi-buffer XDP packet in
> zerocopy mode when there is a binding XDP program. However, in that
> case, when receiving multi-buffer XDP packet, we skip the XDP program
> and return XDP_PASS. As a result, the packet is passed to normal network
> stack which is an incorrect behavior. This commit instead returns
> XDP_DROP in that case.
>
> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..4c35324d6e5b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(s=
truct net_device *dev, struct
>         ret =3D XDP_PASS;

It would be simpler to just assign XDP_DROP here?

Or if you wish to stick to the way, we can simply remove this assignment.

>         rcu_read_lock();
>         prog =3D rcu_dereference(rq->xdp_prog);
> -       /* TODO: support multi buffer. */
> -       if (prog && num_buf =3D=3D 1)
> -               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, sta=
ts);
> +       if (prog) {
> +               /* TODO: support multi buffer. */
> +               if (num_buf =3D=3D 1)
> +                       ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_x=
mit,
> +                                                 stats);
> +               else
> +                       ret =3D XDP_DROP;
> +       }
>         rcu_read_unlock();
>
>         switch (ret) {
> --
> 2.43.0
>

Thanks


