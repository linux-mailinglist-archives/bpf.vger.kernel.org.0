Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB27B6EC054
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 16:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDWOV2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 10:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWOV1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 10:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2D1737
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682259623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oalj8UvYCHWtG0w/MWnC3lE9ZP+shcr1ycBlVQbj5bo=;
        b=U+3qZwz3vU8JKh0h1rzoP+aL54oj/FaazeqFaTzJ1X7ddMSx07+RqipBIDAH/4i8RU/T1D
        D73kEu8I8Js32QizrY7UeK39eyVFAb5Zc5I30G29XOeHRqesZ4ZHhNZpOTsYQTpOuciBL1
        xKzU9AOV4zmxEZcnREvR4mQGaiQtNi0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-z0YRX-mPNpKfIYAJCWBszg-1; Sun, 23 Apr 2023 10:20:21 -0400
X-MC-Unique: z0YRX-mPNpKfIYAJCWBszg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f065208a64so20010405e9.3
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 07:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682259620; x=1684851620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oalj8UvYCHWtG0w/MWnC3lE9ZP+shcr1ycBlVQbj5bo=;
        b=RpPF75Ax3equKFe9gvsJr4sy3eLVjgO3fM/qflCZJ0pz09zSTdT6MDGpooEyXrRj6d
         wcjoY/fRJaGslIlnggUOv9WNHTp+g91b59tDmQeDXgHRqUiVTskez+eRrMflJI3uYO1y
         ho14D6u8rR3FSQYILPgFvhUus9uAZgV2bhtMwBdXFfQQ+ydCr3107309hUgOYK6u+ZfG
         ClVxE8KDmC8KAFwCPJOjevJvyT0GoE3SwHB95WfRXqn0hAOgZ5ZEiYURo91zwiPwIYrh
         RRFanDiK1C+frNNltjZVTVCQbV22NHIosLjjrsao/AO6NMOtN8z1YrEfWDlfq7jHFaep
         UbQw==
X-Gm-Message-State: AAQBX9eKyiU1zBvynmEF//oqS3IZ8ACQd40QYykkRE43EpbijyH/m7dM
        4UL/OW/M4ms0+oEMC7HG13Br/7ndyzvSKXdoJIqcd4v8v/DCXpTb8bX3H1Oy2Fob3aW/8BuAG9n
        6hzXvyQjabAYo
X-Received: by 2002:a7b:cb88:0:b0:3f1:7136:dd45 with SMTP id m8-20020a7bcb88000000b003f17136dd45mr5671751wmi.30.1682259619899;
        Sun, 23 Apr 2023 07:20:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350bgLLfhOD7mVreoPPp6Uc2hu+viu2sH3u6/MwfWWGclrxhqLMrwkE7Vsq3laWZZoQGaZ1Xj/Q==
X-Received: by 2002:a7b:cb88:0:b0:3f1:7136:dd45 with SMTP id m8-20020a7bcb88000000b003f17136dd45mr5671727wmi.30.1682259619434;
        Sun, 23 Apr 2023 07:20:19 -0700 (PDT)
Received: from localhost (77-32-99-124.dyn.eolo.it. [77.32.99.124])
        by smtp.gmail.com with ESMTPSA id t13-20020a7bc3cd000000b003f173c566b5sm9802698wmj.5.2023.04.23.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 07:20:18 -0700 (PDT)
Date:   Sun, 23 Apr 2023 16:20:46 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v2 net-next 1/2] net: veth: add page_pool for page
 recycling
Message-ID: <ZEU+vospFdm08IeE@localhost.localdomain>
References: <cover.1682188837.git.lorenzo@kernel.org>
 <6298f73f7cc7391c7c4a52a6a89b1ae21488bda1.1682188837.git.lorenzo@kernel.org>
 <4f008243-49d0-77aa-0e7f-d20be3a68f3c@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mkr+ZXA+8ovhJ2bC"
