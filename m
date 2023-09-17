Return-Path: <bpf+bounces-10241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87A7A3E63
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 00:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D009F281361
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5481F4F9;
	Sun, 17 Sep 2023 22:09:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46FDE563
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:09:57 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD0DB
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 15:09:55 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so1261898a12.0
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694988593; x=1695593393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKDMiDzuEvN+r87ZYPnawzPo7DBqVrmHmcZyS3nnHo0=;
        b=BhcomlVuTH3TFxCuSFR9pz6P5aH6hCyh7n0KXfltCAZ/JbCvzXG7NVaS8+DIfg4JJr
         UCMBX/pJNhZxtqPzH/8e9iiJILUMI2lQXMWtd5w2aB+/uoRUEwdKQF0o5o6R5OMSz4aF
         a52JGJ4SrQrjqkEkHvr4bHHv98GCgqTq93UZZqGWukRdKfI4NO8fqqLOxjWOk2gF7yDF
         TEAG+jjT9uGPdUHYOXEf6yjguWhKrN/CFl27sMJOczzwkfDgiUWHGAlU+PNCOZ7Jkwyt
         mS4xNwIT7dkUAPvoS+uFAiSXoFw93ibBrqWS4VtWAMebymfAGnbd/YA0Q15pbVPRA+N3
         v8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694988593; x=1695593393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKDMiDzuEvN+r87ZYPnawzPo7DBqVrmHmcZyS3nnHo0=;
        b=HT4PO0M151Srg4C6gViJi8Adm1Wygs6w3jsYEqmM5tsls+W9IqH8F9v09mM6Vp3BiE
         HrIke15Ae8DYqIiVeNB8fa/zpNvCs5p2X3wRvOm+BV18ompUR+khe4UjCylQozQ0U5FD
         1lCmqvVH8nHsBwF7bpNqVa+SGRklDjmEz2joUdUsnd1EmNIn4ziqGW7u+xbQz0H8BitY
         Zi2fk7/P57hwdIWVUN8hAJREMP8vgosTqw22sA92WNJf5aczFv6LI2d/qeoK87Jr4gVd
         qf+ykhEgWjoh7KqIeBxHm2bg7LjNGBK7yvEYwuy48sr9eKVxjaXB1KOq01+FiZWlfIh7
         hF2Q==
X-Gm-Message-State: AOJu0Yzf14aXUR34OrxBovIALT6FL7wtHl9Dm04i6st6IrA0cEaTyzKl
	vOi9/i6B4q07PXB0+bLHjjbGhpHj34P3L0Lqk6mmgFV42q8Dsw==
X-Google-Smtp-Source: AGHT+IEhKrvmLEsd6IpARC52g4XRFmqXirRyx9EwNrNxpPjfZw6gp5toZBfEszgs+ANyUFgzsaKd8lV6cwPl5Xe559E=
X-Received: by 2002:a05:6402:1d95:b0:531:157d:ba2d with SMTP id
 dk21-20020a0564021d9500b00531157dba2dmr1409261edb.4.1694988593367; Sun, 17
 Sep 2023 15:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com> <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
In-Reply-To: <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 18 Sep 2023 00:09:17 +0200
Message-ID: <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
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

On Sun, 17 Sept 2023 at 23:37, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2023-07-07 at 11:08 -0700, Andrii Nakryiko wrote:
> > On Fri, Jul 7, 2023 at 9:44=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jul 7, 2023 at 7:04=E2=80=AFAM Andrew Werner <awerner32@gmail=
.com> wrote:
> > > >
> > > > When it comes to fixing the problem, I don't quite know where to st=
art.
> > > > Perhaps these iteration callbacks ought to be treated more like glo=
bal functions
> > > > -- you can't always make assumptions about the state of the data in=
 the context
> > > > pointer. Treating the context pointer as totally opaque seems bad f=
rom
> > > > a usability
> > > > perspective. Maybe there's a way to attempt to verify the function
> > > > body of the function
> > > > by treating all or part of the context as read-only, and then if th=
at
> > > > fails, go back and
> > > > assume nothing about that part of the context structure. What is th=
e
> > > > right way to
> > > > think about plugging this hole?
> > >
> > > 'treat as global' might be a way to fix it, but it will likely break
> > > some setups, since people passing pointers in a context and current
> > > global func verification doesn't support that.
> >
> > yeah, the intended use case is to return something from callbacks
> > through context pointer. So it will definitely break real uses.
> >
> > > I think the simplest fix would be to disallow writes into any pointer=
s
> > > within a ctx. Writes to scalars should still be allowed.
> >
> > It might be a partial mitigation, but even with SCALARs there could be
> > problems due to assumed SCALAR range, which will be invalid if
> > callback is never called or called many times.
> >
> > > Much more complex fix would be to verify callbacks as
> > > process_iter_next_call(). See giant comment next to it.
> >
> > yep, that seems like the right way forward. We need to simulate 0, 1,
> > 2, .... executions of callbacks until we validate and exhaust all
> > possible context modification permutations, just like open-coded
> > iterators do it
> >
> > > But since we need a fix for stable I'd try the simple approach first.
> > > Could you try to implement that?
>
> Hi All,
>
> This issue seems stalled, so I took a look over the weekend.
> I have a work in progress fix, please let me know if you don't agree
> with direction I'm taking or if I'm stepping on anyone's toes.
>

