Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3883F41686
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2019 23:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406837AbfFKVAR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jun 2019 17:00:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35691 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406734AbfFKVAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jun 2019 17:00:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so8197469pfd.2
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2019 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=nUPaXZb2EyHCiKOm64w17o/WMgOXwq3cvo71tUNaOwE=;
        b=1PkfIHxoAL100GHTIJPtUgnC6vtovLyncp9xFBxlnggPu12+zsDGgnLaBjug3WcCRF
         ADQVr3JetSynDAQbtUt6ErvLUOeaCpig1636+Ma6Jq/Pzq9Wm8vruTUnsCFntkIJGXPX
         wWnf8ZOx9s4y5y8Qm3ZvQvL2os1TOwaLQLvbm9ZJou9U0nJzedf/8LPDMnNkHoMmIRvm
         0JVJjUBp99ct05cqa2egnpZd13j2INZwnsHocqWKQQe5RqyURZIMrPteLnuZG4T+3ubQ
         FsvDJpuZH3QIeO3XlnkM7vdfDShdyMdLnG6hcUpiZJVNutSS2SeLa5Fxo2XceNqs4ysr
         0rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=nUPaXZb2EyHCiKOm64w17o/WMgOXwq3cvo71tUNaOwE=;
        b=mDc5EsdV9KUnEmdcEfHd6Rcqd8ZhYHPlTL/iOzL4BkTGYHU7obEZiTgPUAdaK5EQBh
         ewI75optv4PWI4wsp5+gVOiGhWYPDui8RLxJW3BHIgtb9Bfck0faxElJnJFzUA5l+O7o
         vk0t2YLe00Q4ZoaPf27k+wovR7QZGyaaoCXESqOwPeSw8bQY6Uu+KGLzxnPxjcqbZROJ
         csnZiWrdWAl1kTabiNO5z5a6vWxPDS8mNfn6eCdLZeRR6hcLixOOKBQCKoDQBdvD2sY2
         a6/ACG6wBtEDSVmxEWycr2jCqAuXF9hQaq9y6qY66ACK4HNOBJBMtq+Z7dHpqLoKyhr4
         +xPQ==
X-Gm-Message-State: APjAAAXVQv3zweThgHDx/3P6htar9JnnmIYrzzMtIOytY5yXZB1FHW7s
        1r3dK8cfLprcrBOesOrFVCoFWw==
X-Google-Smtp-Source: APXvYqw4YBmB5zv3pmuSF2o1Ro24lhPZ3aL8+7Yz5YYkMM5A75U9mLeByV4nZS/X2MAaqVMFGY5qAQ==
X-Received: by 2002:a63:4419:: with SMTP id r25mr22692286pga.247.1560286815720;
        Tue, 11 Jun 2019 14:00:15 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id l1sm14357897pgj.67.2019.06.11.14.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 14:00:14 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6DCAE4F8-3BEC-45F2-A733-F4D15850B7F3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_31ECB8A0-2497-4644-8BE0-DFE1190172F7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2] include: linux: Regularise the use of FIELD_SIZEOF
 macro
Date:   Tue, 11 Jun 2019 15:00:10 -0600
In-Reply-To: <20190611134831.a60c11f4b691d14d04a87e29@linux-foundation.org>
Cc:     Shyam Saini <shyam.saini@amarulasolutions.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-sctp@vger.kernel.org, bpf@vger.kernel.org,
        kvm@vger.kernel.org, mayhs11saini@gmail.com,
        Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20190611193836.2772-1-shyam.saini@amarulasolutions.com>
 <20190611134831.a60c11f4b691d14d04a87e29@linux-foundation.org>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--Apple-Mail=_31ECB8A0-2497-4644-8BE0-DFE1190172F7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 11, 2019, at 2:48 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Wed, 12 Jun 2019 01:08:36 +0530 Shyam Saini =
<shyam.saini@amarulasolutions.com> wrote:
>=20
>> Currently, there are 3 different macros, namely sizeof_field, =
SIZEOF_FIELD
>> and FIELD_SIZEOF which are used to calculate the size of a member of
>> structure, so to bring uniformity in entire kernel source tree lets =
use
>> FIELD_SIZEOF and replace all occurrences of other two macros with =
this.
>>=20
>> For this purpose, redefine FIELD_SIZEOF in include/linux/stddef.h and
>> tools/testing/selftests/bpf/bpf_util.h and remove its defination from
>> include/linux/kernel.h
>>=20
>> In favour of FIELD_SIZEOF, this patch also deprecates other two =
similar
>> macros sizeof_field and SIZEOF_FIELD.
>>=20
>> For code compatibility reason, retain sizeof_field macro as a wrapper =
macro
>> to FIELD_SIZEOF
>=20
> As Alexey has pointed out, C structs and unions don't have fields -
> they have members.  So this is an opportunity to switch everything to
> a new member_sizeof().
>=20
> What do people think of that and how does this impact the patch =
footprint?

I did a check, and FIELD_SIZEOF() is used about 350x, while =
sizeof_field()
is about 30x, and SIZEOF_FIELD() is only about 5x.

That said, I'm much more in favour of "sizeof_field()" or =
"sizeof_member()"
than FIELD_SIZEOF().  Not only does that better match "offsetof()", with
which it is closely related, but is also closer to the original =
"sizeof()".

Since this is a rather trivial change, it can be split into a number of
patches to get approval/landing via subsystem maintainers, and there is =
no
huge urgency to remove the original macros until the users are gone.  It
would make sense to remove SIZEOF_FIELD() and sizeof_field() quickly so
they don't gain more users, and the remaining FIELD_SIZEOF() users can =
be
whittled away as the patches come through the maintainer trees.

Cheers, Andreas






--Apple-Mail=_31ECB8A0-2497-4644-8BE0-DFE1190172F7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl0AFloACgkQcqXauRfM
H+AuLxAAgNkosRb8jCBUvSkSZcRIz6m3CRCKyZBz9EPhtA2ihZfEB+0hz1uGmXS5
opkX/nM8cIIrc2g/uiWBq6RVg8FFJxC3qVRDhPqDJ5b6jq6Q5WjV98HwBljIKIEM
EWXmiEtnxAQAWrNcYoI0HAI5nMUxpIHxo0+hWnfLhk/fTPoUwgLgZawDmn+pwcND
DU07/6GM67fcfUGYxZKD43X6a/s2lkR28Nn3MN7o2Y/exOm6J0otNWB4Vsu7d6t/
cScoBhni7d5c02FbLXTpab1n/Sjq/+Ijd3yp3ooxjoFvhfqx6YoBYL5fKxZx29HO
AXautmzcIwSccj17hB9lIvq/lLdXBL/k9qiKBcIzImCLxSa9+hMJFcl4gH3Qo4i7
J+7jzFHXnFnx9g5J4rka5VIlGpbBM85N35g8vJZFGVc/juJm6r6YXA+48kKI6hZB
uFH8fNhjYJGDFyiCh637pF5CObUattAasEPN8O8mQ3qxZKg8C/9jvOLgHlI9W9iK
ijBEDk0atDHpIJe3dlUw/fQA7LZ4bvXe07VUBqnBUd+/+7KBLZxLkfnygJXf8nzX
k0TILorUWagkDNgpBE/vwV1ER8UzU6NRxz/w4e6/N/mufG7iPcxZjCTtfJUS3GLW
hPKj3bi6qV6cw+EyroLHp9igONkqhvnPjEFx5a4YA3gAxQ8viSE=
=5D1y
-----END PGP SIGNATURE-----

--Apple-Mail=_31ECB8A0-2497-4644-8BE0-DFE1190172F7--
