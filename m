Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB362FAB3
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 17:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiKRQqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 11:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242297AbiKRQp7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 11:45:59 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A6942DD;
        Fri, 18 Nov 2022 08:45:36 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id e15so3704417qvo.4;
        Fri, 18 Nov 2022 08:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HeHN6E7JY+fZJEK9/2BXLPOhQLc4Woa9ln3zokZynw=;
        b=wTM8U9KRiXBm14bUtV3ghtPVJD+Y8o8CC1rqYAtl6F6fvuNCZlTEYQl94yBu0lYlEG
         qgxNEQfi94MURV7afgTHzJA/YS+2b4GUBnhGWIn2GxJl2cGrtj2Z+NkFCCh8ELYTZd2H
         LT4R2BxON8nDvDigGaY9gUa7ziRYT7ANrf2LgKYCJIgrLbnwthc9mnE0KHz/K8dM/RgB
         Z0nES4kYOTVYriR1z9yzkEGhnIT+g4TDeRblTHnFCApQ/ZDPltIbJ0KHaCMroVro+QGj
         F4p3dnT6zno7Fuy3MhjQ6F2SjjxJP8F+EoquNwLQr09DMDZY/ZRPPPmDT6O0f3NbgSeU
         HWgQ==
X-Gm-Message-State: ANoB5pkRv/1iW8UcMWjizkRTWtMXE0icirAy+MYsWtobJSVLkYtj10W3
        kuDIx/GegUskI/RhaPlkh8Y=
X-Google-Smtp-Source: AA0mqf7mEO4W/W/jHKPS9T1h+ygfsB6eXF4R/1gHyt+yBj7Oshhd3ASCxQJtbhIaP0euFd+Oq8LUeA==
X-Received: by 2002:a0c:cb86:0:b0:4c6:34ae:9611 with SMTP id p6-20020a0ccb86000000b004c634ae9611mr7341416qvk.92.1668789935607;
        Fri, 18 Nov 2022 08:45:35 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a248f00b006fa9d101775sm2751095qkn.33.2022.11.18.08.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 08:45:35 -0800 (PST)
Date:   Fri, 18 Nov 2022 10:45:37 -0600
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
Message-ID: <Y3e2sdqL1E0SKJ5/@maniforge.lan>
References: <20221117032402.2356776-1-void@manifault.com>
 <20221117032402.2356776-2-void@manifault.com>
 <20221118022640.borhn6iy4v2fhl7g@MacBook-Pro-5.local>
 <Y3eamIVUVb6V47LF@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3eamIVUVb6V47LF@maniforge.lan>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 08:45:44AM -0600, David Vernet wrote:

[...]

> > >  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> > >  		    const struct bpf_prog *prog,
> > >  		    struct bpf_insn_access_aux *info)
> > > @@ -5722,6 +5727,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> > >  	}
> > >  
> > >  	info->reg_type = PTR_TO_BTF_ID;
> > > +	if (prog_type_args_trusted(prog->type))
> > > +		info->reg_type |= PTR_TRUSTED;
> > > +
> > >  	if (tgt_prog) {
> > >  		enum bpf_prog_type tgt_type;
> > >  
> > > @@ -6558,15 +6566,26 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >  		/* These register types have special constraints wrt ref_obj_id
> > >  		 * and offset checks. The rest of trusted args don't.
> > >  		 */
> > > -		obj_ptr = reg->type == PTR_TO_CTX || reg->type == PTR_TO_BTF_ID ||
> > > +		obj_ptr = reg->type == PTR_TO_CTX ||
> > > +			  base_type(reg->type) == PTR_TO_BTF_ID ||
> > >  			  reg2btf_ids[base_type(reg->type)];
> > >  
> > >  		/* Check if argument must be a referenced pointer, args + i has
> > >  		 * been verified to be a pointer (after skipping modifiers).
> > >  		 * PTR_TO_CTX is ok without having non-zero ref_obj_id.
> > > +		 *
> > > +		 * All object pointers must be refcounted, other than:
> > > +		 * - PTR_TO_CTX
> > > +		 * - PTR_TRUSTED pointers
> > >  		 */
> > > -		if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
> > > -			bpf_log(log, "R%d must be referenced\n", regno);
> > > +		if (is_kfunc &&
> > > +		    trusted_args &&
> > > +		    obj_ptr &&
> > > +		    base_type(reg->type) != PTR_TO_CTX &&
> > > +		    (!(type_flag(reg->type) & PTR_TRUSTED) ||
> > > +		     (type_flag(reg->type) & ~PTR_TRUSTED)) &&
> > > +		    !reg->ref_obj_id) {
> > 
> > This is pretty hard to read.
> > Is this checking:
> > !(reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED))
> > ?
> > 
> > Why not to use the above?
> 
> Agreed this is more readable, I'll do this for v8 (from a helper as you
> suggested).

