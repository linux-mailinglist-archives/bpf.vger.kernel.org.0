Return-Path: <bpf+bounces-69028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3114B8BB10
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCE47B8907
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94841E5B71;
	Sat, 20 Sep 2025 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwPDZsfT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479D81E9B35
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758328131; cv=none; b=ZUlgBUKfGDllLyi3CKBs7kzdg0PT1hL169zfR555uUZxR1LivB/D8YbKMzOkNU/xWo+HsMkDf2i+WIuvJoYBhVxd5NvlE+/j6iNK5vzWgdfWJ+mtKuIdBGPnUrze28tHBNwAHz17FXB8XL4HXMahqmazUPybHYqWbWhwQJMRDYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758328131; c=relaxed/simple;
	bh=P6OWmsWG/LCNVaFJuJGlOJ2T7MhK1XrjgDP3+a4+k9U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CDHQu8DKjykaq2rC1MBmrPZfmccMb2bjAh22+0d6xIPwiRTRi8uAeRcgPaBKQsUfrbVULqz7las5yKiuwmZhY4UHCJc5nt2XC5k2t7RWEwfE1JRCeML3/Il28gFzzJCFFlNg4DzJWmzpLx26dIZC7sGdi1rdgYbjuwYcHZpK4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwPDZsfT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-268107d8662so25797965ad.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 17:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758328127; x=1758932927; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEBOxejIHDJYurYcaw4pnM+U0TMT5zd0xf4tf6jGGsI=;
        b=EwPDZsfT6HkaIklYiXzg9kmv9zFdV9UwP//gNqflWgIt2V9ZSskhwpFpcfF9J50EKp
         EfmDVr2TXxvPca96az9sC1h8poCvPcrM0g9kdBncRabzxqXH83+UprUwy/v7roARsQB3
         QpVNud8KHCTAprT8kJng9KQ25I5wU2Em1ueWhC+/BdbGyepqEckQ62Vii2H1kMmxExEW
         O9oAs4g1yd3Ff4BhEHA9F0ZSVCDHFCYFqsNBriFU+di17VMOWwnlQAVBCwNww4t02vEF
         1ZUp7eS6c6Mqgxex1zO4uvL6jTAGcDwet/HkIMt2aHi0sDQa7C+h/92JFZcye1tZngTD
         e7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758328127; x=1758932927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aEBOxejIHDJYurYcaw4pnM+U0TMT5zd0xf4tf6jGGsI=;
        b=b5p4ag0KTcwGjSO6UrtTY0mE4bbt4xEm5Dslmf++m8DA0xUCI9K/sEZBNGu0WsMAW3
         /GfeTslol0uL/vMdwvy515KV/ZsgOPUK+ZORA3QTH2OKTkncU14V4pkZJCJB6j0+pWLa
         0aShc+Qz5MEkrBSUr3dYodUlmkH/Ks4X6kgjvpfkUFltW+9zhHukj4ZPuE7Q9OXl0Stv
         7Iw7VnGj5SBL5YYLaILkBbSv0hEPNDDe+wqxGGnLTTakBSr1Nh7PuwWh5AGI9NhX4Uxe
         Bq5vF3BbTL/qrhDXHfVotPuQB4gCxyM9jySc3O8e2V782PXMXfyyc5345dsWjHY/nXJI
         spwg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8AwuxFG1Q5azQjDIFDX1sGbc7Hjt4g0+FhEMed3JWAnkvN0WJyTLEY3W1HqlihFEIPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrykX2zdw5RrZOqK8Q2RstOaucHaA9Jtz9t1GlZm6tQRsPYO7R
	T0XvbmBhR9b4mI6obBaXpEmobUw7HHSxNuN2jv+CM/HUtSZxq24wA5sTxdtthg==
X-Gm-Gg: ASbGncs6g9STAviKPW4jSpjxBo2cn70mrNAUyKbkUnFhhLyb9NI6jq0SkMhxROw2+p7
	eHNGcFpuZtue728JzNx0tq7kobBgqiwOBKIsZDziUC20HsBiu48jUUr4lB8TKqesw5ZtNuGGTLz
	lFov4GBjVEDLGNNLoMGpXNKBTstnQIGLETy7bZ6rOp+KVEWrtt2Hrz3DdjmkN+6Ri9pydcaZTB+
	9cJdS2//WcswmhF5AhAMbtqvA6Jg7Ri/w2ip/1LMZccsOVtxzNNucjmtDN71Lw/Sp/UkO75vMAO
	qtJ6PXtwyjfYP5Wdvl1kbcvOPKKJW95Yx1u/oiWiUMKdY3OziNrUPPcoV86iqI5DO3DRT8w93LC
	iAjBsIolRK5hXVjlwOFOzltakDkG1gQ==
