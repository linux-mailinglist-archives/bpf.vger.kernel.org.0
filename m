Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51935B48D3
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIJUfp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 16:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIJUfo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 16:35:44 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEE03AB08
        for <bpf@vger.kernel.org>; Sat, 10 Sep 2022 13:35:40 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id g4-20020aa78184000000b0053e70e333c6so2997314pfi.2
        for <bpf@vger.kernel.org>; Sat, 10 Sep 2022 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Vd7nhzv/O6fKSD39SGDLKzKBCJiQ/3Jnc+Mcf/pOolY=;
        b=dHvMoteWHwMFmM1IRvoNcI9ZL1S3Z71NwWPYAXF2mS9Gn1AbTyJ5IQ/L/mV2soFv7U
         QarCTSRqBCMpTztl6XUebVHSkqsrMFhoYtuODr2kt9XZ8yGbdeBQevBPt+B8/1Hnzm9N
         O3ARNrOz85CyBh89+MLGOBdGdTlI5iXIdFbwsHv6idFdT87ev6Ef/XHBUzd/7+7/gtsv
         vlqg5ldx7Mka5k3yx5IuT2CF/gIeIPyuy13hAK08QDkzM1soYzOZknMeUzVHPIe30R+T
         1rg10sW+G56EPBXOtSYnpUldtx8iB0YDEgS7oS7BYd7h5/qtNNbxBSQnv8MF8My4K/Lm
         RfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Vd7nhzv/O6fKSD39SGDLKzKBCJiQ/3Jnc+Mcf/pOolY=;
        b=AiezBGFzWvIOTlWZrYYgo1zyg8IhUpnkS8fuOV/RGsbY8HBCfLCVAzIJph2o8NSkqn
         jZY9O10dAibZ9jh2q0rKPmAR1+PHcHWQekFhXZbeQUrXXzzDelpytR6RAPz29F3Rh/Yy
         hwxnQKgrEHtXawXgBpit9EAl2KikuLWNQWt773LQ1sR/iLUMSIDbvw5hJzQNZ/zZYWOf
         k6h0bOJRa32anvwNiw8HA2Gj+eN5zJ+8rgwOYDeVrdn1E5Ml3UGT4ELXQlSZBRRCSpbD
         m+W6febBkW6HiA9OcDGEjCkB/yN5T83Ix0x8dJyhym5jfHNqcJl8N6Gif5PVNaSw3rp5
         6qWA==
X-Gm-Message-State: ACgBeo0yxYK8dME3Zj9LO9pvavdKGib4D9Jd+8YjrLVrbz0Kk6XmTBYx
        bFOcBbNc6ij9CJGQ6kmoNDuLvHI=
X-Google-Smtp-Source: AA6agR4EpDbq1ccAGO47ZSaCVLiFcED0OQ4x8EF6xd5xTjDCIuAg/AeUbonP/3/7gpKZ8+EPXCHscT0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1892:b0:540:acee:29e8 with SMTP id
 x18-20020a056a00189200b00540acee29e8mr13104410pfh.1.1662842140157; Sat, 10
 Sep 2022 13:35:40 -0700 (PDT)
Date:   Sat, 10 Sep 2022 13:35:38 -0700
In-Reply-To: <20220910025214.1536510-1-yhs@fb.com>
Mime-Version: 1.0
References: <20220910025214.1536510-1-yhs@fb.com>
Message-ID: <Yxz1GvdTlVKrN6Aq@google.com>
Subject: Re: [PATCH bpf-next] libbpf: Improve BPF_PROG2 macro code quality and description
From:   sdf@google.com
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/09, Yonghong Song wrote:
> Commit 34586d29f8df ("libbpf: Add new BPF_PROG2 macro") added BPF_PROG2
> macro for trampoline based programs with struct arguments. Andrii
> made a few suggestions to improve code quality and description.
> This patch implemented these suggestions including better internal
> macro name, consistent usage pattern for __builtin_choose_expr(),
> simpler macro definition for always-inline func arguments and
> better macro description.

Not sure if Andrii wants to take a look, if not feel free to use:

Acked-by: Stanislav Fomichev <sdf@google.com>

> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   tools/lib/bpf/bpf_tracing.h | 77 ++++++++++++++++++++++---------------
>   1 file changed, 47 insertions(+), 30 deletions(-)

> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 8d4bdd18cb3d..a71ca48ea479 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -438,39 +438,45 @@ typeof(name(0)) name(unsigned long long *ctx)			 
> 	    \
>   static __always_inline typeof(name(0))					    \
>   ____##name(unsigned long long *ctx, ##args)

