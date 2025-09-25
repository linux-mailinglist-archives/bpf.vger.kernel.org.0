Return-Path: <bpf+bounces-69763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED072BA0F7E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F547AAA28
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824883128C9;
	Thu, 25 Sep 2025 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iynjkv60"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA1428CF50
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823298; cv=none; b=DGra2+VCdg2Y3GpCOHCGyWf441rUgcLomXK2hk/2M0pJMRoB8GJPGIfxtVfkOuWM01xetzuuamu88UB4rjmnWjw5X7BSLjJXUGewWakbmllHPKgyvFYwM5CKa051+Tr1Q0hKW34/S2NxgUvyvIDtF36JA1vfVbIrvOp4lQ34iPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823298; c=relaxed/simple;
	bh=uqZmQB347EJF3Lo0gLJJ8R+iWqdFMz0/UIGFLngkO/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJEifmlntt+RQU127pOB/O/v92osYNfkOW2w6yt1/FIGwinLs+b9hX5qRj5ERXdlVTzuf1iQQzKc27A7pZ7cSNrkpE11LFxNi8/cHDDWHMnLpCJu5g8JKZys8KxpVp12EbB7fGJnUirUpKcUR/LWRzZSvZCdTkumLfQmN3t87n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iynjkv60; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e1bc8ffa1so13543365e9.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758823294; x=1759428094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIQ+agH+deyE0oibQaWGfCzvnH7hfdEzfc3KPp/V7Ik=;
        b=iynjkv60CbJli1yAXhWRt6tru+aiPcE4CKSYaO2R6ptWdKKipLV5PdI2n8vRd58ZUw
         NhodSJftuUekH7jrLimQo1bTD8mD6Tc9QZYF7Xx4LU5jHSmv3Pz0BWYojpyUJ8gmZo39
         nfitevYZNeP5tOTboFci5QL/brnc3OsLACd2VDDymFc9siyXA/c6FTeeNfTa7katJfLo
         emYQPcOumcU1uTcCjfKgAw0jo+a1k1ipI6XIAvUCxLw+JDza1hxaE5KknN7aW5vKCMY1
         TD+BDfm6nZsn220VD7Wq11q9obt24Av1/gDIuC6I9lzLNs1AfxEv23X3CwyTCRALodFZ
         1UBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758823294; x=1759428094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIQ+agH+deyE0oibQaWGfCzvnH7hfdEzfc3KPp/V7Ik=;
        b=kY8yzsV7ypp1eGZG0y4DmhyNlLbPB+xotkXwRdaDjmEmUjDrePe+dVguWqCQ8VQl6l
         XsHzPEagYBpmes2JUeb3ghFJ375TrJ7sOY42C6O0WRidH7zUUsfQPew727nbLA7KrbJo
         5RYHD7aaNFYLmmgzwa15WFXtmvAXqaMr1RTDXGbEfqNRjoYk1oQ4VSMRr7rsmWn2Uigy
         ci5H5K5Pax5P6PeEUXuv4zjhg7fDsxDRlZCOKk6U1NAP+leMq2mdXUIlNEZNZCXTuTOl
         wZtOhFa4GBfWEt1S5jLn/+XDmLiLJVUKQQZEuZAs49/j6ZTwTsWFUK6CWy7afNXMpCK2
         77qw==
X-Gm-Message-State: AOJu0YwyXMftZSeeeK+ta724QqiR4R2QZvADTkZA2RCkY7Su5ceYHRL6
	rxxutCgoFqABfDRefiU7Tlst1TVyZQdSx5MzRwvU9bLsdk3Dvp7LAZ4X
X-Gm-Gg: ASbGncsyilqfEP1sRYkWX8uw8eBvMeLY6LbQd+//UdD5rTrAApALWsAE2Gbfkb8BWBw
	zI22Q4u6HDHBQdpO8sRs5LPkmMg44OGmUFXbFObqOO/5wpejt4CnB/xtgNLRpMToxEDTywIHj90
	0P0Y6XSNmdACNeNWa1HK0NCN9bwO6pUzykq1eCcW4K9Y3bhk1v4atfoBXjXLHrnFrA1cYfUWN9O
	uTe0M5K8QnF3srUVGJzOOoItNK5ZllErO8M5Vd+5a47FX+kUjygsBu5uDEZJvW31w650uXONDkP
	vLsKWiManwuipEKkx3u6FQ+Gakr8XAa3IIV+RGZok3ufGoRNF8rS1JYrmlUWQ5zSBbDWF4V0D7h
	GT0bvuT2podWGQl7C3ipKmhQ9BWyp+EWx
