Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B434B274
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZXGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCZXFf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 19:05:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951CCC0613AA;
        Fri, 26 Mar 2021 16:05:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id x189so7435138ybg.5;
        Fri, 26 Mar 2021 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjxxnlWbQ73WMt4RzF0hQ7IUkIuTu6QiZzPUNKIpmKM=;
        b=aZYp52Hn7x5IhQYlRWTBlte5pL56LuZ1Q44SLuNVegc+TMBnQoh26fryyE+2k9EiXI
         zPrFZe0Syfs5EmfCf89d31uwYMhv9EQUCibyQsIM/5goiPljSPhv95J42S7QparT9Fo+
         GyC0+jra/9G3DlQEr4rhY5D02IGXWVgkjnNGlTpEsNoYzcQjw8tBP/IZDxjxjhzjNngI
         DVCwLhXs6/g8fqACeAJS/bvsoiK3M8IsffbSQd2rtUYZPi3zCFoyW0Td/i+c42MeVB+Y
         RZAhHaqHbKPOaDZr3r/f4wgkkYj4GLAeOvMz6x9StkShzeU0an6nn2MJoxvauguLZZu3
         aRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjxxnlWbQ73WMt4RzF0hQ7IUkIuTu6QiZzPUNKIpmKM=;
        b=qDswt6GSAMIp2CYlAel90BAeDHnerbQw5uA+56YFXzRywd/+WmgUxm8Ds2yvkN7vpR
         qKUcjyz0ATV9S0/C3FW+M4hzF4fLjfics0+EOuKygow3PGJS0x7BGq5rh7UpGrxE/k12
         MGI9m4UCyR6xn+kTueFR1qjC56EFg1pu6idx+LBUT5CszWgYb1LB4jlXpCmrIb97rBf5
         NNJh2oacc5cHpq7dQv3RwsL+7Q4F8XxZ9B8iWoegwzwi6R2t25s/+tKlg/7y1dKz8fRs
         99PMWSeoYNURqXQXAw1dKKj5hlaSh0YB4GtQOcDi9BD7cbjaJB+zLpCUbfWE2Ai3HvYs
         RKbw==
X-Gm-Message-State: AOAM533k2nAvAsIrCCOtLHm73qLB+8JWNc8G/wEaKucpYbQTy9xYRa0j
        mJBnNpJwDYWYymqIpuPxkQ1/3xP7Qktean/53No=
X-Google-Smtp-Source: ABdhPJx3bYT/be/5+/6ifGqCYDCs21gumyMHgC6U6HghH4PzD4QHdHQkPPNOhVLc0Ycm+j8o8RpOdRha0GUkxlhsSjw=
X-Received: by 2002:a25:9942:: with SMTP id n2mr22100008ybo.230.1616799934946;
 Fri, 26 Mar 2021 16:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-7-revest@chromium.org>
In-Reply-To: <20210324022211.1718762-7-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Mar 2021 16:05:24 -0700
Message-ID: <CAEf4Bzb1z2KOHsMTrSP2t3S0iT3UrYMAWsO1_OqD_EYMECsZ-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
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
> This exercises most of the format specifiers when things go well.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---

Looks good. Please add a no-argument test case as well.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/snprintf.c       | 65 +++++++++++++++++++
>  .../selftests/bpf/progs/test_snprintf.c       | 59 +++++++++++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
>

[...]

> +
> +SEC("raw_tp/sys_enter")
> +int handler(const void *ctx)
> +{
> +       /* Convenient values to pretty-print */
> +       const __u8 ex_ipv4[] = {127, 0, 0, 1};
> +       const __u8 ex_ipv6[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1};
> +       const char str1[] = "str1";
> +       const char longstr[] = "longstr";
> +       extern const void schedule __ksym;

oh, fancy. I'd move it out of this function into global space, though,
to make it more apparent. I almost missed that it's a special one.

> +
> +       /* Integer types */
> +       num_ret  = BPF_SNPRINTF(num_out, sizeof(num_out),
> +                               "%d %u %x %li %llu %lX",
> +                               -8, 9, 150, -424242, 1337, 0xDABBAD00);
> +       /* IP addresses */
> +       ip_ret   = BPF_SNPRINTF(ip_out, sizeof(ip_out), "%pi4 %pI6",
> +                               &ex_ipv4, &ex_ipv6);
> +       /* Symbol lookup formatting */
> +       sym_ret  = BPF_SNPRINTF(sym_out,  sizeof(sym_out), "%ps %pS %pB",
> +                               &schedule, &schedule, &schedule);
> +       /* Kernel pointers */
> +       addr_ret = BPF_SNPRINTF(addr_out, sizeof(addr_out), "%pK %px %p",
> +                               0, 0xFFFF00000ADD4E55, 0xFFFF00000ADD4E55);
> +       /* Strings embedding */
> +       str_ret  = BPF_SNPRINTF(str_out, sizeof(str_out), "%s %+05s",
> +                               str1, longstr);
> +       /* Overflow */
> +       over_ret = BPF_SNPRINTF(over_out, sizeof(over_out), "%%overflow");
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
