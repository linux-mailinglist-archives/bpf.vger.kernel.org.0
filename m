Return-Path: <bpf+bounces-66476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2EFB34FA1
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 01:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7547B0567
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 23:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADF19B5A7;
	Mon, 25 Aug 2025 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1+pHNfI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD581393DE4
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 23:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756163741; cv=none; b=rdki/zUmDck6wcBw2HlwlJ8VnTONjlBz19M39RlwPKWO2SgukDkiJ1ii24+erQ69AB8BuSQAhuCigvAm8Vr+bRkR6m14M9fi3mEVutZQUg+mONZZfd99mGYrIucCtBN5R4blPW9tUTZVYo+dFPiQ1hseZR29JwoZpJaRb8SN7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756163741; c=relaxed/simple;
	bh=BGoMyO0pScTG35vKJcKwZHwvywZGHrHzHV14mrWfj2E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=miJpa1ZFUzI9NPaUTWwIgUOZPfwibuAD+I/nggVSMmzaN7DWDo7EsRHThtYBeyIl/KgD4ZR5DbttMCkiNYbrxEowbX8W5VrCrp62L78tgabitH/7p6XubhBc+QhaVg/agHyblOJUEau7ioZ6pXhy2aA5nkro+XJaBv33Xr8mDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1+pHNfI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2461864f7f8so40394035ad.2
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 16:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756163738; x=1756768538; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKuwmiFF7vE60kB7/fAZEas4TruP7lTCAlAJC6Q+e+0=;
        b=S1+pHNfIloxXFl8MJk5fs8L29VGkF7ksWsZ2jrvELey5SuM8uxYjhoL4CIkEZ1CHtF
         odkkJQ695/cNa0DtdQJs7KR6JVz1ELXjhbZ9z3jLdGbEP9050R3yL04ALD2Lfp7B39tJ
         +g1wr5FqLxUayOJSlHhKmltPqSdzzhqYVcY5e7E7mVIr7FjAfisHivCpGVFs+WAG7MVH
         L1leHdy6QgmngFdVXdaDRdJcE8j/1D+FLII8cYBEOxntSJkg4ZO6XcogFDyak7Es4UDm
         +RZVq3bkJjVhxLe3gWZXSWqd7niOiE3vKJ3YREw8T47LEo3o0Z5ZEBWF5kKsAzh4x+LJ
         CSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756163738; x=1756768538;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKuwmiFF7vE60kB7/fAZEas4TruP7lTCAlAJC6Q+e+0=;
        b=gqzsb+a7+5Pxx2xrEEHkPk7jjlPeYu8zRaYdnFhmLBK6itgnmF6MbpbnUDqFMfUH9W
         RDq0UL12UVeGYjc6h3GPWoj07XE4Kd8x3wqimxXsO6dm6xf43Y4OKXL6KUfv35iKSQoL
         +k21s23aHo7g5seuTaz5pq5WBIZkhKbPl+bBRQ59Quo+oRhVHepjn1w/kdqHoZPprsFm
         1S1sjD4bM3sS6gxFUVzApSWnVbpAHpE00lnw3EbBtFGlUeP8/wZgEl4JIRMOOTXQqk8d
         wiy91Ko7x4XwsrCwf/prl04svIpodTrDvJAAeZNwBGVnEzweQg7DHkwOSvh6wJhzrS22
         pRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgC9P8+68OCAv/vD0P/79axddyAow50UgHh27rlWI6SIoTGh2KOvEXndFfrXFRWaxW3vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJkvIBHXXmiRnA8S6l43LM9GIqG2329g8uEXFOV+bMWZ4IbOg
	5Ov7egLiqic4nB3Baor280QQNpjRq2lrtetW9he3hdhROJ+DF0Z1Igq2
X-Gm-Gg: ASbGncvKmLlMumGKw0oNVnBAp6mAigj3iKIUROs5KstCLFg13f8vAeu7Gby41VObF94
	jg/zwS7IICNs7gzH6SvESxwTtVS9I37eN4bokkhl/FtjhBWi+pF/6QoznUDs+zPzQTTd8ltasLh
	Yf55lI4CX+jBjSTBKA2BBGhujyKRus7hrzrRMkR3hi+jn8X970crjKeEpDIm4DIu2CdXbEnphkE
	kGVkzk33+NQbnK5xr4bT8dyhzdvv7ABd2pA5un6DMl9WHABWBnKc1dYxpCpDGL3Peik/Nenl92d
	bNg7eigBFHtbO8jPjuqh0hQtTjmGDkhhRorDezTJQNraKli2Fw4jVX1VHoIQ9YhY+i9ekFTl9vb
	iRMHaHt2GGZPVYxmbuOH8Hjwdsh/c0MQkmsNjd3Q=
