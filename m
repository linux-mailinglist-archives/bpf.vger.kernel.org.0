Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4861F35E964
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 01:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347934AbhDMXCH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 19:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhDMXCG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 19:02:06 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F239C061574;
        Tue, 13 Apr 2021 16:01:45 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id x76so9985653ybe.5;
        Tue, 13 Apr 2021 16:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAErPwMdXrF7pmSh8heFdAEW1/481fIcdNyxEWU56cU=;
        b=kJ0M+AcVPvMvyPA2/3+LS+Xg4EHtpIm1QNabc5dmBDDxXmf16ar3CTN8kw24tqvfQL
         gq6X9V1E2NHnVm/v8mBGS6B5tDyZy13T0fO7e3JTqJd7AVvBqIlZtaxEPe1rUfeRxFBs
         TxZwUfDh12kVgoplSAa+fh1azAzIiH00fj57JG98g34C6YoKw40OSnB3/0meFOtszqFz
         TTaqRSj+P4r4B9SUd9w6zvWSYHRzSEVZLwVM9iepmSik+SgHYUR1Jvf8FGZF1zgRGBSj
         MqZ1jUJoM28hztABLE4rmjrEOCojMx6Vsdvm5cAZthomUAD0c55kxwGU/LPWkuLP1Bki
         j48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAErPwMdXrF7pmSh8heFdAEW1/481fIcdNyxEWU56cU=;
        b=FwbZKvyqqS26DNg1X2E0Zdz/UnoVf99xTcbihWtn0nS32gsVt8p1llxU8B8+TtpiFP
         56qpTmbhcdAB3xsedlS/AuAS6/rJetR3Fu+z/zMiweFRLqjy+P1lwNWYu2w1Ohkc5pM2
         LkGMU0XYvBhSRTlNTyxIo/hNKV2+Z8cc3iYAksDfoT6ODgeHUDpAt56zF8tvHyihdH77
         SSRw0+pk1R04+jruBiz+DUmozBiFuNvYgfOjOqm46ML5UTKVW2G3yjD0Ee1VpXwEWj6i
         n8oW5YfQhnqCrypvJDMD+sJR8p8+6S3nUPdnJmJ3iNisuGJoA2/BxDchUsIRKHPyKjd2
         0HTQ==
X-Gm-Message-State: AOAM5338/XI5ncOS6ZJQFNFMrqe3y+mNFz+7yrxQJFJYupVN7BIfgU7l
        PuvOIyukO3beHRvXNQ9KJyjlkxkXMfp35HFrXhbe+MN1Pew=
X-Google-Smtp-Source: ABdhPJwspEcTc/A1adah6CFa3y+KZQFPWs2IW/abEha1Hsga2FjffqFUdQq/KPHkjakMUVrlSIZ/Ljd6VIil0ihjMR0=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr47395938ybf.425.1618354904331;
 Tue, 13 Apr 2021 16:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-2-revest@chromium.org>
In-Reply-To: <20210412153754.235500-2-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 16:01:33 -0700
Message-ID: <CAEf4BzaUeE7EPObUuS=NPw9qmssxJ=i6+M1v6A3=wvLVGOKkXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Factorize bpf_trace_printk and bpf_seq_printf
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

On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
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
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  kernel/trace/bpf_trace.c | 529 ++++++++++++++++++---------------------
>  1 file changed, 248 insertions(+), 281 deletions(-)
>

[...]

