Return-Path: <bpf+bounces-49977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C703A211D3
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 19:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722A21652D9
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97EF1DE4DB;
	Tue, 28 Jan 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaQa2xom"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C74C8E
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738090248; cv=none; b=ruolPoLvcrBrQaKWqVqHHoxYjY9jQJ0iTwDq1y0sBWwKn2R25u7f2+T9aESJ/UZwzP15dSxKDJ+wRTx/TPq9+RHrb5gB0JENIYX7dQKdf2hBpahAgNIbp4npPUmLmc17NK9/OZJd5LgpFIqvNs87JlYVZCgm52EYVBMGLmgt6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738090248; c=relaxed/simple;
	bh=Kqs1VxHJC37NUQUAD2ALJ0fgRcVS3YBYQCSmOPEpZZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dm5hfgjAgKWDrBmvaNgM9+VgpyVzbPBBG2ioGfm3vbP1KIC2ln25AYSMFoTngFnzZvY6t6gh4SoXfsChFR6EcSNtqR04+m7N91k6OQ6mZOWpf3W2AGK3sox4hO6iiEvsuz4MxHxbSOEVspeZxE4DycexLYVoaBDr4hBIkv8ZhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaQa2xom; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso5078437f8f.1
        for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 10:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738090245; x=1738695045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLXQcrpC08SByd+ekG3BltoeYgN1y40vQduPk+Om6Lk=;
        b=VaQa2xomryYYTFp8DhpftQpekPP0GyOKxKG2GHZ2afSnGR5Q8HyhiikqPxDk4TIyjB
         gm8oJwAbjR6OBpbvJEliR31HHG68gh11d3tmL33CTVKIPFU/pWQEroh1itBscKZSCGv1
         tFzgfa8f0SNe2Lt308Wi1rnmYdxIiVV2zMuMZpULgjvyStRmYd32xmmkmTLywHIaJV65
         i++V5V3sECRT5rr0hdRyGSN+oufdKVb6Dz1ebXXYL/2XIX8VMLvLxuE56rschJFTZ0zu
         VcCln+NGCwcdKstGXtE3v072eawNXeXIMVPmkJejauGhyekHwn4GK/jtOonEEC/7hZJU
         sHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738090245; x=1738695045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLXQcrpC08SByd+ekG3BltoeYgN1y40vQduPk+Om6Lk=;
        b=TkgvCEFrFiNAn0KzhghkAhDBRv8DRyoSbWYV5j98n4QRP4XRJJd+OZLflaz285+Clt
         2Rg1ec5FSabCvji7G/bwJwke6onx749Bifr+iT9lM14hwPDRbTy1T+Hryd2ujkeM/77t
         bibD58n0MuljwOFHP8906nUfhlWP6agC/6R8MPwugWPryeKr5jh+ol3ml+NRsIQD8cDi
         WS9a2RZG6MM010af2JE33qu3u6y056meQ9GRlCkTBbqnqQaycxMVZ2bBJXUT8Hd+DZpi
         z7fBWcyaZg+mTfBIKI55kQ3wNKzRedvL4bZjS+k1PLRVITK6HlI9GbXgwMTuxgXe3dlq
         JjYA==
X-Gm-Message-State: AOJu0YxEr2jXHNmaUzTMvCsBq2jx341qjanQ2GJi12uTlplDdYtgm//0
	CobtkC+9kuNgWPYHc/szxDJuoxtSEYwhg1DOZIglbYg4cRVKH0m6eUpbyF7yZW7ObK1nDButnBy
	fASkxiobIJg0yT/4tbP6bo6pS5/c=
X-Gm-Gg: ASbGnculF+V3npP3BDtPM+ld4ZLoRlBgSoQIlOcvmG5xiVbGaquxLwC5ZFJzz/s6Fgu
	oms3XiA5oNfV46KUzUFBr/gN4XqEoZuX1Mwh+LSKcLeaTTQ1+8lz8YLZg9pB2jhM7yvisBcHrTB
	ZrbWhLmDOEUvNV
X-Google-Smtp-Source: AGHT+IHjDaflJDaOKu497bYAZhLlqBgpcFCDaNmpjVxO83OSotXsSXFuV/+3V8Ekq4fD8EAQsS0nLH5J9ULpoI1MtTQ=
X-Received: by 2002:adf:ee8b:0:b0:382:3c7b:9ae with SMTP id
 ffacd0b85a97d-38c51943ddemr151840f8f.16.1738090244731; Tue, 28 Jan 2025
 10:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <20250124035655.78899-4-alexei.starovoitov@gmail.com> <20250128172137.bLPGqHth@linutronix.de>
In-Reply-To: <20250128172137.bLPGqHth@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Jan 2025 10:50:33 -0800
X-Gm-Features: AWEUYZmQeya52wJt1WtPmcR76uDPHzZwfAcbFoiZKNXeJJbMrPiSCWMzINgfJxM
Message-ID: <CAADnVQ+6YD=jzx08ynUDo=ptFbD62o17ozymFfycF5WbPb9GbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/6] locking/local_lock: Introduce
 local_trylock_t and local_trylock_irqsave()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 9:21=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-01-23 19:56:52 [-0800], Alexei Starovoitov wrote:
> > Usage:
> >
> > local_lock_t lock;                     // sizeof(lock) =3D=3D 0 in !RT
> > local_lock_irqsave(&lock, ...);        // irqsave as before
> > if (local_trylock_irqsave(&lock, ...)) // compilation error
> >
> > local_trylock_t lock;                  // sizeof(lock) =3D=3D 4 in !RT
> > local_lock_irqsave(&lock, ...);        // irqsave and active =3D 1
> > if (local_trylock_irqsave(&lock, ...)) // if (!active) irqsave
>
> so I've been looking at this for a while and I don't like the part where
> the type is hidden away. It is then casted back. So I tried something
> with _Generics but then the existing guard implementation complained.
> Then I asked myself why do we want to hide much of the implementation
> and not make it obvious.

Well, the idea of hiding extra field with _Generic is to avoid
the churn:

git grep -E 'local_.*lock_irq'|wc -l
42

I think the api is clean enough and _Generic part is not exposed
to users.
Misuse or accidental usage is not possible either.
See the point:
if (local_trylock_irqsave(&lock, ...)) // compilation error

So imo it's a better tradeoff.

> is this anywhere near possible to accept?

Other than churn it's fine.
I can go with it if you insist,
but casting and _Generic() I think is cleaner.
Certainly a bit unusual pattern.
Could you sleep on it?

I can do s/local_trylock_t/localtry_lock_t/.
That part is trivial.

