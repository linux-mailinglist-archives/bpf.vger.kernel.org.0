Return-Path: <bpf+bounces-55186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636C9A797C6
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 23:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2225C16DFAB
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 21:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F257A1F4624;
	Wed,  2 Apr 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPuSWme5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5278C91;
	Wed,  2 Apr 2025 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743630061; cv=none; b=HMKt18IcT/WKkADSMYLngEQS4MA6/Qvf3kRI+xE3HQOkDkUyzagqGYLgkO8E4+gTcixTqipdtx+YWekgMU/AGykuLqIJ4HDhbNIHqd/q0JU/SGW6egLbhTbMKY8k59ItJQRyoqTsz/r+6fjIjzaSj7l8q3iITZOe+ZzOECbebzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743630061; c=relaxed/simple;
	bh=FWgFicx3R6GR1dcwhsobS/nee2ZFoLoCDiDadGdYIws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiagXEEd4uxLgrAChtSdMP8C6ee10DI6PqZRBwuwINKe9LlyMkRxK1BB7Nd/gcwoyenPNTnVNmzHKX5Xq/eGK9145hMj6S+LyWfRMkdi3n1PVjpzLcSJwZv4UwyPHB28tIpeOsKY6T7JV8IikwDnjHjqV+zCTbvVnXUex5QUT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPuSWme5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso1161115e9.3;
        Wed, 02 Apr 2025 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743630058; x=1744234858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrWOLaML/b83w97VJppoWPqmsyehVsKuYGtUNHZ100g=;
        b=KPuSWme5SXsQYpDLOH+Fw/jlM1gjQ1mJa6tO7+fUTfA9W/zma+T0F/NRvCQkZ099o1
         iYC0C5wSV79GffdJcSN4/y7ZHk2yMfTWi0P9RQpmz2TDob8qWBb0R0mrOKeDnThGeEQH
         btJviYWShvEBMoK9zlRxS77PRiSrUbki7W367ZIiZR8ucjVWMKvCyipq6YcuqscR+Ynd
         I4ueQCZszzZjQ/wtnA8gDPEJeL1/vO2RpF44ACl9qfH/zMbbXyvGk9eb/2gnBbFNq1QH
         /mSlHUUoKK61IGL7+rvPk+LdWOgap6kQVkVgCiH6jGpRfHElhcPsw068qboOr50U/RPs
         of5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743630058; x=1744234858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrWOLaML/b83w97VJppoWPqmsyehVsKuYGtUNHZ100g=;
        b=dP41UlOacF9szY53Wl849aDiEg70WflFhr22CIQAmZlwl0/dqardrT7AboZn7zVrTk
         BovN0G62TWsIDEDwMi4GVczVXRD8uv62c8wLL79FEM7dGrmDjuqljGMTXsIWcBKucrsZ
         jlFt8Ct0wtQ3BQ8TUTsAiKrxXGa+O5po3uBFrDybBuoNgHqNnVrvbnwmPzfHM65C5pyn
         /Be3zgJDcEaa+HS4mVDelT3AMh6l/gaZeOitTAXS6rSOABEap0WzqqwMXJm1amzUq7bm
         mnZXIzn76xlc1aw6I585PiFXxSreqoXoIjErBIKdKvnPyZWvQ9//a6K87bvpWU8oQDin
         fssw==
X-Forwarded-Encrypted: i=1; AJvYcCVbBCs658nCeWmTgi1eyVPppD4V1Je04grwu2DIU+ZQhtjEBNH29HmACVsjF6W82H3IfAhg2PCnlyvaWGsL@vger.kernel.org, AJvYcCXA1WsYJECvIBdf3Nwt6ByeT/GnLhVaHKbvRY0ijLLooYs5NGoKrSNACtpyRS2TxxwlyJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQR1cursw7cm87wPT49XInaApcMmfcP01cEgQCOTnozH1X5jNc
	JyusJSau7KXmSx7Q12IETeNoPnYPpjronoGgGL3udHhxT5YCMJtYOnUOg4xpnfQqynT2v8ABJYy
	xzeUqT/uY52pzCADXNb/H6C9CHK0=
X-Gm-Gg: ASbGncuXQrPVNI6V+6/uEI2G7M6RQp3BWzGNWN35jtQMoofw7jXI04S3c6X+j1IrHxg
	CPPhbiy0wkEnjHp0v1zIC7rWurLHhQskMfCTVU6U0BNK4wWGlnNTjVXfbG++J9d7+lBTkh9g/2b
	sSVWR/I9ReMElPcP0JWnQooagDBhf0Opv425EvX8IQ8A==
