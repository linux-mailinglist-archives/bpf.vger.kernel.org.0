Return-Path: <bpf+bounces-40607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BBE98AED3
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5558F2832C4
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A5C1A2561;
	Mon, 30 Sep 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmlZ/sSV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C3194082;
	Mon, 30 Sep 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730298; cv=none; b=LErUWCMpjnZcUiFLQaKpAP/RTvtbpxb+PE9XUTbO5ZUC55gxJQVLaoh9LJpWbBIq3JOlwqcUjVuYcJvWLV6x7JvYJO2jlin1YiFx9mki5MrPt76x0IN51RWV7EaHXP6vcwGbSwhsKIikuD76ctsIReIQoqgNcQdOliPZ+FgLcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730298; c=relaxed/simple;
	bh=YxTZas78/NVXOmwsaCMZ22i6fm5T8b7+NoKP/9BLJdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8rNn9c1BJGJ+0lFwd0MsyY61xF2pp0x6HV0gVc0B3LfFZ7iyPvfQBKJQsX+EHhAuY0Z+TcVj9x563ivCuBwhI0iMY081R9dB0RFbGRwLGeCktluAuxOEZMKQinRIYc+CymmKPpDBX25L5lzn57I5Z133AkrzZ4pTrPXJliu8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmlZ/sSV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a93a1cda54dso695298466b.2;
        Mon, 30 Sep 2024 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727730294; x=1728335094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJTX8BYXxpTUWbRF4KnmS10smbwnBFAOcVX85CE1+8k=;
        b=TmlZ/sSVWt+CS+8/RyXMYBRcHqjwgLOyLuEwu+3rQjLRP0xofmSBiAbc4VR4dt9TQf
         z1cG6dRSJ4fZwJrCXzkjTYSeI/zMRzKZUARkOFDrnA8aR+bM/sRLjH6sw7hwq/rqUO+U
         lMjyoAcjWf3Qx2noNe7Rz9d2N1h0CFrivcxlTWnS5k57mfaTobPfq7kXYJK9uP/4Bv/T
         v4c+ttfaeXFkb7iadhLrh+fHCllMJJR2ZKkOHD8pWVhgPO13QBXcyIGileZn9G2d+di7
         r7f5gB948cRweHdhg/FLhRiaAZmY/oxqfqyMVKRfUIcelrh4NgQD6TYERLi3+xC9fQZp
         H/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727730294; x=1728335094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJTX8BYXxpTUWbRF4KnmS10smbwnBFAOcVX85CE1+8k=;
        b=FOOw5xXKz421b9XCnfdJBun2LFDHzbfEUtp8JsqPXWuoDDtF/O3MiTC/2h93NSXFM3
         dMTnoLANptkyEVB9LzQr90iTMlZy/LjX3q0I51wc/B7jkeHa9RFuhYlw2kF7rRrMWBu4
         /F5GO+9lxgSpUdRGZyc/0IKdzuSeCqDcF0YprJWy/hHJPMubkiOF0XgZS7bA+l8nyveF
         4jXQhBbTZ4pGTjw3p1RfA5gfHY2KbGDW4UNYeAVVwy/iPKNNZPNjfO5MpUoqg3XTvnwv
         IrHUIBHlO9jkjo6bKnFjcOudnv7yn8GFvzRjno4b5MNWFGI+zlqgAsIBjwbZxpra4/9V
         uvhA==
X-Forwarded-Encrypted: i=1; AJvYcCU7bvnLbYvHDE05IvGHDCQRMhbMQASoA+4D5fs8njdp/V+0snsP8avcwx2QP3wyn103j5xrljHSNG3zounyA2y6Ig==@vger.kernel.org, AJvYcCVqLNCqdkSgk8fbDKoD+reejVibFo7QSbjIZeZ7DMjv87nZ6QgLGO6tS7RyNd3FZxJ585s=@vger.kernel.org, AJvYcCXeYnM48hntmHceUiS7YiFcYTqvFpNlPql++f2KS8l04kD2avMS4k0cP6hWHhV1UxPv/G7RUd47uItpES3e@vger.kernel.org, AJvYcCXs2RQw/0ev1AjBE0emlGhx0nXDdtpKv7C+8PUWXLVS48ttru4/ZLwOQu8WakgwhWg1nbitNbHYAcmWHLEzHJXXkAaV@vger.kernel.org
X-Gm-Message-State: AOJu0YxkC1Cfwhh0Q9mpCsndKqYaoodfe9UZAzk5nQ2DkG5fKtC1LIIV
	wP/+2zwZodpFP6Hsbn3ebg2IrkBpFzJVWyYY4yco2UN+ZJxVnjLJ1eupqBiwqxwpDyTnWdfzfkO
	oVEWz4MB/9knT0zf1GImr9VFNrz4=
