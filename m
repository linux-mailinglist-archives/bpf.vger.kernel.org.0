Return-Path: <bpf+bounces-64830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F315B17616
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 20:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849324E6F1E
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183342C3247;
	Thu, 31 Jul 2025 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ZKVx2yxQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9681E5B6A
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753986442; cv=none; b=mJ01nq/Ae9Z+3i2et8PvETK1QTAvvVihzrbJ9z3+zQHbVKSmwVAXhMlXam1/fjGskkvJhnLY2jWsiTRMCq+OU1C5azYC+8rLsPyoh9m2QK1Ra+/6nOe68NRfW1HSwLy3EtywFLaMkEUeGWsr8bmTx7iPhNVekU4BTi93vMzmY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753986442; c=relaxed/simple;
	bh=zBCDqtV8zccI7XnYawzHMqYk1CLyCoB6UdFhzSxdlbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCLz8aq9DbbgmzfJ3rZwz8tL+3Bc9vdOoxwDEDp5vfH5LkleH6BDNRCZastlZ45iIxzunfxW7Jflf8TUcpLlQBwE2xPjWuR1jBF6V0j2toz2el23ha/RZD3q8v37DqKBjtAd682Irw5U0O5cngfkbjvfUp/NPP3owQ7pmqNiQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ZKVx2yxQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71b4a007b59so8484777b3.3
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1753986439; x=1754591239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM1F+twQpy71daa6qC1+XAJlSbFRdKW6eeB3Y6Ifp5A=;
        b=ZKVx2yxQc2Gkq7AbvHPudWvXWn3euUXU/fOllU7gPUoL8Mw/QSxhqa9Z9ck2G79D32
         G2Cpkvap+4+sbhzUbhOHw4KBaTT1m59ifnfummXX2/nXUTdcstUCoHwgWMperE4Cm7yn
         wJYiILnk3DrcKwO/PTU3KG1/fuRUTje4W1rfETuZ4OrjzHdePBXgnfeDCtlGl2ZN03LU
         f6xu1MEHlaFaqgqo2h7Ru8Bx93BAGnVxVBAa9DnwmMZ2cwR+oGpk2PnITx5SA/KtRJ0m
         Ttdi2TR8dsqWDtinaLIV7V8OI13C5gPfFtBJ2PVl0gso3zpeTKM8vbt7zA7WBMGYipbH
         aayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753986439; x=1754591239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NM1F+twQpy71daa6qC1+XAJlSbFRdKW6eeB3Y6Ifp5A=;
        b=SycQGoUNTq6aZpuFZ2SUC5nncg1FgZLaUN9l43ONmHv8c7tSJtraShBnIdyGP5B8qD
         sonGKxIN60YF9hCivCrNlA/90xNhS5H+sxCz5ByFSBXKGUuCOQlXQyllXpt9kew4v7Rx
         MbK0QZ9wdwn66WcJohQhOhVYSoX/hCZQcuvQ6J3wI5OhPbsq1jJrLbZKfyv8+U/5D7uB
         NOzvx7cpPYpgybbBNQ6qFgeYfb4kE73ACUz8teJ+N/sdO6PxObWmTORmIUSS2byWPy8F
         Gpxs1wbIu63a2aTEDW9ituTUoOTb5F1LZKWEzH7UcJsKAMpPuSsBftFwiZKcp/REKXjr
         uahg==
X-Gm-Message-State: AOJu0YzUb/RFp2GxfyO818Js7Ixnp7mBzA5E/T1DyQTHUuLp0+UZ4DV4
	DTO/22tK/ZAmBaBOd0vGBoOSiFC9Z6p8lQwEU/c1m5LrvcyegAaZTzHk78pt3ERIiOgQDklLeVa
	zgGianuq0Xs1dhn2eZFyPuAKqlW6XqTsruoVlPpqxsQ==
X-Gm-Gg: ASbGncvprzN/ng9/7ngiza1I/IMiVfvWrO0MeDS7nNE6H6Krjf3ci+VyIQtShA88pVY
	Vklaj34ixdXaj8bnUd47URFnRd10hvR79tMWT8102u4aVOnXFw/gl8hcMu9YWSBM0D5DIWQcqjf
	onAhFtIxUJm/oXVPzRHlozWEdwOHGKq2MrGMPCmTG+dVgQBm6LRnhLzCIcEHuAmoYo3cOPS491K
	FBSDF8xn4z/d2Pe8ak=
