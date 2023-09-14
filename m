Return-Path: <bpf+bounces-10018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAFA7A04C6
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E722820A9
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B2A1F5E6;
	Thu, 14 Sep 2023 13:02:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2881241E0;
	Thu, 14 Sep 2023 13:02:28 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC951FD0;
	Thu, 14 Sep 2023 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694696548; x=1726232548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FKfzwEgabNmnr7ctogDVTVjqR+tQlE/LAJw2UQIySqk=;
  b=hrWnDQYtILFTTUD0q/BB8TJ7+Q70gXbGNOJEd8woYYvNkk5IHy06M9Us
   tWZXMA8Am4b7kuY8ERaweJqccxPTgaKXSiJ/xwyDMYGo/cxwWQD9sJ01e
   IlXqXwNaIyCQh+Zg4sEw4dv3DURVsQ2jZd2FW9JdHXBuGU8Pi06fb/Dcc
   HLFAkb4oBwWh8e4YoBPV9jjrrdRJolp4sXy02JLC9OXdQehsHqp753IUm
   KjnTg7f2INSPRSAyGFh//UD6/12P6Y5iR/mCMUVe0iR5lpwdkziyHR1U3
   03fqyTuvw9hlSsaVhRt37fQBqgj7WL0Gqbm3qPziy60Vw77AXaxF+Q9J1
   Q==;
X-CSE-ConnectionGUID: AFW5LNIURoy9wLgAfO/wEA==
X-CSE-MsgGUID: MPvWWLIsRTuZD0YJFcDjng==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="asc'?scan'208";a="235193637"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 06:02:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 14 Sep 2023 06:02:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 14 Sep 2023 06:02:20 -0700
Date: Thu, 14 Sep 2023 14:02:04 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, Pu
 Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 4/6] riscv, bpf: Add necessary Zbb instructions
Message-ID: <20230914-ought-hypnotize-64cee0e27ed2@wendy>
References: <20230913153413.1446068-1-pulehui@huaweicloud.com>
 <20230913153413.1446068-5-pulehui@huaweicloud.com>
 <20230913-granny-heat-35d70b49ac85@spud>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UdjAGp0Chm4M5aeN"
Content-Disposition: inline
In-Reply-To: <20230913-granny-heat-35d70b49ac85@spud>

--UdjAGp0Chm4M5aeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 05:23:48PM +0100, Conor Dooley wrote:
> On Wed, Sep 13, 2023 at 11:34:11PM +0800, Pu Lehui wrote:
> > From: Pu Lehui <pulehui@huawei.com>
> >=20
> > Add necessary Zbb instructions introduced by [0] to reduce code size and
> > improve performance of RV64 JIT. At the same time, a helper is added to
> > check whether the CPU supports Zbb instructions.
> >=20
> > [0] https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bit=
manip-1.0.0-38-g865e7a7.pdf
> >=20
> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
> > ---
> >  arch/riscv/net/bpf_jit.h | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> > index 8e0ef4d08..7ee59d1f6 100644
> > --- a/arch/riscv/net/bpf_jit.h
> > +++ b/arch/riscv/net/bpf_jit.h
> > @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
> >  	return IS_ENABLED(CONFIG_RISCV_ISA_C);
> >  }
> > =20
> > +static inline bool rvzbb_enabled(void)
> > +{
> > +	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB);
> > +}
>=20
> I dunno much about bpf, so passing question that may be a bit obvious:
> Is this meant to be a test as to whether the kernel binary is built with
> support for the extension, or whether the underlying platform is capable
> of executing zbb instructions.
>=20
> Sorry if that would be obvious to a bpf aficionado, context I have here
> is the later user and the above rvc_enabled() test, which functions
> differently to Zbb and so doesn't really help me.

FTR, I got an off-list reply about this & it is meant to be a check as
to whether the underlying platform supports the extension. The current
test here is insufficient for that.

Thanks,
Conor.

--UdjAGp0Chm4M5aeN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQMETAAKCRB4tDGHoIJi
0r2GAP9G/Tqz8CZj+46l3JPNeu10+ifMteg0qvwIC0WpXczpbAEAoZJnprYePgJx
FLwHEzyRTZklaezLKQvJLVjjuM4DjQ8=
=qF/h
-----END PGP SIGNATURE-----

--UdjAGp0Chm4M5aeN--

