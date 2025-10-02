Return-Path: <bpf+bounces-70187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B5DBB371F
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A8D18980E8
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A43301018;
	Thu,  2 Oct 2025 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJy3QQQV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6302DCBEE
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396857; cv=none; b=dhi25V4uuPa5jrqbMcdU8UO7lxHMHHaSfR5Q+wiBCrEPj6qCMTb1vrJmmafze/2TPenMF5DEqs/T2/4Z/Ulqz5Lj3c5ReG+CyZdZ9ubCMYSaJvc6RSEtlKO2EpLSln50Gcxi/eRrGLaVLi3pGGEydRhU306xyZoSD1TK1bGhGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396857; c=relaxed/simple;
	bh=9bWwp1oJv1Mqj2lkefxK2dckh2ur8WA7wluyJ/3X1Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3vYDSwukLNy9+0oGixh20s8AALnblemiCyn9ULCbmr8oDXlEVTwOT9RMH+YW9w3dS6sqS4F48xv4EqjJEue/gMLqyTgF79hJ5jo3R8lEbRyClBlYem2ZadZJiCJLRbZ4wvwent/FcqbbGgBBwC3ZEK5ul9Otmf+DUk0Vvbd3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJy3QQQV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e2e363118so6704155e9.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 02:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396853; x=1760001653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MHfu5RK9fQGyEY9zqStxoL5d61OtEaZHSUCnCxJYEKc=;
        b=nJy3QQQV0uxzrU9F+bWRSStZQZ3TABdX6vFCIi/ng9Hi2TJI2/zsHt0EWv0DP7eQl6
         iKMOG+dUAcWW3gNymKeJO8QWHHgYhv+n8VStdOTsHEDoM11VI1MJ03eeDnMOlbizz6HT
         2MGfFynDV7RRXGRsS8wwTNB1PC4DgEpVbNwb0tbotH/CqRr8YoD0oMejvONWGneuHsND
         3EKHMfPuCRlZEUpKh09c66QN0Ez+rG2LA9l99fkSb71occC7TvGKKnXY7vR5D0GEcC8V
         r/lkg26mAkaCHGYEtihJNRIFhbK+H5XpM+3qq8IFcIc4gnp6N5YNcq4QdLEa0aD5jzBW
         4Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396853; x=1760001653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHfu5RK9fQGyEY9zqStxoL5d61OtEaZHSUCnCxJYEKc=;
        b=X8r61FyuIMplqLbH00JVxX5pp66TnEadxyNJVt+bndRq5wa56GWwJhvka3LWqGobAg
         aQdJPcpiG75dxzWAgmWqiTECltcwZmcguyDoBP1VctgdyB5Eq2A4fUVI+4wv0aR9WA/z
         rRPJ805/knuz1Edx0YDbacp72jNBmS+Fvg4OBQEl4D+Qt3RS/Nw/YM+iYUum0eKBbaUV
         MMOIiREa8rggmPDmMEE9fWq0/gn4f6RKbX+dTMWItkSdb31noiFyodK0gpuNDeBLrxlQ
         BubwQWnqJyhUqBPTpaPWzeATOtvV9S4YoWb4NPRdg3bDg4e/EfkJsLP0QoVnhf4AZhWl
         THog==
X-Gm-Message-State: AOJu0Yyd82dTd1mogt4hQyV0YIo6zzjhO247WqZdFiuseht9pQ4ox3YG
	y0DKCOgDqxwSdLeKdnrBpSd/lPcV4+XwlVWU46uCac310gsl/yFf6rp4
X-Gm-Gg: ASbGncuN03Fl2UdbaLFnxySbgr9vuW1wwEktnPcJW5KMpRcBUht3mLL5i6Z2060o1rC
	S45V6QY2YfbnEE+UsvuZ6eujovOuo1rowrjBGCwvEzYyaKHgajbhJp5NeY8sudcB0beMAeHuO1O
	v/5gJXr4Bqg5T241fDHGi9umM5xh9BbqL/cx+oKy0HhxWxD4TKYZUhFt4vJH71G3I5jfN+TtrGx
	FrFRtd5DKqipxpF6omBPEZe1budDJQs52oX1+7GJ43bX2SCCEwn8Y5qMvQDPXXkPnuOdPqx2Llo
	RHR6kDMooSjWzPy9wbJJQnUf9nRlVaT3eH1dM9epcfbJSEghYGinSYc8lf9ejhUGN2WHd+stOO5
	5f41ZNgerFf+1t84i8TKAEcBBy92m7RypELjlUIGg3gNURE+4QvLI8+3z7Nw2jVntRDBihivH6g
	bG9w==
