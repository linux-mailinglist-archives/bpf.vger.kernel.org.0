Return-Path: <bpf+bounces-1549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE9718BAD
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 23:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13604281252
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9996C3C0A7;
	Wed, 31 May 2023 21:14:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710EB1640F
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 21:14:42 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDA1B3
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 14:14:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51496f57e59so303633a12.2
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685567678; x=1688159678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV0jS3iejnNuwuziiueqYq1WuHFFNyAp3awqFhkRN2Y=;
        b=cHz11a7CCWhPMW+tu+ubLEL0XKpOqmE3nO2YWziLxrqAicv2XELuYOl4lFIyNcuw5z
         HPHbVzkdLrbNZxs157GgjDuRoWMYW4p42wTrUJwR1JtcaiPYZLAwfpZandIBO2lpiPr3
         3+oyVTzXpA9nW0bdrVC/kvuGFG+dcqlmoz/+0ZLNS5uqAcshvWWKjyT1AcimHS8X5uQL
         Q3+H9LfRBu/u2I7fx8xa8hLBXXY/uF+FFEsL9gtxmPzVVS7MtwFk+wiGoXRgfSe454l+
         ym5DwDVDovZ+34dkAIOjuak/HPAQ3Qe+1BOuinz0JSojDp54EQkU7+LE0cvVBYSh7wiv
         Am8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685567678; x=1688159678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV0jS3iejnNuwuziiueqYq1WuHFFNyAp3awqFhkRN2Y=;
        b=bpw6iA7ggpbqiJ8AUmS+mgC7hgBoJhoOirx5BkQnDxpehXQar+acpqWZtW3KmTykyr
         g3c+Lo2+ubDlJ783gNWjAVPjUryBZaE6IEJ7O5LYSzsDQylI/qgiUPOwmfP3sGVxxX1k
         ifCUur2LA91fHC10GCEHRTwjhhkhe3vJhpiPPfuNLwNWrqxKY74fxHNa+zCKaACxFLdP
         e/qWIZPoj5IIz5tq3PNzwwvWlDE3mv70eDYuSEx+SpwRcQhNdWS/2zVet2nCZ/HNOHyb
         C/g0Ar9DFn79fTuu5Vlqk3eFt0oHN6Ub9gxYxpv8KOy/xaNsYsfTrcF0kGf5dyiGqu81
         vPBw==
X-Gm-Message-State: AC+VfDwK7N0Bamkt1ueQN8GxPG2cmXaMMY+cGUwmdxlbtpozXxrjUbWA
	B0Ct6Nt72fIetW3kpVG2YVXFJuiPTITlQfZt88h8wgR8z5c=
X-Google-Smtp-Source: ACHHUZ4Jk2BWWe1YUvlzrKP9so4FRcUGB6Qzlk/sYlk5kGSJPP7ytDVyNhZWgvxAgTzYE9xes11/LX+pdJCdo/mJG7k=
X-Received: by 2002:a05:6402:1296:b0:514:8e4a:2d72 with SMTP id
 w22-20020a056402129600b005148e4a2d72mr4623405edv.22.1685567677443; Wed, 31
 May 2023 14:14:37 -0700 (PDT)
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
 <CAEf4BzYE_7m3FNc6dtZeKb6tNbW4xkhz6SVdV6KetD5reSer6A@mail.gmail.com> <aa64ee05281ec952df41b7a7842ed2836ae79762.camel@gmail.com>
In-Reply-To: <aa64ee05281ec952df41b7a7842ed2836ae79762.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 May 2023 14:14:24 -0700
Message-ID: <CAEf4BzZVd2=QnXe-A_n9zBYKcsY=DiHhH3EG8yB9Cq5+8D5jcQ@mail.gmail.com>
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

