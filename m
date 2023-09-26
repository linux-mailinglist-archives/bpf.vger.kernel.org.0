Return-Path: <bpf+bounces-10829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90B37AE2F7
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 02:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DB5D21C209EF
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558F63A;
	Tue, 26 Sep 2023 00:33:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6436B
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 00:33:53 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6018B10A
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:33:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso1001344866b.2
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 17:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695688425; x=1696293225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc6g0UesX6RIjRJc/BS4xnHstYn2EM+AgZ+3pPh3jYI=;
        b=mVxqA9LUpp7Wm070KxMb++6OchuhpllFiVlu821SarQfC7t+X6xKoPHB/KerYlltS7
         He5taTCJaJk3doogRnwbl/e34Pwcu4tz7bMvRkOqXlq40YKCVTauKblv45UT+FAOMHlQ
         f4Acg/19UjaUSsvHD5r5fUA55lfA9YN0UZyQIKBwpTlsysTyrdQszVMEAif1/5EwPHQ6
         zAU9IxcLsShaIb7hJZi8TnQcBEPoczy3pppWyg8tqvjrRrgOo1t78fu/BWIhaUQUXADo
         usDyFANsKL9nvG1WRjQzTPBzLbaMa/jZ1PEAvPBs4Ol16kLiprFP8WKHipcOkt+Bqdu6
         Bsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695688425; x=1696293225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc6g0UesX6RIjRJc/BS4xnHstYn2EM+AgZ+3pPh3jYI=;
        b=iZpiOuujE+AbrPTDdmSOj5NTi2tDQWhxXuTf9z86+AXfWOJi7wiEOhMoLXgqqrxvlF
         S+th3MOER1+g3BW8zVFTl5jfqKuhqBafXNKsJmVpxCZlckVnan1YOiU0QKpyxEWzEtJy
         sLNrp+trO1UgUJczkfG9avqrGcqNojfYEcaSSp3K+GxtH/6wXC/zCGrcOZOAcwCoRFLN
         5l8HOKERf/0cV0aSJQM/lHOyJeLRl8x0hwzKfMk9RMvcHuNKC1nvaI7Iq3kJa1/SwbKw
         JibiidQyrPlWZCtYNgH5iK+L2oAxGs60uvzX20+4GLQZkEaz/FT+sdmbuVrxWg61XW6F
         XhBw==
X-Gm-Message-State: AOJu0YzpMbHE8ofWFQnprNzk9oC9BThI/hZGtBVRlcbKE0R4NS0lmScn
	YnzuKNL3x/83FZO6/jMTQikHQgpnsX2tpITSbmEFAoQn
X-Google-Smtp-Source: AGHT+IFFlSSXGcSDHt0BACdA++XOyI6D4lPyFhYE3tiNB9R7+YylTWSEhMW8QTgav9TDv2D/U/tawPsNtlQ5BIgItWw=
X-Received: by 2002:a17:906:7491:b0:9a1:d29c:6a9d with SMTP id
 e17-20020a170906749100b009a1d29c6a9dmr9018503ejl.46.1695688424570; Mon, 25
 Sep 2023 17:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
 <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
 <CAADnVQJn35f0UvYJ9gyFT4BfViXn8T8rPCXRAC=m_Jx_CFjrtw@mail.gmail.com>
 <5649df64315467c67b969e145afda8bbf7e60445.camel@gmail.com>
 <CAADnVQJO0aVJfV=8RDf5rdtjOCC-=57dmHF20fQYV9EiW2pJ2Q@mail.gmail.com>
 <4b121c3b96dcc0322ea111062ed2260d2d1d0ed7.camel@gmail.com>
 <CAEf4BzbUxHCLhMoPOtCC=6Y-OxkkC9GvjykC8KyKPrFxp6cLvw@mail.gmail.com>
 <52df1240415be1ee8827cb6395fd339a720e229c.camel@gmail.com>
 <ec118c24a33fb740ecaafd9a55416d56fcb77776.camel@gmail.com>
 <CAEf4BzZjut_JGnrqgPE0poJhMjJgtJcafRd6Z_0T0jrW3zARJw@mail.gmail.com>
 <44363f61c49bafa7901ae2aa43897b525805192c.camel@gmail.com>
 <CAEf4BzZ-NGiUVw+yCRCkrPQbJAS4wMBsT3e=eYVMuintqKDKqg@mail.gmail.com> <a777445dcb94c0029eb3bd3ddc96ddc493c85ad0.camel@gmail.com>