X-Google-Smtp-Source: AGHT+IFgFRkE12eS+QX9mHNQNcv24cRM0E6fdm/Fa17vSRqRCfc15Qej04PSP89juqjZYZ2qBNIc8A==
X-Received: by 2002:a17:903:41cc:b0:246:b351:36a3 with SMTP id d9443c01a7336-246b3513841mr74472595ad.48.1756163737772;
        Mon, 25 Aug 2025 16:15:37 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::947? ([2620:10d:c090:600::1:299c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889f11esm78702145ad.150.2025.08.25.16.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 16:15:37 -0700 (PDT)
Message-ID: <506e9593cf15c388ddfd4feaf89053c1e469b078.camel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 08/11] bpf, x86: add support for indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 25 Aug 2025 16:15:35 -0700
In-Reply-To: <20250816180631.952085-9-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
	 <20250816180631.952085-9-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:

> Add support for a new instruction
>
>     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0[, imm=3Dfd(M)]
                                                ^^^^^^^^^^^^^
					Do we really need to support this now?

[...]

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 4bfb4faab4d7..f419a89b0147 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -671,9 +671,11 @@ static void __emit_indirect_jump(u8 **pprog, int reg=
, bool ereg)
>  	*pprog =3D prog;
>  }
> =20
> -static void emit_indirect_jump(u8 **pprog, int reg, bool ereg, u8 *ip)
> +static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)

Nit: maybe make this change a part of the previous patch?

