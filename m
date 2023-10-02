Return-Path: <bpf+bounces-11182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F87B4AE9
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 05:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3D8992817BC
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 03:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061B80D;
	Mon,  2 Oct 2023 03:26:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A487E3
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 03:26:12 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF8D9
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 20:26:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso256434861fa.1
        for <bpf@vger.kernel.org>; Sun, 01 Oct 2023 20:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696217168; x=1696821968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8loEKvtgUaf2tQIOHNTpd3jg4NqAefr+7CzPasURB74=;
        b=QWJDBZR0kt+cYRqqScy5AQX4p9wIxUx+D0f2TmBhUV5rPUg7ih2hUBbIirJY3E1+uA
         UO+8BiuZFNoj5NvBxoohOLhxZHxXIddVvvQSeDOjtoJPtMRk3+8Uh1mDmcQ8ok5T6UB/
         ZbJdkrOAC7ihZfoEmuLLiSKgFxKFUPMC7z3mVnwFIdD6/ffCK2eXzTU5NYh5/y3gzDzU
         ZJ97K8TGhbMAjUqGCn7GJtQAxJsAa0rWCJWTQzrG+r/kjTT5lEreif6RkXFqyz/tD0QH
         H6aMzwgt4r0JfZ59oa/0wi4Sc83x4YSG78w6pxr+iV00oRYkVfltpzyfzakA+erHlUJL
         me9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696217168; x=1696821968;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8loEKvtgUaf2tQIOHNTpd3jg4NqAefr+7CzPasURB74=;
        b=rLVpyLeLKLjZU4fZIfqNooOU5EvFu/g4nOyt9zhdrEHZsbwrlOV90UVEu2r4apmVa6
         r9V7TYtUVzh3wdii9GxzjG81MvtMCdo7x/rC7oNCt1VAfGWAm2wDrc3B9uRjusQlX0BA
         EmU3qvDbxzlaEM88F+Y2vsVn8RQl61bVG1s4Vb6g/ZZzMjhlFJqgJw2VDQxYqyn6dEDv
         DLDGKlgkngUR4qCCL7iReytSYXIOgrDv0WVjHr/sLi8cL0EU82HdyCEcyXbSoCgFdRAT
         el1W8LhKRMKMg0d2FjIojcPz5+zj6G5B7IufxUHkOyUvmE4r35iFRKAVn/u03mWXVJ15
         U1lw==
X-Gm-Message-State: AOJu0Yxb+jbYODKTAakp66L42q44f+oaE0IztGwPB7N5Z9kZ6nayaCpb
	RiYDUKNLSR0bjUuVd/H/SbE=
X-Google-Smtp-Source: AGHT+IF/PQ8RCjG8e2qXGnm32GdhJDGy8EsyMbUh9PaxZpCmvxW24biaR4kQ0fXNucj3VuArTKYcGw==
X-Received: by 2002:a2e:99da:0:b0:2b9:f2e8:363 with SMTP id l26-20020a2e99da000000b002b9f2e80363mr8149171ljj.51.1696217167734;
        Sun, 01 Oct 2023 20:26:07 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j8-20020a2e8008000000b002bcc303bbffsm4908916ljg.104.2023.10.01.20.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 20:26:06 -0700 (PDT)
Message-ID: <a60a991079f633955e1e6fcebc4d040c06fea408.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 02 Oct 2023 06:26:04 +0300
In-Reply-To: <CAEf4BzYNpL7OVqCfDCoPfrcJ3pkZo77GS7000pRfGghQf1kn2Q@mail.gmail.com>
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
	 <a777445dcb94c0029eb3bd3ddc96ddc493c85ad0.camel@gmail.com>
	 <CAEf4BzZU0MxwLfz-dGbmHbEtqVhEMTxwSG+QfwCuCv09CqLcNw@mail.gmail.com>
	 <ca9ac095cf1b3fff55eea8a3c87670a349bbfbcf.camel@gmail.com>
	 <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
	 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
	 <CAEf4BzYNpL7OVqCfDCoPfrcJ3pkZo77GS7000pRfGghQf1kn2Q@mail.gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-09-28 at 11:30 -0700, Andrii Nakryiko wrote:
[...]
> > The way I read it the following algorithm should suffice:
> > - add a field bpf_verifier_env::iter_head similar to 'head' but for
> >   postponed looping states;
> > - add functions push_iter_stack(), pop_iter_stack() similar to
> >   push_stack() and pop_stack();
>=20
> I don't like the suggested naming, it's too iter-centric, and it's
> actually a queue, not a stack, etc. But that's something to figure out
> later.

After spending some time I think I figured out an example that shows
that postponed looping states do not form a queue. Please bear with
me, as it is quite large:

    1.  j =3D iter_new();             // fp[-16]
    2.  a =3D 0;                      // r6
    3.  b =3D 0;                      // r7
    4.  c =3D -24;                    // r8
    5.  while (iter_next(j)) {
    6.    i =3D iter_new();
    7.    a =3D 0;
    8.    b =3D 0;
    9.    while (iter_next(i)) {
    10.      if (a =3D=3D 1) {
    11.        a =3D 0;
    12.        b =3D 1;
    13.      } else if (a =3D=3D 0) {
    14.        a =3D 1;
    15.        if (random() =3D=3D 42)
    16.          continue;
    17.        if (b =3D=3D 1) {
    18.          *(r10 + c) =3D 7;
    19.          iter_destroy(i);
    20.          iter_destroy(j);
    21.          return;
    22.        }
    23.      }
    24.    }
    25.    iter_destroy(i);
    26.    a =3D 0;
    27.    b =3D 0;
    28.    c =3D -25;
    29.  }
    30.  iter_destroy(j);
    31.  return;

