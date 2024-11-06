Return-Path: <bpf+bounces-44150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E419BF7BC
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B4A1C212CF
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0B209F28;
	Wed,  6 Nov 2024 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsK6MMuz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CB199247
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923386; cv=none; b=iLNZ2bHAKpir2EfjD3RVuNpXIfagEHsehrCE/GYPelrmQuDM3MNsvF/WNk0qQkBHCTqrUqiYEdbIRzYg9tuQVJWuuFZjhDadvGTE3X8O8WNM8ulNEEuIBjcb+q038oKiAzv0/mspNYQQh77XAx7nno46XdzuUwnRm7tXimu2FEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923386; c=relaxed/simple;
	bh=ad9zKXW4xjVHfbncarln4yvJTwhj4TjGU39aTvkTAhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zu3IHmFIIL87FqHQbF9TzBesVLTtwjAdBdytYFihZ4G7+JwOksugKIubai1p4dYUxV9lVx/SIQoqEWW4flj0wK5yBQ2V7Bo1Y1dodBpTemvW1ZWh6X+yztaBnogFvK1PkDe2PCyOu0Bqru1ufwAspbop5Tifc0jcOX5Ne4gunTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsK6MMuz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cceb8d8b4so1593175ad.1
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730923384; x=1731528184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv0s0JXqd7LLCNdomxxE6WAfpzpVC9Bm9Q5MiZv2EfA=;
        b=IsK6MMuzMGRfE4IyIWgDGkJHNw8BlrKVKY7RrrvHROW3bEWRDCev1aIAuVwPQpV6Ij
         coB5IL80OI9VgXCLDpGGDhfrvfforAJNBiBTPssl+Wzy2H8Ir+BdPfHo28YnJT31MMF+
         Tcz5bYS4L+n2Umqe2JKy4rYIF4UIeH7mtYi37rLRtMWsTmMkznNkFiFfsjT24iS5E1uU
         Ck1z9ra+vJWGsVbc97to2OptoE2Efiwcnz3YJgP2hngsvJ5OpdpD8ndCAx4VtiH15art
         AIfkZ6rLljCqs7fu+W+Fp+t5hpYhip5Vfn/NGJIXkvzCoStdrN/6X6C9sppOrUmMbqU7
         h7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730923384; x=1731528184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rv0s0JXqd7LLCNdomxxE6WAfpzpVC9Bm9Q5MiZv2EfA=;
        b=QOdd9nAkEqV/OYbHtilNwtxrno3a0B+OZ7XByqyCe8Q0t8++Pr2EOjW4W9fUvp6qpx
         VVmlAAZn5q6eUXZAG04C/i6GEdJIwiVrHmWqnLLI/7q9BKv4p5nxGur1t7jsCjs1qvHM
         kksc1xSS/20q+rWvoMQvLy0wsy3wLiT4InrcGuzyL1cqKPv6n4wpMqORd6UGLKbdgmrH
         3KtCNFiGQwGEZvuxWCk+PspF6d3HRI5uvlA8Vai6PZla2P1PUO+r+vdTbm+VH9Um6vSj
         XMOOEekP6B8e5uK2XH6HKxTR7spHlDl3errvQOpasBgSEOFVuvrk7QaZU933RNz/W9Iw
         hENQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPIoW8038CuH0Vybfr255PrltuXLEDgdU0hGUYI1PqCmyQW+5EiyalklUbHg9cOJ2wjF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLXq7O3RHs3GJZkuWChxIrQV1T311vEIvY7ufX3RDOHprooor
	LqF6Nh28DtuzoDakZfpsIQT8ybPTmTpqW4+LAp14Bu3fQaneyWBB/Djw3s2PgjQdRZIQTV/23Qo
	d8Ss4CNIDanAWvMyKrQNCRmRRCEI=
X-Google-Smtp-Source: AGHT+IEVuUqmpWJHt9LjJqUqC/M2AcpAFJ39O+tWiSzX6FYXintCvFVTmY4riGh8zo5ZrHLu8A5kA5JuNJNKM5iYgV8=
X-Received: by 2002:a17:903:181:b0:20c:b3ea:9006 with SMTP id
 d9443c01a7336-21175a93c88mr8243045ad.6.1730923384041; Wed, 06 Nov 2024
 12:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12bc3982-5738-5cf5-7dba-f3512a6dfac5@huaweicloud.com>
 <20241031161911.11260-1-zhongjinji@honor.com> <CAEf4BzZVhXXvGvtccH8w2yHdKihGbMVrGR9AL-fLFBMNr4bR2w@mail.gmail.com>
 <95dd16ca-c37d-4269-a008-385922ba3894@paulmck-laptop>
In-Reply-To: <95dd16ca-c37d-4269-a008-385922ba3894@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 12:02:51 -0800
Message-ID: <CAEf4BzYd-0yhU5nT=BQU6Db_fbTBWwe4o1_R7V9YV4E46Ba3cw@mail.gmail.com>
Subject: Re: [PATCH] bpf: smp_wmb before bpf_ringbuf really commit
To: paulmck@kernel.org
Cc: zhongjinji <zhongjinji@honor.com>, houtao@huaweicloud.com, andrii@kernel.org, 
	ast@kernel.org, billy@starlabs.sg, bpf@vger.kernel.org, feng.han@honor.com, 
	liulu.liu@honor.com, ramdhan@starlabs.sg, yipengxiang@honor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:30=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Fri, Nov 01, 2024 at 12:12:58PM -0700, Andrii Nakryiko wrote:
