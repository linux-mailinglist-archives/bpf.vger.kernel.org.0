Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDF24F9F87
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 00:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiDHWUx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 18:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiDHWUw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 18:20:52 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12E7EBAF3
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 15:18:46 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k25so12244190iok.8
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdU/ztSIAB7ik7iWaV6xhj8Et6R7Jt68oQvhn3QX6CI=;
        b=AKgPpOxWw5PeWr+ndsgIDJN02quXwC7wP7tYHo9tvbASQDU494imZsbr/ccJ49O4ao
         sLli4f/sCjoC39IzbkJNXRZm8KL+EHHOPTptEF5Hqg+czvIgkJlwd9BilXO0dP9QOdZV
         9YPVgwUqpPwZk2zSJpyJU4+LvcpHwteCmXvsT0vf6XykldCqR1fICXb1DkRsfv6/aoyV
         xOZSf/SVroeg567SqHVJ27Wk+ALZLk0PtdFNvD8Olq5sLW2UMJ6whZWK4MVDaATWbMGA
         ogKyNETUD8Z2ksIilEZH1t2RPdAu5AEtGBfGMySiSIIWCSp/AtULkY2AjgbirAxSzBjd
         Z9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdU/ztSIAB7ik7iWaV6xhj8Et6R7Jt68oQvhn3QX6CI=;
        b=LkjxvnDZZRJliEFVBTa0lxAzoYEKqc01e2a0MVfWhn500dgwqHnTNoP1VDEIBheJW/
         ORwguUH21gpgBHaBH6K0fiM+dIWpdV+n8vI9lKOGPnl+44TPQulNn9XQuMzn3SM3Ex1D
         qdInwAMVxCPwV2ZIF742kXJEMHEvMzILTK01rR2fNCbnF0/Ji0ibHFoBskt1gHfu9wsZ
         oP9hJBd9ajSDQRbA1YdX/6z2Ahfn97tYxYf6jC9FPTGIoo+FU5+GSV5dVEbNOpHBXwlW
         Y/ZOc1eJIZjUm1P1WxbXczQB42G0KnNkQzRawUZ+OTaxYeTsHYNJziLF5h38r6/sAesK
         gJpA==
X-Gm-Message-State: AOAM532SRyUvCOzj3IGC8TLQXfM9u1AtKh9WYB1wY6qCgA//e5+/2hyu
        TCeU4w/tqCWCfgRXYpA/jKWyYCmpu6tg6kRqrHI=
X-Google-Smtp-Source: ABdhPJykWFTZAlKAQIYirQIDrXxAB8PCDG31ltDz03gURzfluVGY9C19YCH1pXAoUe8SplfrvSRxE6WjRdOGS6UpBQk=
X-Received: by 2002:a05:6602:735:b0:64c:adf1:ae09 with SMTP id
 g21-20020a056602073500b0064cadf1ae09mr9261742iox.79.1649456326088; Fri, 08
 Apr 2022 15:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220408153829.582386-1-geomatsi@gmail.com>
In-Reply-To: <20220408153829.582386-1-geomatsi@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Apr 2022 15:18:35 -0700
Message-ID: <CAEf4BzarNmLS+tDCnhnWWNqmr3+3-ZHti2eXhnYvmaepx1e9nw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add ARC support to bpf_tracing.h
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Vladimir Isaev <isaev@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 8, 2022 at 10:21 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
>
> From: Vladimir Isaev <isaev@synopsys.com>
>
> Add PT_REGS macros suitable for ARCompact and ARCv2.
>
> Signed-off-by: Vladimir Isaev <isaev@synopsys.com>
> ---

I have no way to test this unfortunately. Please be available to help
with ARC-specific issues if those come up. Thanks. Applied to
bpf-next.

>  tools/include/uapi/asm/bpf_perf_event.h |  2 ++
>  tools/lib/bpf/bpf_tracing.h             | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/tools/include/uapi/asm/bpf_perf_event.h b/tools/include/uapi/asm/bpf_perf_event.h
> index 39acc149d843..d7dfeab0d71a 100644
> --- a/tools/include/uapi/asm/bpf_perf_event.h
> +++ b/tools/include/uapi/asm/bpf_perf_event.h
> @@ -1,5 +1,7 @@
>  #if defined(__aarch64__)
>  #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
> +#elif defined(__arc__)
> +#include "../../arch/arc/include/uapi/asm/bpf_perf_event.h"
>  #elif defined(__s390__)
>  #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
>  #elif defined(__riscv)
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index e3a8c947e89f..01ce121c302d 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -27,6 +27,9 @@
>  #elif defined(__TARGET_ARCH_riscv)
>         #define bpf_target_riscv
>         #define bpf_target_defined
> +#elif defined(__TARGET_ARCH_arc)
> +       #define bpf_target_arc
> +       #define bpf_target_defined
>  #else
>
>  /* Fall back to what the compiler says */
> @@ -54,6 +57,9 @@
>  #elif defined(__riscv) && __riscv_xlen == 64
>         #define bpf_target_riscv
>         #define bpf_target_defined
> +#elif defined(__arc__)
> +       #define bpf_target_arc
> +       #define bpf_target_defined
>  #endif /* no compiler target */
>
>  #endif
> @@ -233,6 +239,23 @@ struct pt_regs___arm64 {
>  /* riscv does not select ARCH_HAS_SYSCALL_WRAPPER. */
>  #define PT_REGS_SYSCALL_REGS(ctx) ctx
>
> +#elif defined(bpf_target_arc)
> +
> +/* arc provides struct user_pt_regs instead of struct pt_regs to userspace */
> +#define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
> +#define __PT_PARM1_REG scratch.r0
> +#define __PT_PARM2_REG scratch.r1
> +#define __PT_PARM3_REG scratch.r2
> +#define __PT_PARM4_REG scratch.r3
> +#define __PT_PARM5_REG scratch.r4
> +#define __PT_RET_REG scratch.blink
> +#define __PT_FP_REG __unsupported__
> +#define __PT_RC_REG scratch.r0
> +#define __PT_SP_REG scratch.sp
> +#define __PT_IP_REG scratch.ret
> +/* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
> +#define PT_REGS_SYSCALL_REGS(ctx) ctx
> +
>  #endif
>
>  #if defined(bpf_target_defined)
> --
> 2.35.1
>
