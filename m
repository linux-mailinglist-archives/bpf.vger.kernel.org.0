Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905D322838
	for <lists+bpf@lfdr.de>; Sun, 19 May 2019 20:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfESSHJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 May 2019 14:07:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40356 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfESSHF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 May 2019 14:07:05 -0400
Received: by mail-io1-f65.google.com with SMTP id s20so9277958ioj.7
        for <bpf@vger.kernel.org>; Sun, 19 May 2019 11:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrJ+8w3q4C2ZYv1/8t+7v0iFZoScN0cheuy7tMbszSA=;
        b=qwH+ZkJPtv+OcphTB1F3aJ4AMlPgXvQOeJnEvr338O631vS0lNv7mnMTLt67bwspAz
         i6R6LfHXcte86idMvEOY2rG64GYkg6ZSidpmiYq3uYSBRxWgw22iG6TUQrGWTbvRYsbP
         aSKxtANq+x69SHjemJ0Sz5cjgEJuY7zSM5LnysXLjrIYlFGJPQV9bvrl1Ae/kqsxA7Ex
         rCIo8viaApNkiBOeW3/s6+ojn4kheJxPNj4JWACw35mZ+zpV8sAGGeV3HnRsHb20toAL
         Yy6pOVNezvxSIzO5ab9vF0w1L8IuMmtpW8LTHjFXMun84p36T026wOsFvHdmi/m7QdvQ
         a4Ng==
X-Gm-Message-State: APjAAAXZ2cPqr2XardK0DzuGMQNpfDIhZer+dPwP8UtTYx24Ku7s6tCK
        Vbv1CBtMpQD7gdY1GF8HoxeNeR4QBqiUmxfskp1+Dg==
X-Google-Smtp-Source: APXvYqy1XROmNEZrT2qxm6jsC0ny+x7qxxPnQf9qM8ZsWe9g/PqSWqm7OW/MwwlBoVYHrD2cnsDtsbxmX6BSu5mYL+0=
X-Received: by 2002:a6b:7d0d:: with SMTP id c13mr8028833ioq.249.1558289224445;
 Sun, 19 May 2019 11:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com> <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net> <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net>
In-Reply-To: <20190517091044.GM2606@hirez.programming.kicks-ass.net>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 20 May 2019 02:06:54 +0800
Message-ID: <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>,
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

On Fri, May 17, 2019 at 5:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, May 17, 2019 at 04:15:39PM +0800, Kairui Song wrote:
> > Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
> > some other bfp functions) is now broken, or, strating an unwind
> > directly inside a bpf program will end up strangely. It have following
> > kernel message:
>
> Urgh, what is that bpf_get_stackid_tp() doing to get the regs? I can't
> follow.

bpf_get_stackid_tp will just use the regs passed to it from the trace
point. And then it will eventually call perf_get_callchain to get the
call chain.
With a tracepoint we have the fake regs, so unwinder will start from
where it is called, and use the fake regs as the indicator of the
target frame it want, and keep unwinding until reached the actually
callsite.

But if the stack trace is started withing a bpf func call then it's broken...

If the unwinder could trace back through the bpf func call then there
will be no such problem.

