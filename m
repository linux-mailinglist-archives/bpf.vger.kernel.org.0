Return-Path: <bpf+bounces-10959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936497B0132
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 12:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 11920B20AC4
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A77266D1;
	Wed, 27 Sep 2023 10:01:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3133F1
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 10:01:00 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116A59F;
	Wed, 27 Sep 2023 03:00:58 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-64cca551ae2so62732166d6.0;
        Wed, 27 Sep 2023 03:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695808857; x=1696413657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AW1sOFKUHwYbhcsQE+C2kQ8PARbC/GgdyTh4PxP3nY=;
        b=Ogcf/DAYy+p5PV1DfI6EtrgD2BJDtTSBYjB0fdcFRfWpgx1CcGTpP8wXYHN0X0Qs2B
         YaYNaHvvfH+VmvOYUKXtQnjYvSEf1qgicdQGVDoybCtWZJvGqctHnu96ZSXm7WsDP9yL
         6IOpkTM8NDAs3qtq2HvPZ/6e8RD1TVMbeiQd/Fh6S3O1cC3yE1iOwz48MxUEDU0oTj7f
         nRV4J6q8eYJe6CH/VBkMfo898D5pnrUPTsKFkPQF4uWPZqQCD/wIwblymKOyBk4fzb1j
         Hkke6zaXuImoWuNIdOAuwVyR9sFeXAsxQa31YHSjwQCfWRngzqGdkNgqzMzMwHijZ1Cg
         fFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695808857; x=1696413657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AW1sOFKUHwYbhcsQE+C2kQ8PARbC/GgdyTh4PxP3nY=;
        b=CNXHGgoeHR5c9vtmKTAagdQOC1H8r1OaX+3//BdXU9A2vsVcVE8Oo2fC1A/J9pYGbN
         M2Z3VEJKS+M0pQfIxwUuma3Hxj/RQPzLWKYuE0lWdZrHKmvaTl3KhwS35RqxDaxBqjxg
         hA5o+/fTjtID4/WthO2rE8rnUkJS9llDV+b7uyLIjpD2fjy1pzfIK90f83SNSluf9GtV
         BLE+GKXcjYnPgCUBIpsCu1Ya5Gd4KskRycyWLQaqEViO4HGXZlU5gTIh2j1m3IvB/2VT
         Q0gxMMMr+vCJj50j83fjVKchp8TtRW3unXzyaTqJY1Iz/8isPADVvEKlLuuYBReDGGBK
         dtKw==
X-Gm-Message-State: AOJu0Yw8RkVPAyd8Whp8G9lY5Is2l40CRzTQlrDbNP6Rt2hLsPHmgPDr
	2EYAl00KTVNUT8tEqmcq8KyhvL8USplMzgkfcRVFKHBSbj/hlQ==
X-Google-Smtp-Source: AGHT+IEfPQV8nubMUCNRl0FTwIOmCDRsZWsRD7QF+A0ce1SS/qpfojqIfksLAahGVUv7ej2VJZ/gnE3YnKaIHlnHM+s=
X-Received: by 2002:a0c:b40e:0:b0:647:1fc5:1cc3 with SMTP id
 u14-20020a0cb40e000000b006471fc51cc3mr1502007qve.36.1695808856984; Wed, 27
 Sep 2023 03:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925105552.817513-1-zhouchuyi@bytedance.com> <20230925105552.817513-6-zhouchuyi@bytedance.com>
In-Reply-To: <20230925105552.817513-6-zhouchuyi@bytedance.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 27 Sep 2023 18:00:20 +0800
Message-ID: <CALOAHbBrSasWs1=15TB0O+DnKohVKQrRWTM6x9zP-VR1G9zehQ@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 6:56=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.com=
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

This patch should be ahead of patch #2 and you introduce
KF_RCU_PROTECTED in it then use this flag in later patches.
BTW, I can't apply your series on bpf-next. I think you should rebase
it on the latest bpf-next, otherwise the BPF CI can't be triggered.

