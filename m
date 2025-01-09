Return-Path: <bpf+bounces-48357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC766A06CAB
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 05:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19CF16606A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 04:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB0B13E02D;
	Thu,  9 Jan 2025 04:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="du5mVg34"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933D12EBEA
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736395771; cv=none; b=PFmgEuba2DdHBjXFRp0aCLrbATnBvRim1BULwM/2+eCkvEh9E71mFhbJcCHpzZt69wvLipOCdDYMQrxo/0KGi2GOR6ThepBHeSwDxp2TH7x9ECDSm1l9lX0rgKMgi2br/WK/rCH6TI6tCFzUMAk4R2DDLs/foAqZdgzVEKx+qQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736395771; c=relaxed/simple;
	bh=KkzmugCTgh+bXLzcAZrKoqpxBapWwQJqI3gj6/F8mdQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dfl3bIdtuX+8QA+D0WPloxck2D8JRxMMdjE3MLYU4XOjmfVKqfAhfDLiUp0yupKGncFheV3nPkVxzX+cL9abXlazk03Sd8PNkHGMVxaCYhuxz96aVpJBcI4Zq8//Hx6maiVVJmVK/Lwhu9ItfzNtVl0N+V97pHvxQRwCeYjGDEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=du5mVg34; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736395768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJ5zV7CX5tYDF/V2UPUwqBaPremWRdletcofDoq7dI4=;
	b=du5mVg34eeSoRsiOfnmqFVwSXdzIy5RAps++1sWDYdEYyGmQ+Ow3e4E+C4c6GpbqHPvNzq
	AcxYw6wROJZKHkK+KyjJsXHNfLsubnPYthBchJ5KH3+lPGhNetma9lgBhrpqKeqVrTlDW/
	ApvO4UCoGCQr9cUvR2OD3rioNAVzcSw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-2WnRAJuuM_KLYWFB57VJdA-1; Wed, 08 Jan 2025 23:09:27 -0500
X-MC-Unique: 2WnRAJuuM_KLYWFB57VJdA-1
X-Mimecast-MFC-AGG-ID: 2WnRAJuuM_KLYWFB57VJdA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d89154adabso10100076d6.0
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 20:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736395767; x=1737000567;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ5zV7CX5tYDF/V2UPUwqBaPremWRdletcofDoq7dI4=;
        b=mRpVe8kwVEu45q6lknftRDKhvQofLq4/j8GSk7YJDnrM/xrQyeSkLLXE6yFGGhKdO1
         vLqIM60HqHRFplPY7drshjNdC7B8Wo3obDn7QnLNi6lyiE8PGp+0nJD9ETs5hHc4vn25
         to7hxp9xgbaK6r6NYtfQXuJBWKvz3R7cqXZ98SS5HjZNZA3MjlFsBMZy0UiE75iVxZSy
         q+4wGCzhRvEh31eVRvft5HlNqyQw4LWHeeedUrqgoqvhADOJcHsWYqz2aq0/AMRfFqjh
         sbfy+C4JGUc5adQ9vlsFq+2XC0z4STagEy8eT8agaWPc3wsSqJAPsRXgQlXZ4VzrG7Ny
         UClg==
X-Forwarded-Encrypted: i=1; AJvYcCVLcvnftBDYgWxA8EqS5V1O2xk3fS4NUznVWzm+oramva5IDDgfzIBSOJWfAl7DE7YOhqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZjZU62vmSpJ1DHXaTNOX5+e+nYzsDK/vOrFjduqA6BEYjwyg
	oBp9+hxlZ05Zv2tYF+uV/L8v7R5hGa05qounh3Xq/bCDRKwJbrtpeh0LqWXyc3g77ND2I414sdH
	qMGWIysEsr44A0Bo4viTFnJ2a8y7i8zP7nZFLHYeYS9+TEUk0hw==
X-Gm-Gg: ASbGncsAySSiMdgEVVCcyJwgJhKeTS0AphveO6HhILFRUjneOpwI10bdpBZ84DkrwJ5
	tmHwCR3HH9q6bOC/+xRiwWoxoSJYfb/7DeCh96nfUSa2w7jmDGf0TkApqvedbGijCT/wnmkpxYZ
	WvQjbo2ldUR1KNMzMMEDZejE1oOEzQJIoVo696U0GuM52c/cKgALQLvPm+oiLhvvXn9hB9pWTOY
	ozH8Y5kL+fUkjsPX1CkY+o276cvnRZNmGU86Z5roB0lRDKdzurJwxq9ZtbYNMgWIN/OsO1HieAR
	XnYYJSTX9gu+0o5T8Qi8Dgc4
X-Received: by 2002:a05:6214:5f08:b0:6d8:9e16:d07e with SMTP id 6a1803df08f44-6df9b1cf107mr88034266d6.4.1736395766952;
        Wed, 08 Jan 2025 20:09:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnoeSGFiv1eIDOU4jqMF+BKzN7ysXy9cEVuijebjFAZy1AvL9ARsBTHwIcMybPM/olz9ebtg==
