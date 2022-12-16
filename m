Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42CC64E98C
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLPKgx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 05:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLPKgw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 05:36:52 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F4932B9C
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 02:36:51 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a17so885187wrt.11
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 02:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vQrcKJFU1s7wrtXw0lMfVXCx3MSwWI1A8HhPED3dOdc=;
        b=PDGxCKiCzop1tvudC0hSQfc0wyEo8pfRMIou4EqfQ5Qkk/hCLa3W+7irPHWqmo2pJS
         8XwsDgxZssGgwY78X8VihbXHP7cnXmydzlGaeGcnGM9ydL5MFAwoJem/MyVrAB0L35Co
         /kj9ShOQayPzmqWDH2wM7TBa7ytEqn1G47+xhggqC7UZe2TvcooCjX1RP7XBysgIPaCG
         Mhr/4yVKmTMNnV41hfrK7+xN4w0rYyfGuacgxJVmrFmaAH3WWPg7+lAPQP9kK8tcGYGb
         eJsiEB/TDE1JvNlySckQCHV4NYAqX6e13wUvI9xJZOx82nGbPMgzd4cJmBhf/4R3Ct5y
         HXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQrcKJFU1s7wrtXw0lMfVXCx3MSwWI1A8HhPED3dOdc=;
        b=uT/1vaBhJ59SDqcVaQRki68k65XnTkz6GQxprp7y9dXJmMbqpkhg2u8vpnMU1LeQnA
         LqSdSIaFHJ6OjyfeCd5OF6qBRl3h0whDzOkVov+DW+7dTNAgNC5KI6aO+EwXK95jwfCl
         E2T1yFUvb9SHbgpHNtsl7W+WvWfyt/BO7tH7d3duEvNT4QzYp5gKZADffLtXvjdxyz/2
         asTrcN7O2UOWKotz2AHRy6YQXLgnsHy8x0ipDlmjaiXUszQ3voCJhu05iX03KoBWN2aR
         Bg2qIWReuLBiELjNXkUuofmFwO05Sock8QJSEKllV+HakNAa2WmvKqWN7n8bQP0KXhtk
         OS/w==
X-Gm-Message-State: ANoB5pm06zmzw8C+cGaAqEi51jM6xqeg4qMUItJzLW+F7o/dF+FLFLI7
        p51JKlr8KCGIXeXGkTX+SglzGCY7k9sitO+bvVQ=
X-Google-Smtp-Source: AA0mqf68ZDHay2PQj5Xd/lf4pvs+VUSgDaLfT+H8EEpd1Fw46qmfbq7DxnYwKK1Z1I1iukIHbm+ZhA7HcfSDZ4dR53c=
X-Received: by 2002:a5d:4592:0:b0:242:5675:5a0d with SMTP id
 p18-20020a5d4592000000b0024256755a0dmr13207752wrq.199.1671187009867; Fri, 16
 Dec 2022 02:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
 <20221214103857.69082-2-xiangxia.m.yue@gmail.com> <73b9ef21-de67-e421-378a-1814ffbc263f@meta.com>
