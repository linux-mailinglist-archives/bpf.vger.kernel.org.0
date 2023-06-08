Return-Path: <bpf+bounces-2124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C52D7283FF
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 17:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464B1281716
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 15:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BE615ADE;
	Thu,  8 Jun 2023 15:44:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBAC2DA
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 15:44:48 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCD830FF
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 08:44:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1af9ef7a9so7202711fa.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686239032; x=1688831032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwwYcS9Nqthn6KfjOGSbLoK+BPCP/HVh+cxfFeUVM98=;
        b=rCZ1+sRjAFSLdi/MhgXWHP7XAKHcT5OYmydAe8FmLRD99sqZPMm0JLN8L+PFjYzwLB
         YJE0nfmMJIaZlqzJWDaoLzOQRF73K+CvnRXLFCCsGd1pP8mWH3JkK/H4zIWCT+fTA30X
         IFmMu+LVTQATzLnjXR2/OBwYdRbzA9icMT2guHorKUMPqse2CyiF4KK40RqSN2r54jeL
         vAsWd984jfgeGAaPiFUcei9BlZXrRV9ih8RiyfJRHl6ip5Fl7VD+QvyALcsnVOx99a5T
         4h8/8Wfx1e+m3dYI7h5XsDd18ldoCMOvnf3pbBrtj0dOoTveq/sKNh8QxWzvWFYpGlqV
         CtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239032; x=1688831032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwwYcS9Nqthn6KfjOGSbLoK+BPCP/HVh+cxfFeUVM98=;
        b=Da0qyzgxbm1f+ehVc69lJRLAdkyrPKPFyB/SUwydZh6vVUOn3gk/w9gXTOrm6hErHP
         eC9ZoinK/a7UvlzPAlbgwgiPF5hPIuMW5zVrQZzbIsfADS5H2fsbE7pztpBvQq/ezaUU
         ZRraCFSM6Y9N98gz7J0QOVLwFKdnluNQ5BwQa6hb9nD/wdwpwDaHU4oklgYoUfhYoP29
         OyZj6O7FyDNUfiVzXwjlNl/TxFlU2EHFNbo0QC81wnt4XNpK1AtW+BFDwRHRNMzp2c1t
         cCKnltmLAcPUI8MWYTNQUvn7SpktQMx5QFjW1o/HdLJzY0to85J9ltCmE+QCxw4NQM2k
         nDaw==
X-Gm-Message-State: AC+VfDwOp5+TpYrCnITHb6TENof1Rpw3nHjcmKqrkMkqJ/bF/3z7/td8
	gRs06IYZyi13as4QYqTHWqKLljJQbzJi25nOfpA=
X-Google-Smtp-Source: ACHHUZ5AjpVXxLrYXoa7BwP0pPkORsI2Zw4CEi4K7PS4oKo+xqDAmlr4BJpjx+S//kJ/WqOe7E22hF/9KYarwwF//zQ=
X-Received: by 2002:a2e:924d:0:b0:2b1:c7f7:188d with SMTP id
 v13-20020a2e924d000000b002b1c7f7188dmr3661010ljg.23.1686239032265; Thu, 08
 Jun 2023 08:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606222411.1820404-1-eddyz87@gmail.com> <20230606222411.1820404-2-eddyz87@gmail.com>
 <CAEf4BzYmi+_S79q4udJAx-9Ra4FasTHft_E9-=PeE0c3vqW2eg@mail.gmail.com> <ce5219f00b113e586c764fe91f215af29f6e0a9a.camel@gmail.com>
In-Reply-To: <ce5219f00b113e586c764fe91f215af29f6e0a9a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Jun 2023 08:43:41 -0700
Message-ID: <CAADnVQJzWxAuQpf8Ci=-xp+0EP5C8rSjS9xyX+o_fTmhri=yRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: use scalar ids in mark_chain_precision()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 5:35=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2023-06-07 at 14:40 -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > Change mark_chain_precision() to track precision in situations
> > > like below:
> > >
> > >     r2 =3D unknown value
> > >     ...
> > >   --- state #0 ---
> > >     ...
> > >     r1 =3D r2                 // r1 and r2 now share the same ID
> > >     ...
> > >   --- state #1 {r1.id =3D A, r2.id =3D A} ---
> > >     ...
> > >     if (r2 > 10) goto exit; // find_equal_scalars() assigns range to =
r1
> > >     ...
> > >   --- state #2 {r1.id =3D A, r2.id =3D A} ---
> > >     r3 =3D r10
> > >     r3 +=3D r1                // need to mark both r1 and r2
> > >
> > > At the beginning of the processing of each state, ensure that if a
> > > register with a scalar ID is marked as precise, all registers sharing
> > > this ID are also marked as precise.
> > >
> > > This property would be used by a follow-up change in regsafe().
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h                  |  10 +-
> > >  kernel/bpf/verifier.c                         | 114 ++++++++++++++++=
++
> > >  .../testing/selftests/bpf/verifier/precise.c  |   8 +-
> > >  3 files changed, 127 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index ee4cc7471ed9..3f9856baa542 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -559,6 +559,11 @@ struct backtrack_state {
> > >         u64 stack_masks[MAX_CALL_FRAMES];
> > >  };
> > >
> > > +struct reg_id_scratch {
> > > +       u32 count;
> > > +       u32 ids[BPF_ID_MAP_SIZE];
> > > +};
> > > +
> > >  /* single container for all structs
> > >   * one verifier_env per bpf_check() call
> > >   */
> > > @@ -590,7 +595,10 @@ struct bpf_verifier_env {
> > >         const struct bpf_line_info *prev_linfo;
> > >         struct bpf_verifier_log log;
> > >         struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
> > > -       struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
> > > +       union {
> > > +               struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
> > > +               struct reg_id_scratch precise_ids_scratch;
> >
> > naming nit: "ids_scratch" or "idset_scratch" to stay in line with
> > "idmap_scratch"?
>
> Makes sense, will change to "idset_scratch".
>
> >
> > > +       };
> > >         struct {
> > >                 int *insn_state;
> > >                 int *insn_stack;
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index d117deb03806..2aa60b73f1b5 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3779,6 +3779,96 @@ static void mark_all_scalars_imprecise(struct =
bpf_verifier_env *env, struct bpf_
> > >         }
> > >  }
> > >
> > > +static inline bool reg_id_scratch_contains(struct reg_id_scratch *s,=
 u32 id)
> > > +{
> > > +       u32 i;
> > > +
> > > +       for (i =3D 0; i < s->count; ++i)
> > > +               if (s->ids[i] =3D=3D id)
> > > +                       return true;
> > > +
> > > +       return false;
> > > +}
> > > +
> > > +static inline int reg_id_scratch_push(struct reg_id_scratch *s, u32 =
id)
> > > +{
> > > +       if (WARN_ON_ONCE(s->count >=3D ARRAY_SIZE(s->ids)))
> > > +               return -1;
> > > +       s->ids[s->count++] =3D id;
> >
> > this will allow duplicated IDs to be added? Was it done in the name of =
speed?
>
> tbh, it's an artifact from bsearch/sort migration of a series.
> While doing test veristat runs I found that maximal value of s->count is =
5,
> so looks like it would be fine the way it is now and it would be fine
> if linear scan is added to avoid duplicate ids. Don't think I have a pref=
erence.

Maybe return -EFAULT for count > 64 and print a verifier error message ?
If/when syzbot/human manages to craft such a program we'll know that
this is something to address.

