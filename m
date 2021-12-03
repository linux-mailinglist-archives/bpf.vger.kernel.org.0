Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18237467FAC
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 23:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383322AbhLCWKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 17:10:23 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:55126 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383318AbhLCWKX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 17:10:23 -0500
Received: by mail-wm1-f44.google.com with SMTP id i12so3421268wmq.4;
        Fri, 03 Dec 2021 14:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=2m15vci7/0W9KySYNRQumNcK2wiuRF1V6uwKt1+mi6c=;
        b=hW0iY8IdPKKPn3n95fhdmjpHaU2i/8tBLGGwtMahRNEhJIWJig2KF6hBvhaDh0Dcup
         JGjLIKpyThNiKG8hsq0WS4AXPYF4AHc9vbmDad92hTlvfABlW/4/oMmXcEbe9y5ePMtj
         tH7x+bZycRaRwGX+JEMV+wEmGaW/CgPAc/0mAC6gLQyNM/Ii5UyBnSsCYL8U1uKY40T/
         4kHMdRKKBc+ihWSYEmte40mcqL5JxckR7XxnqJTh7pgU/RovWPcfCc2p2fA6XJjyg/bJ
         lpII0eBGto8vOv2FmSd7GZwrxUq2Ul+DxCyA7gmCRTo0jhBLZ/Q6fGkvFKuiqDe4PYCd
         xgBg==
X-Gm-Message-State: AOAM5329ULlfozi/2FWaIcqQDj0uucL2i4hHaCNeI4Szh9FKtzcjhz9F
        QahnxyCEFO4kaN/jVmoC8YhgtO9jPDg=
X-Google-Smtp-Source: ABdhPJwys4+Q3kC/4kyEp/EjrRvQqcLTHXiVLaiRt2MtWWUvp2rD9NPFyHM+S1KzocVuaNFlgYHPqw==
X-Received: by 2002:a1c:7d0f:: with SMTP id y15mr18745651wmc.191.1638569217551;
        Fri, 03 Dec 2021 14:06:57 -0800 (PST)
Received: from localhost ([2a01:4b00:f41a:3600:df86:cebc:8870:2184])
        by smtp.gmail.com with ESMTPSA id c4sm3786987wrr.37.2021.12.03.14.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:06:56 -0800 (PST)
Message-ID: <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
From:   Luca Boccassi <bluca@debian.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Fri, 03 Dec 2021 22:06:51 +0000
In-Reply-To: <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
         <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
         <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
         <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-9dGd7pIPTozUlvTxQ6OC"
User-Agent: Evolution 3.42.1-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-9dGd7pIPTozUlvTxQ6OC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-12-03 at 11:37 -0800, Alexei Starovoitov wrote:
> On Fri, Dec 3, 2021 at 11:36 AM Matteo Croce
> <mcroce@linux.microsoft.com> wrote:
> >=20
> > On Fri, Dec 3, 2021 at 8:22 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >=20
> > > On Fri, Dec 3, 2021 at 11:18 AM Matteo Croce
> > > <mcroce@linux.microsoft.com> wrote:
> > > >=20
> > > > From: Matteo Croce <mcroce@microsoft.com>
> > > >=20
> > > > This series add signature verification for BPF files.
> > > > The first patch implements the signature validation in the
> > > > kernel,
> > > > the second patch optionally makes the signature mandatory,
> > > > the third adds signature generation to bpftool.
> > >=20
> > > Matteo,
> > >=20
> > > I think I already mentioned that it's no-go as-is.
> > > We've agreed to go with John's suggestion.
> >=20
> > Hi,
> >=20
> > my previous attempt was loading a whole ELF file and parsing it in
> > kernel.
> > In this series I just validate the instructions against a
> > signature,
> > as with kernel CO-RE libbpf doesn't need to mangle it.
> >=20
> > Which suggestion? I think I missed this one..
>=20
> This talk and discussion:
> https://linuxplumbersconf.org/event/11/contributions/947/

Thanks for the link - but for those of us who don't have ~5 hours to
watch a video recording, would you mind sharing a one line summary,
please? Is there an alternative patch series implementing BPF signing
that you can link us so that we can look at it? Just a link or
googlable reference would be more than enough.

Thank you!

--=20
Kind regards,
Luca Boccassi

--=-9dGd7pIPTozUlvTxQ6OC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAmGqlPsACgkQSylmgFB4
UWJQnAgAq3GA8XzZRwGZwL34DIKH2I4aOB3vedcJgWDfrtQ/tRoaAxWVOB3J3z/V
MV3R5FgL3JleXVKowRnpIz1nf+EHU3RP2XH1Hf0QXFkNJKDp0fz8BOnO/CqcokrP
EcL3FJeK496YAKHs8idXPnGas4CIkjOZ7K8HdT1i3JCCt/6lxcZOvxuC4w48AQM2
osb5oqdr9r2Pd891rW2ZKiKnutYr4vzkYdq8DmCvagr93FAh+V1vDVk8SRslDhkM
K/3GJ9oGpBj0PJ0Unt+jYqqMZKsQYCm4k+Fkg3de1Rjldln4gTFNVlzVHcYuRtlr
PcgpliiyJ3ptRxVgp2ozdK8YebpQ5w==
=V9Ai
-----END PGP SIGNATURE-----

--=-9dGd7pIPTozUlvTxQ6OC--
