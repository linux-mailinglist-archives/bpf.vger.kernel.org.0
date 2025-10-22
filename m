Return-Path: <bpf+bounces-71672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3695EBFA49C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45043481676
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 06:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C2B2EE60B;
	Wed, 22 Oct 2025 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8TBj/5z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11F62EFD9E
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115495; cv=none; b=pcdlQqMmhOuc2AFHYSo4XXVlLDW4ZxosxHlYE2UbXQnR3SbaITeiKvRHwJcygnEew2Z38qWwaJPgaVOzJKw7GYltUwA71459GRXWizBcy7ZtoiHnSbr1Ijf7eY5g/na8HN4F/zA19LtrrNyfaxGSosRu3H7Lua6Z/fN8loYoFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115495; c=relaxed/simple;
	bh=rXJwZo/sEsZnLWIaanrdMrDp6qXD1VbRpS6y/7uiAVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjE/MwG0dpGIMkedW/1l/2Y36LvvA97EEhlSmT6lvurbpoP4dB7eYxtjhBynFmuFzQHv9/P0I+qruPfpG4OMkQ/vQIVyM9zp4AdJoNdDn/CgnO9hAuHVC85kriuuuxmOjJ74UQPSI8FGYCy+vy5IPQQi05Z4D0nIPr4rHSMeqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8TBj/5z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47118259fd8so40000535e9.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761115492; x=1761720292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fDC7fBGVjICr0dHegQoMCTHDX7ueu7LgShVSHZLYb18=;
        b=c8TBj/5zZXp4sfExJvkl7lWJjwX+lWwLVNK0vMEW9h81XJl1dW33QJ3C7aHqGnRm+M
         LVLLB4FEqwhZzOcDtDe6bQonZrscio/QXFgw1dqrK75RfUFEEl0APjy78o2nSjtTsKlW
         vuVizTFIj+NbLJqO5aUPFIpk8blN5eYotiEmS9JesieJ2CLRUVwSdO0LgMdGWT6TkXDX
         EbkOlKrndthbK1DdpEIsTFb7e3MBjnJQuslLc1gYu3TiGtRq5sOmXYGNXHv+uTxVArHH
         gKmbOX6/Vee4zI47hT93IbfKIGZq64gaisRNg1zHyl6l2WpjEJ3G0+VMB8i5ihdNZ7oh
         2B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115492; x=1761720292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDC7fBGVjICr0dHegQoMCTHDX7ueu7LgShVSHZLYb18=;
        b=PWEVBFpyTWyrKgT+MO4FpQ3QozH5EggsX7ONSAcx1qlg/5XLmmTZXQNrEkXODAHrps
         avekzREfS+zgcESEu61DYZtvRK/3vChb8fA+EXXiWHFx3f3xSJTBAmJLqZpHGpxiS2ia
         5Mib16kVa7VIQ/iCnfzqFb1kZ+3zmDevfCFwc11h7e8I/cs0fI55smfYVddmQkTQFLEn
         oKZTh4zwWeWs37w0Zu0yu7z6FbbyZ89VCvXCdW6+eyN0O/kRgFS4SgfUoV+sn9tZxW3a
         /qp0rG0uJjA5YM8KAJ86Vo0LwV4eU9Yi0gx7BUZ90/FLqF797bWJjf5X4Ovm7H/NNhES
         Rzkg==
X-Gm-Message-State: AOJu0YxiutNikLdXqfG97tWAkebfPh0FKfPYYtLXiIjzgoL3lCmXU6AA
	xNYVYi93OetUIaohAjrh4GHn7k/PJORfOo82WCOyK2vekEVNs9q68vd7
X-Gm-Gg: ASbGncs7X+Imzs0xANg+Wi8PoUhJEk5cBCugDV5G8W+2a1fssdYKJX69wPSLw+iTIxL
	2SqwE4krCIsfENV7BCiWpuq2zpjPxie97+3hd6EWS79KEgEEfzCpfEtUVJky4N2/8zgfkzgFqqT
	IKwm/JthhuxpagxszPSfPwJ5tWoQZwZXRHpBBdEwzpUzLbwTypjDy3ypvvB+St2n5Fcq4XIWxyk
	bH9QX+CpNfhy8OHJirBQ5AwwjQL5qwKoL+Cv24THkyWBQmtvkL7U4pOUAYEkqgCVMXzKfOn5jxK
	ondnW31ni7odj/+5AhT8YNOaQuxwnwbQo608DCaQHQoKZ9+i9fjITYm6mmXCqSBHD5bFbahZ+HA
	Iv/faCMC8Dzw1U8+Zc04XsCXy2hwlNCG0WBIqewlWKklRK4am4aBFCw/2nRFrCHKNfDOZz4yQSh
	omKk1MaA66sw==
