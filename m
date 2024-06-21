Return-Path: <bpf+bounces-32761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B59912E42
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 22:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7AD91C2434E
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63B16CD0A;
	Fri, 21 Jun 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+OKTnBI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89315F30F
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000301; cv=none; b=HdI8wgIcTytdZYYIO1RmosclZn9rUpTgCpoOJFHn88rnN9FQzC59iGWz0kGYqFuq3OSzHf5DjFEHlH5LRLd+0prc0sMOCN0Z5ac4DrIpW0UgApFvMFjz81E+1jOYd89s1bH4RxCOfuUgClsv8INwrTPAB0SHsn9VI5ot3m1XeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000301; c=relaxed/simple;
	bh=LWXQ1P6a4IOvAT1qlGGqK/9AHHgg87MD7hbnK83H9ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhw1Eic+BTgFQ/QZMA25MdK3upvsgB3uvuLgEwG6/UserqTXa0PjEIABBrEPY+sIsuHFHz2Z6Cf1MTbCVgrdq0tPmd0HrhQFHTZwCdVSqnwTqWrg4TzaEztrQ83WHWD3XOM2GTMlnHNnWVqCFem5EgxAxzeW3jm1if4BvFrx6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+OKTnBI; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1627187a12.0
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719000299; x=1719605099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIlujjBcfC3oRmj051KYEYqDTqF9hcPJCN+gVr2qOzU=;
        b=M+OKTnBI2HL+3s9yRwoNNE17IZ5dpOWjvuZzs4q5f4p9+maNBgTp/o08CRu/hhe1bS
         4Fa48lbNxHu1CcxQFD0nzmsRdQH3bvMtIC6EhWMTbKpKvEdOU3a3xt7n6psdou+7uSOv
         MgsQ/topIlbiYebeJb8jtyfBrxHQyiwk0disG0cODs7zOl2ULLyLkuVnh4kto7nVRuAA
         vyjK7wcRiMPWZc8ZOleG2BjUFJDOJGg6hfT+l5FStmHGRMuTMvGwQUvumMdZwM7ckbkC
         WDSf4adK+xT4gxbvycEql2ePBCri0iHNsZ9ajDrsB6AX8B6UYqaGrhH9oqyO05pt8Dhd
         hBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719000299; x=1719605099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIlujjBcfC3oRmj051KYEYqDTqF9hcPJCN+gVr2qOzU=;
        b=eUMeapJ5aBO1JhMeX7rplr+928O14P3HM5rMruEpVUUpAZL01CYvrJzX752deFzkzC
         AM/w1casqfatX6VP8vMh6cX9Z+RJj1weRHwIg+YisIn+zh+OD26WjFKSSpT6PhwxqniA
         qyVLdG6PT+80fhfcflrt9mE8xsNmHNZmlIA1kJ8nVck0Gs8w7d/KM8cAgkNjbZ2uZjA8
         05k69ouSzeQhbAQhKRMh7v+GCT7SNqN4s2rgt7/vUCgAYZDjSVagAbRQmoCBP427vJzz
         CNKFMddf7boRYclYrITer0Xh0yNBvfclc2xTqqmWo/pwHlk9E2y+c9gAGQEfyV5XDuXC
         sSYg==
X-Forwarded-Encrypted: i=1; AJvYcCVgcFHoFP+RsoOAS/qPKEMJGFOKjgLFKg+fhUIkdJVKvhE1JfRI6eyG89Y7gVYwMiqwX1He8K+TBbQjNLmXYze3xF2h
X-Gm-Message-State: AOJu0Yz5b+CqZvuYgi3UYz34vR1FkKGlsvpsd+CLCfWtFsQhPKAOQ4vJ
	UxUP0+pmXHluyuAmBlIE3/649LuDS1nb5Tv4hgu5SlOed1rUvwnnLCiAi+VDUm9POvJ8qLJ/r3K
	QyYMdux9wCNwNdaGbliO3bvZt6rU=
