Return-Path: <bpf+bounces-64671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFCFB153FD
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 21:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841843B3E7B
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 19:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C02512D7;
	Tue, 29 Jul 2025 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHgZgP47"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76418C322;
	Tue, 29 Jul 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818955; cv=none; b=Apn3W/dScJEng0wGoO9XGPYDCX5JnHUCXKSJLaMTSRkGWIMGoIewg8r/Q4yNbfmA64K094fmym7W33Sh7319hoGLIu2X3tV//ZSlqNTHicI8mNp9QH9hJfFqLO3XJITcFw/gfNeFXW50C91SE9UnkMlLp9tYZAn8Us7c9LHtWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818955; c=relaxed/simple;
	bh=1X707ejKro/d80XjVLR2kIaQBkkbypuyYeeC/9sBP00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovqu8Lbf+Z4r4/hIHMG/gQ32nyOTwGYUvSnRBJEfGQjzcbVdPkFjN9CFNeus6H0vC++yRVJPegoy99VOLwyoqxsgznCAcd/fHG313Vx/FMQ6/bXJBs9jM6osL1crEqmsYfS2KD7NxoE8j51AdDcQDW1QUXtoFUiwAWlQdbmxBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHgZgP47; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71a19ea0be4so23611567b3.0;
        Tue, 29 Jul 2025 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753818952; x=1754423752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmuCskNmDWXvkZgPPGklzlojeNsDhNmC8O2c5IIvffg=;
        b=PHgZgP47gfLU6YAc8H7Qa5TYPvkgXZkywC2l73xXqeJX5Xf26xt9B1IQ/EqTzarC8N
         dM+sP/oiNBAm9dfQK86U5TgBxDH7rxL8EvMaaJbkVJVPYVc8ftd54Z+We5akVKVTj3t3
         rwVnybF/cUD3aljiQDb7s+PEQpsoeZMJ55UzSg+2yF9OsZg/Z+mK4SbQ358pj/mDOKym
         dVhisZZNE8qjGv1SnvmWSmRaucdaBLgJ9L5sZVmXbYIh6tH69bzLGeH1GdFOdBKjF/pR
         C9aR7F9frsQaoq9AU1bBPG0dZxOHEQj4L6csq3wuKG89g0eqEpDT3taX5ZuhSWIYmhtr
         5paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753818952; x=1754423752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmuCskNmDWXvkZgPPGklzlojeNsDhNmC8O2c5IIvffg=;
        b=ajH/w+2xfYgRlocvhbyDy0z4IYXTh3VJDa5McgZJiiK7vqc+m8PI1bc9U8wM/Mjm9N
         14DNbOxxD+1H+gtDYAqgtMkgsigZMayKlANkdn47+HM5TzGoiu2DBuUkWOTkbOVEa1Fc
         wAk8SxcbTS3uLOJtH3RmSKpO/B6BbqCSwM99ByEoqJ7sFY3jE6LnmTKBcbVLjisuPBVU
         KT4fhr+fnOUsvjdHsQOu8qXUTDcBKlBrWQyKULyfWtILFyqSgXsGmXoGeHk6SMgvYq7r
         /CN7mtVmemk/lxJZyUEjOV0XFZ9r9M0MdWQGBDOEJ/NyjVjEq1RjInsP5HHpbtNE7YXv
         Krig==
X-Forwarded-Encrypted: i=1; AJvYcCXZNb8jPIoszfuk7yuFSPuemTsnsvkLgL7bRI0Bs9hzOJyeKAjhHM1zOVUHaHYcj7/J8PLA0BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hw2oFj78cbfssBf3Z+OA/L2zNI1K5smlZtejcnd49O5D44+d
	KEcypm7mKL4j5LpJa2zsYIZJ2sD2rJLT6jX16Z+aSfWht3FGukqXgC6lTUKjLTnCZ7rnX5mB0y0
	rblCIcIW6IwOnl5H9vIgdo1lowSeNt7JPUGq6
