Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8210D6E25CB
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 16:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDNOca (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDNOcW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 10:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1994AB478
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681482693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jMtXyBdstcFNCWPwaA2GbPzJM18jRO/5c2YrxYmlIsc=;
        b=RT2/p3r4ztXgFaMx5v8JyV57UNrNlM5I7f9eCGh7JxaLqgpydV2V0p5qfFV/QQS4wPQKJ7
        VNK3B0q5ScXQhZhqjHgJ6lI//RxaLYblMAUTrASakioJ5u8vPL3Kcut2lNj003nl8TwCjn
        GdjTT//TDm2nqUYKpA4AQsUHcL8r1Xs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-jzYvOjkiNqyxR3vbd5a55g-1; Fri, 14 Apr 2023 10:31:31 -0400
X-MC-Unique: jzYvOjkiNqyxR3vbd5a55g-1
Received: by mail-wm1-f72.google.com with SMTP id u9-20020a05600c00c900b003f144967a91so509094wmm.3
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 07:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482690; x=1684074690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMtXyBdstcFNCWPwaA2GbPzJM18jRO/5c2YrxYmlIsc=;
        b=LwjGRlcGyD3mvriM9+bjxblwfKImyyG5tIUHt/8KW7h1NBKlwI6daQcg7VMQfGUbwX
         GvHD+5sbSshkhJhK8g0PxoslL3/3z95cCe/2o+5Mjt6RcCYxf+VNDBCA5ix/F0vhUtqm
         qEbI5OaVg+bNlUo8+9SjT19binrfdF2tL0o8/yuUmF4S41XzbRZDdDY2Fd016CVyOqTz
         BiUU8ahltpRN/yn2ufVOJL7slVPeLVYZbzm1FsnXzntZOXrvbrjYX83J268F8FzZkiXi
         J1fEiEhMSGPuHzSM4yb6rV0o6a+wBBcF2/b/KET1uD7iSybJSQMVoKrt+XoSxVoaMZes
         GWow==
X-Gm-Message-State: AAQBX9eiQiNV40hl0FDnWZAC1P2bIJSU1IMIMilb1FykqCl+CfbllIWK
        7qgpGnXGgXjYsh67++gKsCnrNuzPz7HD6FpENu4rGyFRFWVAw2K1hcvTeuMh9PQuXUP5r2E/hts
        /7OF6zeEhOeV8
X-Received: by 2002:a05:600c:ad6:b0:3f0:bf4d:8c64 with SMTP id c22-20020a05600c0ad600b003f0bf4d8c64mr1499007wmr.22.1681482690662;
        Fri, 14 Apr 2023 07:31:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y1wDo1yf1kN+rMmSGoVejnrex9e2JoZSSMxcWNuymuBGrpniVfUmqdcXU6Mh76JDx4Z7vC9g==
X-Received: by 2002:a05:600c:ad6:b0:3f0:bf4d:8c64 with SMTP id c22-20020a05600c0ad600b003f0bf4d8c64mr1498992wmr.22.1681482690315;
        Fri, 14 Apr 2023 07:31:30 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c1d0700b003ee443bf0c7sm8140771wms.16.2023.04.14.07.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:31:29 -0700 (PDT)
Date:   Fri, 14 Apr 2023 16:31:27 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jussi Maki <joamaki@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Manu Bretelle <chantra@meta.com>, bpf <bpf@vger.kernel.org>,
        lorenzo@kernel.org
Subject: Re: xdp_bonding/xdp_bonding_redirect_multi is failing
Message-ID: <ZDljvzZ8N+I7CGVT@lore-desk>
References: <CAADnVQL53uhY7qwALpFWznTANbN0dnU=Pp-gZXUYT98tUBDtDQ@mail.gmail.com>
 <CAHn8xck_k3UCGHoEF=rwxL-bZ3u63+m_6aWSXVejjK6EKwH0Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J6Y/Cv3gxxuTeAFe"
Content-Disposition: inline
In-Reply-To: <CAHn8xck_k3UCGHoEF=rwxL-bZ3u63+m_6aWSXVejjK6EKwH0Xw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--J6Y/Cv3gxxuTeAFe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Alexei,
>=20
> On Fri, Apr 14, 2023 at 3:26=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > is failing with:
> > test_xdp_bonding_redirect_multi:FAIL:expected packets on veth1_2
> > unexpected expected packets on veth1_2: actual 1 < expected 100
>=20
> I bisected this down to:
> fccca038f3 veth: take into account device reconfiguration for xdp_feature=
s flag.
>=20
> This seems to break XDP redirection from a veth device to another veth de=
vice.
> Since bonding just delegates the XDP loading to the slave devices the
> failure should
> also be reproducible with just a pair of veth devices:
>=20
>  pkt -> veth1_1  <|> veth1_2 (xdp_redirect_map_multi_prog redirects)
>                   |              /
>      <- veth2_1  <|> veth2_2   <-
>=20
> It seems like this is the same failure as with the xdp_do_redirect test:
> https://lore.kernel.org/bpf/ea5cda51-e8f0-2bcd-abfa-b6bf4b11d354@linux.de=
v/
>=20
> Lorenzo: if you fix the xdp_do_redirect test, could you also check
> that xdp_bonding passes?
>=20
> Cheers,
> Jussi

Hi Jussi,

sure, let me look into it.

Regards,
Lorenzo

>=20

--J6Y/Cv3gxxuTeAFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZDljvwAKCRA6cBh0uS2t
rGanAPoCoyuE3G5aK0rxlG/t4zxsab3K8SWLJCLYtDX4CY9XRQEAvRBJlCG5ob2D
/xZ2053ps88VBna7KK5QC+YLFtwHSgw=
=R+SI
-----END PGP SIGNATURE-----

--J6Y/Cv3gxxuTeAFe--

