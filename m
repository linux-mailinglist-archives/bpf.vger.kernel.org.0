Return-Path: <bpf+bounces-16034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5C87FB634
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 10:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90144B20E03
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2954AF93;
	Tue, 28 Nov 2023 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guox/1bN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29810E
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701164747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONi3pcPSO6suG0LhIvjam1J9vSuFjbP0aR9GNU0eBjo=;
	b=guox/1bNAnv9nSJXuOEmGb3KwoE6OoR+tNZtuQgXGAsjS19cbqHW7/LOwDxpniQHnA5Cux
	h0Uj+GJDAO8s0++2kbQ/h6DBVnDjahpB8YN9cxRxsLmSsrMgIKhms1H4Itq6YMPJeaJFxW
	bX6/NbIkPWiv3ZK2C/bbs1wgLA8ZXGA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-1c7MmCZwPMyhomZHODSyow-1; Tue, 28 Nov 2023 04:45:45 -0500
X-MC-Unique: 1c7MmCZwPMyhomZHODSyow-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5411d71889aso3939988a12.2
        for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 01:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701164744; x=1701769544;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONi3pcPSO6suG0LhIvjam1J9vSuFjbP0aR9GNU0eBjo=;
        b=gPritwuegIxxWWDxjoCMN0ZOCMmudxqBjDSak81KxcgU8Icr1zdWR+f/mkS0n/g7Kh
         VdZEsP4cOrO+ZknWJHt/JnquieIolH+JXysX9WHpspNu3tcZZyq/OX39o5pRuSxbNVnd
         3wBh83YCqALzVs6skNHuB4nex8V+qZtDYzvDJ5jWmNICHdqqAYcLMOLDFjRBZziUHSom
         w/LSzXJPK/PLQk0uXmSTmLCv1cMSmgRhi6NOD0PWlhTWxAL3pdB85GugMiX6kOx/nTFr
         Pq0QRaTSmdpmBh3/bwA/TKjlgUwHM6YjJaTequIvCXApiz6LHQ8Ky5eFjK5gpZGhCjfp
         dj3g==
X-Gm-Message-State: AOJu0YwA5vAVbu0mjZSKPFY3JQzSunUvNnIZXM6CtFPD0N41xtGOi3wy
	kYwAekkn+FakLeZDSFcIJnz7xX6QRTSEFe8Sr6vN0ZTQsmW2Fin0xaRvY4R7VhCBXGCx1SwJpHf
	MajPuVApDmM8W
X-Received: by 2002:a05:6402:3:b0:54b:8968:4573 with SMTP id d3-20020a056402000300b0054b89684573mr3064513edu.5.1701164744504;
        Tue, 28 Nov 2023 01:45:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkIC1CY5NQqgBFcTP5m9umrcKsXt2cRdss3dxpagkMqpINerEpo1RugxYxtfKWBAoUcy8qYQ==
X-Received: by 2002:a05:6402:3:b0:54b:8968:4573 with SMTP id d3-20020a056402000300b0054b89684573mr3064491edu.5.1701164744152;
        Tue, 28 Nov 2023 01:45:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id co3-20020a0564020c0300b0054ba787af1asm494921edb.3.2023.11.28.01.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 01:45:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8116DF78098; Tue, 28 Nov 2023 10:45:43 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lorenzo.bianconi@redhat.com, bpf@vger.kernel.org,
 hawk@kernel.org
Subject: Re: [PATCH net-next] xdp: add multi-buff support for xdp running in
 generic mode
In-Reply-To: <c928f7c698de070b33d38f230081fd4f993f2567.1701128026.git.lorenzo@kernel.org>
References: <c928f7c698de070b33d38f230081fd4f993f2567.1701128026.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 28 Nov 2023 10:45:43 +0100
Message-ID: <87o7fejjnc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Similar to native xdp, do not always linearize the skb in
> netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> processed by the eBPF program. This allow to add multi-buffer support
> for xdp running in generic mode.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

With one nit below:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

> ---
>  net/core/dev.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3950ced396b5..5a58f3e28657 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4853,6 +4853,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, =
struct xdp_buff *xdp,
>  	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
>  	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
>  			 skb_headlen(skb) + mac_len, true);
> +	if (skb_is_nonlinear(skb)) {
> +		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
> +		xdp_buff_set_frags_flag(xdp);
> +	} else {
> +		xdp_buff_clear_frags_flag(xdp);
> +	}
>=20=20
>  	orig_data_end =3D xdp->data_end;
>  	orig_data =3D xdp->data;
> @@ -4882,6 +4888,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, =
struct xdp_buff *xdp,
>  		skb->len +=3D off; /* positive on grow, negative on shrink */
>  	}
>=20=20
> +	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> +	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 */
> +	if (xdp_buff_has_frags(xdp))
> +		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> +	else
> +		skb->data_len =3D 0;
> +
>  	/* check if XDP changed eth hdr such SKB needs update */
>  	eth =3D (struct ethhdr *)xdp->data;
>  	if ((orig_eth_type !=3D eth->h_proto) ||
> @@ -4927,9 +4941,9 @@ static u32 netif_receive_generic_xdp(struct sk_buff=
 *skb,
>  	if (skb_is_redirected(skb))
>  		return XDP_PASS;
>=20=20
> -	/* XDP packets must be linear and must have sufficient headroom
> -	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
> -	 * native XDP provides, thus we need to do it here as well.
> +	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
> +	 * bytes. This is the guarantee that also native XDP provides,
> +	 * thus we need to do it here as well.
>  	 */
>  	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
>  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> @@ -4943,8 +4957,12 @@ static u32 netif_receive_generic_xdp(struct sk_buf=
f *skb,
>  				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
>  				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
>  			goto do_drop;

There's a comment above the pskb_expand_head() call that isn't quite
part of the context here, that should also be adjusted now that we don't
always linearise:

		/* In case we have to go down the path and also linearize,
		 * then lets do the pskb_expand_head() work just once here.
		 */

Actually, I think maybe just dropping that comment entirely with this
change would make sense?


> -		if (skb_linearize(skb))
> -			goto do_drop;
> +
> +		/* XDP does not support fraglist */
> +		if (skb_has_frag_list(skb) || !xdp_prog->aux->xdp_has_frags) {
> +			if (skb_linearize(skb))
> +				goto do_drop;
> +		}
>  	}
>=20=20
>  	act =3D bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
> --=20
> 2.43.0


