Return-Path: <bpf+bounces-1552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A78718E4A
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 00:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A98F1C20F92
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A1A40773;
	Wed, 31 May 2023 22:16:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F076519E7C
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 22:16:00 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B5E10C2
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 15:15:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4d6aee530so27291e87.2
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685571318; x=1688163318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0xWQrNh1j+xPyJL2mi7KdOdXF3Pp7OEswuxUhNzt49c=;
        b=KLBLadYABRCS805hFS2I7pU573RsWEATcslSxBYxSgiHJJxoUla7gpDuf/7oKFLZUW
         YWI4g5yIYjI911EszO1rOR5hNP/YzN12pyqlFG70SZjxB5pe4xQyP5oleuMCAfQ2Edha
         HXPlwxEfLq42+mqUf6QVCkAH3etadl21MsZpLX27JeobZnoJGOmIxKCt3UoDxjUJllZn
         EtTnVk/EAGLGuOGjqsfMr8ecQ7YTDg+k6vgkJDUI1cjtXXnveKYqC/14XJCgYeukKBEU
         v9ne2LATkwfGt/Bj6gfrayePZIugmsmJGm/bD0U7FJ/i+C8+vm9768esJAVn88Ur/54b
         zi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685571318; x=1688163318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xWQrNh1j+xPyJL2mi7KdOdXF3Pp7OEswuxUhNzt49c=;
        b=I4w2kjOB51ALK9gbh9Ecwf8Qr8HSWWSXIC59LibmdWTbPiavh+jEB2nBzEoNgNkKku
         l+4Zu78K4Kl5pfA7h612sGtAINcAjHmI5DkUQZJe2tgfFv4iLn+d6oHUj0pCslFu+MI9
         lt5sjYEP02qXMTAs7998toEi0Kte960xjTltbIej3speGvUrshK2QvpQWHdH0MyBtWkg
         yGeU5IQA5E0BATXE4xUFtN2SD0zqxaxhqbUbG1LUQ80doqWw8/TgxYr8PBZ25ZwlK9uo
         m4FmQPUSoYjIvsVxdzillXLdWnCZY14y510DTSO6RKPXjxxTzl0MrqjALS5KkyJtwENe
         7VqA==
X-Gm-Message-State: AC+VfDz+mKK+vS7bzQvXK/vTLgNG8e4O93Q4CeGrF+VS9zWdqSBsi4Gq
	PNoiLtwUx9373lsnDvzT3TKYbcziuWX+qg==
X-Google-Smtp-Source: ACHHUZ66zR+EJmKxByu6wfV/BXJbR3UNBcbiFQLnsLZDUMHzEl+TcjNtl0H6ggHEjmnl7G3uPWvn9w==
X-Received: by 2002:a19:f502:0:b0:4f3:98b4:e45a with SMTP id j2-20020a19f502000000b004f398b4e45amr203507lfb.21.1685571317761;
        Wed, 31 May 2023 15:15:17 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x17-20020a19f611000000b004f27cecb68asm858675lfe.166.2023.05.31.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:15:17 -0700 (PDT)
Message-ID: <eaa12a66fa3e06e24232507359fa0a07f43d514d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Thu, 01 Jun 2023 01:15:16 +0300
In-Reply-To: <CAEf4BzZVd2=QnXe-A_n9zBYKcsY=DiHhH3EG8yB9Cq5+8D5jcQ@mail.gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <f2abf39bcd4de841a89bb248de9e242a880aaa93.camel@gmail.com>
	 <CAEf4BzYjvjbm9g1N9Z04kXV1N3+KH+dZ_sq_0NWuhyuJ+A18UQ@mail.gmail.com>
	 <a13ee48ac037d0dbb6796c7ea5965140ec7ef726.camel@gmail.com>
	 <CAEf4BzYE_7m3FNc6dtZeKb6tNbW4xkhz6SVdV6KetD5reSer6A@mail.gmail.com>
	 <aa64ee05281ec952df41b7a7842ed2836ae79762.camel@gmail.com>
	 <CAEf4BzZVd2=QnXe-A_n9zBYKcsY=DiHhH3EG8yB9Cq5+8D5jcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-05-31 at 14:14 -0700, Andrii Nakryiko wrote:
> On Wed, May 31, 2023 at 1:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2023-05-31 at 13:12 -0700, Andrii Nakryiko wrote:
> > > On Wed, May 31, 2023 at 12:30=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > >=20
> > > > On Wed, 2023-05-31 at 11:29 -0700, Andrii Nakryiko wrote:
> > > > > On Wed, May 31, 2023 at 10:21=E2=80=AFAM Eduard Zingerman <eddyz8=
7@gmail.com> wrote:
> > > > > >=20
> > > > > > On Tue, 2023-05-30 at 14:37 -0700, Andrii Nakryiko wrote:
> > > > > > [...]
> > > > > > > Also, it might make sense to drop SCALAR register IDs as soon=
 as we
