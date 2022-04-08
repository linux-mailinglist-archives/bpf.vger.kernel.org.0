Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E174F9F94
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 00:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiDHW2d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 18:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiDHW2c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 18:28:32 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2604F13F67
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 15:26:28 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id 8so7422430ilq.4
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOAP89yO3KC+nVe2lHBPhLTj/h7YRNcKkGR/vaQBKio=;
        b=fXX2VwgJCT6zPUrwJQfdl+h8TfC35hCAWjHWy1sgjy7BzD0u5Kaj20bYbk37SJI4S4
         v+378Nj2E+S7Q3a4G32cWu7eZ8ZbOJCETbCDlQLH/wYhQ5V2hecKeV/U0DWe1X716+Jq
         GIcBJu68gCqfbJK4NJ4byacqGCFNwHc4QL453EPyq1InLtc6qNXXdqERYnUEGXpw2afk
         z9guJ+ScjMNEDdQXGlTu2ol7w6qLtlDEYK0ZUyozMOlkQ7P7X1LE6qvkNy9faF4VGnoX
         cWfz7BZygY/9satTpC6jKTZdrCGZOsWqfrxL5abMlPk0uxfMKE1OiKFntMA9MIm3zm07
         3xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOAP89yO3KC+nVe2lHBPhLTj/h7YRNcKkGR/vaQBKio=;
        b=A9Ngoq6PgCQdppl5noepTFyMweg2PwqcZUy/RSgXifz1nkUoZ/Ah8GzB5S+bBAu5X4
         IsBCefJaxsNZMra2x1L/a2F5G0rwbayqLcXpiDOWuW6uAt/78UvibYXr7O8zi6LVvQV0
         YWWPase68zZf8iYtxK0sViug1s9vzOXurgclK3zLedQggwhpDOxw13SlNifAQBGuIZuz
         42FVv3nIWRsY5wnuaojrxy1xZUrkewbasBtGhRVFi+4tab7u9bsm0vKISyJnJLn4NYYN
         IW0vc55wFZXtc1Cc4zV087l0ALA+VylMfqJuFJCGfBtps8SPP7g+KvztWLs/ygJNYQ0Q
         N1YA==
X-Gm-Message-State: AOAM530Rl+C4rAahap0B1EXFhdrRyZA28B16FR2sfWI3zVoYG5kQ6NMu
        adTUf0PjlckLkB1BV+0EXN3LC2tjYKImcXmdhFA=
X-Google-Smtp-Source: ABdhPJzM2+kl8rz5i1b37crcEmRp1WVKr+nQg6Tkqv9ckGniubfDNWzhtoT1OcDwTTred4oRNS9XnRAMxQx6r4HydZE=
X-Received: by 2002:a05:6e02:1562:b0:2ca:50f1:72f3 with SMTP id
 k2-20020a056e02156200b002ca50f172f3mr9252227ilu.71.1649456787380; Fri, 08 Apr
 2022 15:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220408153829.582386-1-geomatsi@gmail.com> <CAEf4BzarNmLS+tDCnhnWWNqmr3+3-ZHti2eXhnYvmaepx1e9nw@mail.gmail.com>
In-Reply-To: <CAEf4BzarNmLS+tDCnhnWWNqmr3+3-ZHti2eXhnYvmaepx1e9nw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Apr 2022 15:26:16 -0700
Message-ID: <CAEf4BzZsvyck14Z_gP_b+++iEDnkjUpiBTEdq4qN4E=eTe-yZg@mail.gmail.com>
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

On Fri, Apr 8, 2022 at 3:18 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 8, 2022 at 10:21 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
> >
> > From: Vladimir Isaev <isaev@synopsys.com>
> >
> > Add PT_REGS macros suitable for ARCompact and ARCv2.
> >
> > Signed-off-by: Vladimir Isaev <isaev@synopsys.com>
> > ---
>
> I have no way to test this unfortunately. Please be available to help
> with ARC-specific issues if those come up. Thanks. Applied to
> bpf-next.
>

Welp, didn't see Song's email before applying and sending. Song is
right, we'll need your SoB. Backed out patch for now.

> >  tools/include/uapi/asm/bpf_perf_event.h |  2 ++
> >  tools/lib/bpf/bpf_tracing.h             | 23 +++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/tools/include/uapi/asm/bpf_perf_event.h b/tools/include/uapi/asm/bpf_perf_event.h
> > index 39acc149d843..d7dfeab0d71a 100644
> > --- a/tools/include/uapi/asm/bpf_perf_event.h
> > +++ b/tools/include/uapi/asm/bpf_perf_event.h
> > @@ -1,5 +1,7 @@
> >  #if defined(__aarch64__)
> >  #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
> > +#elif defined(__arc__)
> > +#include "../../arch/arc/include/uapi/asm/bpf_perf_event.h"
> >  #elif defined(__s390__)
> >  #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
> >  #elif defined(__riscv)
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index e3a8c947e89f..01ce121c302d 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -27,6 +27,9 @@
> >  #elif defined(__TARGET_ARCH_riscv)
> >         #define bpf_target_riscv
> >         #define bpf_target_defined
> > +#elif defined(__TARGET_ARCH_arc)
> > +       #define bpf_target_arc
> > +       #define bpf_target_defined
> >  #else
> >
> >  /* Fall back to what the compiler says */
> > @@ -54,6 +57,9 @@
> >  #elif defined(__riscv) && __riscv_xlen == 64
> >         #define bpf_target_riscv
> >         #define bpf_target_defined
> > +#elif defined(__arc__)
> > +       #define bpf_target_arc
> > +       #define bpf_target_defined
> >  #endif /* no compiler target */
> >
> >  #endif
> > @@ -233,6 +239,23 @@ struct pt_regs___arm64 {
> >  /* riscv does not select ARCH_HAS_SYSCALL_WRAPPER. */
> >  #define PT_REGS_SYSCALL_REGS(ctx) ctx
> >
> > +#elif defined(bpf_target_arc)
> > +
> > +/* arc provides struct user_pt_regs instead of struct pt_regs to userspace */
> > +#define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
> > +#define __PT_PARM1_REG scratch.r0
> > +#define __PT_PARM2_REG scratch.r1
> > +#define __PT_PARM3_REG scratch.r2
> > +#define __PT_PARM4_REG scratch.r3
> > +#define __PT_PARM5_REG scratch.r4
> > +#define __PT_RET_REG scratch.blink
> > +#define __PT_FP_REG __unsupported__
> > +#define __PT_RC_REG scratch.r0
> > +#define __PT_SP_REG scratch.sp
> > +#define __PT_IP_REG scratch.ret
> > +/* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
> > +#define PT_REGS_SYSCALL_REGS(ctx) ctx
> > +
> >  #endif
> >
> >  #if defined(bpf_target_defined)
> > --
> > 2.35.1
> >
