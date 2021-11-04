Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2CA44578F
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 17:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhKDQxl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhKDQxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 12:53:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472AC061203
        for <bpf@vger.kernel.org>; Thu,  4 Nov 2021 09:51:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t11so8155629plq.11
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSXO7GvyEv44qQUXeQlRoAYS31grkHUfoSmd7ckK8QE=;
        b=O8laJlEeojc4XU1QFI4AaaSPGzYRJXBuqFQOXAJQnIO4RdR5niSSOZhMDvrkWtLubM
         56Uvsconv8FAys/KBmFGLsAqhpeTuMQ4F6btlL+kUHWDy4/FIHvIv2QvgnWuzZuzQ/zh
         uoruudhdMH/2iREZG1KozYSNygTwSRZ9YnWdaba1QyJifO+n+Ls5mveA/cRSIBN3URFc
         avavaW9q3+mcRFZ5R9mc1gJIOjXNxamesfG42mIpoxsbk1id/Ump6gR0w61LLvLg0dni
         mwlyMIO2qpAn/ObhW915+Cho+jtjELe+V5SsScj695hH28trtKRr8CMZG5eakb2dyag+
         yJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSXO7GvyEv44qQUXeQlRoAYS31grkHUfoSmd7ckK8QE=;
        b=AYBklIPWRsuQSkqTr3iP3tCLxXjFveG8xZM+qW9sL54tFly3m+RkrhfOLRoJPNKz9i
         Cu7AUyyV05CggsKkSvKTf0y+YQR1Ai3n0oe2ThSh6zL/iS7hieiLa4S0yxge4/5irzt/
         nGGJEO7r2TB3BXlYWgHP2etWoFkW2CfsrSzxcpNWr6Jbwj3L8N4pz6d9nrvNIujZxiFD
         Yhri21RclUGjoU4WNXt9n3R2wHPV89tAEhxe+erJre0JQ09xkN0SQKO/M2x5Lq1b6int
         4wJ8RsiH57o3CHGFyDDpHUxI132idrIRv1iJJklTTwpCmx8GbwHhmjANlYoxf65EoplK
         QwiA==
X-Gm-Message-State: AOAM530AA1SxTnWBkm/DNp6RCLrWbSbxrpFkalCwUc3EqsqqWHta+9It
        zXEZI6rMQY23j2LEJZEKFZGzr+qTWZQdmm3cVAo=
X-Google-Smtp-Source: ABdhPJypNp/XxUfVZbTGqYBs3SUM+b5l3QPjY8Fc9T/2CXBTvEtQLhTbISQDfmnWVw4iNXXEwHRJ4T+Prxpekq9Pcok=
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr23464435pjj.138.1636044660985;
 Thu, 04 Nov 2021 09:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
In-Reply-To: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 4 Nov 2021 09:50:49 -0700
Message-ID: <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
Subject: Re: Verifier rejects previously accepted program
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 3, 2021 at 4:55 AM Lorenz Bauer <lmb@cloudflare.com> wrote:

> #pragma clang loop unroll(full)
>     for (int b = 1 << 10; b >= 4; b >>= 1) {
>         if (start + b > end) {
>             continue;
>         }
>
>         // If we do 8 byte reads, we have to handle overflows which is
> slower than 4 byte reads.
>         for (int i = 0; i < b; i += 4) {
>             csum += *(uint32_t *)(start + i);
>         }
>
>         start += b;
>     }
>     if (start + 2 <= end) {
>         csum += *(uint16_t *)(start);
>         start += 2;
>     }
>     if (start + 1 <= end) {
>         csum += *(start);
>     }

Thanks for flagging!
Could you craft a test case that we can use a repro and future
test case?

> fp-88=map_value fp-96=mmmmmmmm fp-104=map_value fp-112=inv fp-120=fp
...
> I've bisected the problem to commit 3e8ce29850f1 ("bpf: Prevent
> pointer mismatch in bpf_timer_init.") The commit seems unrelated to
> loop processing though (it does touch the verifier however). Either I
> got the bisection wrong or there is something subtle going on.

I stared at that commit and the example asm.
I suspect the bisect went wrong.

Could you try reverting a single
commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
?
The above fp-112=inv means that the verifier is tracking scalar spill.
That could be the reason for bounded loop logic seeing different
stack state on every iteration.
But the asm snippet doesn't have the store to stack at [fp-112]
location, so it could be a red herring.

Are you using the same llvm during bisect?
The commit 354e8f1970f8 should be harmless
(when commit f30d4968e9ae ("bpf: Do not reject when the stack read
size is different from the tracked scalar size"))
is also applied. That fix is in bpf tree only, so far.
The tracking of 8-byte spill is the most useful with the latest llvm
that was taught to use 8-byte aligned stack for such spills.

Without being able to repro it's hard to investigate much further.
