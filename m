Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACABF65B96D
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 03:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjACClE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Jan 2023 21:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjACClC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Jan 2023 21:41:02 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0885FE6
        for <bpf@vger.kernel.org>; Mon,  2 Jan 2023 18:40:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs20so25903456wrb.3
        for <bpf@vger.kernel.org>; Mon, 02 Jan 2023 18:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eBc4c2ZZnBlcyWGy6xA3STh4MCbq3afCJLcnMJKUb74=;
        b=YveUjU1TN51kPgduh4G5OIlzVnF58HsIuVsKLNrCahxFNywGz3GiIJOm3w8NCXSMw5
         vWNVUA+Ff1PXmskvcJFoWwHczAQ12VxeoVtNBsOX25iwnQRuwoaUoiPSFisoAM9bYnGV
         4Lqr3IFa+3ylS4J5N8sb9evxULjYM33sZ/8cWj4cyqvITuNjRqfrgRGM/NUmnTsB2FfP
         OK1zh6v8KbL+KV3wF/o6bf6ZyL9UXBDei3sVKMvaxJ7/aqqUi346DT2jY7ahwf1YeGRv
         03OY8paj0fQB74MCuIm+nY69732yYipN9E7Jjy9wUsmg1ntaPYCNk0sCIoRSy1tDv4RI
         gsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBc4c2ZZnBlcyWGy6xA3STh4MCbq3afCJLcnMJKUb74=;
        b=KML25CANqHsFC3FWvmcFdSP/z2bq/w6r1MrFwze3J5fo5fJf3oFYj/7CO+YnARKvRm
         /YZCvpiECgetUtWub1+IJ05VO7rb+BcL9YS+6tRFIpKNXvf1FXT+lfI8Vdi3dPP+vPLK
         ncDZ0fFD3mZxWGOcUznVt98hasBDFDrsv1y277ZkR35uEHz8MsUoLf6U6fYHyHzsJm6i
         AoKoiTXy3bXJR3J9cbWHybhs9i4kjwI9Zjq4hFdBew6N9brEvmuVj696oT8bfUitfBZk
         ewiU+uCAbKSabe3BoYIEn3hEp7ICG3I9h2y1YhLtNHjLL+vv3B+rqR8eF/CAW1x1nuDg
         cmqw==
X-Gm-Message-State: AFqh2kpFPpuYTCMzAnyF/6mEy5LVeS6BMbnYhIgjaeM8ngu/1CRV3pRX
        bxmFdwXd26u9Wepg4N3/x8rvikypdbby1HbURLE=
X-Google-Smtp-Source: AMrXdXv0T8ccM4iFMzW882qs079XmaZFPfwQgwrTEfVBvTJhBdE2n5y/e8DyAK2kC4KbwkhpVqlcXsP616TwPPRk+58=
X-Received: by 2002:adf:f64e:0:b0:242:5675:5a0d with SMTP id
 x14-20020adff64e000000b0024256755a0dmr1275722wrp.199.1672713656139; Mon, 02
 Jan 2023 18:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
 <20221219041551.69344-2-xiangxia.m.yue@gmail.com> <c41daf29-43b4-8924-b5af-49f287ba8cdc@meta.com>
 <CAADnVQLE+M0xEK+L8Tu7fqsjFxNFdEyFvR4q3U1f1N1tomZ2bQ@mail.gmail.com> <ac540d41-4ac3-4d70-39e8-722e3fb360cd@meta.com>
In-Reply-To: <ac540d41-4ac3-4d70-39e8-722e3fb360cd@meta.com>
From:   Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date:   Tue, 3 Jan 2023 10:40:18 +0800
Message-ID: <CAMDZJNV_J-LmxxzX5DMGHQLm6WyYqG2GAMHb=WZvBG_y1rUOYg@mail.gmail.com>
Subject: Re: [bpf-next v3 2/2] selftests/bpf: add test case for htab map
To:     Yonghong Song <yhs@meta.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

 a

