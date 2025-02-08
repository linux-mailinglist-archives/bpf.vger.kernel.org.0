Return-Path: <bpf+bounces-50830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D02A2D2C4
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 02:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3F6188D499
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 01:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40B613B7A3;
	Sat,  8 Feb 2025 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvA2GE9P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7363B19A;
	Sat,  8 Feb 2025 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738979643; cv=none; b=lngSU06wRlyO1KX/W9NkMte4Dbq3Y7tQ/cpLL9rpQJjclasnjxlkMa179TT8bTjU74LS8g+ERJ0Y7hTbMS1LH5Erz9d/t3NFiuiqwIqiYQNfat2JQih10nRRU8APzjHf3dmUzkymMS2VoACT7qCMrd07NCVZWJVL2QnUZ5c1a4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738979643; c=relaxed/simple;
	bh=XS33MVhIjfVKk8upTaLO5OR1KiRd8GIcCgqMSRLT0VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/1nSmab7F4gkhTWnBzCNWlR03fZ7oQ6U+EbwGUA9fjxCMCvcKAWYHtMLleowVyiRuPwHKyTdzs0l1tjazpHh6NPC+G7MYpWQlVNCJA0kk4aVb9aPM+NwceTC5B83Yx7zlK2Z7XPbzoHHf8n6dTXBU6J4p8rwe2ECP5fybFNrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvA2GE9P; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361f664af5so28903955e9.1;
        Fri, 07 Feb 2025 17:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738979640; x=1739584440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/goMiwoZ9a2nGgXHy/KgywCzCXPCOrvFLwPlIkrV3lQ=;
        b=lvA2GE9PGg16050w0Wz3CvC/I7hCbdYWHYaWZLy4JPergRHJ0cZzoA6lDLor4WVetI
         scc27wKFfpHOHH9Jk7Wi1ry77gYo23B9Sttg8mZabdcUqN51svTEV48vcZCbC2Xg3MD2
         ZdKr4wRWbnupooLlzIrOpmKI6unYojKg1njGusUfLa5xhfiNlCiGciLgntEPfKOei4H8
         veJuE2wd+j8jZfybt8bDFEvAhZNnFLXJIg/mo8IQQVJZRxXm5eCDHIt/xmJsdftpZLrj
         vJXtq4Vwsa/IuvwKbVN4T008xpfwzNcj9bc6/Fr12MAl93wGm3jxlW07mS16EDby6ENl
         EZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738979640; x=1739584440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/goMiwoZ9a2nGgXHy/KgywCzCXPCOrvFLwPlIkrV3lQ=;
        b=e4OuT08zkz2x51ZmbQ1HytnzQuVCCKwtMIqVfMViXfEJywIkMxqoPzhgpAHAkN1chk
         YHlIKH3cKLzEBuGYo8/Ggv8is1xtUa0+QdjtCOmiSZAW9/jRznY+8uKCBjIkchKqcv1k
         S6N7sliM0A20XJ/nr4Aank30mBfZLDDUcy5JhNshSINwf7CrUqT/NllJuccwUB6yBaAj
         yO6Z7m28OHYkjuHrvxPOqPSPfFA9GJmAANyU3vWvQgDd9k4YOBX0R5Ty2FmeV62ikzeH
         FA4scj94N+kIRTDQ9Dr8arxfbtGLUG6sxTAc7InfhdVorfJxpxsDFM21YqfUFO6c3ucY
         35gA==
X-Forwarded-Encrypted: i=1; AJvYcCX0RcmWyLo/eShXKeu337atRo1hTkaIPYEjIG9Nf2JvV8u9VXeSTwpuMtSDUTVzIainaFZOxMqm5pqhP50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzGJ9OfdjzpgmR+z7VgTtkYcMXgXVwXR57rJTqORs9vhno4Z4
	iwM7sqYgfkAAozTmIyveoZxugDRf0t6f2OCga6StlOlHJOXI9E3PRS8OG/dh+rh+gSceGJ2oC4V
	FDVaU2ELRiGN9Q3qYuNSpu1Q9hnU=
X-Gm-Gg: ASbGnctlq/QXTwdJkx6DK+wZCdAA9MhGct7A3J8hY5wB+zsFmFj/9w4t1XiRxFrNXZc
	3GKbDM4HQyyt+RRW9juJ4mlJoFRLhPODla/7jzFnsiV4XWOEx6LgXQOfALLzXR3wqd7YlWur8E7
	IuZZKA2lyqLGfbGgkG1D7WtOHJTWFw
X-Google-Smtp-Source: AGHT+IG9ncxhWb1JDjWrffjcJaSLE/cGisHt3doGbPXfB2uc5syeNwNjChl7mOFipKQ8YpOR06lQMAWoY36G1lYyN2E=
X-Received: by 2002:a05:6000:1041:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38dc8dec2f6mr3125108f8f.33.1738979639593; Fri, 07 Feb 2025
 17:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-12-memxor@gmail.com>
In-Reply-To: <20250206105435.2159977-12-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Feb 2025 17:53:48 -0800
X-Gm-Features: AWEUYZnAQdSbylvQFKH-kduRkJgF7cpFCzktTKz3eyY2jqCF3QQ_ePHqKFyE-Ks
Message-ID: <CAADnVQL=E3F5-Uwa5_508e+OKzLnLGJGtAMhv1WW8kHobzBMgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/26] rqspinlock: Add deadlock detection and recovery
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:54=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> +/*
> + * It is possible to run into misdetection scenarios of AA deadlocks on =
the same
> + * CPU, and missed ABBA deadlocks on remote CPUs when this function pops=
 entries
> + * out of order (due to lock A, lock B, unlock A, unlock B) pattern. The=
 correct
> + * logic to preserve right entries in the table would be to walk the arr=
ay of
> + * held locks and swap and clear out-of-order entries, but that's too
> + * complicated and we don't have a compelling use case for out of order =
unlocking.
> + *
> + * Therefore, we simply don't support such cases and keep the logic simp=
le here.
> + */

The comment looks obsolete from the old version of this patch.
Patch 25 is now enforces the fifo order in the verifier
and code review will do the same for use of res_spin_lock()
in bpf internals. So pls drop the comment or reword.

> +static __always_inline void release_held_lock_entry(void)
> +{
> +       struct rqspinlock_held *rqh =3D this_cpu_ptr(&rqspinlock_held_loc=
ks);
> +
> +       if (unlikely(rqh->cnt > RES_NR_HELD))
> +               goto dec;
> +       WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
> +dec:
> +       this_cpu_dec(rqspinlock_held_locks.cnt);

..
> +        * We don't have a problem if the dec and WRITE_ONCE above get re=
ordered
> +        * with each other, we either notice an empty NULL entry on top (=
if dec
> +        * succeeds WRITE_ONCE), or a potentially stale entry which canno=
t be
> +        * observed (if dec precedes WRITE_ONCE).
> +        */
> +       smp_wmb();

since smp_wmb() is needed to address ordering weakness vs try_cmpxchg_acqui=
re()
would it make sense to move it before this_cpu_dec() to address
the 2nd part of the harmless race as well?