> > On Thu, Oct 31, 2024 at 9:19=E2=80=AFAM zhongjinji <zhongjinji@honor.co=
m> wrote:
> > >
> > > >It seems you didn't use the ringbuf related APIs (e.g.,
> > > >ring_buffer__consume()) in libbpf to access the ring buffer. In my
> > > >understanding, the "xchg(&hdr->len, new_len)" in bpf_ringbuf_commit(=
)
> > > >works as the barrier to ensure the order of committed data and hdr->=
len,
> > > >and accordingly the "smp_load_acquire(len_ptr)" in
> > > >ringbuf_process_ring() in libbpf works as the paired barrier to ensu=
re
> > > >the order of hdr->len and the committed data. So I think the extra
> > > >smp_wmb() in the kernel is not necessary here. Instead, you should f=
ix
> > > >your code in the userspace.
> > > >>
> > > >> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > > >> ---
> > > >>  kernel/bpf/ringbuf.c | 4 ++++
> > > >>  1 file changed, 4 insertions(+)
> > > >>
> > > >> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > > >> index e1cfe890e0be..a66059e2b0d6 100644
> > > >> --- a/kernel/bpf/ringbuf.c
> > > >> +++ b/kernel/bpf/ringbuf.c
> > > >> @@ -508,6 +508,10 @@ static void bpf_ringbuf_commit(void *sample, =
u64 flags, bool discard)
> > > >>      rec_pos =3D (void *)hdr - (void *)rb->data;
> > > >>      cons_pos =3D smp_load_acquire(&rb->consumer_pos) & rb->mask;
> > > >>
> > > >> +    /* Make sure the modification of data is visible on other CPU=
's
> > > >> +     * before consume the event
> > > >> +     */
> > > >> +    smp_wmb();
>
> This won't order the prior smp_load_acquire(), but you knew that already.
>
> > > >>      if (flags & BPF_RB_FORCE_WAKEUP)
> > > >>              irq_work_queue(&rb->work);
> > > >>      else if (cons_pos =3D=3D rec_pos && !(flags & BPF_RB_NO_WAKEU=
P))
> > >
> > > well, I missed the implementation of __smp_store_release in the x86 a=
rchitecture,
> > > it is not necessary because __smp_store_release has a memory barrier =
in x86,
> >
> > yep, we do rely on xchg() and smp_load_acquire() pairing. I'm not
> > familiar with arm64 specifics, I didn't know that this assumption is
> > x86-64-specific. Cc'ed Paul who I believe suggested xchg() as a more
> > performant way of achieving this. That happened years ago so all of
> > us, I'm sure, lost a lot of context by now, but still, let's see.
>
> The xchg() is supposed to be fully ordered on all architectures,
> including arm64.  And smp_load_acquire() provides acquire ordering,
> again on all architectures.  So if you have something like this

I think this is what we need and should be sufficient. Thank you,
Paul, for confirming! Seems like we don't really need to add anything
extra here.

> with x, y, and z all initially zero:
>
>         CPU 0                           CPU 1
>
>         WRITE_ONCE(x, 1);               r3 =3D smp_load_acquire(&z);
>         r1 =3D READ_ONCE(y);              r4 =3D READ_ONCE(x);
>         r2 =3D xchg(&z, 1);               WRITE_ONCE(y, 1);
>
> Then if r3=3D=3D1, it is guaranteed that r1=3D=3D0 and r4=3D=3D1.
>
> Or are you looking for some other ordering guarantee, and if so, what
> is it?
>
>                                                         Thanx, Paul
>
> > > but it can't guarantee the order of committed data in arm64 because
> > > __smp_store_release does not include a memory barrier, and it just en=
sure
> > > the variable is visible. The implementation of ARM64 is as follows,
> > > in common/arch/arm64/include/asm/barrier.h
> > >
> > > #define __smp_load_acquire(p)                                        =
   \
> > > ({                                                                   =
   \
> > >         union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u;=
   \
> > >         typeof(p) __p =3D (p);                                       =
     \
> > >         compiletime_assert_atomic_type(*p);                          =
   \
> > >         kasan_check_read(__p, sizeof(*p));                           =
   \
> > >         switch (sizeof(*p)) {                                        =
   \
> > >         case 1:                                                      =
   \
> > >                 asm volatile ("ldarb %w0, %1"                        =
   \
> > >                         : "=3Dr" (*(__u8 *)__u.__c)                  =
     \
> > >                         : "Q" (*__p) : "memory");                    =
   \
> > >                 break;                                               =
   \
> > >         case 2:                                                      =
   \
> > >                 asm volatile ("ldarh %w0, %1"                        =
   \
> > >                         : "=3Dr" (*(__u16 *)__u.__c)                 =
     \
> > >                         : "Q" (*__p) : "memory");                    =
   \
> > >                 break;                                               =
   \
> > >         case 4:                                                      =
   \
> > >                 asm volatile ("ldar %w0, %1"                         =
   \
> > >                         : "=3Dr" (*(__u32 *)__u.__c)                 =
     \
> > >                         : "Q" (*__p) : "memory");                    =
   \
> > >                 break;                                               =
   \
> > >         case 8:                                                      =
   \
> > >                 asm volatile ("ldar %0, %1"                          =
   \
> > >                         : "=3Dr" (*(__u64 *)__u.__c)                 =
     \
> > >                         : "Q" (*__p) : "memory");                    =
   \
> > >                 break;                                               =
   \
> > >         }                                                            =
   \
> > >         (typeof(*p))__u.__val;                                       =
   \
> > > })
> > >

