Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFF6524EEC
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351939AbiELN4t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354778AbiELN4r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 09:56:47 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CDE1C345C
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 06:56:35 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id k2so4353929qtp.1
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 06:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yCrQ+Fa/GQ6gHfGTTc+fd3fPvMF11+RqAJluIjYkwMU=;
        b=4KIbzGy6S4FXZWFJ4fSVaP7ByU5nWDzMNbi7bHDFD9fbBbx2iPtUSEAjWfRJD3tXuF
         rVqsSMJiIDf/iM/PhOXw//tpdQtg7+qnG4+yhOTHNo1B/1tvTg/2eCXtbE/1fOxWo1bk
         XbFbLfz/C3swg5U9HFeX9XOXHlyIGMWV9WH8Hp1OzFt/RQ3draDKteBbiyiNkau7PYxh
         UOZw72Xo05DheZypkiSgsUwZ7KExphbavExkiV5JQhwTE8uxn54n4RSINbPVbaqSMqi/
         wDRENr4pTVLS4SQoHYvU/8wDOtgYbP8+T1EKahgT1UOFw/fhm1heqTvhoZSA6XfWeTpO
         u9+w==
X-Gm-Message-State: AOAM5308XI9clbBBbYBGT2gOZXcfTZu/ajvLSn5iABc2P990ZTjZArH/
        7pve0fiEO6JxJLAJEi+FdWw=
X-Google-Smtp-Source: ABdhPJy29nGLRof0TlUmWSyYGg3FO+kDig59wpKC1EQBcpeLE2xu2BU2LiuH8vqdeiHlZ30CbP7IEQ==
X-Received: by 2002:a05:622a:2cf:b0:2f3:d47d:80d9 with SMTP id a15-20020a05622a02cf00b002f3d47d80d9mr21021015qtx.6.1652363794377;
        Thu, 12 May 2022 06:56:34 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-119.fbsv.net. [2a03:2880:20ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id v3-20020ae9e303000000b0069fcf7678besm3042240qkf.105.2022.05.12.06.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 06:56:34 -0700 (PDT)
Date:   Thu, 12 May 2022 06:56:31 -0700
From:   David Vernet <void@manifault.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, kernel-team@fb.com
Subject: Re: [RFC PATCH bpf-next 1/5] x86/fpu: Move context.h to include/asm
Message-ID: <20220512135631.arfh7ofamo6xmlls@dev0025.ash9.facebook.com>
References: <20220512074321.2090073-1-davemarchevsky@fb.com>
 <20220512074321.2090073-2-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512074321.2090073-2-davemarchevsky@fb.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 12:43:17AM -0700, Dave Marchevsky wrote:
> The file's fpregs_state_valid function is useful outside of
> arch/x86/kernel/fpu dir. Further commits in this series use
> fpregs_state_valid to determine whether a BPF helper should fetch
> fpu reg value from xsave'd memory or register.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  arch/x86/{kernel => include/asm}/fpu/context.h | 2 ++
>  arch/x86/kernel/fpu/core.c                     | 2 +-
>  arch/x86/kernel/fpu/regset.c                   | 2 +-
>  arch/x86/kernel/fpu/signal.c                   | 2 +-
>  arch/x86/kernel/fpu/xstate.c                   | 2 +-
>  5 files changed, 6 insertions(+), 4 deletions(-)
>  rename arch/x86/{kernel => include/asm}/fpu/context.h (96%)
> 
> diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/include/asm/fpu/context.h
> similarity index 96%
> rename from arch/x86/kernel/fpu/context.h
> rename to arch/x86/include/asm/fpu/context.h
> index 958accf2ccf0..39dac18cd22c 100644
> --- a/arch/x86/kernel/fpu/context.h
> +++ b/arch/x86/include/asm/fpu/context.h
> @@ -51,6 +51,8 @@ static inline void fpregs_activate(struct fpu *fpu)
>  	trace_x86_fpu_regs_activated(fpu);
>  }
>  
> +extern void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask);

This signature is already included in arch/x86/include/asm/fpu/signal.h.
Should we just include that header from arch/x86/include/asm/fpu/context.h
rather than declaring the signature twice?

> +
>  /* Internal helper for switch_fpu_return() and signal frame setup */
>  static inline void fpregs_restore_userregs(void)
>  {
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index c049561f373a..5296112d4273 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -7,6 +7,7 @@
>   *	Gareth Hughes <gareth@valinux.com>, May 2000
>   */
>  #include <asm/fpu/api.h>
> +#include <asm/fpu/context.h>
>  #include <asm/fpu/regset.h>
>  #include <asm/fpu/sched.h>
>  #include <asm/fpu/signal.h>
> @@ -18,7 +19,6 @@
>  #include <linux/pkeys.h>
>  #include <linux/vmalloc.h>
>  
> -#include "context.h"
>  #include "internal.h"
>  #include "legacy.h"
>  #include "xstate.h"
> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
> index 75ffaef8c299..f93336f332e3 100644
> --- a/arch/x86/kernel/fpu/regset.c
> +++ b/arch/x86/kernel/fpu/regset.c
> @@ -6,10 +6,10 @@
>  #include <linux/vmalloc.h>
>  
>  #include <asm/fpu/api.h>
> +#include <asm/fpu/context.h>
>  #include <asm/fpu/signal.h>
>  #include <asm/fpu/regset.h>
>  
> -#include "context.h"
>  #include "internal.h"
>  #include "legacy.h"
>  #include "xstate.h"
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 91d4b6de58ab..f099a56c9a93 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -7,6 +7,7 @@
>  #include <linux/cpu.h>
>  #include <linux/pagemap.h>
>  
> +#include <asm/fpu/context.h>
>  #include <asm/fpu/signal.h>
>  #include <asm/fpu/regset.h>
>  #include <asm/fpu/xstate.h>
> @@ -15,7 +16,6 @@
>  #include <asm/trapnr.h>
>  #include <asm/trace/fpu.h>
>  
> -#include "context.h"
>  #include "internal.h"
>  #include "legacy.h"
>  #include "xstate.h"
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 39e1c8626ab9..ab5e26075716 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -15,6 +15,7 @@
>  #include <linux/vmalloc.h>
>  
>  #include <asm/fpu/api.h>
> +#include <asm/fpu/context.h>
>  #include <asm/fpu/regset.h>
>  #include <asm/fpu/signal.h>
>  #include <asm/fpu/xcr.h>
> @@ -23,7 +24,6 @@
>  #include <asm/prctl.h>
>  #include <asm/elf.h>
>  
> -#include "context.h"
>  #include "internal.h"
>  #include "legacy.h"
>  #include "xstate.h"
> -- 
> 2.30.2
> 

Looks reasonable otherwise, though it's unclear to me (as I'm not an expert
in this code) whether we should or shouldn't export all of these functions
if some of them are specific to the logic in arch/x86/kernel/fpu. It looks
like there's already a precedent for doing that with e.g.
fpu__clear_user_states(), so it seems fine.

Thanks,
David
