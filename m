Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035063E5060
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 02:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhHJAgj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 20:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhHJAgj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 20:36:39 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BACC0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 17:36:18 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p4so1436673yba.3
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 17:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=58AQUwBu7ZbRb/vA20J2WUU1NJ9tEcgzVcG1YfX0pVM=;
        b=XgBR9sxTZXeoQ3l7EJg4wItfMh3bjaGYSRQVHSM6kfLZ5BB49wCu0HJ8nUN5XSe1gW
         vQ4izRP+PINinSRWL63IBBohGYbz0xLtSeUfF/XKq8IhjrUoPXwq/N6gN9VwVL0+fLFW
         cFHFu9es+Ff+VnZV/eAnGT/BlBansf0DBVLB4vcCIb3RN307pWSQAlRMiYXxn8bBjAcb
         m2XcVxQd8VdUdgRhfJhuMwtLJo0SD7UaRgcyj84Rtv/kloeo40SSX6p/Eqz7ywlMpn0D
         oc6ApkRWScWXpn70zweN+Es8L+mod9eYzHkNrRm2BlRcMU9Ip9s5hjUwlzgF4zvaGl4y
         f1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58AQUwBu7ZbRb/vA20J2WUU1NJ9tEcgzVcG1YfX0pVM=;
        b=eDsnLs0Uu2XXUSDBBcE2eLuCDNt5e06MrVWB1vzCRvaTKMj3CcGibDm9voISP4AP4Z
         N3cUEbKOWU2RcupW0tAk2kRD8TrWDpI19PhoHJvMcrGJ/LumG3KXdO7vyWtNmp727xPU
         f4lIi/3DeEZwyThWSzwz2YUoI1gbmXddE57XTuxxH3FpIyH5nUyyl1LkyLjKkL5pJmGO
         bT6ipoDFZrWkJxc15Xbli1NLB0pDVtuq1xje/6HeNKxUdTX/KJV984JJTzBDr/WWy0RF
         udfWT9NGO/hI6HKdZMqUguAlG7wIZKWH64ALy5OsmeLcTw1QlqeF4QswMfujaxaf6CW1
         rvYg==
X-Gm-Message-State: AOAM532nBzdpJMyyyVspnnJJWi3qeqZpoatEtxoX/PnQXZzJna3qL0Ny
        Zm+4Uh2qzFgTyRvug0nc86F0xksGOnCrHflgy5w=
X-Google-Smtp-Source: ABdhPJyF2uBYajhRQn0gpvKYtD9SwrKU2Zk4mn7HHlqYOWNKgMOTDPQUGSHE2Xcs3UUSPnBuU4crmTVqnOfapqsyAsc=
X-Received: by 2002:a25:2901:: with SMTP id p1mr34669071ybp.459.1628555777567;
 Mon, 09 Aug 2021 17:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210730053413.1090371-1-andrii@kernel.org> <20210730053413.1090371-3-andrii@kernel.org>
 <578a340e-1880-bea9-62c2-a028ca2fa321@iogearbox.net>
