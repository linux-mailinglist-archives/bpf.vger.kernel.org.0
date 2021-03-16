Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23A433CCB7
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 05:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCPEtY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 00:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhCPEtT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 00:49:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51770C06174A;
        Mon, 15 Mar 2021 21:49:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id n195so35500077ybg.9;
        Mon, 15 Mar 2021 21:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfinjcOP/WltgE7VDVEoULBPntit2uuL70TjgkQqusg=;
        b=s6H6WZuM6/QOl8zJvXnGtqo7FVK6KeDBFpeA0nPhkYQr+qDQ0nVAS1h4716qxiVwia
         Tmu7fFGKZgIaImdnDnvTmI5VApq7OpYDJGKy/98OVqL7Bj6GusYlWP/UsxP6B4G6Vgw7
         wP4Yxq7Nr9BfMsM7eeaBGDDE1ZqH8GzXAgyexBHiEXtZgckrqcDtSZn85gOpzch2ku9f
         00vZCo/x2Y+SoRcUak6MNgvgHiuWIkAMqj7nWuNPjoTLD6PSyH6HpUpCy0JphDCarszV
         HNhnZ7q5E+dNY9AghKvLSXKbLrtT6Na0rZuOZPm9lVMYMq/f0AThOQ5l0NJJ7pDOdaq4
         WANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfinjcOP/WltgE7VDVEoULBPntit2uuL70TjgkQqusg=;
        b=MQOaGRwYabMtIE6mXieUtIUKht6tjNcuEMgvJZEMQSUphXcmV+3fgKDFsSS5Wqy7ai
         sfOkusKlklk0oKGvIgbf88xaizLFEAbsX+oucyviBE8+ofcupBve7c0Ysa5V3G1Pk9nn
         yo29ZvbfcHpSPjFW/vyb3bj/hGbC1RBNziv7blfiGBZZ7gAI6dr8Tq2zePVGAsTui96h
         d884XNbSnexH4Pv5wuKdemDT+1jFisshzUIqR/6MV5GqJ6EfXzaeMX2YV38LZ/MvVd5f
         /V/tJ2dIhykb1qTIWSE7ckjFgOv6OhtG0REThAXnhii7wBrjb4jwJ2VkZuqjGrBuAZcH
         ylfg==
X-Gm-Message-State: AOAM532Pp+lV4B5tTZ8yP6dOdJOLdlTJm6xuZl1VOG5I+kS8rYefOPf2
        2WuIFvjdiVaJEsdWAlBlZrxfc+7ocK7VftWc+xU=
X-Google-Smtp-Source: ABdhPJxa12hMvy3oFM2qB6rCWJbQDjbOhBNDHFyl1vwMhuVgzbmPGx4gB+Op10dlGs9KQlkh/0kdFdgkqH6qNprMkiw=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr4174800yba.510.1615870158661;
 Mon, 15 Mar 2021 21:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-6-revest@chromium.org>
In-Reply-To: <20210310220211.1454516-6-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Mar 2021 21:49:07 -0700
Message-ID: <CAEf4BzYTMjWWVS8ZLXNs8W89_koAdo2-4ir++He=tXA11VU0xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Add a series of tests for bpf_snprintf
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

On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
>
> This exercices most of the format specifiers when things go well.

typo: exercises

>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  .../selftests/bpf/prog_tests/snprintf.c       | 71 +++++++++++++++++++
>  .../selftests/bpf/progs/test_snprintf.c       | 71 +++++++++++++++++++
>  2 files changed, 142 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> new file mode 100644
> index 000000000000..23af1dbd1eeb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Google LLC. */
> +
> +#include <test_progs.h>
> +#include "test_snprintf.skel.h"
> +
> +static int duration;

if you drop CHECK() below, you won't need duration here at all

> +
> +#define EXP_NUM_OUT  "-8 9 96 -424242 1337 DABBAD00"
> +#define EXP_NUM_RET  sizeof(EXP_NUM_OUT)
> +
> +#define EXP_IP_OUT   "127.000.000.001 0000:0000:0000:0000:0000:0000:0000:0001"
> +#define EXP_IP_RET   sizeof(EXP_IP_OUT)
> +
> +/* The third specifier, %pB, depends on compiler inlining so don't check it */
> +#define EXP_SYM_OUT  "schedule schedule+0x0/"
> +#define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
> +
> +/* The third specifier, %p, is a hashed pointer which changes on every reboot */
> +#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
> +#define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
> +
> +#define EXP_STR_OUT  "str1 longstr"
> +#define EXP_STR_RET  sizeof(EXP_STR_OUT)
> +
> +#define EXP_OVER_OUT {'%', 'o', 'v', 'e', 'r'}
> +#define EXP_OVER_RET 10
> +
> +void test_snprintf(void)
> +{
> +       char exp_addr_out[] = EXP_ADDR_OUT;
> +       char exp_over_out[] = EXP_OVER_OUT;
> +       char exp_sym_out[]  = EXP_SYM_OUT;
> +       struct test_snprintf *skel;
> +       int err;
> +
> +       skel = test_snprintf__open_and_load();
> +       if (CHECK(!skel, "skel_open", "failed to open and load skeleton\n"))

ASSERT_OK_PTR
> +               return;
> +
> +       err = test_snprintf__attach(skel);
> +       if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))

