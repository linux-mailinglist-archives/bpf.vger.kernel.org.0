Return-Path: <bpf+bounces-2133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1E72865D
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68AB42816A7
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E01DCB5;
	Thu,  8 Jun 2023 17:30:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762A1993D
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 17:30:23 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119EF95
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:30:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so1097478e87.3
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686245420; x=1688837420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mPRPaqwvwWWImgzxGCdFAWo3F1AkJy6BNMqc6HYtvgk=;
        b=F7+ju6v2IBikFgYjXmr/eMStUqHp5rWzwYr0SiSUM8/v4oiptLw/RZggrFvRFHpeAi
         Pchn4T72xMT0scDIxNhZY5KJuQ/fucooWk0/DZ8OtXFFdmFCFTvUmACWhaUDTL3+lVjz
         zhg0Lv1HKmEUrTjfApxiD2CKhGS1zXL2S+IWumV3Y6Lao1GR6H97bETeUeGt8x48CeAM
         bh+PtlbBPrG9nICIkxymrwepjkpv4/qCCLpV0PN7H65bRC1nE28ku13RXQlRlHlEbeMA
         oL63377ozpOrlDp9acjlm0ue3uTc4xxCrlNoqRlSNSzPCm0Z/6tf4/6WD+VUwA2Hlnc2
         SkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686245420; x=1688837420;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPRPaqwvwWWImgzxGCdFAWo3F1AkJy6BNMqc6HYtvgk=;
        b=QDavXhPvxJrsfTu1atOWa8Hjrfylp4b5TPTxRD1Jf5KMNLO/qvK1ExyoGu+KXcfczc
         VfQZbQgpyGV9iaNQhx/Ww9Sg/sUxwLqRk60MGSjxqFOtZQPkrCFmdgMHROFjCawXMh17
         GWvoL/VHmK5X3/PrKEzzfeCb6xIxKkRWCZaKMIM5B7Gfs61ADKYk18vdBVzR8qalhvxG
         fr/MjTxALjgqtx6yuA5iLqrAAyqIYOZ9UGVvzEAbKn0AN0AfmEulkJfKdbE9gIX92QjN
         oG/qEg6QPpyVZXIczyUHan0KwMegblHQIaTZ0VicbY7tzmTrSsXaLdVqRIf6j1w5kTAL
         MphA==
X-Gm-Message-State: AC+VfDzUqzYCCkrwQ5+yye14VLFV1CnHkBI5CDW6qxfVBC6RSWj0RwQP
	jp+dv7n9yTqjWRqxtDD+Gdsku5Bo1yS3qA==
X-Google-Smtp-Source: ACHHUZ5WQFldrGYv94PxLhcm+A6LBHAOqipbrz1+EamB6YhiLlaWiUBXAo9CnH9Vc8Fa9Rr3BkrGhw==
X-Received: by 2002:ac2:5292:0:b0:4f4:eeb4:ba70 with SMTP id q18-20020ac25292000000b004f4eeb4ba70mr3423100lfm.32.1686245419964;
        Thu, 08 Jun 2023 10:30:19 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a2-20020ac25202000000b004f4b42e2d7dsm248386lfl.230.2023.06.08.10.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 10:30:19 -0700 (PDT)
Message-ID: <5b89f7004d247982915bfe47cc76f656e5bde9d6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: use scalar ids in
 mark_chain_precision()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, Yonghong Song
 <yhs@fb.com>
Date: Thu, 08 Jun 2023 20:30:18 +0300
In-Reply-To: <CAADnVQJzWxAuQpf8Ci=-xp+0EP5C8rSjS9xyX+o_fTmhri=yRA@mail.gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
	 <20230606222411.1820404-2-eddyz87@gmail.com>
	 <CAEf4BzYmi+_S79q4udJAx-9Ra4FasTHft_E9-=PeE0c3vqW2eg@mail.gmail.com>
	 <ce5219f00b113e586c764fe91f215af29f6e0a9a.camel@gmail.com>
	 <CAADnVQJzWxAuQpf8Ci=-xp+0EP5C8rSjS9xyX+o_fTmhri=yRA@mail.gmail.com>
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

