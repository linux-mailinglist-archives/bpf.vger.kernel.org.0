Return-Path: <bpf+bounces-11283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB017B6D38
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 17:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F3433281509
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA82B36AF1;
	Tue,  3 Oct 2023 15:33:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FBC328DF
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 15:33:54 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68190AB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 08:33:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5044dd5b561so1265206e87.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696347230; x=1696952030; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F8xIQzJty4+9K8/+BMP+c0isEPX6YD2aMBdd/lN9Zmo=;
        b=AqJaWO8fE7/y7/MaMnAwAGIMlj4a3LjjYLYDBoGvlgcYjXTbLhJzR/uK8/Eu1FYrlo
         pKESWWz6XKf8SLm8oAsU0AfvEj8oTLWvW9ame1RYjaRjw2gVyRwoH8MtNzH3WrRm9C3F
         72PNIl1F1fFsBrbesZTIre0ZOMG7Eih9s6Ywhr7h04hlGySUl94uIjeVJ45m0j0/u/iE
         NmjEqzpWvxb5RVnignZ8JllizP449qH41ns0DxrN4uKduuzKWdMKosQAPWFgWiF/+cFQ
         QOtdrEUgBCsgOe2zBg2hlPUolbHb22/4MoGMCP1omqbMjVNOuJvmPdxmLI7wOqkjVdOc
         UuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696347230; x=1696952030;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8xIQzJty4+9K8/+BMP+c0isEPX6YD2aMBdd/lN9Zmo=;
        b=saXD40nIsJwJKe1SNqccp3xxNWCmVfBCTK54kUjxDYWY+EckpGAsw1JjjJZc/ELupc
         pHYgKtvZexYS7gCUVYXOmWZcTg7h3t6ZNi7ak7WYw+psHT2kIWkpn+mhCLqbg04VpxG7
         DYQqaidtQ0iNHOLosnAllApcmaZkNsBGxSM7wOgzEkwR5zc3y6A1otfdAEyesSIb32Zs
         9oC5Jauu3eAKKxJ/YoJJ9+3Fj1exE2hgj0PnewiaZvIo1Xe0EN3IRGrMs3sstX4EiWD0
         FjPmli+W7LPGaA7nILgc6azrCunqfqWLJwRYhGMo1et4uCswxYeT9jrDuMbVSVWpzGSO
         BY4Q==
X-Gm-Message-State: AOJu0YzH7StoIf/GmZXUjpuwBfGTE+oWrJdM9NYAcZ3H3EsnUv9i66Ue
	X022ZFzwcQDThQS21a8E4ci4NIB7mBrSLza1
X-Google-Smtp-Source: AGHT+IF3jNCBVqazF/odZduYj2zSj8EC7i2Po5Ug/J1jJi6HokKEcJnSoem1643WUErIc1LKULar4g==
X-Received: by 2002:a05:6512:4019:b0:502:d84d:e893 with SMTP id br25-20020a056512401900b00502d84de893mr14709082lfb.36.1696347230124;
        Tue, 03 Oct 2023 08:33:50 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a8-20020ac25208000000b004fe461aab36sm225636lfl.129.2023.10.03.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:33:49 -0700 (PDT)
Message-ID: <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 03 Oct 2023 18:33:48 +0300
In-Reply-To: <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
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

On Mon, 2023-10-02 at 17:05 -0700, Alexei Starovoitov wrote:
[...]
> > Consider that we get to the environment state where:
> > - all env->head states are exhausted;
> > - all potentially looping states (stored in as a separate set of
> >   states instead of env->head) are states_equal() to some already
> >   explored state.
> >=20
> > I argue that if such environment state is reached the program should
> > be safe, because:
> > - Each looping state L is a sub-state of some explored state V and
> >   every path from V leads to either safe exit or another loop.
> > - Iterator loops are guaranteed to exit eventually.
>=20
> It sounds correct, but I don't like that the new mechanism
> with two stacks of states completely changes the way the verifier works.
> The check you proposed:
> if (env->stack_size !=3D 0)
>       push_iter_stack()
> rings alarm bells.
>=20
> env->stack_size =3D=3D 0 (same as env->head exhausted) means we're done
> with verification (ignoring bpf_exit in callbacks and subprogs).
> So above check looks like a hack for something that I don't understand ye=
t.
> Also there could be branches in the code before and after iter loop.
> With "opportunistic" states_equal() for looping states and delayed
> reschedule_loop_states() to throw states back at the verifier
> the whole verification model is non comprehensible (at least to me).
> The stack + iter_stack + reschedule_loop_states means that in the followi=
ng:
> foo()
> {
>   br1 // some if() {...} block
>   loop {
>     br2
>   }
>   br3
> }
>=20
> the normal verifier pop_stack logic will check br3 and br1,
> but br2 may or may not be checked depending on "luck" of states_equal
> and looping states that will be in iter_stack.
> Then the verifier will restart from checking loop-ing states.
>
> If they somehow go past the end of the loop all kinds of things go crazy.
> update_branch_counts() might warn, propagate_liveness, propagate_precisio=
n
> will do nonsensical things.

When I put states to the loop stack I do copy_verifier_state() and
increase .branches counter for each state parent, so this should not
trigger warnings with update_branch_counts(). Logically, any state
that has a loop state as it's grandchild is not verified to be safe
until loops steady state is achieved, thus such states could not be
used for states pruning and it is correct to keep their branch
counters > 0.

