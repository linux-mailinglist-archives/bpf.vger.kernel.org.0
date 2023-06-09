Return-Path: <bpf+bounces-2280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAE072A69C
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 01:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BC9281A99
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 23:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A66C148;
	Fri,  9 Jun 2023 23:12:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C3D539C
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 23:12:11 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E511C30C1
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 16:12:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so4037925a12.1
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 16:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686352327; x=1688944327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xchFt/bFSeY/NTrFatYMAtCHB3jh3+WinpJx5+0YC10=;
        b=b4/DtrEY+I4hr3nGrwL1BfpYETBTa8agx1HvdK+6sVPrvqA51Vz8XwrGgNIbcFxxBU
         LHHz0z6Xh5BqRrtrh9X/v2ShQOz2NEEEz6A3MEM19v+nChEIzdj56P6/dSCFKPPreT3N
         g0KPzP2J7Ne1zJgkOxsajTgHnAixVT54pCByG8hgNfrTc/4YleD/dEqkdFT1/yEgoS/x
         +OPv1nug0NVvHYGP5dzVwxXOwSWXs99uA2NVNwqAiXpFTnq9KAkkvP2dCBFtBLj7RQaD
         eIHI4ovQwcJ8cMqUN/ERfa/6+aDTMIVMHoLsgBjEtEFwC2JDVxRZ0ygjz6StlSUXL2o3
         RgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686352327; x=1688944327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xchFt/bFSeY/NTrFatYMAtCHB3jh3+WinpJx5+0YC10=;
        b=K+yCeH4NLxKwu6ab5b6Hv7AB2woOpQk0nEPYUEU5wULM1RW52GVdTn3fe9Hc1P2kXD
         WfNp8qQ4luWBbbH3yI7GfBvI8Ufh7eVwqFHfnYDV7vcI4kUfFluEscKe2jHwABmL2W7h
         lhNoYWFg9tNRTTaSRKjGKMbgBtuNhr+LRaAErFXVETmE5ch4HIh2yPZWyABo/LylkVDP
         nzI8Hbg6b/b4DZ3I/eW+z2JLCIXM0lELnLJT1M58rd8fIBk7QTnn+kZzA1n4snAqT4jr
         NGcEykx8edMcCl43LaEDoWTTW9UVl/4Mcu+QDrnJgFJ5vFUYu2EiF2wmvMzMKqTaEd7R
         Q4qw==
X-Gm-Message-State: AC+VfDzpZ9t1NIVk+4RSp5cwvk6BIpooj3xM4X33dBK7y9BOvBeKmbFS
	5NDiEkaTmWZoMU6LytavKyXJPyJI2dHjzpKp21w=
X-Google-Smtp-Source: ACHHUZ4FhVCOX4PoIrT8WEaMa0+m6q2UgW79v6LbR8gGlvv1/SZd3BexyTFwdb8sz8+ci41//Kcosxk//c1rvbV5+J8=
X-Received: by 2002:a17:907:8a02:b0:973:8198:bbf7 with SMTP id
 sc2-20020a1709078a0200b009738198bbf7mr3294372ejc.11.1686352327073; Fri, 09
 Jun 2023 16:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230609210143.2625430-1-eddyz87@gmail.com> <20230609210143.2625430-4-eddyz87@gmail.com>
In-Reply-To: <20230609210143.2625430-4-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jun 2023 16:11:55 -0700
Message-ID: <CAEf4BzYar7RifhvAgtjit0ibCXfJPHEHHxa85GYbphU-WartXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 9, 2023 at 2:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Make sure that the following unsafe example is rejected by verifier:
>
> 1: r9 =3D ... some pointer with range X ...
> 2: r6 =3D ... unbound scalar ID=3Da ...
> 3: r7 =3D ... unbound scalar ID=3Db ...
> 4: if (r6 > r7) goto +1
> 5: r6 =3D r7
> 6: if (r6 > X) goto ...
> --- checkpoint ---
> 7: r9 +=3D r7
> 8: *(u64 *)r9 =3D Y
>
> This example is unsafe because not all execution paths verify r7 range.
> Because of the jump at (4) the verifier would arrive at (6) in two states=
:
> I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
>
> Currently regsafe() does not call check_ids() for scalar registers,
> thus from POV of regsafe() states (I) and (II) are identical. If the
> path 1-6 is taken by verifier first, and checkpoint is created at (6)
> the path [1-4, 6] would be considered safe.
>
> This commit adds a new function: check_scalar_ids() and updates
> regsafe() to call it for precise scalar registers.
> check_scalar_ids() differs from check_ids() in order to:
> - treat ID zero as a unique scalar ID;
> - disallow mapping same 'cur_id' to multiple 'old_id'.
>
> To minimize the impact on verification performance, avoid generating
> bpf_reg_state::id for constant scalar values when processing BPF_MOV
> in check_alu_op(). Scalar IDs are utilized by find_equal_scalars() to
> propagate information about value ranges for registers that hold the
> same value. However, there is no need to propagate range information
> for constants.
>
> Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assig=
nments.")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  1 +
>  kernel/bpf/verifier.c        | 77 +++++++++++++++++++++++++++++++++---
>  2 files changed, 73 insertions(+), 5 deletions(-)
>

