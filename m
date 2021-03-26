Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A04E34B190
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 22:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZVya (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZVyC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 17:54:02 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663CCC0613AA;
        Fri, 26 Mar 2021 14:54:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i144so7313935ybg.1;
        Fri, 26 Mar 2021 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThGJXqSBVtGk6KIhRrFIKcUMK7/vpKeq9ueUBtv72FU=;
        b=GfDHokUT05JveQjRoJwweQjrGtp/L4xsAw95tHDw1yKy7ByzIGP4re+OvHF9eRFdGd
         5E8DDetHcS0H3mZccik/tB33V6nkozaI3MCZ8fZlG+WHboBwhy+lUt3VLlrAFZQDdeFM
         QV7Ow/4c4OQ+1pF/IeoJ9BKIo1SYS0cpKJgdONDdILUhDK2mS/TF0dBL1ton+OVitIXD
         P+PohQkgit9K6uWjoBBZPhnK6X05+EM14BCE7gKYSelDFITzIqQikU5FufimTmPgXw0Q
         QjVt+BYEjwi/tFCElADxB/NDtSXUVRzssMmvVytA8g9p8m7Ain9ND7lsiAfzTJJQsbov
         BXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThGJXqSBVtGk6KIhRrFIKcUMK7/vpKeq9ueUBtv72FU=;
        b=KIiei5qyQvbYHmp741IqFetHN3cqrf8gGujnw7TDlqYkVeRXuJ3RfCaljPn9954vj9
         tcp9Rr3yTRZnp5Qa4R+b/DMH5ZO9jJL2pXfCy66/vvMQ+l+wYJOnFPJyQUEiCuYf7Vi4
         Fi4Fxc4k+Mc1hy35+qf0escwBGlwgnAc9EN9Pq7dgbVQA30qeH6z+7Ntj1tnRgnW90M4
         3G4FX6AHqD4cMu0HknxULntR40Lj8lhG/bG2WeC9MnpEhEwQ1PH40EsIhdn7fLFbx4VL
         xKAmZBKL+5b2Q6+okzZKsFU1AqBR6UmsoFw7pjfTvyUox2Z0K1JXhDO/HZ+6k+ztHLQm
         o3Mw==
X-Gm-Message-State: AOAM531aPICpDRuBZX6a9mSTSNHoT7yJxfbsGeNQk/2MlAFLfETpilJ3
        9Et1FH8O85liPETtnLaY7B4lQtxkjL7A+D6E/Lu7lElVq7WtFA==
X-Google-Smtp-Source: ABdhPJyRzadXGLkzDYkubw1g45UmcIZQMVLmREy4QGONvHNnjb5k6+dGE/FoMuRvwYDMx09xOmZURnshCs2QsFwRVGo=
X-Received: by 2002:a25:874c:: with SMTP id e12mr21367498ybn.403.1616795641562;
 Fri, 26 Mar 2021 14:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-2-revest@chromium.org>
In-Reply-To: <20210324022211.1718762-2-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Mar 2021 14:53:50 -0700
Message-ID: <CAEf4BzZP6uK_ZcKJZsESWrMHG5kEG_swRYJwqsaiD95CEOdJ5g@mail.gmail.com>
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

On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
>
> Two helpers (trace_printk and seq_printf) have very similar
> implementations of format string parsing and a third one is coming
> (snprintf). To avoid code duplication and make the code easier to
> maintain, this moves the operations associated with format string
> parsing (validation and argument sanitization) into one generic
> function.
>
> Unfortunately, the implementation of the two existing helpers already
> drifted quite a bit and unifying them entailed a lot of changes:

"Unfortunately" as in a lot of extra work for you? I think overall
though it was very fortunate that you ended up doing it, all
implementations are more feature-complete and saner now, no? Thanks a
lot for your hard work!

>
> - bpf_trace_printk always expected fmt[fmt_size] to be the terminating
>   NULL character, this is no longer true, the first 0 is terminating.

You mean if you had bpf_trace_printk("bla bla\0some more bla\0", 24)
it would emit that zero character? If yes, I don't think it was a sane
behavior anyways.

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

This is great, you already saved some lines of code! I suspect I'll
have some complaints about mods (it feels like this preample should
provide extra information about which arguments have to be read from
kernel/user memory, but I'll see next patches first.

See my comments below (I deliberately didn't trim most of the code for
easier jumping around), but it's great overall, thanks!

>  kernel/trace/bpf_trace.c | 529 ++++++++++++++++++---------------------
>  1 file changed, 244 insertions(+), 285 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0d23755c2747..0fdca94a3c9c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -372,7 +372,7 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
>         return &bpf_probe_write_user_proto;
>  }
>
> -static void bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
> +static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
>                 size_t bufsz)
>  {
>         void __user *user_ptr = (__force void __user *)unsafe_ptr;
> @@ -382,178 +382,284 @@ static void bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
>         switch (fmt_ptype) {
>         case 's':
>  #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> -               if ((unsigned long)unsafe_ptr < TASK_SIZE) {
> -                       strncpy_from_user_nofault(buf, user_ptr, bufsz);
> -                       break;
> -               }
> +               if ((unsigned long)unsafe_ptr < TASK_SIZE)
> +                       return strncpy_from_user_nofault(buf, user_ptr, bufsz);
>                 fallthrough;
>  #endif
>         case 'k':
> -               strncpy_from_kernel_nofault(buf, unsafe_ptr, bufsz);
> -               break;
> +               return strncpy_from_kernel_nofault(buf, unsafe_ptr, bufsz);
>         case 'u':
> -               strncpy_from_user_nofault(buf, user_ptr, bufsz);
> -               break;
> +               return strncpy_from_user_nofault(buf, user_ptr, bufsz);
>         }
> +
> +       return -EINVAL;
>  }
>
>  static DEFINE_RAW_SPINLOCK(trace_printk_lock);
>
> -#define BPF_TRACE_PRINTK_SIZE   1024
> +enum bpf_printf_mod_type {
> +       BPF_PRINTF_INT,
> +       BPF_PRINTF_LONG,
> +       BPF_PRINTF_LONG_LONG,
> +};
>
> -static __printf(1, 0) int bpf_do_trace_printk(const char *fmt, ...)
> -{
> -       static char buf[BPF_TRACE_PRINTK_SIZE];
> -       unsigned long flags;
> -       va_list ap;
> -       int ret;
> +/* Horrid workaround for getting va_list handling working with different
> + * argument type combinations generically for 32 and 64 bit archs.
> + */
> +#define BPF_CAST_FMT_ARG(arg_nb, args, mod)                            \
> +       ((mod[arg_nb] == BPF_PRINTF_LONG_LONG ||                        \
> +        (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64))     \
> +         ? args[arg_nb]                                                \
> +         : ((mod[arg_nb] == BPF_PRINTF_LONG ||                         \
> +            (mod[arg_nb] == BPF_PRINTF_INT && __BITS_PER_LONG == 32))  \

is this right? INT is always 32-bit, it's only LONG that differs.
Shouldn't the rule be

(LONG_LONG || LONG && __BITS_PER_LONG) -> (__u64)args[args_nb]
(INT || LONG && __BITS_PER_LONG == 32) -> (__u32)args[args_nb]

Does (long) cast do anything fancy when casting from u64? Sorry, maybe
I'm confused.


> +             ? (long)args[arg_nb]                                      \
> +             : (u32)args[arg_nb]))
> +
> +/* Per-cpu temp buffers which can be used by printf-like helpers for %s or %p
> + */
> +#define MAX_PRINTF_BUF_LEN     512
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
> +struct bpf_printf_buf {
> +       char tmp_buf[MAX_PRINTF_BUF_LEN];
> +};
> +static DEFINE_PER_CPU(struct bpf_printf_buf, bpf_printf_buf);
> +static DEFINE_PER_CPU(int, bpf_printf_buf_used);
>
> -       return ret;
> +static void bpf_printf_postamble(void)
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
> + * allocated and bpf_printf_postamble should be called to free them after use.
>   */
> -BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
> -          u64, arg2, u64, arg3)
> -{
> -       int i, mod[3] = {}, fmt_cnt = 0;
> -       char buf[64], fmt_ptype;
> -       void *unsafe_ptr = NULL;
> -       bool str_seen = false;
> -
> -       /*
> -        * bpf_check()->check_func_arg()->check_stack_boundary()
> -        * guarantees that fmt points to bpf program stack,
> -        * fmt_size bytes of it were initialized and fmt_size > 0
> -        */
> -       if (fmt[--fmt_size] != 0)
> -               return -EINVAL;
> -
> -       /* check format string for allowed specifiers */
> -       for (i = 0; i < fmt_size; i++) {
> -               if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i]))
> -                       return -EINVAL;
> +int bpf_printf_preamble(char *fmt, u32 fmt_size, const u64 *raw_args,
> +                       u64 *final_args, enum bpf_printf_mod_type *mod,
> +                       u32 num_args)
> +{
> +       struct bpf_printf_buf *bufs = this_cpu_ptr(&bpf_printf_buf);
> +       int err, i, fmt_cnt = 0, copy_size, used;
> +       char *unsafe_ptr = NULL, *tmp_buf = NULL;
> +       bool prepare_args = final_args && mod;

probably better to enforce that both or none are specified, otherwise
return error

> +       enum bpf_printf_mod_type current_mod;
> +       size_t tmp_buf_len;
> +       u64 current_arg;
> +       char fmt_ptype;
> +
> +       for (i = 0; i < fmt_size && fmt[i] != '\0'; i++) {

Can we say that if the last character is not '\0' then it's a bad
format string and return -EINVAL? And if \0 is inside the format
string, then it's also a bad format string? I wonder what others think
about this?... I think sanity should prevail.

> +               if ((!isprint(fmt[i]) && !isspace(fmt[i])) ||
> +                   !isascii(fmt[i])) {

&& always binds tighter than ||, so you can omit extra (). I'd put
this on a single line as well, but that's a total nit.

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
> +               if (fmt_cnt >= num_args) {
> +                       err = -EINVAL;
> +                       goto out;
> +               }
>
>                 /* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
>                 i++;
> -               if (fmt[i] == 'l') {
> -                       mod[fmt_cnt]++;
> +
> +               /* skip optional "[0 +-][num]" width formating field */

typo: formatting

> +               while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
> +                      fmt[i] == ' ')
> +                       i++;
> +               if (fmt[i] >= '1' && fmt[i] <= '9') {
>                         i++;

Are we worried about integer overflow here? %123123123123123d
hopefully won't crash anything, right?

> -               } else if (fmt[i] == 'p') {
> -                       mod[fmt_cnt]++;
> -                       if ((fmt[i + 1] == 'k' ||
> -                            fmt[i + 1] == 'u') &&
> +                       while (fmt[i] >= '0' && fmt[i] <= '9')
> +                               i++;

whoa, fmt_size shouldn't be ignored

> +               }
> +

and here if we exhausted all format string but haven't gotten to
format specified, we should -EINVAL

if (i >= fmt_size) return -EINVAL?

> +               if (fmt[i] == 'p') {
> +                       current_mod = BPF_PRINTF_LONG;
> +
> +                       if ((fmt[i + 1] == 'k' || fmt[i + 1] == 'u') &&
>                             fmt[i + 2] == 's') {

right, if i + 2 is ok to access? always be remembering about fmt_size

>                                 fmt_ptype = fmt[i + 1];
>                                 i += 2;
>                                 goto fmt_str;
>                         }
>
> -                       if (fmt[i + 1] == 'B') {
> -                               i++;
> +                       if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
> +                           ispunct(fmt[i + 1]) || fmt[i + 1] == 'K' ||
> +                           fmt[i + 1] == 'x' || fmt[i + 1] == 'B' ||
> +                           fmt[i + 1] == 's' || fmt[i + 1] == 'S') {
> +                               /* just kernel pointers */
> +                               if (prepare_args)
> +                                       current_arg = raw_args[fmt_cnt];

fmt_cnt is not the best name, imo. arg_cnt makes more sense

>                                 goto fmt_next;
>                         }
>
> -                       /* disallow any further format extensions */
> -                       if (fmt[i + 1] != 0 &&
> -                           !isspace(fmt[i + 1]) &&
> -                           !ispunct(fmt[i + 1]))
> -                               return -EINVAL;
> +                       /* only support "%pI4", "%pi4", "%pI6" and "%pi6". */
> +                       if ((fmt[i + 1] != 'i' && fmt[i + 1] != 'I') ||
> +                           (fmt[i + 2] != '4' && fmt[i + 2] != '6')) {
> +                               err = -EINVAL;
> +                               goto out;
> +                       }
> +
> +                       i += 2;
> +                       if (!prepare_args)
> +                               goto fmt_next;
> +
> +                       if (!tmp_buf) {
> +                               used = this_cpu_inc_return(bpf_printf_buf_used);
> +                               if (WARN_ON_ONCE(used > 1)) {
> +                                       this_cpu_dec(bpf_printf_buf_used);
> +                                       return -EBUSY;
> +                               }
> +                               preempt_disable();

shouldn't we preempt_disable before we got bpf_printf_buf_used? if we
get preempted after incrementing counter, buffer will be unusable for
a while, potentially, right?

> +                               tmp_buf = bufs->tmp_buf;
> +                               tmp_buf_len = MAX_PRINTF_BUF_LEN;
> +                       }
> +
> +                       copy_size = (fmt[i + 2] == '4') ? 4 : 16;
> +                       if (tmp_buf_len < copy_size) {
> +                               err = -ENOSPC;
> +                               goto out;
> +                       }
> +
> +                       unsafe_ptr = (char *)(long)raw_args[fmt_cnt];
> +                       err = copy_from_kernel_nofault(tmp_buf, unsafe_ptr,
> +                                                      copy_size);
> +                       if (err < 0)
> +                               memset(tmp_buf, 0, copy_size);
> +                       current_arg = (u64)(long)tmp_buf;
> +                       tmp_buf += copy_size;
> +                       tmp_buf_len -= copy_size;
>
>                         goto fmt_next;
>                 } else if (fmt[i] == 's') {
> -                       mod[fmt_cnt]++;
> +                       current_mod = BPF_PRINTF_LONG;
>                         fmt_ptype = fmt[i];
>  fmt_str:
> -                       if (str_seen)
> -                               /* allow only one '%s' per fmt string */
> -                               return -EINVAL;
> -                       str_seen = true;
> -
>                         if (fmt[i + 1] != 0 &&
>                             !isspace(fmt[i + 1]) &&
> -                           !ispunct(fmt[i + 1]))
> -                               return -EINVAL;
> +                           !ispunct(fmt[i + 1])) {
> +                               err = -EINVAL;
> +                               goto out;
> +                       }
>
> -                       switch (fmt_cnt) {
> -                       case 0:
> -                               unsafe_ptr = (void *)(long)arg1;
> -                               arg1 = (long)buf;
> -                               break;
> -                       case 1:
> -                               unsafe_ptr = (void *)(long)arg2;
> -                               arg2 = (long)buf;
> -                               break;
> -                       case 2:
> -                               unsafe_ptr = (void *)(long)arg3;
> -                               arg3 = (long)buf;
> -                               break;
> +                       if (!prepare_args)
> +                               goto fmt_next;
> +
> +                       if (!tmp_buf) {
> +                               used = this_cpu_inc_return(bpf_printf_buf_used);
> +                               if (WARN_ON_ONCE(used > 1)) {
> +                                       this_cpu_dec(bpf_printf_buf_used);
> +                                       return -EBUSY;
> +                               }
> +                               preempt_disable();
> +                               tmp_buf = bufs->tmp_buf;
> +                               tmp_buf_len = MAX_PRINTF_BUF_LEN;
> +                       }

how about helper used like this:

if (try_get_fmt_tmp_buf(&tmp_buf, &tmp_buf_len))
    return -EBUSY;

which will do nothing if tmp_buf != NULL?

> +
> +                       if (!tmp_buf_len) {
> +                               err = -ENOSPC;
> +                               goto out;
>                         }
>
> -                       bpf_trace_copy_string(buf, unsafe_ptr, fmt_ptype,
> -                                       sizeof(buf));
> +                       unsafe_ptr = (char *)(long)raw_args[fmt_cnt];
> +                       err = bpf_trace_copy_string(tmp_buf, unsafe_ptr,
> +                                                   fmt_ptype, tmp_buf_len);
> +                       if (err < 0) {
> +                               tmp_buf[0] = '\0';
> +                               err = 1;
> +                       }
> +
> +                       current_arg = (u64)(long)tmp_buf;
> +                       tmp_buf += err;
> +                       tmp_buf_len -= err;
> +
>                         goto fmt_next;
>                 }
>
> +               current_mod = BPF_PRINTF_INT;
> +
>                 if (fmt[i] == 'l') {
> -                       mod[fmt_cnt]++;
> +                       current_mod = BPF_PRINTF_LONG;
> +                       i++;
> +               }
> +               if (fmt[i] == 'l') {
> +                       current_mod = BPF_PRINTF_LONG_LONG;
>                         i++;
>                 }
>
> -               if (fmt[i] != 'i' && fmt[i] != 'd' &&
> -                   fmt[i] != 'u' && fmt[i] != 'x')
> -                       return -EINVAL;
> +               if (fmt[i] != 'i' && fmt[i] != 'd' && fmt[i] != 'u' &&
> +                   fmt[i] != 'x' && fmt[i] != 'X') {
> +                       err = -EINVAL;
> +                       goto out;
> +               }
> +
> +               if (prepare_args)
> +                       current_arg = raw_args[fmt_cnt];
>  fmt_next:
> +               if (prepare_args) {

I'd ditch prepare_args variable and just check final_args (and that
check to ensure both mods and final_args are specified I suggested
above)

> +                       mod[fmt_cnt] = current_mod;
> +                       final_args[fmt_cnt] = current_arg;
> +               }
>                 fmt_cnt++;
>         }

[...]

> -
> -       return __BPF_TP_EMIT();
> +       err = 0;
> +out:
> +       bpf_printf_postamble();

naming is hard, but preamble and postamble reads way too fancy :)
bpf_printf_prepare() and bpf_printf_cleanup() or something like that
is a bit more to the point, no?


