Return-Path: <bpf+bounces-43787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4AC9B9978
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E47B20F85
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732411D0157;
	Fri,  1 Nov 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHs3+yus"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07515530C
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493020; cv=none; b=G4SIRRo/3w+oic32V3FIIM9yXbAtIbAeECsPdAwdqS5O95+DXqoJg+w1XVWAsy+YFYkzP0dLEWGxDAJ5MWTJkc0YMlABC348685ifnHbzxm8cf4yr1K6kaXdLrt4Y7oK1MKzHfSv7FbzQfQVXV6Bx19ZDjkPpifUo5rJ+v3EysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493020; c=relaxed/simple;
	bh=2cVLRYTe60eUyYXsOY6Ayf+LuByjcOGeQTYVJhmK1Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYboQOY7Bkwox7qBFjK3qXaV4bXgX0CVJjp8QrSNkD01Dy+j3geGjsP7hdX+l/pkeoEYPkVdFWIXwUt08N3ZPfinB4zHSnJ+mY5ymoOkMFwzcqE2EwOw5XNcq+rCrJ8B/0xhRl7KjjD1KdfgzS/eAhQ7rjTdIEWAgQQvtQIeLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHs3+yus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646B8C4CECD;
	Fri,  1 Nov 2024 20:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730493019;
	bh=2cVLRYTe60eUyYXsOY6Ayf+LuByjcOGeQTYVJhmK1Z0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kHs3+yusAz0ubtnLyUG7nvDh6wvD3vhuzvPe75oyKVJ+cQT0gqUNwxBdxqzIUPOrl
	 WYvEN0qoYF5pLikiIv2DIyoZXDOyHTjrsx2PiAwTbu47L5UzSs8UKG0vUQ8er2ubGj
	 ESKLPzZnOei7UAnSC2uA0XQYite0ah97ji6F8jo0GpwKlNtDCEzyF5dSzKN80CGxB4
	 u/xv44gQMZu5bLBOQixRPPWiBuVz7iafDT44NIHuAyGMgliiu0fDdhVkxznzIEqAEh
	 +35mAjxQG/A7GLgY0NBV2DyUPxm7Ofj+GRbAq4jhmvUrsPGXVrw0Kx1gDaHRfU9nOO
	 TrYQmwsjYhk1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 05523CE0F74; Fri,  1 Nov 2024 13:30:19 -0700 (PDT)
Date: Fri, 1 Nov 2024 13:30:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: zhongjinji <zhongjinji@honor.com>, houtao@huaweicloud.com,
	andrii@kernel.org, ast@kernel.org, billy@starlabs.sg,
	bpf@vger.kernel.org, feng.han@honor.com, liulu.liu@honor.com,
	ramdhan@starlabs.sg, yipengxiang@honor.com
Subject: Re: [PATCH] bpf: smp_wmb before bpf_ringbuf really commit
Message-ID: <95dd16ca-c37d-4269-a008-385922ba3894@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <12bc3982-5738-5cf5-7dba-f3512a6dfac5@huaweicloud.com>
 <20241031161911.11260-1-zhongjinji@honor.com>
 <CAEf4BzZVhXXvGvtccH8w2yHdKihGbMVrGR9AL-fLFBMNr4bR2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZVhXXvGvtccH8w2yHdKihGbMVrGR9AL-fLFBMNr4bR2w@mail.gmail.com>

