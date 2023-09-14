Return-Path: <bpf+bounces-10066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A777A0B62
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6C61C20DED
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC7F26299;
	Thu, 14 Sep 2023 17:16:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC1208A1
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 17:16:21 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97531CF;
	Thu, 14 Sep 2023 10:16:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-530196c780dso1077334a12.1;
        Thu, 14 Sep 2023 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694711779; x=1695316579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wR8njeDBhvSDtR6lVlpBWKsc/TiwJI5inQMLli8IvXE=;
        b=nQJeEWkB+r1rSts6S53Kz9LEBZCCrZ/+qfTPzGQpQZjAPZ5BoUcKQCSimEzzZpudgj
         gcig6NIseLRg0hO5b4Fl3OlllB9rSIg2JAuK3G5tNgMnQQpnDrfT2DzV8ro3lNdGlKAB
         c/IMLkytIAgNaJr62BvEbbQ6Ag7pcZ52aQs1ezXeHjdzaLupaMQabTpr5li0arXwfsWj
         VcV9psWe6iTNhX1eGBQWcvIxsu/Mrz08u4XEb4NjW/SUHR3rc+cTNMBEB06ANCCmgsxB
         skax4ZX4ppkGzSyGEz0U9+3AWngUxV29/OjIojn85qhO2w1D+w/r581Oo4QCYFturNtW
         KT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694711779; x=1695316579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR8njeDBhvSDtR6lVlpBWKsc/TiwJI5inQMLli8IvXE=;
        b=M7ial1aC0cxWWQwzF2J2fqAvF2uK3sghgX3AdVLdkACIcXL1osDeYuYaxd4WfgQTem
         G00uMHHvd1GENfzFU3PQpN8UtufeVBE3Ww4hwJgVurigQdl3q4exVr3XlZINsnQwT7Oa
         CQyP5iMXhhCqeiKKsVVnzSG5tSnhlUbdjoRUaffb10V98RbjUOQJAIrcxJxJ/TOFp/wy
         SqXdaR+BNOY8z9x56Fn5maFLGwCgQdmpzq18WIfBUTcl7OGlBjXbV+5YoiRt32jjj6+G
         5BW6BCA9Uw9Z0wQgBLBjmeUbkJTbK9KjNAMFM9CXxz73SHKE3XEVpd7a6isVIXwzGXx+
         vuIw==
X-Gm-Message-State: AOJu0YyjB9hhRri/D6i+ysJr81117y6zTUYYWyjwQxOlzH9POV1ayypR
	C763y0gJ9lEEQ9IfCXikDaMic+8P1ZoCM36Zwmw=
X-Google-Smtp-Source: AGHT+IG7AECGJCQlEUvPgHVZQrQ8QYcBqANrfXJzC9D4NyMNu7aYNrTVzEh+oErPxr/zoB/QsSAcX2ThZYlCrMlytaQ=
X-Received: by 2002:aa7:c1d1:0:b0:525:6588:b624 with SMTP id
 d17-20020aa7c1d1000000b005256588b624mr5479932edp.37.1694711778617; Thu, 14
 Sep 2023 10:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-3-zhouchuyi@bytedance.com> <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
 <e5e986a0-0bb9-6611-77f0-f8472346965e@bytedance.com> <CAADnVQL-ZGV6C7VWdQpX64f0+gokE5MLBO3F2J3WyMoq-_NCPg@mail.gmail.com>
 <CAEf4BzaEg5CieQKQxvRGnwnyeK_2MZqr8ROVjg-Tftg-0vpntg@mail.gmail.com> <CAP01T77cWxWNwq5HLr+Woiu7k4-P3QQfJWX1OeQJUkxW3=P4bA@mail.gmail.com>
In-Reply-To: <CAP01T77cWxWNwq5HLr+Woiu7k4-P3QQfJWX1OeQJUkxW3=P4bA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Sep 2023 10:16:06 -0700
Message-ID: <CAEf4BzY+BuTfLfamUVCGk+3kY2O5BtTvWiXQRn5OcXt4P2md2g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded
 iterator kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 3:21=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 13 Sept 2023 at 00:12, Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Sep 6, 2023 at 10:18=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Sep 6, 2023 at 5:38=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedanc=
