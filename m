Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CFE369CD5
	for <lists+bpf@lfdr.de>; Sat, 24 Apr 2021 00:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhDWWjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 18:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhDWWi7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 18:38:59 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014BBC061574;
        Fri, 23 Apr 2021 15:38:23 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c195so57376142ybf.9;
        Fri, 23 Apr 2021 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M6dRbZWxkOXLYGL6npBves0jo4gxvKKmAPb1kIlkFJM=;
        b=HYEQ9C0zhA8J/iuIK7yJ//iVjJfDFoT7lKHPx//bdeUrPDVUFZHtcA/n3B6uJyotgF
         eF4aPj6Y2xIeHux+Ut34ciP9IM7oMtrBOXN3HsBuh75SnmKdRogff4VBYC5S6lgaPK+z
         DwmMh2Gx9qkg9pHV4S/U52fkmGoE1fuXieCDqqs2bbMr3SjlijM5RhEmlOiRNsL3BsKk
         L3i9GGBkUcZ7syTU1Dvzv+ld9AeTeb8DhOA/YH5V3hlBKJKfvP6VQt0s1Za/3eHvPqLQ
         yI92O/SRuLZ/g0Iktkn+BgNRdI+Qa/+ZxAECWuS/Lzq5YPoJ1HgJAs/z81dFqoWXSOKi
         m92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M6dRbZWxkOXLYGL6npBves0jo4gxvKKmAPb1kIlkFJM=;
        b=mcb62QoWSLpss5JQ0Sa9WftZMLvw2nv0MhiyOnwWzWklrcCr0oxToCIlmYStZthpLg
         jg2kauh73HeYzOguUF7W77zIiXy6vltbZhwr/QUIsigxjLvrkuDCpNM0/WQ75SCgne2j
         qEfVFm6NnZ/H6G9GsbOekKWNv3ND2BcV4xx+34YDVULy9GCn9UY0rOEMOFAFj6h+0Y1s
         C0cPj4ttVXlvML+GeYK/bygNiOr5jwAJm0Fukc541b9xnkrqYDrpRXCwD+1fTuZ1v1sr
         shA4NpVyJk+B4fKbgRaZOnpx38QEXXrLQ10IAbS2mhELOaHwnOJBJc29CdzT+G7+ZVJE
         kG9A==
X-Gm-Message-State: AOAM532LT7BLbMpeCsfAzA2AuBpxl7ZbtQwOwq4OGorFIDrrg0ELqfEG
        Z7K32/AiO3Uqx/wEoby+dt1s7QNYOCn3O7hm32A=
X-Google-Smtp-Source: ABdhPJznUzvbQUnnMybj04p96QCBlJfHq+gLp90bgClI8/E6Lcul/sa0t2ZSklb8gne1qw1BtLNWcwbaxIuTNSIjreA=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr8038815ybg.459.1619217502233;
 Fri, 23 Apr 2021 15:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <20210419155243.1632274-7-revest@chromium.org>
In-Reply-To: <20210419155243.1632274-7-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Apr 2021 15:38:11 -0700
Message-ID: <CAEf4BzZUM4hb9owhompwARabRvRbCYxBrpgXSdXM8RRm42tU1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
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

On Mon, Apr 19, 2021 at 8:52 AM Florent Revest <revest@chromium.org> wrote:
>
> The "positive" part tests all format specifiers when things go well.
>
> The "negative" part makes sure that incorrect format strings fail at
> load time.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  .../selftests/bpf/prog_tests/snprintf.c       | 125 ++++++++++++++++++
>  .../selftests/bpf/progs/test_snprintf.c       |  73 ++++++++++
>  .../bpf/progs/test_snprintf_single.c          |  20 +++
>  3 files changed, 218 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> new file mode 100644
> index 000000000000..a958c22aec75
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Google LLC. */
> +
> +#include <test_progs.h>
> +#include "test_snprintf.skel.h"
> +#include "test_snprintf_single.skel.h"
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
> +#define EXP_OVER_OUT "%over"
> +#define EXP_OVER_RET 10
> +
> +#define EXP_PAD_OUT "    4 000"

Roughly 50% of the time I get failure for this test case:

test_snprintf_positive:FAIL:pad_out unexpected pad_out: actual '    4
0000' != expected '    4 000'

Re-running this test case immediately passes. Running again most
probably fails. Please take a look.

> +#define EXP_PAD_RET 900007
> +
> +#define EXP_NO_ARG_OUT "simple case"
> +#define EXP_NO_ARG_RET 12
> +
> +#define EXP_NO_BUF_RET 29
> +

[...]