In-Reply-To: <73b9ef21-de67-e421-378a-1814ffbc263f@meta.com>
From:   Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date:   Fri, 16 Dec 2022 18:36:13 +0800
Message-ID: <CAMDZJNUef_1aBCGoGkC5FpP3MvD-SciYn1jQ7Kkmcwk-gkzDKw@mail.gmail.com>
Subject: Re: [bpf-next 2/2] selftests/bpf: add test cases for htab map
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 16, 2022 at 12:10 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 12/14/22 2:38 AM, xiangxia.m.yue@gmail.com wrote:
> > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >
> > This testing show how to reproduce deadlock in special case.
> >
> > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Hou Tao <houtao1@huawei.com>
> > ---
> >   .../selftests/bpf/prog_tests/htab_deadlock.c  | 74 +++++++++++++++++++
> >   .../selftests/bpf/progs/htab_deadlock.c       | 30 ++++++++
> >   2 files changed, 104 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> > new file mode 100644
> > index 000000000000..7dce4c2fe4f5
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 DiDi Global Inc. */
> > +#define _GNU_SOURCE
> > +#include <pthread.h>
> > +#include <sched.h>
> > +#include <test_progs.h>
> > +
> > +#include "htab_deadlock.skel.h"
> > +
> > +static int perf_event_open(void)
> > +{
> > +     struct perf_event_attr attr = {0};
> > +     int pfd;
> > +
> > +     /* create perf event */
> > +     attr.size = sizeof(attr);
> > +     attr.type = PERF_TYPE_HARDWARE;
> > +     attr.config = PERF_COUNT_HW_CPU_CYCLES;
> > +     attr.freq = 1;
> > +     attr.sample_freq = 1000;
> > +     pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
> > +
> > +     return pfd >= 0 ? pfd : -errno;
> > +}
> > +
> > +void test_htab_deadlock(void)
> > +{
> > +     unsigned int val = 0, key = 20;
> > +     struct bpf_link *link = NULL;
> > +     struct htab_deadlock *skel;
> > +     cpu_set_t cpus;
> > +     int err;
> > +     int pfd;
> > +     int i;
>
> No need to have three lines for type 'int' variables. One line
> is enough to hold all three variables.
>
> > +
> > +     skel = htab_deadlock__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> > +             return;
> > +
> > +     err = htab_deadlock__attach(skel);
> > +     if (!ASSERT_OK(err, "skel_attach"))
> > +             goto clean_skel;
> > +
> > +     /* NMI events. */
> > +     pfd = perf_event_open();
> > +     if (pfd < 0) {
> > +             if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
> > +                     printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
> > +                     test__skip();
> > +                     goto clean_skel;
> > +             }
> > +             if (!ASSERT_GE(pfd, 0, "perf_event_open"))
> > +                     goto clean_skel;
> > +     }
> > +
> > +     link = bpf_program__attach_perf_event(skel->progs.bpf_perf_event, pfd);
> > +     if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> > +             goto clean_pfd;
> > +
> > +     /* Pinned on CPU 0 */
> > +     CPU_ZERO(&cpus);
> > +     CPU_SET(0, &cpus);
> > +     pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
> > +
> > +     for (i = 0; i < 100000; i++)
>
> Please add some comments in the above loop to mention the test
> expects (hopefully) duriing one of bpf_map_update_elem(), one
> perf event might kick to trigger prog bpf_nmi_handle run.
>
> > +             bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
> > +                                 &key, &val, BPF_ANY);
> > +
> > +     bpf_link__destroy(link);
> > +clean_pfd:
> > +     close(pfd);
> > +clean_skel:
> > +     htab_deadlock__destroy(skel);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> > new file mode 100644
> > index 000000000000..c4bd1567f882
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2022 DiDi Global Inc. */
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(max_entries, 2);
> > +     __uint(map_flags, BPF_F_ZERO_SEED);
> > +     __uint(key_size, sizeof(unsigned int));
> > +     __uint(value_size, sizeof(unsigned int));
> > +} htab SEC(".maps");
>
> You can use
>         __type(key, unsigned int);
>         __type(value, unsigned int);
> This is more expressive.
>
> > +
> > +SEC("fentry/nmi_handle")
> > +int bpf_nmi_handle(struct pt_regs *regs)
>
> Do we need this fentry function? Can be just put
> bpf_map_update_elem() into bpf_perf_event program?
Hi
bpf_overflow_handler will check the bpf_prog_active, and
bpf_map_update_value invokes bpf_disable_instrumentation,
so the deadlock will not occur. In fentry/nmi_handle, bpf does not
check the bpf_prog_active.

Other comments look good to me, I will send v2 soon.
> Also s390x and aarch64 failed the test due to none/incomplete trampoline
> support. See bpf ci https://github.com/kernel-patches/bpf/pull/4211.
> You need to add them in their corresponding deny list if this fentry
> bpf program is used.
>
> > +{
> > +     unsigned int val = 0, key = 4;
> > +
> > +     bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
> > +     return 0;
> > +}
> > +
> > +SEC("perf_event")
> > +int bpf_perf_event(struct pt_regs *regs)
> > +{
> > +     return 0;
> > +}



-- 
Best regards, Tonghao
