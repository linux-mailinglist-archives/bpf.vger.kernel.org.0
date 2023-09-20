Return-Path: <bpf+bounces-10420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C957A6FC1
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 02:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9E1C208CB
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 00:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6CC64A;
	Wed, 20 Sep 2023 00:06:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B723193
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 00:06:50 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38530AB
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 17:06:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so721023a12.1
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695168405; x=1695773205; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d7stKDFX12KCw55KHDLgJxBguvBnEeVA49rCOG7CzO4=;
        b=gQ7ui2hxsS4e5z0gAhOtAidYVqqvUYgUkofSOgXI1NRT/hdwds0H3naAdk75eYK/pX
         ZuYdaBK7MF/t9vQ+dASl3sQFuw9LW0pB1kaw2pE1CJM3vAAnKBMxY5NYzAN6P51d/+pA
         cgyMjjBPzPoMmYbX3nBmf+6Q1S4tWrW2orMHNgbKMYYVebTRuhNCAzfvwXytRRQglIWC
         fS0BJlmgbkwc69/cM9km081cbviEJXUB4FdOYNAQlNJ629Uj7DgRG3EBkMtz5Sg0yhsu
         N9k30Ide8PTwgEcWM/zZ43WGqMb8kI68bDuNBc7glm4I4PmOiYl3JDkgH2xn6eqFlLnF
         QG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695168405; x=1695773205;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7stKDFX12KCw55KHDLgJxBguvBnEeVA49rCOG7CzO4=;
        b=eTzWUSWOyX2ZoHV1xDHHmqCC6sSUOMh+iagd3s9IdxAEkK9im67Ti7UY4lpThLxoFR
         LVq/SjXBwyC+DAUprjWsA3p/eD+ZAjg+YOS4Qb/+Iv7F/o5Gu9OvAFnfHWECzxddkHj3
         0p1V5fpKjpUsUhOT8OlihPCf1cloGfdM83iIP71RT+5e8sAEU/P5/O05woFOFXmC3HPD
         YuvCToF8Z2o7tEIDhTx6M7Q4VKy3NpONiDxVYiIPddX9+tMlSN8pADLY2g84++h/cgat
         lB7eMl327eyZjgcOo0ZSe0a6M69PVzmX7ttr7sEpwxvVMalPuNeO6dSRHrSk6SJfDs9G
         CqiQ==
X-Gm-Message-State: AOJu0YyPd6EBJNkTGqF94FrsORI/U874vqlbVE3p3hc8n4atAlLA5NTs
	XT8EkFI44F/Ni/xfxJaqna8=
X-Google-Smtp-Source: AGHT+IEmljH9TA77K+UT6l5Fl+uhuhOVSt6MPykd/J9ufuMJE0E+NvjsqBuHt08YClrOanS62JKrkg==
X-Received: by 2002:a17:906:31da:b0:9ad:f60c:7287 with SMTP id f26-20020a17090631da00b009adf60c7287mr1493888ejf.28.1695168405281;
        Tue, 19 Sep 2023 17:06:45 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906241500b0099b76c3041csm8470315eja.7.2023.09.19.17.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:06:44 -0700 (PDT)
Message-ID: <feb852b58c39fb50e3e5fdd33fa8ddf46bce3a8c.camel@gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner
 <awerner32@gmail.com>, bpf <bpf@vger.kernel.org>, Andrei Matei
 <andreimatei1@gmail.com>, Tamir Duberstein <tamird@gmail.com>, Joanne Koong
 <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, Song Liu
 <song@kernel.org>
Date: Wed, 20 Sep 2023 03:06:43 +0300
In-Reply-To: <CAEf4BzbKV5eHSWk8LgQmCM1vx1N2__ANUbB137i7_7RqBOsTiQ@mail.gmail.com>
References: 
	<CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
	 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
	 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
	 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
	 <CAEf4BzbKV5eHSWk8LgQmCM1vx1N2__ANUbB137i7_7RqBOsTiQ@mail.gmail.com>
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

On Tue, 2023-09-19 at 16:14 -0700, Andrii Nakryiko wrote:
[...]
> > Hi All,
> >=20
> > This issue seems stalled, so I took a look over the weekend.
> > I have a work in progress fix, please let me know if you don't agree
> > with direction I'm taking or if I'm stepping on anyone's toes.
> >=20
> > After some analysis I decided to go with Alexei's suggestion and
> > implement something similar to iterators for selected set of helper
> > functions that accept "looping" callbacks, such as:
> > - bpf_loop
> > - bpf_for_each_map_elem
> > - bpf_user_ringbuf_drain
> > - bpf_timer_set_callback (?)

Hi Andrii, thank you for taking a look.

> As Kumar mentioned, pretty much all helpers with callbacks are either
> 0-1, or 0-1-many cases, so all of them (except for the async callback
> ones that shouldn't be accepting parent stack pointers) should be
> validated.

Yes, makes sense. I need to finish the fix for bpf_loop first, as it
seems as a good representative for many possible issues.

> > The sketch of the fix looks as follows:
> > - extend struct bpf_func_state with callback iterator state information=
:
> >   - active/non-active flag
>=20
> not sure why you need this flag

Note:
  I have a better version of the fix locally but will share it a bit later.
  It actually depends on states_equal() discussion in the sibling thread.

In mu upgraded version I use non-zero depth as an indicator the.
So no separate flag in the end.

> >   - depth
>=20
> yep, this seems necessary
>=20
> >   - r1-r5 state at the entry to callback;
>=20
> not sure why you need this, this should be part of func_state already?

This was a bit tricky but I think I figured an acceptable solution w/o
extra copies for r1-r5. The tricky part is the structure of
check_helper_call():
- collect arguments 'meta' info & check arguments
- call __check_func_call():
  - setup frame for callback;
  - schedule next instruction index to be callback entry;
- reset r1-r5 in caller's frame;
- set r0 in caller's frame.

The problem is that check_helper_call() resets caller's r1-r5
immediately. I figured that this reset could be done at BPF_EXIT
processing for callback instead =3D> no extra copy needed.

> > - extend __check_func_call() to setup callback iterator state when
> >   call to suitable helper function is processed;
>=20
> this logic is "like iterator", but it's not exactly the same, so I
> don't think we should reuse bpf_iter state (as you can see above with
> active/non-active flag, for example)

