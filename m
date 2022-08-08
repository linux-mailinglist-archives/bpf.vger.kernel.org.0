Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D45958CF84
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 23:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiHHVOi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiHHVOi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 17:14:38 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009418352
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:14:37 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id y11so7281340qvn.3
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 14:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=l/Xv5r9OrnZrhHw6KcL8EwEA8t9NUvf7qrtlt1u02IM=;
        b=WkJhMqmvFBtyfgEP0kQ63D3Pn0IOL03/CWUH+iE8i1K44Hqd1jqS/0aKxED/fYKaFx
         kjJEcx3N4xmNwIS4rYOIWgnIT8O7B/7E/kuIOdGa4J8uMW/hYgIfrzDWhSMELCouVDDB
         HRSOF8CDUTwzP5h9F47V+GFoRNpqo2LpOjhDc5OvvlPzsC599UUuCzXtSmOOfkDqobO9
         MSJ3W+mP4k57GBHpcjMg2w3Zwc4iUO6/57X4GieAIHNnvUMAc+wbK2VCA6Ui0eZF9FZP
         WfXJ1Tz6/U6Kry+GmfqmJmgavkpu6+MNpaT2q8UwiwCMwXobEDEL3P7f6vP7UkMRlOXl
         Hqdw==
X-Gm-Message-State: ACgBeo0k2cKqwHa547GOA9u3tH9ATDyp4aYvlrTW6VmQEAq0Kvss32Et
        YMWrtCedKPeApTtD70s+xLM=
X-Google-Smtp-Source: AA6agR6mpSq6B/Smglcj/fXhvKHfUui9BTCYtxXKTzWQX2FAP8pSmxdtOhPjQVWpH2m436/S4cBrUQ==
X-Received: by 2002:a05:6214:2b0f:b0:478:5319:c4ff with SMTP id jx15-20020a0562142b0f00b004785319c4ffmr16936940qvb.66.1659993276127;
        Mon, 08 Aug 2022 14:14:36 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-013.fbsv.net. [2a03:2880:20ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id h126-20020a375384000000b006b5cb0c512asm9631531qkb.101.2022.08.08.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 14:14:35 -0700 (PDT)
Date:   Mon, 8 Aug 2022 14:14:33 -0700
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, jolsa@kernel.org,
        haoluo@google.com, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix ref_obj_id for dynptr data
 slices in verifier
Message-ID: <20220808211433.oz3fuvtayfdwrnwi@dev0025.ash9.facebook.com>
References: <20220722175807.4038317-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722175807.4038317-1-joannelkoong@gmail.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 10:58:06AM -0700, Joanne Koong wrote:
> When a data slice is obtained from a dynptr (through the bpf_dynptr_data API),
> the ref obj id of the dynptr must be found and then associated with the data
> slice.
> 
> The ref obj id of the dynptr must be found *before* the caller saved regs are
> reset. Without this fix, the ref obj id tracking is not correct for
> dynptrs that are at an offset from the frame pointer.
> 
> Please also note that the data slice's ref obj id must be assigned after the
> ret types are parsed, since RET_PTR_TO_ALLOC_MEM-type return regs get
> zero-marked.
> 
> Fixes: 34d4ef5775f776ec4b0d53a02d588bf3195cada6 ("bpf: Add dynptr data slices");
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Hi Joanne,

Overall this looks great, thanks. Just a couple small comments / questions.

>  kernel/bpf/verifier.c | 62 ++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c59c3df0fea6..29987b2ea26f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5830,7 +5830,8 @@ static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state
>  
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			  struct bpf_call_arg_meta *meta,
> -			  const struct bpf_func_proto *fn)
> +			  const struct bpf_func_proto *fn,
> +			  int func_id)

Can we get the func_id from meta instead of adding another argument? It
looks like the func_id is stored there before we call check_func_arg.

>  {
>  	u32 regno = BPF_REG_1 + arg;
>  	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> @@ -6040,23 +6041,33 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			}
>  
>  			meta->uninit_dynptr_regno = regno;
> -		} else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> -			const char *err_extra = "";
> +		} else {
> +			if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> +				const char *err_extra = "";
>  
> -			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> -			case DYNPTR_TYPE_LOCAL:
> -				err_extra = "local ";
> -				break;
> -			case DYNPTR_TYPE_RINGBUF:
> -				err_extra = "ringbuf ";
> -				break;
> -			default:
> -				break;
> -			}
> +				switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> +				case DYNPTR_TYPE_LOCAL:
> +					err_extra = "local ";
> +					break;
> +				case DYNPTR_TYPE_RINGBUF:
> +					err_extra = "ringbuf ";
> +					break;
> +				default:
> +					break;
> +				}
>  
> -			verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> -				err_extra, arg + 1);
> -			return -EINVAL;
> +				verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> +					err_extra, arg + 1);
> +				return -EINVAL;
> +			}
> +			if (func_id == BPF_FUNC_dynptr_data) {
> +				if (meta->ref_obj_id) {
> +					verbose(env, "verifier internal error: multiple refcounted args in BPF_FUNC_dynptr_data");
> +					return -EFAULT;
> +				}
> +				/* Find the id of the dynptr we're tracking the reference of */
> +				meta->ref_obj_id = stack_slot_get_id(env, reg);
> +			}
>  		}
>  		break;
>  	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
> @@ -7227,7 +7238,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	meta.func_id = func_id;
>  	/* check args */
>  	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> -		err = check_func_arg(env, i, &meta, fn);
> +		err = check_func_arg(env, i, &meta, fn, func_id);
>  		if (err)
>  			return err;
>  	}
> @@ -7457,7 +7468,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	if (type_may_be_null(regs[BPF_REG_0].type))
>  		regs[BPF_REG_0].id = ++env->id_gen;
>  
> -	if (is_ptr_cast_function(func_id)) {
> +	if (is_ptr_cast_function(func_id) || func_id == BPF_FUNC_dynptr_data) {

Just a nit and my two cents, but IMO, is_ptr_cast_function() feels like a
bit of an unclear function name. It's only used for this specific if
statement, so maybe we should change that function name to something like
is_meta_stored_ref() and just add BPF_FUNC_dynptr_data to that list?

>  		/* For release_reference() */
>  		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
>  	} else if (is_acquire_function(func_id, meta.map_ptr)) {
> @@ -7469,21 +7480,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		regs[BPF_REG_0].id = id;
>  		/* For release_reference() */
>  		regs[BPF_REG_0].ref_obj_id = id;
> -	} else if (func_id == BPF_FUNC_dynptr_data) {
> -		int dynptr_id = 0, i;
> -
> -		/* Find the id of the dynptr we're acquiring a reference to */
> -		for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> -			if (arg_type_is_dynptr(fn->arg_type[i])) {
> -				if (dynptr_id) {
> -					verbose(env, "verifier internal error: multiple dynptr args in func\n");
> -					return -EFAULT;
> -				}
> -				dynptr_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> -			}
> -		}
> -		/* For release_reference() */
> -		regs[BPF_REG_0].ref_obj_id = dynptr_id;
>  	}
>  
>  	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
> -- 
> 2.30.2
> 

Looks good otherwise, as mentioned above.

Thanks,
David