X-Google-Smtp-Source: AGHT+IH0oXvLO7XYFiKAKMij5W3FVfmeEt3ZsND4UyuPJ7Vo2VADNDg6hlrOCZ9UG6+DkA8kumP6cQ==
X-Received: by 2002:a05:600c:1e1f:b0:471:d2f:799a with SMTP id 5b1f17b1804b1-47117877791mr130890115e9.16.1761115492033;
        Tue, 21 Oct 2025 23:44:52 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm28670895e9.3.2025.10.21.23.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:44:51 -0700 (PDT)
Date: Wed, 22 Oct 2025 06:51:32 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 10/17] bpf, x86: add support for indirect
 jumps
Message-ID: <aPh+9Lw+vmD1nXqY@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-11-a.s.protopopov@gmail.com>
 <c3de352f15a5004c48f4b37bfb4294f6602ec644.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3de352f15a5004c48f4b37bfb4294f6602ec644.camel@gmail.com>

On 25/10/21 02:17PM, Eduard Zingerman wrote:
> On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
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
> LGTM, please, address a few remaining points.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index ae017c032944..d2df21fde118 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [...]
> 
> > +static struct bpf_iarray *
> > +create_jt(int t, struct bpf_verifier_env *env, int fd)
>   		    	   		    	  ^^^^^^
> 				   This parameter is unused

Ah, yes, no more ->imm. Fixed.

> > +{
> > +	static struct bpf_subprog_info *subprog;
> > +	int subprog_start, subprog_end;
> > +	struct bpf_iarray *jt;
> > +	int i;
> > +
> > +	subprog = bpf_find_containing_subprog(env, t);
> > +	subprog_start = subprog->start;
> > +	subprog_end = (subprog + 1)->start;
> > +	jt = jt_from_subprog(env, subprog_start, subprog_end);
> > +	if (IS_ERR(jt))
> > +		return jt;
> > +
> > +	/* Check that the every element of the jump table fits within the given subprogram */
> > +	for (i = 0; i < jt->cnt; i++) {
> > +		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
> > +			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]",
> > +					t, subprog_start, subprog_end);
> > +			return ERR_PTR(-EINVAL);
> > +		}
> > +	}
> > +
> > +	return jt;
> > +}
> 
> [...]
> 
> > +/* gotox *dst_reg */
> > +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
> > +{
> > +	struct bpf_verifier_state *other_branch;
> > +	struct bpf_reg_state *dst_reg;
> > +	struct bpf_map *map;
> > +	u32 min_index, max_index;
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
> Nit: we discussed this in v5, let's drop the verifier_bug_if() and
>      return -EINVAL?

So, I think this is a verifier bug. We've checked above that the
register is PTR_TO_INSN, so it must have map and map type should
be BPF_MAP_TYPE_INSN_ARRAY. Now this is always true, for future
I added these warnings, just in case. Wdyt?

>      > The program can be written in a way, such that e.g. hash map
>      > pointer is passed as a parameter for gotox, that would be an
>      > incorrect program, not a verifier bug.
> 
>      Also, use reg_type_str() instead of "type %d"?

This is map type, not register? Ah, you maybe meant the first
message, I will fix it, thanks.

> > +
> > +	err = indirect_jump_min_max_index(env, insn->dst_reg, map, &min_index, &max_index);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Ensure that the buffer is large enough */
> > +	if (!env->gotox_tmp_buf || env->gotox_tmp_buf->cnt < max_index - min_index + 1) {
> > +		env->gotox_tmp_buf = iarray_realloc(env->gotox_tmp_buf,
> > +						    max_index - min_index + 1);
> > +		if (!env->gotox_tmp_buf)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	n = copy_insn_array_uniq(map, min_index, max_index, env->gotox_tmp_buf->items);
> 
> Nit: let's not forget about a follow-up to remove this allocation.

Thanks, in the list of followups.

> > +	if (n < 0)
> > +		return n;
> > +	if (n == 0) {
> > +		verbose(env, "register R%d doesn't point to any offset in map id=%d\n",
> > +			     insn->dst_reg, map->id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0; i < n - 1; i++) {
> > +		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
> > +					  env->insn_idx, env->cur_state->speculative);
> > +		if (IS_ERR(other_branch))
> > +			return PTR_ERR(other_branch);
> > +	}
> > +	env->insn_idx = env->gotox_tmp_buf->items[n-1];
> > +	return 0;
> > +}
> > +
> 
> [...]

