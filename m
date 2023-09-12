Return-Path: <bpf+bounces-9807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAA479DBB9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20243281F87
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E6BA3B;
	Tue, 12 Sep 2023 22:12:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC2BA22
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 22:12:47 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7266210DF;
	Tue, 12 Sep 2023 15:12:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so784875566b.1;
        Tue, 12 Sep 2023 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694556765; x=1695161565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IJfarNrrigVZ6GT5z4GlrFnGstC/W9B80yBZkpCLS4=;
        b=jG5zbqICHDkZbcu7osSx3Aywz7K2dqp2HwIw3Lo2/CTjkUOsKm28EK0IH9XRwOJz1O
         VdNrJ8y7JKwO4NatztujZgobcEG7i8W4jzRy1SUnMIXDE4bv+SAj1qR9YKTtzLMyv8r9
         vF5RbqVwtYuk14cSyMzVPOk9JRticIGJHS0ctKak1/+4xPpukiID6TBi8DZwkdDgqvSm
         M7zf5RN4p0Nb98lImA1svMJlA37QLSeajf4t7WKf0cOOZMHqlsHjfqemH3ai1npsRC5z
         CVi8l1keLeQPu7Q8vXvAI/jdwV8sHOmqLxG4wLho9o4VMdRUncsqt8ttoAhwLohu9dO1
         nLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694556765; x=1695161565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IJfarNrrigVZ6GT5z4GlrFnGstC/W9B80yBZkpCLS4=;
        b=Uje/s1QbNbbBFUKHlIXa0ByGFEihlkEYLA6O71yq+KqhmShc/JabMnAU8e4dMZ2hNa
         5S/IfMkpJCQIJ7e1uGvoa7GzLR2tpYpbj+PpfeP1l8snQwyJN3+Bcyx3QoZHEpT0oB0G
         huQFzfoBUzYyRSboqCGzOsoI4rzvwvw1gKARJele7KP83Mfsfgh7TlNT/a8VDXgsjEax
         OC7DIEDpgc9CLxGQKk07YmqEBxPtmKOBoLGf0aMuyVNDcIaRtPUDlQ2NT1fOFYJ62pFQ
         7L+kDm48wOO34uc7B3QCujrOfLEWeQ31aEBbip01d1pUCvV7mks81m6oEgc33rkwXoqQ
         /6ww==
X-Gm-Message-State: AOJu0YxVx1nFH6uksK4l8hfFBbpSVr31BTSX3D2cgVsk8ddzfyowFqnS
	Ef9O1Pu2oej0E/Qzka7crfPwxXtJ0oIiO0yLSuk=
X-Google-Smtp-Source: AGHT+IHYQvrjubMQhINvNX+TvJ1lH22YqclR1lkWh05N3akJpE3xw5vL2h5KfzfpFXC3H+6MLb0g80B8fG48I1pHKJk=
X-Received: by 2002:a17:907:2c4f:b0:9a1:fab3:ee43 with SMTP id
 hf15-20020a1709072c4f00b009a1fab3ee43mr436753ejc.0.1694556764468; Tue, 12 Sep
 2023 15:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-3-zhouchuyi@bytedance.com> <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
 <e5e986a0-0bb9-6611-77f0-f8472346965e@bytedance.com> <CAADnVQL-ZGV6C7VWdQpX64f0+gokE5MLBO3F2J3WyMoq-_NCPg@mail.gmail.com>
