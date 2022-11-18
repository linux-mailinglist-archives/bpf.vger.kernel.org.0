Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A5662FF82
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 22:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiKRVoo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 16:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKRVon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 16:44:43 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB115697C6;
        Fri, 18 Nov 2022 13:44:41 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id x18so4393017qki.4;
        Fri, 18 Nov 2022 13:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW8hLDOiOF1kLWptWRos7iSOYDjkGH6QjMVZyxX6h8E=;
        b=kJhumbGR+qUD+/HKGMzCzgGkzb44pfic3amXkdfHdv8o9lUKbPFMmR0/4yMF7OgSv8
         s35WiptG0PhHRSBwV8I642Lw0gAV7H+B5uhsBPxGu+gwhxpKTMlEkz41zLNMEm0BhpWP
         O+cbzdouqTEmlfFpZqN9BCzZwnd2/u4JAN3Le+AymNmhRC72P0YfxHEku/CDux59zGOT
         mh0+Wl6FknbAJx1NzY1tSXxK209o13hP3dA96j2OTdD1NZbfTujbDM//GIRggIOhZahk
         inPZTX8ojNZIlfJXHX+MiuTaa78W6SCBErhrzwNa+6NSVRv26dBbUXNlGhsIjnCYR11j
         2rEw==
X-Gm-Message-State: ANoB5pmRERs89Z8mLnWQeFCS2UUWKqLvArO8ePyijOyF17elxzm6PmyT
        VQxo7gWgEUFXs+BySQ5C03Tb16M45u13r40X
X-Google-Smtp-Source: AA0mqf75yz3S2HeePkjaeSq+tF+w1tbLuET0y4P/l7dQqPV/71B4fQj5am0CJB8buaSHb/N8ZYhgvQ==
X-Received: by 2002:a37:387:0:b0:6ec:597a:ce01 with SMTP id 129-20020a370387000000b006ec597ace01mr7545183qkd.133.1668807880648;
        Fri, 18 Nov 2022 13:44:40 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:cf15])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006bb8b5b79efsm3305396qko.129.2022.11.18.13.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 13:44:40 -0800 (PST)
Date:   Fri, 18 Nov 2022 15:44:42 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <Y3f8yqhRRBIzrDvH@maniforge.lan>
References: <20221117032402.2356776-1-void@manifault.com>
 <20221117032402.2356776-2-void@manifault.com>
 <20221118022640.borhn6iy4v2fhl7g@MacBook-Pro-5.local>
 <Y3eamIVUVb6V47LF@maniforge.lan>
 <Y3e2sdqL1E0SKJ5/@maniforge.lan>
 <20221118184500.yshwvcrx2a34xkmc@MacBook-Pro-5.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118184500.yshwvcrx2a34xkmc@MacBook-Pro-5.local>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 10:45:00AM -0800, Alexei Starovoitov wrote:
> On Fri, Nov 18, 2022 at 10:45:37AM -0600, David Vernet wrote:
> > On Fri, Nov 18, 2022 at 08:45:44AM -0600, David Vernet wrote:
> > 
> > [...]
> > 
> > > > >  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> > > > >  		    const struct bpf_prog *prog,
> > > > >  		    struct bpf_insn_access_aux *info)
> > > > > @@ -5722,6 +5727,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> > > > >  	}
> > > > >  
> > > > >  	info->reg_type = PTR_TO_BTF_ID;
> > > > > +	if (prog_type_args_trusted(prog->type))
> > > > > +		info->reg_type |= PTR_TRUSTED;
> > > > > +
> > > > >  	if (tgt_prog) {
> > > > >  		enum bpf_prog_type tgt_type;
> > > > >  
> > > > > @@ -6558,15 +6566,26 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > > >  		/* These register types have special constraints wrt ref_obj_id
> > > > >  		 * and offset checks. The rest of trusted args don't.
> > > > >  		 */
> > > > > -		obj_ptr = reg->type == PTR_TO_CTX || reg->type == PTR_TO_BTF_ID ||
> > > > > +		obj_ptr = reg->type == PTR_TO_CTX ||
> > > > > +			  base_type(reg->type) == PTR_TO_BTF_ID ||
> > > > >  			  reg2btf_ids[base_type(reg->type)];
> > > > >  
> > > > >  		/* Check if argument must be a referenced pointer, args + i has
> > > > >  		 * been verified to be a pointer (after skipping modifiers).
> > > > >  		 * PTR_TO_CTX is ok without having non-zero ref_obj_id.
> > > > > +		 *
> > > > > +		 * All object pointers must be refcounted, other than:
> > > > > +		 * - PTR_TO_CTX
> > > > > +		 * - PTR_TRUSTED pointers
> > > > >  		 */
> > > > > -		if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
> > > > > -			bpf_log(log, "R%d must be referenced\n", regno);
> > > > > +		if (is_kfunc &&
> > > > > +		    trusted_args &&
> > > > > +		    obj_ptr &&
> > > > > +		    base_type(reg->type) != PTR_TO_CTX &&
> > > > > +		    (!(type_flag(reg->type) & PTR_TRUSTED) ||
> > > > > +		     (type_flag(reg->type) & ~PTR_TRUSTED)) &&
> > > > > +		    !reg->ref_obj_id) {
> > > > 
> > > > This is pretty hard to read.
> > > > Is this checking:
> > > > !(reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED))
> > > > ?
> > > > 
> > > > Why not to use the above?
> > > 
> > > Agreed this is more readable, I'll do this for v8 (from a helper as you
> > > suggested).
> > 
> > Sorry, my initial response was incorrect. After thinking about this
> > more, I don't think this conditional would be correct here:
> > 
> > 	!(reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED))
> > 
> > That conditional is saying, "If it's PTR_TO_BTF_ID, and either no
> > modifiers are set, or PTR_TRUSTED is set". Or in other words, "If
> > PTR_TO_BTF_ID is set, we don't need a refcount check unless a modifier
> > other than PTR_TRUSTED is set on the register." This is incorrect, as it
> > would short-circuit out of the check before !reg->ref_obj_id for
> > reg->type == PTR_TO_BTF_ID, so we would skip the reference requirement
> > for normal, unmodified PTR_TO_BTF_ID objects. It would also cause us to
> > incorrectly _not_ skip the ref_obj_id > 0 check for when a
> > reg2btf_ids[base_type(reg->type)] register has the PTR_TRUSTED modifier.
> > 
> > What we really need is a check that encodes, "Don't require a refcount
> > if PTR_TRUSTED is present and no other type modifiers are present",
> > i.e.:
> > 
> > 	!(type_flag(reg->type) & PTR_TRUSTED) || (type_flag(reg->type) & ~PTR_TRUSTED)
> > 
> > My intention was to be conservative here and say "only trust PTR_TRUSTED
> > if no other type modifiers are set". I think this is necessary because
> > other type modifiers such as PTR_UNTRUSTED could theoretically be set on
> > the register as well. Clearly this code is pretty difficult to reason
> > about though, so I'm open to suggestions for how to simplify it.
> > 
> > I'll point out specifically that it's difficult to reason about when
> > modifiers are or are not safe to allow. For example, we definitely don't
> > want to skip the refcount check for OBJ_RELEASE | PTR_TRUSTED, because
> 
> OBJ_RELEASE cannot be part of reg flag.
> It's only in arg_type.

