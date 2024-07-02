Return-Path: <bpf+bounces-33595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15791ECB6
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 03:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB6F1C212B4
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD2883D;
	Tue,  2 Jul 2024 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuLXdtJQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2452F43;
	Tue,  2 Jul 2024 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719884111; cv=none; b=VAp7zLJivUf3np5hL0BCmofHUsUTGXEScHMl4+aBAZEp9qH1/zwWg6wqVhHDPm8ZllE7Ptnpmhj50VZx8bf8mx0Q3ipoRg/D0+4K2ItNG4oFNm5c9TdvPFRRmJPDesy0B3MAYBLAaH4Y3VKzmdo3DUxluUSaEeZ+2TEmG06BfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719884111; c=relaxed/simple;
	bh=PIzYFOK0PDzkUyIeOB5c2a9FdJS+U+iXhHuKC468duk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/rO8dVZo/Ou+PuNYxR02sVZ+qbBhZN+OVEBbvhxIMv0SdGBc/Xpn4PwgR4gcfuDKJeDHC17Tgx6zkH4Q+FShVKK/RzAIUOvMfcBSXYHfMVRKJ4LkeqM2J/ytkvgekLqwPA46TlYpVe4o9MPTZo8KPCdln9M2ucWlrvZfr+O71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuLXdtJQ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d55f198f1eso1812100b6e.0;
        Mon, 01 Jul 2024 18:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719884108; x=1720488908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBXXf8pITsw6l4LfxVnWjvzW94GQwfP4c3NRXFnNIJE=;
        b=ZuLXdtJQJh6kKTY0qUMFa8ubwDW1h3o3cz+Lj7946m3SLAGIck+9F45k0Bo9tjkAYA
         vylNt4OWmidCov7qCTMjUlzVyxpQ3LHWfuru5d4wYDjh+cJAyZNv3uWKielco9+FxQGN
         CcEMXAP2UsKeoM9j6Bd3YlObO/ekQdwKI6MWM+Nqi+nwRC3RB+qzmyoCpwiDxI1tR5mc
         5CrHypbJAkePwd9b4L1fOOpHUuhOrGbtLKPblLzqC68WZw8lHc28TEQa6u2VNBsNrHb/
         fX8W9FYAvFkPXZ5g66uHKr9idnMI3ECJUYW55iIydc63t0uKFrIOukpNjaURzNnKZ+WW
         MRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719884108; x=1720488908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBXXf8pITsw6l4LfxVnWjvzW94GQwfP4c3NRXFnNIJE=;
        b=fFP4YOk64EseBxPKO0Sf4SAhMNI07zxmcGY8PDfPFovzAt6bvBVkMSLekox1efmUqI
         AU3mwCIfTulD69b9bU71AaqvqV4yn+r9fCYCLpn7WOj5JujcThrgYNzBXu+95Taz8TOo
         cBCMO9JRu/yywz/9MBD5XZc3jy6DmgIFFOpZD0b7lVsV8fry/qhpLVqJpfdHNED8Wfrr
         UXf0xf3cNx3H1/h9iWcJW+6XIgepcF79ujNS90FrM6+xSLdcTS95NOUYzBST3A/Eu/n5
         w7xGR2GWd0pKXk4SxuSx1LmPJ9JOG/ffU7GqRFgpzjz32uxqONYQ4hKIb3oJLQA70Py+
         WRTA==
X-Forwarded-Encrypted: i=1; AJvYcCVOiQbQpOG3BNOHx+TF6JZOk3h1IZOQylIlIS3iv6Fb3MbqGiGT/AhiIFHEPL86DEkTmuBYNBvZRRTQVRLjEjfGddKwZ3ICDRpKkXLMIZJritAjW3ouYamowrkkgCK+ExdfYSPijkXz
X-Gm-Message-State: AOJu0YypYl/o86FobutGVrhBcEItWgzh7W1I68+XObae941z2OgB7UyG
	eLgKgt+GLvexiH6fRIHlIRuQkK9j7SN0VR600oNYf4lMHNcYLN7OfmGSddkA4kGVhCSedSMcQ+t
	XAzPTgIZ9Q9XdmXBIHt0+dYOqEyg=