X-Google-Smtp-Source: AGHT+IFkONef/rZOKOk6Mje4y7O1d1mlzwQUZBSyzSJ8QHOTcSGWZboeZ8AOKGCK94Xr9UXqV/EBlA==
X-Received: by 2002:a05:6000:616:b0:3ea:2ed6:9e37 with SMTP id ffacd0b85a97d-425577f34fbmr4559851f8f.24.1759396852624;
        Thu, 02 Oct 2025 02:20:52 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a029a0sm72742225e9.13.2025.10.02.02.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:20:52 -0700 (PDT)
Date: Thu, 2 Oct 2025 09:27:13 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v5 bpf-next 10/15] bpf, x86: add support for indirect
 jumps
Message-ID: <aN5FcYKFLMV44igw@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
 <20250930125111.1269861-11-a.s.protopopov@gmail.com>
 <8143e0481d68bb1793464c2d796fce7602695076.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8143e0481d68bb1793464c2d796fce7602695076.camel@gmail.com>

On 25/10/01 05:15PM, Eduard Zingerman wrote:
> On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
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
> >     7:   gotox r1                   # jit will generate proper code
> > 
> > Here the gotox instruction corresponds to one particular map. This is
> > possible however to have a gotox instruction which can be loaded from
> > different maps, e.g.
> > 
> >     0:   r1 &= 0x1
> >     1:   r2 <<= 0x3
> >     2:   r3 = 0x0 ll                # load from map M_1
> >     4:   r3 += r2
> >     5:   if r1 == 0x0 goto +0x4
> >     6:   r1 <<= 0x3
> >     7:   r3 = 0x0 ll                # load from map M_2
> >     9:   r3 += r1
> >     A:   r1 = *(u64 *)(r3 + 0x0)
> >     B:   gotox r1                   # jump to target loaded from M_1 or M_2
> > 
> > During check_cfg stage the verifier will collect all the maps which
> > point to inside the subprog being verified. When building the config,
> > the high 16 bytes of the insn_state are used, so this patch
> > (theoretically) supports jump tables of up to 2^16 slots.
> > 
> > During the later stage, in check_indirect_jump, it is checked that
> > the register Rx was loaded from a particular instruction array.
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> 
> [...]
> 
> > @@ -571,6 +572,9 @@ struct bpf_insn_aux_data {
> >  	u8 fastcall_spills_num:3;
> >  	u8 arg_prog:4;
> >  
> > +	/* true if jt->off was allocated */
> > +	bool jt_allocated;
> > +
> 
> This is a leftover from v3, no longer used.

Thanks.

> >  	/* below fields are initialized once */
> >  	unsigned int orig_idx; /* original instruction index */
> >  	bool jmp_point;
> > @@ -840,6 +844,8 @@ struct bpf_verifier_env {
> >  	struct bpf_scc_info **scc_info;
> >  	u32 scc_cnt;
> >  	struct bpf_iarray *succ;
> > +	u32 *gotox_tmp_buf;
> > +	size_t gotox_tmp_buf_size;
> >  };
> 
> [...]
> 
> > @@ -14685,6 +14723,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
> >  				dst);
> >  			return -EACCES;
> >  		}
> > +		if (ptr_to_insn_array) {
> > +			verbose(env, "R%d subtraction from pointer to instruction prohibited\n",
> > +				dst);
> > +			return -EACCES;
> > +		}
> 
> Is anything going to break if subtraction is allowed?
> The bounds are still maintained, so seem to be ok.

Ok, I just haven't seen any reason to add because such code
is not generated on practice. I will add in the next version.

