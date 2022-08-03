Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79B35888A3
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiHCITn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiHCITk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 04:19:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFE160D0;
        Wed,  3 Aug 2022 01:19:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w3so4842773edc.2;
        Wed, 03 Aug 2022 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc;
        bh=l1hEI332NfT1JuaXAK4dv586CJr0lsUfuhuRLOyrE/U=;
        b=PNxl3iOhkhoiomYAywGEUu6Or+U6/6U9qXaRBf+w5tOTvR7gDSZyLXxg85QTFLXOzZ
         /3nOjeXG+5+i9nscnGlJnMU9w9li4lA1MZiISFbWjRsY6F2WWvDMKMN0QJOOzT3XT2nv
         x0QmWevrvXfttf65MqnOUbrnBl7vZbFMJfV/ZeLxGNBKfRGvjRUg0wWuXmkuvYIHE89M
         8bDQxO7PS3hoEa0R/CkH2AoiMVX/lMgeLR/s7Y4tubC+rpYQRlIv2OZcrgdIcha6Z+CM
         0nRrGOxbTf8Eo4gHzyqNCGvo2AZcWCy/xB1/Qb74N1rhrQ9zD8zxMw9PflMkPUKXJRYO
         m1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc;
        bh=l1hEI332NfT1JuaXAK4dv586CJr0lsUfuhuRLOyrE/U=;
        b=PFL5xFTvq4zUk7Yf2HGD+EnHHTKH5ePgaLFFcO40M6E8gdHA7noA1I90fnToF49469
         4yjSlqCAm7UMnSMcGqF8n+IT7gvHfIKf7fW6r1ON1KFXbTMpd9njSqppK6hNT5pUHNj0
         FR1LdKwpCNRwaMXgLgh+ReQBdhgqmy+JpyqkioZXzGLar9tUsXfiw7MWcFEU6svUg3gF
         fYVVwSECoICEPA6Ct2qqZWsACx81xpUJllkUeyeRjoBrqFQS3RKDoZKyHDwcv37TuvkD
         hXva+NHIhsXHSaLHZJg+jwvby4n+C38LLM4xNWyOMINzVwyKcwotxdYEZt/2QiHs12tl
         CN8Q==
X-Gm-Message-State: AJIora+hsZKXF454xuPvxdHChx2HYdo6uFkByGFVjKBmqTCn3JnaBG8i
        qB4KOovmeKOS4JhM60aiXhyeO75afJWK8Q==
X-Google-Smtp-Source: AGRyM1tBFIv2Lax6dslMiZcXUev92ozsHx9/tOweo2qIno7yWaJHQjIaQZQd9EfW+yF9zCdUwO4ajw==
X-Received: by 2002:a05:6402:430e:b0:43d:1cf6:61ec with SMTP id m14-20020a056402430e00b0043d1cf661ecmr23564547edc.194.1659514777992;
        Wed, 03 Aug 2022 01:19:37 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o17-20020a170906769100b007308bdef04bsm2813733ejm.103.2022.08.03.01.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 01:19:37 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 3 Aug 2022 10:19:35 +0200
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: ensure functions with always_inline attribute
 are inline
Message-ID: <Yuovl3ycDfflqV9h@krava>
References: <20220802232741.481145-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802232741.481145-1-james.hilliard1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 02, 2022 at 05:27:41PM -0600, James Hilliard wrote:
> GCC expects the always_inline attribute to only be set on inline
> functions, as such we should make all functions with this attribute
> inline.
> 
> Fixes errors like:
> /home/buildroot/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_tracing.h:439:1: error: ‘always_inline’ function might not be inlinable [-Werror=attributes]
>   439 | ____##name(unsigned long long *ctx, ##args)
>       | ^~~~
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 14 +++++++-------
>  tools/lib/bpf/usdt.bpf.h    |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 43ca3aff2292..ae67fcee912c 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -426,7 +426,7 @@ struct pt_regs;
>   */
>  #define BPF_PROG(name, args...)						    \
>  name(unsigned long long *ctx);						    \
> -static __attribute__((always_inline)) typeof(name(0))			    \
> +static inline __attribute__((always_inline)) typeof(name(0))		    \

could you use __always_inline that does exactly that?

