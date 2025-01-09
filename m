Return-Path: <bpf+bounces-48322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B49A069FE
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 01:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930F03A6DCD
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 00:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD8779D0;
	Thu,  9 Jan 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SS5n9l7o"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442A1853
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736383689; cv=none; b=bLAy34Hc63QwA6NC6zWdBfLblnBBp026/lTgCsQ3DGGMo4gRKUwRV2V+2/kbDgGuyICNd6E8N/WJg+nL0hcDewIZ9ctfsGhUe/iCK6Y3ZXSnhUQCqgWnaepkBYlC02CZ6DW7235Mw+UB9IPAqFF0zHWq2jSfFnR/E3VVPMHrUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736383689; c=relaxed/simple;
	bh=XVRjFgQlPP0eYtwxQWUBzG/ybfsJ4dUvNuUWqcMVfRg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AonXJ8Gy8sDGx6B7BphnmFlDWs9s2pqKIK/EP2ljqCUfcLKNElwSqsyd9rlM2jZ6f7V+RZjFb0K43QIyb+8u3aUw/aVwWBuGZ44cSeCuCfeyuIlRrtaocnJ7hPiQrFxnHBk2lfHeVjMdGz5SWKMTzsgAJMu2rodUBDBobkRtEeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SS5n9l7o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736383686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pL5esHArIoaNFGvBsuxJdLuUOOU+uugBRELxjcG9CLo=;
	b=SS5n9l7oAF6EfOKlEA1gV8mv54EysnTXaTSVTXlSchKdg3RA965Xzr2zOgYLSmhpYyS6U3
	ye0z6Jl4ZFXUU5niy3mayhbvT4dAIzzrp3lMGu/MCCT8yjDWY8v3fqLNnT+yTiZMAibuId
	7fensvqAwt1K4LPWoTXZHXNh9+gqoEU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-IUWx6LKzPTmBb6I7b0Id6w-1; Wed, 08 Jan 2025 19:48:05 -0500
X-MC-Unique: IUWx6LKzPTmBb6I7b0Id6w-1
X-Mimecast-MFC-AGG-ID: IUWx6LKzPTmBb6I7b0Id6w
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8fe8a0371so7037646d6.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 16:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736383685; x=1736988485;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pL5esHArIoaNFGvBsuxJdLuUOOU+uugBRELxjcG9CLo=;
        b=RjJof8cnatqqj8h97VeJq4RdUiNGZXCnS0KaPQD0hdqmVbE2oyV3Of9ANxrX4aKAVT
         Xa1svlecqVz+xg1eWhaMUOB87mGsvdgwLTo3oEUPkH5Kc0tNvCplwdZHYXvdeIh05Zrv
         L6SwVo2wLBrE66/kNThyKfNNH1f1V0xZfl/ZJT22+qzPMlpW8/tGmBv8M5JQgGeHLyGR
         2W086DZwE2or9OphLbIALeUAq7a5R+9GocM2p7Jjw/+UIx166JvOuPC201JP3EEQewbk
         Jxgqq6LYYVe/8vOogh0gj9lFdf87sp5cSeIdixpUyP3klhQwg4oln5aSjIXNy7Zx2ZAW
         tz8A==
X-Gm-Message-State: AOJu0YywFRue8XG0zrjSqgdFBu6sbLHjcu6RVsj3fpbu0Bg6mZbyidxy
	BdYO7bOu20V+exX8rrSjQhd86JWD5BA3GlCwWmzayqXTzRTjRzBXbug5N4haVIM1n343dUYscQn
	k+jfaro58x4a0H2ddGGVF+g5owM8Zo6RSOX/e84PrNPVScMoN+w==
X-Gm-Gg: ASbGnctT4SctlFLBeYZqqqMqIGh52qEbBsv1HOYRdav5eEW7u5vF7lHKVdCwx0W5WIF
	egHhBpc/ytqv54URGgLfFlgGeDR0ONXoKJ5DYx22XDVuseECKrtghkmPkNZ4GSBK/KNtEqskaoy
	NLh9GnYf8VftOoh9ndDKJM0yP9sm/upC1eimIdrYrIQqs+BbwbmdBmAGUNWHfUQCKDHU6mANsmE
	r54SqECJBfydN76ddHhALT6eQydwGH8xVAmr3OqBAXT/htVuaeUwQZK0ysc/oF9MtNduSEjO3RI
	TYdseabCEeWFwpfbh5rsmoPA
