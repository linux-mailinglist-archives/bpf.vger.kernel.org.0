Return-Path: <bpf+bounces-1470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C42471712A
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 01:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8731C20DBB
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 23:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9001534CE4;
	Tue, 30 May 2023 23:02:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570EDA927
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 23:02:45 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BC0E8
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 16:02:43 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af2e1725bdso4363951fa.0
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 16:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685487761; x=1688079761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y+TQJtgSw/9TDoVd8JqKZWWWD6eIgHptnIfhU7W5IWE=;
        b=Epx9xdktTBq/hsFwtKPuSn+PYqGUT/T1iVrsbnp+Esz5WgRVLkMHtlA4IJlTRCmUBD
         Cu13efv6HD2OhL0sEPZny1hbnOQUCyi2qkHGB6UYdCy3iwoPTOz5bErCOzerEDas5njP
         zXLe+9KvYej4IbNyl31vfySvD/kVP2Kh7ClRebF/ZXuO7eubjT6My0TcLTflM/A61BMy
         XOneFVXGaI7C8WBt6vMJhhkXVrpvmTv6AxQU758EXGHcZLtYizob78z4ZZEfLxi0yued
         wYZddha+OmvJB5C0Zpfx45BTf2luaLqwRZTVlDF1XVMPby5NDVrpA3PtoNLN9x+aVw0F
         b1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685487761; x=1688079761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+TQJtgSw/9TDoVd8JqKZWWWD6eIgHptnIfhU7W5IWE=;
        b=Sba8XrM8YI07F//XKja2hGV4GAPCiwTapQBjiDMGh0jQm1hUEYk8wpPXl/UlHukc+7
         rvIIUOJJ6ZDzYCsFSKfnk84NoBr0ZZKniWgEdWdJPR0WNIIdup4B7rJe2IYcXMg+Kvz1
         tSOjyJ/r2ZQCgqZUpfRglcJVufb1Hu0Wml64c96upRMP/X9qemDzK3SCZDfGwRcKzRDD
         qMShMrSQMfYLgYLbUskcHSR+V1h+AeugPoNoamqP9mto1ZUlIxADTK6AV0ApoeXdlsyK
         THrwg4iJLWEhTHeQdksrdt7HDEIo8gxiwYiy5eiM5z8WBwyVdK7ExxKrQWHZSW00tLf2
         MFoQ==
X-Gm-Message-State: AC+VfDzw6wIgm34pJC8l+Sq6UL1H6qR47tlMRT3mHzR/KRNIsLlYlATJ
	31a2rpB8yzMglq2KEyqGopo=
X-Google-Smtp-Source: ACHHUZ4RoIx5WIK39M3hwZZ2F0Yo2XOVNTRWAf/wZ5cfqtcuR37VF9qaKfJm8nsOI6hGyNZ8rqbAuA==
X-Received: by 2002:a05:651c:10b:b0:2a2:ac00:4de4 with SMTP id a11-20020a05651c010b00b002a2ac004de4mr1091804ljb.22.1685487760909;
        Tue, 30 May 2023 16:02:40 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n17-20020a2eb791000000b002ad8bccceb2sm3042562ljo.57.2023.05.30.16.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:02:40 -0700 (PDT)
Message-ID: <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Wed, 31 May 2023 02:02:37 +0300
In-Reply-To: <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
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

