Return-Path: <bpf+bounces-18323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1DB818E30
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3C21C21943
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F85286A6;
	Tue, 19 Dec 2023 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjPJ7AQy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16837D08;
	Tue, 19 Dec 2023 17:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3FEC433C7;
	Tue, 19 Dec 2023 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703007155;
	bh=DOLY6rWmqh5ec0k9/aGUb6iYDuhsCvDc9FcVXRqGXm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjPJ7AQyB069VymZHh3C1d/6yI3kNKO1rlQSK0aQhGEFqUitPJlnxGqWupu8g1RZy
	 lZs635rpWABVBGTNxfMl09sax+fbBUJ2fUCAAa77MkhVxbIculES3iUEMK2zyLKc+q
	 04g90wUmD3iof+0tOyTYK92MOs8CazWjav/9DA/lP9Il7wX1FspTWTNo8h48KktKti
	 cjuMEtb5Rs5UzIUSLotj7plo5xgCtYvKGveZVw6eno1iUEnQO7GJxIMAxCvAjsY0B7
	 dRhOHEZrYy8dQ0vmhBjrtqTQrPaGwVSvOhI3xPOWVoPhwRGxw6c0PGkl863m05QFR8
	 ahtIEWe5pafRw==
Date: Tue, 19 Dec 2023 18:32:31 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	bpf@vger.kernel.org, hawk@kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com
Subject: Re: [PATCH v5 net-next 1/3] net: introduce page_pool pointer in
 softnet_data percpu struct
Message-ID: <ZYHTr-26328RpBDf@lore-desk>
References: <cover.1702563810.git.lorenzo@kernel.org>
 <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
 <CANn89iKytnOU3_mR2RidXE74ad3x9QdWxGf+OZei4tpL8Wvcbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CbQoNBFBfWs13DN6"
Content-Disposition: inline
In-Reply-To: <CANn89iKytnOU3_mR2RidXE74ad3x9QdWxGf+OZei4tpL8Wvcbw@mail.gmail.com>


--CbQoNBFBfWs13DN6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Dec 14, 2023 at 3:30=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
> >
> > Allocate percpu page_pools in softnet_data.
> > Moreover add cpuid filed in page_pool struct in order to recycle the
> > page in the page_pool "hot" cache if napi_pp_put_page() is running on
> > the same cpu.
> > This is a preliminary patch to add xdp multi-buff support for xdp runni=
ng
> > in generic mode.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  include/linux/netdevice.h       |  1 +
> >  include/net/page_pool/helpers.h |  5 +++++
> >  include/net/page_pool/types.h   |  1 +
> >  net/core/dev.c                  | 39 ++++++++++++++++++++++++++++++++-
> >  net/core/page_pool.c            |  5 +++++
> >  net/core/skbuff.c               |  5 +++--
> >  6 files changed, 53 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 1b935ee341b4..30b6a3f601fe 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -3319,6 +3319,7 @@ struct softnet_data {
> >         int                     defer_count;
> >         int                     defer_ipi_scheduled;
> >         struct sk_buff          *defer_list;
> > +       struct page_pool        *page_pool;
> >         call_single_data_t      defer_csd;
> >  };
>=20
> This field should be put elsewhere, not in this contended cache line.

ack, I think we could add a percpu dedicated pointer for it.

Regards,
Lorenzo

--CbQoNBFBfWs13DN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZYHTrwAKCRA6cBh0uS2t
rBAFAP4ijVWyw72BYaRqhg68zQNqUWJ+kMkRtWwAsGew9NjQmgEAqGpMs7dKz4YQ
V6jwoyX9cgiJcBC2j7/htNO/0C11Tgc=
=lP2u
-----END PGP SIGNATURE-----

--CbQoNBFBfWs13DN6--