In-Reply-To: <a777445dcb94c0029eb3bd3ddc96ddc493c85ad0.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Sep 2023 17:33:32 -0700
Message-ID: <CAEf4BzZU0MxwLfz-dGbmHbEtqVhEMTxwSG+QfwCuCv09CqLcNw@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 6:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-09-22 at 13:52 -0700, Andrii Nakryiko wrote:
> > > > I can't say I understand what exactly you are proposing and how you
> > > > are going to determine these conservative precision marks. But I'd
> > > > like to learn some new ideas, so please elaborate :)
> > >
> > > I'll send a follow-up email, trying to figure out what to do with poi=
nters.
> >
> > Ok, sounds good.
>
> (below explains why DFA was a bad idea, please proceed to the next
>  section if that's not interesting).

ok, that's what I'm doing :)

>
> My initial thought was that it would be possible to use a simple
> live-variable DFA in order to compute conservative read and precise
> marks. Like a textbook version:
> - split code in basic blocks;
> - for each instruction propagate liveness information backwards:
>   - define USE(insn) to be a set of registers / stack slots read by
>     this instruction;
>   - define KILL(insn) to be a set of registers / stack slots written
>     to by this instruction.
>   - compute set of live variables before insn as:
>     LIVE_in(insn) =3D USE(insn) U (LIVE_out(insn) / KILL(insn))
> - compute basic block BB_out as a union of BB_in of each successor;
> - etc... iterate in postorder until fixed point is reached.
>
> However, this is a moot point because of presence of pointers.
> For series of instructions like:
>   "r1 =3D r10; r1 +=3D -8; r1 =3D *(u64 *)(r1 + 0);"
> Such algorithm would need to know possible range of values for r1.
> Meaning that before executing liveness DFA some sort of value range
> analysis would have to be run.
> And these things might get complicated [1]
> (I never implemented one, maybe it's not that bad).
> So, basically that would be a mini-copy of the verifier but
> implemented as a thing that computes fixed point instead of "tracing".
> Probably a no-go.
>
> [1] https://boxbase.org/entries/2017/oct/23/range_analysis_papers/
>
> ---
>
> However, I think there are two more relatively simple options that
> should give correct results.
>
> Option A. "Exit or Loop"
> ------------------------
>
> - Similar to Andrii's suggestion postpone exploration of
>   bpf_iter_*_next() #N->#N+1 states for as long as there are other
>   states to explore.
> - When evaluating is_state_visited() for bpf_iter_*_next() #N->#N+1
>   allow to use visited state with .branches > 0 to prune current
>   state if:
>   - states_equal() for visited and current states returns true;
>   - all verfication paths starting from current instruction index with
>     current iterator ref_obj_id either run to safe exit or run back to
>     current instruction index with current iterator ref_obj_id.
>
> The last rule is needed to:
> - Ensure presence of read and precision marks in a state used for pruning=
.
> - Give a meaning to the precise scalars comparisons in regsafe() which
>   I think is currently missing for bpf_iter_*_next() .branches > 0 case.
>   Precise scalars comparison for visited states with .branches =3D=3D 0
>   could be read as: "using any value from a specific range it is
>   possible to reach safe exit".
>   Precise scalars comparison for looping states from above
>   could be read as: "using any value from a specific range it is
>   possible to reach either safe exit or get back to this instruction".
>
> This algorithm should be able to handle simple iteration patterns like:
>
>     bpf_iter_*_new(&it1, ...)
>     while (!bpf_iter_*_next(&it1)) { ... }
>     bpf_iter_*_destroy(&it1)
>
> And also handle nested iteration:
>
>     bpf_iter_*_new(&it1, ...)
>     while (!bpf_iter_*_next(&it1)) {
>       bpf_iter_*_new(&it2, ...)
>       while (!bpf_iter_*_next(&it2)) { ... }
>       bpf_iter_*_destroy(&it2)
>     }
>     bpf_iter_*_destroy(&it1)
>
> But it would fail to handle more complex patterns, e.g. interleaved
> iteration:
>
>     for (;;) {
>       if (!bpf_iter_*_next(&it1))  // a
>         break;
>       if (!bpf_iter_*_next(&it2))  // b
>         break;
>       ...
>     }
>
> For any state originating in (a) there would always be a state in (b)
> pending verification and vice versa. It would actually bail out even
> if it1 =3D=3D it2.

not working for this intermixed iterator case would be ok, I think
most practical use cases would be a properly nested loops.

But, compiler can actually do something like even for a proper loop.
E.g., something like below

for (; bpf_iter_num_next(&it); ) {
   ....
}

in assembly could be layed out as


bpf_iter_num_next(&it);
...
again:
r0 =3D bpf_iter_num_next(&it)
...
if (r0) goto again


Or something along those lines. So these assumptions that the
iterator's next() call is happening at the same instruction is
problematic.



>
> Option B. "Widening"
> --------------------
>
> The trivial fix for current .branches > 0 states comparison is to
> force "exact" states comparisons for is_iter_next_insn() case:
> 1. Ignore liveness marks, as those are not finalized yet;
> 2. Ignore precision marks, as those are not finalized yet;
> 3. Use regs_exact() for scalars comparison.
>
> This, however, is very restrictive as it fails to verify trivial
> programs like (iters_looping/simplest_loop):
>
>     sum =3D 0;
>     bpf_iter_num_new(&it, 0, 10);
>     while (!(r0 =3D bpf_iter_num_next()))
>       sum +=3D *(u32 *)r0;
>     bpf_iter_num_destroy(&it);
>
> Here ever increasing bounds for "sum" prevent regs_exact() from ever
> returning true.
>
> One way to lift this limitation is to borrow something like the
> "widening" trick from the abstract interpretation papers mentioned
> earlier:
> - suppose there is current state C and a visited is_iter_next_insn()
>   state V with .branches > 0;
> - suppose states_equal(V, C) returns true but exact states comparison
>   returns false because there are scalar values not marked as precise
>   that differ between V and C.
> - copy C as C' and mark these scalars as __mark_reg_unbounded() in C';
> - run verification for C':
>   - if verification succeeds -- problem solved;
>   - if verification fails -- discard C' and proceed from C.
>
> Such algorithm should succeed for programs that don't use widened
> values in "precise" context.
>
> Looking at testcases failing with trivial fix I think that such
> limitations would be similar to those already present (e.g. the big
> comment in progs/iters.c:iter_obfuscate_counter would still apply).
>

This makes sense. I was originally thinking along those lines (and
rejected it for myself), but in a more eager (and thus restrictive)
way: for any scalar register where old and new register states are
equivalent thanks to read mark or precision bit (or rather lack of
precision bit), force that precision/mark in old state. But that is
too pessimistic for cases where we truly needed to simulate N+1 due to
state differences, while keeping the old state intact.

What you propose with temporary C -> C' seems to be along similar
lines, but will give "a second chance" if something doesn't work out:
we'll go on N+1 instead of just failing.


But let's think about this case. Let's say in V R1 is set to 7, but
imprecise. In C we have R1 as 14, also imprecise. According to your
algorithm, we'll create C1 with R1 set to <any num>. Now I have two
questions:

1. How do we terminate C' validation? What happens when we get back to
the next() call again and do states_equal() between V and C'? We just
assume it's correct because C' has R1 as unbounded?

2. Assuming yes. What if later on, V's R1 is actually forced to be
precise, so only if V's R1=3DP7, then it is safe. But we already
concluded that C' is safe based on R1 being unbounded, right? Isn't
that a violation?


> ---
>
> Option B appears to be simpler to implement so I'm proceeding with it.
> Will share progress on Monday. Please let me know if there are any
> obvious flaws with what I shared above.
>
> Thanks,
> Eduard

