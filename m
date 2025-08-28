Return-Path: <bpf+bounces-66832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BE6B3A14D
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0160B610C8
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B84931579F;
	Thu, 28 Aug 2025 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvD1Tu/9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023E314B9C
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756390154; cv=none; b=aj/Oqwg8QOMnRcLis6J/KucSn2p54bPbfe35fzFRgHzP6CqjU5g7Bw+Fzk29qaI6VJGROrA/6AME9dufORQyjNRtCJlL/AKNEAfFNTEotN1q3ttDTPHY1f7TXRtWl+l4BYuYxC5fCnmelj9aLPF3NSx/jEu5hC91/RXXeodH4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756390154; c=relaxed/simple;
	bh=x4sRVrOwsPozk+TvMqw1fQ9o/sScBFDYlqWZEbKnVns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTV7QWouJTSS/FPGsY8mPcO4OOADodVlqTZ/EpxX+j7LPpXJ+TnYe/FVKhr4+TJ4gfdcgM0annt0OlVgZOdEln+2cCU/L7/volo2IwNKbU96Zf0/FY+qsqm+vB8qlrUlPPbvvMapO3Qx84Z1nu0UxQUHzx3iEeeX3cMxMcivCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvD1Tu/9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso6204255e9.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756390151; x=1756994951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iT4QPOld809hb0t/4oWA/iavLlodldhi7NcBfjirSPc=;
        b=WvD1Tu/9XhCsLmmk8VN4Mh2UNlniALpvZ5Ep5oepnejsSBfquSKDMwg/1REuBKrzFA
         50wxIwtFGnqRVy2OAJDoEJVMvLDVlzzBvIioT8xxRqx5Gm0GPks+iklxvrGGAjZvwagJ
         KT4UA0FHyXgtmLFYL7Z3d/P/phkuuXwH48irkkKDImCyI6Nd79Fu+DwTQMzRYumyMz7o
         rSd5eITEovKbQGrCPs7sqGquTXrdTEP5oTqhvEZhXoIsLLZdZZK+XPHLCt31duCGhHtL
         d8rT/fW1O7vEI2qjZ5BlK+4aS5KrGNzon+fdghCkYCdDUkCNs4zsugD2SetOAAMuO/8T
         1IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756390151; x=1756994951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT4QPOld809hb0t/4oWA/iavLlodldhi7NcBfjirSPc=;
        b=gKGwJJchb1GsWM9mF5L3Ms74PCBqYopom1zdQCYpR8YOxTYGk2hzl2JQ0qIRLzTvIk
         wIpyy31WVinU5lCTYtyNazsOhxStSBaa6EbIOjCa0MojBK9NBG2NxqpVhG6rBweDVvni
         6cp+XwBvinxX0DAIrs12h/Bu3UF0HsxeXnLPmmk8tqpltY+3cmUhWZXgBbU3ZnqOrGiM
         LjGTymOiU5ebVucNrimSkLh8EYpFuLJUaN22hRSnpeYc5r8SH51Qy1zewKtdz+hhqLAO
         lRoCorBy2J19bIYPP4R5uIcf9vu1Kv0fVRGZoQmvPmjXINUdr4nYtePGHQhPD9Lee2s9
         F6rQ==
X-Gm-Message-State: AOJu0Ywg/9pxmdYJYtHjQ0D6ALVuUv+To76C/l80YjqahtMcdbn38UDo
	NsHekxKIikxCrVBmeYu6ry162+RyPuPtSU533rl6Qu6ETYGdpSbHqPGq
X-Gm-Gg: ASbGnctoUgaqi979/owDuNFlY1wm5wCoOEjDGFUq7QZ//VQMk7GsvOSxRJuc+mMyPv7
	9nR96a0NJEmUMX+8e/nfeubbq54xJHOXl2wtEz+H1WMxGAGoZtZNlE36tabVKsVOT32qruN22km
	g1mPw9fHaWvOrZ8syed2SZ2DXtNdrFqdAfVJhDR0B+UW8762UVeog5xMJ3Ay0HgbqmOXrAqSPGs
	pgaAxd/KcEusA8rIei3X/m6sZtMaaXXz14pGX2963ueUi8SCQnp8+ejWHXhUKy11U2NcE9TwLQo
	4PCd2olAMXIeZVbQ7v2GpTc5HgS6xAXFxbcmzrAzOtnHCbHndqbZ43r53TmK7FLkvpJn/gzmUKX
	HhH62VVLTp0FBWUwgfRDkYyKnjig8QxEeWZazzJ14YBZd
X-Google-Smtp-Source: AGHT+IGsMw8/+D/3e3qOxp91MFgPTnOCOPsojBaCG/JH1j6HtAbR33bnerE3irOdEw2n5IOAVrCx6g==
X-Received: by 2002:a05:600c:154d:b0:459:d780:3602 with SMTP id 5b1f17b1804b1-45b517d4185mr197599115e9.23.1756390150884;
        Thu, 28 Aug 2025 07:09:10 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc50050c4esm8384520f8f.25.2025.08.28.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 07:09:10 -0700 (PDT)
