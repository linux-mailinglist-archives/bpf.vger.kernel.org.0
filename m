Return-Path: <bpf+bounces-48345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B131A06B95
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F8418882BC
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96612B17C;
	Thu,  9 Jan 2025 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU6zAHLI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0B17BA6;
	Thu,  9 Jan 2025 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390545; cv=none; b=M4OQy6o40i9As5j98ef4vIcY0VWleqy7IE8lRGeCSoqu/6BYXYQbVVay4+TLI+RrxVtS+6iG/wn+KBIdNLao91OgXk9mSFyyF8Gc9Uzg50KW/+dRvsFi5/M7E0JCHtCvEhsDgL1jP0oRCFqi/zcfz2FOiNYQ3qJCAZndhiDEmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390545; c=relaxed/simple;
	bh=Hk+lEux6ZIXX9NU6VrkL6uK2EOF9dfonew3tR5EM6Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdvUPuN+rJx0IFumaykSshu/Of4EpDpMXFl0OYTc0qf70E6U9lDfqtfId32ZsJd7Wiph62AtP5+oFGiq8JZ/jkhf4JLpCNVC9aZFdlBCCqAGcvyLY0hfa13MSpDLzFlykbo2kPKRFNwGQOB9bfGDdE/LgURlY+X2NRu+nfDnx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU6zAHLI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385deda28b3so249527f8f.0;
        Wed, 08 Jan 2025 18:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736390542; x=1736995342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJHkzd76fIH7qdh8WDNTtF1WAJtF5o6l8AAQNZ85xhg=;
        b=cU6zAHLI4xtnewDlagtJiQs8OIPxfLNnnFposNchgy7bLAdbjPD92fIJVo6b+sDfMk
         ATJTKm/oT7KWZUvBPKx1/+Jbl6FzHpMo5qEq6NNHX7so+HbjuZGxm71rCLiWF+bAjfqC
         oUWo+KFCsmvEr05Jhrg7fpG3wxKdpOc3fBJDexN1arQGqwbC0JvzlH1Q9gghb9D2HV30
         AweQiXccLaly/Kqu2yWfR/V989Xp2MeSu4vfZNn35JaBuGuyT0ZuZSXkCYMQRTys+shR
         cy9f2RR32AsDghc/LoEt1eTs+cTZUD3Qbckk/kDSvXCj9zSJFIpmWDza0JEcb1btJT/M
         IbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736390542; x=1736995342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJHkzd76fIH7qdh8WDNTtF1WAJtF5o6l8AAQNZ85xhg=;
        b=rA6UCTw596jnBiOhO8LsYFqp7fUDd9fPeB1LXnSRAXSGVAV9BlaXl1v9Yi2jtqMwJB
         SHgHRQ6YQWkGD8/P7T7guvOoPkwNrVJkrjcMMsEQc5Ee642poRMPYvCSk50yMswD5Ere
         cDX4sfH+NIHqlROd7hIFWNP5oabKXmuPMkkgeYDMhhqZdUnl0SaOaVmBhRZzwojxaqki
         Wks3JjAiIJFHjbpmZmdSqkBwF1Dx3KUhP3rEqqN+Cx35V3kbDRsVHToEu/fd1fGPSjg9
         uyYwz5MhsFj0+e7HXasC1hXUUef6jBQypJt4SQej9gqQhsnhYuGgTjbzoxynLZQO5tTp
         yJYg==
X-Forwarded-Encrypted: i=1; AJvYcCV7ntHt7whmxf1JBDsNz2Sg6LVBOkT+Xj8R5ANSIO2VkMiAkvW+TBQiSzrPec/I2XWw3A8=@vger.kernel.org, AJvYcCWOOebVrWcxgKPTygDYKVVsHCSsi30VHZfoaRr90tTwv5nZSNaiXeQwIxjmXLTS3Drh19vfxNw/VHWrM5Pc@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfZyqZmiXqk9XuXChNLZqgek8Bo5VJXIof5SS8uPy5no5GJRX
	tU5EtSMNuE5ylQoUaN81fYfd0TcnHo1nmVE1+uzWqSeWgsdV1252vWUM9ku7uOJjsBVkZ7BnaDD
	Pba1JBhY/t/zp4QHTsbTtIT2i2dE=
