Return-Path: <bpf+bounces-10474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5507A899F
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864FC1C20AAD
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219E3E471;
	Wed, 20 Sep 2023 16:38:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FA79EE
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:38:04 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFCCC6
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:38:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so2509507a12.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695227880; x=1695832680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcgJ+kBKoCdOtosFdTHh7Bh15RquvGY2tjHVZ70ZDMI=;
        b=Lvocz/GgyOzKgTIh8iMnkH+j5GjweBaOTizrLAiKu907L2BCTQjNX63evaU7vi/mCe
         7CRR11fg9izErfSXMKrl3MRp0dpxMNZGCW7eN9fhhN6zt4sOcCkN5Re30kFuFZy3u3Zn
         ALvF6lzRmUpeg6Q9c8vmBPYaDLLjE4LnRCyiTVuWbvV3wa4Lsfg5DG5XWRAk9qjMxlvg
         5Q+vfBGOywnsHoc0ZeDkm4C/m8Iu9pZGGR7Mez0MIXyio9fbkqaKGr2mVqXXSxfpa9mh
         ge4fDZM/s/dZDRr0mOLpqEkw52AhvdvguD6Ov9Ss3AhkJEW1zREBSNXNNs3nSLRM9GVa
         ypzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695227880; x=1695832680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcgJ+kBKoCdOtosFdTHh7Bh15RquvGY2tjHVZ70ZDMI=;
        b=rGu2/oOIi3CjN3M8+6pLSibUSKh/nm+a/GdfZG0jHil/if1ouHQ1UCymUQddDB+XTZ
         VQGC918sVq5DE/tSUCxEvynx5yRAcWiYAgfMM/sVH/01q09x23BMqx7CXB+2QkRBId86
         ykNie8DE4GNV+8SBDplPH/ELKoNjBdQhic/I2R7Perd/3TKVhxjI0U6iR62/cnsmW4Iw
         4robzHl2vtAopZZQ+PTesEqKHZ/XWFiZbAkJixCaozWxBvLrA9dWU21VCixsl/HoASQc
         2otu6Hvq+GfdZpWbqw1s/GdtB/n1WuGDAfNiUvX3EgM1pIdxauSEEkdZLG0aPuR5kEWq
         L/0Q==
X-Gm-Message-State: AOJu0YyyRItIRXvfkN49J8oH+B5BpW5m8wg7KkXgNZE6AZo493VhXwzo
	X9Fdwu2GaQt0WTVziyrldS1vG1AEhZgBaQ+o1YQ=
X-Google-Smtp-Source: AGHT+IHn9ttZyVNUPMEu9urkUMhCnpLHrAzs1xyeoKLR7EX8zuAj5DdMB89Po69eIl0ARPS9odI8j4bctrke0eplEgw=
X-Received: by 2002:a17:907:36c9:b0:9a9:405b:26d1 with SMTP id
 bj9-20020a17090736c900b009a9405b26d1mr8397148ejc.5.1695227880016; Wed, 20 Sep
 2023 09:38:00 -0700 (PDT)
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
 <CAEf4BzbKV5eHSWk8LgQmCM1vx1N2__ANUbB137i7_7RqBOsTiQ@mail.gmail.com> <feb852b58c39fb50e3e5fdd33fa8ddf46bce3a8c.camel@gmail.com>