Ah yeah, fair enough. Got confused because it's part of the same
bpf_type_flag enum. I think the point in general stands though.

> Anyway Kumar's refactoring was applied the code in question looks different now:
> It would fall into this part:

Great, that's a nice simplification.

> case KF_ARG_PTR_TO_BTF_ID:
>         /* Only base_type is checked, further checks are done here */
>         if (reg->type != PTR_TO_BTF_ID &&
>             (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
>                 verbose(env, "arg#%d expected pointer to btf or socket\n", i);
>                 return -EINVAL;
>         }
>         ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
> 
> > if it's a release arg it should always have a refcount on it.
> > PTR_UNTRUSTED | PTR_TRUSTED would also make no sense. MEM_FIXED_SIZE
> > though seems fine? In general, I thought it was prudent for us to take
> > the most conservative possible approach here, which is that PTR_TRUSTED
> > only applies when no other modifiers are present, and it applies for all
> > obj_ptr types (other than PTR_TO_CTX which does its own thing).
> 
> Probably worth refining when PTR_TRUSTED is cleared.
> For example adding PTR_UNTRUSTED should definitely clear it.

That makes sense for PTR_UNTRUSTED, what about the other type modifiers
like PTR_MAYBE_NULL? We set and unset if a ptr is NULL throughout a
function, so we'd have to record if it was previously trusted in order
to properly re-OR after a NULL check.

> MEM_ALLOC flag is probably equivalent to PTR_TRUSTED.
> Maybe the bit:
> regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
> should set PTR_TRUSTED as well?

We could, but that changes the meaning of PTR_TRUSTED and IMO makes it
harder to reason about. Before it was just "the kernel passed this arg
to the program and promises the program that it was trusted when it was
first passed". Now it's that plus it could mean that it points to an
allocated object from bpf_obj_new()". IMO we should keep all of these
modifiers separate so that the presence of a modifier has a well-defined
meaning that we can interpret in each context as needed.  In this case,
we can make trust opt-in, so a KF_TRUSTED_ARGS BTF pointer either of the
following:

1. reg->ref_obj_id > 0
2. Either one of PTR_TRUSTED | MEM_ALLOC type modifiers are set, and no
   others.

Let me know if that sounds OK to you.

> > 
> > Note as well that this check is different from the one you pointed out
> > below, which is verifying that PTR_TRUSTED is the only modifier for both
> > reg2btf_ids[base_type(reg->type)] and base_type(reg->type) ==
> > PTR_TO_BTF_ID.  Additionally, the check is different than the check in
> > check_reg_type(), which I'll highlight below where the code is actually
> > modified.
> 
> I'm mainly objecting to logic:
> !(type_flag(reg->type) & PTR_TRUSTED) || (type_flag(reg->type) & ~PTR_TRUSTED)
> 
> which looks like 'catch-all'.
> Like it will error on MEM_ALLOC which probably not correct.
> In other words it's 'too conservative'. Meaning it's rejecting valid code.

Agreed that after the rebase this would no longer be correct. I think we
should make it opt-in, though. PTR_TRUSTED | MEM_ALLOC is fine.
PTR_TRUSTED | MEM_ALLOC | PTR_MAYBE_NULL would not be.

> 
> > > > >  
> > > > >  found:
> > > > > -	if (reg->type == PTR_TO_BTF_ID) {
> > > > > +	if (base_type(reg->type) == PTR_TO_BTF_ID && !(type_flag(reg->type) & ~PTR_TRUSTED)) {
> > 
> > As mentioned above, this check is different than the one we're doing in
> > btf_ctx_access() when determining if the reg requires a ref_obj_id > 0.
> > This check is actually doing what you originally suggested above:
> > 
> > if (reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED))
> > 
> > I think what you wrote is more readable and am happy to apply it to this
> > check in v8, but unfortunately I don't think we really have an
> > opportunity to avoid code duplication here with a helper (though a
> > helper may still improve readability).
> 
> ok. forget the helper. open coding all conditions is probably cleaner,
> since they will be different in every case.

Ack