Yes, I agree, already removed this locally.

> > - extend BPF_EXIT processing (prepare_func_exit()) to queue new
> >   callback visit upon return from iterating callback
> >   (similar to process_iter_next_call());
>=20
> as mentioned above, we should simulate "no callback called" situation
> as well, don't forget about that

Yeap

> > - extend is_state_visited() to account for callback iterator hits in a
> >   way similar to regular iterators;
> > - extend backtrack_insn() to correctly react to jumps from callback
> >   exit to callback entry.
> >=20
> > I have a patch (at the end of this email) that correctly recognizes
> > the bpf_loop example in this thread as unsafe. However this patch has
> > a few deficiencies:
> >=20
> > - verif_scale_strobemeta_bpf_loop selftest is not passing, because
> >   read_map_var function invoked from the callback continuously
> >   increments 'payload' pointer used in subsequent iterations.
> >=20
> >   In order to handle such code I need to add an upper bound tracking
> >   for iteration depth (when such bound could be deduced).
>=20
> if the example is broken and really can get out of bounds, we should
> fix an example to be provable within bounds no matter how many
> iterations it was called with

For that particular case number of iterations guarantees that payload
pointer will not get out of bounds. It is bumped up 4 bytes on each
iteration, but the number of iterations and buffer size correlate to
avoid out of bound access.

> > - loop detection is broken for simple callback as below:
> >=20
> >   static int loop_callback_infinite(__u32 idx, __u64 *data)
> >   {
> >       for (;;)
> >           (*ctx)++;
> >       return 0;
> >   }
> >=20
> >   To handle such code I need to change is_state_visited() to do
> >   callback iterator loop/hit detection on exit from callback
> >   (returns are not prune points at the moment), currently it is done
> >   on entry.
>=20
> I'm a bit confused. What's ctx in the above example? And why loop
> detection doesn't detect for(;;) loop right now?

It's an implementation detail for the fix sketch shared in the parent
email. It can catch cases like this:

    ... any insn ...;
    for (;;)
        (*ctx)++;
    return 0;

But cannot catch case like this:

    for (;;)
        (*ctx)++;
    return 0;

In that sketch I jump to the callback start from callback return and
callback entry needs two checks:
- iteration convergence
- simple looping
Because of the code structure only iteration convergence check was done.
Locally, I fixed this issue by jumping to the callback call instruction
instead.

> > - the callback as bellow currently causes state explosion:
> >=20
> >   static int precise1_callback(__u32 idx, struct precise1_ctx *ctx)
> >   {
> >       if (idx =3D=3D 0)
> >           ctx->a =3D 1;
> >       if (idx =3D=3D 1 && ctx->a =3D=3D 1)
> >           ctx->b =3D 1;
> >       return 0;
> >   }
>=20
> why state explosion? there should be a bunch of different branches
> (idx 0, 1, something else x ctx->a =3D 1 or not 1 and ctx->b being 1 or
> not), but it should be a fixed number of states? Do you know what
> causes the explosion?

I forgot to do mark_force_checkpoint() at callback entry. Fixed locally.

>=20
> >=20
> >   I'm not sure yet what to do about this, there are several possibiliti=
es:
> >   - tweak the order in which states are visited (need to think about it=
);
> >   - check states in bpf_verifier_env::head (not explored yet) for
> >     equivalence and avoid enqueuing duplicate states.
> >=20
> > I'll proceed addressing the issues above on Monday.
> >=20
> > Thanks,
> > Eduard
> >=20
> > ---
> >=20
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index a3236651ec64..5589f55e42ba 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -70,6 +70,17 @@ enum bpf_iter_state {
> >         BPF_ITER_STATE_DRAINED,
> >  };
> >=20
> > +struct bpf_iter {
> > +       /* BTF container and BTF type ID describing
> > +        * struct bpf_iter_<type> of an iterator state
> > +        */
> > +       struct btf *btf;
> > +       u32 btf_id;
> > +       /* packing following two fields to fit iter state into 16 bytes=
 */
> > +       enum bpf_iter_state state:2;
> > +       int depth:30;
> > +};
> > +
> >  struct bpf_reg_state {
> >         /* Ordering of fields matters.  See states_equal() */
> >         enum bpf_reg_type type;
> > @@ -115,16 +126,7 @@ struct bpf_reg_state {
> >                 } dynptr;
> >=20
> >                 /* For bpf_iter stack slots */
> > -               struct {
> > -                       /* BTF container and BTF type ID describing
> > -                        * struct bpf_iter_<type> of an iterator state
> > -                        */
> > -                       struct btf *btf;
> > -                       u32 btf_id;
> > -                       /* packing following two fields to fit iter sta=
te into 16 bytes */
> > -                       enum bpf_iter_state state:2;
> > -                       int depth:30;
> > -               } iter;
> > +               struct bpf_iter iter;
>=20
> Let's not do this, conceptually processes are similar, but bpf_iter is
> one thing, and this callback validation is another thing. Let's not
> conflate things.
>=20
> >=20
> >                 /* Max size from any of the above. */
> >                 struct {
>=20
> [...]


