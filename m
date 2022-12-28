Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A8365874B
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 23:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiL1WYh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 17:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1WYh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 17:24:37 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C334B13D16
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 14:24:35 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id t17so41204400eju.1
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 14:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XdQxvOsqDDc9pEDlZev6zckaGTFHTXE//1eMp1iazwo=;
        b=WxusQWekdX2jm23oJWPCIgy1p4oM3Z7OrMges1aqyM7IS/QuqYk2nmM3nQ22obkldJ
         7eSrhEndweVw485Rn7nOw4E0Gv8IY0WbnkT50B6S8S0Eboq/nHvTWBlDKbpIc0id3TyE
         8H8YgL+ZXf0rSNi9j805WGsfOnBiDMCPZCq8PMIUuf/WcMyteijApcUajBtczzGZFu+Z
         bI6U5YFPZLtRXEShKIppnlqQwyT2IiHFwpy3CEf48iASK/0Hd1JzFu/T7d3yENOCrCf+
         QnYj6hkbt+v6FVN63GINORCRvEYAuZPT8owFBUrqIA903vDPtRpZcxGlgJcpGROG4X2M
         TUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdQxvOsqDDc9pEDlZev6zckaGTFHTXE//1eMp1iazwo=;
        b=ORsyP4IgNnxV27lUNm99JSg0qfb/gs7zyscFVNZ+e7eTqJFiLEYJ1axreBMY0WhEXU
         luCFMjyuCzxeyrpsgltM963kz/u2GoBZ9Z86Yz/b+SAt1vT5qKQlwypW2Y43+MC1Y619
         QtrKnHVH7yrCTMNbO1hXSkCh1ilcbxQTn6RF7LlYqLQjjWN/4xv/E1rFUtT6ymPYZOqE
         H5L07jJO4Teu3h20C7z7Ux0P9/T7A0cisW+9WlRBrvflBsF5MfpUrrCGkwGRhH7/pa9p
         B2nrg4HC2Ze89BfKSx7SEWiv60UYhFTHY9hA/hY/JT8woG8dGOFvV3InTMdZKCCDm9Lq
         xrwA==
X-Gm-Message-State: AFqh2krAcLi/WCpwunG0anKCpk8bmSqpCvgLO7TAd7Kvh6IaEvaRkhZG
        bFBsby13yaCvyMixfvQJzwmKXsgUC5iLdghfkjM=
X-Google-Smtp-Source: AMrXdXsLOtBQMcCaaKmQG/6vwkClpEbcHdZGpxGHNcYmkOTIYYVzdKPdg8BsTSh0AexSUJUrlFCqAKNXy4SV8JwRIkQ=
X-Received: by 2002:a17:906:f157:b0:7c0:8b4c:e30f with SMTP id
 gw23-20020a170906f15700b007c08b4ce30fmr3299359ejb.502.1672266274196; Wed, 28
 Dec 2022 14:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
 <20221219041551.69344-2-xiangxia.m.yue@gmail.com> <c41daf29-43b4-8924-b5af-49f287ba8cdc@meta.com>
In-Reply-To: <c41daf29-43b4-8924-b5af-49f287ba8cdc@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 28 Dec 2022 14:24:22 -0800
Message-ID: <CAADnVQLE+M0xEK+L8Tu7fqsjFxNFdEyFvR4q3U1f1N1tomZ2bQ@mail.gmail.com>
Subject: Re: [bpf-next v3 2/2] selftests/bpf: add test case for htab map
To:     Yonghong Song <yhs@meta.com>
Cc:     xiangxia.m.yue@gmail.com, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Tue, Dec 27, 2022 at 8:43 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 12/18/22 8:15 PM, xiangxia.m.yue@gmail.com wrote:
> > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >
> > This testing show how to reproduce deadlock in special case.
> > We update htab map in Task and NMI context. Task can be interrupted by
> > NMI, if the same map bucket was locked, there will be a deadlock.
> >
> > * map max_entries is 2.
> > * NMI using key 4 and Task context using key 20.
> > * so same bucket index but map_locked index is different.
> >
> > The selftest use perf to produce the NMI and fentry nmi_handle.
> > Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
> > map syscall increase this counter in bpf_disable_instrumentation.
> > Then fentry nmi_handle and update hash map will reproduce the issue.
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
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> >   tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
> >   tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
> >   .../selftests/bpf/prog_tests/htab_deadlock.c  | 75 +++++++++++++++++++
> >   .../selftests/bpf/progs/htab_deadlock.c       | 32 ++++++++
> >   4 files changed, 109 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > index 99cc33c51eaa..87e8fc9c9df2 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -24,6 +24,7 @@ fexit_test                                       # fexit_attach unexpected error
> >   get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
> >   get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
> >   htab_update/reenter_update
> > +htab_deadlock                                    # failed to find kernel BTF type ID of 'nmi_handle': -3 (trampoline)
> >   kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
> >   kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
> >   kfunc_call/subprog_lskel                         # skel unexpected error: -2
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> > index 585fcf73c731..735239b31050 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > @@ -26,6 +26,7 @@ get_func_args_test                   # trampoline
> >   get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
> >   get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
> >   htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
> > +htab_deadlock                            # failed to find kernel BTF type ID of 'nmi_handle': -3                       (trampoline)
> >   kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
> >   kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
> >   kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> > new file mode 100644
> > index 000000000000..137dce8f1346
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> > @@ -0,0 +1,75 @@
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
> > +     /* create perf event on CPU 0 */
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
> > +     int err, i, pfd;
> > +     cpu_set_t cpus;
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
> > +     link = bpf_program__attach_perf_event(skel->progs.bpf_empty, pfd);
> > +     if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> > +             goto clean_pfd;
> > +
> > +     /* Pinned on CPU 0 */
> > +     CPU_ZERO(&cpus);
> > +     CPU_SET(0, &cpus);
> > +     pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
> > +
> > +     /* update bpf map concurrently on CPU0 in NMI and Task context.
> > +      * there should be no kernel deadlock.
> > +      */
> > +     for (i = 0; i < 100000; i++)
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
> > index 000000000000..d394f95e97c3
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> > @@ -0,0 +1,32 @@
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
> > +     __type(key, unsigned int);
> > +     __type(value, unsigned int);
> > +} htab SEC(".maps");
> > +
> > +/* nmi_handle on x86 platform. If changing keyword
> > + * "static" to "inline", this prog load failed. */
> > +SEC("fentry/nmi_handle")
>
> The above comment is not what I mean. In arch/x86/kernel/nmi.c,
> we have
>    static int nmi_handle(unsigned int type, struct pt_regs *regs)
>    {
>         ...
>    }
>    ...
>    static noinstr void default_do_nmi(struct pt_regs *regs)
>    {
>         ...
>         handled = nmi_handle(NMI_LOCAL, regs);
>         ...
>    }
>
> Since nmi_handle is a static function, it is possible that
> the function might be inlined in default_do_nmi by the
> compiler. If this happens, fentry/nmi_handle will not
> be triggered and the test will pass.
>
> So I suggest to change the comment to
>    nmi_handle() is a static function and might be
>    inlined into its caller. If this happens, the
>    test can still pass without previous kernel fix.

It's worse than this.
fentry is buggy.
We shouldn't allow attaching fentry to:
NOKPROBE_SYMBOL(nmi_handle);
