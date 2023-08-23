Return-Path: <bpf+bounces-8335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7FC784E74
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 03:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1E628123D
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 01:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D1315B1;
	Wed, 23 Aug 2023 01:58:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64015A4
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 01:58:13 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D870AE4A
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 18:58:11 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so45421941fa.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 18:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692755890; x=1693360690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2xf0wdh2/h5n4t9PA6U8J/tN/hC9uR6Kd2JN6JeIpk=;
        b=HdYybC7RiKQTyrr7iyzr6gFq6vARhrk367/jyC4UaWxwhUX6jft5fPPSMk0lNxcxu6
         glfhFnnNyTtvisL9kfeFjgmcZnkaT4KoZ3V0HeA0Ju4n/OwKQNVWBij9BkKxgkOOoetP
         OWMNq/n/ElsJie4ncBC+TGxGMWC48HuITCpVwwYU6MWYf01IaEwhhrnT7hz8ag22wP/r
         g6uQcrr6/23WkrNdpjmmUPYpmiZfX9g40tdc2Tu86jYjkvPAZKbb8hJ4rShryJvwsTbd
         vkemx3bwHQWIs342CQakzGKt/YycPPYxC8eDdg9K2OWCx/heZoyLd3gTVgLDZjBTMXo1
         ktXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692755890; x=1693360690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2xf0wdh2/h5n4t9PA6U8J/tN/hC9uR6Kd2JN6JeIpk=;
        b=cFx55BnGgDEy5uV9mY884RfxWk3fFbynjnxBZQu+Tb9TQtels/P7furzDQ/TS+orCj
         VQ1/NG0QN7BKb+TI3XEWBT+dUmJ2eH6AjQ0rQewJuLATtI9U3rV+TinH3q0OQtG+oL5O
         vqYFzdKE2JX8flQK2I6eI5w6Xpp5kIqoGBukosAZ73PeGGf4I2Sd91KJFPOZqQZitpxT
         hhbm+hVdcqrSdjWNLzE7fuewrkkxbhBRaDnVIkaMXpXLmVIxC5sgQMPC5cHFsbO8/YWf
         epQqkXffvETrlxdOcHo6C/3FAg2jA2u1dWOpxXWdDtbedhvkHmHjNYM5ejTWpIZLqGFZ
         9fWg==
X-Gm-Message-State: AOJu0YwWalh1p1ghBxTMy1vDdNeYVSOC/b1cOXcTs6ytmG4Czt3ORhgT
	OAIsfkqvpzcY5x0m6UIAxdEMzZczSIMxVgSSIwA=
X-Google-Smtp-Source: AGHT+IGgEm3Ok47GMqd40eMVjBD3SEIyIRJm+dX9HX4XuGBp8T9k4qVzDRuIEX+cBAftQHs13Unp0oyHgtTYhBdJs8U=
X-Received: by 2002:a2e:9c81:0:b0:2bc:c3ad:f418 with SMTP id
 x1-20020a2e9c81000000b002bcc3adf418mr5439552lji.20.1692755889738; Tue, 22 Aug
 2023 18:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822133807.3198625-1-houtao@huaweicloud.com>
 <20230822133807.3198625-2-houtao@huaweicloud.com> <CAADnVQKFh9pWp1abrG2KKiZanb+4rzRb3HmzX0snggah3Lq-yg@mail.gmail.com>
 <bf4faa34-019c-bb3d-a451-a067bbe027a4@huaweicloud.com>