>  {
>  	u8 *prog =3D *pprog;
> +	int reg =3D reg2hex[bpf_reg];
> +	bool ereg =3D is_ereg(bpf_reg);
> =20
>  	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
>  		OPTIMIZER_HIDE_VAR(reg);

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index aca43c284203..6e68e0082c81 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -77,7 +77,15 @@ struct bpf_reg_state {
>  			 * the map_uid is non-zero for registers
>  			 * pointing to inner maps.
>  			 */
> -			u32 map_uid;
> +			union {
> +				u32 map_uid;
> +
> +				/* Used to track boundaries of a PTR_TO_INSN */
> +				struct {
> +					u32 min_index;
> +					u32 max_index;

Could you please elaborate why these fields are necessary?
It appears that .var_off/.{s,u}{32_,}{min,max}_value fields can be
used to track current index bounds (min/max fields for bounds,
.var_off field to check 8-byte alignment).

> +				};
> +			};
>  		};
> =20
>  		/* for PTR_TO_BTF_ID */
> @@ -542,6 +550,11 @@ struct bpf_insn_aux_data {
>  		struct {
>  			u32 map_index;		/* index into used_maps[] */
>  			u32 map_off;		/* offset from value base address */
> +
> +			struct jt {		/* jump table for gotox instruction */
                               ^^
		  should this be anonymous or have a `bpf_` prefix?

> +				u32 *off;
> +				int off_cnt;
> +			} jt;
>  		};
>  		struct {
>  			enum bpf_reg_type reg_type;	/* type of pseudo_btf_id */

[...]

> diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> index 0c8dac62f457..d077a5aa2c7c 100644
> --- a/kernel/bpf/bpf_insn_array.c
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> =20
>  #include <linux/bpf.h>
> -#include <linux/sort.h>
> =20
>  #define MAX_INSN_ARRAY_ENTRIES 256
> =20
> @@ -173,6 +172,20 @@ static u64 insn_array_mem_usage(const struct bpf_map=
 *map)
>  	return insn_array_alloc_size(map->max_entries) + extra_size;
>  }
> =20
> +static int insn_array_map_direct_value_addr(const struct bpf_map *map, u=
64 *imm, u32 off)
> +{
> +	struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> +
> +	if ((off % sizeof(long)) !=3D 0 ||
> +	    (off / sizeof(long)) >=3D map->max_entries)
> +		return -EINVAL;
> +
> +	/* from BPF's point of view, this map is a jump table */
> +	*imm =3D (unsigned long)insn_array->ips + off / sizeof(long);
> +
> +	return 0;
> +}
> +

This function is called during main verification pass by
verifier.c:check_mem_access() -> verifier.c:bpf_map_direct_read().
However, insn_array->ips is filled by bpf_jit_comp.c:do_jit()
bpf_insn_array.c:bpf_prog_update_insn_ptr(), which is called *after*
main verification pass. Do I miss something, or this can't work?

>  BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
> =20
>  const struct bpf_map_ops insn_array_map_ops =3D {

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 863b7114866b..c2cfa55913f8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -6072,6 +6084,14 @@ static int check_map_kptr_access(struct bpf_verifi=
er_env *env, u32 regno,
>  	return 0;
>  }
> =20
> +static u32 map_mem_size(const struct bpf_map *map)

Nit: It is a bit non-obvious why this function returns the size of a
     single value for all map types except insn array. Maybe add a
     comment here, something like:

       Return the size of the memory region accessible from a pointer
       to map value. For INSN_ARRAY maps whole bpf_insn_array->ips
       array is accessible.

> +{
> +	if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY)
> +		return map->max_entries * sizeof(long);
  		       			  ^^^^^^^^^^^^
		Nit: sizeof_field(struct bpf_insn_array, ips) ?
> +
> +	return map->value_size;
> +}
> +
>  /* check read/write into a map element with possible variable offset */
>  static int check_map_access(struct bpf_verifier_env *env, u32 regno,
>  			    int off, int size, bool zero_size_allowed,

[...]

> @@ -7820,6 +7849,13 @@ static int check_load_mem(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>  				       allow_trust_mismatch);
>  	err =3D err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
> =20
> +	if (map_ptr_copy) {
> +		regs[insn->dst_reg].type =3D PTR_TO_INSN;
> +		regs[insn->dst_reg].map_ptr =3D map_ptr_copy;
> +		regs[insn->dst_reg].min_index =3D regs[insn->src_reg].min_index;
> +		regs[insn->dst_reg].max_index =3D regs[insn->src_reg].max_index;
> +	}
> +

I think this should be handled inside check_mem_access(), see case for
reg->type =3D=3D PTR_TO_MAP_VALUE.

>  	return err;
>  }
> =20

[...]

> @@ -14554,6 +14592,36 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
> =20
>  	switch (opcode) {
>  	case BPF_ADD:
> +		if (ptr_to_insn_array) {
> +			u32 min_index =3D dst_reg->min_index;
> +			u32 max_index =3D dst_reg->max_index;
> +
> +			if ((umin_val + ptr_reg->off) > (u64) U32_MAX * sizeof(long)) {
> +				verbose(env, "umin_value %llu + offset %u is too big to convert to i=
ndex\n",
> +					     umin_val, ptr_reg->off);
> +				return -EACCES;
> +			}
> +			if ((umax_val + ptr_reg->off) > (u64) U32_MAX * sizeof(long)) {
> +				verbose(env, "umax_value %llu + offset %u is too big to convert to i=
ndex\n",
> +					     umax_val, ptr_reg->off);
> +				return -EACCES;
> +			}
> +
> +			min_index +=3D (umin_val + ptr_reg->off) / sizeof(long);
> +			max_index +=3D (umax_val + ptr_reg->off) / sizeof(long);
> +
> +			if (min_index >=3D ptr_reg->map_ptr->max_entries) {
> +				verbose(env, "min_index %u points to outside of map\n", min_index);
> +				return -EACCES;
> +			}
> +			if (max_index >=3D ptr_reg->map_ptr->max_entries) {
> +				verbose(env, "max_index %u points to outside of map\n", max_index);
> +				return -EACCES;
> +			}
> +
> +			dst_reg->min_index =3D min_index;
> +			dst_reg->max_index =3D max_index;
> +		}

I think this and the following hunk would disappear if {min,max}_index
are replaced by regular offset tracking mechanics.

>  		/* We can take a fixed offset as long as it doesn't overflow
>  		 * the s32 'off' field
>  		 */
> @@ -14598,6 +14666,11 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>  		}
>  		break;
>  	case BPF_SUB:
> +		if (ptr_to_insn_array) {
> +			verbose(env, "Operation %s on ptr to instruction set map is prohibite=
d\n",
> +				bpf_alu_string[opcode >> 4]);
> +			return -EACCES;
> +		}
>  		if (dst_reg =3D=3D off_reg) {
>  			/* scalar -=3D pointer.  Creates an unknown scalar */
>  			verbose(env, "R%d tried to subtract pointer from scalar\n",
> @@ -16943,7 +17016,8 @@ static int check_ld_imm(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>  		}
>  		dst_reg->type =3D PTR_TO_MAP_VALUE;
>  		dst_reg->off =3D aux->map_off;
> -		WARN_ON_ONCE(map->max_entries !=3D 1);
> +		WARN_ON_ONCE(map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY &&
> +			     map->max_entries !=3D 1);

Q: when is this necessary?

>  		/* We want reg->id to be same (0) as map_value is not distinct */
>  	} else if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
>  		   insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX) {
> @@ -17696,6 +17770,246 @@ static int mark_fastcall_patterns(struct bpf_ve=
rifier_env *env)
>  	return 0;
>  }
> =20
> +#define SET_HIGH(STATE, LAST)	STATE =3D (STATE & 0xffffU) | ((LAST) << 1=
6)
> +#define GET_HIGH(STATE)		((u16)((STATE) >> 16))
> +
> +static int push_goto_x_edge(int t, struct bpf_verifier_env *env, struct =
jt *jt)

I think check_cfg() can be refactored to use insn_successors().
In such a case it won't be necessary to special case gotox processing
(appart from insn_aux->jt allocation).

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
> +
> +		break;
> +	}
> +
> +	if (prev =3D=3D jt->off_cnt)
> +		return DONE_EXPLORING;
> +
> +	mark_prune_point(env, t);
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
> +
> +static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 =
*off)
> +{
> +	struct bpf_insn_array_value *value;
> +	u32 i;
> +
> +	for (i =3D start; i <=3D end; i++) {
> +		value =3D map->ops->map_lookup_elem(map, &i);
> +		if (!value)
> +			return -EINVAL;
> +		off[i - start] =3D value->xlated_off;
> +	}
> +	return 0;
> +}
> +
> +static int cmp_ptr_to_u32(const void *a, const void *b)
> +{
> +	return *(u32 *)a - *(u32 *)b;
> +}