X-Gm-Gg: ASbGncsy9nrzCvTSqvfcKprWxJ8jiyr4F1tFJw4YhAwnKbC6DVtN+LF3YjG84j55uYX
	SYbJnFTzPulrgtjycBFN0eMUx/WPqsWmkbVKzNPyVQNWV5MYMPQNuP/2er1tk7M34NNoA+X7qB9
	WXxFOPVfC6d8eOGxGWzynYMoqvKbZgUqM5PNAN/WiIK3dcfBMZZ9GoVg/+nCYG2EdkfbBys8l5c
	nosK2uPOZfMgZUTQQxc/ZQYonUjxi0Z
X-Google-Smtp-Source: AGHT+IGBX9RHkWmchbo3KBFrM93P/znTf0q4OSO55sUjFhTyE9uCAnSmx01JaZRcDpVsOG4AURcK2Y3o8KyLT3tOE8s=
X-Received: by 2002:a05:690c:f96:b0:71a:413d:5673 with SMTP id
 00721157ae682-71a4657972amr13268827b3.11.1753818952228; Tue, 29 Jul 2025
 12:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717164842.1848817-1-ameryhung@gmail.com> <20250717164842.1848817-2-ameryhung@gmail.com>
 <CABFh=a59HabocTSqjkHA1myf6xd6_h1aKiPvDRQoDPaM42u3JQ@mail.gmail.com>
