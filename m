Return-Path: <bpf+bounces-5075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6172675591B
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 03:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18466281311
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 01:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C67111F;
	Mon, 17 Jul 2023 01:41:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D3A49
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 01:41:46 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF8F11A
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 18:41:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso39152595e9.1
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 18:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689558103; x=1692150103;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXOhkHhVsAu1Hu81yAFhtJcowv0B677iKnY2VdViOnw=;
        b=KPnR3srGeztdEmH7BH0SX+XP9ggRNEkDv/FE7tvnx00PWaelmsLHauKVYCiyPA55Oh
         3rQB+Mlxrs35Yaq3hfsmB3if6N/kLcOVWe3PIgy1IkLmMRGkKgRXxTSuFjyR7/P2eBb0
         dhhRBR6JhvsxbzMCJSp0B/VL2USvS9QsAKtAU+VDRAv1i+kumWeEu0cFNxH4M4ahVvGA
         LoxYm9Z+1Rcl4Uvli+9GiZLVy/82gp8XIL3/bPlszG2BbI9Gs6/PZXEbKSzTl03scT2F
         Wck6UAwa5+IGByhH8cEPgpTKYuAyvgex7K2qj2u+O8XDwpT7Z+OUf5boFEfisOz71E65
         V9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689558103; x=1692150103;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXOhkHhVsAu1Hu81yAFhtJcowv0B677iKnY2VdViOnw=;
        b=IvJWEuqRB7FG8d4ytrW8r1aOh7P1z2V6rPAq1s7cAeU0TqSM4OgRn1rCknGMbSBSqc
         wCpuubj3AlK3wgFLM9JkGaGaM4dkxRNuWmfiERJ4Bb+Nxy4xhbOIwASddiOVfw4ou9ul
         YVDw7VQdMUTCo/Uq3WE0UT9xCIMHGqn401m4nTlkyqhxuY1Y7zZQy8TvZ0HnCs8beeNv
         aWGy8sKMcdrINTc/kqOTIArgK53CFfbcxkK11VhpO737SBVCCDWGRd00C5zz0ukRIZob
         dKwwWy5DagQFzyEz1i83b8fRcMADkcd5WBgIAyVFdP5ZkRmdHop126orHn5lKzEdWpOU
         pj0A==
X-Gm-Message-State: ABy/qLa0H99mG/c4YQTD7ZU1OkL6P5D6y5GziPubAYbrc2ynqqMlXjhn
	2zsjkNHoKEYOb65bwwH6AWo=
X-Google-Smtp-Source: APBJJlHWciiKSBah03eSY+Zv/ikymVnh5mmXXNsPPwtAfoc0u3jAXDy5bs9YEguYv+/31oe8M2nbOQ==
X-Received: by 2002:a7b:ca4a:0:b0:3fc:1a9:7900 with SMTP id m10-20020a7bca4a000000b003fc01a97900mr10639252wml.16.1689558102694;
        Sun, 16 Jul 2023 18:41:42 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b003fa74bff02asm6773029wmj.26.2023.07.16.18.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 18:41:42 -0700 (PDT)
Message-ID: <5b1f7cd2a995882a05fcfdef78bb1390794c2603.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/15] bpf: Support new sign-extension mov
 insns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song
 <maskray@google.com>, kernel-team@fb.com
