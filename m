Return-Path: <bpf+bounces-1559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FA719056
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 04:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D6B1C20F5A
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 02:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9643F1C2E;
	Thu,  1 Jun 2023 02:05:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4F1101
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 02:05:20 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F30F11F
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:05:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b04949e5baso2900265ad.0
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685585118; x=1688177118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=76KJkpC1Zatw40zoohQ9ysnKp2/UDSN1tCPzv9GE2iE=;
        b=efJEqMVEdfXEHXZSj6oqHGiVXE9RxCnCIgu2C3AOvqnx3wnriPDJ2bL4lMlUy5XuJZ
         fnYgvZKXWRCxAfp702uadSmhftuMxaWFaCcxt9URR/ljKn3EscWTdlgdT+yb7Q5D56ws
         /vlVbJmM4Zvk8t+c2rtjIl3EuV9611xYiMD2E11zKVxjXuPcboveZE1tOcsXGq1vzFSW
         GdeNITA0ft1vU7xRQsGmk4U7M0jHRa0SotIR5DfVAlPrGpB/KWPW8YQTSRiPNXBFznGI
         Y32zzBBT0NWTUjwhOfjmAT+1IsW+nXXWQmBX7QWL46qFbNEl0KqPPyKz7rMD2EQk4iVi
         7u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685585118; x=1688177118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76KJkpC1Zatw40zoohQ9ysnKp2/UDSN1tCPzv9GE2iE=;
        b=OdQBFAX20dwbJ3/F9PMTv+kdqJoKz0E41y7BDDR0ZeEFwp4VB6np/j9deq8f2FDMRd
         Rx9rSxEqXSL/EaCDCL8bhONMJOsYDb05IE6/e7610KkOAC8iSQdhdeIWcAW9rmIn1fZu
         G+yIVxOkL9mu494I+KrgV5W9Su0cPL9wYGILsGAm7X9pH/Bkeo2B/q0owrmzjf6GR/l9
         LJ9NDE91nKJiH5Fts+yFCfE6nX7S7EU8mebaqy8LtJ9m9b0kEqt513y8nXaQwDYPKrOy
         cZbv4FXLBAgsqVAwmfyB1D6w7yR6zmlVEBg2zCrG/tV8zrDc62AG++aHNwnKUgq3inni
         Iecg==
X-Gm-Message-State: AC+VfDwNONfB8uTFweKjzwGAODqgpck5L0ViS1miXpNW4qPDbAN/ds5G
	6WZ2DwFVAQp+r9KGCDhoJVc=
X-Google-Smtp-Source: ACHHUZ73ZXx3DiCn0ymhx4sNP7ZK0dK8ty/rfHCjtnb7u9J/G4xkhJ4WW5dm2c9pYbS8pklmJJIepQ==
X-Received: by 2002:a17:903:1251:b0:1ae:8892:7d27 with SMTP id u17-20020a170903125100b001ae88927d27mr7867456plh.42.1685585117472;
        Wed, 31 May 2023 19:05:17 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:a01a])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b0019a5aa7eab0sm2091012plt.54.2023.05.31.19.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 19:05:17 -0700 (PDT)
Date: Wed, 31 May 2023 19:05:14 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
Message-ID: <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local>
References: <20230530172739.447290-1-eddyz87@gmail.com>
 <20230530172739.447290-2-eddyz87@gmail.com>
 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 02:02:37AM +0300, Eduard Zingerman wrote:
