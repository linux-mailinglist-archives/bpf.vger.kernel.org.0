Return-Path: <bpf+bounces-9344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0F7941EF
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 19:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2B2281458
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AC10976;
	Wed,  6 Sep 2023 17:18:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02FEDB
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 17:18:16 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993D21998;
	Wed,  6 Sep 2023 10:18:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso1881961fa.1;
        Wed, 06 Sep 2023 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694020690; x=1694625490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfI7yf43ET624hBFUVSQTNKbTQVCOa1P5ykThzOMYn0=;
        b=h69HQbtaW/exEs5hnksH5QynXuluwXaEEUYNTe4BVdDmmNQDSxr1aQP/tqa7K23Bh6
         kQf2xFOK7UQ1ToAJUVUpGNrJtXx5m8dAMmqNZdeuOt0ho3hHtSZkMU2zioS3V95h7Ukr
         Ug+9bOp7BcirV5NEWdNeEk0cdzCiiB1KwI4VYwY13RvIlGdpLr591TDdAqPQkTfUOe8z
         J6abzrPVliw/gKbq5lvmE78WjP6jsK1r/7VI2qfG4JBgaxqktbKP+yoED4uXkMlPrYkY
         j8QgEfReSsLsWGUGS30Yn8eW5LX7xxIsv87D2X0vi565KFSBhaq0hBAx4DMcQDrhBluX
         z8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694020690; x=1694625490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfI7yf43ET624hBFUVSQTNKbTQVCOa1P5ykThzOMYn0=;
        b=RcwGTYgJ8Za7Qj8zf05d2lKjHK54OwN1vZKz6rg7WZLhQBhPW9cOIrw1lTqK3ygOkm
         FTP2LaeA4owMnkzqwyZ/dNeULBJ7YWhD6Dre/ovTGZ5PGFRubmz4+lMUhIqT9Piw1Wly
         HCZ3OZt2DqPFWamEwxfksP0uP1iW41WAAe9Yj37D8Of2JrIK630lxE++VhNAfIH4izQH
         Uaps1+U+gO8xKmHahRzCPFIoWUdWgbn/f0gI9jn+HlBf5zHM0ZCYNfAQxDPNGJgSdo/z
         Kvfn4GmDrq7Ceir8SzfDQUU5fa4yF9nMzG+eR/TsBUK2/pqpxZl0mmlr2eXEwRT0XtDB
         GK0A==
X-Gm-Message-State: AOJu0YworAEg7EXvix3SCHCAV99Xo3k2m5rZv0vDBg0iBNevTd2DG202
	15923NJ85URNTBRtrGqPZYFmF/FS8tF5mZicnxk=
X-Google-Smtp-Source: AGHT+IHD4DYumYFCdjNLjF17I5NUhBT5IsnI3QSr+gxh0BVtcDdFsPs8sHyeBZKBYZNYeeu/PAbo0Kqq90jvZsMCXg8=
X-Received: by 2002:a2e:8195:0:b0:2b7:3656:c594 with SMTP id
 e21-20020a2e8195000000b002b73656c594mr2544980ljg.3.1694020689414; Wed, 06 Sep
 2023 10:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-3-zhouchuyi@bytedance.com> <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
 <e5e986a0-0bb9-6611-77f0-f8472346965e@bytedance.com>
In-Reply-To: <e5e986a0-0bb9-6611-77f0-f8472346965e@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Sep 2023 10:17:57 -0700
Message-ID: <CAADnVQL-ZGV6C7VWdQpX64f0+gokE5MLBO3F2J3WyMoq-_NCPg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded
 iterator kfuncs
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 6, 2023 at 5:38=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com>=
 wrote:
>
> Hello, Alexei.
>
> =E5=9C=A8 2023/9/6 04:09, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Sun, Aug 27, 2023 at 12:21=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedanc=
e.com> wrote:
> >>
> >> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which allow
> >> creation and manipulation of struct bpf_iter_process in open-coded ite=
rator
> >> style. BPF programs can use these kfuncs or through bpf_for_each macro=
 to
