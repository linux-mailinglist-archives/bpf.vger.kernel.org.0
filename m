Return-Path: <bpf+bounces-10183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1537A2802
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 22:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE131C20F4B
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55F1B27D;
	Fri, 15 Sep 2023 20:23:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B510947
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 20:23:47 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E93AA8;
	Fri, 15 Sep 2023 13:23:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-501cba1ec0aso4226314e87.2;
        Fri, 15 Sep 2023 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694809424; x=1695414224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j10NGF+uwrPInTdK3534ZVRmil1MgGKJfRrtg2/+nrE=;
        b=cyv9uime3tAFzhQTppdliQq5HOMUlDfA7gAhpO8pNZD6+aaxPXDGtKv4FdATgAklis
         fkTrLKFwuFa0enyrKrlR8W/IsoKvNeMqYTkRSSNXL/C8jCgFdCtD/khm6wUkhadtZiwS
         1PVm5nl/yqVjx4lkjJmct7pVWqTDJ6BqLudUp7FLHTHQYrmjvoUMkYuTmkDHJOAIqNxU
         gqo7ULp40utRSbjmqFt25IxQJtQNnAnG8TJh4JfzM8oH4DJh8fuKHZXFZ3PYHt7VuF/D
         DwVY21DoIGPKHh0YE0hqmtQEp4BxjPSqCAptY2rflNN+oCeD2xO+GoLR2V+g9iwQ3W5C
         n+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694809424; x=1695414224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j10NGF+uwrPInTdK3534ZVRmil1MgGKJfRrtg2/+nrE=;
        b=XBo9s7HLUKeEkrA92PFoFYGXPXI+yC3Kgys4lja5ZY6ptLcDwjZCzuZO27Rw3bnW3N
         nciCAKDcFPddkSQbLKZO8ljatUnJ9HWjdo7NqBLyF++gbEp4+BQM6AR2mwWz9fbk1McN
         MKv/eUmP/naRD8wYEJZVLrxVxQR8f3EFblNPZC7VLq2x8dVd4+vFS5GUqHIANnIdNgxA
         7O0uS8+Lr3AgGV1gv11M7oPhqPi8kv+ALDp4zrh66URTSF/7bbvDCK4sELAb0OmNQZkO
         HbLjWsNRnkYwHtVKu5HiNJqsOkxg3CVe2LDtbZ/0/l14OCgVYRH3NVB7+odIhXXZap7H
         rxRQ==
X-Gm-Message-State: AOJu0YyHvmh95rx0sZiDjGkA6pbo+npKuxo1JRpnDeZ/Sj4DTT8zZPsJ
	wDbtXxoCYFl196mMIfbHFpbcJ3DJ4ZP+AiaE8Kw=
X-Google-Smtp-Source: AGHT+IEwUUVd9cPKODuRMtOILMmPnjAogp1VUdG5BfsmwADmBY5HkoMW9m7dDogBQa4izMYSVROtMsuUESJR3XEEwdQ=
X-Received: by 2002:a05:6512:ba7:b0:4ff:9095:a817 with SMTP id
 b39-20020a0565120ba700b004ff9095a817mr3211434lfv.57.1694809423988; Fri, 15
 Sep 2023 13:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-6-zhouchuyi@bytedance.com> <4c15c9fc-7c9f-9695-5c67-d3f214d04bd9@bytedance.com>
 <1f9cae15-979c-c049-78a9-f89d5cd1b53e@bytedance.com> <CAEf4BzZ18pjmav45mxhQ9eigJuAWnowgSm=+c==8dY0AUm2WdQ@mail.gmail.com>
 <8f388b8f-bc19-5ad1-00ee-e67cdcdd9d4f@bytedance.com>
