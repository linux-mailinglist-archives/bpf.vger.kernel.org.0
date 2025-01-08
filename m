Return-Path: <bpf+bounces-48295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF771A065CC
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC2A16519D
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D407202C3E;
	Wed,  8 Jan 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqojS9ol"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DB91CDFD5;
	Wed,  8 Jan 2025 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367235; cv=none; b=EyEpYQf8kN6yOuxuRpw1qKGbDrcQRxo0tvbs2gWEpjpIipMA023heelXOkqmICtb5KHctEZmyhVVJMZNKIv8DCq1c9iGBR+TxmE0v3KXYhgUkRfOhlwXJTJsY47P7KjbMGgbajbrYBPYwvtKZy6KYevHFAjwvgyGRD3br9dlvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367235; c=relaxed/simple;
	bh=pe1f9LyW6KP2nvtxTwwHEzUiAxBJ1pnQR0n460yxGWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uA7zL6MGLABo0kZHzWdA/9jby7jHEc0GgyH49azlMSL15AV0j7eetRJLRb3yrDunziThq9xriOaoppdX79p4ZcEJrJexXHgecHmgkR3/28EbCjbpwGxuQo890t+pdfAZ/YmHuY2QlCF1xAWh6RbOp1Q/QnT4eeoaJb+qKsDTlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqojS9ol; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so148622a12.3;
        Wed, 08 Jan 2025 12:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736367232; x=1736972032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q0Mu6USzt8pZcMlFndiVdet7lGxWxHKHxHNaBI/MpWQ=;
        b=BqojS9ol8ID8JZzjE1tqQTSQ7htsAmBCWKYtGKVnsYnsInErqfcK6bqQ5vXoiJ5nGH
         X7MrFCls10KZjW6VWvErLxsqBaYtNYN9v1xXrVMtAxSzU+HEZS2h5xmSNnu9id9tv3mi
         77yoROXE2UMqmrCG01QYmu5aRuY8szLyAnnREFsjse9xAiqyJWpmwOVxkV109U5vI6ca
         skdfXDdTjvqDuouJX7fr09RSI3KkOxMIF6n3ImX/Ik/b/cOKM4Jg+uLgTPEqnNBEsQ5c
         5KwhuCRu63AMJWkDkm4bvj6uNAQVXD6E8GAMdxEdVUZY3lHTnThOmVOaFT2IuJ6TOVUC
         FT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736367232; x=1736972032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0Mu6USzt8pZcMlFndiVdet7lGxWxHKHxHNaBI/MpWQ=;
        b=cqtbaQdR8vIyxCR/3EbOES13sDuzWHVRcHn71PCUtW2Ui+WqE4yy5K0Ps/lc2vjQXx
         BWCTpnZoS3hA4YY4SlvogHIp5WKgajNapV6hhXj3l5xZPwD+qMVK7HCoZYGlhJIdxwSH
         v4Z0v1pqQFyMbrXR05Y3wTu7iCZaMUZP4MwS8MksQ8IltuKz27NTCxEwZ5r9D+f8xifv
         iicSd3aaakvAOo0T2ODuGZ/hDXrd/aDX8MD6JFDSFPfORsvF0sEzGCPpP7Z1dey7mWWq
         8P/cGGT6LuUHy++upcwHPN9NME1vBVgG1AkqHTSDUVUjFTN5iS3FWaKvsdioWlfl3qvm
         H3zg==
X-Forwarded-Encrypted: i=1; AJvYcCXYrSlCUC2HgpU+VNpdxCGpvtzZAoiaclmCqJMN3mBFre+Yghd1PwDBBM/zIMKwZ9aez0tqgDiwaYW4uA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCU8m3dU2Vr4RrPpgiBMwJu4NBt+V4WhYkHntDFvFGSDpDeiln
	UUIMrdl9ORpYttbIlb8TkHUKStvi8bFYYJPHPwS86mgVFx/AhzeO0ScxAM5jDnSUKq0c88UFvx9
	0/aiRUpLt8x0aG4TGq0KsgDHKnbc=
