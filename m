Return-Path: <bpf+bounces-32661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B291173F
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 02:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC7E281D93
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 00:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F933A47;
	Fri, 21 Jun 2024 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl/ox4rh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD3394
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929525; cv=none; b=Dihdj21h4swED2JWR7td/ix7yVVguOk9+J9WfbNjjPA9txuPGLx8GQTF1Mie2xRp0uwRaLKUlCbwZCo7/EN4BGaQHYkbW5TtYjDSyy4MVUjuX04gS8bvkpA/Vptzip9u+ICAmUqF4kpvZ6IqnkGinoeWeQqK5F9TPdMFF44c4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929525; c=relaxed/simple;
	bh=IyGjx6yxG2OvcLJJKxcTD3fX0YnCZ+3TW20rah3bQxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLU86xYxiGT82OaebHbkiqEVnlI7kBRg/g7zqTXRKL/bS6qO+Htb22yM/wTNy7XtT6ZhxOurCiBT+aDU67R/MXjUd7szncuUByohLxBDGBjfeGanFIUWUkvZn9UOPQefZ/GBjolUNTl+ZukXVPFLfW1UyxFYhLGcbsS3RPY6PXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kl/ox4rh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c5362c7c0bso1169615a91.1
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 17:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718929523; x=1719534323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vHR8NFGNjxGkKKiluux0k0pp4DJPi5hmAmNRcyCbkU=;
        b=kl/ox4rh6VStZgH9XcEBpMYGqSamjir8Nc3Id65p4WiWUWpybfxN6aGJeEpXJpRgWO
         FC3GjJPMDIwyi4+hnhuTzxmneVdq2XtQQ8bxxwiFEBRKoZGCbAyTPDoz8LHkIlGoruC0
         8DHEH7wvtb0O/dYNdLBMpMJ3oRAPnMyeMnwZWRRxVE8xfo7cymtWcQxjPwtD3CmynGAh
         SYZBBod7C0QpCeNAqocCRpDvIVHfxMTg8LfOLTtqWlmo792GYPqIHmcB17pA1AXnmwJn
         0g7lDXRxq4eFjcM//tAp2acTPmnuBuP56AYPoCOTK/DNC/S7LwlwTSet5IVLkkmFzcQ0
         OxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718929523; x=1719534323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vHR8NFGNjxGkKKiluux0k0pp4DJPi5hmAmNRcyCbkU=;
        b=YRwQgrPm7ixqg8J/xXXz8yS9VTkS3C98kBOaXnc1PVWIQ2BSajKWf4bbpNBM6dqR7W
         /FU3kknSATiqS9ekQAKkHUPa6MrULbqVpmStKM026tgpAPEu9Yh7PfGe8kMWIeD+38J/
         PhwMiwTFIYECfWz5gZi885dkkWTRt7+m0e5VEdOyN3rs+gypBSRzZ8wruhSMElloIW/p
         prjbRzAITIc7Eut8MKmsHlVcJfgwSW6gYXCyfYZOrX6VH5TfX4bMctqaEMNWYJxQj720
         6AkpOG4mMHcuHIwFUc7dyFPXludFWu0HCtZ/L00mBQgBvn5Q0023DsX3/VK2nu9ySQst
         rKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI9NFkYErV1Cwz5lK+mBTazTcw4fLUhxK5YR2DVCJ/XmPKmPjQdtS5HYUtXt/sS1BO5YPlrjHpzG7UXiE0MLKiqRKH
X-Gm-Message-State: AOJu0YxP/3ZP8on7F8RGmbcgrCa6+5eYkt3DCQvL84bEGo0jeb7G0pJK
	wihsxRAhNid7xs4xQQNSuaeGIP5XYbLdLIvjv53GliwggK2llAGVhsIrQDRO6iZyVzYErVTthIg
	vGwzd64xHKbQMStFy0iV6IB+O4Vkwvw==
X-Google-Smtp-Source: AGHT+IEz5Cq2p+BWXek4EBJNi2iCGrw8t4PPvLW9P/xKlnvoUBnX3+dVZmnGH6L+LP8uTdqLo8LWOu3CHyeBOvbQbVI=
X-Received: by 2002:a17:90a:e00e:b0:2c0:17b4:85aa with SMTP id
 98e67ed59e1d1-2c7b5c9f60amr6582456a91.22.1718929523445; Thu, 20 Jun 2024
 17:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620213435.16336-1-daniel@iogearbox.net>
In-Reply-To: <20240620213435.16336-1-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Jun 2024 17:25:11 -0700
Message-ID: <CAEf4BzY34QFfnao7PJh2HRFRgWN9u0vUZX3-M5E7N99Q6qf4sg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix overrunning reservations in ringbuf
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, bpf@vger.kernel.org, 
	Bing-Jhong Billy Jheng <billy@starlabs.sg>, Muhammad Ramdhan <ramdhan@starlabs.sg>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 2:34=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
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
>  kernel/bpf/ringbuf.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 0ee653a936ea..7f82116b46ec 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -29,6 +29,7 @@ struct bpf_ringbuf {
>         u64 mask;
>         struct page **pages;
>         int nr_pages;
> +       unsigned long pending_pos;

let's put it right after producer_pos, as that one is also updated in
the same reserve step, so cache line will be exclusive. By putting it
into read-mostly parts of bpf_ringbuf struct we'll induce unnecessary
cache line bouncing

>         spinlock_t spinlock ____cacheline_aligned_in_smp;
>         /* For user-space producer ring buffers, an atomic_t busy bit is =
used
>          * to synchronize access to the ring buffers in the kernel, rathe=
r than
> @@ -179,6 +180,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t d=
ata_sz, int numa_node)
>         rb->mask =3D data_sz - 1;
>         rb->consumer_pos =3D 0;
>         rb->producer_pos =3D 0;
> +       rb->pending_pos =3D 0;
>
>         return rb;
>  }
> @@ -404,9 +406,10 @@ bpf_ringbuf_restore_from_rec(struct bpf_ringbuf_hdr =
*hdr)
>
>  static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
>  {
> -       unsigned long cons_pos, prod_pos, new_prod_pos, flags;
> -       u32 len, pg_off;
> +       unsigned long cons_pos, prod_pos, new_prod_pos, pend_pos, flags;
>         struct bpf_ringbuf_hdr *hdr;
> +       u32 len, pg_off;
> +       u64 tmp_size;
>
>         if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
>                 return NULL;
> @@ -424,13 +427,28 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringb=
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
> +               if (hdr->len & BPF_RINGBUF_BUSY_BIT)
> +                       break;
> +               tmp_size =3D hdr->len & ~BPF_RINGBUF_DISCARD_BIT;

it feels right to have hdr_len =3D READ_ONCE(hdr->len) and then using
that for bit checks and manipulations, WDYT?

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

