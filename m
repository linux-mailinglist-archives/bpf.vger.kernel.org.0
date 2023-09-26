Return-Path: <bpf+bounces-10875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC9D7AF013
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 17:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4BCFEB209F6
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B130D15;
	Tue, 26 Sep 2023 15:55:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C230D10
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 15:55:57 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D2121
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 08:55:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ad8a822508so1144344166b.0
        for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695743753; x=1696348553; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4b8H5CuchG/00E/HglxXH60H3ur212WvpPcGDX0Kjso=;
        b=UCSL2f7ew7hxw2HmQQQPgBNlXexng95G1swSeSojBVMxHY9lFO2F88YOYOSAlVk2x+
         +OfciS6WRLbwVyh1i+APBDB6O9DvaBAhw7L3EPhFSdc9CLJpO+yyJ/JIsZ6alUFtHATg
         sLAJg2LvlJxwh5N4+1zkwFuRwm3bFe3lI1EQY2BZ8MG7Yd2ZODPwVrcG9rymBtvwQHkx
         7YeRIj5NQ+XJ5X1FHiktj/YUUvAPb8y3duGj9NAllTI9qP5mCp5DhUsYBPrbMmwtNhq3
         nM/+7nPg8arOdXogby1EFqNytd5ueq6VbTGas9PwULx03dYLyJ+8hNZIblgQMB9Veb4s
         3dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695743753; x=1696348553;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4b8H5CuchG/00E/HglxXH60H3ur212WvpPcGDX0Kjso=;
        b=sk/MmcrqXLpxsi6gziI2siKzLR9XnsCKnN5pHFd9wRQyY4KXzbdqlMXKyXJPk2LJvB
         twolxS6++76QMuvZ/kuZDxrbFw19STFQki5j9/KxxI/Zn/k5ElSSTLJKDkFN0xXuZWZ5
         i+bmKmM9tiezl8W5RuCWobKnW2gZLE0ITX3fI9vHl/BQxFd5KCkRdDPgTtZzy1O9xSpF
         UBj4k90EdRnAFs7+zE8jfypfIJfyt/99v9uJ5bvxQAAauqMiRmkNe+65l9MQ7t5TqSAs
         ff8TgFJmgGL/oAuOzLVuJ4Uv8mJfoC51dkFWGSfO3SMMaH3obOMu2/VpDPFZvpqfzlqK
         KHkg==
X-Gm-Message-State: AOJu0Yz9jrvqySexoUFOm0699/af2OmcR7Vz8YIEH7jZeAYk9f+ommC4
	2WNG78wzQI1WZdbuUnJpbNs=
X-Google-Smtp-Source: AGHT+IHRzKe4XjIn0iz6KxOgRaMvDIBn+te+BTVfF553EqYPho9xCmQq23q2qNtEv/3Hz/DHeeWrIw==
X-Received: by 2002:a17:906:51dd:b0:9ae:62ec:f4a1 with SMTP id v29-20020a17090651dd00b009ae62ecf4a1mr8518681ejk.33.1695743753059;
        Tue, 26 Sep 2023 08:55:53 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id sa21-20020a170906edb500b009add084a00csm7894678ejb.36.2023.09.26.08.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:55:52 -0700 (PDT)
Message-ID: <ca9ac095cf1b3fff55eea8a3c87670a349bbfbcf.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 26 Sep 2023 18:55:50 +0300
In-Reply-To: <CAEf4BzZU0MxwLfz-dGbmHbEtqVhEMTxwSG+QfwCuCv09CqLcNw@mail.gmail.com>
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

On Mon, 2023-09-25 at 17:33 -0700, Andrii Nakryiko wrote:
[...]
> not working for this intermixed iterator case would be ok, I think
> most practical use cases would be a properly nested loops.
>=20
> But, compiler can actually do something like even for a proper loop.
> E.g., something like below
>=20
> for (; bpf_iter_num_next(&it); ) {
>    ....
> }
>=20
> in assembly could be layed out as
>=20
>=20
> bpf_iter_num_next(&it);
> ...
> again:
> r0 =3D bpf_iter_num_next(&it)
> ...
> if (r0) goto again
>=20
>=20
> Or something along those lines. So these assumptions that the
> iterator's next() call is happening at the same instruction is
> problematic.

For the specific example above I think it would not be an issue
because there is still only one next() call in the loop =3D>
there would be no stalled next() transition states.

