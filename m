Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D433F506
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 17:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhCQQG2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 12:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhCQQF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 12:05:57 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC59CC061763
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 09:05:56 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id e21so1345142vsh.5
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2KL8kozO5erdsP6tss56cJzIGTvQeUixy1fwBfyf9E=;
        b=L+sKGzrqRGkayjrIbx3UhJgUwtMmmzJiP7xVkweSApuxYoYxI4LeRgqnM7E2cVNFT2
         L45AC/pwNU1fz3kkRnhcRp5Khlan5/Osp695ao4Zeq1DMR4U7/JYz+4t7MEdHv1+9qwG
         zwxXB5v4s7x+iSvmDyAA8j6J5F/LEkxHHfS2qwphtbLFYhEDWUv95/kvZL3Trdu79AyT
         NNZbI9fnUQcz8+iyHBFSLC3Wa55Q+r5QDMMipTfIOHdnYaK4LSCdSwlrvXeW0lhZ4AF5
         WXtzd1I3zdoC7C//HbblJCanoQNzLOyg1wur/OGHsKtTZ3gw78PQ17RnksLC/ossk+fU
         fcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2KL8kozO5erdsP6tss56cJzIGTvQeUixy1fwBfyf9E=;
        b=j5qwKn0sLiSrRb+Hq9llMEskfAuqeTy6q+rSn0DWGLZpGfot71YScXxqpJALd9G2dA
         9KVHm0vVIAScTvKVTKyH/vhwoTnCJHWe37W79fv486FjjrN2l5JBU7kie5yKafp/IpaM
         pLkqyGzVi3QeP5pkhbAWSNKLJckxD+JyByf6EJX4lGGKEd6o0d2fYZKQWrrAsRLxr4my
         bAZGzk0gbn4Wp+Lh1k0I1Qqv+ZDkXRmwN/hw7p4lS0/Hx5OVGTRoEvzcYadnoBXxjBvS
         2sBzfTBZ5ripsOvNRyotrVIT0IfOrQau6k2fKHbhvfHtH1pidJr/XJMUeUDfcHntkkID
         co1w==
X-Gm-Message-State: AOAM5326FYBFjnjAL63B/2O76p4mZmx9iC2FaYEFBuwl5eZ0lD8ZxuwQ
        ksbsTzC795v8CW/GQ4Ooq74EXMGRPHteRLrMspt7Sw==
X-Google-Smtp-Source: ABdhPJxaHsoJ+bz7hvftL5zgwqX9DbDHuTiz3ir8dA5jWQPZop9wwdoJTujQjPIzJwP11rynhQBtRWijCPDqibIFRy4=
X-Received: by 2002:a67:db98:: with SMTP id f24mr4264884vsk.13.1615997155510;
 Wed, 17 Mar 2021 09:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-7-samitolvanen@google.com> <20210312061304.GA2321497@infradead.org>
In-Reply-To: <20210312061304.GA2321497@infradead.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 17 Mar 2021 09:05:44 -0700
Message-ID: <CABCJKud-wRfmRLFv71QQ6etUMFX6KXsErmL6u0dPH4SU8HS-BQ@mail.gmail.com>
Subject: Re: [PATCH 06/17] kthread: cfi: disable callback pointer check with modules
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 10:13 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Mar 11, 2021 at 04:49:08PM -0800, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, a callback function passed to
> > __kthread_queue_delayed_work from a module points to a jump table
> > entry defined in the module instead of the one used in the core
> > kernel, which breaks function address equality in this check:
> >
> >   WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
> >
> > Disable the warning when CFI and modules are enabled.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  kernel/kthread.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 1578973c5740..af5fee350586 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -963,7 +963,13 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
> >       struct timer_list *timer = &dwork->timer;
> >       struct kthread_work *work = &dwork->work;
> >
> > -     WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
> > +     /*
> > +      * With CFI, timer->function can point to a jump table entry in a module,
>
> you keep spewing this comment line that has exactly 81 characters and
> thus badly messes up read it with a normal termina everywhere.
>
> Maybe instead of fixing that in ever duplication hide the whole check in
> a well documented helper (which would have to be a macro due to the
> typing involved).

Sure, that sounds cleaner. I'll add a helper macro in v2.

Sami
