Return-Path: <bpf+bounces-10119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4737A11AC
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943CD282382
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85237D515;
	Thu, 14 Sep 2023 23:27:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521733F2
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:27:02 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C77270A;
	Thu, 14 Sep 2023 16:27:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so1779521a12.3;
        Thu, 14 Sep 2023 16:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694734020; x=1695338820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKnhB3oM9vLVjnyH8gIiq1opGHvfWiBJljsIyE5tQWc=;
        b=Rj3fekYaSv7M5P/DN86FqARheOblDeay9BGGCKsDRGqhtetV0TSreGS0RJnNQPVLml
         y7ZdqZi5GGSZTqJuGQ5Pshd6h+J39J7jawkg/nmyMtpzzxTqcfdAEz/PMjMZYglrjV8R
         KH78YixuGuLYuBKAdn5e4F03CW0Iyn7H4dGggs1CjLUm2rWFF4hKbEKYyiNThjqvbE5O
         iaYr/Dtk1NVkKlup4vGa7IATMAHGlAOwaea8olB3gt+MolBn2TrK0p4WUVz//XnAFFb6
         blCA9tt3eVny5H/3+6gX/6FEn2yYMiIbQUPDYVbPVkS7DXWdeUOY3mA4x6UZBI1Xfvqb
         OvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694734020; x=1695338820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKnhB3oM9vLVjnyH8gIiq1opGHvfWiBJljsIyE5tQWc=;
        b=Z4U7sq8q/cTwmEkiPQYet0MoSMMudmiQZiHrejRQpqTbKZoVbxOYAJAiP4HoBQ0HvI
         /1gcNI7HeKpfj9Rl1ZXD86DaYoDv77ozLrz3u0lY9vqW5mC8Qi4FVwLDQeMj43C5AUV4
         IX7eVQvQAqt+cY0ivajeZsvpn0pw6w0EMDtZuYVd7WvI9/sPh3W1sim6N0pBbKL6b7gk
         0zUQYTjrxZ7l1bDVoruX/gbu7TJSJLgKKBfzf7wArJyBOpX4D7ipFgU9q8+skSp5r4x6
         kMSQzrIGZZBTyL+Byrj5Pmc+yO2iZbDMIojpQGU+upW98ALwKRl6PKDlCbiXokjHMdt6
         KZjw==
X-Gm-Message-State: AOJu0Yyj9RsRImS7gh+NJNVVCkb5HsbbyR0vG9n0N09LLMd+CMGneguI
	GwXeqcEAKUW8uqwmEw6bR0B+vnlOVoF7uMvRTRbWE3pT
X-Google-Smtp-Source: AGHT+IHHHDViKXP8zVKYZR1Cb0taurAXixV+0gR74lIlmefdHB3de8YmUrjik4DiWUQUer7sJy0fQtii9K/aKJeGKkw=
X-Received: by 2002:a05:6402:4d0:b0:525:6d9e:67c0 with SMTP id
 n16-20020a05640204d000b005256d9e67c0mr6533261edw.23.1694734020435; Thu, 14
 Sep 2023 16:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-6-zhouchuyi@bytedance.com> <4c15c9fc-7c9f-9695-5c67-d3f214d04bd9@bytedance.com>
 <1f9cae15-979c-c049-78a9-f89d5cd1b53e@bytedance.com>
In-Reply-To: <1f9cae15-979c-c049-78a9-f89d5cd1b53e@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Sep 2023 16:26:49 -0700
Message-ID: <CAEf4BzZ18pjmav45mxhQ9eigJuAWnowgSm=+c==8dY0AUm2WdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] bpf: teach the verifier to enforce
 css_iter and process_iter in RCU CS
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 1:56=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
>
>
> =E5=9C=A8 2023/9/13 21:53, Chuyi Zhou =E5=86=99=E9=81=93:
> > Hello.
> >
> > =E5=9C=A8 2023/9/12 15:01, Chuyi Zhou =E5=86=99=E9=81=93:
> >> css_iter and process_iter should be used in rcu section. Specifically,=
 in
> >> sleepable progs explicit bpf_rcu_read_lock() is needed before use thes=
e
> >> iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK=
 to
