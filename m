Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DBB69A7CB
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 10:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBQJGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 04:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBQJGJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 04:06:09 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311FC5FBFE
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 01:06:08 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id o102so660770qvo.0
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 01:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4p07mdo4O1kAC4M9tEfoLRTI790ovMC9GRvMZKzlD2U=;
        b=aEQQAJPXWabDjps06YwVNzaXzXFO60efxIFM5ws9vinsS07Moxz8wpPrMGsXbbYC3U
         Qkxon6lDavJVBWy4EU+gWytEJNxZ8YQGNynCB6eNDueV/DBdAzkv4n2G89ZE5PKJ6cwi
         aaMqyIyu4hNwyCeFKa01J4UL+IpGwSVgiP+KKjsemJovXpiXuFjCFB7vuqSFf6bvfCAH
         YQyGGtH92FHMwFMyhnnVGFk3kF6nKaFdr1/TPLs5w0dj8myjXplgOk4EOqy0bxnnFQXq
         sKtiqdIlcc2XCLn+OYCPSC9JKU0JwVZznP8JVEgHvkImmfwIVH1nvqFzV9WwbaEnpLYQ
         YIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p07mdo4O1kAC4M9tEfoLRTI790ovMC9GRvMZKzlD2U=;
        b=0ZYHGLeDgzHrmtPxIyogPXczGKI1maXtvm2dwPnkuitkX12tHM6bUibeVrj07by1ie
         HDKuumIUgz83MlflBNx8Raiha58gLpBf793BnvhIMcHhwKstyQMEkEajLw1TBcCHGwg8
         YEMxp4VnwcD/OMU7RZs9UntOQvB1OYolBPZll6oIQpeDH0r8hq6kaEowtR69hnRUCQUz
         5Is2VRYyLKf55v90aPqum/DM6tcJ9TNqQ9CFNsMs8jcWsmx7ZJx4Po8RUeuZY+ZXjMjG
         Yw1TVC3sTKVv52MXLz12gJG3veOwBSMP/XMisRUB+3qpMHL5okWu0Fh8ktUyOB6TojsM
         PjYQ==
X-Gm-Message-State: AO0yUKWA5JL3VCeFi/gVXEhEtxjM3s9p8W8klZjuPI5K+ZHEX6UnU+Hg
        xQIeODgrf9c5hD2FxAHx+JA=
X-Google-Smtp-Source: AK7set/lnCFNe/sasa3KLqD9bSO8fuT7HhwVwwa9fFBP1of+8o8ydcFvmlTob21g28m0RSXdDdittQ==
X-Received: by 2002:a05:6214:2404:b0:537:7d76:ea7c with SMTP id fv4-20020a056214240400b005377d76ea7cmr923480qvb.25.1676624767299;
        Fri, 17 Feb 2023 01:06:07 -0800 (PST)
Received: from krava ([213.208.157.36])
        by smtp.gmail.com with ESMTPSA id f5-20020a37d205000000b00729b7d71ac7sm2910126qkj.33.2023.02.17.01.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:06:06 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 17 Feb 2023 10:05:58 +0100
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH v1 bpf-next] bpf: Tidy up verifier checking
Message-ID: <Y+9Ddvey0iPgC8ZS@krava>
References: <20230217005451.2438147-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217005451.2438147-1-joannelkoong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 16, 2023 at 04:54:51PM -0800, Joanne Koong wrote:
> This change refactors check_mem_access() to check against the base type of
> the register, and uses switch case checking instead of if / else if
> checks. This change also uses the existing clear_called_saved_regs()
> function for resetting caller saved regs in check_helper_call().
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  kernel/bpf/verifier.c | 67 +++++++++++++++++++++++++++++--------------
>  1 file changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 272563a0b770..b40165be2943 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5317,7 +5317,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  	/* for access checks, reg->off is just part of off */
>  	off += reg->off;
>  
> -	if (reg->type == PTR_TO_MAP_KEY) {
> +	switch (base_type(reg->type)) {
> +	case PTR_TO_MAP_KEY:
>  		if (t == BPF_WRITE) {
>  			verbose(env, "write to change key R%d not allowed\n", regno);
>  			return -EACCES;
> @@ -5329,7 +5330,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  			return err;
>  		if (value_regno >= 0)
>  			mark_reg_unknown(env, regs, value_regno);
> -	} else if (reg->type == PTR_TO_MAP_VALUE) {
> +
> +		break;
> +	case PTR_TO_MAP_VALUE:
> +	{

I'm getting failure in this test:
  #92/1    jeq_infer_not_null/jeq_infer_not_null_ptr_to_btfid:FAIL

I wonder with this change we execute this case even if there's PTR_MAYBE_NULL set,
which we did not do before, so the test won't fail now as expected

>  		struct btf_field *kptr_field = NULL;
>  
>  		if (t == BPF_WRITE && value_regno >= 0 &&
> @@ -5369,7 +5373,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  				mark_reg_unknown(env, regs, value_regno);
>  			}
>  		}
> -	} else if (base_type(reg->type) == PTR_TO_MEM) {
> +		break;
> +	}

SNIP

> @@ -5521,7 +5539,17 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  
>  		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
>  			mark_reg_unknown(env, regs, value_regno);
> -	} else {
> +		break;
> +	}
> +	case PTR_TO_BTF_ID:
> +		if (!type_may_be_null(reg->type)) {
> +			err = check_ptr_to_btf_access(env, regs, regno, off, size, t,
> +						      value_regno);
> +			break;
> +		} else {
> +			fallthrough;
> +		}

nit, no need for the else branch, just use fallthrough directly

> +	default:
>  		verbose(env, "R%d invalid mem access '%s'\n", regno,
>  			reg_type_str(env, reg->type));
>  		return -EACCES;
> @@ -8377,10 +8405,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		return err;
>  
>  	/* reset caller saved regs */

nit, we could remove the comment as well, the function name says it all

jirka

> -	for (i = 0; i < CALLER_SAVED_REGS; i++) {
> -		mark_reg_not_init(env, regs, caller_saved[i]);
> -		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> -	}
> +	clear_caller_saved_regs(env, regs);
>  
>  	/* helper call returns 64-bit value. */
>  	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> -- 
> 2.30.2
> 
