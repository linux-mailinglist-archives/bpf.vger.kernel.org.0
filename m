Return-Path: <bpf+bounces-54074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE601A61D8D
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 22:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD6418985FD
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 21:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1141A5B84;
	Fri, 14 Mar 2025 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRbDzyP2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95C190676
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986325; cv=none; b=Vno0rVUARc9OklPlOQQjkHwWWwYJlDTGsdNjyS5oqwHlKsmwRaZYyEP5zOxGgqXq8O2NuSUHjNY+jp1fRE+44jmKaG0oO8HzXjtkGX29onNMfaHA30SljF5QMIO7KxRKhNZytfogSynzkUmCh2TP7x7EPNNIbknlMfSifiUV694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986325; c=relaxed/simple;
	bh=PK4BAut0O9u0MyuPnp8VNqQbPw1Q7vwbcazeiPQAYe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1cmWV4PujMQWyiTNkxA4pM59bt8wndoJMLJsM/wOrMByI/7Xzxn3XDIHIWhLDwrWDGcTXBGGSJSZPZ8vUX49isNXLiUzHl/IhvzOSxEui2mhUwPm9Fw0Y7lDIYzAPxoXii+6+f8QOXdnR60yHTnuqWgPNo573vbhUSRTTLlDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRbDzyP2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39149bccb69so2278515f8f.2
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741986322; x=1742591122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7w6Uc54Hp4Z4ogU8idzqB5PDjE5SVF81UwFxvxvh5Y=;
        b=HRbDzyP22VdrsIlZ0TkukzF6S0uWuiYH4y4zY4WYdrIsnZs8zqP8c+eoIeQW8EL9sR
         CgiRmTDqEqD+iG19vtE4VLhSwvrYpQCI4Yju8pMwEnyq5koRypO5W7Qi2k470ivYYkKj
         8J7ctg5csiQ12BcMIhTDkPnoh6uMo+KZHZZBTAXkt+bQHh4GsX0KovM2kAow0CHAxf4l
         g+e1rgifNAhElvVZMDV3DHDEWGpsnAHXuhh8vXDqvrr0u/yG5/ZVg9Ij3hR7HdSICImJ
         6ruv+3K6qa1az8f9CJZagLAZDU2ZXrSyDYNW6QjlWLmPsvQPvseWxjf9g/5WrqAPFHCz
         VzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741986322; x=1742591122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7w6Uc54Hp4Z4ogU8idzqB5PDjE5SVF81UwFxvxvh5Y=;
        b=dk7LgFkwTqAXu3jJ4TRpV06GwRkXIgBdDBZsc26ppPF9vJV8MYVjW+l1s/QSwDjhdV
         V7ULiVNbIaiSzFzOgBVqudK9Zh4MRyFjbeRCitFrjCfNIamqSKG4GGduqv+IAaG6CANQ
         /lJnPRBju2ndGqnFoyoZ5ex3dnXHuo2WcYciWH8V7zgRFzhQQ6XoIINaiOtfQHbHwQ0x
         UazSPpbRzPhOfGNehqqM2PCb7BGrXNIA/3Hjghiw/GfD6hzBnuS1KqM0gudzUAxFwwW2
         VmeHNrzgJh1/GpgHOU1ZIRB3lNswmlX/Suh7k2wTBtg1SLo6Uc3uYoAt/nGtJPlg15UT
         t5NA==
X-Forwarded-Encrypted: i=1; AJvYcCUDmXkaJhp9YuNdet0i9hP4Kpc9HlS0E59RiGp5E+VcxVvrOtNKXHHp7eHqwIdDUmg4zhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Aj2uG8+0N2gAgdrZH4fpkgcLVkQSoHPy4bfXx2qd8e1WbLow
	MgJSe+m/Kk0/e4rt826pDhWnYKH+xqx3MO07RBjgzpoGT9k4oXa9UxOQdvGtstUl93GyuAuymIt
	uwqRxoekfXjRFZRzrBCI8otaiPXY=
X-Gm-Gg: ASbGncuYXAQUFWV5r5EyC8lAwnsFO4IN5v2KHu1DwVey5fRl4AAFAqBhID01o8qBgm8
	C+8q9/xPPkxP+xFS0GY31OSRPmqQ8RQgn4XKSOv/4YV9Owzz2nHOQGVXm6wYlnodobwOEbgKrY2
	JlIG3JG0u2iWh6JeQo9aO1zWTG8tgu2FE7nxwvpprGeg==
X-Google-Smtp-Source: AGHT+IFo13vCXBHtrlSWgGPCh8y5QQMU4cv7zNOU9SlNZjO1a1oUxuWBBplDhT7izEPAhcVB+QCkW2Zh/58maKTowiY=
X-Received: by 2002:a5d:598b:0:b0:38d:badf:9df5 with SMTP id
 ffacd0b85a97d-3971d2378a8mr4137708f8f.17.1741986321824; Fri, 14 Mar 2025
 14:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-2-alexei.starovoitov@gmail.com> <oswrb2f2mx36l6f624hqjvx4lkjdi26xwfwux2wi2mlzmdmmf2@dpaodu372ldv>
 <20250311162059.BunTzxde@linutronix.de> <CAGudoHEaGXwS1OQT_Af5YA=uw_zmUYy_csQ3nqYA_np+SbQ-cQ@mail.gmail.com>
 <b428858a-e985-4acc-95f4-4203afcb500a@suse.cz> <CAADnVQKP-oMrCyC2VPCEEXMxEO6+E2qknY8URLtCNySxwu8h0g@mail.gmail.com>
 <496ff0d2-97ac-41f5-a776-455025fb72db@suse.cz>
