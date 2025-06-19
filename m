Return-Path: <bpf+bounces-61118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A945AE0E72
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 22:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCFA171095
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 20:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB92459F0;
	Thu, 19 Jun 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6LoMT98"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A161221F28
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363691; cv=none; b=jrIF0VR2jmRJJsyUK+g7BNLuiNwJCukOY1EcyvkejdxJCdK4RKJ7ooqwKnmbbFsA5V+1gc/GJnQsfqsIzlYALZG+5CN4pmzzvz6W1a2VQ+TfXFbiUaH+q4k5WFNE+Q9wWcooPPb8anUE3EjJS5BZVdj7VHtFwSUPkyzQVmSE0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363691; c=relaxed/simple;
	bh=eTsGzFgxGAZ4rIdVlC+uXGCAslFtQ9hKn1QDZCj0+10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOrhqfAtPrxzkrLZSkK8HK1d3TGiGe+BLXeRrEUlrlcM4VWOZ3pTiiQx6W7SDWddpOs45XZcOT6+dRWGxQf6QDwNuuJPRBTFYNRd2JETQe7CsCmCV+4+EAReXF/TjgfOYe7GcNrpCuQFmrJP6dRrsFkn+wsqsXDHD3kWVyhwO2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6LoMT98; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a375e72473so539908f8f.0
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750363688; x=1750968488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh7hcEF4DJqeOZE3r4TDrUCj+37VScVPXvrdwJJFwVE=;
        b=X6LoMT98h50BY/ATS9U9jhJemwXCP2W8gGLeqZEZY2LvGdrBIfcRwY65QfilQ6fMlv
         ++heffx7vA4hIyzg8E1s9Q+XxBrt+1dzTJlosysOjRYeU6vtyL2cDgvPQ2BX6ogVpT3c
         tpD7ML8g9Ps7cn6YZwdXMB8i5SqYEuACXiq99oleTv7BXaJwEdXDOCR8L0w6dz3Y7lno
         qyvIOHt8AQNcZOZ562UopRSSK9NVtZeAps+ZJZ2ZwupJ/b8d+zV/Fqe2GRHPjP21oyLH
         03RfUxxjR2qHSr7jRxuG6mODkMLgOBrK0hibLJ6/v3OiDbwO+LMUo/srDGF1XMzcVRdb
         l0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750363688; x=1750968488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh7hcEF4DJqeOZE3r4TDrUCj+37VScVPXvrdwJJFwVE=;
        b=Ow/rgD1w2qLx1DTUYCWwcgcwT+A7OUQNJPVhzfxTLUBBaeCXf4oyq4PUsc/unfSPdK
         3IrUDCMJ/9nTJ8SVE4XOeYY7oNXDoAkT+PbAPHq7/4Oi0gQfnlq/s1CsZFsMkXlefhD5
         MTa7uffRN0Iezd3+FpcTj3IPnTYwYrPRbsN+vA5DcIwpXO4sF6h1xCvitwhtOYhtx0VR
         49sEraJNXDvie9fl0HEogfWSU1JbJlAtXA5oKzOVwoFW8PCt8kYEpBWsLf2R2g7vutLl
         y1bdxCooO/lyp71e8ucBX0hEoCc1FsZMud25I4LiC8wOYWCC900J70AKAYHG0YQsufX8
         x6VQ==
X-Gm-Message-State: AOJu0Yy6DboQjlvpRGmFNOxUlDPJH6KKn3AnAxgcBu3wcpLS9RWNQUwt
	LWqpDbEMpalNC5YVLAyO/wlFgL+Ge/rKXxDoVoVaV9ojfcBn1P3jELvXdNBMug==
