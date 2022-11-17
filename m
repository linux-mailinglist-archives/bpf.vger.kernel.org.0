Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E750962E9DE
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 00:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiKQXt2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 18:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiKQXt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 18:49:27 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D2F79E28
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:49:26 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id z1so2402142qkl.9
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKefdm4Ol9ahkwr7LquHQ+4UQwIZr1m8j+txqDMTuYk=;
        b=F8sx1VFiO1tWO1n9U7Zp/b+Ycw9+qWWbkarTzZfn2DvQMBN2wSDBxGZTt7taDk7WrQ
         SY6vSuzFfquUCEZKkA8zpCKwtGBie5a5TYLy/TCypvEpORwov2zEmdOkaE3P2nQXLMV0
         fEuNNj8uKB8Rz1E+nOqPUEOV7ckfIn/UtBejX+7E642aAcAPFiaD3VrRECiqJd/cKMoE
         bfRI7kmIsr33g74W/lGohndrEJHxX5mvzNLXKMYs81gCT7RK3a9cXHzlfLe4RcUhvduA
         hukbDX3MWDNIJlGsi4rhCI+f3zK1UhatTzZmTk/SpVWcwVmamOV7utaREyh8dGEVq3hL
         L4ww==
X-Gm-Message-State: ANoB5pnJL9iuQ38Cb/twgQGW8xPtWPpq2Fku8vd8hB9izmADmGQU3KSI
        71R+GZPdOWFxaQxNF3FC/8E=
X-Google-Smtp-Source: AA0mqf5TcQf38MAyJ64kDRL2SKn3vNLMLZWdV213OanjSwtZec6my6mRTilhpCW1n8OGMCIG69g6sw==
X-Received: by 2002:a37:b746:0:b0:6fa:1d5c:ba00 with SMTP id h67-20020a37b746000000b006fa1d5cba00mr3737905qkf.202.1668728965156;
        Thu, 17 Nov 2022 15:49:25 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8ad4])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a240700b006e702033b15sm1452599qkn.66.2022.11.17.15.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:49:24 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:49:27 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Move PTR_TO_STACK alignment check
 to process_dynptr_func
Message-ID: <Y3bIhyOWs1r22R+2@maniforge.lan>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-6-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115000130.1967465-6-memxor@gmail.com>
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

On Tue, Nov 15, 2022 at 05:31:28AM +0530, Kumar Kartikeya Dwivedi wrote:
> After previous commit, we are minimizing helper specific assumptions
> from check_func_arg_reg_off, making it generic, and offloading checks
> for a specific argument type to their respective functions called after
> check_func_arg_reg_off has been called.

What's the point of check_func_arg_reg_off() if helpers have to check
offsets after it's been called? Also, in [0], there's now logic in
check_func_arg_reg_off() which checks for OBJ_RELEASE arg types, so
there's still a precedent for looking at arg types there. IMO it's
actually less confusing to just push as much offset checking as possible
into one place.

[0]: https://lore.kernel.org/all/20221115000130.1967465-5-memxor@gmail.com/

> This allows relying on a consistent set of guarantees after that call
> and then relying on them in code that deals with registers for each
> argument type later. This is in line with how process_spin_lock,
> process_timer_func, process_kptr_func check reg->var_off to be constant.
> The same reasoning is used here to move the alignment check into
> process_dynptr_func. Note that it also needs to check for constant
> var_off, and accumulate the constant var_off when computing the spi in
> get_spi, but that fix will come in later changes.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 34e67d04579b..fd292f762d53 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5774,6 +5774,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>  		return -EFAULT;
>  	}
>  
> +	/* CONST_PTR_TO_DYNPTR already has fixed and var_off as 0 due to
> +	 * check_func_arg_reg_off's logic. We only need to check offset
> +	 * alignment for PTR_TO_STACK.
> +	 */
> +	if (reg->type == PTR_TO_STACK && (reg->off % BPF_REG_SIZE)) {
> +		verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> +		return -EINVAL;
> +	}

As alluded to above, I personally think it's more confusing to have this
check in process_dynptr_func(). On the one hand you have
check_func_arg_reg_off() which verifies that a register has the correct
offset, but then here we have to check for the register offset for
PTR_TO_STACK dynptrs specifically? Wouldn't it be better to try and push
as much of the offset-checking complexity into one place as possible?

>  	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
>  	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
>  	 *
> @@ -6125,11 +6133,6 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	switch (type) {
>  	/* Pointer types where both fixed and variable offset is explicitly allowed: */
>  	case PTR_TO_STACK:
> -		if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
> -			verbose(env, "cannot pass in dynptr at an offset\n");
> -			return -EINVAL;
> -		}
> -		fallthrough;
>  	case PTR_TO_PACKET:
>  	case PTR_TO_PACKET_META:
>  	case PTR_TO_MAP_KEY:
> -- 
> 2.38.1
> 
