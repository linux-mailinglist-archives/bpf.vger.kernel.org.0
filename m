Return-Path: <bpf+bounces-1553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90330718ED2
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 00:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401EE281629
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A24076D;
	Wed, 31 May 2023 22:54:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035820697
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 22:54:41 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA658107
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 15:54:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af31dc49f9so2723341fa.0
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 15:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685573677; x=1688165677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvUCHuqNKsTgHuJl6dEq6+BmiKbDk8jab9h+brSPseA=;
        b=ddUIuym5IGXoB1Ju7OSmGFa0TeMK24LdM5RXsNFwpUqyaQyajFIjtE88RoL4lnNyNw
         sXCV9+xn2jpRxF3bDhqUbiP1Wbw2aRs3wui257A6tq3r0bd44pKPopCAGsJY8/3fmCrR
         p4E/ZoarNAzcypX7kWR1g9VDVTuXBFcgMabTWDPqc65ESOvZqC4AsmHOxKEQXh5hk8Iz
         zaXyRiruFv+koHwiObYT4ornuSdvSeIT2sIiBQOBG3JSsSvw//+1uAWMQCZCJHtmvCvd
         e8VexzO9yhQNaWWZaNH3ADyFMrOkUNNN1MfTKjHudsrQoTwaJjJpsL5Spihgx3wdAJJ9
         imJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685573677; x=1688165677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvUCHuqNKsTgHuJl6dEq6+BmiKbDk8jab9h+brSPseA=;
        b=FS+guELVB4w7Av6+bFI9+KveiB4jhktcscFmpxqv5ohFoza9Tgr3uwJnfFrcxNhZO7
         SxpwJeWq531i3vE7bFGhOOMuYlS6CDWRZnh+RYGWT3AQ+v+BNm5XmwYM23NJmJ718qc9
         8KfaWgZc/2KMpZgH5GM+FSZuXg3gg3LOsaNdHbTiHHSC6Hu7UgvBivE34W74TrGB4PHp
         dW5U88MfZRpBGOFaQyF+C2KghdAGGtwkdFE+4XWVP/hmRUDctGbMWb6n3NWAzaF1bimc
         2d9O2HuAqnPG2ZpUQF8ASyT5cJEBXhdAlZm3Ff/6p8WuLb8yG5sAYyaG3OXNf1LkIJF9
         fvdA==
X-Gm-Message-State: AC+VfDxfFXaS35NPpY5RGVkw/fV8jcHqaQl5V3UT315iEsR6fg4ODXO8
	V8OKq/WHHimHPWmJ+NpyccqUm8OLW4JnDT8z0gE=
X-Google-Smtp-Source: ACHHUZ6Q2HkSuqfyo2HvHbC4NQYCfSTXO9H6Q0UuYPwSMNcpZJ7UuA4WQBoUpTk6Lsrgmcwf9EIZoRcQUb0t6j0bn1Q=
X-Received: by 2002:a2e:3101:0:b0:2a8:e642:8cdb with SMTP id
 x1-20020a2e3101000000b002a8e6428cdbmr3289181ljx.49.1685573676635; Wed, 31 May
 2023 15:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530172739.447290-1-eddyz87@gmail.com> <20230530172739.447290-2-eddyz87@gmail.com>
 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
 <f2abf39bcd4de841a89bb248de9e242a880aaa93.camel@gmail.com>
 <CAEf4BzYjvjbm9g1N9Z04kXV1N3+KH+dZ_sq_0NWuhyuJ+A18UQ@mail.gmail.com>
 <a13ee48ac037d0dbb6796c7ea5965140ec7ef726.camel@gmail.com>
 <CAEf4BzYE_7m3FNc6dtZeKb6tNbW4xkhz6SVdV6KetD5reSer6A@mail.gmail.com>
 <aa64ee05281ec952df41b7a7842ed2836ae79762.camel@gmail.com>
 <CAEf4BzZVd2=QnXe-A_n9zBYKcsY=DiHhH3EG8yB9Cq5+8D5jcQ@mail.gmail.com> <eaa12a66fa3e06e24232507359fa0a07f43d514d.camel@gmail.com>