In-Reply-To: <CABFh=a59HabocTSqjkHA1myf6xd6_h1aKiPvDRQoDPaM42u3JQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 29 Jul 2025 12:55:39 -0700
X-Gm-Features: Ac12FXyvnn7cZCEJd0HoLprVbd60dP_Om5DJIYP6M5erh6nc2OXuBStkFPKyF7I
Message-ID: <CAMB2axN+7O=vBDpUfkCmZmSzcPrwrBRkvwx7PMBYvr01GBEk_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] selftests/bpf: Introduce task local data
To: Emil Tsalapatis <linux-lists@etsalapatis.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:45=E2=80=AFAM Emil Tsalapatis
<linux-lists@etsalapatis.com> wrote:
>
> On Thu, Jul 17, 2025 at 12:49=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > Task local data defines an abstract storage type for storing task-
> > specific data (TLD). This patch provides user space and bpf
> > implementation as header-only libraries for accessing task local data.
> >
> > Task local data is a bpf task local storage map with two UPTRs:
> > 1) u_tld_metadata, shared by all tasks of the same process, consists of
> > the total count of TLDs and an array of metadata of TLDs. A metadata of
> > a TLD comprises the size and the name. The name is used to identify a
> > specific TLD in bpf 2) u_tld_data points to a task-specific memory regi=
on
> > for storing TLDs.
> >
> > Below are the core task local data API:
> >
> >                      User space                           BPF
> > Define TLD    TLD_DEFINE_KEY(), tld_create_key()           -
> > Get data           tld_get_data()                    tld_get_data()
> >
> > A TLD is first defined by the user space with TLD_DEFINE_KEY() or
> > tld_create_key(). TLD_DEFINE_KEY() defines a TLD statically and allocat=
es
> > just enough memory during initialization. tld_create_key() allows
> > creating TLDs on the fly, but has a fix memory budget, TLD_DYN_DATA_SIZ=
E.
> > Internally, they all go through the metadata array to check if the TLD =
can
> > be added. The total TLD size needs to fit into a page (limited by UPTR)=
,
> > and no two TLDs can have the same name. It also calculates the offset, =
the
> > next available space in u_tld_data, by summing sizes of TLDs. If the TL=
D
> > can be added, it increases the count using cmpxchg as there may be othe=
r
> > concurrent tld_create_key(). After a successful cmpxchg, the last
> > metadata slot now belongs to the calling thread and will be updated.
> > tld_create_key() returns the offset encapsulated as a opaque object key
> > to prevent user misuse.
> >
> > Then, user space can pass the key to tld_get_data() to get a pointer
> > to the TLD. The pointer will remain valid for the lifetime of the
> > thread.
> >
> > BPF programs can also locate the TLD by tld_get_data(), but with both
> > name and key. The first time tld_get_data() is called, the name will
> > be used to lookup the metadata. Then, the key will be saved to a
> > task_local_data map, tld_keys_map. Subsequent call to tld_get_data()
> > will use the key to quickly locate the data.
> >
> > User space task local data library uses a light way approach to ensure
> > thread safety (i.e., atomic operation + compiler and memory barriers).
> > While a metadata is being updated, other threads may also try to read i=
t.
> > To prevent them from seeing incomplete data, metadata::size is used to
> > signal the completion of the update, where 0 means the update is still
> > ongoing. Threads will wait until seeing a non-zero size to read a
> > metadata.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> > ---
> >  .../bpf/prog_tests/task_local_data.h          | 388 ++++++++++++++++++
> >  .../selftests/bpf/progs/task_local_data.bpf.h | 227 ++++++++++
> >  2 files changed, 615 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_d=
ata.h
> >  create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.b=
pf.h
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b=
/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> > new file mode 100644
> > index 000000000000..73ee122daf81
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> > @@ -0,0 +1,388 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __TASK_LOCAL_DATA_H
> > +#define __TASK_LOCAL_DATA_H
> > +
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <sched.h>
> > +#include <stdatomic.h>
> > +#include <stddef.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <sys/syscall.h>
> > +#include <sys/types.h>
> > +
> > +#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> > +#include <pthread.h>
> > +#endif
> > +
> > +#include <bpf/bpf.h>
> > +
> > +/*
> > + * OPTIONS
> > + *
> > + *   Define the option before including the header
> > + *
> > + *   TLD_FREE_DATA_ON_THREAD_EXIT - Frees memory on thread exit automa=
tically
> > + *
> > + *   Thread-specific memory for storing TLD is allocated lazily on the=
 first call to
> > + *   tld_get_data(). The thread that calls it must also calls tld_free=
() on thread exit
>
> Typo: must also calls -> must also call
>
> > + *   to prevent memory leak. Pthread will be included if the option is=
 defined. A pthread
> > + *   key will be registered with a destructor that calls tld_free().
> > + *
> > + *
> > + *   TLD_DYN_DATA_SIZE - The maximum size of memory allocated for TLDs=
 created dynamically
> > + *   (default: 64 bytes)
> > + *
> > + *   A TLD can be defined statically using TLD_DEFINE_KEY() or created=
 on the fly using
> > + *   tld_create_key(). As the total size of TLDs created with tld_crea=
te_key() cannot be
> > + *   possibly known statically, a memory area of size TLD_DYN_DATA_SIZ=
E will be allocated
> > + *   for these TLDs. This additional memory is allocated for every thr=
ead that calls
> > + *   tld_get_data() even if no tld_create_key are actually called, so =
be mindful of
> > + *   potential memory wastage. Use TLD_DEFINE_KEY() whenever possible =
as just enough memory
> > + *   will be allocated for TLDs created with it.
> > + *
> > + *
> > + *   TLD_NAME_LEN - The maximum length of the name of a TLD (default: =
62)
> > + *
> > + *   Setting TLD_NAME_LEN will affect the maximum number of TLDs a pro=
cess can store,
> > + *   TLD_MAX_DATA_CNT.
> > + *
> > + *
> > + *   TLD_DATA_USE_ALIGNED_ALLOC - Always use aligned_alloc() instead o=
f malloc()
> > + *
> > + *   When allocating the memory for storing TLDs, we need to make sure=
 there is a memory
> > + *   region of the X bytes within a page. This is due to the limit pos=
ed by UPTR: memory
> > + *   pinned to the kernel cannot exceed a page nor can it cross the pa=
ge boundary. The
> > + *   library normally calls malloc(2*X) given X bytes of total TLDs, a=
nd only uses
> > + *   aligned_alloc(PAGE_SIZE, X) when X >=3D PAGE_SIZE / 2. This is to=
 reduce memory wastage
> > + *   as not all memory allocator can use the exact amount of memory re=
quested to fulfill
> > + *   aligned_alloc(). For example, some may round the size up to the a=
lignment. Enable the
> > + *   option to always use aligned_alloc() if the implementation has lo=
w memory overhead.
> > + */
> > +
> > +#define TLD_PIDFD_THREAD O_EXCL
> > +
>
> Is this #define necessary? The alias is used only once in the code and
> passed directly into syscall().
> Is it supposed to be called by the user in any way?
>

Nope. I will change to use O_EXCL directly.

