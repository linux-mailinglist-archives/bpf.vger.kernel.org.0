Return-Path: <bpf+bounces-48300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB60A06634
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B18188267D
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273AA204087;
	Wed,  8 Jan 2025 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPAMZ2yI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B4203706;
	Wed,  8 Jan 2025 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368382; cv=none; b=kfHj2aMX0N/OGcr2YR02OHSExxDrS4y1w2yh897W1uChK2WTuc7x6iLtUMUoKEQOsFf0fTohkFOpx9zwxfiTk0pMYYwvrYD1dZVwnPmNWNLR6GL8MmwSgRMF+TBKNbs8IA+M4rrP8TkSmvb2Kth3AJ3tfBANVTDkke2r9D5N/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368382; c=relaxed/simple;
	bh=uItGO1jdr/yiyFDkrFC0/TlUtd50goUOSxso02ferQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTJ7Mv/qkOolNk+BX3+OT/tFtl1nbVYnQDkrtg971PydtaEBZsLkzyXSXxEuePiMex2zpdDS3YQwq45ob4joQc+fxyVKrQeX6ehWJt3HVe8P7TCLarL3B4HZEC9+cpKfLdcIpla/tfM8VAIB5PoDfAvff0EYy02nxw9NJa55Qrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPAMZ2yI; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so46949466b.3;
        Wed, 08 Jan 2025 12:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736368379; x=1736973179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uItGO1jdr/yiyFDkrFC0/TlUtd50goUOSxso02ferQA=;
        b=XPAMZ2yIQt8MGwD5oJ+pisTXFPTFmTBsU1zTTy/pS9EigBnvqczE9OW07mlgUkMqmg
         OICAvX/FmMpzOp/UK3IzS1Gc7bjFzkvq/kN6/JLeTdeiWnKuMJzk7Xu1A3NjA0QYVQY4
         2oOG4/q1WaKiFY/bpH7+Xxt9CshwYeA2pjQ905x9wLeE0B/s+RLHduXKTCjVikJw5xf+
         gHuHHcSb/mLCiMvJhBYnOKCpaB26zgR3PJjW8y4tBiRxkyXt2watMGEvMu45A9VXmnn3
         sxDcTVx0VfwVewieTN4vvPSbdkamvq6bCXX7NmPODyxUnV2vpXdVheTJcOI0480DErmk
         N2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736368379; x=1736973179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uItGO1jdr/yiyFDkrFC0/TlUtd50goUOSxso02ferQA=;
        b=hx9lXXbNWy135iF5XtMZ4sSg5+uXJoHsLD+cNbFMhs4oZ4BNIe+yoKUcu7LPq4Ioid
         12UQQj6UUgaOvRhTJQDWDxMUEUZ6pDdB9TwmjgHbClJ0eJnPt+g2QrZZYYRNWgFmotPA
         urGeRuNRM/rBxiaKiUB9in3eLt5M+MenpD4Fv4BvnvDfNB5Z/QahqScZvcD8F+dMYAfP
         NExplB+9mSFNS/bJOs8IoSdtlIGtQU3Xlqy/+VNNJSizrY797JMX89hkerNkU6au+ots
         P17hXZSCwi6l5qKfmOfGfeeg4abRQ+xpGPiLE52h2rN5tSqanpDsz9TDBs1XJgAKNRFr
         HR1g==
X-Forwarded-Encrypted: i=1; AJvYcCXTHM0FGAZB/WCSIFwTfme+u5P6QWlDraekxXAohC4gdWexZvkZpYN4hgfIdE8gpq7E4Kda+PgqLRQ/uM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0BVXXfCyQiqLZzMw/FxsJ6ztBE+Aa9N6Eoil7lJN4Dru4kL+
	+sx8UCz482rNCKMiw1m68UvQUHnGboED3UqUEQXTIT7Lyp/mMbvfGIo4R66QwI6zrR3KQKHo4Ko
	Jtkx+zun6nAKfJMH8Si8n2vS33ys=
X-Gm-Gg: ASbGnctk9pMk9nPb6sOjIIguVWdXuX4GcFxeHIFvBsdYGAFDhpnhtsp5ChS7kDD/dAx
	krygzb3iSExKS1HME1ZBJBU7FA8m5Vn5FUWyLfbpAhElr4Y8ffyRpdN/hATxDdWlpnacl
X-Google-Smtp-Source: AGHT+IEf5vlCXVDO0qYQSNpRfllvSioUrzl8at0wild/KcbO3k9kl3Dtysz22PgFIzgJG8XY7xmuaETu8kksYiHH9BQ=
X-Received: by 2002:a17:907:2cc4:b0:aae:ec01:2de4 with SMTP id
 a640c23a62f3a-ab2ab5f52efmr342561866b.30.1736368378761; Wed, 08 Jan 2025
 12:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-13-memxor@gmail.com>
 <2eaf52fb-b7d4-4024-a671-02d5375fca22@redhat.com>
In-Reply-To: <2eaf52fb-b7d4-4024-a671-02d5375fca22@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 9 Jan 2025 02:02:21 +0530
X-Gm-Features: AbW1kvZImSoQY64ed9Qjj5eAVUkuBxRL5plj2Q5htY_Z2fvcW51HMBgysZw96pY
Message-ID: <CAP01T74UX4VKNKmeooiCKsw7G6qkhohSFTXP0r=DZ1AuaEetAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 12/22] rqspinlock: Add basic support for CONFIG_PARAVIRT
To: Waiman Long <llong@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 21:57, Waiman Long <llong@redhat.com> wrote:
>
> On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
> > We ripped out PV and virtualization related bits from rqspinlock in an
> > earlier commit, however, a fair lock performs poorly within a virtual
> > machine when the lock holder is preempted. As such, retain the
> > virt_spin_lock fallback to test and set lock, but with timeout and
> > deadlock detection.
> >
> > We don't integrate support for CONFIG_PARAVIRT_SPINLOCKS yet, as that
> > requires more involved algorithmic changes and introduces more
> > complexity. It can be done when the need arises in the future.
>
> virt_spin_lock() doesn't scale well. It is for hypervisors that don't
> support PV qspinlock yet. Now rqspinlock() will be in this category.

We would need to make algorithmic changes to paravirt versions, which
would be too much for this series, so I didn't go there.

>
> I wonder if we should provide an option to disable rqspinlock and fall
> back to the regular qspinlock with strict BPF locking semantics.

That unfortunately won't work, because rqspinlock operates essentially
like a trylock, where it is allowed to fail and callers must handle
errors accordingly. Some of the users in BPF (e.g. in patch 17) remove
their per-cpu nesting counts to rely on AA deadlock detection of
rqspinlock, which would cause a deadlock if we transparently replace
it with qspinlock as a fallback.

>
> Another question that I have is about PREEMPT_RT kernel which cannot
> tolerate any locking stall. That will probably require disabling
> rqspinlock if CONFIG_PREEMPT_RT is enabled.

I think rqspinlock better maps to the raw spin lock variants, which
stays as a spin lock on RT kernels, and as you see in patch 17 and 18,
BPF maps were already using the raw spin lock variants. To avoid
stalling, we perform deadlock checks immediately when we enter the
slow path, so for the cases where we rely upon rqspinlock to diagnose
and report an error, we'll recover quickly. If we still hit the
timeout it is probably a different problem / bug anyway (and would
have caused a kernel hang otherwise).

>
> Cheers,
> Longman
>

