Return-Path: <bpf+bounces-5192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E4A7588D0
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3271C20E86
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C10217AB0;
	Tue, 18 Jul 2023 23:00:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80115AC4
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 23:00:36 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A960A1
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 16:00:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso57211995e9.3
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 16:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689721233; x=1692313233;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BN1036w01ftueVv9yrC46ZpGuiZf35jmb+6n5IeH0Sg=;
        b=ZZWmW8fmXuED88mKPwZIvqbmNNnjP358QZuLWC7gbuGSQmRy1TQeUDE06UuHeHafv8
         h3YFQvfIE75qvxpjLD/s+zL08w5BzQaY6+K6++cRgwByowgCwVQ+tGKZGZL2iZlPG0M5
         KmaI83lbID6/w4j491Mx5NL0G/DDjOr+46XbC56rcwRZMepHwPGJv+wPKr+6x68Ytm7S
         SVsLSvm5AIycidEl0q9lfM9HDEgPoHvkTHHbzBOlDLfHqNylRgK5AZ08rc+ir8a4iCDo
         YKYLZn75fo7y5OcCcKFgDM+lpEtbzWRYnLVwRS2GCUOnO91RkuHdIcawrqrXKZwl5k7p
         pSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689721233; x=1692313233;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BN1036w01ftueVv9yrC46ZpGuiZf35jmb+6n5IeH0Sg=;
        b=Fi73XxiXfLk6/mQ5cBZ4oqbaJZj48gqCKTf9OBQcen61TACwViXI2jgF+0tz2jTlFD
         H93efuPTzCCXzwG/pzWHMuPo9HlZUOzcgAwcqligDXOXffuM3NtiVK2Myc3dqZA6F42G
         aEXlEMndmimdB5f5qlsdjhZgPDdei7LYtR+Z3gmZJR80yAzjrNNuccTta1R8p+jgVs2j
         wfUDOmnJ5VAFXOlsTmic5vgsXGZfRwqGgqahpKksqH5rgRqq7RSLcNkEcfYT0hTXBP4I
         MlF9lLetHNUsimWF23fo+0jhDNsM3hAIHXhtSUKFV4x7+h1icffhqdPXrshmXD5JwjoD
         QptA==
X-Gm-Message-State: ABy/qLZU6HqWN9KToFfDFc5RO0T2X0vxDnxcJ/t2nTe5nizMIAdYouZx
	0l3M8ox6+3c67pCgchR3urE=
X-Google-Smtp-Source: APBJJlGPL6Uj4wQfFgNy0xhuqJfKG97wVxili+NniOZN6IBH+XaAMec5nNzNZRN747eWeAsm+l0qRQ==
X-Received: by 2002:a7b:cb97:0:b0:3fc:443:3773 with SMTP id m23-20020a7bcb97000000b003fc04433773mr2858881wmi.30.1689721233232;
        Tue, 18 Jul 2023 16:00:33 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c00ca00b003fbb618f7adsm242449wmm.15.2023.07.18.16.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 16:00:32 -0700 (PDT)
Message-ID: <b8a16850c0482bf64f30b41c7dcb8b33ea6a6f61.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/15] bpf: Support new signed div/mod
 instructions.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song
 <maskray@google.com>, kernel-team@fb.com
Date: Wed, 19 Jul 2023 02:00:31 +0300
In-Reply-To: <20230713060744.390929-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
	 <20230713060744.390929-1-yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
