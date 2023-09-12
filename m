Return-Path: <bpf+bounces-9810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF71479DBCA
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE5A1C20EFD
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E8C126;
	Tue, 12 Sep 2023 22:21:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7FBE61
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 22:21:16 +0000 (UTC)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C96E10C8;
	Tue, 12 Sep 2023 15:21:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 2adb3069b0e04-500c7796d8eso10251800e87.1;
        Tue, 12 Sep 2023 15:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694557274; x=1695162074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STtBbcPGoMcBx0hfO9mfqv7R56JxJw1TcuLXkgjU0q8=;
        b=Nnm6lJC43hHDCI0phWASIH+2vErL855pQhEa+cRrUoLkacME+EE+zNEbUlQHzndxRL
         i/WIUhe60fqLVQd3FR5/fdvxAWT8CdNzwyGFTopya+PN1Hy7Df6ec2LVyxFs6/06+5BS
         0iAcYuxSVSkPw65PAKZWgsV47/QDjC6tDaiBour2uj/i1wXPVfFRWEKwtMr2s+lh1Osl
         LCD5hY2fx/Gx6U7esreVgMQHAbTwtFMQ/g+c2gM1I7jNScbr75MVCQHamJZcrePFrPOH
         C7WFy7za07d1+bAbU4UElazgFdSfxwUHZTIRhpKJZZ+21JvTZn/Nr+usunpHGYVcq4gz
         4sDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694557274; x=1695162074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STtBbcPGoMcBx0hfO9mfqv7R56JxJw1TcuLXkgjU0q8=;
        b=isSj/kEWVSv9rQXuVrpHO8SQtAiX/2VyMNL79kuL09tYki8Guq3xBLtTmJODhBeMzh
         vmMLDmUIx36l5BVlKnyVTxOjIrHTGU0Kv5tRd47SFKZB4q/ZLeZ9W0745PCfsJcxGkPl
         xf85+1UheA2+OCfwZONqPLpTRzznKU8V0F6cyzAegBKJCrVCWmvc4D/Z/mOGh3peW3cA
         fIEU43tc589biFSdfA9A2IHnG/kp55RIZm9g/c1EY40TClxy9wO+16CjR+uTgSxm7igs
         1MYa2I+YzUqTVQT4uTpSDII39zMrqmuyWPzxuYp9bb7Y8duZ+E28prl9MipE5LuizYoN
         0v6A==
X-Gm-Message-State: AOJu0Yx2b2fRnLINC2iAsGOYVmQTcBYSxgeZaG5btUQOj+JrbGovQlGP
	SgfC8TypkxWuO6+pznDaxptB3uZ8MsGbU2I9km0=
X-Google-Smtp-Source: AGHT+IHqWt89jEOy0lUp+7S5Wz09Xbyhrbmv9phVK6VQ47mm14FgWKwDKo6HIZG+QY97QBItZ7Q2XqCq86/5BIiWrC8=
X-Received: by 2002:a05:6512:108a:b0:500:a39a:1b99 with SMTP id
 j10-20020a056512108a00b00500a39a1b99mr604143lfg.38.1694557273959; Tue, 12 Sep
 2023 15:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-3-zhouchuyi@bytedance.com> <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
 <e5e986a0-0bb9-6611-77f0-f8472346965e@bytedance.com> <CAADnVQL-ZGV6C7VWdQpX64f0+gokE5MLBO3F2J3WyMoq-_NCPg@mail.gmail.com>
 <CAEf4BzaEg5CieQKQxvRGnwnyeK_2MZqr8ROVjg-Tftg-0vpntg@mail.gmail.com>
In-Reply-To: <CAEf4BzaEg5CieQKQxvRGnwnyeK_2MZqr8ROVjg-Tftg-0vpntg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 13 Sep 2023 00:20:38 +0200
Message-ID: <CAP01T77cWxWNwq5HLr+Woiu7k4-P3QQfJWX1OeQJUkxW3=P4bA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded
 iterator kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Sept 2023 at 00:12, Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 6, 2023 at 10:18=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Sep 6, 2023 at 5:38=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.=