X-Gm-Gg: ASbGnct2sBUVVCN4IfiF5cGi7jTDzKNTT+AyqL3KKaAEzo6ySCj1c2FzUctSpyIHbyC
	Q8cxPs7plVXia1gk11qSVwWDkk66g6ni7rbvj3i1dA7lvE6OThMuWzeDuHnBvgpPvheOer1Pv+7
	2mVtsKg+/fKradlfaiQ8Rroj+qCfSp2eHeCDv7odPBJXr3JXdkJfof1p3+vFEamVHL+F/KBSPTr
	Es0hn1LPEE806UIeJx8LTuAmewJDfklZAfNb/VHHmniNqRvcePjSoLbzrkpn6LiNEtqJENfwrG/
	Nm21tT42162P3eeiUgTxNLCD3+aEkW3cdVivArx0vexwgdvhEj/EMzyJGI5knDRSSVlhufId7A=
	=
X-Google-Smtp-Source: AGHT+IGy2QJlV3km4GeCTiunGwDtCZYqkF9CAyGNRvyDuym3dE8cZbRZpzAJ8lv3JfSFi93fMzcTdg==
X-Received: by 2002:a05:6000:4715:b0:3a5:2923:7ffa with SMTP id ffacd0b85a97d-3a6d1193fd2mr259389f8f.7.1750363687513;
        Thu, 19 Jun 2025 13:08:07 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8edbsm37765255e9.24.2025.06.19.13.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 13:08:07 -0700 (PDT)
Date: Thu, 19 Jun 2025 20:13:47 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 5/9] bpf, x86: add support for indirect jumps
Message-ID: <aFRve0dIxsTfa2TC@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-6-a.s.protopopov@gmail.com>
 <8727a800569d88f8f932333859590f702c5332ea.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8727a800569d88f8f932333859590f702c5332ea.camel@gmail.com>

On 25/06/18 04:03AM, Eduard Zingerman wrote:
> On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
> 
> [...]
> 
> >     0:   r3 = r1                    # "switch (r3)"
> >     1:   if r3 > 0x13 goto +0x666   # check r3 boundaries
> >     2:   r3 <<= 0x3                 # r3 is void*, point to an address
> >     3:   r1 = 0xbeef ll             # r1 is PTR_TO_MAP_VALUE, r1->map_ptr=M
> >     5:   r1 += r3                   # r1 inherits boundaries from r3
> >     6:   r1 = *(u64 *)(r1 + 0x0)    # r1 now has type INSN_TO_PTR
>                                                         ^^^^^^^^^^^
>                                                         PTR_TO_INSN?