In-Reply-To: <496ff0d2-97ac-41f5-a776-455025fb72db@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Mar 2025 14:05:10 -0700
X-Gm-Features: AQ5f1JrTxff2qQvWoQ34z5jQ9hEz8VBsLUFbKhfnN4sPE5bEh5-m8am-auc_V8s
Message-ID: <CAADnVQJnZB52jvQDhA8XbhM3nd7O6PCms1jBKXx+F0jn+HA6fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/6] locking/local_lock: Introduce localtry_lock_t
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:29=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 3/11/25 23:24, Alexei Starovoitov wrote:
> > On Tue, Mar 11, 2025 at 9:21=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 3/11/25 17:31, Mateusz Guzik wrote:
> >> > On Tue, Mar 11, 2025 at 5:21=E2=80=AFPM Sebastian Andrzej Siewior
> >> > <bigeasy@linutronix.de> wrote:
> >> >>
> >> >> On 2025-03-11 16:44:30 [+0100], Mateusz Guzik wrote:
> >> >> > On Fri, Feb 21, 2025 at 06:44:22PM -0800, Alexei Starovoitov wrot=
e:
> >> >> > > +#define __localtry_lock(lock)                                 =
     \
> >> >> > > +   do {                                                    \
> >> >> > > +           localtry_lock_t *lt;                            \
> >> >> > > +           preempt_disable();                              \
> >> >> > > +           lt =3D this_cpu_ptr(lock);                        \
> >> >> > > +           local_lock_acquire(&lt->llock);                 \
> >> >> > > +           WRITE_ONCE(lt->acquired, 1);                    \
> >> >> > > +   } while (0)
> >> >> >
> >> >> > I think these need compiler barriers.
> >> >> >
> >> >> > I checked with gcc docs (https://gcc.gnu.org/onlinedocs/gcc/Volat=
iles.html)
> >> >> > and found this as confirmation:
> >> >> > > Accesses to non-volatile objects are not ordered with respect t=
o volatile accesses.
> >> >> >
> >> >> > Unless the Linux kernel is built with some magic to render this m=
oot(?).
> >> >>
> >> >> You say we need a barrier() after the WRITE_ONCE()? If so, we need =
it in
> >> >> the whole file=E2=80=A6
> >> >>
> >> >
> >> > I see the original local_lock machinery on the stock kernel works fi=
ne
> >> > as it expands to the preempt pair which has the appropriate fences. =
If
> >> > debug is added, the "locking" remains unaffected, but the debug stat=
e
> >> > might be bogus when looked at from the "wrong" context and adding th=
e
> >> > compiler fences would trivially sort it out. I don't think it's a bi=
g
> >> > deal for *their* case, but patching that up should not raise any
> >> > eyebrows and may prevent eyebrows from going up later.
> >> >
> >> > The machinery added in this patch does need the addition for
> >> > correctness in the base operation though.
> >>
> >> Yeah my version of this kind of lock in sheaves code had those barrier=
()'s,
> >> IIRC after you or Jann told me. It's needed so that the *compiler* doe=
s not
> >> e.g. reorder a write to the protected data to happen before the
> >> WRITE_ONCE(lt->acquired, 1) (or after the WRITE_ONCE(lt->acquired, 0) =
in
> >> unlock).
> >
> > I think you all are missing a fine print in gcc doc:
> > "Unless...can be aliased".
> > The kernel is compiled with -fno-strict-aliasing.
> > No need for barrier()s here.
>
> Note I know next to nothing about these things, but I see here [1]:
>
> "Whether GCC actually performs type-based aliasing analysis depends on th=
e
> details of the code. GCC has other ways to determine (in some cases) whet=
her
> objects alias, and if it gets a reliable answer that way, it won=E2=80=99=
t fall back
> on type-based heuristics. [...] You can turn off type-based aliasing
> analysis by giving GCC the option -fno-strict-aliasing."
>
> I'd read that as -fno-strict-aliasing only disables TBAA, but that does n=
ot
> necessary mean anything can be assumed to be aliased with anything?

That's correct.

> An if we e.g. have a pointer to memcg_stock_pcp through which we access t=
he
> stock_lock an the other (protected) fields and that pointer doesn't chang=
e
> between that, I imagine gcc can reliably determine these can't alias?

Though my last gcc commit was very long ago here is a simple example
where compiler can reorder/combine stores:
struct s {
   short a, b;
} *p;
p->a =3D 1;
p->b =3D 2;
The compiler can keep them as-is, combine or reorder even with
-fno-strict-aliasing, because it can determine that a and b don't alias.

But after re-reading gcc doc on volatiles again it's clear that
extra barriers are not necessary.
The main part:
"The minimum requirement is that at a sequence point all previous
accesses to volatile objects have stabilized"

So anything after WRITE_ONCE(lt->acquired, 1); will not be hoisted up
and that's what we care about here.

