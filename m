Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC87C65D5BA
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 15:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbjADOdA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 09:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbjADOcr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 09:32:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D728637533
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 06:32:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bn26so13696048wrb.0
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 06:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3YqrE2THxqluakJiX4FbxNBBk15XXMhZz6zppelXSlA=;
        b=Mxv/hg71BxBqapN6RTpQY//7OmCLMVTGPR9bPmtuBKdEfk6MEyqBDFMrjuGpJI0Nc0
         BLfkjKYA3bR4SYXDZUq2u79e7NglSdrEG69GYwrswcSZA/BBaJvB4YccCWV3/8XOz2tm
         oHXyFi2ZLlW+BE7qNUeTO3eciTb5y5yBAibze+q1qSqfCEGFVubT/kPZDv9hoOAXOU/j
         OkX5wkCSDLXufT5OXEdRTgGy8oipImusJX3A23RushAhcb38PddiANlsxYQySjbUUlMj
         1ZC3A4XBAMBvnJBX0HAARJhe2ngGzm/z5Qx9ed6p835Ehd5fYnCoEAdPPVuRr2HV6oaH
         NX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YqrE2THxqluakJiX4FbxNBBk15XXMhZz6zppelXSlA=;
        b=2Pp5Sz0mUcm4Daoup/4DTCgJ62QfgbWsg2SxmlH2wfbbQiymC21wXHFlF9aIxPtRcV
         FfAfeYOeZIXlg8xuzhr3oVRfaO1rHiG3XcFLYz2SnAPIMuyz02AnnmQkv+zIMLzXH0aL
         poQCEj9jhly7Edyse61f1wQ8Wf3z9sLywOiYdcfJd6+B8DUPfDs6uzktcmXUKNMunPRW
         sSTGNonKHx3W7PlJwwrN7ZScyf8U8M/95TqMV+VbDVa4qmlMQrhG2qip6PmTtsA+ZbnH
         GgDriM9kKt3oO5jZbXAE/xM6NAEQueEgIDmqHv+Vro+zPHir4YWrk3JwPG50GrSvNZKU
         GRDA==
X-Gm-Message-State: AFqh2kr44/3AC7d4TMwpLKsqDbhJm7ID2yC9Y4AhpOd9XnIpp2xIOAhQ
        ij1Q39huIXwdgod1WuCs/UvAoMql4ygHpKX2bzP5sA3M5eM=
X-Google-Smtp-Source: AMrXdXv9ysQ1WtvbpHccQImvhRz71iUgjjPMhP4zMIRNKlcib+vz2iDqQCwAzNR+znTp1ipdXxt6gDBzT72UBGg8KCQ=
X-Received: by 2002:adf:d222:0:b0:25d:a7fd:6797 with SMTP id
 k2-20020adfd222000000b0025da7fd6797mr929438wrh.346.1672842764299; Wed, 04 Jan
 2023 06:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
 <20221219041551.69344-2-xiangxia.m.yue@gmail.com> <c41daf29-43b4-8924-b5af-49f287ba8cdc@meta.com>
 <CAADnVQLE+M0xEK+L8Tu7fqsjFxNFdEyFvR4q3U1f1N1tomZ2bQ@mail.gmail.com>
 <ac540d41-4ac3-4d70-39e8-722e3fb360cd@meta.com> <CAMDZJNV_J-LmxxzX5DMGHQLm6WyYqG2GAMHb=WZvBG_y1rUOYg@mail.gmail.com>
 <323005b1-67f6-9eec-46af-4952e133e1c4@meta.com> <dc658ded-719f-17bd-9166-e335a86150a6@huawei.com>
 <ff6473d8-c640-267e-c0f7-a92ce747c888@meta.com>
In-Reply-To: <ff6473d8-c640-267e-c0f7-a92ce747c888@meta.com>
From:   Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date:   Wed, 4 Jan 2023 22:32:06 +0800
Message-ID: <CAMDZJNWs3jSbZwbSe-U4ypMSqhjgJ=Z8AyYcz=wEzX-B4pJg7w@mail.gmail.com>
Subject: Re: [bpf-next v3 2/2] selftests/bpf: add test case for htab map
To:     Yonghong Song <yhs@meta.com>, Hou Tao <houtao1@huawei.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
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

