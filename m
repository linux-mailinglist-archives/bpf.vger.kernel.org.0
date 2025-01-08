Return-Path: <bpf+bounces-48294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0085A065CA
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB6188983F
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE207202F61;
	Wed,  8 Jan 2025 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An5opI/8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953721DF963;
	Wed,  8 Jan 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367196; cv=none; b=cVOFY2pqp6JFk75ln226GkrbWUyny3jvOceKCP+YtjGKWnQmWFSRBEYVtESxpEhDTTgB9oWDZfGbWmCJezsHScZhXpsVBMv+pnJX+k6US6mVa3i86nIsnAYHoLvZSdVMAR62xA8jZRHX0V1CjV8nhKp4/1AnBpupFM41vgrrq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367196; c=relaxed/simple;
	bh=Yevwme4h5wUU0/+FbPPGWOzcr5RdzxKfilTRF9DUyl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHveqO8kY62HZraCFtpl3nNHBZcFzefY0vBsB4uzAhAdl0dSt1vjUvfths6ExvxZ95qULvHvzryIhL5yjHwYgRG9w0/e705UiUMcJ1wST2EI8rP6AYWKfWltKL+tWK5ccSyqcvUxOxlbHgfIeu6PU3PHew2boAu9+qdBMUtIqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An5opI/8; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so36298666b.1;
        Wed, 08 Jan 2025 12:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736367193; x=1736971993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yevwme4h5wUU0/+FbPPGWOzcr5RdzxKfilTRF9DUyl8=;
        b=An5opI/8O/F5VNvuM132CBxd8ndOa5/6b4YTU8RdHMfBrgI9gYdwHUfIWDebcof3N8
         l2JjZHbOC/GhPN5z9+A0kzAW0nAh6ncqdIJgggI/qr65ccVMRLL+VegFgpQ4XsDH5yUo
         mkxbhx8brsYGQYh15sS/XLcwSNpN6+TKKH9o3iLc8/Gh04EaGs1SXa8XcLXeb64ruNLu
         GFdBt4O8Hiuhr8RPbT+o04kcJjlgdjiqnBwEQ3+2obi93iaxnRvB44hxJm9aHc/tfmKC
         9eLQKZU5/Xze7NXyXzXlde2rJPTuJ5c0weyeYwH0Z+noLG9WdeJFaepnL8QYmBcQef5/
         dvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736367193; x=1736971993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yevwme4h5wUU0/+FbPPGWOzcr5RdzxKfilTRF9DUyl8=;
        b=xI7kkAUoLtHWutpBvFhItlgt4XBfXkZ6OXJWkaThf5pKYskPJpK3ygPah5Mb6df+F9
         TYHta7+hW+sj6p3Qfa2mTX3pyU+krkZYUVPJcNvVQ7YyubqyILPGYg48lxgbMqPCwl7N
         /JI2RXSAboDBW05pxob6f6pBOgIrI4CWMieiQEnj03BDuS8bJPP3sFDdX8Orc0d6bvDv
         jQivbL2tmPFuruZbvfycflztFD3UCebgwIA4IKaInl5aFj6PwzsCMFA/JqF+j+mHvNDq
         5Fi3FCrwqNVWWJPR4GaBtLPz1wfry+XCUuCWStRpvpfvyDQCtofcVxCBJ4RXJEPX1jc+
         c8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhCOtT6M3n/QKa2XIltrAnF7CVktjtGxsL42G+y2e90O1PHPJzLsx0aRm3wPfaYvPTZeE=@vger.kernel.org, AJvYcCX01xu80Yn8jhLqIFaQtJ070rbc9WVX1/Hfr1nRBsNS4lWIDE3krfc2VKG0yejEYio8MO7h7Ammdx2qcRY8@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7ttOk9u1VA+eSUYZupVoOwfURXYy3oV1TSs/tXH5WNR/Qrg8
	TSHcBIVLNxzlTop7AbzS+ceWJbirqOwr0qDhx/25xezJ2+ht1tAyXriJ65JwnZTKgOl9habOCpo
	6rMOTJFlOxPX7T4YKE12FbwUvQMc=