X-Google-Smtp-Source: AGHT+IHKPWI0NSblAKLaUPd9rjK6qaWI+ALjv67JUrDIDXgm4UyDp/ybvmi8ZJdPjdlpuV8gm1AbhA==
X-Received: by 2002:a05:600c:4512:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46e329f9b5amr47906755e9.18.1758823293393;
        Thu, 25 Sep 2025 11:01:33 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31f62sm85372725e9.15.2025.09.25.11.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:01:32 -0700 (PDT)
Date: Thu, 25 Sep 2025 18:07:27 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 08/13] bpf, x86: add support for indirect
 jumps
Message-ID: <aNWE3x7SwgyTglAN@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <20250918093850.455051-9-a.s.protopopov@gmail.com>
 <61861bfd86d150b86c674ef7bea2b23e3482e1f2.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61861bfd86d150b86c674ef7bea2b23e3482e1f2.camel@gmail.com>

On 25/09/19 05:28PM, Eduard Zingerman wrote:
> On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > Add support for a new instruction
> > 
> >     BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0
> > 
> > which does an indirect jump to a location stored in Rx.  The register
> > Rx should have type PTR_TO_INSN. This new type assures that the Rx
> > register contains a value (or a range of values) loaded from a
> > correct jump table – map of type instruction array.
> > 
> > For example, for a C switch LLVM will generate the following code:
> > 
> >     0:   r3 = r1                    # "switch (r3)"
> >     1:   if r3 > 0x13 goto +0x666   # check r3 boundaries
> >     2:   r3 <<= 0x3                 # adjust to an index in array of addresses
> >     3:   r1 = 0xbeef ll             # r1 is PTR_TO_MAP_VALUE, r1->map_ptr=M
> >     5:   r1 += r3                   # r1 inherits boundaries from r3
> >     6:   r1 = *(u64 *)(r1 + 0x0)    # r1 now has type INSN_TO_PTR
> >     7:   gotox r1[,imm=fd(M)]       # jit will generate proper code
>                    ^^^^^^^^^^^^
> 	      Nit: this part is not needed atm.

Thanks, removed.

> > 
> > Here the gotox instruction corresponds to one particular map. This is
> > possible however to have a gotox instruction which can be loaded from
> > different maps, e.g.
> 
> [...]
> 
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index aca43c284203..607a684642e5 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> 
> [...]
> 
> > @@ -586,6 +597,9 @@ struct bpf_insn_aux_data {
> >  	u8 fastcall_spills_num:3;
> >  	u8 arg_prog:4;
> >  
> > +	/* true if jt->off was allocated */
> > +	bool jt_allocated;
> > +
> 
> Nit: in clear_insn_aux_data() maybe just check if instruction is a gotox?

Yes, this should work, thanks

> 
> >  	/* below fields are initialized once */
> >  	unsigned int orig_idx; /* original instruction index */
> >  	bool jmp_point;
> 
> [...]
> 
> >  static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > index 0c8dac62f457..4b945b7e31b8 100644
> > --- a/kernel/bpf/bpf_insn_array.c
> > +++ b/kernel/bpf/bpf_insn_array.c
> > @@ -1,7 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  
> >  #include <linux/bpf.h>
> > -#include <linux/sort.h>
> 
> Nit: remove this include from patch #3?

sure, thanks!

> >  
> >  #define MAX_INSN_ARRAY_ENTRIES 256
> >  
> 
> [...]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5c1e4e37d1f8..839260e62fa9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [...]
> 
> > @@ -7620,6 +7644,19 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >  
> >  				regs[value_regno].type = SCALAR_VALUE;
> >  				__mark_reg_known(&regs[value_regno], val);
> > +			} else if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
> > +				regs[value_regno].type = PTR_TO_INSN;
> > +				regs[value_regno].map_ptr = map;
> > +				regs[value_regno].off = reg->off;
> > +				regs[value_regno].umin_value = reg->umin_value;
> > +				regs[value_regno].umax_value = reg->umax_value;
> > +				regs[value_regno].smin_value = reg->smin_value;
> > +				regs[value_regno].smax_value = reg->smax_value;
> > +				regs[value_regno].s32_min_value = reg->s32_min_value;
> > +				regs[value_regno].s32_max_value = reg->s32_max_value;
> > +				regs[value_regno].u32_min_value = reg->u32_min_value;
> > +				regs[value_regno].u32_max_value = reg->u32_max_value;
> > +				regs[value_regno].var_off = reg->var_off;
> 
> This can be shortened to:
> 
>   copy_register_state(regs + value_regno, reg);
>   regs[value_regno].type = PTR_TO_INSN;
> 
> I think that a check that read is u64 wide is necessary here.
> Otherwise e.g. for u8 load you'd need to truncate the bounds set above.
> This is also necessary for alignment check at the beginning of this
> function (check_ptr_alignment() call).

