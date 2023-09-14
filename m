Return-Path: <bpf+bounces-10118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A22B27A11AB
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21831C20F7E
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0CD50B;
	Thu, 14 Sep 2023 23:27:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FA33F2
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:27:00 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1E42729;
	Thu, 14 Sep 2023 16:26:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52eed139ec2so1725827a12.2;
        Thu, 14 Sep 2023 16:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694734018; x=1695338818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5Hl9cDGuf3HeMIbNy2+lG6sVU6W7XRK06rgKNehvKA=;
        b=MdiAtC/Jjnt6SdJsWgOsLPZ6gxCfWLf/Hy0A7UXYnmhlCISPz9Mae7lI4XwMQNnQzJ
         bfjSBlz4s9FplSRRv1LCKYY9+Njy8NGnkJgR37akYS9SIj6BTqXsYjxhuxYjxVNtqk3r
         w/Iz6lFZvH8X+hKSKkMqxhtvUHjQ4i8vithSrolBwVOuvr62SVUOPHBabYWqEoDmpsIM
         q5zK26hMNC07B7r3aZHSYmRsh39jatYxIC+IA1wL8eSbPszsNXeVuX2IV1dpNM2hSvzW
         jAgDvG1b+NA//wmPUhHJ/T7U2qKseBWU+DMPvrH0vrNjeWKrqG0vrTb//8ARDgQyqhdr
         CpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694734018; x=1695338818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5Hl9cDGuf3HeMIbNy2+lG6sVU6W7XRK06rgKNehvKA=;
        b=YsUBDSvpCza5OgwusovYjlS0oaG2lF0pJH6EoTMolBWjnC5DH5cKjUCVdxt0K/a7fq
         PADu0nrHNl1khX7FeeKWhoyxPC7hTJCrscJoJJju1Ckq25SXgfSQ/N8rjnVevyolOO6q
         QblEPGJ/es3yON5kYO2GMAb9RvV9DXs76vl4WjIN+cFYNsnacwvCtvxXHSTvbplxSKzp
         GvVMOhUkPu88XvHJmoMxlzLJfZZ+Pl3lETH5Y1zBxOBcsVBI7RMmmsXi6QSR7H7ajgYP
         I1oL3/kn2Vs0+e9YaRPlaee8DgKiWvNpIIT0pn0u2BHC8QNen40zYvdH2MH66JynWt7q
         RtHw==
X-Gm-Message-State: AOJu0Yz7Pm663v5VJl/NKp5c53Z+2C9+UoHUPBJHA7U78fEtwyQEicwv
	xfL1fm4glzegiWr2/5qK/SbKdKe5IB1tV5+r0y+den2e
X-Google-Smtp-Source: AGHT+IEvL5YKC81jQtyubqeAEoqfdPjP20fgOxmlZr29I1IGdH3vAS8pjBFZwdap9b+CkmbqFWcsdDIFtdqoeVa/WAk=
X-Received: by 2002:a05:6402:f0c:b0:530:7abf:3a84 with SMTP id
 i12-20020a0564020f0c00b005307abf3a84mr564786eda.25.1694734018046; Thu, 14 Sep
 2023 16:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912070149.969939-1-zhouchuyi@bytedance.com> <20230912070149.969939-6-zhouchuyi@bytedance.com>
In-Reply-To: <20230912070149.969939-6-zhouchuyi@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Sep 2023 16:26:46 -0700
Message-ID: <CAEf4Bzb33btcH8McsTS7BpC_+GefzEUGUMNdetxAqvDvDDFA9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] bpf: teach the verifier to enforce
 css_iter and process_iter in RCU CS
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 12:02=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.co=
m> wrote:
>
> css_iter and process_iter should be used in rcu section. Specifically, in
> sleepable progs explicit bpf_rcu_read_lock() is needed before use these
> iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK to
> use them directly.
>
> This patch checks whether we are in rcu cs before we want to invoke
> bpf_iter_process_new and bpf_iter_css_{pre, post}_new in
> mark_stack_slots_iter(). If the rcu protection is guaranteed, we would
> let st->type =3D PTR_TO_STACK | MEM_RCU. is_iter_reg_valid_init() will
> reject if reg->type is UNTRUSTED.

it would be nice to mention where this MEM_RCU is turned into
UNTRUSTED when we do rcu_read_unlock(). For someone unfamiliar with
these parts of verifier (like me) this is completely unobvious.