In-Reply-To: <eaa12a66fa3e06e24232507359fa0a07f43d514d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 May 2023 15:54:24 -0700
Message-ID: <CAEf4Bza+60Wjbk=Hww1joxoykx+HeyP_Nv5igP7V0RZi=-3OVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 3:15=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-05-31 at 14:14 -0700, Andrii Nakryiko wrote:
> > On Wed, May 31, 2023 at 1:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Wed, 2023-05-31 at 13:12 -0700, Andrii Nakryiko wrote:
> > > > On Wed, May 31, 2023 at 12:30=E2=80=AFPM Eduard Zingerman <eddyz87@=
gmail.com> wrote:
> > > > >
> > > > > On Wed, 2023-05-31 at 11:29 -0700, Andrii Nakryiko wrote:
> > > > > > On Wed, May 31, 2023 at 10:21=E2=80=AFAM Eduard Zingerman <eddy=
z87@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, 2023-05-30 at 14:37 -0700, Andrii Nakryiko wrote:
> > > > > > > [...]
> > > > > > > > Also, it might make sense to drop SCALAR register IDs as so=
on as we
> > > > > > > > have only one instance of it left (e.g., if "paired" regist=
er was
> > > > > > > > overwritten already). I.e., aggressively drop IDs when they=
 become
> > > > > > > > useless. WDYT?
> > > > > > >
> > > > > > > I added modification which resets sole scalar IDs to zero bef=
ore
> > > > > > > states comparison, it shows some speedup but is still slow:
> > > > > > >
> > > > > > >   Filter        | Number of programs | Number of programs
> > > > > > >                 | patch #1           | patch #1 + sole scalar=
 ID pruning
> > > > > > >   -----------------------------------------------------------=
-----------
> > > > > > >   states_pct>10 | 40                 | 40
> > > > > > >   states_pct>20 | 20                 | 19
> > > > > > >   states_pct>30 | 15                 | 13
> > > > > > >   states_pct>40 | 11                 | 8
> > > > > > >
> > > > > > > (Out of 177 programs).
> > > > > > >
> > > > > > > I'll modify mark_chain_precision() to propagate precision mar=
ks for
> > > > > > > find_equal_scalars(), so that it could be compared to current=
 patch #3
> > > > > > > in terms of code complexity and verification performance.
> > > > > > >
> > > > > > > If you have any thoughts regarding my previous email, please =
share.
> > > > > > >
> > > > > >
> > > > > > Yep, I do. Given SCALAR registers with the same ID are meant to=
 "share
> > > > > > the destiny", shouldn't it be required that when we mark r6 as =
precise
> > > > > > we should automatically mark linked r7 as precise at the same p=
oint.
> > > > > > So in your example:
> > > > > >
> > > > > > 7: r9 +=3D r6
> > > > > >
> > > > > > should be where we request both r6 and r7 (and whatever other r=
egister
> > > > > > has the same ID) to be marked as precise. It should be very eas=
y to
> > > > > > implement, especially given my recent refactoring with
> > > > > > mark_chain_precision_batch.
> > > > >
> > > > > Ok, I'll modify the `struct backtrack_state` as follows:
> > > > >
> > > > >   struct backtrack_state {
> > > > >         struct bpf_verifier_env *env;
> > > > >         u32 frame;
> > > > >         u32 reg_masks[MAX_CALL_FRAMES];
> > > > > +       u32 reg_ids[MAX_CALL_FRAMES];
> > > > >         u64 stack_masks[MAX_CALL_FRAMES];
> > > > > +       u64 stack_ids[MAX_CALL_FRAMES];
> > > > >   };
> > > > >
> > > > > And add corresponding logic to backtrack_insn().
> > > >
> > > > I don't see why you need to change anything about backtrack_state a=
t
> > > > all, so we are not on the same page.
> > > >
> > > > What I propose is that in mark_chain_precision(), when given regno,=
 go
