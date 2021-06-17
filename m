Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853973ABBE3
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhFQSdX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 14:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhFQSdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 14:33:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D702C061574;
        Thu, 17 Jun 2021 11:31:15 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j184so4543657qkd.6;
        Thu, 17 Jun 2021 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdN3+P74lXshSmLwmq8jXVTzzottgAs9RSBNmB7e3EA=;
        b=u2I9VloRjp4sirTz6YED7fjPAlghS++A6VFWyEPCzv+f84jWGjOASSFHQ0bMqZdiOK
         0cqNeehvUaMB8xr59Lx30f256fE6+pEPcvRco2ZO6bffKwFc0QICXscXhrx30D/zZS1e
         s4HpekyBUj4K+pXvm1M4FopfZUF4/I5NyQUw9ak2XwW4eqGHNs+CI7vm0RNiCUxA6Jba
         uJ7TloSlxBB4zIAIjeXORVNBfOQ6/TmzooZFvRlWjxsVDZtUPfjjZI/xrEZrnAON+6n/
         41vBO9htiyFGuENRGm9xeAPN2AHtdzIMGd3/hai66A8/rovi0coXMrqFAyOffDt04HTq
         g9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdN3+P74lXshSmLwmq8jXVTzzottgAs9RSBNmB7e3EA=;
        b=eJ7i9ywtwwyBpY+rH9rL9Qcbbocqstz7rOT5huwcv0lA2GMZJmD2UaOwri5CnD0CjS
         15jmDQHvfz6n9MhMLh/a3pTMiPQeOksGZrYZmAii9zh3WtvC10F/ZtFO7qmbkk91kTqQ
         SCbRg22bGsf39pjmmjc6mpqflZFj2+2EhRAkrTBWxgqddUI/riFiUMSM5+sOgRNqJohn
         vY08xvHfxPllc1TevsGlwyJlI2mseQeTezbNWAJ4/0VvkZXE8jsvHteVbIoPDRy4ne3q
         Ssx3v+1W2HzLqpPZJlIXGn9c7KG0LxxYz1DEghwK+SWyzpzHd34IEqwQIy7o8t+Wan7D
         W84A==
X-Gm-Message-State: AOAM532QSuq0kedwSxzt+TW468vvEGNbIm3hP/EGLsuxZ2IwmGipmWT+
        EtxDPqSn35+sPNJqMabx9jsZoP3a7+4t5MGqA+o=
X-Google-Smtp-Source: ABdhPJwwdYD1acgsEBpF8ndRSZL+cl6G14jBl7NUiLnOvL8eBeV1bd6q2pHNfc2xJVywwFx2Gxuk7hniv4F5CQbsl9c=
X-Received: by 2002:a25:6612:: with SMTP id a18mr8397287ybc.347.1623954674508;
 Thu, 17 Jun 2021 11:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
 <162209762943.436794.874947392889792501.stgit@devnote2> <20210617043909.fgu2lhnkxflmy5mk@treble>
 <20210617044032.txng4enhiduacvt6@treble> <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
 <20210618000239.f95de17418beae6d84ce783d@kernel.org> <CAEf4Bzbob_M0aS-GUY5XaqePZr_prxUag3RLHtp=HY8Uu__10g@mail.gmail.com>
 <20210617182159.ka227nkmhe4yu2de@treble>
In-Reply-To: <20210617182159.ka227nkmhe4yu2de@treble>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Jun 2021 11:31:03 -0700
Message-ID: <CAEf4BzbQxxAWEvE7BfrBPCPzBjrAEVL9cg-duwbFNzEmbPPW2w@mail.gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 11:22 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Jun 17, 2021 at 10:45:41AM -0700, Andrii Nakryiko wrote:
> > > > > > I know I suggested this patch, but I believe it would only be useful in
> > > > > > combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> > > > > > think that would be tricky to pull off correctly.  Instead, we have
> > > > > > UNWIND_HINT_FUNC, which is working fine.
> > > > > >
> > > > > > So I'd suggest dropping this patch, as the unwinder isn't actually
> > > > > > reading regs->ip after all.
> > > > >
> > > > > ... and I guess this means patches 6-8 are no longer necessary.
> > > >
> > > > OK, I also confirmed that dropping those patche does not make any change
> > > > on the stacktrace.
> > > > Let me update the series without those.
> > >
> > > Oops, Andrii, can you also test the kernel without this patch?
> > > (you don't need to drop patch 6-8)
> >
> > Hi Masami,
> >
> > Dropping this patch and leaving all the other in place breaks stack
> > traces from kretprobes for BPF. I double checked with and without this
> > patch. Without this patch we are back to having broken stack traces. I
> > see either
> >
> >   kretprobe_trampoline+0x0
> >
> > or
> >
> >   ftrace_trampoline+0xc8
> >   kretprobe_trampoline+0x0
> >
> > Is there any problem if you leave this patch as is?
>
> Hm, I must be missing something then.  The patch is probably fine to
> keep, we just may need to improve the commit log so that it makes sense
> to me.
>
> Which unwinder are you using (CONFIG_UNWINDER_*)?
>

$ rg UNWINDER ~/linux-build/default/.config
5585:CONFIG_UNWINDER_ORC=y
5586:# CONFIG_UNWINDER_FRAME_POINTER is not set
5587:# CONFIG_UNWINDER_GUESS is not set

> --
> Josh
>