propagate_liveness() and propagate_precision() should not be called
for the delayed states (work-in-progress I'll update the patch).
Behavior for non-delayed states should not be altered by these changes.

> This out-of-order state processing distorts the existing model so
> much that I don't see how we can reason about these two stacks verificati=
on.

Iterators (and callbacks) try to diverge from regular verification
logic of visiting all possible paths by making some general
assumptions about loop bodies. There is no way to verify safety of
such bodies w/o computing steady states.

> I think the cleaner solution is to keep current single stack model.
> In the above example the verifier would reach the end, then check br3,
> then check br2,
> then we need to split branches counter somehow, so that we can
> compare loop iter states with previous visited states that are known
> to be safe.
> In visited states we explored everything in br3 and in br2,
> so no concerns that some path inside the loop or after the loop
> missed precision or liveness.
>
> Maybe we can split branches counter into branches due to 'if' blocks
> and branches due to process_iter_next_call().
> If there are pending process_iter_next_call-caused states it's still
> ok to call states_equal on such visited states.

Using a stack forces DFS states traversal, if there is a loop state
with branching this is prone to infinite nesting, e.g.:

  0. // Complete assembly code is in the end of the email.
  1. while (next(i)) {
  2.   if (random())
  3.     continue;
  4.   r0 +=3D 0;
  5. }

Would lead to an infinite loop when using the patch shared in [1].
At (2) verifier would always create a state with {.loop_state=3Dfalse},
thus checkpoint state at (1) would always have
`sl->branches !=3D sl->state.looping_states`:
- looping state is current one,
- non-looping state is the "else" branch scheduled in (2).
Therefore checkpoint in (1) is not eligible for pruning and verifier
would eagerly descend via path 1,2,3,1,2,3,...

I don't think this is a quirk of the patch, with only a single stack
there are no means to postpone exploration.

Note, that removal of `elem->st.looping_state =3D false;` from
push_stack() is not safe either, precision marks and unsafe values
could be concealed in nested iteration states as shown in example [2],
so we are risking pruning some states too early.

[1] https://lore.kernel.org/bpf/CAADnVQJ3=3Dx8hfv7d29FQ-ckzh9=3DMXo54cnFShF=
p=3DeG0fJjdDow@mail.gmail.com/T/#m8fc0fc3e338f57845f9fb65e0c3798a2ef5fb2e7
[2] https://lore.kernel.org/bpf/CAADnVQJ3=3Dx8hfv7d29FQ-ckzh9=3DMXo54cnFShF=
p=3DeG0fJjdDow@mail.gmail.com/T/#m6014e44a00ab7732890c13b83b5497f8d856fc81

---

In theory, loops steady state does not have to be tracked globally it
can be tracked per some key states, e.g. entry states for top-level loops:
- at the entry state E for a top level loop:
  - establish a separate regular and loop state stacks: E.stack, E.loop_sta=
ck;
  - add E to explored states as a checkpoint and continue verification
    from E' a copy of E (at this point E branches counter is > 0);
- in is_state_visited() / .branches > 0 / is_bpf_next_insn():
  - only consider current state C for states_equal(V, C) if V and C
    have a common grandparent E;
  - use E.loop_stack to delay C;
- use same logic for steady state as before:
  - E.stack should be exhausted;
  - states in E.loop_stack should all be states_equal() to some
    explored state V that has E as it's grandparent.
- if such steady state is achieved E's loop states could be dropped
  and branches counter for E could be set to 0, thus opening it up for
  regular states pruning.
 =20
Such logic would make verification of loops more similar to
verification of regular conditionals, e.g.:

  foo() {
    if (random()) {
      r0 =3D 0;  // branch B1
    } else {
      r0 =3D 42; // branch B2
    }
    i =3D iter_new();
    // loop entry E
    while (iter_next()) {
      // loop body LB
      do_something();
    }
  }

Here verifier would first visit path B1,E,LB, second visit to LB would
be delayed and steady state for E would be declared, E.branches would
be set to 0. Then path B1,E would be visited and declared safe as E is
eligible for states pruning.

This gives more opportunities for states pruning and makes user's
reasoning about iterators verification similar to user's reasoning
about regular loops verification.
But it adds some more complexity to the implementation
(albeit, I think it's not much, env->head becomes a stack of stacks
 and a few other tweaks).

---

SEC("?raw_tp")
__success
__naked int loop1(void)
{
 	asm volatile (
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"r2 =3D 0;"
		"r3 =3D 10;"
		"call %[bpf_iter_num_new];"
	"loop_%=3D:"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"call %[bpf_iter_num_next];"
		"if r0 =3D=3D 0 goto loop_end_%=3D;"
		"call %[bpf_get_prandom_u32];"
		"if r0 !=3D 42 goto loop_%=3D;"
		"r0 +=3D 0;"
		"goto loop_%=3D;"
	"loop_end_%=3D:"
		"r1 =3D r10;"
		"r1 +=3D -8;"
		"call %[bpf_iter_num_destroy];"
		"r0 =3D 0;"
		"exit;"
		:
		: __imm(bpf_get_prandom_u32),
		  __imm(bpf_iter_num_new),
		  __imm(bpf_iter_num_next),
		  __imm(bpf_iter_num_destroy)
		: __clobber_all
	);
}

