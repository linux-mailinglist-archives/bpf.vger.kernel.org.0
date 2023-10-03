Return-Path: <bpf+bounces-11237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FBB7B5DF2
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 02:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D45E91C20825
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 00:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D52EC4;
	Tue,  3 Oct 2023 00:05:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B41EA3
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 00:05:38 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F5B93
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 17:05:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32320381a07so411461f8f.0
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696291534; x=1696896334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv95tLVX6KGm4z7YXrduIXaoekIstQjSaNWbSwzycEU=;
        b=cb4uQltZtgW+9uM25obYrWcJlpnGtN05RCPQ5JAt3PxR+HztLHkIGphC1LIEH9vcCZ
         QqwA3vIWIsPuR+O9mpUItcf9FkTEXp+7Tk+g6iQzEitce0mWWJ8eTWEue8nrRbvitzcF
         Gxjcmf4Bk5AEQXtuvDCc/zgTd0iqY5TYCs5rwDrQVHW0NgxWazRb0wJKCsQuh1aT0qin
         5PlchVnsNXvwgy2+PgD9gQcBaifMNZa+HG1LD1dYt0NbYH1Bqtv7isawNzd/D0DtFZJD
         sIQDCvLZpsFAPXA9PwSKdOoWJWUmyEl1pqYTZtDcfzKMZyi+0iNErVDb52a0hIUupQ5u
         VQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696291534; x=1696896334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv95tLVX6KGm4z7YXrduIXaoekIstQjSaNWbSwzycEU=;
        b=suuHVBzuuRPwrVteLy5P3/oY+i56vwD2UWOEoLmasRd4trRsZxnhS0jb3eujLJ21Be
         v6tznvBVu9dgsVlC54r8fPVVwwanOJQe3phCrsehAwU0Vh8zO+cJDxJocd7RHjVgxjK1
         VQWY5UyknjGpvKHKHEV7hFRGpvxx44IWlp1iixhCb8Y6v3LvrCsWjm6KDjtrkfVv+VGd
         6L2ec2RVFnTh7cmzbJdX0aTmxanZO3qfM0OEMqQWglZWHG8BqlGkwJUfQ7b3+XSlvkUH
         bnTI9CAjWQ8NdtUqs7WbWKJRvlC6OKn76iFZnDMxNq6NAAfook5BBrPdolyHBGJ5uNnu
         mOHA==
X-Gm-Message-State: AOJu0Yx34YoWLYAG+dXI5C7cITkMLSFJrujUyyPK9xEndaGmeNvs10BE
	ySzLzBH7a/YQrj4AB1xoyHQ/Tcq5jia+hW/lQoc=
X-Google-Smtp-Source: AGHT+IEKeFL/wJEnPWzD2vvOE99NAvKN0/RGhDHWLX8sEl0wsMsNSmEqzst6wVLUhDGT5r5hbGANnk2sFOh1hNIl0XY=
X-Received: by 2002:a5d:5a17:0:b0:319:8bd0:d18c with SMTP id
 bq23-20020a5d5a17000000b003198bd0d18cmr6766607wrb.52.1696291533566; Mon, 02
 Oct 2023 17:05:33 -0700 (PDT)
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
 <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com> <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
In-Reply-To: <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Oct 2023 17:05:21 -0700
Message-ID: <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
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

