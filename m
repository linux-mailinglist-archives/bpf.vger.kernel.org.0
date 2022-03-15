Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD8C4DA590
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 23:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345219AbiCOWqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 18:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbiCOWqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 18:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9B3A11A15
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647384288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2i0Rb2LW/wKMRzqZ8bDWFK8lI2BuUKRqBqny86kOtKw=;
        b=bSVMdfraOgr6+qm+eB7DiJsKw9G/SRO38BPFTlswAl8XR/XBs/7uHnIiM70FcQZnmNO21t
        BP0xMH7khsA0xRgwWNL1n/2FiBiFcjne42dIXfjaezxurVQxeNsxXtAY5YSsnuYOI7n2YW
        omLvsQvi00aRxx6G5zMLNwE7myhU0CM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-cWHJtu0iPry5Q--QlpDAXQ-1; Tue, 15 Mar 2022 18:44:46 -0400
X-MC-Unique: cWHJtu0iPry5Q--QlpDAXQ-1
Received: by mail-wm1-f71.google.com with SMTP id i128-20020a1c3b86000000b0038a05a88880so1842515wma.1
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 15:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2i0Rb2LW/wKMRzqZ8bDWFK8lI2BuUKRqBqny86kOtKw=;
        b=ms7nnj3Dhzq5kpg4d2KqDbMSZxQzQqVPz/Xh5NlItt+EnhMHWWHxIB722eWhQZWDyQ
         EI5A5QGfPf3gMVT4CAIq1/GlrBQ79tHJ2/T/7PI8y0OSAmIbOvpRKfJWeiptm2xZIo8n
         03Kb2pVCfw6OXrKHMT3ZzbcIq0Fnvb8fzAQgApO3AXlxVcDhz1H27Pxa3o8koECoWDG0
         GxJ/8U+3B4/KYggrRZFbcILY8Nl//rR+XsRzGlDGtC2rrfXfmYUhhz4RmHxa5rW/yNMV
         DywP+cR4qwRPGftCdKD2Z7wsk0QiL5cievuBJRdcU2URrHsbDgjmLprfG7B8bhFO/K4g
         m2GQ==
X-Gm-Message-State: AOAM531AOtdHkNdj8Cc280ZEhap3bNv00PbEybHaPmGP3L612wAUi8ps
        1s4P2bkBEVbO+HA7EkxsZbXHY7lWnL2PxzQWmSGuYqTGuOJYtC6ENl0FM7jsNbIF4bZZw2UwKA6
        Q8jECKR1tajix
X-Received: by 2002:a05:600c:1913:b0:389:f643:28a5 with SMTP id j19-20020a05600c191300b00389f64328a5mr5029121wmq.182.1647384285157;
        Tue, 15 Mar 2022 15:44:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6wvujB4WpKNEdnKzQVRCvtnsNwi+28RmEvr1azmN/jhUXFj4g0McMssFEhn7MUQsWeXkryQ==
X-Received: by 2002:a05:600c:1913:b0:389:f643:28a5 with SMTP id j19-20020a05600c191300b00389f64328a5mr5029108wmq.182.1647384284965;
        Tue, 15 Mar 2022 15:44:44 -0700 (PDT)
Received: from localhost (net-93-144-71-136.cust.dsl.teletu.it. [93.144.71.136])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b00389d2ca24c9sm109884wms.30.2022.03.15.15.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:44:44 -0700 (PDT)
Date:   Tue, 15 Mar 2022 23:44:42 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] samples: bpf: convert xdp_router_ipv4 to XDP
 samples helper
Message-ID: <YjEW2rwFbcHaqv2D@lore-desk>
References: <7c20ed355c2f587d3e1c81a6b398cb8f68304780.1647342110.git.lorenzo@kernel.org>
 <CAEf4BzZFGv-_5U8LL=Jzr8MqL5F5F0i=gz+06nJOc961Ta54KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iiCnXvvjX5CEUWp"
Content-Disposition: inline
In-Reply-To: <CAEf4BzZFGv-_5U8LL=Jzr8MqL5F5F0i=gz+06nJOc961Ta54KA@mail.gmail.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--7iiCnXvvjX5CEUWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Mar 15, 2022 at 4:06 AM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> >
> > Rely on the libbpf skeleton facility and other utilities provided by XDP
> > sample helpers in xdp_router_ipv4 sample.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  samples/bpf/Makefile               |   9 +-
> >  samples/bpf/xdp_router_ipv4.bpf.c  | 180 +++++++++++
> >  samples/bpf/xdp_router_ipv4_kern.c | 186 ------------
>=20
> hm... git should be able to record this as a rename and the result
> patch will be much smaller, only showing what really changed. Can you
> check where this went wrong?

I am not so familiar with git internal, but I think it depends on the simil=
arity
between the "old" and "new" files. If they are very different (like in this=
 case),
git will report the "old" file as remove and the creation of the "new" one.
I guess you can try to do "git mv" a given file and overwrite it with a
different one. Am I missing something?

>=20
> Please also add libbpf_set_strict_mode(LIBBPF_STRICT_ALL) to enable
> stricter "libbpf 1.0" mode. Thanks!

ack, I will add it in v2.

Regards,
Lorenzo

>=20
> >  samples/bpf/xdp_router_ipv4_user.c | 462 ++++++++++++-----------------
> >  4 files changed, 377 insertions(+), 460 deletions(-)
> >  create mode 100644 samples/bpf/xdp_router_ipv4.bpf.c
> >  delete mode 100644 samples/bpf/xdp_router_ipv4_kern.c
> >
>=20
> [...]
>=20

--7iiCnXvvjX5CEUWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYjEW2gAKCRA6cBh0uS2t
rDheAP9+AB24gJLURQ15sludg4k0YYz1iBTQzUGxLfpY50tgSwD+O0Da5x0lIfvP
4hFqSoa/nVqeqt+pT4HGRsSFme1VUw4=
=9lEF
-----END PGP SIGNATURE-----

--7iiCnXvvjX5CEUWp--

