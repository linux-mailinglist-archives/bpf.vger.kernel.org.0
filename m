Return-Path: <bpf+bounces-58420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FAEABA34D
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 20:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B911BA0248
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C038227AC42;
	Fri, 16 May 2025 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpHO6lTB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44F27FB08;
	Fri, 16 May 2025 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421861; cv=none; b=dh5zPTuTlojw2uAjriM5VOA/jh7Q0siNKZuwXsUVs7NccYNMnyZ8ec86UGyGMCSu9fPUnKs6w9bc3CC/CL2F15V2YTZ3EB2D13zy2yXKJOD7iQFonB2aLcj2Xc/R+1j4rJ7GZOm8A+VBOXn3k6bbwoEkLRTi8WHhBYPD/i522Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421861; c=relaxed/simple;
	bh=7as/Axua4qQI4MB9tNcRc2T9F0voGU5p5Bo283d/M5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBSs0RF6CU6yh1ddKVFoI0ZE7s2WEdPB9m7+kUABWLvAevcffBtZ0tt2q4kXuz7M68WTTsTwL5EOOgCwdjTDRjtBbUVhaTZ34C62m90DoYPB1paG5Eg4N5Z+7L4znS8v4gTZX1MkZ5m3pKsVrP/dZzkDArnpo8prxR5/e5tJP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpHO6lTB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441c99459e9so15525845e9.3;
        Fri, 16 May 2025 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747421857; x=1748026657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5phvEay9iWwQZhlk2Jrr5mfI1oIWrnFgPZ/JoKDR9zU=;
        b=VpHO6lTB6vdeOTuoFLOOgHnqQIryPrBXI7TkuC1MG7skjNvubJq4NYsY30wT9iki5P
         /ft7eAIxeqQThRuCHhTnPiiR89Tl1slvssYqbvKMhCWCcEK4B6FI5JNe2nQi6cF3V7cC
         Weab4YKBCG5GggziOP01vTcZxiM2LbZwuUU8lI+XqDW3ai2f9j2v0KQ/mVkPPf1cJLqz
         7nFcRU6KzP9rnygh3YrbSaQao8A0Kz2ZJ9XIuDnb9UoMcIEuIalXS3+UtUl7MqVBMwro
         rp15vMMhZbPKg/OhWg+v7lorcqEiFYFv5sWFIR85m6/py3vz9v3ev/hTqNjTEo3sPPpw
         ma6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747421857; x=1748026657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5phvEay9iWwQZhlk2Jrr5mfI1oIWrnFgPZ/JoKDR9zU=;
        b=tO0XIhVGRvHv6YZdECnlGpOgh6OxQRPDFbugYJq+9V/qMpOfByTJAT9aXZbkLNim03
         UxOezNV1Bg5G+ZrI7Pi2VV1g/kFyvWaz+ii5xY2FrSN7K3ixNCC5PW5lSIbK4zChBVhy
         l5eD6ZBB2APVe1w3W42fCgmCXEuSGN4pcWR5NoBr1d50G5voPlCgIHPxjCxMRSDOFSGp
         f5QN6tZxTI/yMauiYha68q6oPmY25hGE5WnikbSgBLLG4bOJT/RRLHJYPr9SkPJRWgT0
         YE+5PKGPP4U9yflEnLt56UE7gvR7P9pkj0YSwcyVQhVtcr+jUJ2ux3znxuavI19DdlOW
         j55g==
X-Forwarded-Encrypted: i=1; AJvYcCWzo2j5xMZeEZ+ZuFO5PVRXaT/t0iqNQm1hZsg7Wsb+F9btzkUObiFr07CA52oNN6E5XpZgNdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1w/0sbdGJUnyHP/GTYcSjcELDIWXbfHE4MDbpDbPtZD4bV8el
	PqKLFiG/e79m9tnpExmjYYqEEDdVZs4ZKtH0t88G244UFG+a7Zsg6/j6BMe4B/lkQc0l4K5jFtf
	TEh0cWysBfb9en8/r1OtJn6tz8jv1crI=
