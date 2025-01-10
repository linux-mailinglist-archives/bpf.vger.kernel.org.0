Return-Path: <bpf+bounces-48555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46679A0927C
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 14:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065CE161478
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C7820E6E9;
	Fri, 10 Jan 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZML/Y/d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7E620E010;
	Fri, 10 Jan 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516902; cv=none; b=TCbcVdkMwdyLeNEKMgiRDV0OjaZAMoYAV6tmLCZnQtt7TYKI3DJHgps4QVRlGo/I7zbwHjOystr7DHoJ9ogGHNuM0Tw2qlKl0Ak5aBHUVCJwbLYxnMdeK6YRUBGUlkpCwmiqvA4+UKGY14duEntvMI3AjxesgAxJNS/t/M069pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516902; c=relaxed/simple;
	bh=PAcVRU+Kdt4vR9+Cl2Tf2u5LOxm2wokxmSJ5H9ET5KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/aquCHhEDWQzeOCKbpojeLc8ttknIALmlnwMu/w8br/AG4GPnYlvMDpa6ioaOL07hSa2+b6WoGZaZ7UFb++1+DzMRjiM3o6L+fr6ytNzIoCPqTnbiqmfNabz/a2pOE0Ik7BYGsoHp/UqW4rYrkvxnobGHOzjbWsitslxCbRq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZML/Y/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CB4C4CED6;
	Fri, 10 Jan 2025 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736516901;
	bh=PAcVRU+Kdt4vR9+Cl2Tf2u5LOxm2wokxmSJ5H9ET5KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZML/Y/dLkDSFAlcidbpgx+4Rq/wKl79maghmi6nluI9Lp9hL3pkCT23QHD2eyGcm
	 EHvZKQihaikIzYBG2VIWbRG5le24ZnUO5mfWk6G6DmNCWT7yuxNtNeQ47OOsNzvvNe
	 tNgggdB50UkuskC7jWxTh/6VCEZhKwg29TsdDSTvLQAnvQRE37MRrJYdbOM55oNKxF
	 jyhc/Q/g56ovw94J4i9XjwqaRAzbpmtJEhZXEjJ8cfMOet4ukLvVDgfgaUpUF5huvW
	 OTZ+1Te1cZeUqvYOSbdJGY4jOQG4BQZldJipuqq2nYXD3IMs37+geQpmNYY7UDTgi+
	 MjjdA7huZgA6A==
Date: Fri, 10 Jan 2025 10:48:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, eddyz87@gmail.com, andrii@kernel.org,
	mykolal@fb.com, olsajiri@gmail.com
Subject: Re: [PATCH dwarves] btf_encoder: always initialize func_state to 0
Message-ID: <Z4ElI8tY3otAZych@x1>
References: <20250110023138.659519-1-ihor.solodrai@pm.me>
 <3f5369ba-7bbb-4816-b7d9-ab08c48870ae@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f5369ba-7bbb-4816-b7d9-ab08c48870ae@oracle.com>

On Fri, Jan 10, 2025 at 10:39:50AM +0000, Alan Maguire wrote:
> On 10/01/2025 02:31, Ihor Solodrai wrote:
> > BPF CI caught a segfault on aarch64 and s390x [1] after recent merges
> > into the master branch.
> > 
> > The segfault happened at free(func_state->annots) in
> > btf_encoder__delete_saved_funcs().
> > 
> > func_state->annots arrived there uninitialized because after patch [2]
> > in some cases func_state may be allocated with a realloc, but was not
> > zeroed out.
> > 
> > Fix this bug by always memset-ing a func_state to zero in
> > btf_encoder__alloc_func_state().
> > 
> > [1] https://github.com/kernel-patches/bpf/actions/runs/12700574327
> > [2] https://lore.kernel.org/dwarves/20250109185950.653110-11-ihor.solodrai@pm.me/
> 
> 
> Thanks for the quick fix! Reproduced this on an aarch64 system:
> 
>  BTF [M] kernel/resource_kunit.ko
> /bin/sh: line 1: 630875 Segmentation fault      (core dumped)
> LLVM_OBJCOPY="objcopy" pahole -J -j
> --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> --lang_exclude=rust --btf_base ./vmlinux kernel/kcsan/kcsan_test.ko
> make[2]: *** [scripts/Makefile.modfinal:57: kernel/kcsan/kcsan_test.ko]
> Error 139
> make[2]: *** Deleting file 'kernel/kcsan/kcsan_test.ko'
> make[2]: *** Waiting for unfinished jobs....
> /bin/sh: line 1: 630907 Segmentation fault      (core dumped)
> LLVM_OBJCOPY="objcopy" pahole -J -j
> --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
> --lang_exclude=rust --btf_base ./vmlinux kernel/torture.ko
> make[2]: *** [scripts/Makefile.modfinal:56: kernel/torture.ko] Error 139
> make[2]: *** Deleting file 'kernel/torture.ko'
> 
> ...and verified that with the fix all works well.
> 
> Nit: missing Signed-off-by

I'm adding it, ok?

- Arnaldo
 
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

Thanks!
 
> > ---
> >  btf_encoder.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 78efd70..511c1ea 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -1083,7 +1083,7 @@ static bool funcs__match(struct btf_encoder_func_state *s1,
> >  
> >  static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_encoder *encoder)
> >  {
> > -	struct btf_encoder_func_state *tmp;
> > +	struct btf_encoder_func_state *state, *tmp;
> >  
> >  	if (encoder->func_states.cnt >= encoder->func_states.cap) {
> >  
> > @@ -1100,7 +1100,10 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
> >  		encoder->func_states.array = tmp;
> >  	}
> >  
> > -	return &encoder->func_states.array[encoder->func_states.cnt++];
> > +	state = &encoder->func_states.array[encoder->func_states.cnt++];
> > +	memset(state, 0, sizeof(*state));
> > +
> > +	return state;
> >  }
> >  
> >  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)

