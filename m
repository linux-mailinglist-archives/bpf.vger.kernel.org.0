Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA425537CA
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 18:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352165AbiFUQ0M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351898AbiFUQ0K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 12:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A57112CE3C
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655828768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WDvAfC8H1jWG/kPl4hssaiTNP9VbbBXL1QM5A1sW0U4=;
        b=LWnB0hpqee1bMvMd7UPiLyyWZuMNjw8QBBiAmRK9ESkPAyVMXUVSpVFFUG5xVDeROPdc7w
        on/Bww8mhIQ+6WojjMb+0g6LwzhsXagtOtNCyGDLsxGPFb9NTV+nVRZmNTO9npB/RAI+e/
        /X9MZ4gkyPZD4H+4hJZQiGAmycUCh7U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-xuhUKgBlPCKO57weXIur2Q-1; Tue, 21 Jun 2022 12:26:04 -0400
X-MC-Unique: xuhUKgBlPCKO57weXIur2Q-1
Received: by mail-wr1-f69.google.com with SMTP id v8-20020adfa1c8000000b0021b81a553fbso2771004wrv.18
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDvAfC8H1jWG/kPl4hssaiTNP9VbbBXL1QM5A1sW0U4=;
        b=Zaac59hfrtK6fnlLCXi1Gdsr/NLiFuWFegj7dLFWcFNmBHwZq7FgllNZnpfyCJFEE/
         e7LDN+kcIQ1p+cS9E7GYdMuknFUAuILQyEMfNkkJmPjNWlAqqjvdEuMkwodK/AmMfOJZ
         bSQfQfvLtcgfYra8pngBQeZ0y96Vk3RKGaJ76hFLz8hGR+jrOQcqw6ehlKOyrMciNDqh
         dkwwGSm+w4l+a2tlDkEAEF9WnyLRPCBefbPYkU8F8AKs2uSt19DF3WkupilYisclWIrz
         XLEn/I7dKsEYu3Lv/Fu3AQs4tLtQeOO1odV/6/YMHYV0+ga8MquzhFKdyCdFWVFmyH59
         hdRw==
X-Gm-Message-State: AJIora+lWJ0lzBf1+uPWvHmgZ02MqQlSQ3mgKTDXzzEg+7PP36TEGWm3
        zHS1cIaUQx3XcItgXUEDYUlDbfVCpPqM4QXKNaUAZgVfGZT/w2nCdzdoiLPSUbgK0EhPeFEbIWw
        eibo0NH3jd0J9
X-Received: by 2002:a05:600c:2105:b0:39c:381c:1e13 with SMTP id u5-20020a05600c210500b0039c381c1e13mr31200324wml.189.1655828763407;
        Tue, 21 Jun 2022 09:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tLVVHWep27Pszg8AaHPX0SKs7SwcyIctPWq8R/Dd6xz2vqMeAosqMqmjEE9gIClLLIIqIuEQ==
X-Received: by 2002:a05:600c:2105:b0:39c:381c:1e13 with SMTP id u5-20020a05600c210500b0039c381c1e13mr31200305wml.189.1655828763169;
        Tue, 21 Jun 2022 09:26:03 -0700 (PDT)
Received: from localhost (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id t9-20020adfe109000000b0021018642ff8sm16673450wrz.76.2022.06.21.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:26:02 -0700 (PDT)
Date:   Tue, 21 Jun 2022 18:25:59 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, toke@redhat.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next] samples/bpf: fixup some xdp progs to be able to
 support xdp multibuffer
Message-ID: <YrHxF3j5cqqVWE2y@localhost.localdomain>
References: <20220617220738.3593-1-gospo@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JXivmyhH6RaVy4Gq"
Content-Disposition: inline
In-Reply-To: <20220617220738.3593-1-gospo@broadcom.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--JXivmyhH6RaVy4Gq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This changes the section name for the bpf program embedded in these
> files to "xdp.frags" to allow the programs to be loaded on drivers that
> are using an MTU greater than PAGE_SIZE.  Rather than directly accessing
> the buffers, the packet data is now accessed via xdp helper functions to
> provide an example for those who may need to write more complex
> programs.
>=20
> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>

Hi Andy,

