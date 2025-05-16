Return-Path: <bpf+bounces-58430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1553CABA5E2
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 00:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FBD3BE022
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86A228003D;
	Fri, 16 May 2025 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItPlI8cC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377E1A76BC;
	Fri, 16 May 2025 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747434136; cv=none; b=GeHavztjXjpSatZ21D2L1f7reSJR5PpMX1+WED/na8FBUkD94ZOGrGa56WiKw8u7/RC61ptMqsCYawXTLNpdDIV8zc7DryFvgeB6TW2Fgbf8bugazmsA3UEeAQJMh54nqNSD36a/8NGS0sYWXsvBj2Ek33HnE56bGT1s7DVVy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747434136; c=relaxed/simple;
	bh=niJK17frrLNERvdChWDymcFcgPYqkOdoJrjToUMTUhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yhwyk3t72Jfi3nM0lG5ay+AxdOXKuWdC24EzsdlvfiOB2FZJ+6TOo+k1JBVc5zua+3yWrZOrGCZNhzudCY6H8jvKjb7c91deyj+9vkXT24orrypp2eSORg8eHAA0gPjBe6D6roH1w8Jd8pVewCrXIpVOZmB88Du0v1fFA59HILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItPlI8cC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a1f5d2d91eso1681717f8f.1;
        Fri, 16 May 2025 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747434132; x=1748038932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zICbWdfrt1r6ZtuKVV8v64CX+9iZkwP2dqOMnKPx0SQ=;
        b=ItPlI8cCs53pp7jva2ZVH8K4tEM2hbo/KEIZnR0Wq0vinlxu0ujc8RP7qac/437fKo
         KbG5jIJkAlxVtyy6b2MXRk/8Rg+yh8Yp/HhfF5Wjbnabf3PuCE2kg3+IxlzF0yQDAcEo
         o7qXRsI08hHXsKZ8C6/Jmb71tZCg8e8cMJ7RYdcg0ElFhnyuAOLFq/LDQBUood7oRao/
         SGq0bghoJ0KriDue0OCCux3hD2TLPdGcx5ZLJY7iQiUeE986bgawXQNoArZgR1Xkg2+6
         SfmBc8fKYwD5fsV73HSSJESkEpQwldvjzjJb6yjG5RPeht5Ct9/hCKwDdqxLcMQ5/lNK
         lG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747434132; x=1748038932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zICbWdfrt1r6ZtuKVV8v64CX+9iZkwP2dqOMnKPx0SQ=;
        b=eQwtpV/oE54xYblj9tNIPi0hdogKbEEhdvPaIOHL45aN+9qjfKfSwRW0P3xj5+osfQ
         q9LpR/OU5fBWFhFJrF8OhwSrkQ/3D0hx0G2gWQcJdJY0WdzKeOcskCgh0e7YnYDJzg/S
         V3uESANrwiSAmS7cum4YqSKlpD+RqXIw8vGRq1Hqnd0WSQxeszw5izBaQg4ui4dgbcqW
         dndHkQtC9LJgY2Bhw46JrtWzljcDmgW4xWaieo1np1IWCfrJk2Prdap0adQquXcdBeCx
         CvnemBktyjIvN79gLqsRB8Coqtg4Inl8wvZDdGMFJlgYYK+VrBn7UA4lLpN1ipX5vtyW
         mKew==
X-Forwarded-Encrypted: i=1; AJvYcCUiVd59nSE+Fx4Ao49OtV0HFQ54Qqx1wowCMrY/w9uqP6aOSOMdxk1popVCzJ2nYz1FqX1O9ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOwuHchgZ8Vpsh6af16pHw4Ejpg2YOCvCvFDW+8cPOgx19suJK
	eLQaE2FgX8WX7cFPR8/Zn382GqhVOn3kZX06d4y4ybIsBUF+PHIrrNVy2ONDrht5cQc8m0fnuN+
	mmI3cMkqO2T963YKTNCiYoJ50gEUQD5M=