X-Gm-Gg: ASbGnct1myRDkgtpsCN7wE5CN2JlaRKamWx1XIBh7Wh9bvR6TpeDWPFvQR9iegL2+7I
	jonJFXFj1TnqUJ9jIatAUaE6VeX3inbuujUahCavcvvx24X2X+XApqJ1bk1bfrlmjHxzv
X-Google-Smtp-Source: AGHT+IEaSUbx0MmumKxTvV8aofe6bH1AdvOR7RZmmGX8VQNiN91RopG4OHyA6lVJzZO0a7AG8vAGP3zsAy4BVT3AUvo=
X-Received: by 2002:a17:906:f58a:b0:aa6:5e35:d72d with SMTP id
 a640c23a62f3a-ab2ab703f0dmr310510566b.24.1736367192360; Wed, 08 Jan 2025
 12:13:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <CAHk-=wh9bm+xSuJOoAdV_Wr0_jthnE0J5k7hsVgKO6v-3D6=Dg@mail.gmail.com>
 <20250108091827.GF23315@noisy.programming.kicks-ass.net>
In-Reply-To: <20250108091827.GF23315@noisy.programming.kicks-ass.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 9 Jan 2025 01:42:35 +0530
X-Gm-Features: AbW1kvarMCOPdlA0QcqUaTzGZVg96Mavqd2DWKe8mBq2iRn-CjeYmuEnBP1TGAw
Message-ID: <CAP01T75XoSv91C6oT8WSFrSsqNxnGHn0ZE=RbPSYgwX79pRQVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/22] Resilient Queued Spin Lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Waiman Long <llong@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 14:48, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 07, 2025 at 03:54:36PM -0800, Linus Torvalds wrote:
> > On Tue, 7 Jan 2025 at 06:00, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > This patch set introduces Resilient Queued Spin Lock (or rqspinlock with
> > > res_spin_lock() and res_spin_unlock() APIs).
> >
> > So when I see people doing new locking mechanisms, I invariably go "Oh no!".
> >
> > But this series seems reasonable to me. I see that PeterZ had a couple
> > of minor comments (well, the arm64 one is more fundamental), which
> > hopefully means that it seems reasonable to him too. Peter?
>
> I've not had time to fully read the whole thing yet, I only did a quick
> once over. I'll try and get around to doing a proper reading eventually,
> but I'm chasing a regression atm, and then I need to go review a ton of
> code Andrew merged over the xmas/newyears holiday :/
>
> One potential issue is that qspinlock isn't suitable for all
> architectures -- and I've yet to figure out widely BPF is planning on
> using this.

For architectures where qspinlock is not available, I think we can
have a fallback to a test and set lock with timeout and deadlock
checks, like patch 12.
We plan on using this in BPF core and BPF maps, so the usage will be
pervasive, and we have atleast one architecture in CI (s390) which
doesn't have ARCH_USER_QUEUED_SPINLOCK selected, so we should have
coverage for both cases. For now the fallback is missing, but I will
add one in v2.

> Notably qspinlock is ineffective (as in way over engineered)
> for architectures that do not provide hardware level progress guarantees
> on competing atomics and qspinlock uses mixed sized atomics, which are
> typically under specified, architecturally.

Yes, we also noticed during development that try_cmpxchg_tail (in
patch 9) couldn't rely on 16-bit cmpxchg being available everywhere (I
think the build broke on arm64), unlike 16-bit xchg which is used in
xchg_tail, but otherwise we should be using 32-bit atomics or relying
on mixed sized atomics similar to qspinlock.

>
> Another issue is the code duplication.

I agree that this isn't ideal, but IMO it would be too ugly to ifdef
parts of qspinlock slow path to accommodate rqspinlock logic, and it
will get harder to reason about. Plus there's distinct return types
for both slow paths, which means if we combine them we end up with the
normal qspinlock returning a value, which isn't very meaningful. We
can probably discuss more code sharing possibilities through common
inline functions to minimize duplication though.

>
> Anyway, I'll get to it eventually...

