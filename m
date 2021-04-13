Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6EF35E995
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 01:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhDMXRQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 19:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhDMXRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 19:17:15 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D998C061574;
        Tue, 13 Apr 2021 16:16:55 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 65so20033563ybc.4;
        Tue, 13 Apr 2021 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QgfRJoCybq9KsaEJIAzOX252QGmZc9D7nckNGd8wwqk=;
        b=lsqgwiDY2hueWfpFoHPjNpqKf63Yrg8mX8D8SLHoJHZKmel0b1P07wSdUF6J10QhEQ
         HrtsLKcKzQ1uBtTqsawQBIievd/Gge40kUWDjV3EybgbKtcY+MbAJfXFFlYy+s9UUvdf
         uSCVbBLhEXv3z/EkNs2UIHz8bDwo97PcIvgccgecRKI/IfWRGuMJtMmS7u0MqS5b0RiF
         +utIE7K7TLY4wrD8XKDwrY1X31s2X5W8JLJrSSIDvtS8iAurWmyEUL0iG4KuRC8bVGGW
         06cgme0b0pazI+4lrFTuVAtZ7WpSogF3+QWU+aUCDKfUCjoqk15+rBbiiMIYu56oDHGW
         ySuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QgfRJoCybq9KsaEJIAzOX252QGmZc9D7nckNGd8wwqk=;
        b=SwhtNvLdj5ncGQ6X5gbwkFHTmnehAYdEW7IsXlapoNi95w94nAyXP1i62KzJdxD7AD
         Kqbqf5u2yQ9u6DKZNpETOsQRzq1jbnW7M46DmxIz1liShV7fOvX6RUFpHmC4Af2fH/Mv
         qWcfyhXh+rDWytc1fhaSAlYf1dCNB46Y54Ooxb7Wg9x20wVa4eJ/veUoKCrguWw8e7+k
         WU54zv4oxCuVeevSXbedJ+f1Gk5x6YUZw37mRw3ds+O3hEo6lRyULLgM7ZKrs+JMdDvK
         kpTddDKwH4V76LkjlagRN3uyy7KrTlZ3hWNTuvTAU5gbsyKSsLBfoX2MAfSNEw8rDtF9
         qWVA==
X-Gm-Message-State: AOAM531dPQ8ztTm0fyaQWQwRYJkDxYscN0TqQdDrVyaSI5AQY0QmqmqH
        IgKUU/VKNjrIj9/XdhjakNITQhmJSbkPqT8D0w6/fQiq
X-Google-Smtp-Source: ABdhPJzVwe6XeypoL5AGx18j/fFFjg2J4NBzEF9zUVH7EBEvCdmGOBfgpttxDsWM1kVweQgS3tr7HNOjUsEmxxs2OqU=
X-Received: by 2002:a25:850c:: with SMTP id w12mr4566130ybk.347.1618355814520;
 Tue, 13 Apr 2021 16:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-4-revest@chromium.org>
In-Reply-To: <20210412153754.235500-4-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 16:16:43 -0700
Message-ID: <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
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
> The implementation takes inspiration from the existing bpf_trace_printk
> helper but there are a few differences:
>
> To allow for a large number of format-specifiers, parameters are
> provided in an array, like in bpf_seq_printf.
>
> Because the output string takes two arguments and the array of
> parameters also takes two arguments, the format string needs to fit in
> one argument. Thankfully, ARG_PTR_TO_CONST_STR is guaranteed to point to
> a zero-terminated read-only map so we don't need a format string length
> arg.
>
> Because the format-string is known at verification time, we also do
> a first pass of format string validation in the verifier logic. This
> makes debugging easier.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  include/linux/bpf.h            |  6 ++++
>  include/uapi/linux/bpf.h       | 28 +++++++++++++++++++
>  kernel/bpf/helpers.c           |  2 ++
>  kernel/bpf/verifier.c          | 41 ++++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c       | 50 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++
>  6 files changed, 155 insertions(+)
>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5f46dd6f3383..d4020e5f91ee 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5918,6 +5918,41 @@ static int check_reference_leak(struct bpf_verifier_env *env)
>         return state->acquired_refs ? -EINVAL : 0;
>  }
>
> +static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
> +                                  struct bpf_reg_state *regs)
> +{
> +       struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
> +       struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
> +       struct bpf_map *fmt_map = fmt_reg->map_ptr;
> +       int err, fmt_map_off, num_args;
> +       u64 fmt_addr;
> +       char *fmt;
> +
> +       /* data must be an array of u64 */
> +       if (data_len_reg->var_off.value % 8)
> +               return -EINVAL;
> +       num_args = data_len_reg->var_off.value / 8;
> +
> +       /* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
> +        * and map_direct_value_addr is set.
> +        */
> +       fmt_map_off = fmt_reg->off + fmt_reg->var_off.value;
> +       err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
> +                                                 fmt_map_off);
> +       if (err)
> +               return err;
> +       fmt = (char *)fmt_addr + fmt_map_off;
> +

bot complained about lack of (long) cast before fmt_addr, please address


[...]

> +       /* Maximumly we can have MAX_SNPRINTF_VARARGS parameters, just give
> +        * all of them to snprintf().
> +        */
> +       err = snprintf(str, str_size, fmt, BPF_CAST_FMT_ARG(0, args, mod),
> +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod),
> +               BPF_CAST_FMT_ARG(3, args, mod), BPF_CAST_FMT_ARG(4, args, mod),
> +               BPF_CAST_FMT_ARG(5, args, mod), BPF_CAST_FMT_ARG(6, args, mod),
> +               BPF_CAST_FMT_ARG(7, args, mod), BPF_CAST_FMT_ARG(8, args, mod),
> +               BPF_CAST_FMT_ARG(9, args, mod), BPF_CAST_FMT_ARG(10, args, mod),
> +               BPF_CAST_FMT_ARG(11, args, mod));
> +
> +       put_fmt_tmp_buf();

reading this for at least 3rd time, this put_fmt_tmp_buf() looks a bit
out of place and kind of random. I think bpf_printf_cleanup() name
pairs with bpf_printf_prepare() better.

> +
> +       return err + 1;

snprintf() already returns string length *including* terminating zero,
so this is wrong


> +}
> +

[...]
