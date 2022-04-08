Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC64F9DCB
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 21:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiDHTxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 15:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiDHTxw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 15:53:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F87113C70D
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 12:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF825B82D14
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 19:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DD3C385A3
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 19:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649447505;
        bh=B86A0JLSmH8I1lXamwm8hFdwtcjG0Mw17cSHGewPM9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZIrjpkknoTJD+YQ73yMRk8+Nr+LJhSLdpEkKh1NUq9TPQ33yqFA5CAPKZ2VxyjJLR
         Qy5QG9VOxH7dHO968yvM0ztVy/glXVaXUz1GI1S8UeVWCw7/a6apX+o555JKR96dxt
         vsUd8fD5Y6ImXQq09UEncsJzEPSMnVlqb+vrk+GEfm0FY1ipxdi2nG+FcYqtj8oEjA
         c/haKbdwtkMnlAlYIU/lGumndM6q+heoRESy6pP8zb5HUPxrpXstpkGfRNnnegineK
         EIoBrwZqdrbiJWpc6WtESZUkWPHm6gwejAv2l4xfxkiHGJZYkzXPR+H+WZ5E9qzDFh
         +AV2VJiLN0E9w==
Received: by mail-yb1-f174.google.com with SMTP id b4so227751ybi.9
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 12:51:45 -0700 (PDT)
X-Gm-Message-State: AOAM533KEkynmE35KHQ41P4kGp1DVtPAaMd0+cyk1YfhE85zERO9f8uD
        vOA84WUnjEu4AYerWoxdYOjX5t78iU8RETW/XdY=
X-Google-Smtp-Source: ABdhPJyfWNtcWm2zNo+FcG34TcgoV/Mkntg1cUSEz/Vlo8lVO/Xrf0z/K3CxeFbUUa7Xes7envfQgdKn7ozjhBsZiSg=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr13866365ybn.259.1649447504375; Fri, 08
 Apr 2022 12:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220408153829.582386-1-geomatsi@gmail.com>
In-Reply-To: <20220408153829.582386-1-geomatsi@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Apr 2022 12:51:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4T9mUsYEvYeXHxD6cMoxcG90d34UkOh=g2mEv3zFqpig@mail.gmail.com>
Message-ID: <CAPhsuW4T9mUsYEvYeXHxD6cMoxcG90d34UkOh=g2mEv3zFqpig@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add ARC support to bpf_tracing.h
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Vladimir Isaev <isaev@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 8, 2022 at 8:39 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
>
> From: Vladimir Isaev <isaev@synopsys.com>
>
> Add PT_REGS macros suitable for ARCompact and ARCv2.
>
> Signed-off-by: Vladimir Isaev <isaev@synopsys.com>

Hi Sergey,

The patch looks good to me. However, since you are sending the patch for
Vladimir Isaev, we also need your Signed-off-by tag.

Song


> ---
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
