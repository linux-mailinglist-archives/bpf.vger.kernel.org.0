Return-Path: <bpf+bounces-53718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01BBA5924E
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BD616BAE8
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C0A226D18;
	Mon, 10 Mar 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ir5/tmEI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77C1B4138
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605050; cv=none; b=U1OuuXHI4Y5VnwnkepEX1i5mIo5zurLUaNzlep+siFYQqly/CaQAHNLwZv4qF1r/I9fNcHxcA10k9PvQsImfdOFu8bhX/jCU5+kEY2IvAebbWoPas2/duKvTIXCUGKJtyUd63hwYaEViYZxr6lBb2Jid8v4IQpOZd+120EsvHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605050; c=relaxed/simple;
	bh=DUGY4RyTyyLtGebb4mM1O6agnYPAK8XjRLZ4xWFyKiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6Ge3g+jASQXeaeVvEZchrVA50+qBBu3hJMVuBLVNL+Hwx/EvTffDA+laNhcf4mC9L9iMh2WT96mGltPBljFTWl4dclt8q/eQBv8huEUGcHyTBMqALSF/8woIz4pH0kuA0TVXDKWXI7kOUhRrODt+7uly3/WIn6t9x9S0jgXXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ir5/tmEI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741605047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jWsvyVdHh4CdZ3fxBfjm7tC0neUuEN9Dv7lVimkztQ=;
	b=Ir5/tmEIndysYNvT8hHFxZ91irWao47ueoWVCdGN92DuSetv98fQ/VlpbFJ6TUPKp5CQik
	epc9LUyFczRGHpCFWrpn60qAiSr8M+cSJF0EaUPUlzn2aCz8uUXLtXr0y5uTZFcSrOj4Wy
	576XCQyC5iGnT9NkREB4P8Mugd4dsA0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-B9U_oP88Ng29OBznR627UQ-1; Mon, 10 Mar 2025 07:10:43 -0400
X-MC-Unique: B9U_oP88Ng29OBznR627UQ-1
X-Mimecast-MFC-AGG-ID: B9U_oP88Ng29OBznR627UQ_1741605043
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cebfa08ccso10485515e9.2
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 04:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741605042; x=1742209842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jWsvyVdHh4CdZ3fxBfjm7tC0neUuEN9Dv7lVimkztQ=;
        b=stnzcRk7Fj85DzqqOqv6PkDxdWDz1u2Uel3qVfMPGLgjmIDhOOeFdNSm4083skJHFZ
         EehouUr3TgQv96VCII/ZXW0zQW56fJF+PvZURzqwgEXyQKfwUijZ+gSilizi3Wb7yOqy
         yx1HG1sxjb//T5mCL13MQvmgEaLX0VcjRrSkEJ/dx38BstZBGIvVoHRRxQcr9OYwo/W6
         q7/RZmfGrCq6F8j7rrWpVT1OFWRwImpwidLKpZtpJCvExTm4cnBgYYu1cKfWqV0gItIo
         L9iV9f89VxeETE40pe05/SOhGH+5KGP7W4LrB1LQmWSy6RMW+5P/ajjygcVjvXEqjU75
         1gbg==
X-Forwarded-Encrypted: i=1; AJvYcCUQu0+JwhDMLllBBlO5dZrEer2/l/f8j1vWQLz8CxlJX6pz4afgOssP7hBJKPaZQK9LbQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEkq+nW9pBupN9fok+IYHZyxiHsu1Uk4s1dAFxUH+K77GL/mB
	3WZ1H9dzudqizb8Plag57MqqbbO2sfmCgkoYkeJ/I5s1Ogs1Syg+BUuynyHGlx/ETm7WMY7j1Ee
	of4DZoBSVar76f2GVGaDqV32bV8W0Tl6VVw4hPXh3kXIop1UmsQ==
X-Gm-Gg: ASbGncsvJv+KFe0YAfc8SaRD5obR3MnX6dAuFB5tp11wHdyLeK7cULOYnHy9qiWh+gE
	hbFjkZYliqkqTBbXwjTwwQGfnt41lczgiVUoReJPelMUsqBgzV1or2/9bycK+bPf3M9IWzb3W81
	FBIHnVvrZSIjXsYqSNmcSjYpnpUqYK4a5IRO9OnJske8jFDvR7Yz7v7yi73YqTB+YDHYZZRAeNk
	k2XtrvaZuUnYmdPx6aF67LzxIZmEidVIm9n05jEjnPMjmnZQ6oaSo8Wl5I/uucm3XEa+ITMkpr3
	1QTiVHLYmN0e5wjGp1iMiEWE9YgElgTjXBjig1x5IOuMaqJeLDLCZzs8VrwmhZg=