In-Reply-To: <bf4faa34-019c-bb3d-a451-a067bbe027a4@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 18:57:58 -0700
Message-ID: <CAADnVQJfpxk3dsjYdH8DUarJHu0wFXa24XFxvn+F5mseMKTAhQ@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 5:51=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/23/2023 8:05 AM, Alexei Starovoitov wrote:
> > On Tue, Aug 22, 2023 at 6:06=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> When doing stress test for qp-trie, bpf_mem_alloc() returned NULL
> >> unexpectedly because all qp-trie operations were initiated from
> >> bpf syscalls and there was still available free memory. bpf_obj_new()
> >> has the same problem as shown by the following selftest.
> >>
> >> The failure is due to the preemption. irq_work_raise() will invoke
> >> irq_work_claim() first to mark the irq work as pending and then inovke
> >> __irq_work_queue_local() to raise an IPI. So when the current task
> >> which is invoking irq_work_raise() is preempted by other task,
> >> unit_alloc() may return NULL for preemptive task as shown below:
> >>
> >> task A         task B
> >>
> >> unit_alloc()
> >>   // low_watermark =3D 32
> >>   // free_cnt =3D 31 after alloc
> >>   irq_work_raise()
> >>     // mark irq work as IRQ_WORK_PENDING
> >>     irq_work_claim()
> >>
> >>                // task B preempts task A
> >>                unit_alloc()
> >>                  // free_cnt =3D 30 after alloc
> >>                  // irq work is already PENDING,
> >>                  // so just return
> >>                  irq_work_raise()
> >>                // does unit_alloc() 30-times
> >>                ......
> >>                unit_alloc()
> >>                  // free_cnt =3D 0 before alloc
> >>                  return NULL
> >>
> >> Fix it by invoking preempt_disable_notrace() before allocation and
> >> invoking preempt_enable_notrace() to enable preemption after
> >> irq_work_raise() completes. An alternative fix is to move
> >> local_irq_restore() after the invocation of irq_work_raise(), but it
> >> will enlarge the irq-disabled region. Another feasible fix is to only
> >> disable preemption before invoking irq_work_queue() and enable
> >> preemption after the invocation in irq_work_raise(), but it can't
> >> handle the case when c->low_watermark is 1.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/bpf/memalloc.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >> index 9c49ae53deaf..83f8913ebb0a 100644
> >> --- a/kernel/bpf/memalloc.c
> >> +++ b/kernel/bpf/memalloc.c
> >> @@ -6,6 +6,7 @@
> >>  #include <linux/irq_work.h>
> >>  #include <linux/bpf_mem_alloc.h>
> >>  #include <linux/memcontrol.h>
> >> +#include <linux/preempt.h>
> >>  #include <asm/local.h>
> >>
> >>  /* Any context (including NMI) BPF specific memory allocator.
> >> @@ -725,6 +726,7 @@ static void notrace *unit_alloc(struct bpf_mem_cac=
he *c)
> >>          * Use per-cpu 'active' counter to order free_list access betw=
een
> >>          * unit_alloc/unit_free/bpf_mem_refill.
> >>          */
> >> +       preempt_disable_notrace();
> >>         local_irq_save(flags);
> >>         if (local_inc_return(&c->active) =3D=3D 1) {
> >>                 llnode =3D __llist_del_first(&c->free_llist);
> >> @@ -740,6 +742,12 @@ static void notrace *unit_alloc(struct bpf_mem_ca=
che *c)
> >>
> >>         if (cnt < c->low_watermark)
> >>                  (c);
> >> +       /* Enable preemption after the enqueue of irq work completes,
> >> +        * so free_llist may be refilled by irq work before other task
> >> +        * preempts current task.
> >> +        */
> >> +       preempt_enable_notrace();
> > So this helps qp-trie init, since it's doing bpf_mem_alloc from
> > syscall context and helps bpf_obj_new from bpf prog, since prog is
> > non-migrateable, but preemptable. It's not an issue for htab doing
> > during map_update, since
> > it's under htab bucket lock.
> > Let's introduce minimal:
> > /* big comment here explaining the reason of extra preempt disable */
> > static void bpf_memalloc_irq_work_raise(...)
> > {
> >   preempt_disable_notrace();
> >   irq_work_raise();
> >   preempt_enable_notrace();
> > }
> >
> > it will have the same effect, right?
> > .
>
> No. As I said in commit message, when c->low_watermark is 1, the above
> fix doesn't work as shown below:

Yes. I got mark=3D1 part. I just don't think it's worth the complexity.

