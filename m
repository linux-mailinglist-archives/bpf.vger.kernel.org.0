Return-Path: <bpf+bounces-43764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9009B9831
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF801C2184E
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463CC1CEEBA;
	Fri,  1 Nov 2024 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSVDu2U1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA061CEEA8
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488392; cv=none; b=ioAK3mErsLrlh0nq/nZzNrjmNkz1nnqrm/ZF4SPJ4SrgpafRBH3fkUrE+PgL+HmJHVEPlkguFPHqqUcAtv1dZGzZPOrVfM6oXZ2uI+fbQ0bURpDQcRlETnioaMdNtgrZmAv1W8QXw+tkEMRj7YjJLrFCzNLnI0NGq8vtdWATHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488392; c=relaxed/simple;
	bh=4wvMWurYikD6KdTQa6gHNCFoDIv/bBiMx3JZ6v9IdNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCSyIE4PXIoV2fpcIMWJQS1hWhVItM9N64GmINEadTQ9B2M4WavywWSI6NBSTlwZbHOb0QbRZPAEPk6QV2Y2SVkIdDZuDLkC80/JHHl1HZOahbU6z603YxmcR3xvjLdnSKwXmuq81+QDRjNw/r9GSUxeGfnj65ulQZ5NpPfUxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSVDu2U1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ede6803585so2497912a12.0
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730488390; x=1731093190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDg+3VKfoCtzwXs/NB9BmeutnAcL2v2mtlhap8Dr2sY=;
        b=SSVDu2U1EfPKL/KSf9ljFH491aa7hlxGZ6KhHCXzeOVYgvH8anGNrTfeinHshJnRvP
         NDIyC0FNgR+QAzjEdMwoopYSvA1TM8go7blix/kHbBcMHwtZAUxqxGSarkDUqGczWlRi
         U9g5C5aULCTiF/cccQiXrHOmAYs1P2orDpIC1YJf/+3WHn+brTAembcMyxY95LkID985
         N7j6m5+wwIgtCGDe29gkfdpcHi/0m/+tQLQwvX/5gumvxArkypbCV0Nr2WFa2sXNJMeB
         GpvzeTr3TB/WyOjRSvJOO56LE8/mH/CipgyuBipBcNjBq8ZJbdMHRZShEuyzd7lDWCNl
         GiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488390; x=1731093190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDg+3VKfoCtzwXs/NB9BmeutnAcL2v2mtlhap8Dr2sY=;
        b=R8Db/3ZAnYJdwsdOkH6prHBHpo/fe+OrDbV7xuzvxpA789iu0ZH9JfD/WKa9JtBg0K
         JIFYMxk+dT9BOsnPT8JK42x9xdz8y04b5/ASS455Dhm/Wf2ld/qzQT+9s5Ef4vnSV2j6
         WSaLgx5OEXGtMLuQURDS/0eOBIQcllqy6GT7oSNWyA8LoLrc/up8RConttFkZTWJT58b
         IkOAn6psrvwhEFK2CfQSLYP0btm17AlM0OuuVOEc7gKsyanJYjmOh4W5vXig8K+usV+F
         JXzCz3o5S1ll+4YKGV5y086Zb2i8lN84TYHzSpT+VhJMeSpSoFSLNsY8yf8nBjl4HteO
         F/wg==
X-Forwarded-Encrypted: i=1; AJvYcCWBoZquRXO5/Ru4f6OyDv1kpJehTfuuSahM76NkIvt50xnqe3HkzideHJNHA0fevE4oVRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KbcWwZU2Wvoq4NdjyZnSwhECQZPD/DZkphB1SS+qIZDWR9eg
	VRQFYAy7CE8cPf9PTqRayGvE8rzvbAhLZJlit661AWNpJ9sdPZW/06TLY0jCGHNgeFlYWgyygiI
	lGuyp6pX67aMvlKtfo3eNvdeCW40=
X-Google-Smtp-Source: AGHT+IGNzQeTGGBaTg012Y0MmIzW43OQLI6k0+6ItSYmV0rMGlNpS5UG7Mf0nhueQJ3Mx/MIc1tZGDxa+7FHIxqFhrg=
X-Received: by 2002:a17:90b:4ac7:b0:2e9:20d8:414c with SMTP id
 98e67ed59e1d1-2e94bcdcb02mr7740988a91.5.1730488390476; Fri, 01 Nov 2024
 12:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12bc3982-5738-5cf5-7dba-f3512a6dfac5@huaweicloud.com> <20241031161911.11260-1-zhongjinji@honor.com>
