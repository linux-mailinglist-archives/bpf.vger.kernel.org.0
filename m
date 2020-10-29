Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4132729EC93
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 14:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgJ2NQI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 09:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbgJ2NQH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Oct 2020 09:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603977366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Muj7rfopJdT5GXxgbmz6MN0zN66mg2zfOlcoX4apg2U=;
        b=KxocP3sMBDnL8yMLppWUPAPEnfna4O3AORjqGawR6L+3EuNS6nkQzVp/v8/nw3XUBM7iCn
        GowXQ5Th+GRCER3hL+tx7Pff4ZoDEA6wJitavYHnUutEMG+VdAV9P9e0QWQ5QwCFgR+ctV
        cjMxMbka6TGgPvGXapz9FcS2NONUvKM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-U1JSUDMTNm6lkltSAk_uVQ-1; Thu, 29 Oct 2020 09:16:02 -0400
X-MC-Unique: U1JSUDMTNm6lkltSAk_uVQ-1
Received: by mail-wm1-f71.google.com with SMTP id z62so624508wmb.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 06:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Muj7rfopJdT5GXxgbmz6MN0zN66mg2zfOlcoX4apg2U=;
        b=RJAT2Cmq+MIZhKAmhJ0zOHjAOvCRaKI7MJz4pTSk8hOfI9+wFbFP0ieKMP+j12ubIR
         J5Z8U+9pu72wpZIxPJGB6WAIR0318C6JkTeHjHSGFaRABjs//PhreOgrDqt+cevD2QX0
         HCJyLZdFM9iSatz5Q/FayOMaai9IQGYYCC4SnIKyUy+t7K1zvaIOlM82DOHgDdQ6eLj6
         9P9KNCdlzqr2F21d1PevrCSOi6FhLePaAOTVq2yR3yaDYZnqIPUNTPwQOhJRZLvMRmXU
         nK5LZplcUq14p+QvL2LM0FvtKsf6/BDIr6swKmTddy4QRAlGtJIFh3lMQWPvX2ALgkN1
         dTqg==
X-Gm-Message-State: AOAM533hhvcKCV2WsrtEJGmLS9VJr0eMQneoQnk3phdBq3x5oNx4JXEE
        2AKxQ1QtM616RGVNZ+IAHh55x/6a5iytfS60LXkEssBTMGyE0pfS/1pBSARq7VndOfEUKnZ2S1E
        K8RK4kcnzowh/
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr1119010wru.110.1603977361680;
        Thu, 29 Oct 2020 06:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLyOTtBflIRAtSHTw049p4CwhBZ4wv+1QG8wuAgURjOU43jVnWhEmmjPA63xJbrw09Hfa78A==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr1118983wru.110.1603977361464;
        Thu, 29 Oct 2020 06:16:01 -0700 (PDT)
Received: from localhost ([151.66.29.159])
        by smtp.gmail.com with ESMTPSA id f7sm5402588wrx.64.2020.10.29.06.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 06:16:00 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:15:57 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Shay Agroskin <shayagr@amazon.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        brouer@redhat.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 4/4] net: mlx5: add xdp tx return bulking support
Message-ID: <20201029131557.GD15697@lore-desk>
References: <cover.1603824486.git.lorenzo@kernel.org>
 <3fb334388ac7af755e1f03abb76a0a6335a90ff6.1603824486.git.lorenzo@kernel.org>
 <pj41zl5z6tl0ln.fsf@u68c7b5b1d2d758.ant.amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <pj41zl5z6tl0ln.fsf@u68c7b5b1d2d758.ant.amazon.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Convert mlx5 driver to xdp_return_frame_bulk APIs.
> >=20
> > XDP_REDIRECT (upstream codepath): 8.5Mpps
> > XDP_REDIRECT (upstream codepath + bulking APIs): 10.1Mpps
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > index ae90d533a350..5fdfbf390d5c 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > @@ -369,8 +369,10 @@ static void mlx5e_free_xdpsq_desc(struct
> > mlx5e_xdpsq *sq,
> >  				  bool recycle)
> >  {
> >  	struct mlx5e_xdp_info_fifo *xdpi_fifo =3D &sq->db.xdpi_fifo;
> > +	struct xdp_frame_bulk bq;
> >  	u16 i;
> > +	bq.xa =3D NULL;
> >  	for (i =3D 0; i < wi->num_pkts; i++) {
> >  		struct mlx5e_xdp_info xdpi =3D  mlx5e_xdpi_fifo_pop(xdpi_fifo);
> >   @@ -379,7 +381,7 @@ static void mlx5e_free_xdpsq_desc(struct
> > mlx5e_xdpsq *sq,
> >  			/* XDP_TX from the XSK RQ and XDP_REDIRECT  */
> >  			dma_unmap_single(sq->pdev,  xdpi.frame.dma_addr,
> >  					 xdpi.frame.xdpf->len,  DMA_TO_DEVICE);
> > -			xdp_return_frame(xdpi.frame.xdpf);
> > +			xdp_return_frame_bulk(xdpi.frame.xdpf, &bq);
> >  			break;
> >  		case MLX5E_XDP_XMIT_MODE_PAGE:
> >  			/* XDP_TX from the regular RQ */
> > @@ -393,6 +395,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq
> > *sq,
> >  			WARN_ON_ONCE(true);
> >  		}
> >  	}
> > +	xdp_flush_frame_bulk(&bq);
>=20
> While I understand the rational behind this patchset, using an intermedia=
te
> buffer
> 	void *q[XDP_BULK_QUEUE_SIZE];
> means more pressure on the data cache.
>=20
> At the time I ran performance tests on mlx5 to see whether batching skbs
> before passing them to GRO would improve performance. On some flows I got
> worse performance.
> This function seems to have less Dcache contention than RX flow, but maybe
> some performance testing are needed here.

Hi Shay,

this codepath is only activated for "redirected" frames (not for packets
forwarded to networking stack). We run performance comparisons with the
upstream code for this particular use-case and we reported a nice
improvements (8.5Mpps vs 10.1Mpps).
Do you have in mind other possible performance tests to run?

Regards,
Lorenzo

>=20
> >  }
> >  bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
>=20

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX5rAiwAKCRA6cBh0uS2t
rKpnAQDF5IDwaXJAWrR9t1aSM2K8nTSG08HxjOPov0dGtP22YQD/Zz/zJX4c1r1s
1PGjPLVPMiWUTc6q4awwJcjxotkXlQM=
=aXPB
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

