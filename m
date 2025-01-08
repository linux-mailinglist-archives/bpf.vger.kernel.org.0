Return-Path: <bpf+bounces-48218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD3AA05084
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 03:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6EA7A010E
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16147158858;
	Wed,  8 Jan 2025 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ar2YTMat"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90351362
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302786; cv=none; b=LUk6Qtyq4BvoyciXcpiYm2aMXApXLDoGV8oUoS+WKqiejD9R6gZXjigjtVL9myNcK67jPEae34mz9ZSg6jjrVGMCJ2VvRsjT+B3cWLMkH6Z+gEd24arWr3e/GTOrcJt+tQYz22KqLSfWl3VpXru23bUwAZz7ZnKPHTSkB3pVunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302786; c=relaxed/simple;
	bh=Qj+hLD0gEGnHb8JH0qSYU8eyFpcK4ftOZb4vC7NlWsk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ToLfRFd3x1BYHoJVpF5ZohOrFpOrQvDX87RwTuBYHCbB8x8YOfDVmFWYGKWr6fpUvR/AGAu5FidFR1hWTlCaP6o5JoUTgKicAYp2QuHU/x58IYAy5QKYqy344J0lMNljwu+sSPWFeZKTP/ek/nQH9wIqW3oq990bzvgVqRH3+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ar2YTMat; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736302783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LJU0czswQQdicouhFkuEn3K0tQUHiRMIxjJx5nDcxI=;
	b=ar2YTMat4vSk1PzY1XGOq7t+DZJpaBgqDCFIxAyIHD0WccT9LXvlw68ZqagsHWZpja0d+w
	ApKDXcEHy3GUlspjgJbiYSp9jkwhSsAxs0oCraIkbwP1hwjPMUa7jH6Knemogs2qP/8uu/
	fMHDVrzDDyyygY3p329yZVEVuaTXPzg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-klgNFGH0N7esY9HNtH1--g-1; Tue, 07 Jan 2025 21:19:42 -0500
X-MC-Unique: klgNFGH0N7esY9HNtH1--g-1
X-Mimecast-MFC-AGG-ID: klgNFGH0N7esY9HNtH1--g
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6eabd51cfso2584290385a.0
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 18:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736302781; x=1736907581;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LJU0czswQQdicouhFkuEn3K0tQUHiRMIxjJx5nDcxI=;
        b=N/oIAU3/9ge/bGQNBzMEBYTWYJ/1RzkNKtUSYVE1cdjIeZKuFUqKZrQyw+bemc8U02
         5N8LgXMBkPm+TOhvAH7IxvoDwm/kNx9kJKIh0BoJEEp1X+O8liOzMY1BKsx8IlHA4/ll
         uS5mMteKiaUceT5gUqzPNC4zAG2swCgPP8VsHbvj+hw+6LutUP0AwC/XcsUOMDp2fQEr
         Qtdbyx9L7PKX23YIX68CLZFA6KXs1D/2LTLS0TgTjc6tuizLAQ1bhI25GHeMM29+gOZj
         4eYKGLHflLcL3ZyeO7eD6t4qyzM72of0jqySw26b+0I8YQbsj0AVLbt3tERMxCathDF8
         AQyg==
X-Forwarded-Encrypted: i=1; AJvYcCUNclDn7kfRjrmwg7/mQfSsuahM/L2IMVGMBTYHHZ2nSzqakGINexbox5ynmhunXCI80FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzStw+uT21UTUK+CxGf0rLhIeXwJ730Z7I3w68aPC1SAm/gxJ6
	XTSXX1RvnsR4dwo7IdfNDIoSQwLnVBlRzHYHRmue06wT0+Sg9pRc9g2m1lgcyb0Xefn0QBKAh0r
	hU6JhoF7n7VTFa+z+aWhMnrklmcDi6taj4kMklJpGbBHmginpXQ==
