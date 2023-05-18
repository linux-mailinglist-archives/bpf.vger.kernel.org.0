Return-Path: <bpf+bounces-916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A63708945
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 22:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818DB281A9D
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 20:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B1134C9;
	Thu, 18 May 2023 20:16:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D62134AF
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 20:16:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC810D8
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684440958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4dbLnrsFQB/dr671yZZ2BqBWyzHNhCNJDMFDOMVwd8=;
	b=JIcF5J66vj1g+e4MQ1QDj5/r7t86NpvG3t9vLcOKpoEG0TZRmOd9pDOfoTo413kA8fe/aV
	t4AbkX328SCR91Yk5WvQFVrGxg/du/scRiXjbdu+QcqPlbKLIu14v+zmVkSc7XrytKle1q
	Qxt4cPDR3cj9s+V+5jtprRNfB4BS1LM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-g92ocGkhNuanzWdZIKBTSQ-1; Thu, 18 May 2023 16:15:56 -0400
X-MC-Unique: g92ocGkhNuanzWdZIKBTSQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f42867b47dso14372645e9.2
        for <bpf@vger.kernel.org>; Thu, 18 May 2023 13:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440955; x=1687032955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4dbLnrsFQB/dr671yZZ2BqBWyzHNhCNJDMFDOMVwd8=;
        b=AaQhBPrcW/6DDMaWQvOjEqoFDhhzHi07TDyjXY78CJWrurdD7KldO1udbQb0BBP44q
         UaUgYfI8f8lXWqMpktZJXnr+adTCSzZyp1ffQ5GjPqEfN6Z+tI5l13aAxlNOkh+kEqX9
         W4g58SElneWSDNIgU7VAjW/q7s2jmHi/Yg7TVVevAJUTvWVCQd3H1X4rvN4HeL6lbN7n
         ApTvWDOjgQbWAajwaAab2CBgz9er3zPCrSu7LHa1z1b9dQUACeI192bQMxxG681peb0K
         iTMi4JzpJ7ZRrEudgwaJFsBLkX8tskD2YVkHmvxUUE2mcAjNFsCN3WE/JKCfz55fyc8A
         4JFA==
X-Gm-Message-State: AC+VfDxVVgLhPLAwcs5s70y8HraKNPF1LUx5xPzkNZqb41pVg7mxXGaD
	40xlF71264zsosmAme2JJpy1lnhD6xmtyvOmegSnFTVmzDh+AHVnqXTL9KuWrHyJjXMiinW313M
	bdjdvzwOnW/A0
X-Received: by 2002:a05:600c:220b:b0:3f5:d0b8:4a53 with SMTP id z11-20020a05600c220b00b003f5d0b84a53mr2745162wml.34.1684440955179;
        Thu, 18 May 2023 13:15:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WP++3qbUh8cNx179wrEne1e7LJ/VwBZbAfv/N3saw6OGNrRF6VR6aLIxDd9u6/v/KiCG58A==
X-Received: by 2002:a05:600c:220b:b0:3f5:d0b8:4a53 with SMTP id z11-20020a05600c220b00b003f5d0b84a53mr2745148wml.34.1684440954854;
        Thu, 18 May 2023 13:15:54 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id o5-20020a1c7505000000b003f0ad8d1c69sm240917wmc.25.2023.05.18.13.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:15:54 -0700 (PDT)
Date: Thu, 18 May 2023 22:15:52 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: wei.fang@nxp.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	shenwei.wang@nxp.com, xiaoning.wang@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-imx@nxp.com, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH net-next] net: fec: turn on XDP features
Message-ID: <ZGaHeGUwFdWDthh4@lore-desk>
References: <20230518143236.1638914-1-wei.fang@nxp.com>
 <ZGZkmvX0OLI+4fqY@corigine.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Abo9Bduke0Fad34+"
Content-Disposition: inline
In-Reply-To: <ZGZkmvX0OLI+4fqY@corigine.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--Abo9Bduke0Fad34+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +Lorenzo
>=20
> On Thu, May 18, 2023 at 10:32:36PM +0800, wei.fang@nxp.com wrote:
> > From: Wei Fang <wei.fang@nxp.com>
> >=20
> > The XDP features are supported since the commit 66c0e13ad236
> > ("drivers: net: turn on XDP features"). Currently, the fec
> > driver supports NETDEV_XDP_ACT_BASIC, NETDEV_XDP_ACT_REDIRECT
> > and NETDEV_XDP_ACT_NDO_XMIT. So turn on these XDP features
> > for fec driver.
> >=20
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/fec_main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/et=
hernet/freescale/fec_main.c
> > index cd215ab20ff9..577affda6efa 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -4030,6 +4030,8 @@ static int fec_enet_init(struct net_device *ndev)
> >  	}
> > =20
> >  	ndev->hw_features =3D ndev->features;
> > +	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT=
 |
> > +			     NETDEV_XDP_ACT_NDO_XMIT;

should we check FEC_QUIRK_SWAP_FRAME here? something like:

	if (!(fep->quirks & FEC_QUIRK_SWAP_FRAME)
		ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
				     NETDEV_XDP_ACT_REDIRECT |
				     NETDEV_XDP_ACT_NDO_XMIT;

Regards,
Lorenzo

> > =20
> >  	fec_restart(ndev);
> > =20
> > --=20
> > 2.25.1
> >=20
> >=20
>=20

--Abo9Bduke0Fad34+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZGaHeAAKCRA6cBh0uS2t
rN7NAP4ry0vKmj20KLCmHhYLXOte8cDr0k+KWUnGqFqYLjqttAEAng3fDLIBqD5r
3OEjWoQ6Ut7Sm/4irqcTIw++8nfprws=
=mLbT
-----END PGP SIGNATURE-----

--Abo9Bduke0Fad34+--


