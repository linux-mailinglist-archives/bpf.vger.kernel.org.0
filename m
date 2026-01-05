Return-Path: <bpf+bounces-77810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39FDCF3562
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 12:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DDE5301C907
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FB72C235E;
	Mon,  5 Jan 2026 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OH/jx28S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039E2D3EC1
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613662; cv=none; b=HijNG3jUKYIPzwKYiccZfcMHXDGk/FedeMS4lh98t5ph4132KtjdV4gCQ4wxhI0d6EoHNeGiST8QYZn7cfnzlcp11ZWVKNwlOi0fAlHiBJSobeuHBIrYIcgozJkVl3S2CVjjVYHktJ76i7Fk/TKnPFXNXoaB+4pA5BFgzdDSI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613662; c=relaxed/simple;
	bh=ts3iwxZ2cAbMT/W4sDfy5XyKUhMUiEEMD/Y4uJZyk30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMaWQZe+QD6EWen+xOvu0fGI+v4Bohp3d9CebNayS+4JR4UTD7mYN5EWrVljVS2YrIjvygGyo/VX2NM5kyzQMBfSOUI4q85vMSZhu9mNaBEUcLrOagPG//8RbDuHxV9xOxf6FqecZmMGmuJ0GIpUZp4NcUMb6lpUQuuFMJMFHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OH/jx28S; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso431604a12.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 03:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767613657; x=1768218457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m17uYCatZPNweCRBX/sngXFTPvpwP0pbjoi0G6O2mgc=;
        b=OH/jx28S1+Fpkpa6/oSQqxBHsefD6XPOpGW6nOCytl/KB60KYdwmYb/YF/IGQJw+lY
         sjoUu9+aZ7+K+YUU4S5CQi3rHW578KHFNSEnBc7IHrEJav3+/Cn4+fJwlO/giskPSQ0F
         Hzt53jfvgiIjKXAPm3RiH3A/hzKxHVrpjCx0nodO3gfabvw9uEgnu5c0XNcsL0CGR1sX
         hDCAT0I6nCNOimTrVud6/sOvvjaOTfm2+MLYlbycjCwtNWsTi4jlRHPEXLrAu5Qq3CjZ
         0H5CY8GpCoFMjNUJ8LTYxab19PFX9JIpeenuph9WikHn5wnonN5acR+T2ADici/mQBDj
         khPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767613657; x=1768218457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m17uYCatZPNweCRBX/sngXFTPvpwP0pbjoi0G6O2mgc=;
        b=Y1/FsOn8CiArE3/i3tpyeO6I60YIY0Eq5LbKNhRWaoyesYk7g+mmOxYZiMuSy2OVtz
         4KRAlq+0MoYMeQlL3kf595GPWFwWEfUkmNWqH3rCd6g5PkucMgtB19puxTc7nlQs36fQ
         94Y93+w9X0z/IP93O0+OYmXrF5YAn7QZp4J3Wu5/YHOgkmJ6QJws3GacWguY18DX6OQ7
         TWK+R3oKiceHloDvka59hI/OtRcCU1SmTphm+M+PLuCkXkn3hOMWoQOg+ptNzSCpGfAZ
         iqqQKV5k7NohVlj3FoxSSpzj62ymGK9iCDfIYZ6pi+Em2cwd7/nOGfkgwWxzYkko8J4o
         9c8A==
X-Forwarded-Encrypted: i=1; AJvYcCVybsLfuq+5ki9IRspF/QClYN0xUd1GJ7oBzE2WV8AKUr2nvB2XCGHlP/5qIl7iYfAEaDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpCeevITYn9ZpHC0xObIfbQh1ntgQJ6TUU9VOnQnhshf93mrd
	f1EgF6HqLKQvXnFJKeZj/9qbhfPqxWzkl1QqVKGlf0FC4OB4fGTqMwkn1b41T+MGetMZFW/bg+R
	76VPgRw==
X-Gm-Gg: AY/fxX4SjqVO+73uIMO2WNxmYyDdvBkQBJlkfKrsn4LBmzdRILrjZsVmRQs8lvHHRzp
	9Mi1/2bK9UTx6n+75Bl4h27CsNbeHq89aAhx6HnQB/e+qponvVMb+LeKMoealOqmTEG+l/J1wOk
	85eAcNSYEvVUoUB1IzrotOIp5lSbLBUmO9JyhseMvouEJsENPvjWfLSRZRPdDwCgQfCTpVszAgs
	dLMPMEujxZDWnnzgamOwhpwDglYR0e4AgdWWyufVds0VKGoI6K8PWQ5O0vyA1d/Pu644c62AlNt
	EClH7H6mpEtLEj7o94pPUZlei1bOttAj+SisDjelruulae/aP7okNCWOU/3T+VY9UVhqiknFqhk
	S9iLh7w3JcZXe0lWW9HrnIWEtzqhofWgatWppXPeNysrtQ+Jg5jTP6dHPU246JhSfqJv0HE0NZI
	SSOaDgThk7rvkPt9vVYudR2+XbXmVRiCvVwOp21rvIT02ZnjHQc8uSpQ==
X-Google-Smtp-Source: AGHT+IGuetLP0nVJFf8G40HuKlEjGvP4p2WkBVwDQXq6+Oe3bbGFu5XYHxd/BJZjAz7Mu37PliTbdQ==
X-Received: by 2002:a05:6402:2706:b0:64d:f39:3fdb with SMTP id 4fb4d7f45d1cf-64d0f3941a6mr42766682a12.13.1767613657383;
        Mon, 05 Jan 2026 03:47:37 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105a9c4sm53770107a12.12.2026.01.05.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:47:36 -0800 (PST)