> +       return err;
> +}
> +

[...]

>
>  static const struct bpf_func_proto bpf_trace_printk_proto = {
> @@ -581,184 +687,37 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
>  }
>
>  #define MAX_SEQ_PRINTF_VARARGS         12
> -#define MAX_SEQ_PRINTF_MAX_MEMCPY      6
> -#define MAX_SEQ_PRINTF_STR_LEN         128
> -
> -struct bpf_seq_printf_buf {
> -       char buf[MAX_SEQ_PRINTF_MAX_MEMCPY][MAX_SEQ_PRINTF_STR_LEN];
> -};
> -static DEFINE_PER_CPU(struct bpf_seq_printf_buf, bpf_seq_printf_buf);
> -static DEFINE_PER_CPU(int, bpf_seq_printf_buf_used);
>
>  BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
>            const void *, data, u32, data_len)

[...]

> +       enum bpf_printf_mod_type mod[MAX_SEQ_PRINTF_VARARGS];
> +       u64 args[MAX_SEQ_PRINTF_VARARGS];
> +       int err, num_args;
>
> +       if (data_len & 7 || data_len > MAX_SEQ_PRINTF_VARARGS * 8 ||
> +           (data_len && !data))

data && !data_len is also an error, no?

> +               return -EINVAL;
>         num_args = data_len / 8;
>

[...]
