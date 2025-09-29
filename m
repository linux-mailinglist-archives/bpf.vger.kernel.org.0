Return-Path: <bpf+bounces-69950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F693BA9788
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F230416BA52
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35AC3090C7;
	Mon, 29 Sep 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8JBNydh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B3D305047
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154677; cv=none; b=H8uZb+vD2T/1/pJUdCMDwLwM+7Pe2spJp3LVjWNRS8QNuMoCMNFx9oFrXSHD2yszPYjQGZTExQroe2h+XUac9AaOb9jREiWqztBiYG7QOW3jOI/VfZ7ZliryTRINGg0KzZZRLBXHe15zSsI+4UAQMdFFqNg7I8oQtBoV9vzkAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154677; c=relaxed/simple;
	bh=q7QZ+ux1hba8E322s3R6UiMSnDM0HL6YqJllvq3KdEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcNvQJvTqYfdWuuC9/o7d7wtqet9mcmddAFPahkmSb/VhNDuXt0ztOpk0C6gGNgiUmK02q0i9sXREpSEIbBTNGMSKLDs5fwJI4r4nhOr4ulp9+jJFVPSxL3EzJZzO/Fs7BwOI0oOtEt82I90GejccRIHx9hOFkSfJC789krhw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8JBNydh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3fa528f127fso3678508f8f.1
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759154674; x=1759759474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yx9iYHLPIpijioU+0LGx/gFN0laWjRGLsA7AjYMe090=;
        b=Q8JBNydhiGEqblfYL0bjjYs1S1DBGRsjd6ri/cfmIM+Ai2x//eLll3DAK/PmmcBWlN
         c98EqMoChSk9BxfPaXC3jSipEDz6cThqQDNM3zL61nzXQuZoyi+w3BHdsAgea00/7bex
         BJvFf1yVQnaLJe1K6aZ061ThcJp2qsMkT3Tn825jfu+WhaVBLEyCB3rcyafv68FePHUy
         2SjHO/kA6NpFpkAI72ZT0zopFAPozigIH9RlAVaoqjKJHumhTYogfldlpOBiznuqGsUa
         t7NDn2/nqb7CYHPZAvQ/GcAikRcD3hYOgl3lRoyaWkAvjIQKx+xZyd7zswIY3Vbq72cZ
         N4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154674; x=1759759474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx9iYHLPIpijioU+0LGx/gFN0laWjRGLsA7AjYMe090=;
        b=bh1d8qFQu+0ihG4XRhwhNuOjgDH3Nv855i8ZMak9OpjQNH0CWVHUHrDMm9SSe7jiIS
         6xvZcIfSwU24faSAYyw02AqN6PIl4+t/ZNwwon+f2T487nSkj8qMwnmUQ5PV5m6awctQ
         upNsVSxkEyE6ihxPH6FS4whWYG0YqeQXrKuKCuSPfxtX/+UsYYPcGYPwX2+iinPe7BSk
         JbshX9Yexq4Ee82qslovBvZZDdSE8faOJGHEjJSmnVecXGb2+JglvBY2FRbthISpQPLr
         QcEaNhx676xAFkM0SNECSkLN48l6wQba4Qtx7lY+2X8F15vwqkkkkM3aICj4dfuuHEs+
         4ymw==
X-Gm-Message-State: AOJu0Yx5zL6SMCn/NuwrVdaLgVcR9cnhTsuEErB6WTaDE3bcuQtmLGWp
	WifPAORjb0+VGknBxhfpI1XiZhIBW9PkFI8R9tndH7IDbxz2/tcjQLf6
X-Gm-Gg: ASbGncuhehN4oe3OR1A0h9qU2CxEijDaGpgi7d+0jJ0WoYVWPSJ08Vx/PNmz99PoxL3
	nU8JhaLoG27u1802LQv4AwpR0gbyj0ls/UOiiFn5lB4hZaPt5ZdJcAZvaIPTVEe05j4Y0HlHIJz
	OHzecRp7139eGS3iXu9Dw3/Nt+UbyRj23avjBltV4fnm1Bezr8HfU3RiTrWfq/Ezs4Tjh8SPDKY
	5GTfn4+QhXlf2/lr/wdZYJabexRHstLpWHVQ8TUTPyHiSvIAUXWMcRklFDc6P6q5pwgcDZkbFXv
	Ga7zsrG2YzoOKUjZa7q2teW7+dHQc3PcXx8XiTTaCiJNxhLjwOvoGZXPfsH5mEaR+VKUaLkX9yP
	LGff9G047jy9KRQZc4w4q6lcCmhLB9juc
X-Google-Smtp-Source: AGHT+IEdn67A/3CqJNQZtxZRM2rVCDT3GZj/gNDtHX5126aj+Pn9ZkMyZ8hNqYMONtRgSsKoJSEGaA==
X-Received: by 2002:a5d:5f83:0:b0:3ea:fb3d:c4d1 with SMTP id ffacd0b85a97d-4241111f6d1mr749364f8f.18.1759154673704;
        Mon, 29 Sep 2025 07:04:33 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc6cf3835sm18608221f8f.46.2025.09.29.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:04:33 -0700 (PDT)
Date: Mon, 29 Sep 2025 14:10:16 +0000
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
Message-ID: <aNqTSJFlZUogqP28@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <20250918093850.455051-9-a.s.protopopov@gmail.com>
 <61861bfd86d150b86c674ef7bea2b23e3482e1f2.camel@gmail.com>
 <aNWE3x7SwgyTglAN@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNWE3x7SwgyTglAN@mail.gmail.com>

On 25/09/25 06:07PM, Anton Protopopov wrote:
> On 25/09/19 05:28PM, Eduard Zingerman wrote:
> > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> [...]
> > > +static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
> > > +{
> > > +	struct bpf_verifier_state *other_branch;
> > > +	struct bpf_reg_state *dst_reg;
> > > +	struct bpf_map *map;
> > > +	u32 min_index, max_index;
> > > +	int err = 0;
> > > +	u32 *xoff;
> > > +	int n;
> > > +	int i;
> > > +
> > > +	dst_reg = reg_state(env, insn->dst_reg);
> > > +	if (dst_reg->type != PTR_TO_INSN) {
> > > +		verbose(env, "R%d has type %d, expected PTR_TO_INSN\n",
> > > +			     insn->dst_reg, dst_reg->type);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	map = dst_reg->map_ptr;
> > > +	if (verifier_bug_if(!map, env, "R%d has an empty map pointer", insn->dst_reg))
> > > +		return -EFAULT;
> > > +
> > > +	if (verifier_bug_if(map->map_type != BPF_MAP_TYPE_INSN_ARRAY, env,
> > > +			    "R%d has incorrect map type %d", insn->dst_reg, map->map_type))
> > > +		return -EFAULT;
> > > +
> > > +	err = indirect_jump_min_max_index(env, insn->dst_reg, map, &min_index, &max_index);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	xoff = kvcalloc(max_index - min_index + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
> > > +	if (!xoff)
> > > +		return -ENOMEM;
> > 
> > Let's keep a buffer for this allocation in `env` and realloc it when needed.
> > Would be good to avoid allocating memory each time this gotox is visited.
> 
> Ok (to put it in bpf_subprog_info as suggested in your next letter).
> Though, probably it still needs to grow (= realloc).

On a second thought, this doesn't work in general case: hard to avoid
copying/sorting. Every other request wants to do sort(M[start, end]).
All three things are vaiables: M, start, end. For now I will just add
a buffer to avoid allocations.

> [...]