In-Reply-To: <feb852b58c39fb50e3e5fdd33fa8ddf46bce3a8c.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Sep 2023 09:37:48 -0700
Message-ID: <CAEf4Bzb-bauJ-gSVdUJdDHzFwOnGNwA4ee9OhYnq1D5sAGhDSw@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 5:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-09-19 at 16:14 -0700, Andrii Nakryiko wrote:
> [...]
> > > Hi All,
> > >
> > > This issue seems stalled, so I took a look over the weekend.
> > > I have a work in progress fix, please let me know if you don't agree
> > > with direction I'm taking or if I'm stepping on anyone's toes.
> > >
> > > After some analysis I decided to go with Alexei's suggestion and
> > > implement something similar to iterators for selected set of helper
> > > functions that accept "looping" callbacks, such as:
> > > - bpf_loop
> > > - bpf_for_each_map_elem
> > > - bpf_user_ringbuf_drain
> > > - bpf_timer_set_callback (?)
>
> Hi Andrii, thank you for taking a look.
>
> > As Kumar mentioned, pretty much all helpers with callbacks are either
> > 0-1, or 0-1-many cases, so all of them (except for the async callback
> > ones that shouldn't be accepting parent stack pointers) should be
> > validated.
>
> Yes, makes sense. I need to finish the fix for bpf_loop first, as it
> seems as a good representative for many possible issues.

yes, it's the most generic 0-1-many case

>
> > > The sketch of the fix looks as follows:
> > > - extend struct bpf_func_state with callback iterator state informati=
on:
> > >   - active/non-active flag
> >
> > not sure why you need this flag
>
> Note:
>   I have a better version of the fix locally but will share it a bit late=
r.
>   It actually depends on states_equal() discussion in the sibling thread.
>
> In mu upgraded version I use non-zero depth as an indicator the.
> So no separate flag in the end.

great

>
> > >   - depth
> >
> > yep, this seems necessary
> >
> > >   - r1-r5 state at the entry to callback;
> >
> > not sure why you need this, this should be part of func_state already?
>
> This was a bit tricky but I think I figured an acceptable solution w/o
> extra copies for r1-r5. The tricky part is the structure of
> check_helper_call():
> - collect arguments 'meta' info & check arguments
> - call __check_func_call():
>   - setup frame for callback;
>   - schedule next instruction index to be callback entry;
> - reset r1-r5 in caller's frame;
> - set r0 in caller's frame.
>
> The problem is that check_helper_call() resets caller's r1-r5
> immediately. I figured that this reset could be done at BPF_EXIT
> processing for callback instead =3D> no extra copy needed.
>

I guess then r0 setting would have to happen at BPF_EXIT as well,
right? Is that a problem?

> > > - extend __check_func_call() to setup callback iterator state when
> > >   call to suitable helper function is processed;
> >
> > this logic is "like iterator", but it's not exactly the same, so I
> > don't think we should reuse bpf_iter state (as you can see above with
> > active/non-active flag, for example)
>
> Yes, I agree, already removed this locally.

cool

>
> > > - extend BPF_EXIT processing (prepare_func_exit()) to queue new
> > >   callback visit upon return from iterating callback
> > >   (similar to process_iter_next_call());
> >
> > as mentioned above, we should simulate "no callback called" situation
> > as well, don't forget about that
>
> Yeap
>
> > > - extend is_state_visited() to account for callback iterator hits in =
a
> > >   way similar to regular iterators;
> > > - extend backtrack_insn() to correctly react to jumps from callback
> > >   exit to callback entry.
> > >
> > > I have a patch (at the end of this email) that correctly recognizes
> > > the bpf_loop example in this thread as unsafe. However this patch has
> > > a few deficiencies:
> > >
> > > - verif_scale_strobemeta_bpf_loop selftest is not passing, because
> > >   read_map_var function invoked from the callback continuously
> > >   increments 'payload' pointer used in subsequent iterations.
> > >
> > >   In order to handle such code I need to add an upper bound tracking
> > >   for iteration depth (when such bound could be deduced).
> >
> > if the example is broken and really can get out of bounds, we should
> > fix an example to be provable within bounds no matter how many
> > iterations it was called with
>
> For that particular case number of iterations guarantees that payload
> pointer will not get out of bounds. It is bumped up 4 bytes on each
> iteration, but the number of iterations and buffer size correlate to
> avoid out of bound access.

ok, good, I was trying to avoid deducing bounds on the number of
iterations or anything like that.

