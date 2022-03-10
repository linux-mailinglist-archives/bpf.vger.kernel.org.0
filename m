Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA74D5204
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 20:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbiCJT1O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 14:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbiCJT1M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 14:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 227AE137032
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 11:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646940370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p9coYP+KrszVJ1fGBd535mC7HRS8xrMw8GNaRnHQitY=;
        b=ZEZoGt09lSiGy4eht2cLM5SC3TtF5CI68LEvEkNXjcwcHUxs/5ckzMkfNRLbyTMwnTq7zB
        mzcSMrCL7Nubys6c8+fF/8GL1WQRG3hc7feQcLBS5+bXpUkUIzLc+hPQu3wA2rk1FBupNP
        k9d/jjc4Dwwo8l+LxqrYHGbXoX0UE8o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-3H7-lb-6M4Wh6jH7YfhrKQ-1; Thu, 10 Mar 2022 14:26:08 -0500
X-MC-Unique: 3H7-lb-6M4Wh6jH7YfhrKQ-1
Received: by mail-qk1-f198.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso4587931qkl.7
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 11:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p9coYP+KrszVJ1fGBd535mC7HRS8xrMw8GNaRnHQitY=;
        b=q0MqjTfzXJWybu1pJzzEMlYQPhuuJrqlbm3iIddo/S57sGsKHjcJZjlCsNbDXWxPYg
         Wpz5qmWsu9LG34uj8iXEXRmbuhJ2StksvJzvuyTpf5f2LgrJtdrtcgoCAepd4n25Up2h
         ZG66UED6VSV8SxtK+7YtcDS6zRY/Cf7VOmLuxkIDvYgdL5HwP3GHWgxUBJoyRAPP/Cqc
         juu3v8XYBVHDQiGhz7/uKNgTgqbAJrmDAD8FRc6/e/aq6zDR24I+SQwkwSiF2ZeBYbxC
         +h0dem+HFY7VXFo73fJRiYc5Wi8kGEtyYGoSiRDsRj2bXcVZfDJRvUQgrQvFdq7kFvz2
         XS+g==
X-Gm-Message-State: AOAM532gszq+ROF51MntV6HxtoQzUhbb1MYDTpeVWdSK0uyyiALWJwKq
        Qw37OROxurr7s4RGJXRfMvl8NTcJ1NInWDHcMl5ffMExj7jpZsvS/0hJ+yjzOQKFLUIIg79191E
        RGT6zA9r/U7dI
X-Received: by 2002:a05:620a:16c5:b0:67d:47db:8b50 with SMTP id a5-20020a05620a16c500b0067d47db8b50mr4216835qkn.77.1646940367964;
        Thu, 10 Mar 2022 11:26:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWTt9X3fNY0XWma+IQ3fQzwxQiF6AISWw0rtWKaGJCtaDhRstAOr2xE/BDAtTTbtzB9r9mLQ==
X-Received: by 2002:a05:620a:16c5:b0:67d:47db:8b50 with SMTP id a5-20020a05620a16c500b0067d47db8b50mr4216818qkn.77.1646940367598;
        Thu, 10 Mar 2022 11:26:07 -0800 (PST)
Received: from localhost ([37.183.9.66])
        by smtp.gmail.com with ESMTPSA id h14-20020a05622a170e00b002e1a65754d8sm2698483qtk.91.2022.03.10.11.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 11:26:07 -0800 (PST)
Date:   Thu, 10 Mar 2022 20:26:04 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, brouer@redhat.com,
        pabeni@redhat.com, echaudro@redhat.com, toshiaki.makita1@gmail.com,
        andrii@kernel.org
Subject: Re: [PATCH v4 bpf-next 2/3] veth: rework veth_xdp_rcv_skb in order
 to accept non-linear skb
Message-ID: <YipQzAGMyVbJQyhX@lore-desk>
References: <cover.1646755129.git.lorenzo@kernel.org>
 <24703dbc3477a4b3aaf908f6226a566d27969f83.1646755129.git.lorenzo@kernel.org>
 <87ee3auk70.fsf@toke.dk>
 <YinkUiv/yC/gJhYZ@lore-desk>
 <87ilsly6db.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w72cXKqn55jNfhLL"
