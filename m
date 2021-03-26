Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2110434B24F
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 23:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhCZWv2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 18:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhCZWvV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 18:51:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2179EC0613AA;
        Fri, 26 Mar 2021 15:51:21 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o66so7372182ybg.10;
        Fri, 26 Mar 2021 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wo1xdtPvSfPYNdGvfB/dj7upKQGrr8JQkBYTGwXZk30=;
        b=c3A2uDO9nuopsC7Bfv6aw/O7cwWYnuEcJlO+eq9xmeGZ6Uubf3GJUMC5LxMHBIKmCD
         MA3wDQVubMGNWXrFQdDdW89GL5ovBKr3nMZOLe6LlflBPAJQBMj3eRIr0bThl9RM1OYF
         y091L3UArKWtRl5qM2vvoiMjQJNhafUK9TgDZ8MoE9dCRZ1z7QXP6P6l1gdPAmnDjSmh
         Gfu80Ul8gHBVK1qQXUu+aoFLUibR/TN120C2BMqFCysff5adwfMPDnCuKkHv+09mcsdE
         thlUSzg2aglt6Wo5a3oQUegb1ATIxoN1FG6Ry6nhyhF0NjjCZhgHXa8+o9p+EmZMz7Qs
         SqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wo1xdtPvSfPYNdGvfB/dj7upKQGrr8JQkBYTGwXZk30=;
        b=lnCjRQcWw2+1f8kYNIaYLrQ1iNdJO4P3VWcPOKf8AYe0RlDo4Wz0MtnmusBUEJQ6bp
         xbq74QwZhfPzlBR9BC+F7tzeZgT4NMHzYjNI9x6fsJZM5j6sn3LSd2xiHZ2jtJR6w2ny
         MbPcWVeEQPYX6BBwHLqkn3aTREmuT9OP292L62SKtZyGaQa8icbBjl3+cI6AOZLJIzvl
         xXulOlIwE2XICQaVFgFe6guwSib68Io0vktQG6YQ6WmV3ATApapCgVX5vajTeEKYxFoN
         +p+q96KEpXsPDR+J+UoLWrlLX8c6nyGBwXuIvYJ7NX2HQc4GaDzbjQhIAmxVhTfNddbH
         S/Qg==
X-Gm-Message-State: AOAM532J+DK/f2qqmBEMhofuJnvdqpxNDHkJ12UUGrWHSu1Ve3XSn4aQ
        YGO204NWifGUGvRIK0yDJozouDXCFEkEAqXehYF7nETQAHM=
X-Google-Smtp-Source: ABdhPJyJsQ+U80oti2ENieabuzvAaL+3BQRGcknnMPzFKhEJzggh6LTo2Q2/wAN0dGAbe0BjQ6wBT/erIraUDLDa5Js=
X-Received: by 2002:a25:874c:: with SMTP id e12mr21619164ybn.403.1616799079001;
 Fri, 26 Mar 2021 15:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-2-revest@chromium.org>
 <CAEf4BzZP6uK_ZcKJZsESWrMHG5kEG_swRYJwqsaiD95CEOdJ5g@mail.gmail.com>
In-Reply-To: <CAEf4BzZP6uK_ZcKJZsESWrMHG5kEG_swRYJwqsaiD95CEOdJ5g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Mar 2021 15:51:08 -0700
Message-ID: <CAEf4BzYVTHm5Zrr7RPoRB7EL9nsE5kUzciHEv5fPipbMoEtQxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Factorize bpf_trace_printk and bpf_seq_printf
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 26, 2021 at 2:53 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
> >
> > Two helpers (trace_printk and seq_printf) have very similar
> > implementations of format string parsing and a third one is coming
> > (snprintf). To avoid code duplication and make the code easier to
> > maintain, this moves the operations associated with format string
> > parsing (validation and argument sanitization) into one generic
> > function.
> >
> > Unfortunately, the implementation of the two existing helpers already
> > drifted quite a bit and unifying them entailed a lot of changes:
>
> "Unfortunately" as in a lot of extra work for you? I think overall
> though it was very fortunate that you ended up doing it, all
> implementations are more feature-complete and saner now, no? Thanks a
> lot for your hard work!
>
> >
> > - bpf_trace_printk always expected fmt[fmt_size] to be the terminating
> >   NULL character, this is no longer true, the first 0 is terminating.
>
> You mean if you had bpf_trace_printk("bla bla\0some more bla\0", 24)
> it would emit that zero character? If yes, I don't think it was a sane
> behavior anyways.
>
> > - bpf_trace_printk now supports %% (which produces the percentage char).
> > - bpf_trace_printk now skips width formating fields.
> > - bpf_trace_printk now supports the X modifier (capital hexadecimal).
> > - bpf_trace_printk now supports %pK, %px, %pB, %pi4, %pI4, %pi6 and %pI6
> > - argument casting on 32 bit has been simplified into one macro and
> >   using an enum instead of obscure int increments.
> >
> > - bpf_seq_printf now uses bpf_trace_copy_string instead of
> >   strncpy_from_kernel_nofault and handles the %pks %pus specifiers.
> > - bpf_seq_printf now prints longs correctly on 32 bit architectures.
> >
> > - both were changed to use a global per-cpu tmp buffer instead of one
> >   stack buffer for trace_printk and 6 small buffers for seq_printf.
> > - to avoid per-cpu buffer usage conflict, these helpers disable
> >   preemption while the per-cpu buffer is in use.
> > - both helpers now support the %ps and %pS specifiers to print symbols.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
>
> This is great, you already saved some lines of code! I suspect I'll
> have some complaints about mods (it feels like this preample should
> provide extra information about which arguments have to be read from
> kernel/user memory, but I'll see next patches first.

Disregard the last part (at least for now). I had a mental model that
it should be possible to parse a format string once and then remember
"instructions" (i.e., arg1 is long, arg2 is string, and so on). But
that's too complicated, so I think re-parsing the format string is
much simpler.

>
> See my comments below (I deliberately didn't trim most of the code for
> easier jumping around), but it's great overall, thanks!
>
> >  kernel/trace/bpf_trace.c | 529 ++++++++++++++++++---------------------
> >  1 file changed, 244 insertions(+), 285 deletions(-)
> >

[...]

> > +int bpf_printf_preamble(char *fmt, u32 fmt_size, const u64 *raw_args,
> > +                       u64 *final_args, enum bpf_printf_mod_type *mod,
> > +                       u32 num_args)
> > +{
> > +       struct bpf_printf_buf *bufs = this_cpu_ptr(&bpf_printf_buf);
> > +       int err, i, fmt_cnt = 0, copy_size, used;
> > +       char *unsafe_ptr = NULL, *tmp_buf = NULL;
> > +       bool prepare_args = final_args && mod;
>
> probably better to enforce that both or none are specified, otherwise
> return error

it's actually three of them: raw_args, mod, and num_args, right? All
three are either NULL or non-NULL.

>
> > +       enum bpf_printf_mod_type current_mod;
> > +       size_t tmp_buf_len;
> > +       u64 current_arg;
> > +       char fmt_ptype;
> > +
> > +       for (i = 0; i < fmt_size && fmt[i] != '\0'; i++) {
>

[...]
