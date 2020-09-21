Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774E227311B
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 19:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgIURre (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 13:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIURre (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 13:47:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD27C061755
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 10:47:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lo4so18939873ejb.8
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVoTB5ka9ij/JNpMUQJi3uemYQWRbk5sRyxB8af0Yk4=;
        b=iqJprXevp6YDSedAolM02uxv2cp/VvZkDrKCCaO+89H5aB2fW4FG0aF+s3sWCB3S16
         LrGTxEKt5vKKXLbFEmE8dYK0Ety4W7YGQlALf6fXgM7HaJQXNIXZL29uGpoqtKz+2naV
         MmSszpAeuePE2GFK55RuS22V2W88ZD458SxQlfYzxK7EJwN8ZVtHZ4CowY54hnAe5QJC
         xJEHk+lHx884k8Ri8/X2BtjIb0eoqy29IjFDXGTYAa/7HuPWpBgyIFIVB8nosZIcFvKB
         nkqQkVBTSGebVutfgBiREpafaBBHUM991eqqzZuZwheCK+pE4a+tcor/dw+HgnDQx2Vi
         gwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVoTB5ka9ij/JNpMUQJi3uemYQWRbk5sRyxB8af0Yk4=;
        b=IkIXKHVCq28g8lLhNiayQ5tPhLPuq3fpz/QICRHbKQa/4cpZs0ZKJd3n5wZyt17nXU
         WCNrhqDwE5kqCa85NBtx6Oi3SQT61k7NaYKQeYCweaFErOeWr3aSDgEahJwSCmWwtSJL
         sU/fCa43lv9lVs6mKimtidpNjghqlgGUOUSLefsYoYgjtdqp5yRHeklCRnLhI0wLka/W
         Oa/bK7Awen/RBv/+6uuxDKJjvrAww0e9sEQjo8UzRrnJgLUmZnqOkYgB/rh1I/EkWV/p
         seO7H+koHYXZuQcq40/UnZ1pZbVqg2sWdi8EWkei6fgVTf3vKn+/VS2asjMieENlkfC5
         9Jjg==
X-Gm-Message-State: AOAM532H/0/6qt16qoGje/fDFYjwyvJWj4oi1Qh14T0VheyVOo3mmc+z
        2FXOlKGRCWwxIaGXaKYNPRtBsh0bKNKgQVQ9BNaK6A==
X-Google-Smtp-Source: ABdhPJzUx+dGF1qmUJjldN5R/Kp/CHg8b3GsPokZFi763Z3EI3PzJUFPr6qBkBdrErj+QF7fFBLW4ARTCHeUiHBtnXc=
X-Received: by 2002:a17:906:9389:: with SMTP id l9mr581002ejx.537.1600710452090;
 Mon, 21 Sep 2020 10:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <6af89348c08a4820039e614a090d35aa1583acff.1600661419.git.yifeifz2@illinois.edu>
In-Reply-To: <6af89348c08a4820039e614a090d35aa1583acff.1600661419.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Sep 2020 19:47:05 +0200
Message-ID: <CAG48ez0OqZavgm0BkGjCAJUr5UfRgbeCbmLOZFJ=Rj46COcN3Q@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 1/2] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 7:35 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> SECCOMP_CACHE_NR_ONLY will only operate on syscalls that do not
> access any syscall arguments or instruction pointer. To facilitate
> this we need a static analyser to know whether a filter will
> access. This is implemented here with a pseudo-emulator, and
> stored in a per-filter bitmap. Each seccomp cBPF instruction,
> aside from ALU (which should rarely be used in seccomp), gets a
> naive best-effort emulation for each syscall number.
>
> The emulator works by following all possible (without SAT solving)
> paths the filter can take. Every cBPF register / memory position
> records whether that is a constant, and of so, the value of the
> constant. Loading from struct seccomp_data is considered constant
> if it is a syscall number, else it is an unknown. For each
> conditional jump, if the both arguments can be resolved to a
> constant, the jump is followed after computing the result of the
> condition; else both directions are followed, by pushing one of
> the next states to a linked list of next states to process. We
> keep a finite number of pending states to process.

Is this actually necessary, or can we just bail out on any branch that
we can't statically resolve?

struct seccomp_data only contains the syscall number (constant for a
given filter evaluation), the architecture number (also constant), the
instruction pointer (basically never used in seccomp filters), and the
syscall arguments. Any normal seccomp filter first branches on the
architecture, then branches on the syscall number, and then branches
on arguments if necessary.

This optimization could only be improved by the "follow both branches"
logic if a seccomp program branches on either the instruction pointer
or an argument *before* looking at the syscall number, and later comes
to the same conclusion on *both* sides of the check. It would have to
be something like:

if (instruction_pointer == 0xasdf1234) {
  if (nr == mmap) return ACCEPT;
  [...]
  return KILL;
} else {
  if (nr == mmap) return ACCEPT;
  [...]
  return KILL;
}

I've never seen anyone do something like this. And the proposed patch
would still bail out on such a filter because of the load from the
instruction_pointer field; I don't think it would even be possible to
reach a branch with an unknown condition with this patch. So I think
we should probably get rid of this extra logic for keeping track of
multiple execution states for now. That would make the code a lot
simpler.


Also: If it turns out that the time spent in seccomp_cache_prepare()
is measurable for large filters, a possible improvement would be to
keep track of the last syscall number for which the result would be
the same as for the current one, such that instead of evaluating the
filter for one instruction at a time, it would effectively be
evaluated for a range at a time. That should be pretty straightforward
to implement, I think.

> The emulation is halted if it reaches a return, or if it reaches a
> read from struct seccomp_data that reads an offset that is neither
> syscall number or architecture number. In the latter case, we mark
> the syscall number as not okay for seccomp to cache. If a filter
> depends on more filters, then if its dependee cannot process the
> syscall then the depender is also marked not to process the syscall.
>
> We also do a single pass on the entire filter instructions before
> performing emulation. If none of the filter instructions load from
> the troublesome offsets, then the filter is considered "trivial",
> and all syscalls are marked okay for seccomp to cache.
>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/x86/Kconfig |  27 ++++
>  kernel/seccomp.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 349 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
[...]
> +choice
> +       prompt "Seccomp filter cache"
> +       default SECCOMP_CACHE_NONE

I think this should be on by default.

> +       depends on SECCOMP
> +       depends on SECCOMP_FILTER

SECCOMP_FILTER already depends on SECCOMP, so the "depends on SECCOMP"
line is unnecessary.

> +       help
> +         Seccomp filters can potentially incur large overhead for each
> +         system call. This can alleviate some of the overhead.
> +
> +         If in doubt, select 'none'.

This should not be in arch/x86. Other architectures, such as arm64,
should also be able to use this without extra work.

> +config SECCOMP_CACHE_NONE
> +       bool "None"
> +       help
> +         No caching is done. Seccomp filters will be called each time
> +         a system call occurs in a seccomp-guarded task.
> +
> +config SECCOMP_CACHE_NR_ONLY
> +       bool "Syscall number only"
> +       help
> +         This is enables a bitmap to cache the results of seccomp
> +         filters, if the filter allows the syscall and is independent
> +         of the syscall arguments.

Maybe reword this as something like: "For each syscall number, if the
seccomp filter has a fixed result, store that result in a bitmap to
speed up system calls."

> This requires around 60 bytes per
> +         filter and 70 bytes per task.
> +
> +endchoice
> +
>  source "kernel/Kconfig.hz"
>
>  config KEXEC
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 3ee59ce0a323..d8c30901face 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -143,6 +143,27 @@ struct notification {
>         struct list_head notifications;
>  };
>
> +#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
> +/**
> + * struct seccomp_cache_filter_data - container for cache's per-filter data
> + *
> + * @syscall_ok: A bitmap where each bit represent whether seccomp is allowed to

nit: represents

> + *             cache the results of this syscall.
> + */
> +struct seccomp_cache_filter_data {
> +       DECLARE_BITMAP(syscall_ok, NR_syscalls);
> +};
> +
> +#define SECCOMP_EMU_MAX_PENDING_STATES 64
> +#else
> +struct seccomp_cache_filter_data { };
> +
> +static inline int seccomp_cache_prepare(struct seccomp_filter *sfilter)
> +{
> +       return 0;
> +}
> +#endif /* CONFIG_SECCOMP_CACHE_NR_ONLY */
[...]
> +/**
> + * seccomp_emu_step - step one instruction in the emulator
> + * @env: The emulator environment
> + * @state: The emulator state
> + *
> + * Returns 1 to halt emulation, 0 to continue, or -errno if error occurred.
> + */
> +static int seccomp_emu_step(struct seccomp_emu_env *env,
> +                           struct seccomp_emu_state *state)
> +{
> +       struct sock_filter *ftest = &env->filter[state->pc++];
> +       struct seccomp_emu_state *new_state;
> +       u16 code = ftest->code;
> +       u32 k = ftest->k;
> +       u32 operand;
> +       bool compare;
> +       int reg_idx;
> +
> +       switch (BPF_CLASS(code)) {
> +       case BPF_LD:
> +       case BPF_LDX:
> +               reg_idx = BPF_CLASS(code) == BPF_LDX;
> +
> +               switch (BPF_MODE(code)) {
> +               case BPF_IMM:
> +                       state->reg_known[reg_idx] = true;
> +                       state->reg_const[reg_idx] = k;
> +                       break;
> +               case BPF_ABS:
> +                       if (k == offsetof(struct seccomp_data, nr)) {
> +                               state->reg_known[reg_idx] = true;
> +                               state->reg_const[reg_idx] = env->nr;
> +                       } else {
> +                               state->reg_known[reg_idx] = false;

This is completely broken. This emulation logic *needs* to run with
the proper architecture identifier. (And for platforms like x86-64
that have compatibility support for a second ABI, the emulation should
probably also be done for that ABI, and there should be separate
bitmasks for that ABI.)

With the current logic, you will (almost) never actually have
permitted syscalls in the bitmask, because filters fundamentally have
to return different results for different ABIs - the syscall numbers
mean completely different things under different ABIs.

> +                               if (k != offsetof(struct seccomp_data, arch)) {
> +                                       env->syscall_ok = false;
> +                                       return 1;
> +                               }
> +                       }

This would read nicer as:

if (k == offsetof(struct seccomp_data, nr)) {

} else if (k == offsetof(struct seccomp_data, arch)) {

} else {
  env->syscall_ok = false;
  return 1;
}

> +
> +                       break;
> +               case BPF_MEM:
> +                       state->reg_known[reg_idx] = state->reg_known[2 + k];
> +                       state->reg_const[reg_idx] = state->reg_const[2 + k];
> +                       break;
> +               default:
> +                       state->reg_known[reg_idx] = false;
> +               }
> +
> +               return 0;
> +       case BPF_ST:
> +       case BPF_STX:
> +               reg_idx = BPF_CLASS(code) == BPF_STX;
> +
> +               state->reg_known[2 + k] = state->reg_known[reg_idx];
> +               state->reg_const[2 + k] = state->reg_const[reg_idx];

I think we should probably just bail out if we see anything that's
BPF_ST/BPF_STX. I've never seen seccomp filters that actually use that
part of cBPF.

But in case we do need this, maybe instead of using "2 +" for all
these things, the cBPF memory slots should be in a separate array.

> +               return 0;
> +       case BPF_ALU:
> +               state->reg_known[0] = false;
> +               return 0;
> +       case BPF_JMP:
> +               if (BPF_OP(code) == BPF_JA) {
> +                       state->pc += k;
> +                       return 0;
> +               }
> +
> +               if (ftest->jt == ftest->jf) {
> +                       state->pc += ftest->jt;
> +                       return 0;
> +               }

Why is this check here? Is anyone actually creating filters with such
obviously nonsensical branches? I know that there are highly ludicrous
filters out there, but I don't think I've ever seen this specific kind
of useless code.

> +               if (!state->reg_known[0])
> +                       goto both_cases;
[...]
> +both_cases:
> +               if (env->next_state_len >= SECCOMP_EMU_MAX_PENDING_STATES)
> +                       return -E2BIG;

Even if we cap the maximum number of pending states, this could still
run for an almost unbounded amount of time, I think. Which is bad. If
this code was actually necessary, we'd probably want to track
separately the total number of branches we've seen and so on.

But as I said, I think this code should just be removed instead.

[...]
> +       }
> +}
[...]
