Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B3E5A4013
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 00:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiH1WkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 18:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1Wj7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 18:39:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA21BF44
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 15:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15172B80A75
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 22:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1087C43146
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 22:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661726393;
        bh=YyLL66oa2xi2Jn+IQyFv6wsG+Mz/VnRLQqcNbi9brgA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oZ7tBaVNN4iVRqrikBsvRauJ7mdyFCK7WYpMdss3PaMvdmsd5D1DHSaInHFLDAbei
         MPcAcW+H3Mo4j807j91RXP+enR3wchq3AQgcF+Lq6OJXd6bCyK8WMHVdVExP9awWUS
         PyzzCnZeFQc4Ttohh6raE7iZnHOUn40As2hpTg8XE/95ew3IX3hWePE6uTJnLi+t/+
         D9ITz/MTFzXe+dMddFFT1leNnSiQj+SxU4aFOyhGNNKxZz7p0v6O0Dx7nle0R+YvH0
         qFwOFkIVy7NR8gtmqmb6X6OJJPhy+yKxTLqYuSlMXO3BRj6+7iKCZmeHLBB0xYL+UB
         td9XsVWuqdxlQ==
Received: by mail-qv1-f41.google.com with SMTP id j1so5131783qvv.8
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 15:39:53 -0700 (PDT)
X-Gm-Message-State: ACgBeo3X/AITVbFAuewdem6FbWFpGmMHyxyBxHg/N5yPDWsGtih2lJt8
        3hD+qS4VIvvPb8yoWHFev7LLtl4D5PDVy3OqMLNaTw==
X-Google-Smtp-Source: AA6agR6HxkCqZ1XCzZj//x7TLvgLXSQl3PSloetP7+AOd0I0mvijvORCBYf0kdSN0C7U+PN2wlCiFePtMvmVJu1f7Sw=
X-Received: by 2002:a05:6214:e64:b0:497:1320:fd6 with SMTP id
 jz4-20020a0562140e6400b0049713200fd6mr8676933qvb.73.1661726392497; Sun, 28
 Aug 2022 15:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220827100134.1621137-1-houtao@huaweicloud.com> <20220827100134.1621137-3-houtao@huaweicloud.com>
In-Reply-To: <20220827100134.1621137-3-houtao@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 29 Aug 2022 00:39:41 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6aAFvWuR4ozqAQjO2bDPQMsDX+q6fMxq64Xk7ZaKA51g@mail.gmail.com>
Message-ID: <CACYkzJ6aAFvWuR4ozqAQjO2bDPQMsDX+q6fMxq64Xk7ZaKA51g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: add test cases for htab update
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 27, 2022 at 11:43 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> One test demonstrates the reentrancy of hash map update fails, and
> another one shows concureently updates of the same hash map bucket

"concurrent updates of the same hashmap"

This is just a description of what the test does but not why?

What's the expected behaviour? Was it broken?

I think your whole series will benefit from a cover letter to explain
the stuff you are fixing.

> succeed.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  .../selftests/bpf/prog_tests/htab_update.c    | 126 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/htab_update.c |  29 ++++
>  2 files changed, 155 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_update.c
>  create mode 100644 tools/testing/selftests/bpf/progs/htab_update.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> new file mode 100644
> index 000000000000..e2a4034daa79
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <test_progs.h>
> +#include "htab_update.skel.h"
> +
> +struct htab_update_ctx {
> +       int fd;
> +       int loop;
> +       bool stop;
> +};
> +
> +static void test_reenter_update(void)
> +{
> +       struct htab_update *skel;
> +       unsigned int key, value;
> +       int err;
> +
> +       skel = htab_update__open();
> +       if (!ASSERT_OK_PTR(skel, "htab_update__open"))
> +               return;
> +
> +       /* lookup_elem_raw() may be inlined and find_kernel_btf_id() will return -ESRCH */
> +       bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
> +       err = htab_update__load(skel);
> +       if (!ASSERT_TRUE(!err || err == -ESRCH, "htab_update__load") || err)
> +               goto out;
> +
> +       skel->bss->pid = getpid();
> +       err = htab_update__attach(skel);
> +       if (!ASSERT_OK(err, "htab_update__attach"))
> +               goto out;
> +
> +       /* Will trigger the reentrancy of bpf_map_update_elem() */
> +       key = 0;
> +       value = 0;

nit: just move these initializations to the top.

> +       err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, 0);
> +       if (!ASSERT_OK(err, "add element"))
> +               goto out;
> +
> +       ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> +out:
> +       htab_update__destroy(skel);
> +}
> +
> +static void *htab_update_thread(void *arg)
> +{
> +       struct htab_update_ctx *ctx = arg;
> +       cpu_set_t cpus;
> +       int i;
> +
> +       /* Pin on CPU 0 */
> +       CPU_ZERO(&cpus);
> +       CPU_SET(0, &cpus);
> +       pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
> +
> +       i = 0;
> +       while (i++ < ctx->loop && !ctx->stop) {

nit: for loop?


> +               unsigned int key = 0, value = 0;
> +               int err;
> +
> +               err = bpf_map_update_elem(ctx->fd, &key, &value, 0);
> +               if (err) {
> +                       ctx->stop = true;
> +                       return (void *)(long)err;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static void test_concurrent_update(void)
> +{
> +       struct htab_update_ctx ctx;
> +       struct htab_update *skel;
> +       unsigned int i, nr;
> +       pthread_t *tids;
> +       int err;
> +
> +       skel = htab_update__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "htab_update__open_and_load"))
> +               return;
> +
> +       ctx.fd = bpf_map__fd(skel->maps.htab);
> +       ctx.loop = 1000;
> +       ctx.stop = false;
> +
> +       nr = 4;
> +       tids = calloc(nr, sizeof(*tids));
> +       if (!ASSERT_NEQ(tids, NULL, "no mem"))
> +               goto out;
> +
> +       for (i = 0; i < nr; i++) {
> +               err = pthread_create(&tids[i], NULL, htab_update_thread, &ctx);
> +               if (!ASSERT_OK(err, "pthread_create")) {
> +                       unsigned int j;
> +
> +                       ctx.stop = true;
> +                       for (j = 0; j < i; j++)
> +                               pthread_join(tids[j], NULL);
> +                       goto out;
> +               }
> +       }
> +
> +       for (i = 0; i < nr; i++) {
> +               void *thread_err = NULL;
> +
> +               pthread_join(tids[i], &thread_err);
> +               ASSERT_EQ(thread_err, NULL, "update error");
> +       }
> +
> +out:
> +       if (tids)
> +               free(tids);
> +       htab_update__destroy(skel);
> +}
> +
> +void test_htab_update(void)
> +{
> +       if (test__start_subtest("reenter_update"))
> +               test_reenter_update();
> +       if (test__start_subtest("concurrent_update"))
> +               test_concurrent_update();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/htab_update.c b/tools/testing/selftests/bpf/progs/htab_update.c
> new file mode 100644
> index 000000000000..7481bb30b29b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/htab_update.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 1);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(__u32));
> +} htab SEC(".maps");
> +
> +int pid = 0;
> +int update_err = 0;
> +
> +SEC("?fentry/lookup_elem_raw")
> +int lookup_elem_raw(void *ctx)
> +{
> +       __u32 key = 0, value = 1;
> +
> +       if ((bpf_get_current_pid_tgid() >> 32) != pid)
> +               return 0;
> +
> +       update_err = bpf_map_update_elem(&htab, &key, &value, 0);
> +       return 0;
> +}
> --
> 2.29.2
>
