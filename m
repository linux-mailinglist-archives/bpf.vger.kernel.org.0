Return-Path: <bpf+bounces-1548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AF0718B36
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1AD1C2082F
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A4B3D393;
	Wed, 31 May 2023 20:31:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32653D38E
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:31:10 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7512C
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:31:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f3b9755961so7267952e87.0
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685565067; x=1688157067;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AODRDepThwKQUrujmvVDpKNQoxwkAIkRwuAgq2d6yyo=;
        b=eZgUBiIMEQMnGNxUrrFeXUfadwj5iorejAYwRfxtfs8021yVa4UvFQR27gRV/f1d5t
         JQZWjWHzXYWlIiriWJwxH0jzukC64tp2ByUU2SqKfGQD3NBWVvsgnDGzD+khiwaBteST
         rUKEkEIggSyMzg4HPD4chRvz96i+pM54MVZ1iLadXJYpo3diJ07JV+czMjjCG8+HfQw1
         GyRuETrH5MlXOMxC8Ns313jJ2t9OejSKM5NX28C+xJkNjbH0SyItj735PB5X9UeI+dIQ
         2XuJxjOl3Prsi5djQWzT1SqQoKRglOudBRmvfBDAd0gerXox23+RXYcT6oEfSzyhT5Xm
         N6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685565067; x=1688157067;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AODRDepThwKQUrujmvVDpKNQoxwkAIkRwuAgq2d6yyo=;
        b=ch3xhb03BwMLpub8o2LCWqkjbI3Y4yXuZDlrdepiwWVJEk2g6pzgjj7G2wG1i0ZaTJ
         b1aawyhTHkp1sCNZHSmhb3lloJiYWt6jnSJSCuNzKfeCDGwkXeFrNl6GVbzJEgC9O4EY
         iUvmkVNK6DfkIPp1c+v6kGKKEzrM1e4+7IUfMBJlLn7IXgjXphAOSnpOd8jItFIA39vV
         xt0hZSHCwlad5/Vtk0NDGCq6nI6Ht/ZbdaGPHbEW9Mav6I+5537ZBaSvqQ17CJb/oISz
         Vp+FkLVIjgSeSgZ3Gsv9jv1kUbcPw6bjlaQpI6nG440zucI+aU3oc9WwDj95A0xkPIuw
         3zJA==
X-Gm-Message-State: AC+VfDyq1ON4pFoM56tADY78+Km4oFMNsZPBA0UmUewv5Em6XKlPb+MU
	dVW4ZknVrzeeZoCvV1kfaO4=
X-Google-Smtp-Source: ACHHUZ49A3Z9XbPt7F/J9DNUiSSbcqMVHKGBXFmhHef3UWRwStpvf0vfixsEAf73RUvXbhgrcj/TAw==
X-Received: by 2002:ac2:52a6:0:b0:4db:2ab7:43e6 with SMTP id r6-20020ac252a6000000b004db2ab743e6mr80288lfm.44.1685565066386;
        Wed, 31 May 2023 13:31:06 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r10-20020a19ac4a000000b004f00c854d34sm839793lfc.204.2023.05.31.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 13:31:05 -0700 (PDT)
Message-ID: <aa64ee05281ec952df41b7a7842ed2836ae79762.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Wed, 31 May 2023 23:31:04 +0300
In-Reply-To: <CAEf4BzYE_7m3FNc6dtZeKb6tNbW4xkhz6SVdV6KetD5reSer6A@mail.gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <f2abf39bcd4de841a89bb248de9e242a880aaa93.camel@gmail.com>
	 <CAEf4BzYjvjbm9g1N9Z04kXV1N3+KH+dZ_sq_0NWuhyuJ+A18UQ@mail.gmail.com>
	 <a13ee48ac037d0dbb6796c7ea5965140ec7ef726.camel@gmail.com>
	 <CAEf4BzYE_7m3FNc6dtZeKb6tNbW4xkhz6SVdV6KetD5reSer6A@mail.gmail.com>
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

On Wed, 2023-05-31 at 13:12 -0700, Andrii Nakryiko wrote:
> On Wed, May 31, 2023 at 12:30=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Wed, 2023-05-31 at 11:29 -0700, Andrii Nakryiko wrote:
> > > On Wed, May 31, 2023 at 10:21=E2=80=AFAM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > >=20
> > > > On Tue, 2023-05-30 at 14:37 -0700, Andrii Nakryiko wrote:
> > > > [...]
> > > > > Also, it might make sense to drop SCALAR register IDs as soon as =
we
> > > > > have only one instance of it left (e.g., if "paired" register was
> > > > > overwritten already). I.e., aggressively drop IDs when they becom=
e
> > > > > useless. WDYT?
> > > >=20
> > > > I added modification which resets sole scalar IDs to zero before
> > > > states comparison, it shows some speedup but is still slow:
> > > >=20
> > > >   Filter        | Number of programs | Number of programs
> > > >                 | patch #1           | patch #1 + sole scalar ID pr=
uning
> > > >   -----------------------------------------------------------------=
-----
> > > >   states_pct>10 | 40                 | 40
> > > >   states_pct>20 | 20                 | 19
> > > >   states_pct>30 | 15                 | 13
> > > >   states_pct>40 | 11                 | 8
> > > >=20
> > > > (Out of 177 programs).
> > > >=20
> > > > I'll modify mark_chain_precision() to propagate precision marks for
> > > > find_equal_scalars(), so that it could be compared to current patch=
 #3