Just 2 nit inline but the code is fine.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  samples/bpf/xdp1_kern.c            | 13 ++++++++++---
>  samples/bpf/xdp2_kern.c            | 13 ++++++++++---
>  samples/bpf/xdp_tx_iptunnel_kern.c |  2 +-
>  3 files changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/samples/bpf/xdp1_kern.c b/samples/bpf/xdp1_kern.c
> index f0c5d95084de..a798553fca3b 100644
> --- a/samples/bpf/xdp1_kern.c
> +++ b/samples/bpf/xdp1_kern.c
> @@ -39,17 +39,24 @@ static int parse_ipv6(void *data, u64 nh_off, void *d=
ata_end)
>  	return ip6h->nexthdr;
>  }
> =20
> -SEC("xdp1")
> +#define XDPBUFSIZE	64
> +SEC("xdp.frags")
>  int xdp_prog1(struct xdp_md *ctx)
>  {
> -	void *data_end =3D (void *)(long)ctx->data_end;
> -	void *data =3D (void *)(long)ctx->data;
> +	__u8 pkt[XDPBUFSIZE] =3D {};
> +	void *data_end =3D &pkt[XDPBUFSIZE-1];
> +	void *data =3D pkt;
>  	struct ethhdr *eth =3D data;
>  	int rc =3D XDP_DROP;
>  	long *value;
>  	u16 h_proto;
>  	u64 nh_off;
>  	u32 ipproto;
> +	int err;
> +
> +	err =3D bpf_xdp_load_bytes(ctx, 0, pkt, sizeof(pkt));
> +	if (err < 0)
> +		return rc;

I guess we do not need err here:

	if (bpf_xdp_load_bytes(ctx, 0, pkt, sizeof(pkt)) < 0)
		return XDP_DROP;

> =20
>  	nh_off =3D sizeof(*eth);
>  	if (data + nh_off > data_end)
> diff --git a/samples/bpf/xdp2_kern.c b/samples/bpf/xdp2_kern.c
> index d8a64ab077b0..1502ef820aed 100644
> --- a/samples/bpf/xdp2_kern.c
> +++ b/samples/bpf/xdp2_kern.c
> @@ -55,17 +55,24 @@ static int parse_ipv6(void *data, u64 nh_off, void *d=
ata_end)
>  	return ip6h->nexthdr;
>  }
> =20
> -SEC("xdp1")
> +#define XDPBUFSIZE	64
> +SEC("xdp.frags")
>  int xdp_prog1(struct xdp_md *ctx)
>  {
> -	void *data_end =3D (void *)(long)ctx->data_end;
> -	void *data =3D (void *)(long)ctx->data;
> +	__u8 pkt[XDPBUFSIZE] =3D {};
> +	void *data_end =3D &pkt[XDPBUFSIZE-1];
> +	void *data =3D pkt;
>  	struct ethhdr *eth =3D data;
>  	int rc =3D XDP_DROP;
>  	long *value;
>  	u16 h_proto;
>  	u64 nh_off;
>  	u32 ipproto;
> +	int err;
> +
> +	err =3D bpf_xdp_load_bytes(ctx, 0, pkt, sizeof(pkt));
> +	if (err < 0)
> +		return rc;

same here

> =20
>  	nh_off =3D sizeof(*eth);
>  	if (data + nh_off > data_end)
> diff --git a/samples/bpf/xdp_tx_iptunnel_kern.c b/samples/bpf/xdp_tx_iptu=
nnel_kern.c
> index 575d57e4b8d6..0e2bca3a3fff 100644
> --- a/samples/bpf/xdp_tx_iptunnel_kern.c
> +++ b/samples/bpf/xdp_tx_iptunnel_kern.c
> @@ -212,7 +212,7 @@ static __always_inline int handle_ipv6(struct xdp_md =
*xdp)
>  	return XDP_TX;
>  }
> =20
> -SEC("xdp_tx_iptunnel")
> +SEC("xdp.frags")
>  int _xdp_tx_iptunnel(struct xdp_md *xdp)
>  {
>  	void *data_end =3D (void *)(long)xdp->data_end;
> --=20
> 2.25.1
>=20



--JXivmyhH6RaVy4Gq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYrHxFAAKCRA6cBh0uS2t
rNXWAQC9RJ9eBhQ8nqZk0eHJVD+XnR8cAsMvS3kRaQcLM0zAMgD+IVGR3IUNouQF
obNO+iYLRxLKVLkqQ5tvRO0Xh0kAyw0=
=LNWy
-----END PGP SIGNATURE-----

--JXivmyhH6RaVy4Gq--

