Return-Path: <bpf+bounces-8541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D9787EBB
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 05:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F928281705
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 03:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C640A31;
	Fri, 25 Aug 2023 03:48:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15097E0
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 03:48:46 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE451BEC
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 20:48:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so6829071fa.2
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 20:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692935323; x=1693540123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl1KgoxYMiwpPNkZEErYzEBDv9AIvFtm0ZS5/pbX9zk=;
        b=m3AjTBihZhw1Hg++r5oppM+pS55Uj4CaMor2rcAlWrKB7I9UMnqLTyUtpT9GPm4bif
         ua7NeglwqenmnQT2gl0ZXNLT2163L3eiQHWTgaABzh1RJhLUHug7CxuHjee+rGQDznbf
         GsZ0fDlm4I2e+5Wxtfm3kZxnc8iZR7T7fUBBxc/4BxRFC0l2HCcfqRQubUiMHlfn8FQ4
         oJKiOTxHew+qur2rcPJqHnV+8j8JKBGums0YLOW1dQChuXgdG3sSKKEp4b/eY4OJXeZ6
         L+u6IqlaU98Je6EKHBcFqqd1wiwpJ//+8O7qI+ktYskARZCeI0zHhlgnB8S5z8Lz+55K
         g9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692935323; x=1693540123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl1KgoxYMiwpPNkZEErYzEBDv9AIvFtm0ZS5/pbX9zk=;
        b=HFRZAcTjIJH2gTxy63XTkfINwAJyYMTL3PuH7frcLAx2ikPYU61WmE8avrb5788aBS
         i2U4yUMN6YPQA2r1K1/Q4uj1CoSYw4ezYNXO8vec3/PnrZdz5ZZZiJUoRmPhYN4tmQQk
         nsd3qBJfcyvIugG8n+ZeslOCO5Oa/zI8shpV3/6oi2+pYg/b7vTdgh8zUQMLKlGLN7ED
         /4LSSqsEIQ2du81/gcU/Gfjk8e0wSiGljWubRZ0qWEZuHMp0IWZry84PSLMFruc5XOKN
         MTH3BrPntzSlqTOd9TXyGDHHqlylpDVyA7s1hV/qriD2cIfvQGWHs1SYnVnq+3rdp5qM
         adRA==
X-Gm-Message-State: AOJu0YzvLvuipD4AZxGdUOqHIOnLNTUZBsfwHaMMd8QG/VvvdUwoITcI
	v2EzgkXmTDG8/+xOIQHXs9Q+9d/LadxDQq7ANdE=
X-Google-Smtp-Source: AGHT+IFsWWss50Y6F1gk0e4C2K0AkfcISm2XIKx1a90MByToF8VgT4GjuZf+o4l2XLHismJQ/GtTU7nTQoJLzFrernU=
X-Received: by 2002:a2e:6812:0:b0:2b9:e0ba:752a with SMTP id
 c18-20020a2e6812000000b002b9e0ba752amr12971175lja.53.1692935322492; Thu, 24
 Aug 2023 20:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822133807.3198625-1-houtao@huaweicloud.com>
 <20230822133807.3198625-2-houtao@huaweicloud.com> <CAADnVQKFh9pWp1abrG2KKiZanb+4rzRb3HmzX0snggah3Lq-yg@mail.gmail.com>
 <bf4faa34-019c-bb3d-a451-a067bbe027a4@huaweicloud.com> <CAADnVQJfpxk3dsjYdH8DUarJHu0wFXa24XFxvn+F5mseMKTAhQ@mail.gmail.com>
 <3c30289a-d683-d1c8-b18d-c87a5ecebe3b@huaweicloud.com> <CAADnVQLHPx-0dR7nBXAfBHOpF09Jr6+cqGjfGf9mT2BHCid5YA@mail.gmail.com>
 <5fe435aa-526f-4b54-b0d2-e0ae1c6c234c@huaweicloud.com>
In-Reply-To: <5fe435aa-526f-4b54-b0d2-e0ae1c6c234c@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Aug 2023 20:48:31 -0700
Message-ID: <CAADnVQLtJBOTueuGZHM0PUhskMZY-uaaehvgfx7pkpq0qfhvVA@mail.gmail.com>
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

