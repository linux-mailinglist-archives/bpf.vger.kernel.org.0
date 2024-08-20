Return-Path: <bpf+bounces-37648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C52F958DB7
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 20:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA801C21B8C
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A271BD507;
	Tue, 20 Aug 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMpjauNj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726CF10A24;
	Tue, 20 Aug 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176887; cv=none; b=F34W8mnT75Y4Y/oK5jvJd47Vh4ZbVjcPSEUHmnzPTZSWd9jHmOs7aFFctSLrNT02+QqRFLf8rklbkqpbicp0pmPkmN6KtV0l3Kh7Z6dYoFBcDa9m4t797jHmXbF/vHU6QFmbzSKn861i2Q1uPk+BhS1vRXSsMra7Obcb+S5owO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176887; c=relaxed/simple;
	bh=bV34x7MYYztAMqSEYzWOGsAv/cwdogusL3EtVW2BvRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7XVtDOV8ehrfhj5li+7iwiAN900rGUVLphoHwhlUN0Ju+KEZLPtPrb84YarKawwsOJ75YNwPoFBr0vkFoizoHX1rv1DefFPXGOpe/DslD4wEOffV/efeZJPnleYg/GvdJVB5LqyT842wQds3XzaWy8p48oeWKjp2CSYqBFAEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMpjauNj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201f7fb09f6so41322345ad.2;
        Tue, 20 Aug 2024 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724176886; x=1724781686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW2EDQsveDHftwUoUVuswpkNq+gO1+8ZL6TivHjfcJ0=;
        b=LMpjauNjWCcto40/tLFancuyAdZcJR55pFuX7AIwaL7poNB9tIj9ni2J0lw3J9veJC
         Zl+EXEezIYbEsrBQmrBR5vj0JYAtS9Wgyq4EIbHB1+Y4Kv70EXw/CD0MVxesVTX2PFol
         hrTSVQtkMdhm8Dw7Sf61uzWBTwAeNXDR3OSbRwlaUtzcywjpE/b6yTCA5q2B5RAGfH1d
         JAY8geaVZd53PZXKwnISvWGv9NHGKzoaaog0r1nMbi74MTokwDpHS2Gcijqu8QBqldmV
         EE2TJkmw/ljtTPghIPUFFABzx66lSerrIp4Ve3Ktqeqb60gwVjz3Aj/uMdXOXkkvfBzm
         TbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724176886; x=1724781686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XW2EDQsveDHftwUoUVuswpkNq+gO1+8ZL6TivHjfcJ0=;
        b=Uv1Qou6Xa0L2kLQeW7vNxq7CqAUntB07pUtWpNWbLqo574n70XdP4qe5BKWAWHhEyA
         uQp06r8Bmp9n/55zKmXtzjt5NiMsOzoqG423vszMDlL4AkZ88liQuBdPX56rpXPPM82w
         1rtYJzvHHcnqjx3CSbyJtatZ7+Q5e7DOM6NXq9AGrtL0xsdzdHrdfkvPbd9/DEKMebRl
         HLa3N6QmLA4sv82I5T6qDrAlh+xRIGxR8d+7a9l6w2ZcDgxwTgBMWHL8doXQToNnyBa2
         oI1aoI1537JEJWX22hpnQXHo+zZ5aG4EhZb+RBUMqK50X/cCf/oq689fEm1ccGKQvKqp
         3K2A==
X-Forwarded-Encrypted: i=1; AJvYcCUUsOIbLxZivOM9nWhjkuYnHnN+EuJAf8PUM1uZ+COJvN/pF+MIW+aSFm2th2v2dYhjv6/gIoi96E/4fE73@vger.kernel.org, AJvYcCXkZsiekaqWTGbzxoHmul943ZYWS4gN9EOARrM8NMf+sEwwRFffkytuFuomE8cN+mEyZj3lIv2iMjahzpR58rGoDaL+@vger.kernel.org, AJvYcCXr6TnoeCq5nNsrFOwdSd8G+sPpbAnnpxbxHnLsOTti2lGJMibjWuICFdhakCr46QYq598=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8x0D3wlo8mbd23ze9Zf+yzHlMWeZjzOKm1TKoT9aeu8DAKrvE
	zRezd/adggCABHCh79cdw0OcvqKA3onYw1s4rEv1uF4WjLI2lS0fCObHIPwMIx0hYiuIalktWwz
	arETI4DmN8WGe6m1+avx+xE88nvs=
X-Google-Smtp-Source: AGHT+IH+ytdwRHSzvQk3nNnD41x0T2rOFsEZheRcnQGQLslFa+6HExdYnCpFoslduDeAxl5b3tb0cFOh9PB4zP2KLbg=
X-Received: by 2002:a17:90a:744a:b0:2c9:61ad:dcd9 with SMTP id
 98e67ed59e1d1-2d3e00ec17dmr14073007a91.27.1724176885685; Tue, 20 Aug 2024
 11:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-10-andrii@kernel.org>
 <20240819134107.GB3515@redhat.com> <CAEf4BzYFXmCU83mr9YHy2JtF35WmYBvKpyrmBV4QxFuqubk_6A@mail.gmail.com>
 <20240820150534.GD12400@redhat.com>
