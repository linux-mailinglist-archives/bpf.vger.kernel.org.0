Return-Path: <bpf+bounces-4440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9B874B4FC
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02260280E64
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59E10960;
	Fri,  7 Jul 2023 16:11:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA9107AD;
	Fri,  7 Jul 2023 16:11:49 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6B2105;
	Fri,  7 Jul 2023 09:11:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b703c900e3so32320431fa.1;
        Fri, 07 Jul 2023 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688746294; x=1691338294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pf5dnyrXQEda2yB2QUPvv6NwuWjzgPzEHR6aZnBBoI=;
        b=cdVhKwZUfPiXWP69XMDCI6Bi2Exp1T0y7P7EVJYBQ62InMEESI+wq1gQFtgZrbhAcf
         ZXmv4tj9SMi7mK1yQVN1VY532JCGPfr5ahfNCYz3qTFAehOWMOLEdpIp/xBW6abW7W3d
         N3vaRdD78aqiVZUsLol6VZ3WwJaBLo+dHZPbN7emV+har8ya4e8Tkl65zcjoq40h6do6
         7AZJRemxb1ml7mvBq83Jg4YDiefQw6yFt3REhoagAhxRLoB5gbFR/8q51sPV2rw/Jh/u
         4RWjiMMDUsYmB/wy7GoG40fZUou05ffPheW5ih9VcaEYUw2bpLQPZvN34/37seIfOjsM
         vrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688746294; x=1691338294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pf5dnyrXQEda2yB2QUPvv6NwuWjzgPzEHR6aZnBBoI=;
        b=d9h1M2lYESZOBELr3nnrs+XGeI3hoM0hOHZ8rIjxAOo4DLI2A7n6yDHI1y/H4+0QCL
         v2wVhdVslX/hx/iIDt+dY7khyVnwszvewD3p/JHOk674ygot+4/l5EOnGs7FslLlTRdO
         Z8oOM9dggXHMygRd5QAKjlOc7EoDcNRuyXhCr4azTyhOy0JR2L9LnDdBxdyTlY9PMKLR
         RtRFWPzO0+Kbrt5uEwvYgwVmQ0qNN+QYwwBbFRsLPPmTZBOa1FwHybyr5m/b0RML4ZqZ
         ja+GeumZNGMlismR5ttTOb5COE9C1LjTHlYkdFlCCT2MqkiyLeNFOmlvF2sZW7cl4D/9
         X9mQ==
X-Gm-Message-State: ABy/qLYe0Lq2IrEdT28sJtYUND9ShQPXoYj9+/0ox+tZntEKnfQNcW/5
	kTb0Leujs1k3xS0mw8BHNWowBQci8lscIkA72P0=
X-Google-Smtp-Source: APBJJlHIhhYIDDRcZFjdoEd3CK4wQXFWlTIhkaiipMXKjU/w9eDVUaF0RKUngfEmkJCjmtbmj4YEw7V6JxBDksC3lnw=
X-Received: by 2002:a2e:9250:0:b0:2b6:fe3c:c3c1 with SMTP id
 v16-20020a2e9250000000b002b6fe3cc3c1mr4167361ljg.4.1688746293623; Fri, 07 Jul
 2023 09:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-10-alexei.starovoitov@gmail.com> <fe733a7b-3775-947a-23c0-0dadacabdca2@huaweicloud.com>
 <CAADnVQJ3mNnzKEohRhYfAhBtB6R2Gh9dHAyqSJ5BU5ke+NTVuw@mail.gmail.com>
 <4e0765b7-9054-a33d-8b1e-c986df353848@huaweicloud.com> <CAADnVQJhrbTtuBfexE6NPA6q=cdh1vVxfVQ73ZR2u8ZZWRb+wA@mail.gmail.com>
 <224322d6-28d3-f3b7-fcac-463e5329a082@huaweicloud.com>
In-Reply-To: <224322d6-28d3-f3b7-fcac-463e5329a082@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Jul 2023 09:11:22 -0700
Message-ID: <CAADnVQL5O5uzy=sewNJ=NFSGV7JTb3ONHR=V2kWiT1YdN=ax8g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/14] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
To: Hou Tao <houtao@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 9:37=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 7/7/2023 12:16 PM, Alexei Starovoitov wrote:
> > On Thu, Jul 6, 2023 at 8:39=E2=80=AFPM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> Hi,
> >>
> >> On 7/7/2023 10:12 AM, Alexei Starovoitov wrote:
> >>> On Thu, Jul 6, 2023 at 7:07=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >>>> Hi,
> >>>>
> >>>> On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
> >>>>
> SNIP
> >>> and it's not just waiting_for_gp_ttrace. free_by_rcu_ttrace is simila=
r.
> >> I think free_by_rcu_ttrace is different, because the reuse is only
> >> possible after one tasks trace RCU grace period as shown below, and th=
e
> >> concurrent llist_del_first() must have been completed when the head is
> >> reused and re-added into free_by_rcu_ttrace again.
> >>
> >> // c0->free_by_rcu_ttrace
> >> A -> B -> C -> nil
> >>
> >> P1:
> >> alloc_bulk()
> >>     llist_del_first(&c->free_by_rcu_ttrace)
> >>         entry =3D A
> >>         next =3D B
> >>
> >> P2:
> >> do_call_rcu_ttrace()
> >>     // c->free_by_rcu_ttrace->first =3D NULL
> >>     llist_del_all(&c->free_by_rcu_ttrace)
> >>         move to c->waiting_for_gp_ttrace
> >>
> >> P1:
> >> llist_del_first()
> >>     return NULL
> >>
> >> // A is only reusable after one task trace RCU grace
> >> // llist_del_first() must have been completed
> > "must have been completed" ?
> >
> > I guess you're assuming that alloc_bulk() from irq_work
> > is running within rcu_tasks_trace critical section,
> > so __free_rcu_tasks_trace() callback will execute after
> > irq work completed?
> > I don't think that's the case.
>
> Yes. The following is my original thoughts. Correct me if I was wrong:
>
> 1. llist_del_first() must be running concurrently with llist_del_all().
> If llist_del_first() runs after llist_del_all(), it will return NULL
> directly.
> 2. call_rcu_tasks_trace() must happen after llist_del_all(), else the
> elements in free_by_rcu_ttrace will not be freed back to slab.
> 3. call_rcu_tasks_trace() will wait for one tasks trace RCU grace period
> to call __free_rcu_tasks_trace()
> 4. llist_del_first() in running in an context with irq-disabled, so the
> tasks trace RCU grace period will wait for the end of llist_del_first()
>
> It seems you thought step 4) is not true, right ?

Yes. I think so. For two reasons:

1.
I believe irq disabled region isn't considered equivalent
to rcu_read_lock_trace() region.

Paul,
could you clarify ?

2.
Even if 1 is incorrect, in RT llist_del_first() from alloc_bulk()
runs "in a per-CPU thread in preemptible context."
See irq_work_run_list.