>
> > > - loop detection is broken for simple callback as below:
> > >
> > >   static int loop_callback_infinite(__u32 idx, __u64 *data)
> > >   {
> > >       for (;;)
> > >           (*ctx)++;
> > >       return 0;
> > >   }
> > >
> > >   To handle such code I need to change is_state_visited() to do
> > >   callback iterator loop/hit detection on exit from callback
> > >   (returns are not prune points at the moment), currently it is done
> > >   on entry.
> >
> > I'm a bit confused. What's ctx in the above example? And why loop
> > detection doesn't detect for(;;) loop right now?
>
> It's an implementation detail for the fix sketch shared in the parent
> email. It can catch cases like this:
>
>     ... any insn ...;
>     for (;;)
>         (*ctx)++;
>     return 0;
>
> But cannot catch case like this:
>
>     for (;;)
>         (*ctx)++;
>     return 0;
>
> In that sketch I jump to the callback start from callback return and
> callback entry needs two checks:
> - iteration convergence
> - simple looping
> Because of the code structure only iteration convergence check was done.
> Locally, I fixed this issue by jumping to the callback call instruction
> instead.

wouldn't this be a problem for just any subprog if we don't check the
looping condition on the entry instruction? Perhaps that's a separate
issue that needs generic fix?

>
> > > - the callback as bellow currently causes state explosion:
> > >
> > >   static int precise1_callback(__u32 idx, struct precise1_ctx *ctx)
> > >   {
> > >       if (idx =3D=3D 0)
> > >           ctx->a =3D 1;
> > >       if (idx =3D=3D 1 && ctx->a =3D=3D 1)
> > >           ctx->b =3D 1;
> > >       return 0;
> > >   }
> >
> > why state explosion? there should be a bunch of different branches
> > (idx 0, 1, something else x ctx->a =3D 1 or not 1 and ctx->b being 1 or
> > not), but it should be a fixed number of states? Do you know what
> > causes the explosion?
>
> I forgot to do mark_force_checkpoint() at callback entry. Fixed locally.

ok, makes sense

>
> >
> > >
> > >   I'm not sure yet what to do about this, there are several possibili=
ties:
> > >   - tweak the order in which states are visited (need to think about =
it);
> > >   - check states in bpf_verifier_env::head (not explored yet) for
> > >     equivalence and avoid enqueuing duplicate states.
> > >
> > > I'll proceed addressing the issues above on Monday.
> > >
> > > Thanks,
> > > Eduard
> > >
> > > ---
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index a3236651ec64..5589f55e42ba 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -70,6 +70,17 @@ enum bpf_iter_state {
> > >         BPF_ITER_STATE_DRAINED,
> > >  };
> > >
> > > +struct bpf_iter {
> > > +       /* BTF container and BTF type ID describing
> > > +        * struct bpf_iter_<type> of an iterator state
> > > +        */
> > > +       struct btf *btf;
> > > +       u32 btf_id;
> > > +       /* packing following two fields to fit iter state into 16 byt=
es */
> > > +       enum bpf_iter_state state:2;
> > > +       int depth:30;
> > > +};
> > > +
> > >  struct bpf_reg_state {
> > >         /* Ordering of fields matters.  See states_equal() */
> > >         enum bpf_reg_type type;
> > > @@ -115,16 +126,7 @@ struct bpf_reg_state {
> > >                 } dynptr;
> > >
> > >                 /* For bpf_iter stack slots */
> > > -               struct {
> > > -                       /* BTF container and BTF type ID describing
> > > -                        * struct bpf_iter_<type> of an iterator stat=
e
> > > -                        */
> > > -                       struct btf *btf;
> > > -                       u32 btf_id;
> > > -                       /* packing following two fields to fit iter s=
tate into 16 bytes */
> > > -                       enum bpf_iter_state state:2;
> > > -                       int depth:30;
> > > -               } iter;
> > > +               struct bpf_iter iter;
> >
> > Let's not do this, conceptually processes are similar, but bpf_iter is
> > one thing, and this callback validation is another thing. Let's not
> > conflate things.
> >
> > >
> > >                 /* Max size from any of the above. */
> > >                 struct {
> >
> > [...]
>

