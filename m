Return-Path: <bpf+bounces-31573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B828FFDF9
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 10:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB55286644
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA315B0F8;
	Fri,  7 Jun 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REFWItkG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4315B0F0;
	Fri,  7 Jun 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748808; cv=none; b=Ijwb1XVcbpm8GEpS1TJBeKj3ryBHt30M/QzS+vrPQwqxeoJGVp8FOYFR9fr95Wz5T+rKZSJK37iG0KcdISQMuIkfbURmLtkUt/Grb8OClKl36ofHpvfokH9qalDCsIWa5+XIdvURvPSK/sj/7nk/A2iqGpJ1XYq6mtEEORwBmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748808; c=relaxed/simple;
	bh=O6OzUbqAekTV4J/eVvhqJ9Tniy1uY7cuH31yR4TMCug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmhJbn5pxBgccJhEj+1Lkbl6Z3W6mMMePO7iOVfnC2d4lEMFco+d+L1QdGrqisTJmt9k6zSj8UWKwEWWZtveb2/quohztZON6qhcQZ7qNFYtrQPGK4CFNQKRgJQuj8qRMzEb9z+ZoUE6ePjf364FFzZcfyHFd5WFyafGRRRti0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REFWItkG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b93370ad0so2501125e87.2;
        Fri, 07 Jun 2024 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717748804; x=1718353604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OFZkGeshCcQpSdoBExD30oxf+WozrVkEn2Rgo3xnGo=;
        b=REFWItkG5xrDK0vAN6TjkgqWPvKYOSXwX+0CGnj5wX3/wP5BRwSa1U+3pgS1A1jc0f
         l7awQ7yOHklUCatk3voc7T1ziFhAYfTZe6O74EJ6XIjNeCzxHQRWaiOzHOCNN0FoWgPT
         tRu9xntE8GejtnsgcXQppLrQtrXpbgCoyt5/53Vd32HzH90zZMq1PEJ0Jo6Z7JCmmCwU
         AmC1rWd0R1LmczRt256Vqx+XPL8/cJrQEY1hDHGoQKMqIj711AF0VKN9r7MyVqw3ZYtj
         C9j9XxcghNe8JH08/pe6T/+q4mYkv3xDBR/u9cZeQ7IX9dUK7SisUZKIck7CHcbycF82
         0i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717748804; x=1718353604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OFZkGeshCcQpSdoBExD30oxf+WozrVkEn2Rgo3xnGo=;
        b=JN2xTxFtM/XEBreEkXPFlewTMDQXU9mVlESHJHJSTdMMrBChdXCC5ceyWWR7ogTqHX
         rsXmHncTbPvki2YkaxV5YFCN5KSgeN5IWA1ms+N8v69SCYu0Wk73r+T/ISF0AX4xt8Wi
         +EdVMjEQmR13vVw2XSPZ14hqcMOFgJ5zlN2fqXjG3HeV4u3YXlaZA95mFnHmHC9NjHfW
         /FhdyNilISOSRcazYt8Qw8CkJDFHSaLg7fr9bB8ItBaSwM7XsNhlxy81U/JBuHKn8Duw
         vwP3P41VLYKHpZ4bdH3B1nP4F7tzF6YRCLrQd50DVeEYfsgP7ixZDv6y+W5njA6HPt4X
         nJMA==
X-Forwarded-Encrypted: i=1; AJvYcCWrc1pduZnxT7TBQchM5FFZw/FnU/rHb9Ehb4fCjRIuvv7aZvHZ1A2RsgfREZsl9yukyHuHByhUMh5w4ZoHqsxdu2tuqhR7TmEtbAkrtAQTAbJ9iNdGdlMIyJQWc1JIkXMmUqgUSuBzTG+Tc8YGp5Ud+wJCXSSL99BSJA==
X-Gm-Message-State: AOJu0Yy+nCodHV65cVJpGgN64VLAhLqRV3aAcuOPbSvJcuzXT7ERaOjN
	aGgcMlnfgXTFGW0GykGAuBnRPiy9whp8maNMCFP9ysft/9yE9r8Y