X-Google-Smtp-Source: AGHT+IEaKMa7dMMExEAbZPVCn4fFtJeUmg4AvBwMMEcSd/VM/7y6K/G90ymVQFd/6BaR4d7Q3xtLOHMhAZYSrfN/JLM=
X-Received: by 2002:a17:90a:d314:b0:2bf:7eb7:373b with SMTP id
 98e67ed59e1d1-2c7b5d7bf59mr8631871a91.33.1719000298798; Fri, 21 Jun 2024
 13:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621140828.18238-1-daniel@iogearbox.net>
In-Reply-To: <20240621140828.18238-1-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Jun 2024 13:04:46 -0700
Message-ID: <CAEf4BzY7Z33XUA3nrZPjModcVG4d4F+fX4T+CY0Czi_t+smHsA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix overrunning reservations in ringbuf
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, bpf@vger.kernel.org, 
	Bing-Jhong Billy Jheng <billy@starlabs.sg>, Muhammad Ramdhan <ramdhan@starlabs.sg>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 7:25=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> The BPF ring buffer internally is implemented as a power-of-2 sized circu=
lar
> buffer, with two logical and ever-increasing counters: consumer_pos is th=
e
> consumer counter to show which logical position the consumer consumed the
> data, and producer_pos which is the producer counter denoting the amount =
of
> data reserved by all producers.
>
> Each time a record is reserved, the producer that "owns" the record will
> successfully advance producer counter. In user space each time a record i=
s
> read, the consumer of the data advanced the consumer counter once it fini=
shed
> processing. Both counters are stored in separate pages so that from user
> space, the producer counter is read-only and the consumer counter is read=
-write.
>
> One aspect that simplifies and thus speeds up the implementation of both
> producers and consumers is how the data area is mapped twice contiguously
> back-to-back in the virtual memory, allowing to not take any special meas=
ures
> for samples that have to wrap around at the end of the circular buffer da=
ta
> area, because the next page after the last data page would be first data =
page
> again, and thus the sample will still appear completely contiguous in vir=
tual
> memory.
>
> Each record has a struct bpf_ringbuf_hdr { u32 len; u32 pg_off; } header =
for
> book-keeping the length and offset, and is inaccessible to the BPF progra=
m.
> Helpers like bpf_ringbuf_reserve() return `(void *)hdr + BPF_RINGBUF_HDR_=
SZ`
> for the BPF program to use. Bing-Jhong and Muhammad reported that it is h=
owever
> possible to make a second allocated memory chunk overlapping with the fir=
st
> chunk and as a result, the BPF program is now able to edit first chunk's
> header.
>
> For example, consider the creation of a BPF_MAP_TYPE_RINGBUF map with siz=
e
> of 0x4000. Next, the consumer_pos is modified to 0x3000 /before/ a call t=
o
> bpf_ringbuf_reserve() is made. This will allocate a chunk A, which is in
> [0x0,0x3008], and the BPF program is able to edit [0x8,0x3008]. Now, lets
> allocate a chunk B with size 0x3000. This will succeed because consumer_p=
os
> was edited ahead of time to pass the `new_prod_pos - cons_pos > rb->mask`
> check. Chunk B will be in range [0x3008,0x6010], and the BPF program is a=
ble
> to edit [0x3010,0x6010]. Due to the ring buffer memory layout mentioned
> earlier, the ranges [0x0,0x4000] and [0x4000,0x8000] point to the same da=
ta
> pages. This means that chunk B at [0x4000,0x4008] is chunk A's header.
> bpf_ringbuf_submit() / bpf_ringbuf_discard() use the header's pg_off to t=
hen
> locate the bpf_ringbuf itself via bpf_ringbuf_restore_from_rec(). Once ch=
unk
> B modified chunk A's header, then bpf_ringbuf_commit() refers to the wron=
g
> page and could cause a crash.
>
> Fix it by calculating the oldest pending_pos and check whether the range
> from the oldest outstanding record to the newest would span beyond the ri=
ng
> buffer size. If that is the case, then reject the request. We've tested w=
ith
> the ring buffer benchmark in BPF selftests (./benchs/run_bench_ringbufs.s=
h)
> before/after the fix and while it seems a bit slower on some benchmarks, =
it
> is still not significantly enough to matter.
>
> Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support=
 for it")
> Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
> Reported-by: Muhammad Ramdhan <ramdhan@starlabs.sg>
> Co-developed-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
> Signed-off-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
> Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  v1 -> v2:
>    - Move pending_pos to the same cacheline as producer_pos
>    - Force compiler to read hdr->len only once
>
>  kernel/bpf/ringbuf.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 0ee653a936ea..87466de8316a 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -51,7 +51,8 @@ struct bpf_ringbuf {
>          * This prevents a user-space application from modifying the
>          * position and ruining in-kernel tracking. The permissions of th=
e
>          * pages depend on who is producing samples: user-space or the
> -        * kernel.
> +        * kernel. Note that the pending counter is placed in the same
> +        * page as the producer, so that it shares the same cacheline.
>          *
>          * Kernel-producer
>          * ---------------
> @@ -70,6 +71,7 @@ struct bpf_ringbuf {
>          */
>         unsigned long consumer_pos __aligned(PAGE_SIZE);
>         unsigned long producer_pos __aligned(PAGE_SIZE);
> +       unsigned long pending_pos;
>         char data[] __aligned(PAGE_SIZE);
>  };
>
> @@ -179,6 +181,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t d=
ata_sz, int numa_node)
>         rb->mask =3D data_sz - 1;
>         rb->consumer_pos =3D 0;
>         rb->producer_pos =3D 0;
> +       rb->pending_pos =3D 0;
>
>         return rb;
>  }
> @@ -404,9 +407,10 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr =
*hdr)
>
>  static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
>  {
> -       unsigned long cons_pos, prod_pos, new_prod_pos, flags;
> -       u32 len, pg_off;
> +       unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, flags;
>         struct bpf_ringbuf_hdr *hdr;
> +       u64 tmp_size, hdr_len;

these can be u32, so I fixed it up while applying, thanks!

> +       u32 len, pg_off;
>
>         if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
>                 return NULL;
> @@ -424,13 +428,29 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringb=
uf *rb, u64 size)
>                 spin_lock_irqsave(&rb->spinlock, flags);
>         }
>
> +       pend_pos =3D rb->pending_pos;
>         prod_pos =3D rb->producer_pos;
>         new_prod_pos =3D prod_pos + len;
>
> -       /* check for out of ringbuf space by ensuring producer position
> -        * doesn't advance more than (ringbuf_size - 1) ahead
> +       while (pend_pos < prod_pos) {
> +               hdr =3D (void *)rb->data + (pend_pos & rb->mask);
> +               hdr_len =3D READ_ONCE(hdr->len);
> +               if (hdr_len & BPF_RINGBUF_BUSY_BIT)
> +                       break;
> +               tmp_size =3D hdr_len & ~BPF_RINGBUF_DISCARD_BIT;
> +               tmp_size =3D round_up(tmp_size + BPF_RINGBUF_HDR_SZ, 8);
> +               pend_pos +=3D tmp_size;
> +       }
> +       rb->pending_pos =3D pend_pos;
> +
> +       /* check for out of ringbuf space:
> +        * - by ensuring producer position doesn't advance more than
> +        *   (ringbuf_size - 1) ahead
> +        * - by ensuring oldest not yet committed record until newest
> +        *   record does not span more than (ringbuf_size - 1)
>          */
> -       if (new_prod_pos - cons_pos > rb->mask) {
> +       if ((new_prod_pos - cons_pos > rb->mask) ||
> +           (new_prod_pos - pend_pos > rb->mask)) {
>                 spin_unlock_irqrestore(&rb->spinlock, flags);
>                 return NULL;
>         }
> --
> 2.43.0
>

