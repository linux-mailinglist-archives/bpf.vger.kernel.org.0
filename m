Return-Path: <bpf+bounces-2038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC247270A1
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D8228155F
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2203D3B8B3;
	Wed,  7 Jun 2023 21:40:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C53B8A3
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:40:40 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867C8E4A
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:40:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso2487436a12.0
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686174035; x=1688766035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir1VyrmJvb10EcGCesQtctC6Aa1eLZq+7yp+jp2MJuo=;
        b=SfuqoKsVxLUUN391yn13RuHqLaT1WA8O3UONnegxrGYhog39MwIhIMaFZGJHVwqx/a
         TPsA5zzWe5HZvMpG//+W3mITS1BD9wMjCA2zqKoZYzqmL9Y6CzBwiIebyQvAqayPxZzb
         QZVkuoeJC9Cdk7tG+86qofhSYNeXagDpHqObjWve/Q3OfyP3hD5dMxcSzMLgm0aYn5mm
         UZ49SF9UY0iStaLtMKRrligSu3Wi79lHvptqSkijwDu5PE1EVLmiq6T3M0n6rzqq8f0q
         5MWB0bEaOWSVLFbqzZp2F5TjVjnih0TF3XceP+Kq5mQLWxsKpyNlRUOlOSfL9Kf66RF7
         S3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174035; x=1688766035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ir1VyrmJvb10EcGCesQtctC6Aa1eLZq+7yp+jp2MJuo=;
        b=PAoM9IEXIhQvuGgGFtQP8aN9Bw+5fAkPSLJxqBq/l/uUN8K2MrKAXHQxshIZMo/6Rx
         co8Mr/ROawDQEBdV/xxr1jkxMZwgGTy2rZq9A7JldYaA4BxexnbXM1l+vS8iZZDPxoD4
         afptTsRGVA1baKXW5KSrNMgD4LosUpM8GElme0326auXISKBRG7N3c67OerUhPt06h+2
         SSSSXUlLae0bItUqVCUPyrjCsihf/yn2+PTo7UeUpGlfr8mbiLn8Rc3J45iG2jnMkkMf
         EOuzjYNAmUVtFZ+ZHNmg+sbYA9XQz+druQVYHO5SaMPM6up5td5lYDWm3rN5+XJ5RHIS
         CL2w==
X-Gm-Message-State: AC+VfDzhJ7D7ixMjQ4I8xhaJfzIb2CddCK+ocwTv8e9P1yDkzhQvIuri
	HLyTqBuEojZwUVfqSfhKWMPFnSnzWj6Zg7rDhrI=
X-Google-Smtp-Source: ACHHUZ56IK+xC5O268u9uJvkSne7RmJGqR7wv1u+NX0XpvGwm5FJ1eVSFqVUfZ9H71pE63jVMiCPrKZqPyC8NPBua1k=
X-Received: by 2002:a50:fa91:0:b0:506:7c86:1fd with SMTP id
 w17-20020a50fa91000000b005067c8601fdmr5683277edr.37.1686174034778; Wed, 07
 Jun 2023 14:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606222411.1820404-1-eddyz87@gmail.com> <20230606222411.1820404-2-eddyz87@gmail.com>
