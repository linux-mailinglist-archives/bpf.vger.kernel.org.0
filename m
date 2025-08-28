Return-Path: <bpf+bounces-66809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13891B398D6
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBCC5E4E60
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18272EDD59;
	Thu, 28 Aug 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io76OjbD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90852E03EC
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374764; cv=none; b=h6zOzKdJ7Ia8fKGUNfpMfncG0cxOet/+gJmB6FG2BHLHDqj61NIqgd/cFl4bEV4tkIF+C0lB7NaqV6B7/leOjpwBihGzJEXILgW7VoEiAdUXBIptIS5gob/CUYliCj3Hfdhx9aHLEa1B16VoprNyPfoU3KjXzZfSiZa0uowZL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374764; c=relaxed/simple;
	bh=7nMiuWqAUHqbLI1dmSjsWGRmCcEbZBayp6UbQspiXM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtLQCRUi7YbBiBYfTd4Cqs2SGef4un1EtUbSQaeunNpA1uJigD7OnKkKWMtUELbxd2NBPTnwH3MpmdSjKvxqqNK+RpnbgSmABLGPvDvKV1EzMFOdtz7k1HmBItbtuA2veS6C6gFKBgn38mC0BLW1NaV7ZT7FkqFryownzw6vTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io76OjbD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ce47d1f1f8so278684f8f.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756374760; x=1756979560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zSu/gRLQqnanTM5ODgcoFtPmfZrkkXuli/7Kd1wOqT4=;
        b=Io76OjbDcL1uVrv49/PsdD9ShVnVFut4a8IermS7UbKocxpq4D8MP1TQ/ZN4qKVoGg
         qE/rjWT6RwzFvcpC3tfburbo5UP0THEBFFdbI8530jLBqTu/mOUkpVuHoWQXHBzpKeaU
         lTZz+RXcTC5bKW11M/zhcbQBn7EgZ/5FMCvMkzcygXbAnglSMWmCXjWthdBawvSbPCGC
         xszV4ss7A1K4atRaBcoQb7Vd7qzKXjUKKaVmYplfE7XvGxcOVppERtAkEREUq1F8XH2K
         O2cmS0Iycmo2DVH2FyCYOovdTuGWPLY+bnB3h1HKL1R6Q/X+IfkuPr9fYehNkMaz9a74
         AcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374760; x=1756979560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSu/gRLQqnanTM5ODgcoFtPmfZrkkXuli/7Kd1wOqT4=;
        b=PfOFpddhbMdOdqWOw1lJ5jIy6tcrD0nM2+6RcmmvNk0viEsCAb3sJlBMJfYjUahq4t
         xeZnH7uMYVGqlqdygZ4QAvxtiHQcHU2a9am2At0KCp08EiGMhpehmAcQWu23bwztEqh4
         /RIkbNHFjLTPTrXvaa8wppx1lmy0fMBUi3Mnl85G9DQ+aY5z6s+N2sbxIUc1nS5Nh90r
         ntWimaz1ZwUUUqwRn445LKn5sR4xS2cknA6dC6Cfh6L02enKM/ELJUWR5I9moe+QaWZB
         vmBtaWbOObF7AHwnZsGWyfqf/o9ZelWmMiaBO3Vt1cZjYcp3vJnOpJGg3gRCofl3MOd3
         f+mw==
X-Gm-Message-State: AOJu0Yw6DuaweD8e5Yeor+GPCVCgquFPwC/8INdQfyQDlLwy3O3x6AWA
	QKeatIVqv2bSUj9mdrvl33kwrlPwMfXSmXioPI1Km0pAuJ821DNWW567
X-Gm-Gg: ASbGncu6jy9ikI25Mld0atpsIks3lGy+uv9LnqAYrD6shP2lwSHTw4qM523QY5Y8keb
	a1mVgHFhU3WkaRr8UuPUL7KHmbJNyWT/mV+0jU389ETtZ/deJr7FKM0kU/c4RBOOXmJpN7sFMKY
	hM5w2MkpxSz2Zn6W00SBPygofHYzjWZa5Jx3lhg6nS4TkKZG/OcNTMpPycScv1jSDuqBK9dmYIn
	1TrzkwoLFHE+1QgqE9I4S4Z4TUOEC9s0IH/ImrcFpjP6wJclGNDuU5wLGa+0k/FYvYp892/pXyq
	mD1nO6nHgAw1z5kexdcvi5anTdYTR7d5Ps2vhftPuAaTVMFRHdhNYNHiES5Z0KSfLemV/4KpB5u
	hOTPTpuaH9hRzekvaRRHs9YMIz29iwi338g==
X-Google-Smtp-Source: AGHT+IFkgLINBvImhQFpnNfKc468iiEdyCMbtvmn48FCYeA4OdCnxBQW6QM89raGB8TdJsdi4cg8iQ==
X-Received: by 2002:a05:6000:2891:b0:3cd:8a55:f175 with SMTP id ffacd0b85a97d-3cd8a55f69cmr2418834f8f.43.1756374759600;
        Thu, 28 Aug 2025 02:52:39 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ca6240b4ecsm13815278f8f.43.2025.08.28.02.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:52:39 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:58:40 +0000
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
Message-ID: <aLAoUK22+PpuAbhy@mail.gmail.com>
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

[...] (see the previous reply)

> > +{
> > +	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY)
> > +		return map->max_entries * sizeof(long);
>   		       			  ^^^^^^^^^^^^
> 		Nit: sizeof_field(struct bpf_insn_array, ips) ?

I think sizeof(long) is ok, as this always will be a size of a
pointer.  (To use sizeof_field() the bpf_insn_array should be
shared in a header, is it worth it?)

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

yes, ok

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

For all maps except INSN_ARRAY only (map->max_entries == 1) is
allowed. This change adds an exception for INSN_ARRAY.

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

Yes, this sounds right, theoretically. I will take a look.

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

Why? 0U - 8U = 0xfffffff8U (it's not an UB because values are
unsigned).  Then it's cast to int on return which is -8.

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

This was intentional. If you have a switch or a jump table
defined in C, then corresponding jump tables belong to one function.
Also, what if you have a jt which can jump from function f() to g(),
but then g() is livepatched by another function?

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

Yes, thanks, good catch! (This code will be removed in v2, as
gotox[imm=map_fd] will be gone for now, as you've suggested.)

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

I've replaced with words, don't see other examples of unicode around
(but also can't find "don't use unicode" in coding-style.rst).

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

Yes, thanks, this would be a bug.

> > +
> > +	if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY)
> > +		return -EINVAL;
> 
> Same question here, ->type is already `PTR_TO_INSN`.

Right, thanks, I can add a bug check here. (I think this check is here
historically earlier than PTR_TO_INSN appeared.)

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

But it should be a list of unique values, how would you sort it
without allocating memory (in a reqsonable time)?

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

Yes, thanks.

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

I like this variant of yours more than the second one.

Small corrections that this would be

    u32 *insn_successors(struct bpf_verifier_env *env, u32 insn_idx, int *succ_num)

to return the number of instructions.

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

Yes, thanks for pointing to it, will do.

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