This example is unsafe, because on second iteration of loop 5-29 the
value of 'c' is -25 (assignment at 28) and 'c' is used for stack
access at 18, offset of -25 is misaligned.
The basic idea is to:
(a) hide the fact that (c) is precise behind a postponed state;
(b) hide the unsafe (c) value behind a postponed state.

The (b) is achieved on first iteration of the loop 5-29:
enter 5 in state with c=3D-24 not precise, 'i' is initially considered
drained thus verification path is 5-9,25-29,5. Upon second visit to 5
the state is postponed because c=3D-24 is considered equal to c=3D-25
(both are not precise).

State at first visit of 5:
  R0=3Dscalar() R1_rw=3Dfp-16 R6=3D0 R7=3D0 R8=3D-24 R10=3Dfp0
  fp-16_r=3Diter_num(ref_id=3D1,state=3Dactive,depth=3D0) refs=3D1

State at second visit of 5 (postponed, let's call it P1):
  R1_w=3Dfp-16 R6=3D0 R7=3D0 R8=3D-25 R10=3Dfp0
  fp-16=3Diter_num(ref_id=3D1,state=3Dactive,depth=3D1) refs=3D1

The (a) is achieved by a series of jumps in the inner loop 9-24:
- first visit of 9 is in state {a=3D0,b=3D0,c=3DXX}
  (here XX is a value of C and it is either -24 or -25, depending on
   outer loop iteration number);
- second visit of 9 is in state {a=3D1P,b=3D0,c=3DXX}
  (path 9,14-16,9; at this point 'a' is marked precise because of predictio=
n at 13);
- third visit of 9 is in state {a=3D0P,b=3D1,c=3DXX}
  (path 9-12,9; 'b' is not yet marked as precise and thus this state
   is equal to the first one and is postponed).
- after this verifier visits 17, predicts condition as false and marks
  'b' as precise, but {a=3D1P,b=3D1,c=3DXX} is already postponed.
 =20
E.g. the following state is postponed at first iteration, let's call it P2:
  R0=3D... R1_w=3Dfp-8 R6=3D0 R7=3D1 R8=3D-24 R10=3Dfp0
  fp-8=3Diter_num(ref_id=3D3,state=3Dactive,depth=3D2)
  fp-16=3Diter_num(ref_id=3D1,state=3Dactive,depth=3D1) refs=3D1,3

If verification were to proceed from state P2 {a=3D0P,b=3D1P,c=3DXX} at 9
the path would be 9,13-14,17-21 and 'c' would be marked as precise.

But if we process postponed states as a queue P1 would be processed
first, 'c' would not have a precision mark yet and P1 would be
discarded =3D> P2 with R8=3D-25 would never be investigated.

I converted this test case to assembly [2] and tried with a
prototype [1] to make sure that I don't miss anything.

---

In general, states form a tree during verification and we want to stop
the tree growth when we see a would be back-edge to a similar state.
Consider the following state graph:

    .---> S1 <---.     Here there is a chain of derived states:
    |     |      |       S1 -> S2 -> S3
    |     v      |
    |     S2 -> S2'    And there are potentially looping states:
    |     |            - S2' (derived from S2, states_equal to S1)
    |     v            - S3' (derived from S3, states_equal to S1)
   S3' <- S3

If we find that S2' is no longer states_equal to S1 it might add a
derivation that would eventually propagate read or precision mark to
some register in S1. Same is true for S3'. Thus there is no clear
order in which S2' and S3' should be processed.

It is possible to imagine more complex state graphs. Unfortunately,
preparing real BPF examples for this graphs is very time consuming
(at-least for me).

Hence, I think that a fixed point computation is necessary as I write
in a sibling email to Alexei:
- Process states from env->head while those are available, in case if
  potential looping state (is_states_equal()) is reached put it to a
  separate queue.
- Once all env->head states are processed the only source for new read
  and precision marks is in postponed looping states, some of which
  might not be is_states_equal() anymore. Submit each such state for
  verification until fixed point is reached (repeating steps for
  env->head processing).

The work-in-progress implementation for this algorithm is in [1].

---

While working on this I found an unexpected interaction with infinite
loop detection for the following test case:

    // any branch
    if (random() > 42)
      a =3D 0;
    else
      a =3D 1;
    // iterator loop
    i =3D iter_new()
    while (iter_next(i))
      // do something

When first branch of 'if' is processed a looping state for 'while' is
added to a postponed states queue. Then second branch of 'if' is
processed and reaches 'iter_new()', at which point infinite loop
detection logic sounds an alarm:

    if (states_maybe_looping(&sl->state, cur) &&
        states_equal(env, &sl->state, cur) &&
        !iter_active_depths_differ(&sl->state, cur) && false) {
        verbose_linfo(env, insn_idx, "; ");
        verbose(env, "infinite loop detected at insn %d\n", insn_idx);
        return -EINVAL;
    }

The state with iter_new() is a parent for a looping state thus has
it's .branches counter as non-zero, and iterator depth is 0 for both
hands of the 'if'.

Adding such states to the looping states queue is not safe, as there
is no guarantee this arbitrary state would terminate (opposed to
iter_next() for which we are guaranteed to have 'drained' branch).
Thus, the only fix that I see now is to disable infinite loop
detection if there are active iterators.

(Might do some trick with remembering this state are printing it if
 instructions limit counter is reached, but I'm not sure if added
 complexity is worth it, e.g. what to do if there are several such
 states?)

---

[1] https://github.com/eddyz87/bpf/tree/iters-bug-delayed-traversal
[2] https://github.com/eddyz87/bpf/blob/iters-bug-delayed-traversal/tools/t=
esting/selftests/bpf/progs/iters.c#L860

Thanks,
Eduard

