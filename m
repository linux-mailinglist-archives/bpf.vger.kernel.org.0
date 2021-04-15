Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41973605C3
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 11:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhDOJdZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhDOJdZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 05:33:25 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08B8C061756
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 02:33:02 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z5so1761008ioc.13
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywf0bpiNMcKWdf1xGxMCFgbb7KI06dhEyiPCUR2/0zk=;
        b=lr3hXR5sz8eVp9IX8mdziXqSdnbSCOJp2FyjK+KXCGFXrKTvr7pWmQprZk7EhvW6V4
         bEH1LwoUa6UCcZnUc2Y61Enr5WSnfL/xCVS1I+cwaPDASIzlEcbwWIFe3SnAnhE+q+Y5
         HzJYA6Gf2R0dONiReAoDxOWmONlFHqz8b/K/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywf0bpiNMcKWdf1xGxMCFgbb7KI06dhEyiPCUR2/0zk=;
        b=g5Pc9ME9G7rJo9+up+kUsoJhJ6KmaYeEbRy3ykYqzRK2PjEx4I4aYSaqzOqSh7Zsit
         T74kLx31fcjpBIhA/0DLNbmdkSDZJw/A4OeA/tDWNZxQ708ucGLcM9F/ys9+SNRFjz0+
         MLTeoPX85sAfNMWblLOqCNpUbowJhcc9nT/tIbcUEwiNoZIPAYMOHAqA/dH3391VQjBa
         exxSwQNq35MqV6hUezaF/JwAP+cq7wSJrmp+kV9ZFw/ssItDF5vSlXmroogwwrVbrcQU
         rhrfkETzMp+qq76JEyKF8obfGC/rtwGT/mBtRDSBJiBGz6ludfGqWUg495f0j+E1dWi8
         4NnA==
X-Gm-Message-State: AOAM530HMd2m7GNizNmprzQzt35jBawEu0LfDzS5Cpqo4Fqje68zCB9x
        bchKBejLvPvAZGQnrVill8nYjJrGqYbktADvk7hAWA==
X-Google-Smtp-Source: ABdhPJx48Jc3OXSHX5a9Jsj4STxtvGXrEw7SSgK9esRnMsnujlI2bvjRTF4SJOGyMav4CigHZEXBgxaXLDpTAabh2dQ=
X-Received: by 2002:a6b:6e17:: with SMTP id d23mr1953060ioh.122.1618479182125;
 Thu, 15 Apr 2021 02:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210414185406.917890-1-revest@chromium.org> <20210414185406.917890-2-revest@chromium.org>
 <CAEf4BzYx-M7deKD9s8qFUwRyzgD5fvonkTpHO9ceXkQxgjBHBQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYx-M7deKD9s8qFUwRyzgD5fvonkTpHO9ceXkQxgjBHBQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 15 Apr 2021 11:32:51 +0200
Message-ID: <CABRcYmKL4QO+S-raU6B1ZxCjdm7DFj-27XgEps8sZ8mU7_Hy4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] bpf: Factorize bpf_trace_printk and bpf_seq_printf
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

On Thu, Apr 15, 2021 at 2:38 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Apr 14, 2021 at 11:54 AM Florent Revest <revest@chromium.org> wrote:
> > +static int try_get_fmt_tmp_buf(char **tmp_buf)
> > +{
> > +       struct bpf_printf_buf *bufs;
> > +       int used;
> > +
> > +       if (*tmp_buf)
> > +               return 0;
> > +
> > +       preempt_disable();
> > +       used = this_cpu_inc_return(bpf_printf_buf_used);
> > +       if (WARN_ON_ONCE(used > 1)) {
> > +               this_cpu_dec(bpf_printf_buf_used);
>
> this makes me uncomfortable. If used > 1, you won't preempt_enable()
> here, but you'll decrease count. Then later bpf_printf_cleanup() will
> be called (inside bpf_printf_prepare()) and will further decrease
> count (which it didn't increase, so it's a mess now).

Awkward, yes. :( This code is untested because it only covers a niche
preempt_rt usecase that is hard to reproduce but I should have thought
harder about these corner cases.

> > +                       i += 2;
> > +                       if (!final_args)
> > +                               goto fmt_next;
> > +
> > +                       if (try_get_fmt_tmp_buf(&tmp_buf)) {
> > +                               err = -EBUSY;
> > +                               goto out;
>
> this probably should bypass doing bpf_printf_cleanup() and
> try_get_fmt_tmp_buf() should enable preemption internally on error.

Yes. I'll fix this and spend some more brain cycles thinking about
what I'm doing. ;)

> > -static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
> > +BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
> > +          u64, arg2, u64, arg3)
> >  {
> > +       u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
> > +       enum bpf_printf_mod_type mod[MAX_TRACE_PRINTK_VARARGS];
> >         static char buf[BPF_TRACE_PRINTK_SIZE];
> >         unsigned long flags;
> > -       va_list ap;
> >         int ret;
> >
> > -       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> > -       va_start(ap, fmt);
> > -       ret = vsnprintf(buf, sizeof(buf), fmt, ap);
> > -       va_end(ap);
> > -       /* vsnprintf() will not append null for zero-length strings */
> > +       ret = bpf_printf_prepare(fmt, fmt_size, args, args, mod,
> > +                                MAX_TRACE_PRINTK_VARARGS);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
> > +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
> > +       /* snprintf() will not append null for zero-length strings */
> >         if (ret == 0)
> >                 buf[0] = '\0';
> > +
> > +       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> >         trace_bpf_trace_printk(buf);
> >         raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
> >
> > -       return ret;
>
> see here, no + 1 :(

I wonder if it's a bug or a feature though. The helper documentation
says the helper returns "the number of bytes written to the buffer". I
am not familiar with the internals of trace_printk but if the
terminating \0 is not outputted in the trace_printk buffer, then it
kind of makes sense.

Also, if anyone uses this return value, I can imagine that the usecase
would be if (ret == 0) assume_nothing_was_written(). And if we
suddenly output 1 here, we might break something.

Because the helper is quite old, maybe we should improve the helper
documentation instead? Your call :)