>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2367483bf4c2..6a6827ba7a18 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1172,7 +1172,13 @@ static bool is_dynptr_type_expected(struct bpf_ver=
ifier_env *env, struct bpf_reg
>
>  static void __mark_reg_known_zero(struct bpf_reg_state *reg);
>
> +static bool in_rcu_cs(struct bpf_verifier_env *env);
> +
> +/* check whether we are using bpf_iter_process_*() or bpf_iter_css_*() *=
/
> +static bool is_iter_need_rcu(struct bpf_kfunc_call_arg_meta *meta);
> +
>  static int mark_stack_slots_iter(struct bpf_verifier_env *env,
> +                                struct bpf_kfunc_call_arg_meta *meta,
>                                  struct bpf_reg_state *reg, int insn_idx,
>                                  struct btf *btf, u32 btf_id, int nr_slot=
s)
>  {
> @@ -1193,6 +1199,12 @@ static int mark_stack_slots_iter(struct bpf_verifi=
er_env *env,
>
>                 __mark_reg_known_zero(st);
>                 st->type =3D PTR_TO_STACK; /* we don't have dedicated reg=
 type */
> +               if (is_iter_need_rcu(meta)) {
> +                       if (in_rcu_cs(env))
> +                               st->type |=3D MEM_RCU;
> +                       else
> +                               st->type |=3D PTR_UNTRUSTED;
> +               }
>                 st->live |=3D REG_LIVE_WRITTEN;
>                 st->ref_obj_id =3D i =3D=3D 0 ? id : 0;
>                 st->iter.btf =3D btf;
> @@ -1281,6 +1293,8 @@ static bool is_iter_reg_valid_init(struct bpf_verif=
ier_env *env, struct bpf_reg_
>                 struct bpf_stack_state *slot =3D &state->stack[spi - i];
>                 struct bpf_reg_state *st =3D &slot->spilled_ptr;
>
> +               if (st->type & PTR_UNTRUSTED)
> +                       return false;
>                 /* only main (first) slot has ref_obj_id set */
>                 if (i =3D=3D 0 && !st->ref_obj_id)
>                         return false;
> @@ -7503,13 +7517,13 @@ static int process_iter_arg(struct bpf_verifier_e=
nv *env, int regno, int insn_id
>                                 return err;
>                 }
>
> -               err =3D mark_stack_slots_iter(env, reg, insn_idx, meta->b=
tf, btf_id, nr_slots);
> +               err =3D mark_stack_slots_iter(env, meta, reg, insn_idx, m=
eta->btf, btf_id, nr_slots);
>                 if (err)
>                         return err;
>         } else {
>                 /* iter_next() or iter_destroy() expect initialized iter =
state*/
>                 if (!is_iter_reg_valid_init(env, reg, meta->btf, btf_id, =
nr_slots)) {
> -                       verbose(env, "expected an initialized iter_%s as =
arg #%d\n",
> +                       verbose(env, "expected an initialized iter_%s as =
arg #%d or without bpf_rcu_read_lock()\n",
>                                 iter_type_str(meta->btf, btf_id), regno);

this message makes no sense, but even if reworded it would be
confusing for users. So maybe do the RCU check separately and report a
clear message that this iterator is expected to be within a single
continuous rcu_read_{lock+unlock} region.

I do think tracking RCU regions explicitly would make for much easier
to follow code, better messages, etc. Probably would be beneficial for
some other RCU-protected features. But that's a separate topic.

>                         return -EINVAL;
>                 }
> @@ -10382,6 +10396,18 @@ BTF_ID(func, bpf_percpu_obj_new_impl)
>  BTF_ID(func, bpf_percpu_obj_drop_impl)
>  BTF_ID(func, bpf_iter_css_task_new)
>
> +BTF_SET_START(rcu_protect_kfuns_set)
> +BTF_ID(func, bpf_iter_process_new)
> +BTF_ID(func, bpf_iter_css_pre_new)
> +BTF_ID(func, bpf_iter_css_post_new)
> +BTF_SET_END(rcu_protect_kfuns_set)
> +

instead of maintaining these extra special sets, why not add a KF
flag, like KF_RCU_PROTECTED?


> +static inline bool is_iter_need_rcu(struct bpf_kfunc_call_arg_meta *meta=
)
> +{
> +       return btf_id_set_contains(&rcu_protect_kfuns_set, meta->func_id)=
;
> +}
> +
> +
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
>         if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acqui=
re_impl] &&
> --
> 2.20.1
>

