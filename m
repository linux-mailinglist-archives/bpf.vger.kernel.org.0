Return-Path: <bpf+bounces-20557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30232840252
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 10:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554C41C2115E
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2354455E67;
	Mon, 29 Jan 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gA+U7ENh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39055774;
	Mon, 29 Jan 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522291; cv=none; b=OgDL3dnPZlB96FL5OiSsBe1bD4S/DGxpEVHAno3LKMNcDAs20lN83P1hFrUtJzaGPUTk4Nn9YCKKmjIm8IQwA8UyCSiLy+xIhc1X+qHtoMwslBhKxaQStRV8apXp3DVn3NG9ZJTn0VuWELqR0JHITPDPi1lqDBEkNbPzj9TlBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522291; c=relaxed/simple;
	bh=yBmF8atRzE/jKjGYvhm71cL0rw5MHTlNp0e8Kl6OdBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6Ysreb0FL6s99i+rUDs4fkRiVyLf7pJiSS5Ac4DWlex6yTrM6Fbur4CEgTGLIMGtP0CfGMQkx7yGt/h2SaeCT/P5y/w6OEkIdA4keZJl0Y+nv7bFIEuiHhKBlywqr5/btLIe9+Oxwn/hlT3wAr7rQjyfWDyDIj0IRRu4Csk6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gA+U7ENh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDDBC433F1;
	Mon, 29 Jan 2024 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706522291;
	bh=yBmF8atRzE/jKjGYvhm71cL0rw5MHTlNp0e8Kl6OdBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gA+U7ENhiiFgN0DaPbq96cWnQZZ98kgesGEs/f2zqHBhXs6zTQZZOLNr3lhCNFnBd
	 nWFxeI9nbR832RT/7Q6aWR/J1wsphnTuEUX8wBOo3sYn4xF1sB104qTDlqss55QfyL
	 vmXWUlz4ITr6BtUDMdWMh+kMsrwEflPe6cpyRDzRWTio4DVUIKHtT/exXbaaG8jzbL
	 jRQ0OntOGYScm7/9cusVELTD2Z9Gp9VmCEjDpqaRJjjv79xx6qovzNb3eWnrmKd4ca
	 B/eNEW9dk9yaVRz1cxfYXpmZVtYWHC6jgrZzMqwvAzfRKT2nXZjeEJ42s2oggjojI5
	 v61vbVE5sKP5Q==
Date: Mon, 29 Jan 2024 10:58:07 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org
Subject: Re: [PATCH v6 net-next 2/5] xdp: rely on skb pointer reference in
 do_xdp_generic and netif_receive_generic_xdp
Message-ID: <Zbd2r_F0ob4_dh2j@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <7fd76e88e2aadc03f14b040ffc762e88d05afc8c.1706451150.git.lorenzo@kernel.org>
 <CAC_iWj+qTUmzD6Du-FRf7yhQj-euG3cFHcT5hZccdeP6tB=jGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vs4wSioN5QIjyM7p"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+qTUmzD6Du-FRf7yhQj-euG3cFHcT5hZccdeP6tB=jGg@mail.gmail.com>


--vs4wSioN5QIjyM7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> On Sun, 28 Jan 2024 at 16:22, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >
> > Rely on skb pointer reference instead of the skb pointer in do_xdp_gene=
ric and
> > netif_receive_generic_xdp routine signatures. This is a preliminary pat=
ch to add
> > multi-buff support for xdp running in generic mode.
>=20
> The patch looks fine, but can we tweak the commit message explaining
> in more detail  why this is needed?

ack, I will update commit log in the next iteration.

Regards,
Lorenzo

