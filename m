Return-Path: <bpf+bounces-2121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C437B728021
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 14:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8469728170E
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB7BD2FC;
	Thu,  8 Jun 2023 12:35:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6663B407
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 12:35:23 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F021FDF
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 05:35:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso686853e87.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686227718; x=1688819718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9dF86ekNLRqalsvWZuyWAOS0CIdPFsbBDpzcSRmeaQ0=;
        b=NNXaBQpR+qhdF5u4dlIaYsRJK4wOC/7ZtZtdrZhXtsyCj3mNEkn2/dOt9brQWayZyu
         evD/JWFlYj7XaUrSMl4h9URzRqwy8Mnby8eWehcz3ZKyOWaYAH3db0QGIGOSlzS23LNx
         CPm7O9Jk3Ulv66f+WVmqiQCLZyRX4hTxhabXy4Mkpx1WvdCAN4ob2+FsKz8frXAosiE0
         d/hm0OOitEnDmRll6TszZ1J4pMvnaAafZqPKgE68x8l//xKhxsSqIriyd4YG4jgWSznW
         mzSyp0UMgmLQizsPl5mM/EAMLvVju9+YgkIwi3L5Wg9aQ+9MKSgTLwugsi4djYrjpqzk
         CrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686227718; x=1688819718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dF86ekNLRqalsvWZuyWAOS0CIdPFsbBDpzcSRmeaQ0=;
        b=Q3RyIZDJb9u+hygfA19e8BrR01RYK6Up/VpY9+kbgEQ5vhZ1XxMec5ffG5lx/6/g+C
         WDGwyok9euYKnRzVhUIwEYcZ27c6TBjeKqk3lcZU27wn3LB60qiyT4xQo/aj9WhOcIvH
         tg5TrR9e3nZLz3Ur83AJ4jsIsuArI7U6trEqgzhU7hDtQQv0ZrxnuxsSNC62on6d1Cdc
         I1TWC3UxNz8x0yEwqKF/V5AKyF2J7AQr8ZqwMDQ+lavqdqSwTVIuPuZKIYNANbBH7HoO
         9MmenXMJe97fTrlxXmDv53m/J+od3eoTZ60YGm+OrY2+kvUvzP0ORyV1kLVSEJ9ycIfq
         SseQ==
X-Gm-Message-State: AC+VfDwPb3vojWi2UW7dSNsF9eSkOd7iOFoBFrbSPM6n10z9Ak0iSbqu
	0L+BZ6P61k+mFc7HyOCdz9U=
X-Google-Smtp-Source: ACHHUZ4WYBDf2dxY9TMjh4yHmXmg9y6yEyrlzMJG/gGaYJ0xcOHZFU8xBjhcKEfTIaMHyWadvUXMMg==
X-Received: by 2002:ac2:5631:0:b0:4ec:8a12:9e70 with SMTP id b17-20020ac25631000000b004ec8a129e70mr2813327lff.46.1686227717937;
        Thu, 08 Jun 2023 05:35:17 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b11-20020ac2562b000000b004f59c182f7bsm171660lff.249.2023.06.08.05.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 05:35:17 -0700 (PDT)
Message-ID: <ce5219f00b113e586c764fe91f215af29f6e0a9a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: use scalar ids in
 mark_chain_precision()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Thu, 08 Jun 2023 15:35:15 +0300
In-Reply-To: <CAEf4BzYmi+_S79q4udJAx-9Ra4FasTHft_E9-=PeE0c3vqW2eg@mail.gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
	 <20230606222411.1820404-2-eddyz87@gmail.com>
	 <CAEf4BzYmi+_S79q4udJAx-9Ra4FasTHft_E9-=PeE0c3vqW2eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-06-07 at 14:40 -0700, Andrii Nakryiko wrote:
