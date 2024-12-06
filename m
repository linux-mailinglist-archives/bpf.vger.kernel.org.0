Return-Path: <bpf+bounces-46294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E19E779F
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAFF286AE5
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EEC2206B5;
	Fri,  6 Dec 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZE6lxxm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1922068A
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506948; cv=none; b=OKZ6oiYOdWwnctGj6h9wbsNHnbK36JfX5BWLvLNN2Cl8uReEKv5i9rWODux437SMzo7I6LVzP0JAXc3HsuZOherwJem4w8NWt5QUGusoi7PubwwKQ2cFcEZExtIKow4Kxa6tcKFDOkTcRZKYkBeGdHmPUBJFsMFg3xwxpn6wD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506948; c=relaxed/simple;
	bh=xeXnSh2ms0wdjjeFtnHtjD7mMjFMP2LrKAC25fK7/tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXzO3ssyBugftRHpx7Y7vSfirhygPdyYqXluSlnxtwLDhtjrG8NwmS7AiHRkBjv0w81cJz3tWuSNIdO1YWu96+krYJdUzuTzkO+tn0SaeTh9uklSvHWcfZZTNIDX7z2vt9Ua/tC0aEgHTXfEZd8ywv0sE4rbICGfmJ6Bprg+HqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZE6lxxm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724e1742d0dso2225515b3a.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733506946; x=1734111746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeXnSh2ms0wdjjeFtnHtjD7mMjFMP2LrKAC25fK7/tU=;
        b=cZE6lxxmaVM6SfD9fM58BOaRRonAhBNyANwdR6Oit8Z4RvKJgIKZOfc2h93xuo8Mzy
         s9+o1B9bBkS31cFqSCC1xFkJPVbYvGkHhbuxeJznTnIoDrt/iPsgkCbruz0tggk/9RNg
         b9fVOx3JoXHze1FpBtoEhDHHsDsT54tRdy5lU3jico51kPQlDFl5EJqu/VvrF94l0o5y
         GkgG2gPRoeXact+ONRslbOUqNsXxnspvh+EkmjOyr/WBjBKZqKEIWgvg8z6OHj4QiPpH
         ssddWnMFBbXag0E4jRfhI8lzTO7Gwcn3oBDx7OiTT5TaJE1JLcdy/NrYuvAZUU1CDs9u
         KmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506946; x=1734111746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeXnSh2ms0wdjjeFtnHtjD7mMjFMP2LrKAC25fK7/tU=;
        b=e2w5nA4AuTG+Cd1OXVncTZFpUIWRIn6xmInCnZZgm0OfAtESryQHwIzAe89m2xlV+b
         9bDg1hGpHDXV5ooHOX32J5+KgyV5NspAPbu3KY715iUHnAqjLagIF2Z8LbjrxiyWpsub
         0wXHBUKnCDPGteOJxtOdt6ao45tMjemF0w357Lap5Sw/Ggy2QD3KiPN6GI0/moKgeeqM
         FpqUXH/IvjD4CUm93er8Hh/z9BuR3NsnhdHAeBggtJBkgpVPg/JK/9DqOQstihOfKcy7
         txjNPWsWXTff4E+sG5aSn4Y+M/cqPilGxTt2ot9qlUHL4IghBm2293C9LgU2inhVVq/9
         jU3g==
X-Forwarded-Encrypted: i=1; AJvYcCWNIqkDwSFV1cYkc8wpMv/V92yVWiKcOFawQK3WWnRxV5ov/mhGQgI28HbZ++GVQYz/OgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyia68HNvo2ElvGJjAT1spjlMaXsGVjjBtEgCrgOtK0s+F/0Huw
	u+loypd3oj8D6vWV8xKokOXicc1HPO/V9Kh6JDOqGqxgdqlaHFwqefOJFbE2tJeRCwmzXOAYLFO
	qbBDh71g0Uc3RwhsZPL72tW/o4us=
X-Gm-Gg: ASbGncvSzH4KduwX5sFLRm0qugaFLiyRWUtl7hst8FmCxc8UQOGtrPQIkr2+uCOoTRH
	4yON1RgB3YqH1HhOVW0lJaWSn1ksTwnt5JPNspYFKEouaY04=
X-Google-Smtp-Source: AGHT+IHjbRmle4POSpbKAePRwUB2Vd4ckoZvkOeveKFlJYZIi+7R0BDz/97tEUnCedd/mRAFQH3PapqRYeMKodU5qcM=
X-Received: by 2002:a17:90a:d88e:b0:2ee:f687:6ad3 with SMTP id
 98e67ed59e1d1-2ef6ab0c2aamr5523931a91.28.1733506945005; Fri, 06 Dec 2024
 09:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
 <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com>
 <CAEf4BzZPFy1XXf=2mXVpdVw70rJjgUfPnDOzWb5ZXrJF1=XqUA@mail.gmail.com> <CAADnVQL-0SAvibeS45arBoZcwYjQjVnsrMeny=xzptOdUOwdjQ@mail.gmail.com>