> -#ifndef ____bpf_nth
> -#define ____bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11,  
> _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, N, ...) N
> +#ifndef ___bpf_nth2
> +#define ___bpf_nth2(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11,  
> _12, _13,	\
> +		    _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, N, ...) N
>   #endif
> -#ifndef ____bpf_narg
> -#define ____bpf_narg(...) ____bpf_nth(_, ##__VA_ARGS__, 12, 12, 11, 11,  
> 10, 10, 9, 9, 8, 8, 7, 7, 6, 6, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1, 0)
> +#ifndef ___bpf_narg2
> +#define ___bpf_narg2(...)	\
> +	___bpf_nth2(_, ##__VA_ARGS__, 12, 12, 11, 11, 10, 10, 9, 9, 8, 8, 7, 7,	 
> \
> +		    6, 6, 5, 5, 4, 4, 3, 3, 2, 2, 1, 1, 0)
>   #endif

> -#define BPF_REG_CNT(t) \
> -	(__builtin_choose_expr(sizeof(t) == 1 || sizeof(t) == 2 || sizeof(t) ==  
> 4 || sizeof(t) == 8, 1,	\
> -	 __builtin_choose_expr(sizeof(t) == 16, 2,							\
> -			       (void)0)))
> +#define ___bpf_reg_cnt(t) \
> +	__builtin_choose_expr(sizeof(t) == 1, 1,	\
> +	__builtin_choose_expr(sizeof(t) == 2, 1,	\
> +	__builtin_choose_expr(sizeof(t) == 4, 1,	\
> +	__builtin_choose_expr(sizeof(t) == 8, 1,	\
> +	__builtin_choose_expr(sizeof(t) == 16, 2,	\
> +			      (void)0)))))

>   #define ____bpf_reg_cnt0()			(0)
> -#define ____bpf_reg_cnt1(t, x)			(____bpf_reg_cnt0() + BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt2(t, x, args...)		(____bpf_reg_cnt1(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt3(t, x, args...)		(____bpf_reg_cnt2(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt4(t, x, args...)		(____bpf_reg_cnt3(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt5(t, x, args...)		(____bpf_reg_cnt4(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt6(t, x, args...)		(____bpf_reg_cnt5(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt7(t, x, args...)		(____bpf_reg_cnt6(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt8(t, x, args...)		(____bpf_reg_cnt7(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt9(t, x, args...)		(____bpf_reg_cnt8(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt10(t, x, args...)	(____bpf_reg_cnt9(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt11(t, x, args...)	(____bpf_reg_cnt10(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt12(t, x, args...)	(____bpf_reg_cnt11(args) +  
> BPF_REG_CNT(t))
> -#define ____bpf_reg_cnt(args...)	 ___bpf_apply(____bpf_reg_cnt,  
> ____bpf_narg(args))(args)
> +#define ____bpf_reg_cnt1(t, x)			(____bpf_reg_cnt0() + ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt2(t, x, args...)		(____bpf_reg_cnt1(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt3(t, x, args...)		(____bpf_reg_cnt2(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt4(t, x, args...)		(____bpf_reg_cnt3(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt5(t, x, args...)		(____bpf_reg_cnt4(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt6(t, x, args...)		(____bpf_reg_cnt5(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt7(t, x, args...)		(____bpf_reg_cnt6(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt8(t, x, args...)		(____bpf_reg_cnt7(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt9(t, x, args...)		(____bpf_reg_cnt8(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt10(t, x, args...)	(____bpf_reg_cnt9(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt11(t, x, args...)	(____bpf_reg_cnt10(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt12(t, x, args...)	(____bpf_reg_cnt11(args) +  
> ___bpf_reg_cnt(t))
> +#define ____bpf_reg_cnt(args...)	 ___bpf_apply(____bpf_reg_cnt,  
> ___bpf_narg2(args))(args)