On Wed, Jan 4, 2023 at 4:01 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 1/3/23 11:51 PM, Hou Tao wrote:
> > Hi,
> >
> > On 1/4/2023 3:09 PM, Yonghong Song wrote:
> >>
> >>
> >> On 1/2/23 6:40 PM, Tonghao Zhang wrote:
> >>>    a
> >>>
> >>> On Thu, Dec 29, 2022 at 2:29 PM Yonghong Song <yhs@meta.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 12/28/22 2:24 PM, Alexei Starovoitov wrote:
> >>>>> On Tue, Dec 27, 2022 at 8:43 PM Yonghong Song <yhs@meta.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 12/18/22 8:15 PM, xiangxia.m.yue@gmail.com wrote:
> >>>>>>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >>>>>>>
> >>>>>>> This testing show how to reproduce deadlock in special case.
> >>>>>>> We update htab map in Task and NMI context. Task can be interrupted by
> >>>>>>> NMI, if the same map bucket was locked, there will be a deadlock.
> >>>>>>>
> >>>>>>> * map max_entries is 2.
> >>>>>>> * NMI using key 4 and Task context using key 20.
> >>>>>>> * so same bucket index but map_locked index is different.
> >>>>>>>
> >>>>>>> The selftest use perf to produce the NMI and fentry nmi_handle.
> >>>>>>> Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
> >>>>>>> map syscall increase this counter in bpf_disable_instrumentation.
> >>>>>>> Then fentry nmi_handle and update hash map will reproduce the issue.
> > SNIP
> >>>>>>> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c
> >>>>>>> b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000000..d394f95e97c3
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> >>>>>>> @@ -0,0 +1,32 @@
> >>>>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>>>> +/* Copyright (c) 2022 DiDi Global Inc. */
> >>>>>>> +#include <linux/bpf.h>
> >>>>>>> +#include <bpf/bpf_helpers.h>
> >>>>>>> +#include <bpf/bpf_tracing.h>
> >>>>>>> +
> >>>>>>> +char _license[] SEC("license") = "GPL";
> >>>>>>> +
> >>>>>>> +struct {
> >>>>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
> >>>>>>> +     __uint(max_entries, 2);
> >>>>>>> +     __uint(map_flags, BPF_F_ZERO_SEED);
> >>>>>>> +     __type(key, unsigned int);
> >>>>>>> +     __type(value, unsigned int);
> >>>>>>> +} htab SEC(".maps");
> >>>>>>> +
> >>>>>>> +/* nmi_handle on x86 platform. If changing keyword
> >>>>>>> + * "static" to "inline", this prog load failed. */
> >>>>>>> +SEC("fentry/nmi_handle")
> >>>>>>
> >>>>>> The above comment is not what I mean. In arch/x86/kernel/nmi.c,
> >>>>>> we have
> >>>>>>       static int nmi_handle(unsigned int type, struct pt_regs *regs)
> >>>>>>       {
> >>>>>>            ...
> >>>>>>       }
> >>>>>>       ...
> >>>>>>       static noinstr void default_do_nmi(struct pt_regs *regs)
> >>>>>>       {
> >>>>>>            ...
> >>>>>>            handled = nmi_handle(NMI_LOCAL, regs);
> >>>>>>            ...
> >>>>>>       }
> >>>>>>
> >>>>>> Since nmi_handle is a static function, it is possible that
> >>>>>> the function might be inlined in default_do_nmi by the
> >>>>>> compiler. If this happens, fentry/nmi_handle will not
> >>>>>> be triggered and the test will pass.
> >>>>>>
> >>>>>> So I suggest to change the comment to
> >>>>>>       nmi_handle() is a static function and might be
> >>>>>>       inlined into its caller. If this happens, the
> >>>>>>       test can still pass without previous kernel fix.
> >>>>>
> >>>>> It's worse than this.
> >>>>> fentry is buggy.
> >>>>> We shouldn't allow attaching fentry to:
> >>>>> NOKPROBE_SYMBOL(nmi_handle);
> >>>>
> >>>> Okay, I see. Looks we should prevent fentry from
> >>>> attaching any NOKPROBE_SYMBOL functions.
> >>>>
> >>>> BTW, I think fentry/nmi_handle can be replaced with
> >>>> tracepoint nmi/nmi_handler. it is more reliable
> >>> The tracepoint will not reproduce the deadlock(we have discussed v2).
> >>> If it's not easy to complete a test for this case, should we drop this
> >>> testcase patch? or fentry the nmi_handle and update the comments.
> >>
> >> could we use a softirq perf event (timer), e.g.,
> >>
> >>          struct perf_event_attr attr = {
> >>                  .sample_period = 1,
> >>                  .type = PERF_TYPE_SOFTWARE,
> >>                  .config = PERF_COUNT_SW_CPU_CLOCK,
> >>          };
> >>
> >> then you can attach function hrtimer_run_softirq (not tested) or
> >> similar functions?
> > The context will be a hard-irq context, right ? Because htab_lock_bucket() has
> > already disabled hard-irq on current CPU, so the dead-lock will be impossible.
>
> Okay, I see. soft-irq doesn't work. The only thing it works is nmi since
> it is non-masking.
>
> >>
> >> I suspect most (if not all) functions in nmi path cannot
> >> be kprobe'd.
> > It seems that perf_event_nmi_handler() is also nokprobe function. However I
> > think we could try its callees (e.g., x86_pmu_handle_irq or perf_event_overflow).
>
> If we can find a function in nmi handling path which is not marked as
> nonkprobe, sure, we can use that function for fentry.
I think perf_event_overflow is ok.
[   93.233093]  dump_stack_lvl+0x57/0x81
[   93.233098]  lock_acquire+0x1f4/0x29a
[   93.233103]  ? htab_lock_bucket+0x61/0x6c
[   93.233108]  _raw_spin_lock_irqsave+0x43/0x7f
[   93.233111]  ? htab_lock_bucket+0x61/0x6c
[   93.233114]  htab_lock_bucket+0x61/0x6c
[   93.233118]  htab_map_update_elem+0x11e/0x220
[   93.233124]  bpf_prog_df326439468c24a9_bpf_prog1+0x41/0x45
[   93.233137]  bpf_trampoline_6442478975_0+0x48/0x1000
[   93.233144]  perf_event_overflow+0x5/0x15
[   93.233149]  handle_pmi_common+0x1ad/0x1f0
[   93.233166]  intel_pmu_handle_irq+0x136/0x18a
[   93.233170]  perf_event_nmi_handler+0x28/0x47
[   93.233176]  nmi_handle+0xb8/0x254
[   93.233182]  default_do_nmi+0x3d/0xf6
[   93.233187]  exc_nmi+0xa1/0x109
[   93.233191]  end_repeat_nmi+0x16/0x67
> >>
> >>>> and won't be impacted by potential NOKPROBE_SYMBOL
> >>>> issues.
> >>>
> >>>
> >>>
> >> .
> >



-- 
Best regards, Tonghao
