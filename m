Return-Path: <bpf+bounces-29759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A1D8C65E9
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 13:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA8B22EE8
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F946F513;
	Wed, 15 May 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kwyUd6Y3"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007AC5A0F5;
	Wed, 15 May 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715773904; cv=none; b=j4IL3j4FUJG59XWFhCy3MOgLjH25/GQI1Z+1mhuBRP9LzIvj+gHTx++U7DEzriyiObjCdaMmDfgEhGJQ4ZsR9MnJrJPGB8sm4jEM9PaCnCqr0Jm/xBDwbU3TBdv5e3IgcVNbisE9eT7x2nYDNWCf90W/uqNo0JfnrRrDdBX/N4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715773904; c=relaxed/simple;
	bh=GdvQ3kH47JlZhzV5G7bHu6bKjpEJvCPgt4JPEYVNd3A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcF5wCBA+LFs3YMbkEy2oamGlc6ofK6TvCh3JUKG7/c3Ta6/K2VDAjIXaAc6aVMDS/A+Q25HlgLBEN/hsqnIZmTk7xn9FNh5HzIgFu+uv9ucpCrCGbdz94ylsu1mz7iiM8HzoRqDrw9p1LLVZ0qu1CQM4s4VwuoxHIjJW5yTdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kwyUd6Y3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715773901; x=1747309901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GdvQ3kH47JlZhzV5G7bHu6bKjpEJvCPgt4JPEYVNd3A=;
  b=kwyUd6Y3O87zVnp6ORJIAFBHpJIfjn8wPpBTNaiulqBl0Rf2K3M870fx
   Y2PVKr3Zak1z9/lZRMdVbh1IDT5Hw+B7g1kMh7U4daeD/Y2pFuvhKEbS4
   4or6D77ONCMk1X64o8Lb7AsZMQhJuoRdcqdxz4VnoAsvgi2vHOUawFsKO
   diG13Bs4U1vmV2yvXQvucsHysEQm7KKiGIm764xglPuNZYM8DupefFdc6
   I1tI0J6dcZXr0mYEARHe9lszzB1P5WgrebSX1G5X6YvDBdA22IYWsONNF
   j+nDF+ZesHKY5+AQU/fvbYauZ+3vMTU9hz/rMvp/7UDUew/FP0N/hC9WN
   w==;
X-CSE-ConnectionGUID: ud8/5qnhRsubTfo6bloRBg==
X-CSE-MsgGUID: YPeKYJfeQtqP+N3X1UJ6iw==
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="asc'?scan'208";a="192175672"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2024 04:51:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 04:51:23 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 04:51:19 -0700
Date: Wed, 15 May 2024 12:51:04 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: "Wang, Xiao W" <xiao.w.wang@intel.com>
CC: Andrew Jones <ajones@ventanamicro.com>, "paul.walmsley@sifive.com"
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
Message-ID: <20240515-wobble-stack-5b9264c12f37@wendy>
References: <20240511023436.3282285-1-xiao.w.wang@intel.com>
 <20240513-5c6f04fb4a29963c63d09aa2@orel>
 <DM8PR11MB575179A3EB8D056B3EEECA74B8E32@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20240514-944dec90b2c531d8b6c783f7@orel>
 <20240515-cone-getting-d17037b51e97@wendy>
 <20240515-jogger-pummel-19fe4e9e8314@wendy>
 <DM8PR11MB5751A2BB91C431DAE14F48C1B8EC2@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="maladpWpE2+wJpPh"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751A2BB91C431DAE14F48C1B8EC2@DM8PR11MB5751.namprd11.prod.outlook.com>

--maladpWpE2+wJpPh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 11:31:43AM +0000, Wang, Xiao W wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > > > My preferences is to remove as much of the TOOLCHAIN_HAS_ stuff as
> > > > possible. We should audit the extensions which have them to see if
> > > > they're really necessary.
> > >
> > > While I think it is reasonable to allow the "RISCV_ISA_ZBB" option to
> > > control whether or not bpf is allowed to use it for optimisations, on=
ly
> > > allowing bpf to do that if there's toolchain support feels odd to me..
> > > Maybe we need to sorta steal from Charlie's patchset and introduce
> > > some hidden options that have the toolchain dep that are used by the
> > > alternative macros etc?
> > >
> > > I'll have a poke at how bad that looks I think.
> >=20
> > I don't love this, in particular my option naming, but it would allow
> > the Zbb optimisations in the kernel to not depend on toolchain support
> > while not muddying the Kconfig waters for users:
> > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/=
?h=3Dri
> > scv-zbb_split
>=20
> In that patch, I think the bpt jit part should check IS_ENABLED(CONFIG_RI=
SCV_ISA_ZBB)
> rather than IS_ENABLED(CONFIG_RISCV_ISA_ZBB_ALT).

D'oh, you're right. The bpf code being different was meant to be the whole
point of the change...

> > A similar model could be followed if there were to be some
> > optimisations for Zba in the future that do require toolchain support:
>=20
> Though this model introduces extra hidden Kconfig option, it does provide=
 finer=20
> config granularity. This should be a separate patch in the future, we can=
 discuss about
> the option naming there.

Yeah, not expecting you to do this as part of this patch.

Thanks,
Conor.


--maladpWpE2+wJpPh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkShnwAKCRB4tDGHoIJi
0sTgAPwICMKtZQim3Vt/IyQaj7mA09XXCNeqaMmOhqqrqRhmcAD+JuScaCRXPxMN
fi/Dv2IKekKAVwvT3aEZbt7ZJnLMjg4=
=znv+
-----END PGP SIGNATURE-----

--maladpWpE2+wJpPh--