> >> use them directly.
> >>
> >> This patch checks whether we are in rcu cs before we want to invoke
> >> bpf_iter_process_new and bpf_iter_css_{pre, post}_new in
> >> mark_stack_slots_iter(). If the rcu protection is guaranteed, we would
> >> let st->type =3D PTR_TO_STACK | MEM_RCU. is_iter_reg_valid_init() will
> >> reject if reg->type is UNTRUSTED.
> >
> > I use the following BPF Prog to test this patch:
> >
> > SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> > int iter_task_for_each_sleep(void *ctx)
> > {
> >      struct task_struct *task;
> >      struct task_struct *cur_task =3D bpf_get_current_task_btf();
> >
> >      if (cur_task->pid !=3D target_pid)
> >          return 0;
> >      bpf_rcu_read_lock();
> >      bpf_for_each(process, task) {
> >          bpf_rcu_read_unlock();
> >          if (task->pid =3D=3D target_pid)
> >              process_cnt +=3D 1;
> >          bpf_rcu_read_lock();
> >      }
> >      bpf_rcu_read_unlock();
> >      return 0;
> > }
> >
> > Unfortunately, we can pass the verifier.
> >
> > Then I add some printk-messages before setting/clearing state to help
> > debug:
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d151e6b43a5f..35f3fa9471a9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1200,7 +1200,7 @@ static int mark_stack_slots_iter(struct
> > bpf_verifier_env *env,
> >                  __mark_reg_known_zero(st);
> >                  st->type =3D PTR_TO_STACK; /* we don't have dedicated =
reg
> > type */
> >                  if (is_iter_need_rcu(meta)) {
> > +                       printk("mark reg_addr : %px", st);
> >                          if (in_rcu_cs(env))
> >                                  st->type |=3D MEM_RCU;
> >                          else
> > @@ -11472,8 +11472,8 @@ static int check_kfunc_call(struct
> > bpf_verifier_env *env, struct bpf_insn *insn,
> >                          return -EINVAL;
> >                  } else if (rcu_unlock) {
> >                          bpf_for_each_reg_in_vstate(env->cur_state,
> > state, reg, ({
> > +                               printk("clear reg_addr : %px MEM_RCU :
> > %d PTR_UNTRUSTED : %d\n ", reg, reg->type & MEM_RCU, reg->type &
> > PTR_UNTRUSTED);
> >                                  if (reg->type & MEM_RCU) {
> > -                                       printk("clear reg addr : %lld",
> > reg);
> >                                          reg->type &=3D ~(MEM_RCU |
> > PTR_MAYBE_NULL);
> >                                          reg->type |=3D PTR_UNTRUSTED;
> >                                  }
> >
> >
> > The demsg log:
> >
> > [  393.705324] mark reg_addr : ffff88814e40e200
> >
> > [  393.706883] clear reg_addr : ffff88814d5f8000 MEM_RCU : 0
> > PTR_UNTRUSTED : 0
> >
> > [  393.707353] clear reg_addr : ffff88814d5f8078 MEM_RCU : 0
> > PTR_UNTRUSTED : 0
> >
> > [  393.708099] clear reg_addr : ffff88814d5f80f0 MEM_RCU : 0
> > PTR_UNTRUSTED : 0
> > ....
> > ....
> >
> > I didn't see ffff88814e40e200 is cleared as expected because
> > bpf_for_each_reg_in_vstate didn't find it.
> >
> > It seems when we are doing bpf_read_unlock() in the middle of iteration
> > and want to clearing state through bpf_for_each_reg_in_vstate, we can
> > not find the previous reg which we marked MEM_RCU/PTR_UNTRUSTED in
> > mark_stack_slots_iter().
> >
>
> bpf_get_spilled_reg will skip slots if they are not STACK_SPILL, but in
> mark_stack_slots_iter() we has marked the slots *STACK_ITER*
>
> With the following change, everything seems work OK.
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index a3236651ec64..83c5ecccadb4 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -387,7 +387,7 @@ struct bpf_verifier_state {
>
>   #define bpf_get_spilled_reg(slot, frame)                               =
\
>          (((slot < frame->allocated_stack / BPF_REG_SIZE) &&             =
\
> -         (frame->stack[slot].slot_type[0] =3D=3D STACK_SPILL))          =
   \
> +         (frame->stack[slot].slot_type[0] =3D=3D STACK_SPILL ||
> frame->stack[slot].slot_type[0] =3D=3D STACK_ITER))            \
>           ? &frame->stack[slot].spilled_ptr : NULL)
>
> I am not sure whether this would harm some logic implicitly when using
> bpf_get_spilled_reg/bpf_for_each_spilled_reg in other place. If so,
> maybe we should add a extra parameter to control the picking behaviour.
>
> #define bpf_get_spilled_reg(slot, frame, stack_type)
>                         \
>         (((slot < frame->allocated_stack / BPF_REG_SIZE) &&             \
>           (frame->stack[slot].slot_type[0] =3D=3D stack_type))           =
   \
>          ? &frame->stack[slot].spilled_ptr : NULL)
>
> Thanks.

I don't think it's safe to just make bpf_get_spilled_reg, and
subsequently bpf_for_each_reg_in_vstate and bpf_for_each_spilled_reg
just suddenly start iterating iterator states and/or dynptrs. At least
some of existing uses of those assume they are really working just
with registers.