X-Gm-Gg: ASbGncuTYOVSc3algCwmZziqNiiTEohoxxI8r6nnbRioham66M17VzgyAr69O6ia03b
	Bb+9GGpy4vuO295spg3I1B2hvWC1wf8bUVAfnRGrRfwRN/Ps1TsovIqBd/H2+kxnP8Z+SPuGI8V
	RJXf4mOTdjXq+d3gH5eXx6RQHsnY53cKQ6cVysRUyNm2w7RJC76TARHzZOdiKV4A==
X-Google-Smtp-Source: AGHT+IGk/5Kr+sIOGZ/sh5mIqGOsqWSs8HJRWgDMWJryNmhTTnN2Fj/2TCITsH46CyYoOIAD1hMVsEmcJ7UmtxEeAQA=
X-Received: by 2002:a5d:5f8d:0:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-3a35c808b4amr5078374f8f.1.1747421856581; Fri, 16 May 2025
 11:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515211606.2697271-1-ameryhung@gmail.com> <20250515211606.2697271-2-ameryhung@gmail.com>
In-Reply-To: <20250515211606.2697271-2-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 May 2025 11:57:25 -0700
X-Gm-Features: AX0GCFv38ya2U4NgdR956GPbbqrGOOw2UBiw-wIth_EJYCcwa3bxwtF2tb4PhdE
Message-ID: <CAADnVQLPyHnqEbPowpN+JuMwH+iMX4=dZZu2chMaiexwAVxxJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 2:16=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Task local data defines an abstract storage type for storing task-
> specific data (TLD). This patch provides user space and bpf
> implementation as header-only libraries for accessing task local data.
>
> Task local data is a bpf task local storage map with two UPTRs:
> 1) u_tld_metadata, shared by all tasks of the same process, consists of
> the total count of TLDs and an array of metadata of TLDs. A metadata of
> a TLD comprises the size and the name. The name is used to identify a
> specific TLD in bpf 2) data is memory for storing TLDs specific to the
> task.
>
> The following are the basic task local data API:
>
>                  User space               BPF
> Create key     tld_create_key()            -
> Fetch key            -               tld_fetch_key()
> Get data       tld_get_data()        tld_get_data()
>
> A TLD is first created by the user space with tld_create_key(). First,
> it goes through the metadata array to check if the TLD can be added.
> The total TLD size needs to fit into a page (limited by UPTR), and no
> two TLDs can have the same name. It also calculates the offset, the next
> available space in u_tld_data, by summing sizes of TLDs. If the TLD
> can be added, it increases the count using cmpxchg as there may be other
> concurrent tld_create_key(). After a successful cmpxchg, the last
> metadata slot now belongs to the calling thread and will be updated.
> tld_create_key() returns the offset encapsulated as a opaque object key
> to prevent user misuse.
>
> Then user space can pass the key to tld_get_data() to get a pointer
> to the TLD. The pointer will remain valid for the lifetime of the
> thread.
>
> BPF programs also locate TLDs with the keys. This is done by calling
> tld_fetch_key() with the name of the TLD. Similar to tld_create_key(),
> it scans through metadata array, compare the name of TLDs and compute
> the offset. Once found, the offset is also returned as a key, which
> can be passed to the bpf version of tld_get_data() to retrieve a
> pointer to the TLD.
>
> User space task local data library uses a light way approach to ensure
> thread safety (i.e., atomic operation + compiler and memory barriers).
> While a metadata is being updated, other threads may also try to read it.
> To prevent them from seeing incomplete data, metadata::size is used to
> signal the completion of the update, where 0 means the update is still
> ongoing. Threads will wait until seeing a non-zero size to read a
> metadata. Acquire/release order is required for metadata::size to
> prevent hardware reordering. For example, moving store to metadata::name
> after store to metadata::size or moving load from metadata::name before
> load from metadata::size.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  .../bpf/prog_tests/task_local_data.h          | 263 ++++++++++++++++++
>  .../selftests/bpf/progs/task_local_data.bpf.h | 220 +++++++++++++++
>  2 files changed, 483 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_dat=
a.h
>  create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf=
.h
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
> new file mode 100644
> index 000000000000..ec43ea59267c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> @@ -0,0 +1,263 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TASK_LOCAL_DATA_H
> +#define __TASK_LOCAL_DATA_H
> +
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <sched.h>
> +#include <stddef.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +
> +#include <bpf/bpf.h>
> +
> +#ifndef PIDFD_THREAD
> +#define PIDFD_THREAD O_EXCL
> +#endif
> +
> +#define PAGE_SIZE 4096
> +
> +#ifndef __round_mask
> +#define __round_mask(x, y) ((__typeof__(x))((y)-1))
> +#endif
> +#ifndef round_up
> +#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
> +#endif
> +
> +#ifndef READ_ONCE
> +#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> +#endif
> +
> +#ifndef WRITE_ONCE
> +#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) =3D (val))
> +#endif
> +
> +#define TLD_DATA_SIZE PAGE_SIZE

