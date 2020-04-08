Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7B1A2299
	for <lists+bpf@lfdr.de>; Wed,  8 Apr 2020 15:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgDHNJg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Apr 2020 09:09:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45747 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728731AbgDHNJg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Apr 2020 09:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586351375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZbQFA2D8jpcYd53d+si3LGCED4GujO47ufGYI//79E=;
        b=UlCMrjEpFVG8jV1XaBGpAWZRXYxw4EZiqVdLGh5SBI8tFPyyP8CzkoH4oHEJmWmxve/CPu
        bVhlmGeg8wmZyBx29qwb9qmBwrP3wV3YV+LMoCeap8eXwieCP/Tl8Br9g9C3EwfwhByQ42
        BrH2xRbDbUe8KtAdpwGAih2CW/52nFI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-VOxfF4cmOBKZPDjz1U3X1A-1; Wed, 08 Apr 2020 09:09:29 -0400
X-MC-Unique: VOxfF4cmOBKZPDjz1U3X1A-1
Received: by mail-wr1-f72.google.com with SMTP id k11so3955051wrm.19
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2020 06:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XZbQFA2D8jpcYd53d+si3LGCED4GujO47ufGYI//79E=;
        b=sM7IwucyVu3vpBJI085WJX94jg29YmsVabu/SjBW34M4M5q98YSRfE4pfME0mmBc00
         2nQe7q3dVqPjJv9IzJWDAK9ANl6eKYCm9vxlvJoF0T1k5HQAUqqwGcE3irqA+28gQVZe
         c6N8dTfWrD5YDhls2qArKBJx3G4LRPH1Km2Q93a4eg6XQIf6Y7pYPcGs3IJ0PRL6v18s
         P3TE3aUgLTqdEGZYbA9bvCXwYTSijK6kWN183DWZbLk5rVnugUkM73LXns6+FL8FOUK8
         tQJT/vkFcdkgxfwXD8/CzGdks/1Qd2FP9TVjSuHqtnxqBS20ta9pjfNhzmhuD2OUMCWm
         kBAg==
X-Gm-Message-State: AGi0PuZEdrjZBXhTn/THa5rrad3PJfy8DyYlvQkBsesQLg5PdcEDj6P3
        RIcKCBjVjC4VaVncv+Li4MSKnApw2/OI/mSismfwjJwTDrC7I+OBQocJytl44PfC+H1Z6bhpdeZ
        kWOeTfBPkVXcq
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr8238619wrv.348.1586351368524;
        Wed, 08 Apr 2020 06:09:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypK7YzRW6g3Gx8dS+PhbpTtWO6AQHIGhZ5y66OwgmauvrHCSkg2yiA2BqczlD960VkbRLIHQdA==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr8238592wrv.348.1586351368292;
        Wed, 08 Apr 2020 06:09:28 -0700 (PDT)
Received: from lore-desk-wlan ([151.48.151.50])
        by smtp.gmail.com with ESMTPSA id h13sm10717701wru.64.2020.04.08.06.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:09:27 -0700 (PDT)
Date:   Wed, 8 Apr 2020 15:09:23 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     sameehj@amazon.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH RFC v2 05/33] net: netsec: Add support for XDP frame size
Message-ID: <20200408130923.GA9157@lore-desk-wlan>
References: <158634658714.707275.7903484085370879864.stgit@firesoul>
 <158634665970.707275.15490233569929847990.stgit@firesoul>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <158634665970.707275.15490233569929847990.stgit@firesoul>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> This driver takes advantage of page_pool PP_FLAG_DMA_SYNC_DEV that
