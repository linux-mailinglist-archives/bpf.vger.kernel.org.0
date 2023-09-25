Return-Path: <bpf+bounces-10726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12E77ACD5F
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 03:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 752702813BE
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A86A29;
	Mon, 25 Sep 2023 01:02:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4A811
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 01:02:05 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77173C4
	for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 18:02:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ad8a822508so646515466b.0
        for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 18:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695603721; x=1696208521; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EjR1OavIxnpWMptijEYVG9t1BxqNq4P4PykOD2eIvus=;
        b=N+0jXI0eFiKHAYT1VS/7xUAOamRKeitfvQO5OdIQRJ6+01cbVLByDmnQJvhmhQgntJ
         1Ehq9/AQjbLukCJz0mtYHMeP8UkjE/83PL1uSw4Uof13C8WfBBxmafudTsfRIUhf7Zs3
         847vasH2hL+zLbP+MMuXGXQayB+WcvnFld+fKDgBQMQyjqgm2Pn/A7VrNV1I5zb26Cxc
         f+oXn1UAcKR3rkMVCwh7n3/SXxcUGMHDkm1DHbdET6G9D9Z3wxtg+QjmTBhSqoga8ix2
         l+pJF1AStEku5VNO1E9BqsLJW/yGkYYnw7Pfn5FzkSsQF/w3bRcWgvgN0VNxKfVBPm8z
         nVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695603721; x=1696208521;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjR1OavIxnpWMptijEYVG9t1BxqNq4P4PykOD2eIvus=;
        b=bIhaG/nqUNBEuO5TO36jlRYqYiy55o1K4VjsJoVFrELORChvmYmWoVFC36dtLZuLLg
         JbF5/Pa4PDMQPsL0fQkzWnqLtkrK1JarQUygyPikx79zXv/THG5yTHmCvpihLHLtsgBE
         2fGahynN6jL8pHCx5sqqkaHV2AgqLkmFZlHCQlqQgFo+mqBV/lvqW1Fq/Onskrsid3Gi
         TDeAEZlIyCZp7UXte33idxRamvaI3ijg3OHW1NMrLQwwVyYMn2huKXLeuFRlesX9x+nI
         YTjE15cQlrXcVugeyOQ1x+6Vr5F4aEFkjpbWqAkaEszb+hiIm6tFJALEgcNketPCRTAt
         w7Iw==
X-Gm-Message-State: AOJu0Yy1BqDlKLBr9Vz9AEiqO3C4x3/HDhyQvT18cPgcleFkX5CxU6kh
	xZNSd7jAVUKLCX5ODVPD70M=
X-Google-Smtp-Source: AGHT+IEPtWPBlQf5yZUGOQk27NAaBEIyuh/hk9HyGPZXZGDycQ6PBpfBNZUZpcuiNntdAJO7iep4lA==
X-Received: by 2002:a17:906:a44d:b0:9a5:d657:47ec with SMTP id cb13-20020a170906a44d00b009a5d65747ecmr3989221ejb.64.1695603720652;
        Sun, 24 Sep 2023 18:02:00 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id dx26-20020a170906a85a00b0099bcd1fa5b0sm5528251ejb.192.2023.09.24.18.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 18:02:00 -0700 (PDT)
Message-ID: <a777445dcb94c0029eb3bd3ddc96ddc493c85ad0.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 25 Sep 2023 04:01:58 +0300
In-Reply-To: <CAEf4BzZ-NGiUVw+yCRCkrPQbJAS4wMBsT3e=eYVMuintqKDKqg@mail.gmail.com>
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
	 <ec118c24a33fb740ecaafd9a55416d56fcb77776.camel@gmail.com>
	 <CAEf4BzZjut_JGnrqgPE0poJhMjJgtJcafRd6Z_0T0jrW3zARJw@mail.gmail.com>
	 <44363f61c49bafa7901ae2aa43897b525805192c.camel@gmail.com>
	 <CAEf4BzZ-NGiUVw+yCRCkrPQbJAS4wMBsT3e=eYVMuintqKDKqg@mail.gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-09-22 at 13:52 -0700, Andrii Nakryiko wrote:
> > > I can't say I understand what exactly you are proposing and how you
> > > are going to determine these conservative precision marks. But I'd
> > > like to learn some new ideas, so please elaborate :)
> >=20
> > I'll send a follow-up email, trying to figure out what to do with point=
ers.
>=20
> Ok, sounds good.