X-Google-Smtp-Source: AGHT+IEmoCyS7HVavEzbWNXeJ9sL5X5V6KJLxKH1gsr5Vl+evGRYqpTvO+4l1qtVmeHtuiiy69CWuw==
X-Received: by 2002:a17:903:24e:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-269ba46450cmr81079205ad.18.1758328127158;
        Fri, 19 Sep 2025 17:28:47 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698018d0fasm67057295ad.60.2025.09.19.17.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 17:28:46 -0700 (PDT)
Message-ID: <61861bfd86d150b86c674ef7bea2b23e3482e1f2.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/13] bpf, x86: add support for indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Fri, 19 Sep 2025 17:28:43 -0700
In-Reply-To: <20250918093850.455051-9-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
	 <20250918093850.455051-9-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> Add support for a new instruction
>=20
>     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0, imm=3D0
>=20
> which does an indirect jump to a location stored in Rx.  The register
> Rx should have type PTR_TO_INSN. This new type assures that the Rx
> register contains a value (or a range of values) loaded from a
> correct jump table =E2=80=93 map of type instruction array.
>=20
> For example, for a C switch LLVM will generate the following code:
>=20
>     0:   r3 =3D r1                    # "switch (r3)"
>     1:   if r3 > 0x13 goto +0x666   # check r3 boundaries
>     2:   r3 <<=3D 0x3                 # adjust to an index in array of ad=
dresses
>     3:   r1 =3D 0xbeef ll             # r1 is PTR_TO_MAP_VALUE, r1->map_p=
tr=3DM
>     5:   r1 +=3D r3                   # r1 inherits boundaries from r3
>     6:   r1 =3D *(u64 *)(r1 + 0x0)    # r1 now has type INSN_TO_PTR
>     7:   gotox r1[,imm=3Dfd(M)]       # jit will generate proper code
                   ^^^^^^^^^^^^
	      Nit: this part is not needed atm.
>=20
> Here the gotox instruction corresponds to one particular map. This is
> possible however to have a gotox instruction which can be loaded from
> different maps, e.g.

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index aca43c284203..607a684642e5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[...]

> @@ -586,6 +597,9 @@ struct bpf_insn_aux_data {
>  	u8 fastcall_spills_num:3;
>  	u8 arg_prog:4;
> =20
> +	/* true if jt->off was allocated */
> +	bool jt_allocated;
> +

Nit: in clear_insn_aux_data() maybe just check if instruction is a gotox?

>  	/* below fields are initialized once */
>  	unsigned int orig_idx; /* original instruction index */
>  	bool jmp_point;

[...]

>  static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_=
env *env, int subprog)
> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index 0c8dac62f457..4b945b7e31b8 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> =20
>  #include <linux/bpf.h>
> -#include <linux/sort.h>

Nit: remove this include from patch #3?

> =20
>  #define MAX_INSN_ARRAY_ENTRIES 256
> =20

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5c1e4e37d1f8..839260e62fa9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -7620,6 +7644,19 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
> =20
>  				regs[value_regno].type =3D SCALAR_VALUE;
>  				__mark_reg_known(&regs[value_regno], val);
> +			} else if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY) {
> +				regs[value_regno].type =3D PTR_TO_INSN;
> +				regs[value_regno].map_ptr =3D map;
> +				regs[value_regno].off =3D reg->off;
> +				regs[value_regno].umin_value =3D reg->umin_value;
> +				regs[value_regno].umax_value =3D reg->umax_value;
> +				regs[value_regno].smin_value =3D reg->smin_value;
> +				regs[value_regno].smax_value =3D reg->smax_value;
> +				regs[value_regno].s32_min_value =3D reg->s32_min_value;
> +				regs[value_regno].s32_max_value =3D reg->s32_max_value;
> +				regs[value_regno].u32_min_value =3D reg->u32_min_value;
> +				regs[value_regno].u32_max_value =3D reg->u32_max_value;
> +				regs[value_regno].var_off =3D reg->var_off;

This can be shortened to:

  copy_register_state(regs + value_regno, reg);
  regs[value_regno].type =3D PTR_TO_INSN;

I think that a check that read is u64 wide is necessary here.
Otherwise e.g. for u8 load you'd need to truncate the bounds set above.
This is also necessary for alignment check at the beginning of this
function (check_ptr_alignment() call).

>  			} else {
>  				mark_reg_unknown(env, regs, value_regno);
>  			}