This will overflow for e.g. `0 - 8`.

> +
> +static int sort_insn_array_uniq(u32 *off, int off_cnt)
> +{
> +	int unique =3D 1;
> +	int i;
> +
> +	sort(off, off_cnt, sizeof(off[0]), cmp_ptr_to_u32, NULL);
> +
> +	for (i =3D 1; i < off_cnt; i++)
> +		if (off[i] !=3D off[unique - 1])
> +			off[unique++] =3D off[i];
> +
> +	return unique;
> +}
> +
> +/*
> + * sort_unique({map[start], ..., map[end]}) into off
> + */
> +static int copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end,=
 u32 *off)
> +{
> +	u32 n =3D end - start + 1;
> +	int err;
> +
> +	err =3D copy_insn_array(map, start, end, off);
> +	if (err)
> +		return err;
> +
> +	return sort_insn_array_uniq(off, n);
> +}
> +
> +/*
> + * Copy all unique offsets from the map
> + */
> +static int jt_from_map(struct bpf_map *map, struct jt *jt)
> +{
> +	u32 *off;
> +	int n;
> +
> +	off =3D kvcalloc(map->max_entries, sizeof(u32), GFP_KERNEL_ACCOUNT);
> +	if (!off)
> +		return -ENOMEM;
> +
> +	n =3D copy_insn_array_uniq(map, 0, map->max_entries - 1, off);
> +	if (n < 0) {
> +		kvfree(off);
> +		return n;
> +	}
> +
> +	jt->off =3D off;
> +	jt->off_cnt =3D n;
> +	return 0;
> +}
> +
> +/*
> + * Find and collect all maps which fit in the subprog. Return the result=
 as one
> + * combined jump table in jt->off (allocated with kvcalloc
> + */
> +static int jt_from_subprog(struct bpf_verifier_env *env,
> +			   int subprog_start,
> +			   int subprog_end,
> +			   struct jt *jt)
> +{
> +	struct bpf_map *map;
> +	struct jt jt_cur;
> +	u32 *off;
> +	int err;
> +	int i;
> +
> +	jt->off =3D NULL;
> +	jt->off_cnt =3D 0;
> +
> +	for (i =3D 0; i < env->insn_array_map_cnt; i++) {
> +		/*
> +		 * TODO (when needed): collect only jump tables, not static keys
> +		 * or maps for indirect calls
> +		 */
> +		map =3D env->insn_array_maps[i];
> +
> +		err =3D jt_from_map(map, &jt_cur);
> +		if (err) {
> +			kvfree(jt->off);
> +			return err;
> +		}
> +
> +		/*
> +		 * This is enough to check one element. The full table is
> +		 * checked to fit inside the subprog later in create_jt()
> +		 */
> +		if (jt_cur.off[0] >=3D subprog_start && jt_cur.off[0] < subprog_end) {

This won't always catch cases when insn array references offsets from
several subprograms. Also is one subprogram limitation really necessary?

> +			off =3D kvrealloc(jt->off, (jt->off_cnt + jt_cur.off_cnt) << 2, GFP_K=
ERNEL_ACCOUNT);
> +			if (!off) {
> +				kvfree(jt_cur.off);
> +				kvfree(jt->off);
> +				return -ENOMEM;
> +			}
> +			memcpy(off + jt->off_cnt, jt_cur.off, jt_cur.off_cnt << 2);
> +			jt->off =3D off;
> +			jt->off_cnt +=3D jt_cur.off_cnt;
> +		}
> +
> +		kvfree(jt_cur.off);
> +	}
> +
> +	if (jt->off =3D=3D NULL) {
> +		verbose(env, "no jump tables found for subprog starting at %u\n", subp=
rog_start);
> +		return -EINVAL;
> +	}
> +
> +	jt->off_cnt =3D sort_insn_array_uniq(jt->off, jt->off_cnt);
> +	return 0;
> +}
> +
> +static int create_jt(int t, struct bpf_verifier_env *env, int fd, struct=
 jt *jt)
