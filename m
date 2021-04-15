Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E9D35FEF0
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 02:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhDOAid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 20:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhDOAia (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 20:38:30 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A4C061574;
        Wed, 14 Apr 2021 17:38:08 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z1so24188335ybf.6;
        Wed, 14 Apr 2021 17:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8TQQFiQJj7oshGFdEkhGVUpY5HgU3ka+gKPlqoMHaq4=;
        b=K7meKzc8bbKPO89rS90oeoty0pTVw5LY2ZNliaG+nhzJwemnxszNUadAvl/CQp2f94
         7ltxUw/yJ+yDVTsQ+3RoTKOTyR//epvyeWWL8M90VU8PzmC3OuHdb3WeSrEn2uJ/K3SH
         +92sHx9IfxCtR7EOwhj+ZFIZFGY95o7IMc9Tl11TW2E5i2eiaU8yP/i9vDCgJkH1WKPf
         bqHkmGAH+FyTWiVn+9AB4EsbRYPdjKzkbuWPWQgjanA8elDEG1k4kvw8iiAzrXD3x048
         0OVWzJHFnxJtvE/24x44i/u+Nxlqy8niIRcTXdb7r10w54oKPcyup7ho7i+iGlgf0cpw
         Jovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TQQFiQJj7oshGFdEkhGVUpY5HgU3ka+gKPlqoMHaq4=;
        b=eAj7Jveesej/J7ZMrqQt0ORq4hVN/YERg7TQulIqsfh6mBbdcLd8x45r27oM9x2NRk
         SgB586waVz2tL4Ij8oPorw8m3uXZL+N3QdJyQfjIuYYLJkAZANczhSEy+hxoJ0NjLVz6
         g/wa7NdNLLzaO1AQSR4lIJ451KrnzDdaEiJG2lVTVIuyg9K1U3zkkcJhknyrvzGJfgvt
         eeky3hFj+VSfEm+XVWwt3GU7zdZx05w1ROgyi9Hlr+mPPRUTyl5+eUfmFxSlo6olrhcM
         Kc8OnkeDLPDPGOxOquQ+s3PF9a3p9hOU9ovjs2N/cX+NjZtoh6FBLwF9defuqWS2l+Jf
         At4Q==
X-Gm-Message-State: AOAM530s2FxaEnIwFLd8CRS27WDm8dCKshJ+DbjTSApp0sGSKu1BD876
        shhQSwCjl5n1DP/W3VX6RZaAFjb4KbkWKSsmvsM=
X-Google-Smtp-Source: ABdhPJwpiyXE5312iTT3SLT9rT+uEFqqjWaXHGlfMeyw6gflCTUlL50Kwy8UpQJIfCxAWtH+H5br6p2OQ4Mbg6qrGHU=
X-Received: by 2002:a25:850c:: with SMTP id w12mr883979ybk.347.1618447087400;
 Wed, 14 Apr 2021 17:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210414185406.917890-1-revest@chromium.org> <20210414185406.917890-2-revest@chromium.org>
In-Reply-To: <20210414185406.917890-2-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Apr 2021 17:37:56 -0700
Message-ID: <CAEf4BzYx-M7deKD9s8qFUwRyzgD5fvonkTpHO9ceXkQxgjBHBQ@mail.gmail.com>
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

On Wed, Apr 14, 2021 at 11:54 AM Florent Revest <revest@chromium.org> wrote:
>
> Two helpers (trace_printk and seq_printf) have very similar
> implementations of format string parsing and a third one is coming
> (snprintf). To avoid code duplication and make the code easier to
> maintain, this moves the operations associated with format string
> parsing (validation and argument sanitization) into one generic
> function.
>
> The implementation of the two existing helpers already drifted quite a
> bit so unifying them entailed a lot of changes:
>
> - bpf_trace_printk always expected fmt[fmt_size] to be the terminating
>   NULL character, this is no longer true, the first 0 is terminating.
> - bpf_trace_printk now supports %% (which produces the percentage char).
> - bpf_trace_printk now skips width formating fields.
> - bpf_trace_printk now supports the X modifier (capital hexadecimal).
> - bpf_trace_printk now supports %pK, %px, %pB, %pi4, %pI4, %pi6 and %pI6
> - argument casting on 32 bit has been simplified into one macro and
>   using an enum instead of obscure int increments.
>
> - bpf_seq_printf now uses bpf_trace_copy_string instead of
>   strncpy_from_kernel_nofault and handles the %pks %pus specifiers.
> - bpf_seq_printf now prints longs correctly on 32 bit architectures.
>
> - both were changed to use a global per-cpu tmp buffer instead of one
>   stack buffer for trace_printk and 6 small buffers for seq_printf.
> - to avoid per-cpu buffer usage conflict, these helpers disable
>   preemption while the per-cpu buffer is in use.
> - both helpers now support the %ps and %pS specifiers to print symbols.
>
> The implementation is also moved from bpf_trace.c to helpers.c because
> the upcoming bpf_snprintf helper will be made available to all BPF
> programs and will need it.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/bpf.h      |  20 +++
>  kernel/bpf/helpers.c     | 254 +++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c | 371 ++++-----------------------------------
>  3 files changed, 311 insertions(+), 334 deletions(-)
>

[...]

> +static int try_get_fmt_tmp_buf(char **tmp_buf)
> +{
> +       struct bpf_printf_buf *bufs;
> +       int used;
> +
> +       if (*tmp_buf)
> +               return 0;
> +
> +       preempt_disable();
> +       used = this_cpu_inc_return(bpf_printf_buf_used);
> +       if (WARN_ON_ONCE(used > 1)) {
> +               this_cpu_dec(bpf_printf_buf_used);

this makes me uncomfortable. If used > 1, you won't preempt_enable()
here, but you'll decrease count. Then later bpf_printf_cleanup() will
be called (inside bpf_printf_prepare()) and will further decrease
count (which it didn't increase, so it's a mess now).

> +               return -EBUSY;
> +       }
> +       bufs = this_cpu_ptr(&bpf_printf_buf);
> +       *tmp_buf = bufs->tmp_buf;
> +
> +       return 0;
> +}
> +

[...]

> +                       i += 2;
> +                       if (!final_args)
> +                               goto fmt_next;
> +
> +                       if (try_get_fmt_tmp_buf(&tmp_buf)) {
> +                               err = -EBUSY;
> +                               goto out;

this probably should bypass doing bpf_printf_cleanup() and
try_get_fmt_tmp_buf() should enable preemption internally on error.

> +                       }
> +
> +                       copy_size = (fmt[i + 2] == '4') ? 4 : 16;
> +                       if (tmp_buf_len < copy_size) {
> +                               err = -ENOSPC;
> +                               goto out;
> +                       }
> +

[...]

> -static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
> +BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
> +          u64, arg2, u64, arg3)
>  {
> +       u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
> +       enum bpf_printf_mod_type mod[MAX_TRACE_PRINTK_VARARGS];
>         static char buf[BPF_TRACE_PRINTK_SIZE];
>         unsigned long flags;
> -       va_list ap;
>         int ret;
>
> -       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> -       va_start(ap, fmt);
> -       ret = vsnprintf(buf, sizeof(buf), fmt, ap);
> -       va_end(ap);
> -       /* vsnprintf() will not append null for zero-length strings */
> +       ret = bpf_printf_prepare(fmt, fmt_size, args, args, mod,
> +                                MAX_TRACE_PRINTK_VARARGS);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
> +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
> +       /* snprintf() will not append null for zero-length strings */
>         if (ret == 0)
>                 buf[0] = '\0';
> +
> +       raw_spin_lock_irqsave(&trace_printk_lock, flags);
>         trace_bpf_trace_printk(buf);
>         raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
>
> -       return ret;

see here, no + 1 :(

> -}
> -
> -/*
> - * Only limited trace_printk() conversion specifiers allowed:
> - * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pB %pks %pus %s
> - */

[...]
