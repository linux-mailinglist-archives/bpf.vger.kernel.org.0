Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF712D6678
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 20:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393327AbgLJT34 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 14:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393380AbgLJT3i (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 14:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607628491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=omCvcs/DfXzJefzlykaXhyPIzlw/HpjWeUkr0sJCAcA=;
        b=bAllAoJ84RYmrzIkPrOt+gi7udDmwZBxEF/nEPMnBu+1Hy+kyBdIQlo9vjO2rreMiqfPeP
        yPYomKX+UrtrK75SUE3qH9+jtSmMAEJYue19wKMzpDdxYDPdSacHbDqtpK/nwQzBAo1h86
        IKtHkQBa7oveTIF6H7aYru+aRIkqLtM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-8rD2PQYMNYS2YzvCR1Y8Wg-1; Thu, 10 Dec 2020 14:28:10 -0500
X-MC-Unique: 8rD2PQYMNYS2YzvCR1Y8Wg-1
Received: by mail-wr1-f69.google.com with SMTP id u29so2320201wru.6
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 11:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omCvcs/DfXzJefzlykaXhyPIzlw/HpjWeUkr0sJCAcA=;
        b=fjD4pRJn8Ac0qHyeT+OutajjRwkaT2s35pbJt32ULKwryFGYabfa6QdwuQxmhMiG7j
         m7VXrzOQ8780oJ/WQQJM+sH0lE5ggnsIzJmYtZLQy0xnJNKSn1vzHaYh4vNT7BbcbtlD
         qqPQhOa6d8LMsRTgNfmMHZyYaIVduamDIKfNXJ1ojYlkUQ7yixw2Y6u0dIXb6JkUcJXc
         dGWGzsrtfOpNQPN9FWLQRQ6ZmEX0eJvsMN9j/U3AO8pnt7Mfdgz938Hyf/W0PqiMAhwl
         KuOaRYsYK5mKNEzCrMAy9uy+ceHBWY7BJWZ4Mg8sjTs7UNiBhinsoZUyPQy+1hubbMAs
         UTUg==
X-Gm-Message-State: AOAM530PG1emHhfOqGLNSeUXhNdTORyOwzi0t8FuuQPwOESYKuCCtezO
        VLXqUbdwxNCZt0mWRnK3GgVrHUrnXnCjd9oTHYlw+vik3ESlDKFZVT7IY05i2q0qE1Ivf3/HjO1
        ADJBoBETyTWJS
X-Received: by 2002:a1c:b7d4:: with SMTP id h203mr9950383wmf.59.1607628488407;
        Thu, 10 Dec 2020 11:28:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxw70K/v4HbP7cMSk0tI75tjgdD/4p5cSqq5D1NmHRnsN3mHgY+7qkZCK8JBG83GwKrHt1dsg==
X-Received: by 2002:a1c:b7d4:: with SMTP id h203mr9950366wmf.59.1607628488221;
        Thu, 10 Dec 2020 11:28:08 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id s13sm10430112wmj.28.2020.12.10.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 11:28:07 -0800 (PST)
Date:   Thu, 10 Dec 2020 20:28:04 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, brouer@redhat.com,
        alexander.duyck@gmail.com
Subject: Re: [PATCH bpf-next] net: xdp: introduce xdp_init_buff utility
 routine
Message-ID: <20201210192804.GC462213@lore-desk>
References: <e54fb61ff17c21f022392f1bb46ec951c9b909cc.1607615094.git.lorenzo@kernel.org>
 <20201210160507.GC45760@ranger.igk.intel.com>
 <20201210163241.GA462213@lore-desk>
 <20201210165556.GA46492@ranger.igk.intel.com>
 <20201210175945.GB462213@lore-desk>
 <721648a5e14dadc32629291a7d1914dd1044b7d0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <721648a5e14dadc32629291a7d1914dd1044b7d0.camel@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 2020-12-10 at 18:59 +0100, Lorenzo Bianconi wrote:
> > On Dec 10, Maciej Fijalkowski wrote:
> > > On Thu, Dec 10, 2020 at 05:32:41PM +0100, Lorenzo Bianconi wrote:
> > > > > On Thu, Dec 10, 2020 at 04:50:42PM +0100, Lorenzo Bianconi
> > > > > wrote:
> > > > > > Introduce xdp_init_buff utility routine to initialize
> > > > > > xdp_buff data
> > > > > > structure. Rely on xdp_init_buff in all XDP capable drivers.
> > > > >=20
> > > > > Hm, Jesper was suggesting two helpers, one that you implemented
> > > > > for things
> > > > > that are set once per NAPI and the other that is set per each
> > > > > buffer.
> > > > >=20
> > > > > Not sure about the naming for a second one - xdp_prepare_buff ?
> > > > > xdp_init_buff that you have feels ok.
> > > >=20
> > > > ack, so we can have xdp_init_buff() for initialization done once
> > > > per NAPI run and=20
> > > > xdp_prepare_buff() for per-NAPI iteration initialization, e.g.
> > > >=20
> > > > static inline void
> > > > xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
> > > > 		 int headroom, int data_len)
> > > > {
> > > > 	xdp->data_hard_start =3D hard_start;
> > > > 	xdp->data =3D hard_start + headroom;
> > > > 	xdp->data_end =3D xdp->data + data_len;
> > > > 	xdp_set_data_meta_invalid(xdp);
> > > > }
> > >=20
> > > I think we should allow for setting the data_meta as well.
> > > x64 calling convention states that first four args are placed onto
> > > registers, so to keep it fast maybe have a third helper:
> > >=20
> > > static inline void
> > > xdp_prepare_buff_meta(struct xdp_buff *xdp, unsigned char
> > > *hard_start,
> > > 		      int headroom, int data_len)
> > > {
> > > 	xdp->data_hard_start =3D hard_start;
> > > 	xdp->data =3D hard_start + headroom;
> > > 	xdp->data_end =3D xdp->data + data_len;
> > > 	xdp->data_meta =3D xdp->data;
> > > }
> > >=20
> > > Thoughts?
> >=20
> > ack, I am fine with it. Let's wait for some feedback.
> >=20
> > Do you prefer to have xdp_prepare_buff/xdp_prepare_buff_meta in the
> > same series
> > of xdp_buff_init() or is it ok to address it in a separate patch?
> >=20
>=20
> you only need 2
> why do you need xpd_prepare_buff_meta? that's exactly
> what xdp_set_data_meta_invalid(xdp) is all about.

IIUC what Maciej means is to avoid to overwrite xdp->data_meta with
xdp_set_data_meta_invalid() after setting it to xdp->data in
xdp_prepare_buff_meta().
I guess setting xdp->data_meta to xdp->data is valid, it means an empty meta
area.
Anyway I guess we can set xdp->data_meta to xdp->data wherever we need and =
just
keep xdp_prepare_buff(). Agree?

Regards,
Lorenzo

>=20
>=20

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX9J2wgAKCRA6cBh0uS2t
rExgAQCEHQ1ohiffZYAZUyuEL0cf+WFe2mVJaFBIS5IX/EdvmQD/V05jNJ7rx+4V
uMmb+f9rM6X2vKlseVJjXy6t9mnmpQU=
=lyrM
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--