Date: Thu, 28 Aug 2025 14:15:11 +0000
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
Message-ID: <aLBkbzahReym9UXm@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
 <20250816180631.952085-9-a.s.protopopov@gmail.com>
 <506e9593cf15c388ddfd4feaf89053c1e469b078.camel@gmail.com>
 <aLAoUK22+PpuAbhy@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLAoUK22+PpuAbhy@mail.gmail.com>

On 25/08/28 09:58AM, Anton Protopopov wrote:
> On 25/08/25 04:15PM, Eduard Zingerman wrote:
> > On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:
> > 
> 

[...]

> > >  
> > > -static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
> > > +static int insn_successors_regular(struct bpf_prog *prog, u32 insn_idx, u32 *succ)
> > >  {
> > > -	struct bpf_insn *insn = &prog->insnsi[idx];
> > > +	struct bpf_insn *insn = &prog->insnsi[insn_idx];
> > >  	int i = 0, insn_sz;
> > >  	u32 dst;
> > >  
> > >  	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
> > > -	if (can_fallthrough(insn) && idx + 1 < prog->len)
> > > -		succ[i++] = idx + insn_sz;
> > > +	if (can_fallthrough(insn) && insn_idx + 1 < prog->len)
> > > +		succ[i++] = insn_idx + insn_sz;
> > >  
> > >  	if (can_jump(insn)) {
> > > -		dst = idx + jmp_offset(insn) + 1;
> > > +		dst = insn_idx + jmp_offset(insn) + 1;
> > >  		if (i == 0 || succ[0] != dst)
> > >  			succ[i++] = dst;
> > >  	}
> > > @@ -24194,6 +24605,36 @@ static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
> > >  	return i;
> > >  }
> > >  
> > > +static int insn_successors_gotox(struct bpf_verifier_env *env,
> > > +				 struct bpf_prog *prog,
> > > +				 u32 insn_idx, u32 **succ)
> > > +{
> > > +	struct jt *jt = &env->insn_aux_data[insn_idx].jt;
> > > +
> > > +	if (WARN_ON_ONCE(!jt->off || !jt->off_cnt))
> > > +		return -EFAULT;
> > > +
> > > +	*succ = jt->off;
> > > +	return jt->off_cnt;
> > > +}
> > > +
> > > +/*
> > > + * Fill in *succ[0],...,*succ[n-1] with successors. The default *succ
> > > + * pointer (of size 2) may be replaced with a custom one if more
> > > + * elements are required (i.e., an indirect jump).
> > > + */
> > > +static int insn_successors(struct bpf_verifier_env *env,
> > > +			   struct bpf_prog *prog,
> > > +			   u32 insn_idx, u32 **succ)
> > > +{
> > > +	struct bpf_insn *insn = &prog->insnsi[insn_idx];
> > > +
> > > +	if (unlikely(insn_is_gotox(insn)))
> > > +		return insn_successors_gotox(env, prog, insn_idx, succ);
> > > +
> > > +	return insn_successors_regular(prog, insn_idx, *succ);
> > > +}
> > > +
> > 
> > The `prog` parameter can be dropped, as it is accessible from `env`.
> > I don't like the `u32 **succ` part of this interface.
> > What about one of the following alternatives:
> > 
> > - u32 *insn_successors(struct bpf_verifier_env *env, u32 insn_idx)
> >   and `u32 succ_buf[2]` added to bpf_verifier_env?
> 
> I like this variant of yours more than the second one.
> 
> Small corrections that this would be
> 
>     u32 *insn_successors(struct bpf_verifier_env *env, u32 insn_idx, int *succ_num)
> 
> to return the number of instructions.
> 
> > - int insn_successor(struct bpf_verifier_env *env, u32 insn_idx, u32 succ_num):
> > 	bool fallthrough = can_fallthrough(insn);
> > 	bool jump = can_jump(insn);
> > 	if (succ_num == 0) {
> > 		if (fallthrough)
> > 			return <next insn>
> > 		if (jump)
> > 			return <jump tgt>
> > 	} else if (succ_num == 1) {
> > 		if (fallthrough && jump)
> > 			return <jmp tgt>
> > 	} else if (is_gotox) {
> > 		return <lookup>
> > 	}
> > 	return -1;
> >   
> > ?

So, insn_successors() actually returns two values: a pointer and a
number elements. This is the same value as "struct bpf_jt" (struct jt
in the sent patch). Wdyt about 

     struct bpf_jt *insn_successors(struct bpf_verifier_env *env, u32 insn_idx)

? (Maybe bpf_jt is not right name here, "insn_array" is already used
in the map, maybe smth with "successors"?)