Date: Mon, 17 Jul 2023 04:41:41 +0300
In-Reply-To: <20230713060734.390551-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
	 <20230713060734.390551-1-yhs@fb.com>
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
> > Add interpreter/jit support for new sign-extension mov insns.
> > The original 'MOV' insn is extended to support signed version
> > for both ALU and ALU64 operations. For ALU mode,
> > the insn->off value of 8 or 16 indicates sign-extension
> > from 8- or 16-bit value to 32-bit value. For ALU64 mode,
> > the insn->off value of 8/16/32 indicates sign-extension
> > from 8-, 16- or 32-bit value to 64-bit value.
> >=20
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c |  43 ++++++++++-
> >  kernel/bpf/core.c           |  28 ++++++-
> >  kernel/bpf/verifier.c       | 150 +++++++++++++++++++++++++++++-------
> >  3 files changed, 190 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index addeea95f397..a740a1a6e71d 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -701,6 +701,38 @@ static void emit_mov_reg(u8 **pprog, bool is64, u3=
2 dst_reg, u32 src_reg)
> >  	*pprog =3D prog;
> >  }
> > =20
> > +static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, u32 ds=
t_reg,
> > +			   u32 src_reg)
> > +{
> > +	u8 *prog =3D *pprog;
> > +
> > +	if (is64) {
> > +		/* movs[b,w,l]q dst, src */
> > +		if (num_bits =3D=3D 8)
> > +			EMIT4(add_2mod(0x48, src_reg, dst_reg), 0x0f, 0xbe,
> > +			      add_2reg(0xC0, src_reg, dst_reg));
> > +		else if (num_bits =3D=3D 16)
> > +			EMIT4(add_2mod(0x48, src_reg, dst_reg), 0x0f, 0xbf,
> > +			      add_2reg(0xC0, src_reg, dst_reg));
> > +		else if (num_bits =3D=3D 32)
> > +			EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x63,
> > +			      add_2reg(0xC0, src_reg, dst_reg));
> > +	} else {
> > +		/* movs[b,w]l dst, src */
> > +		if (num_bits =3D=3D 8) {
> > +			EMIT4(add_2mod(0x40, src_reg, dst_reg), 0x0f, 0xbe,
> > +			      add_2reg(0xC0, src_reg, dst_reg));

Nit: As far as I understand 4-126 Vol. 2B of [1]
     the 0x40 prefix (REX prefix) is optional here
     (same as implemented below for num_bits =3D=3D 16).

[1] https://cdrdv2.intel.com/v1/dl/getContent/671200


> > +		} else if (num_bits =3D=3D 16) {
> > +			if (is_ereg(dst_reg) || is_ereg(src_reg))
> > +				EMIT1(add_2mod(0x40, src_reg, dst_reg));
> > +			EMIT3(add_2mod(0x0f, src_reg, dst_reg), 0xbf,

Nit: Basing on the same manual I don't understand why=C2=A0
     add_2mod(0x0f, src_reg, dst_reg) is used, '0xf' should suffice
     (but I tried it both ways and it works...).

> > +			      add_2reg(0xC0, src_reg, dst_reg));
> > +		}
> > +	}
> > +
> > +	*pprog =3D prog;
> > +}
> > +
> >  /* Emit the suffix (ModR/M etc) for addressing *(ptr_reg + off) and va=
l_reg */
> >  static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int=
 off)