> can help reduce the number of cache-lines that need to be flushed
> when doing DMA sync for_device. Due to xdp_adjust_tail can grow the
> area accessible to the by the CPU (can possibly write into), then max
> sync length *after* bpf_prog_run_xdp() needs to be taken into account.
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  drivers/net/ethernet/socionext/netsec.c |   30 ++++++++++++++++++-------=
-----
>  1 file changed, 18 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethern=
et/socionext/netsec.c
> index a5a0fb60193a..e1f4be4b3d69 100644
> --- a/drivers/net/ethernet/socionext/netsec.c
> +++ b/drivers/net/ethernet/socionext/netsec.c
> @@ -884,23 +884,28 @@ static u32 netsec_run_xdp(struct netsec_priv *priv,=
 struct bpf_prog *prog,
>  			  struct xdp_buff *xdp)
>  {
>  	struct netsec_desc_ring *dring =3D &priv->desc_ring[NETSEC_RING_RX];
> -	unsigned int len =3D xdp->data_end - xdp->data;
> +	unsigned int sync, len =3D xdp->data_end - xdp->data;
>  	u32 ret =3D NETSEC_XDP_PASS;
> +	struct page *page;
>  	int err;
>  	u32 act;
> =20
>  	act =3D bpf_prog_run_xdp(prog, xdp);
> =20
> +	/* Due xdp_adjust_tail: DMA sync for_device cover max len CPU touch */
> +	sync =3D xdp->data_end - xdp->data_hard_start - NETSEC_RXBUF_HEADROOM;
> +	sync =3D max(sync, len);
> +
>  	switch (act) {
>  	case XDP_PASS:
>  		ret =3D NETSEC_XDP_PASS;
>  		break;
>  	case XDP_TX:
>  		ret =3D netsec_xdp_xmit_back(priv, xdp);
> -		if (ret !=3D NETSEC_XDP_TX)
> -			page_pool_put_page(dring->page_pool,
> -					   virt_to_head_page(xdp->data), len,
> -					   true);
> +		if (ret !=3D NETSEC_XDP_TX) {
> +			page =3D virt_to_head_page(xdp->data);
> +			page_pool_put_page(dring->page_pool, page, sync, true);
> +		}
>  		break;
>  	case XDP_REDIRECT:
>  		err =3D xdp_do_redirect(priv->ndev, xdp, prog);
> @@ -908,9 +913,8 @@ static u32 netsec_run_xdp(struct netsec_priv *priv, s=
truct bpf_prog *prog,
>  			ret =3D NETSEC_XDP_REDIR;
>  		} else {
>  			ret =3D NETSEC_XDP_CONSUMED;
> -			page_pool_put_page(dring->page_pool,
> -					   virt_to_head_page(xdp->data), len,
> -					   true);
> +			page =3D virt_to_head_page(xdp->data);
> +			page_pool_put_page(dring->page_pool, page, sync, true);
>  		}
>  		break;
>  	default:
> @@ -921,8 +925,8 @@ static u32 netsec_run_xdp(struct netsec_priv *priv, s=
truct bpf_prog *prog,
>  		/* fall through -- handle aborts by dropping packet */
>  	case XDP_DROP:
>  		ret =3D NETSEC_XDP_CONSUMED;
> -		page_pool_put_page(dring->page_pool,
> -				   virt_to_head_page(xdp->data), len, true);
> +		page =3D virt_to_head_page(xdp->data);
> +		page_pool_put_page(dring->page_pool, page, sync, true);
>  		break;
>  	}
> =20
> @@ -936,10 +940,14 @@ static int netsec_process_rx(struct netsec_priv *pr=
iv, int budget)
>  	struct netsec_rx_pkt_info rx_info;
>  	enum dma_data_direction dma_dir;
>  	struct bpf_prog *xdp_prog;
> +	struct xdp_buff xdp;
>  	u16 xdp_xmit =3D 0;
>  	u32 xdp_act =3D 0;
>  	int done =3D 0;
> =20
> +	xdp.rxq =3D &dring->xdp_rxq;
> +	xdp.frame_sz =3D PAGE_SIZE;
> +
>  	rcu_read_lock();
>  	xdp_prog =3D READ_ONCE(priv->xdp_prog);
>  	dma_dir =3D page_pool_get_dma_dir(dring->page_pool);
> @@ -953,7 +961,6 @@ static int netsec_process_rx(struct netsec_priv *priv=
, int budget)
>  		struct sk_buff *skb =3D NULL;
>  		u16 pkt_len, desc_len;
>  		dma_addr_t dma_handle;
> -		struct xdp_buff xdp;
>  		void *buf_addr;
> =20
>  		if (de->attr & (1U << NETSEC_RX_PKT_OWN_FIELD)) {
> @@ -1002,7 +1009,6 @@ static int netsec_process_rx(struct netsec_priv *pr=
iv, int budget)
>  		xdp.data =3D desc->addr + NETSEC_RXBUF_HEADROOM;
>  		xdp_set_data_meta_invalid(&xdp);
>  		xdp.data_end =3D xdp.data + pkt_len;
> -		xdp.rxq =3D &dring->xdp_rxq;
> =20
>  		if (xdp_prog) {
>  			xdp_result =3D netsec_run_xdp(priv, xdp_prog, &xdp);
>=20
>=20

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXo3NAQAKCRA6cBh0uS2t
rDl7APoD2SBpSP768xvL4g6PkdSEwigyyltlMEU4RTP+dXu8fgD7BsrK1X4hM58O
afaiIsVcdx//u5LiLpryY03/U8S1Pgc=
=SjoV
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

