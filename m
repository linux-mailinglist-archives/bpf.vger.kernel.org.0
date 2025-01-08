Return-Path: <bpf+bounces-48302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AB6A0668C
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CB418818C3
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44E204C2C;
	Wed,  8 Jan 2025 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0QJhZhU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69A204C2E;
	Wed,  8 Jan 2025 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369020; cv=none; b=EGdzs0PpBE0Co7FTVTy6Bi2IrB0EZ7xUjuRndZIycLoA54N/aepXB2FNM1US49rAgFTBtOX9uFeXtmXUKx9KOGBerbWBNRPbxnMzV3cK3XlPDiGKEIzEwidLcF0LV8tTEZHmRztDqulLUuzurBpojBT/gDPWZDj6mOdWXKrcC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369020; c=relaxed/simple;
	bh=cAWntYmAtIfTaa+3LG+2BnN6RbCgER+/NFeMFfoNoWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL66Z/eDT0KvuaqYWRHnk1w2gPb/MPpZUC05ULNyY8HoZfaODbhN632ZqHzL6TE3w5r1IIpZhjLbT4HZ52bn79aJISdm2m+o129HDR6TQA64f1gxvU39psfnpPqM6VWUWnued0sWAhtfaBVvwb+Q+UMmUnvi6WrMP8/gKWMsetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0QJhZhU; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so229693a12.0;
        Wed, 08 Jan 2025 12:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736369016; x=1736973816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R0GxLo0abC/kX5Xe+ogkeHosuFqsXPettH3T8miQ2hw=;
        b=K0QJhZhUlyZw07owHieoL2Sj4/8aTCalyDier4YUN/PsQrK0LQsxLm6f4H+ixFroXn
         DBTtzGAMhGjeRDdDqrU9HCWRQEOMJLE9aXv5lXUxCP9e/vPEr6n312m9PyVD3HapM5I3
         AxslJCzfSr029mFNkKTfsSyEijkBaKq/zcxYVLzg/5aXtp0o+L9O7MR8jiwxTLvLDi/z
         AuSS3oMGYnLql2LjGI+Zzbdqa9eYTBG0iY1+QoXYj4wn6QKFwH/VuKq8FbzhSoCIGKDG
         TpWUKs0a1Zxt/fHyJWL+F8jLJKQd7OBj4o2cJuJJSo10FPd2ULbV95Qsf2AHfTHICkQ9
         0W9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736369016; x=1736973816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0GxLo0abC/kX5Xe+ogkeHosuFqsXPettH3T8miQ2hw=;
        b=kuMZNtPCT8C1CWPW/CRoY2TDsGuvOu0+CM2bJ1pFga9zuy4bFz9R+6Ujp0MjpAcKHI
         OL/cfU4Ud8Ci1Ee79G9emIwY99VYGdWg0ZQkD7BlJfY7paRaJlCXV8z5nQ/4Lxi6wXAX
         Cb/Z3YKqDRKBPXU4afy31XHgipaYYi6P+nDUQbLTf4P4RHCIRWzh920S9ZqukJaeJWFG
         quNUHmnXZtSEYSt4Hqd8hXgOzb/CKe2Luvt9kWyvbwlzMC7gTGT1AUy6YizwFedmCM1K
         J2nQQRRxdebOdxevD5i8ih+05fHj8kY1IFiQuiDxowBapj6BNxDlEORQGqydQiDkJ3tB
         JoXA==
X-Forwarded-Encrypted: i=1; AJvYcCXsAdZZXdHD+3iBuO9Q99Yp/mGxLv5eoNiXJJZglnhT5FCWM3GEmgKcz0nKEmC/VwTWDgdpZh4NEFrF6mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6ced7X6lzbj4rkrEgQg5NRpXTdLe8l/uzpxaBT+AM1qOal82
	XJr5dYa7T2onCtTC0OpUMYCS+zALvBZhQGr4t8RgfT2ZlBQZ2eZZKh6iMkLLcXvBHncBLoXHtvD
	yysYac1RTDrWS9TkO+u72eDv96GY=
X-Gm-Gg: ASbGncvHMeQh7kjTjI85rECsCrjAIq2mcNA9wcYCZ5JCUKvs6ChWXCgFu7RpOLx56u8
	A+YR3020HAUY0JiKfGLDSPaHfPMfPKRgwJpUEvdHgWLeujAtnW0k6rHGvK8iLCzKJxees
X-Google-Smtp-Source: AGHT+IFgXeNPtz2B6zb4FV0q8NLlQXEX7hkY/QVBWu6K8uTeIFmx0zLjbtsnEjdWPEHU/zXRLP7JCasrrdLPp+Al3p0=
X-Received: by 2002:a05:6402:5243:b0:5d3:ce7f:ac05 with SMTP id
 4fb4d7f45d1cf-5d972e6e675mr3618537a12.31.1736369016152; Wed, 08 Jan 2025
 12:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-10-memxor@gmail.com>
 <f7bc2566-20a7-41fb-ac59-5d6a8901d8fb@redhat.com>
