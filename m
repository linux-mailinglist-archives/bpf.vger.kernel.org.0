Return-Path: <bpf+bounces-10880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6824D7AF0A7
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 18:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 60D4F1C20856
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D8834188;
	Tue, 26 Sep 2023 16:25:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22880339A0
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 16:25:44 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C5119E
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 09:25:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso1210354166b.2
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695745541; x=1696350341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZsMP4Vx4eIE8PD5KRjjD6qgBxJvND6Vrc+A0wtJE+c=;
        b=AFbekqQMorMlI6FNM20zQ3ps25NxUrqjSmEMjv6bgoHO17gXzvaJVoyRpSDkfN/YYu
         YlWaUjky5mJSO5Mm/kPivvw3044/tEadF2xriSYosuwLUdWAp7qW0K9IgFO+Z3X4OR4o
         9ah2VPf0hoyNeViKSsimSfIAskrcdjb6V2W2e6FMPpAXNEy9x1QRa9UN0Q3hfVKSdKYC
         0p9lbQBNwk2KpxonfTCz0Z4AcDLa4NR9ULFuGLGAK3ZiU5bq2H04QURd45pZE2GbGF0s
         6/QnofanEfEJqHKsc01NDZyS1esDQvQyubkhnSZZx6E0sUsms4vYbyHM0wGi23coin6f
         wKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695745541; x=1696350341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZsMP4Vx4eIE8PD5KRjjD6qgBxJvND6Vrc+A0wtJE+c=;
        b=xCrffagEr4hIXdN7xgbF4GXd2AQN1S/iw+q64EKMxf7h8U5r2dZMh+ns3JP1ujn7EM
         08d7JUvjZhYWchJHoUtCFO6yQg11Ch4lJEnScDxyFGQhFnk6qec1OwtCnmqGEqPSgs60
         Tk3FkMwRU/wjWOH5fiRLcu0EnlZKsh8UCeITotJGlpTNr94hDHTfT9Q2kd6r9o9qFI1n
         UhT05WnxjtxUpjemC0ioBmzCzKv2gPQdcFn29PaYMNtjCv/d+V343PrDOh9ikR9m+lLB
         VBihTNX2HDP73ga2HH3q0NhgT/rL2z68yA6ss9HikddhfqtMlvE2Y43UBApqAoDDwWaR
         TpAQ==
X-Gm-Message-State: AOJu0Yx40QZ3veQWi7xYYxlOHQgcAStfJd0M8ZINEthdjJOtwP51bRLF
	7B8pZaMjTO7ke2FnsgwsXkkYYtSieALtGLPoPo02s+/Dfj4=
X-Google-Smtp-Source: AGHT+IFuP4108JB4TDcZnjbQ40lbCSu4VpTsxlUnJYMe8Zy1ja+E7TLQHDM15lv4wmtrZ3Ci8igyeH9/ot82VEpai3I=
X-Received: by 2002:a17:906:3046:b0:9a9:eef6:434a with SMTP id
 d6-20020a170906304600b009a9eef6434amr10246085ejd.36.1695745540400; Tue, 26
 Sep 2023 09:25:40 -0700 (PDT)
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
 <CAEf4BzZ-NGiUVw+yCRCkrPQbJAS4wMBsT3e=eYVMuintqKDKqg@mail.gmail.com>
 <a777445dcb94c0029eb3bd3ddc96ddc493c85ad0.camel@gmail.com>
 <CAEf4BzZU0MxwLfz-dGbmHbEtqVhEMTxwSG+QfwCuCv09CqLcNw@mail.gmail.com> <ca9ac095cf1b3fff55eea8a3c87670a349bbfbcf.camel@gmail.com>
In-Reply-To: <ca9ac095cf1b3fff55eea8a3c87670a349bbfbcf.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Sep 2023 09:25:28 -0700
Message-ID: <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
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

