Return-Path: <bpf+bounces-46566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461659EBC22
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 22:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F628158F
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 21:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9141230D23;
	Tue, 10 Dec 2024 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhkS4mjA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337723ED78
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867640; cv=none; b=A3lfthJuTF2pfVrQ9yLEW7A1YwtMJLh9wLzKudF9J3edxZqtLiDRwzRsr7NjLLYWnZHRpMb7EGjFnZzpbbRqN24/tdsqHDBagcN51s7vAbsSGlIY9weQCkimVM2RbYoUFRgwKF9vQZRZ2HPQwrSrwAwGETPQnvsq61r2JXVKtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867640; c=relaxed/simple;
	bh=nU6L/6q4fycGnb1IfLNF6RjJrVjEHLRk43yjWb/OKv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLUhA0U8OromrKb7HYYFKzVu1V7TlJWcd7kRbTLj9ql1xrfkZAZyJH1XQ9h2AWuJcRMjvR6ECnr/hO+NsNOXkVy+sLh0bJsW2M9HOA+EfTqkLFoK8w2j+1dTZH7+m/Wt2aPGVp2fLesT/bZAry8BStVuO/ukGxsizaSjbpQR9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhkS4mjA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-382610c7116so3149128f8f.0
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 13:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733867637; x=1734472437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU6L/6q4fycGnb1IfLNF6RjJrVjEHLRk43yjWb/OKv4=;
        b=VhkS4mjAnaVmOL5m2O/KGmUClFuaBYn/IQrxaOGs6dpF0JBz0nu+RRqye2VC36D0vB
         aBoKIlpzsBDf9HZiEAVJyLIKrOJaRALYv9vM0FZkDhBsFtBa8ilZ/FQSOGs9NF9ll0Vn
         PJsubx4OMgP3dUd1fd+dXiDq1mFZaxkynKEZUdsPBD/h4kLdLUtREWZKb1u8a+HYqXqf
         IDd8EToDfm94XIkxdkLl88n03OUcXyBqIikV1eAk6ZtiwBNaxfKikETtcFxHm/7fi2IM
         t0mLnQUPXAe4IwULn9PwnkQzEbaCeeOYorDriL6jU7BKCCP1q5nLe23s5uXVV3zxV+qr
         feSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733867637; x=1734472437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU6L/6q4fycGnb1IfLNF6RjJrVjEHLRk43yjWb/OKv4=;
        b=pumvVP/H2FAN602R1mlRvid6i2320rXLMh6315GyjmZbZpXV5u9YH6bw2/uvpJeMYw
         OsOD9gW8leFhLsNRTAC5Zfg2FK9OLDROKWEIRUF4B5k7ibmWIOD6kSMZuaXZn0bo8lf5
         aNqfilO/17+Xc5J/AOuRpZKfL1pcGCr7/tJ59SIJaAoaqLiJt3GQdR4HFknzL5J6ShiT
         R4M7ygjwASDBIId9Cx4NlPHOsNmVewqGRz52WbpPSfeFlyiVBQ0ZKbX5///CMsYlpPXO
         xAY3zWKCQ8nbUUL4byK6/Bt4rIKOVcNlrQEvbzwfJrEj6/76fMgZHrxp1BE2VwDd48K7
         OKpQ==
X-Gm-Message-State: AOJu0Ywrkngs8avXwjnB6chk3PmAKXmvWNZhdZ7rjaqPJJDljHz4PZpU
	sr03UJ6YkBUc2+OS+gjrH4c1xGEsDjxDECmO+at44axltNgzW+Gvx55AH1OcCNbeoicNylz2zwJ
	vksmLof5qE2oiSzjEpKMTZ3xLdKw=
X-Gm-Gg: ASbGncs+X6Pun2DzNigEPchSXrnMb+mNfCBF00bWcPdbP6Updz1g8HbAGTMMjpIpVv+
	pv7K55O/5ZircK6huTV5Dd7b1voyLtWvhjBkzlUFwktMhlSuNLJ8=
X-Google-Smtp-Source: AGHT+IH9Pnj16gzbnddOYI8nZHGvVHzysHGw9SWtsSIM0/9Jl5uCgv9FIGEWbyDEn37isp/TeHJEEhEhsPkUSXMfSXo=
X-Received: by 2002:a5d:64cf:0:b0:386:39fd:5ec with SMTP id
 ffacd0b85a97d-3864cea567cmr398753f8f.57.1733867636768; Tue, 10 Dec 2024
 13:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com> <20241210090136.DGfYLmeo@linutronix.de>
In-Reply-To: <20241210090136.DGfYLmeo@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 13:53:44 -0800
Message-ID: <CAADnVQK_oFD9+HbcEgqy0+JMygje8fB9qdhkJ5uoofQntZoywg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 1:01=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-12-09 18:39:31 [-0800], Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Tracing BPF programs execute from tracepoints and kprobes where running
> > context is unknown, but they need to request additional memory.
> > The prior workarounds were using pre-allocated memory and BPF specific
> > freelists to satisfy such allocation requests. Instead, introduce
> > __GFP_TRYLOCK flag that makes page allocator accessible from any contex=
t.
> > It relies on percpu free list of pages that rmqueue_pcplist() should be
> > able to pop the page from. If it fails (due to IRQ re-entrancy or list
> > being empty) then try_alloc_pages() attempts to spin_trylock zone->lock
> > and refill percpu freelist as normal.
> > BPF program may execute with IRQs disabled and zone->lock is sleeping i=
n RT,
> > so trylock is the only option.
>
> The __GFP_TRYLOCK flag looks reasonable given the challenges for BPF
> where it is not known how much memory will be needed and what the
> calling context is.

Exactly.

> I hope it does not spread across the kernel where
> people do ATOMIC in preempt/ IRQ-off on PREEMPT_RT and then once they
> learn that this does not work, add this flag to the mix to make it work
> without spending some time on reworking it.

We can call it __GFP_BPF to discourage any other usage,
but that seems like an odd "solution" to code review problem.
If people start using __GFP_TRYLOCK just to shut up lockdep splats
they will soon realize that it's an _oportunistic_ allocator.
bpf doesn't need more than a page and single page will likely
will be found in percpu free page pool, so this opportunistic approach
will work most of the time for bpf, but unlikely for others
that need order >=3D PAGE_ALLOC_COSTLY_ORDER (3).

> Side note: I am in the process of hopefully getting rid of the
> preempt_disable() from trace points. What remains then is attaching BPF
> programs to any code/ function with a raw_spinlock_t and I am not yet
> sure what to do here.

That won't help the bpf core.
There are tracepoints that are called after preemption is disabled.
The worst is trace_contention_begin() and people have good reasons
to attach bpf prog there to collect contention stats.
In such case bpf prog has no idea what kind of spin_lock is contending.
It might have disabled preemption and/or irqs before getting to
that tracepoint. So removal of preempt_disable from tracepoint
handling logic doesn't help bpf core. It's a good thing to do anyway.