> On Tue, 2023-05-30 at 14:37 -0700, Andrii Nakryiko wrote:
> > On Tue, May 30, 2023 at 10:27 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > 
> > > Make sure that the following unsafe example is rejected by verifier:
> > > 
> > > 1: r9 = ... some pointer with range X ...
> > > 2: r6 = ... unbound scalar ID=a ...
> > > 3: r7 = ... unbound scalar ID=b ...
> > > 4: if (r6 > r7) goto +1
> > > 5: r6 = r7
> > > 6: if (r6 > X) goto ...
> > > --- checkpoint ---
> > > 7: r9 += r7
> > > 8: *(u64 *)r9 = Y
> > > 
> > > This example is unsafe because not all execution paths verify r7 range.
> > > Because of the jump at (4) the verifier would arrive at (6) in two states:
> > > I.  r6{.id=b}, r7{.id=b} via path 1-6;
> > > II. r6{.id=a}, r7{.id=b} via path 1-4, 6.
> > > 
> > > Currently regsafe() does not call check_ids() for scalar registers,
> > > thus from POV of regsafe() states (I) and (II) are identical. If the
> > > path 1-6 is taken by verifier first, and checkpoint is created at (6)
> > > the path [1-4, 6] would be considered safe.
> > > 
> > > This commit updates regsafe() to call check_ids() for scalar registers.
> > > 
> > > This change is costly in terms of verification performance.
> > > Using veristat to compare number of processed states for selftests
> > > object files listed in tools/testing/selftests/bpf/veristat.cfg and
> > > Cilium object files from [1] gives the following statistics:
> > > 
> > >   Filter        | Number of programs
> > >   ----------------------------------
> > >   states_pct>10 | 40
> > >   states_pct>20 | 20
> > >   states_pct>30 | 15
> > >   states_pct>40 | 11
> > > 
> > > (Out of total 177 programs)
> > > 
> > > In fact, impact is so bad that in no-alu32 mode the following
> > > test_progs tests no longer pass verifiction:
> > > - verif_scale2: maximal number of instructions exceeded
> > > - verif_scale3: maximal number of instructions exceeded
> > > - verif_scale_pyperf600: maximal number of instructions exceeded
> > > 
> > > Additionally:
> > > - verifier_search_pruning/allocated_stack: expected prunning does not
> > >   happen because of differences in register id allocation.
> > > 
> > > Followup patch would address these issues.
> > > 
> > > [1] git@github.com:anakryiko/cilium.git
> > > 
> > > Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index af70dad655ab..9c10f2619c4f 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -15151,6 +15151,28 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
> > > 
> > >         switch (base_type(rold->type)) {
> > >         case SCALAR_VALUE:
> > > +               /* Why check_ids() for scalar registers?
> > > +                *
> > > +                * Consider the following BPF code:
> > > +                *   1: r6 = ... unbound scalar, ID=a ...
> > > +                *   2: r7 = ... unbound scalar, ID=b ...
> > > +                *   3: if (r6 > r7) goto +1
> > > +                *   4: r6 = r7
> > > +                *   5: if (r6 > X) goto ...
> > > +                *   6: ... memory operation using r7 ...
> > > +                *
> > > +                * First verification path is [1-6]:
> > > +                * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
> > > +                * - at (5) r6 would be marked <= X, find_equal_scalars() would also mark
> > > +                *   r7 <= X, because r6 and r7 share same id.
> > > +                *
> > > +                * Next verification path would start from (5), because of the jump at (3).
> > > +                * The only state difference between first and second visits of (5) is
> > > +                * bpf_reg_state::id assignments for r6 and r7: (b, b) vs (a, b).
> > > +                * Thus, use check_ids() to distinguish these states.
> > > +                */
> > > +               if (!check_ids(rold->id, rcur->id, idmap))
> > > +                       return false;
> > 
> > does this check_ids() have to be performed before regs_exact (which
> > also checks IDs, btw) *and* before rold->precise check?
> 
> Relative position to regs_exact() does not matter (because it does check_ids).
> Relative position to rold->precise *does* matter (see next answer).
> 
> > Intuitively, it feels like `rold->precise = false` case shouldn't care
> > about IDs in rcur, as any value should be safe. But I haven't spent
> > much time thinking about this, so there might be some corner case I'm
> > missing.
> 
> I tried to explain this in the cover letter, I'll try to add more
> details below. Effectively what you suggest is to modify the check as
> follows:
> 
>   if (rold->precise && !check_ids(rold->id, rcur->id, idmap))
>     return false;
> 
> Unfortunately, not all registers with interesting IDs would be marked
> as precise. Consider the original example but with r6 and r7 swapped:
> 
>   1: r9 = ... some pointer with range X ...
>   2: r6 = ... unbound scalar ID=a ...
>   3: r7 = ... unbound scalar ID=b ...
>   4: if (r6 > r7) goto +1
>   5: r7 = r6
>   6: if (r7 > X) goto ...
>   7: r9 += r6
> 
> Suppose that current verification path is 1-7:
> - On a way down 1-6 r7 will not be marked as precise, because
>   condition (r7 > X) is not predictable (see check_cond_jmp_op());
> - When (7) is reached mark_chain_precision() will start moving up
>   marking the following registers as precise:
> 
>   4: if (r6 > r7) goto +1 ; r6, r7
>   5: r7 = r6              ; r6
>   6: if (r7 > X) goto ... ; r6
>   7: r9 += r6             ; r6
> 
> - Thus, if checkpoint is created for (6) r7 would be marked as read,
>   but will not be marked as precise.
>   
> Next, suppose that jump from 4 to 6 is verified and checkpoint for (6)
> is considered:
> - r6 is not precise, so check_ids() is not called for it and it is not
>   added to idmap;
> - r7 is precise, so check_ids() is called for it, but it is a sole
>   register in the idmap;

typos in above?
r6 is precise and r7 is not precise.

> - States are considered equal.
> 
> Here is the log (I added a few prints for states cache comparison):
> 
>   from 10 to 13: safe
>     steq hit 10, cur:
>       R0=scalar(id=2) R6=scalar(id=2) R7=scalar(id=1) R9=fp-8 R10=fp0 fp-8=00000000
>     steq hit 10, old:
>       R6_rD=Pscalar(id=2) R7_rwD=scalar(id=2) R9_rD=fp-8 R10=fp0 fp-8_rD=00000000

the log is correct, thouhg.
r6_old = Pscalar which will go through check_ids() successfully and both are unbounded.
r7_old is not precise. different id-s don't matter and different ranges don't matter.

As another potential fix...
can we mark_chain_precision() right at the time of R1 = R2 when we do
src_reg->id = ++env->id_gen
and copy_register_state();
for both regs?

I think
if (rold->precise && !check_ids(rold->id, rcur->id, idmap))
would be good property to have.
I don't like u32_hashset either.
It's more or less saying that scalar id-s are incompatible with precision.

I hope we don't need to do:
+       u32 reg_ids[MAX_CALL_FRAMES];
for backtracking either.
Hacking id-s into jmp history is equally bad.

Let's figure out a minimal fix.