In-Reply-To: <CAADnVQL-ZGV6C7VWdQpX64f0+gokE5MLBO3F2J3WyMoq-_NCPg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Sep 2023 15:12:33 -0700
Message-ID: <CAEf4BzaEg5CieQKQxvRGnwnyeK_2MZqr8ROVjg-Tftg-0vpntg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2023 at 10:18=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 6, 2023 at 5:38=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.co=
m> wrote:
> >
> > Hello, Alexei.
> >
> > =E5=9C=A8 2023/9/6 04:09, Alexei Starovoitov =E5=86=99=E9=81=93:
> > > On Sun, Aug 27, 2023 at 12:21=E2=80=AFAM Chuyi Zhou <zhouchuyi@byteda=
nce.com> wrote:
> > >>
> > >> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which all=
ow
> > >> creation and manipulation of struct bpf_iter_process in open-coded i=
terator
> > >> style. BPF programs can use these kfuncs or through bpf_for_each mac=
ro to
> > >> iterate all processes in the system.
> > >>
> > >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> > >> ---
> > >>   include/uapi/linux/bpf.h       |  4 ++++
> > >>   kernel/bpf/helpers.c           |  3 +++
> > >>   kernel/bpf/task_iter.c         | 31 ++++++++++++++++++++++++++++++=
+
> > >>   tools/include/uapi/linux/bpf.h |  4 ++++
> > >>   tools/lib/bpf/bpf_helpers.h    |  5 +++++
> > >>   5 files changed, 47 insertions(+)
> > >>
> > >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >> index 2a6e9b99564b..cfbd527e3733 100644
> > >> --- a/include/uapi/linux/bpf.h
> > >> +++ b/include/uapi/linux/bpf.h
> > >> @@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
> > >>          __u64 __opaque[1];
> > >>   } __attribute__((aligned(8)));
> > >>
> > >> +struct bpf_iter_process {
> > >> +       __u64 __opaque[1];
> > >> +} __attribute__((aligned(8)));
> > >> +
> > >>   #endif /* _UAPI__LINUX_BPF_H__ */
> > >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > >> index cf113ad24837..81a2005edc26 100644
> > >> --- a/kernel/bpf/helpers.c
> > >> +++ b/kernel/bpf/helpers.c
> > >> @@ -2458,6 +2458,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_IT=
ER_DESTROY)
> > >>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
> > >>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_N=
ULL)
> > >>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> > >> +BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
> > >> +BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NUL=
L)
> > >> +BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
> > >>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> > >>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> > >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> > >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > >> index b1bdba40b684..a6717a76c1e0 100644
> > >> --- a/kernel/bpf/task_iter.c
> > >> +++ b/kernel/bpf/task_iter.c
> > >> @@ -862,6 +862,37 @@ __bpf_kfunc void bpf_iter_css_task_destroy(stru=
ct bpf_iter_css_task *it)
> > >>          kfree(kit->css_it);
> > >>   }
> > >>
> > >> +struct bpf_iter_process_kern {
> > >> +       struct task_struct *tsk;
> > >> +} __attribute__((aligned(8)));
> > >> +
> > >> +__bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
> > >> +{
> > >> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> > >> +
> > >> +       BUILD_BUG_ON(sizeof(struct bpf_iter_process_kern) !=3D sizeo=
f(struct bpf_iter_process));
> > >> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_process_kern) !=3D
> > >> +                                       __alignof__(struct bpf_iter_=
process));
> > >> +
> > >> +       rcu_read_lock();
> > >> +       kit->tsk =3D &init_task;
> > >> +       return 0;
> > >> +}
> > >> +
> > >> +__bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_it=
er_process *it)
> > >> +{
> > >> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> > >> +
> > >> +       kit->tsk =3D next_task(kit->tsk);
> > >> +
> > >> +       return kit->tsk =3D=3D &init_task ? NULL : kit->tsk;
> > >> +}
> > >> +
> > >> +__bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *=
it)
> > >> +{
> > >> +       rcu_read_unlock();
> > >> +}
> > >
> > > This iter can be used in all ctx-s which is nice, but let's
> > > make the verifier enforce rcu_read_lock/unlock done by bpf prog
> > > instead of doing in the ctor/dtor of iter, since
> > > in sleepable progs the verifier won't recognize that body is RCU CS.
> > > We'd need to teach the verifier to allow bpf_iter_process_new()
> > > inside in_rcu_cs() and make sure there is no rcu_read_unlock
> > > while BPF_ITER_STATE_ACTIVE.
> > > bpf_iter_process_destroy() would become a nop.
> >
> > Thanks for your review!
> >
> > I think bpf_iter_process_{new, next, destroy} should be protected by
> > bpf_rcu_read_lock/unlock explicitly whether the prog is sleepable or
> > not, right?
>
> Correct. By explicit bpf_rcu_read_lock() in case of sleepable progs
> or just by using them in normal bpf progs that have implicit rcu_read_loc=
k()
> done before calling into them.
>
> > I'm not very familiar with the BPF verifier, but I believe
> > there is still a risk in directly calling these kfuns even if
> > in_rcu_cs() is true.
> >
> > Maby what we actually need here is to enforce BPF verifier to check
> > env->cur_state->active_rcu_lock is true when we want to call these kfun=
cs.
>
> active_rcu_lock means explicit bpf_rcu_read_lock.
> Currently we do allow bpf_rcu_read_lock in non-sleepable, but it's pointl=
ess.
>
> Technically we can extend the check:
>                 if (in_rbtree_lock_required_cb(env) && (rcu_lock ||
> rcu_unlock)) {
>                         verbose(env, "Calling
> bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
>                         return -EACCES;
>                 }
> to discourage their use in all non-sleepable, but it will break some prog=
s.
>
> I think it's ok to check in_rcu_cs() to allow bpf_iter_process_*().
> If bpf prog adds explicit and unnecessary bpf_rcu_read_lock() around
> the iter ops it won't do any harm.
> Just need to make sure that rcu unlock logic:
>                 } else if (rcu_unlock) {
>                         bpf_for_each_reg_in_vstate(env->cur_state,
> state, reg, ({
>                                 if (reg->type & MEM_RCU) {
>                                         reg->type &=3D ~(MEM_RCU |
> PTR_MAYBE_NULL);
>                                         reg->type |=3D PTR_UNTRUSTED;
>                                 }
>                         }));
> clears iter state that depends on rcu.
>
> I thought about changing mark_stack_slots_iter() to do
> st->type =3D PTR_TO_STACK | MEM_RCU;
> so that the above clearing logic kicks in,
> but it might be better to have something iter specific.
> is_iter_reg_valid_init() should probably be changed to
> make sure reg->type is not UNTRUSTED.
>
> Andrii,
> do you have better suggestions?

What if we just remember inside bpf_reg_state.iter state whether
iterator needs to be RCU protected (it's just one bit if we don't
allow nesting rcu_read_lock()/rcu_read_unlock(), or we'd need to
remember RCU nestedness level), and then when validating iter_next and
iter_destroy() kfuncs, check that we are still in RCU-protected region
(if we have nestedness, then iter->rcu_nest_level <=3D
cur_rcu_nest_level, if I understand correctly). And if not, provide a
clear and nice message.

That seems straightforward enough, but am I missing anything subtle?