> > +#define TLD_PAGE_SIZE getpagesize()
> > +#define TLD_PAGE_MASK (~(TLD_PAGE_SIZE - 1))
> > +
> > +#define TLD_ROUND_MASK(x, y) ((__typeof__(x))((y) - 1))
> > +#define TLD_ROUND_UP(x, y) ((((x) - 1) | TLD_ROUND_MASK(x, y)) + 1)
> > +
> > +#define TLD_READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> > +
> > +#ifndef TLD_DYN_DATA_SIZE
> > +#define TLD_DYN_DATA_SIZE 64
> > +#endif
> > +
> > +#define TLD_MAX_DATA_CNT (TLD_PAGE_SIZE / sizeof(struct tld_metadata) =
- 1)
> > +
> > +#ifndef TLD_NAME_LEN
> > +#define TLD_NAME_LEN 62
> > +#endif
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +typedef struct {
> > +       __s16 off;
> > +} tld_key_t;
> > +
> > +struct tld_metadata {
> > +       char name[TLD_NAME_LEN];
> > +       _Atomic __u16 size;
> > +};
> > +
> > +struct u_tld_metadata {
> > +       _Atomic __u8 cnt;
> > +       __u16 size;
> > +       struct tld_metadata metadata[];
> > +};
> > +
> > +struct u_tld_data {
> > +       __u64 start; /* offset of u_tld_data->data in a page */
> > +       char data[];
> > +};
> > +
> > +struct tld_map_value {
> > +       void *data;
> > +       struct u_tld_metadata *metadata;
> > +};
> > +
> > +struct u_tld_metadata * _Atomic tld_metadata_p __attribute__((weak));
> > +__thread struct u_tld_data *tld_data_p __attribute__((weak));
> > +__thread void *tld_data_alloc_p __attribute__((weak));
> > +
> > +#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> > +pthread_key_t tld_pthread_key __attribute__((weak));
> > +
> > +static void tld_free(void);
> > +
> > +static void __tld_thread_exit_handler(void *unused)
> > +{
> > +       tld_free();
> > +}
> > +#endif
> > +
> > +static int __tld_init_metadata(void)
>
> Nit: rename it to init_metadata_p? It's about the per-process metadata, n=
ot the
> per-key metadata.

I will try to make the distinction of the metadata page and the per
TLD metadata clear in the naming.