X-Gm-Gg: ASbGncurt5ouT1ekLuhcHtpONzg5IY+zRu3/INk8NDEyy9SQP6VcrMjkESvUw0PSYaN
	z1x3EEk8DMMfL4ssUD/O1nYFuJv09sJ57/NkovoGWTwZ/ConLnmdUepm1uW8khd7ku6OB
X-Google-Smtp-Source: AGHT+IFNNkEwNt3XW9tvg+ntKSVroHi9GjiflzUvqWxGsNmV9ylQAqdpHKM4Qx4yk7ZTaSKJycVgLdAPHWl3fBpPZas=
X-Received: by 2002:a05:6402:448a:b0:5d3:cff2:71a3 with SMTP id
 4fb4d7f45d1cf-5d972e72a9emr3715663a12.33.1736367232302; Wed, 08 Jan 2025
 12:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-9-memxor@gmail.com>
 <593abb4c-12d6-4d61-a41e-f258cb8f22c6@redhat.com>
In-Reply-To: <593abb4c-12d6-4d61-a41e-f258cb8f22c6@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 9 Jan 2025 01:43:15 +0530
X-Gm-Features: AbW1kvakIuO9ymlvf6D_hcRibGcDcbT8WSd4YTolTKrH11kjmfwrP7BKXM387nw
Message-ID: <CAP01T74RVqKgkK9cV8ta97o2dVBNTB-b05Dk66JWF_RFLem1-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/22] rqspinlock: Protect pending bit owners
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

On Wed, 8 Jan 2025 at 07:49, Waiman Long <llong@redhat.com> wrote:
>
> On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
> > The pending bit is used to avoid queueing in case the lock is
> > uncontended, and has demonstrated benefits for the 2 contender scenario,
> > esp. on x86. In case the pending bit is acquired and we wait for the
> > locked bit to disappear, we may get stuck due to the lock owner not
> > making progress. Hence, this waiting loop must be protected with a
> > timeout check.
> >
> > To perform a graceful recovery once we decide to abort our lock
> > acquisition attempt in this case, we must unset the pending bit since we
> > own it. All waiters undoing their changes and exiting gracefully allows
> > the lock word to be restored to the unlocked state once all participants
> > (owner, waiters) have been recovered, and the lock remains usable.
> > Hence, set the pending bit back to zero before returning to the caller.
> >
> > Introduce a lockevent (rqspinlock_lock_timeout) to capture timeout
> > event statistics.
> >
> > Reviewed-by: Barret Rhoden <brho@google.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   include/asm-generic/rqspinlock.h  |  2 +-
> >   kernel/locking/lock_events_list.h |  5 +++++
> >   kernel/locking/rqspinlock.c       | 28 +++++++++++++++++++++++-----
> >   3 files changed, 29 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
> > index 8ed266f4e70b..5c996a82e75f 100644
> > --- a/include/asm-generic/rqspinlock.h
> > +++ b/include/asm-generic/rqspinlock.h
> > @@ -19,6 +19,6 @@ struct qspinlock;
> >    */
> >   #define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
> >
> > -extern void resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
> > +extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
> >
> >   #endif /* __ASM_GENERIC_RQSPINLOCK_H */
> > diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
> > index 97fb6f3f840a..c5286249994d 100644
> > --- a/kernel/locking/lock_events_list.h
> > +++ b/kernel/locking/lock_events_list.h
> > @@ -49,6 +49,11 @@ LOCK_EVENT(lock_use_node4) /* # of locking ops that use 4th percpu node */
> >   LOCK_EVENT(lock_no_node)    /* # of locking ops w/o using percpu node    */
> >   #endif /* CONFIG_QUEUED_SPINLOCKS */
> >
> > +/*
> > + * Locking events for Resilient Queued Spin Lock
> > + */
> > +LOCK_EVENT(rqspinlock_lock_timeout)  /* # of locking ops that timeout        */
> > +
> >   /*
> >    * Locking events for rwsem
> >    */
>
> Since the build of rqspinlock.c is conditional on
> CONFIG_QUEUED_SPINLOCKS, this lock event should be inside the
> CONFIG_QUEUED_SPINLOCKS block.

Ack, I will fix this.

>
> Cheers,
> Longman
>
>

