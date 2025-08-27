Return-Path: <bpf+bounces-66672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FD5B386AA
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A0D1BA1777
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CDC28488E;
	Wed, 27 Aug 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNQF8bpM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F0279915
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308510; cv=none; b=TDm7TpoDX7lRgdY3/ehoQqYO5RKV3k0MObFOLn0UGKYBk4BhYrcchwUn9fW27FkaPWEuzL4P/f4JhAw/H5fxnK0fIDRSG1UCuscVBggR0AxMQ8kZv3m/YPIludJqW9+YymopRzVerceB7SW7QtuieFWERFpdqEzgLP8GTu4Zr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308510; c=relaxed/simple;
	bh=u6MayIg2TGbxmn6x2cW9T6kPpaTHQtrIlrtNaBpfOiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPuE0NlwODsYJtbigtvSSvzg9SN/ERswzXR7TTriX6zVsXXIop0wsHonr0FPfeM7aQgx87z4bFpvUeo2vFk4hgQYg5KxEKn7HZRp66FdnTvpTdA4c97P9aleqHpMWHFX5YmKAvxp2f/ESql2rfAmj+zyDLyNQskrNB9WQJd24f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNQF8bpM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c854b644c1so2680258f8f.3
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308506; x=1756913306; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b+fh7Rn3VuBojO1w1wnlliRL//J26yEDTg5X7/M3PwU=;
        b=cNQF8bpMOwmSQpX+l6gbNZNEcDkbv8GzI0kwiF9cHLINUW+PMgzHhSeokV3avi67pW
         IGP6I7ctfxA/Oz+4WLRZP6fsKKKYqhsAQXcRZjk2iVLtG6kzfSL1MfeL9jYL9gxCDUjt
         yR5pHbtIFka14OdXmeNk+0a7QbIu3sg/gMfYjdlMI2zc4MkfWmpAYjG/GsXV34K4pETa
         iReffsLa47786tAO8WK4jdgD9BT3vDt/MEolSartyWDvKbgO8unUCWGA/y+lbIeqPJZb
         KR5f4F37yuozxVg0VcYPf8aqwalRzppTZOBgL7VGOGIstKJyn+Uf/Lnw4GLEPXQgqwUu
         JxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308506; x=1756913306;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+fh7Rn3VuBojO1w1wnlliRL//J26yEDTg5X7/M3PwU=;
        b=IeDwwXmUPmGb6x+4PESDUzWCR+QERrTF4Bcqg67IGYBVD2LbcN1s+KgJwSFOJvVKlp
         LPYoBcxiC4oBwVvd37XHpTGeUrI/DydU0y6EJSXvcON1Lo97HjtngQnRaA8zFnl7Q1Z4
         6GD3Mxa6DK9g/+VD1p32SRd9XH/C8SnkH43qDICrZ1bcG9WFZgaH5ExFKFLkAVj1xEZf
         SPQS6cLU5vvL2A8kWPCkq704WKns8gAobxVxYd447DYRgIGOeb64M25gTy7g1czN+pAS
         WofkOMlxWduds0o+Dsaxmnwrdn0eERt0ME/YjemjfV3vaz89uuSmKuFADrwcIOZynFhD
         SSIg==
X-Gm-Message-State: AOJu0Yz+5cXjJs587gTI1EoHu+Pg0Mj1KG6idbyAGfeYo+/6D/CmqqU9
	lw0E2VfJYU7etErXLDhUMkH1fSK8/SBSQIcT85PA79vNqwu4ckv28STz
X-Gm-Gg: ASbGncumV8lAxzc5KKz9EB8EgT/PE5zDk8AvGtYVjW3JouAxqWA3TXsjgYk69sJr/Wg
	kQmGzVrtMTiokb6Qc0tKQ+GtJZrzafs66JvzwJR0bFAM/ms4DUpmBJUgvn/l/UMb/pM8Zfns6x3
	yvDldXO655IQZW43phBiJUhY+LiabbIV4THgjvRzPItFtxORhEAPxVQpOYzS1DaP1CGYyUL1zIG
	0hWLzRM9ToC5qhXPra+oxuaDXjOvYyhFN+/vOQu3c5EFJg2dVOvvCNvCEa9yuP4ojI3pzIS7oLm
	uQcExz7P0sPVNUjw3hRE46Nszxs2PvXhPwqb7GYMwxyF7bVPHp7HddulAFzlNifzYgXUHXAERa7
	8Akvagl7zqOUBUKrFBEr0Gvfz67shZzXzxQ==