Heh, thanks, fill fix. [It's C, so a[1] and 1[a] means the same :-)]

> >     7:   gotox r1[,imm=fd(M)]       # verifier checks that M == r1->map_ptr
> 
> [...]
> 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 37dc83d91832..d20f6775605d 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2520,6 +2520,13 @@ st:			if (is_imm8(insn->off))
> >  
> >  			break;
> >  
> > +		case BPF_JMP | BPF_JA | BPF_X:
> > +		case BPF_JMP32 | BPF_JA | BPF_X:
> 
> Is it necessary to add both JMP and JMP32 versions?
> Do we need to extend e.g. bpf_jit_supports_insn() and report an error
> in verifier.c or should we rely on individual jits to report unknown
> instruction?

Hmm, should I just leave BPF_JMP? Or just leave as is and do not distinguish?

> 
> > +			emit_indirect_jump(&prog,
> > +					   reg2hex[insn->dst_reg],
> > +					   is_ereg(insn->dst_reg),
> > +					   image + addrs[i - 1]);
> > +			break;
> >  		case BPF_JMP | BPF_JA:
> >  		case BPF_JMP32 | BPF_JA:
> >  			if (BPF_CLASS(insn->code) == BPF_JMP) {
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 008bcd44c60e..3c5eaea2b476 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -952,6 +952,7 @@ enum bpf_reg_type {
> >  	PTR_TO_ARENA,
> >  	PTR_TO_BUF,		 /* reg points to a read/write buffer */
> >  	PTR_TO_FUNC,		 /* reg points to a bpf program function */
> > +	PTR_TO_INSN,		 /* reg points to a bpf program instruction */
> >  	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
> >  	__BPF_REG_TYPE_MAX,
> >  
> > @@ -3601,6 +3602,7 @@ int bpf_insn_set_ready(struct bpf_map *map);
> >  void bpf_insn_set_release(struct bpf_map *map);
> >  void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len);
> >  void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
> > +int bpf_insn_set_iter_xlated_offset(struct bpf_map *map, u32 iter_no);
> 
> This is a horrible name:
> - this function is not an iterator;
> - it is way too long.
> 
> Maybe make it a bit more complex but convenient to use, e.g.:
> 
>   struct bpf_iarray_iter {
> 	struct bpf_map *map;
> 	u32 idx;
>   };
> 
>   struct bpf_iset_iter bpf_iset_make_iter(struct bpf_map *map, u32 lo, u32 hi);
>   bool bpf_iset_iter_next(struct bpf_iarray_iter *it, u32 *offset); // still a horrible name
> 
> This would hide the manipulation with unique indices from verifier.c.
> 
> ?

How about just bpf_insn_set_next[_unique]_offset()?

> 
> >  
> >  struct bpf_insn_ptr {
> >  	void *jitted_ip;
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 84b5e6b25c52..80d9afcca488 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -229,6 +229,10 @@ struct bpf_reg_state {
> >  	enum bpf_reg_liveness live;
> >  	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
> >  	bool precise;
> > +
> > +	/* Used to track boundaries of a PTR_TO_INSN */
> > +	u32 min_index;
> > +	u32 max_index;
> 
> Use {umin,umax}_value instead?

Please see my comments in the reply to Alexei.

> >  };
> >  
> >  enum bpf_stack_slot_type {
> > diff --git a/kernel/bpf/bpf_insn_set.c b/kernel/bpf/bpf_insn_set.c
> > index c20e99327118..316cecad60a9 100644
> > --- a/kernel/bpf/bpf_insn_set.c
> > +++ b/kernel/bpf/bpf_insn_set.c
> > @@ -9,6 +9,8 @@ struct bpf_insn_set {
> >  	struct bpf_map map;
> >  	struct mutex state_mutex;
> >  	int state;
> > +	u32 **unique_offsets;
> 
> Why is this a pointer to pointer?
> bpf_insn_set_iter_xlated_offset() is only used during check_cfg() and
> main verification. At that point no instruction movement occurred yet,
> so no need to track `&insn_set->ptrs[i].user_value.xlated_off`?
> 
> > +	u32 unique_offsets_cnt;
> >  	long *ips;
> >  	DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
> >  };
> 
> [...]
> 
> > @@ -15296,6 +15330,22 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
> >  		return 0;
> >  	}
> >  
> > +	if (dst_reg->type == PTR_TO_MAP_VALUE && map_is_insn_set(dst_reg->map_ptr)) {
> > +		if (opcode != BPF_ADD) {
> > +			verbose(env, "Operation %s on ptr to instruction set map is prohibited\n",
> > +				bpf_alu_string[opcode >> 4]);
> > +			return -EACCES;
> > +		}
> > +		src_reg = &regs[insn->src_reg];
> > +		if (src_reg->type != SCALAR_VALUE) {
> > +			verbose(env, "Adding non-scalar R%d to an instruction ptr is prohibited\n",
> > +				insn->src_reg);
> > +			return -EACCES;
> > +		}
> > +		dst_reg->min_index = src_reg->umin_value / sizeof(long);
> > +		dst_reg->max_index = src_reg->umax_value / sizeof(long);
> > +	}
> > +
> 
> What if there are several BPF_ADD on the same PTR_TO_MAP_VALUE in a row?
> Shouldn't the {min,max}_index be accumulated in that case?
> 
> Nit: this should be handled inside adjust_ptr_min_max_vals().

Yes, thanks, I've had this in my TBDs list for the next version. (All
"legal" cases generated by LLVM just do one add, so I've skipped it.)

> >  	if (dst_reg->type != SCALAR_VALUE)
> >  		ptr_reg = dst_reg;
> >  
> 
> [...]
> 
> > @@ -17552,6 +17607,62 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
> 
> [...]
> 
> > +/* "conditional jump with N edges" */
> > +static int visit_goto_x_insn(int t, struct bpf_verifier_env *env, int fd)
> > +{
> > +	struct bpf_map *map;
> > +	int ret;
> > +
> > +	ret = add_used_map(env, fd, &map);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (map->map_type != BPF_MAP_TYPE_INSN_SET)
> > +		return -EINVAL;
> 
> Nit: print something in the log?

Yes, thanks.

> 
> > +
> > +	return push_goto_x_edge(t, env, map);
> > +}
> > +
> 
> [...]
> 
> > @@ -18786,11 +18904,22 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
> >  			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exact)
> >  {
> >  	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
> > +	struct bpf_insn *insn;
> >  	u16 i;
> >  
> >  	if (old->callback_depth > cur->callback_depth)
> >  		return false;
> >  
> > +	insn = &env->prog->insnsi[insn_idx];
> > +	if (insn_is_gotox(insn)) {
> > +		struct bpf_reg_state *old_dst = &old->regs[insn->dst_reg];
> > +		struct bpf_reg_state *cur_dst = &cur->regs[insn->dst_reg];
> > +
> > +		if (old_dst->min_index != cur_dst->min_index ||
> > +		    old_dst->max_index != cur_dst->max_index)
> > +			return false;
> > +	}
> > +
> 
> Concur with Alexei, this should be handled by regsafe().
> Also, having cur_dst as a subset of old_dst should be fine.

Thanks, yes to both.

> >  	for (i = 0; i < MAX_BPF_REG; i++)
> >  		if (((1 << i) & live_regs) &&
> >  		    !regsafe(env, &old->regs[i], &cur->regs[i],
> > @@ -19654,6 +19783,55 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
> >  	return PROCESS_BPF_EXIT;
> >  }
> >  
> > +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
> > +{
> > +	struct bpf_verifier_state *other_branch;
> > +	struct bpf_reg_state *dst_reg;
> > +	struct bpf_map *map;
> > +	int xoff;
> > +	int err;
> > +	u32 i;
> > +
> > +	/* this map should already have been added */
> > +	err = add_used_map(env, insn->imm, &map);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	dst_reg = reg_state(env, insn->dst_reg);
> > +	if (dst_reg->type != PTR_TO_INSN) {
> > +		verbose(env, "BPF_JA|BPF_X R%d has type %d, expected PTR_TO_INSN\n",
> > +				insn->dst_reg, dst_reg->type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (dst_reg->map_ptr != map) {
> > +		verbose(env, "BPF_JA|BPF_X R%d was loaded from map id=%u, expected id=%u\n",
> > +				insn->dst_reg, dst_reg->map_ptr->id, map->id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (dst_reg->max_index >= map->max_entries)
> > +		return -EINVAL;
> > +
> > +	for (i = dst_reg->min_index + 1; i <= dst_reg->max_index; i++) {
> 
> Why +1 is needed in `i = dst_reg->min_index + 1`?

We want to "jump" to states {min,min+1,...,max} so we push states
{min+1,...,max} and continue the current state with the `jump
M[min]`:

    env->insn_idx = bpf_insn_set_iter_xlated_offset(map, dst_reg->min_index);

> > +		xoff = bpf_insn_set_iter_xlated_offset(map, i);
> > +		if (xoff == -ENOENT)
> > +			break;
> > +		if (xoff < 0)
> > +			return xoff;
> > +
> > +		other_branch = push_stack(env, xoff, env->insn_idx, false);
> > +		if (!other_branch)
> > +			return -EFAULT;
> 
> Nit: `return -ENOMEM`.

Ok, thanks.

> 
> > +	}
> > +
> > +	env->insn_idx = bpf_insn_set_iter_xlated_offset(map, dst_reg->min_index);
> > +	if (env->insn_idx < 0)
> > +		return env->insn_idx;
> > +
> > +	return 0;
> > +}
> > +
> >  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
> >  {
> >  	int err;
> 
> [...]
> 