> >> iterate all processes in the system.
> >>
> >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> >> ---
> >>   include/uapi/linux/bpf.h       |  4 ++++
> >>   kernel/bpf/helpers.c           |  3 +++
> >>   kernel/bpf/task_iter.c         | 31 +++++++++++++++++++++++++++++++
> >>   tools/include/uapi/linux/bpf.h |  4 ++++
> >>   tools/lib/bpf/bpf_helpers.h    |  5 +++++
> >>   5 files changed, 47 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 2a6e9b99564b..cfbd527e3733 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7199,4 +7199,8 @@ struct bpf_iter_css_task {
> >>          __u64 __opaque[1];
> >>   } __attribute__((aligned(8)));
> >>
> >> +struct bpf_iter_process {
> >> +       __u64 __opaque[1];
> >> +} __attribute__((aligned(8)));
> >> +
> >>   #endif /* _UAPI__LINUX_BPF_H__ */
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index cf113ad24837..81a2005edc26 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2458,6 +2458,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER=
_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
> >>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NUL=
L)
> >>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> >> +BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
> >> +BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
> >> +BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index b1bdba40b684..a6717a76c1e0 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -862,6 +862,37 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct=
 bpf_iter_css_task *it)
> >>          kfree(kit->css_it);
> >>   }
> >>
> >> +struct bpf_iter_process_kern {
> >> +       struct task_struct *tsk;
> >> +} __attribute__((aligned(8)));
> >> +
> >> +__bpf_kfunc int bpf_iter_process_new(struct bpf_iter_process *it)
> >> +{
> >> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> >> +
> >> +       BUILD_BUG_ON(sizeof(struct bpf_iter_process_kern) !=3D sizeof(=
struct bpf_iter_process));
> >> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_process_kern) !=3D
> >> +                                       __alignof__(struct bpf_iter_pr=
ocess));
> >> +
> >> +       rcu_read_lock();
> >> +       kit->tsk =3D &init_task;
> >> +       return 0;
> >> +}
> >> +
> >> +__bpf_kfunc struct task_struct *bpf_iter_process_next(struct bpf_iter=
_process *it)
> >> +{
> >> +       struct bpf_iter_process_kern *kit =3D (void *)it;
> >> +
> >> +       kit->tsk =3D next_task(kit->tsk);
> >> +
> >> +       return kit->tsk =3D=3D &init_task ? NULL : kit->tsk;
> >> +}
> >> +
> >> +__bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it=
)
> >> +{
> >> +       rcu_read_unlock();
> >> +}
> >
> > This iter can be used in all ctx-s which is nice, but let's
> > make the verifier enforce rcu_read_lock/unlock done by bpf prog
> > instead of doing in the ctor/dtor of iter, since
> > in sleepable progs the verifier won't recognize that body is RCU CS.
> > We'd need to teach the verifier to allow bpf_iter_process_new()
> > inside in_rcu_cs() and make sure there is no rcu_read_unlock
> > while BPF_ITER_STATE_ACTIVE.
> > bpf_iter_process_destroy() would become a nop.
>
> Thanks for your review!
>
> I think bpf_iter_process_{new, next, destroy} should be protected by
> bpf_rcu_read_lock/unlock explicitly whether the prog is sleepable or
> not, right?

Correct. By explicit bpf_rcu_read_lock() in case of sleepable progs
or just by using them in normal bpf progs that have implicit rcu_read_lock(=
)
done before calling into them.

> I'm not very familiar with the BPF verifier, but I believe
> there is still a risk in directly calling these kfuns even if
> in_rcu_cs() is true.
>
> Maby what we actually need here is to enforce BPF verifier to check
> env->cur_state->active_rcu_lock is true when we want to call these kfuncs=
.

active_rcu_lock means explicit bpf_rcu_read_lock.
Currently we do allow bpf_rcu_read_lock in non-sleepable, but it's pointles=
s.

Technically we can extend the check:
                if (in_rbtree_lock_required_cb(env) && (rcu_lock ||
rcu_unlock)) {
                        verbose(env, "Calling
bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
                        return -EACCES;
                }
to discourage their use in all non-sleepable, but it will break some progs.

I think it's ok to check in_rcu_cs() to allow bpf_iter_process_*().
If bpf prog adds explicit and unnecessary bpf_rcu_read_lock() around
the iter ops it won't do any harm.
Just need to make sure that rcu unlock logic:
                } else if (rcu_unlock) {
                        bpf_for_each_reg_in_vstate(env->cur_state,
state, reg, ({
                                if (reg->type & MEM_RCU) {
                                        reg->type &=3D ~(MEM_RCU |
PTR_MAYBE_NULL);
                                        reg->type |=3D PTR_UNTRUSTED;
                                }
                        }));
clears iter state that depends on rcu.

I thought about changing mark_stack_slots_iter() to do
st->type =3D PTR_TO_STACK | MEM_RCU;
so that the above clearing logic kicks in,
but it might be better to have something iter specific.
is_iter_reg_valid_init() should probably be changed to
make sure reg->type is not UNTRUSTED.

Andrii,
do you have better suggestions?

