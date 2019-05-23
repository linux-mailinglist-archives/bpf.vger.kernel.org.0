Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D173275D9
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 08:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEWGG4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 02:06:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46384 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWGG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 02:06:56 -0400
Received: by mail-io1-f66.google.com with SMTP id q21so3867603iog.13
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 23:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNUktpedBrxulRohJ67/ZQIyhajUGPsEgfYnIkyhhQ8=;
        b=HM6nNxVsxbmg6BTcWjOSOQZ0R4+DK8z68uG6aFpspVFzgQOLQOWz0AEylxAmLxh+3h
         d6Xlce4iycy2laKCz+h4hmefIR4y1rxyNsvFgWGYsBSoz6R54h+SjhQjgsGyIC+U+W3x
         Fo2grzxG+qGfog9dukvUGxSUgm2Nixa3rq7NAr6Bx/hUyUI/LlyebRhmonuiUFItbnEj
         39nHGr8+TUJRflsRA6EC51Jccu3xQwaS1PTqRwYp2SYbmm8SL1aHtAKAxmKu9nThBfQU
         vGW+y4EiiI2vPi1zgGR8dS9vCw4bMqRHO5X1E4Qh5bGedYYDTqp1YMF5AZDktsc8Veqe
         l7fw==
X-Gm-Message-State: APjAAAVR8Wnx2o5Y677rKYsHBziRAhiTGnYB0bftjuxqm07Qozmkw6UQ
        lw/A7x2zujifjdCFkUnrAbIzBPYqU4SN4K/9yuWy8A==
X-Google-Smtp-Source: APXvYqwL+rTJ8coX0NZseJHhduGDusNE2IYZsftgMszlpkAqf1otdDBkRNtA+47vpccRttGr3CjHVW1lepULvMCFt/g=
X-Received: by 2002:a6b:7d0d:: with SMTP id c13mr10557094ioq.249.1558591616008;
 Wed, 22 May 2019 23:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190523053429.3567376-1-songliubraving@fb.com>
In-Reply-To: <20190523053429.3567376-1-songliubraving@fb.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 23 May 2019 14:06:44 +0800
Message-ID: <CACPcB9cXUEhn1a14mq_axJfkR13dna4OfgDZ=YEr=LVKn8K5tg@mail.gmail.com>
Subject: Re: [PATCH v2] perf/x86: always include regs->ip in callchain
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 23, 2019 at 1:34 PM Song Liu <songliubraving@fb.com> wrote:
>
> Commit d15d356887e7 removes regs->ip for !perf_hw_regs(regs) case. This
> patch adds regs->ip back.
>
> Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> Cc: Kairui Song <kasong@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  arch/x86/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index f315425d8468..7b8a9eb4d5fd 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2402,9 +2402,9 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>                 return;
>         }
>
> +       if (perf_callchain_store(entry, regs->ip))
> +               return;
>         if (perf_hw_regs(regs)) {
> -               if (perf_callchain_store(entry, regs->ip))
> -                       return;
>                 unwind_start(&state, current, regs, NULL);
>         } else {
>                 unwind_start(&state, current, NULL, (void *)regs->sp);
> --
> 2.17.1
>

Hi, this will make !perf_hw_regs(regs) case print a double first level
stack trace, which is wrong. And the actual problem that unwinder give
empty calltrace in bpf is still not fixed.

-- 
Best Regards,
Kairui Song
