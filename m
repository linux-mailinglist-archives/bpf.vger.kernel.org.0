Return-Path: <bpf+bounces-2275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FF572A63B
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 00:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25ED1C20A86
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 22:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2624E96;
	Fri,  9 Jun 2023 22:25:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38623403
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 22:25:05 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852C3A87
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 15:24:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977d55ac17bso398039666b.3
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686349496; x=1688941496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzaPjRKJyh8nuSzaQVaGmg5nyODPuPb+YPSmOTqfPQ4=;
        b=QQZBuBku2+dtU3HlHf6LShLIn/Un6IFFUVZEkbUFViJmE+OzElupEtjTX/MW1kYqCl
         SyiCKmKUqX7uQB2CPQ8DRSdDClM/NsR8RTzdpw2OjpWX3ybHcz2Otcb/0FRVo1DQFYzh
         2VN/3R05ZyL8L8ThcK7AmZjmSlRVUYqADHfMKeU1aHweXosIUZqzuL1TSISMnNSFoA7R
         WMoz7F5oewopyLd6lT9M5vM4noocn1/ZX8YNJz2lr2iudn5iDfQa73QWd3ydQySOlICN
         lHQUOeBM3HWdgzzy37tg+UXKwaK1fHObuT3thVGdTpyK1HFcmqNEw2Qtl/Yq4cE2YVAr
         Wf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686349496; x=1688941496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzaPjRKJyh8nuSzaQVaGmg5nyODPuPb+YPSmOTqfPQ4=;
        b=DLCUUTLv2TYkWXa2UmKIqLSoTcs9Aoz1yFcuE6SpLlphBqS+KPKFlXlEqnUXqhex9e
         hfPYy/83up7a+eJc7ObR5n7zhyknMR84QnPQUBohC2G7bx8FflvV2WYR57I9XryR4m6w
         3+hNVAaFDakl8o7YDTzCWZ2r0liwoCXo0X867TQUeKBMLtGWfDspYZEd/mArPvpQeO05
         0t+SSQFpqNFBo4WjJiuN+nBui9Rqc6W6GcXxNllGh12h1qIMyECUqPZIEqsd0OfBR66e
         1kkDbNke61hDaz7MikdnfsiQ6Ad6DkbnQZ+LcMgQLaAOpwAxJ7K5OLkLlw99Zxzjlas1
         BA7g==
X-Gm-Message-State: AC+VfDzTP8EJvb0rFWs0PlgIFflRHhEx4MfcBOSdH7TTENEwnt7Qt001
	7nwLGHlLLGVU5jOMxzkSI/6K5PyYUbobsvls9mk=
X-Google-Smtp-Source: ACHHUZ6TyMYLfVkVvnmbU+0M6EmixkjFeJk/5R7badiq+BiOF1OAitkGd9ShVqTjthWYMYqhefJ/UFTko3gPLvZ2xvA=
X-Received: by 2002:a17:907:62a0:b0:978:afbc:676e with SMTP id
 nd32-20020a17090762a000b00978afbc676emr3579094ejc.6.1686349496090; Fri, 09
 Jun 2023 15:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230609210143.2625430-1-eddyz87@gmail.com> <20230609210143.2625430-2-eddyz87@gmail.com>
In-Reply-To: <20230609210143.2625430-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jun 2023 15:24:43 -0700
Message-ID: <CAEf4BzY7cfD-hKo7jMpj6O9KhjFKZZ0VxaUKxMFMoLDy2QEogQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: use scalar ids in mark_chain_precision()
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

On Fri, Jun 9, 2023 at 2:01=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
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
>  kernel/bpf/verifier.c                         | 115 ++++++++++++++++++
>  .../testing/selftests/bpf/verifier/precise.c  |   8 +-
>  3 files changed, 128 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5fe589e11ac8..73a98f6240fd 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -559,6 +559,11 @@ struct backtrack_state {
>         u64 stack_masks[MAX_CALL_FRAMES];
>  };
>
> +struct bpf_idset {
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
> +               struct bpf_idset idset_scratch;
> +       };
>         struct {
>                 int *insn_state;
>                 int *insn_stack;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed79a93398f8..f719de396c61 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3787,6 +3787,96 @@ static void mark_all_scalars_imprecise(struct bpf_=
verifier_env *env, struct bpf_
>         }
>  }
>
> +static bool idset_contains(struct bpf_idset *s, u32 id)
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
> +static int idset_push(struct bpf_idset *s, u32 id)
> +{
> +       if (WARN_ON_ONCE(s->count >=3D ARRAY_SIZE(s->ids)))
> +               return -1;
> +       s->ids[s->count++] =3D id;
> +       return 0;
> +}
> +
> +static void idset_reset(struct bpf_idset *s)
> +{
> +       s->count =3D 0;
> +}
> +
> +/* Collect a set of IDs for all registers currently marked as precise in=
 env->bt.
> + * Mark all registers with these IDs as precise.
> + */
> +static int mark_precise_scalar_ids(struct bpf_verifier_env *env, struct =
bpf_verifier_state *st)
> +{
> +       struct bpf_idset *precise_ids =3D &env->idset_scratch;
> +       struct backtrack_state *bt =3D &env->bt;
> +       struct bpf_func_state *func;
> +       struct bpf_reg_state *reg;
> +       DECLARE_BITMAP(mask, 64);
> +       int i, fr;
> +
> +       idset_reset(precise_ids);
> +
> +       for (fr =3D bt->frame; fr >=3D 0; fr--) {
> +               func =3D st->frame[fr];
> +
> +               bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
> +               for_each_set_bit(i, mask, 32) {
> +                       reg =3D &func->regs[i];
> +                       if (!reg->id || reg->type !=3D SCALAR_VALUE)
> +                               continue;
> +                       if (idset_push(precise_ids, reg->id))
> +                               return -1;
> +               }
> +
> +               bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
> +               for_each_set_bit(i, mask, 64) {
> +                       if (i >=3D func->allocated_stack / BPF_REG_SIZE)
> +                               break;
> +                       if (!is_spilled_scalar_reg(&func->stack[i]))
> +                               continue;
> +                       reg =3D &func->stack[i].spilled_ptr;
> +                       if (!reg->id)
> +                               continue;
> +                       if (idset_push(precise_ids, reg->id))
> +                               return -1;

-EFAULT, -1 is -EPERM, super confusing if it ever bubbles up. Same for
idset_push return code, please use more appropriate error code
constants

Other than that, it looks good. Please add my ack once you fix error values=
:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


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
> +                       if (!idset_contains(precise_ids, reg->id))
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
> +                       if (!idset_contains(precise_ids, reg->id))
> +                               continue;
> +                       bt_set_frame_slot(bt, fr, i);
> +               }
> +       }
> +
> +       return 0;
> +}
> +

[...]