jirka

>  ____##name(unsigned long long *ctx, ##args);				    \
>  typeof(name(0)) name(unsigned long long *ctx)				    \
>  {									    \
> @@ -435,7 +435,7 @@ typeof(name(0)) name(unsigned long long *ctx)				    \
>  	return ____##name(___bpf_ctx_cast(args));			    \
>  	_Pragma("GCC diagnostic pop")					    \
>  }									    \
> -static __attribute__((always_inline)) typeof(name(0))			    \
> +static inline __attribute__((always_inline)) typeof(name(0))		    \
>  ____##name(unsigned long long *ctx, ##args)
>  
>  struct pt_regs;
> @@ -460,7 +460,7 @@ struct pt_regs;
>   */
>  #define BPF_KPROBE(name, args...)					    \
>  name(struct pt_regs *ctx);						    \
> -static __attribute__((always_inline)) typeof(name(0))			    \
> +static inline __attribute__((always_inline)) typeof(name(0))		    \
>  ____##name(struct pt_regs *ctx, ##args);				    \
>  typeof(name(0)) name(struct pt_regs *ctx)				    \
>  {									    \
> @@ -469,7 +469,7 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
>  	return ____##name(___bpf_kprobe_args(args));			    \
>  	_Pragma("GCC diagnostic pop")					    \
>  }									    \
> -static __attribute__((always_inline)) typeof(name(0))			    \
> +static inline __attribute__((always_inline)) typeof(name(0))		    \
>  ____##name(struct pt_regs *ctx, ##args)
>  
>  #define ___bpf_kretprobe_args0()       ctx
> @@ -484,7 +484,7 @@ ____##name(struct pt_regs *ctx, ##args)
>   */
>  #define BPF_KRETPROBE(name, args...)					    \
>  name(struct pt_regs *ctx);						    \
> -static __attribute__((always_inline)) typeof(name(0))			    \
> +static inline __attribute__((always_inline)) typeof(name(0))		    \
>  ____##name(struct pt_regs *ctx, ##args);				    \
>  typeof(name(0)) name(struct pt_regs *ctx)				    \
>  {									    \
> @@ -540,7 +540,7 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>  #define BPF_KSYSCALL(name, args...)					    \
>  name(struct pt_regs *ctx);						    \
>  extern _Bool LINUX_HAS_SYSCALL_WRAPPER __kconfig;			    \
> -static __attribute__((always_inline)) typeof(name(0))			    \
> +static inline __attribute__((always_inline)) typeof(name(0))		    \
>  ____##name(struct pt_regs *ctx, ##args);				    \
>  typeof(name(0)) name(struct pt_regs *ctx)				    \
>  {									    \
> @@ -555,7 +555,7 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
>  		return ____##name(___bpf_syscall_args(args));		    \
>  	_Pragma("GCC diagnostic pop")					    \
>  }									    \
> -static __attribute__((always_inline)) typeof(name(0))			    \
> +static inline __attribute__((always_inline)) typeof(name(0))		    \
>  ____##name(struct pt_regs *ctx, ##args)
>  
>  #define BPF_KPROBE_SYSCALL BPF_KSYSCALL
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index 4f2adc0bd6ca..2bd2d80b3751 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -232,7 +232,7 @@ long bpf_usdt_cookie(struct pt_regs *ctx)
>   */
>  #define BPF_USDT(name, args...)						    \
>  name(struct pt_regs *ctx);						    \
> -static __attribute__((always_inline)) typeof(name(0))			    \
> +static inline __attribute__((always_inline)) typeof(name(0))		    \
>  ____##name(struct pt_regs *ctx, ##args);				    \
>  typeof(name(0)) name(struct pt_regs *ctx)				    \
>  {									    \
> @@ -241,7 +241,7 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
>          return ____##name(___bpf_usdt_args(args));			    \
>          _Pragma("GCC diagnostic pop")					    \
>  }									    \
> -static __attribute__((always_inline)) typeof(name(0))			    \
> +static inline __attribute__((always_inline)) typeof(name(0))		    \
>  ____##name(struct pt_regs *ctx, ##args)
>  
>  #endif /* __USDT_BPF_H__ */
> -- 
> 2.34.1
> 