In-Reply-To: <CAADnVQL-0SAvibeS45arBoZcwYjQjVnsrMeny=xzptOdUOwdjQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 09:42:12 -0800
Message-ID: <CAEf4BzZF3ZrVC0j=s2SpCyRWzfxS8Gcmh1vXomX4X=VS-COxJw@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, 
	Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:20=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 6, 2024 at 8:13=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Dec 6, 2024 at 8:08=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Dec 5, 2024 at 10:23=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 5, 2024 at 8:07=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > > >
> > > > > On Thu, 2024-12-05 at 17:44 -0800, Alexei Starovoitov wrote:
> > > > > > On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Eduard Zingerman <eddyz8=
7@gmail.com> wrote:
> > > > > > >
> > > > > > > so I went ahead and the fix does look simple:
> > > > > > > https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func=
-bug
> > > > > >
> > > > > > Looks simple enough to me.
> > > > > > Ship it for bpf tree.
> > > > > > If we can come up with something better we can do it later in b=
pf-next.
> > > > > >
> > > > > > I very much prefer to avoid complexity as much as possible.
> > > > >
> > > > > Sent the patch-set for "simple".
> > > > > It is better then "dumb" by any metric anyways.
> > > > > Will try what Andrii suggests, as allowing calling global sub-pro=
grams
> > > > > from non-sleepable context sounds interesting.
> > > > >
> > > >
> > > > I haven't looked at your patches yet, but keep in mind another gotc=
ha
> > > > with subprograms: they can be freplace'd by another BPF program
> > > > (clearly freplace programs were a successful reduction of
> > > > complexity... ;)
> > > >
> > > > What this means in practice is whatever deductions you get out of
> > > > analyzing any specific original subprogram might be violated by
> > > > freplace program if we don't enforce them during freplace attachmen=
t.
> > > >
> > > >
> > > > Anyways, I came here to say that I think I have a much simpler
> > > > solution that won't require big changes to the BPF verifier: tags. =
We
> > > > can shift the burden to the user having to declare the intent upfro=
nt
> > > > through subprog tags. And then, during verification of that global
> > > > subprog, the verifier can enforce that only explicitly declared sid=
e
> > > > effects can be enacted by the subprogram's code (taking into accoun=
t
> > > > lazy dead code detection logic).
> > > >
> > > > We already take advantage of declarative tags for global subprog ar=
gs
> > > > (__arg_trusted, etc), we can do the same for the function itself. W=
e
> > > > can have __subprog_invalidates_all_pkt_pointers tag (and yes, I do
> > > > insist on this laconic name, of course), and during verification of
> > > > subprogram we just make sure that subprog was annotated as such, if
> > > > one of those fancy helpers is called directly in subprog itself or
> > > > transitively through any of *actually* called subprogs.
> > >
> > > tags for args was an aid to the verifier. Nothing is broken without t=
hem.
> > > Here it's about correctness.
> > > So we cannot use tags to solve this case.
> >
> > Hm.. Just like without an arg tag, verifier would conservatively
> > assume that `struct task_struct *task` global subprog argument is just
> > some opaque memory, not really a task, and would verify that argument
> > and code working with it as such. If a user did something that
> > required extra task_struct semantics, then that would be a
> > verification error. Unless the user added __arg_trusted, of course.
> >
> > Same thing here. We *assume* that global subprog doesn't have this
> > packet pointers side effect. If later during verification it turns out
> > it does have this effect -- this is an error and subprog gets
> > rejected. Unless the user provided
> > __subprog_invalidates_all_pkt_pointers, of course. Same thing.
>
> So depending on the order of walking the progs, compiler layout,
> static vs global the extra tag is either mandatory or not.

How so? If the verifier can *reach* one of those special helpers
during verification, then this tag would be required *for global
subprog*.

Or, *importantly*, if user anticipates that "freplace-ment" BPF
program for such subprog might need to invalidate packet pointers, but
the default subprog implementation doesn't actually call any of those
special helpers, user can just explicitly say that "yes, this subprog
should be treated as such that invalidates pkt pointers". With your
approach there is no way to even express this, unless you hack default
subprog implementation to intentionally have reachable
pkt-invalidating helper, but not really call it at runtime.

Think about some more advanced XDP chainer approach, where replacement
slots would need this pkt invalidation capabilities (but default
subprogs just are no-ops).

> That is horrible UX. I really don't like moving the burden to the user
> when the verifier can see it all.

I disagree, but it doesn't matter. It's being clear and explicit about
functionality that global subprog (verified in isolation) needs right
now or might need later (e.g., due to freplace-ment)

> arg_ctx is different. The verifier just doesn't have the knowledge.

No, it's not. It's conceptually absolutely the same. Verifier can
derive that global subprog arg has to be a trusted pointer. It's just
that with pkt invalidation it's trivial enough to detect (crudely and
eagerly, but still) in check_cfg(), while for trusted pointers you
can't take this shortcut.

I don't like the check_cfg()-based approach, it's hacky and subpar
workaround, and goes against all the lazy verification philosophy we
pursued with BPF CO-RE. I'm happy to discuss this offline if that will
be easier to get through all the nuance, but if you guys insist, so be
it.