On Fri, Nov 01, 2024 at 12:12:58PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 31, 2024 at 9:19 AM zhongjinji <zhongjinji@honor.com> wrote:
> >
> > >It seems you didn't use the ringbuf related APIs (e.g.,
> > >ring_buffer__consume()) in libbpf to access the ring buffer. In my
> > >understanding, the "xchg(&hdr->len, new_len)" in bpf_ringbuf_commit()
> > >works as the barrier to ensure the order of committed data and hdr->len,
> > >and accordingly the "smp_load_acquire(len_ptr)" in
> > >ringbuf_process_ring() in libbpf works as the paired barrier to ensure
> > >the order of hdr->len and the committed data. So I think the extra
> > >smp_wmb() in the kernel is not necessary here. Instead, you should fix
> > >your code in the userspace.
> > >>
> > >> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > >> ---
> > >>  kernel/bpf/ringbuf.c | 4 ++++
> > >>  1 file changed, 4 insertions(+)
> > >>
> > >> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > >> index e1cfe890e0be..a66059e2b0d6 100644
> > >> --- a/kernel/bpf/ringbuf.c
> > >> +++ b/kernel/bpf/ringbuf.c
> > >> @@ -508,6 +508,10 @@ static void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
> > >>      rec_pos = (void *)hdr - (void *)rb->data;
> > >>      cons_pos = smp_load_acquire(&rb->consumer_pos) & rb->mask;
> > >>
> > >> +    /* Make sure the modification of data is visible on other CPU's
> > >> +     * before consume the event
> > >> +     */
> > >> +    smp_wmb();

This won't order the prior smp_load_acquire(), but you knew that already.

> > >>      if (flags & BPF_RB_FORCE_WAKEUP)
> > >>              irq_work_queue(&rb->work);
> > >>      else if (cons_pos == rec_pos && !(flags & BPF_RB_NO_WAKEUP))
> >
> > well, I missed the implementation of __smp_store_release in the x86 architecture,
> > it is not necessary because __smp_store_release has a memory barrier in x86,
> 
> yep, we do rely on xchg() and smp_load_acquire() pairing. I'm not
> familiar with arm64 specifics, I didn't know that this assumption is
> x86-64-specific. Cc'ed Paul who I believe suggested xchg() as a more
> performant way of achieving this. That happened years ago so all of
> us, I'm sure, lost a lot of context by now, but still, let's see.

The xchg() is supposed to be fully ordered on all architectures,
including arm64.  And smp_load_acquire() provides acquire ordering,
again on all architectures.  So if you have something like this
with x, y, and z all initially zero:

	CPU 0				CPU 1

	WRITE_ONCE(x, 1);		r3 = smp_load_acquire(&z);
	r1 = READ_ONCE(y);		r4 = READ_ONCE(x);
	r2 = xchg(&z, 1);		WRITE_ONCE(y, 1);

Then if r3==1, it is guaranteed that r1==0 and r4==1.

Or are you looking for some other ordering guarantee, and if so, what
is it?

							Thanx, Paul

> > but it can't guarantee the order of committed data in arm64 because
> > __smp_store_release does not include a memory barrier, and it just ensure
> > the variable is visible. The implementation of ARM64 is as follows,
> > in common/arch/arm64/include/asm/barrier.h
> >
> > #define __smp_load_acquire(p)                                           \
> > ({                                                                      \
> >         union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u;   \
> >         typeof(p) __p = (p);                                            \
> >         compiletime_assert_atomic_type(*p);                             \
> >         kasan_check_read(__p, sizeof(*p));                              \
> >         switch (sizeof(*p)) {                                           \
> >         case 1:                                                         \
> >                 asm volatile ("ldarb %w0, %1"                           \
> >                         : "=r" (*(__u8 *)__u.__c)                       \
> >                         : "Q" (*__p) : "memory");                       \
> >                 break;                                                  \
> >         case 2:                                                         \
> >                 asm volatile ("ldarh %w0, %1"                           \
> >                         : "=r" (*(__u16 *)__u.__c)                      \
> >                         : "Q" (*__p) : "memory");                       \
> >                 break;                                                  \
> >         case 4:                                                         \
> >                 asm volatile ("ldar %w0, %1"                            \
> >                         : "=r" (*(__u32 *)__u.__c)                      \
> >                         : "Q" (*__p) : "memory");                       \
> >                 break;                                                  \
> >         case 8:                                                         \
> >                 asm volatile ("ldar %0, %1"                             \
> >                         : "=r" (*(__u64 *)__u.__c)                      \
> >                         : "Q" (*__p) : "memory");                       \
> >                 break;                                                  \
> >         }                                                               \
> >         (typeof(*p))__u.__val;                                          \
> > })
> >

