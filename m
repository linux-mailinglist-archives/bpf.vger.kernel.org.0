Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7F41C370
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 13:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244336AbhI2L3B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 07:29:01 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:34379 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhI2L3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 07:29:01 -0400
Received: by mail-wm1-f41.google.com with SMTP id r11-20020a1c440b000000b0030cf0f01fbaso3610279wma.1
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 04:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=8MXT4khhcGqSMpn2WZtc1mqCkTlBv8y0jVw1bIIckQc=;
        b=2OexHh+Pzq1lY8Vg5GW8uEq9r4QrC2cAWqe00+goHCfiGkUOR73X9SKNRhQKS5X5VW
         xYTbNK0YNepVIsKiEQt5DFBeEUBM6VXQ+OxAvY/ZctSC3qZLMamL6SJUYNuvBRc5tMi8
         T/c9C/PhMrLgDSHO/GnWtrB0kb4GWnLQO18csv8P5FJlJxjAv87y+WTB1kOVQ3d6Q6jb
         4mpY1Ak6Um3Zf7bDhgsAnvYImFPH5dLARmxzh1F+WK6oAKhUa8gVRUie+8VQ7A2xO10J
         r16hcRoaMRmPCfQO8Ya54/8eBOIiz1uTEm2wiWZrL1k/fmEgmgQCDjlnX15gUglSk7GS
         2nqQ==
X-Gm-Message-State: AOAM531uBrTmVchkydhk5zXIMh1wFjWPiG4xioXllHzkYGLtPWxwoqaY
        RK0mipCroexzDD0srfwbkQPh/W+k8bE=
X-Google-Smtp-Source: ABdhPJwsG6KLCkYk+CZbSKgRGqUdSL8vwQSrBa5nOUj3dlS7DefbdrCiRNIWnbcQC9CTQyOmEOdHRQ==
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr9720097wma.115.1632914839390;
        Wed, 29 Sep 2021 04:27:19 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id d7sm1984320wrh.13.2021.09.29.04.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 04:27:18 -0700 (PDT)
Message-ID: <41c5f064898c6427b589ea86f6b538266b2ce8c6.camel@debian.org>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
From:   Luca Boccassi <bluca@debian.org>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        bpf <bpf@vger.kernel.org>,
        "Mcnamara, John" <john.mcnamara@intel.com>
Date:   Wed, 29 Sep 2021 12:27:17 +0100
In-Reply-To: <CAJ8uoz3ammMczNQqFk0SDmTnFThV8U6Fy9YEB+wLkv4fZ5qxZA@mail.gmail.com>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
         <1aa77fde2f7f4637d9eae7807c5c55063d6a4066.camel@debian.org>
         <CAJ+HfNjsJZx62ZnA9Gi-rCuL=yBVLKZke7J+ruQFHAAKarpk=g@mail.gmail.com>
         <ed448659f66f2142151b34e6af9c98b46abdaaf0.camel@debian.org>
         <CAJ8uoz3ammMczNQqFk0SDmTnFThV8U6Fy9YEB+wLkv4fZ5qxZA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-eO4ZpWy6jrYYElgYicWZ"
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-eO4ZpWy6jrYYElgYicWZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-09-29 at 13:26 +0200, Magnus Karlsson wrote:
> On Wed, Sep 29, 2021 at 1:20 PM Luca Boccassi <bluca@debian.org> wrote:
> >=20
> > On Wed, 2021-09-29 at 13:01 +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > > On Tue, 28 Sept 2021 at 17:44, Luca Boccassi <bluca@debian.org> wrote=
:
> > > >=20
> > >=20
> > > [...]
> > >=20
> > > >=20
> > > > Gentle ping. Bj=C3=B6rn and Joe, would be great to hear from you on=
 the
> > > > above. TIA!
> > > >=20
> > >=20
> > > Luca, apologies for the slow response. I'm no longer at Intel, and I'=
m
> > > not sure if an Intel-person needs to do anything? Magnus, do you know=
?
> > >=20
> > > FWIW:
> > > Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> >=20
> > No worries! Unless you had an arrangement in place that made you the
> > copyright owner of that contribution (eg: it was done in spare time,
> > etc), then yes we'd need an ack to the relicense from an intel.com
> > email address to be above board.
>=20
> Will this do?
>=20
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

Good enough for me, thank you!

--=20
Kind regards,
Luca Boccassi

--=-eO4ZpWy6jrYYElgYicWZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmFUTZUACgkQKGv37813
JB6c3BAAsBfRxcT2XpTnvZUFxtjKNbIeGUIKb48O/rk2CwCOlRF6qnOwptpHlAdE
fLiWdf2VUAbF/hznz7UIgWvIgplVCDW0fSDCF5q2et42yPB3Ywumsv3KoqdQifuK
NWHM15NHE5myjd9qTzHWOycZYt+rNvZ9V9xxrLtpKJcHewFNun1hY4V2BPTSKg57
Wtqdl7AwtIt0bf5E0e75vU4WUr1FzEwzd+mghdqRKD+YFq1VGvjrDzwFuGDxbo2l
YpzPfwbgZCFNLHjSRViWfSK2SiiopL+aKce3YJpRSSkESXs7JjvA0DuiVDHF4nVa
OESIRTIMFuISe3lL0oJ4QBkaUZ8Aqm0TUXuQreScjzCvdleysL2kMq4fn40f6H6K
ERFZK/hAgwHAxxdZ8ZIxBgcCfjJ00ZkY0i2eseXge4i/QA7EyIbyeqKfbT9zMqfk
niDBEaeIcqTZKg0Za9nLBa3PMEC2CM9YpAtoj565hJ1gI51DABYqs2KlvTxsGxyC
p7qW//ImOg4/WfOYkBfe2RwwPJ5LYoWTq30xIJF9x7fKshOzc7ijaFchDIGWwDW/
UgY5JIrL/0y+SP6E5DuYPjtr07ax+vpSh135I2Lvsr366OUuTHXsl0p8PJ69ziWL
jxZK649uSz7tgVZXCeE/J5mZ0TQJZQjWHLFbykOyDANLeEqk92Y=
=cAQY
-----END PGP SIGNATURE-----

--=-eO4ZpWy6jrYYElgYicWZ--