>
> > +{
> > +       struct u_tld_metadata *meta, *uninit =3D NULL;
> > +       int err =3D 0;
> > +
> > +       meta =3D (struct u_tld_metadata *)aligned_alloc(TLD_PAGE_SIZE, =
TLD_PAGE_SIZE);
> > +       if (!meta) {
> > +               err =3D -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       memset(meta, 0, TLD_PAGE_SIZE);
> > +       meta->size =3D TLD_DYN_DATA_SIZE;
> > +
> > +       if (!atomic_compare_exchange_strong(&tld_metadata_p, &uninit, m=
eta)) {
> > +               free(meta);
> > +               goto out;
> > +       }
> > +
> > +#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> > +       pthread_key_create(&tld_pthread_key, __tld_thread_exit_handler)=
;
> > +#endif
> > +out:
> > +       return err;
> > +}
> > +
> > +static int __tld_init_data(int map_fd)
> > +{
> > +       bool use_aligned_alloc =3D false;
> > +       struct tld_map_value map_val;
> > +       struct u_tld_data *data;
> > +       int err, tid_fd =3D -1;
> > +       void *d =3D NULL;
> > +
> > +       tid_fd =3D syscall(SYS_pidfd_open, gettid(), TLD_PIDFD_THREAD);
> > +       if (tid_fd < 0) {
> > +               err =3D -errno;
> > +               goto out;
> > +       }
> > +
> > +#ifdef TLD_DATA_USE_ALIGNED_ALLOC
> > +       use_aligned_alloc =3D true;
> > +#endif
> > +
> > +       /*
> > +        * tld_metadata_p->size =3D TLD_DYN_DATA_SIZE +
> > +        *          total size of TLDs defined via TLD_DEFINE_KEY()
> > +        */
> > +       if (use_aligned_alloc || tld_metadata_p->size >=3D TLD_PAGE_SIZ=
E / 2)
> > +               d =3D aligned_alloc(TLD_PAGE_SIZE, tld_metadata_p->size=
);
>
> Comment: The manpage for aligned_alloc() says tld_metadata_p->size
> should be a multiple
> of the alignment, but at least glibc doesn't actually enforce that so
> this call should work fine.

Some additional context for the TLD_DATA_USE_ALIGNED_ALLOC option

Recent glibc aligned_alloc() implementation is able to fulfill
aligned_alloc(align, sz) with sz + a few bytes of overhead. While for
jemalloc, it will use align byte of memory in this case. Hence, the
option is here to allow users to reduce their memory usage if the
memory allocator allows.

>
> > +       else
> > +               d =3D malloc(tld_metadata_p->size * 2);
> > +       if (!d) {
> > +               err =3D -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       /*
> > +        * Always pass a page-aligned address to UPTR since the size of=
 tld_map_value::data
> > +        * is a page in BTF. If d spans across two pages, use the page =
that contains large
> > +        * enough memory.
> > +        */
> > +       if (TLD_PAGE_SIZE - (~TLD_PAGE_MASK & (intptr_t)d) >=3D tld_met=
adata_p->size) {
> > +               map_val.data =3D (void *)(TLD_PAGE_MASK & (intptr_t)d);
> > +               data =3D d;
> > +               data->start =3D (~TLD_PAGE_MASK & (intptr_t)d) + offset=
of(struct u_tld_data, data);
> > +       } else {
> > +               map_val.data =3D (void *)(TLD_ROUND_UP((intptr_t)d, TLD=
_PAGE_SIZE));
> > +               data =3D (void *)(TLD_ROUND_UP((intptr_t)d, TLD_PAGE_SI=
ZE));
> > +               data->start =3D offsetof(struct u_tld_data, data);
> > +       }
> > +       map_val.metadata =3D TLD_READ_ONCE(tld_metadata_p);
> > +
> > +       err =3D bpf_map_update_elem(map_fd, &tid_fd, &map_val, 0);
> > +       if (err) {
> > +               free(d);
> > +               goto out;
> > +       }
> > +
> > +       tld_data_p =3D (struct u_tld_data *)data;
> > +       tld_data_alloc_p =3D d;
> > +#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> > +       pthread_setspecific(tld_pthread_key, (void *)1);
> > +#endif
> > +out:
> > +       if (tid_fd >=3D 0)
> > +               close(tid_fd);
> > +       return err;
> > +}
> > +
> > +static tld_key_t __tld_create_key(const char *name, size_t size, bool =
dyn_data)
> > +{
> > +       int err, i, sz, off =3D 0;
> > +       __u8 cnt;
> > +
> > +       if (!TLD_READ_ONCE(tld_metadata_p)) {
> > +               err =3D __tld_init_metadata();
> > +               if (err)
> > +                       return (tld_key_t){err};
> > +       }
> > +
> > +       for (i =3D 0; i < TLD_MAX_DATA_CNT; i++) {
> > +retry:
> > +               cnt =3D atomic_load(&tld_metadata_p->cnt);
> > +               if (i < cnt) {
> > +                       /* A metadata is not ready until size is update=
d with a non-zero value */
> > +                       while (!(sz =3D atomic_load(&tld_metadata_p->me=
tadata[i].size)))
> > +                               sched_yield();
> > +
> > +                       if (!strncmp(tld_metadata_p->metadata[i].name, =
name, TLD_NAME_LEN))
> > +                               return (tld_key_t){-EEXIST};
> > +
> > +                       off +=3D TLD_ROUND_UP(sz, 8);
> > +                       continue;
> > +               }
> > +
> > +               /*
> > +                * TLD_DEFINE_KEY() is given memory upto a page while a=
t most
>
> Typo: upto -> up to
>

Thanks for catching all the typos!

>
> > +                * TLD_DYN_DATA_SIZE is allocated for tld_create_key()
> > +                */
> > +               if (dyn_data) {
> > +                       if (off + TLD_ROUND_UP(size, 8) > tld_metadata_=
p->size)
> > +                               return (tld_key_t){-E2BIG};
> > +               } else {
> > +                       if (off + TLD_ROUND_UP(size, 8) > TLD_PAGE_SIZE=
 - sizeof(struct u_tld_data))
> > +                               return (tld_key_t){-E2BIG};
> > +                       tld_metadata_p->size +=3D TLD_ROUND_UP(size, 8)=
;
>
> Discussion: Would there be advantages to adjusting tld_metadata_p with
> dynamic keys defined before
> __tld_init_data is called? That way we wouldn't have to worry about
> rightsizing TLD_DYN_DATA_SIZE,
> and it may be a reasonable expectation that all dynamic keys are
> defined before the program starts using
> the TLDs. Imo it's not necessary now because we don't know how this
> API will end up being used, but
> just wondering if it is a possibility.

TLD_DEFINE_KEY() is introduced in this iteration to address the memory
wastage and rightsizing issue of tld_create_key().

I also think that keys should be known before the program starts in
most cases, and TLD_DEFINE_KEY() should be used whenever possible.
But, I prefer to keep the dynamic API here just in case it is useful.
Plus the code is mostly shared.

>
> > +               }
> > +
> > +               /*
> > +                * Only one tld_create_key() can increase the current c=
nt by one and
> > +                * takes the latest available slot. Other threads will =
check again if a new
> > +                * TLD can still be added, and then compete for the new=
 slot after the
> > +                * succeeding thread update the size.
> > +                */
> > +               if (!atomic_compare_exchange_strong(&tld_metadata_p->cn=
t, &cnt, cnt + 1))
> > +                       goto retry;
> > +
> > +               strncpy(tld_metadata_p->metadata[i].name, name, TLD_NAM=
E_LEN);
> > +               atomic_store(&tld_metadata_p->metadata[i].size, size);
> > +               return (tld_key_t){(__s16)off};
> > +       }
> > +
> > +       return (tld_key_t){-ENOSPC};
> > +}
> > +
> > +/**
> > + * TLD_DEFINE_KEY() - Define a TLD and a global variable key associate=
d with the TLD.
> > + *
> > + * @name: The name of the TLD
> > + * @size: The size of the TLD
> > + * @key: The variable name of the key. Cannot exceed TLD_NAME_LEN
> > + *
> > + * The macro can only be used in file scope.
> > + *
> > + * A global variable key of opaque type, tld_key_t, will be declared a=
nd initialized before
> > + * main() starts. Use tld_key_is_err() or tld_key_err_or_zero() later =
to check if the key
> > + * creation succeeded. Pass the key to tld_get_data() to get a pointer=
 to the TLD.
> > + * bpf programs can also fetch the same key by name.
> > + *
> > + * The total size of TLDs created using TLD_DEFINE_KEY() cannot exceed=
 a page. Just
> > + * enough memory will be allocated for each thread on the first call t=
o tld_get_data().
> > + */
> > +#define TLD_DEFINE_KEY(key, name, size)                        \
> > +tld_key_t key;                                         \
> > +                                                       \
> > +__attribute__((constructor))                           \
> > +void __tld_define_key_##key(void)                      \
> > +{                                                      \
> > +       key =3D __tld_create_key(name, size, false);      \
> > +}
> > +
> > +/**
> > + * tld_create_key() - Create a TLD and return a key associated with th=
e TLD.
> > + *
> > + * @name: The name the TLD
> > + * @size: The size of the TLD
> > + *
> > + * Return an opaque object key. Use tld_key_is_err() or tld_key_err_or=
_zero() to check
> > + * if the key creation succeeded. Pass the key to tld_get_data() to ge=
t a pointer to
> > + * locate the TLD. bpf programs can also fetch the same key by name.
> > + *
> > + * Use tld_create_key() only when a TLD needs to be created dynamicall=
y (e.g., @name is
> > + * not known statically or a TLD needs to be created conditionally)
> > + *
> > + * An additional TLD_DYN_DATA_SIZE bytes are allocated per-thread to a=
ccommodate TLDs
> > + * created dynamically with tld_create_key(). Since only a user page i=
s pinned to the
> > + * kernel, when TLDs created with TLD_DEFINE_KEY() uses more than TLD_=
PAGE_SIZE -
> > + * TLD_DYN_DATA_SIZE, the buffer size will be limited to the rest of t=
he page.
> > + */
> > +__attribute__((unused))
> > +static tld_key_t tld_create_key(const char *name, size_t size)
> > +{
> > +       return __tld_create_key(name, size, true);
> > +}

[...]

