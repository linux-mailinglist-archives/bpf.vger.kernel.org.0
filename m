Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFF2283A
	for <lists+bpf@lfdr.de>; Sun, 19 May 2019 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfESSH3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 May 2019 14:07:29 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53164 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfESSH3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 May 2019 14:07:29 -0400
Received: by mail-it1-f193.google.com with SMTP id q65so19469877itg.2
        for <bpf@vger.kernel.org>; Sun, 19 May 2019 11:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7S1JiY5XMndUySOPpCBhO3vugzf338c54HkvkOEdUI=;
        b=i4khMEpiQd3utPyQ2qhBaDJUGl8P8qqyJXND/paxP1OFWrA+2uTsz9ZLXaH+73bubr
         7rNj4X1TtuvB7l9bq3GjVdL4VOpd1OPmYYEDn3MjX9sxXEER8VWapNn/pCzXkrT7jlwT
         /2RHAnvozvdOzcuxLCvFxt6Y8YU/jgIGNbLXoqBb0QtwgzTauxJd/F3m5/WSQvTXHnLh
         bOpacXmc3tV9I2ZrWDZMyQJXhJz18VypYuKJVEfbklS0HwYtReElmPDChunjiCXCx4EF
         3aBVDHRuycAO+g8O0ss0ViixGOpNA6i1AvaMh9ECDp+dn2P+yNR9W2ZMD4cvw/VANCyD
         xkQA==
X-Gm-Message-State: APjAAAW2VIPzfLnxXf6/z6Wb1f5/vQtE5WSF8NGoxQ5Fcuosd9JkCSHr
        5DGG/CgINLFSuaZLjndkhgEXRFxfM7wCT3V+0VZDmQ==
X-Google-Smtp-Source: APXvYqzP5hoR7AStmML42U8uNCorWch+uTjHRCykkRZbdO5pXKwP6oCjkjO5vOQkA/sKjCaQPRa48D4ntAa22XdygUI=
X-Received: by 2002:a24:7a90:: with SMTP id a138mr25523149itc.95.1558289248398;
 Sun, 19 May 2019 11:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com> <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net> <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net> <8C814E68-B0B6-47E4-BDD6-917B01EC62D0@fb.com>
 <c881767d-b6f3-c53e-5c70-556d09ea8d89@fb.com> <8449BBF3-E754-4ABC-BFEF-A8F264297F2D@fb.com>
In-Reply-To: <8449BBF3-E754-4ABC-BFEF-A8F264297F2D@fb.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 20 May 2019 02:07:19 +0800
Message-ID: <CACPcB9emh9T23sixx-91mg2wL6kgrYF4MVfmuTCE0SsD=8efcQ@mail.gmail.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
To:     Song Liu <songliubraving@fb.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 18, 2019 at 5:48 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On May 17, 2019, at 2:06 PM, Alexei Starovoitov <ast@fb.com> wrote:
> >
> > On 5/17/19 11:40 AM, Song Liu wrote:
> >> +Alexei, Daniel, and bpf
> >>
> >>> On May 17, 2019, at 2:10 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >>>
> >>> On Fri, May 17, 2019 at 04:15:39PM +0800, Kairui Song wrote:
> >>>> Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
> >>>> some other bfp functions) is now broken, or, strating an unwind
> >>>> directly inside a bpf program will end up strangely. It have following
> >>>> kernel message:
> >>>
> >>> Urgh, what is that bpf_get_stackid_tp() doing to get the regs? I can't
> >>> follow.
> >>
> >> I guess we need something like the following? (we should be able to
> >> optimize the PER_CPU stuff).
> >>
> >> Thanks,
> >> Song
> >>
> >>
> >> diff --git i/kernel/trace/bpf_trace.c w/kernel/trace/bpf_trace.c
> >> index f92d6ad5e080..c525149028a7 100644
> >> --- i/kernel/trace/bpf_trace.c
> >> +++ w/kernel/trace/bpf_trace.c
> >> @@ -696,11 +696,13 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_tp = {
> >>         .arg5_type      = ARG_CONST_SIZE_OR_ZERO,
> >>  };
> >>
> >> +static DEFINE_PER_CPU(struct pt_regs, bpf_stackid_tp_regs);
> >>  BPF_CALL_3(bpf_get_stackid_tp, void *, tp_buff, struct bpf_map *, map,
> >>            u64, flags)
> >>  {
> >> -       struct pt_regs *regs = *(struct pt_regs **)tp_buff;
> >> +       struct pt_regs *regs = this_cpu_ptr(&bpf_stackid_tp_regs);
> >>
> >> +       perf_fetch_caller_regs(regs);
> >
> > No. pt_regs is already passed in. It's the first argument.
> > If we call perf_fetch_caller_regs() again the stack trace will be wrong.
> > bpf prog should not see itself, interpreter or all the frames in between.
>
> Thanks Alexei! I get it now.
>
> In bpf_get_stackid_tp(), the pt_regs is get by dereferencing the first field
> of tp_buff:
>
>         struct pt_regs *regs = *(struct pt_regs **)tp_buff;
>
> tp_buff points to something like
>
>         struct sched_switch_args {
>                 unsigned long long pad;
>                 char prev_comm[16];
>                 int prev_pid;
>                 int prev_prio;
>                 long long prev_state;
>                 char next_comm[16];
>                 int next_pid;
>                 int next_prio;
>         };
>
> where the first field "pad" is a pointer to pt_regs.
>
> @Kairui, I think you confirmed that current code will give empty call trace
> with ORC unwinder? If that's the case, can we add regs->ip back? (as in the
> first email of this thread.
>
> Thanks,
> Song
>

Hi thanks for the suggestion, yes we can add it should be good an idea
to always have IP when stack trace is not available.
But stack trace is actually still broken, it will always give only one
level of stacktrace (the IP).

-- 
Best Regards,
Kairui Song
