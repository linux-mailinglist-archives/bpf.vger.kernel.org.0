Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E2326A5E
	for <lists+bpf@lfdr.de>; Sat, 27 Feb 2021 00:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBZXVW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 18:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZXVV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 18:21:21 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806CCC061574
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 15:20:41 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 133so10534275ybd.5
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 15:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPmkoCSFXUhUb4FCX03qCxGgyEIxQbPmrDpp++fdpPY=;
        b=tTlVaYFvJ+tLat2oziuididg5luDkTXfCgWdFLzb1OAV5y0W/91IuqY+ijtn5N7bE9
         USCeolzTJE3IR3pcXWawxb1SlQyHrr9PkuB90jSlN6fhr5iafrqU3f/gAEY5jBkmwBIS
         KxIH/XFozJJSW90CAvUdddHAupUTAvlh7TwXPBM7My7It5j5aP3QV4tHAUxURwHB3XBg
         WQXxKhA61heiWPqLxBZwhI1IaicBLRIWicMYzolLYdgyOyaHzhZXD1a1kkDp3QikEw+Y
         fJAebR1MONntmRBBuGvwzL+pCSj1g+mYtTVCZDb8ZfWCTsL2XrhaTdxb3BcBaOv+q+FL
         gO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPmkoCSFXUhUb4FCX03qCxGgyEIxQbPmrDpp++fdpPY=;
        b=h8MoX3044KkHCiYR/ySG407n/hFpWrLjs9JAH6wbxvAUr0Cft6TiqvZqnJSFIUF58O
         VgwuQzDfsmVZbITjZ7t5ROgrH1FUSwIhV39V9c2OB/ZDUKxneEKJ1D0rJb/c+0wVdSfc
         yz2JRgE/9GMVf9LuCZFZTtzbl6XyG41/5fRRqkOY+RMMjy/VOniQUfsF9IdDmLo4WfkH
         uiDyRCoyNY8nNqrtvrs8b3XtnVEbSt8Em21S4d/YT5ys9kc2apKLG+A9lEymFjfasTpd
         9lcUOLUSPReAKhSoznMrsLRHCyxWK+RMNte2FP3x3huDIeFIjPHuUsAWYaZHCSBZzpai
         XYOA==
X-Gm-Message-State: AOAM5316X86GQ5KGY7qVkoD3oPKrrA5z5kCmBOop/tGzifK2IrEmz0aJ
        Po/kkNnZOJ1Ms7fIOrKSN+nmMTue+kZQ1MhIloIzilf8
X-Google-Smtp-Source: ABdhPJyXPeYsuc96PizO3chPaNyTJNKPZV1tzFxPgjSKpiQXS1SJz3OmtU2gVx4bVLAPLS5AeV+Po1BmNxRougijtdk=
X-Received: by 2002:a25:1e89:: with SMTP id e131mr7924862ybe.459.1614381640678;
 Fri, 26 Feb 2021 15:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20210226174800.2928132-1-yhs@fb.com> <CAEf4BzaumK2DC_dREDffQGRsVrBinZmbyp4JAESqjP3-rN51NA@mail.gmail.com>
 <e06e5bd3-a5bb-0f60-07c2-3e435707b69e@fb.com>
