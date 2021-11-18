Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28ED5456400
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 21:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhKRU0m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 15:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhKRU0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 15:26:40 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD0C061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 12:23:39 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id g17so21535579ybe.13
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQYgxvi1E4/+ApQSsFK6eALdCLWECkKcThoUYXIzkCQ=;
        b=mWOPVdJYQorNcUOGu7pfkrppMfFJIDUsCayumY9YLElplS+3hSjweUpgzl6HzKqUeY
         88mbtMBG9fLawc1sHKkEzQyG8A/Q8ws7CH5mQkP8S9WezOJw3bm4rDswepW81JeelunB
         kUSK3NKeaaVhcLVg0J7U5dsTz3LjTBxfMIATv8VdCYxqePVkx1wJkDv3UFOS3fmA2Mlz
         dy9HF7saR2x8iB4fsy+4bgvkeAgwTqQR9Ki+YA4Sq4WXCG0s/lMSJRbtxVYnasUewm2N
         /M8ZK40Nu6TAaFiOLLaqAlJd4zhV9AvxRwQEoG3s9pnnLeGZH9wayVyx9oQ8k9iLm2tc
         ZZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQYgxvi1E4/+ApQSsFK6eALdCLWECkKcThoUYXIzkCQ=;
        b=32fduuUrd+M10SKg1d+y+InJs1ohy/73KbJuA7Xw7wYXIBUCu5TkVeWOwM1Uo4wxei
         cV1G9hrtNF6AML9+lPZxevINCOrg1lyhcjJQyqbRkODAEZyk8uDXXOvIHLdiM59n822l
         BwUYrnt5uQFDxQnt4N5VdRmPqAmDDRGXgS8QdQqgP2BdbEArPmh+cA4EBXoadmC+dbej
         Fc4LcZGXoJCDY01l75RdcER9bdhebcMGMaNKpZ/wILCNzEbHWklZ3DNHgHwPtJXxSYNI
         vdt+SwctFteT822oWealeYs4JBOvvXDaAbEnrvqKhvag+L9XXWDyVjz5c+ze6g1xZTb3
         laYA==
X-Gm-Message-State: AOAM5331W9sI1CvA4lEEv5Icq+uMffuCd/kMcTCIZZcAt76DKdI+8lN7
        vgse5oyDM8939TplbE0P9RyQ3Jmut2VIjir1DCm8S/la
X-Google-Smtp-Source: ABdhPJwB6OGN5edx1w4GHAWmlNI3LdT3apajBuFYOzMrScGKRX0SBvu7TgqrlROeJ0U1Oc3W9drN3tEq/DP9cHtxbfs=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr30337731ybf.114.1637267018671;
 Thu, 18 Nov 2021 12:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20211118010404.2415864-1-joannekoong@fb.com> <20211118010404.2415864-3-joannekoong@fb.com>
In-Reply-To: <20211118010404.2415864-3-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Nov 2021 12:23:27 -0800
Message-ID: <CAEf4BzYKdK3Oj0=cKPof+MZCmnSAgNcA7TTyswcq7oNY6+s9Gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add tests for bpf_for_each
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 17, 2021 at 5:07 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> In this patch -
> 1) Add a new prog "for_each_helper" which tests the basic functionality of
> the bpf_for_each helper.
>
> 2) Add pyperf600_foreach and strobemeta_foreach to test the performance
> of using bpf_for_each instead of a for loop
>
> The results of pyperf600 and strobemeta are as follows:
>
> ~strobemeta~
>
> Baseline
>     verification time 6808200 usec
>     stack depth 496
>     processed 592132 insns (limit 1000000) max_states_per_insn 14
>     total_states 16018 peak_states 13684 mark_read 3132
>     #188 verif_scale_strobemeta:OK (unrolled loop)
>
> Using bpf_for_each
>     verification time 31589 usec
>     stack depth 96+408
>     processed 1630 insns (limit 1000000) max_states_per_insn 4
>     total_states 107 peak_states 107 mark_read 60
>     #189 verif_scale_strobemeta_foreach:OK
>
> ~pyperf600~
>
> Baseline
>     verification time 29702486 usec
>     stack depth 368
>     processed 626838 insns (limit 1000000) max_states_per_insn 7
>     total_states 30368 peak_states 30279 mark_read 748
>     #182 verif_scale_pyperf600:OK (unrolled loop)
>
> Using bpf_for_each
>     verification time 148488 usec

