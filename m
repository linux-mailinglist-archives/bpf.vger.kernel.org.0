Return-Path: <bpf+bounces-77878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A550CF58EA
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 21:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2A363073E2E
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9F2DAFAA;
	Mon,  5 Jan 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srKcBCD1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D683213FEE
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767645838; cv=none; b=bcvxN7JqZkAgi3OmXqFXRfYINg51MaKnXNfarbqwprvR0eB/OH16nMGnB88QiusAmTSeNcy37nTCxqkL1t5o5JrgJBDwkeP0Gm+Rg231eQqjmofyb6Y8DkMiHk/NJbNNNq47eI9EpgUZZFwEaKbkYVsJb9pA9SShx1Rz5FysspY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767645838; c=relaxed/simple;
	bh=WjJwmAfYdMf5SAaVPzbS5dFiogmjSrgtmAWrbrhoC3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDBjxpRIcjn1YNbdi1Un0QVwmBcYlSKNoMX4rg1SFFZAIRhrzYn4sOEy8mciQVb+lfBd88duD4co6sz3GMvTbEisyapOUn4APnSel2OSyLJMOi50PKhjeDJMVF024lEGL73Vkgz1Jat6xYo3EIww3f1ExsC8wikauuxXYfsmLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srKcBCD1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b8b5410a1so426096a12.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 12:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767645835; x=1768250635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lMqvStSvFSxUzkQX5q2v9C9qSg4usWmTmbHR+7n7Wmc=;
        b=srKcBCD1aMQReHlEK7wbuSuhaR07+4moAXXWyHVZBNnhKcP2T0+6mEsyPjNLAm6xyc
         XqFvA65IAJ65i8yZvfyiMcPZXFtLtTVyEQ9A03KoXHX2vgw8Tn6cbpIHELL0wBneaThl
         hnx4qpNsbwtDkOaciZZ+0xeCsRvtAd4fuM6iAPuQSQTPkU7IumGtZ0K4QqQWdkIz0nZ8
         n/xXNoRZUqCzDG/SOSLcPdPUJfgkSJRQB/b+ITINmZ0GXW41X/g+tlhghUBKxPT/0nAA
         ARin5x8ZYIvQi+jwkqYUu8mdxMK7z+5ibOokqQhKrAn8Hc9Zi6X76nNRiRE5BbYBNHj4
         sDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767645835; x=1768250635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMqvStSvFSxUzkQX5q2v9C9qSg4usWmTmbHR+7n7Wmc=;
        b=CVlOv0XOo9/Xbm+q2qqN1x32G2SSCAJHgFj4TijkbKUQl07BdvMG240z6bHFwpGzJl
         XvqC0/n+nj21VzQMC13M4IsX3adeCflq+waXN0epzTBiMwhAmCLEZ1YqR9sKHNWQgzHl
         R78rIaBsZabkOfD8162yyTe84S42gA7vN5bwK+tALpTIA+EgVpCTrNJVRHhf9hcmj9pj
         YMySFqO+CDu0We900/xYUEV3qwNlnT19Qo+e4FJ9RzSwEx99nbvMJnXsnNzuV+lso4CU
         8+tCA3CEvFeKPAt6rYatEstqfunwOHpBxm9dkFXXmmB3fDSwwUBsBsmkMc2jP8qhOkfe
         akRg==
X-Forwarded-Encrypted: i=1; AJvYcCU317ewAUWCTqTgSiVzxWbYF21vbD1vElMx/xGRbyxgdGRW1+qtrr4wbzIRPOjqj43XhOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRPcIIa/BRhnIKbvqYkpdhuP9B0bJF6rT0RGRvhR4xqfBLH2Q
	wRjKkbdrLG7uMR7y3QT5Roga8tbY0i65tv3Fagm5j2aUySeRN3nDsu4ZdxxvWJ6nZw==
