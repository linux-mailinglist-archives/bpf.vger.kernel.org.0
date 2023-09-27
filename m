Return-Path: <bpf+bounces-11009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E327B0F92
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 01:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EF38F282142
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE01C4D8EE;
	Wed, 27 Sep 2023 23:30:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6915B6
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 23:30:14 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15AF9;
	Wed, 27 Sep 2023 16:30:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ad810be221so1573196966b.2;
        Wed, 27 Sep 2023 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695857411; x=1696462211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbKiPz0S5PrH/McDrIUSrlEVbeP0Nk47uyo5DMI/g4I=;
        b=SeNz/82i7Qtvsga7cn0qhDLDxIvpKX5CKF2MM0FSEpbvQCrXDJN/aRuUkeGx2ilvme
         LSpSZLUapTf0sDADoC4DVdMO4msZjE1pNe+IkPoNubyJivLdp4Mo35fFQ7zctgbvoE9i
         01SfHeJ3pWlwvp2Ay37EgtZv7GhBNUiR8AaruIhePbIn8wY9oTkyLMarnXFzqxtxWfFD
         DTtebXPsvH/mOYdpXk15UH8wLszRYBy5tLZ+tPdUhfBkVvv5//QEKmRMC1wEU9B86Xtf
         ZQkYbkHduGjYn3WsC8iDqiocXeJuEHSjg38QkzlffZq/rFJuc9PWwtGrFWykeJ/ISmO0
         Oylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695857411; x=1696462211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbKiPz0S5PrH/McDrIUSrlEVbeP0Nk47uyo5DMI/g4I=;
        b=X/EPuZxiHHKmlcm3LqSjBbb/VsBKz14mrJRqZDIiM3ZhzaoZbVpAZKgwZ+EK1kpwqr
         lYXseseX6riVYXkMlfF4avkkdufsEQqwWZig4HrDp7nYY/RbmVuPxt/Z3UDF/nWFbZ7a
         PCWyRnyq3Uq4o5a1qMBQKPb8qeZJDdL3VN9PqsWpzPgiz4qriBqWJcbSUJc4NxV270Vo
         DTWI7Js8giOgYmVJu6C+RXoaPVzGlknuIStgdl5XY/s5USWV1m0UAmexzQJa66dLlj8B
         +/b0nfinobX/Y4DVL9t2yRtZ15sCPcHoKlK5vLI5stnmlKO8RTlalz/fMa+t8TRBUcH2
         qYtA==
X-Gm-Message-State: AOJu0Yz3oRd6Qx7MEJq29vmjKKK5s8A+t7HWVkFI7FS1uR88OX0nhPPY
	oNWQOb2iX1QAQxG+5x0XaZJpCcDrYKr2RI18e3J0iJeH
X-Google-Smtp-Source: AGHT+IGMZgtSJDO5/A5UvywJSZqDi9vtZAD2iymTO1Gvi6K7UC4Jxq3SEkQWmh3wV7ewOVrSWtzjeoLvop2Fs0lEmIo=
X-Received: by 2002:a17:906:7692:b0:9a9:f042:dec0 with SMTP id
 o18-20020a170906769200b009a9f042dec0mr2636597ejm.38.1695857411121; Wed, 27
 Sep 2023 16:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925105552.817513-1-zhouchuyi@bytedance.com> <20230925105552.817513-6-zhouchuyi@bytedance.com>
In-Reply-To: <20230925105552.817513-6-zhouchuyi@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Sep 2023 16:29:59 -0700
Message-ID: <CAEf4Bzbeb+BZBNK+VU2THdJ5x5FeWp9SXVKOhLHCeFLwYijRig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/7] bpf: teach the verifier to enforce
 css_iter and task_iter in RCU CS
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 3:56=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> css_iter and task_iter should be used in rcu section. Specifically, in
> sleepable progs explicit bpf_rcu_read_lock() is needed before use these
> iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK to
> use them directly.
>
> This patch adds a new a KF flag KF_RCU_PROTECTED for bpf_iter_task_new an=
d
> bpf_iter_css_new. It means the kfunc should be used in RCU CS. We check
> whether we are in rcu cs before we want to invoke this kfunc. If the rcu
> protection is guaranteed, we would let st->type =3D PTR_TO_STACK | MEM_RC=
U.
> Once user do rcu_unlock during the iteration, state MEM_RCU of regs would
> be cleared. is_iter_reg_valid_init() will reject if reg->type is UNTRUSTE=
D.
>
> It is worth noting that currently, bpf_rcu_read_unlock does not
> clear the state of the STACK_ITER reg, since bpf_for_each_spilled_reg
> only considers STACK_SPILL. This patch also let bpf_for_each_spilled_reg
> search STACK_ITER.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/linux/bpf_verifier.h | 19 ++++++++------
>  include/linux/btf.h          |  1 +
>  kernel/bpf/helpers.c         |  4 +--
>  kernel/bpf/verifier.c        | 48 +++++++++++++++++++++++++++---------
>  4 files changed, 50 insertions(+), 22 deletions(-)
>