will fix, thanks!

> >  			} else {
> >  				mark_reg_unknown(env, regs, value_regno);
> >  			}
> 
> [...]
> 
> > @@ -14628,6 +14672,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
> >  		}
> >  		break;
> >  	case BPF_SUB:
> > +		if (ptr_to_insn_array) {
> > +			verbose(env, "Operation %s on ptr to instruction set map is prohibited\n",
> > +				bpf_alu_string[opcode >> 4]);
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                Nit: Just "subtraction", no need for lookup?
>                     Also, maybe put this near the same check for PTR_TO_STACK?

ok

> 
> > +			return -EACCES;
> > +		}
> >  		if (dst_reg == off_reg) {
> >  			/* scalar -= pointer.  Creates an unknown scalar */
> >  			verbose(env, "R%d tried to subtract pointer from scalar\n",
> 
> [...]
> 
> > @@ -17733,6 +17783,234 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
> >  	return 0;
> >  }
> >  
> > +#define SET_HIGH(STATE, LAST)	STATE = (STATE & 0xffffU) | ((LAST) << 16)
> > +#define GET_HIGH(STATE)		((u16)((STATE) >> 16))
> > +
> > +static int push_gotox_edge(int t, struct bpf_verifier_env *env, struct bpf_iarray *jt)
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
> 
> Suppose there is some other way to reach `w` beside gotox.
> Also suppose that `w` had been visited already.
> In such case `mark_jmp_point(env, w)` might get omitted for `w`.

thanks

> > +
> > +		break;
> > +	}
> > +
> > +	if (prev == jt->off_cnt)
> > +		return DONE_EXPLORING;
> > +
> > +	mark_prune_point(env, t);
> 
> Nit: do this from visit_gotox_insn() ?

yes, ok

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
> 
> [...]
> 
> > +/*
> > + * Find and collect all maps which fit in the subprog. Return the result as one
> > + * combined jump table in jt->off (allocated with kvcalloc
>                                                            ^^^
> 						   nit: missing ')'
> 
> > + */
> > +static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
> > +					  int subprog_start, int subprog_end)
> 
> [...]
> 
> > +static struct bpf_iarray *
> > +create_jt(int t, struct bpf_verifier_env *env, int fd)
>                                                   ^^^^^^
> 			fd is unused, same for visit_gotox_insn()
> 
> [...]
> 
> > @@ -18716,6 +19001,10 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
> >  		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
> >  	case PTR_TO_ARENA:
> >  		return true;
> > +	case PTR_TO_INSN:
> > +		/* is rcur a subset of rold? */
> > +		return (rcur->umin_value >= rold->umin_value &&
> > +			rcur->umax_value <= rold->umax_value);
> 
> I think this should be:
> 
>                  if (rold->off != rcur->off)
>                          return false;
>                  return range_within(old: rold, cur: rcur) &&
>                         tnum_in(a: rold->var_off, b: rcur->var_off);

ok, makes sense