On Tue, Sep 26, 2023 at 8:55=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-09-25 at 17:33 -0700, Andrii Nakryiko wrote:
> [...]
> > not working for this intermixed iterator case would be ok, I think
> > most practical use cases would be a properly nested loops.
> >
> > But, compiler can actually do something like even for a proper loop.
> > E.g., something like below
> >
> > for (; bpf_iter_num_next(&it); ) {
> >    ....
> > }
> >
> > in assembly could be layed out as
> >
> >
> > bpf_iter_num_next(&it);
> > ...
> > again:
> > r0 =3D bpf_iter_num_next(&it)
> > ...
> > if (r0) goto again
> >
> >
> > Or something along those lines. So these assumptions that the
> > iterator's next() call is happening at the same instruction is
> > problematic.
>
> For the specific example above I think it would not be an issue
> because there is still only one next() call in the loop =3D>
> there would be no stalled next() transition states.
>
> I checked disassembly for progs/iters.c and it appears that for each
> program there compiler preserves nested loops structure such that:
> - each loop is driven by a single next() call of a dedicated iterator;
> - each nested loop exit goes through destroy() for corresponding
>   iterator, meaning that outer loop's next will never see inner's loop
>   iterator as active =3D> no stalled states due to inner loop
>   processing.
>
> Of-course, I'm not a robot and might have missed something that would
> break real implementation.
>
> > > Option B. "Widening"
> > > --------------------
> > >
> > > The trivial fix for current .branches > 0 states comparison is to
> > > force "exact" states comparisons for is_iter_next_insn() case:
> > > 1. Ignore liveness marks, as those are not finalized yet;
> > > 2. Ignore precision marks, as those are not finalized yet;
> > > 3. Use regs_exact() for scalars comparison.
> > >
> > > This, however, is very restrictive as it fails to verify trivial
> > > programs like (iters_looping/simplest_loop):
> > >
> > >     sum =3D 0;
> > >     bpf_iter_num_new(&it, 0, 10);
> > >     while (!(r0 =3D bpf_iter_num_next()))
> > >       sum +=3D *(u32 *)r0;
> > >     bpf_iter_num_destroy(&it);
> > >
> > > Here ever increasing bounds for "sum" prevent regs_exact() from ever
> > > returning true.
> > >
> > > One way to lift this limitation is to borrow something like the
> > > "widening" trick from the abstract interpretation papers mentioned
> > > earlier:
> > > - suppose there is current state C and a visited is_iter_next_insn()
> > >   state V with .branches > 0;
> > > - suppose states_equal(V, C) returns true but exact states comparison
> > >   returns false because there are scalar values not marked as precise
> > >   that differ between V and C.
> > > - copy C as C' and mark these scalars as __mark_reg_unbounded() in C'=
;
> > > - run verification for C':
> > >   - if verification succeeds -- problem solved;
> > >   - if verification fails -- discard C' and proceed from C.
> > >
> > > Such algorithm should succeed for programs that don't use widened
> > > values in "precise" context.
> > >
> > > Looking at testcases failing with trivial fix I think that such
> > > limitations would be similar to those already present (e.g. the big
> > > comment in progs/iters.c:iter_obfuscate_counter would still apply).
> > >
> >
> > This makes sense. I was originally thinking along those lines (and
> > rejected it for myself), but in a more eager (and thus restrictive)
> > way: for any scalar register where old and new register states are
> > equivalent thanks to read mark or precision bit (or rather lack of
> > precision bit), force that precision/mark in old state. But that is
> > too pessimistic for cases where we truly needed to simulate N+1 due to
> > state differences, while keeping the old state intact.
>
> In other words there is a function states_equal' for comparison of
> states when old{.branches > 0}, which differs from states_equal in
> the following way:
> - considers all registers read;
> - considers all scalars precise.
>

Not really. The important aspect is to mark registers that were
required to be imprecise in old state as "required to be imprecise",
and if later we decide that this register has to be precise, too bad,
too late, game over (which is why I didn't propose it, this seems too
restrictive).

