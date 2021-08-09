Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B003E4BAD
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 20:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhHISA4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 14:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhHISAp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 14:00:45 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC899C0619E0
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 10:58:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id k65so31046788yba.13
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DHj8bQUdLJA9TWiDO+5yLLYs8506ONGixdlp8YHKNg0=;
        b=RiVObJYAq63/WaQPgpugleHZQQvz8RVezKZusj7/ub0RTDvSKL1KDK7YWyfckUSL4u
         whBsp3ULkCE0lYe4XROZvX0BT844yQ/36tQgNKUDqIJkDP8979rdl8g+uBSkfxlkXxDh
         3rs3SK4tCeKHKtQCn6/pWy8Z7Vzr6cNzmZuaBPUlR5l+liMSyGBaBaqaqOUdyfj/lywU
         ZZKjW1DU4RvE+S7m9FCB90s+uCAGcs9Xus+/0gBdCS0ns9BNanN6ctbWcNQdXMubhlZO
         XmzCmz6lktRx+Hx7G26pRZe/2jrV1YOp2OzKCZQtQlxgpzbnGf8Nv2jg+I9ITwfwmK/H
         kXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DHj8bQUdLJA9TWiDO+5yLLYs8506ONGixdlp8YHKNg0=;
        b=uL6ArlJVFbYEc25NJsLOsevzqe5wp2siThqL8LHjLoRfUrWjm+m1HGQDEp/cMEqZWR
         ARgvXbsyICSxKK2wRW2RVTIFYWSMVTwTxf5W60oAhpHzZDsvSMGNnYRT1bi/TIUm3/tQ
         M+rwboye03mA3lJTj6zafG1iNyZ7PTImkjsJwr/TdarYnj6RnqTnjumP/8tQnF+H6JW+
         7VSGRYcehRzjUxlaH6wddzKq+6ZM0D+bdUh2jvUUf9pOCAfM3fOj5EZnuk5cnFdg5y9m
         EZb+VH12QYovP1oAb8M2mfD5fE+mdlVC8ByYLww+HRxiRSnaKnKq4KhvoKiiVdzuT5UM
         oZQA==
X-Gm-Message-State: AOAM531f/Xs/fxRnTyfC1RTy/xdgTwdZ2993QiGfjL7KBdJqhZ34l+tY
        MWPEnpqV8kIG/+9N1RxFH3VhhyXZnmkSUpTO0tw=
X-Google-Smtp-Source: ABdhPJwhNLvfHHnPI1NDEtc/bIeNbdbG829uZQdC0ob28ONNsMEaKDBFjylgEabwRujqp6fRNHHbXDrSN0psvhBJf/o=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr34091968ybg.347.1628531909067;
 Mon, 09 Aug 2021 10:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210809060310.1174777-1-yhs@fb.com> <20210809060315.1175802-1-yhs@fb.com>
 <CAEf4BzY+-v4NhMmHnr8agjWj6+O7O-J909+TM1HSZUE6WYifrA@mail.gmail.com> <0b299368-370f-2292-2ae6-e86a9bc9a240@fb.com>