X-Google-Smtp-Source: AGHT+IFnKQJJQf2DcHMf2/zfeDLOoYEl3lfLqR44MAYqOrU9J0pty0XFh359NZne+LhFP+KstZr2dQ==
X-Received: by 2002:a05:6000:420d:b0:3cc:eb92:e81b with SMTP id ffacd0b85a97d-3cceb92ec6amr1662597f8f.23.1756308505417;
        Wed, 27 Aug 2025 08:28:25 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cd935931ebsm444670f8f.55.2025.08.27.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:28:24 -0700 (PDT)
Date: Wed, 27 Aug 2025 15:34:28 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 08/11] bpf, x86: add support for indirect
 jumps
Message-ID: <aK8lhDi+LybnjdfG@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-9-a.s.protopopov@gmail.com>
 <506e9593cf15c388ddfd4feaf89053c1e469b078.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <506e9593cf15c388ddfd4feaf89053c1e469b078.camel@gmail.com>

On 25/08/25 04:15PM, Eduard Zingerman wrote:
> On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:
> 
> > Add support for a new instruction
> >
> >     BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0[, imm=fd(M)]
>                                                 ^^^^^^^^^^^^^
> 					Do we really need to support this now?
> 
> [...]

Maybe not, as libbpf in any case always sets 0. I will remove it for now.

> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 4bfb4faab4d7..f419a89b0147 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -671,9 +671,11 @@ static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
> >  	*pprog = prog;
> >  }
> >  
> > -static void emit_indirect_jump(u8 **pprog, int reg, bool ereg, u8 *ip)
> > +static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
> 
> Nit: maybe make this change a part of the previous patch?

Done.