In-Reply-To: <578a340e-1880-bea9-62c2-a028ca2fa321@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Aug 2021 17:36:06 -0700
Message-ID: <CAEf4Bza_21fmSTFit2OQjscxVHW_8Yyx-A9oUicmJ4Fy9bgqEA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 02/14] bpf: refactor BPF_PROG_RUN_ARRAY family
 of macros into functions
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 4:00 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/30/21 7:34 AM, Andrii Nakryiko wrote:
> > Similar to BPF_PROG_RUN, turn BPF_PROG_RUN_ARRAY macros into proper functions
> > with all the same readability and maintainability benefits. Making them into
> > functions required shuffling around bpf_set_run_ctx/bpf_reset_run_ctx
> > functions. Also, explicitly specifying the type of the BPF prog run callback
> > required adjusting __bpf_prog_run_save_cb() to accept const void *, casted
> > internally to const struct sk_buff.
> >
> > Further, split out a cgroup-specific BPF_PROG_RUN_ARRAY_CG and
> > BPF_PROG_RUN_ARRAY_CG_FLAGS from the more generic BPF_PROG_RUN_ARRAY due to
> > the differences in bpf_run_ctx used for those two different use cases.
> >
> > I think BPF_PROG_RUN_ARRAY_CG would benefit from further refactoring to accept
> > struct cgroup and enum bpf_attach_type instead of bpf_prog_array, fetching
> > cgrp->bpf.effective[type] and RCU-dereferencing it internally. But that
> > required including include/linux/cgroup-defs.h, which I wasn't sure is ok with
> > everyone.
> >
> > The remaining generic BPF_PROG_RUN_ARRAY function will be extended to
> > pass-through user-provided context value in the next patch.
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   include/linux/bpf.h      | 187 +++++++++++++++++++++++----------------
> >   include/linux/filter.h   |   5 +-
> >   kernel/bpf/cgroup.c      |  32 +++----
> >   kernel/trace/bpf_trace.c |   2 +-
> >   4 files changed, 132 insertions(+), 94 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index c8cc09013210..9c44b56b698f 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1146,67 +1146,124 @@ struct bpf_run_ctx {};
> >
> >   struct bpf_cg_run_ctx {
> >       struct bpf_run_ctx run_ctx;
> > -     struct bpf_prog_array_item *prog_item;
> > +     const struct bpf_prog_array_item *prog_item;
> >   };
> >
> > +#ifdef CONFIG_BPF_SYSCALL
> > +static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
> > +{
> > +     struct bpf_run_ctx *old_ctx;
> > +
> > +     old_ctx = current->bpf_ctx;
> > +     current->bpf_ctx = new_ctx;
> > +     return old_ctx;
> > +}
> > +
> > +static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
> > +{
> > +     current->bpf_ctx = old_ctx;
> > +}
> > +#else /* CONFIG_BPF_SYSCALL */
> > +static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
> > +{
> > +     return NULL;
> > +}
> > +
> > +static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
> > +{
> > +}
> > +#endif /* CONFIG_BPF_SYSCALL */
>
> nit, but either is fine..:
>
> static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
> {
>         struct bpf_run_ctx *old_ctx = NULL;
>
> #ifdef CONFIG_BPF_SYSCALL
>         old_ctx = current->bpf_ctx;
>         current->bpf_ctx = new_ctx;
> #endif
>         return old_ctx;
> }
>
> static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
> {
> #ifdef CONFIG_BPF_SYSCALL
>         current->bpf_ctx = old_ctx;
> #endif
> }

sure, I don't mind

