Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041696E3464
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 01:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjDOXIi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 19:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDOXIh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 19:08:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018FE72;
        Sat, 15 Apr 2023 16:08:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso8881135pjb.0;
        Sat, 15 Apr 2023 16:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681600115; x=1684192115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39PuCCuj94A8wvhWfmSofwyxOxK860d75vvdbLmz9qg=;
        b=OfPBqLHVtCm5t5i/foGq0MOygDKM3IS0SgqmIwL5GIUnhEKDJv51r3z8C07p9VRnjv
         pOdSBv429zfx64+O2pXiw+kCxH/PIWBO1Num3gbjHu/+REV6n6IWsU7nHdvRdKCUuKo0
         ND/Gm7KSNjk5mfpvLFJZZGcsxZyUGZlib5HC0EMvHHEYcLuzn4vB3R6QKtAQ41yAYMBc
         /pEOL+zMFVY+s2YcMi4+UOF2hb56L33wWpwKxNSQUqen40ersrfbm34rfwef7/Z6Ra/q
         Zo44aJYKCJgV51lHK1xZZ3dX99iSrVt5xFjg3Y7+fYMXWD/qT/cMjqsG7Bzliki2HqYg
         96+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681600115; x=1684192115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39PuCCuj94A8wvhWfmSofwyxOxK860d75vvdbLmz9qg=;
        b=NLspA2oaauts4+2nTXdcwPDSsrHUU2oHcBfG4znjP3FvAbuZOTvMNsE2U3pBu2Pv2v
         PvwYwkOyX1unMtIat1R7crM1sdY1+GEt0tx0Iv2nG/RtI2nG/vsluV4o3Da9Mctz7TWd
         AYDxdW4NjG8eR5pfnOPqJlIyY7/XzwvN+RvOy85IWuTTHAF50vkF86YkIvwulJkXtP8T
         AmGdBHWn9hPEoUj3k+Wfcpj0hSwl97A/g2JINb1K8SKI7KH8hDZPVCf8OWq0tUXZvs1k
         5U3GhiJtUiLMW6W0tDCO9G4QAWUUlGF3MbhaHvqYe4Yp8m9thpxEs1LuCgvISt/8IdSG
         /W8Q==
X-Gm-Message-State: AAQBX9d0WhYsAayTzp+fqzhoEDCc7xlqJwXZDoG099UbTFThY0xFloAB
        P8SEyR2HrgvBBMzgTLV2lBg=
X-Google-Smtp-Source: AKy350apd+Ln282XmoJOQXWb/TXH3/+xy90UhScPT5BE9gR9Zz7xNmca84oyVR6rAEXPRAJm+4jvsQ==
X-Received: by 2002:a05:6a21:6d94:b0:ef:2389:66ca with SMTP id wl20-20020a056a216d9400b000ef238966camr2233402pzb.7.1681600115116;
        Sat, 15 Apr 2023 16:08:35 -0700 (PDT)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:eeb9])
        by smtp.gmail.com with ESMTPSA id m9-20020a654c89000000b00502ecb91940sm4717761pgt.55.2023.04.15.16.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 16:08:34 -0700 (PDT)
Date:   Sat, 15 Apr 2023 16:08:31 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        memxor@gmail.com
Subject: Re: [PATCH bpf-next 2/3] bpf: Remove KF_KPTR_GET kfunc flag
Message-ID: <20230415230831.pkpk5qtgjynap62c@macbook-pro-6.dhcp.thefacebook.com>
References: <20230415103231.236063-1-void@manifault.com>
 <20230415103231.236063-3-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415103231.236063-3-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 15, 2023 at 05:32:30AM -0500, David Vernet wrote:
> We've managed to improve the UX for kptrs significantly over the last 9
> months. All of the existing use cases which previously had KF_KPTR_GET
> kfuncs (struct bpf_cpumask *, struct task_struct *, and struct cgroup *)
> have all been updated to be synchronized using RCU. In other words,
> their KF_KPTR_GET kfuncs have been removed in favor of KF_RU |

typo: KF_RCU.
same typo is in cover letter.

> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 495250162422..7721c90ead5b 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -18,7 +18,6 @@
>  #define KF_ACQUIRE	(1 << 0) /* kfunc is an acquire function */
>  #define KF_RELEASE	(1 << 1) /* kfunc is a release function */
>  #define KF_RET_NULL	(1 << 2) /* kfunc returns a pointer that may be NULL */
> -#define KF_KPTR_GET	(1 << 3) /* kfunc returns reference to a kptr */
>  /* Trusted arguments are those which are guaranteed to be valid when passed to
>   * the kfunc. It is used to enforce that pointers obtained from either acquire
>   * kfuncs, or from the main kernel on a tracepoint or struct_ops callback
> @@ -67,14 +66,14 @@
>   *	return 0;
>   * }
>   */
> -#define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
> -#define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
> -#define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
> -#define KF_RCU          (1 << 7) /* kfunc takes either rcu or trusted pointer arguments */
> +#define KF_TRUSTED_ARGS (1 << 3) /* kfunc only takes trusted pointer arguments */
> +#define KF_SLEEPABLE    (1 << 4) /* kfunc may sleep */
> +#define KF_DESTRUCTIVE  (1 << 5) /* kfunc performs destructive actions */
> +#define KF_RCU          (1 << 6) /* kfunc takes either rcu or trusted pointer arguments */
>  /* only one of KF_ITER_{NEW,NEXT,DESTROY} could be specified per kfunc */
> -#define KF_ITER_NEW     (1 << 8) /* kfunc implements BPF iter constructor */
> -#define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
> -#define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
> +#define KF_ITER_NEW     (1 << 7) /* kfunc implements BPF iter constructor */
> +#define KF_ITER_NEXT    (1 << 8) /* kfunc implements BPF iter next method */
> +#define KF_ITER_DESTROY (1 << 9) /* kfunc implements BPF iter destructor */

Great cleanup! but let's not renumber flags to reduce the churn.
Just delete #define KF_KPTR_GET  (1 << 3)
I bet soon enough we will add another KF_ flag in that place.
