Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3043B7324
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhF2N0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 09:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233625AbhF2NZ6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 09:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624973011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EyvaCkZhOMSHx3o21qIXEKCGCED9gI6ag82jMyhH/Sg=;
        b=hurU+CJnDsKaaYSZkkeqGxqPhtgJ2sar5z1HZKl3LUN2Y7QP2G4wc9kOw/9kfublDNVlX0
        LiPOPCU/jXb51RhJocqhw55Xq8RSKm8XphpbiTBL0ZeZ6nw5QpmHhvCj01OIIYXtl2olXC
        JyiJFaGzFEjFlXp9BnXRb7/JsNY6bxU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-aO7U67jfPX21n6pmH5cEfw-1; Tue, 29 Jun 2021 09:23:29 -0400
X-MC-Unique: aO7U67jfPX21n6pmH5cEfw-1
Received: by mail-wm1-f70.google.com with SMTP id n11-20020a05600c3b8bb02901ec5ef98aa0so1385501wms.0
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 06:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EyvaCkZhOMSHx3o21qIXEKCGCED9gI6ag82jMyhH/Sg=;
        b=H3TaHJSozpjhpSFKPD8wpGzW76si32WOsEdDJbk4y4e//77ALsFOvA7eyVEK/p7Xyh
         rM3NY+igy+wj6UJfjOzS4hAAHothSZJgNEXStV8GNsBo8DX7Taw1UfIG5M9RuZ85aBBW
         j9XHaksVuXLQz2e1PIYrQ1AH3MkkGdQ2kWMXPYNwjydqytBYxTYbuNPd/DUYGEyKuv3X
         AmVQTOaniETEu4oeDOzuwGipeC8ugFhGByiSCKM6NV31DRgg2F0ckqCkThWs00ARnRIq
         dT7OhAKT3YFq5n9kL2cq5gcW0om0rcu6Pr0ArG2/u+KOBqo3UkvQ65F+E/ci7cU5WNvn
         VZ5A==
X-Gm-Message-State: AOAM533FM8L/6exwpLEReNAufY9/QjK32Glx4O0JNzfg1DcN9vn0b2CZ
        cc6Dtwq/HQCjQTzb3pQbB67rxfyd2dVXs+k+huixHzflMKaW7wWtYVYxsUy+0wQuDG4MPOgIpoM
        B9/JZzYoJ5ziq
X-Received: by 2002:a05:600c:4848:: with SMTP id j8mr5378975wmo.7.1624973008148;
        Tue, 29 Jun 2021 06:23:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAy9pTIcfHtjG5M9hiqZdtsR7veAROp86GMT0KUa/h/AhCNTJIIsF+C6gf0uOzqFOhL26K6Q==
X-Received: by 2002:a05:600c:4848:: with SMTP id j8mr5378945wmo.7.1624973007947;
        Tue, 29 Jun 2021 06:23:27 -0700 (PDT)
Received: from localhost (net-130-25-105-72.cust.vodafonedsl.it. [130.25.105.72])
        by smtp.gmail.com with ESMTPSA id f2sm8645765wrd.64.2021.06.29.06.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:23:27 -0700 (PDT)
Date:   Tue, 29 Jun 2021 15:23:24 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Eelco Chaudron <echaudro@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        sameehj@amazon.com, dsahern@kernel.org, brouer@redhat.com,
        jasowang@redhat.com, alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v9 bpf-next 10/14] bpf: add multi-buffer support to xdp
 copy helpers
Message-ID: <YNsezApfos+47EZr@lore-desk>
References: <cover.1623674025.git.lorenzo@kernel.org>
 <4d2a74f7389eb51e2b43c63df76d9cd76f57384c.1623674025.git.lorenzo@kernel.org>
 <60d27716b5a5a_1342e208d5@john-XPS-13-9370.notmuch>
 <34E2BF41-03E0-4DEC-ABF3-72C8FF7B4E4A@redhat.com>
 <60d49690a87ae_2e84a2082c@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YP2g8SKWm09WLO9v"
Content-Disposition: inline
In-Reply-To: <60d49690a87ae_2e84a2082c@john-XPS-13-9370.notmuch>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--YP2g8SKWm09WLO9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >=20
> >=20
> > On 23 Jun 2021, at 1:49, John Fastabend wrote:
> >=20
> > > Lorenzo Bianconi wrote:
> > >> From: Eelco Chaudron <echaudro@redhat.com>
> > >>
> > >> This patch adds support for multi-buffer for the following helpers:
> > >>   - bpf_xdp_output()
> > >>   - bpf_perf_event_output()
> > >>
> > >> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> > >> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > >> ---
> > >
> > > Ah ok so at least xdp_output will work with all bytes. But this is
> > > getting close to having access into the frags so I think doing
> > > the last bit shouldn't be too hard?
> >=20
> >=20
> > Guess you are talking about multi-buffer access in the XDP program?
> >=20
> > I did suggest an API a while back, https://lore.kernel.org/bpf/FD3E6E08=
-DE78-4FBA-96F6-646C93E88631@redhat.com/ but I had/have not time to work on=
 it. Guess the difficult part is to convince the verifier to allow the data=
 to be accessed.
>=20
> Ah great I think we had the same idea I called it xdp_pull_data()
> though.
>=20
> Whats the complication though it looks like it can be done by simply
> moving the data and data_end pointers around then marking them
> invalidated. This way the verifier knows the program needs to
> rewrite them. I can probably look more into next week.
>=20
> From my first glance it looks relatively straight forward to do
> now. I really would like to avoid yet another iteration of
> programs features I have to discover and somehow work around
> if we can get the helper into this series. If you really don't
> have time I can probably take a look early next week on an
> RFC for something like above helper.

cool, thx :)
What about discussing APIs during the BPF mtg upstream on Thursday (probably
not next one since most of the people will be in PTO)? I will work on some =
docs.

Regards,
Lorenzo

>=20
>=20
> .John
>=20

--YP2g8SKWm09WLO9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYNseyQAKCRA6cBh0uS2t
rBG5AP40aAEo3QWo/uXjy5xR/9sTxDknxvWEfU422xQFFaExSQD8D2z+yioaQ7WA
2tnW5x2HV/E5vID4hebnOuPKhIYcuwQ=
=+6MP
-----END PGP SIGNATURE-----

--YP2g8SKWm09WLO9v--

