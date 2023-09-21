Return-Path: <bpf+bounces-10531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD67A985E
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C962826D9
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C9314F90;
	Thu, 21 Sep 2023 17:11:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31FD14F7C
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 17:11:56 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F524875
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:11:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405361bba99so7586805e9.2
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316291; x=1695921091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IcVQTPRepN/jNJNgXZwlS0UIYhTlGVRoMrnWGGHrUI=;
        b=Y7WG1C2GtNZy96GblgSSCmZUbRH2sOiDGrF5yotWkGeW/HTNggl9SlCZui40eCs24J
         gfEJrBkpefO5HBGdbQFws2cIbdcIwBBChI6XKp2FMC68NGBPWnljaPdB5Q8Ity3qXp8p
         Q+gIDVgG35srWCaUgHG3gHmKMWTBOT1SwuecFq8P7YIzxKU9H/MGRHj35gWbmLBo1eii
         O+HNlcF8EjqqH1DAuKr9JwDvs67OW8Y4Iir+12OsMpG2+K/7eVxg2tVnQ6AS6x/eekik
         rDUBgsFemn/EYogv5FTzvahwrEFNln0wmXiC04Vgc03DpeRNKj23dsRon6mtm9Wv/UPq
         hCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316291; x=1695921091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IcVQTPRepN/jNJNgXZwlS0UIYhTlGVRoMrnWGGHrUI=;
        b=V0NL+/7IDgusBlFNDo5VopATuxxj7ktBckRkf4bJ4sCmfR6y4EnbNr1gRh/1+cIiP4
         R/2QOXdPyTO3TKq1hCJOpHMe98as2nihQKq7Zkx7GziRCLLRX3CjWxVdg0Y1RqVZ/Ses
         l+qPdnkqmka2KF1Fk6Y0j+ApEgYpyRB0OmTZKPO9CP7SDXLWvlMVZaRS+YWY7loPmRFE
         k9e/uXjKy6TuV3un549P05GG9wQ5lHJM1eE7WeO2YqwmRQSk1eLaiTnFe3OlPU1/kFrD
         ZD6FG6jDZMFgJ9C9ClRSUAWifuFKJFY3NxRolAmVU48EY2tQ6iOBSGjBFaJWweK3xez8
         h0Fw==
X-Gm-Message-State: AOJu0YzWCJvyTXLO/idIB9bIjFcX9dofAA8Jfbf178PKrloPErSnkJ/q
	A9gU3IjTSfznKefDFsyIhpwn+1bIOM9kDZayHjJlzHsf3ng=
X-Google-Smtp-Source: AGHT+IH1pvZqy5kiG/39zvD8RP8uhBBEGOPn4DLX46R0z804Zv+Nn6OLROpA/cYcrz2NVQVE76aFeRHCM48z42Gqhs8=
X-Received: by 2002:a17:906:4ca:b0:9a9:f2fd:2a2b with SMTP id
 g10-20020a17090604ca00b009a9f2fd2a2bmr5393442eja.73.1695314160667; Thu, 21
 Sep 2023 09:36:00 -0700 (PDT)
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
 <CAADnVQJO0aVJfV=8RDf5rdtjOCC-=57dmHF20fQYV9EiW2pJ2Q@mail.gmail.com> <4b121c3b96dcc0322ea111062ed2260d2d1d0ed7.camel@gmail.com>
In-Reply-To: <4b121c3b96dcc0322ea111062ed2260d2d1d0ed7.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Sep 2023 09:35:48 -0700
Message-ID: <CAEf4BzbUxHCLhMoPOtCC=6Y-OxkkC9GvjykC8KyKPrFxp6cLvw@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 9:23=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-09-21 at 05:56 -0700, Alexei Starovoitov wrote:
> [...]
> > Now I see that asm matches if (likely(r6 !=3D 42)).
> > I suspect if you use that in C code you wouldn't need to
> > write the test in asm.
> > Just a thought.
>
> Thank you this does change test behavior, however compiler still decides
> to partially unroll the loop for whatever reason. Will stick to asm
> snippets for now.
>
> > Maybe instead of brute forcing all regs to live and precise
> > we can add iter.depth check to stacksafe() such
> > that depth=3D0 !=3D depth=3D1, but
> > depth=3D1 =3D=3D depthN ?
> > (and a tweak to iter_active_depths_differ() as well)
> >
> > Then in the above r7 will be 'equivalent', but fp-8 will differ,
> > then the state with r7=3D-32 won't be pruned
> > and it will address this particular example ? or not ?
>
> This does help for the particular example, however a simple
> modification can still trick the verifier:
>
>      ...
>      r6 =3D bpf_get_current_pid_tgid()
>      bpf_iter_num_new(&fp[-8], 0, 10)
> +    bpf_iter_num_next(&fp[-8])
>      while (bpf_iter_num_next(&fp[-8])) {
>        ...
>      }
>      ...
>
> > Another idea is to add another state.branches specifically for loop bod=
y
> > and keep iterating the body until branches=3D=3D0.
> > Same concept as the verifier uses for the whole prog, but localized
> > to a loop to make sure we don't declare 'equivalent' state
> > until all paths in the loop body are explored.
>
> I'm not sure I understand the idea. If we count branches there always
> would be back-edges leading to new branches. Or do you suggest to not
> prune "equivalent" loop states until all basic blocks in the loop are
> visited? (So that all read marks are propagated and probably all
> precision marks).
>

I've been thinking in a similar direction as Alexei, overnight. Here
are some raw thoughts.

I think the overall approach with iter verification is sound. If we
loop and see an equivalent state at the entry to next loop iteration,
then it's safe to assume doing many iterations is safe. The problem is
that delayed precision and read marks make this state equivalence
wrong in some case. So we need to find a solution that will ensure
that all precision and read marks are propagated to parent state
before making a decision about convergence.

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

We should work out exact details on how to do this hybrid BFS+DFS, but
let's think carefully if this will solve the problems?

I think this is conceptually similar to what Alexei proposed above.
Basically, we "unroll" loop verification iteration by iteration, but
make sure that we explore all the branching within iteration #N before
going one iteration deeper.

Let's think if there are any cases which wouldn't be handled. And then
think how to implement this elegantly (e.g., some sort of queue within
a parent state, which sounds similar to this separate "branches"
counter that Alexei is proposing above).


> I'm still doubt range_within() check for is_iter_next_insn() case but
> can't come up with counter example.