> >  		if (known && (ptr_reg->off - smin_val ==
> >  			      (s64)(s32)(ptr_reg->off - smin_val))) {
> >  			/* pointer -= K.  Subtract it from fixed offset */
> 
> [...]
> 
> > @@ -17786,6 +17830,210 @@ static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
> >  	return new;
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
> 
> push_insn() checks if `t` is in range [0, env->prog->len],
> is the same check needed here?

You wanted to say `w`? (I think `t` is guaranteed to be a valid one.)
In cas of push_gotox_edge `w` is taken from a jump table which is
guaranteed to have only correct instructions.

> > +	for (prev = GET_HIGH(insn_state[t]); prev < jt->off_cnt; prev++) {
> > +		w = jt->off[prev];
> > +		mark_jmp_point(env, w);
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
> > +	if (env->cfg.cur_stack >= env->prog->len)
> > +		return -E2BIG;
> > +	insn_stack[env->cfg.cur_stack++] = w;
> 
> I think `insn_state[w] |= DISCOVERED;` is missing here.

Hmm, yes, thanks.

> > +
> > +	SET_HIGH(insn_state[t], prev + 1);
> > +	return KEEP_EXPLORING;
> > +}
> 
> [...]
> 
> > +static struct bpf_iarray *
> > +create_jt(int t, struct bpf_verifier_env *env, int fd)
> > +{
> > +	static struct bpf_subprog_info *subprog;
> > +	int subprog_idx, subprog_start, subprog_end;
> > +	struct bpf_iarray *jt;
> > +	int i;
> > +
> > +	if (env->subprog_cnt == 0)
> > +		return ERR_PTR(-EFAULT);
> > +
> > +	subprog_idx = bpf_find_containing_subprog_idx(env, t);
> > +	if (subprog_idx < 0) {
> > +		verbose(env, "can't find subprog containing instruction %d\n", t);
> > +		return ERR_PTR(-EFAULT);
> > +	}
> 
> Nit: There is now verifier_bug() for such cases.
>      Also, it seems that all bpf_find_containing_subprog() users
>      assume that the function can't fail.
>      Like in this case, there is already access `jt = env->insn_aux_data[t].jt;`
>      in visit_gotox_insn() that will be an error if `t` is bogus.

Could you please explain this once again? The error from
bpf_find_containing_subprog* funcs is checked in this code.

> > +	subprog = &env->subprog_info[subprog_idx];
> > +	subprog_start = subprog->start;
> > +	subprog_end = (subprog + 1)->start;
> > +	jt = jt_from_subprog(env, subprog_start, subprog_end);
> > +	if (IS_ERR(jt))
> > +		return jt;
> > +
> > +	/* Check that the every element of the jump table fits within the given subprogram */
> > +	for (i = 0; i < jt->off_cnt; i++) {
> > +		if (jt->off[i] < subprog_start || jt->off[i] >= subprog_end) {
> > +			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]",
> > +					t, subprog_start, subprog_end);
> > +			return ERR_PTR(-EINVAL);
> > +		}
> > +	}
> > +
> > +	return jt;
> > +}
> > +
> > +/* "conditional jump with N edges" */
> > +static int visit_gotox_insn(int t, struct bpf_verifier_env *env, int fd)
> > +{
> > +	struct bpf_iarray *jt;
> > +
> > +	jt = env->insn_aux_data[t].jt;
> > +	if (!jt) {
> > +		jt = create_jt(t, env, fd);
> > +		if (IS_ERR(jt))
> > +			return PTR_ERR(jt);
> > +	}
> > +	env->insn_aux_data[t].jt = jt;
> 
> Nit: move this assignment up into the `if (!jt)` body?

Sure, thanks

> > +
> > +	mark_prune_point(env, t);
> > +	return push_gotox_edge(t, env, jt);
> > +}
> > +
> 
> I think the following implementation should achieve the same result:
> 
>   /* "conditional jump with N edges" */
>   static int visit_gotox_insn(int t, struct bpf_verifier_env *env, int fd)
>   {
>         int *insn_stack = env->cfg.insn_stack;
>         int *insn_state = env->cfg.insn_state;
>         bool keep_exploring = false;
>         struct bpf_iarray *jt;
>         int i, w;
> 
>         jt = env->insn_aux_data[t].jt;
>         if (!jt) {
>                 jt = create_jt(t, env, fd);
>                 if (IS_ERR(ptr: jt))

(BTW, out of curiosity, do these "ptr: jt" type hints and alike
come from your environment? What is it, if this is not a secret?)

>                         return PTR_ERR(ptr: jt);
> 
>                 env->insn_aux_data[t].jt = jt;
>         }
> 
>         mark_prune_point(env, idx: t);
>         for (i = 0; i < jt->off_cnt; i++) {
>                 w = jt->off[i];
>                 mark_jmp_point(env, idx: w);
> 
>                 /* EXPLORED || DISCOVERED */
>                 if (insn_state[w])
>                         continue;
> 
>                 if (env->cfg.cur_stack >= env->prog->len)
>                         return -E2BIG;
> 
>                 insn_stack[env->cfg.cur_stack++] = w;
>                 insn_state[w] |= DISCOVERED;
>                 keep_exploring = true;
>         }
> 
>         return keep_exploring ? KEEP_EXPLORING : DONE_EXPLORING;
>   }
> 
> But w/o GET_HIGH/SET_HIGH things. Wdyt?

