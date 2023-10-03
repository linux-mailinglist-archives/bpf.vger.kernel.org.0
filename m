Return-Path: <bpf+bounces-11314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D997B7389
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 23:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1AEA0281346
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC703D992;
	Tue,  3 Oct 2023 21:52:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1A3D3BF
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 21:52:13 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B122A1
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 14:52:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so1645848e87.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696369929; x=1696974729; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KvMi7fQJymeBC0ZVXu8IfR0drKrF4YOv2pRnGe31Z1I=;
        b=Y+M8DiloLD83IDSM6Y7YU+ypFa7mFDBMF3E1TreQP/XgBXoTseCh+JksZIOr83IAU5
         9R7euO6l1oK06BDzL9u+3EMgp2ku/M5KyZmgphuNuxIR5izjz+9wttrpHbrjhEInJYQG
         uzA+wLWHORTgPepr8G1e5kxgj9M0l+CJf6ad2st3D4qT7CUAH4xVNPYlgMd9LrifL1Uy
         /7VyAiThPe6oH5GrkSjrOWkS+dohjj1keo6RHOdLP6eyDGOrmGZ736xNebCjFX4A0Dge
         3sUPE2q1v23e8FdK3k4CRqLsOexX5L2Vy0Q0H+q9dC/KM5drlTTm0V1WgyEa7ZK0eBMH
         0aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696369929; x=1696974729;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvMi7fQJymeBC0ZVXu8IfR0drKrF4YOv2pRnGe31Z1I=;
        b=TIydlHQKBIIpV10G0vGNCEevEhw8/QP9cV9mdZAIS7YILWzbCNmmffoCDJSxomvcXm
         ZsES16DSc6oNp9G+AVlQZTEkZFrSxNbW/hzuMQ4BmYExjdAGi6cmuagYDc+R+Ci4vpap
         OYg9dFYqp8l80okRmq5oyAzrElFUAYN5UwjmwepNvUvoEt8RqhhA8BODT9wc1O7zdkz8
         GA0AVhe6fNot9ve6VHeb1mL650K6LNRhfAuDjY8UV8Zovt300iZ3BVTHLNzJGv8ZE2zZ
         NFU/ypK4o6Z3DJf4Ka6+kFD53Py4KG5W/jloQUQM4N7j12AZvVNKx6sX7BcNaMblQnjW
         yazQ==
X-Gm-Message-State: AOJu0YyWYvz7cowOAOcWMhdH3anfsRCImve/viUklwPdCjvECvXuz0zm
	waOL3bP0DqABU805vSoR4Ug=
X-Google-Smtp-Source: AGHT+IGlpT4feWDTzQa1KIqnutCuQg63bdHq7y9EVKQD5O9hhKts84F+iiDJr5n6gLSfcIGr7hLx+g==
X-Received: by 2002:a05:6512:3ca4:b0:500:b5db:990b with SMTP id h36-20020a0565123ca400b00500b5db990bmr468959lfv.47.1696369929073;
        Tue, 03 Oct 2023 14:52:09 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l8-20020ac24308000000b004fe10276bbfsm330778lfh.296.2023.10.03.14.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:52:08 -0700 (PDT)
Message-ID: <5b7f4b6199decf266a9218b674c232662ed13db5.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 04 Oct 2023 00:52:07 +0300
In-Reply-To: <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
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
	 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
	 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
	 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
	 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
	 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
	 <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
	 <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
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

On Tue, 2023-10-03 at 11:50 -0700, Alexei Starovoitov wrote:
> On Tue, Oct 3, 2023 at 8:33=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > When I put states to the loop stack I do copy_verifier_state() and
> > increase .branches counter for each state parent, so this should not
> > trigger warnings with update_branch_counts().
>=20
> No warn doesn't mean it's correct.
> I suspect what your reschedule_loop_states() will increase
> branches from 0 to 1.
> Which is equivalent to increasing refcnt from zero. Not good.