In-Reply-To: <e06e5bd3-a5bb-0f60-07c2-3e435707b69e@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Feb 2021 15:20:29 -0800
Message-ID: <CAEf4BzbPzG7EwsCJVOyjcr8A22mAU1apkBztLmoNcqeJ8YRdsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add a verifier scale test with
 unknown bounded loop
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        zhenwei pi <pizhenwei@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 26, 2021 at 2:31 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/26/21 1:08 PM, Andrii Nakryiko wrote:
> > On Fri, Feb 26, 2021 at 9:50 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> The orignal bcc pull request
> >>    https://github.com/iovisor/bcc/pull/3270
> >> exposed a verifier failure with Clang 12/13 while
> >> Clang 4 works fine. Further investigation exposed two issues.
> >>    Issue 1: LLVM may generate code which uses less refined
> >>       value. The issue is fixed in llvm patch
> >>       https://reviews.llvm.org/D97479
> >>    Issue 2: Spills with initial value 0 are marked as precise
> >>       which makes later state pruning less effective.
> >>       This is my rough initial analysis and further investigation
> >>       is needed to find how to improve verifier pruning
> >>       in such cases.
> >>
> >> With the above llvm patch, for the new loop6.c test, which has
> >> smaller loop bound compared to original test, I got
> >>    $ test_progs -s -n 10/16
> >>    ...
> >>    stack depth 64
> >>    processed 405099 insns (limit 1000000) max_states_per_insn 92
> >>        total_states 8866 peak_states 889 mark_read 6
> >>    #10/16 loop6.o:OK
> >>
> >> Use the original loop bound, i.e., commenting out "#define WORKAROUND",
> >> I got
> >>    $ test_progs -s -n 10/16
> >>    ...
> >>    BPF program is too large. Processed 1000001 insn
> >>    stack depth 64
> >>    processed 1000001 insns (limit 1000000) max_states_per_insn 91
> >>        total_states 23176 peak_states 5069 mark_read 6
> >>    ...
> >>    #10/16 loop6.o:FAIL
> >>
> >> The purpose of this patch is to provide a regression
> >> test for the above llvm fix and also provide a test
> >> case for further analyzing the verifier pruning issue.
> >>
> >> Cc: zhenwei pi <pizhenwei@bytedance.com>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/testing/selftests/bpf/README.rst        |  39 +++++++
> >>   .../bpf/prog_tests/bpf_verif_scale.c          |   1 +
> >>   tools/testing/selftests/bpf/progs/loop6.c     | 101 ++++++++++++++++++
> >>   3 files changed, 141 insertions(+)
> >>   create mode 100644 tools/testing/selftests/bpf/progs/loop6.c
> >>
> >> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> >> index fd148b8410fa..dbc8f6cc5c67 100644
> >> --- a/tools/testing/selftests/bpf/README.rst
> >> +++ b/tools/testing/selftests/bpf/README.rst
> >> @@ -111,6 +111,45 @@ available in 10.0.1. The patch is available in llvm 11.0.0 trunk.
> >>
> >>   __  https://reviews.llvm.org/D78466
> >>
> >> +bpf_verif_scale/loop6.o test failure with Clang 12
> >> +==================================================
> >> +
> >> +With Clang 12, the following bpf_verif_scale test failed:
> >> +  * ``bpf_verif_scale/loop6.o``
> >> +
> >> +The verifier output looks like
> >> +
> >> +.. code-block:: c
> >> +
> >> +  R1 type=ctx expected=fp
> >> +  The sequence of 8193 jumps is too complex.
> >> +
> >> +The reason is compiler generating the following code
> >> +
> >> +.. code-block:: c
> >> +
> >> +  ;       for (i = 0; (i < VIRTIO_MAX_SGS) && (i < num); i++) {
> >> +      14:       16 05 40 00 00 00 00 00 if w5 == 0 goto +64 <LBB0_6>
> >> +      15:       bc 51 00 00 00 00 00 00 w1 = w5
> >> +      16:       04 01 00 00 ff ff ff ff w1 += -1
> >> +      17:       67 05 00 00 20 00 00 00 r5 <<= 32
> >> +      18:       77 05 00 00 20 00 00 00 r5 >>= 32
> >> +      19:       a6 01 01 00 05 00 00 00 if w1 < 5 goto +1 <LBB0_4>
> >> +      20:       b7 05 00 00 06 00 00 00 r5 = 6
> >> +  00000000000000a8 <LBB0_4>:
> >> +      21:       b7 02 00 00 00 00 00 00 r2 = 0
> >> +      22:       b7 01 00 00 00 00 00 00 r1 = 0
> >> +  ;       for (i = 0; (i < VIRTIO_MAX_SGS) && (i < num); i++) {
> >> +      23:       7b 1a e0 ff 00 00 00 00 *(u64 *)(r10 - 32) = r1
> >> +      24:       7b 5a c0 ff 00 00 00 00 *(u64 *)(r10 - 64) = r5
> >> +
> >> +Note that insn #15 has w1 = w5 and w1 is refined later but
> >> +r5(w5) is eventually saved on stack at insn #24 for later use.
> >> +This cause later verifier failure. The bug has been `fixed`__ in
> >> +Clang 13.
> >> +
> >> +__  https://reviews.llvm.org/D97479
> >> +
> >>   BPF CO-RE-based tests and Clang version
> >>   =======================================
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> >> index e698ee6bb6c2..3d002c245d2b 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> >> @@ -76,6 +76,7 @@ void test_bpf_verif_scale(void)
> >>                  { "loop2.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
> >>                  { "loop4.o", BPF_PROG_TYPE_SCHED_CLS },
> >>                  { "loop5.o", BPF_PROG_TYPE_SCHED_CLS },
> >> +               { "loop6.o", BPF_PROG_TYPE_KPROBE },
> >>
> >>                  /* partial unroll. 19k insn in a loop.
> >>                   * Total program size 20.8k insn.
> >> diff --git a/tools/testing/selftests/bpf/progs/loop6.c b/tools/testing/selftests/bpf/progs/loop6.c
> >> new file mode 100644
> >> index 000000000000..fe535922bed8
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/progs/loop6.c
> >> @@ -0,0 +1,101 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include <linux/ptrace.h>
> >> +#include <stddef.h>
> >> +#include <linux/bpf.h>
> >> +#include <bpf/bpf_helpers.h>
> >> +#include <bpf/bpf_tracing.h>
> >> +
> >> +char _license[] SEC("license") = "GPL";
> >> +
> >> +/* typically virtio scsi has max SGs of 6 */
> >> +#define VIRTIO_MAX_SGS 6
> >> +
> >> +/* Verifier will fail with SG_MAX = 128. The failure can be
> >> + * workarounded with a smaller SG_MAX, e.g. 10.
> >> + */
> >> +#define WORKAROUND
> >> +#ifdef WORKAROUND
> >> +#define SG_MAX         10
> >> +#else
> >> +/* typically virtio blk has max SEG of 128 */
> >> +#define SG_MAX         128
> >> +#endif
> >> +
> >> +#define SG_CHAIN       0x01UL
> >> +#define SG_END         0x02UL
> >> +
> >> +struct scatterlist {
> >> +       unsigned long   page_link;
> >> +       unsigned int    offset;
> >> +       unsigned int    length;
> >> +};
> >> +
> >> +#define sg_is_chain(sg)                ((sg)->page_link & SG_CHAIN)
> >> +#define sg_is_last(sg)         ((sg)->page_link & SG_END)
> >> +#define sg_chain_ptr(sg)       \
> >> +       ((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
> >> +
> >> +static inline struct scatterlist *__sg_next(struct scatterlist *sgp)
> >
> > nit: here and below, it doesn't have to be inline, does it?
>
> I will keep inline here. With __noinline, current loop6.c failed
> at verifier:
>    BPF program is too large. Processed 1000001 insn
> This may be another issue we need to investigate later.
>

sure, no worries. At least we learned something new :)

> >
> >> +{
> >> +       struct scatterlist sg;
> >> +
> >> +       bpf_probe_read_kernel(&sg, sizeof(sg), sgp);
> >> +       if (sg_is_last(&sg))
> >> +               return NULL;
> >> +
> >> +       sgp++;
> >> +
> >> +       bpf_probe_read_kernel(&sg, sizeof(sg), sgp);
> >> +       if (sg_is_chain(&sg))
> >> +               sgp = sg_chain_ptr(&sg);
> >> +
> >> +       return sgp;
> >> +}
> >> +
> >> +static inline struct scatterlist *get_sgp(struct scatterlist **sgs, int i)
> >> +{
> >> +       struct scatterlist *sgp;
> >> +
> >> +       bpf_probe_read_kernel(&sgp, sizeof(sgp), sgs + i);
> >> +       return sgp;
> >> +}
> >> +
> >> +int config = 0;
> >> +int result = 0;
> >> +
> >> +SEC("kprobe/virtqueue_add_sgs")
> >> +int nested_loops(volatile struct pt_regs* ctx)
> >
> > libbpf provides BPF_KPROBE macro, similar to BPF_PROG for
> > fentry/fexit. Can you please use that instead? You won't need
> > PT_REGS_PARM macroses below, which will lead to nicer and shorter
> > code.
>
> Sure. Will use. Indeed better.
>
> >
> >> +{
> >> +       struct scatterlist **sgs = PT_REGS_PARM2(ctx);
> >> +       unsigned int num1 = PT_REGS_PARM3(ctx);
> >> +       unsigned int num2 = PT_REGS_PARM4(ctx);
> >> +       struct scatterlist *sgp = NULL;
> >> +       __u64 length1 = 0, length2 = 0;
> >> +       unsigned int i, n, len;
> >> +
> >> +       if (config != 0)
> >> +               return 0;
> >> +
> >> +       for (i = 0; (i < VIRTIO_MAX_SGS) && (i < num1); i++) {
> >> +               for (n = 0, sgp = get_sgp(sgs, i); sgp && (n < SG_MAX);
> >> +                    sgp = __sg_next(sgp)) {
> >> +                       bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
> >> +                       length1 += len;
> >> +                       n++;
> >> +               }
> >> +       }
> >> +
> >> +       for (i = 0; (i < VIRTIO_MAX_SGS) && (i < num2); i++) {
> >> +               for (n = 0, sgp = get_sgp(sgs, i); sgp && (n < SG_MAX);
> >> +                    sgp = __sg_next(sgp)) {
> >> +                       bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
> >> +                       length2 += len;
> >> +                       n++;
> >> +               }
> >> +       }
> >> +
> >> +       config = 1;
> >> +       result = length2 - length1;
> >> +       return 0;
> >> +}
> >> --
> >> 2.24.1
> >>