Sorry, my initial response was incorrect. After thinking about this
more, I don't think this conditional would be correct here:

	!(reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED))

That conditional is saying, "If it's PTR_TO_BTF_ID, and either no
modifiers are set, or PTR_TRUSTED is set". Or in other words, "If
PTR_TO_BTF_ID is set, we don't need a refcount check unless a modifier
other than PTR_TRUSTED is set on the register." This is incorrect, as it
would short-circuit out of the check before !reg->ref_obj_id for
reg->type == PTR_TO_BTF_ID, so we would skip the reference requirement
for normal, unmodified PTR_TO_BTF_ID objects. It would also cause us to
incorrectly _not_ skip the ref_obj_id > 0 check for when a
reg2btf_ids[base_type(reg->type)] register has the PTR_TRUSTED modifier.

What we really need is a check that encodes, "Don't require a refcount
if PTR_TRUSTED is present and no other type modifiers are present",
i.e.:

	!(type_flag(reg->type) & PTR_TRUSTED) || (type_flag(reg->type) & ~PTR_TRUSTED)

My intention was to be conservative here and say "only trust PTR_TRUSTED
if no other type modifiers are set". I think this is necessary because
other type modifiers such as PTR_UNTRUSTED could theoretically be set on
the register as well. Clearly this code is pretty difficult to reason
about though, so I'm open to suggestions for how to simplify it.

I'll point out specifically that it's difficult to reason about when
modifiers are or are not safe to allow. For example, we definitely don't
want to skip the refcount check for OBJ_RELEASE | PTR_TRUSTED, because
if it's a release arg it should always have a refcount on it.
PTR_UNTRUSTED | PTR_TRUSTED would also make no sense. MEM_FIXED_SIZE
though seems fine? In general, I thought it was prudent for us to take
the most conservative possible approach here, which is that PTR_TRUSTED
only applies when no other modifiers are present, and it applies for all
obj_ptr types (other than PTR_TO_CTX which does its own thing).

Note as well that this check is different from the one you pointed out
below, which is verifying that PTR_TRUSTED is the only modifier for both
reg2btf_ids[base_type(reg->type)] and base_type(reg->type) ==
PTR_TO_BTF_ID.  Additionally, the check is different than the check in
check_reg_type(), which I'll highlight below where the code is actually
modified.

