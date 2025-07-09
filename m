Return-Path: <bpf+bounces-62826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF572AFF120
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 20:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2044E56F9
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039C023BCEC;
	Wed,  9 Jul 2025 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="vmMcRjg0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258817578
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086887; cv=none; b=DrqWUFHtp1cZU+LZt6dB7QpUO+O3Hg5ZwiYA9UMNHwKa1HeUIBAvsFtey5SOq01ms5PFbcZ1RZdlgsc5Veu6yKlCiNUnGNA+8REVEg0JE3bFtGFd1C6Ib5cWjhiNKN1RzXY21NcOvYO6mrn8WLHB8YC+j6o1pSWWaaV1Ou+OpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086887; c=relaxed/simple;
	bh=jLhAmkCcyuz7f2EUm+cZMoMgjHR6x06hUSGy35OpUSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAvrtYV7j6usfqBSX+TAmxo64lU45ISIFpOZY4IGaQkufosBB6EwKoAv4MLfBqTchMZTmxkuGEv9t41VYjif9Ri4JUef3pfNmEKVl9BdU31bMtry9bi1nJwdIZ/huj2zil3fBNyuxSp7i+vAjYs7wRao6Q0o8UscJ7cUhrcZDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=vmMcRjg0; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so124169276.1
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752086884; x=1752691684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mxJkMSS0XGPxmFkT/H1ptkSLauxgr5/8Fq9MqthWm4=;
        b=vmMcRjg0QCdWgEyOfcwmgk7uOc/CL56iybac6pOFdpHyrz830qqcCKQIXXi3rgx3Ai
         XJZZAG/hTynSGofHTFD0H2OwDHl0UWq6R1VSxu5O3DMIBoydkGeo+OqXJXC9MhZGnJdw
         WyuGp+cBQa7aWtyWO30U5wnwcbwfxbgX56ngVBARguE+niIT9F9tzcyEK2MZ9AWDuvdH
         /r3QcKItH7dlQz0OwCuNq8DLjEixPeoEstyg4HoEh1w4wJvLfylXJ6p0RxJUuTj2Nhxa
         lhT38UykmKdW5TVRXzt14SXFbABKsC01IgaqqTugqWgdVF1piImK4ctcCIynjeHuC4WF
         r07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752086884; x=1752691684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mxJkMSS0XGPxmFkT/H1ptkSLauxgr5/8Fq9MqthWm4=;
        b=s2OX6qUWpENQrnPZO9LpjpYJqnzw9NYG8nH+5c/nQzYLrKgcvfKhX17WYDMaMPv9dG
         esls0lz7AXwyAHBTQcyogRB99LbasV1SkdQt0mHofXTBtbWqCf77hOo5w5l1XXAm/BzM
         IJY2Mh9td8vGCrmU/FjSkmW5WtdHUD1tE4UmK/My8UZDp/8xqsh762NzHa37vZY3Jb+g
         LAx1mtEAWYxIGdl9bmRfe3upsLZByn3duH8Gp2oHJhTi041+8Ljtp40Vzz91LBNEHfpJ
         EQb374FCGO3jAwxf48X0qHpLQs7Gi8DUvn47CZvAzgJQgS8/LZ0b8esdvDh7qTu8dTYZ
         XbDw==
X-Gm-Message-State: AOJu0YyinSUuSbS/pCE6baEX/b+jyXY+YLOp7eOx1jPYYEKWfazoRVsM
	YF5AhbOoZQntafdcwws+41H3oTEAtGwktWEf2nfsdPUIGNeEdGbm0J9bLVPoNwInsV1nMaSKZtD
	z9vTMQD5B+MdnnuW+A6/he/WtO8fN7C+YHAyTAGRLEA==
X-Gm-Gg: ASbGncuP9vzfko4LvIjd1NmeZwJRPYmFiX7iq8yzkT82Z6ickvgbHD1GDPSXVwwGXxM
	wde+lviU3VQ2GQnOrp56RR38yRSZ+mWaIJtnWUNGEuFHBSg//yDZt0NIep8vPTj6ADPC6v+yFNG
	jKNt8yTqL56GQAJyJGzrD1eSVcBt4ttlFY3cL4aaACgq2Z
X-Google-Smtp-Source: AGHT+IHZ4RydLgc0hTM3tvrc7MTrJ0Yw9GAfn/TEy5lHix2dp0vVHAZ8P9V9cNzUZMVPBNmxHLZjJMD5kFMRge8hO/I=
X-Received: by 2002:a05:690c:6301:b0:70f:83ef:ddff with SMTP id
 00721157ae682-717c17a68f7mr8776087b3.30.1752086883982; Wed, 09 Jul 2025
 11:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709015712.97099-1-emil@etsalapatis.com> <20250709015712.97099-3-emil@etsalapatis.com>
 <bbbe127a-436a-459a-93d6-517e9377fa39@linux.dev>