Date: Mon, 5 Jan 2026 11:47:33 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] btf_encoder: prefer strong function definitions
 for BTF generation
Message-ID: <aVuk1e73g7ZTHqMY@google.com>
References: <20251231085322.3248063-1-mattbobrowski@google.com>
 <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>
 <aVt139VXMTka-hYw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVt139VXMTka-hYw@google.com>

On Mon, Jan 05, 2026 at 08:27:11AM +0000, Matt Bobrowski wrote:
> On Fri, Jan 02, 2026 at 10:46:00AM -0800, Yonghong Song wrote:
> > 
> > 
> > On 12/31/25 12:53 AM, Matt Bobrowski wrote:
> > > Currently, when a function has both a weak and a strong definition
> > > across different compilation units (CUs), the BTF encoder arbitrarily
> > > selects one to generate the BTF entry. This selection fundamentally is
> > > dependent on the order in which pahole processes the CUs.
> > > 
> > > This indifference often leads to a mismatch where the generated BTF
> > > reflects the weak definition's prototype, even though the linker
> > > selected the strong definition for the final vmlinux binary.
> > > 
> > > A notable example described in [0] involving function
> > > bpf_lsm_mmap_file(). Both weak and strong definitions exist,
> > > distinguished only by parameter names (e.g., file vs
> > > file__nullable). While the strong definition is linked into the
> > > vmlinux object, the generated BTF contained the prototype for the weak
> > > definition. This causes issues for BPF verifier (e.g., __nullable
> > > annotation semantics), or tools relying on accurate type information.
> > > 
> > > To fix this, ensure the BTF encoder selects the function definition
> > > corresponding to the actual code linked into the binary. This is
> > > achieved by comparing the DWARF function address (DW_AT_low_pc) with
> > > the ELF symbol address (st_value). Only the DWARF entry for the strong
> > > definition will match the final resolved ELF symbol address.
> > > 
> > > [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> > > 
> > > Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> > > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> > 
> > LGTM with some nits below.
> 
> Thanks for the review.
> 
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > 
> > > ---
> > >   btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 36 insertions(+)
> > > 
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index b37ee7f..0462094 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
> > >   /* state used to do later encoding of saved functions */
> > >   struct btf_encoder_func_state {
> > > +	uint64_t addr;
> > >   	struct elf_function *elf;
> > >   	uint32_t type_id_off;
> > >   	uint16_t nr_parms;
> > > @@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
> > >   	if (!state)
> > >   		return -ENOMEM;
> > > +	state->addr = function__addr(fn);
> > >   	state->elf = func;
> > >   	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> > >   	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
> > > @@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
> > >   	encoder->func_states.cap = 0;
> > >   }
> > > +static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
> > > +									  int combined_cnt)
> > > +{
> > > +	int i, j;
> > > +
> > > +	/*
> > > +	 * The same elf_function is shared amongst combined functions,
> > > +	 * as per saved_functions_combine().
> > > +	 */
> > > +	struct elf_function *elf = combined_states[0].elf;
> > 
> > The logic is okay. But can we limit elf->sym_cnt to be 1 here?
> > This will match the case where two functions (weak and strong)
> > co-exist in compiler and eventually only strong/global function
> > will survive.
> 
> In fact, checking again I believe that the loop is redundant because
> elf_function__has_ambiguous_address() ensures that if we reach this
> point, all symbols for the function share the same address. Therefore,
> checking the first symbol (elf->syms[0]) should be sufficient and
> equivalent to checking all of them.
> 
> Will send through a v2 with this amendment.

Hm, actually, no. I don't think the addresses stored within
elf->syms[#].addr should all be assumed to be the same at the point
which the new btf_encoder__select_canonical_state() function is called
(due to things like skip_encoding_inconsistent_proto possibly taking
effect). Therefore, I think it's best that we leave things as is and
exhaustively iterate through all elf->syms? I don't believe there's
any adverse effects in doing it this way anyway?

> > > +
> > > +	for (i = 0; i < combined_cnt; i++) {
> > > +		struct btf_encoder_func_state *state = &combined_states[i];
> > > +
> > > +		for (j = 0; j < elf->sym_cnt; j++) {
> > > +			if (state->addr == elf->syms[j].addr)
> > > +				return state;
> > > +		}
> > > +	}
> > > +
> > > +	return &combined_states[0];
> > > +}
> > > +
> > >   static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
> > >   {
> > >   	struct btf_encoder_func_state *saved_fns = encoder->func_states.array;
> > > @@ -1517,6 +1542,17 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
> > >   					0, 0);
> > >   		if (add_to_btf) {
> > > +			/*
> > > +			 * We're to add the current function within
> > > +			 * BTF. Although, from all functions that have
> > > +			 * possibly been combined via
> > > +			 * saved_functions_combine(), ensure to only
> > > +			 * select and emit BTF for the most canonical
> > > +			 * function definition.
> > > +			 */
> > > +			if (j - i > 1)
> > > +				state = btf_encoder__select_canonical_state(state, j - i);
> > > +
> > >   			if (is_kfunc_state(state))
> > >   				err = btf_encoder__add_bpf_kfunc(encoder, state);
> > >   			else
> > 

