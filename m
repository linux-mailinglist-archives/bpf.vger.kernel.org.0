Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571D535F11B
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 11:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhDNJ52 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhDNJ51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 05:57:27 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95CFC061756
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 02:57:02 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d5so10635969iof.3
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilr4nYYuLua8u/5rpMGCuRSKg5BbVKR1oTVkZgGq8YM=;
        b=J5dMM0tUpszxfjI8JS6aCxCePUvhhXK5qW0Gom0xOACuzCYD+mrjvksyDZmMcM0KlR
         zr6VRM4AN3HohuMcZRuI1QxKnQ1O7q8GjrRroSmgpzH9XQpbJQ7oEHA1OARyrh9ToYXi
         2mZ/7py6oGEiZ+GZrVc4W2ebBva2fsqHY1HDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilr4nYYuLua8u/5rpMGCuRSKg5BbVKR1oTVkZgGq8YM=;
        b=Hz4y9NAm3qnEODAYwOIKh5nqC8ut4o26mFkKga30/DsKdO8yDQc9lI65gvLtfdoSuG
         TkdUNdiyDh10Br2evt32k5t4mftPtN7KPY338As+MDGNUQYOZNvaNFwovuEQ5g9QyGGt
         oc/zP/b3737e3rKgQDYR46LWgRSXaSgttiAwCKBMMwmdprIuMJ3ctwAxYWjrDa6WjC8s
         3HNQSMbXv5x+cYVmF25/df0xQUA01BVFsIVbQVlf4vfn8HqFQ+m2G6tLWRsPfSInCx6q
         JdDO6Ral8GUcadUbFGmCWju7WBXFbYaG5/X6riGvDXeyqJzoL7Q2iOqDRzSyt4qRbey6
         m94w==
X-Gm-Message-State: AOAM530MiaX4kAitBbnIUrvXEMH8bhk9KYDL4+f2DB8+3ur2SdgYWpPm
        SbzvGhdC3o8cyiI5r4Iczdfz/LbKcHxbcj9Nj4Ruag==
X-Google-Smtp-Source: ABdhPJzPq9lpd6QMokc51nU/hP/o00aGgKlDWI+9MZt2Tgf6b2dVy+x6A/zy5xQkqTX0WawY7A6/y3VgfkhmXh4Jx7U=
X-Received: by 2002:a6b:b645:: with SMTP id g66mr11176615iof.83.1618394222069;
 Wed, 14 Apr 2021 02:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-2-revest@chromium.org>
 <CAEf4BzaUeE7EPObUuS=NPw9qmssxJ=i6+M1v6A3=wvLVGOKkXg@mail.gmail.com>
In-Reply-To: <CAEf4BzaUeE7EPObUuS=NPw9qmssxJ=i6+M1v6A3=wvLVGOKkXg@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 14 Apr 2021 11:56:51 +0200
Message-ID: <CABRcYmKjcZD4px3QwjqMZozOJDTXV+fWvf+w2R=ssPyBOJmMTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Factorize bpf_trace_printk and bpf_seq_printf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Wed, Apr 14, 2021 at 1:01 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > +/* Per-cpu temp buffers which can be used by printf-like helpers for %s or %p
> > + */
> > +#define MAX_PRINTF_BUF_LEN     512
> > +
> > +struct bpf_printf_buf {
> > +       char tmp_buf[MAX_PRINTF_BUF_LEN];
> > +};
> > +static DEFINE_PER_CPU(struct bpf_printf_buf, bpf_printf_buf);
> > +static DEFINE_PER_CPU(int, bpf_printf_buf_used);
> > +
> > +static int try_get_fmt_tmp_buf(char **tmp_buf)
> >  {
> > -       static char buf[BPF_TRACE_PRINTK_SIZE];
> > -       unsigned long flags;
> > -       va_list ap;
> > -       int ret;
> > +       struct bpf_printf_buf *bufs = this_cpu_ptr(&bpf_printf_buf);
>
> why doing this_cpu_ptr() if below (if *tmp_buf case), you will not use
> it. just a waste of CPU, no?

Sure I can move it past the conditions.

> > +       int used;
> >
> > -       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> > -       va_start(ap, fmt);
> > -       ret = vsnprintf(buf, sizeof(buf), fmt, ap);
> > -       va_end(ap);
> > -       /* vsnprintf() will not append null for zero-length strings */
> > -       if (ret == 0)
> > -               buf[0] = '\0';
> > -       trace_bpf_trace_printk(buf);
> > -       raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
> > +       if (*tmp_buf)
> > +               return 0;
> >
> > -       return ret;
> > +       preempt_disable();
> > +       used = this_cpu_inc_return(bpf_printf_buf_used);
> > +       if (WARN_ON_ONCE(used > 1)) {
> > +               this_cpu_dec(bpf_printf_buf_used);
> > +               return -EBUSY;
> > +       }
>
> get bufs pointer here instead?

Okay :)