On Thu, 2023-06-08 at 08:43 -0700, Alexei Starovoitov wrote:
> On Thu, Jun 8, 2023 at 5:35=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Wed, 2023-06-07 at 14:40 -0700, Andrii Nakryiko wrote:
> > > On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >=20
> > > > Change mark_chain_precision() to track precision in situations
> > > > like below:
> > > >=20
> > > >     r2 =3D unknown value
> > > >     ...
> > > >   --- state #0 ---
> > > >     ...
> > > >     r1 =3D r2                 // r1 and r2 now share the same ID
> > > >     ...
> > > >   --- state #1 {r1.id =3D A, r2.id =3D A} ---
> > > >     ...
> > > >     if (r2 > 10) goto exit; // find_equal_scalars() assigns range t=
o r1
> > > >     ...
> > > >   --- state #2 {r1.id =3D A, r2.id =3D A} ---
> > > >     r3 =3D r10
> > > >     r3 +=3D r1                // need to mark both r1 and r2
> > > >=20
> > > > At the beginning of the processing of each state, ensure that if a
> > > > register with a scalar ID is marked as precise, all registers shari=
ng
> > > > this ID are also marked as precise.
> > > >=20
> > > > This property would be used by a follow-up change in regsafe().
> > > >=20
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > >  include/linux/bpf_verifier.h                  |  10 +-
> > > >  kernel/bpf/verifier.c                         | 114 ++++++++++++++=
++++
> > > >  .../testing/selftests/bpf/verifier/precise.c  |   8 +-
> > > >  3 files changed, 127 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verif=
ier.h
> > > > index ee4cc7471ed9..3f9856baa542 100644
> > > > --- a/include/linux/bpf_verifier.h
> > > > +++ b/include/linux/bpf_verifier.h
> > > > @@ -559,6 +559,11 @@ struct backtrack_state {
> > > >         u64 stack_masks[MAX_CALL_FRAMES];
> > > >  };
> > > >=20
> > > > +struct reg_id_scratch {
> > > > +       u32 count;
> > > > +       u32 ids[BPF_ID_MAP_SIZE];
> > > > +};
> > > > +
> > > >  /* single container for all structs
> > > >   * one verifier_env per bpf_check() call
> > > >   */
> > > > @@ -590,7 +595,10 @@ struct bpf_verifier_env {
> > > >         const struct bpf_line_info *prev_linfo;
> > > >         struct bpf_verifier_log log;
> > > >         struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
> > > > -       struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
> > > > +       union {
> > > > +               struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
> > > > +               struct reg_id_scratch precise_ids_scratch;
> > >=20
> > > naming nit: "ids_scratch" or "idset_scratch" to stay in line with
> > > "idmap_scratch"?
> >=20
> > Makes sense, will change to "idset_scratch".
> >=20
> > >=20
> > > > +       };
> > > >         struct {
> > > >                 int *insn_state;
> > > >                 int *insn_stack;
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index d117deb03806..2aa60b73f1b5 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -3779,6 +3779,96 @@ static void mark_all_scalars_imprecise(struc=
t bpf_verifier_env *env, struct bpf_
> > > >         }
> > > >  }
> > > >=20
> > > > +static inline bool reg_id_scratch_contains(struct reg_id_scratch *=
s, u32 id)
> > > > +{
> > > > +       u32 i;
> > > > +
> > > > +       for (i =3D 0; i < s->count; ++i)
> > > > +               if (s->ids[i] =3D=3D id)
> > > > +                       return true;
> > > > +
> > > > +       return false;
> > > > +}
> > > > +
> > > > +static inline int reg_id_scratch_push(struct reg_id_scratch *s, u3=
2 id)
> > > > +{
> > > > +       if (WARN_ON_ONCE(s->count >=3D ARRAY_SIZE(s->ids)))
> > > > +               return -1;
> > > > +       s->ids[s->count++] =3D id;
> > >=20
> > > this will allow duplicated IDs to be added? Was it done in the name o=
f speed?
> >=20
> > tbh, it's an artifact from bsearch/sort migration of a series.
> > While doing test veristat runs I found that maximal value of s->count i=
s 5,
> > so looks like it would be fine the way it is now and it would be fine
> > if linear scan is added to avoid duplicate ids. Don't think I have a pr=
eference.
>=20
> Maybe return -EFAULT for count > 64 and print a verifier error message ?
> If/when syzbot/human manages to craft such a program we'll know that
> this is something to address.

Sounds a bit heavy-handed.
Should the same logic apply to idmap?

I did some silly testing, 1'000'000 searches over u32 array of size (10+64)=
*8:
- linear search is done in 0.7s
- qsort/bsearch is done in 23s

It looks like my concerns are completely overblown. I'm inclined to
remove the size warning and just check for array overflow.

