Return-Path: <bpf+bounces-11060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC307B2548
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9830F282958
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC7515491;
	Thu, 28 Sep 2023 18:30:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB93516D7
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 18:30:20 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C00BF
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 11:30:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9adb9fa7200so2941268466b.0
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695925818; x=1696530618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yK/3CRuUOYBwzjkaUGUHLZH4xjAJLVhiY3QZYYCxps=;
        b=KQGop/CVZXC7L5SdZhGauOhmv7GL2iMTEEuZ+ORVWQLLqt4rP6oT8cfW/PaErbs8Zm
         ma8vHLT5WFJsmXM5He/jJwNT2FpGj7dEeA+NbR+biyTsesdmiY9iCu5k45BoZAhYUZKw
         0VevjNE+RaPm0Aoo0Lrd8irn4+EmgRNi2s5eHhKNgT3gl2a0wHIsm0T3r6f0+MEMAVs9
         PYhSeGeHad+3mUfWFY0FWcdavG62z+qvwQvOgyikXwc3RUPxzZT51xpgcM9OSkIGrfLl
         pAZRL1GazGIXzeelBQB91L/fMYoxMW6CXI/TJjOAKbIOh/QVzIFIyFaiNPBsbYTaY6uT
         reEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695925818; x=1696530618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yK/3CRuUOYBwzjkaUGUHLZH4xjAJLVhiY3QZYYCxps=;
        b=su4248LO6eFSfkSWYApbhJHovU/81P914WoQ5YeNDTOY7im1vPOPYzEm3WTCnc8WV+
         OwS6uoiJYAtMUHHBzGiT+9DuXEjRBvHV3VNdYkLOihy84OQJLRZp7y/QgrWHa6KadhbG
         ndiDout7ww1m9LJ3aGy2fqwbAwJg24JaeGfT+TWf3S/VWWvk3SIpk8GrZlS/w6h/9kq2
         N5CGGB1VxuA4pvx8Bd3aH6H5beewvkPwQLusVvVnuLI2MjVi4+dpKE5np5d/XA39wupS
         fgw9r8dXxoVZjB8GMLnIgQ0B0tNmtvS4uqACeimQA1XKtWgdtfWuyKMtfDqN96PXXLUt
         B+LQ==
X-Gm-Message-State: AOJu0YzUi2X8CJS4ZidP0I5R0Vp7Vp6538nlpi0K3fzYvCHztPvK76ll
	XXW6aHuSIjtcXKo/VoerFHJ/Z9IkwLUsLJux6xE8MXIU
X-Google-Smtp-Source: AGHT+IE6ad2sC/AKt4sK+sBuSSujAgiRfMwKxnU631TjVEPZqOVOAjaEJFXPjbbLLIi2uVHb6hh/NfVIT8gUYCdyqoo=
X-Received: by 2002:a17:906:24d:b0:9b2:b742:d1d3 with SMTP id
 13-20020a170906024d00b009b2b742d1d3mr2078462ejl.5.1695925817486; Thu, 28 Sep
 2023 11:30:17 -0700 (PDT)
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
 <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com> <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
In-Reply-To: <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 Sep 2023 11:30:05 -0700
Message-ID: <CAEf4BzYNpL7OVqCfDCoPfrcJ3pkZo77GS7000pRfGghQf1kn2Q@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 6:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-09-26 at 09:25 -0700, Andrii Nakryiko wrote:
> [...]
> > > In other words there is a function states_equal' for comparison of
> > > states when old{.branches > 0}, which differs from states_equal in
> > > the following way:
> > > - considers all registers read;
> > > - considers all scalars precise.
> > >
> >
> > Not really. The important aspect is to mark registers that were
> > required to be imprecise in old state as "required to be imprecise",
> > and if later we decide that this register has to be precise, too bad,
> > too late, game over (which is why I didn't propose it, this seems too
> > restrictive).
>
> Could you please elaborate a bit? What's wrong with the following:
> Suppose I see a register R that differs between V and C an is not
> precise in both. I fork C as C', mark R unbound in C' and proceed with
> C' verification. At some point during that verification I see that
> some precise R's value is necessary, thus C' verification fails.
> If that happens verification resumes from C, otherwise C is discarded.
> I also postpone read and precision marks propagation from C' to it's
> parent until C' verification succeeds (if it succeeds).

Nothing wrong, I'm just saying your C' derivation gives a chance to
undo things, while my eager idea wouldn't allow to do that. And that's
bad, so I didn't propose any of that.

Aside from that, I'd be curious to see how to prevent read/precision
marks propagation to V, seems like yet another hack and special case,
which just seems like yet another complication.

>
> [...]
> > 1. If V and C (using your terminology from earlier, where V is the old
> > parent state at some next() call instruction, and C is the current one
> > on the same instruction) are different -- we just keep going. So
> > always try to explore different input states for the loop.
> >
> > 2. But if V and C are equivalent, it's too early to conclude anything.
> > So enqueue C for later in a separate BFS queue (and perhaps that queue
> > is per-instruction, actually; or maybe even per-state, not sure), and
> > keep exploring all the other pending queues from the (global) DFS
> > queue, until we get back to state V again. At that point we need to
> > start looking at postponed states for that V state. But this time we
> > should be sure that precision and read marks are propagated from all
> > those terminatable code paths.
> >
> > Basically, this tries to make sure that we do mark every register that
> > is important for all the branching decision making, memory
> > dereferences, etc. And just avoids going into endless loops with the
> > same input conditions.
> >
> > Give it some fresh thought and let's see if we are missing something
> > again. Thanks!
>
> This should work for examples we've seen so far.
> Why do you think a separate per-instruction queue is necessary?

I'm not positive, it was just a possibility that it might matter. I'd
try with global queue first and tried to break the approach.

> The way I read it the following algorithm should suffice:
> - add a field bpf_verifier_env::iter_head similar to 'head' but for
>   postponed looping states;
> - add functions push_iter_stack(), pop_iter_stack() similar to
>   push_stack() and pop_stack();

I don't like the suggested naming, it's too iter-centric, and it's
actually a queue, not a stack, etc. But that's something to figure out
later.

> - modify is_state_visited() as follows:
>
>  static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>  {
>      ...
>      while (sl) {
>          ...
>          if (sl->state.branches) {
>              ...
>              if (is_iter_next_insn(env, insn_idx)) {
>                  if (states_equal(env, &sl->state, cur)) {
>                      ...
>                      iter_state =3D &func(env, iter_reg)->stack[spi].spil=
led_ptr;
>                      if (iter_state->iter.state =3D=3D BPF_ITER_STATE_ACT=
IVE) {
> +                        // Don't want to proceed with 'cur' verification=
,
> +                        // push it to iters queue to check again if stat=
es
> +                        // are still equal after env->head is exahusted.
> +                        if (env->stack_size !=3D 0)
> +                            push_iter_stack(env, cur, ...);
>                          goto hit;
>                      }
>                  }
>                  goto skip_inf_loop_check;
>              }
>      ...
>  }
>
> - modify do_check() to do pop_iter_stack() if pop_stack() is
>   exhausted, the popped state would get into is_state_visited() and
>   checked against old state, which at that moment should have all
>   read/precision masks that env->head could have provided.

Yeah, something like that.

>
> After working on "widening conjectures" implementation a bit this
> approach seems to be much simpler. Need to think harder if I can break it=
.

yeah, I think this C' derivation while conceptually seems
straightforward, probably has tons of non-obvious complications.