>
> >   /* BPF program asks to bypass CAP_NET_BIND_SERVICE in bind. */
> >   #define BPF_RET_BIND_NO_CAP_NET_BIND_SERVICE                        (1 << 0)
> >   /* BPF program asks to set CN on the packet. */
> >   #define BPF_RET_SET_CN                                              (1 << 0)
> >
> > -#define BPF_PROG_RUN_ARRAY_FLAGS(array, ctx, func, ret_flags)                \
> > -     ({                                                              \
> > -             struct bpf_prog_array_item *_item;                      \
> > -             struct bpf_prog *_prog;                                 \
> > -             struct bpf_prog_array *_array;                          \
> > -             struct bpf_run_ctx *old_run_ctx;                        \
> > -             struct bpf_cg_run_ctx run_ctx;                          \
> > -             u32 _ret = 1;                                           \
> > -             u32 func_ret;                                           \
> > -             migrate_disable();                                      \
> > -             rcu_read_lock();                                        \
> > -             _array = rcu_dereference(array);                        \
> > -             _item = &_array->items[0];                              \
> > -             old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);        \
> > -             while ((_prog = READ_ONCE(_item->prog))) {              \
> > -                     run_ctx.prog_item = _item;                      \
> > -                     func_ret = func(_prog, ctx);                    \
> > -                     _ret &= (func_ret & 1);                         \
> > -                     *(ret_flags) |= (func_ret >> 1);                \
> > -                     _item++;                                        \
> > -             }                                                       \
> > -             bpf_reset_run_ctx(old_run_ctx);                         \
> > -             rcu_read_unlock();                                      \
> > -             migrate_enable();                                       \
> > -             _ret;                                                   \
> > -      })
> > -
> > -#define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null, set_cg_storage)       \
> > -     ({                                              \
> > -             struct bpf_prog_array_item *_item;      \
> > -             struct bpf_prog *_prog;                 \
> > -             struct bpf_prog_array *_array;          \
> > -             struct bpf_run_ctx *old_run_ctx;        \
> > -             struct bpf_cg_run_ctx run_ctx;          \
> > -             u32 _ret = 1;                           \
> > -             migrate_disable();                      \
> > -             rcu_read_lock();                        \
> > -             _array = rcu_dereference(array);        \
> > -             if (unlikely(check_non_null && !_array))\
> > -                     goto _out;                      \
> > -             _item = &_array->items[0];              \
> > -             old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);\
> > -             while ((_prog = READ_ONCE(_item->prog))) {      \
> > -                     run_ctx.prog_item = _item;      \
> > -                     _ret &= func(_prog, ctx);       \
> > -                     _item++;                        \
> > -             }                                       \
> > -             bpf_reset_run_ctx(old_run_ctx);         \
> > -_out:                                                        \
> > -             rcu_read_unlock();                      \
> > -             migrate_enable();                       \
> > -             _ret;                                   \
> > -      })
> > +typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
> > +
> > +static __always_inline u32
> > +BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
> > +                         const void *ctx, bpf_prog_run_fn run_prog,
> > +                         u32 *ret_flags)
> > +{
> > +     const struct bpf_prog_array_item *item;
> > +     const struct bpf_prog *prog;
> > +     const struct bpf_prog_array *array;
> > +     struct bpf_run_ctx *old_run_ctx;
> > +     struct bpf_cg_run_ctx run_ctx;
> > +     u32 ret = 1;
> > +     u32 func_ret;
> > +
> > +     migrate_disable();
> > +     rcu_read_lock();
> > +     array = rcu_dereference(array_rcu);
> > +     item = &array->items[0];
> > +     old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > +     while ((prog = READ_ONCE(item->prog))) {
> > +             run_ctx.prog_item = item;
> > +             func_ret = run_prog(prog, ctx);
> > +             ret &= (func_ret & 1);
> > +             *(ret_flags) |= (func_ret >> 1);
> > +             item++;
> > +     }
> > +     bpf_reset_run_ctx(old_run_ctx);
> > +     rcu_read_unlock();
> > +     migrate_enable();
> > +     return ret;
> > +}
> > +
> > +static __always_inline u32
> > +BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
> > +                   const void *ctx, bpf_prog_run_fn run_prog)
> > +{
> > +     const struct bpf_prog_array_item *item;
> > +     const struct bpf_prog *prog;
> > +     const struct bpf_prog_array *array;
> > +     struct bpf_run_ctx *old_run_ctx;
> > +     struct bpf_cg_run_ctx run_ctx;
> > +     u32 ret = 1;
> > +
> > +     migrate_disable();
> > +     rcu_read_lock();
> > +     array = rcu_dereference(array_rcu);
> > +     item = &array->items[0];
> > +     old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > +     while ((prog = READ_ONCE(item->prog))) {
> > +             run_ctx.prog_item = item;
> > +             ret &= run_prog(prog, ctx);
> > +             item++;
> > +     }
> > +     bpf_reset_run_ctx(old_run_ctx);
> > +     rcu_read_unlock();
> > +     migrate_enable();
> > +     return ret;
> > +}
> > +
> > +static __always_inline u32
> > +BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
> > +                const void *ctx, bpf_prog_run_fn run_prog)
> > +{
> > +     const struct bpf_prog_array_item *item;
> > +     const struct bpf_prog *prog;
> > +     const struct bpf_prog_array *array;
> > +     u32 ret = 1;
> > +
> > +     migrate_disable();
> > +     rcu_read_lock();
> > +     array = rcu_dereference(array_rcu);
> > +     if (unlikely(!array))
> > +             goto out;
> > +     item = &array->items[0];
> > +     while ((prog = READ_ONCE(item->prog))) {
> > +             ret &= run_prog(prog, ctx);
> > +             item++;
> > +     }
> > +out:
> > +     rcu_read_unlock();
> > +     migrate_enable();
> > +     return ret;
> > +}
>
> Is there any way we could consolidate the above somewhat further and have things
> optimized out at compilation time, e.g. when const args are null/non-null? :/

Do you mean like passing "bool check_for_null" as an extra argument and then do

if (check_for_null && unlikely(!array))
    goto out;

?

I feel like that actually makes a bigger mess and just unnecessarily
obfuscates code, while saving just a few lines of straightforward
code. We didn't even do that for BPF_PROG_RUN_ARRAY_FLAGS vs
__BPF_PROG_RUN_ARRAY before, even though there are about 2 lines of
code differences.

But also in one of the next patches I'm adding perf-specific
bpf_perf_run_ctx (different from bpf_cg_run_ctx), so it will make
sharing the logic within these BPF_PROG_RUN_ARRAY*  even harder and
more convoluted.

Or were you talking about some other aspect here?

>
> >   /* To be used by __cgroup_bpf_run_filter_skb for EGRESS BPF progs
> >    * so BPF programs can request cwr for TCP packets.
> > @@ -1235,7 +1292,7 @@ _out:                                                   \
> >               u32 _flags = 0;                         \
> [...]
