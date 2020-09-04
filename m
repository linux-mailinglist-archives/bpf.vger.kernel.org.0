Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF61B25DBA3
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgIDO1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 10:27:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51484 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730833AbgIDO1b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 10:27:31 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-qx01OkyVPs69PR_rfSwa9Q-1; Fri, 04 Sep 2020 10:27:28 -0400
X-MC-Unique: qx01OkyVPs69PR_rfSwa9Q-1
Received: by mail-ej1-f71.google.com with SMTP id b23so2642332ejv.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 07:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J53E4/YgiJkaUhyBjiz/oUIyxfEdmyQnv9Bdln6ibCU=;
        b=P6Lf53haF5iX2xckt10tY9YmGQYz1N+YdJU3w2j1Ru9CKYtbz6AT3mtpI+sv3W8imh
         a4XP1ZqdYOaAVcyUJ0GfBHcWY22lg2CWtxey18X28+Fogd9l7SnoQLPa8l2tk4DBjgxh
         C0N4R1lkho5pbTp1/QtcMZI693TOYXmFWy80PWN5fF67Dqr2UUI9gVKGYbSgDU4IUZxL
         H5NU93qCvnLUy+FRYthvAppIiPFlGkfJXcsC9za+JdumT66AFNH5mk9nRX+t56ebw71d
         +zcUE//8AQSfoE7W+BzTt2hq9psCMaTpItJbzdwDx0/Jgg0veKPxijZZR87EbP/6Ul80
         FAIQ==
X-Gm-Message-State: AOAM532ztEl1iIQQulqjZWOy6aUS074kA2biOOZjIJsAUNcyo256YCxQ
        d33NZxP6c1BNz3TNXBckvclkxNtbKTlifLut/QX62dh1wxOIpPdSlulMSCIlQWuBA7kMMBPxbhr
        YlfLEmZK8Pz0R
X-Received: by 2002:a05:6402:1d97:: with SMTP id dk23mr9008525edb.350.1599229646972;
        Fri, 04 Sep 2020 07:27:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7RSyfQFxI88r4+Z/a+uLPJFhTbTSmbOOe5F3kaSYTmbC7ht53XAh0/zaSmAdOkDT11Ged2g==
X-Received: by 2002:a05:6402:1d97:: with SMTP id dk23mr9008508edb.350.1599229646716;
        Fri, 04 Sep 2020 07:27:26 -0700 (PDT)
Received: from localhost ([151.66.86.87])
        by smtp.gmail.com with ESMTPSA id o17sm6203758eje.17.2020.09.04.07.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:27:26 -0700 (PDT)
Date:   Fri, 4 Sep 2020 16:27:22 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        echaudro@redhat.com, sameehj@amazon.com, kuba@kernel.org,
        john.fastabend@gmail.com, daniel@iogearbox.net, ast@kernel.org,
        shayagr@amazon.com
Subject: Re: [PATCH v2 net-next 6/9] bpf: helpers: add
 bpf_xdp_adjust_mb_header helper
Message-ID: <20200904142722.GA3941@lore-desk>
References: <cover.1599165031.git.lorenzo@kernel.org>
 <b7475687bb09aac6ec051596a8ccbb311a54cb8a.1599165031.git.lorenzo@kernel.org>
 <20200904011358.kbdxf4awugi3qwjl@ast-mbp.dhcp.thefacebook.com>
 <20200904075031.GC2884@lore-desk>
 <20200904155200.75f8d65a@carbon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20200904155200.75f8d65a@carbon>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 4 Sep 2020 09:50:31 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Thu, Sep 03, 2020 at 10:58:50PM +0200, Lorenzo Bianconi wrote: =20
> > > > +BPF_CALL_2(bpf_xdp_adjust_mb_header, struct  xdp_buff *, xdp,
> > > > +	   int, offset)
> > > > +{
> > > > +	void *data_hard_end, *data_end;
> > > > +	struct skb_shared_info *sinfo;
> > > > +	int frag_offset, frag_len;
> > > > +	u8 *addr;
> > > > +
> > > > +	if (!xdp->mb)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > > > +
> > > > +	frag_len =3D skb_frag_size(&sinfo->frags[0]);
> > > > +	if (offset > frag_len)
> > > > +		return -EINVAL;
> > > > +
> > > > +	frag_offset =3D skb_frag_off(&sinfo->frags[0]);
> > > > +	data_end =3D xdp->data_end + offset;
> > > > +
> > > > +	if (offset < 0 && (-offset > frag_offset ||
> > > > +			   data_end < xdp->data + ETH_HLEN))
> > > > +		return -EINVAL;
> > > > +
> > > > +	data_hard_end =3D xdp_data_hard_end(xdp); /* use xdp->frame_sz */
> > > > +	if (data_end > data_hard_end)
> > > > +		return -EINVAL;
> > > > +
> > > > +	addr =3D page_address(skb_frag_page(&sinfo->frags[0])) + frag_off=
set;
> > > > +	if (offset > 0) {
> > > > +		memcpy(xdp->data_end, addr, offset);
> > > > +	} else {
> > > > +		memcpy(addr + offset, xdp->data_end + offset, -offset);
> > > > +		memset(xdp->data_end + offset, 0, -offset);
> > > > +	}
> > > > +
> > > > +	skb_frag_size_sub(&sinfo->frags[0], offset);
> > > > +	skb_frag_off_add(&sinfo->frags[0], offset);
> > > > +	xdp->data_end =3D data_end;
> > > > +
> > > > +	return 0;
> > > > +} =20
> > >=20
> > > wait a sec. Are you saying that multi buffer XDP actually should be s=
kb based?
> > > If that's what mvneta driver is doing that's fine, but that is not a
> > > reasonable requirement to put on all other drivers. =20
> >=20
> > I did not got what you mean here. The xdp multi-buffer layout uses
> > the skb_shared_info at the end of the first buffer to link subsequent
> > frames [0] and we rely on skb_frag* utilities to set/read offset and
> > length of subsequent buffers.
>=20
> Yes, for now the same layout as "skb_shared_info" is "reuse", but I
> think we should think of this as "xdp_shared_info" instead, as how it
> is used for XDP is going to divert from SKBs.  We already discussed (in
> conf call) that we could store the total len of "frags" here, to
> simplify the other helper.

I like this approach, at the end the first fragment we can have something l=
ike:

struct xdp_shared_info {
	skb_frag_f frags[16];
	int n_frags;
	int frag_len;
};

or do you prefer to not use skb_frag_t struct?

>=20
> Using the skb_frag_* helper functions are misleading, and will make it
> more difficult to divert from how SKB handle frags.  What about
> introducing xdp_frag_* wrappers? (what do others think?)

I am fine with having some dedicated helpers.
Anyway we need to construct the xdp_buff {} receiving the dma descriptors.

Regards,
Lorenzo

>=20
>=20
> >=20
> > [0] http://people.redhat.com/lbiancon/conference/NetDevConf2020-0x14/ad=
d-xdp-on-driver.html
> >     - XDP multi-buffers section (slide 40)
>=20
> --=20
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>=20

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX1JOyAAKCRA6cBh0uS2t
rAjaAQDnmLopcQ8B2Ct8CSLE2XhYrTxrVCQNLNBS2Ljx3oB+AgD/crSW0FIOYsTX
3UaSxWY8CRRQ4k8B12CLOp1995cUlQg=
=2VDs
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

