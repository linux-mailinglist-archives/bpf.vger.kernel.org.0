Return-Path: <bpf+bounces-29746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C68E8C62AF
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 10:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4111F21B7B
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168264D5AB;
	Wed, 15 May 2024 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dYUJuOCI"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A84C627;
	Wed, 15 May 2024 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761215; cv=none; b=RMThYnWb0tBCHwj639qy8C2QioBuahhvcGP4XRnWfCJcrcp97o3i6fc5baO6Fzq0VL6nLyB4Q4gqFQx8ABLoTkift9nN0cf6fzeCzJCQRMcqKx/0VAYXa/G4yC+t9WV1E49CSmN0Mq7E2muLvYQ6jHUnllkDUwFFUxFwOX6pbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761215; c=relaxed/simple;
	bh=ISlf6Oang1bIb3NO5GiCyu6dI90A4hgSsCEF1qXyjhM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArqaBRabbKNZVfYxQj1zyy75bk2LUH0N+NymIFHeLLPkbiHH+35QM2p2q0RdsIc2qJlxyT25PNBqOhNmCXFcYVnW0f5gFGlBHMmaY/yt3x8QVo2+T++I72Uz9Op8NaYU4aJPWC072oW09Kw8xIt3SS4HDmB12uy+6hLSafPe454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dYUJuOCI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715761214; x=1747297214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ISlf6Oang1bIb3NO5GiCyu6dI90A4hgSsCEF1qXyjhM=;
  b=dYUJuOCIkC+YxbJ878n4kUTHelvSPJhhx7nD8jrs7Ug8CGYSj8RiB7ko
   4UkTICBt1MTSiYabgz1X2qVIxJQr1CjtrM+wICF/xzqS9JEeBZdGKIgdT
   GuD5csHaSzrYeeBKhn4obpGG2etxGkgD8M/oXyjdiXN2VlMV/+J+PLfB6
   m8k6JJM2CGNNWK8fYktQ4QiwW+jjjtkf17wCbxcbZ83wOxtpKL2YMMznP
   rxlN+Eg5pOgBHwp9gUYPsJdOpXdhx4+bVy+hL4T8lPcHiNyItIXPP7uWK
   sS8IPcgem3BxXaZ0txymcdzAUdMuXk/eZ5i9jjVPHIUT8nlKzaMm6CapB
   A==;
X-CSE-ConnectionGUID: abhP6raiRY2CWqedFddvng==
X-CSE-MsgGUID: 4iB1jHs7SKKoyuFQP8+Gpg==
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="asc'?scan'208";a="255643733"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2024 01:20:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 01:20:04 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 01:20:00 -0700
Date: Wed, 15 May 2024 09:19:46 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Andrew Jones <ajones@ventanamicro.com>
CC: "Wang, Xiao W" <xiao.w.wang@intel.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "luke.r.nels@gmail.com"
	<luke.r.nels@gmail.com>, "xi.wang@gmail.com" <xi.wang@gmail.com>,
	"bjorn@kernel.org" <bjorn@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "pulehui@huawei.com"
	<pulehui@huawei.com>, "Li, Haicheng" <haicheng.li@intel.com>,
	"conor@kernel.org" <conor@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v2] riscv, bpf: Optimize zextw insn with Zba extension
Message-ID: <20240515-cone-getting-d17037b51e97@wendy>
References: <20240511023436.3282285-1-xiao.w.wang@intel.com>
 <20240513-5c6f04fb4a29963c63d09aa2@orel>
 <DM8PR11MB575179A3EB8D056B3EEECA74B8E32@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20240514-944dec90b2c531d8b6c783f7@orel>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PCtwkfT5UTiocbOE"
Content-Disposition: inline
In-Reply-To: <20240514-944dec90b2c531d8b6c783f7@orel>

--PCtwkfT5UTiocbOE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 03:37:02PM +0200, Andrew Jones wrote:
> On Tue, May 14, 2024 at 07:36:04AM GMT, Wang, Xiao W wrote:
> > > From: Andrew Jones <ajones@ventanamicro.com>
>> > > > +config RISCV_ISA_ZBA
> > > > +	bool "Zba extension support for bit manipulation instructions"
> > > > +	depends on TOOLCHAIN_HAS_ZBA
> > >=20
> > > We handcraft the instruction, so why do we need toolchain support?
> >=20
> > Good point, we don't need toolchain support for this bpf jit case.
> >=20
> > >=20
> > > > +	depends on RISCV_ALTERNATIVE
> > >=20
> > > Also, while riscv_has_extension_likely() will be accelerated with
> > > RISCV_ALTERNATIVE, it's not required.
> >=20
> > Agree, it's not required. For this bpf jit case, we should drop these t=
wo dependencies.
> >=20
> > BTW, Zbb is used in bpf jit, the usage there also doesn't depend on too=
lchain and
> > RISCV_ALTERNATIVE, but the Kconfig for RISCV_ISA_ZBB has forced the dep=
endencies
> > due to Zbb assembly programming elsewhere.
> > Maybe we could just dynamically check the existence of RISCV_ISA_ZB* be=
fore jit code
> > emission? or introduce new config options for bpf jit? I prefer the fir=
st method and
> > welcome any comments.
>=20
> My preferences is to remove as much of the TOOLCHAIN_HAS_ stuff as
> possible. We should audit the extensions which have them to see if
> they're really necessary.

While I think it is reasonable to allow the "RISCV_ISA_ZBB" option to
control whether or not bpf is allowed to use it for optimisations, only
allowing bpf to do that if there's toolchain support feels odd to me..
Maybe we need to sorta steal from Charlie's patchset and introduce
some hidden options that have the toolchain dep that are used by the
alternative macros etc?

I'll have a poke at how bad that looks I think.

> I don't mind depending on RISCV_ALTERNATIVE,
> since it's almost required for riscv at this point anyway.

As you say, using on riscv_has_extension_likely() doesn't mean you
depend on alternatives so effectively all this does is rule out use
with XIP, since alternatives are selected when !XIP. Does BPF even work
for XIP?

--PCtwkfT5UTiocbOE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkRwIgAKCRB4tDGHoIJi
0oNrAP9q45vV3szU20JF9S6wc6DveShfdByLH9gPMYtr7jfQJwEAgOlRs5bh/aUj
XQBTHLztm+XoKiwl2Q24JAHreZtb9Ac=
=/lH/
-----END PGP SIGNATURE-----

--PCtwkfT5UTiocbOE--