X-Gm-Gg: AY/fxX7Q1PayI/3xp7dq909vpMhmXBqA6QzLfLYHPlvGokX484stxtZMZcGg9K+LaHw
	nGKaUN7K8dT7yPYCNU5T8+BLfkD1G4iY7yIZUzhKKhi66rvFBT3M9cX+gOSMUOZSGOEmturbWXN
	4PdV7ZdaLEC0jLpjbiqtWaLbPh9vzX5eUbLxlA/CDypM2kGuGrJUXlJcwpvyIDngzL/xIUaGeI1
	JE4798AkCl1V/PFCRKRivx6tLb2kK/TBImmOQrv3HDY+eT04m7wANwgE1GZs2l3UU0crKfDz9Cp
	lbRRwEbwFV8U27tmVoY+M8oX4e8QoftTl3EpPbsA4HnSrT0AFQUFuFFlq8nD+3+NceUQYlnY7d9
	+q/qhogwgjIblVwRnZ1jCGIRT8O7w1sz9zepWn+A5d/mtSA/nB4f6yfetq4tu1uOyLMPdfFaq0c
	0L8/osd2NKV5gCbqu/pFxfZpoMZaJQLgmmhkwSBrgVgw6gqmSfN4fM+0RXIiQonIj8
X-Google-Smtp-Source: AGHT+IHkrrJjP4SqkLTB3N9Q9NR+A8WhQu2Nw1SmwhMvzRKlTiMI7DXKDwEtpz3SCfqBVyG07RM/9A==
X-Received: by 2002:a05:6402:274d:b0:64d:23ac:6ca7 with SMTP id 4fb4d7f45d1cf-6507967c2fdmr607422a12.20.1767645835067;
        Mon, 05 Jan 2026 12:43:55 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf65c07sm332578a12.23.2026.01.05.12.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 12:43:53 -0800 (PST)
Date: Mon, 5 Jan 2026 20:43:50 +0000
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
Message-ID: <aVwihhKEszvcyNKo@google.com>
References: <20251231085322.3248063-1-mattbobrowski@google.com>
 <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>
 <aVt139VXMTka-hYw@google.com>
 <aVuk1e73g7ZTHqMY@google.com>
 <6b0968a3-406b-412f-acbb-c00ac2ad7c93@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b0968a3-406b-412f-acbb-c00ac2ad7c93@linux.dev>