X-Received: by 2002:a05:600c:198d:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-43cfdbe4493mr8051365e9.6.1741605042525;
        Mon, 10 Mar 2025 04:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxQKAfcGbfVbc7RudCGgbeyKyDopEFEZ7+6RTPv/GSQ7F2awFFsus6B9IaNk9E9lRJ5njVvw==
X-Received: by 2002:a05:600c:198d:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-43cfdbe4493mr8051125e9.6.1741605042048;
        Mon, 10 Mar 2025 04:10:42 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea4619e9sm57800125e9.1.2025.03.10.04.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 04:10:41 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:10:40 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Arthur Fabre <arthur@arthurfabre.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
	yan@cloudflare.com, jbrandeburg@cloudflare.com, thoiland@redhat.com,
	lbiancon@redhat.com, Arthur Fabre <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 07/20] xdp: Track if metadata is supported
 in xdp_frame <> xdp_buff conversions
Message-ID: <Z87IsCfNrjEKCHz0@lore-desk>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
 <20250305-afabre-traits-010-rfc2-v1-7-d0ecfb869797@cloudflare.com>
 <bc356c91-5bff-454a-8f87-7415cb7e82b4@intel.com>
 <D88HSZ3GZZNN.160YSWHX1HIO2@arthurfabre.com>
 <45522396-0fad-406e-ba53-0bb4aee53e67@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JtkONm/S2nFS2F49"
Content-Disposition: inline
In-Reply-To: <45522396-0fad-406e-ba53-0bb4aee53e67@kernel.org>


--JtkONm/S2nFS2F49
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > >=20
>=20
> I'm fairly sure that all drivers support XDP_REDIRECT.
> Except didn't Lorenzo add a feature bit for this?
> (so, some drivers might explicitly not-support this)

I think most of the drivers support XDP_REDIRECT. IIRC just some vf
implementations (e.g. ixgbevf or thunder/nicvf do not support XDP_REDIRECT).
Maybe nfp is a special case.

Regards,
Lorenzo

