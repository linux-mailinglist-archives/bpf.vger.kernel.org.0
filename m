Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884232D28F7
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgLHKch (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 05:32:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727463AbgLHKch (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Dec 2020 05:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607423471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FnDYozib2j1IcsXrxXmhP6xX5mNvo6P0PV0t/hQYgKw=;
        b=gn6PSSa92x931H3a914MeaU328g2yxzr47JUTaB+iWHbzhMsbUJwtvdrA9jsTY1nMHqVYL
        Uh7qi1evGL3E4dRcc8bUvrPmcX3z7shXiFi1DsxNq9kSdx+wP1ZnUnBfpU8UClfjSEvmij
        36NbTfusDgCIDOdntCOeM458crgZ+T4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-qqcXS0z-NNC9_dox2TE6bA-1; Tue, 08 Dec 2020 05:31:09 -0500
X-MC-Unique: qqcXS0z-NNC9_dox2TE6bA-1
Received: by mail-ej1-f70.google.com with SMTP id u25so4954772ejf.3
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 02:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FnDYozib2j1IcsXrxXmhP6xX5mNvo6P0PV0t/hQYgKw=;
        b=tIM489ETM2hMb4qQtOgjkGTH0keNJZykxHqclNoBZLyfpuRSuZRNqiiANuOVZEAcko
         KXtyLztfVsrISSsvVPLw3ZWU/TIvgXYsqaOvycy/xNIy6+tK4EWaK84ptup2KJJHJpno
         OoiT6nkRAwDOZy5epJ6krGcVRSwiHV4cvo7FACu5V7y/NxlcwC6kZ+Fgx6IzRPkwFpjx
         kb3tESD6oJ/TpmjmgOE0MIK6TC4jXe4u2F9lqMaENLAspGl7gZKazcca3hq3OmoNB5nP
         OPz3XWMUTvWecF9m+AjlgsHqFAhd9QL6/4i9y+hIVdjTxlUo71yK0c2lN8XCqEcy66tS
         rR5w==
X-Gm-Message-State: AOAM531+LF2aSneZLIFvfd60z8oFpW1wYwRet3ptRGxTu6CAt1wnGUH2
        VsaH5m97vaV06uhD8fnV717tKqyLoaM5yq4l1+ZCFJ7Y9SqKbGfhm0YUe2rMekmAUFq2JYGhjuP
        BixclTJz9cjDx
X-Received: by 2002:aa7:db01:: with SMTP id t1mr24079067eds.185.1607423467742;
        Tue, 08 Dec 2020 02:31:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6tXAsFEiXruf6FrfDvFEY/oYdV5P5h4j478j1AfYgBH0yJT44zQ3037zqa1IPoDbXj2YBwA==
X-Received: by 2002:aa7:db01:: with SMTP id t1mr24079039eds.185.1607423467501;
        Tue, 08 Dec 2020 02:31:07 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id q4sm12780248ejc.78.2020.12.08.02.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 02:31:06 -0800 (PST)
Date:   Tue, 8 Dec 2020 11:31:03 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        "Jubran, Samih" <sameehj@amazon.com>,
        John Fastabend <john.fastabend@gmail.com>, dsahern@kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v5 bpf-next 02/14] xdp: initialize xdp_buff mb bit to 0
 in all XDP drivers
Message-ID: <20201208103103.GB36228@lore-desk>
References: <cover.1607349924.git.lorenzo@kernel.org>
 <693d48b46dd5172763952acd94358cc5d02dcda3.1607349924.git.lorenzo@kernel.org>
 <CAKgT0UcjtERgpV9tke-HcmP7rWOns_-jmthnGiNPES+aqhScFg@mail.gmail.com>
 <20201207213711.GA27205@ranger.igk.intel.com>
 <71aa9016c087e4c8d502d835ef2cddad42b56fc1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <71aa9016c087e4c8d502d835ef2cddad42b56fc1.camel@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 2020-12-07 at 22:37 +0100, Maciej Fijalkowski wrote:
> > On Mon, Dec 07, 2020 at 01:15:00PM -0800, Alexander Duyck wrote:
> > > On Mon, Dec 7, 2020 at 8:36 AM Lorenzo Bianconi <lorenzo@kernel.org
> > > > wrote:
> > > > Initialize multi-buffer bit (mb) to 0 in all XDP-capable drivers.
> > > > This is a preliminary patch to enable xdp multi-buffer support.
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > >=20
> > > I'm really not a fan of this design. Having to update every driver
> > > in
> > > order to initialize a field that was fragmented is a pain. At a
> > > minimum it seems like it might be time to consider introducing some
> > > sort of initializer function for this so that you can update things
> > > in
> > > one central place the next time you have to add a new field instead
> > > of
> > > having to update every individual driver that supports XDP.
> > > Otherwise
> > > this isn't going to scale going forward.
> >=20
> > Also, a good example of why this might be bothering for us is a fact
> > that
> > in the meantime the dpaa driver got XDP support and this patch hasn't
> > been
> > updated to include mb setting in that driver.
> >=20
> something like
> init_xdp_buff(hard_start, headroom, len, frame_sz, rxq);
>=20
> would work for most of the drivers.
>=20

ack, agree. I will add init_xdp_buff() in v6.

Regards,
Lorenzo

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX89V5AAKCRA6cBh0uS2t
rOpqAP4m7g+arPis5Ksw1syRztjci8dHH9eLUuApBtt0eu68jgEA5rygFkdoYXh2
ZMgokToLUtIdRGhxdjk1221LIIxGxgc=
=b4al
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--