>   #define ____bpf_union_arg(t, x, n) \
> -	__builtin_choose_expr(sizeof(t) == 1, ({ union { struct { __u8 x; }  
> ___z; t x; } ___tmp = { .___z = {ctx[n]}}; ___tmp.x; }), \
> -	__builtin_choose_expr(sizeof(t) == 2, ({ union { struct { __u16 x; }  
> ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
> -	__builtin_choose_expr(sizeof(t) == 4, ({ union { struct { __u32 x; }  
> ___z; t x; } ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
> -	__builtin_choose_expr(sizeof(t) == 8, ({ union { struct { __u64 x; }  
> ___z; t x; } ___tmp = {.___z = {ctx[n]} }; ___tmp.x; }), \
> -	__builtin_choose_expr(sizeof(t) == 16, ({ union { struct { __u64 x, y;  
> } ___z; t x; } ___tmp = {.___z = {ctx[n], ctx[n + 1]} }; ___tmp.x; }), \
> +	__builtin_choose_expr(sizeof(t) == 1, ({ union { __u8 ___z[1]; t x; }  
> ___tmp = { .___z = {ctx[n]}}; ___tmp.x; }), \
> +	__builtin_choose_expr(sizeof(t) == 2, ({ union { __u16 ___z[1]; t x; }  
> ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
> +	__builtin_choose_expr(sizeof(t) == 4, ({ union { __u32 ___z[1]; t x; }  
> ___tmp = { .___z = {ctx[n]} }; ___tmp.x; }), \
> +	__builtin_choose_expr(sizeof(t) == 8, ({ union { __u64 ___z[1]; t x; }  
> ___tmp = {.___z = {ctx[n]} }; ___tmp.x; }), \
> +	__builtin_choose_expr(sizeof(t) == 16, ({ union { __u64 ___z[2]; t x; }  
> ___tmp = {.___z = {ctx[n], ctx[n + 1]} }; ___tmp.x; }), \
>   			      (void)0)))))

>   #define ____bpf_ctx_arg0(n, args...)
> @@ -486,7 +492,7 @@ ____##name(unsigned long long *ctx, ##args)
>   #define ____bpf_ctx_arg10(n, t, x, args...)	, ____bpf_union_arg(t, x, n  
> - ____bpf_reg_cnt10(t, x, args)) ____bpf_ctx_arg9(n, args)
>   #define ____bpf_ctx_arg11(n, t, x, args...)	, ____bpf_union_arg(t, x, n  
> - ____bpf_reg_cnt11(t, x, args)) ____bpf_ctx_arg10(n, args)
>   #define ____bpf_ctx_arg12(n, t, x, args...)	, ____bpf_union_arg(t, x, n  
> - ____bpf_reg_cnt12(t, x, args)) ____bpf_ctx_arg11(n, args)
> -#define ____bpf_ctx_arg(n, args...)	___bpf_apply(____bpf_ctx_arg,  
> ____bpf_narg(args))(n, args)
> +#define ____bpf_ctx_arg(args...)	___bpf_apply(____bpf_ctx_arg,  
> ___bpf_narg2(args))(____bpf_reg_cnt(args), args)

>   #define ____bpf_ctx_decl0()
>   #define ____bpf_ctx_decl1(t, x)			, t x
> @@ -501,10 +507,21 @@ ____##name(unsigned long long *ctx, ##args)
>   #define ____bpf_ctx_decl10(t, x, args...)	, t x ____bpf_ctx_decl9(args)
>   #define ____bpf_ctx_decl11(t, x, args...)	, t x ____bpf_ctx_decl10(args)
>   #define ____bpf_ctx_decl12(t, x, args...)	, t x ____bpf_ctx_decl11(args)
> -#define ____bpf_ctx_decl(args...)	___bpf_apply(____bpf_ctx_decl,  
> ____bpf_narg(args))(args)
> +#define ____bpf_ctx_decl(args...)	___bpf_apply(____bpf_ctx_decl,  
> ___bpf_narg2(args))(args)

>   /*
> - * BPF_PROG2 can handle struct arguments.
> + * BPF_PROG2 is an enhanced version of BPF_PROG in order to handle struct
> + * arguments. Since each struct argument might take one or two u64 values
> + * in the trampoline stack, argument type size is needed to place proper  
> number
> + * of u64 values for each argument. Therefore, BPF_PROG2 has different
> + * syntax from BPF_PROG. For example, for the following BPF_PROG syntax,
> + *   int BPF_PROG(test2, int a, int b)
> + * the corresponding BPF_PROG2 synx is,
> + *   int BPF_PROG2(test2, int, a, int, b)
> + * where type and the corresponding argument name are separated by comma.
> + * If one or more argument is of struct type, BPF_PROG2 macro should be  
> used,
> + *   int BPF_PROG2(test_struct_arg, struct bpf_testmod_struct_arg_1, a,  
> int, b,
> + *		   int, c, int, d, struct bpf_testmod_struct_arg_2, e, int, ret)
>    */
>   #define BPF_PROG2(name, args...)						\
>   name(unsigned long long *ctx);							\
> @@ -512,7 +529,7 @@ static __always_inline typeof(name(0))						\
>   ____##name(unsigned long long *ctx ____bpf_ctx_decl(args));			\
>   typeof(name(0)) name(unsigned long long *ctx)					\
>   {										\
> -	return ____##name(ctx ____bpf_ctx_arg(____bpf_reg_cnt(args), args));	\
> +	return ____##name(ctx ____bpf_ctx_arg(args));				\
>   }										\
>   static __always_inline typeof(name(0))						\
>   ____##name(unsigned long long *ctx ____bpf_ctx_decl(args))
> --
> 2.30.2