X-Gm-Gg: ASbGncuyvdzNgzX9Z+Vm/OfiV1crQSHkf5zg2a4Pm6LwmFNCdHjAQjdYc8wEeo18iqZ
	fVxRs+xpy9PvjlBN5jtBGOHrYZnSwcMP/eLCMJFHsmRcX0YVm/DMMqFz8qLQdBfzmDRAGbhC7lo
	cut8LV7c9fFcYMiE/Afj8UybB/P4qEw9+FjoXr1w397LIx2N9vjJUHefABaPhPpg==
X-Google-Smtp-Source: AGHT+IFx7ymiJJ5SwIE/Hj7IcYAZo6jMy8dGSyvcB6asl9MBp/YBoQvbLywRbU2uDumXBUOA7KPDEn2WZBDB3nxq05k=
X-Received: by 2002:a05:6000:2405:b0:3a0:ba67:8379 with SMTP id
 ffacd0b85a97d-3a35c821aaamr5282842f8f.20.1747434131976; Fri, 16 May 2025
 15:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515211606.2697271-1-ameryhung@gmail.com> <20250515211606.2697271-2-ameryhung@gmail.com>
 <CAADnVQLPyHnqEbPowpN+JuMwH+iMX4=dZZu2chMaiexwAVxxJA@mail.gmail.com> <CAMB2axPpAdhkc0wvHY6VEKjRKti_85MMPo2eJ07T2w+kgV3YjQ@mail.gmail.com>
In-Reply-To: <CAMB2axPpAdhkc0wvHY6VEKjRKti_85MMPo2eJ07T2w+kgV3YjQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 May 2025 15:22:01 -0700
X-Gm-Features: AX0GCFuKrrOg2VQmocyDfuf4s12s3gSJa9znz0-WiB64UFcIQVUwHy4YN2R_K54
Message-ID: <CAADnVQK30M9+eJz8OjFpteGXfpF6DoQqNxXJa3p5YGmxyG7xJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 1:41=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> > > +       size =3D round_up(size, 8);
> >
> > why roundup ? and to 8 in particular?
> > If user space wants byte size keys, why not let it?
>
> I will remove it. This was to prevent breaking using TLD in atomic
> operations, but it should be very unlikely as they are thread
> specific.

You mean for a case where one part of the app (like a shared library)
is using u32, but the other is using u64 and doing atomic ops on it?

Make sense to align the off set by tld_create_key(),
but it can be done without rounding up all previous keys to 8.
63 bytes in the header are wasted. So use 2 as an offset.
A single cmpxchg 4 byte can update cnt+offset.
Actually why store size in each tld_metadata ?
Won't the logic will be simpler if it's an offset ?
bpf side tld_fetch_key() wouldn't need to count.

> > > +               if (i < cnt) {
> > > +                       /*
> > > +                        * Pending tld_create_key() uses size to sign=
al if the metadata has
> > > +                        * been fully updated.
> > > +                        */
> > > +                       while (!(sz =3D __atomic_load_n(&tld_metadata=
_p->metadata[i].size,
> > > +                                                     __ATOMIC_ACQUIR=
E)))
> > > +                               sched_yield();
> > > +
> > > +                       if (!strncmp(tld_metadata_p->metadata[i].name=
, name, TLD_NAME_LEN))
> > > +                               return (tld_key_t) {.off =3D -EEXIST}=
;
> > > +
> > > +                       off +=3D sz;
> > > +                       continue;
> > > +               }
> > > +
> > > +               if (off + size > TLD_DATA_SIZE)
> > > +                       return (tld_key_t) {.off =3D -E2BIG};
> > > +
> > > +               /*
> > > +                * Only one tld_create_key() can increase the current=
 cnt by one and
> > > +                * takes the latest available slot. Other threads wil=
l check again if a new
> > > +                * TLD can still be added, and then compete for the n=
ew slot after the
> > > +                * succeeding thread update the size.
> > > +                */
> > > +               if (!__atomic_compare_exchange_n(&tld_metadata_p->cnt=
, &cnt, cnt + 1, true,
> > > +                                                __ATOMIC_RELAXED, __=
ATOMIC_RELAXED))
> >
> > weak and relaxed/relaxed ?
>
> I can't see reordering issue with cnt so I choose to use relax. I can
> change to strong acq/rel just to be safe.
>
> > That's unusual.
> > I don't know what it is supposed to do.
> > I think weak=3Dfalse and __ATOMIC_ACQUIRE, __ATOMIC_RELAXED
> > would look as expected.
> >
>
> Do you mean weak=3Dfalse and __ATOMIC_RELAXED, __ATOMIC_ACQUIRE?