In-Reply-To: <f7bc2566-20a7-41fb-ac59-5d6a8901d8fb@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 9 Jan 2025 02:12:59 +0530
X-Gm-Features: AbW1kvZjmCu3B9mHSoAJhzm9jqF06hikSdpglZKWbkC7SK0dhcudCOPNI4cM73M
Message-ID: <CAP01T740HHea23yF+H_fV0fSPyCxCGmx3EBvyoN6ngRVkA1_ZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 09/22] rqspinlock: Protect waiters in queue
 from stalls
To: Waiman Long <llong@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barret Rhoden <brho@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 09:08, Waiman Long <llong@redhat.com> wrote:
>
> On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
> > Implement the wait queue cleanup algorithm for rqspinlock. There are
> > three forms of waiters in the original queued spin lock algorithm. The
> > first is the waiter which acquires the pending bit and spins on the lock
> > word without forming a wait queue. The second is the head waiter that is
> > the first waiter heading the wait queue. The third form is of all the
> > non-head waiters queued behind the head, waiting to be signalled through
> > their MCS node to overtake the responsibility of the head.
> >
> > In this commit, we are concerned with the second and third kind. First,
> > we augment the waiting loop of the head of the wait queue with a
> > timeout. When this timeout happens, all waiters part of the wait queue
> > will abort their lock acquisition attempts. This happens in three steps.
> > First, the head breaks out of its loop waiting for pending and locked
> > bits to turn to 0, and non-head waiters break out of their MCS node spin
> > (more on that later). Next, every waiter (head or non-head) attempts to
> > check whether they are also the tail waiter, in such a case they attempt
> > to zero out the tail word and allow a new queue to be built up for this
> > lock. If they succeed, they have no one to signal next in the queue to
> > stop spinning. Otherwise, they signal the MCS node of the next waiter to
> > break out of its spin and try resetting the tail word back to 0. This
> > goes on until the tail waiter is found. In case of races, the new tail
> > will be responsible for performing the same task, as the old tail will
> > then fail to reset the tail word and wait for its next pointer to be
> > updated before it signals the new tail to do the same.
> >
> > Lastly, all of these waiters release the rqnode and return to the
> > caller. This patch underscores the point that rqspinlock's timeout does
> > not apply to each waiter individually, and cannot be relied upon as an
> > upper bound. It is possible for the rqspinlock waiters to return early
> > from a failed lock acquisition attempt as soon as stalls are detected.
> >
> > The head waiter cannot directly WRITE_ONCE the tail to zero, as it may
> > race with a concurrent xchg and a non-head waiter linking its MCS node
> > to the head's MCS node through 'prev->next' assignment.
> >
> > Reviewed-by: Barret Rhoden <brho@google.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   kernel/locking/rqspinlock.c | 42 +++++++++++++++++++++++++++++---
> >   kernel/locking/rqspinlock.h | 48 +++++++++++++++++++++++++++++++++++++
> >   2 files changed, 87 insertions(+), 3 deletions(-)
> >   create mode 100644 kernel/locking/rqspinlock.h
> >
> > diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
> > index dd305573db13..f712fe4b1f38 100644
> > --- a/kernel/locking/rqspinlock.c
> > +++ b/kernel/locking/rqspinlock.c
> > @@ -77,6 +77,8 @@ struct rqspinlock_timeout {
> >       u16 spin;
> >   };
> >
> > +#define RES_TIMEOUT_VAL      2
> > +
> >   static noinline int check_timeout(struct rqspinlock_timeout *ts)
> >   {
> >       u64 time = ktime_get_mono_fast_ns();
> > @@ -305,12 +307,18 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
> >        * head of the waitqueue.
> >        */
> >       if (old & _Q_TAIL_MASK) {
> > +             int val;
> > +
> >               prev = decode_tail(old, qnodes);
> >
> >               /* Link @node into the waitqueue. */
> >               WRITE_ONCE(prev->next, node);
> >
> > -             arch_mcs_spin_lock_contended(&node->locked);
> > +             val = arch_mcs_spin_lock_contended(&node->locked);
> > +             if (val == RES_TIMEOUT_VAL) {
> > +                     ret = -EDEADLK;
> > +                     goto waitq_timeout;
> > +             }
> >
> >               /*
> >                * While waiting for the MCS lock, the next pointer may have
> > @@ -334,7 +342,35 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
> >        * sequentiality; this is because the set_locked() function below
> >        * does not imply a full barrier.
> >        */
> > -     val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
> > +     RES_RESET_TIMEOUT(ts);
> > +     val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
> > +                                    RES_CHECK_TIMEOUT(ts, ret));
>
> This has the same wfe problem for arm64.

Ack, I will keep the no-WFE fallback as mentioned in the reply to
Peter for now, and switch over once Ankur's smp_cond_load_*_timeout
patches land.

>
> Cheers,
> Longman
>
>