[...]

>
> -static bool is_iter_reg_valid_init(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg,
> +static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct b=
pf_reg_state *reg,
>                                    struct btf *btf, u32 btf_id, int nr_sl=
ots)
>  {
>         struct bpf_func_state *state =3D func(env, reg);
> @@ -1275,26 +1286,28 @@ static bool is_iter_reg_valid_init(struct bpf_ver=
ifier_env *env, struct bpf_reg_
>
>         spi =3D iter_get_spi(env, reg, nr_slots);
>         if (spi < 0)
> -               return false;
> +               return -EINVAL;
>
>         for (i =3D 0; i < nr_slots; i++) {
>                 struct bpf_stack_state *slot =3D &state->stack[spi - i];
>                 struct bpf_reg_state *st =3D &slot->spilled_ptr;
>
> +               if (st->type & PTR_UNTRUSTED)
> +                       return -EPERM;
>                 /* only main (first) slot has ref_obj_id set */
>                 if (i =3D=3D 0 && !st->ref_obj_id)
> -                       return false;
> +                       return -EINVAL;
>                 if (i !=3D 0 && st->ref_obj_id)
> -                       return false;
> +                       return -EINVAL;
>                 if (st->iter.btf !=3D btf || st->iter.btf_id !=3D btf_id)
> -                       return false;
> +                       return -EINVAL;
>
>                 for (j =3D 0; j < BPF_REG_SIZE; j++)
>                         if (slot->slot_type[j] !=3D STACK_ITER)
> -                               return false;
> +                               return -EINVAL;
>         }
>
> -       return true;
> +       return 0;
>  }
>
>  /* Check if given stack slot is "special":
> @@ -7503,15 +7516,20 @@ static int process_iter_arg(struct bpf_verifier_e=
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
> -               if (!is_iter_reg_valid_init(env, reg, meta->btf, btf_id, =
nr_slots)) {
> -                       verbose(env, "expected an initialized iter_%s as =
arg #%d\n",
> +               err =3D is_iter_reg_valid_init(env, reg, meta->btf, btf_i=
d, nr_slots);
> +               switch (err) {
> +               case -EINVAL:

I'd also add default: here, in case we ever emit some other error from
is_iter_reg_valid_init()

> +                       verbose(env, "expected an initialized iter_%s as =
arg #%d or without bpf_rcu_read_lock()\n",
>                                 iter_type_str(meta->btf, btf_id), regno);
> -                       return -EINVAL;
> +                       return err;
> +               case -EPERM:

I find -EPERM a bit confusing. Let's use something a bit more
specific, e.g., -EPROTO? We are basically not following a protocol if
we don't keep RCU-protected iterators within a single RCU region,
right?

> +                       verbose(env, "expected an RCU CS when using %s\n"=
, meta->func_name);
> +                       return err;
>                 }
>
>                 spi =3D iter_get_spi(env, reg, nr_slots);
> @@ -10092,6 +10110,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_a=
rg_meta *meta)
>         return meta->kfunc_flags & KF_RCU;
>  }
>
> +static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +       return meta->kfunc_flags & KF_RCU_PROTECTED;
> +}
> +
>  static bool __kfunc_param_match_suffix(const struct btf *btf,
>                                        const struct btf_param *arg,
>                                        const char *suffix)
> @@ -11428,6 +11451,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>         if (env->cur_state->active_rcu_lock) {
>                 struct bpf_func_state *state;
>                 struct bpf_reg_state *reg;
> +               u32 clear_mask =3D (1 << STACK_SPILL) | (1 << STACK_ITER)=
;
>
>                 if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_u=
nlock)) {
>                         verbose(env, "Calling bpf_rcu_read_{lock,unlock} =
in unnecessary rbtree callback\n");
> @@ -11438,7 +11462,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                         verbose(env, "nested rcu read lock (kernel functi=
on %s)\n", func_name);
>                         return -EINVAL;
>                 } else if (rcu_unlock) {
> -                       bpf_for_each_reg_in_vstate(env->cur_state, state,=
 reg, ({
> +                       bpf_for_each_reg_in_vstate_mask(env->cur_state, s=
tate, reg, clear_mask, ({
>                                 if (reg->type & MEM_RCU) {
>                                         reg->type &=3D ~(MEM_RCU | PTR_MA=
YBE_NULL);
>                                         reg->type |=3D PTR_UNTRUSTED;
> --
> 2.20.1
>