> >  {
> >  	u8 *prog = *pprog;
> > +	int reg = reg2hex[bpf_reg];
> > +	bool ereg = is_ereg(bpf_reg);
> >  
> >  	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
> >  		OPTIMIZER_HIDE_VAR(reg);
> 
> [...]
> 
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index aca43c284203..6e68e0082c81 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -77,7 +77,15 @@ struct bpf_reg_state {
> >  			 * the map_uid is non-zero for registers
> >  			 * pointing to inner maps.
> >  			 */
> > -			u32 map_uid;
> > +			union {
> > +				u32 map_uid;
> > +
> > +				/* Used to track boundaries of a PTR_TO_INSN */
> > +				struct {
> > +					u32 min_index;
> > +					u32 max_index;
> 
> Could you please elaborate why these fields are necessary?
> It appears that .var_off/.{s,u}{32_,}{min,max}_value fields can be
> used to track current index bounds (min/max fields for bounds,
> .var_off field to check 8-byte alignment).

I thought it is better readable (and not wasting memory anymore).
They clearly say "pointer X was loaded from an instruction pointer
map M and can point to any of {M[min_index], ..., M[max_index]}".
Those indexes come from off_reg, not ptr_reg. In order to use
ptr_reg->u_min/u_max instead, more checks should be added (like those
in BPF_ADD for min/max_index) to check that registers doesn't point
to outside of M->ips. I am not sure this will be easier to read.

Also, PTR_TO_INSN is created by dereferencing the address, and right
now it looks easier just to copy min/max_index. As I understand,
normally this register is set to ips[var_off] and marked as unknown,
so there will be additional code to use u_min/u_max to keep track of
boundaries.

Or do you think this is still more clear?

I will try to look into this again in the morning.

> > +				};
> > +			};
> >  		};
> >  
> >  		/* for PTR_TO_BTF_ID */
> > @@ -542,6 +550,11 @@ struct bpf_insn_aux_data {
> >  		struct {
> >  			u32 map_index;		/* index into used_maps[] */
> >  			u32 map_off;		/* offset from value base address */
> > +
> > +			struct jt {		/* jump table for gotox instruction */
>                                ^^
> 		  should this be anonymous or have a `bpf_` prefix?

I will add bpf_ prefix, it is used in a few functions as a parameter.

> 
> > +				u32 *off;
> > +				int off_cnt;
> > +			} jt;
> >  		};
> >  		struct {
> >  			enum bpf_reg_type reg_type;	/* type of pseudo_btf_id */
> 
> [...]
> 
> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > index 0c8dac62f457..d077a5aa2c7c 100644
> > --- a/kernel/bpf/bpf_insn_array.c
> > +++ b/kernel/bpf/bpf_insn_array.c
> > @@ -1,7 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  
> >  #include <linux/bpf.h>
> > -#include <linux/sort.h>
> >  
> >  #define MAX_INSN_ARRAY_ENTRIES 256
> >  
> > @@ -173,6 +172,20 @@ static u64 insn_array_mem_usage(const struct bpf_map *map)
> >  	return insn_array_alloc_size(map->max_entries) + extra_size;
> >  }
> >  
> > +static int insn_array_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
> > +{
> > +	struct bpf_insn_array *insn_array = cast_insn_array(map);
> > +
> > +	if ((off % sizeof(long)) != 0 ||
> > +	    (off / sizeof(long)) >= map->max_entries)
> > +		return -EINVAL;
> > +
> > +	/* from BPF's point of view, this map is a jump table */
> > +	*imm = (unsigned long)insn_array->ips + off / sizeof(long);
> > +
> > +	return 0;
> > +}
> > +
> 
> This function is called during main verification pass by
> verifier.c:check_mem_access() -> verifier.c:bpf_map_direct_read().
> However, insn_array->ips is filled by bpf_jit_comp.c:do_jit()
> bpf_insn_array.c:bpf_prog_update_insn_ptr(), which is called *after*
> main verification pass. Do I miss something, or this can't work?

This gets an address &ips[off], not the address of the bpf program.
Ad this moment ips[off] contains garbage. Later when
bpf_prog_update_insn_ptr() is executed, ips[off] is populated with
the real IP. The running program then reads it by dereferencing the
[correct at this time] address, i.e., *(&ips[off]).

> >  BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
> >  
> >  const struct bpf_map_ops insn_array_map_ops = {
> 
> [...]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 863b7114866b..c2cfa55913f8 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [...]
> 
> > @@ -6072,6 +6084,14 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> >  	return 0;
> >  }
> >  
> > +static u32 map_mem_size(const struct bpf_map *map)
> 
> Nit: It is a bit non-obvious why this function returns the size of a
>      single value for all map types except insn array. Maybe add a
>      comment here, something like:
> 
>        Return the size of the memory region accessible from a pointer
>        to map value. For INSN_ARRAY maps whole bpf_insn_array->ips
>        array is accessible.

Thanks, will add.

> > +{
> > +	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY)
> > +		return map->max_entries * sizeof(long);
>   		       			  ^^^^^^^^^^^^
> 		Nit: sizeof_field(struct bpf_insn_array, ips) ?

ok, ack

[No comments below, I will reply to those tomorrow.
And thanks a lot for your reviews!]

> > +
> > +	return map->value_size;
> > +}
> > +
> >  /* check read/write into a map element with possible variable offset */
> >  static int check_map_access(struct bpf_verifier_env *env, u32 regno,
> >  			    int off, int size, bool zero_size_allowed,
> 
> [...]
> 
> > @@ -7820,6 +7849,13 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  				       allow_trust_mismatch);
> >  	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
> >  
> > +	if (map_ptr_copy) {
> > +		regs[insn->dst_reg].type = PTR_TO_INSN;
> > +		regs[insn->dst_reg].map_ptr = map_ptr_copy;
> > +		regs[insn->dst_reg].min_index = regs[insn->src_reg].min_index;
> > +		regs[insn->dst_reg].max_index = regs[insn->src_reg].max_index;
> > +	}
> > +
> 
> I think this should be handled inside check_mem_access(), see case for
> reg->type == PTR_TO_MAP_VALUE.
> 
> >  	return err;
> >  }
> >  
> 
> [...]
> 
> > @@ -14554,6 +14592,36 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
> >  
> >  	switch (opcode) {
> >  	case BPF_ADD:
> > +		if (ptr_to_insn_array) {
> > +			u32 min_index = dst_reg->min_index;
> > +			u32 max_index = dst_reg->max_index;
> > +
> > +			if ((umin_val + ptr_reg->off) > (u64) U32_MAX * sizeof(long)) {
> > +				verbose(env, "umin_value %llu + offset %u is too big to convert to index\n",
> > +					     umin_val, ptr_reg->off);
> > +				return -EACCES;
> > +			}
> > +			if ((umax_val + ptr_reg->off) > (u64) U32_MAX * sizeof(long)) {
> > +				verbose(env, "umax_value %llu + offset %u is too big to convert to index\n",
> > +					     umax_val, ptr_reg->off);
> > +				return -EACCES;
> > +			}
> > +
> > +			min_index += (umin_val + ptr_reg->off) / sizeof(long);
> > +			max_index += (umax_val + ptr_reg->off) / sizeof(long);
> > +
> > +			if (min_index >= ptr_reg->map_ptr->max_entries) {
> > +				verbose(env, "min_index %u points to outside of map\n", min_index);
> > +				return -EACCES;
> > +			}
> > +			if (max_index >= ptr_reg->map_ptr->max_entries) {
> > +				verbose(env, "max_index %u points to outside of map\n", max_index);
> > +				return -EACCES;
> > +			}
> > +
> > +			dst_reg->min_index = min_index;
> > +			dst_reg->max_index = max_index;
> > +		}
> 
> I think this and the following hunk would disappear if {min,max}_index
> are replaced by regular offset tracking mechanics.
> 
> >  		/* We can take a fixed offset as long as it doesn't overflow
> >  		 * the s32 'off' field
> >  		 */
> > @@ -14598,6 +14666,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
> >  		}
> >  		break;
> >  	case BPF_SUB:
> > +		if (ptr_to_insn_array) {
> > +			verbose(env, "Operation %s on ptr to instruction set map is prohibited\n",
> > +				bpf_alu_string[opcode >> 4]);
> > +			return -EACCES;
> > +		}
> >  		if (dst_reg == off_reg) {
> >  			/* scalar -= pointer.  Creates an unknown scalar */
> >  			verbose(env, "R%d tried to subtract pointer from scalar\n",
> > @@ -16943,7 +17016,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
> >  		}
> >  		dst_reg->type = PTR_TO_MAP_VALUE;
> >  		dst_reg->off = aux->map_off;
> > -		WARN_ON_ONCE(map->max_entries != 1);
> > +		WARN_ON_ONCE(map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
> > +			     map->max_entries != 1);
> 
> Q: when is this necessary?
> 
> >  		/* We want reg->id to be same (0) as map_value is not distinct */
> >  	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
> >  		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
> > @@ -17696,6 +17770,246 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
> >  	return 0;
> >  }
> >  
> > +#define SET_HIGH(STATE, LAST)	STATE = (STATE & 0xffffU) | ((LAST) << 16)
> > +#define GET_HIGH(STATE)		((u16)((STATE) >> 16))
> > +
> > +static int push_goto_x_edge(int t, struct bpf_verifier_env *env, struct jt *jt)
> 
> I think check_cfg() can be refactored to use insn_successors().
> In such a case it won't be necessary to special case gotox processing
> (appart from insn_aux->jt allocation).
> 
> > +{
> > +	int *insn_stack = env->cfg.insn_stack;
> > +	int *insn_state = env->cfg.insn_state;
> > +	u16 prev;
> > +	int w;
> > +
> > +	for (prev = GET_HIGH(insn_state[t]); prev < jt->off_cnt; prev++) {
> > +		w = jt->off[prev];
> > +
> > +		/* EXPLORED || DISCOVERED */
> > +		if (insn_state[w])
> > +			continue;
> > +
> > +		break;
> > +	}
> > +
> > +	if (prev == jt->off_cnt)
> > +		return DONE_EXPLORING;
> > +
> > +	mark_prune_point(env, t);
> > +
> > +	if (env->cfg.cur_stack >= env->prog->len)
> > +		return -E2BIG;
> > +	insn_stack[env->cfg.cur_stack++] = w;
> > +
> > +	mark_jmp_point(env, w);
> > +
> > +	SET_HIGH(insn_state[t], prev + 1);
> > +	return KEEP_EXPLORING;
> > +}
> > +
> > +static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *off)
> > +{
> > +	struct bpf_insn_array_value *value;
> > +	u32 i;
> > +
> > +	for (i = start; i <= end; i++) {
> > +		value = map->ops->map_lookup_elem(map, &i);
> > +		if (!value)
> > +			return -EINVAL;
> > +		off[i - start] = value->xlated_off;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int cmp_ptr_to_u32(const void *a, const void *b)
> > +{
> > +	return *(u32 *)a - *(u32 *)b;
> > +}
> 
> This will overflow for e.g. `0 - 8`.
> 
> > +
> > +static int sort_insn_array_uniq(u32 *off, int off_cnt)
> > +{
> > +	int unique = 1;
> > +	int i;
> > +
> > +	sort(off, off_cnt, sizeof(off[0]), cmp_ptr_to_u32, NULL);
> > +
> > +	for (i = 1; i < off_cnt; i++)
> > +		if (off[i] != off[unique - 1])
> > +			off[unique++] = off[i];
> > +
> > +	return unique;
> > +}
> > +
> > +/*
> > + * sort_unique({map[start], ..., map[end]}) into off
> > + */
> > +static int copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off)
> > +{
> > +	u32 n = end - start + 1;
> > +	int err;
> > +
> > +	err = copy_insn_array(map, start, end, off);
> > +	if (err)
> > +		return err;
> > +
> > +	return sort_insn_array_uniq(off, n);
> > +}
> > +
> > +/*
> > + * Copy all unique offsets from the map
> > + */
> > +static int jt_from_map(struct bpf_map *map, struct jt *jt)
> > +{
> > +	u32 *off;
> > +	int n;
> > +
> > +	off = kvcalloc(map->max_entries, sizeof(u32), GFP_KERNEL_ACCOUNT);
> > +	if (!off)
> > +		return -ENOMEM;
> > +
> > +	n = copy_insn_array_uniq(map, 0, map->max_entries - 1, off);
> > +	if (n < 0) {
> > +		kvfree(off);
> > +		return n;
> > +	}
> > +
> > +	jt->off = off;
> > +	jt->off_cnt = n;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Find and collect all maps which fit in the subprog. Return the result as one
> > + * combined jump table in jt->off (allocated with kvcalloc
> > + */
> > +static int jt_from_subprog(struct bpf_verifier_env *env,
> > +			   int subprog_start,
> > +			   int subprog_end,
> > +			   struct jt *jt)
> > +{
> > +	struct bpf_map *map;
> > +	struct jt jt_cur;
> > +	u32 *off;
> > +	int err;
> > +	int i;
> > +
> > +	jt->off = NULL;
> > +	jt->off_cnt = 0;
> > +
> > +	for (i = 0; i < env->insn_array_map_cnt; i++) {
> > +		/*
> > +		 * TODO (when needed): collect only jump tables, not static keys
> > +		 * or maps for indirect calls
> > +		 */
> > +		map = env->insn_array_maps[i];
> > +
> > +		err = jt_from_map(map, &jt_cur);
> > +		if (err) {
> > +			kvfree(jt->off);
> > +			return err;
> > +		}
> > +
> > +		/*
> > +		 * This is enough to check one element. The full table is
> > +		 * checked to fit inside the subprog later in create_jt()
> > +		 */
> > +		if (jt_cur.off[0] >= subprog_start && jt_cur.off[0] < subprog_end) {
> 
> This won't always catch cases when insn array references offsets from
> several subprograms. Also is one subprogram limitation really necessary?
> 
> > +			off = kvrealloc(jt->off, (jt->off_cnt + jt_cur.off_cnt) << 2, GFP_KERNEL_ACCOUNT);
> > +			if (!off) {
> > +				kvfree(jt_cur.off);
> > +				kvfree(jt->off);
> > +				return -ENOMEM;
> > +			}
> > +			memcpy(off + jt->off_cnt, jt_cur.off, jt_cur.off_cnt << 2);
> > +			jt->off = off;
> > +			jt->off_cnt += jt_cur.off_cnt;
> > +		}
> > +
> > +		kvfree(jt_cur.off);
> > +	}
> > +
> > +	if (jt->off == NULL) {
> > +		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
> > +		return -EINVAL;
> > +	}
> > +
> > +	jt->off_cnt = sort_insn_array_uniq(jt->off, jt->off_cnt);
> > +	return 0;
> > +}
> > +
> > +static int create_jt(int t, struct bpf_verifier_env *env, int fd, struct jt *jt)
> > +{
> > +	static struct bpf_subprog_info *subprog;
> > +	int subprog_idx, subprog_start, subprog_end;
> > +	struct bpf_map *map;
> > +	int map_idx;
> > +	int ret;
> > +	int i;
> > +
> > +	if (env->subprog_cnt == 0)
> > +		return -EFAULT;
> > +
> > +	subprog_idx = find_containing_subprog_idx(env, t);
> > +	if (subprog_idx < 0) {
> > +		verbose(env, "can't find subprog containing instruction %d\n", t);
> > +		return -EFAULT;
> > +	}
> > +	subprog = &env->subprog_info[subprog_idx];
> > +	subprog_start = subprog->start;
> > +	subprog_end = (subprog + 1)->start;
> > +
> > +	map_idx = add_used_map(env, fd);
> 
> Will this spam the log with bogus
> "fd %d is not pointing to valid bpf_map\n" messages if gotox does not
> specify fd?
> 
> > +	if (map_idx >= 0) {
> > +		map = env->used_maps[map_idx];
> > +		if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
> > +			verbose(env, "map type %d in the gotox insn %d is incorrect\n",
> > +				     map->map_type, t);
> > +			return -EINVAL;
> > +		}
> > +
> > +		env->insn_aux_data[t].map_index = map_idx;
> > +
> > +		ret = jt_from_map(map, jt);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		ret = jt_from_subprog(env, subprog_start, subprog_end, jt);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/* Check that the every element of the jump table fits within the given subprogram */
> > +	for (i = 0; i < jt->off_cnt; i++) {
> > +		if (jt->off[i] < subprog_start || jt->off[i] >= subprog_end) {
> > +			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]",
> > +					t, subprog_start, subprog_end);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* "conditional jump with N edges" */
> > +static int visit_goto_x_insn(int t, struct bpf_verifier_env *env, int fd)
> > +{
> > +	struct jt *jt = &env->insn_aux_data[t].jt;
> > +	int ret;
> > +
> > +	if (jt->off == NULL) {
> > +		ret = create_jt(t, env, fd, jt);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/*
> > +	 * Mark jt as allocated. Otherwise, this is not possible to check if it
> > +	 * was allocated or not in the code which frees memory (jt is a part of
> > +	 * union)
> > +	 */
> > +	env->insn_aux_data[t].jt_allocated = true;
> > +
> > +	return push_goto_x_edge(t, env, jt);
> > +}
> > +
> >  /* Visits the instruction at index t and returns one of the following:
> >   *  < 0 - an error occurred
> >   *  DONE_EXPLORING - the instruction was fully explored
> > @@ -17786,8 +18100,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
> >  		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
> >  
> >  	case BPF_JA:
> > -		if (BPF_SRC(insn->code) != BPF_K)
> > -			return -EINVAL;
> > +		if (BPF_SRC(insn->code) == BPF_X)
> > +			return visit_goto_x_insn(t, env, insn->imm);
> >  
> >  		if (BPF_CLASS(insn->code) == BPF_JMP)
> >  			off = insn->off;
> 
> [...]
> 
> > @@ -18679,6 +19000,10 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
> >  		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
> >  	case PTR_TO_ARENA:
> >  		return true;
> > +	case PTR_TO_INSN:
> > +		/* cur ⊆ old */
> 
> Out of curiosity: are unicode symbols allowed in kernel source code?
> 
> > +		return (rcur->min_index >= rold->min_index &&
> > +			rcur->max_index <= rold->max_index);
> >  	default:
> >  		return regs_exact(rold, rcur, idmap);
> >  	}
> > @@ -19825,6 +20150,67 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
> >  	return PROCESS_BPF_EXIT;
> >  }
> >  
> > +/* gotox *dst_reg */
> > +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
> > +{
> > +	struct bpf_verifier_state *other_branch;
> > +	struct bpf_reg_state *dst_reg;
> > +	struct bpf_map *map;
> > +	int err = 0;
> > +	u32 *xoff;
> > +	int n;
> > +	int i;
> > +
> > +	dst_reg = reg_state(env, insn->dst_reg);
> > +	if (dst_reg->type != PTR_TO_INSN) {
> > +		verbose(env, "BPF_JA|BPF_X R%d has type %d, expected PTR_TO_INSN\n",
> > +				insn->dst_reg, dst_reg->type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	map = dst_reg->map_ptr;
> > +	if (!map)
> > +		return -EINVAL;
> 
> Is this a verifier bug or legit situation?
> If it is a bug, maybe add a verifier_bug() here and return -EFAULT?
> 
> > +
> > +	if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY)
> > +		return -EINVAL;
> 
> Same question here, ->type is already `PTR_TO_INSN`.
> 
> > +
> > +	if (dst_reg->max_index >= map->max_entries) {
> > +		verbose(env, "BPF_JA|BPF_X R%d is out of map boundaries: index=%u, max_index=%u\n",
> > +				insn->dst_reg, dst_reg->max_index, map->max_entries-1);
> > +		return -EINVAL;
> > +	}
> > +
> > +	xoff = kvcalloc(dst_reg->max_index - dst_reg->min_index + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
> > +	if (!xoff)
> > +		return -ENOMEM;
> > +
> > +	n = copy_insn_array_uniq(map, dst_reg->min_index, dst_reg->max_index, xoff);
> 
> Nit: I'd avoid this allocation and do a loop for(i = min_index; i <= max_index; i++),
>      with map->ops->map_lookup_elem(map, &i) (or a wrapper) inside it.
> 
> > +	if (n < 0) {
> > +		err = n;
> > +		goto free_off;
> > +	}
> > +	if (n == 0) {
> > +		verbose(env, "register R%d doesn't point to any offset in map id=%d\n",
> > +			     insn->dst_reg, map->id);
> > +		err = -EINVAL;
> > +		goto free_off;
> > +	}
> > +
> > +	for (i = 0; i < n - 1; i++) {
> > +		other_branch = push_stack(env, xoff[i], env->insn_idx, false);
> > +		if (IS_ERR(other_branch)) {
> > +			err = PTR_ERR(other_branch);
> > +			goto free_off;
> > +		}
> > +	}
> > +	env->insn_idx = xoff[n-1];
> > +
> > +free_off:
> > +	kvfree(xoff);
> > +	return err;
> > +}
> > +
> >  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
> >  {
> >  	int err;
> 
> [...]
> 
> > @@ -20981,6 +21371,23 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Clean up dynamically allocated fields of aux data for instructions [start, ..., end]
> > + */
> > +static void clear_insn_aux_data(struct bpf_insn_aux_data *aux_data, int start, int end)
> 
> Nit: switching this to (..., int start, int len) would simplify arithmetic at call sites.
> 
> > +{
> > +	int i;
> > +
> > +	for (i = start; i <= end; i++) {
> > +		if (aux_data[i].jt_allocated) {
> > +			kvfree(aux_data[i].jt.off);
> > +			aux_data[i].jt.off = NULL;
> > +			aux_data[i].jt.off_cnt = 0;
> > +			aux_data[i].jt_allocated = false;
> > +		}
> > +	}
> > +}
> > +
> >  static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
> >  {
> >  	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
> 
> [...]
> 
> > @@ -24175,18 +24586,18 @@ static bool can_jump(struct bpf_insn *insn)
> >  	return false;
> >  }
> >  
> > -static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
> > +static int insn_successors_regular(struct bpf_prog *prog, u32 insn_idx, u32 *succ)
> >  {
> > -	struct bpf_insn *insn = &prog->insnsi[idx];
> > +	struct bpf_insn *insn = &prog->insnsi[insn_idx];
> >  	int i = 0, insn_sz;
> >  	u32 dst;
> >  
> >  	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
> > -	if (can_fallthrough(insn) && idx + 1 < prog->len)
> > -		succ[i++] = idx + insn_sz;
> > +	if (can_fallthrough(insn) && insn_idx + 1 < prog->len)
> > +		succ[i++] = insn_idx + insn_sz;
> >  
> >  	if (can_jump(insn)) {
> > -		dst = idx + jmp_offset(insn) + 1;
> > +		dst = insn_idx + jmp_offset(insn) + 1;
> >  		if (i == 0 || succ[0] != dst)
> >  			succ[i++] = dst;
> >  	}
> > @@ -24194,6 +24605,36 @@ static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
> >  	return i;
> >  }
> >  
> > +static int insn_successors_gotox(struct bpf_verifier_env *env,
> > +				 struct bpf_prog *prog,
> > +				 u32 insn_idx, u32 **succ)
> > +{
> > +	struct jt *jt = &env->insn_aux_data[insn_idx].jt;
> > +
> > +	if (WARN_ON_ONCE(!jt->off || !jt->off_cnt))
> > +		return -EFAULT;
> > +
> > +	*succ = jt->off;
> > +	return jt->off_cnt;
> > +}
> > +
> > +/*
> > + * Fill in *succ[0],...,*succ[n-1] with successors. The default *succ
> > + * pointer (of size 2) may be replaced with a custom one if more
> > + * elements are required (i.e., an indirect jump).
> > + */
> > +static int insn_successors(struct bpf_verifier_env *env,
> > +			   struct bpf_prog *prog,
> > +			   u32 insn_idx, u32 **succ)
> > +{
> > +	struct bpf_insn *insn = &prog->insnsi[insn_idx];
> > +
> > +	if (unlikely(insn_is_gotox(insn)))
> > +		return insn_successors_gotox(env, prog, insn_idx, succ);
> > +
> > +	return insn_successors_regular(prog, insn_idx, *succ);
> > +}
> > +
> 
> The `prog` parameter can be dropped, as it is accessible from `env`.
> I don't like the `u32 **succ` part of this interface.
> What about one of the following alternatives:
> 
> - u32 *insn_successors(struct bpf_verifier_env *env, u32 insn_idx)
>   and `u32 succ_buf[2]` added to bpf_verifier_env?
> 
> - int insn_successor(struct bpf_verifier_env *env, u32 insn_idx, u32 succ_num):
> 	bool fallthrough = can_fallthrough(insn);
> 	bool jump = can_jump(insn);
> 	if (succ_num == 0) {
> 		if (fallthrough)
> 			return <next insn>
> 		if (jump)
> 			return <jump tgt>
> 	} else if (succ_num == 1) {
> 		if (fallthrough && jump)
> 			return <jmp tgt>
> 	} else if (is_gotox) {
> 		return <lookup>
> 	}
> 	return -1;
>   
> ?
> 
> >  /* Each field is a register bitmask */
> >  struct insn_live_regs {
> >  	u16 use;	/* registers read by instruction */
> > @@ -24387,11 +24828,17 @@ static int compute_live_registers(struct bpf_verifier_env *env)
> 
> Could you please extend `tools/testing/selftests/bpf/progs/compute_live_registers.c`
> with test cases for gotox?
> 
> >  			int insn_idx = env->cfg.insn_postorder[i];
> >  			struct insn_live_regs *live = &state[insn_idx];
> >  			int succ_num;
> > -			u32 succ[2];
> > +			u32 _succ[2];
> > +			u32 *succ = &_succ[0];
> >  			u16 new_out = 0;
> >  			u16 new_in = 0;
> >  
> > -			succ_num = insn_successors(env->prog, insn_idx, succ);
> > +			succ_num = insn_successors(env, env->prog, insn_idx, &succ);
> > +			if (succ_num < 0) {
> > +				err = succ_num;
> > +				goto out;
> > +
> > +			}
> >  			for (int s = 0; s < succ_num; ++s)
> >  				new_out |= state[succ[s]].in;
> >  			new_in = (new_out & ~live->def) | live->use;
> 
> [...]