> ---
>  include/linux/bpf_verifier.h | 19 ++++++++------
>  include/linux/btf.h          |  1 +
>  kernel/bpf/helpers.c         |  4 +--
>  kernel/bpf/verifier.c        | 48 +++++++++++++++++++++++++++---------
>  4 files changed, 50 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index a3236651ec64..b5cdcc332b0a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -385,19 +385,18 @@ struct bpf_verifier_state {
>         u32 jmp_history_cnt;
>  };
>
> -#define bpf_get_spilled_reg(slot, frame)                               \
> +#define bpf_get_spilled_reg(slot, frame, mask)                         \
>         (((slot < frame->allocated_stack / BPF_REG_SIZE) &&             \
> -         (frame->stack[slot].slot_type[0] =3D=3D STACK_SPILL))          =
   \
> +         ((1 << frame->stack[slot].slot_type[0]) & (mask))) \
>          ? &frame->stack[slot].spilled_ptr : NULL)
>
>  /* Iterate over 'frame', setting 'reg' to either NULL or a spilled regis=
ter. */
> -#define bpf_for_each_spilled_reg(iter, frame, reg)                     \
> -       for (iter =3D 0, reg =3D bpf_get_spilled_reg(iter, frame);       =
   \
> +#define bpf_for_each_spilled_reg(iter, frame, reg, mask)                =
       \
> +       for (iter =3D 0, reg =3D bpf_get_spilled_reg(iter, frame, mask); =
           \
>              iter < frame->allocated_stack / BPF_REG_SIZE;              \
> -            iter++, reg =3D bpf_get_spilled_reg(iter, frame))
> +            iter++, reg =3D bpf_get_spilled_reg(iter, frame, mask))
>
> -/* Invoke __expr over regsiters in __vst, setting __state and __reg */
> -#define bpf_for_each_reg_in_vstate(__vst, __state, __reg, __expr)   \
> +#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, _=
_expr)   \
>         ({                                                               =
\
>                 struct bpf_verifier_state *___vstate =3D __vst;          =
  \
>                 int ___i, ___j;                                          =
\
> @@ -409,7 +408,7 @@ struct bpf_verifier_state {
>                                 __reg =3D &___regs[___j];                =
  \
>                                 (void)(__expr);                          =
\
>                         }                                                =
\
> -                       bpf_for_each_spilled_reg(___j, __state, __reg) { =
\
> +                       bpf_for_each_spilled_reg(___j, __state, __reg, __=
mask) { \
>                                 if (!__reg)                              =
\
>                                         continue;                        =
\
>                                 (void)(__expr);                          =
\
> @@ -417,6 +416,10 @@ struct bpf_verifier_state {
>                 }                                                        =
\
>         })
>
> +/* Invoke __expr over regsiters in __vst, setting __state and __reg */
> +#define bpf_for_each_reg_in_vstate(__vst, __state, __reg, __expr) \
> +       bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, 1 << STACK=
_SPILL, __expr)
> +
>  /* linked list of verifier states used to prune search */
>  struct bpf_verifier_state_list {
>         struct bpf_verifier_state state;
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 928113a80a95..c2231c64d60b 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -74,6 +74,7 @@
>  #define KF_ITER_NEW     (1 << 8) /* kfunc implements BPF iter constructo=
r */
>  #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next metho=
d */
>  #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructo=
r */
> +#define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu c=
s when they are invoked */
>
>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize t=
he
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9c3af36249a2..aa9e03fbfe1a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2507,10 +2507,10 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_=
DESTROY)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> -BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF=
_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
> -BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_=
RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2367483bf4c2..a065e18a0b3a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1172,7 +1172,12 @@ static bool is_dynptr_type_expected(struct bpf_ver=
ifier_env *env, struct bpf_reg
>
>  static void __mark_reg_known_zero(struct bpf_reg_state *reg);
>
> +static bool in_rcu_cs(struct bpf_verifier_env *env);
> +
> +static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta)=
;
> +
>  static int mark_stack_slots_iter(struct bpf_verifier_env *env,
> +                                struct bpf_kfunc_call_arg_meta *meta,
>                                  struct bpf_reg_state *reg, int insn_idx,
>                                  struct btf *btf, u32 btf_id, int nr_slot=
s)
>  {
> @@ -1193,6 +1198,12 @@ static int mark_stack_slots_iter(struct bpf_verifi=
er_env *env,
>
>                 __mark_reg_known_zero(st);
>                 st->type =3D PTR_TO_STACK; /* we don't have dedicated reg=
 type */
> +               if (is_kfunc_rcu_protected(meta)) {
> +                       if (in_rcu_cs(env))
> +                               st->type |=3D MEM_RCU;

I think this change is incorrect.  The type of st->type is enum
bpf_reg_type, but MEM_RCU is enum bpf_type_flag.
Or am I missing something?

> +                       else
> +                               st->type |=3D PTR_UNTRUSTED;
> +               }
>                 st->live |=3D REG_LIVE_WRITTEN;
>                 st->ref_obj_id =3D i =3D=3D 0 ? id : 0;
>                 st->iter.btf =3D btf;
> @@ -1267,7 +1278,7 @@ static bool is_iter_reg_valid_uninit(struct bpf_ver=
ifier_env *env,
>         return true;
>  }
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
> +                       verbose(env, "expected an initialized iter_%s as =
arg #%d or without bpf_rcu_read_lock()\n",
>                                 iter_type_str(meta->btf, btf_id), regno);
> -                       return -EINVAL;
> +                       return err;
> +               case -EPERM:
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
>


--=20
Regards
Yafang