> > > > > > > have only one instance of it left (e.g., if "paired" register=
 was
> > > > > > > overwritten already). I.e., aggressively drop IDs when they b=
ecome
> > > > > > > useless. WDYT?
> > > > > >=20
> > > > > > I added modification which resets sole scalar IDs to zero befor=
e
> > > > > > states comparison, it shows some speedup but is still slow:
> > > > > >=20
> > > > > >   Filter        | Number of programs | Number of programs
> > > > > >                 | patch #1           | patch #1 + sole scalar I=
D pruning
> > > > > >   -------------------------------------------------------------=
---------
> > > > > >   states_pct>10 | 40                 | 40
> > > > > >   states_pct>20 | 20                 | 19
> > > > > >   states_pct>30 | 15                 | 13
> > > > > >   states_pct>40 | 11                 | 8
> > > > > >=20
> > > > > > (Out of 177 programs).
> > > > > >=20
> > > > > > I'll modify mark_chain_precision() to propagate precision marks=
 for
> > > > > > find_equal_scalars(), so that it could be compared to current p=
atch #3
> > > > > > in terms of code complexity and verification performance.
> > > > > >=20
> > > > > > If you have any thoughts regarding my previous email, please sh=
are.
> > > > > >=20
> > > > >=20
> > > > > Yep, I do. Given SCALAR registers with the same ID are meant to "=
share
> > > > > the destiny", shouldn't it be required that when we mark r6 as pr=
ecise
> > > > > we should automatically mark linked r7 as precise at the same poi=
nt.
> > > > > So in your example:
> > > > >=20
> > > > > 7: r9 +=3D r6
> > > > >=20
> > > > > should be where we request both r6 and r7 (and whatever other reg=
ister
> > > > > has the same ID) to be marked as precise. It should be very easy =
to
> > > > > implement, especially given my recent refactoring with
> > > > > mark_chain_precision_batch.
> > > >=20
> > > > Ok, I'll modify the `struct backtrack_state` as follows:
> > > >=20
> > > >   struct backtrack_state {
> > > >         struct bpf_verifier_env *env;
> > > >         u32 frame;
> > > >         u32 reg_masks[MAX_CALL_FRAMES];
> > > > +       u32 reg_ids[MAX_CALL_FRAMES];
> > > >         u64 stack_masks[MAX_CALL_FRAMES];
> > > > +       u64 stack_ids[MAX_CALL_FRAMES];
> > > >   };
> > > >=20
> > > > And add corresponding logic to backtrack_insn().
> > >=20
> > > I don't see why you need to change anything about backtrack_state at
> > > all, so we are not on the same page.
> > >=20
> > > What I propose is that in mark_chain_precision(), when given regno, g=
o
> > > over all *current* registers with the same ID, and set all of them as
> > > "to be marked precise". And then call mark_chain_precision_batch().
> > > See propagate_precision() for how we do similar stuff for bulk
> > > precision propagation.
> > >=20
> > > backtrack_state shouldn't need to know about IDs, unless I'm missing =
something
> >=20
> > Consider a modified version of the original example:
> >=20
> >   1: r9 =3D ... some pointer with range X ...
> >   2: r6 =3D ... unbound scalar ID=3Da ...
> >   3: r7 =3D ... unbound scalar ID=3Db ...
> >   4: if (r6 > r7) goto +1
> >   5: r7 =3D r6
> >   6: if (r7 > X) goto ...
> >   7: r7 =3D 0
> >   8: r9 +=3D r6
> >=20
> > Suppose verification path is 1-8, the ID assignments are:
> >=20
> >                             r6.id r7.id
> >   4: if (r6 > r7) goto +1   a     b
> >   5: r7 =3D r6                a     a
> >   6: if (r7 > X) goto ...   a     a
> >   7: r7 =3D 0                 a     -
> >   8: r9 +=3D r6               a     -
> >=20
> > When mark_chain_precision() is called at (8) it no longer knows that
> > r6 and r7 shared the same ID at some point in the past. What you
> > suggest won't work in this case, what I suggest won't work as well.
>=20
> Let's not jump the gun here. If r6 and r7 are not linked anymore, then
> a) precision of either r6 or r7 didn't matter before and b) r6
> precision doesn't imply r7 precision anymore, because r7 is completely
> independent now.
>=20
> If there is some other code path at which r7's precise range would
> matter, then a) in that other code path r6 and r7 would still be
> linked and thus proposed precision tracking will mark both as precise,
> or b) r7 would be already independent and precision tracking will mark
> only r7 directly.

Just to be on the same page, you suggest to do the following
modification:

  int mark_chain_precision(struct bpf_verifier_env *env, int regno)
  {
    // set env->bt flag for regno
	// set env->bt flag for each register the same id as regno=20
	return mark_chain_precision_batch(env);
  }