(below explains why DFA was a bad idea, please proceed to the next
 section if that's not interesting).

My initial thought was that it would be possible to use a simple
live-variable DFA in order to compute conservative read and precise
marks. Like a textbook version:
- split code in basic blocks;
- for each instruction propagate liveness information backwards:
  - define USE(insn) to be a set of registers / stack slots read by
    this instruction;
  - define KILL(insn) to be a set of registers / stack slots written
    to by this instruction.
  - compute set of live variables before insn as:
    LIVE_in(insn) =3D USE(insn) U (LIVE_out(insn) / KILL(insn))
- compute basic block BB_out as a union of BB_in of each successor;
- etc... iterate in postorder until fixed point is reached.

However, this is a moot point because of presence of pointers.
For series of instructions like:
  "r1 =3D r10; r1 +=3D -8; r1 =3D *(u64 *)(r1 + 0);"
Such algorithm would need to know possible range of values for r1.
Meaning that before executing liveness DFA some sort of value range
analysis would have to be run.
And these things might get complicated [1]
(I never implemented one, maybe it's not that bad).
So, basically that would be a mini-copy of the verifier but
implemented as a thing that computes fixed point instead of "tracing".
Probably a no-go.

[1] https://boxbase.org/entries/2017/oct/23/range_analysis_papers/

---

However, I think there are two more relatively simple options that
should give correct results.

Option A. "Exit or Loop"
------------------------

- Similar to Andrii's suggestion postpone exploration of
  bpf_iter_*_next() #N->#N+1 states for as long as there are other
  states to explore.
- When evaluating is_state_visited() for bpf_iter_*_next() #N->#N+1
  allow to use visited state with .branches > 0 to prune current
  state if:
  - states_equal() for visited and current states returns true;
  - all verfication paths starting from current instruction index with
    current iterator ref_obj_id either run to safe exit or run back to
    current instruction index with current iterator ref_obj_id.

The last rule is needed to:
- Ensure presence of read and precision marks in a state used for pruning.
- Give a meaning to the precise scalars comparisons in regsafe() which
  I think is currently missing for bpf_iter_*_next() .branches > 0 case.
  Precise scalars comparison for visited states with .branches =3D=3D 0
  could be read as: "using any value from a specific range it is
  possible to reach safe exit".
  Precise scalars comparison for looping states from above
  could be read as: "using any value from a specific range it is
  possible to reach either safe exit or get back to this instruction".

This algorithm should be able to handle simple iteration patterns like:

    bpf_iter_*_new(&it1, ...)
    while (!bpf_iter_*_next(&it1)) { ... }
    bpf_iter_*_destroy(&it1)

And also handle nested iteration:

    bpf_iter_*_new(&it1, ...)
    while (!bpf_iter_*_next(&it1)) {
      bpf_iter_*_new(&it2, ...)
      while (!bpf_iter_*_next(&it2)) { ... }
      bpf_iter_*_destroy(&it2)
    }
    bpf_iter_*_destroy(&it1)

But it would fail to handle more complex patterns, e.g. interleaved
iteration:

    for (;;) {
      if (!bpf_iter_*_next(&it1))  // a
        break;
      if (!bpf_iter_*_next(&it2))  // b
        break;
      ...
    }

For any state originating in (a) there would always be a state in (b)
pending verification and vice versa. It would actually bail out even
if it1 =3D=3D it2.

Option B. "Widening"
--------------------

The trivial fix for current .branches > 0 states comparison is to
force "exact" states comparisons for is_iter_next_insn() case:
1. Ignore liveness marks, as those are not finalized yet;
2. Ignore precision marks, as those are not finalized yet;
3. Use regs_exact() for scalars comparison.

This, however, is very restrictive as it fails to verify trivial
programs like (iters_looping/simplest_loop):

    sum =3D 0;
    bpf_iter_num_new(&it, 0, 10);
    while (!(r0 =3D bpf_iter_num_next()))
      sum +=3D *(u32 *)r0;
    bpf_iter_num_destroy(&it);

Here ever increasing bounds for "sum" prevent regs_exact() from ever
returning true.

One way to lift this limitation is to borrow something like the
"widening" trick from the abstract interpretation papers mentioned
earlier:
- suppose there is current state C and a visited is_iter_next_insn()
  state V with .branches > 0;
- suppose states_equal(V, C) returns true but exact states comparison
  returns false because there are scalar values not marked as precise
  that differ between V and C.
- copy C as C' and mark these scalars as __mark_reg_unbounded() in C';
- run verification for C':
  - if verification succeeds -- problem solved;
  - if verification fails -- discard C' and proceed from C.

Such algorithm should succeed for programs that don't use widened
values in "precise" context.

Looking at testcases failing with trivial fix I think that such
limitations would be similar to those already present (e.g. the big
comment in progs/iters.c:iter_obfuscate_counter would still apply).

---

Option B appears to be simpler to implement so I'm proceeding with it.
Will share progress on Monday. Please let me know if there are any
obvious flaws with what I shared above.

Thanks,
Eduard

