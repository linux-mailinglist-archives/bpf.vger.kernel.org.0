Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F3F326755
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 20:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBZTSv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 14:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZTSt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 14:18:49 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4CAC061574
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:18:09 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id u75so9936974ybi.10
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsdtmGKED24jpwEo6jPFoeZ6M5CeJ3xREeV7c4a/TTE=;
        b=tFESsp2KobhQA/nWjvHX1TwH8UM0de1YmPn9RUgZz1WxG8N6olMK+kHMpYfAaQlDc7
         en1QmXV+zvHE7WthKJibyp/+HDqyxRBTr9bU66LuCnne32AZqFOUnCjsfX+1u8jFCRjv
         KTRLwxxb06gdMTZCWDeu5MpqjYSX0w1Kf5oX725EJI90XL3cOjFqaMwD1Llc4V6yrt0D
         fIB0TAXARfELbeD85/NtmdcRnCg9kt+KUQzsj7F+bWksIF6+WinDlmtfWuBNUNAqG2oJ
         fGAIYNPHRdT3lmASN/0kld9yvLiqOTsE+Zi2bHpXKMtBX+dCVnjh3d9CtYKIDdU2B+P5
         pNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsdtmGKED24jpwEo6jPFoeZ6M5CeJ3xREeV7c4a/TTE=;
        b=SqXZ/v4zsQsZVMa6KRgiiPkG6nLm2HvoZzi+HYlu6GdzOMCwUVTK7vre1K24GmTVwE
         nk4gdnE/OnkHa7hzGa2YwadvAmKtd3YWVTauPqQ64LW7e5aB/3RjUhmi1dCNCNdTuVUn
         8ofMx1mDmU85s7HFflvOJle/WuuW+SzxbdKTYf2OD0GypPpMfjGEfAKM3ZzkdbE1w1R7
         zeDlsFjQnAwFOPgvQQYxSNM+CZMHmgx4VgjaXm3qGh7PxiLK200wGfQhybMjOTZcdcFK
         Olqj6NGzZQGK/wG0RInDzR9FpmXMCmxpOq0MffJS7YUWgHqUZ3AsBiDeVOOjWPGFl1la
         3nmw==
X-Gm-Message-State: AOAM530NAq0vEpgAgt4+1viKhcHWxxaB6ROArjbXuEJlW9YFAJzy/lgf
        FmqBc+IbK0lFhEonF+v8rEam5u0EeIJLB2lPBYv4fe/+
X-Google-Smtp-Source: ABdhPJyzJxPtRg6madHBIMHww1lxx1JOkYX5HMn9lSH2rCD2Hm2LR/KOYAxXp1Fku7EPmmm1violL9FeGBhI2xVZRhc=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr6383345yba.510.1614367088721;
 Fri, 26 Feb 2021 11:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20210226051305.3428235-1-yhs@fb.com> <20210226051318.3429592-1-yhs@fb.com>
In-Reply-To: <20210226051318.3429592-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Feb 2021 11:17:58 -0800
Message-ID: <CAEf4BzauuErwH0akKTWmvQOmoD9qw4U8EjSKU7O=0N2sqU5Y7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 11/12] selftests/bpf: add hashmap test for
 bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 9:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> A test case is added for hashmap and percpu hashmap. The test