X-Google-Smtp-Source: AGHT+IFFnwJrCikvTvRLc8lqDTvqbg69fZuem9RLrHkDEjEy0d9sjVQtg22pvwVdaVVu6YjCj0ymK3NNOCf6UzCJ5Tw=
X-Received: by 2002:a17:907:96a7:b0:a8a:3f78:7b7b with SMTP id
 a640c23a62f3a-a93c4916e6cmr1200525166b.14.1727730294341; Mon, 30 Sep 2024
 14:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927094549.3382916-1-liaochang1@huawei.com>
In-Reply-To: <20240927094549.3382916-1-liaochang1@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 14:04:40 -0700
Message-ID: <CAEf4BzaWkkfxTHdkDZKZ1htCB90wM3gb1m_xrCpkZo_w_eJMUw@mail.gmail.com>
Subject: Re: [PATCH v2] uprobes: Improve the usage of xol slots for better scalability
To: Liao Chang <liaochang1@huawei.com>
Cc: ak@linux.intel.com, mhiramat@kernel.org, oleg@redhat.com, 
	andrii@kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 2:56=E2=80=AFAM Liao Chang <liaochang1@huawei.com> =
wrote:
>
> The uprobe handler allocates xol slot from xol_area and quickly release
> it in the single-step handler. The atomic operations on the xol bitmap
> and slot_count lead to expensive cache line bouncing between multiple
> CPUs. Given the xol slot is on the hot path for uprobe and kretprobe
> handling, the profiling results on some Arm64 machine show that nearly
> 80% of cycles are spent on this. So optimizing xol slot usage will
> become important to scalability after the Andrii's series land.
>
> This patch address this scalability issues from two perspectives:
>
> - Allocated xol slot is now saved in the thread associated utask data.
>   It allows to reuse it throughout the therad's lifetime. This avoid
>   the frequent atomic operation on the slot bitmap and slot_count of
>   xol_area data, which is the major negative impact on scalability.
>
> - A garbage collection routine xol_recycle_insn_slot() is introduced to
>   reclaim unused xol slots. utask instances that own xol slot but
>   haven't reclaimed them are linked in a linked list. When xol_area runs
>   out of slots, the garbage collection routine travel the list to free
>   one slot. Allocated xol slots is marked as unused in single-step
>   handler. While the marking relies on the refcount of utask instance,
>   due to thread can't run on multiple CPUs at same time, therefore, it
>   is unlikely CPUs take the refcount of same utask, minimizing cache
>   line bouncing.
>
>   Upon thread exit, the utask is deleted from the linked-list, and the
>   associated xol slot will be free.
>
> v2->v1:
> -------
> As suggested by Andi Kleen [1], the updates to the garbage collection
> list of xol slots is not a common case. This revision replaces the
> complex lockless RCU scheme with a simple raw spinlock.
>
> Here's an explanation of the locking and refcount update scheme in the
> patch:
>
> - area->gc_lock protects the write operations on the area->gc_list. This
>   includes inserting slot into area->gc_list in xol_get_insn_slot() and
>   removing slot from area->gc_list in xol_recycle_insn_slot().
>
> - utask->slot_ref is used to track the status of uprobe_task instance
>   associated insn_slot. It has three values, the value of 1 means the
>   slot is free to use or recycle. The value of 2 means the slot is in
>   use. The value of 0 means the slot is being recycled. This design
>   ensure that slots in use aren't recycled from GC list and that slots
>   being recycled aren't available for uprobe use. For example,
>   refcount_inc_not_zero() turns the value from 1 to 2 in uprobe BRK
>   handling, Using refcount_dec() to turn it from 2 to 1 during uprobe
>   single-step handling. Using refcount_dec_if_one() to turn the value
>   from 1 to 0 when recycling slot from GC list.
>
> [1] https://lore.kernel.org/all/ZuwoUmqXrztp-Mzh@tassilo/
>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  include/linux/uprobes.h |   4 +
>  kernel/events/uprobes.c | 177 ++++++++++++++++++++++++++++++----------
>  2 files changed, 139 insertions(+), 42 deletions(-)
>

Liao,

Assuming your ARM64 improvements go through, would you still need
these changes? XOL case is a slow case and if possible should be
avoided at all costs. If all common cases for ARM64 are covered
through instruction emulation, would we need to add all this
complexity to optimize slow case?


[...]