Content-Disposition: inline
In-Reply-To: <87ilsly6db.fsf@toke.dk>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--w72cXKqn55jNfhLL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> > Introduce veth_convert_xdp_buff_from_skb routine in order to
> >> > convert a non-linear skb into a xdp buffer. If the received skb
> >> > is cloned or shared, veth_convert_xdp_buff_from_skb will copy it
> >> > in a new skb composed by order-0 pages for the linear and the
> >> > fragmented area. Moreover veth_convert_xdp_buff_from_skb guarantees
> >> > we have enough headroom for xdp.
> >> > This is a preliminary patch to allow attaching xdp programs with fra=
gs
> >> > support on veth devices.
> >> >
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>=20
> >> It's cool that we can do this! A few comments below:
> >
> > Hi Toke,
> >
> > thx for the review :)
> >
> > [...]
> >
> >> > +static int veth_convert_xdp_buff_from_skb(struct veth_rq *rq,
> >> > +					  struct xdp_buff *xdp,
> >> > +					  struct sk_buff **pskb)
> >> > +{
> >>=20
> >> nit: It's not really "converting" and skb into an xdp_buff, since the
> >> xdp_buff lives on the stack; so maybe 'veth_init_xdp_buff_from_skb()'?
> >
> > I kept the previous naming convention used for xdp_convert_frame_to_buf=
f()
> > (my goal would be to move it in xdp.c and reuse this routine for the
> > generic-xdp use case) but I am fine with
> > veth_init_xdp_buff_from_skb().
>=20
> Consistency is probably good, but right now we have functions of the
> form 'xdp_convert_X_to_Y()' and 'xdp_update_Y_from_X()'. So to follow
> that you'd have either 'veth_update_xdp_buff_from_skb()' or
> 'veth_convert_skb_to_xdp_buff()' :)

ack, I am fine with veth_convert_skb_to_xdp_buff()

>=20
> >> > +	struct sk_buff *skb =3D *pskb;
> >> > +	u32 frame_sz;
> >> > =20
> >> >  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
> >> > -	    skb_is_nonlinear(skb) || headroom < XDP_PACKET_HEADROOM) {
> >> > +	    skb_shinfo(skb)->nr_frags) {
> >>=20
> >> So this always clones the skb if it has frags? Is that really needed?
> >
> > if we look at skb_cow_data(), paged area is always considered not writa=
ble
>=20
> Ah, right, did not know that. Seems a bit odd, but OK.
>=20
> >> Also, there's a lot of memory allocation and copying going on here; ha=
ve
> >> you measured the performance?
> >
> > even in the previous implementation we always reallocate the skb if the
> > conditions above are verified so I do not expect any difference in the =
single
> > buffer use-case but I will run some performance tests.
>=20
> No, I wouldn't expect any difference for the single-buffer case, but I
> would also be interested in how big the overhead is of having to copy
> the whole jumbo-frame?

oh ok, I got what you mean. I guess we can compare the tcp throughput for
the legacy skb mode (when no program is attached on the veth pair) and xdp=
=20
mode (when we load a simple xdp program that just returns xdp_pass) when
jumbo frames are enabled. I would expect a performance penalty but let's se=
e.

>=20
> BTW, just noticed one other change - before we had:
>=20
> > -	headroom =3D skb_headroom(skb) - mac_len;
> >  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
> > -	    skb_is_nonlinear(skb) || headroom < XDP_PACKET_HEADROOM) {
>=20
>=20
> And in your patch that becomes:
>=20
> > +	} else if (skb_headroom(skb) < XDP_PACKET_HEADROOM &&
> > +		   pskb_expand_head(skb, VETH_XDP_HEADROOM, 0, GFP_ATOMIC)) {
> > +		goto drop;
>=20
>=20
> So the mac_len subtraction disappeared; that seems wrong?

we call __skb_push before running veth_convert_xdp_buff_from_skb() in
veth_xdp_rcv_skb().

>=20
> >> > +
> >> > +	if (xdp_buff_has_frags(&xdp))
> >> > +		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> >> > +	else
> >> > +		skb->data_len =3D 0;
> >>=20
> >> We can remove entire frags using xdp_adjust_tail, right? Will that get
> >> propagated in the right way to the skb frags due to the dual use of
> >> skb_shared_info, or?
> >
> > bpf_xdp_frags_shrink_tail() can remove entire frags and it will modify
> > metadata contained in the skb_shared_info (e.g. nr_frags or the frag
> > size of the given page). We should consider the data_len field in this
> > case. Agree?
>=20
> Right, that's what I assumed; makes sense. But adding a comment
> mentioning this above the update of data_len might be helpful? :)

ack, will do.

Regards,
Lorenzo

>=20
> -Toke
>=20

--w72cXKqn55jNfhLL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYipQywAKCRA6cBh0uS2t
rPGYAQDlcxgaY2m9XC6c6822dEO+IPhSF+xEgbk2koma3IkpUQD9F9XNzLdC3A0M
oLcRYoTvatt+SO3KHXxxi/GuY8/a5Qo=
=faou
-----END PGP SIGNATURE-----

--w72cXKqn55jNfhLL--