X-Google-Smtp-Source: AGHT+IHy+Y6h8rJPoGFEbP+KJGsipp6tAXpGy5APPCt3s2FjjlIXtNx2R+j/yb57MppAbcepPV4dH8UZpNIpQdneTgs=
X-Received: by 2002:a05:690c:4c05:b0:6ef:6d61:c254 with SMTP id
 00721157ae682-71a4696e4camr114178727b3.38.1753986438690; Thu, 31 Jul 2025
 11:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730185903.3574598-1-ameryhung@gmail.com> <20250730185903.3574598-3-ameryhung@gmail.com>
In-Reply-To: <20250730185903.3574598-3-ameryhung@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Thu, 31 Jul 2025 14:27:07 -0400
X-Gm-Features: Ac12FXxmYf9JAYs4bljCKjmk_S1ukNdfSAOv7raGIL08nlr9rTP5ssSUahF4E_g
Message-ID: <CABFh=a5wVa_ErAPkN9soQ27crgfxo2LxpEykOCgjBai25_qi3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/4] selftests/bpf: Introduce task local data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 2:59=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Task local data defines an abstract storage type for storing task-
> specific data (TLD). This patch provides user space and bpf
> implementation as header-only libraries for accessing task local data.
>
> Task local data is a bpf task local storage map with two UPTRs:
>
> - tld_meta_u, shared by all tasks of a process, consists of the total
>   count and size of TLDs and an array of metadata of TLDs. A TLD
>   metadata contains the size and name. The name is used to identify a
>   specific TLD in bpf programs.
>
> - u_tld_data points to a task-specific memory. It stores TLD data and
>   the starting offset of data in a page.
>
>   Task local design decouple user space and bpf programs. Since bpf
>   program does not know the size of TLDs in compile time, u_tld_data
>   is declared as a page to accommodate TLDs up to a page. As a result,
>   while user space will likely allocate memory smaller than a page for
>   actual TLDs, it needs to pin a page to kernel. It will pin the page
>   that contains enough memory if the allocated memory spans across the
>   page boundary.
>
> The library also creates another task local storage map, tld_key_map,
> to cache keys for bpf programs to speed up the access.
>
> Below are the core task local data API:
>
>                    User space                          BPF
>   Define TLD       TLD_DEFINE_KEY(), tld_create_key()  -
>   Init TLD object  -                                   tld_object_init()
>   Get TLD data     tld_get_data()                      tld_get_data()
>
> - TLD_DEFINE_KEY(), tld_create_key()
>
>   A TLD is first defined by the user space with TLD_DEFINE_KEY() or
>   tld_create_key(). TLD_DEFINE_KEY() defines a TLD statically and
>   allocates just enough memory during initialization. tld_create_key()
>   allows creating TLDs on the fly, but has a fix memory budget,
>   TLD_DYN_DATA_SIZE.
>
>   Internally, they all call __tld_create_key(), which iterates
>   tld_meta_u->metadata to check if a TLD can be added. The total TLD
>   size needs to fit into a page (limit of UPTR), and no two TLDs can
>   have the same name. If a TLD can be added, u_tld_meta->cnt is
>   increased using cmpxchg as there may be other concurrent
>   __tld_create_key(). After a successful cmpxchg, the last available
>   tld_meta_u->metadata now belongs to the calling thread. To prevent
>   other threads from reading incomplete metadata while it is being
>   updated, tld_meta_u->metadata->size is used to signal the completion.
>
>   Finally, the offset, derived from adding up prior TLD sizes is then
>   encapsulated as an opaque object key to prevent user misuse. The
>   offset is guaranteed to be 8-byte aligned to prevent load/store
>   tearing and allow atomic operations on it.
>
> - tld_get_data()
>
>   User space programs can pass the key to tld_get_data() to get a
>   pointer to the associated TLD. The pointer will remain valid for the
>   lifetime of the thread.
>
>   tld_data_u is lazily allocated on the first call to tld_get_data().
>   Trying to read task local data from bpf will result in -ENODATA
>   during tld_object_init(). The task-specific memory need to be freed
>   manually by calling tld_free() on thread exit to prevent memory leak
>   or use TLD_FREE_DATA_ON_THREAD_EXIT.
>
> - tld_object_init() (BPF)
>
>   BPF programs need to call tld_object_init() before calling
>   tld_get_data(). This is to avoid redundant map lookup in
>   tld_get_data() by storing pointers to the map values on stack.
>   The pointers are encapsulated as tld_object.
>
>   tld_key_map is also created on the first time tld_object_init()
>   is called to cache TLD keys successfully fetched by tld_get_data().
>
>   bpf_task_storage_get(.., F_CREATE) needs to be retried since it may
>   fail when another thread has already taken the percpu counter lock
>   for the task local storage.
>
> - tld_get_data() (BPF)
>
>   BPF programs can also get a pointer to a TLD with tld_get_data().
>   It uses the cached key in tld_key_map to locate the data in
>   tld_data_u->data. If the cached key is not set yet (<=3D 0),
>   __tld_fetch_key() will be called to iterate tld_meta_u->metadata
>   and find the TLD by name. To prevent redundant string comparison
>   in the future when the search fail, the tld_meta_u->cnt is stored
>   in the non-positive range of the key. Next time, __tld_fetch_key()
>   will be called only if there are new TLDs and the search will start
>   from the newly added tld_meta_u->metadata using the old
>   tld_meta_u-cnt.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../bpf/prog_tests/task_local_data.h          | 386 ++++++++++++++++++
>  .../selftests/bpf/progs/task_local_data.bpf.h | 237 +++++++++++
>  2 files changed, 623 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_dat=
a.h
>  create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf=
.h
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> new file mode 100644
> index 000000000000..a408d10c3688
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -0,0 +1,386 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TASK_LOCAL_DATA_H
> +#define __TASK_LOCAL_DATA_H
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <stdatomic.h>
> +#include <stddef.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +
> +#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> +#include <pthread.h>
> +#endif
> +
> +#include <bpf/bpf.h>
> +
> +/*
> + * OPTIONS
> + *
> + *   Define the option before including the header
> + *
> + *   TLD_FREE_DATA_ON_THREAD_EXIT - Frees memory on thread exit automati=
cally
> + *
> + *   Thread-specific memory for storing TLD is allocated lazily on the f=
irst call to
> + *   tld_get_data(). The thread that calls it must also call tld_free() =
on thread exit
> + *   to prevent memory leak. Pthread will be included if the option is d=
efined. A pthread
> + *   key will be registered with a destructor that calls tld_free().
> + *
> + *
> + *   TLD_DYN_DATA_SIZE - The maximum size of memory allocated for TLDs c=
reated dynamically
> + *   (default: 64 bytes)
> + *
> + *   A TLD can be defined statically using TLD_DEFINE_KEY() or created o=
n the fly using
> + *   tld_create_key(). As the total size of TLDs created with tld_create=
_key() cannot be
> + *   possibly known statically, a memory area of size TLD_DYN_DATA_SIZE =
will be allocated
> + *   for these TLDs. This additional memory is allocated for every threa=
d that calls
> + *   tld_get_data() even if no tld_create_key are actually called, so be=
 mindful of
> + *   potential memory wastage. Use TLD_DEFINE_KEY() whenever possible as=
 just enough memory
> + *   will be allocated for TLDs created with it.
> + *
> + *
> + *   TLD_NAME_LEN - The maximum length of the name of a TLD (default: 62=
)
> + *
> + *   Setting TLD_NAME_LEN will affect the maximum number of TLDs a proce=
ss can store,
> + *   TLD_MAX_DATA_CNT.
> + *
> + *
> + *   TLD_DATA_USE_ALIGNED_ALLOC - Always use aligned_alloc() instead of =
malloc()
> + *
> + *   When allocating the memory for storing TLDs, we need to make sure t=
here is a memory
> + *   region of the X bytes within a page. This is due to the limit posed=
 by UPTR: memory
> + *   pinned to the kernel cannot exceed a page nor can it cross the page=
 boundary. The
> + *   library normally calls malloc(2*X) given X bytes of total TLDs, and=
 only uses
> + *   aligned_alloc(PAGE_SIZE, X) when X >=3D PAGE_SIZE / 2. This is to r=
educe memory wastage
> + *   as not all memory allocator can use the exact amount of memory requ=
ested to fulfill
> + *   aligned_alloc(). For example, some may round the size up to the ali=
gnment. Enable the
> + *   option to always use aligned_alloc() if the implementation has low =
memory overhead.
> + */
> +
> +#define TLD_PAGE_SIZE getpagesize()
> +#define TLD_PAGE_MASK (~(TLD_PAGE_SIZE - 1))
> +
> +#define TLD_ROUND_MASK(x, y) ((__typeof__(x))((y) - 1))
> +#define TLD_ROUND_UP(x, y) ((((x) - 1) | TLD_ROUND_MASK(x, y)) + 1)
> +
> +#define TLD_READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> +
> +#ifndef TLD_DYN_DATA_SIZE
> +#define TLD_DYN_DATA_SIZE 64
> +#endif
> +
> +#define TLD_MAX_DATA_CNT (TLD_PAGE_SIZE / sizeof(struct tld_metadata) - =
1)
> +
> +#ifndef TLD_NAME_LEN
> +#define TLD_NAME_LEN 62
> +#endif
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +typedef struct {
> +       __s16 off;
> +} tld_key_t;
> +
> +struct tld_metadata {
> +       char name[TLD_NAME_LEN];
> +       _Atomic __u16 size;
> +};
> +
> +struct tld_meta_u {
> +       _Atomic __u8 cnt;
> +       __u16 size;
> +       struct tld_metadata metadata[];
> +};
> +
> +struct tld_data_u {
> +       __u64 start; /* offset of tld_data_u->data in a page */
> +       char data[];
> +};
> +
> +struct tld_map_value {
> +       void *data;
> +       struct tld_meta_u *meta;
> +};
> +
> +struct tld_meta_u * _Atomic tld_meta_p __attribute__((weak));
> +__thread struct tld_data_u *tld_data_p __attribute__((weak));
> +__thread void *tld_data_alloc_p __attribute__((weak));
> +
> +#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> +pthread_key_t tld_pthread_key __attribute__((weak));
> +
> +static void tld_free(void);
> +
> +static void __tld_thread_exit_handler(void *unused)
> +{
> +       tld_free();
> +}
> +#endif
> +
> +static int __tld_init_meta_p(void)
> +{
> +       struct tld_meta_u *meta, *uninit =3D NULL;
> +       int err =3D 0;
> +
> +       meta =3D (struct tld_meta_u *)aligned_alloc(TLD_PAGE_SIZE, TLD_PA=
GE_SIZE);
> +       if (!meta) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       memset(meta, 0, TLD_PAGE_SIZE);
> +       meta->size =3D TLD_DYN_DATA_SIZE;
> +
> +       if (!atomic_compare_exchange_strong(&tld_meta_p, &uninit, meta)) =
{
> +               free(meta);
> +               goto out;
> +       }
> +
> +#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> +       pthread_key_create(&tld_pthread_key, __tld_thread_exit_handler);
> +#endif
> +out:
> +       return err;
> +}
> +
> +static int __tld_init_data_p(int map_fd)
> +{
> +       bool use_aligned_alloc =3D false;
> +       struct tld_map_value map_val;
> +       struct tld_data_u *data;
> +       void *data_alloc =3D NULL;
> +       int err, tid_fd =3D -1;
> +
> +       tid_fd =3D syscall(SYS_pidfd_open, gettid(), O_EXCL);
> +       if (tid_fd < 0) {
> +               err =3D -errno;
> +               goto out;
> +       }
> +
> +#ifdef TLD_DATA_USE_ALIGNED_ALLOC
> +       use_aligned_alloc =3D true;
> +#endif
> +
> +       /*
> +        * tld_meta_p->size =3D TLD_DYN_DATA_SIZE +
> +        *          total size of TLDs defined via TLD_DEFINE_KEY()
> +        */
> +       data_alloc =3D (use_aligned_alloc || tld_meta_p->size * 2 >=3D TL=
D_PAGE_SIZE) ?
> +               aligned_alloc(TLD_PAGE_SIZE, tld_meta_p->size) :
> +               malloc(tld_meta_p->size * 2);
> +       if (!data_alloc) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       /*
> +        * Always pass a page-aligned address to UPTR since the size of t=
ld_map_value::data
> +        * is a page in BTF. If data_alloc spans across two pages, use th=
e page that contains large
> +        * enough memory.
> +        */
> +       if (TLD_PAGE_SIZE - (~TLD_PAGE_MASK & (intptr_t)data_alloc) >=3D =
tld_meta_p->size) {
> +               map_val.data =3D (void *)(TLD_PAGE_MASK & (intptr_t)data_=
alloc);
> +               data =3D data_alloc;
> +               data->start =3D (~TLD_PAGE_MASK & (intptr_t)data_alloc) +
> +                             offsetof(struct tld_data_u, data);
> +       } else {
> +               map_val.data =3D (void *)(TLD_ROUND_UP((intptr_t)data_all=
oc, TLD_PAGE_SIZE));
> +               data =3D (void *)(TLD_ROUND_UP((intptr_t)data_alloc, TLD_=
PAGE_SIZE));
> +               data->start =3D offsetof(struct tld_data_u, data);
> +       }
> +       map_val.meta =3D TLD_READ_ONCE(tld_meta_p);
> +
> +       err =3D bpf_map_update_elem(map_fd, &tid_fd, &map_val, 0);
> +       if (err) {
> +               free(data_alloc);
> +               goto out;
> +       }
> +
> +       tld_data_p =3D data;
> +       tld_data_alloc_p =3D data_alloc;
> +#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
> +       pthread_setspecific(tld_pthread_key, (void *)1);
> +#endif
> +out:
> +       if (tid_fd >=3D 0)
> +               close(tid_fd);
> +       return err;
> +}
> +
> +static tld_key_t __tld_create_key(const char *name, size_t size, bool dy=
n_data)
> +{
> +       int err, i, sz, off =3D 0;
> +       __u8 cnt;
> +
> +       if (!TLD_READ_ONCE(tld_meta_p)) {
> +               err =3D __tld_init_meta_p();
> +               if (err)
> +                       return (tld_key_t){err};
> +       }
> +
> +       for (i =3D 0; i < TLD_MAX_DATA_CNT; i++) {
> +retry:
> +               cnt =3D atomic_load(&tld_meta_p->cnt);
> +               if (i < cnt) {
> +                       /* A metadata is not ready until size is updated =
with a non-zero value */
> +                       while (!(sz =3D atomic_load(&tld_meta_p->metadata=
[i].size)))
> +                               sched_yield();
> +
> +                       if (!strncmp(tld_meta_p->metadata[i].name, name, =
TLD_NAME_LEN))
> +                               return (tld_key_t){-EEXIST};
> +
> +                       off +=3D TLD_ROUND_UP(sz, 8);
> +                       continue;
> +               }
> +
> +               /*
> +                * TLD_DEFINE_KEY() is given memory upto a page while at =
most
> +                * TLD_DYN_DATA_SIZE is allocated for tld_create_key()
> +                */
> +               if (dyn_data) {
> +                       if (off + TLD_ROUND_UP(size, 8) > tld_meta_p->siz=
e)
> +                               return (tld_key_t){-E2BIG};
> +               } else {
> +                       if (off + TLD_ROUND_UP(size, 8) > TLD_PAGE_SIZE -=
 sizeof(struct tld_data_u))
> +                               return (tld_key_t){-E2BIG};
> +                       tld_meta_p->size +=3D TLD_ROUND_UP(size, 8);
> +               }
> +
> +               /*
> +                * Only one tld_create_key() can increase the current cnt=
 by one and
> +                * takes the latest available slot. Other threads will ch=
eck again if a new
> +                * TLD can still be added, and then compete for the new s=
lot after the
> +                * succeeding thread update the size.
> +                */
> +               if (!atomic_compare_exchange_strong(&tld_meta_p->cnt, &cn=
t, cnt + 1))
> +                       goto retry;
> +
> +               strncpy(tld_meta_p->metadata[i].name, name, TLD_NAME_LEN)=
;
> +               atomic_store(&tld_meta_p->metadata[i].size, size);
> +               return (tld_key_t){(__s16)off};
> +       }
> +
> +       return (tld_key_t){-ENOSPC};
> +}
> +
> +/**
> + * TLD_DEFINE_KEY() - Define a TLD and a global variable key associated =
with the TLD.
> + *
> + * @name: The name of the TLD
> + * @size: The size of the TLD
> + * @key: The variable name of the key. Cannot exceed TLD_NAME_LEN
> + *
> + * The macro can only be used in file scope.
> + *
> + * A global variable key of opaque type, tld_key_t, will be declared and=
 initialized before
> + * main() starts. Use tld_key_is_err() or tld_key_err_or_zero() later to=
 check if the key
> + * creation succeeded. Pass the key to tld_get_data() to get a pointer t=
o the TLD.
> + * bpf programs can also fetch the same key by name.
> + *
> + * The total size of TLDs created using TLD_DEFINE_KEY() cannot exceed a=
 page. Just
> + * enough memory will be allocated for each thread on the first call to =
tld_get_data().
> + */
> +#define TLD_DEFINE_KEY(key, name, size)                        \
> +tld_key_t key;                                         \
> +                                                       \
> +__attribute__((constructor))                           \
> +void __tld_define_key_##key(void)                      \
> +{                                                      \
> +       key =3D __tld_create_key(name, size, false);      \
> +}
> +
> +/**
> + * tld_create_key() - Create a TLD and return a key associated with the =
TLD.
> + *
> + * @name: The name the TLD
> + * @size: The size of the TLD
> + *
> + * Return an opaque object key. Use tld_key_is_err() or tld_key_err_or_z=
ero() to check
> + * if the key creation succeeded. Pass the key to tld_get_data() to get =
a pointer to
> + * locate the TLD. bpf programs can also fetch the same key by name.
> + *
> + * Use tld_create_key() only when a TLD needs to be created dynamically =
(e.g., @name is
> + * not known statically or a TLD needs to be created conditionally)
> + *
> + * An additional TLD_DYN_DATA_SIZE bytes are allocated per-thread to acc=
ommodate TLDs
> + * created dynamically with tld_create_key(). Since only a user page is =
pinned to the
> + * kernel, when TLDs created with TLD_DEFINE_KEY() uses more than TLD_PA=
GE_SIZE -
> + * TLD_DYN_DATA_SIZE, the buffer size will be limited to the rest of the=
 page.
> + */
> +__attribute__((unused))
> +static tld_key_t tld_create_key(const char *name, size_t size)
> +{
> +       return __tld_create_key(name, size, true);
> +}
> +
> +__attribute__((unused))
> +static inline bool tld_key_is_err(tld_key_t key)
> +{
> +       return key.off < 0;
> +}
> +
> +__attribute__((unused))
> +static inline int tld_key_err_or_zero(tld_key_t key)
> +{
> +       return tld_key_is_err(key) ? key.off : 0;
> +}
> +
> +/**
> + * tld_get_data() - Get a pointer to the TLD associated with the given k=
ey of the
> + * calling thread.
> + *
> + * @map_fd: A file descriptor of tld_data_map, the underlying BPF task l=
ocal storage map
> + * of task local data.
> + * @key: A key object created by TLD_DEFINE_KEY() or tld_create_key().
> + *
> + * Return a pointer to the TLD if the key is valid; NULL if not enough m=
emory for TLD
> + * for this thread, or the key is invalid. The returned pointer is guara=
nteed to be 8-byte
> + * aligned.
> + *
> + * Threads that call tld_get_data() must call tld_free() on exit to prev=
ent
> + * memory leak if TLD_FREE_DATA_ON_THREAD_EXIT is not defined.
> + */
> +__attribute__((unused))
> +static void *tld_get_data(int map_fd, tld_key_t key)
> +{
> +       if (!TLD_READ_ONCE(tld_meta_p))
> +               return NULL;
> +
> +       /* tld_data_p is allocated on the first invocation of tld_get_dat=
a() */
> +       if (!tld_data_p && __tld_init_data_p(map_fd))
> +               return NULL;
> +
> +       return tld_data_p->data + key.off;
> +}
> +
> +/**
> + * tld_free() - Free task local data memory of the calling thread
> + *
> + * For the calling thread, all pointers to TLDs acquired before will bec=
ome invalid.
> + *
> + * Users must call tld_free() on thread exit to prevent memory leak. Alt=
ernatively,
> + * define TLD_FREE_DATA_ON_THREAD_EXIT and a thread exit handler will be=
 registered
> + * to free the memory automatically.
> + */
> +__attribute__((unused))
> +static void tld_free(void)
> +{
> +       if (tld_data_alloc_p) {
> +               free(tld_data_alloc_p);
> +               tld_data_alloc_p =3D NULL;
> +               tld_data_p =3D NULL;
> +       }
> +}
> +
> +#ifdef __cplusplus
> +} /* extern "C" */
> +#endif
> +
> +#endif /* __TASK_LOCAL_DATA_H */
> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/to=
ols/testing/selftests/bpf/progs/task_local_data.bpf.h
> new file mode 100644
> index 000000000000..432fff2af844
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> @@ -0,0 +1,237 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TASK_LOCAL_DATA_BPF_H
> +#define __TASK_LOCAL_DATA_BPF_H
> +
> +/*
> + * Task local data is a library that facilitates sharing per-task data
> + * between user space and bpf programs.
> + *
> + *
> + * USAGE
> + *
> + * A TLD, an entry of data in task local data, first needs to be created=
 by the
> + * user space. This is done by calling user space API, TLD_DEFINE_KEY() =
or
> + * tld_create_key(), with the name of the TLD and the size.
> + *
> + * TLD_DEFINE_KEY(prio, "priority", sizeof(int));
> + *
> + * or
> + *
> + * void func_call(...) {
> + *     tld_key_t prio, in_cs;
> + *
> + *     prio =3D tld_create_key("priority", sizeof(int));
> + *     in_cs =3D tld_create_key("in_critical_section", sizeof(bool));
> + *     ...
> + *
> + * A key associated with the TLD, which has an opaque type tld_key_t, wi=
ll be
> + * initialized or returned. It can be used to get a pointer to the TLD i=
n the
> + * user space by calling tld_get_data().
> + *
> + * In a bpf program, tld_object_init() first needs to be called to initi=
alized a
> + * tld_object on the stack. Then, TLDs can be accessed by calling tld_ge=
t_data().
> + * The API will try to fetch the key by the name and use it to locate th=
e data.
> + * A pointer to the TLD will be returned. It also caches the key in a ta=
sk local
> + * storage map, tld_key_map, whose value type, struct tld_keys, must be =
defined
> + * by the developer.
> + *
> + * struct tld_keys {
> + *     tld_key_t prio;
> + *     tld_key_t in_cs;
> + * };
> + *
> + * SEC("struct_ops")
> + * void prog(struct task_struct task, ...)
> + * {
> + *     struct tld_object tld_obj;
> + *     int err, *p;
> + *
> + *     err =3D tld_object_init(task, &tld_obj);
> + *     if (err)
> + *         return;
> + *
> + *     p =3D tld_get_data(&tld_obj, prio, "priority", sizeof(int));
> + *     if (p)
> + *         // do something depending on *p
> + */
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#define TLD_ROUND_MASK(x, y) ((__typeof__(x))((y) - 1))
> +#define TLD_ROUND_UP(x, y) ((((x) - 1) | TLD_ROUND_MASK(x, y)) + 1)
> +
> +#define TLD_MAX_DATA_CNT (__PAGE_SIZE / sizeof(struct tld_metadata) - 1)
> +
> +#ifndef TLD_NAME_LEN
> +#define TLD_NAME_LEN 62
> +#endif
> +
> +#ifndef TLD_KEY_MAP_CREATE_RETRY
> +#define TLD_KEY_MAP_CREATE_RETRY 10
> +#endif
> +
> +typedef struct {
> +       __s16 off;
> +} tld_key_t;
> +
> +struct tld_metadata {
> +       char name[TLD_NAME_LEN];
> +       __u16 size;
> +};
> +
> +struct tld_meta_u {
> +       __u8 cnt;
> +       __u16 size;
> +       struct tld_metadata metadata[TLD_MAX_DATA_CNT];
> +};
> +
> +struct tld_data_u {
> +       __u64 start; /* offset of tld_data_u->data in a page */
> +       char data[__PAGE_SIZE - sizeof(__u64)];
> +};
> +
> +struct tld_map_value {
> +       struct tld_data_u __uptr *data;
> +       struct tld_meta_u __uptr *meta;
> +};
> +
> +typedef struct tld_uptr_dummy {
> +       struct tld_data_u data[0];
> +       struct tld_meta_u meta[0];
> +} *tld_uptr_dummy_t;
> +
> +struct tld_object {
> +       struct tld_map_value *data_map;
> +       struct tld_keys *key_map;
> +       /*
> +        * Force the compiler to generate the actual definition of tld_me=
ta_u
> +        * and tld_data_u in BTF. Without it, tld_meta_u and u_tld_data w=
ill
> +        * be BTF_KIND_FWD.
> +        */
> +       tld_uptr_dummy_t dummy[0];
> +};
> +
> +/*
> + * Map value of tld_key_map for caching keys. Must be defined by the dev=
eloper.
> + * Members should be tld_key_t and passed to the 3rd argument of tld_fet=
ch_key().
> + */
> +struct tld_keys;
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, struct tld_map_value);
> +} tld_data_map SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, struct tld_keys);
> +} tld_key_map SEC(".maps");
> +
> +/**
> + * tld_object_init() - Initialize a tld_object.
> + *
> + * @task: The task_struct of the target task
> + * @tld_obj: A pointer to a tld_object to be initialized
> + *
> + * Return 0 on success; -ENODATA if the user space did not initialize ta=
sk local data
> + * for the current task through tld_get_data(); -ENOMEM if the creation =
of tld_key_map
> + * fails
> + */
> +__attribute__((unused))
> +static int tld_object_init(struct task_struct *task, struct tld_object *=
tld_obj)
> +{
> +       int i;
> +
> +       tld_obj->data_map =3D bpf_task_storage_get(&tld_data_map, task, 0=
, 0);
> +       if (!tld_obj->data_map)
> +               return -ENODATA;
> +
> +       bpf_for(i, 0, TLD_KEY_MAP_CREATE_RETRY) {
> +               tld_obj->key_map =3D bpf_task_storage_get(&tld_key_map, t=
ask, 0,
> +                                                       BPF_LOCAL_STORAGE=
_GET_F_CREATE);
> +               if (likely(tld_obj->key_map))
> +                       break;
> +       }
> +       if (!tld_obj->key_map)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +/*
> + * Return the offset of TLD if @name is found. Otherwise, return the cur=
rent TLD count
> + * using the nonpositive range so that the next tld_get_data() can skip =
fetching key if
> + * no new TLD is added or start comparing name from the first newly adde=
d TLD.
> + */
> +__attribute__((unused))
> +static int __tld_fetch_key(struct tld_object *tld_obj, const char *name,=
 int i_start)
> +{
> +       struct tld_metadata *metadata;
> +       int i, cnt, start, off =3D 0;
> +
> +       if (!tld_obj->data_map || !tld_obj->data_map->data || !tld_obj->d=
ata_map->meta)
> +               return 0;
> +
> +       start =3D tld_obj->data_map->data->start;
> +       cnt =3D tld_obj->data_map->meta->cnt;
> +       metadata =3D tld_obj->data_map->meta->metadata;
> +
> +       bpf_for(i, 0, cnt) {
> +               if (i >=3D TLD_MAX_DATA_CNT)
> +                       break;
> +
> +               if (i >=3D i_start && !bpf_strncmp(metadata[i].name, TLD_=
NAME_LEN, name))
> +                       return start + off;
> +
> +               off +=3D TLD_ROUND_UP(metadata[i].size, 8);
> +       }
> +
> +       return -cnt;
> +}
> +
> +/**
> + * tld_get_data() - Retrieve a pointer to the TLD associated with the na=
me.
> + *
> + * @tld_obj: A pointer to a valid tld_object initialized by tld_object_i=
nit()
> + * @key: The cached key of the TLD in tld_key_map
> + * @name: The name of the key associated with a TLD
> + * @size: The size of the TLD. Must be a known constant value
> + *
> + * Return a pointer to the TLD associated with @name; NULL if not found =
or @size is too
> + * big. @key is used to cache the key if the TLD is found to speed up su=
bsequent calls.
> + * It should be defined as an member of tld_keys of tld_key_t type by th=
e developer.
> + */
> +#define tld_get_data(tld_obj, key, name, size)                          =
               \
> +       ({                                                               =
               \
> +               void *data =3D NULL, *_data =3D (tld_obj)->data_map->data=
;                  \
> +               long off =3D (tld_obj)->key_map->key.off;                =
                 \
> +               int cnt;                                                 =
               \
> +                                                                        =
               \
> +               if (likely(_data)) {                                     =
               \
> +                       if (likely(off > 0)) {                           =
               \
> +                               barrier_var(off);                        =
               \
> +                               if (likely(off < __PAGE_SIZE - size))    =
               \
> +                                       data =3D _data + off;            =
                 \
> +                       } else {                                         =
               \
> +                               cnt =3D -(off);                          =
                 \
> +                               if (likely((tld_obj)->data_map->meta) && =
               \
> +                                   cnt < (tld_obj)->data_map->meta->cnt)=
 {             \
> +                                       off =3D __tld_fetch_key(tld_obj, =
name, cnt);      \
> +                                       (tld_obj)->key_map->key.off =3D o=
ff;              \
> +                                                                        =
               \
> +                                       if (likely(off < __PAGE_SIZE - si=
ze)) {         \
> +                                               barrier_var(off);        =
               \
> +                                               if (off > 0)             =
               \
> +                                                       data =3D _data + =
off;             \
> +                                       }                                =
               \
> +                               }                                        =
               \
> +                       }                                                =
               \
> +               }                                                        =
               \
> +               data;                                                    =
               \
> +       })
> +
> +#endif
> --
> 2.47.3
>