On Thu, Aug 24, 2023 at 7:07=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/24/2023 12:33 AM, Alexei Starovoitov wrote:
> > On Tue, Aug 22, 2023 at 9:39=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> On 8/23/2023 9:57 AM, Alexei Starovoitov wrote:
> >>> On Tue, Aug 22, 2023 at 5:51=E2=80=AFPM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> >>>> Hi,
> >>>>
> >>>> On 8/23/2023 8:05 AM, Alexei Starovoitov wrote:
> >>>>> On Tue, Aug 22, 2023 at 6:06=E2=80=AFAM Hou Tao <houtao@huaweicloud=
.com> wrote:
> >>>>>> From: Hou Tao <houtao1@huawei.com>
> >>>>>>
> >>>>>> When doing stress test for qp-trie, bpf_mem_alloc() returned NULL
> >>>>>> unexpectedly because all qp-trie operations were initiated from
> >>>>>> bpf syscalls and there was still available free memory. bpf_obj_ne=
w()
> >>>>>> has the same problem as shown by the following selftest.
> >>>>>>
> >>>>>> The failure is due to the preemption. irq_work_raise() will invoke
> >>>>>> irq_work_claim() first to mark the irq work as pending and then in=
ovke
> >>>>>> __irq_work_queue_local() to raise an IPI. So when the current task
> >>>>>> which is invoking irq_work_raise() is preempted by other task,
> >>>>>> unit_alloc() may return NULL for preemptive task as shown below:
> >>>>>>
> >>>>>> task A         task B
> >>>>>>
> >>>>>> unit_alloc()
> >>>>>>   // low_watermark =3D 32
> >>>>>>   // free_cnt =3D 31 after alloc
> >>>>>>   irq_work_raise()
> >>>>>>     // mark irq work as IRQ_WORK_PENDING
> >>>>>>     irq_work_claim()
> >>>>>>
> >>>>>>                // task B preempts task A
> >>>>>>                unit_alloc()
> >>>>>>                  // free_cnt =3D 30 after alloc
> >>>>>>                  // irq work is already PENDING,
> >>>>>>                  // so just return
> >>>>>>                  irq_work_raise()
> >>>>>>                // does unit_alloc() 30-times
> >>>>>>                ......
> >>>>>>                unit_alloc()
> >>>>>>                  // free_cnt =3D 0 before alloc
> >>>>>>                  return NULL
> >>>>>>
> >>>>>> Fix it by invoking preempt_disable_notrace() before allocation and
> >>>>>> invoking preempt_enable_notrace() to enable preemption after
> >>>>>> irq_work_raise() completes. An alternative fix is to move
> >>>>>> local_irq_restore() after the invocation of irq_work_raise(), but =
it
> >>>>>> will enlarge the irq-disabled region. Another feasible fix is to o=
nly
> >>>>>> disable preemption before invoking irq_work_queue() and enable
> >>>>>> preemption after the invocation in irq_work_raise(), but it can't
> >>>>>> handle the case when c->low_watermark is 1.
> >>>>>>
> >>>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>>>>> ---
> >>>>>>  kernel/bpf/memalloc.c | 8 ++++++++
> >>>>>>  1 file changed, 8 insertions(+)
> >>>>>>
> >>>>>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >>>>>> index 9c49ae53deaf..83f8913ebb0a 100644
> >>>>>> --- a/kernel/bpf/memalloc.c
> >>>>>> +++ b/kernel/bpf/memalloc.c
> >>>>>> @@ -6,6 +6,7 @@
> >>>>>>  #include <linux/irq_work.h>
> >>>>>>  #include <linux/bpf_mem_alloc.h>
> >>>>>>  #include <linux/memcontrol.h>
> >>>>>> +#include <linux/preempt.h>
> >>>>>>  #include <asm/local.h>
> >>>>>>
> >>>>>>  /* Any context (including NMI) BPF specific memory allocator.
> >>>>>> @@ -725,6 +726,7 @@ static void notrace *unit_alloc(struct bpf_mem=
_cache *c)
> >>>>>>          * Use per-cpu 'active' counter to order free_list access =
between
> >>>>>>          * unit_alloc/unit_free/bpf_mem_refill.
> >>>>>>          */
> >>>>>> +       preempt_disable_notrace();
> >>>>>>         local_irq_save(flags);
> >>>>>>         if (local_inc_return(&c->active) =3D=3D 1) {
> >>>>>>                 llnode =3D __llist_del_first(&c->free_llist);
> >>>>>> @@ -740,6 +742,12 @@ static void notrace *unit_alloc(struct bpf_me=
m_cache *c)
> >>>>>>
> >>>>>>         if (cnt < c->low_watermark)
> >>>>>>                  (c);
> >>>>>> +       /* Enable preemption after the enqueue of irq work complet=
es,
> >>>>>> +        * so free_llist may be refilled by irq work before other =
task
> >>>>>> +        * preempts current task.
> >>>>>> +        */
> >>>>>> +       preempt_enable_notrace();
> >>>>> So this helps qp-trie init, since it's doing bpf_mem_alloc from
> >>>>> syscall context and helps bpf_obj_new from bpf prog, since prog is
> >>>>> non-migrateable, but preemptable. It's not an issue for htab doing
> >>>>> during map_update, since
> >>>>> it's under htab bucket lock.
> >>>>> Let's introduce minimal:
> >>>>> /* big comment here explaining the reason of extra preempt disable =
*/
> >>>>> static void bpf_memalloc_irq_work_raise(...)
> >>>>> {
> >>>>>   preempt_disable_notrace();
> >>>>>   irq_work_raise();
> >>>>>   preempt_enable_notrace();
> >>>>> }
> >>>>>
> >>>>> it will have the same effect, right?
> >>>>> .
> >>>> No. As I said in commit message, when c->low_watermark is 1, the abo=
ve
> >>>> fix doesn't work as shown below:
> >>> Yes. I got mark=3D1 part. I just don't think it's worth the complexit=
y.
> >> Just find out that for bpf_obj_new() the minimal low_watermark is 2
> >> instead of 1 (unit_size=3D 4096 instead of 4096 + 8). But even with
> >> low_watermark as 2, the above fix may don't work when there are nested
> >> preemption: task A (free_cnt =3D 1 after alloc) -> preempted by task B
> >> (free_cnt =3D 0 after alloc) -> preempted by task C (fail to do
> >> allocation). And in my naive understanding of bpf memory allocate, the=
se
> >> fixes are simple. Why do you think it will introduce extra complexity =
?
> >> Do you mean preempt_disable_notrace() could be used to trigger the
> >> running of bpf program ? If it is the problem, I think we should fix i=
t
> >> instead.
> > I'm not worried about recursive calls from _notrace(). That shouldn't
> > be possible.
>
> OK
> > I'm just saying that disabling preemption around irq_work_raise() helps=
 a bit
> > while disable around the whole unit_alloc/free is a snake oil.
> > bpf prog could be running in irq disabled context and preempt disabled
> > unit_alloc vs irq_work_raise won't make any difference. Both will retur=
n NULL.
> > Same with batched htab update. It will hit NULL too.
> > So from my pov you're trying to fix something that is not fixable.
>
> The patch set didn't try to fix the problem for all possible context,
> especially the irq disable context. It just tries to fix the ENOMEM
> problem for process context which is the major context. I still think
> disabling preemption around the whole unit_alloc/free is much solider
> than just do that for irq_work_raise() (e.g., for the nested preemption
> case). But if you have a strong preference for only disabling preemption
> for irq_work_raise(), I will post v2 to do that.

In process ctx the preempt_disable/enable across unit_alloc will keep
asking kernel to consider preemption on every unit_alloc call
which can be a lot.
If I'm reading the code correctly preempt_schedule() is quite heavy.
Doing it every unit_alloc is a performance concern.

Could you try the following:
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9c49ae53deaf..ee8262f58c5a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -442,7 +442,10 @@ static void bpf_mem_refill(struct irq_work *work)

 static void notrace irq_work_raise(struct bpf_mem_cache *c)
 {
-       irq_work_queue(&c->refill_work);
+       if (!irq_work_queue(&c->refill_work)) {
+               preempt_disable_notrace();
+               preempt_enable_notrace();
+       }
 }

The idea that it will ask for resched if preemptible.
will it address the issue you're seeing?