e.com> wrote:
> > > >
> > > > Hello, Alexei.
> > > >
> > > > =E5=9C=A8 2023/9/6 04:09, Alexei Starovoitov =E5=86=99=E9=81=93:
> > > > > On Sun, Aug 27, 2023 at 12:21=E2=80=AFAM Chuyi Zhou <zhouchuyi@by=
tedance.com> wrote:
> > > > >>
> > > > >> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which=
 allow
> > > > >> creation and manipulation of struct bpf_iter_process in open-cod=
ed iterator
> > > > >> style. BPF programs can use these kfuncs or through bpf_for_each=
 macro to
> > > > >> iterate all processes in the system.
> > > > >>
> > > > >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> > > > >> ---
> > > > >>   include/uapi/linux/bpf.h       |  4 ++++
> > > > >>   kernel/bpf/helpers.c           |  3 +++
> > > > >>   kernel/bpf/task_iter.c         | 31 ++++++++++++++++++++++++++=
+++++
> > > > >>   tools/include/uapi/linux/bpf.h |  4 ++++
> > > > >>   tools/lib/bpf/bpf_helpers.h    |  5 +++++
> > > > >>   5 files changed, 47 insertions(+)
> > > > >>
> > > > >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > >> index 2a6e9b99564b..cfbd527e3733 100644
> > > > >> --- a/include/uapi/linux/bpf.h
> > > > >> +++ b/include/uapi/linux/bpf.h
> > > > >> @@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
> > > > >>          __u64 __opaque[1];
> > > > >>   } __attribute__((aligned(8)));
> > > > >>
> > > > >> +struct bpf_iter_process {
> > > > >> +       __u64 __opaque[1];
> > > > >> +} __attribute__((aligned(8)));
> > > > >> +
> > > > >>   #endif /* _UAPI__LINUX_BPF_H__ */
> > > > >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > >> index cf113ad24837..81a2005edc26 100644
> > > > >> --- a/kernel/bpf/helpers.c
> > > > >> +++ b/kernel/bpf/helpers.c
> > > > >> @@ -2458,6 +2458,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, K=
F_ITER_DESTROY)
> > > > >>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
> > > > >>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_R=
ET_NULL)
> > > > >>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> > > > >> +BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
> > > > >> +BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET=
_NULL)
> > > > >> +BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
> > > > >>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> > > > >>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> > > > >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> > > > >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > > > >> index b1bdba40b684..a6717a76c1e0 100644
> > > > >> --- a/kernel/bpf/task_iter.c
> > > > >> +++ b/kernel/bpf/task_iter.c
> > > > >> @@ -862,6 +862,37 @@ __bpf_kfunc void bpf_iter_css_task_destroy(=
struct bpf_iter_css_task *it)
> > > > >>          kfree(kit->css_it);
> > > > >>   }
> > > > >>
> > > > >> +struct bpf_iter_process_kern {
> > > > >> +       struct task_struct *tsk;
> > > > >> +} __attribute__((aligned(8)));
> > > > >> +
> > > > >> +__bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *i=
t)
> > > > >> +{
> > > > >> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> > > > >> +
> > > > >> +       BUILD_BUG_ON(sizeof(struct bpf_iter_process_kern) !=3D s=
izeof(struct bpf_iter_process));
> > > > >> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_process_kern) !=
=3D
> > > > >> +                                       __alignof__(struct bpf_i=
ter_process));
> > > > >> +
> > > > >> +       rcu_read_lock();
> > > > >> +       kit->tsk =3D &init_task;
> > > > >> +       return 0;
> > > > >> +}
> > > > >> +
> > > > >> +__bpf_kfunc struct task_struct *bpf_iter_process_next(struct bp=
f_iter_process *it)
> > > > >> +{
> > > > >> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> > > > >> +
> > > > >> +       kit->tsk =3D next_task(kit->tsk);
> > > > >> +
> > > > >> +       return kit->tsk =3D=3D &init_task ? NULL : kit->tsk;
> > > > >> +}
> > > > >> +
> > > > >> +__bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_proce=
ss *it)
> > > > >> +{
> > > > >> +       rcu_read_unlock();
> > > > >> +}
> > > > >
> > > > > This iter can be used in all ctx-s which is nice, but let's
> > > > > make the verifier enforce rcu_read_lock/unlock done by bpf prog
> > > > > instead of doing in the ctor/dtor of iter, since
> > > > > in sleepable progs the verifier won't recognize that body is RCU =
CS.
> > > > > We'd need to teach the verifier to allow bpf_iter_process_new()
> > > > > inside in_rcu_cs() and make sure there is no rcu_read_unlock
> > > > > while BPF_ITER_STATE_ACTIVE.
> > > > > bpf_iter_process_destroy() would become a nop.
> > > >
> > > > Thanks for your review!
> > > >
> > > > I think bpf_iter_process_{new, next, destroy} should be protected b=
y
> > > > bpf_rcu_read_lock/unlock explicitly whether the prog is sleepable o=
r
> > > > not, right?
> > >
> > > Correct. By explicit bpf_rcu_read_lock() in case of sleepable progs
> > > or just by using them in normal bpf progs that have implicit rcu_read=
_lock()
> > > done before calling into them.
> > >
> > > > I'm not very familiar with the BPF verifier, but I believe
> > > > there is still a risk in directly calling these kfuns even if
> > > > in_rcu_cs() is true.
> > > >
> > > > Maby what we actually need here is to enforce BPF verifier to check
> > > > env->cur_state->active_rcu_lock is true when we want to call these =
kfuncs.
> > >
> > > active_rcu_lock means explicit bpf_rcu_read_lock.
> > > Currently we do allow bpf_rcu_read_lock in non-sleepable, but it's po=
intless.
> > >
> > > Technically we can extend the check:
> > >                 if (in_rbtree_lock_required_cb(env) && (rcu_lock ||
> > > rcu_unlock)) {
> > >                         verbose(env, "Calling
> > > bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
> > >                         return -EACCES;
> > >                 }
> > > to discourage their use in all non-sleepable, but it will break some =
progs.
> > >
> > > I think it's ok to check in_rcu_cs() to allow bpf_iter_process_*().
> > > If bpf prog adds explicit and unnecessary bpf_rcu_read_lock() around
> > > the iter ops it won't do any harm.
> > > Just need to make sure that rcu unlock logic:
> > >                 } else if (rcu_unlock) {
> > >                         bpf_for_each_reg_in_vstate(env->cur_state,
> > > state, reg, ({
> > >                                 if (reg->type & MEM_RCU) {
> > >                                         reg->type &=3D ~(MEM_RCU |
> > > PTR_MAYBE_NULL);
> > >                                         reg->type |=3D PTR_UNTRUSTED;
> > >                                 }
> > >                         }));
> > > clears iter state that depends on rcu.
> > >
> > > I thought about changing mark_stack_slots_iter() to do
> > > st->type =3D PTR_TO_STACK | MEM_RCU;
> > > so that the above clearing logic kicks in,
> > > but it might be better to have something iter specific.
> > > is_iter_reg_valid_init() should probably be changed to
> > > make sure reg->type is not UNTRUSTED.
> > >
> > > Andrii,
> > > do you have better suggestions?
> >
> > What if we just remember inside bpf_reg_state.iter state whether
> > iterator needs to be RCU protected (it's just one bit if we don't
> > allow nesting rcu_read_lock()/rcu_read_unlock(), or we'd need to
> > remember RCU nestedness level), and then when validating iter_next and
> > iter_destroy() kfuncs, check that we are still in RCU-protected region
> > (if we have nestedness, then iter->rcu_nest_level <=3D
> > cur_rcu_nest_level, if I understand correctly). And if not, provide a
> > clear and nice message.
> >
> > That seems straightforward enough, but am I missing anything subtle?
> >
>
> We also need to ensure one does not do a bpf_rcu_read_unlock and
> bpf_rcu_read_lock again between the iter_new and
> iter_next/iter_destroy calls. Simply checking we are in an RCU
> protected region will pass the verifier in such a case.

Yep, you are right, what I proposed is too naive, of course.

>
> A simple solution might be associating an ID with the RCU CS, so make
> active_rcu_lock a 32-bit ID which is monotonically increasing for each
> new RCU region. Ofcourse, all of this only matters for sleepable
> programs. Then check if id recorded in iter state is same on next and
> destroy.

Yep, I think each RCU region should ideally be tracked separately and
get a unique ID. Kind of like a ref. It is some lifetime/scope, not
necessarily an actual kernel object. And if/when we have it, we can
grab the ID of most nested RCU scope, associate it with RCU-protected
iter, and then make sure that this RCU scope is active at every
next/destroy invocation.

