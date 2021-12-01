Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB4746572C
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 21:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhLAUeM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 15:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhLAUeL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 15:34:11 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C953C061574
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 12:30:49 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b13so18627834plg.2
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 12:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7cePK99ShlEXSt+RrvkrdAxNnJ+46voFWERFQjpBiZU=;
        b=nYr5G+8Dq2QoqbhfanRXRzmDNdkUIYKzYvgxD0XED6WWyAEy3kUF/BejOvrBxF3Byz
         PtPsAsX2kimyyY31JX3fYezbp2KpL0nwi6W34U7AaYxEhZSiG/hhcUQ8Cj58zxc2tN1P
         e94rVxlOKuSWYLcplCRW9ck+A/MnpTrvVvRjGAZ3cdD46E4HhxgXK1Cb+1p39KkrNucx
         jX/LbKL73pFoW/F3Jt+bYiXnaeRoITyW/gkPXxkAP7LDAnHOjhT+nYpSAj0S+NDcM5MK
         lT8YqoIsjqEBzkLs5qyu2dZyudYCNuoAmqTgLyAiEsKA5ttUuxEbw/7xdDqkO09vQc87
         GduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7cePK99ShlEXSt+RrvkrdAxNnJ+46voFWERFQjpBiZU=;
        b=X69BOGbpc/Sn0YDY2QqSOPPHV60z0eUUXYnfjHSznx/u3aUxfOQbjKgl1731aPG1a2
         rlYbZNNBfFCj8OJAGaP6/Y548pAg4wtxTmPG9Y7rAiJJWLzSM3iR/dHxb4BbdmaeLJ/x
         vDBc0Fg78I1vR0sNeXjJU3POWHk1flDpbaaSgmN5+cXqyV3RDoHWd+uzwtwS0/dxkcQg
         SM2A8JeLYs23neyk7elbZXzwIfNL80TT7wEvVWNe/SK/WT0s55vhpot082JbmYOEWzZT
         veW8GVVWFXAiJ1CJsdUJMPAf5m2O4k+ZqXMt3JgHeHOE7hLe3grJcQh/yhBeSAgcTnkK
         X0tQ==
X-Gm-Message-State: AOAM532fynugF0rh9m9hVt4ydMPdfOmFt+gIgDEjjTt7oSuPezwJtvfh
        wvcoF/WCiuAEatGDZc9lR1c=
X-Google-Smtp-Source: ABdhPJx0g3JE3q9I3ci4tgevrY268OnXYNX/IhY2a04qkV9gNSbJZPQh59Vdmcb2/SvgCjyO2kPvzw==
X-Received: by 2002:a17:90b:1bc3:: with SMTP id oa3mr644264pjb.52.1638390648874;
        Wed, 01 Dec 2021 12:30:48 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id 7sm444968pgk.55.2021.12.01.12.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:30:48 -0800 (PST)
Date:   Wed, 1 Dec 2021 12:30:46 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 3/9] bpf: Replace RET_XXX_OR_NULL with
 RET_XXX | PTR_MAYBE_NULL
Message-ID: <20211201203046.saxv5hl7zz3wzyvv@ast-mbp.dhcp.thefacebook.com>
References: <20211130012948.380602-1-haoluo@google.com>
 <20211130012948.380602-4-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130012948.380602-4-haoluo@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 05:29:42PM -0800, Hao Luo wrote:
>  	/* update return register (already marked as written above) */
> -	if (fn->ret_type == RET_INTEGER) {
> +	ret_type = fn->ret_type;
> +	if (ret_type == RET_INTEGER) {
>  		/* sets type to SCALAR_VALUE */
>  		mark_reg_unknown(env, regs, BPF_REG_0);
> -	} else if (fn->ret_type == RET_VOID) {
> +	} else if (ret_type == RET_VOID) {
>  		regs[BPF_REG_0].type = NOT_INIT;
> -	} else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL ||
> -		   fn->ret_type == RET_PTR_TO_MAP_VALUE) {
> +	} else if (BPF_BASE_TYPE(ret_type) == RET_PTR_TO_MAP_VALUE) {
>  		/* There is no offset yet applied, variable or fixed */
>  		mark_reg_known_zero(env, regs, BPF_REG_0);
>  		/* remember map_ptr, so that check_map_access()
> @@ -6530,28 +6536,27 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		}
>  		regs[BPF_REG_0].map_ptr = meta.map_ptr;
>  		regs[BPF_REG_0].map_uid = meta.map_uid;
> -		if (fn->ret_type == RET_PTR_TO_MAP_VALUE) {
> +		if (ret_type_may_be_null(fn->ret_type)) {

it should have been ret_type here?

> +			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
> +		} else {
>  			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
