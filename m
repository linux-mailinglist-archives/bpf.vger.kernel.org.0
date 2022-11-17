Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384B562E9B4
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 00:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiKQXmI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 18:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKQXmH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 18:42:07 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5681769F7
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:42:05 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id e15so2321371qvo.4
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0XZ1sAi1IWebqPFpWsPU0YnwlVTOXegvTBOET6wqzs=;
        b=WDrOiaGgUOMPpsiniWid4/pX3HgvQAdyJqhIbNBOvglAExZTrZ3ndTgWqqPN+NSWLk
         OqYVQ475mMz0LPJBNQgRkGv6MxrHLA7i/GA5AkOA/vP1jC4sXtdeuc2DbmqmT6xN39zn
         UMKDjuVt724QUc/rb98OoJC/KOYs+LumPvRnC0RKHg8mAzR6+MG1kDFzUmqrKXUCGhLy
         nJOQqcj9K1wY8cR4xWY9hsqjm5NLKDkkUl4pQ1eau7ec5YjD+NTgpjWR6o/239HXNbOB
         GWh365aN9zTTa/3AkAeyfa7qQasOufAFZz/8iRg5UvzlSyauLgkeGI1QQyE2DovBZqle
         CooA==
X-Gm-Message-State: ANoB5pnuTI37/f3NSYurNbEaxnBsjTHaMuvmwC3+1jRiPHY5mzrpg/hi
        5cE4VCvNQwYuTyCsoo0LDZ8=
X-Google-Smtp-Source: AA0mqf7ZLSel2DZTofZ7ksw10xBILeqS34fu+++M0+6JlHIjUslF3g3VbO+U0ElTs4y3TY5cTBAoCQ==
X-Received: by 2002:a05:6214:81:b0:4bb:5931:f949 with SMTP id n1-20020a056214008100b004bb5931f949mr4801050qvr.66.1668728524701;
        Thu, 17 Nov 2022 15:42:04 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8ad4])
        by smtp.gmail.com with ESMTPSA id gb14-20020a05622a598e00b003a5d7b54894sm1129491qtb.31.2022.11.17.15.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:42:04 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:42:07 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/7] bpf: Rework check_func_arg_reg_off
Message-ID: <Y3bGz6glidknanpf@maniforge.lan>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-5-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115000130.1967465-5-memxor@gmail.com>
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

On Tue, Nov 15, 2022 at 05:31:27AM +0530, Kumar Kartikeya Dwivedi wrote:
> While check_func_arg_reg_off is the place which performs generic checks
> needed by various candidates of reg->type, there is some handling for
> special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
> ARG_PTR_TO_ALLOC_MEM.
> 
> This commit aims to streamline these special cases and instead leave
> other things up to argument type specific code to handle. The function
> will be restrictive by default, and cover all possible cases when
> OBJ_RELEASE is set, without having to update the function again (and
> missing to do that being a bug).
>
> This is done primarily for two reasons: associating back reg->type to
> its argument leaves room for the list getting out of sync when a new
> reg->type is supported by an arg_type.
>
> The other case is ARG_PTR_TO_ALLOC_MEM. The problem there is something
> we already handle, whenever a release argument is expected, it should
> be passed as the pointer that was received from the acquire function.
> Hence zero fixed and variable offset.
> 
> There is nothing special about ARG_PTR_TO_ALLOC_MEM, where technically
> its target register type PTR_TO_MEM | MEM_ALLOC can already be passed
> with non-zero offset to other helper functions, which makes sense.

Agreed -- just out of curiosity do you know what the rationale was for
it disallowing offsets in the first place?