X-Google-Smtp-Source: AGHT+IGkmEJ8753bYaETSqXEP7YS13zqav+d3S14tfqjdJeANw9bthaekf1H1Nt7Tv3PRqTjnZl3ZMMWgZ8Cbul+KWQ=
X-Received: by 2002:a05:6808:1416:b0:3d5:6344:fd9f with SMTP id
 5614622812f47-3d6b37b3ac8mr9816968b6e.31.1719884107383; Mon, 01 Jul 2024
 18:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-7-andrii@kernel.org>
 <20240627220449.0d2a12e24731e4764540f8aa@kernel.org> <CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
 <20240628152846.ddf192c426fc6ce155044da0@kernel.org> <CAEf4Bzbr-yFv6wPJ8P=GBth7jLLj58Y7D5NwcDbX4V8nAs1QmA@mail.gmail.com>
 <20240630083010.99ff77488ec62b38bcfeaa29@kernel.org> <CAEf4BzZh4ShURvqk-QxC5h1NpN0tjWMr1db+__gsCmr-suUNOQ@mail.gmail.com>
 <CAEf4BzbRQjK7nnR2nnw_hgYztPPxaSC6_qFTrdADy3yCki_wEA@mail.gmail.com> <20240702100151.509a9e45c04a9cfed0653e6f@kernel.org>
In-Reply-To: <20240702100151.509a9e45c04a9cfed0653e6f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 18:34:55 -0700
Message-ID: <CAEf4BzYShpT2fZKv3yZYxZA0Ha9JQXC3YQyJsjGB+T-yLOKs+Q@mail.gmail.com>
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister APIs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 6:01=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Mon, 1 Jul 2024 15:15:56 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Mon, Jul 1, 2024 at 10:55=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sat, Jun 29, 2024 at 4:30=E2=80=AFPM Masami Hiramatsu <mhiramat@ke=
rnel.org> wrote:
> > > >
> > > > On Fri, 28 Jun 2024 09:34:26 -0700
> > > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > > On Thu, Jun 27, 2024 at 11:28=E2=80=AFPM Masami Hiramatsu <mhiram=
at@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, 27 Jun 2024 09:47:10 -0700
> > > > > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > > On Thu, Jun 27, 2024 at 6:04=E2=80=AFAM Masami Hiramatsu <mhi=
ramat@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, 24 Jun 2024 17:21:38 -0700
> > > > > > > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > > > > >
> > > > > > > > > -static int __uprobe_register(struct inode *inode, loff_t=
 offset,
> > > > > > > > > -                          loff_t ref_ctr_offset, struct =
uprobe_consumer *uc)
> > > > > > > > > +int uprobe_register_batch(struct inode *inode, int cnt,
> > > > > > > > > +                       uprobe_consumer_fn get_uprobe_con=
sumer, void *ctx)
> > > > > > > >
> > > > > > > > Is this interface just for avoiding memory allocation? Can'=
t we just
> > > > > > > > allocate a temporary array of *uprobe_consumer instead?
> > > > > > >
> > > > > > > Yes, exactly, to avoid the need for allocating another array =
that
> > > > > > > would just contain pointers to uprobe_consumer. Consumers wou=
ld never
> > > > > > > just have an array of `struct uprobe_consumer *`, because
> > > > > > > uprobe_consumer struct is embedded in some other struct, so t=
he array
> > > > > > > interface isn't the most convenient.
> > > > > >
> > > > > > OK, I understand it.
> > > > > >
> > > > > > >
> > > > > > > If you feel strongly, I can do an array, but this necessitate=
s
> > > > > > > allocating an extra array *and keeping it* for the entire dur=
ation of
> > > > > > > BPF multi-uprobe link (attachment) existence, so it feels lik=
e a
> > > > > > > waste. This is because we don't want to do anything that can =
fail in
> > > > > > > the detachment logic (so no temporary array allocation there)=
.
> > > > > >
> > > > > > No need to change it, that sounds reasonable.
> > > > > >
> > > > >
> > > > > Great, thanks.
> > > > >
> > > > > > >
> > > > > > > Anyways, let me know how you feel about keeping this callback=
.
> > > > > >
> > > > > > IMHO, maybe the interface function is better to change to
> > > > > > `uprobe_consumer *next_uprobe_consumer(void **data)`. If caller
> > > > > > side uses a linked list of structure, index access will need to
> > > > > > follow the list every time.
> > > > >
> > > > > This would be problematic. Note how we call get_uprobe_consumer(i=
,
> > > > > ctx) with i going from 0 to N in multiple independent loops. So i=
f we
> > > > > are only allowed to ask for the next consumer, then
> > > > > uprobe_register_batch and uprobe_unregister_batch would need to b=
uild
> > > > > its own internal index and remember ith instance. Which again mea=
ns
> > > > > more allocations and possibly failing uprobe_unregister_batch(), =
which
> > > > > isn't great.
> > > >
> > > > No, I think we can use a cursor variable as;
> > > >
> > > > int uprobe_register_batch(struct inode *inode,
> > > >                  uprobe_consumer_fn get_uprobe_consumer, void *ctx)
> > > > {
> > > >         void *cur =3D ctx;
> > > >
> > > >         while ((uc =3D get_uprobe_consumer(&cur)) !=3D NULL) {
> > > >                 ...
> > > >         }
> > > >
> > > >         cur =3D ctx;
> > > >         while ((uc =3D get_uprobe_consumer(&cur)) !=3D NULL) {
> > > >                 ...
> > > >         }
> > > > }
> > > >
> > > > This can also remove the cnt.
> > >
> > > Ok, if you prefer this I'll switch. It's a bit more cumbersome to use
> > > for callers, but we have one right now, and might have another one, s=
o
> > > not a big deal.
> > >
> >
> > Actually, now that I started implementing this, I really-really don't
> > like it. In the example above you assume by storing and reusing
> > original ctx value you will reset iteration to the very beginning.
> > This is not how it works in practice though. Ctx is most probably a
> > pointer to some struct somewhere with iteration state (e.g., array of
> > all uprobes + current index), and so get_uprobe_consumer() doesn't
> > update `void *ctx` itself, it updates the state of that struct.
>
> Yeah, that should be noted so that if the get_uprobe_consumer() is
> called with original `ctx` value, it should return the same.
> Ah, and I found we need to pass both ctx and pos...
>
>        while ((uc =3D get_uprobe_consumer(&cur, ctx)) !=3D NULL) {
>                  ...
>          }
>
> Usually it is enough to pass the cursor as similar to the other
> for_each_* macros. For example, struct foo has .list and .uc, then
>
> struct uprobe_consumer *get_uprobe_consumer_foo(void **pos, void *head)
> {
>         struct foo *foo =3D *pos;
>
>         if (!foo)
>                 return NULL;
>
>         *pos =3D list_next_entry(foo, list);
>         if (list_is_head(pos, (head)))
>                 *pos =3D NULL;
>
>         return foo->uc;
> }
>
> This works something like this.
>
> #define for_each_uprobe_consumer_from_foo(uc, pos, head) \
>         list_for_each_entry(pos, head, list) \
>                 if (uc =3D uprobe_consumer_from_foo(pos))
>
> or, for array of *uprobe_consumer (array must be end with NULL),
>
> struct uprobe_consumer *get_uprobe_consumer_array(void **pos, void *head =
__unused)
> {
>         struct uprobe_consumer **uc =3D *pos;
>
>         if (!*uc)
>                 return NULL;
>
>         *pos =3D uc + 1;
>
>         return *uc;
> }
>
> But this may not be able to support array of uprobe_consumer. Hmm.
>
>
> > And so there is no easy and clean way to reset this iterator without
> > adding another callback or something. At which point it becomes quite
> > cumbersome and convoluted.
>
> If you consider that is problematic, I think we can prepare more
> iterator like object;
>
> struct uprobe_consumer_iter_ops {
>         struct uprobe_consumer *(*start)(struct uprobe_consumer_iter_ops =
*);
>         struct uprobe_consumer *(*next)(struct uprobe_consumer_iter_ops *=
);
>         void *ctx; // or, just embed the data in this structure.
> };
>