> > What you propose with temporary C -> C' seems to be along similar
> > lines, but will give "a second chance" if something doesn't work out:
> > we'll go on N+1 instead of just failing.
>
> Right.
>
> > But let's think about this case. Let's say in V R1 is set to 7, but
> > imprecise. In C we have R1 as 14, also imprecise. According to your
> > algorithm, we'll create C1 with R1 set to <any num>. Now I have two
> > questions:
> >
> > 1. How do we terminate C' validation? What happens when we get back to
> > the next() call again and do states_equal() between V and C'? We just
> > assume it's correct because C' has R1 as unbounded?
>
> For the definition above states_equal'(V, C') is false, but because we
> are at checkpoint on the next iteration we would get to
> states_equal'(C', C'') where C'' is derived from C' and same rules
> would apply. If we are lucky nothing would change and there would no
> point in scheduling another traversal.

Ah, I see, "fixed point" state convergence is the hope, ok.

>
> > 2. Assuming yes. What if later on, V's R1 is actually forced to be
> > precise, so only if V's R1=3DP7, then it is safe. But we already
> > concluded that C' is safe based on R1 being unbounded, right? Isn't
> > that a violation?
>
> My base assumption is that:
> 1. any instruction reachable from V should also be reachable from C';
> 2. and that it is also guaranteed to be visited from C'.
> I cannot give a formal reasoning for (2) at the moment.
>
> In case if this assumption holds, when verification proceeds from C'
> it would eventually get to instruction for which R1 value is only safe
> when R1=3D7, if so:
> - verification of C' conjecture would fail;
> - all states derived from C' would need to be removed from
>   states stack / explored states;
> - verification should proceed from C.
> (And there is also a question of delaying read/precision propagation
>  from unproven conjecture states to regular states).
>
> (Also I'm still not sure whether to use regs_exact() for scalars
>  comparison instead of precision logic in states_equal').

Yeah, it's getting complicated, eh? :)

But aside from this approach, I was thinking back to my proposal to
combine BFS and DFS approaches. Let's give it another look. Quoting
from my earlier email:


The idea is to let verifier explore all code paths starting from
iteration #N, except the code paths that lead to looping into
iteration #N+1. I tried to do that with validating NULL case first and
exiting from loop on each iteration (first), but clearly that doesn't
capture all the cases, as Eduard have shown.

So what if we delay convergence state checks (and then further
exploration at iteration #N+1) using BFS instead of DFS? That is, when
we are about to start new iteration and check state convergence, we
enqueue current state to be processed later after all the states that
"belong" to iteration #N are processed.


I still think that the whole "let's explore all states except the
looping back ones" idea is the right direction. But the above is a bit
imprecise about "iteration #N and iteration #N+1" parts. We
interpreted it as when we get back to *any* next() call for a given
iterator, then we postpone the checks.

And you've shown with your counter examples how we actually don't
explore all possible code paths. Let's see if we can actually fix that
problem and make sure that we do explore everything that is
terminatable. How about the following clarifications/refinements to
the above:

1. If V and C (using your terminology from earlier, where V is the old
parent state at some next() call instruction, and C is the current one
on the same instruction) are different -- we just keep going. So
always try to explore different input states for the loop.

2. But if V and C are equivalent, it's too early to conclude anything.
So enqueue C for later in a separate BFS queue (and perhaps that queue
is per-instruction, actually; or maybe even per-state, not sure), and
keep exploring all the other pending queues from the (global) DFS
queue, until we get back to state V again. At that point we need to
start looking at postponed states for that V state. But this time we
should be sure that precision and read marks are propagated from all
those terminatable code paths.

Basically, this tries to make sure that we do mark every register that
is important for all the branching decision making, memory
dereferences, etc. And just avoids going into endless loops with the
same input conditions.

Give it some fresh thought and let's see if we are missing something
again. Thanks!