In-Reply-To: <8f388b8f-bc19-5ad1-00ee-e67cdcdd9d4f@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Sep 2023 13:23:32 -0700
Message-ID: <CAEf4Bzb8v-O+7Py0zxNFOGgGx_Ley76u7hrjRpBKE49eHbfHOw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 5/6] bpf: teach the verifier to
 enforce css_iter and process_iter in RCU CS
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 10:46=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.co=
m> wrote:
>
> Hello.
>
> =E5=9C=A8 2023/9/15 07:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Thu, Sep 14, 2023 at 1:56=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance=
.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2023/9/13 21:53, Chuyi Zhou =E5=86=99=E9=81=93:
> >>> Hello.
> >>>
> >>> =E5=9C=A8 2023/9/12 15:01, Chuyi Zhou =E5=86=99=E9=81=93:
> >>>> css_iter and process_iter should be used in rcu section. Specificall=
y, in
> >>>> sleepable progs explicit bpf_rcu_read_lock() is needed before use th=
ese
> >>>> iters. In normal bpf progs that have implicit rcu_read_lock(), it's =
OK to
> >>>> use them directly.
> >>>>
> >>>> This patch checks whether we are in rcu cs before we want to invoke
> >>>> bpf_iter_process_new and bpf_iter_css_{pre, post}_new in
> >>>> mark_stack_slots_iter(). If the rcu protection is guaranteed, we wou=
ld
> >>>> let st->type =3D PTR_TO_STACK | MEM_RCU. is_iter_reg_valid_init() wi=
ll
> >>>> reject if reg->type is UNTRUSTED.
> >>>
> >>> I use the following BPF Prog to test this patch:
> >>>
> >>> SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> >>> int iter_task_for_each_sleep(void *ctx)
> >>> {
> >>>       struct task_struct *task;
> >>>       struct task_struct *cur_task =3D bpf_get_current_task_btf();
> >>>
> >>>       if (cur_task->pid !=3D target_pid)
> >>>           return 0;
> >>>       bpf_rcu_read_lock();
> >>>       bpf_for_each(process, task) {
> >>>           bpf_rcu_read_unlock();
> >>>           if (task->pid =3D=3D target_pid)
> >>>               process_cnt +=3D 1;
> >>>           bpf_rcu_read_lock();
> >>>       }
> >>>       bpf_rcu_read_unlock();
> >>>       return 0;
> >>> }
> >>>
> >>> Unfortunately, we can pass the verifier.
> >>>
> >>> Then I add some printk-messages before setting/clearing state to help
> >>> debug:
> >>>
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index d151e6b43a5f..35f3fa9471a9 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -1200,7 +1200,7 @@ static int mark_stack_slots_iter(struct
> >>> bpf_verifier_env *env,
> >>>                   __mark_reg_known_zero(st);
> >>>                   st->type =3D PTR_TO_STACK; /* we don't have dedicat=
ed reg
> >>> type */
> >>>                   if (is_iter_need_rcu(meta)) {
> >>> +                       printk("mark reg_addr : %px", st);
> >>>                           if (in_rcu_cs(env))
> >>>                                   st->type |=3D MEM_RCU;
> >>>                           else
> >>> @@ -11472,8 +11472,8 @@ static int check_kfunc_call(struct
> >>> bpf_verifier_env *env, struct bpf_insn *insn,
> >>>                           return -EINVAL;
> >>>                   } else if (rcu_unlock) {
> >>>                           bpf_for_each_reg_in_vstate(env->cur_state,
> >>> state, reg, ({
> >>> +                               printk("clear reg_addr : %px MEM_RCU =
:
> >>> %d PTR_UNTRUSTED : %d\n ", reg, reg->type & MEM_RCU, reg->type &
> >>> PTR_UNTRUSTED);
> >>>                                   if (reg->type & MEM_RCU) {
> >>> -                                       printk("clear reg addr : %lld=
",
> >>> reg);
> >>>                                           reg->type &=3D ~(MEM_RCU |
> >>> PTR_MAYBE_NULL);
> >>>                                           reg->type |=3D PTR_UNTRUSTE=
D;
> >>>                                   }
> >>>
> >>>
> >>> The demsg log:
> >>>
> >>> [  393.705324] mark reg_addr : ffff88814e40e200
> >>>
> >>> [  393.706883] clear reg_addr : ffff88814d5f8000 MEM_RCU : 0
> >>> PTR_UNTRUSTED : 0
> >>>
> >>> [  393.707353] clear reg_addr : ffff88814d5f8078 MEM_RCU : 0
> >>> PTR_UNTRUSTED : 0
> >>>
> >>> [  393.708099] clear reg_addr : ffff88814d5f80f0 MEM_RCU : 0
> >>> PTR_UNTRUSTED : 0
> >>> ....
> >>> ....
> >>>
> >>> I didn't see ffff88814e40e200 is cleared as expected because
> >>> bpf_for_each_reg_in_vstate didn't find it.
> >>>
> >>> It seems when we are doing bpf_read_unlock() in the middle of iterati=
on
> >>> and want to clearing state through bpf_for_each_reg_in_vstate, we can
> >>> not find the previous reg which we marked MEM_RCU/PTR_UNTRUSTED in
> >>> mark_stack_slots_iter().
> >>>
> >>
> >> bpf_get_spilled_reg will skip slots if they are not STACK_SPILL, but i=
n
> >> mark_stack_slots_iter() we has marked the slots *STACK_ITER*
> >>
> >> With the following change, everything seems work OK.
> >>
> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier=
.h
> >> index a3236651ec64..83c5ecccadb4 100644
> >> --- a/include/linux/bpf_verifier.h
> >> +++ b/include/linux/bpf_verifier.h
> >> @@ -387,7 +387,7 @@ struct bpf_verifier_state {
> >>
> >>    #define bpf_get_spilled_reg(slot, frame)                           =
    \
> >>           (((slot < frame->allocated_stack / BPF_REG_SIZE) &&         =
    \
> >> -         (frame->stack[slot].slot_type[0] =3D=3D STACK_SPILL))       =
      \
> >> +         (frame->stack[slot].slot_type[0] =3D=3D STACK_SPILL ||
> >> frame->stack[slot].slot_type[0] =3D=3D STACK_ITER))            \
> >>            ? &frame->stack[slot].spilled_ptr : NULL)
> >>
> >> I am not sure whether this would harm some logic implicitly when using
> >> bpf_get_spilled_reg/bpf_for_each_spilled_reg in other place. If so,
> >> maybe we should add a extra parameter to control the picking behaviour=
.
> >>
> >> #define bpf_get_spilled_reg(slot, frame, stack_type)
> >>                          \
> >>          (((slot < frame->allocated_stack / BPF_REG_SIZE) &&          =
   \
> >>            (frame->stack[slot].slot_type[0] =3D=3D stack_type))       =
       \
> >>           ? &frame->stack[slot].spilled_ptr : NULL)
> >>
> >> Thanks.
> >
> > I don't think it's safe to just make bpf_get_spilled_reg, and
> > subsequently bpf_for_each_reg_in_vstate and bpf_for_each_spilled_reg
> > just suddenly start iterating iterator states and/or dynptrs. At least
> > some of existing uses of those assume they are really working just
> > with registers.
>
> IIUC, when we are doing bpf_rcu_unlock, we do need to clear the state of
> reg including STACK_ITER.
>
> Maybe here we only need change the logic when using
> bpf_for_each_reg_in_vstate to clear state in bpf_rcu_unlock and keep
> everything else unchanged ?

Right, maybe. I see 10 uses of bpf_for_each_reg_in_vstate() in
kernel/bpf/verifier.c. Before we change the definition of
bpf_for_each_reg_in_vstate() we should validate that iterating dynptr
and iter states doesn't break any of them, that's all.

>
> Thanks.