Yeah, I was thinking about something like this for adding a proper
iterator-based interface.

>
> > How about this? I'll keep the existing get_uprobe_consumer(idx, ctx)
> > contract, which works for the only user right now, BPF multi-uprobes.
> > When it's time to add another consumer that works with a linked list,
> > we can add another more complicated contract that would do
> > iterator-style callbacks. This would be used by linked list users, and
> > we can transparently implement existing uprobe_register_batch()
> > contract on top of if by implementing a trivial iterator wrapper on
> > top of get_uprobe_consumer(idx, ctx) approach.
>
> Agreed, anyway as far as it uses an array of uprobe_consumer, it works.
> When we need to register list of the structure, we may be possible to
> allocate an array or introduce new function.
>

Cool, glad we agree. What you propose above with start + next + ctx
seems like a way forward if we need this.

BTW, is this (batched register/unregister APIs) something you'd like
to use from the tracefs-based (or whatever it's called, I mean non-BPF
ones) uprobes as well? Or there is just no way to even specify a batch
of uprobes? Just curious if you had any plans for this.

> Thank you!
>
> >
> > Let's not add unnecessary complications right now given we have a
> > clear path forward to add it later, if necessary, without breaking
> > anything. I'll send v2 without changes to get_uprobe_consumer() for
> > now, hopefully my above plan makes sense to you. Thanks!
> >
> > > >
> > > > Thank you,
> > > >
> > > > >
> > > > > For now this API works well, I propose to keep it as is. For link=
ed
> > > > > list case consumers would need to allocate one extra array or pay=
 the
> > > > > price of O(N) search (which might be ok, depending on how many up=
robes
> > > > > are being attached). But we don't have such consumers right now,
> > > > > thankfully.
> > > > >
> > > > > >
> > > > > > Thank you,
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thank you,
> > > > > > > >
> > > > > > > > --
> > > > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

