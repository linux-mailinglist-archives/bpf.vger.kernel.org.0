Return-Path: <bpf+bounces-10608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEBD7AA718
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 04:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 91E32282188
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 02:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D3E80E;
	Fri, 22 Sep 2023 02:48:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C42385
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 02:48:21 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8862D19C
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 19:48:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c008042211so27854941fa.2
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 19:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695350898; x=1695955698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0dBoRh2lUZqJNKyfkoPqYPW0tPyNYC9KEKW02oqu90=;
        b=Gwfo9HP2sMciA6ObtUV3e88g5d/dE4DfaWwbH7F7v7KxAMjl9G4EFyr3ChpZ93LNij
         3e63Yh0CYWd1DSmpxR36wZBOV65ykyD8HTsTaBl3e8G+YQwW8z6+PjhYsRj412f2c6Aw
         Ojw2BALovpPAD47dlMDoWq5xeE0dNdnD+7DKW3btlysohxbAPu1heaVPfIBr94UZn6Zl
         2pcv8yHD+N5Z+chda3YEwekJCZ4hakmmEIP9mCvtiawl43o7jSvKat6lMzIAMWrwHx9p
         iprS+kD82Fl1xVLwXRmrfgcHOKHKydDGpZiwdPRsLhUdmbW4bIMJx7f3aNSRoDgHhlle
         abFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695350898; x=1695955698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0dBoRh2lUZqJNKyfkoPqYPW0tPyNYC9KEKW02oqu90=;
        b=BgYAwTEOfHfGZ85dYLiZzIOTN4GBQOAbppJeHfsFQjMUbEGQ3zbtcPifV+/eA0J1dR
         xcvmjioo5VUYUDeJF2kuGDO9+nTTg0nFyqC068gl8xNvqEzv8Z1+Qe722if7UXym47hw
         iD6P+RtpILb+7C7XWq9BKw7l1hzGsk/4neRZ0C6o+O+QOeNzjMrLmFIo7t+0+Dzm2wEe
         qsZaAESPc3rbsih6um6yCKtMTiGGdOtmYUobnleTBbESM5Akdho6yuLI955NJdzk3Ial
         LC7nTBMkMU/u0xNalsqt5fOth+dk4WN6Ht6/o7xaPxp3Md+Qe8he9QIrc8D7zVaoFjY8
         z6Mw==
X-Gm-Message-State: AOJu0YxscQ6OIrOUFLtVNwxNlJGIkgVRnOLV4QyKZPZUyDB7HzkLxqGm
	e65xIKDXr+ggL0jm6J9b/CDaQ7A+zOvFx/3PFHU=
X-Google-Smtp-Source: AGHT+IHe2IGbr5g5Iw0z1aHUaQzQe7fGvmyOKNtRF8TwKFMjmShczPLjPohvTaLUV8XfcSpFXSXT8HwCqguMB3mIbc0=
X-Received: by 2002:a2e:874e:0:b0:2c0:2f71:2043 with SMTP id
 q14-20020a2e874e000000b002c02f712043mr5974397ljj.53.1695350897436; Thu, 21
 Sep 2023 19:48:17 -0700 (PDT)
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
 <52df1240415be1ee8827cb6395fd339a720e229c.camel@gmail.com> <ec118c24a33fb740ecaafd9a55416d56fcb77776.camel@gmail.com>
In-Reply-To: <ec118c24a33fb740ecaafd9a55416d56fcb77776.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Sep 2023 19:48:05 -0700
Message-ID: <CAEf4BzZjut_JGnrqgPE0poJhMjJgtJcafRd6Z_0T0jrW3zARJw@mail.gmail.com>
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

