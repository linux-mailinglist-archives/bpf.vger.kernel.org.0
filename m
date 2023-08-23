Return-Path: <bpf+bounces-8388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A86785D57
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08ADE1C20CFE
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84755C151;
	Wed, 23 Aug 2023 16:33:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C2E9445
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 16:33:32 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D2C11F
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:33:30 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso89918951fa.1
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692808408; x=1693413208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHNKTsz3fzu1c49nJsZAIP+u7XzpaEcajNuJAlRO5c4=;
        b=DmXEPhd+Famq/PjcI/IzPhr58ekA5bAVhuPpFvuj7twnMX9IESeeiejE44Cn3fexp4
         7QKwcQETfwOZcYrVVRKdjZe/DVNiXa9rEEKTI8ssdnTvH+K3xlvdbrpgOwWF9iyLgLlW
         W8bOj5M+bAsDpRsWwVsOVymL2F6HkUIdh58I/4U0NJ9eRlBw1NJD1kLL4Gsj88c+ZiXe
         feqNo0Wriy9FtZOZhMdLZ7xure05pCgziSsYzLJ/utDDMzeNH9KjaySHHnePob6sqarJ
         kBDhZjygqSX8ppRxaocUU1qm85zb06Hf+39Cb9rpLIQMJyJVEK6HQkyi6F8349nw8j5z
         lFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692808408; x=1693413208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHNKTsz3fzu1c49nJsZAIP+u7XzpaEcajNuJAlRO5c4=;
        b=fEAQadYSOEjU4NxySDYu6mEWmbFm1XA4Z6u2FDWB3A9i5buvxVK0HkEUqMyWJRlkAZ
         mRyEzr8+Zu727DS3RF6F4RByTkV6VqlqIf0GaLHN2EfPGDu2NCDuVh/aovBOix8HV8UK
         WP19UIK5VW5l5J4feV/qV24yBzeRUmUmqbpmxf9pW6nxIWYIHelgizgpDq2zEwDylyTd
         wgcPnpGRlbdmWhXONNcqThADv/X2S1UapVS2dbIvribyu2Cs5/sPIyIEHDIKkjk8LJn7
         BkpW4fUO2Ycwrr2vZbzCUNrriT82Y+MmRNDpztrLbvYOgfbbNT8XZx8+gfb8B/q/jxJ9
         p2NQ==
X-Gm-Message-State: AOJu0YwUFaBqN8Wn+HaojqEBV7xZ+kc64AHPvFgsTZTvmLdVVCMHzN7b
	WaAzyVyVK1E0ypDMJWbswX2G+6L6tJxgvh5PQfL/wiy1nXA=
X-Google-Smtp-Source: AGHT+IEFZfkKakG/lnlvBXmUvbWD3D3JNs48KYlzavX4DoKdv6mdbXBbJHX6NcfHl83ZurOCglwIrvUafcffGN8dApE=
X-Received: by 2002:a05:651c:237:b0:2bc:db5a:9546 with SMTP id
 z23-20020a05651c023700b002bcdb5a9546mr2129641ljn.7.1692808408154; Wed, 23 Aug
 2023 09:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822133807.3198625-1-houtao@huaweicloud.com>
 <20230822133807.3198625-2-houtao@huaweicloud.com> <CAADnVQKFh9pWp1abrG2KKiZanb+4rzRb3HmzX0snggah3Lq-yg@mail.gmail.com>
 <bf4faa34-019c-bb3d-a451-a067bbe027a4@huaweicloud.com> <CAADnVQJfpxk3dsjYdH8DUarJHu0wFXa24XFxvn+F5mseMKTAhQ@mail.gmail.com>
 <3c30289a-d683-d1c8-b18d-c87a5ecebe3b@huaweicloud.com>
In-Reply-To: <3c30289a-d683-d1c8-b18d-c87a5ecebe3b@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Aug 2023 09:33:17 -0700
Message-ID: <CAADnVQLHPx-0dR7nBXAfBHOpF09Jr6+cqGjfGf9mT2BHCid5YA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Enable preemption after
 irq_work_raise() in unit_alloc()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 9:39=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/23/2023 9:57 AM, Alexei Starovoitov wrote:
> > On Tue, Aug 22, 2023 at 5:51=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> On 8/23/2023 8:05 AM, Alexei Starovoitov wrote:
> >>> On Tue, Aug 22, 2023 at 6:06=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> >>>> From: Hou Tao <houtao1@huawei.com>
> >>>>
> >>>> When doing stress test for qp-trie, bpf_mem_alloc() returned NULL
> >>>> unexpectedly because all qp-trie operations were initiated from
> >>>> bpf syscalls and there was still available free memory. bpf_obj_new(=
)
> >>>> has the same problem as shown by the following selftest.
> >>>>
> >>>> The failure is due to the preemption. irq_work_raise() will invoke
> >>>> irq_work_claim() first to mark the irq work as pending and then inov=
ke
> >>>> __irq_work_queue_local() to raise an IPI. So when the current task
> >>>> which is invoking irq_work_raise() is preempted by other task,
> >>>> unit_alloc() may return NULL for preemptive task as shown below:
> >>>>
> >>>> task A         task B
> >>>>
> >>>> unit_alloc()
> >>>>   // low_watermark =3D 32
> >>>>   // free_cnt =3D 31 after alloc
> >>>>   irq_work_raise()
> >>>>     // mark irq work as IRQ_WORK_PENDING
> >>>>     irq_work_claim()
> >>>>
> >>>>                // task B preempts task A
> >>>>                unit_alloc()
> >>>>                  // free_cnt =3D 30 after alloc
> >>>>                  // irq work is already PENDING,
> >>>>                  // so just return
> >>>>                  irq_work_raise()
> >>>>                // does unit_alloc() 30-times
> >>>>                ......
> >>>>                unit_alloc()
> >>>>                  // free_cnt =3D 0 before alloc
> >>>>                  return NULL
> >>>>
> >>>> Fix it by invoking preempt_disable_notrace() before allocation and
> >>>> invoking preempt_enable_notrace() to enable preemption after
> >>>> irq_work_raise() completes. An alternative fix is to move
> >>>> local_irq_restore() after the invocation of irq_work_raise(), but it
> >>>> will enlarge the irq-disabled region. Another feasible fix is to onl=
y
> >>>> disable preemption before invoking irq_work_queue() and enable
> >>>> preemption after the invocation in irq_work_raise(), but it can't
> >>>> handle the case when c->low_watermark is 1.
> >>>>
> >>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>>> ---
> >>>>  kernel/bpf/memalloc.c | 8 ++++++++
> >>>>  1 file changed, 8 insertions(+)
> >>>>
> >>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >>>> index 9c49ae53deaf..83f8913ebb0a 100644
> >>>> --- a/kernel/bpf/memalloc.c
> >>>> +++ b/kernel/bpf/memalloc.c
> >>>> @@ -6,6 +6,7 @@
> >>>>  #include <linux/irq_work.h>
> >>>>  #include <linux/bpf_mem_alloc.h>
> >>>>  #include <linux/memcontrol.h>
> >>>> +#include <linux/preempt.h>
> >>>>  #include <asm/local.h>
> >>>>
> >>>>  /* Any context (including NMI) BPF specific memory allocator.
> >>>> @@ -725,6 +726,7 @@ static void notrace *unit_alloc(struct bpf_mem_c=
ache *c)
> >>>>          * Use per-cpu 'active' counter to order free_list access be=
tween
> >>>>          * unit_alloc/unit_free/bpf_mem_refill.
> >>>>          */
> >>>> +       preempt_disable_notrace();
> >>>>         local_irq_save(flags);
> >>>>         if (local_inc_return(&c->active) =3D=3D 1) {
> >>>>                 llnode =3D __llist_del_first(&c->free_llist);
> >>>> @@ -740,6 +742,12 @@ static void notrace *unit_alloc(struct bpf_mem_=
cache *c)
> >>>>
> >>>>         if (cnt < c->low_watermark)
> >>>>                  (c);
> >>>> +       /* Enable preemption after the enqueue of irq work completes=
,
> >>>> +        * so free_llist may be refilled by irq work before other ta=
sk
> >>>> +        * preempts current task.
> >>>> +        */
> >>>> +       preempt_enable_notrace();
> >>> So this helps qp-trie init, since it's doing bpf_mem_alloc from
> >>> syscall context and helps bpf_obj_new from bpf prog, since prog is
> >>> non-migrateable, but preemptable. It's not an issue for htab doing
> >>> during map_update, since
> >>> it's under htab bucket lock.
> >>> Let's introduce minimal:
> >>> /* big comment here explaining the reason of extra preempt disable */
> >>> static void bpf_memalloc_irq_work_raise(...)
> >>> {
> >>>   preempt_disable_notrace();
> >>>   irq_work_raise();
> >>>   preempt_enable_notrace();
> >>> }
> >>>
> >>> it will have the same effect, right?
> >>> .
> >> No. As I said in commit message, when c->low_watermark is 1, the above
> >> fix doesn't work as shown below:
> > Yes. I got mark=3D1 part. I just don't think it's worth the complexity.
>
> Just find out that for bpf_obj_new() the minimal low_watermark is 2
> instead of 1 (unit_size=3D 4096 instead of 4096 + 8). But even with
> low_watermark as 2, the above fix may don't work when there are nested
> preemption: task A (free_cnt =3D 1 after alloc) -> preempted by task B
> (free_cnt =3D 0 after alloc) -> preempted by task C (fail to do
> allocation). And in my naive understanding of bpf memory allocate, these
> fixes are simple. Why do you think it will introduce extra complexity ?
> Do you mean preempt_disable_notrace() could be used to trigger the
> running of bpf program ? If it is the problem, I think we should fix it
> instead.

I'm not worried about recursive calls from _notrace(). That shouldn't
be possible.
I'm just saying that disabling preemption around irq_work_raise() helps a b=
it
while disable around the whole unit_alloc/free is a snake oil.
bpf prog could be running in irq disabled context and preempt disabled
unit_alloc vs irq_work_raise won't make any difference. Both will return NU=
LL.
Same with batched htab update. It will hit NULL too.
So from my pov you're trying to fix something that is not fixable.
Batched alloc will fail. The users have to use bpf_ma differently.
In places where they cannot afford alloc failures they need to pre-allocate=
.
We were planning to introduce bpf_obj_new() that does kmalloc when
bpf prog is sleepable. Then bpf prog can stash such manually pre-allocated
object and use it later.