I checked disassembly for progs/iters.c and it appears that for each
program there compiler preserves nested loops structure such that:
- each loop is driven by a single next() call of a dedicated iterator;
- each nested loop exit goes through destroy() for corresponding
  iterator, meaning that outer loop's next will never see inner's loop
  iterator as active =3D> no stalled states due to inner loop
  processing.

Of-course, I'm not a robot and might have missed something that would
break real implementation.
=20
> > Option B. "Widening"
> > --------------------
> >=20
> > The trivial fix for current .branches > 0 states comparison is to
> > force "exact" states comparisons for is_iter_next_insn() case:
> > 1. Ignore liveness marks, as those are not finalized yet;
> > 2. Ignore precision marks, as those are not finalized yet;
> > 3. Use regs_exact() for scalars comparison.
> >=20
> > This, however, is very restrictive as it fails to verify trivial
> > programs like (iters_looping/simplest_loop):
> >=20
> >     sum =3D 0;
> >     bpf_iter_num_new(&it, 0, 10);
> >     while (!(r0 =3D bpf_iter_num_next()))
> >       sum +=3D *(u32 *)r0;
> >     bpf_iter_num_destroy(&it);
> >=20
> > Here ever increasing bounds for "sum" prevent regs_exact() from ever
> > returning true.
> >=20
> > One way to lift this limitation is to borrow something like the
> > "widening" trick from the abstract interpretation papers mentioned
> > earlier:
> > - suppose there is current state C and a visited is_iter_next_insn()
> >   state V with .branches > 0;
> > - suppose states_equal(V, C) returns true but exact states comparison
> >   returns false because there are scalar values not marked as precise
> >   that differ between V and C.
> > - copy C as C' and mark these scalars as __mark_reg_unbounded() in C';
> > - run verification for C':
> >   - if verification succeeds -- problem solved;
> >   - if verification fails -- discard C' and proceed from C.
> >=20
> > Such algorithm should succeed for programs that don't use widened
> > values in "precise" context.
> >=20
> > Looking at testcases failing with trivial fix I think that such
> > limitations would be similar to those already present (e.g. the big
> > comment in progs/iters.c:iter_obfuscate_counter would still apply).
> >=20
>=20
> This makes sense. I was originally thinking along those lines (and
> rejected it for myself), but in a more eager (and thus restrictive)
> way: for any scalar register where old and new register states are
> equivalent thanks to read mark or precision bit (or rather lack of
> precision bit), force that precision/mark in old state. But that is
> too pessimistic for cases where we truly needed to simulate N+1 due to
> state differences, while keeping the old state intact.

In other words there is a function states_equal' for comparison of
states when old{.branches > 0}, which differs from states_equal in
the following way:
- considers all registers read;
- considers all scalars precise.

> What you propose with temporary C -> C' seems to be along similar
> lines, but will give "a second chance" if something doesn't work out:
> we'll go on N+1 instead of just failing.

Right.

> But let's think about this case. Let's say in V R1 is set to 7, but
> imprecise. In C we have R1 as 14, also imprecise. According to your
> algorithm, we'll create C1 with R1 set to <any num>. Now I have two
> questions:
>=20
> 1. How do we terminate C' validation? What happens when we get back to
> the next() call again and do states_equal() between V and C'? We just
> assume it's correct because C' has R1 as unbounded?

For the definition above states_equal'(V, C') is false, but because we
are at checkpoint on the next iteration we would get to
states_equal'(C', C'') where C'' is derived from C' and same rules
would apply. If we are lucky nothing would change and there would no
point in scheduling another traversal.

> 2. Assuming yes. What if later on, V's R1 is actually forced to be
> precise, so only if V's R1=3DP7, then it is safe. But we already
> concluded that C' is safe based on R1 being unbounded, right? Isn't
> that a violation?

My base assumption is that:
1. any instruction reachable from V should also be reachable from C';
2. and that it is also guaranteed to be visited from C'.
I cannot give a formal reasoning for (2) at the moment.

In case if this assumption holds, when verification proceeds from C'
it would eventually get to instruction for which R1 value is only safe
when R1=3D7, if so:
- verification of C' conjecture would fail;
- all states derived from C' would need to be removed from
  states stack / explored states;
- verification should proceed from C.
(And there is also a question of delaying read/precision propagation
 from unproven conjecture states to regular states).

(Also I'm still not sure whether to use regs_exact() for scalars
 comparison instead of precision logic in states_equal').

