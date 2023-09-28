Return-Path: <bpf+bounces-11033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FB97B18D9
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 13:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5789B282563
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433F7358B4;
	Thu, 28 Sep 2023 11:02:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05334CC3;
	Thu, 28 Sep 2023 11:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2180C433C8;
	Thu, 28 Sep 2023 11:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695898947;
	bh=ja0DZ6OOOWx3SoES56Dma1x4gAPtESb30QOtChRcEZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YGywSVE8eBruJR7SW6VH+qa877kACiuvPFYhlWPsWpyEQwhOlPUZZiJP8lgcyIeKz
	 IMfffi4oRfaeDxaCVjAbFx5CbkG+dZvhELmQ2OPXal4YefMv3xn16eRub/IWVc+UHs
	 dUZk9eJ8oCJo9wopp746kPezpo42d/SkMaT0hMluDkmRsulJEJ17Z8+McrMn8QeaeO
	 Vij7yL6K3uSEz/P1D9jWmso9ohW7br2MH7Msy52Xo+pP7GyrZmHRBDLoqJGBy6KcV5
	 n4KSh/Lk+fjfcBd1+jFuyUvPgToqabjYhsiR9acFXw47J37nM+aB4PfiS+kOtndmRd
	 PdNC7FH1qY+bQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 4/6] riscv, bpf: Add necessary Zbb instructions
In-Reply-To: <20230919035839.3297328-5-pulehui@huaweicloud.com>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
 <20230919035839.3297328-5-pulehui@huaweicloud.com>
Date: Thu, 28 Sep 2023 13:02:23 +0200
Message-ID: <87y1gqmugw.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Add necessary Zbb instructions introduced by [0] to reduce code size and
> improve performance of RV64 JIT. Meanwhile, a runtime deteted helper is
> added to check whether the CPU supports Zbb instructions.
>
> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bit=
manip-1.0.0-38-g865e7a7.pdf [0]
> Suggested-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 8e0ef4d08..4e24fb2bd 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -18,6 +18,11 @@ static inline bool rvc_enabled(void)
>  	return IS_ENABLED(CONFIG_RISCV_ISA_C);
>  }
>=20=20
> +static inline bool rvzbb_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && riscv_has_extension_likely(R=
ISCV_ISA_EXT_ZBB);
> +}
> +
>  enum {
>  	RV_REG_ZERO =3D	0,	/* The constant value 0 */
>  	RV_REG_RA =3D	1,	/* Return address */
> @@ -727,6 +732,27 @@ static inline u16 rvc_swsp(u32 imm8, u8 rs2)
>  	return rv_css_insn(0x6, imm, rs2, 0x2);
>  }
>=20=20
> +/* RVZBB instrutions. */
> +static inline u32 rvzbb_sextb(u8 rd, u8 rs1)
> +{
> +	return rv_i_insn(0x604, rs1, 1, rd, 0x13);
> +}
> +
> +static inline u32 rvzbb_sexth(u8 rd, u8 rs1)
> +{
> +	return rv_i_insn(0x605, rs1, 1, rd, 0x13);
> +}
> +
> +static inline u32 rvzbb_zexth(u8 rd, u8 rs)
> +{
> +	return rv_i_insn(0x80, rs, 4, rd, __riscv_xlen =3D=3D 64 ? 0x3b : 0x33);

Encoding funcs are hard to read as it is, so let's try to be a bit more
explicit.

I would prefer a

  |        if (IS_ENABLED(CONFIG_64BIT))
  |                return 64bitvariant
  |         return 32bitvariant

version.

Or a 64-bit only variant elsewhere, since this series is only aimed for
64-bit anyway.

> +}
> +
> +static inline u32 rvzbb_rev8(u8 rd, u8 rs)
> +{
> +	return rv_i_insn(__riscv_xlen =3D=3D 64 ? 0x6b8 : 0x698, rs, 5, rd, 0x1=
3);

Dito.



Bj=C3=B6rn