In-Reply-To: <20230606222411.1820404-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jun 2023 14:40:22 -0700
Message-ID: <CAEf4BzYmi+_S79q4udJAx-9Ra4FasTHft_E9-=PeE0c3vqW2eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: use scalar ids in mark_chain_precision()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Change mark_chain_precision() to track precision in situations
> like below:
>
>     r2 =3D unknown value
>     ...
>   --- state #0 ---
>     ...
>     r1 =3D r2                 // r1 and r2 now share the same ID
>     ...
>   --- state #1 {r1.id =3D A, r2.id =3D A} ---
>     ...
>     if (r2 > 10) goto exit; // find_equal_scalars() assigns range to r1
>     ...
>   --- state #2 {r1.id =3D A, r2.id =3D A} ---
>     r3 =3D r10
>     r3 +=3D r1                // need to mark both r1 and r2
>
> At the beginning of the processing of each state, ensure that if a
> register with a scalar ID is marked as precise, all registers sharing
> this ID are also marked as precise.
>
> This property would be used by a follow-up change in regsafe().
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |  10 +-
>  kernel/bpf/verifier.c                         | 114 ++++++++++++++++++
>  .../testing/selftests/bpf/verifier/precise.c  |   8 +-
>  3 files changed, 127 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index ee4cc7471ed9..3f9856baa542 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -559,6 +559,11 @@ struct backtrack_state {
>         u64 stack_masks[MAX_CALL_FRAMES];
>  };
>
> +struct reg_id_scratch {
> +       u32 count;
> +       u32 ids[BPF_ID_MAP_SIZE];
> +};
> +
>  /* single container for all structs
>   * one verifier_env per bpf_check() call
>   */
> @@ -590,7 +595,10 @@ struct bpf_verifier_env {
>         const struct bpf_line_info *prev_linfo;
>         struct bpf_verifier_log log;
>         struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
> -       struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
> +       union {
> +               struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
> +               struct reg_id_scratch precise_ids_scratch;

naming nit: "ids_scratch" or "idset_scratch" to stay in line with
"idmap_scratch"?

> +       };
>         struct {
>                 int *insn_state;
>                 int *insn_stack;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d117deb03806..2aa60b73f1b5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3779,6 +3779,96 @@ static void mark_all_scalars_imprecise(struct bpf_=
verifier_env *env, struct bpf_
>         }
>  }
>
> +static inline bool reg_id_scratch_contains(struct reg_id_scratch *s, u32=
 id)
> +{
> +       u32 i;
> +
> +       for (i =3D 0; i < s->count; ++i)
> +               if (s->ids[i] =3D=3D id)
> +                       return true;
> +
> +       return false;
> +}
> +
> +static inline int reg_id_scratch_push(struct reg_id_scratch *s, u32 id)
> +{
> +       if (WARN_ON_ONCE(s->count >=3D ARRAY_SIZE(s->ids)))
> +               return -1;
> +       s->ids[s->count++] =3D id;

this will allow duplicated IDs to be added? Was it done in the name of spee=
d?

> +       WARN_ONCE(s->count > 64,
> +                 "reg_id_scratch.count is unreasonably large (%d)", s->c=
ount);

do we need this one? Especially that it's not _ONCE variant? Maybe the
first WARN_ON_ONCE is enough?

> +       return 0;
> +}
> +
> +static inline void reg_id_scratch_reset(struct reg_id_scratch *s)

we probably don't need "inline" for all these helpers?

> +{
> +       s->count =3D 0;
> +}
> +
> +/* Collect a set of IDs for all registers currently marked as precise in=
 env->bt.
> + * Mark all registers with these IDs as precise.
> + */
> +static void mark_precise_scalar_ids(struct bpf_verifier_env *env, struct=
 bpf_verifier_state *st)
> +{
> +       struct reg_id_scratch *precise_ids =3D &env->precise_ids_scratch;
> +       struct backtrack_state *bt =3D &env->bt;
> +       struct bpf_func_state *func;
> +       struct bpf_reg_state *reg;
> +       DECLARE_BITMAP(mask, 64);
> +       int i, fr;
> +
> +       reg_id_scratch_reset(precise_ids);
> +
> +       for (fr =3D bt->frame; fr >=3D 0; fr--) {
> +               func =3D st->frame[fr];
> +
> +               bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
> +               for_each_set_bit(i, mask, 32) {
> +                       reg =3D &func->regs[i];
> +                       if (!reg->id || reg->type !=3D SCALAR_VALUE)
> +                               continue;
> +                       if (reg_id_scratch_push(precise_ids, reg->id))
> +                               return;
> +               }
> +
> +               bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
> +               for_each_set_bit(i, mask, 64) {
> +                       if (i >=3D func->allocated_stack / BPF_REG_SIZE)
> +                               break;
> +                       if (!is_spilled_scalar_reg(&func->stack[i]))
> +                               continue;
> +                       reg =3D &func->stack[i].spilled_ptr;
> +                       if (!reg->id || reg->type !=3D SCALAR_VALUE)

is_spilled_scalar_reg() already ensures reg->type is SCALAR_VALUE

> +                               continue;
> +                       if (reg_id_scratch_push(precise_ids, reg->id))
> +                               return;

if push fails (due to overflow of id set), shouldn't we propagate
error back and fallback to mark_all_precise?


> +               }
> +       }
> +
> +       for (fr =3D 0; fr <=3D st->curframe; ++fr) {
> +               func =3D st->frame[fr];
> +
> +               for (i =3D BPF_REG_0; i < BPF_REG_10; ++i) {
> +                       reg =3D &func->regs[i];
> +                       if (!reg->id)
> +                               continue;
> +                       if (!reg_id_scratch_contains(precise_ids, reg->id=
))
> +                               continue;
> +                       bt_set_frame_reg(bt, fr, i);
> +               }
> +               for (i =3D 0; i < func->allocated_stack / BPF_REG_SIZE; +=
+i) {
> +                       if (!is_spilled_scalar_reg(&func->stack[i]))
> +                               continue;
> +                       reg =3D &func->stack[i].spilled_ptr;
> +                       if (!reg->id)
> +                               continue;
> +                       if (!reg_id_scratch_contains(precise_ids, reg->id=
))
> +                               continue;
> +                       bt_set_frame_slot(bt, fr, i);
> +               }
> +       }
> +}
> +
>  /*
>   * __mark_chain_precision() backtracks BPF program instruction sequence =
and
>   * chain of verifier states making sure that register *regno* (if regno =
>=3D 0)
> @@ -3910,6 +4000,30 @@ static int __mark_chain_precision(struct bpf_verif=
ier_env *env, int regno)
>                                 bt->frame, last_idx, first_idx, subseq_id=
x);
>                 }
>
> +               /* If some register with scalar ID is marked as precise,
> +                * make sure that all registers sharing this ID are also =
precise.
> +                * This is needed to estimate effect of find_equal_scalar=
s().
> +                * Do this at the last instruction of each state,
> +                * bpf_reg_state::id fields are valid for these instructi=
ons.
> +                *
> +                * Allows to track precision in situation like below:
> +                *
> +                *     r2 =3D unknown value
> +                *     ...
> +                *   --- state #0 ---
> +                *     ...
> +                *     r1 =3D r2                 // r1 and r2 now share t=
he same ID
> +                *     ...
> +                *   --- state #1 {r1.id =3D A, r2.id =3D A} ---
> +                *     ...
> +                *     if (r2 > 10) goto exit; // find_equal_scalars() as=
signs range to r1
> +                *     ...
> +                *   --- state #2 {r1.id =3D A, r2.id =3D A} ---
> +                *     r3 =3D r10
> +                *     r3 +=3D r1                // need to mark both r1 =
and r2
> +                */
> +               mark_precise_scalar_ids(env, st);
> +
>                 if (last_idx < 0) {
>                         /* we are at the entry into subprog, which
>                          * is expected for global funcs, but only if
> diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testi=
ng/selftests/bpf/verifier/precise.c
> index b8c0aae8e7ec..99272bb890da 100644
> --- a/tools/testing/selftests/bpf/verifier/precise.c
> +++ b/tools/testing/selftests/bpf/verifier/precise.c
> @@ -46,7 +46,7 @@
>         mark_precise: frame0: regs=3Dr2 stack=3D before 20\
>         mark_precise: frame0: parent state regs=3Dr2 stack=3D:\
>         mark_precise: frame0: last_idx 19 first_idx 10\
> -       mark_precise: frame0: regs=3Dr2 stack=3D before 19\
> +       mark_precise: frame0: regs=3Dr2,r9 stack=3D before 19\
>         mark_precise: frame0: regs=3Dr9 stack=3D before 18\
>         mark_precise: frame0: regs=3Dr8,r9 stack=3D before 17\
>         mark_precise: frame0: regs=3Dr0,r9 stack=3D before 15\
> @@ -106,10 +106,10 @@
>         mark_precise: frame0: regs=3Dr2 stack=3D before 22\
>         mark_precise: frame0: parent state regs=3Dr2 stack=3D:\
>         mark_precise: frame0: last_idx 20 first_idx 20\
> -       mark_precise: frame0: regs=3Dr2 stack=3D before 20\
> -       mark_precise: frame0: parent state regs=3Dr2 stack=3D:\
> +       mark_precise: frame0: regs=3Dr2,r9 stack=3D before 20\
> +       mark_precise: frame0: parent state regs=3Dr2,r9 stack=3D:\
>         mark_precise: frame0: last_idx 19 first_idx 17\
> -       mark_precise: frame0: regs=3Dr2 stack=3D before 19\
> +       mark_precise: frame0: regs=3Dr2,r9 stack=3D before 19\
>         mark_precise: frame0: regs=3Dr9 stack=3D before 18\
>         mark_precise: frame0: regs=3Dr8,r9 stack=3D before 17\
>         mark_precise: frame0: parent state regs=3D stack=3D:",
> --
> 2.40.1
>