> Add interpreter/jit support for new signed div/mod insns.
> The new signed div/mod instructions are encoded with
> unsigned div/mod instructions plus insn->off =3D=3D 1.
> Also add basic verifier support to ensure new insns get
> accepted.
>=20
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 27 +++++++----
>  kernel/bpf/core.c           | 96 ++++++++++++++++++++++++++++++-------
>  kernel/bpf/verifier.c       |  6 ++-
>  3 files changed, 103 insertions(+), 26 deletions(-)
>=20
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index adda5e7626b4..3176b60d25c7 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1194,15 +1194,26 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
>  				/* mov rax, dst_reg */
>  				emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
> =20
> -			/*
> -			 * xor edx, edx
> -			 * equivalent to 'xor rdx, rdx', but one byte less
> -			 */
> -			EMIT2(0x31, 0xd2);
> +			if (insn->off =3D=3D 0) {
> +				/*
> +				 * xor edx, edx
> +				 * equivalent to 'xor rdx, rdx', but one byte less
> +				 */
> +				EMIT2(0x31, 0xd2);
> =20
> -			/* div src_reg */
> -			maybe_emit_1mod(&prog, src_reg, is64);
> -			EMIT2(0xF7, add_1reg(0xF0, src_reg));
> +				/* div src_reg */
> +				maybe_emit_1mod(&prog, src_reg, is64);
> +				EMIT2(0xF7, add_1reg(0xF0, src_reg));
> +			} else {
> +				if (BPF_CLASS(insn->code) =3D=3D BPF_ALU)
> +					EMIT1(0x99); /* cltd */
> +				else
> +					EMIT2(0x48, 0x99); /* cqto */

Nitpick: I can't find names cltd/cqto in the Intel instruction manual,
         instead it uses names cdq/cqo for these instructions.
         (See Vol. 2A pages 3-315 and 3-497)

> +
> +				/* idiv src_reg */
> +				maybe_emit_1mod(&prog, src_reg, is64);
> +				EMIT2(0xF7, add_1reg(0xF8, src_reg));
> +			}
> =20
>  			if (BPF_OP(insn->code) =3D=3D BPF_MOD &&
>  			    dst_reg !=3D BPF_REG_3)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 86bb412fee39..6f7134657935 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1789,36 +1789,100 @@ static u64 ___bpf_prog_run(u64 *regs, const stru=
ct bpf_insn *insn)
>  		(*(s64 *) &DST) >>=3D IMM;
>  		CONT;
>  	ALU64_MOD_X:
> -		div64_u64_rem(DST, SRC, &AX);
> -		DST =3D AX;
> +		switch (OFF) {
> +		case 0:
> +			div64_u64_rem(DST, SRC, &AX);
> +			DST =3D AX;
> +			break;
> +		case 1:
> +			AX =3D div64_s64(DST, SRC);
> +			DST =3D DST - AX * SRC;
> +			break;
> +		}
>  		CONT;
>  	ALU_MOD_X:
> -		AX =3D (u32) DST;
> -		DST =3D do_div(AX, (u32) SRC);
> +		switch (OFF) {
> +		case 0:
> +			AX =3D (u32) DST;
> +			DST =3D do_div(AX, (u32) SRC);
> +			break;
> +		case 1:
> +			AX =3D (s32) DST;
> +			DST =3D (u32)do_div(AX, (s32) SRC);
> +			break;
> +		}
>  		CONT;
>  	ALU64_MOD_K:
> -		div64_u64_rem(DST, IMM, &AX);
> -		DST =3D AX;
> +		switch (OFF) {
> +		case 0:
> +			div64_u64_rem(DST, IMM, &AX);
> +			DST =3D AX;
> +			break;
> +		case 1:
> +			AX =3D div64_s64(DST, IMM);
> +			DST =3D DST - AX * IMM;
> +			break;
> +		}
>  		CONT;
>  	ALU_MOD_K:
> -		AX =3D (u32) DST;
> -		DST =3D do_div(AX, (u32) IMM);
> +		switch (OFF) {
> +		case 0:
> +			AX =3D (u32) DST;
> +			DST =3D do_div(AX, (u32) IMM);
> +			break;
> +		case 1:
> +			AX =3D (s32) DST;
> +			DST =3D (u32)do_div(AX, (s32) IMM);
> +			break;
> +		}
>  		CONT;
>  	ALU64_DIV_X:
> -		DST =3D div64_u64(DST, SRC);
> +		switch (OFF) {
> +		case 0:
> +			DST =3D div64_u64(DST, SRC);
> +			break;
> +		case 1:
> +			DST =3D div64_s64(DST, SRC);
> +			break;
> +		}
>  		CONT;
>  	ALU_DIV_X:
> -		AX =3D (u32) DST;
> -		do_div(AX, (u32) SRC);
> -		DST =3D (u32) AX;
> +		switch (OFF) {
> +		case 0:
> +			AX =3D (u32) DST;
> +			do_div(AX, (u32) SRC);
> +			DST =3D (u32) AX;
> +			break;
> +		case 1:
> +			AX =3D (s32) DST;
> +			do_div(AX, (s32) SRC);
> +			DST =3D (u32) AX;
> +			break;
> +		}
>  		CONT;
>  	ALU64_DIV_K:
> -		DST =3D div64_u64(DST, IMM);
> +		switch (OFF) {
> +		case 0:
> +			DST =3D div64_u64(DST, IMM);
> +			break;
> +		case 1:
> +			DST =3D div64_s64(DST, IMM);
> +			break;
> +		}
>  		CONT;
>  	ALU_DIV_K:
> -		AX =3D (u32) DST;
> -		do_div(AX, (u32) IMM);
> -		DST =3D (u32) AX;
> +		switch (OFF) {
> +		case 0:
> +			AX =3D (u32) DST;
> +			do_div(AX, (u32) IMM);
> +			DST =3D (u32) AX;
> +			break;
> +		case 1:
> +			AX =3D (s32) DST;
> +			do_div(AX, (s32) IMM);
> +			DST =3D (u32) AX;
> +			break;
> +		}
>  		CONT;
>  	ALU_END_TO_BE:
>  		switch (IMM) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 22ba0744547b..b606c8ed5470 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13192,7 +13192,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>  	} else {	/* all other ALU ops: and, sub, xor, add, ... */
> =20
>  		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> -			if (insn->imm !=3D 0 || insn->off !=3D 0) {
> +			if (insn->imm !=3D 0 || insn->off > 1 ||
> +			    (insn->off =3D=3D 1 && opcode !=3D BPF_MOD && opcode !=3D BPF_DIV=
)) {
>  				verbose(env, "BPF_ALU uses reserved fields\n");
>  				return -EINVAL;
>  			}
> @@ -13201,7 +13202,8 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>  			if (err)
>  				return err;
>  		} else {
> -			if (insn->src_reg !=3D BPF_REG_0 || insn->off !=3D 0) {
> +			if (insn->src_reg !=3D BPF_REG_0 || insn->off > 1 ||
> +			    (insn->off =3D=3D 1 && opcode !=3D BPF_MOD && opcode !=3D BPF_DIV=
)) {
>  				verbose(env, "BPF_ALU uses reserved fields\n");
>  				return -EINVAL;
>  			}


