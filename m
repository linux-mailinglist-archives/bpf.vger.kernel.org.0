Return-Path: <bpf+bounces-4499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9D574B976
	for <lists+bpf@lfdr.de>; Sat,  8 Jul 2023 00:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C8D1C210EA
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 22:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29A017FE4;
	Fri,  7 Jul 2023 22:22:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C517ACA
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 22:22:30 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528712123
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 15:22:27 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso39228631fa.1
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1688768545; x=1691360545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00HfUo8YcXDv95ABX4BX2QfGk15awNjnmrspcBnuyYI=;
        b=S1i7GsgZS6/9vByJU1h9vaPxX6EfILktPvazZWP5Wsw3CH9mTfB2qSik2nthVCjVcH
         dhKZHhoDxrcL3PiB9drM2KpAFU2A0aXDLxFLU1aTmDKKzbg6lZjFobaP2dcbg7nPvqgq
         BkHbFpM4arUw2jbAEns8E4g+OGETlDhouCwVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688768545; x=1691360545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00HfUo8YcXDv95ABX4BX2QfGk15awNjnmrspcBnuyYI=;
        b=Ow3czZwvwKkrN8b52MZeUTRlU6tblhrdqCDvaYp4z8JaFwOmuY7xAlc9pzRGqV6QA9
         Za4bOi9dN51ipb1OrSpgauAY7WSv5OJeOo39QSFZqLWY8dFi7iGuXaOHfS9ovLJfOTJj
         Ks0hIUln2SyBrbgGNqUlqZvTwd7o6PYwYY2yIkqeCZWYy596SnaLI4zlSJsOTZp68knJ
         0RibrnQU1C0kfoQHLieUAd9GiZvHkOcPdKW5euudg+wdMxK3oZiMrP2XhKVuPO1HVLAx
         C4G9xgWH79BlhLlHHO6+VLtKf0uhAivi5YCez+YuC8Zirpym9+H55QbCSRrdNRNaKjQ7
         TFJA==
X-Gm-Message-State: ABy/qLYNuYHxsysJOTB6dLJfqMqywXoyAZuFut531wIiISsIzR8ldeG2
	NO7Ulk5LgZVwuYUqs+EjcqvfRfDkQ8/jRokakE8A1g==
X-Google-Smtp-Source: APBJJlGTfh3AMzN+1kdBePEo+sjnOFVyLZ+VfqZo0TJaDLXkoafqQ6YreSHG/oLP8hvr6qZ9xVkcY4QZq4PnYX82CO4=
X-Received: by 2002:a2e:9d16:0:b0:2b6:e2cd:20f5 with SMTP id
 t22-20020a2e9d16000000b002b6e2cd20f5mr4795299lji.9.1688768545324; Fri, 07 Jul
 2023 15:22:25 -0700 (PDT)
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
 <224322d6-28d3-f3b7-fcac-463e5329a082@huaweicloud.com> <CAADnVQL5O5uzy=sewNJ=NFSGV7JTb3ONHR=V2kWiT1YdN=ax8g@mail.gmail.com>
 <3f72c4e7-340f-4374-9ebe-f9bffd08c755@paulmck-laptop>
In-Reply-To: <3f72c4e7-340f-4374-9ebe-f9bffd08c755@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 7 Jul 2023 18:22:13 -0400
Message-ID: <CAEXW_YRzJQvX+GVR0+jSDiL9phNgf1-NzH+B7UaCVtGBVT18Yg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/14] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
To: paulmck@kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hou Tao <houtao@huaweicloud.com>, 
	Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 1:47=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Fri, Jul 07, 2023 at 09:11:22AM -0700, Alexei Starovoitov wrote:
> > On Thu, Jul 6, 2023 at 9:37=E2=80=AFPM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> > >
> > > Hi,
> > >
> > > On 7/7/2023 12:16 PM, Alexei Starovoitov wrote:
> > > > On Thu, Jul 6, 2023 at 8:39=E2=80=AFPM Hou Tao <houtao@huaweicloud.=
com> wrote:
> > > >> Hi,
> > > >>
> > > >> On 7/7/2023 10:12 AM, Alexei Starovoitov wrote:
> > > >>> On Thu, Jul 6, 2023 at 7:07=E2=80=AFPM Hou Tao <houtao@huaweiclou=
d.com> wrote:
> > > >>>> Hi,
> > > >>>>
> > > >>>> On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
> > > >>>>
> > > SNIP
> > > >>> and it's not just waiting_for_gp_ttrace. free_by_rcu_ttrace is si=
milar.
> > > >> I think free_by_rcu_ttrace is different, because the reuse is only
> > > >> possible after one tasks trace RCU grace period as shown below, an=
d the
> > > >> concurrent llist_del_first() must have been completed when the hea=
d is
> > > >> reused and re-added into free_by_rcu_ttrace again.
> > > >>
> > > >> // c0->free_by_rcu_ttrace
> > > >> A -> B -> C -> nil
> > > >>
> > > >> P1:
> > > >> alloc_bulk()
> > > >>     llist_del_first(&c->free_by_rcu_ttrace)
> > > >>         entry =3D A
> > > >>         next =3D B
> > > >>
> > > >> P2:
> > > >> do_call_rcu_ttrace()
> > > >>     // c->free_by_rcu_ttrace->first =3D NULL
> > > >>     llist_del_all(&c->free_by_rcu_ttrace)
> > > >>         move to c->waiting_for_gp_ttrace
> > > >>
> > > >> P1:
> > > >> llist_del_first()
> > > >>     return NULL
> > > >>
> > > >> // A is only reusable after one task trace RCU grace
> > > >> // llist_del_first() must have been completed
> > > > "must have been completed" ?
> > > >
> > > > I guess you're assuming that alloc_bulk() from irq_work
> > > > is running within rcu_tasks_trace critical section,
> > > > so __free_rcu_tasks_trace() callback will execute after
> > > > irq work completed?
> > > > I don't think that's the case.
> > >
> > > Yes. The following is my original thoughts. Correct me if I was wrong=
:
> > >
> > > 1. llist_del_first() must be running concurrently with llist_del_all(=
).
> > > If llist_del_first() runs after llist_del_all(), it will return NULL
> > > directly.
> > > 2. call_rcu_tasks_trace() must happen after llist_del_all(), else the
> > > elements in free_by_rcu_ttrace will not be freed back to slab.
> > > 3. call_rcu_tasks_trace() will wait for one tasks trace RCU grace per=
iod
> > > to call __free_rcu_tasks_trace()
> > > 4. llist_del_first() in running in an context with irq-disabled, so t=
he
> > > tasks trace RCU grace period will wait for the end of llist_del_first=
()
> > >
> > > It seems you thought step 4) is not true, right ?
> >
> > Yes. I think so. For two reasons:
> >
> > 1.
> > I believe irq disabled region isn't considered equivalent
> > to rcu_read_lock_trace() region.
> >
> > Paul,
> > could you clarify ?
>
> You are correct, Alexei.  Unlike vanilla RCU, RCU Tasks Trace does not
> count irq-disabled regions of code as readers.
>
> But why not just put an rcu_read_lock_trace() and a matching
> rcu_read_unlock_trace() within that irq-disabled region of code?
>
> For completeness, if it were not for CONFIG_TASKS_TRACE_RCU_READ_MB,
> Hou Tao would be correct from a strict current-implementation
> viewpoint.  The reason is that, given the current implementation in
> CONFIG_TASKS_TRACE_RCU_READ_MB=3Dn kernels, a task must either block or
> take an IPI in order for the grace-period machinery to realize that this
> task is done with all prior readers.
>
> However, we need to account for the possibility of IPI-free
> implementations, for example, if the real-time guys decide to start
> making heavy use of BPF sleepable programs.  They would then insist on
> getting rid of those IPIs for CONFIG_PREEMPT_RT=3Dy kernels.  At which
> point, irq-disabled regions of code will absolutely not act as
> RCU tasks trace readers.
>
> Again, why not just put an rcu_read_lock_trace() and a matching
> rcu_read_unlock_trace() within that irq-disabled region of code?

If I remember correctly, the general guidance is to always put an
explicit marker if it is in an RCU-reader, instead of relying on
implementation details. So the suggestion to put the marker instead of
relying on IRQ disabling does align with that.

Thanks.

