Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D725841CA4B
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345726AbhI2Qjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 12:39:31 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40803 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344376AbhI2Qja (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 12:39:30 -0400
Received: by mail-wm1-f49.google.com with SMTP id t16-20020a1c7710000000b003049690d882so5801777wmi.5
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 09:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=7HWmNBFGfNvX7JA+ozWxmZr5Am5AfSoNXdLNCuKVPRU=;
        b=FRMZkLJ9/r8bt+1tF2Xd4xZhnsmxbqiBiXpf5ZR4JtOxcrGMjmG8tdelScKcucC45K
         q/nYzI5qQLKjUMvh7/IvEkSBycfsk4Qeevc1MA5DvHF98TMzmzDUZs7Pkl+YRJdU3bVx
         WMf3UrWGW9QDWr8Ja25prmCAa/brZvweOYnRG1NgHXYrWbYjCr2zVbbuAfuUkE6JodQ4
         TyT8gqZKExkY5k/z98RSovkrKO1x2WVQmrR/XGGsTr/i6p41+Ueq4oOW40ohUxP9Twoc
         AvXjG1kFNk/G+Uc7qhoRLde2TUN6s+7CPv9GamnxCpjXfvxuEKnbQvf5Q8hDCCWwZjjd
         qexA==
X-Gm-Message-State: AOAM531INrgC01cnaEk3NajjheDWoFckNypQ0jC2bL8yPGyyaLzEwK6H
        +1ID80vMlCZFkjh9j9BY6q61fXXp9eg=
X-Google-Smtp-Source: ABdhPJxgIVBy7gRkyzCfLB6Jgo45dRMI5PAjEvUVD0jue25FMyfu4TNRD9PqSYzSvZTW921+MxZ51Q==
X-Received: by 2002:a05:600c:198e:: with SMTP id t14mr992145wmq.124.1632933468522;
        Wed, 29 Sep 2021 09:37:48 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:360b:9754:2e3a:c344])
        by smtp.gmail.com with ESMTPSA id i1sm362945wrb.93.2021.09.29.09.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 09:37:48 -0700 (PDT)
Message-ID: <c3ac53d54a500e67e17272393e58e1c3c361bceb.camel@debian.org>
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
From:   Luca Boccassi <bluca@debian.org>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     ast@kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Sep 2021 17:37:46 +0100
In-Reply-To: <a60b2164-2a4a-ac8b-c8a4-6e16497d620c@iogearbox.net>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
         <97ba65d49171c1a4eee34722d79b60e5732ce441.camel@debian.org>
         <a60b2164-2a4a-ac8b-c8a4-6e16497d620c@iogearbox.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-SxW+loIF4OJlz2/nPESV"
User-Agent: Evolution 3.38.3-1+plugin 
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--=-SxW+loIF4OJlz2/nPESV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-09-29 at 18:10 +0200, Daniel Borkmann wrote:
> On 9/29/21 6:06 PM, Luca Boccassi wrote:
> [...]
> > So as far as I understand, only your two acks are missing and then it's
> > job done and we can go home!
>=20
> Already applied including both our ACKs.
>=20
> Thanks!
> Daniel

Fantastic, thank you so much!

--=20
Kind regards,
Luca Boccassi

--=-SxW+loIF4OJlz2/nPESV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmFUlloACgkQKGv37813
JB7HnRAAzOw6razcywPEndhEZs4buwxdCTh8SGX5lJJ2bU+/3WgeUQwKFb+7mDCT
RJCD2M6iP3rfsgGlLMGnl2byselaYifgvnTsnwahc6pkD5r0SsI0An5l6aD7RVic
yC4x8f6imz6Se+MRdXmZSa4vNhewcuFrk/7MdRXaXPnqaqsnzPfV8gG4ew8idy0X
c75ckCPnGqFphXaefgDV4Ok4yy17T0MOD8Fi7qBkebpLrlkXEB6iO/McN5ReQt4c
WSbZY6VX5wKht7lcWvTL2hze+1TPI5O+jKVCZXfRQw++22CVWSaWexud1zkkv9xt
qhGWjLh5htovYyTF0BNxFSh2GPBKrAML7+cu0W+RZ8b8NPdrR9qDOiXzoWBtgtJS
bC2ErXXbcZQzh9/6uI6uPAeGD6zy3LvBc9+oGFUIAYBmemf34wR+AhnnC27W8+77
b/WfPcyeL8/bSH8SYPuttOPeJE5bkMLekxEffGiRQ23IQLmyHwE4po5RkEiReC9J
DQTm+1DxSIGW9maTF8vx+JytWBQ6Lao/V6TeWL2Zd9ob2LyDav5Po1n5Sbt235MP
XOMt9XSA5q96Vo2czhHsXz4bJYhUE9UilkILcpEhI/KQwTJstRCR4YywXtHhH1lI
vpB0xT8hxzhAs5aQBO/WydEXLQtLm1E/VRE3WqNxANo/g9Lg1RQ=
=1iP0
-----END PGP SIGNATURE-----

--=-SxW+loIF4OJlz2/nPESV--
