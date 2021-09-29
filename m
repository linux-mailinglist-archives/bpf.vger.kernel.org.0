Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9B141C326
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245640AbhI2LH3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 07:07:29 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43773 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245638AbhI2LH2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 07:07:28 -0400
Received: by mail-wr1-f43.google.com with SMTP id x20so3524129wrg.10
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 04:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=u/GRJSRDNaRjaqe7aITj2N6LmSMTr6ZHtHD11ND2M0M=;
        b=HBwUkTn9c4x6yfEzxJQCwlah1iy/E3ZohU1lnm9Sbk+ZXKqzOgvDIsrAJq5FGyxJby
         g3892WVMu/BxiU+4gVFYgSOcQqmUGAiCjJ/HdPrHJD+TGjC9sZ3mQnzf0aHT2Bu1EzzZ
         s/XFufBle+4EDv3o3a1rgl+9SVbWtjqwg4m6PvHRIT8Pcn3IS3Qbep9ye1RVSGJ5VXJl
         fO/Bo1gtUWdMIidKdC4r4xGqsWu/mSshF0SP/8ApojkZsuNDKMujPxylgO1Z0F6Ub+wI
         5FE1jmB9mq4vhptVDl79VU80P5998enb0eTdh/9SUzAitJw6SISHRiIqxED4MxnZsw6g
         pjDQ==
X-Gm-Message-State: AOAM533Vd0Mrc1Pdzr/f6z/2FiLpppE4KTfBcySiJlpr7cVCL9QcG2GD
        fAMCYCV5fpa9ujpNK4KnaPw=
X-Google-Smtp-Source: ABdhPJw5xDZjQSxWyEMreel/9vUHX0mXjw68/OIm42Qa0YYWwROwJX7UlkwbrTwP/aEeJazaSsRoWg==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr5823149wrx.161.1632913546936;
        Wed, 29 Sep 2021 04:05:46 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id h18sm1890485wrs.75.2021.09.29.04.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 04:05:46 -0700 (PDT)
Message-ID: <ed448659f66f2142151b34e6af9c98b46abdaaf0.camel@debian.org>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
From:   Luca Boccassi <bluca@debian.org>
To:     =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "Mcnamara, John" <john.mcnamara@intel.com>
Date:   Wed, 29 Sep 2021 12:05:44 +0100
In-Reply-To: <CAJ+HfNjsJZx62ZnA9Gi-rCuL=yBVLKZke7J+ruQFHAAKarpk=g@mail.gmail.com>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
         <1aa77fde2f7f4637d9eae7807c5c55063d6a4066.camel@debian.org>
         <CAJ+HfNjsJZx62ZnA9Gi-rCuL=yBVLKZke7J+ruQFHAAKarpk=g@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-FF3UljuYtNQTG73l1hL2"
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-FF3UljuYtNQTG73l1hL2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-09-29 at 13:01 +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> On Tue, 28 Sept 2021 at 17:44, Luca Boccassi <bluca@debian.org> wrote:
> >=20
>=20
> [...]
>=20
> >=20
> > Gentle ping. Bj=C3=B6rn and Joe, would be great to hear from you on the
> > above. TIA!
> >=20
>=20
> Luca, apologies for the slow response. I'm no longer at Intel, and I'm
> not sure if an Intel-person needs to do anything? Magnus, do you know?
>=20
> FWIW:
> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

No worries! Unless you had an arrangement in place that made you the
copyright owner of that contribution (eg: it was done in spare time,
etc), then yes we'd need an ack to the relicense from an intel.com
email address to be above board.

John, is this something you could help with, using your manager hat?
Full context:

https://lore.kernel.org/bpf/20210923000540.47344-1-luca.boccassi@gmail.com/=
T/#u

--=20
Kind regards,
Luca Boccassi

--=-FF3UljuYtNQTG73l1hL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmFUSIgACgkQKGv37813
JB6kAQ/9EqGjFwh9MdqbN+CNZdmXPQa0zIjX4mTHpWPZZPCJsDQQ0rKBgI/JOufc
ujBjXk486ul1eaZgjTQl7uV4bNyJ9FEpVyvHJ4LtjjXD3Xpxu0NYkZDOTFNS7Oty
qT5OXQ+bAJnOM6UyVFX4fZ9flGsiC7UpFm3HRLdMUHW0ZlOfeiTVxEwQn7L+Us35
X/vz6XzgJOkB5aEd51G3vGkl99c7g/pOdsemx7KtwUfYASfVOWv+6UFmaQFX6b+k
2kwl08G7fBbCXqOIk7WDs/yVbf26jqWNPb26XXEAnI2jqUmSxgd3/YbnaAJZdjDK
HPEgDhah9Le8UhCDOm56n+qEC4Io6AnkwXXOFrkv0GbmKXYI+J3YLB/lBP6PZRrC
rE9Y9QJKbo53SysTM3x7rwSxUmOmSXElDDsfkIRCwlKDt2dIh0wRqoBXUsCihXT2
xnK6drRoGBPsU4L7/4qeU1OqO6EOOuVGwBiOLWzcQBZTh+htk2RZqzHKwOhP7a8+
2HwR3dlkk9bXYbgZljFGNa0Kn7J4zfI+0ztQdV8ipLls5uxS3SuxoUrDXSVSXTRw
/c+iKtG9Hc0EvSps2LYSU4pzSmfKbVpCJ+wswu0nPMNVZONx/cPweAZW7GF/Xu7I
y2V487yDDJJwDRw/VspbsE+773YTNWBZW1iRRegvWIUcaCjupVk=
=SOh0
-----END PGP SIGNATURE-----

--=-FF3UljuYtNQTG73l1hL2--
