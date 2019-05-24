Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647A328F17
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 04:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbfEXCVF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 22:21:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36542 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387921AbfEXCVE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 22:21:04 -0400
Received: by mail-io1-f66.google.com with SMTP id e19so6572200iob.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 19:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TU9aYcgfNn+o19/ZAhWzQtbz6o/09lUEz74yQbsbrOs=;
        b=Ce424euHuYmRXHqtJnP/ELnorWBU5L3JkDvwDm+q/Cos3ZP/4xevKBuIVcUx9mFIca
         s2O17nF2XMELbUDz5I5mrYxcl/udDJsSNoMk2hMjH7mct27tuBWb8s3CMyUf0wEBDrJl
         VNaujRH0guDQbk0gEEfTsK854tSDKVK/Jm1JZjVMglImiCPlH9KJT8qtOpWjfb5vbtJ6
         uVPeUAsgnpqTDaAZvPpU+mBciwDCx+lp+7xN+DAeKebAvBcJ6OfYjR7rQ0nZXwc6q7yS
         yBwUbmYp0cIrR8RLaV44/f9+W9Vmp996ECPsQNYD4yFG047+adA1zvPOtmG6WqZpQ4ab
         IHow==
X-Gm-Message-State: APjAAAV1jxvbyMqsX8hp1mAue6K5PeJ/VKxRCL+O18+fZXUh0h+GJC2x
        M0FYSDmpcdThgnnAi3zFzTUGwXB5HLNU3p3L+1sd4w==
X-Google-Smtp-Source: APXvYqxbzwmKP5zCOrF9d/b6xGv/Y8vObXzFIyCgXMb5NFMNIrNQb6s8fIjcHFafIn6tV0z6EJRKgM+nov7KtbhNUjM=
X-Received: by 2002:a05:6602:211a:: with SMTP id x26mr5453533iox.202.1558664464183;
 Thu, 23 May 2019 19:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com> <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble> <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble> <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble> <CACPcB9e0mL6jdNWfH-2K-rkvmQiz=G6mtLiZ+AEmp3-V0x+Z8A@mail.gmail.com>
 <20190523172714.6fkzknfsuv2t44se@treble>
In-Reply-To: <20190523172714.6fkzknfsuv2t44se@treble>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 24 May 2019 10:20:52 +0800
Message-ID: <CACPcB9dHzht9v9G9_z6oe5AAwgxCTuswRLxTB29vhWphqBO5Ng@mail.gmail.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 24, 2019 at 1:27 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, May 24, 2019 at 12:41:59AM +0800, Kairui Song wrote:
> >  On Thu, May 23, 2019 at 11:24 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Thu, May 23, 2019 at 10:50:24PM +0800, Kairui Song wrote:
> > > > > > Hi Josh, this still won't fix the problem.
> > > > > >
> > > > > > Problem is not (or not only) with ___bpf_prog_run, what actually went
> > > > > > wrong is with the JITed bpf code.
> > > > >
> > > > > There seem to be a bunch of issues.  My patch at least fixes the failing
> > > > > selftest reported by Alexei for ORC.
> > > > >
> > > > > How can I recreate your issue?
> > > >
> > > > Hmm, I used bcc's example to attach bpf to trace point, and with that
> > > > fix stack trace is still invalid.
> > > >
> > > > CMD I used with bcc:
> > > > python3 ./tools/stackcount.py t:sched:sched_fork
> > >
> > > I've had problems in the past getting bcc to build, so I was hoping it
> > > was reproducible with a standalone selftest.
> > >
> > > > And I just had another try applying your patch, self test is also failing.
> > >
> > > Is it the same selftest reported by Alexei?
> > >
> > >   test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap err -1 errno 2
> > >
> > > > I'm applying on my local master branch, a few days older than
> > > > upstream, I can update and try again, am I missing anything?
> > >
> > > The above patch had some issues, so with some configs you might see an
> > > objtool warning for ___bpf_prog_run(), in which case the patch doesn't
> > > fix the test_stacktrace_map selftest.
> > >
> > > Here's the latest version which should fix it in all cases (based on
> > > tip/master):
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?h=bpf-orc-fix
> >
> > Hmm, I still get the failure:
> > test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap
> > err -1 errno 2
> >
> > And I didn't see how this will fix the issue. As long as ORC need to
> > unwind through the JITed code it will fail. And that will happen
> > before reaching ___bpf_prog_run.
>
> Ok, I was able to recreate by doing
>
>   echo 1 > /proc/sys/net/core/bpf_jit_enable
>
> first.  I'm guessing you have CONFIG_BPF_JIT_ALWAYS_ON.
>

Yes, with JIT off it will be fixed. I can confirm that.

--
Best Regards,
Kairui Song