X-Received: by 2002:a05:6214:5f08:b0:6d8:9e16:d07e with SMTP id 6a1803df08f44-6df9b1cf107mr88033976d6.4.1736395766655;
        Wed, 08 Jan 2025 20:09:26 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d5af8sm196577446d6.121.2025.01.08.20.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 20:09:26 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3d20f9d4-23e4-404c-9a68-fd8e82177311@redhat.com>
Date: Wed, 8 Jan 2025 23:09:24 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 14/22] rqspinlock: Add macros for rqspinlock
 usage
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Waiman Long <llong@redhat.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
 Dohyun Kim <dohyunkim@google.com>, Kernel Team <kernel-team@meta.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-15-memxor@gmail.com>
 <62c08854-04cb-4e45-a9e1-e6200cb787fd@redhat.com>
 <CAP01T77QD_pYBVS4PfG3jDeXObKHZJkV2nQX+0njv11oKTEqRA@mail.gmail.com>
 <2ff3a68c-1328-4b47-a4aa-0365b3f1809b@redhat.com>
 <CAADnVQJ=B4cdGa+OuN7d61=LCXmQgZQz=TF+nRD55m3=2EX2cA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJ=B4cdGa+OuN7d61=LCXmQgZQz=TF+nRD55m3=2EX2cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/25 10:30 PM, Alexei Starovoitov wrote:
> On Wed, Jan 8, 2025 at 5:11 PM Waiman Long <llong@redhat.com> wrote:
>>
>>> Most of the users use rqspinlock because it is expected a deadlock may
>>> be constructed at runtime (either due to BPF programs or by attaching
>>> programs to the kernel), so lockdep splats will not be helpful on
>>> debug kernels.
>> In most cases, lockdep will report a cyclic locking dependency
>> (potential deadlock) before a real deadlock happens as it requires the
>> right combination of events happening in a specific sequence. So lockdep
>> can report a deadlock while the runtime check of rqspinlock may not see
>> it and there is no locking stall. Also rqspinlock will not see the other
>> locks held in the current context.
>>
>>
>>> Say if a mix of both qspinlock and rqspinlock were involved in an ABBA
>>> situation, as long as rqspinlock is being acquired on one of the
>>> threads, it will still timeout even if check_deadlock fails to
>>> establish presence of a deadlock. This will mean the qspinlock call on
>>> the other side will make progress as long as the kernel unwinds locks
>>> correctly on failures (by handling rqspinlock errors and releasing
>>> held locks on the way out).
>> That is true only if the latest lock to be acquired is a rqspinlock. If.
>> all the rqspinlocks in the circular path have already been acquired, no
>> unwinding is possible.
> There is no 'last lock'. If it's not an AA deadlock there are more
> than 1 cpu that are spinning. In a hypothetical mix of rqspinlocks
> and regular raw_spinlocks at least one cpu will be spinning on
> rqspinlock and despite missing the entries in the lock table it will
> still exit by timeout. The execution will continue and eventually
> all locks will be released.
>
> We considered annotating rqspinlock as trylock with
> raw_spin_lock_init lock class, but usefulness is quite limited.
> It's trylock only. So it may appear in a circular dependency
> only if it's a combination of raw_spin_locks and rqspinlocks
> which is not supposed to ever happen once we convert all bpf inner
> parts to rqspinlock.
> Patches 17,18,19 convert the main offenders. Few remain
> that need a bit more thinking.
> At the end all locks at the leaves will be rqspinlocks and
> no normal locks will be taken after
> (unless NMIs are doing silly things).
> And since rqspinlock is a trylock, lockdep will never complain
> on rqspinlock.
> Even if NMI handler is buggy it's unlikely that NMI's raw_spin_lock
> is in a circular dependency with rqspinlock on bpf side.
> So rqspinlock entries will be adding computational
> overhead to lockdep engine to filter out and not much more.
>
> This all assumes that rqspinlocks are limited to bpf, of course.
>
> If rqspinlock has use cases beyond bpf then, sure, let's add
> trylock lockdep annotations.
>
> Note that if there is an actual bug on bpf side with rqspinlock usage
> it will be reported even when lockdep is off.
> This is patch 13.
> Currently it's pr_info() of held rqspinlocks and dumpstack,
> but in the future we plan to make it better consumable by bpf
> side. Printing into something like a special trace_pipe.
> This is tbd.

If rqspinlock is only limited to within the BPF core and BPF progs and 
won't call out to other subsystems that may acquire other 
raw_spinlock's, lockdep may not be needed. Once the scope is extended 
beyond that, we certainly need to have lockdep enabled. Again, this has 
to be clearly documented.

Cheers,
Longman


