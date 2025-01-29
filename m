Return-Path: <bpf+bounces-50024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C595A218C0
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 09:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB93165A68
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8F199E84;
	Wed, 29 Jan 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f7VyE5jl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MimCJlxB"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BA190665
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138651; cv=none; b=QlQ23UxZlAUs+YSovgAYafnWWCyG43nOAoqOBeHyP3CYb61gL7vHC6qXcAd3Bck7SzhHB87e6r5IUI8sLblIle8WJHQvofzljZxX5I7kQvglFNXyUiXpoTmZkE2EX1izc6p4C0jgpk2vh4olK1YXSXf4/hlZ6tNbp91/l1b9L6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138651; c=relaxed/simple;
	bh=UroWcRB17LjL6KOfHOUVBAVoQiHB6oRzVu2kG52FCWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O22Cy4rtHOS3mZZdgirSDaCKkLWgh8I4XAuFcwerH02RMmEn2bq6EdsiPILTRF/waxXSfQVEXcGCc3flLbKBhLKvvPuy7EIQsF5yp90Gg60TRDaZ7FjknSWtJ508Eo7L5HxZfwZAoTbECeagNB2yQncIs3NUAeMoB9Zv1cXt+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f7VyE5jl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MimCJlxB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Jan 2025 09:17:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738138647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubwupqMU7Aau/E7dbQGwTNwl8txzA7eXEiahExGy9ko=;
	b=f7VyE5jlkeMJYQW+38wMyNw1JoDJCSfqaIFhvRQi2Wn5ny//hE7VhEK8cY2IDTyffME3WE
	UNiGP89/Y9a3QrrvG7T6Mb6goiuIUSKYaDYZNEJ0HL/M7BuMH93OrdL4p6HbVPH+d7Ndly
	XTOx3GI8Px/TrCRGscaDHCZ1zElTWB84STX4fp1Bkzs++MKe7n1v0nFOHmfk0tXTy0KnpT
	qOWx5jadgIRjW9Zu4UJ7VOAn3J21ep1MJwEW6iRB0oBZRApbqwpxs4+FiB+p3d0RyLPPRS
	bryEU1K1kHmC9H04T3qLzupUmDefcu/tXuKMrrFJ/y6W2CYU8v+jgWqjhMxCEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738138647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubwupqMU7Aau/E7dbQGwTNwl8txzA7eXEiahExGy9ko=;
	b=MimCJlxB6a/6gptRkHvVOAV5C8ZGLogrWeMJaZH0qKU5uRqcyXwlgDS0y3btGfhC2wRgF4
	BR5LfQoqCWVlhABA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v6 3/6] locking/local_lock: Introduce
 local_trylock_t and local_trylock_irqsave()
Message-ID: <20250129081726.vGHs_2kD@linutronix.de>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <20250124035655.78899-4-alexei.starovoitov@gmail.com>
 <20250128172137.bLPGqHth@linutronix.de>
 <CAADnVQ+6YD=jzx08ynUDo=ptFbD62o17ozymFfycF5WbPb9GbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAADnVQ+6YD=jzx08ynUDo=ptFbD62o17ozymFfycF5WbPb9GbA@mail.gmail.com>

PeterZ, may I summon you.

On 2025-01-28 10:50:33 [-0800], Alexei Starovoitov wrote:
> On Tue, Jan 28, 2025 at 9:21=E2=80=AFAM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2025-01-23 19:56:52 [-0800], Alexei Starovoitov wrote:
> > > Usage:
> > >
> > > local_lock_t lock;                     // sizeof(lock) =3D=3D 0 in !RT
> > > local_lock_irqsave(&lock, ...);        // irqsave as before
> > > if (local_trylock_irqsave(&lock, ...)) // compilation error
> > >
> > > local_trylock_t lock;                  // sizeof(lock) =3D=3D 4 in !RT
> > > local_lock_irqsave(&lock, ...);        // irqsave and active =3D 1
> > > if (local_trylock_irqsave(&lock, ...)) // if (!active) irqsave
> >
> > so I've been looking at this for a while and I don't like the part where
> > the type is hidden away. It is then casted back. So I tried something
> > with _Generics but then the existing guard implementation complained.
> > Then I asked myself why do we want to hide much of the implementation
> > and not make it obvious.
>=20
> Well, the idea of hiding extra field with _Generic is to avoid
> the churn:
>=20
> git grep -E 'local_.*lock_irq'|wc -l
> 42

This could be also hidden with a macro defining the general body and
having a place holder for "lock primitive".

> I think the api is clean enough and _Generic part is not exposed
> to users.
> Misuse or accidental usage is not possible either.
> See the point:
> if (local_trylock_irqsave(&lock, ...)) // compilation error
>=20
> So imo it's a better tradeoff.
>=20
> > is this anywhere near possible to accept?
>=20
> Other than churn it's fine.
> I can go with it if you insist,
> but casting and _Generic() I think is cleaner.
> Certainly a bit unusual pattern.
> Could you sleep on it?

The cast there is somehow=E2=80=A6 We could have BUILD_BUG_ON() to ensure a
stable the layout of the structs=E2=80=A6 However all this is not my call.

PeterZ, do you have any preferences or an outline what you would like to
see here?

> I can do s/local_trylock_t/localtry_lock_t/.
> That part is trivial.

Sebastian