In-Reply-To: <20241031161911.11260-1-zhongjinji@honor.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:12:58 -0700
Message-ID: <CAEf4BzZVhXXvGvtccH8w2yHdKihGbMVrGR9AL-fLFBMNr4bR2w@mail.gmail.com>
Subject: Re: [PATCH] bpf: smp_wmb before bpf_ringbuf really commit
To: zhongjinji <zhongjinji@honor.com>
Cc: houtao@huaweicloud.com, andrii@kernel.org, ast@kernel.org, 
	billy@starlabs.sg, bpf@vger.kernel.org, feng.han@honor.com, 
	liulu.liu@honor.com, ramdhan@starlabs.sg, yipengxiang@honor.com, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:19=E2=80=AFAM zhongjinji <zhongjinji@honor.com> w=
rote:
>
> >It seems you didn't use the ringbuf related APIs (e.g.,
> >ring_buffer__consume()) in libbpf to access the ring buffer. In my
> >understanding, the "xchg(&hdr->len, new_len)" in bpf_ringbuf_commit()
> >works as the barrier to ensure the order of committed data and hdr->len,
> >and accordingly the "smp_load_acquire(len_ptr)" in
> >ringbuf_process_ring() in libbpf works as the paired barrier to ensure
> >the order of hdr->len and the committed data. So I think the extra
> >smp_wmb() in the kernel is not necessary here. Instead, you should fix
> >your code in the userspace.
> >>
> >> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> >> ---
> >>  kernel/bpf/ringbuf.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> >> index e1cfe890e0be..a66059e2b0d6 100644
> >> --- a/kernel/bpf/ringbuf.c
> >> +++ b/kernel/bpf/ringbuf.c
> >> @@ -508,6 +508,10 @@ static void bpf_ringbuf_commit(void *sample, u64 =
flags, bool discard)
> >>      rec_pos =3D (void *)hdr - (void *)rb->data;
> >>      cons_pos =3D smp_load_acquire(&rb->consumer_pos) & rb->mask;
> >>
> >> +    /* Make sure the modification of data is visible on other CPU's
> >> +     * before consume the event
> >> +     */
> >> +    smp_wmb();
> >>      if (flags & BPF_RB_FORCE_WAKEUP)
> >>              irq_work_queue(&rb->work);
> >>      else if (cons_pos =3D=3D rec_pos && !(flags & BPF_RB_NO_WAKEUP))
>
> well, I missed the implementation of __smp_store_release in the x86 archi=
tecture,
> it is not necessary because __smp_store_release has a memory barrier in x=
86,

yep, we do rely on xchg() and smp_load_acquire() pairing. I'm not
familiar with arm64 specifics, I didn't know that this assumption is
x86-64-specific. Cc'ed Paul who I believe suggested xchg() as a more
performant way of achieving this. That happened years ago so all of
us, I'm sure, lost a lot of context by now, but still, let's see.

> but it can't guarantee the order of committed data in arm64 because
> __smp_store_release does not include a memory barrier, and it just ensure
> the variable is visible. The implementation of ARM64 is as follows,
> in common/arch/arm64/include/asm/barrier.h
>
> #define __smp_load_acquire(p)                                           \
> ({                                                                      \
>         union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u;   \
>         typeof(p) __p =3D (p);                                           =
 \
>         compiletime_assert_atomic_type(*p);                             \
>         kasan_check_read(__p, sizeof(*p));                              \
>         switch (sizeof(*p)) {                                           \
>         case 1:                                                         \
>                 asm volatile ("ldarb %w0, %1"                           \
>                         : "=3Dr" (*(__u8 *)__u.__c)                      =
 \
>                         : "Q" (*__p) : "memory");                       \
>                 break;                                                  \
>         case 2:                                                         \
>                 asm volatile ("ldarh %w0, %1"                           \
>                         : "=3Dr" (*(__u16 *)__u.__c)                     =
 \
>                         : "Q" (*__p) : "memory");                       \
>                 break;                                                  \
>         case 4:                                                         \
>                 asm volatile ("ldar %w0, %1"                            \
>                         : "=3Dr" (*(__u32 *)__u.__c)                     =
 \
>                         : "Q" (*__p) : "memory");                       \
>                 break;                                                  \
>         case 8:                                                         \
>                 asm volatile ("ldar %0, %1"                             \
>                         : "=3Dr" (*(__u64 *)__u.__c)                     =
 \
>                         : "Q" (*__p) : "memory");                       \
>                 break;                                                  \
>         }                                                               \
>         (typeof(*p))__u.__val;                                          \
> })
>