com> wrote:
> > >
> > > Hello, Alexei.
> > >
> > > =E5=9C=A8 2023/9/6 04:09, Alexei Starovoitov =E5=86=99=E9=81=93:
> > > > On Sun, Aug 27, 2023 at 12:21=E2=80=AFAM Chuyi Zhou <zhouchuyi@byte=
dance.com> wrote:
> > > >>
> > > >> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which a=
llow
> > > >> creation and manipulation of struct bpf_iter_process in open-coded=
 iterator
> > > >> style. BPF programs can use these kfuncs or through bpf_for_each m=
acro to
> > > >> iterate all processes in the system.
> > > >>
> > > >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> > > >> ---
> > > >>   include/uapi/linux/bpf.h       |  4 ++++
> > > >>   kernel/bpf/helpers.c           |  3 +++
> > > >>   kernel/bpf/task_iter.c         | 31 ++++++++++++++++++++++++++++=
+++
> > > >>   tools/include/uapi/linux/bpf.h |  4 ++++
> > > >>   tools/lib/bpf/bpf_helpers.h    |  5 +++++
> > > >>   5 files changed, 47 insertions(+)
> > > >>
> > > >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > >> index 2a6e9b99564b..cfbd527e3733 100644
> > > >> --- a/include/uapi/linux/bpf.h
> > > >> +++ b/include/uapi/linux/bpf.h
> > > >> @@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
> > > >>          __u64 __opaque[1];
> > > >>   } __attribute__((aligned(8)));
> > > >>
> > > >> +struct bpf_iter_process {
> > > >> +       __u64 __opaque[1];
> > > >> +} __attribute__((aligned(8)));
> > > >> +
> > > >>   #endif /* _UAPI__LINUX_BPF_H__ */
> > > >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > >> index cf113ad24837..81a2005edc26 100644
> > > >> --- a/kernel/bpf/helpers.c
> > > >> +++ b/kernel/bpf/helpers.c
> > > >> @@ -2458,6 +2458,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_=
ITER_DESTROY)
> > > >>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
> > > >>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET=
_NULL)
> > > >>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> > > >> +BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
> > > >> +BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_N=
ULL)
> > > >> +BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
> > > >>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> > > >>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> > > >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> > > >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > > >> index b1bdba40b684..a6717a76c1e0 100644
> > > >> --- a/kernel/bpf/task_iter.c
> > > >> +++ b/kernel/bpf/task_iter.c
> > > >> @@ -862,6 +862,37 @@ __bpf_kfunc void bpf_iter_css_task_destroy(st=
ruct bpf_iter_css_task *it)
> > > >>          kfree(kit->css_it);
> > > >>   }
> > > >>
> > > >> +struct bpf_iter_process_kern {
> > > >> +       struct task_struct *tsk;
> > > >> +} __attribute__((aligned(8)));
> > > >> +
> > > >> +__bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
> > > >> +{
> > > >> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> > > >> +
> > > >> +       BUILD_BUG_ON(sizeof(struct bpf_iter_process_kern) !=3D siz=
eof(struct bpf_iter_process));
> > > >> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_process_kern) !=
=3D
> > > >> +                                       __alignof__(struct bpf_ite=
r_process));
> > > >> +
> > > >> +       rcu_read_lock();
> > > >> +       kit->tsk =3D &init_task;
> > > >> +       return 0;
> > > >> +}
> > > >> +
> > > >> +__bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_=
iter_process *it)
> > > >> +{
> > > >> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> > > >> +
> > > >> +       kit->tsk =3D next_task(kit->tsk);
> > > >> +
> > > >> +       return kit->tsk =3D=3D &init_task ? NULL : kit->tsk;
> > > >> +}
> > > >> +
> > > >> +__bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process=
 *it)