[...]

> @@ -14628,6 +14672,11 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>  		}
>  		break;
>  	case BPF_SUB:
> +		if (ptr_to_insn_array) {
> +			verbose(env, "Operation %s on ptr to instruction set map is prohibite=
d\n",
> +				bpf_alu_string[opcode >> 4]);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
               Nit: Just "subtraction", no need for lookup?
                    Also, maybe put this near the same check for PTR_TO_STA=
CK?

> +			return -EACCES;
> +		}
>  		if (dst_reg =3D=3D off_reg) {
>  			/* scalar -=3D pointer.  Creates an unknown scalar */
>  			verbose(env, "R%d tried to subtract pointer from scalar\n",

[...]

> @@ -17733,6 +17783,234 @@ static int mark_fastcall_patterns(struct bpf_ve=
rifier_env *env)
>  	return 0;
>  }
> =20
> +#define SET_HIGH(STATE, LAST)	STATE =3D (STATE & 0xffffU) | ((LAST) << 1=
6)
> +#define GET_HIGH(STATE)		((u16)((STATE) >> 16))
> +
> +static int push_gotox_edge(int t, struct bpf_verifier_env *env, struct b=
pf_iarray *jt)
> +{
> +	int *insn_stack =3D env->cfg.insn_stack;
> +	int *insn_state =3D env->cfg.insn_state;
> +	u16 prev;
> +	int w;
> +
> +	for (prev =3D GET_HIGH(insn_state[t]); prev < jt->off_cnt; prev++) {
> +		w =3D jt->off[prev];
> +
> +		/* EXPLORED || DISCOVERED */
> +		if (insn_state[w])
> +			continue;

Suppose there is some other way to reach `w` beside gotox.
Also suppose that `w` had been visited already.
In such case `mark_jmp_point(env, w)` might get omitted for `w`.

> +
> +		break;
> +	}
> +
> +	if (prev =3D=3D jt->off_cnt)
> +		return DONE_EXPLORING;
> +
> +	mark_prune_point(env, t);

Nit: do this from visit_gotox_insn() ?

> +
> +	if (env->cfg.cur_stack >=3D env->prog->len)
> +		return -E2BIG;
> +	insn_stack[env->cfg.cur_stack++] =3D w;
> +
> +	mark_jmp_point(env, w);
> +
> +	SET_HIGH(insn_state[t], prev + 1);
> +	return KEEP_EXPLORING;
> +}

[...]

> +/*
> + * Find and collect all maps which fit in the subprog. Return the result=
 as one
> + * combined jump table in jt->off (allocated with kvcalloc
                                                           ^^^
						   nit: missing ')'

> + */
> +static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
> +					  int subprog_start, int subprog_end)

[...]

> +static struct bpf_iarray *
> +create_jt(int t, struct bpf_verifier_env *env, int fd)
                                                  ^^^^^^
			fd is unused, same for visit_gotox_insn()

[...]