> +{
> +	static struct bpf_subprog_info *subprog;
> +	int subprog_idx, subprog_start, subprog_end;
> +	struct bpf_map *map;
> +	int map_idx;
> +	int ret;
> +	int i;
> +
> +	if (env->subprog_cnt =3D=3D 0)
> +		return -EFAULT;
> +
> +	subprog_idx =3D find_containing_subprog_idx(env, t);
> +	if (subprog_idx < 0) {
> +		verbose(env, "can't find subprog containing instruction %d\n", t);
> +		return -EFAULT;
> +	}
> +	subprog =3D &env->subprog_info[subprog_idx];
> +	subprog_start =3D subprog->start;
> +	subprog_end =3D (subprog + 1)->start;
> +
> +	map_idx =3D add_used_map(env, fd);

Will this spam the log with bogus
"fd %d is not pointing to valid bpf_map\n" messages if gotox does not
specify fd?

> +	if (map_idx >=3D 0) {
> +		map =3D env->used_maps[map_idx];
> +		if (map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY) {
> +			verbose(env, "map type %d in the gotox insn %d is incorrect\n",
> +				     map->map_type, t);
> +			return -EINVAL;
> +		}
> +
> +		env->insn_aux_data[t].map_index =3D map_idx;
> +
> +		ret =3D jt_from_map(map, jt);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D jt_from_subprog(env, subprog_start, subprog_end, jt);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Check that the every element of the jump table fits within the given=
 subprogram */
> +	for (i =3D 0; i < jt->off_cnt; i++) {
> +		if (jt->off[i] < subprog_start || jt->off[i] >=3D subprog_end) {
> +			verbose(env, "jump table for insn %d points outside of the subprog [%=
u,%u]",
> +					t, subprog_start, subprog_end);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* "conditional jump with N edges" */
> +static int visit_goto_x_insn(int t, struct bpf_verifier_env *env, int fd=
)
> +{
> +	struct jt *jt =3D &env->insn_aux_data[t].jt;
> +	int ret;
> +
> +	if (jt->off =3D=3D NULL) {
> +		ret =3D create_jt(t, env, fd, jt);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Mark jt as allocated. Otherwise, this is not possible to check if it
> +	 * was allocated or not in the code which frees memory (jt is a part of
> +	 * union)
> +	 */
> +	env->insn_aux_data[t].jt_allocated =3D true;
> +
> +	return push_goto_x_edge(t, env, jt);
> +}
> +
>  /* Visits the instruction at index t and returns one of the following:
>   *  < 0 - an error occurred
>   *  DONE_EXPLORING - the instruction was fully explored
> @@ -17786,8 +18100,8 @@ static int visit_insn(int t, struct bpf_verifier_=
env *env)
>  		return visit_func_call_insn(t, insns, env, insn->src_reg =3D=3D BPF_PS=
EUDO_CALL);
> =20
>  	case BPF_JA:
> -		if (BPF_SRC(insn->code) !=3D BPF_K)
> -			return -EINVAL;
> +		if (BPF_SRC(insn->code) =3D=3D BPF_X)
> +			return visit_goto_x_insn(t, env, insn->imm);
> =20
>  		if (BPF_CLASS(insn->code) =3D=3D BPF_JMP)
>  			off =3D insn->off;

[...]

> @@ -18679,6 +19000,10 @@ static bool regsafe(struct bpf_verifier_env *env=
, struct bpf_reg_state *rold,
>  		return regs_exact(rold, rcur, idmap) && rold->frameno =3D=3D rcur->fra=
meno;
>  	case PTR_TO_ARENA:
>  		return true;
> +	case PTR_TO_INSN:
> +		/* cur =E2=8A=86 old */

Out of curiosity: are unicode symbols allowed in kernel source code?

> +		return (rcur->min_index >=3D rold->min_index &&
> +			rcur->max_index <=3D rold->max_index);
>  	default:
>  		return regs_exact(rold, rcur, idmap);
>  	}
> @@ -19825,6 +20150,67 @@ static int process_bpf_exit_full(struct bpf_veri=
fier_env *env,
>  	return PROCESS_BPF_EXIT;
>  }
> =20
> +/* gotox *dst_reg */
> +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_=
insn *insn)
> +{
> +	struct bpf_verifier_state *other_branch;
> +	struct bpf_reg_state *dst_reg;
> +	struct bpf_map *map;
> +	int err =3D 0;
> +	u32 *xoff;
> +	int n;
> +	int i;
> +
> +	dst_reg =3D reg_state(env, insn->dst_reg);
> +	if (dst_reg->type !=3D PTR_TO_INSN) {
> +		verbose(env, "BPF_JA|BPF_X R%d has type %d, expected PTR_TO_INSN\n",
> +				insn->dst_reg, dst_reg->type);
> +		return -EINVAL;
> +	}
> +
> +	map =3D dst_reg->map_ptr;
> +	if (!map)
> +		return -EINVAL;

Is this a verifier bug or legit situation?
If it is a bug, maybe add a verifier_bug() here and return -EFAULT?

> +
> +	if (map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY)
> +		return -EINVAL;

Same question here, ->type is already `PTR_TO_INSN`.

> +
> +	if (dst_reg->max_index >=3D map->max_entries) {
> +		verbose(env, "BPF_JA|BPF_X R%d is out of map boundaries: index=3D%u, m=
ax_index=3D%u\n",
> +				insn->dst_reg, dst_reg->max_index, map->max_entries-1);
> +		return -EINVAL;
> +	}
> +
> +	xoff =3D kvcalloc(dst_reg->max_index - dst_reg->min_index + 1, sizeof(u=
32), GFP_KERNEL_ACCOUNT);
> +	if (!xoff)
> +		return -ENOMEM;
> +
> +	n =3D copy_insn_array_uniq(map, dst_reg->min_index, dst_reg->max_index,=
 xoff);

Nit: I'd avoid this allocation and do a loop for(i =3D min_index; i <=3D ma=
x_index; i++),
     with map->ops->map_lookup_elem(map, &i) (or a wrapper) inside it.

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

[...]

> @@ -20981,6 +21371,23 @@ static int bpf_adj_linfo_after_remove(struct bpf=
_verifier_env *env, u32 off,
>  	return 0;
>  }
> =20
> +/*
> + * Clean up dynamically allocated fields of aux data for instructions [s=
tart, ..., end]
> + */
> +static void clear_insn_aux_data(struct bpf_insn_aux_data *aux_data, int =
start, int end)

Nit: switching this to (..., int start, int len) would simplify arithmetic =
at call sites.

> +{
> +	int i;
> +
> +	for (i =3D start; i <=3D end; i++) {
> +		if (aux_data[i].jt_allocated) {
> +			kvfree(aux_data[i].jt.off);
> +			aux_data[i].jt.off =3D NULL;
> +			aux_data[i].jt.off_cnt =3D 0;
> +			aux_data[i].jt_allocated =3D false;
> +		}
> +	}
> +}
> +
>  static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, =
u32 cnt)
>  {
>  	struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;

[...]

> @@ -24175,18 +24586,18 @@ static bool can_jump(struct bpf_insn *insn)
>  	return false;
>  }
> =20
> -static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
> +static int insn_successors_regular(struct bpf_prog *prog, u32 insn_idx, =
u32 *succ)
>  {
> -	struct bpf_insn *insn =3D &prog->insnsi[idx];
> +	struct bpf_insn *insn =3D &prog->insnsi[insn_idx];
>  	int i =3D 0, insn_sz;
>  	u32 dst;
> =20
>  	insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
> -	if (can_fallthrough(insn) && idx + 1 < prog->len)
> -		succ[i++] =3D idx + insn_sz;
> +	if (can_fallthrough(insn) && insn_idx + 1 < prog->len)
> +		succ[i++] =3D insn_idx + insn_sz;
> =20
>  	if (can_jump(insn)) {
> -		dst =3D idx + jmp_offset(insn) + 1;
> +		dst =3D insn_idx + jmp_offset(insn) + 1;
>  		if (i =3D=3D 0 || succ[0] !=3D dst)
>  			succ[i++] =3D dst;
>  	}
> @@ -24194,6 +24605,36 @@ static int insn_successors(struct bpf_prog *prog=
, u32 idx, u32 succ[2])
>  	return i;
>  }
> =20
> +static int insn_successors_gotox(struct bpf_verifier_env *env,
> +				 struct bpf_prog *prog,
> +				 u32 insn_idx, u32 **succ)
> +{
> +	struct jt *jt =3D &env->insn_aux_data[insn_idx].jt;
> +
> +	if (WARN_ON_ONCE(!jt->off || !jt->off_cnt))
> +		return -EFAULT;
> +
> +	*succ =3D jt->off;
> +	return jt->off_cnt;
> +}
> +
> +/*
> + * Fill in *succ[0],...,*succ[n-1] with successors. The default *succ
> + * pointer (of size 2) may be replaced with a custom one if more
> + * elements are required (i.e., an indirect jump).
> + */
> +static int insn_successors(struct bpf_verifier_env *env,
> +			   struct bpf_prog *prog,
> +			   u32 insn_idx, u32 **succ)
> +{
> +	struct bpf_insn *insn =3D &prog->insnsi[insn_idx];
> +
> +	if (unlikely(insn_is_gotox(insn)))
> +		return insn_successors_gotox(env, prog, insn_idx, succ);
> +
> +	return insn_successors_regular(prog, insn_idx, *succ);
> +}
> +

The `prog` parameter can be dropped, as it is accessible from `env`.
I don't like the `u32 **succ` part of this interface.
What about one of the following alternatives:

- u32 *insn_successors(struct bpf_verifier_env *env, u32 insn_idx)
  and `u32 succ_buf[2]` added to bpf_verifier_env?

- int insn_successor(struct bpf_verifier_env *env, u32 insn_idx, u32 succ_n=
um):
	bool fallthrough =3D can_fallthrough(insn);
	bool jump =3D can_jump(insn);
	if (succ_num =3D=3D 0) {
		if (fallthrough)
			return <next insn>
		if (jump)
			return <jump tgt>
	} else if (succ_num =3D=3D 1) {
		if (fallthrough && jump)
			return <jmp tgt>
	} else if (is_gotox) {
		return <lookup>
	}
	return -1;
 =20
?

>  /* Each field is a register bitmask */
>  struct insn_live_regs {
>  	u16 use;	/* registers read by instruction */
> @@ -24387,11 +24828,17 @@ static int compute_live_registers(struct bpf_ve=
rifier_env *env)

Could you please extend `tools/testing/selftests/bpf/progs/compute_live_reg=
isters.c`
with test cases for gotox?

>  			int insn_idx =3D env->cfg.insn_postorder[i];
>  			struct insn_live_regs *live =3D &state[insn_idx];
>  			int succ_num;
> -			u32 succ[2];
> +			u32 _succ[2];
> +			u32 *succ =3D &_succ[0];
>  			u16 new_out =3D 0;
>  			u16 new_in =3D 0;
> =20
> -			succ_num =3D insn_successors(env->prog, insn_idx, succ);
> +			succ_num =3D insn_successors(env, env->prog, insn_idx, &succ);
> +			if (succ_num < 0) {
> +				err =3D succ_num;
> +				goto out;
> +
> +			}
>  			for (int s =3D 0; s < succ_num; ++s)
>  				new_out |=3D state[succ[s]].in;
>  			new_in =3D (new_out & ~live->def) | live->use;

[...]