X-Gm-Gg: ASbGnctVL1gYgPQmcjl+Amz0OUxZ/LaMXTxx/FRBR+YyWv8Qoe/H8qVrakGJGhuWpYc
	BJlzCPz08fg9RUbxrWh0mZD8xRF5ZbfWLu0p32peY+6FAeuNKewtvSgHY/WtW8MRtdhba0AaZSH
	BzeUTT4Lyj/v6If8nKzvjCz6LlV2OkmLaGOyq15rYXWyMvDBFPzNDwgToNqZzFMs20bW9VO+mYT
	FS0r7rKEzQdSnUpFuvk33mCby/YFs785iwpQuZT64r0iKljvJ5Yr9j/N9Z2NDFczF2jATavcsQs
	//4+N0qRBm7w3RNfRcqR8/iw
X-Received: by 2002:a05:6214:21eb:b0:6d8:850a:4d69 with SMTP id 6a1803df08f44-6df9b1c9d3emr22539526d6.1.1736302780788;
        Tue, 07 Jan 2025 18:19:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMT0AZpQ96TehcTrjNxJCuvyQJtut5soZJJgcQFg5JSircrYlrtBGZhzNe7YbnASHCikeEeA==
X-Received: by 2002:a05:6214:21eb:b0:6d8:850a:4d69 with SMTP id 6a1803df08f44-6df9b1c9d3emr22539296d6.1.1736302780493;
        Tue, 07 Jan 2025 18:19:40 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ebe59sm186114706d6.27.2025.01.07.18.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 18:19:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <593abb4c-12d6-4d61-a41e-f258cb8f22c6@redhat.com>
Date: Tue, 7 Jan 2025 21:19:31 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 08/22] rqspinlock: Protect pending bit owners
 from stalls
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>,
 kernel-team@meta.com
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-9-memxor@gmail.com>
Content-Language: en-US
In-Reply-To: <20250107140004.2732830-9-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
> The pending bit is used to avoid queueing in case the lock is
> uncontended, and has demonstrated benefits for the 2 contender scenario,
> esp. on x86. In case the pending bit is acquired and we wait for the
> locked bit to disappear, we may get stuck due to the lock owner not
> making progress. Hence, this waiting loop must be protected with a
> timeout check.
>
> To perform a graceful recovery once we decide to abort our lock
> acquisition attempt in this case, we must unset the pending bit since we
> own it. All waiters undoing their changes and exiting gracefully allows
> the lock word to be restored to the unlocked state once all participants
> (owner, waiters) have been recovered, and the lock remains usable.
> Hence, set the pending bit back to zero before returning to the caller.
>
> Introduce a lockevent (rqspinlock_lock_timeout) to capture timeout
> event statistics.
>
> Reviewed-by: Barret Rhoden <brho@google.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   include/asm-generic/rqspinlock.h  |  2 +-
>   kernel/locking/lock_events_list.h |  5 +++++
>   kernel/locking/rqspinlock.c       | 28 +++++++++++++++++++++++-----
>   3 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
> index 8ed266f4e70b..5c996a82e75f 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -19,6 +19,6 @@ struct qspinlock;
>    */
>   #define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
>   
> -extern void resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
> +extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
>   
>   #endif /* __ASM_GENERIC_RQSPINLOCK_H */
> diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
> index 97fb6f3f840a..c5286249994d 100644
> --- a/kernel/locking/lock_events_list.h
> +++ b/kernel/locking/lock_events_list.h
> @@ -49,6 +49,11 @@ LOCK_EVENT(lock_use_node4)	/* # of locking ops that use 4th percpu node */
>   LOCK_EVENT(lock_no_node)	/* # of locking ops w/o using percpu node    */
>   #endif /* CONFIG_QUEUED_SPINLOCKS */
>   
> +/*
> + * Locking events for Resilient Queued Spin Lock
> + */
> +LOCK_EVENT(rqspinlock_lock_timeout)	/* # of locking ops that timeout	*/
> +
>   /*
>    * Locking events for rwsem
>    */

Since the build of rqspinlock.c is conditional on 
CONFIG_QUEUED_SPINLOCKS, this lock event should be inside the 
CONFIG_QUEUED_SPINLOCKS block.

Cheers,
Longman