I was planning to get to this eventually, but it's great if you are
looking to do it.

> After some analysis I decided to go with Alexei's suggestion and
> implement something similar to iterators for selected set of helper
> functions that accept "looping" callbacks, such as:
> - bpf_loop
> - bpf_for_each_map_elem
> - bpf_user_ringbuf_drain
> - bpf_timer_set_callback (?)
>

The last one won't require this, I think. The callback only runs once,
and asynchronously.
Others you are missing are bpf_find_vma and the bpf_rbtree_add kfunc.
While the latter is not an interator, it can invoke the same callback
an unknown number of times.

The other major thing that needs to be checked is cases where callback
will be executed zero times. There is some discussion on this in [0],
where this bug was reported originally. Basically, we need to explore
a path where the callback execution does not happen and ensure the
program is still safe.

[0]: https://lore.kernel.org/bpf/CAP01T74cOJzo3xQcW6weURH+mYRQ7kAWMqQOgtd_y=
mSbhrOoMQ@mail.gmail.com

You could also consider taking the selftests from this link, some of
them allow completely breaking safety properties of the verifier.

> The sketch of the fix looks as follows:
> - extend struct bpf_func_state with callback iterator state information:
>   - active/non-active flag
>   - depth
>   - r1-r5 state at the entry to callback;
> - extend __check_func_call() to setup callback iterator state when
>   call to suitable helper function is processed;
> - extend BPF_EXIT processing (prepare_func_exit()) to queue new
>   callback visit upon return from iterating callback
>   (similar to process_iter_next_call());
> - extend is_state_visited() to account for callback iterator hits in a
>   way similar to regular iterators;
> - extend backtrack_insn() to correctly react to jumps from callback
>   exit to callback entry.
>
> I have a patch (at the end of this email) that correctly recognizes
> the bpf_loop example in this thread as unsafe. However this patch has
> a few deficiencies:
>
> - verif_scale_strobemeta_bpf_loop selftest is not passing, because
>   read_map_var function invoked from the callback continuously
>   increments 'payload' pointer used in subsequent iterations.
>
>   In order to handle such code I need to add an upper bound tracking
>   for iteration depth (when such bound could be deduced).
>

Yes, either the loop converges before the upper limit is hit, or we
keep unrolling it until we exhaust the deduced loop count passed to
the bpf_loop helper. But we will need to mark the loop count argument
register as precise when we make use of its value in such a case.

> - loop detection is broken for simple callback as below:
>
>   static int loop_callback_infinite(__u32 idx, __u64 *data)
>   {
>       for (;;)
>           (*ctx)++;
>       return 0;
>   }
>
>   To handle such code I need to change is_state_visited() to do
>   callback iterator loop/hit detection on exit from callback
>   (returns are not prune points at the moment), currently it is done
>   on entry.
>
> - the callback as bellow currently causes state explosion:
>
>   static int precise1_callback(__u32 idx, struct precise1_ctx *ctx)
>   {
>       if (idx =3D=3D 0)
>           ctx->a =3D 1;
>       if (idx =3D=3D 1 && ctx->a =3D=3D 1)
>           ctx->b =3D 1;
>       return 0;
>   }
>
>   I'm not sure yet what to do about this, there are several possibilities=
:
>   - tweak the order in which states are visited (need to think about it);
>   - check states in bpf_verifier_env::head (not explored yet) for
>     equivalence and avoid enqueuing duplicate states.
>
>
> I'll proceed addressing the issues above on Monday.
>

I think there is a class of programs that are nevertheless going to be
broken now, as bpf_loop and others basically permitted incorrect code
to pass through. And the iteration until we arrive at a fixpoint won't
be able to cover all classes of loop bodies, so I think we will need
to make a tradeoff in terms of expressibility vs verifier complexity.
In general, cases like this with branches/conditional exit from the
loop body which do not converge will lead to state explosion anyway.

> Thanks,
> Eduard
>
> ---
>
> [...]