> +/* Per-cpu temp buffers which can be used by printf-like helpers for %s or %p
> + */
> +#define MAX_PRINTF_BUF_LEN     512
> +
> +struct bpf_printf_buf {
> +       char tmp_buf[MAX_PRINTF_BUF_LEN];
> +};
> +static DEFINE_PER_CPU(struct bpf_printf_buf, bpf_printf_buf);
> +static DEFINE_PER_CPU(int, bpf_printf_buf_used);
> +
> +static int try_get_fmt_tmp_buf(char **tmp_buf)
>  {
> -       static char buf[BPF_TRACE_PRINTK_SIZE];
> -       unsigned long flags;
> -       va_list ap;
> -       int ret;
> +       struct bpf_printf_buf *bufs = this_cpu_ptr(&bpf_printf_buf);

why doing this_cpu_ptr() if below (if *tmp_buf case), you will not use
it. just a waste of CPU, no?

> +       int used;
>
> -       raw_spin_lock_irqsave(&trace_printk_lock, flags);
> -       va_start(ap, fmt);
> -       ret = vsnprintf(buf, sizeof(buf), fmt, ap);
> -       va_end(ap);
> -       /* vsnprintf() will not append null for zero-length strings */
> -       if (ret == 0)
> -               buf[0] = '\0';
> -       trace_bpf_trace_printk(buf);
> -       raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
> +       if (*tmp_buf)
> +               return 0;
>
> -       return ret;
> +       preempt_disable();
> +       used = this_cpu_inc_return(bpf_printf_buf_used);
> +       if (WARN_ON_ONCE(used > 1)) {
> +               this_cpu_dec(bpf_printf_buf_used);
> +               return -EBUSY;
> +       }

get bufs pointer here instead?

> +       *tmp_buf = bufs->tmp_buf;
> +
> +       return 0;
> +}
> +
> +static void put_fmt_tmp_buf(void)
> +{
> +       if (this_cpu_read(bpf_printf_buf_used)) {
> +               this_cpu_dec(bpf_printf_buf_used);
> +               preempt_enable();
> +       }
>  }
>
>  /*
> - * Only limited trace_printk() conversion specifiers allowed:
> - * %d %i %u %x %ld %li %lu %lx %lld %lli %llu %llx %p %pB %pks %pus %s
> + * bpf_parse_fmt_str - Generic pass on format strings for printf-like helpers
> + *
> + * Returns a negative value if fmt is an invalid format string or 0 otherwise.
> + *
> + * This can be used in two ways:
> + * - Format string verification only: when final_args and mod are NULL
> + * - Arguments preparation: in addition to the above verification, it writes in
> + *   final_args a copy of raw_args where pointers from BPF have been sanitized
> + *   into pointers safe to use by snprintf. This also writes in the mod array
> + *   the size requirement of each argument, usable by BPF_CAST_FMT_ARG for ex.
> + *
> + * In argument preparation mode, if 0 is returned, safe temporary buffers are
> + * allocated and put_fmt_tmp_buf should be called to free them after use.
>   */
> -BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
> -          u64, arg2, u64, arg3)
> -{
> -       int i, mod[3] = {}, fmt_cnt = 0;
> -       char buf[64], fmt_ptype;
> -       void *unsafe_ptr = NULL;
> -       bool str_seen = false;
> +int bpf_printf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
> +                       u64 *final_args, enum bpf_printf_mod_type *mod,
> +                       u32 num_args)
> +{
> +       int err, i, curr_specifier = 0, copy_size;
> +       char *unsafe_ptr = NULL, *tmp_buf = NULL;
> +       size_t tmp_buf_len = MAX_PRINTF_BUF_LEN;
> +       enum bpf_printf_mod_type current_mod;
> +       u64 current_arg;

naming consistency: current_arg vs curr_specifier? maybe just cur_arg
and cur_spec?

> +       char fmt_ptype;
> +
> +       if ((final_args && !mod) || (mod && !final_args))

nit: same check:

if (!!final_args != !!mod)

> +               return -EINVAL;
>
> -       /*
> -        * bpf_check()->check_func_arg()->check_stack_boundary()
> -        * guarantees that fmt points to bpf program stack,
> -        * fmt_size bytes of it were initialized and fmt_size > 0
> -        */
> -       if (fmt[--fmt_size] != 0)
> +       fmt_size = (strnchr(fmt, fmt_size, 0) - fmt);

extra ()

> +       if (!fmt_size)

hm... strnchr() will return NULL if the character is not found, so
fmt_size will be some non-zero value (due to - fmt), how is this
supposed to work?

some negative tests are clearly missing, it seems, if you didn't catch this


>                 return -EINVAL;
>
> -       /* check format string for allowed specifiers */
>         for (i = 0; i < fmt_size; i++) {
> -               if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i]))
> -                       return -EINVAL;
> +               if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
> +                       err = -EINVAL;
> +                       goto out;
> +               }
>
>                 if (fmt[i] != '%')
>                         continue;
>
> -               if (fmt_cnt >= 3)
> -                       return -EINVAL;
> +               if (fmt[i + 1] == '%') {
> +                       i++;
> +                       continue;
> +               }
> +
> +               if (curr_specifier >= num_args) {
> +                       err = -EINVAL;
> +                       goto out;
> +               }
>
>                 /* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */

a bit outdated comment, last doesn't exist anymore. I think the
comment is trying to say that fmt[i + 1] can be read because in the
worst case it will be a final zero terminator (which we checked
above).

>                 i++;
> -               if (fmt[i] == 'l') {
> -                       mod[fmt_cnt]++;
> +

[...]

> +       err = 0;
> +out:
> +       put_fmt_tmp_buf();

so you are putting tmp_buf unconditionally, even when there was no
error. That seems wrong? Should this be:

if (err)
    put_fmt_tmp_buf()

?

> +       return err;
> +}
> +

[...]