For frame pointer unwinder, set the indicator flag (X86_EFLAGS_FIXED)
before bpf call, and ensure bp is also dumped could fix it (so it will
start using the regs for bpf calls, like before the commit
d15d356887e7). But for ORC I don't see a clear way to fix the problem.
First though is maybe dump some callee's regs for ORC (IP, BP, SP, DI,
DX, R10, R13, else?) in the trace point handler, then use the flag to
indicate ORC to do one more unwind (because can't get caller's regs,
so get callee's regs instaed) before actually giving output?

I had a try, for framepointer unwinder, mark the indicator flag before
calling bpf functions, and dump bp as well in the trace point. Then
with frame pointer, it works, test passed:

diff --git a/arch/x86/include/asm/perf_event.h
b/arch/x86/include/asm/perf_event.h
index 1392d5e6e8d6..6f1192e9776b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -302,12 +302,25 @@ extern unsigned long perf_misc_flags(struct
pt_regs *regs);

 #include <asm/stacktrace.h>

+#ifdef CONFIG_FRAME_POINTER
+static inline unsigned long caller_frame_pointer(void)
+{
+       return (unsigned long)__builtin_frame_address(1);
+}
+#else
+static inline unsigned long caller_frame_pointer(void)
+{
+       return 0;
+}
+#endif
+
 /*
  * We abuse bit 3 from flags to pass exact information, see perf_misc_flags
  * and the comment with PERF_EFLAGS_EXACT.
  */
 #define perf_arch_fetch_caller_regs(regs, __ip)                {       \
        (regs)->ip = (__ip);                                    \
+       (regs)->bp = caller_frame_pointer();                    \
        (regs)->sp = (unsigned long)__builtin_frame_address(0); \
        (regs)->cs = __KERNEL_CS;                               \
        regs->flags = 0;                                        \
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..ca7b95ee74f0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8549,6 +8549,7 @@ void perf_trace_run_bpf_submit(void *raw_data,
int size, int rctx,
                               struct task_struct *task)
 {
        if (bpf_prog_array_valid(call)) {
+               regs->flags |= X86_EFLAGS_FIXED;
                *(struct pt_regs **)raw_data = regs;
                if (!trace_call_bpf(call, raw_data) || hlist_empty(head)) {
                        perf_swevent_put_recursion_context(rctx);
@@ -8822,6 +8823,8 @@ static void bpf_overflow_handler(struct perf_event *event,
        int ret = 0;

        ctx.regs = perf_arch_bpf_user_pt_regs(regs);
+       ctx.regs->flags |= X86_EFLAGS_FIXED;
+
        preempt_disable();
        if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
                goto out;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f92d6ad5e080..e1fa656677dc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -497,6 +497,8 @@ u64 bpf_event_output(struct bpf_map *map, u64
flags, void *meta, u64 meta_size,
        };

        perf_fetch_caller_regs(regs);
+       regs->flags |= X86_EFLAGS_FIXED;
+
        perf_sample_data_init(sd, 0, 0);
        sd->raw = &raw;

@@ -831,6 +833,8 @@ BPF_CALL_5(bpf_perf_event_output_raw_tp, struct
bpf_raw_tracepoint_args *, args,
        struct pt_regs *regs = this_cpu_ptr(&bpf_raw_tp_regs);

        perf_fetch_caller_regs(regs);
+       regs->flags |= X86_EFLAGS_FIXED;
+
        return ____bpf_perf_event_output(regs, map, flags, data, size);
 }

@@ -851,6 +855,8 @@ BPF_CALL_3(bpf_get_stackid_raw_tp, struct
bpf_raw_tracepoint_args *, args,
        struct pt_regs *regs = this_cpu_ptr(&bpf_raw_tp_regs);

        perf_fetch_caller_regs(regs);
+       regs->flags |= X86_EFLAGS_FIXED;
+
        /* similar to bpf_perf_event_output_tp, but pt_regs fetched
differently */
        return bpf_get_stackid((unsigned long) regs, (unsigned long) map,
                               flags, 0, 0);
@@ -871,6 +877,8 @@ BPF_CALL_4(bpf_get_stack_raw_tp, struct
bpf_raw_tracepoint_args *, args,
        struct pt_regs *regs = this_cpu_ptr(&bpf_raw_tp_regs);

        perf_fetch_caller_regs(regs);
+       regs->flags |= X86_EFLAGS_FIXED;
+
        return bpf_get_stack((unsigned long) regs, (unsigned long) buf,
                             (unsigned long) size, flags, 0);
 }

And *_raw_tp functions will fetch the regs by themselves so a bit
trouble some...

----------

And another approach is to make unwinder direct unwinding works when
called by bpf (if possible and reasonable). I also had a nasty hacky
experiment (posted below) to just force frame pointer unwinder's
get_stack_info pass for bpf, then problem is fixed without any other
workaround:

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 753b8cfe8b8a..c0cfdf25f5ed 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -166,7 +166,8 @@ int get_stack_info(unsigned long *stack, struct
task_struct *task,
        if (in_entry_stack(stack, info))
                goto recursion_check;

-       goto unknown;
+       goto recursion_check;

 recursion_check:
        /*

Don't know how to do it the right way, or is it even possible for all
unwinders yet...

-- 
Best Regards,
Kairui Song