X-Google-Smtp-Source: AGHT+IGLrFnL5gA0ju1EqpbuuknG7HTGLWI5EOuD+T3KVXz9uu/m3gLfat2JhyGRlukZnEkTx2qsIvmDaWgjmgvvz24=
X-Received: by 2002:a05:600c:1d16:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-43ec13fc2d4mr2591885e9.14.1743630057985; Wed, 02 Apr 2025
 14:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401205245.70838-1-alexei.starovoitov@gmail.com> <umfukiohyxcxxw5g6ca5g7stq7oonnr3sbvjyjshnbqalzffeq@2nrwqsmwcrug>
In-Reply-To: <umfukiohyxcxxw5g6ca5g7stq7oonnr3sbvjyjshnbqalzffeq@2nrwqsmwcrug>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Apr 2025 14:40:46 -0700
X-Gm-Features: AQ5f1JpPI0en9HyxhZYVLh2AoPDXtKe0u1fBU4PxVcauG58LjnEl74wDeNoCNSY
Message-ID: <CAADnVQLHakKsVEbKiENF8eV0fEAtbVbL0b_QbJO2b0dH9r7PSw@mail.gmail.com>
Subject: Re: [PATCH v2] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 1:56=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Tue, Apr 01, 2025 at 01:52:45PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce lo=
caltry_lock_t").
> > Remove localtry_*() helpers, since localtry_lock() name might
> > be misinterpreted as "try lock".
> >
> > Introduce local_trylock[_irqsave]() helpers that only work
> > with newly introduced local_trylock_t type.
> > Note that attempt to use local_trylock[_irqsave]() with local_lock_t
> > will cause compilation failure.
> >
> > Usage and behavior in !PREEMPT_RT:
> >
> > local_lock_t lock;                     // sizeof(lock) =3D=3D 0
> > local_lock(&lock);                     // preempt disable
> > local_lock_irqsave(&lock, ...);        // irq save
> > if (local_trylock_irqsave(&lock, ...)) // compilation error
> >
> > local_trylock_t lock;                  // sizeof(lock) =3D=3D 4
>
> Is there a reason for this 'acquired' to be int? Can it be uint8_t? No
> need to change anything here but I plan to change it later to compact as
> much as possible within one (or two) cachline for memcg stocks.

I don't see any issue. I can make it u8 right away.

> > local_lock(&lock);                     // preempt disable, acquired =3D=
 1
> > local_lock_irqsave(&lock, ...);        // irq save, acquired =3D 1
> > if (local_trylock(&lock))              // if (!acquired) preempt disabl=
e
> > if (local_trylock_irqsave(&lock, ...)) // if (!acquired) irq save
>
> For above two ", acquired =3D 1" as well.

I felt it would be too verbose and not accurate anyway,
since irq save will be done before the check.
It's a pseudo code.
But sure, I can add.

>
> >
> > The existing local_lock_*() macros can be used either with
> > local_lock_t or local_trylock_t.
> > With local_trylock_t they set acquired =3D 1 while local_unlock_*() cle=
ars it.
> >
> > In !PREEMPT_RT local_lock_irqsave(local_lock_t *) disables interrupts
> > to protect critical section, but it doesn't prevent NMI, so the fully
> > reentrant code cannot use local_lock_irqsave(local_lock_t *) for
> > exclusive access.
> >
> > The local_lock_irqsave(local_trylock_t *) helper disables interrupts
> > and sets acquired=3D1, so local_trylock_irqsave(local_trylock_t *) from
> > NMI attempting to acquire the same lock will return false.
> >
> > In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
> > Map local_trylock_irqsave() to preemptible spin_trylock().
> > When in hard IRQ or NMI return false right away, since
> > spin_trylock() is not safe due to explicit locking in the underneath
> > rt_spin_trylock() implementation. Removing this explicit locking and
> > attempting only "trylock" is undesired due to PI implications.
> >
> > The local_trylock() without _irqsave can be used to avoid the cost of
> > disabling/enabling interrupts by only disabling preemption, so
> > local_trylock() in an interrupt attempting to acquire the same
> > lock will return false.
> >
> > Note there is no need to use local_inc for acquired variable,
> > since it's a percpu variable with strict nesting scopes.
> >
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!