> 
> > Similar in other places... type_flag(reg->type) & ~PTR_TRUSTED is not easy.
> > Maybe add a helper that will do
> > bool ff(reg)
> > { 
> >   return reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED);
> > }
> > 
> > ?
> 
> Sure, will do.
> 
> > > +			bpf_log(log, "R%d must be referenced or trusted\n", regno);
> > >  			return -EINVAL;
> > >  		}
> > >  
> > > @@ -6646,8 +6665,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >  					i, btf_type_str(t));
> > >  				return -EINVAL;
> > >  			}
> > > -		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
> > > -			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
> > > +		} else if (is_kfunc && (base_type(reg->type) == PTR_TO_BTF_ID ||
> > > +			   (reg2btf_ids[base_type(reg->type)]))) {
> > >  			const struct btf_type *reg_ref_t;
> > >  			const struct btf *reg_btf;
> > >  			const char *reg_ref_tname;
> > > @@ -6660,7 +6679,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >  				return -EINVAL;
> > >  			}
> > >  
> > > -			if (reg->type == PTR_TO_BTF_ID) {
> > > +			if ((type_flag(reg->type) & ~PTR_TRUSTED)) {
> > 
> > and use that helper here?
> 
> I don't think that specific helper would work here because we also need
> to verify that no type modifiers other than PTR_TRUSTED are present for
> when reg2btf_ids[base_type(reg->type)] is non-NULL.

As mentioned above, this check is slightly different than the one which
would be encapsulated in the helper suggested.

> 
> > 
> > > +				bpf_log(log, "kernel function %s arg#%d pointer had unexpected modifiers %d\n",
> > > +					func_name, i, type_flag(reg->type));
> > > +				return -EINVAL;
> > > +			}
> > > +
> > > +			if (base_type(reg->type) == PTR_TO_BTF_ID) {
> > >  				reg_btf = reg->btf;
> > >  				reg_ref_id = reg->btf_id;
> > >  			} else {
> > > @@ -6988,6 +7013,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
> > >  			}
> > >  
> > >  			reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
> > > +
> > >  			reg->id = ++env->id_gen;
> > >  
> > >  			continue;
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 0312d9ce292f..f5b6b1f969d9 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -543,7 +543,7 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
> > >  static const char *reg_type_str(struct bpf_verifier_env *env,
> > >  				enum bpf_reg_type type)
> > >  {
> > > -	char postfix[16] = {0}, prefix[32] = {0};
> > > +	char postfix[16] = {0}, prefix[64] = {0};
> > >  	static const char * const str[] = {
> > >  		[NOT_INIT]		= "?",
> > >  		[SCALAR_VALUE]		= "scalar",
> > > @@ -575,16 +575,14 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
> > >  			strncpy(postfix, "_or_null", 16);
> > >  	}
> > >  
> > > -	if (type & MEM_RDONLY)
> > > -		strncpy(prefix, "rdonly_", 32);
> > > -	if (type & MEM_RINGBUF)
> > > -		strncpy(prefix, "ringbuf_", 32);
> > > -	if (type & MEM_USER)
> > > -		strncpy(prefix, "user_", 32);
> > > -	if (type & MEM_PERCPU)
> > > -		strncpy(prefix, "percpu_", 32);
> > > -	if (type & PTR_UNTRUSTED)
> > > -		strncpy(prefix, "untrusted_", 32);
> > > +	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s",
> > > +		 type & MEM_RDONLY ? "rdonly_" : "",
> > > +		 type & MEM_RINGBUF ? "ringbuf_" : "",
> > > +		 type & MEM_USER ? "user_" : "",
> > > +		 type & MEM_PERCPU ? "percpu_" : "",
> > > +		 type & PTR_UNTRUSTED ? "untrusted_" : "",
> > > +		 type & PTR_TRUSTED ? "trusted_" : ""
> > > +	);
> > >  
> > >  	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
> > >  		 prefix, str[base_type(type)], postfix);
> > > @@ -3844,7 +3842,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
> > >  			       struct bpf_reg_state *reg, u32 regno)
> > >  {
> > >  	const char *targ_name = kernel_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id);
> > > -	int perm_flags = PTR_MAYBE_NULL;
> > > +	int perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED;
> > >  	const char *reg_name = "";
> > >  
> > >  	/* Only unreferenced case accepts untrusted pointers */
> > > @@ -4707,6 +4705,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> > >  	if (type_flag(reg->type) & PTR_UNTRUSTED)
> > >  		flag |= PTR_UNTRUSTED;
> > >  
> > > +	/* Any pointer obtained from walking a trusted pointer is no longer trusted. */
> > > +	flag &= ~PTR_TRUSTED;
> > > +
> > >  	if (atype == BPF_READ && value_regno >= 0)
> > >  		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
> > >  
> > > @@ -5774,6 +5775,7 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
> > >  		PTR_TO_TCP_SOCK,
> > >  		PTR_TO_XDP_SOCK,
> > >  		PTR_TO_BTF_ID,
> > > +		PTR_TO_BTF_ID | PTR_TRUSTED,
> > >  	},
> > >  	.btf_id = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> > >  };
> > > @@ -5807,9 +5809,19 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
> > >  static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
> > >  static const struct bpf_reg_types ringbuf_mem_types = { .types = { PTR_TO_MEM | MEM_RINGBUF } };
> > >  static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
> > > -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
> > > +static const struct bpf_reg_types btf_ptr_types = {
> > > +	.types = {
> > > +		PTR_TO_BTF_ID,
> > > +		PTR_TO_BTF_ID | PTR_TRUSTED,
> > > +	},
> > > +};
> > >  static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
> > > -static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
> > > +static const struct bpf_reg_types percpu_btf_ptr_types = {
> > > +	.types = {
> > > +		PTR_TO_BTF_ID | MEM_PERCPU,
> > > +		PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED,
> > > +	}
> > > +};
> > >  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> > >  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> > >  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > > @@ -5897,7 +5909,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > >  	return -EACCES;
> > >  
> > >  found:
> > > -	if (reg->type == PTR_TO_BTF_ID) {
> > > +	if (base_type(reg->type) == PTR_TO_BTF_ID && !(type_flag(reg->type) & ~PTR_TRUSTED)) {

As mentioned above, this check is different than the one we're doing in
btf_ctx_access() when determining if the reg requires a ref_obj_id > 0.
This check is actually doing what you originally suggested above:

if (reg->type == PTR_TO_BTF_ID || reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED))

I think what you wrote is more readable and am happy to apply it to this
check in v8, but unfortunately I don't think we really have an
opportunity to avoid code duplication here with a helper (though a
helper may still improve readability).

Let me know your thoughts. I'll wait to post v8 until we've resolved
this.

> > >  		/* For bpf_sk_release, it needs to match against first member
> > >  		 * 'struct sock_common', hence make an exception for it. This
> > >  		 * allows bpf_sk_release to work for multiple socket types.
> > > @@ -5973,6 +5985,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> > >  	 * fixed offset.
> > >  	 */
> > >  	case PTR_TO_BTF_ID:
> > > +	case PTR_TO_BTF_ID | PTR_TRUSTED:
> > >  		/* When referenced PTR_TO_BTF_ID is passed to release function,
> > >  		 * it's fixed offset must be 0.	In the other cases, fixed offset
> > >  		 * can be non-zero.
> > > @@ -13690,6 +13703,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> > >  			break;
> > >  		case PTR_TO_BTF_ID:
> > >  		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
> > > +		case PTR_TO_BTF_ID | PTR_TRUSTED:
> > > +		case PTR_TO_BTF_ID | PTR_UNTRUSTED | PTR_TRUSTED:
> > >  			if (type == BPF_READ) {
> > >  				insn->code = BPF_LDX | BPF_PROBE_MEM |
> > >  					BPF_SIZE((insn)->code);
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index f2d8d070d024..5b9008bc597b 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -774,7 +774,7 @@ BPF_CALL_0(bpf_get_current_task_btf)
> > >  const struct bpf_func_proto bpf_get_current_task_btf_proto = {
> > >  	.func		= bpf_get_current_task_btf,
> > >  	.gpl_only	= true,
> > > -	.ret_type	= RET_PTR_TO_BTF_ID,
> > > +	.ret_type	= RET_PTR_TO_BTF_ID_TRUSTED,
> > >  	.ret_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
> > >  };
> > >  
> > > diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> > > index d15c91de995f..0006b5438ff7 100644
> > > --- a/net/ipv4/bpf_tcp_ca.c
> > > +++ b/net/ipv4/bpf_tcp_ca.c
> > > @@ -61,7 +61,9 @@ static bool bpf_tcp_ca_is_valid_access(int off, int size,
> > >  	if (!bpf_tracing_btf_ctx_access(off, size, type, prog, info))
> > >  		return false;
> > >  
> > > -	if (info->reg_type == PTR_TO_BTF_ID && info->btf_id == sock_id)
> > > +	if (base_type(info->reg_type) == PTR_TO_BTF_ID &&
> > > +	    !(type_flag(info->reg_type) & ~PTR_TRUSTED) &&
> > > +	    info->btf_id == sock_id)
> > >  		/* promote it to tcp_sock */
> > >  		info->btf_id = tcp_sock_id;
> > >  
> > > diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> > > index e1a937277b54..7ac947f00df4 100644
> > > --- a/tools/testing/selftests/bpf/verifier/calls.c
> > > +++ b/tools/testing/selftests/bpf/verifier/calls.c
> > > @@ -109,7 +109,7 @@
> > >  	},
> > >  	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
> > >  	.result = REJECT,
> > > -	.errstr = "arg#0 pointer type STRUCT prog_test_ref_kfunc must point",
> > > +	.errstr = "arg#0 pointer had unexpected modifiers",
> > >  	.fixup_kfunc_btf_id = {
> > >  		{ "bpf_kfunc_call_test_acquire", 3 },
> > >  		{ "bpf_kfunc_call_test_release", 5 },
> > > diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> > > index fd683a32a276..d9367f2894b9 100644
> > > --- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
> > > +++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> > > @@ -142,7 +142,7 @@
> > >  	.kfunc = "bpf",
> > >  	.expected_attach_type = BPF_LSM_MAC,
> > >  	.flags = BPF_F_SLEEPABLE,
> > > -	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
> > > +	.errstr = "arg#0 pointer had unexpected modifiers",
> > >  	.fixup_kfunc_btf_id = {
> > >  		{ "bpf_lookup_user_key", 2 },
> > >  		{ "bpf_key_put", 4 },
> > > @@ -163,7 +163,7 @@
> > >  	.kfunc = "bpf",
> > >  	.expected_attach_type = BPF_LSM_MAC,
> > >  	.flags = BPF_F_SLEEPABLE,
> > > -	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
> > > +	.errstr = "arg#0 pointer had unexpected modifiers",
> > >  	.fixup_kfunc_btf_id = {
> > >  		{ "bpf_lookup_system_key", 1 },
> > >  		{ "bpf_key_put", 3 },
> > > -- 
> > > 2.38.1
> > > 