In-Reply-To: <bbbe127a-436a-459a-93d6-517e9377fa39@linux.dev>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 9 Jul 2025 14:47:52 -0400
X-Gm-Features: Ac12FXwlBll0c8VKwKLlUP9dc9qA5uZudiFscsTh8bQgHgmUIp0TykoZLa1vwkw
Message-ID: <CABFh=a6CU8HceOkxSCEKA=BhiAg4BdBv6+dxD_Y5chSb-PjLug@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: add selftests for bpf_arena_reserve_pages
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	memxor@gmail.com, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 12:09=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 7/8/25 6:57 PM, Emil Tsalapatis wrote:
> > Add selftests for the new bpf_arena_reserve_pages kfunc.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> LGTM with some nits below.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> > ---
> >   .../testing/selftests/bpf/bpf_arena_common.h  |   3 +
> >   .../selftests/bpf/progs/verifier_arena.c      | 106 +++++++++++++++++=
+
> >   .../bpf/progs/verifier_arena_large.c          |  95 ++++++++++++++++
> >   3 files changed, 204 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/tes=
ting/selftests/bpf/bpf_arena_common.h
> > index 68a51dcc0669..16f8ce832004 100644
> > --- a/tools/testing/selftests/bpf/bpf_arena_common.h
> > +++ b/tools/testing/selftests/bpf/bpf_arena_common.h
> > @@ -46,8 +46,11 @@
> >
> >   void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __=
u32 page_cnt,
> >                                   int node_id, __u64 flags) __ksym __we=
ak;
> > +int bpf_arena_reserve_pages(void *map, void __arena *addr, __u32 page_=
cnt) __ksym __weak;
> >   void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cn=
t) __ksym __weak;
> >
> > +#define arena_base(map) ((void __arena *)((struct bpf_arena *)(map))->=
user_vm_start)
> > +
> >   #else /* when compiled as user space code */
> >
> >   #define __arena
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools=
/testing/selftests/bpf/progs/verifier_arena.c
> > index 67509c5d3982..35248b3327aa 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> > @@ -114,6 +114,112 @@ int basic_alloc3(void *ctx)
> >       return 0;
> >   }
> >
> > +SEC("syscall")
> > +__success __retval(0)
> > +int basic_reserve1(void *ctx)
> > +{
> > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > +     char __arena *page;
> > +     int ret;
> > +
> > +     page =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> > +     if (!page)
> > +             return 1;
> > +
> > +     page +=3D __PAGE_SIZE;
> > +
> > +     /* Reserve the second page */
> > +     ret =3D bpf_arena_reserve_pages(&arena, page, 1);
> > +     if (ret)
> > +             return 2;
> > +
> > +     /* Try to explicitly allocate the reserved page. */
> > +     page =3D bpf_arena_alloc_pages(&arena, page, 1, NUMA_NO_NODE, 0);
> > +     if (page)
> > +             return 3;
> > +
> > +     /* Try to implicitly allocate the page (since there's only 2 of t=
hem). */
> > +     page =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> > +     if (page)
> > +             return 4;
> > +#endif
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__success __retval(0)
> > +int basic_reserve2(void *ctx)
> > +{
> > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > +     char __arena *page;
> > +     int ret;
> > +
> > +     page =3D arena_base(&arena);
> > +     ret =3D bpf_arena_reserve_pages(&arena, page, 1);
> > +     if (ret)
> > +             return 1;
> > +
> > +     page =3D bpf_arena_alloc_pages(&arena, page, 1, NUMA_NO_NODE, 0);
> > +     if ((u64)page)
> > +             return 2;
> > +#endif
> > +     return 0;
> > +}
> > +
> > +/* Reserve the same page twice, should return -EBUSY. */
> > +SEC("syscall")
> > +__success __retval(0)
> > +int reserve_twice(void *ctx)
> > +{
> > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > +     char __arena *page;
> > +     int ret;
> > +
> > +     page =3D arena_base(&arena);
> > +
> > +     ret =3D bpf_arena_reserve_pages(&arena, page, 1);
> > +     if (ret)
> > +             return 1;
> > +
> > +     /* Should be -EBUSY. */
> > +     ret =3D bpf_arena_reserve_pages(&arena, page, 1);
> > +     if (ret !=3D -16)
> > +             return 2;
>
> Maybe do the following is better:
>
> #define EBUSY 16
> ...
> if (ret !=3D -EBUSY)
>         return 2;
>
>
> > +#endif
> > +     return 0;
> > +}
> > +
> > +/* Try to reserve past the end of the arena. */
> > +SEC("syscall")
> > +__success __retval(0)
> > +int reserve_invalid_region(void *ctx)
> > +{
> > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > +     char __arena *page;
> > +     int ret;
> > +
> > +     /* Try a NULL pointer. */
> > +     ret =3D bpf_arena_reserve_pages(&arena, NULL, 3);
> > +     if (ret !=3D -22)
> > +             return 1;
>
> Same here.
> #define EINVAL 22
> ...
> if (ret !=3D -EINVAL)
>         return 1;
> and a few cases below.
>
> > +
> > +     page =3D arena_base(&arena);
> > +
> > +     ret =3D bpf_arena_reserve_pages(&arena, page, 3);
> > +     if (ret !=3D -22)
> > +             return 2;
> > +
> > +     ret =3D bpf_arena_reserve_pages(&arena, page, 4096);
> > +     if (ret !=3D -22)
> > +             return 3;
> > +
> > +     ret =3D bpf_arena_reserve_pages(&arena, page, (1ULL << 32) - 1);
> > +     if (ret !=3D -22)
> > +             return 4;
> > +#endif
> > +     return 0;
> > +}
> > +
> >   SEC("iter.s/bpf_map")
> >   __success __log_level(2)
> >   int iter_maps1(struct bpf_iter__bpf_map *ctx)
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b=
/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > index f94f30cf1bb8..9eee51912280 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > @@ -67,6 +67,101 @@ int big_alloc1(void *ctx)
> >       return 0;
> >   }
> >
> > +/* Try to access a reserved page. Behavior should be identical with ac=
cessing unallocated pages. */
> > +SEC("syscall")
> > +__success __retval(0)
> > +int access_reserved(void *ctx)
> > +{
> > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > +     volatile char __arena *page;
> > +     char __arena *base;
> > +     const size_t len =3D 4;
> > +     int ret, i;
> > +
> > +     /* Get a separate region of the arena. */
> > +     page =3D base =3D arena_base(&arena) + 16384 * PAGE_SIZE;
> > +
> > +     ret =3D bpf_arena_reserve_pages(&arena, base, len);
> > +     if (ret)
> > +             return 1;
> > +
> > +     /* Try to dirty reserved memory. */
> > +     for (i =3D 0; i < len && can_loop; i++)
> > +             *page =3D 0x5a;
> > +
> > +     for (i =3D 0; i < len && can_loop; i++) {
> > +             page =3D (volatile char __arena *)(base + i * PAGE_SIZE);
> > +
> > +             /*
> > +              * Error out in case either the write went through,
> > +              * or the address has random garbage.
> > +              */
> > +             if (*page =3D=3D 0x5a)
> > +                     return 2 + 2 * i;
> > +
> > +             if (*page)
> > +                     return 2 + 2 * i + 1;
> > +     }
> > +#endif
> > +     return 0;
> > +}
> > +
> > +/* Try to allocate a region overlapping with a reservation. */
> > +SEC("syscall")
> > +__success __retval(0)
> > +int request_partially_reserved(void *ctx)
> > +{
> > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > +     volatile char __arena *page;
> > +     char __arena *base;
> > +     int ret;
> > +
> > +     /* Add an arbitrary page offset. */
> > +     page =3D base =3D arena_base(&arena) + 4096 * __PAGE_SIZE;
> > +
> > +     ret =3D bpf_arena_reserve_pages(&arena, base + 3 * __PAGE_SIZE, 4=
);
> > +     if (ret)
> > +             return 1;
> > +
> > +     page =3D bpf_arena_alloc_pages(&arena, base, 5, NUMA_NO_NODE, 0);
> > +     if ((u64)page !=3D 0ULL)
> > +             return 2;
> > +#endif
> > +     return 0;
> > +}
> > +
> > +SEC("syscall")
> > +__success __retval(0)
> > +int free_reserved(void *ctx)
> > +{
> > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > +     char __arena *addr;
> > +     char __arena *page;
> > +     int ret;
> > +
> > +     /* Add an arbitrary page offset. */
> > +     addr =3D arena_base(&arena) + 32768 * __PAGE_SIZE;
> > +
> > +     page =3D bpf_arena_alloc_pages(&arena, addr, 4, NUMA_NO_NODE, 0);
> > +     if (!page)
> > +             return 1;
> > +
> > +     ret =3D bpf_arena_reserve_pages(&arena, addr + 4 * __PAGE_SIZE, 4=
);
> > +     if (ret)
> > +             return 2;
> > +
>
> [...]
>
> > +     /* Freeing a reserved area, fully or partially, should succeed. *=
/
>
> You are not freeing a reserved area below. Actually you freeing an alloca=
ted area.
> Maybe you need to add addr argument with 4 * __PAGE_SIZE?

You're right, the current code isn't actually testing anything related
to the patch. The intent of the test
was to partially unmap both the allocated and reserved areas and
reallocate the newly freed
address region, I'll fix it to do that.

>
> > +     bpf_arena_free_pages(&arena, addr, 2);
> > +     bpf_arena_free_pages(&arena, addr + 2 * __PAGE_SIZE, 2);
> > +
> > +     /* The free pages call above should have succeeded, so this alloc=
ation should too. */
> > +     page =3D bpf_arena_alloc_pages(&arena, addr + 3 * __PAGE_SIZE, 1,=
 NUMA_NO_NODE, 0);
> > +     if (!page)
> > +             return 3;
> > +#endif
> > +     return 0;
> > +}
> > +
> >   #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> >   #define PAGE_CNT 100
> >   __u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
>