>=20
> > > So maybe we need to fix those drivers first, if there are any.
> >=20
> > Most drivers don't support metadata unfortunately:
> >=20
> > > rg -U "xdp_prepare_buff\([^)]*false\);" drivers/net/
> > drivers/net/tun.c
> > 1712:		xdp_prepare_buff(&xdp, buf, pad, len, false);
> >=20
> > drivers/net/ethernet/microsoft/mana/mana_bpf.c
> > 94:	xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, false);
> >=20
> > drivers/net/ethernet/marvell/mvneta.c
> > 2344:	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_=
SIZE,
> > 2345:			 data_len, false);
> >=20
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > 1436:	xdp_prepare_buff(&xdp, hard_start, OTX2_HEAD_ROOM,
> > 1437:			 cqe->sg.seg_size, false);
> >=20
> > drivers/net/ethernet/socionext/netsec.c
> > 1021:		xdp_prepare_buff(&xdp, desc->addr, NETSEC_RXBUF_HEADROOM,
> > 1022:				 pkt_len, false);
> >=20
> > drivers/net/ethernet/google/gve/gve_rx.c
> > 740:	xdp_prepare_buff(&new, frame, headroom, len, false);
> > 859:		xdp_prepare_buff(&xdp, page_info->page_address +
> > 860:				 page_info->page_offset, GVE_RX_PAD,
> > 861:				 len, false);
> >=20
> > drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > 3984:			xdp_prepare_buff(&xdp, data,
> > 3985:					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
> > 3986:					 rx_bytes, false);
> >=20
> > drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> > 794:		xdp_prepare_buff(&xdp, hard_start, rx_ring->page_offset,
> > 795:				 buff->len, false);
> >=20
> > drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > 554:	xdp_prepare_buff(&xdp, hard_start, data - hard_start, len, false);
> >=20
> > drivers/net/ethernet/ti/cpsw_new.c
> > 348:		xdp_prepare_buff(&xdp, pa, headroom, size, false);
> >=20
> > drivers/net/ethernet/freescale/enetc/enetc.c
> > 1710:	xdp_prepare_buff(xdp_buff, hard_start - rx_ring->buffer_offset,
> > 1711:			 rx_ring->buffer_offset, size, false);
> >=20
> > drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > 1335:		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
> > 1336:				 pkt_len, false);
> >=20
> > drivers/net/ethernet/ti/cpsw.c
> > 403:		xdp_prepare_buff(&xdp, pa, headroom, size, false);
> >=20
> > drivers/net/ethernet/sfc/rx.c
> > 289:	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
> > 290:			 rx_buf->len, false);
> >=20
> > drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > 2097:			xdp_prepare_buff(&xdp, data, MTK_PP_HEADROOM, pktlen,
> > 2098:					 false);
> >=20
> > drivers/net/ethernet/sfc/siena/rx.c
> > 291:	xdp_prepare_buff(&xdp, *ehp - EFX_XDP_HEADROOM, EFX_XDP_HEADROOM,
> > 292:			 rx_buf->len, false)
> >=20
> > I don't know if it's just because no one has added calls to
> > skb_metadata_set() in yet, or if there's a more fundamental reason.
> >=20
>=20
> I simply think driver developers have been lazy.
>=20
> If someone want some easy kernel commits, these drivers should be fairly
> easy to fix...
>=20
> > I think they all reserve some amount of headroom, but not always the
> > full XDP_PACKET_HEADROOM. Eg sfc:
> >=20
>=20
> The Intel drivers use 192 (AFAIK if that is still true). The API ended
> up supporting non-standard XDP_PACKET_HEADROOM, due to the Intel
> drivers, when XDP support was added to those (which is a long time ago no=
w).
>=20
> > drivers/net/ethernet/sfc/net_driver.h:
> > /* Non-standard XDP_PACKET_HEADROOM and tailroom to satisfy XDP_REDIREC=
T and
> >   * still fit two standard MTU size packets into a single 4K page.
> >   */
> > #define EFX_XDP_HEADROOM	128
> >=20
>=20
> This is smaller than most drivers, but still have enough headroom for
> xdp_frame + traits.
>=20
> > If it's just because skb_metadata_set() is missing, I can take the
> > patches from this series that adds a "generic" XDP -> skb hook ("trait:
> > Propagate presence of traits to sk_buff"), have it call
> > skb_metadata_set(), and try to add it to all the drivers in a separate
> > series.
> >=20
>=20
> I think someone should cleanup those drivers and add support.
>=20
> --Jesper
>=20
> > > >   	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
> > > >   	 * while mem_type is valid on remote CPU.
> > > >   	 */
> > > > @@ -369,6 +374,8 @@ void xdp_convert_frame_to_buff(const struct xdp=
_frame *frame,
> > > >   	xdp->data =3D frame->data;
> > > >   	xdp->data_end =3D frame->data + frame->len;
> > > >   	xdp->data_meta =3D frame->data - frame->metasize;
> > > > +	if (frame->meta_unsupported)
> > > > +		xdp_set_data_meta_invalid(xdp);
> > > >   	xdp->frame_sz =3D frame->frame_sz;
> > > >   	xdp->flags =3D frame->flags;
> > > >   }
> > > > @@ -396,6 +403,7 @@ int xdp_update_frame_from_buff(const struct xdp=
_buff *xdp,
> > > >   	xdp_frame->len  =3D xdp->data_end - xdp->data;
> > > >   	xdp_frame->headroom =3D headroom - sizeof(*xdp_frame);
> > > >   	xdp_frame->metasize =3D metasize;
> > > > +	xdp_frame->meta_unsupported =3D xdp_data_meta_unsupported(xdp);
> > > >   	xdp_frame->frame_sz =3D xdp->frame_sz;
> > > >   	xdp_frame->flags =3D xdp->flags;
> > >=20
> > > Thanks,
> > > Olek
>=20

--JtkONm/S2nFS2F49
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ87IsAAKCRA6cBh0uS2t
rK6DAQD8r1mxdVzGu3go8xjrg+CDLC/xqM32YU4Lm0ICfcuq3AD/ZtDKNq13aynZ
k34lgXcO45VmQl+CqVUCjXsiFrZgmAw=
=7cKB
-----END PGP SIGNATURE-----

--JtkONm/S2nFS2F49--