I have lots of gripes with specifics in this patch, as you can see
below. But ultimately this should fix the issue and we can discuss the
rest separately.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 73a98f6240fd..1bdda17fad70 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -584,6 +584,7 @@ struct bpf_verifier_env {
>         u32 used_map_cnt;               /* number of used maps */
>         u32 used_btf_cnt;               /* number of used BTF objects */
>         u32 id_gen;                     /* used to generate unique reg ID=
s */
> +       u32 tmp_id_gen;
>         bool explore_alu_limits;
>         bool allow_ptr_leaks;
>         bool allow_uninit_stack;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f719de396c61..c6797742f38e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12942,12 +12942,14 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
>                 if (BPF_SRC(insn->code) =3D=3D BPF_X) {
>                         struct bpf_reg_state *src_reg =3D regs + insn->sr=
c_reg;
>                         struct bpf_reg_state *dst_reg =3D regs + insn->ds=
t_reg;
> +                       bool need_id =3D src_reg->type =3D=3D SCALAR_VALU=
E && !src_reg->id &&
> +                                      !tnum_is_const(src_reg->var_off);
>
>                         if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
>                                 /* case: R1 =3D R2
>                                  * copy register state to dest reg
>                                  */
> -                               if (src_reg->type =3D=3D SCALAR_VALUE && =
!src_reg->id)
> +                               if (need_id)
>                                         /* Assign src and dst registers t=
he same ID
>                                          * that will be used by find_equa=
l_scalars()
>                                          * to propagate min/max range.
> @@ -12966,7 +12968,7 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>                                 } else if (src_reg->type =3D=3D SCALAR_VA=
LUE) {
>                                         bool is_src_reg_u32 =3D src_reg->=
umax_value <=3D U32_MAX;
>
> -                                       if (is_src_reg_u32 && !src_reg->i=
d)
> +                                       if (is_src_reg_u32 && need_id)
>                                                 src_reg->id =3D ++env->id=
_gen;
>                                         copy_register_state(dst_reg, src_=
reg);
>                                         /* Make sure ID is cleared if src=
_reg is not in u32 range otherwise
> @@ -15148,6 +15150,36 @@ static bool check_ids(u32 old_id, u32 cur_id, st=
ruct bpf_id_pair *idmap)
>         return false;
>  }
>
> +/* Similar to check_ids(), but:
> + * - disallow mapping of different 'old_id' values to same 'cur_id' valu=
e;
> + * - for zero 'old_id' or 'cur_id' allocate a unique temporary ID
> + *   to allow pairs like '0 vs unique ID', 'unique ID vs 0'.
> + */
> +static bool check_scalar_ids(struct bpf_verifier_env *env, u32 old_id, u=
32 cur_id,
> +                            struct bpf_id_pair *idmap)
> +{
> +       unsigned int i;
> +
> +       old_id =3D old_id ? old_id : ++env->tmp_id_gen;
> +       cur_id =3D cur_id ? cur_id : ++env->tmp_id_gen;
> +
> +       for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
> +               if (!idmap[i].old) {
> +                       /* Reached an empty slot; haven't seen this id be=
fore */
> +                       idmap[i].old =3D old_id;
> +                       idmap[i].cur =3D cur_id;
> +                       return true;
> +               }
> +               if (idmap[i].old =3D=3D old_id)
> +                       return idmap[i].cur =3D=3D cur_id;
> +               if (idmap[i].cur =3D=3D cur_id)
> +                       return false;

As I mentioned, I think we should do it always (even if in some
*partial* cases this might not be necessary to guarantee correctness),
I believe this is what idmap semantics is promising to check, but we
actually don't. But we can discuss that separately.

> +       }
> +       /* We ran out of idmap slots, which should be impossible */
> +       WARN_ON_ONCE(1);
> +       return false;
> +}
> +
>  static void clean_func_state(struct bpf_verifier_env *env,
>                              struct bpf_func_state *st)
>  {
> @@ -15253,6 +15285,15 @@ static bool regs_exact(const struct bpf_reg_stat=
e *rold,
>                check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
>  }
>
> +static bool scalar_regs_exact(struct bpf_verifier_env *env,
> +                             const struct bpf_reg_state *rold,
> +                             const struct bpf_reg_state *rcur,
> +                             struct bpf_id_pair *idmap)
> +{
> +       return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=
=3D 0 &&
> +              check_scalar_ids(env, rold->id, rcur->id, idmap);

At this point I don't know if there is any benefit to having this
special scalar_regs_exact() implementation. We are just assuming that
memcmp() of 88 bytes is significantly faster than doing range_within()
(8 straightforward comparisons) and tnum_in() (few bit operations and
one comparison). And if this doesn't work out, we pay the price of
both memcmp and range_within+tnum_in. Plus check_scalar_ids() in both
cases.

I suspect that just dropping memcmp() will be at least not worse, if not be=
tter.

> +}
> +
>  /* Returns true if (rold safe implies rcur safe) */
>  static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *=
rold,
>                     struct bpf_reg_state *rcur, struct bpf_id_pair *idmap=
)
> @@ -15292,15 +15333,39 @@ static bool regsafe(struct bpf_verifier_env *en=
v, struct bpf_reg_state *rold,
>
>         switch (base_type(rold->type)) {
>         case SCALAR_VALUE:
> -               if (regs_exact(rold, rcur, idmap))
> +               if (scalar_regs_exact(env, rold, rcur, idmap))
>                         return true;
>                 if (env->explore_alu_limits)
>                         return false;
>                 if (!rold->precise)
>                         return true;
> -               /* new val must satisfy old val knowledge */
> +               /* Why check_ids() for scalar registers?
> +                *
> +                * Consider the following BPF code:
> +                *   1: r6 =3D ... unbound scalar, ID=3Da ...
> +                *   2: r7 =3D ... unbound scalar, ID=3Db ...
> +                *   3: if (r6 > r7) goto +1
> +                *   4: r6 =3D r7
> +                *   5: if (r6 > X) goto ...
> +                *   6: ... memory operation using r7 ...
> +                *
> +                * First verification path is [1-6]:
> +                * - at (4) same bpf_reg_state::id (b) would be assigned =
to r6 and r7;
> +                * - at (5) r6 would be marked <=3D X, find_equal_scalars=
() would also mark
> +                *   r7 <=3D X, because r6 and r7 share same id.
> +                * Next verification path is [1-4, 6].
> +                *
> +                * Instruction (6) would be reached in two states:
> +                *   I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> +                *   II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
> +                *
> +                * Use check_ids() to distinguish these states.
> +                * ---
> +                * Also verify that new value satisfies old value range k=
nowledge.
> +                */
>                 return range_within(rold, rcur) &&
> -                      tnum_in(rold->var_off, rcur->var_off);
> +                      tnum_in(rold->var_off, rcur->var_off) &&
> +                      check_scalar_ids(env, rold->id, rcur->id, idmap);
>         case PTR_TO_MAP_KEY:
>         case PTR_TO_MAP_VALUE:
>         case PTR_TO_MEM:
> @@ -15542,6 +15607,8 @@ static bool states_equal(struct bpf_verifier_env =
*env,
>         if (old->active_rcu_lock !=3D cur->active_rcu_lock)
>                 return false;
>
> +       env->tmp_id_gen =3D env->id_gen;
> +

sigh, this is kind of ugly, but ok :( Ideally we have

struct idmap_scratch {
    int id_gen;
    struct bpf_id_pair mapping[BPF_ID_MAP_SIZE];
}

and just initialize idmap_scratch.id_gen =3D env->id_gen and keep all
this very local to id_map.

But I'm nitpicking.


>         /* for states to be equal callsites have to be the same
>          * and all frame states need to be equivalent
>          */
> --
> 2.40.1
>