Awesome, thanks, this should work!

> 
> [...]
> 
> > @@ -19817,6 +20068,103 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
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
> > +	const u32 size = 8;
> > +
> > +	if (check_add_overflow(reg->umin_value, reg->off, &min_index) ||
> > +		(min_index > (u64) U32_MAX * size)) {
> > +		verbose(env, "the sum of R%u umin_value %llu and off %u is too big\n",
> > +			     regno, reg->umin_value, reg->off);
> > +		return -ERANGE;
> > +	}
> > +	if (check_add_overflow(reg->umax_value, reg->off, &max_index) ||
> > +		(max_index > (u64) U32_MAX * size)) {
> > +		verbose(env, "the sum of R%u umax_value %llu and off %u is too big\n",
> > +			     regno, reg->umax_value, reg->off);
> > +		return -ERANGE;
> > +	}
> > +
> > +	min_index /= size;
> > +	max_index /= size;
> > +
> > +	if (min_index >= map->max_entries || max_index >= map->max_entries) {
> 
> Nit: it is guaranteed that reg->umin_value <= reg->umax_value,
>      so checking max_index should be sufficient.

Ok, thanks, removed.

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
> > +	size_t new_size;
> > +	u32 *new_buf;
> > +	int err = 0;
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
> 
> Are you sure this is a verifier bug?
> The program can be written in a way, such that e.g. hash map pointer
> is passed as a parameter for gotox, that would be an incorrect program,
> not a verifier bug.

Yeah, sure, thanks.

> > +
> > +	err = indirect_jump_min_max_index(env, insn->dst_reg, map, &min_index, &max_index);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Ensure that the buffer is large enough */
> > +	new_size = sizeof(u32) * (max_index - min_index + 1);
> > +	if (env->gotox_tmp_buf_size < new_size) {
> > +		new_buf = kvrealloc(env->gotox_tmp_buf, new_size, GFP_KERNEL_ACCOUNT);
> > +		if (!new_buf)
> > +			return -ENOMEM;
> > +		env->gotox_tmp_buf = new_buf;
> > +		env->gotox_tmp_buf_size = new_size;
> 
> Can gotox_tmp_buf be an bpf_iarray instance?
> If it can, iarray_realloc() can be reused here.

Ah, nice, will use it :)

> > +	}
> > +
> > +	n = copy_insn_array_uniq(map, min_index, max_index, env->gotox_tmp_buf);
> 
> I still think this might be a problem for big jump tables if gotox is
> in a loop body. Can you check a perf report for such scenario?
> E.g. 256 entries in the jump table, some duplicates, dispatched in a loop.

Well, for "big jump tables" I want to follow up with some changes in any case,
just didn't get there with this patchset yet. Namely, the `insn_inxed \mapto
jump table map` must be optimized, otherwise the JIT spends too much time on
this. So, this would require bin/serach or better a hash to optimize this. In
the latter case, this piece might also be optimized by caching a lookup
(by the "map[start,end]" key).

> > +	if (n < 0)
> > +		return n;
> > +	if (n == 0) {
> > +		verbose(env, "register R%d doesn't point to any offset in map id=%d\n",
> > +			     insn->dst_reg, map->id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0; i < n - 1; i++) {
> > +		other_branch = push_stack(env, env->gotox_tmp_buf[i],
> > +					  env->insn_idx, env->cur_state->speculative);
> > +		if (IS_ERR(other_branch))
> > +			return PTR_ERR(other_branch);
> > +	}
> > +	env->insn_idx = env->gotox_tmp_buf[n-1];
> > +	return 0;
> > +}
> > +
> >  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
> >  {
> >  	int err;
> 
> [...]