On Wed, May 31, 2023 at 1:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-05-31 at 13:12 -0700, Andrii Nakryiko wrote:
> > On Wed, May 31, 2023 at 12:30=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Wed, 2023-05-31 at 11:29 -0700, Andrii Nakryiko wrote:
> > > > On Wed, May 31, 2023 at 10:21=E2=80=AFAM Eduard Zingerman <eddyz87@=
gmail.com> wrote:
> > > > >
> > > > > On Tue, 2023-05-30 at 14:37 -0700, Andrii Nakryiko wrote:
> > > > > [...]
> > > > > > Also, it might make sense to drop SCALAR register IDs as soon a=
s we
> > > > > > have only one instance of it left (e.g., if "paired" register w=
as
> > > > > > overwritten already). I.e., aggressively drop IDs when they bec=
ome
> > > > > > useless. WDYT?
> > > > >
> > > > > I added modification which resets sole scalar IDs to zero before
> > > > > states comparison, it shows some speedup but is still slow:
> > > > >
> > > > >   Filter        | Number of programs | Number of programs
> > > > >                 | patch #1           | patch #1 + sole scalar ID =
pruning
> > > > >   ---------------------------------------------------------------=
-------
> > > > >   states_pct>10 | 40                 | 40
> > > > >   states_pct>20 | 20                 | 19
> > > > >   states_pct>30 | 15                 | 13
> > > > >   states_pct>40 | 11                 | 8
> > > > >
> > > > > (Out of 177 programs).
> > > > >
> > > > > I'll modify mark_chain_precision() to propagate precision marks f=
or
> > > > > find_equal_scalars(), so that it could be compared to current pat=
ch #3
> > > > > in terms of code complexity and verification performance.
> > > > >
> > > > > If you have any thoughts regarding my previous email, please shar=
e.
> > > > >
> > > >
> > > > Yep, I do. Given SCALAR registers with the same ID are meant to "sh=
are
> > > > the destiny", shouldn't it be required that when we mark r6 as prec=
ise
> > > > we should automatically mark linked r7 as precise at the same point=
.
> > > > So in your example:
> > > >
> > > > 7: r9 +=3D r6
> > > >
> > > > should be where we request both r6 and r7 (and whatever other regis=
ter
> > > > has the same ID) to be marked as precise. It should be very easy to
> > > > implement, especially given my recent refactoring with
> > > > mark_chain_precision_batch.
> > >
> > > Ok, I'll modify the `struct backtrack_state` as follows:
> > >
> > >   struct backtrack_state {
> > >         struct bpf_verifier_env *env;
> > >         u32 frame;
> > >         u32 reg_masks[MAX_CALL_FRAMES];
> > > +       u32 reg_ids[MAX_CALL_FRAMES];
> > >         u64 stack_masks[MAX_CALL_FRAMES];
> > > +       u64 stack_ids[MAX_CALL_FRAMES];
> > >   };
> > >
> > > And add corresponding logic to backtrack_insn().
> >
> > I don't see why you need to change anything about backtrack_state at
> > all, so we are not on the same page.
> >
> > What I propose is that in mark_chain_precision(), when given regno, go
> > over all *current* registers with the same ID, and set all of them as
> > "to be marked precise". And then call mark_chain_precision_batch().
> > See propagate_precision() for how we do similar stuff for bulk
> > precision propagation.
> >
> > backtrack_state shouldn't need to know about IDs, unless I'm missing so=
mething
>
> Consider a modified version of the original example:
>
>   1: r9 =3D ... some pointer with range X ...
>   2: r6 =3D ... unbound scalar ID=3Da ...
>   3: r7 =3D ... unbound scalar ID=3Db ...
>   4: if (r6 > r7) goto +1
>   5: r7 =3D r6
>   6: if (r7 > X) goto ...
>   7: r7 =3D 0
>   8: r9 +=3D r6
>
> Suppose verification path is 1-8, the ID assignments are:
>
>                             r6.id r7.id
>   4: if (r6 > r7) goto +1   a     b
>   5: r7 =3D r6                a     a
>   6: if (r7 > X) goto ...   a     a
>   7: r7 =3D 0                 a     -
>   8: r9 +=3D r6               a     -
>
> When mark_chain_precision() is called at (8) it no longer knows that
> r6 and r7 shared the same ID at some point in the past. What you
> suggest won't work in this case, what I suggest won't work as well.

Let's not jump the gun here. If r6 and r7 are not linked anymore, then
a) precision of either r6 or r7 didn't matter before and b) r6
precision doesn't imply r7 precision anymore, because r7 is completely
independent now.

If there is some other code path at which r7's precise range would
matter, then a) in that other code path r6 and r7 would still be
linked and thus proposed precision tracking will mark both as precise,
or b) r7 would be already independent and precision tracking will mark
only r7 directly.

The way I see it, in a bit of an abstract way, if two registers are
linked through the same ID, then *until the point that they diverge*,
we have to make sure their states are the same. We do that with range
on each operation, but the precise bit is different, as it's
backtracked. So that's what my proposed fix to mark_precise_chain() is
doing: it makes sure we link precise bits for these registers
together. Yes, we will miss some intermediate state where r6 and r7
were linked, but if that link didn't matter (because neither r6 nor r7
were marked as precise at that point), then it effectively as if those
IDs were not even assigned at all.

BTW, as soon as one of the linked registers is modified, I hope we are
breaking the link and dropping the ID (I haven't checked the code, but
that is how it should work, I think). Please double check as you look
at this code, thanks!

Let's see if you can come up with another counterexample to this line
of thinking, I'm very open to me missing another detail, happens all
the time, but discussions like this are the only way to learn about
such details :)

>
> Looks like the only way to do it correctly is to save ID assignments
> after each find_equal_scalars() (for (6) in this example) in the
> bpf_verifier_state, and use this information in backtrack_insn().
> For example, extend jmp_history.
>
> >
> > >
> > > > The question I have (and again, haven't spent any time thinking abo=
ut
> > > > any other corner cases, sorry) is whether that alone would be a pro=
per
> > > > fix?
> > >
> > > As far as I understand, in terms of correctness it would be a proper =
fix.
> > > In terms of performance, I hope that it would be enough but we will s=
ee.
> >
> > ok, let's try that then, before we commit to u32_hashset stuff
> >
> > >
> > > > As for this u32_hashset, it just feels like a big overkill, tbh. If=
 we
> > > > have to do something like that, wouldn't it be better to, say, set
> > > > highest bit in reg->id (for all linked registers, of course) to mar=
k
> > > > it as "used for range checks" instead of maintaining a separate che=
ck?
> > >
> > > Unfortunately no, because this ID change would have to be propagated
> > > backwards. It was the first implementation I tried.
> > >
> > > > But just the whole idea of keeping track of some special circumstan=
ces
> > > > under which IDs are meaningful seems wrong... All this logic is
> > > > complicated, now we are adding another layer of complexity on top. =
And
> > > > the complexity is not in the code, it's in thinking about all possi=
ble
> > > > scenarios and their interactions.
> > >
> > > I agree that adding more layers is a complication in itself.
> > > Thank you for your input.
> > >
> > > > > [...]
> > >
>