wrap it with #ifndef ?

So that application can #define something smaller.

> +#define TLD_DATA_CNT 63
> +#define TLD_NAME_LEN 62
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
> +struct u_tld_metadata {
> +       __u8 cnt;
> +       __u8 padding[63];
> +       struct tld_metadata metadata[TLD_DATA_CNT];
> +};
> +
> +struct u_tld_data {
> +       char data[TLD_DATA_SIZE];
> +};
> +
> +struct tld_map_value {
> +       struct u_tld_data *data;
> +       struct u_tld_metadata *metadata;
> +};
> +
> +struct u_tld_metadata *tld_metadata_p __attribute__((weak));
> +__thread struct u_tld_data *tld_data_p __attribute__((weak));
> +
> +static int __tld_init_metadata(int map_fd)
> +{
> +       struct u_tld_metadata *new_metadata;
> +       struct tld_map_value map_val;
> +       int task_fd =3D 0, err;
> +
> +       task_fd =3D syscall(SYS_pidfd_open, getpid(), 0);

this task_fd and task_fd in __tld_init_data() are two different things.
Please name them differently.

> +       if (task_fd < 0) {
> +               err =3D -errno;
> +               goto out;
> +       }
> +
> +       new_metadata =3D aligned_alloc(PAGE_SIZE, PAGE_SIZE);
> +       if (!new_metadata) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       memset(new_metadata, 0, PAGE_SIZE);
> +
> +       map_val.data =3D NULL;
> +       map_val.metadata =3D new_metadata;
> +
> +       /*
> +        * bpf_map_update_elem(.., pid_fd,..., BPF_NOEXIST) guarantees th=
at
> +        * only one tld_create_key() can update tld_metadata_p.
> +        */
> +       err =3D bpf_map_update_elem(map_fd, &task_fd, &map_val, BPF_NOEXI=
ST);
> +       if (err) {
> +               free(new_metadata);
> +               if (err =3D=3D -EEXIST || err =3D=3D -EAGAIN)
> +                       err =3D 0;
> +               goto out;
> +       }
> +
> +       WRITE_ONCE(tld_metadata_p, new_metadata);
> +out:
> +       if (task_fd > 0)

>=3D

> +               close(task_fd);
> +       return err;
> +}
> +
> +static int __tld_init_data(int map_fd)
> +{
> +       struct u_tld_data *new_data =3D NULL;
> +       struct tld_map_value map_val;
> +       int err, task_fd =3D 0;
> +
> +       task_fd =3D syscall(SYS_pidfd_open, gettid(), PIDFD_THREAD);
> +       if (task_fd < 0) {
> +               err =3D -errno;
> +               goto out;
> +       }
> +
> +       new_data =3D aligned_alloc(PAGE_SIZE, TLD_DATA_SIZE);

probably roundup_power_of_two(TLD_DATA_SIZE) ?
Don't know about libc, but musl implementation of aligned_alloc()
is naive. It allocs align+size.
So it's a memory waste.

> +       if (!new_data) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       map_val.data =3D new_data;
> +       map_val.metadata =3D READ_ONCE(tld_metadata_p);
> +
> +       err =3D bpf_map_update_elem(map_fd, &task_fd, &map_val, 0);
> +       if (err) {
> +               free(new_data);
> +               goto out;
> +       }
> +
> +       tld_data_p =3D new_data;
> +out:
> +       if (task_fd > 0)

>=3D

> +               close(task_fd);
> +       return err;
> +}
> +
> +/**
> + * tld_create_key() - Create a key associated with a TLD.
> + *
> + * @map_fd: A file descriptor of the underlying task local storage map,
> + * tld_data_map
> + * @name: The name the TLD will be associated with
> + * @size: Size of the TLD
> + *
> + * Returns an opaque object key. Use tld_key_is_err() or tld_key_err_or_=
zero() to
> + * check if the key creation succeed. Pass to tld_get_data() to get a po=
inter to
> + * the TLD. bpf programs can also fetch the same key by name.
> + */
> +__attribute__((unused))
> +static tld_key_t tld_create_key(int map_fd, const char *name, size_t siz=
e)
> +{
> +       int err, i, cnt, sz, off =3D 0;
> +
> +       if (!READ_ONCE(tld_metadata_p)) {
> +               err =3D __tld_init_metadata(map_fd);
> +               if (err)
> +                       return (tld_key_t) {.off =3D err};
> +       }
> +
> +       if (!tld_data_p) {
> +               err =3D __tld_init_data(map_fd);
> +               if (err)
> +                       return (tld_key_t) {.off =3D err};
> +       }
> +
> +       size =3D round_up(size, 8);

why roundup ? and to 8 in particular?
If user space wants byte size keys, why not let it?

> +
> +       for (i =3D 0; i < TLD_DATA_CNT; i++) {
> +retry:
> +               cnt =3D __atomic_load_n(&tld_metadata_p->cnt, __ATOMIC_RE=
LAXED);

Instead of explicit __atomic builtins use _Atomic __u8 cnt;
?

> +               if (i < cnt) {
> +                       /*
> +                        * Pending tld_create_key() uses size to signal i=
f the metadata has
> +                        * been fully updated.
> +                        */
> +                       while (!(sz =3D __atomic_load_n(&tld_metadata_p->=
metadata[i].size,
> +                                                     __ATOMIC_ACQUIRE)))
> +                               sched_yield();
> +
> +                       if (!strncmp(tld_metadata_p->metadata[i].name, na=
me, TLD_NAME_LEN))
> +                               return (tld_key_t) {.off =3D -EEXIST};
> +
> +                       off +=3D sz;
> +                       continue;
> +               }
> +
> +               if (off + size > TLD_DATA_SIZE)
> +                       return (tld_key_t) {.off =3D -E2BIG};
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
> +               if (!__atomic_compare_exchange_n(&tld_metadata_p->cnt, &c=
nt, cnt + 1, true,
> +                                                __ATOMIC_RELAXED, __ATOM=
IC_RELAXED))

weak and relaxed/relaxed ?
That's unusual.
I don't know what it is supposed to do.
I think weak=3Dfalse and __ATOMIC_ACQUIRE, __ATOMIC_RELAXED
would look as expected.

> +                       goto retry;
> +
> +               strncpy(tld_metadata_p->metadata[i].name, name, TLD_NAME_=
LEN);
> +               __atomic_store_n(&tld_metadata_p->metadata[i].size, size,=
 __ATOMIC_RELEASE);
> +               return (tld_key_t) {.off =3D off};
> +       }
> +
> +       return (tld_key_t) {.off =3D -ENOSPC};
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
> + * tld_get_data() - Gets a pointer to the TLD associated with the key.
> + *
> + * @map_fd: A file descriptor of the underlying task local storage map,
> + * tld_data_map
> + * @key: A key object returned by tld_create_key().
> + *
> + * Returns a pointer to the TLD if the key is valid; NULL if no key has =
been
> + * added, not enough memory for TLD for this thread, or the key is inval=
id.
> + *
> + * Threads that call tld_get_data() must call tld_free() on exit to prev=
ent
> + * memory leak.
> + */
> +__attribute__((unused))
> +static void *tld_get_data(int map_fd, tld_key_t key)
> +{
> +       if (!READ_ONCE(tld_metadata_p))
> +               return NULL;
> +
> +       if (!tld_data_p && __tld_init_data(map_fd))
> +               return NULL;

Why call it again?
tld_create_key() should have done it, no?

> +
> +       return tld_data_p->data + key.off;
> +}
> +
> +/**
> + * tld_free() - Frees task local data memory of the calling thread
> + */
> +__attribute__((unused))
> +static void tld_free(void)
> +{
> +       if (tld_data_p)
> +               free(tld_data_p);
> +}

Since this .h allocates tld_metadata_p, it probably needs
a helper to free it too.

> +
> +#endif /* __TASK_LOCAL_DATA_H */
> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/to=
ols/testing/selftests/bpf/progs/task_local_data.bpf.h
> new file mode 100644
> index 000000000000..5f48e408a5e5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> @@ -0,0 +1,220 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TASK_LOCAL_DATA_BPF_H
> +#define __TASK_LOCAL_DATA_BPF_H
> +
> +/*
> + * Task local data is a library that facilitates sharing per-task data
> + * between user space and bpf programs.
> + *
> + *
> + * PREREQUISITE
> + *
> + * A TLD, an entry of data in task local data, first needs to be created=
 by the
> + * user space. This is done by calling user space API, tld_create_key(),=
 with
> + * the name of the TLD and the size.
> + *
> + *     tld_key_t prio, in_cs;
> + *
> + *     prio =3D tld_create_key("priority", sizeof(int));
> + *     in_cs =3D tld_create_key("in_critical_section", sizeof(bool));
> + *
> + * A key associated with the TLD, which has an opaque type tld_key_t, wi=
ll be
> + * returned. It can be used to get a pointer to the TLD in the user spac=
e by
> + * calling tld_get_data().
> + *
> + *
> + * USAGE
> + *
> + * Similar to user space, bpf programs locate a TLD using the same key.
> + * tld_fetch_key() allows bpf programs to retrieve a key created in the =
user
> + * space by name, which is specified in the second argument of tld_creat=
e_key().
> + * tld_fetch_key() additionally will cache the key in a task local stora=
ge map,
> + * tld_key_map, to avoid performing costly string comparisons every time=
 when
> + * accessing a TLD. This requires the developer to define the map value =
type of
> + * tld_key_map, struct tld_keys. It only needs to contain keys used by b=
pf
> + * programs in the compilation unit.
> + *
> + * struct tld_keys {
> + *     tld_key_t prio;
> + *     tld_key_t in_cs;
> + * };
> + *
> + * Then, for every new task, a bpf program will fetch and cache keys onc=
e and
> + * for all. This should be done ideally in a non-critical path (e.g., in
> + * sched_ext_ops::init_task).
> + *
> + *     struct tld_object tld_obj;
> + *
> + *     err =3D tld_object_init(task, &tld);
> + *     if (err)
> + *         return 0;
> + *
> + *     tld_fetch_key(&tld_obj, "priority", prio);
> + *     tld_fetch_key(&tld_obj, "in_critical_section", in_cs);
> + *
> + * Note that, the first argument of tld_fetch_key() is a pointer to tld_=
object.
> + * It should be declared as a stack variable and initialized via tld_obj=
ect_init().
> + *
> + * Finally, just like user space programs, bpf programs can get a pointe=
r to a
> + * TLD by calling tld_get_data(), with cached keys.
> + *
> + *     int *p;
> + *
> + *     p =3D tld_get_data(&tld_obj, prio, sizeof(int));
> + *     if (p)
> + *         // do something depending on *p
> + */
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#define TLD_DATA_SIZE __PAGE_SIZE
> +#define TLD_DATA_CNT 63
> +#define TLD_NAME_LEN 62
> +
> +typedef struct {
> +       __s16 off;
> +} tld_key_t;
> +
> +struct u_tld_data *dummy_data;
> +struct u_tld_metadata *dummy_metadata;
> +
> +struct tld_metadata {
> +       char name[TLD_NAME_LEN];
> +       __u16 size;
> +};
> +
> +struct u_tld_metadata {
> +       __u8 cnt;
> +       __u8 padding[63];
> +       struct tld_metadata metadata[TLD_DATA_CNT];
> +};
> +
> +struct u_tld_data {
> +       char data[TLD_DATA_SIZE];
> +};
> +
> +struct tld_map_value {
> +       struct u_tld_data __uptr *data;
> +       struct u_tld_metadata __uptr *metadata;
> +};
> +
> +struct tld_object {
> +       struct tld_map_value *data_map;
> +       struct tld_keys *key_map;
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
> + * tld_object_init() - Initializes a tld_object.
> + *
> + * @task: The task_struct of the target task
> + * @tld_obj: A pointer to a tld_object to be initialized
> + *
> + * Returns 0 on success; -ENODATA if the task has no TLD; -ENOMEM if the=
 creation
> + * of tld_key_map fails
> + */
> +__attribute__((unused))
> +static int tld_object_init(struct task_struct *task, struct tld_object *=
tld_obj)
> +{
> +       tld_obj->data_map =3D bpf_task_storage_get(&tld_data_map, task, 0=
, 0);
> +       if (!tld_obj->data_map)
> +               return -ENODATA;
> +
> +       tld_obj->key_map =3D bpf_task_storage_get(&tld_key_map, task, 0,
> +                                               BPF_LOCAL_STORAGE_GET_F_C=
REATE);
> +       if (!tld_obj->key_map)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +/**
> + * tld_fetch_key() - Fetches the key to a TLD by name. The key has to be=
 created
> + * by user space first with tld_create_key().
> + *
> + * @tld_obj: A pointer to a valid tld_object initialized by tld_object_i=
nit()
> + * @name: The name of the key associated with a TLD
> + * @key: The key in struct tld_keys to be saved to
> + *
> + * Returns a positive integer on success; 0 otherwise
> + */
> +#define tld_fetch_key(tld_obj, name, key)                               =
       \
> +       ({                                                               =
       \
> +               (tld_obj)->key_map->key.off =3D __tld_fetch_key(tld_obj, =
name);   \
> +       })
> +
> +__attribute__((unused))
> +static u16 __tld_fetch_key(struct tld_object *tld_obj, const char *name)
> +{
> +       int i, meta_off, cnt;
> +       void *metadata, *nm, *sz;
> +       u16 off =3D 0;
> +
> +       if (!tld_obj->data_map || !tld_obj->data_map->metadata)
> +               return 0;
> +
> +       cnt =3D tld_obj->data_map->metadata->cnt;
> +       metadata =3D tld_obj->data_map->metadata->metadata;
> +
> +       bpf_for(i, 0, cnt) {
> +               meta_off =3D i * sizeof(struct tld_metadata);
> +               if (meta_off > TLD_DATA_SIZE - offsetof(struct u_tld_meta=
data, metadata)
> +                                          - sizeof(struct tld_metadata))
> +                       break;
> +
> +               nm =3D metadata + meta_off + offsetof(struct tld_metadata=
, name);
> +               sz =3D metadata + meta_off + offsetof(struct tld_metadata=
, size);
> +
> +               /*
> +                * Reserve 0 for uninitialized keys. Increase the offset =
of a valid key
> +                * by one and subtract it later in tld_get_data().
> +                */
> +               if (!bpf_strncmp(nm, TLD_NAME_LEN, name))
> +                       return off + 1;

I think all this +1, -1 dance is doing is helping to catch an
error when tld_get_data() is called without tld_fetch_key().
I feel this is too defensive.

Let tld_fetch_key() return proper negative error code.

> +
> +               off +=3D *(u16 *)sz;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * tld_get_data() - Retrieves a pointer to the TLD associated with the k=
ey.
> + *
> + * @tld_obj: A pointer to a valid tld_object initialized by tld_object_i=
nit()
> + * @key: The key of a TLD saved in tld_maps
> + * @size: The size of the TLD. Must be a known constant value
> + *
> + * Returns a pointer to the TLD data associated with the key; NULL if th=
e key
> + * is not valid or the size is too big
> + */
> +#define tld_get_data(tld_obj, key, size) \
> +       __tld_get_data(tld_obj, (tld_obj)->key_map->key.off - 1, size)
> +
> +__attribute__((unused))
> +__always_inline void *__tld_get_data(struct tld_object *tld_obj, u32 off=
, u32 size)
> +{
> +       return (tld_obj->data_map->data && off >=3D 0 && off < TLD_DATA_S=
IZE - size) ?
> +               (void *)tld_obj->data_map->data + off : NULL;

If we require users to call tld_fetch_key() first and check for errors
tld_get_data() can be faster:
#define tld_get_data(tld_obj, key)
   (void *)tld_obj->data_map->data + tld_obj->key_map->key.off

I wouldn't bother with extra checks, especially for size.

Bigger question.. can we cache the whole pointer for each key ?
and then
#define tld_get_data(tld_obj, key) ld_obj->key_map->key

