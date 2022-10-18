Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C458160350C
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 23:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJRViY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 17:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJRViX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 17:38:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A0D638CC
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 14:38:22 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h2-20020a170902f54200b0018553a8b797so4035266plf.9
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrexORFQfiEbjy28h/vJrT6+ELr67H1N+YuBlJ6Y7HI=;
        b=tDOn7YkjEXdtM6fmCQSGhgp8tzVhCv5Wnj8jSnXysabkTx2GhYB/q7hcfeiEcZPxLA
         tEE09gCpWMsCLrkvpyxadvUA2x6ycM32Mxv8Z+Gh1Cid5pAu5YsbODWyVeXKsU5A9FMm
         ai/cSq6lMSKE3fbYqXR0S7bwgdeDcKBJD/rYywdGGccfGU0kby/IUwT5PrLklv8BY2hZ
         ddXbMMWyJ/iGTp2O+w194WsQnxV6XnH2YfAirN2wtjIfnJ9I9DJZU+JA7KaYiTywllcR
         M4yXsSB7/XoaCRQH7hONAt2VHSu1xwSSAGxM8WaF+Tz469e5HxHRjH8dcS0et+WrC7/M
         qVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrexORFQfiEbjy28h/vJrT6+ELr67H1N+YuBlJ6Y7HI=;
        b=vIIve9/+Zqmq4RSnFbQh0zr2am9BDfVplQNMloyEixrkX+eqTaMm0nY7AxzicRg4mw
         A+pTFY2Suhgb98AouZHMJ9f8hpGtenkkQHwO5QeA2ufqJ6zBE2CqYBHksIgMN9zdX6La
         /eJpdHWurQ+Edmgz9HsCvmJtmXl14mrWyhQsTCJ2ZaxTiEj4jayFeD0RPpdX1y+CM3cO
         vWeD0mhU9oFdOQfH5po7t1qmrISjsfM7MRGWj+ITFQB6ugNMRlKeAYmexlRC9Th9MQ+F
         poBa9haQAMY1caZPFXyaOoK1DRQLNYqD49vst3FmWgHCbQTS+H4qTbS6+qgVwHQ3naAH
         GYog==
X-Gm-Message-State: ACrzQf1oZtYRqxy8jTvF8UdThs3+VtWGnQkpPMzksPRzhuZjNsLzaNrN
        xJP1Kth7au1jCdNP5AN+xY1/n3o=
X-Google-Smtp-Source: AMsMyM6XgnzCOdc8H97zb8l7Rx2mSHkyMC2UfKu/aFbcffZVbYGVciUUcSLDhrzByNwLlmro0wXYkPs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1ace:b0:565:f52a:d998 with SMTP id
 f14-20020a056a001ace00b00565f52ad998mr5224798pfv.25.1666129102488; Tue, 18
 Oct 2022 14:38:22 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:38:21 -0700
In-Reply-To: <20221018135920.726360-4-memxor@gmail.com>
Mime-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-4-memxor@gmail.com>
Message-ID: <Y08czdCQgMig/Wir@google.com>
Subject: Re: [PATCH bpf-next v1 03/13] bpf: Rename confusingly named RET_PTR_TO_ALLOC_MEM
From:   sdf@google.com
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/18, Kumar Kartikeya Dwivedi wrote:
> Currently, the verifier has two return types, RET_PTR_TO_ALLOC_MEM, and
> RET_PTR_TO_ALLOC_MEM_OR_NULL, however the former is confusingly named to
> imply that it carries MEM_ALLOC, while only the latter does. This causes
> confusion during code review leading to conclusions like that the return
> value of RET_PTR_TO_DYNPTR_MEM_OR_NULL (which is RET_PTR_TO_ALLOC_MEM |
> PTR_MAYBE_NULL) may be consumable by bpf_ringbuf_{submit,commit}.

> Rename it to make it clear MEM_ALLOC needs to be tacked on top of
> RET_PTR_TO_MEM.

> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   include/linux/bpf.h   | 6 +++---
>   kernel/bpf/verifier.c | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 13c6ff2de540..834276ba56c9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -538,7 +538,7 @@ enum bpf_return_type {
>   	RET_PTR_TO_SOCKET,		/* returns a pointer to a socket */
>   	RET_PTR_TO_TCP_SOCK,		/* returns a pointer to a tcp_sock */
>   	RET_PTR_TO_SOCK_COMMON,		/* returns a pointer to a sock_common */
> -	RET_PTR_TO_ALLOC_MEM,		/* returns a pointer to dynamically allocated  
> memory */
> +	RET_PTR_TO_MEM,			/* returns a pointer to dynamically allocated memory  
> */

What about the comment? It still says that it's a pointer to a
dynamically allocated memory :-/ Does it make sense to clarify it as
well?

>   	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a  
> btf_id */
>   	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
>   	__BPF_RET_TYPE_MAX,
> @@ -548,8 +548,8 @@ enum bpf_return_type {
>   	RET_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
>   	RET_PTR_TO_TCP_SOCK_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
>   	RET_PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL |  
> RET_PTR_TO_SOCK_COMMON,
> -	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_ALLOC |  
> RET_PTR_TO_ALLOC_MEM,
> -	RET_PTR_TO_DYNPTR_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
> +	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_ALLOC |  
> RET_PTR_TO_MEM,
> +	RET_PTR_TO_DYNPTR_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_MEM,
>   	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,

>   	/* This must be the last entry. Its purpose is to ensure the enum is
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 87d9cccd1623..a49b95c1af1b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7612,7 +7612,7 @@ static int check_helper_call(struct  
> bpf_verifier_env *env, struct bpf_insn *insn
>   		mark_reg_known_zero(env, regs, BPF_REG_0);
>   		regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
>   		break;
> -	case RET_PTR_TO_ALLOC_MEM:
> +	case RET_PTR_TO_MEM:
>   		mark_reg_known_zero(env, regs, BPF_REG_0);
>   		regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
>   		regs[BPF_REG_0].mem_size = meta.mem_size;
> --
> 2.38.0