On Mon, Oct 2, 2023 at 10:18=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-10-02 at 09:29 -0700, Alexei Starovoitov wrote:
> [...]
> > > I'd like to argue about B "widening" for a bit, as I think it might b=
e
> > > interesting in general, and put A aside for now. The algorithm for
> > > widening looks as follows:
> > > - In is_states_equal() for (sl->state.branches > 0 && is_iter_next_in=
sn()) case:
> > >   - Check if states are equal exactly:
> > >     - ignore liveness marks on old state;
> > >     - demand same type for registers and stack slots;
> > >     - ignore precision marks, instead compare scalars using
> > >       regs_exact() [this differs from my previous emails, I'm now sur=
e
> > >       that for this scheme to be correct regs_exact() is needed].
> > >   - If there is an exact match then follow "hit" branch. The idea
> > >     being that visiting exactly the same state can't produce new
> > >     execution paths (like with graph traversal).
> >
> > Right. Exactly the same C state won't produce new paths
> > as seen in visited state V, but
> > if C=3D=3DV at the same insn indx it means we're in the infinite loop.
>
> This is true in general, but for bpf_iter_next() we have a guarantee
> that iteration would end eventually.
>
> > > More formally, before pruning potential looping states we need to
> > > make sure that all precision and read marks are in place.
> > > To achieve this:
> > > - Process states from env->head while those are available, in case if
> > >   potential looping state (is_states_equal()) is reached put it to a
> > >   separate queue.
> > > - Once all env->head states are processed the only source for new rea=
d
> > >   and precision marks is in postponed looping states, some of which
> > >   might not be is_states_equal() anymore. Submit each such state for
> > >   verification until fixed point is reached (repeating steps for
> > >   env->head processing).
> >
> > Comparing if (sl->state.branches) makes sense to find infinite loop.
> > It's waste for the verifier to consider visited state V with branches >=
 0
> > for pruning.
> > The safety of V is unknown. The lack of liveness and precision
> > is just one part. The verifier didn't conclude that V is safe yet.
> > The current state C being equivalent to V doesn't tell us anything.
> >
> > If infinite loop detection logic trips us, let's disable it.
> > I feel the fix should be in process_iter_next_call() to somehow
> > make it stop doing push_stack() when states_equal(N-1, N-2).
>
> Consider that we get to the environment state where:
> - all env->head states are exhausted;
> - all potentially looping states (stored in as a separate set of
>   states instead of env->head) are states_equal() to some already
>   explored state.
>
> I argue that if such environment state is reached the program should
> be safe, because:
> - Each looping state L is a sub-state of some explored state V and
>   every path from V leads to either safe exit or another loop.
> - Iterator loops are guaranteed to exit eventually.

It sounds correct, but I don't like that the new mechanism
with two stacks of states completely changes the way the verifier works.
The check you proposed:
if (env->stack_size !=3D 0)
      push_iter_stack()
rings alarm bells.

env->stack_size =3D=3D 0 (same as env->head exhausted) means we're done
with verification (ignoring bpf_exit in callbacks and subprogs).
So above check looks like a hack for something that I don't understand yet.
Also there could be branches in the code before and after iter loop.
With "opportunistic" states_equal() for looping states and delayed
reschedule_loop_states() to throw states back at the verifier
the whole verification model is non comprehensible (at least to me).
The stack + iter_stack + reschedule_loop_states means that in the following=
:
foo()
{
  br1 // some if() {...} block
  loop {
    br2
  }
  br3
}

the normal verifier pop_stack logic will check br3 and br1,
but br2 may or may not be checked depending on "luck" of states_equal
and looping states that will be in iter_stack.
Then the verifier will restart from checking loop-ing states.
If they somehow go past the end of the loop all kinds of things go crazy.
update_branch_counts() might warn, propagate_liveness, propagate_precision
will do nonsensical things.
This out-of-order state processing distorts the existing model so
much that I don't see how we can reason about these two stacks verification=
.


I think the cleaner solution is to keep current single stack model.
In the above example the verifier would reach the end, then check br3,
then check br2,
then we need to split branches counter somehow, so that we can
compare loop iter states with previous visited states that are known
to be safe.
In visited states we explored everything in br3 and in br2,
so no concerns that some path inside the loop or after the loop
missed precision or liveness.
Maybe we can split branches counter into branches due to 'if' blocks
and branches due to process_iter_next_call().
If there are pending process_iter_next_call-caused states it's still
ok to call states_equal on such visited states.

I could be missing something, of course.