no idea. I just grepped the kernel and saw:
TEST_KERNEL_LOCKED(atomic_builtin_with_memorder,
                   __atomic_compare_exchange_n(flag, &v, 1, 0,
__ATOMIC_ACQUIRE, __ATOMIC_RELAXED),
                   __atomic_store_n(flag, 0, __ATOMIC_RELEASE));
TEST_KERNEL_LOCKED(atomic_builtin_wrong_memorder,
                   __atomic_compare_exchange_n(flag, &v, 1, 0,
__ATOMIC_RELAXED, __ATOMIC_RELAXED),
                   __atomic_store_n(flag, 0, __ATOMIC_RELAXED));

I'd just use __ATOMIC_SEQ_CST everywhere.
Speed is not important here.

>
> > > +                       goto retry;
> > > +
> > > +               strncpy(tld_metadata_p->metadata[i].name, name, TLD_N=
AME_LEN);
> > > +               __atomic_store_n(&tld_metadata_p->metadata[i].size, s=
ize, __ATOMIC_RELEASE);
> > > +               return (tld_key_t) {.off =3D off};
> > > +       }
> > > +
> > > +       return (tld_key_t) {.off =3D -ENOSPC};
> > > +}
> > > +
> > > +__attribute__((unused))
> > > +static inline bool tld_key_is_err(tld_key_t key)
> > > +{
> > > +       return key.off < 0;
> > > +}
> > > +
> > > +__attribute__((unused))
> > > +static inline int tld_key_err_or_zero(tld_key_t key)
> > > +{
> > > +       return tld_key_is_err(key) ? key.off : 0;
> > > +}
> > > +
> > > +/**
> > > + * tld_get_data() - Gets a pointer to the TLD associated with the ke=
y.
> > > + *
> > > + * @map_fd: A file descriptor of the underlying task local storage m=
ap,
> > > + * tld_data_map
> > > + * @key: A key object returned by tld_create_key().
> > > + *
> > > + * Returns a pointer to the TLD if the key is valid; NULL if no key =
has been
> > > + * added, not enough memory for TLD for this thread, or the key is i=
nvalid.
> > > + *
> > > + * Threads that call tld_get_data() must call tld_free() on exit to =
prevent
> > > + * memory leak.
> > > + */
> > > +__attribute__((unused))
> > > +static void *tld_get_data(int map_fd, tld_key_t key)
> > > +{
> > > +       if (!READ_ONCE(tld_metadata_p))
> > > +               return NULL;
> > > +
> > > +       if (!tld_data_p && __tld_init_data(map_fd))
> > > +               return NULL;
> >
> > Why call it again?
> > tld_create_key() should have done it, no?
> >
>
> A TLD is created by calling tld_create_key() once. Then, threads may
> call tld_get_data() to get their thread-specific TLD. So it is
> possible for a thread to call tld_get_data() with tld_data_p=3D=3DNULL.

I see. Please add a comment.

> > > +
> > > +       return tld_data_p->data + key.off;
> > > +}
> > > +
> > > +/**
> > > + * tld_free() - Frees task local data memory of the calling thread
> > > + */
> > > +__attribute__((unused))
> > > +static void tld_free(void)
> > > +{
> > > +       if (tld_data_p)
> > > +               free(tld_data_p);
> > > +}
> >
> > Since this .h allocates tld_metadata_p, it probably needs
> > a helper to free it too.
> >
> > > +
> > > +#endif /* __TASK_LOCAL_DATA_H */
> > > diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h =
b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> > > new file mode 100644
> > > index 000000000000..5f48e408a5e5
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> > > @@ -0,0 +1,220 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __TASK_LOCAL_DATA_BPF_H
> > > +#define __TASK_LOCAL_DATA_BPF_H
> > > +
> > > +/*
> > > + * Task local data is a library that facilitates sharing per-task da=
ta
> > > + * between user space and bpf programs.
> > > + *
> > > + *
> > > + * PREREQUISITE
> > > + *
> > > + * A TLD, an entry of data in task local data, first needs to be cre=
ated by the
> > > + * user space. This is done by calling user space API, tld_create_ke=
y(), with
> > > + * the name of the TLD and the size.
> > > + *
> > > + *     tld_key_t prio, in_cs;
> > > + *
> > > + *     prio =3D tld_create_key("priority", sizeof(int));
> > > + *     in_cs =3D tld_create_key("in_critical_section", sizeof(bool))=
;
> > > + *
> > > + * A key associated with the TLD, which has an opaque type tld_key_t=
, will be
> > > + * returned. It can be used to get a pointer to the TLD in the user =
space by
> > > + * calling tld_get_data().
> > > + *
> > > + *
> > > + * USAGE
> > > + *
> > > + * Similar to user space, bpf programs locate a TLD using the same k=
ey.
> > > + * tld_fetch_key() allows bpf programs to retrieve a key created in =
the user
> > > + * space by name, which is specified in the second argument of tld_c=
reate_key().
> > > + * tld_fetch_key() additionally will cache the key in a task local s=
torage map,
> > > + * tld_key_map, to avoid performing costly string comparisons every =
time when
> > > + * accessing a TLD. This requires the developer to define the map va=
lue type of
> > > + * tld_key_map, struct tld_keys. It only needs to contain keys used =
by bpf
> > > + * programs in the compilation unit.
> > > + *
> > > + * struct tld_keys {
> > > + *     tld_key_t prio;
> > > + *     tld_key_t in_cs;
> > > + * };
> > > + *
> > > + * Then, for every new task, a bpf program will fetch and cache keys=
 once and
> > > + * for all. This should be done ideally in a non-critical path (e.g.=
, in
> > > + * sched_ext_ops::init_task).
> > > + *
> > > + *     struct tld_object tld_obj;
> > > + *
> > > + *     err =3D tld_object_init(task, &tld);
> > > + *     if (err)
> > > + *         return 0;
> > > + *
> > > + *     tld_fetch_key(&tld_obj, "priority", prio);
> > > + *     tld_fetch_key(&tld_obj, "in_critical_section", in_cs);
> > > + *
> > > + * Note that, the first argument of tld_fetch_key() is a pointer to =
tld_object.
> > > + * It should be declared as a stack variable and initialized via tld=
_object_init().
> > > + *
> > > + * Finally, just like user space programs, bpf programs can get a po=
inter to a
> > > + * TLD by calling tld_get_data(), with cached keys.
> > > + *
> > > + *     int *p;
> > > + *
> > > + *     p =3D tld_get_data(&tld_obj, prio, sizeof(int));
> > > + *     if (p)
> > > + *         // do something depending on *p
> > > + */
> > > +#include <errno.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +
> > > +#define TLD_DATA_SIZE __PAGE_SIZE
> > > +#define TLD_DATA_CNT 63
> > > +#define TLD_NAME_LEN 62
> > > +
> > > +typedef struct {
> > > +       __s16 off;
> > > +} tld_key_t;
> > > +
> > > +struct u_tld_data *dummy_data;
> > > +struct u_tld_metadata *dummy_metadata;
> > > +
> > > +struct tld_metadata {
> > > +       char name[TLD_NAME_LEN];
> > > +       __u16 size;
> > > +};
> > > +
> > > +struct u_tld_metadata {
> > > +       __u8 cnt;
> > > +       __u8 padding[63];
> > > +       struct tld_metadata metadata[TLD_DATA_CNT];
> > > +};
> > > +
> > > +struct u_tld_data {
> > > +       char data[TLD_DATA_SIZE];
> > > +};
> > > +
> > > +struct tld_map_value {
> > > +       struct u_tld_data __uptr *data;
> > > +       struct u_tld_metadata __uptr *metadata;
> > > +};
> > > +
> > > +struct tld_object {
> > > +       struct tld_map_value *data_map;
> > > +       struct tld_keys *key_map;
> > > +};
> > > +
> > > +/*
> > > + * Map value of tld_key_map for caching keys. Must be defined by the=
 developer.
> > > + * Members should be tld_key_t and passed to the 3rd argument of tld=
_fetch_key().
> > > + */
> > > +struct tld_keys;
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > > +       __uint(map_flags, BPF_F_NO_PREALLOC);
> > > +       __type(key, int);
> > > +       __type(value, struct tld_map_value);
> > > +} tld_data_map SEC(".maps");
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > > +       __uint(map_flags, BPF_F_NO_PREALLOC);
> > > +       __type(key, int);
> > > +       __type(value, struct tld_keys);
> > > +} tld_key_map SEC(".maps");
> > > +
> > > +/**
> > > + * tld_object_init() - Initializes a tld_object.
> > > + *
> > > + * @task: The task_struct of the target task
> > > + * @tld_obj: A pointer to a tld_object to be initialized
> > > + *
> > > + * Returns 0 on success; -ENODATA if the task has no TLD; -ENOMEM if=
 the creation
> > > + * of tld_key_map fails
> > > + */
> > > +__attribute__((unused))
> > > +static int tld_object_init(struct task_struct *task, struct tld_obje=
ct *tld_obj)
> > > +{
> > > +       tld_obj->data_map =3D bpf_task_storage_get(&tld_data_map, tas=
k, 0, 0);
> > > +       if (!tld_obj->data_map)
> > > +               return -ENODATA;
> > > +
> > > +       tld_obj->key_map =3D bpf_task_storage_get(&tld_key_map, task,=
 0,
> > > +                                               BPF_LOCAL_STORAGE_GET=
_F_CREATE);
> > > +       if (!tld_obj->key_map)
> > > +               return -ENOMEM;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +/**
> > > + * tld_fetch_key() - Fetches the key to a TLD by name. The key has t=
o be created
> > > + * by user space first with tld_create_key().
> > > + *
> > > + * @tld_obj: A pointer to a valid tld_object initialized by tld_obje=
ct_init()
> > > + * @name: The name of the key associated with a TLD
> > > + * @key: The key in struct tld_keys to be saved to
> > > + *
> > > + * Returns a positive integer on success; 0 otherwise
> > > + */
> > > +#define tld_fetch_key(tld_obj, name, key)                           =
           \
> > > +       ({                                                           =
           \
> > > +               (tld_obj)->key_map->key.off =3D __tld_fetch_key(tld_o=
bj, name);   \
> > > +       })
> > > +
> > > +__attribute__((unused))
> > > +static u16 __tld_fetch_key(struct tld_object *tld_obj, const char *n=
ame)
> > > +{
> > > +       int i, meta_off, cnt;
> > > +       void *metadata, *nm, *sz;
> > > +       u16 off =3D 0;
> > > +
> > > +       if (!tld_obj->data_map || !tld_obj->data_map->metadata)
> > > +               return 0;
> > > +
> > > +       cnt =3D tld_obj->data_map->metadata->cnt;
> > > +       metadata =3D tld_obj->data_map->metadata->metadata;
> > > +
> > > +       bpf_for(i, 0, cnt) {
> > > +               meta_off =3D i * sizeof(struct tld_metadata);
> > > +               if (meta_off > TLD_DATA_SIZE - offsetof(struct u_tld_=
metadata, metadata)
> > > +                                          - sizeof(struct tld_metada=
ta))
> > > +                       break;
> > > +
> > > +               nm =3D metadata + meta_off + offsetof(struct tld_meta=
data, name);
> > > +               sz =3D metadata + meta_off + offsetof(struct tld_meta=
data, size);
> > > +
> > > +               /*
> > > +                * Reserve 0 for uninitialized keys. Increase the off=
set of a valid key
> > > +                * by one and subtract it later in tld_get_data().
> > > +                */
> > > +               if (!bpf_strncmp(nm, TLD_NAME_LEN, name))
> > > +                       return off + 1;
> >
> > I think all this +1, -1 dance is doing is helping to catch an
> > error when tld_get_data() is called without tld_fetch_key().
> > I feel this is too defensive.
> >
> > Let tld_fetch_key() return proper negative error code.
> >
>
> I can certainly return negative error code.
>
> But for the +1, -1 logic, I think is a simpler way to differentiate an
> uninitialized key in tld_key_map from the first TLD (both key.off =3D=3D
> 0). After all, bpf programs can call tld_get_data() without
> tld_fetch_key().

I'm saying we don't need to catch this case.
progs should not call tld_get_data() without tld_fetch_key().
If they do, it's a bug.

>
> > > +
> > > +               off +=3D *(u16 *)sz;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +/**
> > > + * tld_get_data() - Retrieves a pointer to the TLD associated with t=
he key.
> > > + *
> > > + * @tld_obj: A pointer to a valid tld_object initialized by tld_obje=
ct_init()
> > > + * @key: The key of a TLD saved in tld_maps
> > > + * @size: The size of the TLD. Must be a known constant value
> > > + *
> > > + * Returns a pointer to the TLD data associated with the key; NULL i=
f the key
> > > + * is not valid or the size is too big
> > > + */
> > > +#define tld_get_data(tld_obj, key, size) \
> > > +       __tld_get_data(tld_obj, (tld_obj)->key_map->key.off - 1, size=
)
> > > +
> > > +__attribute__((unused))
> > > +__always_inline void *__tld_get_data(struct tld_object *tld_obj, u32=
 off, u32 size)
> > > +{
> > > +       return (tld_obj->data_map->data && off >=3D 0 && off < TLD_DA=
TA_SIZE - size) ?
> > > +               (void *)tld_obj->data_map->data + off : NULL;
> >
> > If we require users to call tld_fetch_key() first and check for errors
> > tld_get_data() can be faster:
> > #define tld_get_data(tld_obj, key)
> >    (void *)tld_obj->data_map->data + tld_obj->key_map->key.off
> >
>
> tld_get_data() can be called in a bpf program without tld_fetch_key(),
> so checking tld_obj->data_map->data is needed as the first load from
> tld_obj->data_map->data yields a "mem_or_null".
>
> I did try to save this uptr "mem" after null check to stack (e.g., in
> a tld_object) so that we can save subsequent checks. However, the
> compiler sometime will do a fresh load from map_ptr when reading
> tld_obj->data_map->data. Might need some work or trick to make it
> happen.

likely because you do tld_obj->data_map->data twice.

> > I wouldn't bother with extra checks, especially for size.
> >
>
> It needs to be bound-checked. If tld_get_data() doesn't do it, bpf
> programs have to do it before acceess. Otherwise:
>
> ; return (tld_obj->data_map->data && off >=3D 0) ? @ task_local_data.bpf.=
h:218
> 25: (bf) r3 =3D r1                      ; R1_w=3Dmem(sz=3D4096) R3_w=3Dme=
m(sz=3D4096)
> 26: (0f) r3 +=3D r2                     ;
> R2_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D0xffff7fff,smax3=
2=3D32766,var_off=3D(0x0;
> 0xffffffff)) R3_w=3Dmem(sz=3D4096,smin=3D0,smax=3Dumax=3D0xffffffff,var_o=
ff=3D(0x0;
> 0xfffffff)
> ; test_value1 =3D *int_p; @ test_task_local_data.c:63
> 27: (61) r2 =3D *(u32 *)(r3 +0)
> R3 unbounded memory access, make sure to bounds check any such access

That's easy to fix.
Then something like:
#define tld_get_data(tld_obj, key) \
 ({
    void * data =3D tld_obj->data_map->data;
    if (data)
         data +=3D tld_obj->key_map->key.off & (PAGE_SIZE - 1);
    data;
  })

size is really not needed. The verifier sees it as one page.
Bad bpf prog can write into the wrong key and the verifier cannot stop it.

> > Bigger question.. can we cache the whole pointer for each key ?
> > and then
> > #define tld_get_data(tld_obj, key) ld_obj->key_map->key
>
> Maybe define the member type of tld_key_map as __uptr and allow bpf
> programs to update a uptr field with a valid uptr?

yeah. That indeed gets complicated. Maybe it's possible with some
verifier changes, but let's not go there yet.
The tld_get_data() proposed above is speedy enough.