X-Gm-Gg: ASbGncsFddtu9PIsVO1QP9CGHJBAMAfdnzXiZVaVS2dh7FkUJgvpFQcChUcChlJQC1g
	DTNqTMoy+FayKclNJf9bHD+ujtNeM5Tid/DgacW6fPXtoItk2L2QQ0RvssFPk3ZHfo7lLgA==
X-Google-Smtp-Source: AGHT+IEiaWMYAA7pWLgaQg8I1D5xJkECNLzMxhtaknaFLFlzxihN3ApiC1NYQZbE50W/9/I8IYMf4VQvA5v9rNKL19Y=
X-Received: by 2002:a5d:6c63:0:b0:385:ee59:4510 with SMTP id
 ffacd0b85a97d-38a872fb0f9mr4109473f8f.9.1736390541859; Wed, 08 Jan 2025
 18:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-13-memxor@gmail.com>
 <2eaf52fb-b7d4-4024-a671-02d5375fca22@redhat.com> <CAP01T74UX4VKNKmeooiCKsw7G6qkhohSFTXP0r=DZ1AuaEetAw@mail.gmail.com>
 <dfbaf200-7c87-41b2-ab87-906cbdf3e0d7@redhat.com>
In-Reply-To: <dfbaf200-7c87-41b2-ab87-906cbdf3e0d7@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Jan 2025 18:42:10 -0800
X-Gm-Features: AbW1kvZ8udp3PDHOpFIPylByQHOj7cavPkvIEq2l5cgn7-TmrNJNa5VAtaPJTCg
Message-ID: <CAADnVQJdPNOOXzQvTTx_i4yYYAoOKe=u7yHJiRHSt8O13vp6VA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 12/22] rqspinlock: Add basic support for CONFIG_PARAVIRT
To: Waiman Long <llong@redhat.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:48=E2=80=AFPM Waiman Long <llong@redhat.com> wrote=
:
>
> Is the intention to only replace raw_spinlock_t by rqspinlock but never
> spinlock_t?

Correct. We brainstormed whether we can introduce resilient mutex
for sleepable context, but it's way out of scope and PI
considerations are too complex to think through.
rqspinlock is a spinning lock, so it's a replacement for raw_spin_lock
and really only for bpf use cases.

We considered placing rqspinlock.c in kernel/bpf/ directory
to discourage any other use beyond bpf,
but decided to keep in kernel/locking/ only because
it's using mcs_spinlock.h and qspinlock_stat.h
and doing #include "../locking/mcs_spinlock.h"
is kinda ugly.

Patch 16 does:
+++ b/kernel/locking/Makefile
@@ -24,6 +24,9 @@  obj-$(CONFIG_SMP) +=3D spinlock.o
 obj-$(CONFIG_LOCK_SPIN_ON_OWNER) +=3D osq_lock.o
 obj-$(CONFIG_PROVE_LOCKING) +=3D spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) +=3D qspinlock.o
+ifeq ($(CONFIG_BPF_SYSCALL),y)
+obj-$(CONFIG_QUEUED_SPINLOCKS) +=3D rqspinlock.o
+endif

so that should give enough of a hint that it's for bpf usage.

> As for the locking semantics allowed by the BPF verifier, is it possible
> to enforce the strict locking rules for PREEMPT_RT kernel and use the
> relaxed semantics for non-PREEMPT_RT kernel. We don't want the loading
> of an arbitrary BPF program to break the latency guarantee of a
> PREEMPT_RT kernel.

Not really.
root can load silly bpf progs that take significant
amount time without abusing spinlocks.
Like 100k integer divides or a sequence of thousands of calls to map_update=
.
Long runtime of broken progs is a known issue.
We're working on a runtime termination check/watchdog that
will detect long running progs and will terminate them.
Safe termination is tricky, as you can imagine.