> > +       *tmp_buf = bufs->tmp_buf;
> > +
> > +       return 0;
> > +}
> > +
> > +static void put_fmt_tmp_buf(void)
> > +{
> > +       if (this_cpu_read(bpf_printf_buf_used)) {
> > +               this_cpu_dec(bpf_printf_buf_used);
> > +               preempt_enable();
> > +       }
> >  }
> >
> >  /*
> > - * Only limited trace_printk() conversion specifiers allowed:
> > - * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pB %pks %pus %s
> > + * bpf_parse_fmt_str - Generic pass on format strings for printf-like helpers
> > + *
> > + * Returns a negative value if fmt is an invalid format string or 0 otherwise.
> > + *
> > + * This can be used in two ways:
> > + * - Format string verification only: when final_args and mod are NULL
> > + * - Arguments preparation: in addition to the above verification, it writes in
> > + *   final_args a copy of raw_args where pointers from BPF have been sanitized
> > + *   into pointers safe to use by snprintf. This also writes in the mod array
> > + *   the size requirement of each argument, usable by BPF_CAST_FMT_ARG for ex.
> > + *
> > + * In argument preparation mode, if 0 is returned, safe temporary buffers are
> > + * allocated and put_fmt_tmp_buf should be called to free them after use.
> >   */
> > -BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
> > -          u64, arg2, u64, arg3)
> > -{
> > -       int i, mod[3] = {}, fmt_cnt = 0;
> > -       char buf[64], fmt_ptype;
> > -       void *unsafe_ptr = NULL;
> > -       bool str_seen = false;
> > +int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
> > +                       u64 *final_args, enum bpf_printf_mod_type *mod,
> > +                       u32 num_args)
> > +{
> > +       int err, i, curr_specifier = 0, copy_size;
> > +       char *unsafe_ptr = NULL, *tmp_buf = NULL;
> > +       size_t tmp_buf_len = MAX_PRINTF_BUF_LEN;
> > +       enum bpf_printf_mod_type current_mod;
> > +       u64 current_arg;
>
> naming consistency: current_arg vs curr_specifier? maybe just cur_arg
> and cur_spec?

Ahah, you're right again :)

> > +       char fmt_ptype;
> > +
> > +       if ((final_args && !mod) || (mod && !final_args))
>
> nit: same check:
>
> if (!!final_args != !!mod)

Fancy! :)

> > +               return -EINVAL;
> >
> > -       /*
> > -        * bpf_check()->check_func_arg()->check_stack_boundary()
> > -        * guarantees that fmt points to bpf program stack,
> > -        * fmt_size bytes of it were initialized and fmt_size > 0
> > -        */
> > -       if (fmt[--fmt_size] != 0)
> > +       fmt_size = (strnchr(fmt, fmt_size, 0) - fmt);
>
> extra ()

Oops!

> > +       if (!fmt_size)
>
> hm... strnchr() will return NULL if the character is not found, so
> fmt_size will be some non-zero value (due to - fmt), how is this
> supposed to work?

Ugh!

> some negative tests are clearly missing, it seems, if you didn't catch this

Agree

> >                 return -EINVAL;
> >
> > -       /* check format string for allowed specifiers */
> >         for (i = 0; i < fmt_size; i++) {
> > -               if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i]))
> > -                       return -EINVAL;
> > +               if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
> > +                       err = -EINVAL;
> > +                       goto out;
> > +               }
> >
> >                 if (fmt[i] != '%')
> >                         continue;
> >
> > -               if (fmt_cnt >= 3)
> > -                       return -EINVAL;
> > +               if (fmt[i + 1] == '%') {
> > +                       i++;
> > +                       continue;
> > +               }
> > +
> > +               if (curr_specifier >= num_args) {
> > +                       err = -EINVAL;
> > +                       goto out;
> > +               }
> >
> >                 /* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
>
> a bit outdated comment, last doesn't exist anymore. I think the
> comment is trying to say that fmt[i + 1] can be read because in the
> worst case it will be a final zero terminator (which we checked
> above).

Yes that's the idea. I will rewrite it as a sentence if "last" is confusing.

> > +       err = 0;
> > +out:
> > +       put_fmt_tmp_buf();
>
> so you are putting tmp_buf unconditionally, even when there was no
> error. That seems wrong? Should this be:
>
> if (err)
>     put_fmt_tmp_buf()
>
> ?

Yeah the naming is unfortunate, as discussed in the other patch, I
will rename that to bpf_pintf_cleanup instead. It's not clear from the
name that it only "puts" if the buffer was already gotten.
