Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D913B7319
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhF2NVk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 09:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233056AbhF2NVj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 09:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624972751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9sHcsQOuAI442sog/aSxSVSPsanByNNgiypV7I0rypc=;
        b=PlH77S5hFY+VJfd2gUo4ea0UzlMzP4uVOnvHrQ/02QfTM8diq2ZOhnjKIZ0A/yBGJdiazK
        Xa/hu3odCtHe5H7ofRT7TszbfBDj53AeblafbmAYH92nx7MGT1pmrEaF4MaKYGMeQudF42
        ayv/Rwzc2IcxKt/w8lp7YPlsF3C3l88=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-2QmNpf5mPO6Nvu8RApMITw-1; Tue, 29 Jun 2021 09:19:09 -0400
X-MC-Unique: 2QmNpf5mPO6Nvu8RApMITw-1
Received: by mail-ej1-f70.google.com with SMTP id q14-20020a1709066aceb029049fa6bee56fso5662347ejs.21
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 06:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9sHcsQOuAI442sog/aSxSVSPsanByNNgiypV7I0rypc=;
        b=pIZyI/nqSkLXdgnONJO6daP/UAAB9BRllQzyiVoeP66DVQ8UuvhQrO0b0iIYERbB74
         zLn0sKKlcuAl68cfkAz8JPLz0FC/8OBGUetDx53VAEHOO/w8fc+Xx1WZ0rroRSaHuWhN
         l7u5hmIVTNJQS3SX7HS0K9SS4nZkYU+aCcGjjBId0Pmt2RKX7a2aZPl1J4Fd09OEVgEP
         v90L0mfWa0p6/XPckTqhMZdg7PpYGVClq9YZShnHk2fzEhxiT6i6nGg2RA2xsN5Cvwqm
         jLWyepriIz8UKvpRx6oAfPgehpZ7LYKd7BO/zkNDVlV62sc2366xb99ML+sgRuzV+TB7
         3eFQ==
X-Gm-Message-State: AOAM532+LBbnqrgnZH3klMWGItK9X9Poj6iKMrtd60CLUAp0pWSw2V0E
        pKSoyEvLZz0qbynvrg+yJPnEPKpoeIl2tszofcj4rSqyTRaptqB/a8xpP0OYmniDWyKdw3w46tE
        Nqv7LG3O9AmTe
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr40175222edx.23.1624972748743;
        Tue, 29 Jun 2021 06:19:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDsQp7N34zA47orkQftvjxZe94F0DDsMLpEM3eOQyW/Ehm6YetmwMvr9DmXQCjG5+a5yJUJg==
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr40175181edx.23.1624972748564;
        Tue, 29 Jun 2021 06:19:08 -0700 (PDT)
Received: from localhost (net-130-25-105-72.cust.vodafonedsl.it. [130.25.105.72])
        by smtp.gmail.com with ESMTPSA id o5sm11453514edt.44.2021.06.29.06.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:19:08 -0700 (PDT)
Date:   Tue, 29 Jun 2021 15:19:04 +0200
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
Subject: Re: [PATCH v9 bpf-next 08/14] bpf: add multi-buff support to the
 bpf_xdp_adjust_tail() API
Message-ID: <YNsdyD6OBXcf5mUa@lore-desk>
References: <cover.1623674025.git.lorenzo@kernel.org>
 <863f4934d251f44ad85a6be08b3737fac74f9b5a.1623674025.git.lorenzo@kernel.org>
 <60d2744ee12c2_1342e208f7@john-XPS-13-9370.notmuch>
 <4F52EE5B-1A3F-46CE-9A39-98475CA6B684@redhat.com>
 <60d495a914773_2e84a2082d@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tznHQPPHO+zXBivO"
Content-Disposition: inline
In-Reply-To: <60d495a914773_2e84a2082d@john-XPS-13-9370.notmuch>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--tznHQPPHO+zXBivO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Eelco Chaudron wrote:
> >=20
> >=20
> > On 23 Jun 2021, at 1:37, John Fastabend wrote:
> >=20
> > > Lorenzo Bianconi wrote:
> > >> From: Eelco Chaudron <echaudro@redhat.com>
> > >>
> > >> This change adds support for tail growing and shrinking for XDP mult=
i-buff.
> > >>
> > >
> > > It would be nice if the commit message gave us some details on how the
> > > growing/shrinking works in the multi-buff support.
[...]
> > Guess this is the tricky part, applications need to be multi-buffer awa=
re. If current applications rely on bpf_xdp_adjust_tail(+) to determine max=
imum frame length this approach might not work. In this case, we might need=
 an additional helper to do tail expansion with multi buffer support.
> >=20
> > But then the question arrives how would mb unaware application behave i=
n general when an mb packet is supplied?? It would definitely not determine=
 the correct packet length.
>=20
> Right that was my conclusion as well. Existing programs might
> have subtle side effects if they start running on multibuffer
> drivers as is. I don't have any good ideas though on how
> to handle this.

what about checking the program capabilities at load time (e.g. with a
special program type) and disable mb feature if the bpf program is not
mb-aware? (e.g. forbid to set the MTU greater than 1500B in xdp mode).

Regards,
Lorenzo

>=20
> >=20
> > >> +	} else {
> >=20
>=20
>=20

--tznHQPPHO+zXBivO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYNsdxgAKCRA6cBh0uS2t
rJOBAQDaMv4E/rirRgUa/kmcdDhrVSGYvt+7rNMZva3gG4VF8QD+MCf0UAfWpDcu
Vgoli23bofiZUssU29hFwzy+3NM5CQg=
=tDzY
-----END PGP SIGNATURE-----

--tznHQPPHO+zXBivO--