> > > > over all *current* registers with the same ID, and set all of them =
as
> > > > "to be marked precise". And then call mark_chain_precision_batch().
> > > > See propagate_precision() for how we do similar stuff for bulk
> > > > precision propagation.
> > > >
> > > > backtrack_state shouldn't need to know about IDs, unless I'm missin=
g something
> > >
> > > Consider a modified version of the original example:
> > >
> > >   1: r9 =3D ... some pointer with range X ...
> > >   2: r6 =3D ... unbound scalar ID=3Da ...
> > >   3: r7 =3D ... unbound scalar ID=3Db ...
> > >   4: if (r6 > r7) goto +1
> > >   5: r7 =3D r6
> > >   6: if (r7 > X) goto ...
> > >   7: r7 =3D 0
> > >   8: r9 +=3D r6
> > >
> > > Suppose verification path is 1-8, the ID assignments are:
> > >
> > >                             r6.id r7.id
> > >   4: if (r6 > r7) goto +1   a     b
> > >   5: r7 =3D r6                a     a
> > >   6: if (r7 > X) goto ...   a     a
> > >   7: r7 =3D 0                 a     -
> > >   8: r9 +=3D r6               a     -
> > >
> > > When mark_chain_precision() is called at (8) it no longer knows that
> > > r6 and r7 shared the same ID at some point in the past. What you
> > > suggest won't work in this case, what I suggest won't work as well.
> >
> > Let's not jump the gun here. If r6 and r7 are not linked anymore, then
> > a) precision of either r6 or r7 didn't matter before and b) r6
> > precision doesn't imply r7 precision anymore, because r7 is completely
> > independent now.
> >
> > If there is some other code path at which r7's precise range would
> > matter, then a) in that other code path r6 and r7 would still be
> > linked and thus proposed precision tracking will mark both as precise,
> > or b) r7 would be already independent and precision tracking will mark
> > only r7 directly.
>
> Just to be on the same page, you suggest to do the following
> modification:
>
>   int mark_chain_precision(struct bpf_verifier_env *env, int regno)
>   {
>     // set env->bt flag for regno
>         // set env->bt flag for each register the same id as regno
>         return mark_chain_precision_batch(env);
>   }
>
> right?

yep

>
> It doesn't work for the example at hand:
> - First, the path 1-8 would be marked as safe.
>   Precision marks would be propagated only for r6.
>   Also, let's suppose that checkpoint is created at (6):
>
>    4: if (r6 > r7) goto +1 ; r6=3DPscalar, r7=3DPscalar
>    5: r7 =3D r6              ; r6=3DPscalar
>    --- checkpoint #1 ---
>    6: if (r7 > X) goto ... ; r6=3DPscalar
>    7: r7 =3D 0               ; r6=3DPscalar
>    8: r9 +=3D r6             ; r6=3DPscalar
>
> - Next, the jump (6) to ... is verified, suppose it is safe.
> - Next, the jump from 4 to 6 would be verified, the checkpoint #1
>   would be considered. For this checkpoint only r6 is marked precise,
>   so only r6 would be fed to check_ids(), thus regsafe() would return tru=
e.
>   For correct regsafe() operation we need precision marks for both
>   r7 and r6 at checkpoint #1.

right :(

>
> Now, a question, is it possible to modify your suggestion?
> - all register assignments are known at the beginning of checkpoint #1;
> - checkpoint #1 is a parent state of a state visiting (8)
>   (the state in which mark_chain_precision(env, 6) is called);
> - __mark_chain_precision() can be modified to do a similar thing every
>   time parent state is reached:
>   - look for IDs of registers currently marked as precise;
>   - mark all registers with these IDs as precise.

good point, this would have to happen within each state in which we
need to mark precisions

>
> But does this modification has any loopholes for more complex cases?
> E.g. can we get in trouble with the following modification of the
> original example?:
>
>    4: if (r6 > r7) goto +1
>    5: r7 =3D r6
>    --- checkpoint #1 ---
>    6: <something>
>    7: if (r7 > X) goto ...
>    8: r7 =3D 0
>    9: r9 +=3D r6
>
> It looks like your next paragraph applies here:
> - if <something> modifies r7: there is no r6/r7 link anymore;
> - if <something> modifies r6: same thing;
> - if <something> does not touch r7/r6 the ID assignments for r7/r6 at
>   checkpoint #1 should be fine;
>
> Still, sounds a bit fragile.

well, what can I say... force all imprecise logic isn't that
straightforward either, but so far it still holds. And the big idea
here is similar: whatever happens between two checkpoints doesn't
matter if its effect is not visible at the end of the checkpoint.

So I guess the intent of my proposal is correct: every time we mark r6
as precise, we should mark r7 as well in each state in which they are
still linked. Which necessitates to do this on each walk up the state
chain.

At least let's give it a try and see how it holds up against existing
tests and whatever test you can come up with?..

>
> > The way I see it, in a bit of an abstract way, if two registers are
> > linked through the same ID, then *until the point that they diverge*,
> > we have to make sure their states are the same. We do that with range
> > on each operation, but the precise bit is different, as it's
> > backtracked. So that's what my proposed fix to mark_precise_chain() is
> > doing: it makes sure we link precise bits for these registers
> > together. Yes, we will miss some intermediate state where r6 and r7
> > were linked, but if that link didn't matter (because neither r6 nor r7
> > were marked as precise at that point), then it effectively as if those
> > IDs were not even assigned at all.
> >
> > BTW, as soon as one of the linked registers is modified, I hope we are
> > breaking the link and dropping the ID (I haven't checked the code, but
> > that is how it should work, I think). Please double check as you look
> > at this code, thanks!
>
> This is my understanding as well, but will double-check.

