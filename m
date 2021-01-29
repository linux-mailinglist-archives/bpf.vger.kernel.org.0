Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7071B308BE9
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 18:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhA2Rsc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 12:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhA2Rq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 12:46:28 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC39EC0613ED;
        Fri, 29 Jan 2021 09:46:01 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id m22so4017580ljj.4;
        Fri, 29 Jan 2021 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OiLSidU7jcHvOmsUmz5FLYsay7uE4w9flc5/NGNfkQ=;
        b=c9c1fFAA1Q8jIaxn1++ppLWGxW194CT3+GS7F07iA+23CjkP4o3p62TTBa9+JCPss8
         G95v+K4CU6Kn6ZTEO0E/YFAyGCvA/o1XfIqYRj4KQwr3pfD6t1EjYAF6YKmFs85hdDwv
         w/AOuj4W3TGHANd4rOZkqPn9+2+PuY+X6+Vtlv63lJ8oBuVZ/p/O+kMKyMIihhvktChP
         BaiSqHxjA0ESb6iLgwEnIARFFFVe0kOPAckpIT5ulDSfRXZQrPAwPV5sfE5JBMetGk74
         43umU4wu9L5N6DcwfwW1J9Zj7rS4ujbYTt7k69hIhZ86kpP+qHV4Mu2GTUhVI5JpeYV6
         1meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OiLSidU7jcHvOmsUmz5FLYsay7uE4w9flc5/NGNfkQ=;
        b=nG8hEI0xR+mWhRAmDKjbJLlhCjSJLNgg/bLoVRvS7fGNlxkF6axz2+CSrRz2LNNndp
         +XAPOHVoQmDi12Jd+1kUjnwR5B8S9vvhwJp9qc5L8g/tVLwLLLC/j/+lJR5h6C1Q8cvj
         lYx2DKjL7iQ+HAFxe15dyIIX5IyyhmBDorVK3idaZEA3Xe6YCA68NrBDbADzVO+xw4q8
         0VjdYTAEHw3Zw3DWYKw6hBHmzf7fS4ZJmhfpU1VxCVxWytgOQt1O6ySNCkuv2Q0XdS1c
         lJJ4J7N1JLx91QWnFSPf/Kst3JFNaXrjXboKZgX7KeyIaBO5Vi0KnANN4Qa/NiFS+Gpb
         181Q==
X-Gm-Message-State: AOAM532ViBFH+5A5RD0wsBn7460VCxzV9cALBGUQIDx6KbK0gkbhVxX9
        VCBmFbtD0rrhDiH+3PvczdsVN705aLq/u9KnAic=
X-Google-Smtp-Source: ABdhPJyw4/ZdcfTfGiaJaSjtW7rI6HqbvMxy1MfFTpgwKqPTTtZRzm/XcZPWYFpu1ZRQUDZH3zLDxOfLblZ1if5xmjU=
X-Received: by 2002:a2e:3507:: with SMTP id z7mr2839145ljz.32.1611942360223;
 Fri, 29 Jan 2021 09:46:00 -0800 (PST)
MIME-Version: 1.0
References: <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
 <20210128103415.d90be51ec607bb6123b2843c@kernel.org> <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com> <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <YBMBTsY1uuQb9wCP@hirez.programming.kicks-ass.net> <20210129013452.njuh3fomws62m4rc@ast-mbp.dhcp.thefacebook.com>
 <YBPNyRyrkzw2echi@hirez.programming.kicks-ass.net> <20210129224011.81bcdb3eba1227c414e69e1f@kernel.org>
 <20210129105952.74dc8464@gandalf.local.home> <20210129162438.GC8912@worktop.programming.kicks-ass.net>
In-Reply-To: <20210129162438.GC8912@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 29 Jan 2021 09:45:48 -0800
Message-ID: <CAADnVQLMqHpSsZ1OdZRFmKqNWKiRq3dxRxw+y=kvMdmkN7htUw@mail.gmail.com>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 8:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 29, 2021 at 10:59:52AM -0500, Steven Rostedt wrote:
> > On Fri, 29 Jan 2021 22:40:11 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > > > So what, they can all happen with random locks held. Marking them as NMI
> > > > enables a whole bunch of sanity checks that are entirely appropriate.
> > >
> > > How about introducing an idea of Asynchronous NMI (ANMI) and Synchronous
> > > NMI (SNMI)? kprobes and ftrace is synchronously called and can be controlled
> > > (we can expect the context) but ANMI may be caused by asynchronous
> > > hardware events on any context.
> > >
> > > If we can distinguish those 2 NMIs on preempt count, bpf people can easily
> > > avoid the inevitable situation.
> >
> > I don't like the name NMI IN SNMI, because they are not NMIs. They are
> > actually more like kernel exceptions. Even page faults in the kernel is
> > similar to a kprobe breakpoint or ftrace. It can happen anywhere, with any
> > lock held. Perhaps we need a kernel exception context? Which by definition
> > is synchronous.

I like 'kernel exception' name. SNMI doesn't sound right. There is nothing
'non maskable' here.

>
> What problem are you trying to solve? AFAICT all these contexts have the
> same restrictions, why try and muck about with different names for the
> same thing?

from core kernel perspective the difference between 'kernel exception'
and true NMI is huge:
this_cpu vs __this_cpu
static checks vs runtime checks

Same things apply to bpf side. We can statically prove safety for
ftrace and kprobe attaching whereas to deal with NMI situation we
have to use run-time checks for recursion prevention, etc.