> Hence, lift the arg_type_is_release check for reg->off and cover all
> possible register types, instead of duplicating the same kind of check
> twice for current OBJ_RELEASE arg_types (alloc_mem and ptr_to_btf_id).
> 
> For the release argument, arg_type_is_dynptr is the special case, where
> we go to actual object being freed through the dynptr, so the offset of
> the pointer still needs to allow fixed and variable offset and
> process_dynptr_func will verify them later for the release argument case
> as well.
> 
> This is not specific to ARG_PTR_TO_DYNPTR though, we will need to make
> this exception for any future object on the stack that needs to be
> released. In this sense, PTR_TO_STACK as a candidate for object on stack
> argument is a special case for release offset checks, and they need to
> be done by the helper releasing the object on stack.
> 
> Since the check has been lifted above all register type checks, remove
> the duplicated check that is being done for PTR_TO_BTF_ID.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 62 ++++++++++++-------
>  .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
>  2 files changed, 39 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c484e632b0cd..34e67d04579b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6092,11 +6092,38 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  			   const struct bpf_reg_state *reg, int regno,
>  			   enum bpf_arg_type arg_type)
>  {
> -	enum bpf_reg_type type = reg->type;
> -	bool fixed_off_ok = false;
> +	u32 type = reg->type;
>  
> -	switch ((u32)type) {
> -	/* Pointer types where reg offset is explicitly allowed: */
> +	/* When referenced register is passed to release function, it's fixed

s/it's/its

> +	 * offset must be 0.
> +	 *
> +	 * We will check arg_type_is_release reg has ref_obj_id when storing
> +	 * meta->release_regno.
> +	 */
> +	if (arg_type_is_release(arg_type)) {
> +		/* ARG_PTR_TO_DYNPTR with OBJ_RELEASE is a bit special, as it
> +		 * may not directly point to the object being released, but to
> +		 * dynptr pointing to such object, which might be at some offset
> +		 * on the stack. In that case, we simply to fallback to the
> +		 * default handling.
> +		 */

I personally am not a fan of this. We'd now have an entirely separate
branch of logic for most OBJ_RELEASE args, but then we fall through to
default handling for only PTR_TO_STACK specifically? That kind of
tactical complexity / readability tax is unfortunate, and adds up
quickly. It's already gotten pretty pervasive in the verifier, and I
personally would prefer to see us moving away from adding small one-off
conditional branches like this in the verifier when possible.

It seems to me like the problem we're trying to solve is that both arg
type and register type are relevant when detecting whether a register is
allowed to have nonzero offsets. It would be ideal if we could encode
some of this at build-time, similar to how we statically define and
compare compatible_reg_types in check_reg_type(). Is there some way for
us to do this for allowing offsets? Like maybe we can hoist some of the
build logic for how we define compatible_reg_types into a separate
table-like header file that can be included in multiple places to
construct statically-defined, constant arrays where all of this logic is
encoded? These check-offset / check-type functions could then really
just be lookups into these const arrays, and e.g. enabling new arg types
for register types could be captured by adding an entry to that
header-file table.

Maybe that's overkill for this specific example, but I really feel like
we need to start to try and move away from these one-off conditional
branches which collectively create a lot of complexity, and make it
difficult to reason about high-level correctness in the verifier.

To be clear: I won't block your change on this, but I'd like to hear
what you think about it as an idea, and I personally would really like
to see the verifier moving in that direction in general.

> +		if (!arg_type_is_dynptr(arg_type) || type != PTR_TO_STACK) {
> +			/* Doing check_ptr_off_reg check for the offset will
> +			 * catch this because fixed_off_ok is false, but
> +			 * checking here allows us to give the user a better
> +			 * error message.
> +			 */
> +			if (reg->off) {
> +				verbose(env, "R%d must have zero offset when passed to release func\n",
> +					regno);
> +				return -EINVAL;
> +			}

Why is this check necessary? To get a better error message in the
verifier if the register offset is nonzero? If so, IMO I don't think
that's a good enough reason to completely circumvent calling
__check_ptr_off_reg(). Not for correctness, but because it's
__check_ptr_off_reg()'s job to look at the register offset (that's what
the fixed_off_ok arg is for after all), and adding one-off checks like
which duplicate checks in other functions, it ends up ballooning the
code and complexity in the verifier. If we want to have a different
message for testing the offset being zero depending on the arg type,
that's where it belongs.

> +			return __check_ptr_off_reg(env, reg, regno, false);
> +		}
> +		/* Fallback to default handling */
> +	}
> +	switch (type) {
> +	/* Pointer types where both fixed and variable offset is explicitly allowed: */
>  	case PTR_TO_STACK:
>  		if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
>  			verbose(env, "cannot pass in dynptr at an offset\n");
> @@ -6113,35 +6140,22 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	case PTR_TO_BUF:
>  	case PTR_TO_BUF | MEM_RDONLY:
>  	case SCALAR_VALUE:
> -		/* Some of the argument types nevertheless require a
> -		 * zero register offset.
> -		 */
> -		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
> -			return 0;

Doesn't this result in a change of behavior beyond just verifying an
offset of 0? Before, in addition to checking offset 0, we were also
verifying that e.g. reg->off was nonnegative for ARG_PTR_TO_ALLOC_MEM.
Now we only do that if it's OBJ_RELEASE. I'm actually not following why
we wouldn't want to invoke __check_ptr_offset() for any of these other
register types.

> -		break;
> +		return 0;
>  	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
>  	 * fixed offset.
>  	 */
>  	case PTR_TO_BTF_ID:
>  		/* When referenced PTR_TO_BTF_ID is passed to release function,
>  		 * it's fixed offset must be 0.	In the other cases, fixed offset

Not your change, but while you're here could you please fix s/it's/its

> -		 * can be non-zero.
> +		 * can be non-zero. This was already checked above. So pass
> +		 * fixed_off_ok as true to allow fixed offset for all other
> +		 * cases. var_off always must be 0 for PTR_TO_BTF_ID, hence we
> +		 * still need to do checks instead of returning.
>  		 */
> -		if (arg_type_is_release(arg_type) && reg->off) {
> -			verbose(env, "R%d must have zero offset when passed to release func\n",
> -				regno);
> -			return -EINVAL;
> -		}
> -		/* For arg is release pointer, fixed_off_ok must be false, but
> -		 * we already checked and rejected reg->off != 0 above, so set
> -		 * to true to allow fixed offset for all other cases.
> -		 */
> -		fixed_off_ok = true;
> -		break;
> +		return __check_ptr_off_reg(env, reg, regno, true);
>  	default:
> -		break;
> +		return __check_ptr_off_reg(env, reg, regno, false);
>  	}
> -	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>  }
>  
>  static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> diff --git a/tools/testing/selftests/bpf/verifier/ringbuf.c b/tools/testing/selftests/bpf/verifier/ringbuf.c
> index b64d33e4833c..92e3f6a61a79 100644
> --- a/tools/testing/selftests/bpf/verifier/ringbuf.c
> +++ b/tools/testing/selftests/bpf/verifier/ringbuf.c
> @@ -28,7 +28,7 @@
>  	},
>  	.fixup_map_ringbuf = { 1 },
>  	.result = REJECT,
> -	.errstr = "dereference of modified alloc_mem ptr R1",
> +	.errstr = "R1 must have zero offset when passed to release func",
>  },
>  {
>  	"ringbuf: invalid reservation offset 2",
> -- 
> 2.38.1
> 