sounds good

>
> > Let's see if you can come up with another counterexample to this line
> > of thinking, I'm very open to me missing another detail, happens all
> > the time, but discussions like this are the only way to learn about
> > such details :)
>
> Discussion is good, I knew you wouldn't like the u32_hashset :)

yeah, I don't.


BTW, I did contemplate extending jmp_history to contain extra flags
about "interesting" instructions, though. Specifically, last
unsupported case for precision backtracking is when register other
than r10 is used for stack access (which can happen when one passes a
pointer to a SCALAR to parent function's stack), for which having a
bit next to such instruction saying "this is really a stack access"
would help cover the last class of unsupported situations.

But this is a pretty significant complication. And to make it really
practical, we'd need to think very hard on how to implement
jmp_history more efficiently, without constant reallocations. I have a
hunch that jmp_history should be one large resizable array that all
states share and just point into different parts of it. When state is
pushed to the stack, we just remember at which index it starts. When a
state is finalized, its jump history segment shouldn't be needed by
that state and can be reused by its siblings and parent states.
Ultimately, we only have a linear chain of actively worked-on states
which do use jmp_history, and all others either don't need it
*anymore* (verified states) or don't need it *yet* (enqueued states).

This would allow us to even have an exact "log of execution" with
insn_idx and associated extra information, but it will be code path
dependent, unlike bpf_insn_aux. And the best property is that it will
never grow beyond 1 million instructions deep (absolute worst case).

We might not even need backtracking in its current form if we just
proactively maintain involved registers information (something that we
currently derive during instruction interpretation in backtrack_insn).

So at some point I'd like to get to thinking and implementing this,
but it isn't the most pressing need right now, of course.

>
> > >
> > > Looks like the only way to do it correctly is to save ID assignments
> > > after each find_equal_scalars() (for (6) in this example) in the
> > > bpf_verifier_state, and use this information in backtrack_insn().
> > > For example, extend jmp_history.
> > >
> > > >
> > > > >
> > > > > > The question I have (and again, haven't spent any time thinking=
 about
> > > > > > any other corner cases, sorry) is whether that alone would be a=
 proper
> > > > > > fix?
> > > > >
> > > > > As far as I understand, in terms of correctness it would be a pro=
per fix.
> > > > > In terms of performance, I hope that it would be enough but we wi=
ll see.
> > > >
> > > > ok, let's try that then, before we commit to u32_hashset stuff
> > > >
> > > > >
> > > > > > As for this u32_hashset, it just feels like a big overkill, tbh=
. If we
> > > > > > have to do something like that, wouldn't it be better to, say, =
set
> > > > > > highest bit in reg->id (for all linked registers, of course) to=
 mark
> > > > > > it as "used for range checks" instead of maintaining a separate=
 check?
> > > > >
> > > > > Unfortunately no, because this ID change would have to be propaga=
ted
> > > > > backwards. It was the first implementation I tried.
> > > > >
> > > > > > But just the whole idea of keeping track of some special circum=
stances
> > > > > > under which IDs are meaningful seems wrong... All this logic is
> > > > > > complicated, now we are adding another layer of complexity on t=
op. And
> > > > > > the complexity is not in the code, it's in thinking about all p=
ossible
> > > > > > scenarios and their interactions.
> > > > >
> > > > > I agree that adding more layers is a complication in itself.
> > > > > Thank you for your input.
> > > > >
> > > > > > > [...]
> > > > >
> > >
>