> >  	default:
> >  		return regs_exact(rold, rcur, idmap);
> >  	}
> > @@ -19862,6 +20151,102 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
> >  	return PROCESS_BPF_EXIT;
> >  }
> >  
> > +static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
> > +				       int regno,
> > +				       struct bpf_map *map,
> > +				       u32 *pmin_index, u32 *pmax_index)
> > +{
> > +	struct bpf_reg_state *reg = reg_state(env, regno);
> > +	u64 min_index, max_index;
> > +
> > +	if (check_add_overflow(reg->umin_value, reg->off, &min_index) ||
> > +		(min_index > (u64) U32_MAX * sizeof(long))) {
> > +		verbose(env, "the sum of R%u umin_value %llu and off %u is too big\n",
> > +			     regno, reg->umin_value, reg->off);
> > +		return -ERANGE;
> > +	}
> > +	if (check_add_overflow(reg->umax_value, reg->off, &max_index) ||
> > +		(max_index > (u64) U32_MAX * sizeof(long))) {
> > +		verbose(env, "the sum of R%u umax_value %llu and off %u is too big\n",
> > +			     regno, reg->umax_value, reg->off);
> > +		return -ERANGE;
> > +	}
> > +
> > +	min_index /= sizeof(long);
> > +	max_index /= sizeof(long);
> 
> Nit: `long` is 32-bit long on x86 (w/o -64), I understand that x86 jit
> would just reject gotox, but could you please use `sizeof(u64)` here?

Haven't check, really, but will the jump table contain 8-byte records
for x86_32? I thought they are size of pointers, thus I use long.

Still can replace by 8, yes.

> > +
> > +	if (min_index >= map->max_entries || max_index >= map->max_entries) {
> > +		verbose(env, "R%u points to outside of jump table: [%llu,%llu] max_entries %u\n",
> > +			     regno, min_index, max_index, map->max_entries);
> > +		return -EINVAL;
> > +	}
> > +
> > +	*pmin_index = min_index;
> > +	*pmax_index = max_index;
> > +	return 0;
> > +}
> > +
> > +/* gotox *dst_reg */
> > +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
> > +{
> > +	struct bpf_verifier_state *other_branch;
> > +	struct bpf_reg_state *dst_reg;
> > +	struct bpf_map *map;
> > +	u32 min_index, max_index;
> > +	int err = 0;
> > +	u32 *xoff;
> > +	int n;
> > +	int i;
> > +
> > +	dst_reg = reg_state(env, insn->dst_reg);
> > +	if (dst_reg->type != PTR_TO_INSN) {
> > +		verbose(env, "R%d has type %d, expected PTR_TO_INSN\n",
> > +			     insn->dst_reg, dst_reg->type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	map = dst_reg->map_ptr;
> > +	if (verifier_bug_if(!map, env, "R%d has an empty map pointer", insn->dst_reg))
> > +		return -EFAULT;
> > +
> > +	if (verifier_bug_if(map->map_type != BPF_MAP_TYPE_INSN_ARRAY, env,
> > +			    "R%d has incorrect map type %d", insn->dst_reg, map->map_type))
> > +		return -EFAULT;
> > +
> > +	err = indirect_jump_min_max_index(env, insn->dst_reg, map, &min_index, &max_index);
> > +	if (err)
> > +		return err;
> > +
> > +	xoff = kvcalloc(max_index - min_index + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
> > +	if (!xoff)
> > +		return -ENOMEM;
> 
> Let's keep a buffer for this allocation in `env` and realloc it when needed.
> Would be good to avoid allocating memory each time this gotox is visited.

Ok (to put it in bpf_subprog_info as suggested in your next letter).
Though, probably it still needs to grow (= realloc).

> > +
> > +	n = copy_insn_array_uniq(map, min_index, max_index, xoff);
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
>                                                                        ^^^^^
>                          `is_speculative` has to be inherited from env->cur_state

Ah, yes, thanks

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
> > @@ -19964,6 +20349,9 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
> >  
> >  			mark_reg_scratched(env, BPF_REG_0);
> >  		} else if (opcode == BPF_JA) {
> > +			if (BPF_SRC(insn->code) == BPF_X)
> > +				return check_indirect_jump(env, insn);
> > +
> 
> check_indirect_jump() does not check reserved fields (like offset or dst_reg).

Ok, thanks, will fix. Though, maybe, in the visit_gotox, why to wait until here?

(just in case, should be s/dst_reg/src_reg in your comment)

> 
> >  			if (BPF_SRC(insn->code) != BPF_K ||
> >  			    insn->src_reg != BPF_REG_0 ||
> >  			    insn->dst_reg != BPF_REG_0 ||
> 
> [...]
> 
> > @@ -24215,23 +24625,41 @@ static bool can_jump(struct bpf_insn *insn)
> >  	return false;
> >  }
> >  
> > -static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
> > +/*
> > + * Returns an array of instructions succ, with succ->off[0], ...,
> > + * succ->off[n-1] with successor instructions, where n=succ->off_cnt
> > + */
> > +static struct bpf_iarray *
> > +insn_successors(struct bpf_verifier_env *env, u32 insn_idx)
> 
> Nit: maybe put insn_successors refactoring to a separate patch?

Yes, makes sense, will do. (In any case thi piece needs to be
carefully rebased after you recent changes.)

> >  {
> > -	struct bpf_insn *insn = &prog->insnsi[idx];
> > -	int i = 0, insn_sz;
> > +	struct bpf_prog *prog = env->prog;
> > +	struct bpf_insn *insn = &prog->insnsi[insn_idx];
> > +	struct bpf_iarray *succ;
> > +	int insn_sz;
> >  	u32 dst;
> >  
> > -	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
> > -	if (can_fallthrough(insn) && idx + 1 < prog->len)
> > -		succ[i++] = idx + insn_sz;
> > +	if (unlikely(insn_is_gotox(insn))) {
> > +		succ = env->insn_aux_data[insn_idx].jt;
> > +		if (verifier_bug_if(!succ, env,
> > +				    "aux data for insn %u doesn't contain a jump table\n",
> > +				    insn_idx))
> > +			return ERR_PTR(-EFAULT);
> 
> Requiring each callsite to check error code for this function is very inconvenient.
> Moreover, insn_successors() is hot in liveness.c:update_instance().
> Let's just assume that NULL here cannot happen.

Hmm, ok. I will check and fix.

> > +	} else {
> > +		/* pre-allocated array of size up to 2; reset cnt, as it may be used already */
> > +		succ = env->succ;
> > +		succ->off_cnt = 0;
> >  
> > -	if (can_jump(insn)) {
> > -		dst = idx + jmp_offset(insn) + 1;
> > -		if (i == 0 || succ[0] != dst)
> > -			succ[i++] = dst;
> > -	}
> > +		insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
> > +		if (can_fallthrough(insn) && insn_idx + 1 < prog->len)
> > +			succ->off[succ->off_cnt++] = insn_idx + insn_sz;
> >  
> > -	return i;
> > +		if (can_jump(insn)) {
> > +			dst = insn_idx + jmp_offset(insn) + 1;
> > +			if (succ->off_cnt == 0 || succ->off[0] != dst)
> > +				succ->off[succ->off_cnt++] = dst;
> > +		}
> > +	}
> > +	return succ;
> >  }
> >
> 
> [...]
> 
> > @@ -24489,11 +24921,10 @@ static int compute_scc(struct bpf_verifier_env *env)
> >  	const u32 insn_cnt = env->prog->len;
> >  	int stack_sz, dfs_sz, err = 0;
> >  	u32 *stack, *pre, *low, *dfs;
> > -	u32 succ_cnt, i, j, t, w;
> > +	u32 i, j, t, w;
> >  	u32 next_preorder_num;
> >  	u32 next_scc_id;
> >  	bool assign_scc;
> > -	u32 succ[2];
> >  
> >  	next_preorder_num = 1;
> >  	next_scc_id = 1;
> > @@ -24592,6 +25023,8 @@ static int compute_scc(struct bpf_verifier_env *env)
> >  		dfs[0] = i;
> >  dfs_continue:
> >  		while (dfs_sz) {
> > +			struct bpf_iarray *succ;
> > +
> 
> Nit: please move this declaration up, just to be consistent with other variables.

Sure

> >  			w = dfs[dfs_sz - 1];
> >  			if (pre[w] == 0) {
> >  				low[w] = next_preorder_num;
> > @@ -24600,12 +25033,17 @@ static int compute_scc(struct bpf_verifier_env *env)
> >  				stack[stack_sz++] = w;
> >  			}
> >  			/* Visit 'w' successors */
> > -			succ_cnt = insn_successors(env->prog, w, succ);
> > -			for (j = 0; j < succ_cnt; ++j) {
> > -				if (pre[succ[j]]) {
> > -					low[w] = min(low[w], low[succ[j]]);
> > +			succ = insn_successors(env, w);
> > +			if (IS_ERR(succ)) {
> > +				err = PTR_ERR(succ);
> > +				goto exit;
> > +
> > +			}
> > +			for (j = 0; j < succ->off_cnt; ++j) {
> > +				if (pre[succ->off[j]]) {
> > +					low[w] = min(low[w], low[succ->off[j]]);
> >  				} else {
> > -					dfs[dfs_sz++] = succ[j];
> > +					dfs[dfs_sz++] = succ->off[j];
> >  					goto dfs_continue;
> >  				}
> >  			}
> 
> [...]

