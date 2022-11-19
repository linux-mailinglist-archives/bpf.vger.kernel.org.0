Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939E963113A
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 23:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiKSWU1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Nov 2022 17:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiKSWU0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Nov 2022 17:20:26 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC81740A;
        Sat, 19 Nov 2022 14:20:24 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id d7so5851792qkk.3;
        Sat, 19 Nov 2022 14:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J8tTGgCyLrvAs0eKS8Z9wCd69xykc3/xnMtyKvDdso=;
        b=4CT/ZtIHynAbwOMX2MZaa+iTMHVZSS+5EuyEONZmbjdbHGHEgYLA9rc0485Gnmz2nR
         qBrYbVNasbIcREtvgOgO+bcdciR7T5TCZCnn+ARv7axqKAng+5DA5KH1w+CLuaZ8Y81I
         rPEqWQN/svrjg8/GSJNMaTFEq4WWnyucsSKORp/pVcUiyDdlG0QU281YLXJQ6Ua1jME/
         W4VMOeo9dqTiFMj9UPaYQ84SFMb3ElnGHnCpkphYxreRGxm9XHsbx1hEAoY3Sw/9Bdob
         yDlyS0xXEAOmRShKvbk0HogVPjmo1fnXOLS6DaVVIqW4/9qTUHO6VdBcp8kDdDrXIGK4
         R//g==
X-Gm-Message-State: ANoB5pk8hHgeFLdtRfJ94xX2SRUICGxBT5MCAV0xSZtiatQXi791BDYf
        dsnKZDLGKK2NWlvBQ8Rw4Yo=
X-Google-Smtp-Source: AA0mqf6zdB24Y92Fa4ZDoJ108vf/ThgcBXo/7PNnOpffC23+AgTlOPfOwuIcfh2gY8r7KrTFoaj+Cw==
X-Received: by 2002:a37:345:0:b0:6fa:1031:e379 with SMTP id 66-20020a370345000000b006fa1031e379mr11415429qkd.334.1668896423667;
        Sat, 19 Nov 2022 14:20:23 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:6319])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm5252386qko.126.2022.11.19.14.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 14:20:23 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:20:26 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, memxor@gmail.com, tj@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next v8 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <Y3lWqouIxfOpMGmE@maniforge.lan>
References: <20221119210748.3325667-1-void@manifault.com>
 <20221119210748.3325667-2-void@manifault.com>
 <20221119220246.k4i3zp5wmsm6g2al@macbook-pro-5.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119220246.k4i3zp5wmsm6g2al@macbook-pro-5.dhcp.thefacebook.com>
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

On Sat, Nov 19, 2022 at 02:02:46PM -0800, Alexei Starovoitov wrote:
> On Sat, Nov 19, 2022 at 03:07:46PM -0600, David Vernet wrote:
> > @@ -6887,6 +6895,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
> >  			}
> >  
> >  			reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
> > +
> 
> No need to add empty line here.

Ack

> >  			reg->id = ++env->id_gen;
> >  
> >  			continue;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 195d24316750..3a90a1c7613f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -557,7 +557,7 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
> >  static const char *reg_type_str(struct bpf_verifier_env *env,
> >  				enum bpf_reg_type type)
> >  {
> > -	char postfix[16] = {0}, prefix[32] = {0};
> > +	char postfix[16] = {0}, prefix[64] = {0};
> >  	static const char * const str[] = {
> >  		[NOT_INIT]		= "?",
> >  		[SCALAR_VALUE]		= "scalar",
> > @@ -589,16 +589,14 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
> >  			strncpy(postfix, "_or_null", 16);
> >  	}
> >  
> > -	if (type & MEM_RDONLY)
> > -		strncpy(prefix, "rdonly_", 32);
> > -	if (type & MEM_RINGBUF)
> > -		strncpy(prefix, "ringbuf_", 32);
> > -	if (type & MEM_USER)
> > -		strncpy(prefix, "user_", 32);
> > -	if (type & MEM_PERCPU)
> > -		strncpy(prefix, "percpu_", 32);
> > -	if (type & PTR_UNTRUSTED)
> > -		strncpy(prefix, "untrusted_", 32);
> > +	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s",
> > +		 type & MEM_RDONLY ? "rdonly_" : "",
> > +		 type & MEM_RINGBUF ? "ringbuf_" : "",
> > +		 type & MEM_USER ? "user_" : "",
> > +		 type & MEM_PERCPU ? "percpu_" : "",
> > +		 type & PTR_UNTRUSTED ? "untrusted_" : "",
> > +		 type & PTR_TRUSTED ? "trusted_" : ""
> > +	);
> 
> Nice. Could have been a separate patch, but ok.