On Thu, Sep 21, 2023 at 6:01=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-09-21 at 21:16 +0300, Eduard Zingerman wrote:
> > On Thu, 2023-09-21 at 09:35 -0700, Andrii Nakryiko wrote:
> > > I've been thinking in a similar direction as Alexei, overnight. Here
> > > are some raw thoughts.
> > >
> > > I think the overall approach with iter verification is sound. If we
> > > loop and see an equivalent state at the entry to next loop iteration,
> > > then it's safe to assume doing many iterations is safe. The problem i=
s
> > > that delayed precision and read marks make this state equivalence
> > > wrong in some case. So we need to find a solution that will ensure
> > > that all precision and read marks are propagated to parent state
> > > before making a decision about convergence.
> > >
> > > The idea is to let verifier explore all code paths starting from
> > > iteration #N, except the code paths that lead to looping into
> > > iteration #N+1. I tried to do that with validating NULL case first an=
d
> > > exiting from loop on each iteration (first), but clearly that doesn't
> > > capture all the cases, as Eduard have shown.
> > >
> > > So what if we delay convergence state checks (and then further
> > > exploration at iteration #N+1) using BFS instead of DFS? That is, whe=
n
> > > we are about to start new iteration and check state convergence, we
> > > enqueue current state to be processed later after all the states that
> > > "belong" to iteration #N are processed.
> >
> > This sounds correct if one iterator is involved.
> >
> > > We should work out exact details on how to do this hybrid BFS+DFS, bu=
t
> > > let's think carefully if this will solve the problems?
> > >
> > > I think this is conceptually similar to what Alexei proposed above.
> > > Basically, we "unroll" loop verification iteration by iteration, but
> > > make sure that we explore all the branching within iteration #N befor=
e
> > > going one iteration deeper.
> > >
> > > Let's think if there are any cases which wouldn't be handled. And the=
n
> > > think how to implement this elegantly (e.g., some sort of queue withi=
n
> > > a parent state, which sounds similar to this separate "branches"
> > > counter that Alexei is proposing above).
> >
> > To better understand the suggestion, suppose there is some iterator
> > 'I' and two states:
> > - state S1 where depth(I) =3D=3D N and pending instruction is "next(I)"
> > - state S2 where depth(I) =3D=3D N and pending instruction is *not* "ne=
xt(I)"
> > In such situation state S2 should be verified first, right?
> > And in general, any state that is not at "next(I)" should be explored
> > before S1, right?
> >
> > Such interpretation seems to be prone to deadlocks, e.g. suppose there
> > are two iterators: I1 and I2, and two states:
> > - state S1 with depth(I1) =3D=3D N, depth(I2) =3D=3D M, at instruction =
"next(I1)";
> > - state S2 with depth(I1) =3D=3D N, depth(I2) =3D=3D M, at instruction =
"next(I2)".
> >
> > E.g. like in the following loop:
> >
> >     for (;;) {
> >       if (<random condition>)
> >         if (!next(it1)) break; // a
> >       else
> >         if (!next(it2)) break; // b
> >       ...
> >     }
> >
> > I think it is possible to get to two states here:
> > - (a) it1(active, depth 0), it2(active, depth 0) at insn "next(it1)"
> > - (b) it1(active, depth 0), it2(active, depth 0) at insn "next(it2)"
> >
> > And it is unclear which one should be processed next.
> > Am I missing something?
>
> Not sure if such ordering issues a real issues or any of the
> candidates could be picked.
>

Yes, my gut feeling was that if this idea works at all, then ordering
for this won't matter. The question is if the idea itself is sound.
Basically, I need to convince myself that subsequent iterations won't
add any new read/precise marks. You are good at counter examples, so
maybe you can come up with an example where input state into iteration
#1 will get more precision marks only at iteration #2 or deeper. If
that's the case, then this whole idea of postponing loop convergence
checks probably doesn't work.

> How about a more dumb solution which, imho, is easier to convince
> oneself is correct (at-least from logical pov, not necessarily
> implementation): substitute the goal of finding exact precision marks
> with the goal of finding conservative precision marks. These marks
> could be used instead of exact for states_equal() when .branches > 0.
>
> A straightforward way to compute such marks is to run a flow-sensitive
> context/path-insensitive backwards DFA before do_check(). The result
> of this DFA is a bitmask encoding which registers / stack slots may be
> precise at each instruction. Information for instructions other than
> is_iter_next_insn() could be discarded.
>
> Looking at the tests that are currently failing with my local fixes
> (which force exact states comparions for .branches > 0) I think that
> DFA based version would cover all of them.
>
> This sure adds some code to the verifier, however changing current
> states traversal logic from DFS to combination of DFS+BFS is a
> significant change as well.

I don't think adding BFS sequencing is a lot of code. It's going to be
a simple and small amount of code with potentially intricate behavior.
But code-wise should be pretty minimal.

>
> Wdyt?

I can't say I understand what exactly you are proposing and how you
are going to determine these conservative precision marks. But I'd
like to learn some new ideas, so please elaborate :)