ASSERT_OK
> +               goto cleanup;
> +
> +       /* trigger tracepoint */
> +       usleep(1);
> +
> +       ASSERT_STREQ(skel->bss->num_out, EXP_NUM_OUT, "num_out");
> +       ASSERT_EQ(skel->bss->num_ret, EXP_NUM_RET, "num_ret");
> +
> +       ASSERT_STREQ(skel->bss->ip_out, EXP_IP_OUT, "ip_out");
> +       ASSERT_EQ(skel->bss->ip_ret, EXP_IP_RET, "ip_ret");
> +
> +       ASSERT_OK(memcmp(skel->bss->sym_out, exp_sym_out,
> +                        sizeof(exp_sym_out) - 1), "sym_out");
> +       ASSERT_LT(MIN_SYM_RET, skel->bss->sym_ret, "sym_ret");
> +
> +       ASSERT_OK(memcmp(skel->bss->addr_out, exp_addr_out,
> +                        sizeof(exp_addr_out) - 1), "addr_out");
> +       ASSERT_EQ(skel->bss->addr_ret, EXP_ADDR_RET, "addr_ret");
> +
> +       ASSERT_STREQ(skel->bss->str_out, EXP_STR_OUT, "str_out");
> +       ASSERT_EQ(skel->bss->str_ret, EXP_STR_RET, "str_ret");
> +
> +       ASSERT_OK(memcmp(skel->bss->over_out, exp_over_out,
> +                        sizeof(exp_over_out)), "over_out");
> +       ASSERT_EQ(skel->bss->over_ret, EXP_OVER_RET, "over_ret");
> +
> +cleanup:
> +       test_snprintf__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
> new file mode 100644
> index 000000000000..6c8aa4988e69
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Google LLC. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_endian.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#define OUT_LEN 64
> +
> +/* Integer types */
> +static const char num_fmt[] = "%d %u %x %li %llu %lX";
> +#define NUMBERS -8, 9, 150, -424242, 1337, 0xDABBAD00

here I actually don't get the point of #define, can you please just
inline them at the invocation place? I think that will be nicer and
simpler (and will match common usage pattern)

> +
> +char num_out[OUT_LEN] = {};
> +long num_ret = 0;
> +
> +/* IP addresses */
> +static const char ip_fmt[] = "%pi4 %pI6";
> +static const __u8 dummy_ipv4[] = {127, 0, 0, 1}; /* 127.0.0.1 */
> +static const __u32 dummy_ipv6[] = {0, 0, 0, bpf_htonl(1)}; /* ::1/128 */
> +#define IPS &dummy_ipv4, &dummy_ipv6
> +
> +char ip_out[OUT_LEN] = {};
> +long ip_ret = 0;
> +
> +/* Symbol lookup formatting */
> +static const char sym_fmt[] = "%ps %pS %pB";
> +extern const void schedule __ksym;
> +#define SYMBOLS &schedule, &schedule, &schedule
> +
> +char sym_out[OUT_LEN] = {};
> +long sym_ret = 0;
> +
> +/* Kernel pointers */
> +static const char addr_fmt[] = "%pK %px %p";
> +#define ADDRESSES 0, 0xFFFF00000ADD4E55, 0xFFFF00000ADD4E55
> +
> +char addr_out[OUT_LEN] = {};
> +long addr_ret = 0;
> +
> +/* Strings embedding */
> +static const char str_fmt[] = "%s %+05s";
> +static const char str1[] = "str1";
> +static const char longstr[] = "longstr";
> +#define STRINGS str1, longstr
> +
> +char str_out[OUT_LEN] = {};
> +long str_ret = 0;
> +
> +/* Overflow */
> +static const char over_fmt[] = "%%overflow";
> +
> +#define OVER_OUT_LEN 6
> +char over_out[OVER_OUT_LEN] = {};
> +long over_ret = 0;
> +

same for all the above #defines, tests will be easier to follow if you
just use value in BPF_SNPRINTF below

> +SEC("raw_tp/sys_enter")
> +int handler(const void *ctx)
> +{
> +       num_ret  = BPF_SNPRINTF(num_out,  OUT_LEN, num_fmt,  NUMBERS);
> +       ip_ret   = BPF_SNPRINTF(ip_out,   OUT_LEN, ip_fmt,   IPS);
> +       sym_ret  = BPF_SNPRINTF(sym_out,  OUT_LEN, sym_fmt,  SYMBOLS);
> +       addr_ret = BPF_SNPRINTF(addr_out, OUT_LEN, addr_fmt, ADDRESSES);
> +       str_ret  = BPF_SNPRINTF(str_out,  OUT_LEN, str_fmt,  STRINGS);
> +       over_ret = BPF_SNPRINTF(over_out, OVER_OUT_LEN, over_fmt);

in practice you'd do BPF_SNPRINTF(num_out, sizeof(num_out), ...). So
use that in test code as well please.

> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