Content-Disposition: inline
In-Reply-To: <4f008243-49d0-77aa-0e7f-d20be3a68f3c@huawei.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--mkr+ZXA+8ovhJ2bC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2023/4/23 2:54, Lorenzo Bianconi wrote:
> >  struct veth_priv {
> > @@ -727,17 +729,20 @@ static int veth_convert_skb_to_xdp_buff(struct ve=
th_rq *rq,
> >  			goto drop;
> > =20
> >  		/* Allocate skb head */
> > -		page =3D alloc_page(GFP_ATOMIC | __GFP_NOWARN);
> > +		page =3D page_pool_dev_alloc_pages(rq->page_pool);
> >  		if (!page)
> >  			goto drop;
> > =20
> >  		nskb =3D build_skb(page_address(page), PAGE_SIZE);
>=20
> If page pool is used with PP_FLAG_PAGE_FRAG, maybe there is some addition=
al
> improvement for the MTU 1500B case, it seem a 4K page is able to hold two=
 skb.
> And we can reduce the memory usage too, which is a significant saving if =
page
> size is 64K.

please correct if I am wrong but I think the 1500B MTU case does not fit in=
 the
half-page buffer size since we need to take into account VETH_XDP_HEADROOM.
In particular:

- VETH_BUF_SIZE =3D 2048
- VETH_XDP_HEADROOM =3D 256 + 2 =3D 258
- max_headsize =3D SKB_WITH_OVERHEAD(VETH_BUF_SIZE - VETH_XDP_HEADROOM) =3D=
 1470

Even in this case we will need the consume a full page. In fact, performanc=
es
are a little bit worse:

MTU 1500: tcp throughput ~ 8.3Gbps

Do you agree or am I missing something?

Regards,
Lorenzo

>=20
>=20
> >  		if (!nskb) {
> > -			put_page(page);
> > +			page_pool_put_full_page(rq->page_pool, page, true);
> >  			goto drop;
> >  		}
> > =20
> >  		skb_reserve(nskb, VETH_XDP_HEADROOM);
> > +		skb_copy_header(nskb, skb);
> > +		skb_mark_for_recycle(nskb);
> > +
> >  		size =3D min_t(u32, skb->len, max_head_size);
> >  		if (skb_copy_bits(skb, 0, nskb->data, size)) {
> >  			consume_skb(nskb);
> > @@ -745,7 +750,6 @@ static int veth_convert_skb_to_xdp_buff(struct veth=
_rq *rq,
> >  		}
> >  		skb_put(nskb, size);
> > =20
> > -		skb_copy_header(nskb, skb);
> >  		head_off =3D skb_headroom(nskb) - skb_headroom(skb);
> >  		skb_headers_offset_update(nskb, head_off);
> > =20
> > @@ -754,7 +758,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth=
_rq *rq,
> >  		len =3D skb->len - off;
> > =20
> >  		for (i =3D 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
> > -			page =3D alloc_page(GFP_ATOMIC | __GFP_NOWARN);
> > +			page =3D page_pool_dev_alloc_pages(rq->page_pool);
> >  			if (!page) {
> >  				consume_skb(nskb);
> >  				goto drop;
> > @@ -1002,11 +1006,37 @@ static int veth_poll(struct napi_struct *napi, =
int budget)
> >  	return done;
> >  }
> > =20
> > +static int veth_create_page_pool(struct veth_rq *rq)
> > +{
> > +	struct page_pool_params pp_params =3D {
> > +		.order =3D 0,
> > +		.pool_size =3D VETH_RING_SIZE,
>=20
> It seems better to allocate different poo_size according to
> the mtu, so that the best proformance is achiced using the
> least memory?
>=20

--mkr+ZXA+8ovhJ2bC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZEU+uwAKCRA6cBh0uS2t
rPCEAQCdvP7xMeAT6EECHwKs4KNQFTb8o9qQ6OBWBVOjCOajWQD+Ncp/sgeLiXYE
txzpeg0mM8IXqWgXWQMxpc3dfmP7CgU=
=LBJp
-----END PGP SIGNATURE-----

--mkr+ZXA+8ovhJ2bC--