X-Received: by 2002:a05:6214:29e8:b0:6d8:adb8:4012 with SMTP id 6a1803df08f44-6df9b2cbf39mr90164536d6.45.1736383685248;
        Wed, 08 Jan 2025 16:48:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7iJrAmh/QSHd4ItRBTHP/EVXras15jEDmo808y9ew1P23oHmZADfAtSZt1xrdnijC7Tho8g==
X-Received: by 2002:a05:6214:29e8:b0:6d8:adb8:4012 with SMTP id 6a1803df08f44-6df9b2cbf39mr90164196d6.45.1736383684961;
        Wed, 08 Jan 2025 16:48:04 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181bba3fsm195940616d6.71.2025.01.08.16.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 16:48:04 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dfbaf200-7c87-41b2-ab87-906cbdf3e0d7@redhat.com>
Date: Wed, 8 Jan 2025 19:48:02 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 12/22] rqspinlock: Add basic support for
 CONFIG_PARAVIRT
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Waiman Long <llong@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
 Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-13-memxor@gmail.com>
 <2eaf52fb-b7d4-4024-a671-02d5375fca22@redhat.com>
 <CAP01T74UX4VKNKmeooiCKsw7G6qkhohSFTXP0r=DZ1AuaEetAw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP01T74UX4VKNKmeooiCKsw7G6qkhohSFTXP0r=DZ1AuaEetAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/8/25 3:32 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, 8 Jan 2025 at 21:57, Waiman Long <llong@redhat.com> wrote:
>> On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
>>> We ripped out PV and virtualization related bits from rqspinlock in an
>>> earlier commit, however, a fair lock performs poorly within a virtual
>>> machine when the lock holder is preempted. As such, retain the
>>> virt_spin_lock fallback to test and set lock, but with timeout and
>>> deadlock detection.
>>>
>>> We don't integrate support for CONFIG_PARAVIRT_SPINLOCKS yet, as that
>>> requires more involved algorithmic changes and introduces more
>>> complexity. It can be done when the need arises in the future.
>> virt_spin_lock() doesn't scale well. It is for hypervisors that don't
>> support PV qspinlock yet. Now rqspinlock() will be in this category.
> We would need to make algorithmic changes to paravirt versions, which
> would be too much for this series, so I didn't go there.
I know. The paravirt part is the most difficult. It took me over a year 
to work on the paravirt part of qspinlock to get it right and merged 
upstream.
>
>> I wonder if we should provide an option to disable rqspinlock and fall
>> back to the regular qspinlock with strict BPF locking semantics.
> That unfortunately won't work, because rqspinlock operates essentially
> like a trylock, where it is allowed to fail and callers must handle
> errors accordingly. Some of the users in BPF (e.g. in patch 17) remove
> their per-cpu nesting counts to rely on AA deadlock detection of
> rqspinlock, which would cause a deadlock if we transparently replace
> it with qspinlock as a fallback.

I see. This information should be documented somewhere.


>> Another question that I have is about PREEMPT_RT kernel which cannot
>> tolerate any locking stall. That will probably require disabling
>> rqspinlock if CONFIG_PREEMPT_RT is enabled.
> I think rqspinlock better maps to the raw spin lock variants, which
> stays as a spin lock on RT kernels, and as you see in patch 17 and 18,
> BPF maps were already using the raw spin lock variants. To avoid
> stalling, we perform deadlock checks immediately when we enter the
> slow path, so for the cases where we rely upon rqspinlock to diagnose
> and report an error, we'll recover quickly. If we still hit the
> timeout it is probably a different problem / bug anyway (and would
> have caused a kernel hang otherwise).

Is the intention to only replace raw_spinlock_t by rqspinlock but never 
spinlock_t? Again, this information need to be documented. Looking at 
the pdf file, it looks like the rqspinlock usage will be extended over time.

As for the locking semantics allowed by the BPF verifier, is it possible 
to enforce the strict locking rules for PREEMPT_RT kernel and use the 
relaxed semantics for non-PREEMPT_RT kernel. We don't want the loading 
of an arbitrary BPF program to break the latency guarantee of a 
PREEMPT_RT kernel.

Cheers,
Longman




