Return-Path: <bpf+bounces-13005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AFD7D383B
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 15:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66AD1C209D7
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC819BDE;
	Mon, 23 Oct 2023 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6v0vzXn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34D134A6
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 13:39:02 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA12EC5
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 06:39:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c75ceea588so466580366b.3
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698068339; x=1698673139; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mK8qrxHOmDWGau6T217ca/WGemaIuYznklSn9LwL814=;
        b=V6v0vzXn4SV62M87j8BQHVFsICpsIOPQ48pvO3+wLTOKJ2uxAuaQd85nfhGvF2D0uc
         T1YtW1NitMx8xH/yUWY5qMVQEOPQFAC6GRaxqyHvW+BJ/ldKLpFHh/Ia0HjfH5qT3c9N
         861zPgFB7fNyrzmSURFVTauTegWwyiYJMPgWF/4QFbsXwPCLDGfsipRDylC8/yNF5w1y
         XkOkpKzaIsmQEeOqqAx1l+mikfDB9mPL9Y5fzNn1fPuXYiSfgJ1saV5TYicgbzi3K9yN
         SOFGCkHEqPt+F/rTa2Zz+4TJbc0qhD+YaDoFKat8LNF+17tn42huQB8w+nDI0kLD82BV
         KUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698068339; x=1698673139;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mK8qrxHOmDWGau6T217ca/WGemaIuYznklSn9LwL814=;
        b=os6yredtRYOYtmgIe+M8sU2EXNDD2Her9+46KWcqxNJB4VirWST26uGiyh5ZtnSFHR
         bCOzXkg3xSABEniL7pvrIPKZP/7bASgIiDx8eEmjYpHrmRU1qkX1mXFdRFIEuUnz1wmR
         xee8Gfs/NWuvSszK09zFxBDuTYdlCKvHp07HoPY6qU0OJ82sjgI27lyaeufKcEpU+PLO
         OswNOrsQZFgkTkaiJAWFr/kRWbnbTq4Cux25fUG9WAmtR1sI9yxabnpt29FgX9S3zpA7
         qytSfvjRbxM+mVdZ8ZxRSWE92bLNXz0969+Bqd28HWXUKVvI0PZcwEeWw/y+zNL6ULGY
         AtVw==
X-Gm-Message-State: AOJu0YxyfIXe+4RYj9se8RQoiBUkx/NW0fy+0lqqRXYXPq6IX6M9/uVW
	cFEBjBBJVvkZelSEL8CarJE=
X-Google-Smtp-Source: AGHT+IEOGcERCJWXI3E9/qYfvhxyeBKu2gvfFvcV5LsOetPO0OldHoFDPGwBQ+YsHM00rtKdmD5+OQ==
X-Received: by 2002:a17:906:9c83:b0:9b2:b691:9b5f with SMTP id fj3-20020a1709069c8300b009b2b6919b5fmr6362056ejc.41.1698068338750;
        Mon, 23 Oct 2023 06:38:58 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906011a00b009ae69c303aasm6630518eje.137.2023.10.23.06.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 06:38:58 -0700 (PDT)
Message-ID: <058074a906af81ce86b0d70005289177d94f6a65.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: exact states comparison for
 iterator convergence checks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  memxor@gmail.com, awerner32@gmail.com,
 john.fastabend@gmail.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Oct 2023 16:38:56 +0300
In-Reply-To: <CAEf4BzbLq7rN-nsgx86wqGPg_kUEwOc=Mvh8OL6=icPk3tf1Aw@mail.gmail.com>
References: <20231022010812.9201-1-eddyz87@gmail.com>
	 <20231022010812.9201-4-eddyz87@gmail.com>
	 <CAEf4BzbLq7rN-nsgx86wqGPg_kUEwOc=Mvh8OL6=icPk3tf1Aw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-10-21 at 21:16 -0700, Andrii Nakryiko wrote:
> On Sat, Oct 21, 2023 at 6:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > Convergence for open coded iterators is computed in is_state_visited()
> > by examining states with branches count > 1 and using states_equal().
> > states_equal() computes sub-state relation using read and precision mar=
ks.
> > Read and precision marks are propagated from children states,
> > thus are not guaranteed to be complete inside a loop when branches
> > count > 1. This could be demonstrated using the following unsafe progra=
m:
> >=20
> >      1. r7 =3D -16
> >      2. r6 =3D bpf_get_prandom_u32()
> >      3. while (bpf_iter_num_next(&fp[-8])) {
> >      4.   if (r6 !=3D 42) {
> >      5.     r7 =3D -32
> >      6.     r6 =3D bpf_get_prandom_u32()
> >      7.     continue
> >      8.   }
> >      9.   r0 =3D r10
> >     10.   r0 +=3D r7
> >     11.   r8 =3D *(u64 *)(r0 + 0)
> >     12.   r6 =3D bpf_get_prandom_u32()
> >     13. }
> >=20
> > Here verifier would first visit path 1-3, create a checkpoint at 3
> > with r7=3D-16, continue to 4-7,3 with r7=3D-32.
> >=20
> > Because instructions at 9-12 had not been visitied yet existing
> > checkpoint at 3 does not have read or precision mark for r7.
> > Thus states_equal() would return true and verifier would discard
> > current state, thus unsafe memory access at 11 would not be caught.
> >=20
> > This commit fixes this loophole by introducing exact state comparisons
> > for iterator convergence logic:
> > - registers are compared using regs_exact() regardless of read or
> >   precision marks;
> > - stack slots have to have identical type.
> >=20
> > Unfortunately, this is too strict even for simple programs like below:
> >=20
> >     i =3D 0;
> >     while(iter_next(&it))
> >       i++;
> >=20
> > At each iteration step i++ would produce a new distinct state and
> > eventually instruction processing limit would be reached.
> >=20
> > To avoid such behavior speculatively forget (widen) range for
> > imprecise scalar registers, if those registers were not precise at the
> > end of the previous iteration and do not match exactly.
> >=20
> > This a conservative heuristic that allows to verify wide range of
> > programs, however it precludes verification of programs that conjure
> > an imprecise value on the first loop iteration and use it as precise
> > on the second.
> >=20
> > Test case iter_task_vma_for_each() presents one of such cases:
> >=20
> >         unsigned int seen =3D 0;
> >         ...
> >         bpf_for_each(task_vma, vma, task, 0) {
> >                 if (seen >=3D 1000)
> >                         break;
> >                 ...
> >                 seen++;
> >         }
> >=20
> > Here clang generates the following code:
> >=20
> > <LBB0_4>:
> >       24:       r8 =3D r6                          ; stash current valu=
e of
> >                 ... body ...                       'seen'
> >       29:       r1 =3D r10
> >       30:       r1 +=3D -0x8
> >       31:       call bpf_iter_task_vma_next
> >       32:       r6 +=3D 0x1                        ; seen++;
> >       33:       if r0 =3D=3D 0x0 goto +0x2 <LBB0_6>  ; exit on next() =
=3D=3D NULL
> >       34:       r7 +=3D 0x10
> >       35:       if r8 < 0x3e7 goto -0xc <LBB0_4> ; loop on seen < 1000
> >=20
> > <LBB0_6>:
> >       ... exit ...
> >=20
> > Note that counter in r6 is copied to r8 and then incremented,
> > conditional jump is done using r8. Because of this precision mark for
> > r6 lags one state behind of precision mark on r8 and widening logic
> > kicks in.
> >=20
> > Adding barrier_var(seen) after conditional is sufficient to force
> > clang use the same register for both counting and conditional jump.
> >=20
> > This issue was discussed in the thread [1] which was started by
> > Andrew Werner <awerner32@gmail.com> demonstrating a similar bug
> > in callback functions handling. The callbacks would be addressed
> > in a followup patch.
> >=20
> > [1] https://lore.kernel.org/bpf/97a90da09404c65c8e810cf83c94ac703705dc0=
e.camel@gmail.com/
> >=20
> > Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Co-developed-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h                  |   1 +
> >  kernel/bpf/verifier.c                         | 212 +++++++++++++++---
> >  .../selftests/bpf/progs/iters_task_vma.c      |   1 +
> >  3 files changed, 184 insertions(+), 30 deletions(-)
> >=20
>=20
> [...]
>=20
> > +static int widen_imprecise_scalars(struct bpf_verifier_env *env,
> > +                                  struct bpf_verifier_state *old,
> > +                                  struct bpf_verifier_state *cur)
> > +{
> > +       struct bpf_func_state *fold, *fcur;
> > +       int i, fr;
> > +
> > +       reset_idmap_scratch(env);
> > +       for (fr =3D old->curframe; fr >=3D 0; fr--) {
> > +               fold =3D old->frame[fr];
> > +               fcur =3D cur->frame[fr];
> > +
> > +               for (i =3D 0; i < MAX_BPF_REG; i++)
> > +                       maybe_widen_reg(env,
> > +                                       &fold->regs[i],
> > +                                       &fcur->regs[i],
> > +                                       &env->idmap_scratch);
> > +
> > +               for (i =3D 0; i < fold->allocated_stack / BPF_REG_SIZE;=
 i++) {
> > +                       if (is_spilled_scalar_reg(&fold->stack[i]))
>=20
> should this be !is_spilled_scalar_reg()?
>=20
> but also your should make sure that fcur->stack[i] is also a spilled
> reg (it could be iter or dynptr, or just hard-coded ZERO or MISC stack
> slot, so accessing fcur->stack[i].spilled_ptr below might be invalid)

Yeap, this is a bug, thank you.
I'll add a test case and submit V3 today.

>=20
> > +                               continue;
>=20
> > +
> > +                       maybe_widen_reg(env,
> > +                                       &fold->stack[i].spilled_ptr,
> > +                                       &fcur->stack[i].spilled_ptr,
> > +                                       &env->idmap_scratch);
> > +               }
> > +       }
> > +       return 0;
> > +}
> > +
>=20
> [...]