In-Reply-To: <20240820150534.GD12400@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Aug 2024 11:01:13 -0700
Message-ID: <CAEf4Bzb7gQEKk26B4-KXS_ht8LyCRA7SdThc7ZS05gOEuNZjrQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 09/13] uprobes: SRCU-protect uretprobe lifetime
 (with timeout)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:06=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/19, Andrii Nakryiko wrote:
> >
> > On Mon, Aug 19, 2024 at 6:41=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > On 08/12, Andrii Nakryiko wrote:
> > > >
> > > > Avoid taking refcount on uprobe in prepare_uretprobe(), instead tak=
e
> > > > uretprobe-specific SRCU lock and keep it active as kernel transfers
> > > > control back to user space.
> > > ...
> > > >  include/linux/uprobes.h |  49 ++++++-
> > > >  kernel/events/uprobes.c | 294 ++++++++++++++++++++++++++++++++++--=
----
> > > >  2 files changed, 301 insertions(+), 42 deletions(-)
> > >
> > > Oh. To be honest I don't like this patch.
> > >
> > > I would like to know what other reviewers think, but to me it adds to=
o many
> > > complications that I can't even fully understand...
> >
> > Which parts? The atomic xchg() and cmpxchg() parts? What exactly do
> > you feel like you don't fully understand?
>
> Heh, everything looks too complex for me ;)

Well, the best code is no code. But I'm not doing this just for fun,
so I'm happy with the simplest solution *that works*.

>
> Say, hprobe_expire(). It is also called by ri_timer() in softirq context,
> right? And it does
>
>         /* We lost the race, undo our refcount bump. It can drop to zero.=
 */
>         put_uprobe(uprobe);
>
> How so? If the refcount goes to zero, put_uprobe() does mutex_lock(),
> but it must not sleep in softirq context.
>

Now we are talking about specific issues, thank you! It's hard to
discuss "I don't like".

Yes, I think you are right and it is certainly a problem with
put_uprobe() that it can't be called from softirq (just having to
remember that is error-prone, as is evidenced by me forgetting about
this issue).

It's easy enough to solve. We can either schedule work from timer
thread (and that will solve this particular issue only), or we can
teach put_uprobe() to schedule work item if it drops refcount to zero
from softirq and other restricted contexts.

I vote for making put_uprobe() flexible in this regard, add
work_struct to uprobe, and schedule all this to be done in the work
queue callback. WDYT?

>
> Or, prepare_uretprobe() which does
>
>         rcu_assign_pointer(utask->return_instances, ri);
>
>         if (!timer_pending(&utask->ri_timer))
>                 mod_timer(&utask->ri_timer, ...);
>
> Suppose that the timer was pending and it was fired right before
> rcu_assign_pointer(). What guarantees that prepare_uretprobe() will see
> timer_pending() =3D=3D false?
>
> rcu_assign_pointer()->smp_store_release() is a one-way barrier. This
> timer_pending() check may appear to happen before rcu_assign_pointer()
> completes.
>
> In this (yes, theoretical) case ri_timer() can miss the new return_instan=
ce,
> while prepare_uretprobe() can miss the necessary mod_timer(). I think thi=
s
> needs another mb() in between.
>

Ok, that's fair. I felt like this pattern might be a bit problematic,
but I also felt like it's good to have to ensure that we do
occasionally have a race between timer callback and uretprobe, even if
uretprobe returns very quickly. (and I did confirm we get those races
and they seem to be handled fine, i.e., I saw uprobes being "expired"
into refcounted ones from ri_timer)

But the really simple way to solve this is to do unconditional
mod_timer(), so I can do just that to keep this less tricky. Would you
be ok with that?

>
> And I can't convince myself hprobe_expire() is correct... OK, I don't
> fully understand the logic, but why data_race(READ_ONCE(hprobe->leased)) =
?
> READ_ONCE() should be enough in this case?

you mean why data_race() annotation? To appease KCSAN, given that we
modify hprobe->leased with xchg/cmpxchg, but read here with
READ_ONCE(). Maybe I'm overthinking it, not sure. There is a reason
why this is an RFC ;)

>
>
> > > As I have already mentioned in the previous discussions, we can simpl=
y kill
> > > utask->active_uprobe. And utask->auprobe.
> >
> > I don't have anything against that, in principle, but let's benchmark
> > and test that thoroughly. I'm a bit uneasy about the possibility that
> > some arch-specific code will do container_of() on this arch_uprobe in
> > order to get to uprobe,
>
> Well, struct uprobe is not "exported", the arch-specific code can't do th=
is.
>

Ah, good point, that's great. But as I said, uretprobe is actually
*the common* use case, not single-stepped uprobe. Still not very happy
about that memcpy() and assumption that it's cheap, but that's minor.

But no matter what we do for single-stepped one, uretprobe needs some
solution. (and if that solution works for uretprobe, why wouldn't it
work for single-step?...)

> Oleg.
>

