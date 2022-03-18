Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905674DE1FE
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbiCRT4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 15:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbiCRT4R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 15:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA6C1B2
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647633296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=frASzTACAUZIWyRI9k3nBhIJnztBNRiE/mDa4BbET+c=;
        b=iM7NgqxTPcxlyKtwC2/ro5DAHYlQt0v4pTl7ZFdAxZZx/vElBtgjxWvqw7nw7N0fHA0odn
        T5d/N3Lb5sOeAUvOzK4y5W2oe885uPBIFTsKv8D8EkyT66UvLxPtRp/mzRjbCBMXjjhDDs
        CnwbwUCPHypQ/k3i8oMDLcHZo0y2ryc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-Wzc8WDVsPx2SwcXNdZCbWA-1; Fri, 18 Mar 2022 15:54:55 -0400
X-MC-Unique: Wzc8WDVsPx2SwcXNdZCbWA-1
Received: by mail-wm1-f72.google.com with SMTP id v67-20020a1cac46000000b00383e71bb26fso3452404wme.1
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 12:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=frASzTACAUZIWyRI9k3nBhIJnztBNRiE/mDa4BbET+c=;
        b=h9+Lt+ngg6rZ0KnxB7KwA7KoYuwtAtqJFwGztY2IJtdfeo+zkr4ryQax2XuVruVpR8
         mAj0rW6I7r9Fq2EAAxb5xpKVzvAxJwaSupeAkFbSzoMtgBNchY50SCihtixgF+FXaNJz
         OWxSiC0nxWiNYDtcl36OT72OEQD9JBNw3GLqsrqHDKYpPCHOE8GvnTcj+lGaBH7kaG9B
         7BX+uNkKDsGH29cp5+PSgtIu148CdQDEI8X0qb3F0ipeJ2/9KrCQTwVOmyQ0Rki5nRRG
         lqk2goqukC6Agjwq31GJiQ30jipiibbHOncl5Hho/xOklCHs66LMTzcfWFuDQQ1GWHQQ
         0fPQ==
X-Gm-Message-State: AOAM533a0LXR5GTEFpu/rE6ieX1PU28O0Rfxc4C3/1xT87duuvE+UBGo
        Cro6YhqPraEcNfWA2f79ZPre+jeG7GfOd5zr3AH5xnh3adgfIkjLlAV+qjAkfZvcU9zBKmF8jX1
        VR7wyGwzcl26U
X-Received: by 2002:a05:6000:1569:b0:1f0:47eb:eafa with SMTP id 9-20020a056000156900b001f047ebeafamr9246812wrz.194.1647633293926;
        Fri, 18 Mar 2022 12:54:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyZe9u5kxSyvQhFnP2QLcXQY2xOKluhjCLCV3Lme/XafLoVtd5t3+VhrwIkQrHRuogtiShWA==
X-Received: by 2002:a05:6000:1569:b0:1f0:47eb:eafa with SMTP id 9-20020a056000156900b001f047ebeafamr9246803wrz.194.1647633293719;
        Fri, 18 Mar 2022 12:54:53 -0700 (PDT)
Received: from localhost (net-93-144-71-136.cust.dsl.teletu.it. [93.144.71.136])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b001edc38024c9sm7746241wra.65.2022.03.18.12.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 12:54:53 -0700 (PDT)
Date:   Fri, 18 Mar 2022 20:54:51 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, brouer@redhat.com, pabeni@redhat.com,
        toke@redhat.com, andrii@kernel.org, nbd@nbd.name
Subject: Re: [PATCH bpf-next] net: xdp: introduce XDP_PACKET_HEADROOM_MIN for
 veth and generic-xdp
Message-ID: <YjTji4qgDbrXg4D+@lore-desk>
References: <039064e87f19f93e0d0347fc8e5c692c789774e6.1647630686.git.lorenzo@kernel.org>
 <20220318123323.75973f84@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FFVkPaJuvWVg7EHv"
Content-Disposition: inline
In-Reply-To: <20220318123323.75973f84@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--FFVkPaJuvWVg7EHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 18, Jakub Kicinski wrote:
> On Fri, 18 Mar 2022 20:19:29 +0100 Lorenzo Bianconi wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index ba69ddf85af6..92d560e648ab 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4737,7 +4737,7 @@ static u32 netif_receive_generic_xdp(struct sk_bu=
ff *skb,
> >  	 * native XDP provides, thus we need to do it here as well.
> >  	 */
> >  	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
> > -	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> > +	    skb_headroom(skb) < XDP_PACKET_HEADROOM_MIN) {
> >  		int hroom =3D XDP_PACKET_HEADROOM - skb_headroom(skb);
> >  		int troom =3D skb->tail + skb->data_len - skb->end;
> > =20
>=20
> IIUC the initial purpose of SKB mode was to be able to test or
> experiment with XDP "until drivers add support". If that's still
> the case the semantics of XDP SKB should be as close to ideal
> XDP implementation as possible.

XDP in skb-mode is useful if we want to perform a XDP_REDIRECT from
an ethernet driver into a wlan device since mac80211 requires a skb.

>=20
> We had a knob for specifying needed headroom, is that thing not=20
> working / not a potentially cleaner direction?
>=20

which one do you mean? I guess it would be useful :)

Regards,
Lorenzo

--FFVkPaJuvWVg7EHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYjTjigAKCRA6cBh0uS2t
rHSSAP0TtIh/ZoQVXXyM6GkB50TGUvEhWtaJK6HgwovSiW+RIwEAzzqFjoppHLL6
L5RDhQHu91NDTBcXqIML6fNBQYv2SQg=
=+Mhf
-----END PGP SIGNATURE-----

--FFVkPaJuvWVg7EHv--