> >  {
> > @@ -1051,9 +1083,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int=
 *addrs, u8 *image, u8 *rw_image
> > =20
> >  		case BPF_ALU64 | BPF_MOV | BPF_X:
> >  		case BPF_ALU | BPF_MOV | BPF_X:
> > -			emit_mov_reg(&prog,
> > -				     BPF_CLASS(insn->code) =3D=3D BPF_ALU64,
> > -				     dst_reg, src_reg);
> > +			if (insn->off =3D=3D 0)
> > +				emit_mov_reg(&prog,
> > +					     BPF_CLASS(insn->code) =3D=3D BPF_ALU64,
> > +					     dst_reg, src_reg);
> > +			else
> > +				emit_movsx_reg(&prog, insn->off,
> > +					       BPF_CLASS(insn->code) =3D=3D BPF_ALU64,
> > +					       dst_reg, src_reg);
> >  			break;
> > =20
> >  			/* neg dst */
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 8a1cc658789e..fe648a158c9e 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -61,6 +61,7 @@
> >  #define AX	regs[BPF_REG_AX]
> >  #define ARG1	regs[BPF_REG_ARG1]
> >  #define CTX	regs[BPF_REG_CTX]
> > +#define OFF	insn->off
> >  #define IMM	insn->imm
> > =20
> >  struct bpf_mem_alloc bpf_global_ma;
> > @@ -1736,13 +1737,36 @@ static u64 ___bpf_prog_run(u64 *regs, const str=
uct bpf_insn *insn)
> >  		DST =3D -DST;
> >  		CONT;
> >  	ALU_MOV_X:
> > -		DST =3D (u32) SRC;
> > +		switch (OFF) {
> > +		case 0:
> > +			DST =3D (u32) SRC;
> > +			break;
> > +		case 8:
> > +			DST =3D (u32)(s8) SRC;
> > +			break;
> > +		case 16:
> > +			DST =3D (u32)(s16) SRC;
> > +			break;
> > +		}
> >  		CONT;
> >  	ALU_MOV_K:
> >  		DST =3D (u32) IMM;
> >  		CONT;
> >  	ALU64_MOV_X:
> > -		DST =3D SRC;
> > +		switch (OFF) {
> > +		case 0:
> > +			DST =3D SRC;
> > +			break;
> > +		case 8:
> > +			DST =3D (s8) SRC;
> > +			break;
> > +		case 16:
> > +			DST =3D (s16) SRC;
> > +			break;
> > +		case 32:
> > +			DST =3D (s32) SRC;
> > +			break;
> > +		}
> >  		CONT;
> >  	ALU64_MOV_K:
> >  		DST =3D IMM;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fbe4ca72d4c1..5fee9f24cb5e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3421,7 +3421,7 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
> >  			return 0;
> >  		if (opcode =3D=3D BPF_MOV) {
> >  			if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> > -				/* dreg =3D sreg
> > +				/* dreg =3D sreg or dreg =3D (s8, s16, s32)sreg
> >  				 * dreg needs precision after this insn
> >  				 * sreg needs precision before this insn
> >  				 */
> > @@ -5866,6 +5866,64 @@ static void coerce_reg_to_size_sx(struct bpf_reg=
_state *reg, int size)
> >  	set_sext64_default_val(reg, size);
> >  }
> > =20
> > +static void set_sext32_default_val(struct bpf_reg_state *reg, int size=
)
> > +{
> > +	if (size =3D=3D 1) {
> > +		reg->s32_min_value =3D S8_MIN;
> > +		reg->s32_max_value =3D S8_MAX;
> > +	} else {
> > +		/* size =3D=3D 2 */
> > +		reg->s32_min_value =3D S16_MIN;
> > +		reg->s32_max_value =3D S16_MAX;
> > +	}
> > +	reg->u32_min_value =3D 0;
> > +	reg->u32_max_value =3D U32_MAX;
> > +}
> > +
> > +static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int si=
ze)
> > +{
> > +	s32 init_s32_max, init_s32_min, s32_max, s32_min;
> > +	u32 top_smax_value, top_smin_value;
> > +	u32 num_bits =3D size * 8;
> > +
> > +	top_smax_value =3D ((u32)reg->s32_max_value >> num_bits) << num_bits;
> > +	top_smin_value =3D ((u32)reg->s32_min_value >> num_bits) << num_bits;
> > +
> > +	if (top_smax_value !=3D top_smin_value)
> > +		goto out;
> > +
> > +	/* find the s32_min and s32_min after sign extension */
> > +	if (size =3D=3D 1) {
> > +		init_s32_max =3D (s8)reg->s32_max_value;
> > +		init_s32_min =3D (s8)reg->s32_min_value;
> > +	} else {
> > +		/* size =3D=3D 2 */
> > +		init_s32_max =3D (s16)reg->s32_max_value;
> > +		init_s32_min =3D (s16)reg->s32_min_value;
> > +	}
> > +	s32_max =3D max(init_s32_max, init_s32_min);
> > +	s32_min =3D min(init_s32_max, init_s32_min);
> > +
> > +	if (s32_min >=3D 0 && s32_max >=3D 0) {
> > +		reg->s32_min_value =3D s32_min;
> > +		reg->s32_max_value =3D s32_max;
> > +		reg->u32_min_value =3D 0;
> > +		reg->u32_max_value =3D U32_MAX;
> > +		return;
> > +	}
> > +
> > +	if (s32_min < 0 && s32_max < 0) {
> > +		reg->s32_min_value =3D s32_min;
> > +		reg->s32_max_value =3D s32_max;
> > +		reg->u32_min_value =3D (u32)s32_max;
> > +		reg->u32_max_value =3D (u32)s32_min;
> > +		return;
> > +	}
> > +
> > +out:
> > +	set_sext32_default_val(reg, size);
> > +}
> > +
> >  static bool bpf_map_is_rdonly(const struct bpf_map *map)
> >  {
> >  	/* A map is considered read-only if the following condition are true:
> > @@ -13003,11 +13061,23 @@ static int check_alu_op(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> >  	} else if (opcode =3D=3D BPF_MOV) {
> > =20
> >  		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> > -			if (insn->imm !=3D 0 || insn->off !=3D 0) {
> > +			if (insn->imm !=3D 0) {
> >  				verbose(env, "BPF_MOV uses reserved fields\n");
> >  				return -EINVAL;
> >  			}
> > =20
> > +			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU) {
> > +				if (insn->off !=3D 0 && insn->off !=3D 8 && insn->off !=3D 16) {
> > +					verbose(env, "BPF_MOV uses reserved fields\n");
> > +					return -EINVAL;
> > +				}
> > +			} else {
> > +				if (insn->off !=3D 0 && insn->off !=3D 8 && insn->off !=3D 16 && i=
nsn->off !=3D 32) {
> > +					verbose(env, "BPF_MOV uses reserved fields\n");
> > +					return -EINVAL;
> > +				}
> > +			}
> > +
> >  			/* check src operand */
> >  			err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
> >  			if (err)
> > @@ -13031,18 +13101,32 @@ static int check_alu_op(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> >  				       !tnum_is_const(src_reg->var_off);
> > =20
> >  			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
> > -				/* case: R1 =3D R2
> > -				 * copy register state to dest reg
> > -				 */
> > -				if (need_id)
> > -					/* Assign src and dst registers the same ID
> > -					 * that will be used by find_equal_scalars()
> > -					 * to propagate min/max range.
> > +				if (insn->off =3D=3D 0) {
> > +					/* case: R1 =3D R2
> > +					 * copy register state to dest reg
> >  					 */
> > -					src_reg->id =3D ++env->id_gen;
> > -				copy_register_state(dst_reg, src_reg);
> > -				dst_reg->live |=3D REG_LIVE_WRITTEN;
> > -				dst_reg->subreg_def =3D DEF_NOT_SUBREG;
> > +					if (need_id)
> > +						/* Assign src and dst registers the same ID
> > +						 * that will be used by find_equal_scalars()
> > +						 * to propagate min/max range.
> > +						 */
> > +						src_reg->id =3D ++env->id_gen;
> > +					copy_register_state(dst_reg, src_reg);
> > +					dst_reg->live |=3D REG_LIVE_WRITTEN;
> > +					dst_reg->subreg_def =3D DEF_NOT_SUBREG;
> > +				} else {
> > +					/* case: R1 =3D (s8, s16 s32)R2 */
> > +					bool no_sext =3D src_reg->umax_value < (1ULL << (insn->off - 1));
> > +
> > +					if (no_sext && need_id)
> > +						src_reg->id =3D ++env->id_gen;
> > +					copy_register_state(dst_reg, src_reg);
> > +					if (!no_sext)
> > +						dst_reg->id =3D 0;
> > +					coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
> > +					dst_reg->live |=3D REG_LIVE_WRITTEN;
> > +					dst_reg->subreg_def =3D DEF_NOT_SUBREG;
> > +				}
> >  			} else {
> >  				/* R1 =3D (u32) R2 */
> >  				if (is_pointer_value(env, insn->src_reg)) {
> > @@ -13051,19 +13135,33 @@ static int check_alu_op(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> >  						insn->src_reg);
> >  					return -EACCES;
> >  				} else if (src_reg->type =3D=3D SCALAR_VALUE) {
> > -					bool is_src_reg_u32 =3D src_reg->umax_value <=3D U32_MAX;
> > -
> > -					if (is_src_reg_u32 && need_id)
> > -						src_reg->id =3D ++env->id_gen;
> > -					copy_register_state(dst_reg, src_reg);
> > -					/* Make sure ID is cleared if src_reg is not in u32 range otherwi=
se
> > -					 * dst_reg min/max could be incorrectly
> > -					 * propagated into src_reg by find_equal_scalars()
> > -					 */
> > -					if (!is_src_reg_u32)
> > -						dst_reg->id =3D 0;
> > -					dst_reg->live |=3D REG_LIVE_WRITTEN;
> > -					dst_reg->subreg_def =3D env->insn_idx + 1;
> > +					if (insn->off =3D=3D 0) {
> > +						bool is_src_reg_u32 =3D src_reg->umax_value <=3D U32_MAX;
> > +
> > +						if (is_src_reg_u32 && need_id)
> > +							src_reg->id =3D ++env->id_gen;
> > +						copy_register_state(dst_reg, src_reg);
> > +						/* Make sure ID is cleared if src_reg is not in u32 range otherw=
ise
> > +						 * dst_reg min/max could be incorrectly
> > +						 * propagated into src_reg by find_equal_scalars()
> > +						 */
> > +						if (!is_src_reg_u32)
> > +							dst_reg->id =3D 0;
> > +						dst_reg->live |=3D REG_LIVE_WRITTEN;
> > +						dst_reg->subreg_def =3D env->insn_idx + 1;
> > +					} else {
> > +						/* case: W1 =3D (s8, s16)W2 */
> > +						bool no_sext =3D src_reg->umax_value < (1ULL << (insn->off - 1))=
;
> > +
> > +						if (no_sext && need_id)
> > +							src_reg->id =3D ++env->id_gen;
> > +						copy_register_state(dst_reg, src_reg);
> > +						if (!no_sext)
> > +							dst_reg->id =3D 0;
> > +						dst_reg->live |=3D REG_LIVE_WRITTEN;
> > +						dst_reg->subreg_def =3D env->insn_idx + 1;
> > +						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);

I tried the following test program:

{
 "testtesttest",
 .insns =3D {
 BPF_MOV64_IMM(BPF_REG_7, 0xffff),
 {
 .code =3D BPF_ALU | BPF_MOV | BPF_X,
 .dst_reg =3D BPF_REG_0,
 .src_reg =3D BPF_REG_7,
 .off =3D 16,
 .imm =3D 0,
 },
 BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, 1),
 BPF_EXIT_INSN(),
 },
 .result =3D ACCEPT,
 .retval =3D 0,
},

And it produces verification log as below:

 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
 0: (b7) r7 =3D 65535    ; R7_w=3DP65535
 1: (bc) w0 =3D w7       ; R0_w=3DP65535 R7_w=3DP65535
 2: (77) r0 >>=3D 1      ; R0_w=3DP32767
 3: (95) exit
 ...
 FAIL retval 2147483647 !=3D 0 (run 1/1)=20

Note that verifier considers R0 to be 0x7FFF at 3,
while actual value during execution is 0x7FFF'FFFF.

> > +					}
> >  				} else {
> >  					mark_reg_unknown(env, regs,
> >  							 insn->dst_reg);