right?

It doesn't work for the example at hand:
- First, the path 1-8 would be marked as safe.
  Precision marks would be propagated only for r6.
  Also, let's suppose that checkpoint is created at (6):

   4: if (r6 > r7) goto +1 ; r6=3DPscalar, r7=3DPscalar
   5: r7 =3D r6              ; r6=3DPscalar
   --- checkpoint #1 ---
   6: if (r7 > X) goto ... ; r6=3DPscalar
   7: r7 =3D 0               ; r6=3DPscalar
   8: r9 +=3D r6             ; r6=3DPscalar

- Next, the jump (6) to ... is verified, suppose it is safe.
- Next, the jump from 4 to 6 would be verified, the checkpoint #1
  would be considered. For this checkpoint only r6 is marked precise,
  so only r6 would be fed to check_ids(), thus regsafe() would return true.
  For correct regsafe() operation we need precision marks for both
  r7 and r6 at checkpoint #1.

Now, a question, is it possible to modify your suggestion?
- all register assignments are known at the beginning of checkpoint #1;
- checkpoint #1 is a parent state of a state visiting (8)
  (the state in which mark_chain_precision(env, 6) is called);
- __mark_chain_precision() can be modified to do a similar thing every
  time parent state is reached:
  - look for IDs of registers currently marked as precise;
  - mark all registers with these IDs as precise.

But does this modification has any loopholes for more complex cases?
E.g. can we get in trouble with the following modification of the
original example?:

   4: if (r6 > r7) goto +1=20
   5: r7 =3D r6             =20
   --- checkpoint #1 ---
   6: <something>
   7: if (r7 > X) goto ...=20
   8: r7 =3D 0              =20
   9: r9 +=3D r6            =20

It looks like your next paragraph applies here:
- if <something> modifies r7: there is no r6/r7 link anymore;
- if <something> modifies r6: same thing;
- if <something> does not touch r7/r6 the ID assignments for r7/r6 at
  checkpoint #1 should be fine;

Still, sounds a bit fragile.

> The way I see it, in a bit of an abstract way, if two registers are
> linked through the same ID, then *until the point that they diverge*,
> we have to make sure their states are the same. We do that with range
> on each operation, but the precise bit is different, as it's
> backtracked. So that's what my proposed fix to mark_precise_chain() is
> doing: it makes sure we link precise bits for these registers
> together. Yes, we will miss some intermediate state where r6 and r7
> were linked, but if that link didn't matter (because neither r6 nor r7
> were marked as precise at that point), then it effectively as if those
> IDs were not even assigned at all.
>=20
> BTW, as soon as one of the linked registers is modified, I hope we are
> breaking the link and dropping the ID (I haven't checked the code, but
> that is how it should work, I think). Please double check as you look
> at this code, thanks!

This is my understanding as well, but will double-check.

> Let's see if you can come up with another counterexample to this line
> of thinking, I'm very open to me missing another detail, happens all
> the time, but discussions like this are the only way to learn about
> such details :)
=20
Discussion is good, I knew you wouldn't like the u32_hashset :)

> >=20
> > Looks like the only way to do it correctly is to save ID assignments
> > after each find_equal_scalars() (for (6) in this example) in the
> > bpf_verifier_state, and use this information in backtrack_insn().
> > For example, extend jmp_history.
> >=20
> > >=20
> > > >=20
> > > > > The question I have (and again, haven't spent any time thinking a=
bout
> > > > > any other corner cases, sorry) is whether that alone would be a p=
roper
> > > > > fix?
> > > >=20
> > > > As far as I understand, in terms of correctness it would be a prope=
r fix.
> > > > In terms of performance, I hope that it would be enough but we will=
 see.
> > >=20
> > > ok, let's try that then, before we commit to u32_hashset stuff
> > >=20
> > > >=20
> > > > > As for this u32_hashset, it just feels like a big overkill, tbh. =
If we
> > > > > have to do something like that, wouldn't it be better to, say, se=
t
> > > > > highest bit in reg->id (for all linked registers, of course) to m=
ark
> > > > > it as "used for range checks" instead of maintaining a separate c=
heck?
> > > >=20
> > > > Unfortunately no, because this ID change would have to be propagate=
d
> > > > backwards. It was the first implementation I tried.
> > > >=20
> > > > > But just the whole idea of keeping track of some special circumst=
ances
> > > > > under which IDs are meaningful seems wrong... All this logic is
> > > > > complicated, now we are adding another layer of complexity on top=
. And
> > > > > the complexity is not in the code, it's in thinking about all pos=
sible
> > > > > scenarios and their interactions.
> > > >=20
> > > > I agree that adding more layers is a complication in itself.
> > > > Thank you for your input.
> > > >=20
> > > > > > [...]
> > > >=20
> >=20