> @@ -18716,6 +19001,10 @@ static bool regsafe(struct bpf_verifier_env *env=
, struct bpf_reg_state *rold,
>  		return regs_exact(rold, rcur, idmap) && rold->frameno =3D=3D rcur->fra=
meno;
>  	case PTR_TO_ARENA:
>  		return true;
> +	case PTR_TO_INSN:
> +		/* is rcur a subset of rold? */
> +		return (rcur->umin_value >=3D rold->umin_value &&
> +			rcur->umax_value <=3D rold->umax_value);

I think this should be:

                 if (rold->off !=3D rcur->off)
                         return false;
                 return range_within(old: rold, cur: rcur) &&
                        tnum_in(a: rold->var_off, b: rcur->var_off);

>  	default:
>  		return regs_exact(rold, rcur, idmap);
>  	}
> @@ -19862,6 +20151,102 @@ static int process_bpf_exit_full(struct bpf_ver=
ifier_env *env,
>  	return PROCESS_BPF_EXIT;
>  }
> =20
> +static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
> +				       int regno,
> +				       struct bpf_map *map,
> +				       u32 *pmin_index, u32 *pmax_index)
> +{
> +	struct bpf_reg_state *reg =3D reg_state(env, regno);
> +	u64 min_index, max_index;
> +
> +	if (check_add_overflow(reg->umin_value, reg->off, &min_index) ||
> +		(min_index > (u64) U32_MAX * sizeof(long))) {
> +		verbose(env, "the sum of R%u umin_value %llu and off %u is too big\n",
> +			     regno, reg->umin_value, reg->off);
> +		return -ERANGE;
> +	}
> +	if (check_add_overflow(reg->umax_value, reg->off, &max_index) ||
> +		(max_index > (u64) U32_MAX * sizeof(long))) {
> +		verbose(env, "the sum of R%u umax_value %llu and off %u is too big\n",
> +			     regno, reg->umax_value, reg->off);
> +		return -ERANGE;
> +	}
> +
> +	min_index /=3D sizeof(long);
> +	max_index /=3D sizeof(long);

Nit: `long` is 32-bit long on x86 (w/o -64), I understand that x86 jit
would just reject gotox, but could you please use `sizeof(u64)` here?

> +
> +	if (min_index >=3D map->max_entries || max_index >=3D map->max_entries)=
 {
> +		verbose(env, "R%u points to outside of jump table: [%llu,%llu] max_ent=
ries %u\n",
> +			     regno, min_index, max_index, map->max_entries);
> +		return -EINVAL;
> +	}
> +
> +	*pmin_index =3D min_index;
> +	*pmax_index =3D max_index;
> +	return 0;
> +}
> +
> +/* gotox *dst_reg */
> +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_=
insn *insn)
> +{
> +	struct bpf_verifier_state *other_branch;
> +	struct bpf_reg_state *dst_reg;
> +	struct bpf_map *map;
> +	u32 min_index, max_index;
> +	int err =3D 0;
> +	u32 *xoff;
> +	int n;
> +	int i;
> +
> +	dst_reg =3D reg_state(env, insn->dst_reg);
> +	if (dst_reg->type !=3D PTR_TO_INSN) {
> +		verbose(env, "R%d has type %d, expected PTR_TO_INSN\n",
> +			     insn->dst_reg, dst_reg->type);
> +		return -EINVAL;
> +	}
> +
> +	map =3D dst_reg->map_ptr;
> +	if (verifier_bug_if(!map, env, "R%d has an empty map pointer", insn->ds=
t_reg))
> +		return -EFAULT;
> +
> +	if (verifier_bug_if(map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY, env,
> +			    "R%d has incorrect map type %d", insn->dst_reg, map->map_type))
> +		return -EFAULT;
> +
> +	err =3D indirect_jump_min_max_index(env, insn->dst_reg, map, &min_index=
, &max_index);
> +	if (err)
> +		return err;
> +
> +	xoff =3D kvcalloc(max_index - min_index + 1, sizeof(u32), GFP_KERNEL_AC=
COUNT);
> +	if (!xoff)
> +		return -ENOMEM;

Let's keep a buffer for this allocation in `env` and realloc it when needed=
.
Would be good to avoid allocating memory each time this gotox is visited.

> +
> +	n =3D copy_insn_array_uniq(map, min_index, max_index, xoff);
> +	if (n < 0) {
> +		err =3D n;
> +		goto free_off;
> +	}
> +	if (n =3D=3D 0) {
> +		verbose(env, "register R%d doesn't point to any offset in map id=3D%d\=
n",
> +			     insn->dst_reg, map->id);
> +		err =3D -EINVAL;
> +		goto free_off;
> +	}
> +
> +	for (i =3D 0; i < n - 1; i++) {
> +		other_branch =3D push_stack(env, xoff[i], env->insn_idx, false);
                                                                       ^^^^=
^
                         `is_speculative` has to be inherited from env->cur=
_state

> +		if (IS_ERR(other_branch)) {
> +			err =3D PTR_ERR(other_branch);
> +			goto free_off;
> +		}
> +	}
> +	env->insn_idx =3D xoff[n-1];
> +
> +free_off:
> +	kvfree(xoff);
> +	return err;
> +}
> +
>  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_st=
ate)
>  {
>  	int err;
> @@ -19964,6 +20349,9 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
> =20
>  			mark_reg_scratched(env, BPF_REG_0);
>  		} else if (opcode =3D=3D BPF_JA) {
> +			if (BPF_SRC(insn->code) =3D=3D BPF_X)
> +				return check_indirect_jump(env, insn);
> +

check_indirect_jump() does not check reserved fields (like offset or dst_re=
g).

>  			if (BPF_SRC(insn->code) !=3D BPF_K ||
>  			    insn->src_reg !=3D BPF_REG_0 ||
>  			    insn->dst_reg !=3D BPF_REG_0 ||

[...]

> @@ -24215,23 +24625,41 @@ static bool can_jump(struct bpf_insn *insn)
>  	return false;
>  }
> =20
> -static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
> +/*
> + * Returns an array of instructions succ, with succ->off[0], ...,
> + * succ->off[n-1] with successor instructions, where n=3Dsucc->off_cnt
> + */
> +static struct bpf_iarray *
> +insn_successors(struct bpf_verifier_env *env, u32 insn_idx)

Nit: maybe put insn_successors refactoring to a separate patch?

>  {
> -	struct bpf_insn *insn =3D &prog->insnsi[idx];
> -	int i =3D 0, insn_sz;
> +	struct bpf_prog *prog =3D env->prog;
> +	struct bpf_insn *insn =3D &prog->insnsi[insn_idx];
> +	struct bpf_iarray *succ;
> +	int insn_sz;
>  	u32 dst;
> =20
> -	insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
> -	if (can_fallthrough(insn) && idx + 1 < prog->len)
> -		succ[i++] =3D idx + insn_sz;
> +	if (unlikely(insn_is_gotox(insn))) {
> +		succ =3D env->insn_aux_data[insn_idx].jt;
> +		if (verifier_bug_if(!succ, env,
> +				    "aux data for insn %u doesn't contain a jump table\n",
> +				    insn_idx))
> +			return ERR_PTR(-EFAULT);

Requiring each callsite to check error code for this function is very incon=
venient.
Moreover, insn_successors() is hot in liveness.c:update_instance().
Let's just assume that NULL here cannot happen.

> +	} else {
> +		/* pre-allocated array of size up to 2; reset cnt, as it may be used a=
lready */
> +		succ =3D env->succ;
> +		succ->off_cnt =3D 0;
> =20
> -	if (can_jump(insn)) {
> -		dst =3D idx + jmp_offset(insn) + 1;
> -		if (i =3D=3D 0 || succ[0] !=3D dst)
> -			succ[i++] =3D dst;
> -	}
> +		insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
> +		if (can_fallthrough(insn) && insn_idx + 1 < prog->len)
> +			succ->off[succ->off_cnt++] =3D insn_idx + insn_sz;
> =20
> -	return i;
> +		if (can_jump(insn)) {
> +			dst =3D insn_idx + jmp_offset(insn) + 1;
> +			if (succ->off_cnt =3D=3D 0 || succ->off[0] !=3D dst)
> +				succ->off[succ->off_cnt++] =3D dst;
> +		}
> +	}
> +	return succ;
>  }
>

[...]

> @@ -24489,11 +24921,10 @@ static int compute_scc(struct bpf_verifier_env =
*env)
>  	const u32 insn_cnt =3D env->prog->len;
>  	int stack_sz, dfs_sz, err =3D 0;
>  	u32 *stack, *pre, *low, *dfs;
> -	u32 succ_cnt, i, j, t, w;
> +	u32 i, j, t, w;
>  	u32 next_preorder_num;
>  	u32 next_scc_id;
>  	bool assign_scc;
> -	u32 succ[2];
> =20
>  	next_preorder_num =3D 1;
>  	next_scc_id =3D 1;
> @@ -24592,6 +25023,8 @@ static int compute_scc(struct bpf_verifier_env *e=
nv)
>  		dfs[0] =3D i;
>  dfs_continue:
>  		while (dfs_sz) {
> +			struct bpf_iarray *succ;
> +

Nit: please move this declaration up, just to be consistent with other vari=
ables.

>  			w =3D dfs[dfs_sz - 1];
>  			if (pre[w] =3D=3D 0) {
>  				low[w] =3D next_preorder_num;
> @@ -24600,12 +25033,17 @@ static int compute_scc(struct bpf_verifier_env =
*env)
>  				stack[stack_sz++] =3D w;
>  			}
>  			/* Visit 'w' successors */
> -			succ_cnt =3D insn_successors(env->prog, w, succ);
> -			for (j =3D 0; j < succ_cnt; ++j) {
> -				if (pre[succ[j]]) {
> -					low[w] =3D min(low[w], low[succ[j]]);
> +			succ =3D insn_successors(env, w);
> +			if (IS_ERR(succ)) {
> +				err =3D PTR_ERR(succ);
> +				goto exit;
> +
> +			}
> +			for (j =3D 0; j < succ->off_cnt; ++j) {
> +				if (pre[succ->off[j]]) {
> +					low[w] =3D min(low[w], low[succ->off[j]]);
>  				} else {
> -					dfs[dfs_sz++] =3D succ[j];
> +					dfs[dfs_sz++] =3D succ->off[j];
>  					goto dfs_continue;
>  				}
>  			}

[...]

