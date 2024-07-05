Return-Path: <bpf+bounces-33952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C6A928908
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 14:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49D41F23DAB
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D1C14AD17;
	Fri,  5 Jul 2024 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3ATi96g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27014A611;
	Fri,  5 Jul 2024 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183919; cv=none; b=YzkAc0aIhMyDpBa/09TTEAoH0GiHJDvGKicYV5Pn+BcQ70t2Ufy+m5gQ0ofQXW3rB65ZBg5YT0X3jvIhagjEAZBLAltTBAFWwOCIFROTnJTj03iaI2IIJaKv+ZFCYKvgGw9hiwmK1fGPv5fD9DRni/Fff7Gsp9rdOeEi75KrEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183919; c=relaxed/simple;
	bh=tywzzqXTM3ofbyDOTsWWX9rMUuX3wToN0cFy8fdbH60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B/bHrlJsPrcSkfFBErtUlgf/CN9pVEtxhDD/yWhgo4CIneIt7I6Aryr8pkZL1PlJW4BFyqXoBnDdwj4yHmS2UNvxP4P9qP527XTiX8Ry5RJvFySkbGVWZuU+57PXkByPvfVBLg+9i/XBhFgyq55hd5dQ9lCGmt+0omcNIhpyvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3ATi96g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11586C116B1;
	Fri,  5 Jul 2024 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720183918;
	bh=tywzzqXTM3ofbyDOTsWWX9rMUuX3wToN0cFy8fdbH60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h3ATi96gOBVDY6kMulp4OPha8kVtaO5PM+6r5TZxGUbqOXe26N+iTsPMbzE5qaadQ
	 tgTZsEISXFMJAQTHU4xlt/GbioctJO/9NdSona+2l9JHI+FExr3Z5iU2jFiAajHMFN
	 c7VnK9BOEJF1EURYMDHlXwzVXUwcMWjvZKP1sSeIYcx5b9Kf+BMff8EuLhMSR9ouls
	 k+nDYrqnWhUAszMoluFX8zeN1fZYzbRuweutlXsyhaIOJTZ7EnXF8plC0llRMC4Lcc
	 zMvFOazdQRZmbvOK+M7VUeolBym43fSFwQyNO78udbnBhWrq522Q55CVaaM3Jy3aca
	 fxWd8Gs3cxicQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v6 1/3] riscv, bpf: Add 12-argument support for
 RV64 bpf trampoline
In-Reply-To: <20240702121944.1091530-2-pulehui@huaweicloud.com>
References: <20240702121944.1091530-1-pulehui@huaweicloud.com>
 <20240702121944.1091530-2-pulehui@huaweicloud.com>
Date: Fri, 05 Jul 2024 12:51:36 +0000
Message-ID: <mb61p7ce0roh3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> This patch adds 12 function arguments support for riscv64 bpf
> trampoline. The current bpf trampoline supports <=3D sizeof(u64) bytes
> scalar arguments [0] and <=3D 16 bytes struct arguments [1]. Therefore, we
> focus on the situation where scalars are at most XLEN bits and
> aggregates whose total size does not exceed 2=C3=97XLEN bits in the riscv
> calling convention [2].
>
> Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184=
 [0]
> Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769=
 [1]
> Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/downl=
oad/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [=
2]
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 66 +++++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 19 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 351e1484205e..685c7389ae7e 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -15,6 +15,7 @@
>  #include <asm/percpu.h>
>  #include "bpf_jit.h"
>=20=20
> +#define RV_MAX_REG_ARGS 8
>  #define RV_FENTRY_NINSNS 2
>  /* imm that allows emit_imm to emit max count insns */
>  #define RV_MAX_COUNT_IMM 0x7FFF7FF7FF7FF7FF
> @@ -692,26 +693,45 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke=
_type poke_type,
>  	return ret;
>  }
>=20=20
> -static void store_args(int nregs, int args_off, struct rv_jit_context *c=
tx)
> +static void store_args(int nr_arg_slots, int args_off, struct rv_jit_con=
text *ctx)
>  {
>  	int i;
>=20=20
> -	for (i =3D 0; i < nregs; i++) {
> -		emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
> +	for (i =3D 0; i < nr_arg_slots; i++) {
> +		if (i < RV_MAX_REG_ARGS) {
> +			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
> +		} else {
> +			/* skip slots for T0 and FP of traced function */
> +			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
> +			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
> +		}
>  		args_off -=3D 8;
>  	}
>  }
>=20=20
> -static void restore_args(int nregs, int args_off, struct rv_jit_context =
*ctx)
> +static void restore_args(int nr_reg_args, int args_off, struct rv_jit_co=
ntext *ctx)
>  {
>  	int i;
>=20=20
> -	for (i =3D 0; i < nregs; i++) {
> +	for (i =3D 0; i < nr_reg_args; i++) {
>  		emit_ld(RV_REG_A0 + i, -args_off, RV_REG_FP, ctx);
>  		args_off -=3D 8;
>  	}
>  }
>=20=20
> +static void restore_stack_args(int nr_stack_args, int args_off, int stk_=
arg_off,
> +			       struct rv_jit_context *ctx)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < nr_stack_args; i++) {
> +		emit_ld(RV_REG_T1, -(args_off - RV_MAX_REG_ARGS * 8), RV_REG_FP, ctx);
> +		emit_sd(RV_REG_FP, -stk_arg_off, RV_REG_T1, ctx);
> +		args_off -=3D 8;
> +		stk_arg_off -=3D 8;
> +	}
> +}
> +
>  static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int r=
etval_off,
>  			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
>  {
> @@ -784,8 +804,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
>  {
>  	int i, ret, offset;
>  	int *branches_off =3D NULL;
> -	int stack_size =3D 0, nregs =3D m->nr_args;
> -	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
> +	int stack_size =3D 0, nr_arg_slots =3D 0;
> +	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, stk=
_arg_off;
>  	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
>  	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
> @@ -831,20 +851,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im,
>  	 * FP - sreg_off    [ callee saved reg	]
>  	 *
>  	 *		    [ pads              ] pads for 16 bytes alignment
> +	 *
> +	 *		    [ stack_argN        ]
> +	 *		    [ ...               ]
> +	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
>  	 */
>=20=20
>  	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
>  		return -ENOTSUPP;
>=20=20
> -	/* extra regiters for struct arguments */
> -	for (i =3D 0; i < m->nr_args; i++)
> -		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> -			nregs +=3D round_up(m->arg_size[i], 8) / 8 - 1;
> -
> -	/* 8 arguments passed by registers */
> -	if (nregs > 8)
> +	if (m->nr_args > MAX_BPF_FUNC_ARGS)
>  		return -ENOTSUPP;
>=20=20
> +	for (i =3D 0; i < m->nr_args; i++)
> +		nr_arg_slots +=3D round_up(m->arg_size[i], 8) / 8;
> +
>  	/* room of trampoline frame to store return address and frame pointer */
>  	stack_size +=3D 16;
>=20=20
> @@ -854,7 +875,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
>  		retval_off =3D stack_size;
>  	}
>=20=20
> -	stack_size +=3D nregs * 8;
> +	stack_size +=3D nr_arg_slots * 8;
>  	args_off =3D stack_size;
>=20=20
>  	stack_size +=3D 8;
> @@ -871,8 +892,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_=
tramp_image *im,
>  	stack_size +=3D 8;
>  	sreg_off =3D stack_size;
>=20=20
> +	if (nr_arg_slots - RV_MAX_REG_ARGS > 0)
> +		stack_size +=3D (nr_arg_slots - RV_MAX_REG_ARGS) * 8;

Hi Pu,
Although this is merged now, while working on this for arm64 I realised
that the above doesn't check for BPF_TRAMP_F_CALL_ORIG and can waste
some stack space, we should change this to:

if ((flags & BPF_TRAMP_F_CALL_ORIG) && (nr_arg_slots - RV_MAX_REG_ARGS > 0))
        stack_size +=3D (nr_arg_slots - RV_MAX_REG_ARGS) * 8;

It will save some stack space when BPF_TRAMP_F_CALL_ORIG is not set?

I can send a patch if you think this is worth fixing.


Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZofsWRQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nVLvAP90WXi/Yhb+D7G+xMI9Ul4lb/QgzP3o
mpZFUc3OSw0C9gEA3Pfz/ubFrgU0VX9pgWGQp7va5fPrrL0zh795YgseaQI=
=wqzf
-----END PGP SIGNATURE-----
--=-=-=--

