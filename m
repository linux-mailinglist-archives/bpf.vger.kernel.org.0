Return-Path: <bpf+bounces-11212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454FF7B57E7
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E5950284EFE
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0721BDF5;
	Mon,  2 Oct 2023 16:30:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654911DDC0
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 16:30:14 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BDC83
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 09:30:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so172048315e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696264211; x=1696869011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUVEsItNXpzLwY3rom40J0xH4qEyI2Q28AJB8xr6jto=;
        b=ZEOH7AZAYylTY9eBZR32FeVbAog+Ce/NbbZKJXPiRrJ1ghYkz2eKGYYm1v+orQaSkf
         5R4lHDHCgxmYBME0B6cn8T/rEOntgDVAbbBx3fGD+IcD766SzdUiuYtg2yWYG898nYT3
         zCwh2MO14uji2V20oqKo9rOSSw5rYxFiOHA13ZFxBkWTk5puGBT5PUXj1MpDdgxnE/5I
         2xp6wdFjWbbEZ6eJ60WrOeLhzMSKDfKAkmnp9Z42YavOq8Uxdwp8+AftqmBL1Slt5kRD
         53AeufZ1nX4yA29QxFyJ5WqtQsXClVcWDZfPpCKASAU652qA/RZt4ZpAhj8k9pYDs7VP
         o8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696264211; x=1696869011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUVEsItNXpzLwY3rom40J0xH4qEyI2Q28AJB8xr6jto=;
        b=VP4BE1+K+/ZwlRJ4KJgje58nRawvuXg53VLTHZ5bSXsSR8jbAN+eCHdqbJPltb28LX
         qhYd6FOHOvvofvBgjI/JvfXnAp6XbGIf7a9pkbsDOWOs4UuyEa7SJGwtvwHsr1SbfNw7
         EB++RfczUevnw7A/WzqVnEHnuMZoyzunpUwOBRJ1YK5ylgIlp/6LNPXQnaYEVn8kKzPs
         8q6NmGDpjb4qo+0apynzzVGvjSgIOyBrklyHT378OOs73eNyoeCjbmwkzWQ5P+QNh4S9
         6GTwGRPsM9hnitOkrqYT23knr5Gbb0Y+68lZPtRIlPvGWuPho6AyogPe13PMiNys7dCq
         6rNQ==
X-Gm-Message-State: AOJu0YycN0w0pcX0/aaDpw3a1gkYe09hEJBxPFcDDFP56pPWeIvOs7EN
	ovr7ISpqkVZk3gYU6c70fQe8Zdp9gwlOJmLaCQc=
X-Google-Smtp-Source: AGHT+IF1K5/8vdKfdDWRbUArGj0/TCbC0RiKFiGN9/97tzX62E6hwbVBRg1VNf4+1mhkAsllS4B50sKK9xS5m2pRuW4=
X-Received: by 2002:a5d:4f8a:0:b0:317:5f13:5c2f with SMTP id
 d10-20020a5d4f8a000000b003175f135c2fmr10394797wru.0.1696264210456; Mon, 02
 Oct 2023 09:30:10 -0700 (PDT)
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
 <CAEf4BzZU0MxwLfz-dGbmHbEtqVhEMTxwSG+QfwCuCv09CqLcNw@mail.gmail.com>
 <ca9ac095cf1b3fff55eea8a3c87670a349bbfbcf.camel@gmail.com>
 <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com> <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
In-Reply-To: <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Oct 2023 09:29:58 -0700
Message-ID: <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
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

On Sun, Oct 1, 2023 at 6:40=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2023-09-29 at 17:41 -0700, Alexei Starovoitov wrote:
> [...]
> > I suspect that neither option A "Exit or Loop" or B "widening"
> > are not correct.
> > In both cases we will do states_equal() with states that have
> > not reached exit and don't have live/precision marks.
>
> I'd like to argue about B "widening" for a bit, as I think it might be
> interesting in general, and put A aside for now. The algorithm for
> widening looks as follows:
> - In is_states_equal() for (sl->state.branches > 0 && is_iter_next_insn()=
) case:
>   - Check if states are equal exactly:
>     - ignore liveness marks on old state;
>     - demand same type for registers and stack slots;
>     - ignore precision marks, instead compare scalars using
>       regs_exact() [this differs from my previous emails, I'm now sure
>       that for this scheme to be correct regs_exact() is needed].
>   - If there is an exact match then follow "hit" branch. The idea
>     being that visiting exactly the same state can't produce new
>     execution paths (like with graph traversal).

