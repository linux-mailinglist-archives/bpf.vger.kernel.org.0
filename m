Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB657C589
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 09:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiGUHvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 03:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUHvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 03:51:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8337166BBA
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 00:51:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id oy13so1774511ejb.1
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 00:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b9GU8dI9JjSvJNh8GYyo6nJy0sYt5AWIiKCovWh5cO8=;
        b=d45M4Oszek93NKAqykToU16aPcZx3TW4M16Cs1DGfj8FLWdHPGEJ/4zHs7BhPGobzs
         1VAmiaUpi4aXJO44FCF8m/9snoYdeDstCkvXWG5Q6EyE/EpyB4bkJewhMRqrRWcrhl2w
         hkQOO74gE4GMi3TPKTeMW2d4XRz78r4DAzZzwUdDcM+Lfp3Mfk2vzDEMDl13YOFyKr1M
         +yYTgMAsHbP8Ui154OuIlhNPGsRLUHewxQXbDJ9wjWd2OJ9q3MPUr5CsGmYzRc9GLctW
         NCm7lkg277V+4Nm1U5wQ6PfTkv2qXoBhbwVYjFWeyTaF+STUvzHofCNy+qlztxqV1mag
         0ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9GU8dI9JjSvJNh8GYyo6nJy0sYt5AWIiKCovWh5cO8=;
        b=5hHvm47mw9k3KBUEWtFEN6AuSLfbn9M/Lgi7CQ2Js7fAcew6epRtkh6CVFfn+rPQwm
         AeEMziLzX7pn4THZo2bX8iFHSGx7tjMFnk2QX/rSA8fEA8bFZqSG/97DAaBhAhQoC9iV
         339yHakI1qzKKpx/6dj7sEfZ05Dd38HXiYwdVgibMXQhKJ2E/V0rLFbcSq6nr3hFEKMz
         3eVfWmwGiNBQDThOXTErwqB+QG0ZtJD94xnDDyBwCkKqI6VOnTk8jzg59bamIjkjnMwu
         Uz0FKB0G23Mhy2zFqtBEMPndXyUXeUBrlUnqNdhO928cjIaNirUXXtJiK0gsk/T8xX+x
         vWBw==
X-Gm-Message-State: AJIora80BTyTXbCkBwYHptouMqCY9q9b+bj+97ulXqIxwaLe4Lj8YTcx
        RS6UT29y2hVrCGr+iBN5bXM=
X-Google-Smtp-Source: AGRyM1tC+TA3i2VDT0FCfZUNu1PN5en9WTa+6FlZIJIA3ZQsCgZKRel2hVVuXmzOcJtdKXJsni1xsA==
X-Received: by 2002:a17:907:d28:b0:72b:5cc9:99c with SMTP id gn40-20020a1709070d2800b0072b5cc9099cmr39480035ejc.228.1658389860022;
        Thu, 21 Jul 2022 00:51:00 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402040600b0043bc33530ddsm569186edv.32.2022.07.21.00.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 00:50:59 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 21 Jul 2022 09:50:57 +0200
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix ref_obj_id for dynptr data
 slices in verifier
Message-ID: <YtkFYeQwjqSZ2GOW@krava>
References: <20220721024821.251231-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721024821.251231-1-joannelkoong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 07:48:20PM -0700, Joanne Koong wrote:
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
> Fixes: 34d4ef5775f7("bpf: Add dynptr data slices");
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

LGTM

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/verifier.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c59c3df0fea6..00f9b5a77734 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7341,6 +7341,22 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  			}
>  		}
>  		break;
> +	case BPF_FUNC_dynptr_data:
> +		/* Find the id of the dynptr we're tracking the reference of.
> +		 * We must do this before we reset caller saved regs.
> +		 *
> +		 * Please note as well that meta.ref_obj_id after the check_func_arg() calls doesn't
> +		 * already contain the dynptr ref obj id, since dynptrs are stored on the stack.
> +		 */
> +		for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> +			if (arg_type_is_dynptr(fn->arg_type[i])) {
> +				if (meta.ref_obj_id) {
> +					verbose(env, "verifier internal error: multiple refcounted args in func\n");
> +					return -EFAULT;
> +				}
> +				meta.ref_obj_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> +			}
> +		}
>  	}
>  
>  	if (err)
> @@ -7470,20 +7486,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		/* For release_reference() */
>  		regs[BPF_REG_0].ref_obj_id = id;
>  	} else if (func_id == BPF_FUNC_dynptr_data) {
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
>  		/* For release_reference() */
> -		regs[BPF_REG_0].ref_obj_id = dynptr_id;
> +		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
>  	}
>  
>  	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
> -- 
> 2.30.2
> 
