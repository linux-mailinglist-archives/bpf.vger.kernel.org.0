Return-Path: <bpf+bounces-10605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99087AA644
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 03:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 119A9281466
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 01:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C291438D;
	Fri, 22 Sep 2023 01:01:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DF377
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 01:01:16 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2285C102
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 18:01:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c00c0f11b2so25052511fa.1
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 18:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695344468; x=1695949268; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2RyJqiWcuXmAW4FCoOTNLcNGa6sI16vz4+XveXFB9yI=;
        b=K1gLR8hgEZ7NcGGyN/AokUzBTaj0WJUMkjDjjZjrwe4/BVGdFWcneEnVuOVwZegbM7
         yPOKxqmqGgzn4Rb7M5JsUjSJXP16Rg+WkFggq1gqJiSd4hC1N86Em5qvgqjPKEczqJ+c
         LYwp0sXZGwSB4d2eGvzRXahGzUaIvBkpcOcQz1nFH8ZyzdxhC4cc4rW+FMEGlv5pkHyH
         osYsPesM6qk53U5/+kJS2G7MvZ68VyvL1mjvOK3YnSwrBG0ypOUFTTYmKHJpbejDavdU
         TtECOaRx8oqj88y5MAzosZ9Yq3K+Fxj6itQ/JBqxRF+8QzX7Ci6ItkQZ3p2soe81YGbk
         Ak9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695344468; x=1695949268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RyJqiWcuXmAW4FCoOTNLcNGa6sI16vz4+XveXFB9yI=;
        b=NUdNFW4mu9ZSepEviXCpkjNL5BrXgQJgzBwrh8QC18INv58acOq89GGAX+2UCqjHFr
         E94COHpI2+MmvYbmvK8oQvovWGbXTviF0xlq/e/XxV3NCCJMln9ivCimehzs/2QSDlSG
         jkqh4s5ymSEkZ6PNc2CO4SvVMgTOlgdPsed3wxlXWV5MzGhGvI4Mr6zYJo0Tv2WvfE3q
         gWvRX4pJ0OODJND/fjNhLG07utzNWScgm8wvRlocqrt/D4X4PQ4Vr+bRHH7m9eGch+yA
         U1eM3IaqIy6STMdsRHg4pAXHa5PXWwQcda+4mQfuQCFDxdniKnvEnX9Aq1G+qoU9yha1
         y89g==
X-Gm-Message-State: AOJu0YwlQ4huIeUlWXJ8Ex+583u5eZP11H0gQmSPRoKMgRn46OiFhyZA
	owDe5uT0pcWqthEepWV8zIk=
X-Google-Smtp-Source: AGHT+IEeQ7LAaIFzrJJzNQ32EeCl2oIf3xe0qNsJKNPddTvrM+2l0IyfcHDviPgTSivV9j4WgDZ8Cw==
X-Received: by 2002:a2e:8797:0:b0:2c0:ff6:984a with SMTP id n23-20020a2e8797000000b002c00ff6984amr5052604lji.50.1695344467787;
        Thu, 21 Sep 2023 18:01:07 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709063a1500b0099d0c0bb92bsm1821658eje.80.2023.09.21.18.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 18:01:06 -0700 (PDT)
Message-ID: <ec118c24a33fb740ecaafd9a55416d56fcb77776.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 22 Sep 2023 04:01:05 +0300
In-Reply-To: <52df1240415be1ee8827cb6395fd339a720e229c.camel@gmail.com>
References: 
	<CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-09-21 at 21:16 +0300, Eduard Zingerman wrote:
> On Thu, 2023-09-21 at 09:35 -0700, Andrii Nakryiko wrote:
> > I've been thinking in a similar direction as Alexei, overnight. Here
> > are some raw thoughts.
> >=20
> > I think the overall approach with iter verification is sound. If we
> > loop and see an equivalent state at the entry to next loop iteration,
> > then it's safe to assume doing many iterations is safe. The problem is
> > that delayed precision and read marks make this state equivalence
> > wrong in some case. So we need to find a solution that will ensure
> > that all precision and read marks are propagated to parent state
> > before making a decision about convergence.
> >=20
> > The idea is to let verifier explore all code paths starting from
> > iteration #N, except the code paths that lead to looping into
> > iteration #N+1. I tried to do that with validating NULL case first and
> > exiting from loop on each iteration (first), but clearly that doesn't
> > capture all the cases, as Eduard have shown.
> >=20
> > So what if we delay convergence state checks (and then further
> > exploration at iteration #N+1) using BFS instead of DFS? That is, when
> > we are about to start new iteration and check state convergence, we
> > enqueue current state to be processed later after all the states that
> > "belong" to iteration #N are processed.
>=20
> This sounds correct if one iterator is involved.
>=20
> > We should work out exact details on how to do this hybrid BFS+DFS, but
> > let's think carefully if this will solve the problems?
> >=20
> > I think this is conceptually similar to what Alexei proposed above.
> > Basically, we "unroll" loop verification iteration by iteration, but
> > make sure that we explore all the branching within iteration #N before
> > going one iteration deeper.
> >=20
> > Let's think if there are any cases which wouldn't be handled. And then
> > think how to implement this elegantly (e.g., some sort of queue within
> > a parent state, which sounds similar to this separate "branches"
> > counter that Alexei is proposing above).
>=20
> To better understand the suggestion, suppose there is some iterator
> 'I' and two states:
> - state S1 where depth(I) =3D=3D N and pending instruction is "next(I)"
> - state S2 where depth(I) =3D=3D N and pending instruction is *not* "next=
(I)"
> In such situation state S2 should be verified first, right?
> And in general, any state that is not at "next(I)" should be explored
> before S1, right?
>=20
> Such interpretation seems to be prone to deadlocks, e.g. suppose there
> are two iterators: I1 and I2, and two states:
> - state S1 with depth(I1) =3D=3D N, depth(I2) =3D=3D M, at instruction "n=
ext(I1)";
> - state S2 with depth(I1) =3D=3D N, depth(I2) =3D=3D M, at instruction "n=
ext(I2)".
>=20
> E.g. like in the following loop:
>=20
>     for (;;) {
>       if (<random condition>)
>         if (!next(it1)) break; // a
>       else
>         if (!next(it2)) break; // b
>       ...
>     }
>=20
> I think it is possible to get to two states here:
> - (a) it1(active, depth 0), it2(active, depth 0) at insn "next(it1)"
> - (b) it1(active, depth 0), it2(active, depth 0) at insn "next(it2)"
>=20
> And it is unclear which one should be processed next.
> Am I missing something?

Not sure if such ordering issues a real issues or any of the
candidates could be picked.

How about a more dumb solution which, imho, is easier to convince
oneself is correct (at-least from logical pov, not necessarily
implementation): substitute the goal of finding exact precision marks
with the goal of finding conservative precision marks. These marks
could be used instead of exact for states_equal() when .branches > 0.

A straightforward way to compute such marks is to run a flow-sensitive
context/path-insensitive backwards DFA before do_check(). The result
of this DFA is a bitmask encoding which registers / stack slots may be
precise at each instruction. Information for instructions other than
is_iter_next_insn() could be discarded.

Looking at the tests that are currently failing with my local fixes
(which force exact states comparions for .branches > 0) I think that
DFA based version would cover all of them.

This sure adds some code to the verifier, however changing current
states traversal logic from DFS to combination of DFS+BFS is a
significant change as well.

Wdyt?