Will do next time, sorry for the bloat in this one.

> 
> >  
> >  found:
> > -	if (reg->type == PTR_TO_BTF_ID) {
> > +	if (reg->type == PTR_TO_BTF_ID || (reg->type & PTR_TRUSTED)) {
> 
> No need for (). The operator precedence is pretty clear.

Ack

> >  		/* For bpf_sk_release, it needs to match against first member
> >  		 * 'struct sock_common', hence make an exception for it. This
> >  		 * allows bpf_sk_release to work for multiple socket types.
> > @@ -6058,6 +6070,8 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >  	 */
> >  	case PTR_TO_BTF_ID:
> >  	case PTR_TO_BTF_ID | MEM_ALLOC:
> > +	case PTR_TO_BTF_ID | PTR_TRUSTED:
> > +	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
> >  		/* When referenced PTR_TO_BTF_ID is passed to release function,
> >  		 * it's fixed offset must be 0.	In the other cases, fixed offset
> >  		 * can be non-zero.
> > @@ -7942,6 +7956,25 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
> >  	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
> >  }
> >  
> > +static bool is_trusted_reg(const struct bpf_reg_state *reg)
> > +{
> > +	/* A referenced register is always trusted. */
> > +	if (reg->ref_obj_id)
> > +		return true;
> > +
> > +	/* If a register is not referenced, it is trusted if it has either the
> > +	 * MEM_ALLOC or PTR_TRUSTED type modifiers, and no others. Some of the
> > +	 * other type modifiers may be safe, but we elect to take an opt-in
> > +	 * approach here as some (e.g. PTR_UNTRUSTED and PTR_MAYBE_NULL) are
> > +	 * not.
> > +	 *
> > +	 * Eventually, we should make PTR_TRUSTED the single source of truth
> > +	 * for whether a register is trusted.
> > +	 */
> > +	return (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS) &&
> 
> No need for ().

Ack

> > +	       !bpf_type_has_unsafe_modifiers(reg->type);
> > +}
> > +
> ...
> > -		if (is_kfunc_release(meta) && reg->ref_obj_id)
> > +		if (is_kfunc_release(meta) && reg->ref_obj_id) {
> >  			arg_type |= OBJ_RELEASE;
> > +			if (bpf_type_has_unsafe_modifiers(reg->type)) {
> > +				verbose(env, "R%d release reg has unsafe modifiers\n", i);
> > +				return -EINVAL;
> > +			}
> 
> This part is a bit controversial, sicne it messes up the verifier messages.
> Meaning that doing the check that early is losing important context.
> 
> > +		}
> >  		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
> >  		if (ret < 0)
> >  			return ret;
> > @@ -8705,7 +8745,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >  			break;
> >  		case KF_ARG_PTR_TO_BTF_ID:
> >  			/* Only base_type is checked, further checks are done here */
> > -			if (reg->type != PTR_TO_BTF_ID &&
> > +			if (base_type(reg->type) != PTR_TO_BTF_ID &&
> >  			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
> >  				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
> 
> With base_type() addition maybe the bpf_type_has_unsafe_modifiers() check
> should be done here ?
> Then test_verifier wouldn't need to change.
> It's not the change itself that is a concern, but the loss of context in the messages.
> I guess one can argue that erroring on PTR_TO_BTF_ID | PTR_MAYBE_NULL
> with "reg has unsafe modifiers" is just as correct as saying
> "expected pointer to btf or socket" a bit later.

This was my thinking. I thought it was a clearer message than "expected
pointer to btf or socket". It _is_ a ptr to btf, but it has modifiers.
Teasing that apart for the release reg seemed like an improvement.

> Both could be improved.
> If we keep it early while doing is_kfunc_release(meta) && reg->ref_obj_id
> we could say:
> "%s is not allowed in release function"
> reg_type_str(env,reg->type)
> Which for verifier/calls.c test case will be:
> "ptr_prog_test_ref_kfunc_or_null is not allowed in release function"
> 
> If we do it later here it could be:
> "arg#$d is %s. Expected %s or socket",
> reg_type_str(env,reg->type)
> reg_type_str(env,base_type(reg->type) | type_flag(reg->type) & ~BPF_REG_TRUSTED_MODIFIERS)
> "arg#0 is ptr_prog_test_ref_kfunc_or_null. Expected ptr_prog_test_ref_kfunc or socket"
> 
> which is even better and it will make it easier for user to fix the code.

I like this, it's much better. I'll send out v9 with this change.