>=20
> Thanks
> /Ilias
> >
> > Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/tun.c         |  4 ++--
> >  include/linux/netdevice.h |  2 +-
> >  net/core/dev.c            | 16 +++++++++-------
> >  3 files changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 4a4f8c8e79fa..5bd98bdaddf2 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1927,7 +1927,7 @@ static ssize_t tun_get_user(struct tun_struct *tu=
n, struct tun_file *tfile,
> >                 rcu_read_lock();
> >                 xdp_prog =3D rcu_dereference(tun->xdp_prog);
> >                 if (xdp_prog) {
> > -                       ret =3D do_xdp_generic(xdp_prog, skb);
> > +                       ret =3D do_xdp_generic(xdp_prog, &skb);
> >                         if (ret !=3D XDP_PASS) {
> >                                 rcu_read_unlock();
> >                                 local_bh_enable();
> > @@ -2517,7 +2517,7 @@ static int tun_xdp_one(struct tun_struct *tun,
> >         skb_record_rx_queue(skb, tfile->queue_index);
> >
> >         if (skb_xdp) {
> > -               ret =3D do_xdp_generic(xdp_prog, skb);
> > +               ret =3D do_xdp_generic(xdp_prog, &skb);
> >                 if (ret !=3D XDP_PASS) {
> >                         ret =3D 0;
> >                         goto out;
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 118c40258d07..7eee99a58200 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -3958,7 +3958,7 @@ static inline void dev_consume_skb_any(struct sk_=
buff *skb)
> >  u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> >                              struct bpf_prog *xdp_prog);
> >  void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
> > -int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
> > +int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb);
> >  int netif_rx(struct sk_buff *skb);
> >  int __netif_rx(struct sk_buff *skb);
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index bf9ec740b09a..960f39ac5e33 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4924,10 +4924,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *sk=
b, struct xdp_buff *xdp,
> >         return act;
> >  }
> >
> > -static u32 netif_receive_generic_xdp(struct sk_buff *skb,
> > +static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
> >                                      struct xdp_buff *xdp,
> >                                      struct bpf_prog *xdp_prog)
> >  {
> > +       struct sk_buff *skb =3D *pskb;
> >         u32 act =3D XDP_DROP;
> >
> >         /* Reinjected packets coming from act_mirred or similar should
> > @@ -5008,24 +5009,24 @@ void generic_xdp_tx(struct sk_buff *skb, struct=
 bpf_prog *xdp_prog)
> >
> >  static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
> >
> > -int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
> > +int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
> >  {
> >         if (xdp_prog) {
> >                 struct xdp_buff xdp;
> >                 u32 act;
> >                 int err;
> >
> > -               act =3D netif_receive_generic_xdp(skb, &xdp, xdp_prog);
> > +               act =3D netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
> >                 if (act !=3D XDP_PASS) {
> >                         switch (act) {
> >                         case XDP_REDIRECT:
> > -                               err =3D xdp_do_generic_redirect(skb->de=
v, skb,
> > +                               err =3D xdp_do_generic_redirect((*pskb)=
->dev, *pskb,
> >                                                               &xdp, xdp=
_prog);
> >                                 if (err)
> >                                         goto out_redir;
> >                                 break;
> >                         case XDP_TX:
> > -                               generic_xdp_tx(skb, xdp_prog);
> > +                               generic_xdp_tx(*pskb, xdp_prog);
> >                                 break;
> >                         }
> >                         return XDP_DROP;
> > @@ -5033,7 +5034,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, str=
uct sk_buff *skb)
> >         }
> >         return XDP_PASS;
> >  out_redir:
> > -       kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
> > +       kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
> >         return XDP_DROP;
> >  }
> >  EXPORT_SYMBOL_GPL(do_xdp_generic);
> > @@ -5356,7 +5357,8 @@ static int __netif_receive_skb_core(struct sk_buf=
f **pskb, bool pfmemalloc,
> >                 int ret2;
> >
> >                 migrate_disable();
> > -               ret2 =3D do_xdp_generic(rcu_dereference(skb->dev->xdp_p=
rog), skb);
> > +               ret2 =3D do_xdp_generic(rcu_dereference(skb->dev->xdp_p=
rog),
> > +                                     &skb);
> >                 migrate_enable();
> >
> >                 if (ret2 !=3D XDP_PASS) {
> > --
> > 2.43.0
> >

--vs4wSioN5QIjyM7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbd2rwAKCRA6cBh0uS2t
rAgcAP9/aGP8AS8uS4F+3kWSheURWTvv0X06ScOvUty7MYTUvwD/VWCBNuOVqVQl
Ae/RKb64sUJbDw9QpVCfwzBfKKvSiAc=
=SOBX
-----END PGP SIGNATURE-----

--vs4wSioN5QIjyM7p--

