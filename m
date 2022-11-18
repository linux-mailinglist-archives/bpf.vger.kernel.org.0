Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C4D62FCF0
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 19:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiKRSpI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 13:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiKRSpG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 13:45:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F28F3D4;
        Fri, 18 Nov 2022 10:45:05 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k7so5314077pll.6;
        Fri, 18 Nov 2022 10:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3FC0XJuf4EOjB0UhVhwX8fr+UooJnsmWihJCBqUIz4=;
        b=EDijdibNtrt0r2PUujqwuKpc5+fxdKcSgLzUrFqiJ+soe4YmUYa37QLundGOwKkeM0
         xUzkQRVVn6tMZu0lG4qi1n5S103XuHLj5aJ7lD3G808EZnO/DjcC/xjbGO+D4wQlln2V
         DuDcVo13EXKxw9Q3mNED8NveQfjELbJLfHd7YtDo0j1+H+wVyPrEQ6Pbb7kPmwYZIiE9
         JoGO62XClWkVYj55WmibHFmh2LhX5NDJjrVZmKPZjQRt58742YGeCV4f3fTmGuAotBpk
         Yg4MhSeeTizqhNrUxKTi/sHEJpnws7W7Hq0eGhqcRXXAC0+bg7o4327XkZKy4kgPFpsI
         Nuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3FC0XJuf4EOjB0UhVhwX8fr+UooJnsmWihJCBqUIz4=;
        b=VGObwPk12uKa2mitOMgr9LlUSvDsubp11KfyK2ecwamnknuGXtrRcO+54E+5mj5Y15
         QZSagsGor86DkxW4dHfU3+b4WNLKboTXJZltnvvP4MK7rbzfkFzbe1w6WNi8Gb7MlKcC
         Ah5incxnyNFmfSVk4UNsEI8Aene7WW0TSP+BcYVNQOcQUVErXXEOJJ7HZEgYXM+YC8sO
         6EWNGPkteQ/KK+FMJiFeewKVjKyQwuz84RmU1S3zgR6v3lkvleGhvrv9VDOUVlpsmJ6x
         5GjSpVOQ/uUyna08yDeZtV+fa+P+KGfZ90QEL1tawpy2Ybzo3IyAQYvZ1VuNTQMe8zx6
         c0Sg==
X-Gm-Message-State: ANoB5pmbtmlFUBJQSCZK/YwmNAyBOndYXzKN5yPsYMslA6csyzSVBjsc
        YMVa2vy5LSMcmF+E/pLkHKMEp+t+9Gc=
X-Google-Smtp-Source: AA0mqf5vyLSnR7kLaFOH8EJwldNPEbFUubg5+mavZdX+6X6xofMn3D+5Po0moviBFLyceCHDdyV0+A==
X-Received: by 2002:a17:90b:3547:b0:212:d6ed:cdf5 with SMTP id lt7-20020a17090b354700b00212d6edcdf5mr8740636pjb.142.1668797104655;
        Fri, 18 Nov 2022 10:45:04 -0800 (PST)
Received: from MacBook-Pro-5.local ([2620:10d:c090:500::4:6663])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00188a1ae94bbsm4156050plr.23.2022.11.18.10.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:45:03 -0800 (PST)
Date:   Fri, 18 Nov 2022 10:45:00 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <20221118184500.yshwvcrx2a34xkmc@MacBook-Pro-5.local>
References: <20221117032402.2356776-1-void@manifault.com>
 <20221117032402.2356776-2-void@manifault.com>
 <20221118022640.borhn6iy4v2fhl7g@MacBook-Pro-5.local>
 <Y3eamIVUVb6V47LF@maniforge.lan>
 <Y3e2sdqL1E0SKJ5/@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3e2sdqL1E0SKJ5/@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 10:45:37AM -0600, David Vernet wrote:
> On Fri, Nov 18, 2022 at 08:45:44AM -0600, David Vernet wrote:
> 
> [...]
> 
> > > >  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> > > >  		    const struct bpf_prog *prog,
> > > >  		    struct bpf_insn_access_aux *info)
> > > > @@ -5722,6 +5727,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> > > >  	}
> > > >  
> > > >  	info->reg_type = PTR_TO_BTF_ID;
> > > > +	if (prog_type_args_trusted(prog->type))
> > > > +		info->reg_type |= PTR_TRUSTED;
> > > > +
> > > >  	if (tgt_prog) {
> > > >  		enum bpf_prog_type tgt_type;
> > > >  
> > > > @@ -6558,15 +6566,26 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > > >  		/* These register types have special constraints wrt ref_obj_id
> > > >  		 * and offset checks. The rest of trusted args don't.
> > > >  		 */
> > > > -		obj_ptr = reg->type == PTR_TO_CTX || reg->type == PTR_TO_BTF_ID ||
> > > > +		obj_ptr = reg->type == PTR_TO_CTX ||
> > > > +			  base_type(reg->type) == PTR_TO_BTF_ID ||
> > > >  			  reg2btf_ids[base_type(reg->type)];
> > > >  
> > > >  		/* Check if argument must be a referenced pointer, args + i has
> > > >  		 * been verified to be a pointer (after skipping modifiers).
> > > >  		 * PTR_TO_CTX is ok without having non-zero ref_obj_id.
> > > > +		 *
> > > > +		 * All object pointers must be refcounted, other than:
> > > > +		 * - PTR_TO_CTX
> > > > +		 * - PTR_TRUSTED pointers
> > > >  		 */
> > > > -		if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
> > > > -			bpf_log(log, "R%d must be referenced\n", regno);
> > > > +		if (is_kfunc &&
> > > > +		    trusted_args &&
> > > > +		    obj_ptr &&
> > > > +		    base_type(reg->type) != PTR_TO_CTX &&
> > > > +		    (!(type_flag(reg->type) & PTR_TRUSTED) ||
> > > > +		     (type_flag(reg->type) & ~PTR_TRUSTED)) &&
> > > > +		    !reg->ref_obj_id) {
> > > 
> > > This is pretty hard to read.
> > > Is this checking:
> > > !(reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED))
> > > ?
> > > 
> > > Why not to use the above?
> > 
> > Agreed this is more readable, I'll do this for v8 (from a helper as you
> > suggested).
> 
> Sorry, my initial response was incorrect. After thinking about this
> more, I don't think this conditional would be correct here:
> 
> 	!(reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED))
> 
> That conditional is saying, "If it's PTR_TO_BTF_ID, and either no
> modifiers are set, or PTR_TRUSTED is set". Or in other words, "If
> PTR_TO_BTF_ID is set, we don't need a refcount check unless a modifier
> other than PTR_TRUSTED is set on the register." This is incorrect, as it
> would short-circuit out of the check before !reg->ref_obj_id for
> reg->type == PTR_TO_BTF_ID, so we would skip the reference requirement
> for normal, unmodified PTR_TO_BTF_ID objects. It would also cause us to
> incorrectly _not_ skip the ref_obj_id > 0 check for when a
> reg2btf_ids[base_type(reg->type)] register has the PTR_TRUSTED modifier.
> 
> What we really need is a check that encodes, "Don't require a refcount
> if PTR_TRUSTED is present and no other type modifiers are present",
> i.e.:
> 
> 	!(type_flag(reg->type) & PTR_TRUSTED) || (type_flag(reg->type) & ~PTR_TRUSTED)
> 
> My intention was to be conservative here and say "only trust PTR_TRUSTED
> if no other type modifiers are set". I think this is necessary because
> other type modifiers such as PTR_UNTRUSTED could theoretically be set on
> the register as well. Clearly this code is pretty difficult to reason
> about though, so I'm open to suggestions for how to simplify it.
> 
> I'll point out specifically that it's difficult to reason about when
> modifiers are or are not safe to allow. For example, we definitely don't
> want to skip the refcount check for OBJ_RELEASE | PTR_TRUSTED, because

OBJ_RELEASE cannot be part of reg flag.
It's only in arg_type.

Anyway Kumar's refactoring was applied the code in question looks different now:
It would fall into this part:
case KF_ARG_PTR_TO_BTF_ID:
        /* Only base_type is checked, further checks are done here */
        if (reg->type != PTR_TO_BTF_ID &&
            (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
                verbose(env, "arg#%d expected pointer to btf or socket\n", i);
                return -EINVAL;
        }
        ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);

> if it's a release arg it should always have a refcount on it.
> PTR_UNTRUSTED | PTR_TRUSTED would also make no sense. MEM_FIXED_SIZE
> though seems fine? In general, I thought it was prudent for us to take
> the most conservative possible approach here, which is that PTR_TRUSTED
> only applies when no other modifiers are present, and it applies for all
> obj_ptr types (other than PTR_TO_CTX which does its own thing).

Probably worth refining when PTR_TRUSTED is cleared.
For example adding PTR_UNTRUSTED should definitely clear it.
MEM_ALLOC flag is probably equivalent to PTR_TRUSTED.
Maybe the bit:
regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
should set PTR_TRUSTED as well?

> 
> Note as well that this check is different from the one you pointed out
> below, which is verifying that PTR_TRUSTED is the only modifier for both
> reg2btf_ids[base_type(reg->type)] and base_type(reg->type) ==
> PTR_TO_BTF_ID.  Additionally, the check is different than the check in
> check_reg_type(), which I'll highlight below where the code is actually
> modified.

I'm mainly objecting to logic:
!(type_flag(reg->type) & PTR_TRUSTED) || (type_flag(reg->type) & ~PTR_TRUSTED)

which looks like 'catch-all'.
Like it will error on MEM_ALLOC which probably not correct.
In other words it's 'too conservative'. Meaning it's rejecting valid code.

> > > >  
> > > >  found:
> > > > -	if (reg->type == PTR_TO_BTF_ID) {
> > > > +	if (base_type(reg->type) == PTR_TO_BTF_ID && !(type_flag(reg->type) & ~PTR_TRUSTED)) {
> 
> As mentioned above, this check is different than the one we're doing in
> btf_ctx_access() when determining if the reg requires a ref_obj_id > 0.
> This check is actually doing what you originally suggested above:
> 
> if (reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED))
> 
> I think what you wrote is more readable and am happy to apply it to this
> check in v8, but unfortunately I don't think we really have an
> opportunity to avoid code duplication here with a helper (though a
> helper may still improve readability).

ok. forget the helper. open coding all conditions is probably cleaner,
since they will be different in every case.