In-Reply-To: <0b299368-370f-2292-2ae6-e86a9bc9a240@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Aug 2021 10:58:18 -0700
Message-ID: <CAEf4BzaoLuTqp+c7HKmV98=v59xWRhAnCBJ8Ztt0=Vk6zavCVg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: don't call bpf_get_current_[ancestor_]cgroup_id()
 in sleepable progs
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 10:41 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/9/21 10:18 AM, Andrii Nakryiko wrote:
> > On Sun, Aug 8, 2021 at 11:03 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Currently, if bpf_get_current_cgroup_id() or
> >> bpf_get_current_ancestor_cgroup_id() helper is
> >> called with sleepable programs e.g., sleepable
> >> fentry/fmod_ret/fexit/lsm programs, a rcu warning
> >> may appear. For example, if I added the following
> >> hack to test_progs/test_lsm sleepable fentry program
> >> test_sys_setdomainname:
> >>
> >>    --- a/tools/testing/selftests/bpf/progs/lsm.c
> >>    +++ b/tools/testing/selftests/bpf/progs/lsm.c
> >>    @@ -168,6 +168,10 @@ int BPF_PROG(test_sys_setdomainname, struct pt_regs *regs)
> >>            int buf = 0;
> >>            long ret;
> >>
> >>    +       __u64 cg_id = bpf_get_current_cgroup_id();
> >>    +       if (cg_id == 1000)
> >>    +               copy_test++;
> >>    +
> >>            ret = bpf_copy_from_user(&buf, sizeof(buf), ptr);
> >>            if (len == -2 && ret == 0 && buf == 1234)
> >>                    copy_test++;
> >>
> >> I will hit the following rcu warning:
> >>
> >>    include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> >>    other info that might help us debug this:
> >>      rcu_scheduler_active = 2, debug_locks = 1
> >>      1 lock held by test_progs/260:
> >>        #0: ffffffffa5173360 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xa0
> >>      stack backtrace:
> >>      CPU: 1 PID: 260 Comm: test_progs Tainted: G           O      5.14.0-rc2+ #176
> >>      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> >>      Call Trace:
> >>        dump_stack_lvl+0x56/0x7b
> >>        bpf_get_current_cgroup_id+0x9c/0xb1
> >>        bpf_prog_a29888d1c6706e09_test_sys_setdomainname+0x3e/0x89c
> >>        bpf_trampoline_6442469132_0+0x2d/0x1000
> >>        __x64_sys_setdomainname+0x5/0x110
> >>        do_syscall_64+0x3a/0x80
> >>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >> I can get similar warning using bpf_get_current_ancestor_cgroup_id() helper.
> >> syzbot reported a similar issue in [1] for syscall program. Helper
> >> bpf_get_current_cgroup_id() or bpf_get_current_ancestor_cgroup_id()
> >> has the following callchain:
> >>     task_dfl_cgroup
> >>       task_css_set
> >>         task_css_set_check
> >> and we have
> >>     #define task_css_set_check(task, __c)                                   \
> >>             rcu_dereference_check((task)->cgroups,                          \
> >>                     lockdep_is_held(&cgroup_mutex) ||                       \
> >>                     lockdep_is_held(&css_set_lock) ||                       \
> >>                     ((task)->flags & PF_EXITING) || (__c))
> >> Since cgroup_mutex/css_set_lock is not held and the task
> >> is not existing and rcu read_lock is not held, a warning
> >> will be issued. Note that bpf sleepable program is protected by
> >> rcu_read_lock_trace().
> >>
> >> To fix the issue, let us make these two helpers not available
> >> to sleepable program. I marked the patch fixing 95b861a7935b
> >> ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
> >> which added bpf_get_current_ancestor_cgroup_id() to
> >> 5.14. I think backporting 5.14 is probably good enough as sleepable
> >> progrems are not widely used.
> >>
> >> This patch should fix [1] as well since syscall program is a sleepable
> >> program and bpf_get_current_cgroup_id() is not available to
> >> syscall program any more.
> >>
> >>   [1] https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/
> >>
> >> Reported-by: syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
> >> Fixes: 95b861a7935b ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   kernel/trace/bpf_trace.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index b4916ef388ad..eaa8a8ffbe46 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -1016,9 +1016,11 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >>   #endif
> >>   #ifdef CONFIG_CGROUPS
> >>          case BPF_FUNC_get_current_cgroup_id:
> >> -               return &bpf_get_current_cgroup_id_proto;
> >> +               return prog->aux->sleepable ?
> >> +                      NULL : &bpf_get_current_cgroup_id_proto;
> >>          case BPF_FUNC_get_current_ancestor_cgroup_id:
> >> -               return &bpf_get_current_ancestor_cgroup_id_proto;
> >> +               return prog->aux->sleepable ?
> >> +                      NULL : &bpf_get_current_ancestor_cgroup_id_proto;
> >
> > This feels too extreme. I bet these helpers are as useful in sleepable
> > BPF progs as they are in non-sleepable ones.
> >
> > Why don't we just implement a variant of get_current_cgroup_id (and
> > the ancestor variant as well) which takes that cgroup_mutex lock, and
> > just pick the appropriate implementation. Wouldn't that work?
>
> This may not work. e.g., for sleepable fentry program,
> if the to-be-traced function is inside in cgroup_mutex, we will
> have a deadlock.

We can also do preempty_disable() + rcu_read_lock() inside the helper
itself, no? I mean in the new "sleepable" variant.

>
> Currently, affected program types are tracing/fentry.s,
> tracing/fexit.s, tracing/fmod_ret.s, lsm.s and syscall.
> For fmod_ret.s, lsm.s, they all have
> some kind of predefined attachment/context, we might
> be able to check all potential attachment points and
> allow these two helpers when attachment point is not
> surrounded by cgroup_mutex.

I don't think it's feasible to know if any given attached kernel
function can be called with cgroup_mutex taken. Static analysis will
be too complicated and too restrictive. Runtime checks might be too
expensive and/or not generic enough. But see above, we can do
rcu_read_lock() inside the helper while preventing preemption, and it
will behave the same way as if it was called from non-sleepable BPF
prog.

> For syscall program, we should be okay as it is
> called with bpf_prog_test_run interface but I am
> not sure why user wants a cgroup_id for that.
>
> >
> >>   #endif
> >>          case BPF_FUNC_send_signal:
> >>                  return &bpf_send_signal_proto;
> >> --
> >> 2.30.2
> >>