On Tue, 2023-05-30 at 14:37 -0700, Andrii Nakryiko wrote:
> On Tue, May 30, 2023 at 10:27=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > Make sure that the following unsafe example is rejected by verifier:
> >=20
> > 1: r9 =3D ... some pointer with range X ...
> > 2: r6 =3D ... unbound scalar ID=3Da ...
> > 3: r7 =3D ... unbound scalar ID=3Db ...
> > 4: if (r6 > r7) goto +1
> > 5: r6 =3D r7
> > 6: if (r6 > X) goto ...
> > --- checkpoint ---
> > 7: r9 +=3D r7
> > 8: *(u64 *)r9 =3D Y
> >=20
> > This example is unsafe because not all execution paths verify r7 range.
> > Because of the jump at (4) the verifier would arrive at (6) in two stat=
es:
> > I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> > II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
> >=20
> > Currently regsafe() does not call check_ids() for scalar registers,
> > thus from POV of regsafe() states (I) and (II) are identical. If the
> > path 1-6 is taken by verifier first, and checkpoint is created at (6)
> > the path [1-4, 6] would be considered safe.
> >=20
> > This commit updates regsafe() to call check_ids() for scalar registers.
> >=20
> > This change is costly in terms of verification performance.
> > Using veristat to compare number of processed states for selftests
> > object files listed in tools/testing/selftests/bpf/veristat.cfg and
> > Cilium object files from [1] gives the following statistics:
> >=20
> >   Filter        | Number of programs
> >   ----------------------------------
> >   states_pct>10 | 40
> >   states_pct>20 | 20
> >   states_pct>30 | 15
> >   states_pct>40 | 11
> >=20
> > (Out of total 177 programs)
> >=20
> > In fact, impact is so bad that in no-alu32 mode the following
> > test_progs tests no longer pass verifiction:
> > - verif_scale2: maximal number of instructions exceeded
> > - verif_scale3: maximal number of instructions exceeded
> > - verif_scale_pyperf600: maximal number of instructions exceeded
> >=20
> > Additionally:
> > - verifier_search_pruning/allocated_stack: expected prunning does not
> >   happen because of differences in register id allocation.
> >=20
> > Followup patch would address these issues.
> >=20
> > [1] git@github.com:anakryiko/cilium.git
> >=20
> > Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register ass=
ignments.")
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index af70dad655ab..9c10f2619c4f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15151,6 +15151,28 @@ static bool regsafe(struct bpf_verifier_env *e=
nv, struct bpf_reg_state *rold,
> >=20
> >         switch (base_type(rold->type)) {
> >         case SCALAR_VALUE:
> > +               /* Why check_ids() for scalar registers?
> > +                *
> > +                * Consider the following BPF code:
> > +                *   1: r6 =3D ... unbound scalar, ID=3Da ...
> > +                *   2: r7 =3D ... unbound scalar, ID=3Db ...
> > +                *   3: if (r6 > r7) goto +1
> > +                *   4: r6 =3D r7
> > +                *   5: if (r6 > X) goto ...
> > +                *   6: ... memory operation using r7 ...
> > +                *
> > +                * First verification path is [1-6]:
> > +                * - at (4) same bpf_reg_state::id (b) would be assigne=
d to r6 and r7;
> > +                * - at (5) r6 would be marked <=3D X, find_equal_scala=
rs() would also mark
> > +                *   r7 <=3D X, because r6 and r7 share same id.
> > +                *
> > +                * Next verification path would start from (5), because=
 of the jump at (3).
> > +                * The only state difference between first and second v=
isits of (5) is
> > +                * bpf_reg_state::id assignments for r6 and r7: (b, b) =
vs (a, b).
> > +                * Thus, use check_ids() to distinguish these states.
> > +                */
> > +               if (!check_ids(rold->id, rcur->id, idmap))
> > +                       return false;
>=20
> does this check_ids() have to be performed before regs_exact (which
> also checks IDs, btw) *and* before rold->precise check?

Relative position to regs_exact() does not matter (because it does check_id=
s).
Relative position to rold->precise *does* matter (see next answer).

> Intuitively, it feels like `rold->precise =3D false` case shouldn't care
> about IDs in rcur, as any value should be safe. But I haven't spent
> much time thinking about this, so there might be some corner case I'm
> missing.

I tried to explain this in the cover letter, I'll try to add more
details below. Effectively what you suggest is to modify the check as
follows:

  if (rold->precise && !check_ids(rold->id, rcur->id, idmap))
    return false;

Unfortunately, not all registers with interesting IDs would be marked
as precise. Consider the original example but with r6 and r7 swapped:

  1: r9 =3D ... some pointer with range X ...
  2: r6 =3D ... unbound scalar ID=3Da ...
  3: r7 =3D ... unbound scalar ID=3Db ...
  4: if (r6 > r7) goto +1
  5: r7 =3D r6
  6: if (r7 > X) goto ...
  7: r9 +=3D r6

Suppose that current verification path is 1-7:
- On a way down 1-6 r7 will not be marked as precise, because
  condition (r7 > X) is not predictable (see check_cond_jmp_op());
- When (7) is reached mark_chain_precision() will start moving up
  marking the following registers as precise:

  4: if (r6 > r7) goto +1 ; r6, r7
  5: r7 =3D r6              ; r6
  6: if (r7 > X) goto ... ; r6
  7: r9 +=3D r6             ; r6

- Thus, if checkpoint is created for (6) r7 would be marked as read,
  but will not be marked as precise.
 =20
Next, suppose that jump from 4 to 6 is verified and checkpoint for (6)
is considered:
- r6 is not precise, so check_ids() is not called for it and it is not
  added to idmap;
- r7 is precise, so check_ids() is called for it, but it is a sole
  register in the idmap;
- States are considered equal.

Here is the log (I added a few prints for states cache comparison):

  from 10 to 13: safe
    steq hit 10, cur:
      R0=3Dscalar(id=3D2) R6=3Dscalar(id=3D2) R7=3Dscalar(id=3D1) R9=3Dfp-8=
 R10=3Dfp0 fp-8=3D00000000
    steq hit 10, old:
      R6_rD=3DPscalar(id=3D2) R7_rwD=3Dscalar(id=3D2) R9_rD=3Dfp-8 R10=3Dfp=
0 fp-8_rD=3D00000000

The verifier_scalar_ids.c:ids_id_mapping_in_regsafe_2() is another example.
(test names are so-so...).

I'll recite myself:

  Ideally check_ids() should only be called for 'rold' that either:
  (a) gained range via find_equal_scalars() in some child verification
      path and was then marked as precise;
  (b) was a source of range information for some other register via
      find_equal_scalars() in some child verification path, and that
      register was then marked as precise.

Current implementation of mark_chain_precision() does not guarantee
precision mark for point (b).

This leads to a few questions:
- Q: Should (b) be guaranteed?
  A: I don't know. If patch #1 from this patch-set is applied,
     I cannot figure out any counter-example showing that (b)
     is necessary.
  Corollary: (b) is a performance optimization for patch #1.
- Q: How hard is it to implement (b)?
  A: Information about register id assignments for instructions in the
     middle of a state is lost. I see a few ways to mitigate this:
     - Extend bpf_verifier_state::jmp_history to track a mask for
       registers / stack slots that gained range via
       find_equal_scalars() and use this mask in backtrack_insn().
     - Make it so, that every conditional jump instruction is the last
       instruction in a state. Then register ID assignments should
       actually be valid, and backtrack_insn() could search for
       registers with the same ID when marking precise registers.
- Q: If (b) is merely an optimization, what is simpler (b) or patch #3
     (u32_hashset thing)?
  A: I think that patch #3 is logically simpler.

So, it boils down to a question should (b) be guaranteed?
What do you think?

> I wonder if moving this check after we handled imprecise rold case would =
help.
>=20
> Also, it might make sense to drop SCALAR register IDs as soon as we
> have only one instance of it left (e.g., if "paired" register was
> overwritten already). I.e., aggressively drop IDs when they become
> useless. WDYT?

I'll try, but don't expect a big change, will report a bit later.

> The u32_hashset.... Have you also measured verification time
> regression with this? I wonder how much impact that change has?

Summing up duration_diff field for all object files average is 0.5%
verification time increase.

>=20
> >                 if (regs_exact(rold, rcur, idmap))
> >                         return true;
> >                 if (env->explore_alu_limits)
> > --
> > 2.40.1
> >=20


