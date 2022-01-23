Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3BD4974CB
	for <lists+bpf@lfdr.de>; Sun, 23 Jan 2022 19:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiAWSpx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Jan 2022 13:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiAWSpw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Jan 2022 13:45:52 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E3FC06173D
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 10:45:52 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y84so582276iof.0
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 10:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVezGFnrv75sEcjGEC4/4fkIz/BvlE578Fz7+Ws5ols=;
        b=INx3xHmit+6lRVim//JcN8Eaag5n2aRFeI/hBohCnvW3rt14qcuShwEBxnVbidEjCJ
         geOdUn90/2U4m9uciixLyypK6FlU7ZCYQYmOWzmmSxX3EE2fL8MzWlQv+OfkSuVAmG/X
         oNs4uBo3UHriHuz8SiUNqzqg8Hm3AhBJGsuDKEoLVd/REsHK7H0sRWqIOunbsq5eDXgF
         iY5SJFCZYo0Sj1FTkokc82y66paFwVzqKLLZ12fcTtKeecCNm6jGVG3YKAkU7YojHjjY
         QAaFOB5EHTaK4hky+yUocw9Y2W+Iv72p+c9+Qtv+avrnqvdaLOHYwz/6S1SeUBzJncgM
         PVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVezGFnrv75sEcjGEC4/4fkIz/BvlE578Fz7+Ws5ols=;
        b=AjsUhdwAWokvi7ovp5a6Apmf77rxubN8+Qa42PU+fBjvzyuxHFrOwnRDyRCocjzyBM
         pnwXGx0Rtmy4n6eRrFSpmKQRYdao8a4qWurroxJq8LiBjEGJ8znJbJqyVKBd9j+7IK55
         e1rJFY6U55PwsLtXJw7M8aYRjdSwqc4VzQCEYIp9jiqwMmNkX771I129F/dBFH1u5Gru
         Ow8+Vu90gSW6vQQY5R5QlPzLBydqPQBlzl0o9q0sdZOm8ff166G/1E5vhAg3hs/7KegI
         3gOOCku5y0BGhOgg0uLDP/s5sXZ9n0EPtyeUhcogelSBInZ+uplQwWVeHqfQw9XnbivQ
         WQGw==
X-Gm-Message-State: AOAM531BtGvoDbAlkocG7UwqIMmqUmUsjkn2AsHKHb/LmsR7pY12xPv1
        6PLOTjglo5vw1BmjeZZuCdNeWAlLQjZdzfPiIAb/zg==
X-Google-Smtp-Source: ABdhPJxl0FQl4VdqyjtwwsWqIZoCTfHPXDja23vYMxJNZUE0k5+ze3/9RCliByHGMva3MuebDvtO/jJgwDwIM9RZhfw=
X-Received: by 2002:a05:6602:2b8b:: with SMTP id r11mr6427624iov.97.1642963551847;
 Sun, 23 Jan 2022 10:45:51 -0800 (PST)
MIME-Version: 1.0
References: <87o85ftc3p.fsf@smart-cactus.org> <CAADnVQ++57u30cdooEqXSDVGEgKTy70TChg8+2h8mihHbwdpOg@mail.gmail.com>
In-Reply-To: <CAADnVQ++57u30cdooEqXSDVGEgKTy70TChg8+2h8mihHbwdpOg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 23 Jan 2022 10:45:40 -0800
Message-ID: <CAP-5=fVSSGa3dyg64GYN=-PDmj1aUa8pR0U71FMoZ6U_6Mu0+w@mail.gmail.com>
Subject: Re: Sampling of non-C-like stacks with eBPF and perf_events?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ben Gamari <ben@smart-cactus.org>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei and Ben,

This sounds awesome! Somewhat off-topic, I wonder if we could include
the pyperf and ghc support in regular perf? I think there is an
assumption that these languages are a minority concern, but I think
everyone would benefit from being packaged with perf, being kept in
sync with how the APIs evolve, code reuse, etc.

Thanks,
Ian

On Fri, Jan 21, 2022 at 4:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 17, 2021 at 1:53 PM Ben Gamari <ben@smart-cactus.org> wrote:
> >
> > Hi all,
> >
> > I have recently been exploring the possibility of using a
> > BPF_PROG_TYPE_PERF_EVENT program to implement stack sampling for
> > languages which do not use the platform's %sp for their stack pointer
> > (in my case, GHC/Haskell [1], which on x86-64 uses %rbp for its stack
> > pointer). Specifically, the idea is to use a sampling perf_events
> > session with an eBPF overflow handler which locates the
> > currently-running thread's stack and records it in the sample ringbuffer
> > (see [2] for my current attempt). At this point I only care about
> > user-space samples.
> >
> > However, I quickly ran up against the fact that perf_event's stack
> > sampling logic (namely perf_output_sample_ustack) is called from an IRQ
> > context. This appears to preclude use of a sleepable BPF program, which
> > would be necessary to use bpf_copy_from_user. Indeed, the fact that the
> > usual stack sampling logic uses copy_from_user_inatomic rather than
> > copy_from_user suggests that this isn't a safe context for sleeping.
> >
> > So, I'm at this point a bit unclear on how to proceed. I can see a few
> > possible directions forward, although none are particularly enticing:
> >
> > * Add a bpf_copy_from_user_atomic helper, which can be called from a
> >   non-sleepable context like a perf_events overflow handler. This would
> >   take the same set_fs() and pagefault_disable() precautions as
> >   perf_output_sample_ustack to ensure that the access is safe and aborts
> >   on fault.
> >
> > * Introduce a new BPF program type,
> >   BPF_PROG_TYPE_PERF_EVENT_STACK_LOCATOR, which can be invoked by
> >   perf_output_sample_ustack to locate the stack to be sampled.
> >
> > Do either of these ideas sound upstreamable? Perhaps there are other
> > ideas on how to attack this general problem? I do not believe Haskell is
> > alone in its struggle with the current inflexibility of stack sampling;
> > the JVM introduced framepointer support specifically to allow callgraph
> > sampling; however, dedicating a register and code to this seems like an
> > unfortunate compromise, especially on x86-64 where registers are already
> > fairly precious.
> >
> > Any thoughts or suggestions would be greatly appreciated.
>
> Hi Ben,
>
> if you're sampling the stack trace of the current process
> there is no need for copy_from_user and sleepable.
> The memory with the stack trace unlikely was paged out.
> So normal bpf_probe_read_user() will work fine.
>
> This approach was used to implement 'pyperf'.
> It walks python stack traces:
> https://github.com/iovisor/bcc/tree/master/examples/cpp/pyperf
> What you're trying to do for haskel sounds very similar.
