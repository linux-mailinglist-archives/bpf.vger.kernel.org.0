Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF1361593
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 00:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhDOWic (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 18:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhDOWia (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 18:38:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0809CC061574;
        Thu, 15 Apr 2021 15:38:07 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id o10so27923500ybb.10;
        Thu, 15 Apr 2021 15:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9C1Oe8QJini2Dk5fzBACl4bekWIZfVxFJ6mtWi4qwo=;
        b=me96RqahDqsuxs4tLpRRngaff/lA1X3Bdm3VbHUXEN+m1MhDvDVyG1WNmEMooVjKGF
         YJ8TVhoI63XVR4+GdKx5jB/F3Hr4rnHu/nO9ucaOxzNVMFv903/JiMq0K4VvOjenwgw6
         0i07tbK0YzWhQACSXpVdU0oGz19F+URl8J1MX3kE2SyxZrV6DiunZmb1Ivjup+JkGjHn
         jjFcoZd/ty1LuIK5uBZtCis265VrtNYO5UwDecBE7sOpUKFmEB1xFbKLE/s2YsFkbdKn
         ncXehUS67G8KGSEKrCjD5oe2YUyQhQRNi70s3tZZQDrQFVQ/xr75pE040ZDiWrUckCFM
         669Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9C1Oe8QJini2Dk5fzBACl4bekWIZfVxFJ6mtWi4qwo=;
        b=QxVK/pU2c80tdYfP8s/8p9OJBkoTtHEHI7yQC+heleuYdTUp/ZTXQTKVCW71icBl72
         iLrMsCDYLFtLQZ76uBkKcZ0g0KFLzF3DXcBNzINYnJJR51H9VgwhJswhlQdQ0h/wHOwJ
         NIuVFZeA2EZ1Pwv30epUuHrQtM9iRV80XX6JMl2HyCGXyPohodANu94i/jcgFiSWV3pV
         Dm4WvhEMu1csUcOq6gJe2zplvOfvPMKTWyYHzfnkGxBRSwLkxCQl8NqohHfD+Yo19Zx6
         O4f4AvuurFTGKN8vbRXz7bA3Yx8w8dhjpXjT1wnVbQmTJ/MDRLYhafYNoevX914k2gvX
         jrGA==
X-Gm-Message-State: AOAM533Ftwhx758peh1XTuNx051gMXZHnQU033xtFYG4krwG4GruyTGk
        KRYT4xW/MXxuwVvs+ruphHo/acAT7OShm0qG/NdnoF8j
X-Google-Smtp-Source: ABdhPJzap4Yw/7uCyRzfk4hr1m+vak865h06pq4LeqdI252rHRGFSD1+aT3iovdwIkxD1gCHu4WZrBuFtEskzLqcfdM=
X-Received: by 2002:a25:becd:: with SMTP id k13mr7009158ybm.459.1618526286355;
 Thu, 15 Apr 2021 15:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210414185406.917890-1-revest@chromium.org> <20210414185406.917890-2-revest@chromium.org>
 <CAEf4BzYx-M7deKD9s8qFUwRyzgD5fvonkTpHO9ceXkQxgjBHBQ@mail.gmail.com> <CABRcYmKL4QO+S-raU6B1ZxCjdm7DFj-27XgEps8sZ8mU7_Hy4g@mail.gmail.com>
In-Reply-To: <CABRcYmKL4QO+S-raU6B1ZxCjdm7DFj-27XgEps8sZ8mU7_Hy4g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 15 Apr 2021 15:37:55 -0700
Message-ID: <CAEf4BzYX1WCvj8c--nwP5YHre+xShAL6RST8vtgXtjm4dAzGhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] bpf: Factorize bpf_trace_printk and bpf_seq_printf
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

On Thu, Apr 15, 2021 at 2:33 AM Florent Revest <revest@chromium.org> wrote:
>
> On Thu, Apr 15, 2021 at 2:38 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Apr 14, 2021 at 11:54 AM Florent Revest <revest@chromium.org> wrote:
> > > +static int try_get_fmt_tmp_buf(char **tmp_buf)
> > > +{
> > > +       struct bpf_printf_buf *bufs;
> > > +       int used;
> > > +
> > > +       if (*tmp_buf)
> > > +               return 0;
> > > +
> > > +       preempt_disable();
> > > +       used = this_cpu_inc_return(bpf_printf_buf_used);
> > > +       if (WARN_ON_ONCE(used > 1)) {
> > > +               this_cpu_dec(bpf_printf_buf_used);
> >
> > this makes me uncomfortable. If used > 1, you won't preempt_enable()
> > here, but you'll decrease count. Then later bpf_printf_cleanup() will
> > be called (inside bpf_printf_prepare()) and will further decrease
> > count (which it didn't increase, so it's a mess now).
>
> Awkward, yes. :( This code is untested because it only covers a niche
> preempt_rt usecase that is hard to reproduce but I should have thought
> harder about these corner cases.
>
> > > +                       i += 2;
> > > +                       if (!final_args)
> > > +                               goto fmt_next;
> > > +
> > > +                       if (try_get_fmt_tmp_buf(&tmp_buf)) {
> > > +                               err = -EBUSY;
> > > +                               goto out;
> >
> > this probably should bypass doing bpf_printf_cleanup() and
> > try_get_fmt_tmp_buf() should enable preemption internally on error.
>
> Yes. I'll fix this and spend some more brain cycles thinking about
> what I'm doing. ;)
>
> > > -static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
> > > +BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
> > > +          u64, arg2, u64, arg3)
> > >  {
> > > +       u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
> > > +       enum bpf_printf_mod_type mod[MAX_TRACE_PRINTK_VARARGS];
> > >         static char buf[BPF_TRACE_PRINTK_SIZE];
> > >         unsigned long flags;
> > > -       va_list ap;
> > >         int ret;
> > >
> > > -       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> > > -       va_start(ap, fmt);
> > > -       ret = vsnprintf(buf, sizeof(buf), fmt, ap);
> > > -       va_end(ap);
> > > -       /* vsnprintf() will not append null for zero-length strings */
> > > +       ret = bpf_printf_prepare(fmt, fmt_size, args, args, mod,
> > > +                                MAX_TRACE_PRINTK_VARARGS);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
> > > +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
> > > +       /* snprintf() will not append null for zero-length strings */
> > >         if (ret == 0)
> > >                 buf[0] = '\0';
> > > +
> > > +       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> > >         trace_bpf_trace_printk(buf);
> > >         raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
> > >
> > > -       return ret;
> >
> > see here, no + 1 :(
>
> I wonder if it's a bug or a feature though. The helper documentation
> says the helper returns "the number of bytes written to the buffer". I
> am not familiar with the internals of trace_printk but if the
> terminating \0 is not outputted in the trace_printk buffer, then it
> kind of makes sense.
>
> Also, if anyone uses this return value, I can imagine that the usecase
> would be if (ret == 0) assume_nothing_was_written(). And if we
> suddenly output 1 here, we might break something.
>
> Because the helper is quite old, maybe we should improve the helper
> documentation instead? Your call :)

Yeah, let's make helper's doc a bit more precise, otherwise let's not
touch it. I doubt many users ever check return result of
bpf_trace_printk() at all, tbh.