200x, this is awesome

>     stack depth 320+40
>     processed 10518 insns (limit 1000000) max_states_per_insn 10
>     total_states 705 peak_states 517 mark_read 38
>     #183 verif_scale_pyperf600_foreach:OK
>
> Using the bpf_for_each helper led to approximately a 100% decrease
> in the verification time and in the number of instructions.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  .../bpf/prog_tests/bpf_verif_scale.c          | 12 +++
>  .../selftests/bpf/prog_tests/for_each.c       | 61 ++++++++++++++++
>  .../selftests/bpf/progs/for_each_helper.c     | 69 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/pyperf.h    | 70 +++++++++++++++++-
>  .../selftests/bpf/progs/pyperf600_foreach.c   |  5 ++
>  .../testing/selftests/bpf/progs/strobemeta.h  | 73 ++++++++++++++++++-
>  .../selftests/bpf/progs/strobemeta_foreach.c  |  9 +++

let's split out strobemeta and pyperf refactorings into a separate
patch from dedicated tests for bpf_for_each helper, they are logically
quite different and independent

>  7 files changed, 295 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/for_each_helper.c
>  create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_foreach.c
>  create mode 100644 tools/testing/selftests/bpf/progs/strobemeta_foreach.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> index 867349e4ed9e..77396484fde7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> @@ -115,6 +115,12 @@ void test_verif_scale_pyperf600()
>         scale_test("pyperf600.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
>  }
>
> +void test_verif_scale_pyperf600_foreach(void)
> +{
> +       /* use the bpf_for_each helper*/
> +       scale_test("pyperf600_foreach.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
> +}
> +
>  void test_verif_scale_pyperf600_nounroll()
>  {
>         /* no unroll at all.
> @@ -165,6 +171,12 @@ void test_verif_scale_strobemeta()
>         scale_test("strobemeta.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
>  }
>
> +void test_verif_scale_strobemeta_foreach(void)
> +{
> +       /* use the bpf_for_each helper*/
> +       scale_test("strobemeta_foreach.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
> +}
> +
>  void test_verif_scale_strobemeta_nounroll1()
>  {
>         /* no unroll, tiny loops */
> diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/testing/selftests/bpf/prog_tests/for_each.c
> index 68eb12a287d4..529573a82334 100644
> --- a/tools/testing/selftests/bpf/prog_tests/for_each.c
> +++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
> @@ -4,6 +4,7 @@
>  #include <network_helpers.h>
>  #include "for_each_hash_map_elem.skel.h"
>  #include "for_each_array_map_elem.skel.h"
> +#include "for_each_helper.skel.h"
>
>  static unsigned int duration;
>
> @@ -121,10 +122,70 @@ static void test_array_map(void)
>         for_each_array_map_elem__destroy(skel);
>  }
>
> +static void test_for_each_helper(void)
> +{
> +       struct for_each_helper *skel;
> +       __u32 retval;
> +       int err;
> +
> +       skel = for_each_helper__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "for_each_helper__open_and_load"))
> +               return;
> +
> +       skel->bss->nr_iterations = 100;
> +       err = bpf_prog_test_run(bpf_program__fd(skel->progs.test_prog),
> +                               1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
> +                               &retval, &duration);
> +       if (CHECK(err || retval, "bpf_for_each helper test_prog",

please don't use CHECK() in new test, stick to ASSERT_XXX()


> +                 "err %d errno %d retval %d\n", err, errno, retval))
> +               goto out;
> +       ASSERT_EQ(skel->bss->nr_iterations_completed, skel->bss->nr_iterations,
> +                 "nr_iterations mismatch");
> +       ASSERT_EQ(skel->bss->g_output, (100 * 99) / 2, "wrong output");
> +
> +       /* test callback_fn returning 1 to stop iteration */
> +       skel->bss->nr_iterations = 400;
> +       skel->data->stop_index = 50;
> +       err = bpf_prog_test_run(bpf_program__fd(skel->progs.test_prog),
> +                               1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
> +                               &retval, &duration);
> +       if (CHECK(err || retval, "bpf_for_each helper test_prog",
> +                 "err %d errno %d retval %d\n", err, errno, retval))
> +               goto out;
> +       ASSERT_EQ(skel->bss->nr_iterations_completed, skel->data->stop_index + 1,
> +                 "stop_index not followed");
> +       ASSERT_EQ(skel->bss->g_output, (50 * 49) / 2, "wrong output");
> +
> +       /* test passing in a null ctx */
> +       skel->bss->nr_iterations = 10;
> +       err = bpf_prog_test_run(bpf_program__fd(skel->progs.prog_null_ctx),
> +                               1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
> +                               &retval, &duration);
> +       if (CHECK(err || retval, "bpf_for_each helper prog_null_ctx",
> +                 "err %d errno %d retval %d\n", err, errno, retval))
> +               goto out;
> +       ASSERT_EQ(skel->bss->nr_iterations_completed, skel->bss->nr_iterations,
> +                 "nr_iterations mismatch");
> +
> +       /* test invalid flags */
> +       err = bpf_prog_test_run(bpf_program__fd(skel->progs.prog_invalid_flags),
> +                               1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
> +                               &retval, &duration);
> +       if (CHECK(err || retval, "bpf_for_each helper prog_invalid_flags",
> +                 "err %d errno %d retval %d\n", err, errno, retval))
> +               goto out;
> +       ASSERT_EQ(skel->bss->err, -EINVAL, "invalid_flags");
> +
> +out:
> +       for_each_helper__destroy(skel);
> +}
> +
>  void test_for_each(void)
>  {
>         if (test__start_subtest("hash_map"))
>                 test_hash_map();
>         if (test__start_subtest("array_map"))
>                 test_array_map();
> +       if (test__start_subtest("for_each_helper"))
> +               test_for_each_helper();

those hash_map and array_map are conceptually very different tests,
it's probably best to have a separate file under prog_tests dedicated
to this new helper.

>  }
> diff --git a/tools/testing/selftests/bpf/progs/for_each_helper.c b/tools/testing/selftests/bpf/progs/for_each_helper.c
> new file mode 100644
> index 000000000000..4404d0cb32a6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/for_each_helper.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct callback_ctx {
> +       int output;
> +};
> +
> +/* This should be set by the user program */
> +u32 nr_iterations;
> +u32 stop_index = -1;
> +
> +/* Making these global variables so that the userspace program
> + * can verify the output through the skeleton
> + */
> +int nr_iterations_completed;
> +int g_output;
> +int err;
> +
> +static int callback_fn(__u32 index, void *data)
> +{
> +       struct callback_ctx *ctx = data;
> +
> +       if (index >= stop_index)
> +               return 1;
> +
> +       ctx->output += index;
> +
> +       return 0;
> +}
> +
> +static int empty_callback_fn(__u32 index, void *data)
> +{
> +       return 0;
> +}
> +
> +SEC("tc")
> +int test_prog(struct __sk_buff *skb)
> +{
> +       struct callback_ctx data = {};
> +
> +       nr_iterations_completed = bpf_for_each(nr_iterations, callback_fn, &data, 0);
> +
> +       g_output = data.output;
> +
> +       return 0;
> +}
> +
> +SEC("tc")
> +int prog_null_ctx(struct __sk_buff *skb)
> +{
> +       nr_iterations_completed = bpf_for_each(nr_iterations, empty_callback_fn, NULL, 0);
> +
> +       return 0;
> +}
> +
> +SEC("tc")
> +int prog_invalid_flags(struct __sk_buff *skb)
> +{
> +       struct callback_ctx data = {};
> +
> +       err = bpf_for_each(nr_iterations, callback_fn, &data, 1);
> +
> +       return 0;
> +}

You mentioned that nested loops works, let's have a test for that.

[...]