> > > > in terms of code complexity and verification performance.
> > > >=20
> > > > If you have any thoughts regarding my previous email, please share.
> > > >=20
> > >=20
> > > Yep, I do. Given SCALAR registers with the same ID are meant to "shar=
e
> > > the destiny", shouldn't it be required that when we mark r6 as precis=
e
> > > we should automatically mark linked r7 as precise at the same point.
> > > So in your example:
> > >=20
> > > 7: r9 +=3D r6
> > >=20
> > > should be where we request both r6 and r7 (and whatever other registe=
r
> > > has the same ID) to be marked as precise. It should be very easy to
> > > implement, especially given my recent refactoring with
> > > mark_chain_precision_batch.
> >=20
> > Ok, I'll modify the `struct backtrack_state` as follows:
> >=20
> >   struct backtrack_state {
> >         struct bpf_verifier_env *env;
> >         u32 frame;
> >         u32 reg_masks[MAX_CALL_FRAMES];
> > +       u32 reg_ids[MAX_CALL_FRAMES];
> >         u64 stack_masks[MAX_CALL_FRAMES];
> > +       u64 stack_ids[MAX_CALL_FRAMES];
> >   };
> >=20
> > And add corresponding logic to backtrack_insn().
>=20
> I don't see why you need to change anything about backtrack_state at
> all, so we are not on the same page.
>=20
> What I propose is that in mark_chain_precision(), when given regno, go
> over all *current* registers with the same ID, and set all of them as
> "to be marked precise". And then call mark_chain_precision_batch().
> See propagate_precision() for how we do similar stuff for bulk
> precision propagation.
>=20
> backtrack_state shouldn't need to know about IDs, unless I'm missing some=
thing

Consider a modified version of the original example:

  1: r9 =3D ... some pointer with range X ...
  2: r6 =3D ... unbound scalar ID=3Da ...
  3: r7 =3D ... unbound scalar ID=3Db ...
  4: if (r6 > r7) goto +1
  5: r7 =3D r6
  6: if (r7 > X) goto ...
  7: r7 =3D 0
  8: r9 +=3D r6

Suppose verification path is 1-8, the ID assignments are:

                            r6.id r7.id
  4: if (r6 > r7) goto +1   a     b
  5: r7 =3D r6                a     a
  6: if (r7 > X) goto ...   a     a
  7: r7 =3D 0                 a     -
  8: r9 +=3D r6               a     -

When mark_chain_precision() is called at (8) it no longer knows that
r6 and r7 shared the same ID at some point in the past. What you
suggest won't work in this case, what I suggest won't work as well.

Looks like the only way to do it correctly is to save ID assignments
after each find_equal_scalars() (for (6) in this example) in the
bpf_verifier_state, and use this information in backtrack_insn().
For example, extend jmp_history.

>=20
> >=20
> > > The question I have (and again, haven't spent any time thinking about
> > > any other corner cases, sorry) is whether that alone would be a prope=
r
> > > fix?
> >=20
> > As far as I understand, in terms of correctness it would be a proper fi=
x.
> > In terms of performance, I hope that it would be enough but we will see=
.
>=20
> ok, let's try that then, before we commit to u32_hashset stuff
>=20
> >=20
> > > As for this u32_hashset, it just feels like a big overkill, tbh. If w=
e
> > > have to do something like that, wouldn't it be better to, say, set
> > > highest bit in reg->id (for all linked registers, of course) to mark
> > > it as "used for range checks" instead of maintaining a separate check=
?
> >=20
> > Unfortunately no, because this ID change would have to be propagated
> > backwards. It was the first implementation I tried.
> >=20
> > > But just the whole idea of keeping track of some special circumstance=
s
> > > under which IDs are meaningful seems wrong... All this logic is
> > > complicated, now we are adding another layer of complexity on top. An=
d
> > > the complexity is not in the code, it's in thinking about all possibl=
e
> > > scenarios and their interactions.
> >=20
> > I agree that adding more layers is a complication in itself.
> > Thank you for your input.
> >=20
> > > > [...]
> >=20