On Thu, Dec 29, 2022 at 2:29 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 12/28/22 2:24 PM, Alexei Starovoitov wrote:
> > On Tue, Dec 27, 2022 at 8:43 PM Yonghong Song <yhs@meta.com> wrote:
> >>
> >>
> >>
> >> On 12/18/22 8:15 PM, xiangxia.m.yue@gmail.com wrote:
> >>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >>>
> >>> This testing show how to reproduce deadlock in special case.
> >>> We update htab map in Task and NMI context. Task can be interrupted by
> >>> NMI, if the same map bucket was locked, there will be a deadlock.
> >>>
> >>> * map max_entries is 2.
> >>> * NMI using key 4 and Task context using key 20.
> >>> * so same bucket index but map_locked index is different.
> >>>
> >>> The selftest use perf to produce the NMI and fentry nmi_handle.
> >>> Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
> >>> map syscall increase this counter in bpf_disable_instrumentation.
> >>> Then fentry nmi_handle and update hash map will reproduce the issue.
> >>>
> >>> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >>> Cc: Alexei Starovoitov <ast@kernel.org>
> >>> Cc: Daniel Borkmann <daniel@iogearbox.net>
> >>> Cc: Andrii Nakryiko <andrii@kernel.org>
> >>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> >>> Cc: Song Liu <song@kernel.org>
> >>> Cc: Yonghong Song <yhs@fb.com>
> >>> Cc: John Fastabend <john.fastabend@gmail.com>
> >>> Cc: KP Singh <kpsingh@kernel.org>
> >>> Cc: Stanislav Fomichev <sdf@google.com>
> >>> Cc: Hao Luo <haoluo@google.com>
> >>> Cc: Jiri Olsa <jolsa@kernel.org>
> >>> Cc: Hou Tao <houtao1@huawei.com>
> >>> Acked-by: Yonghong Song <yhs@fb.com>
> >>> ---
> >>>    tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
> >>>    tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
> >>>    .../selftests/bpf/prog_tests/htab_deadlock.c  | 75 +++++++++++++++++++
> >>>    .../selftests/bpf/progs/htab_deadlock.c       | 32 ++++++++
> >>>    4 files changed, 109 insertions(+)
> >>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> >>>    create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> >>> index 99cc33c51eaa..87e8fc9c9df2 100644
> >>> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> >>> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> >>> @@ -24,6 +24,7 @@ fexit_test                                       # fexit_attach unexpected error
> >>>    get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
> >>>    get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
> >>>    htab_update/reenter_update
> >>> +htab_deadlock                                    # failed to find kernel BTF type ID of 'nmi_handle': -3 (trampoline)
> >>>    kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
> >>>    kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
> >>>    kfunc_call/subprog_lskel                         # skel unexpected error: -2
> >>> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> >>> index 585fcf73c731..735239b31050 100644
> >>> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> >>> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> >>> @@ -26,6 +26,7 @@ get_func_args_test                   # trampoline
> >>>    get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
> >>>    get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
> >>>    htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
> >>> +htab_deadlock                            # failed to find kernel BTF type ID of 'nmi_handle': -3                       (trampoline)
> >>>    kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
> >>>    kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
> >>>    kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> >>> new file mode 100644
> >>> index 000000000000..137dce8f1346
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> >>> @@ -0,0 +1,75 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/* Copyright (c) 2022 DiDi Global Inc. */
> >>> +#define _GNU_SOURCE
> >>> +#include <pthread.h>
> >>> +#include <sched.h>
> >>> +#include <test_progs.h>
> >>> +
> >>> +#include "htab_deadlock.skel.h"
> >>> +
> >>> +static int perf_event_open(void)
> >>> +{
> >>> +     struct perf_event_attr attr = {0};
> >>> +     int pfd;
> >>> +
> >>> +     /* create perf event on CPU 0 */
> >>> +     attr.size = sizeof(attr);
> >>> +     attr.type = PERF_TYPE_HARDWARE;
> >>> +     attr.config = PERF_COUNT_HW_CPU_CYCLES;
> >>> +     attr.freq = 1;
> >>> +     attr.sample_freq = 1000;
> >>> +     pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
> >>> +
> >>> +     return pfd >= 0 ? pfd : -errno;
> >>> +}
> >>> +
> >>> +void test_htab_deadlock(void)
> >>> +{
> >>> +     unsigned int val = 0, key = 20;
> >>> +     struct bpf_link *link = NULL;
> >>> +     struct htab_deadlock *skel;
> >>> +     int err, i, pfd;
> >>> +     cpu_set_t cpus;
> >>> +
> >>> +     skel = htab_deadlock__open_and_load();
> >>> +     if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> >>> +             return;
> >>> +
> >>> +     err = htab_deadlock__attach(skel);
> >>> +     if (!ASSERT_OK(err, "skel_attach"))
> >>> +             goto clean_skel;
> >>> +
> >>> +     /* NMI events. */
> >>> +     pfd = perf_event_open();
> >>> +     if (pfd < 0) {
> >>> +             if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
> >>> +                     printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
> >>> +                     test__skip();
> >>> +                     goto clean_skel;
> >>> +             }
> >>> +             if (!ASSERT_GE(pfd, 0, "perf_event_open"))
> >>> +                     goto clean_skel;
> >>> +     }
> >>> +
> >>> +     link = bpf_program__attach_perf_event(skel->progs.bpf_empty, pfd);
> >>> +     if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> >>> +             goto clean_pfd;
> >>> +
> >>> +     /* Pinned on CPU 0 */
> >>> +     CPU_ZERO(&cpus);
> >>> +     CPU_SET(0, &cpus);
> >>> +     pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
> >>> +
> >>> +     /* update bpf map concurrently on CPU0 in NMI and Task context.
> >>> +      * there should be no kernel deadlock.
> >>> +      */
> >>> +     for (i = 0; i < 100000; i++)
> >>> +             bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
> >>> +                                 &key, &val, BPF_ANY);
> >>> +
> >>> +     bpf_link__destroy(link);
> >>> +clean_pfd:
> >>> +     close(pfd);
> >>> +clean_skel:
> >>> +     htab_deadlock__destroy(skel);
> >>> +}
> >>> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> >>> new file mode 100644
> >>> index 000000000000..d394f95e97c3
> >>> --- /dev/null
> >>> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> >>> @@ -0,0 +1,32 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/* Copyright (c) 2022 DiDi Global Inc. */
> >>> +#include <linux/bpf.h>
> >>> +#include <bpf/bpf_helpers.h>
> >>> +#include <bpf/bpf_tracing.h>
> >>> +
> >>> +char _license[] SEC("license") = "GPL";
> >>> +
> >>> +struct {
> >>> +     __uint(type, BPF_MAP_TYPE_HASH);
> >>> +     __uint(max_entries, 2);
> >>> +     __uint(map_flags, BPF_F_ZERO_SEED);
> >>> +     __type(key, unsigned int);
> >>> +     __type(value, unsigned int);
> >>> +} htab SEC(".maps");
> >>> +
> >>> +/* nmi_handle on x86 platform. If changing keyword
> >>> + * "static" to "inline", this prog load failed. */
> >>> +SEC("fentry/nmi_handle")
> >>
> >> The above comment is not what I mean. In arch/x86/kernel/nmi.c,
> >> we have
> >>     static int nmi_handle(unsigned int type, struct pt_regs *regs)
> >>     {
> >>          ...
> >>     }
> >>     ...
> >>     static noinstr void default_do_nmi(struct pt_regs *regs)
> >>     {
> >>          ...
> >>          handled = nmi_handle(NMI_LOCAL, regs);
> >>          ...
> >>     }
> >>
> >> Since nmi_handle is a static function, it is possible that
> >> the function might be inlined in default_do_nmi by the
> >> compiler. If this happens, fentry/nmi_handle will not
> >> be triggered and the test will pass.
> >>
> >> So I suggest to change the comment to
> >>     nmi_handle() is a static function and might be
> >>     inlined into its caller. If this happens, the
> >>     test can still pass without previous kernel fix.
> >
> > It's worse than this.
> > fentry is buggy.
> > We shouldn't allow attaching fentry to:
> > NOKPROBE_SYMBOL(nmi_handle);
>
> Okay, I see. Looks we should prevent fentry from
> attaching any NOKPROBE_SYMBOL functions.
>
> BTW, I think fentry/nmi_handle can be replaced with
> tracepoint nmi/nmi_handler. it is more reliable
The tracepoint will not reproduce the deadlock(we have discussed v2).
If it's not easy to complete a test for this case, should we drop this
testcase patch? or fentry the nmi_handle and update the comments.
> and won't be impacted by potential NOKPROBE_SYMBOL
> issues.



-- 
Best regards, Tonghao
