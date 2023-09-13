Return-Path: <bpf+bounces-9939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5816F79EE31
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 18:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820DB1C20FED
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B781F953;
	Wed, 13 Sep 2023 16:23:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E378F6E;
	Wed, 13 Sep 2023 16:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E09C433CA;
	Wed, 13 Sep 2023 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694622234;
	bh=8VoScEvUyoiDW9AdnpzrCROK3tKKfb5CZhsEihgoG3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7s1IOoxxPdu4onAmi4d9534YJpOJUqFgHZrygzVHfp7xJuM6OEw+NEPML68xaiAF
	 Pjcfnj8Cy4TI2y6H1NBr1OVzxGLk7rQ4yiTf5xtYPH059dhRCOZ46cqr+Vvt6/f1GR
	 D2OxnXn6/tUKYeBLTYTfGbZl18skl2vnJSbxivGkeGLA93tg3dKfVqrJ2kYBr6CAyI
	 qWcSV0vV+tMQrqZl+fZpUIL44/nH5sYPA6x/QrS4X/0+VoWiPG8IJ3e/dIBZ8caTBK
	 qntSNTgoj5Uf8yIyv8dnfhsZf5v8IGEDkal8YE7Lu7N4y1iN4b/CAx0YH4uivRKphw
	 1Awad78OmONew==
Date: Wed, 13 Sep 2023 17:23:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 4/6] riscv, bpf: Add necessary Zbb instructions
Message-ID: <20230913-granny-heat-35d70b49ac85@spud>
References: <20230913153413.1446068-1-pulehui@huaweicloud.com>
 <20230913153413.1446068-5-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gdnSM3Xp1zOMi15X"
Content-Disposition: inline
In-Reply-To: <20230913153413.1446068-5-pulehui@huaweicloud.com>


--gdnSM3Xp1zOMi15X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 11:34:11PM +0800, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>=20
> Add necessary Zbb instructions introduced by [0] to reduce code size and
> improve performance of RV64 JIT. At the same time, a helper is added to
> check whether the CPU supports Zbb instructions.
>=20
> [0] https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitma=
nip-1.0.0-38-g865e7a7.pdf
>=20
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 8e0ef4d08..7ee59d1f6 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>  	return IS_ENABLED(CONFIG_RISCV_ISA_C);
>  }
> =20
> +static inline bool rvzbb_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB);
> +}

I dunno much about bpf, so passing question that may be a bit obvious:
Is this meant to be a test as to whether the kernel binary is built with
support for the extension, or whether the underlying platform is capable
of executing zbb instructions.

Sorry if that would be obvious to a bpf aficionado, context I have here
is the later user and the above rvc_enabled() test, which functions
differently to Zbb and so doesn't really help me.

Thanks,
Conor.

> +
>  enum {
>  	RV_REG_ZERO =3D	0,	/* The constant value 0 */
>  	RV_REG_RA =3D	1,	/* Return address */
> @@ -727,6 +732,27 @@ static inline u16 rvc_swsp(u32 imm8, u8 rs2)
>  	return rv_css_insn(0x6, imm, rs2, 0x2);
>  }
> =20
> +/* RVZBB instrutions. */
> +static inline u32 rvzbb_sextb(u8 rd, u8 rs1)
> +{
> +       return rv_i_insn(0x604, rs1, 1, rd, 0x13);
> +}
> +
> +static inline u32 rvzbb_sexth(u8 rd, u8 rs1)
> +{
> +       return rv_i_insn(0x605, rs1, 1, rd, 0x13);
> +}
> +
> +static inline u32 rvzbb_zexth(u8 rd, u8 rs)
> +{
> +       return rv_i_insn(0x80, rs, 4, rd, __riscv_xlen =3D=3D 64 ? 0x3b :=
 0x33);
> +}
> +
> +static inline u32 rvzbb_rev8(u8 rd, u8 rs)
> +{
> +       return rv_i_insn(__riscv_xlen =3D=3D 64 ? 0x6b8 : 0x698, rs, 5, r=
d, 0x13);
> +}
> +
>  /*
>   * RV64-only instructions.
>   *
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--gdnSM3Xp1zOMi15X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQHiFAAKCRB4tDGHoIJi
0rE3AQDJSqVf5PFuL9NuR1rG1fneRG6aQgIytEsKp73KeKKgKQEA1wYuSNQw6iEB
xZzZo8l2LAK8kyranGvVj6Wc1QSFyQI=
=zvto
-----END PGP SIGNATURE-----

--gdnSM3Xp1zOMi15X--