On Mon, Jan 05, 2026 at 08:23:29AM -0800, Yonghong Song wrote:
> 
> 
> On 1/5/26 3:47 AM, Matt Bobrowski wrote:
> > On Mon, Jan 05, 2026 at 08:27:11AM +0000, Matt Bobrowski wrote:
> > > On Fri, Jan 02, 2026 at 10:46:00AM -0800, Yonghong Song wrote:
> > > > 
> > > > On 12/31/25 12:53 AM, Matt Bobrowski wrote:
> > > > > Currently, when a function has both a weak and a strong definition
> > > > > across different compilation units (CUs), the BTF encoder arbitrarily
> > > > > selects one to generate the BTF entry. This selection fundamentally is
> > > > > dependent on the order in which pahole processes the CUs.
> > > > > 
> > > > > This indifference often leads to a mismatch where the generated BTF
> > > > > reflects the weak definition's prototype, even though the linker
> > > > > selected the strong definition for the final vmlinux binary.
> > > > > 
> > > > > A notable example described in [0] involving function
> > > > > bpf_lsm_mmap_file(). Both weak and strong definitions exist,
> > > > > distinguished only by parameter names (e.g., file vs
> > > > > file__nullable). While the strong definition is linked into the
> > > > > vmlinux object, the generated BTF contained the prototype for the weak
> > > > > definition. This causes issues for BPF verifier (e.g., __nullable
> > > > > annotation semantics), or tools relying on accurate type information.
> > > > > 
> > > > > To fix this, ensure the BTF encoder selects the function definition
> > > > > corresponding to the actual code linked into the binary. This is
> > > > > achieved by comparing the DWARF function address (DW_AT_low_pc) with
> > > > > the ELF symbol address (st_value). Only the DWARF entry for the strong
> > > > > definition will match the final resolved ELF symbol address.
> > > > > 
> > > > > [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> > > > > 
> > > > > Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> > > > > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> > > > LGTM with some nits below.
> > > Thanks for the review.
> > > 
> > > > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > > > 
> > > > > ---
> > > > >    btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
> > > > >    1 file changed, 36 insertions(+)
> > > > > 
> > > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > > index b37ee7f..0462094 100644
> > > > > --- a/btf_encoder.c
> > > > > +++ b/btf_encoder.c
> > > > > @@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
> > > > >    /* state used to do later encoding of saved functions */
> > > > >    struct btf_encoder_func_state {
> > > > > +	uint64_t addr;
> > > > >    	struct elf_function *elf;
> > > > >    	uint32_t type_id_off;
> > > > >    	uint16_t nr_parms;
> > > > > @@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
> > > > >    	if (!state)
> > > > >    		return -ENOMEM;
> > > > > +	state->addr = function__addr(fn);
> > > > >    	state->elf = func;
> > > > >    	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> > > > >    	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
> > > > > @@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
> > > > >    	encoder->func_states.cap = 0;
> > > > >    }
> > > > > +static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
> > > > > +									  int combined_cnt)
> > > > > +{
> > > > > +	int i, j;
> > > > > +
> > > > > +	/*
> > > > > +	 * The same elf_function is shared amongst combined functions,
> > > > > +	 * as per saved_functions_combine().
> > > > > +	 */
> > > > > +	struct elf_function *elf = combined_states[0].elf;
> > > > The logic is okay. But can we limit elf->sym_cnt to be 1 here?
> > > > This will match the case where two functions (weak and strong)
> > > > co-exist in compiler and eventually only strong/global function
> > > > will survive.
> > > In fact, checking again I believe that the loop is redundant because
> > > elf_function__has_ambiguous_address() ensures that if we reach this
> > > point, all symbols for the function share the same address. Therefore,
> > > checking the first symbol (elf->syms[0]) should be sufficient and
> > > equivalent to checking all of them.
> > > 
> > > Will send through a v2 with this amendment.
> > Hm, actually, no. I don't think the addresses stored within
> > elf->syms[#].addr should all be assumed to be the same at the point
> > which the new btf_encoder__select_canonical_state() function is called
> > (due to things like skip_encoding_inconsistent_proto possibly taking
> > effect). Therefore, I think it's best that we leave things as is and
> > exhaustively iterate through all elf->syms? I don't believe there's
> > any adverse effects in doing it this way anyway?
> 
> No. Your code is correct. For elf->sym_cnt, it covers both sym_cnt
> is 1 or more than 1. My previous suggestion is to single out the
> sym_cnt = 1 case since it is what you try to fix.
> 
> I am okay with the current implementation since it is correct.
> Maybe Alan and Arnaldo have additional comments about the code.

Sure, sounds good. I think leaving it as is probably our best bet at
this point.

> > > > > +
> > > > > +	for (i = 0; i < combined_cnt; i++) {
> > > > > +		struct btf_encoder_func_state *state = &combined_states[i];
> > > > > +
> > > > > +		for (j = 0; j < elf->sym_cnt; j++) {
> > > > > +			if (state->addr == elf->syms[j].addr)
> > > > > +				return state;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return &combined_states[0];
> > > > > +}
> > > > > +
> > > > >    static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
> > > > >    {
> > > > >    	struct btf_encoder_func_state *saved_fns = encoder->func_states.array;
> > > > > @@ -1517,6 +1542,17 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
> > > > >    					0, 0);
> > > > >    		if (add_to_btf) {
> > > > > +			/*
> > > > > +			 * We're to add the current function within
> > > > > +			 * BTF. Although, from all functions that have
> > > > > +			 * possibly been combined via
> > > > > +			 * saved_functions_combine(), ensure to only
> > > > > +			 * select and emit BTF for the most canonical
> > > > > +			 * function definition.
> > > > > +			 */
> > > > > +			if (j - i > 1)
> > > > > +				state = btf_encoder__select_canonical_state(state, j - i);
> > > > > +
> > > > >    			if (is_kfunc_state(state))
> > > > >    				err = btf_encoder__add_bpf_kfunc(encoder, state);
> > > > >    			else
> 

