Return-Path: <bpf+bounces-11032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13657B18AD
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 12:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 97D132822BB
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A14F3589B;
	Thu, 28 Sep 2023 10:55:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E417E2E656;
	Thu, 28 Sep 2023 10:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E99C433C7;
	Thu, 28 Sep 2023 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695898556;
	bh=uF8k+xv/J7MQvU+3y3VuDDEpWfL25l0yWZxOxN+yBMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PwKmrtS+RNkpL/btIngYXZtvsPYyF8HxJNu/OKq3SWXSVGgbQE/CYQTqNzlf7u/Vj
	 860MkYo7ecMK7nGr/lIQKGKpNHYNmqPRHzKTHoDnvqlGDxhazpUdq3M2wj5pHtD+um
	 Pa7GpWMPs98PsJt2ezlyuxFZpjBXRbPwIVq7ukDObKPwOtUirEODI67c+wyfNhMYtz
	 FsRjHd0FP3x79Ln43pj+3V3/NWCEzmC9rwCErZJGkd7FIGFaI5gEGZxuU/zV8H0f35
	 JFx1xDX0W1EfRMo7kcvHpCUqHjQrHohweznGM/NfH1hQlBpVnNca9rR3JNSxac13FA
	 Ng3jIO3xxu5KQ==
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
Subject: Re: [PATCH bpf-next v2 3/6] riscv, bpf: Simplify sext and zext
 logics in branch instructions
In-Reply-To: <20230919035839.3297328-4-pulehui@huaweicloud.com>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
 <20230919035839.3297328-4-pulehui@huaweicloud.com>
Date: Thu, 28 Sep 2023 12:55:53 +0200
Message-ID: <874jjeo9c6.fsf@all.your.base.are.belong.to.us>
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
> There are many extension helpers in the current branch instructions, and
> the implementation is a bit complicated. We simplify this logic through
> two simple extension helpers with alternate register.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 82 +++++++++++++--------------------
>  1 file changed, 31 insertions(+), 51 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 4a649e195..0c6ffe11a 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -141,6 +141,19 @@ static bool in_auipc_jalr_range(s64 val)
>  		val < ((1L << 31) - (1L << 11));
>  }
>=20=20
> +/* Modify rd pointer to alternate reg to avoid corrupting original reg */
> +static void emit_sextw_alt(u8 *rd, u8 ra, struct rv_jit_context *ctx)
> +{
> +	emit_sextw(ra, *rd, ctx);
> +	*rd =3D ra;
> +}
> +
> +static void emit_zextw_alt(u8 *rd, u8 ra, struct rv_jit_context *ctx)
> +{
> +	emit_zextw(ra, *rd, ctx);
> +	*rd =3D ra;
> +}
> +
>  /* Emit fixed-length instructions for address */
>  static int emit_addr(u8 rd, u64 addr, bool extra_pass, struct rv_jit_con=
text *ctx)
>  {
> @@ -395,38 +408,6 @@ static void init_regs(u8 *rd, u8 *rs, const struct b=
pf_insn *insn,
>  		*rs =3D bpf_to_rv_reg(insn->src_reg, ctx);
>  }
>=20=20
> -static void emit_zext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ct=
x)
> -{
> -	emit_mv(RV_REG_T2, *rd, ctx);
> -	emit_zextw(RV_REG_T2, RV_REG_T2, ctx);
> -	emit_mv(RV_REG_T1, *rs, ctx);
> -	emit_zextw(RV_REG_T1, RV_REG_T1, ctx);
> -	*rd =3D RV_REG_T2;
> -	*rs =3D RV_REG_T1;
> -}
> -
> -static void emit_sext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ct=
x)
> -{
> -	emit_sextw(RV_REG_T2, *rd, ctx);
> -	emit_sextw(RV_REG_T1, *rs, ctx);
> -	*rd =3D RV_REG_T2;
> -	*rs =3D RV_REG_T1;
> -}
> -
> -static void emit_zext_32_rd_t1(u8 *rd, struct rv_jit_context *ctx)
> -{
> -	emit_mv(RV_REG_T2, *rd, ctx);
> -	emit_zextw(RV_REG_T2, RV_REG_T2, ctx);
> -	emit_zextw(RV_REG_T1, RV_REG_T2, ctx);
> -	*rd =3D RV_REG_T2;
> -}
> -
> -static void emit_sext_32_rd(u8 *rd, struct rv_jit_context *ctx)
> -{
> -	emit_sextw(RV_REG_T2, *rd, ctx);
> -	*rd =3D RV_REG_T2;
> -}
> -
>  static int emit_jump_and_link(u8 rd, s64 rvoff, bool fixed_addr,
>  			      struct rv_jit_context *ctx)
>  {
> @@ -1372,22 +1353,22 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>  		rvoff =3D rv_offset(i, off, ctx);
>  		if (!is64) {
>  			s =3D ctx->ninsns;
> -			if (is_signed_bpf_cond(BPF_OP(code)))
> -				emit_sext_32_rd_rs(&rd, &rs, ctx);
> -			else
> -				emit_zext_32_rd_rs(&rd, &rs, ctx);
> +			if (is_signed_bpf_cond(BPF_OP(code))) {
> +				emit_sextw_alt(&rs, RV_REG_T1, ctx);
> +				emit_sextw_alt(&rd, RV_REG_T2, ctx);
> +			} else {
> +				emit_zextw_alt(&rs, RV_REG_T1, ctx);
> +				emit_zextw_alt(&rd, RV_REG_T2, ctx);
> +			}
>  			e =3D ctx->ninsns;
> -

Please avoid changes like this.


>  			/* Adjust for extra insns */
>  			rvoff -=3D ninsns_rvoff(e - s);
>  		}
> -

Dito.

>  		if (BPF_OP(code) =3D=3D BPF_JSET) {
>  			/* Adjust for and */
>  			rvoff -=3D 4;
>  			emit_and(RV_REG_T1, rd, rs, ctx);
> -			emit_branch(BPF_JNE, RV_REG_T1, RV_REG_ZERO, rvoff,
> -				    ctx);
> +			emit_branch(BPF_JNE, RV_REG_T1, RV_REG_ZERO, rvoff, ctx);
>  		} else {
>  			emit_branch(BPF_OP(code), rd, rs, rvoff, ctx);
>  		}
> @@ -1416,21 +1397,20 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>  	case BPF_JMP32 | BPF_JSLE | BPF_K:
>  		rvoff =3D rv_offset(i, off, ctx);
>  		s =3D ctx->ninsns;
> -		if (imm) {
> +		if (imm)
>  			emit_imm(RV_REG_T1, imm, ctx);
> -			rs =3D RV_REG_T1;
> -		} else {
> -			/* If imm is 0, simply use zero register. */
> -			rs =3D RV_REG_ZERO;
> -		}
> +		rs =3D imm ? RV_REG_T1 : RV_REG_ZERO;
>  		if (!is64) {
> -			if (is_signed_bpf_cond(BPF_OP(code)))
> -				emit_sext_32_rd(&rd, ctx);
> -			else
> -				emit_zext_32_rd_t1(&rd, ctx);
> +			if (is_signed_bpf_cond(BPF_OP(code))) {
> +				emit_sextw_alt(&rd, RV_REG_T2, ctx);
> +				/* rs has been sign extended */
> +			} else {
> +				emit_zextw_alt(&rd, RV_REG_T2, ctx);
> +				if (imm)
> +					emit_zextw(rs, rs, ctx);
> +			}
>  		}
>  		e =3D ctx->ninsns;
> -

Dito.

Other than the formatting changes, it looks good!


Bj=C3=B6rn