> > > >> +{
> > > >> +       rcu_read_unlock();
> > > >> +}
> > > >
> > > > This iter can be used in all ctx-s which is nice, but let's
> > > > make the verifier enforce rcu_read_lock/unlock done by bpf prog
> > > > instead of doing in the ctor/dtor of iter, since
> > > > in sleepable progs the verifier won't recognize that body is RCU CS=
.
> > > > We'd need to teach the verifier to allow bpf_iter_process_new()
> > > > inside in_rcu_cs() and make sure there is no rcu_read_unlock
> > > > while BPF_ITER_STATE_ACTIVE.
> > > > bpf_iter_process_destroy() would become a nop.
> > >
> > > Thanks for your review!
> > >
> > > I think bpf_iter_process_{new, next, destroy} should be protected by
> > > bpf_rcu_read_lock/unlock explicitly whether the prog is sleepable or
> > > not, right?
> >
> > Correct. By explicit bpf_rcu_read_lock() in case of sleepable progs
> > or just by using them in normal bpf progs that have implicit rcu_read_l=
ock()
> > done before calling into them.
> >
> > > I'm not very familiar with the BPF verifier, but I believe
> > > there is still a risk in directly calling these kfuns even if
> > > in_rcu_cs() is true.
> > >
> > > Maby what we actually need here is to enforce BPF verifier to check
> > > env->cur_state->active_rcu_lock is true when we want to call these kf=
uncs.
> >
> > active_rcu_lock means explicit bpf_rcu_read_lock.
> > Currently we do allow bpf_rcu_read_lock in non-sleepable, but it's poin=
tless.
> >
> > Technically we can extend the check:
> >                 if (in_rbtree_lock_required_cb(env) && (rcu_lock ||
> > rcu_unlock)) {
> >                         verbose(env, "Calling
> > bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
> >                         return -EACCES;
> >                 }
> > to discourage their use in all non-sleepable, but it will break some pr=
ogs.
> >
> > I think it's ok to check in_rcu_cs() to allow bpf_iter_process_*().
> > If bpf prog adds explicit and unnecessary bpf_rcu_read_lock() around
> > the iter ops it won't do any harm.
> > Just need to make sure that rcu unlock logic:
> >                 } else if (rcu_unlock) {
> >                         bpf_for_each_reg_in_vstate(env->cur_state,
> > state, reg, ({
> >                                 if (reg->type & MEM_RCU) {
> >                                         reg->type &=3D ~(MEM_RCU |
> > PTR_MAYBE_NULL);
> >                                         reg->type |=3D PTR_UNTRUSTED;
> >                                 }
> >                         }));
> > clears iter state that depends on rcu.
> >
> > I thought about changing mark_stack_slots_iter() to do
> > st->type =3D PTR_TO_STACK | MEM_RCU;
> > so that the above clearing logic kicks in,
> > but it might be better to have something iter specific.
> > is_iter_reg_valid_init() should probably be changed to
> > make sure reg->type is not UNTRUSTED.
> >
> > Andrii,
> > do you have better suggestions?
>
> What if we just remember inside bpf_reg_state.iter state whether
> iterator needs to be RCU protected (it's just one bit if we don't
> allow nesting rcu_read_lock()/rcu_read_unlock(), or we'd need to
> remember RCU nestedness level), and then when validating iter_next and
> iter_destroy() kfuncs, check that we are still in RCU-protected region
> (if we have nestedness, then iter->rcu_nest_level <=3D
> cur_rcu_nest_level, if I understand correctly). And if not, provide a
> clear and nice message.
>
> That seems straightforward enough, but am I missing anything subtle?
>

We also need to ensure one does not do a bpf_rcu_read_unlock and
bpf_rcu_read_lock again between the iter_new and
iter_next/iter_destroy calls. Simply checking we are in an RCU
protected region will pass the verifier in such a case.

A simple solution might be associating an ID with the RCU CS, so make
active_rcu_lock a 32-bit ID which is monotonically increasing for each
new RCU region. Ofcourse, all of this only matters for sleepable
programs. Then check if id recorded in iter state is same on next and
destroy.