Not really, here is how I modified bpf_verifier_env:

    struct bpf_verifier_state_stack {
        struct bpf_verifier_stack_elem *head; /* stack of verifier states t=
o be processed */
        int size;                             /* number of states to be pro=
cessed */
    };
   =20
    struct bpf_verifier_env {
        ...
        struct bpf_verifier_state_stack stack;
        struct bpf_verifier_state_stack loop_stack;
        ...
    }

Here env->stack is used for DFS traversal and env->loop_stack is used
to delay verification of the loop states.

When bpf_iter_next() is reached in state C and states_equal() shows
that there is potentially equivalent state V:
- copy C' of C is created sing copy_verifier_state(), it updates all
  branch counters up the ownership chain as with any other state;
- C' is put to env->loop_stack.

The reschedule_loop_states() [1] loops over states in loop_stack to
see if there are states that no longer have equivalent state, such
states are removed from env->loop_stack and put to env->stack.
This is done without branch counters update, so at any point in time
parent states have loop state accounted for in their branch counters.
Branch counter *never* transitions from 1 to 0 and than to 1 again
during this process.

[1] https://github.com/kernel-patches/bpf/compare/bpf-next_base...eddyz87:b=
pf:iters-bug-delayed-traversal#diff-edbb57adf10d1ce1fbb830a34fa92712fd01db1=
fbd9b6f2504001eb7bcc7b9d0R16823

> > Logically, any state
> > that has a loop state as it's grandchild is not verified to be safe
> > until loops steady state is achieved, thus such states could not be
> > used for states pruning and it is correct to keep their branch
> > counters > 0.
>=20
> Correct.
>
> > propagate_liveness() and propagate_precision() should not be called
> > for the delayed states (work-in-progress I'll update the patch).
> > Behavior for non-delayed states should not be altered by these changes.
>=20
> I disagree. Delayed states should not have different propagation rules.

Upon first discovery the loop state C is states_equal to some state V,
precision and read marks are not yet finalized and thus states_equal(V, C)
become false at some point. Also, C should not be used for states pruning.
Thus, there is no need to propagate liveness and precision from V to C
at this point.

It is possible and correct to propagate liveness and precision from V
to C when loop steady state is achieved, as at that point we know for
sure that C is a sub-state of V. However, currently loop states are
tracked globally and no states are processed after loops steady state
is reached, hence I don't do liveness and precision propagation.

On the other hand, if loop steady state would be tracked non-globally
e.g. for top level loop headers as I wrote in the other email today,
propagation of liveness and precision information would make sense,
as these states could be used for state pruning later.

> Iterators and callbacks should not be special.
> They are no different than bounded loops
> and their verification shouldn't be much different.
> Bounded loops have constant upper bound while
> iterators do not, so they have to converge based on state
> equivalence, but the verifier still has to do DFS and discover
> all possible paths, propagate precision and liveness before
> considering two states equivalent.
> It does this today for bounded loops and should do the same
> for iterators.
> The question is how to do it.
> Delaying states and breaking DFS assumptions is a non starter.

I think that absence of bound is a fundamental difference.

On each verification path of a bounded loop there is always a precise
value that at some point triggers loop termination. There is no need
for states equivalence checks (except for verification performance).

Each verification path of iterator or callback based loop is logically
an infinite series of states. In order to terminate verification of
such path it is necessary to:
- either find some prior state V identical to current state C;
- or find some prior state V such that current state C is a sub-state of V.

Terminating infinite series by identical state turns out to be very
limiting in practice.

On the other hand, sub-state check requires finalization of read and
precision marks in V. We've seen that such marks could be concealed at
an unknown depth. In addition, state V might be a parent state for
multiple grandchildren contributing to precision and read marks.
These grandchildren states are created when conditional jumps are
processed on possibly different iteration depths.

The necessity to visit all grandchildren states of V leads to
necessity of mixed DFS and BFS traversal of the loop states.

(In fact, this is not a special case but a generalization,
 bounded loops processing could be done within the same framework).

> I see now that my 2nd hack is still buggy.
> Differentiating state with branches vs looping_states counters
> doesn't seem to work in all cases.
> Your loop_state_deps1 demonstrates that. It's a great test.

I'm glad this test is useful.