Right. Exactly the same C state won't produce new paths
as seen in visited state V, but
if C=3D=3DV at the same insn indx it means we're in the infinite loop.

>   - If there is no exact match but there is some state V which for
>     which states_equal(V, C) and V and C differ only in inexact
>     scalars:
>     - copy C to state C';
>     - mark range for above mentioned inexact scalars as unbound;
>     - continue verification from C';
>     - if C' verification fails discard it and resume verification from C.
>
> The hope here is that guess for "wide" scalars would be correct and
> range for those would not matter. In such case C' would be added to
> the explored states right after it's creation (as it is a checkpoint),
> and later verification would get to the explored C' copy again, so
> that exact comparison would prune further traversals.
>
> Unfortunately, this is riddled with a number of technical
> complications on implementation side.
> What Andrii suggests might be simpler.
>
> > The key aspect of the verifier state pruning is that safe states
> > in sl list explored all possible paths.
> > Say, there is an 'if' block after iter_destroy.
> > The push_stack/pop_stack logic is done as a stack to make sure
> > that the last 'if' has to be explored before earlier 'if' blocks are ch=
ecked.
> > The existing bpf iter logic violated that.
> > To fix that we need to logically do:
> >
> > if (is_iter_next_insn(env, insn_idx))
> >   if (states_equal(env, &sl->state, cur)) {
> >    if (iter_state->iter.state =3D=3D BPF_ITER_STATE_DRAINED)
> >      goto hit;
> >
> > instead of BPF_ITER_STATE_ACTIVE.
> > In other words we need to process loop iter =3D=3D 0 case first
> > all the way till bpf_exit (just like we do right now),
> > then process loop iter =3D=3D 1 and let it exit the loop and
> > go till bpf_exit (hopefully state prune will find equal states
> > right after exit from the loop).
> > then process loop iter =3D=3D 2 and so on.
> > If there was an 'if' pushed to stack during loop iter =3D=3D 1
> > it has to be popped and explored all the way till bpf_exit.
> >
> > We cannot just replace BPF_ITER_STATE_ACTIVE with DRAINED.
> > It would still be ACTIVE with sl->state.branches=3D=3D0 after that
> > state explored all paths to bpf_exit.
>
> This is similar to what Andrii suggests, please correct me if I'm wrong:
>
> > 1. If V and C (using your terminology from earlier, where V is the old
> > parent state at some next() call instruction, and C is the current one
> > on the same instruction) are different -- we just keep going. So
> > always try to explore different input states for the loop.
>
> > 2. But if V and C are equivalent, it's too early to conclude anything.
> > So enqueue C for later in a separate BFS queue (and perhaps that queue
> > is per-instruction, actually; or maybe even per-state, not sure), and
> > keep exploring all the other pending queues from the (global) DFS
> > queue, until we get back to state V again. At that point we need to
> > start looking at postponed states for that V state. But this time we
> > should be sure that precision and read marks are propagated from all
> > those terminatable code paths.
>
> More formally, before pruning potential looping states we need to
> make sure that all precision and read marks are in place.
> To achieve this:
> - Process states from env->head while those are available, in case if
>   potential looping state (is_states_equal()) is reached put it to a
>   separate queue.
> - Once all env->head states are processed the only source for new read
>   and precision marks is in postponed looping states, some of which
>   might not be is_states_equal() anymore. Submit each such state for
>   verification until fixed point is reached (repeating steps for
>   env->head processing).

Comparing if (sl->state.branches) makes sense to find infinite loop.
It's waste for the verifier to consider visited state V with branches > 0
for pruning.
The safety of V is unknown. The lack of liveness and precision
is just one part. The verifier didn't conclude that V is safe yet.
The current state C being equivalent to V doesn't tell us anything.

If infinite loop detection logic trips us, let's disable it.
I feel the fix should be in process_iter_next_call() to somehow
make it stop doing push_stack() when states_equal(N-1, N-2).