X-Google-Smtp-Source: AGHT+IH29g22z5u03JtOU46VR64CyxxDwQVvl4pLd67eJL4Q+W7+cHIPGnYYI5A2MlgJ18OSu+TLGg==
X-Received: by 2002:a05:6512:4891:b0:523:9515:4b74 with SMTP id 2adb3069b0e04-52bb9f62754mr1598706e87.14.1717748804213;
        Fri, 07 Jun 2024 01:26:44 -0700 (PDT)
Received: from localhost (77-162-229-73.fixed.kpn.net. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072b010sm210252866b.214.2024.06.07.01.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:26:43 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Date: Fri, 7 Jun 2024 10:26:41 +0200
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: Matthias Schwarzott <zzam@gentoo.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Jan Engelhardt <jengelh@inai.de>, Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>, J B <jb.1234abcd@gmail.com>
Subject: Re: ANNOUNCE: pahole v1.26 (more holes, --bpf_features,
 --contains_enum)
Message-ID: <ZmLEQRqznwSowCIi@localhost>
References: <YbC5MC+h+PkDZten@kernel.org>
 <ZkXTmTvII2PDqVvx@localhost>
 <f3fb90a2-5822-4cb9-ba5a-023f74f2e806@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SWhq1PSUxtI1Z5PO"
Content-Disposition: inline
In-Reply-To: <f3fb90a2-5822-4cb9-ba5a-023f74f2e806@gentoo.org>


--SWhq1PSUxtI1Z5PO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 09:03:14AM +0200, Matthias Schwarzott wrote:
> Am 16.05.24 um 11:36 schrieb Domenico Andreoli:
> > On Wed, Feb 28, 2024 at 04:39:21PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > Hi,
> > > 	The v1.26 release of pahole and its friends is out, showing more
> [...]
> > >=20
> > > tarball + gpg signature:
> > >=20
> > >     https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.xz
> > >     https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.bz2
> > >     https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.sign
> >=20
> > Which key do you use to sign this?          ^^^^^^^^^^^^^^^^^^^^^
>=20
> Hi!

Hi!

>=20
> I found the matching key in git on kernel.org:
>=20
> https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/plain/keys/D65016F=
35352AA40.asc
>=20
> The gentoo package uses this key for verification now.

Thanks! I wanted indeed to use it for verification also in Debian.

>=20
> Regards
> Matthias

Dom

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--SWhq1PSUxtI1Z5PO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIhioiE2Z74CX+BiELwJgSGECT1EFAmZixDoACgkQLwJgSGEC
T1EHqA//XhVFrXl5DaDxkJVBQcc+yvHusgN9HAph50jLmSwi5E3N+c/qs5sE+UZc
QU3s7dCN74VPg7hJTd/jFT/kq0HHP3drz8YJYTc8p5sDCq7ssaOjV4XFdxvJFezR
2kGbiceF7znotcTBowH6+UnFfKZapEbQT00fi+B9QrvLN+xFuaicXLSVcWfqk7AY
OjNZfvMRF/bc7QOqebe3uTPWDEW69RD34kb/f71n3ByAIxJHRXH/EhBwyAnyHWLL
cjbk+KjytkV21p0W1DUg/2Ulvhl2l30CccD6a9+cV7OT0KrHbKqt0BroqWYJQmlt
NGyMbbZ4NhuXQoY0qAyF1iNb5PFUwhdhiptLcUIu6eFZJ2vlQHpeW7GuKKbYCC6M
csuYKtiAb3yDsH1LRrEqbCyaX5VBKGm8ZAR1v5uNQ0aHrZQApg3Id+VjUT0aDkBk
n3bTWkN/rV9y5SD9sg1AaW8eXg7XpYNwSGCx7ybqsGDdNDw7RQs3IIO0HHn7Yi3T
OotzX3oez4Lh7eTWlQBu9bOlmAPZfGO01hH/VqnmdkMOJ3lZSDOJxkv+Ci2o9CA7
5LJMEZh9zVn0Yxtgze5twoGVL4X5bcegpHwYVi0U0NaTFCmOX9VOuNlq4c5Lg9ad
OzZyZiZufWIzOZEYhEu6V71eXawJiMu567wf4dstrHDLZjsRNtU=
=5CzK
-----END PGP SIGNATURE-----

--SWhq1PSUxtI1Z5PO--