> On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > Change mark_chain_precision() to track precision in situations
> > like below:
> >=20
> >     r2 =3D unknown value
> >     ...
> >   --- state #0 ---
> >     ...
> >     r1 =3D r2                 // r1 and r2 now share the same ID
> >     ...
> >   --- state #1 {r1.id =3D A, r2.id =3D A} ---
> >     ...
> >     if (r2 > 10) goto exit; // find_equal_scalars() assigns range to r1
> >     ...
> >   --- state #2 {r1.id =3D A, r2.id =3D A} ---
> >     r3 =3D r10
> >     r3 +=3D r1                // need to mark both r1 and r2
> >=20
> > At the beginning of the processing of each state, ensure that if a
> > register with a scalar ID is marked as precise, all registers sharing
> > this ID are also marked as precise.
> >=20
> > This property would be used by a follow-up change in regsafe().
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h                  |  10 +-
> >  kernel/bpf/verifier.c                         | 114 ++++++++++++++++++
> >  .../testing/selftests/bpf/verifier/precise.c  |   8 +-
> >  3 files changed, 127 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index ee4cc7471ed9..3f9856baa542 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -559,6 +559,11 @@ struct backtrack_state {
> >         u64 stack_masks[MAX_CALL_FRAMES];
> >  };
> >=20
> > +struct reg_id_scratch {
> > +       u32 count;
> > +       u32 ids[BPF_ID_MAP_SIZE];
> > +};
> > +
> >  /* single container for all structs
> >   * one verifier_env per bpf_check() call
> >   */
> > @@ -590,7 +595,10 @@ struct bpf_verifier_env {
> >         const struct bpf_line_info *prev_linfo;
> >         struct bpf_verifier_log log;
> >         struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
> > -       struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
> > +       union {
> > +               struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
> > +               struct reg_id_scratch precise_ids_scratch;
>=20
> naming nit: "ids_scratch" or "idset_scratch" to stay in line with
> "idmap_scratch"?

Makes sense, will change to "idset_scratch".

>=20
> > +       };
> >         struct {
> >                 int *insn_state;
> >                 int *insn_stack;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d117deb03806..2aa60b73f1b5 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3779,6 +3779,96 @@ static void mark_all_scalars_imprecise(struct bp=
f_verifier_env *env, struct bpf_
> >         }
> >  }
> >=20
> > +static inline bool reg_id_scratch_contains(struct reg_id_scratch *s, u=
32 id)
> > +{
> > +       u32 i;
> > +
> > +       for (i =3D 0; i < s->count; ++i)
> > +               if (s->ids[i] =3D=3D id)
> > +                       return true;
> > +
> > +       return false;
> > +}
> > +
> > +static inline int reg_id_scratch_push(struct reg_id_scratch *s, u32 id=
)
> > +{
> > +       if (WARN_ON_ONCE(s->count >=3D ARRAY_SIZE(s->ids)))
> > +               return -1;
> > +       s->ids[s->count++] =3D id;
>=20
> this will allow duplicated IDs to be added? Was it done in the name of sp=
eed?

tbh, it's an artifact from bsearch/sort migration of a series.
While doing test veristat runs I found that maximal value of s->count is 5,
so looks like it would be fine the way it is now and it would be fine
if linear scan is added to avoid duplicate ids. Don't think I have a prefer=
ence.

>=20
> > +       WARN_ONCE(s->count > 64,
> > +                 "reg_id_scratch.count is unreasonably large (%d)", s-=
>count);
>=20
> do we need this one? Especially that it's not _ONCE variant? Maybe the
> first WARN_ON_ONCE is enough?

We make an assumption that linear scans of this array are ok, and it
would be scanned often. I'd like to have some indication if this
assumption is broken. The s->ids array is large (10 regs + 64 spills) * 8 f=
rames.
If you think that this logging is not necessary I'll remove it.

>=20
> > +       return 0;
> > +}
> > +
> > +static inline void reg_id_scratch_reset(struct reg_id_scratch *s)
>=20
> we probably don't need "inline" for all these helpers?

Ok, will remove "inline".

>=20
> > +{
> > +       s->count =3D 0;
> > +}
> > +
> > +/* Collect a set of IDs for all registers currently marked as precise =
in env->bt.
> > + * Mark all registers with these IDs as precise.
> > + */
> > +static void mark_precise_scalar_ids(struct bpf_verifier_env *env, stru=
ct bpf_verifier_state *st)
> > +{
> > +       struct reg_id_scratch *precise_ids =3D &env->precise_ids_scratc=
h;
> > +       struct backtrack_state *bt =3D &env->bt;
> > +       struct bpf_func_state *func;
> > +       struct bpf_reg_state *reg;
> > +       DECLARE_BITMAP(mask, 64);
> > +       int i, fr;
> > +
> > +       reg_id_scratch_reset(precise_ids);
> > +
> > +       for (fr =3D bt->frame; fr >=3D 0; fr--) {
> > +               func =3D st->frame[fr];
> > +
> > +               bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
> > +               for_each_set_bit(i, mask, 32) {
> > +                       reg =3D &func->regs[i];
> > +                       if (!reg->id || reg->type !=3D SCALAR_VALUE)
> > +                               continue;
> > +                       if (reg_id_scratch_push(precise_ids, reg->id))
> > +                               return;
> > +               }
> > +
> > +               bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
> > +               for_each_set_bit(i, mask, 64) {
> > +                       if (i >=3D func->allocated_stack / BPF_REG_SIZE=
)
> > +                               break;
> > +                       if (!is_spilled_scalar_reg(&func->stack[i]))
> > +                               continue;
> > +                       reg =3D &func->stack[i].spilled_ptr;
> > +                       if (!reg->id || reg->type !=3D SCALAR_VALUE)
>=20
> is_spilled_scalar_reg() already ensures reg->type is SCALAR_VALUE

Yes, my bad.

>=20
> > +                               continue;
> > +                       if (reg_id_scratch_push(precise_ids, reg->id))
> > +                               return;
>=20
> if push fails (due to overflow of id set), shouldn't we propagate
> error back and fallback to mark_all_precise?

In theory this push should never fail, as we pre-allocate enough slots
in the scratch. I'll propagate error to __mark_chain_precision() and
exit from that one with -EFAULT.

>=20
>=20
> > +               }
> > +       }
> > +
> > +       for (fr =3D 0; fr <=3D st->curframe; ++fr) {
> > +               func =3D st->frame[fr];
> > +
> > +               for (i =3D BPF_REG_0; i < BPF_REG_10; ++i) {
> > +                       reg =3D &func->regs[i];
> > +                       if (!reg->id)
> > +                               continue;
> > +                       if (!reg_id_scratch_contains(precise_ids, reg->=
id))
> > +                               continue;
> > +                       bt_set_frame_reg(bt, fr, i);
> > +               }
> > +               for (i =3D 0; i < func->allocated_stack / BPF_REG_SIZE;=
 ++i) {
> > +                       if (!is_spilled_scalar_reg(&func->stack[i]))
> > +                               continue;
> > +                       reg =3D &func->stack[i].spilled_ptr;
> > +                       if (!reg->id)
> > +                               continue;
> > +                       if (!reg_id_scratch_contains(precise_ids, reg->=
id))
> > +                               continue;
> > +                       bt_set_frame_slot(bt, fr, i);
> > +               }
> > +       }
> > +}
> > +
> >  /*
> >   * __mark_chain_precision() backtracks BPF program instruction sequenc=
e and
> >   * chain of verifier states making sure that register *regno* (if regn=
o >=3D 0)
> > @@ -3910,6 +4000,30 @@ static int __mark_chain_precision(struct bpf_ver=
ifier_env *env, int regno)
> >                                 bt->frame, last_idx, first_idx, subseq_=
idx);
> >                 }
> >=20
> > +               /* If some register with scalar ID is marked as precise=
,
> > +                * make sure that all registers sharing this ID are als=
o precise.
> > +                * This is needed to estimate effect of find_equal_scal=
ars().
> > +                * Do this at the last instruction of each state,
> > +                * bpf_reg_state::id fields are valid for these instruc=
tions.
> > +                *
> > +                * Allows to track precision in situation like below:
> > +                *
> > +                *     r2 =3D unknown value
> > +                *     ...
> > +                *   --- state #0 ---
> > +                *     ...
> > +                *     r1 =3D r2                 // r1 and r2 now share=
 the same ID
> > +                *     ...
> > +                *   --- state #1 {r1.id =3D A, r2.id =3D A} ---
> > +                *     ...
> > +                *     if (r2 > 10) goto exit; // find_equal_scalars() =
assigns range to r1
> > +                *     ...
> > +                *   --- state #2 {r1.id =3D A, r2.id =3D A} ---
> > +                *     r3 =3D r10
> > +                *     r3 +=3D r1                // need to mark both r=
1 and r2
> > +                */
> > +               mark_precise_scalar_ids(env, st);
> > +
> >                 if (last_idx < 0) {
> >                         /* we are at the entry into subprog, which
> >                          * is expected for global funcs, but only if
> > diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/tes=
ting/selftests/bpf/verifier/precise.c
> > index b8c0aae8e7ec..99272bb890da 100644
> > --- a/tools/testing/selftests/bpf/verifier/precise.c
> > +++ b/tools/testing/selftests/bpf/verifier/precise.c
> > @@ -46,7 +46,7 @@
> >         mark_precise: frame0: regs=3Dr2 stack=3D before 20\
> >         mark_precise: frame0: parent state regs=3Dr2 stack=3D:\
> >         mark_precise: frame0: last_idx 19 first_idx 10\
> > -       mark_precise: frame0: regs=3Dr2 stack=3D before 19\
> > +       mark_precise: frame0: regs=3Dr2,r9 stack=3D before 19\
> >         mark_precise: frame0: regs=3Dr9 stack=3D before 18\
> >         mark_precise: frame0: regs=3Dr8,r9 stack=3D before 17\
> >         mark_precise: frame0: regs=3Dr0,r9 stack=3D before 15\
> > @@ -106,10 +106,10 @@
> >         mark_precise: frame0: regs=3Dr2 stack=3D before 22\
> >         mark_precise: frame0: parent state regs=3Dr2 stack=3D:\
> >         mark_precise: frame0: last_idx 20 first_idx 20\
> > -       mark_precise: frame0: regs=3Dr2 stack=3D before 20\
> > -       mark_precise: frame0: parent state regs=3Dr2 stack=3D:\
> > +       mark_precise: frame0: regs=3Dr2,r9 stack=3D before 20\
> > +       mark_precise: frame0: parent state regs=3Dr2,r9 stack=3D:\
> >         mark_precise: frame0: last_idx 19 first_idx 17\
> > -       mark_precise: frame0: regs=3Dr2 stack=3D before 19\
> > +       mark_precise: frame0: regs=3Dr2,r9 stack=3D before 19\
> >         mark_precise: frame0: regs=3Dr9 stack=3D before 18\
> >         mark_precise: frame0: regs=3Dr8,r9 stack=3D before 17\
> >         mark_precise: frame0: parent state regs=3D stack=3D:",
> > --
> > 2.40.1
> >=20