> also exercises nested bpf_for_each_map_elem() calls like
>     bpf_prog:
>       bpf_for_each_map_elem(func1)
>     func1:
>       bpf_for_each_map_elem(func2)
>     func2:
>
>   $ ./test_progs -n 45
>   #45/1 hash_map:OK
>   #45 for_each:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/for_each.c       | 73 ++++++++++++++
>  .../bpf/progs/for_each_hash_map_elem.c        | 95 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h      | 11 +++
>  3 files changed, 179 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
>  create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/testing/selftests/bpf/prog_tests/for_each.c
> new file mode 100644
> index 000000000000..aa847cd9f71f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "for_each_hash_map_elem.skel.h"
> +
> +static unsigned int duration;
> +
> +static void test_hash_map(void)
> +{
> +       int i, err, hashmap_fd, max_entries, percpu_map_fd;
> +       struct for_each_hash_map_elem *skel;
> +       __u64 *percpu_valbuf = NULL;
> +       __u32 key, num_cpus, retval;
> +       __u64 val;
> +
> +       skel = for_each_hash_map_elem__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "for_each_hash_map_elem__open_and_load"))
> +               return;
> +
> +       hashmap_fd = bpf_map__fd(skel->maps.hashmap);
> +       max_entries = bpf_map__max_entries(skel->maps.hashmap);
> +       for (i = 0; i < max_entries; i++) {
> +               key = i;
> +               val = i + 1;
> +               err = bpf_map_update_elem(hashmap_fd, &key, &val, BPF_ANY);
> +               if (!ASSERT_OK(err, "map_update"))
> +                       goto out;
> +       }
> +
> +       num_cpus = bpf_num_possible_cpus();
> +       percpu_map_fd = bpf_map__fd(skel->maps.percpu_map);
> +       percpu_valbuf = malloc(sizeof(__u64) * num_cpus);
> +       if (!ASSERT_OK_PTR(percpu_valbuf, "percpu_valbuf"))
> +               goto out;
> +
> +       key = 1;
> +       for (i = 0; i < num_cpus; i++)
> +               percpu_valbuf[i] = i + 1;
> +       err = bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY);
> +       if (!ASSERT_OK(err, "percpu_map_update"))
> +               goto out;
> +
> +       err = bpf_prog_test_run(bpf_program__fd(skel->progs.test_pkt_access),
> +                               1, &pkt_v4, sizeof(pkt_v4), NULL, NULL,
> +                               &retval, &duration);
> +       if (CHECK(err || retval, "ipv4", "err %d errno %d retval %d\n",
> +                 err, errno, retval))
> +               goto out;
> +
> +       ASSERT_EQ(skel->bss->hashmap_output, 4, "hashmap_output");
> +       ASSERT_EQ(skel->bss->hashmap_elems, max_entries, "hashmap_elems");
> +
> +       key = 1;
> +       err = bpf_map_lookup_elem(hashmap_fd, &key, &val);
> +       ASSERT_ERR(err, "hashmap_lookup");
> +
> +       ASSERT_EQ(skel->bss->percpu_called, 1, "percpu_called");
> +       ASSERT_LT(skel->bss->cpu, num_cpus, "num_cpus");
> +       ASSERT_EQ(skel->bss->percpu_map_elems, 1, "percpu_map_elems");
> +       ASSERT_EQ(skel->bss->percpu_key, 1, "percpu_key");
> +       ASSERT_EQ(skel->bss->percpu_val, skel->bss->cpu + 1, "percpu_val");
> +       ASSERT_EQ(skel->bss->percpu_output, 100, "percpu_output");
> +out:
> +       free(percpu_valbuf);
> +       for_each_hash_map_elem__destroy(skel);
> +}
> +
> +void test_for_each(void)
> +{
> +       if (test__start_subtest("hash_map"))
> +               test_hash_map();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c b/tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
> new file mode 100644
> index 000000000000..913dd91aafff
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 3);
> +       __type(key, __u32);
> +       __type(value, __u64);
> +} hashmap SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_HASH);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, __u64);
> +} percpu_map SEC(".maps");
> +
> +struct callback_ctx {
> +       struct __sk_buff *ctx;
> +       int input;
> +       int output;
> +};
> +
> +static __u64
> +check_hash_elem(struct bpf_map *map, __u32 *key, __u64 *val,
> +               struct callback_ctx *data)
> +{
> +       struct __sk_buff *skb = data->ctx;
> +       __u32 k;
> +       __u64 v;
> +
> +       if (skb) {
> +               k = *key;
> +               v = *val;
> +               if (skb->len == 10000 && k == 10 && v == 10)
> +                       data->output = 3; /* impossible path */
> +               else
> +                       data->output = 4;
> +       } else {
> +               data->output = data->input;
> +               bpf_map_delete_elem(map, key);
> +       }
> +
> +       return 0;
> +}
> +
> +__u32 cpu = 0;
> +__u32 percpu_called = 0;
> +__u32 percpu_key = 0;
> +__u64 percpu_val = 0;
> +int percpu_output = 0;
> +
> +static __u64
> +check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val,
> +                 struct callback_ctx *unused)
> +{
> +       struct callback_ctx data;
> +
> +       percpu_called++;
> +       cpu = bpf_get_smp_processor_id();
> +       percpu_key = *key;
> +       percpu_val = *val;
> +
> +       data.ctx = 0;
> +       data.input = 100;
> +       data.output = 0;
> +       bpf_for_each_map_elem(&hashmap, check_hash_elem, &data, 0);
> +       percpu_output = data.output;
> +
> +       return 0;
> +}
> +
> +int hashmap_output = 0;
> +int hashmap_elems = 0;
> +int percpu_map_elems = 0;
> +
> +SEC("classifier")
> +int test_pkt_access(struct __sk_buff *skb)
> +{
> +       struct callback_ctx data;
> +
> +       data.ctx = skb;
> +       data.input = 10;
> +       data.output = 0;
> +       hashmap_elems = bpf_for_each_map_elem(&hashmap, check_hash_elem, &data, 0);
> +       hashmap_output = data.output;
> +
> +       percpu_map_elems = bpf_for_each_map_elem(&percpu_map, check_percpu_elem,
> +                                                (void *)0, 0);
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index f7c2fd89d01a..e87c8546230e 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -152,6 +152,17 @@ extern int test__join_cgroup(const char *path);
>         ___ok;                                                          \
>  })
>
> +#define ASSERT_LT(actual, expected, name) ({                           \
> +       static int duration = 0;                                        \
> +       typeof(actual) ___act = (actual);                               \
> +       typeof(expected) ___exp = (expected);                           \
> +       bool ___ok = ___act < ___exp;                                   \
> +       CHECK(!___ok, (name),                                           \
> +             "unexpected %s: actual %lld >= expected %lld\n",          \
> +             (name), (long long)(___act), (long long)(___exp));        \
> +       ___ok;                                                          \
> +})

Thanks for adding it!

> +
>  #define ASSERT_STREQ(actual, expected, name) ({                                \
>         static int duration = 0;                                        \
>         const char *___act = actual;                                    \
> --
> 2.24.1
>
