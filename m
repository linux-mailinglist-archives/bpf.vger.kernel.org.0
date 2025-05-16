Return-Path: <bpf+bounces-58425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBA8ABA4CD
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 22:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E399E1301
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 20:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F05280009;
	Fri, 16 May 2025 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVWoSDpG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648A27FD6F;
	Fri, 16 May 2025 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747428112; cv=none; b=qnAx4dEy8bREom13FZXWAqCfYJaPmSKZWolHJun2AmZisdEu5KySV8xGG1NP5M2mrtY0u41DBOX758laG05cESrpTp2KZkRnzVyO2QBsn1Z/O2isZcY7+EBUPB4zr+RLlxMBI9nfJv1tSNGqk0ZG/J6jnpDEzqrnNClxiMdRpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747428112; c=relaxed/simple;
	bh=wNC1XBAa7ZH7G2PUwGP94edjIm0h4bpgnYADzh5zg2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a02fLWAjGAq5Fgv61p+oTKj0wvyMZyqgkNF+U/BWrUHiNvKMT2C2JmiTdLAQ+9i2G0wHV4ZZzPgqp99y79YT+HrqcM8dDTTETKotEdJS2RKpVvVMur9Yn5rYA7/TKvFqdth78zX4hCK98DVx2WFQQZ1zm6MpGHYWlFgbkfmkcuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVWoSDpG; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e733a6ff491so2401967276.2;
        Fri, 16 May 2025 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747428109; x=1748032909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNhKDNTBkS0/Hm0CJYGZvQwGlRcxkd5oISO/abMKJNw=;
        b=AVWoSDpGD8ElLaPDZz52zNdMNGQGdZROLhOe/gOpxaxo9XorpibX3aDK4tV2u2qGYf
         0LSNMAfC72oLG3FbBUdFup6bWQCVrfraO54HtYKVzz51c3BqkOgckl3hGySdB3Woqphr
         tbVq0eQLf6oXhSyz+zQXkG9QZ1YPHzl3q8isSvTc7tiERQm03+9Jq0Yat7h9tvPrgydQ
         yMJY8E4aoZjSyfh1SXM6qfFP0talRtIg7qhvi0eMtvcVvT82uFyJgPrTFxi8lqOwhXG+
         daYxu+LF6g9/QFczgqtJthQwZqMlNWTug2Dl0Q8RaB3L79WBVbY2S8OPjaTeMgn/2sDi
         1w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747428109; x=1748032909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNhKDNTBkS0/Hm0CJYGZvQwGlRcxkd5oISO/abMKJNw=;
        b=oP/ysQHVjAi2tjHucx6X50wYhz9kt5/4HiMUIqLaoWSfmcc31b0E/9yLj+Mi+8gjga
         vAIfqyu8SNYzdQGMq3SCEeE/rzHIem13/uLqZ1JR4T5tQjnkuzZi0BCV3IvuzEkLhbB0
         7+XlNKWoLyxMwA/iA0Y4dP1WyMIcUyrpAzwX6e48xsnrrZqMSRPbSsgiOZEjDQ/ZxB7U
         3bU0/4McdczG8ZB4/8bM2a0gdjhrhcoMoRScQf9WHhxEFAHcqGrSk2GmoUau67ORowG1
         DNZdjnWNTe+LrNYcisOsC1I0OX5YHPQb0371y2PZHJ5zWhxYmDgOoh+yUB86fakYFx8X
         p5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGz24VHu71dTyqr9h2vlpZ62ZRClBjcYJ9mD4gI36bkwTNF8hzGbrS37sBRkBHhYVnT1qfvz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9eofLammMVCQooVt//aJzMTqACeO8N+J80N2NPhEd2b6dX2TJ
	a6bgf1Tbd3CGu6CdNNAYkROJAE7FJ/OZkF2vZpBuZQKzpr1ql/DyfbxYPtFn/ePJ+xbsqi58GF0
	zFDLuQXt2u3twBlXh6W3WtOw+BYn5H8KSseKinC8=
X-Gm-Gg: ASbGncs2t0eMPV0u4px1DF0/eRdz2ri6pJ/SrFfCz8wtZE8y39qQ8KY7fi/SyrlZDod
	1zOexxBNmJ2ePgd/b/Lomx7SrMjwdsWCLGSybtOnr89LfQnGOlGIoIGhTaLrTz8UAtIw0ZhDI/q
	QKTnhV21yFTEIn/qWZKoyP3PFOs5KjB33g
X-Google-Smtp-Source: AGHT+IHnDtBdTCKlGyQTWCOGD4QKGgx9Ob2PygCAsN72FnLMoeDC8F/uutnBcq5gd/Cx2PUI3+eOqD6ZfCVxA+A1QQs=
X-Received: by 2002:a05:6902:18d6:b0:e7b:3358:5663 with SMTP id
 3f1490d57ef6-e7b6d6dbb03mr5536322276.35.1747428108492; Fri, 16 May 2025
 13:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515211606.2697271-1-ameryhung@gmail.com> <20250515211606.2697271-2-ameryhung@gmail.com>
 <CAADnVQLPyHnqEbPowpN+JuMwH+iMX4=dZZu2chMaiexwAVxxJA@mail.gmail.com>
In-Reply-To: <CAADnVQLPyHnqEbPowpN+JuMwH+iMX4=dZZu2chMaiexwAVxxJA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 16 May 2025 16:41:36 -0400
X-Gm-Features: AX0GCFtIClI9SbSnX1i6BhWh5W55HwGNSrH_Fpvo6TPLUk_-Ay5L7vuia7VEX_U
Message-ID: <CAMB2axPpAdhkc0wvHY6VEKjRKti_85MMPo2eJ07T2w+kgV3YjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 2:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 15, 2025 at 2:16=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
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
> > specific TLD in bpf 2) data is memory for storing TLDs specific to the
> > task.
> >
> > The following are the basic task local data API:
> >
> >                  User space               BPF
> > Create key     tld_create_key()            -
> > Fetch key            -               tld_fetch_key()
> > Get data       tld_get_data()        tld_get_data()
> >
> > A TLD is first created by the user space with tld_create_key(). First,
> > it goes through the metadata array to check if the TLD can be added.
> > The total TLD size needs to fit into a page (limited by UPTR), and no
> > two TLDs can have the same name. It also calculates the offset, the nex=
t
> > available space in u_tld_data, by summing sizes of TLDs. If the TLD
> > can be added, it increases the count using cmpxchg as there may be othe=
r
> > concurrent tld_create_key(). After a successful cmpxchg, the last
> > metadata slot now belongs to the calling thread and will be updated.
> > tld_create_key() returns the offset encapsulated as a opaque object key
> > to prevent user misuse.
> >
> > Then user space can pass the key to tld_get_data() to get a pointer
> > to the TLD. The pointer will remain valid for the lifetime of the
> > thread.
> >
> > BPF programs also locate TLDs with the keys. This is done by calling
> > tld_fetch_key() with the name of the TLD. Similar to tld_create_key(),
> > it scans through metadata array, compare the name of TLDs and compute
> > the offset. Once found, the offset is also returned as a key, which
> > can be passed to the bpf version of tld_get_data() to retrieve a
> > pointer to the TLD.
> >
> > User space task local data library uses a light way approach to ensure
> > thread safety (i.e., atomic operation + compiler and memory barriers).
> > While a metadata is being updated, other threads may also try to read i=
t.
> > To prevent them from seeing incomplete data, metadata::size is used to
> > signal the completion of the update, where 0 means the update is still
> > ongoing. Threads will wait until seeing a non-zero size to read a
> > metadata. Acquire/release order is required for metadata::size to
> > prevent hardware reordering. For example, moving store to metadata::nam=
e
> > after store to metadata::size or moving load from metadata::name before
> > load from metadata::size.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../bpf/prog_tests/task_local_data.h          | 263 ++++++++++++++++++
> >  .../selftests/bpf/progs/task_local_data.bpf.h | 220 +++++++++++++++
> >  2 files changed, 483 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_d=
ata.h
> >  create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.b=
pf.h
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b=
/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> > new file mode 100644
> > index 000000000000..ec43ea59267c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
> > @@ -0,0 +1,263 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __TASK_LOCAL_DATA_H
> > +#define __TASK_LOCAL_DATA_H
> > +
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <sched.h>
> > +#include <stddef.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <sys/syscall.h>
> > +#include <sys/types.h>
> > +
> > +#include <bpf/bpf.h>
> > +
> > +#ifndef PIDFD_THREAD
> > +#define PIDFD_THREAD O_EXCL
> > +#endif
> > +
> > +#define PAGE_SIZE 4096
> > +
> > +#ifndef __round_mask
> > +#define __round_mask(x, y) ((__typeof__(x))((y)-1))
> > +#endif
> > +#ifndef round_up
> > +#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
> > +#endif
> > +
> > +#ifndef READ_ONCE
> > +#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> > +#endif
> > +
> > +#ifndef WRITE_ONCE
> > +#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) =3D (val))
> > +#endif
> > +
> > +#define TLD_DATA_SIZE PAGE_SIZE
>
> wrap it with #ifndef ?
>
> So that application can #define something smaller.
>
> > +#define TLD_DATA_CNT 63
> > +#define TLD_NAME_LEN 62
> > +
> > +typedef struct {
> > +       __s16 off;
> > +} tld_key_t;
> > +
> > +struct tld_metadata {
> > +       char name[TLD_NAME_LEN];
> > +       __u16 size;
> > +};
> > +
> > +struct u_tld_metadata {
> > +       __u8 cnt;
> > +       __u8 padding[63];
> > +       struct tld_metadata metadata[TLD_DATA_CNT];
> > +};
> > +
> > +struct u_tld_data {
> > +       char data[TLD_DATA_SIZE];
> > +};
> > +
> > +struct tld_map_value {
> > +       struct u_tld_data *data;
> > +       struct u_tld_metadata *metadata;
> > +};
> > +
> > +struct u_tld_metadata *tld_metadata_p __attribute__((weak));
> > +__thread struct u_tld_data *tld_data_p __attribute__((weak));
> > +
> > +static int __tld_init_metadata(int map_fd)
> > +{
> > +       struct u_tld_metadata *new_metadata;
> > +       struct tld_map_value map_val;
> > +       int task_fd =3D 0, err;
> > +
> > +       task_fd =3D syscall(SYS_pidfd_open, getpid(), 0);
>
> this task_fd and task_fd in __tld_init_data() are two different things.
> Please name them differently.

I will rename them to tid_fd and pid_fd.

>
> > +       if (task_fd < 0) {
> > +               err =3D -errno;
> > +               goto out;
> > +       }
> > +
> > +       new_metadata =3D aligned_alloc(PAGE_SIZE, PAGE_SIZE);
> > +       if (!new_metadata) {
> > +               err =3D -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       memset(new_metadata, 0, PAGE_SIZE);
> > +
> > +       map_val.data =3D NULL;
> > +       map_val.metadata =3D new_metadata;
> > +
> > +       /*
> > +        * bpf_map_update_elem(.., pid_fd,..., BPF_NOEXIST) guarantees =
that
> > +        * only one tld_create_key() can update tld_metadata_p.
> > +        */
> > +       err =3D bpf_map_update_elem(map_fd, &task_fd, &map_val, BPF_NOE=
XIST);
> > +       if (err) {
> > +               free(new_metadata);
> > +               if (err =3D=3D -EEXIST || err =3D=3D -EAGAIN)
> > +                       err =3D 0;
> > +               goto out;
> > +       }
> > +
> > +       WRITE_ONCE(tld_metadata_p, new_metadata);
> > +out:
> > +       if (task_fd > 0)
>
> >=3D
>
> > +               close(task_fd);
> > +       return err;
> > +}
> > +
> > +static int __tld_init_data(int map_fd)
> > +{
> > +       struct u_tld_data *new_data =3D NULL;
> > +       struct tld_map_value map_val;
> > +       int err, task_fd =3D 0;
> > +
> > +       task_fd =3D syscall(SYS_pidfd_open, gettid(), PIDFD_THREAD);
> > +       if (task_fd < 0) {
> > +               err =3D -errno;
> > +               goto out;
> > +       }
> > +
> > +       new_data =3D aligned_alloc(PAGE_SIZE, TLD_DATA_SIZE);
>
> probably roundup_power_of_two(TLD_DATA_SIZE) ?
> Don't know about libc, but musl implementation of aligned_alloc()
> is naive. It allocs align+size.
> So it's a memory waste.
>

I will do roundup_power_of_two for the size in the next respin, and
also check libc implementation.

> > +       if (!new_data) {
> > +               err =3D -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       map_val.data =3D new_data;
> > +       map_val.metadata =3D READ_ONCE(tld_metadata_p);
> > +
> > +       err =3D bpf_map_update_elem(map_fd, &task_fd, &map_val, 0);
> > +       if (err) {
> > +               free(new_data);
> > +               goto out;
> > +       }
> > +
> > +       tld_data_p =3D new_data;
> > +out:
> > +       if (task_fd > 0)
>
> >=3D
>
> > +               close(task_fd);
> > +       return err;
> > +}
> > +
> > +/**
> > + * tld_create_key() - Create a key associated with a TLD.
> > + *
> > + * @map_fd: A file descriptor of the underlying task local storage map=
,
> > + * tld_data_map
> > + * @name: The name the TLD will be associated with
> > + * @size: Size of the TLD
> > + *
> > + * Returns an opaque object key. Use tld_key_is_err() or tld_key_err_o=
r_zero() to
> > + * check if the key creation succeed. Pass to tld_get_data() to get a =
pointer to
> > + * the TLD. bpf programs can also fetch the same key by name.
> > + */
> > +__attribute__((unused))
> > +static tld_key_t tld_create_key(int map_fd, const char *name, size_t s=
ize)
> > +{
> > +       int err, i, cnt, sz, off =3D 0;
> > +
> > +       if (!READ_ONCE(tld_metadata_p)) {
> > +               err =3D __tld_init_metadata(map_fd);
> > +               if (err)
> > +                       return (tld_key_t) {.off =3D err};
> > +       }
> > +
> > +       if (!tld_data_p) {
> > +               err =3D __tld_init_data(map_fd);
> > +               if (err)
> > +                       return (tld_key_t) {.off =3D err};
> > +       }
> > +
> > +       size =3D round_up(size, 8);
>
> why roundup ? and to 8 in particular?
> If user space wants byte size keys, why not let it?

I will remove it. This was to prevent breaking using TLD in atomic
operations, but it should be very unlikely as they are thread
specific.

>
> > +
> > +       for (i =3D 0; i < TLD_DATA_CNT; i++) {
> > +retry:
> > +               cnt =3D __atomic_load_n(&tld_metadata_p->cnt, __ATOMIC_=
RELAXED);
>
> Instead of explicit __atomic builtins use _Atomic __u8 cnt;
> ?
>

Got it. I will use builtins in stdatomic.h.

> > +               if (i < cnt) {
> > +                       /*
> > +                        * Pending tld_create_key() uses size to signal=
 if the metadata has
> > +                        * been fully updated.
> > +                        */
> > +                       while (!(sz =3D __atomic_load_n(&tld_metadata_p=
->metadata[i].size,
> > +                                                     __ATOMIC_ACQUIRE)=
))
> > +                               sched_yield();
> > +
> > +                       if (!strncmp(tld_metadata_p->metadata[i].name, =
name, TLD_NAME_LEN))
> > +                               return (tld_key_t) {.off =3D -EEXIST};
> > +
> > +                       off +=3D sz;
> > +                       continue;
> > +               }
> > +
> > +               if (off + size > TLD_DATA_SIZE)
> > +                       return (tld_key_t) {.off =3D -E2BIG};
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
> > +               if (!__atomic_compare_exchange_n(&tld_metadata_p->cnt, =
&cnt, cnt + 1, true,
> > +                                                __ATOMIC_RELAXED, __AT=
OMIC_RELAXED))
>
> weak and relaxed/relaxed ?

I can't see reordering issue with cnt so I choose to use relax. I can
change to strong acq/rel just to be safe.

> That's unusual.
> I don't know what it is supposed to do.
> I think weak=3Dfalse and __ATOMIC_ACQUIRE, __ATOMIC_RELAXED
> would look as expected.
>

Do you mean weak=3Dfalse and __ATOMIC_RELAXED, __ATOMIC_ACQUIRE?


> > +                       goto retry;
> > +
> > +               strncpy(tld_metadata_p->metadata[i].name, name, TLD_NAM=
E_LEN);
> > +               __atomic_store_n(&tld_metadata_p->metadata[i].size, siz=
e, __ATOMIC_RELEASE);
> > +               return (tld_key_t) {.off =3D off};
> > +       }
> > +
> > +       return (tld_key_t) {.off =3D -ENOSPC};
> > +}
> > +
> > +__attribute__((unused))
> > +static inline bool tld_key_is_err(tld_key_t key)
> > +{
> > +       return key.off < 0;
> > +}
> > +
> > +__attribute__((unused))
> > +static inline int tld_key_err_or_zero(tld_key_t key)
> > +{
> > +       return tld_key_is_err(key) ? key.off : 0;
> > +}
> > +
> > +/**
> > + * tld_get_data() - Gets a pointer to the TLD associated with the key.
> > + *
> > + * @map_fd: A file descriptor of the underlying task local storage map=
,
> > + * tld_data_map
> > + * @key: A key object returned by tld_create_key().
> > + *
> > + * Returns a pointer to the TLD if the key is valid; NULL if no key ha=
s been
> > + * added, not enough memory for TLD for this thread, or the key is inv=
alid.
> > + *
> > + * Threads that call tld_get_data() must call tld_free() on exit to pr=
event
> > + * memory leak.
> > + */
> > +__attribute__((unused))
> > +static void *tld_get_data(int map_fd, tld_key_t key)
> > +{
> > +       if (!READ_ONCE(tld_metadata_p))
> > +               return NULL;
> > +
> > +       if (!tld_data_p && __tld_init_data(map_fd))
> > +               return NULL;
>
> Why call it again?
> tld_create_key() should have done it, no?
>

A TLD is created by calling tld_create_key() once. Then, threads may
call tld_get_data() to get their thread-specific TLD. So it is
possible for a thread to call tld_get_data() with tld_data_p=3D=3DNULL.

> > +
> > +       return tld_data_p->data + key.off;
> > +}
> > +
> > +/**
> > + * tld_free() - Frees task local data memory of the calling thread
> > + */
> > +__attribute__((unused))
> > +static void tld_free(void)
> > +{
> > +       if (tld_data_p)
> > +               free(tld_data_p);
> > +}
>
> Since this .h allocates tld_metadata_p, it probably needs
> a helper to free it too.
>
> > +
> > +#endif /* __TASK_LOCAL_DATA_H */
> > diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/=
tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> > new file mode 100644
> > index 000000000000..5f48e408a5e5
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> > @@ -0,0 +1,220 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __TASK_LOCAL_DATA_BPF_H
> > +#define __TASK_LOCAL_DATA_BPF_H
> > +
> > +/*
> > + * Task local data is a library that facilitates sharing per-task data
> > + * between user space and bpf programs.
> > + *
> > + *
> > + * PREREQUISITE
> > + *
> > + * A TLD, an entry of data in task local data, first needs to be creat=
ed by the
> > + * user space. This is done by calling user space API, tld_create_key(=
), with
> > + * the name of the TLD and the size.
> > + *
> > + *     tld_key_t prio, in_cs;
> > + *
> > + *     prio =3D tld_create_key("priority", sizeof(int));
> > + *     in_cs =3D tld_create_key("in_critical_section", sizeof(bool));
> > + *
> > + * A key associated with the TLD, which has an opaque type tld_key_t, =
will be
> > + * returned. It can be used to get a pointer to the TLD in the user sp=
ace by
> > + * calling tld_get_data().
> > + *
> > + *
> > + * USAGE
> > + *
> > + * Similar to user space, bpf programs locate a TLD using the same key=
.
> > + * tld_fetch_key() allows bpf programs to retrieve a key created in th=
e user
> > + * space by name, which is specified in the second argument of tld_cre=
ate_key().
> > + * tld_fetch_key() additionally will cache the key in a task local sto=
rage map,
> > + * tld_key_map, to avoid performing costly string comparisons every ti=
me when
> > + * accessing a TLD. This requires the developer to define the map valu=
e type of
> > + * tld_key_map, struct tld_keys. It only needs to contain keys used by=
 bpf
> > + * programs in the compilation unit.
> > + *
> > + * struct tld_keys {
> > + *     tld_key_t prio;
> > + *     tld_key_t in_cs;
> > + * };
> > + *
> > + * Then, for every new task, a bpf program will fetch and cache keys o=
nce and
> > + * for all. This should be done ideally in a non-critical path (e.g., =
in
> > + * sched_ext_ops::init_task).
> > + *
> > + *     struct tld_object tld_obj;
> > + *
> > + *     err =3D tld_object_init(task, &tld);
> > + *     if (err)
> > + *         return 0;
> > + *
> > + *     tld_fetch_key(&tld_obj, "priority", prio);
> > + *     tld_fetch_key(&tld_obj, "in_critical_section", in_cs);
> > + *
> > + * Note that, the first argument of tld_fetch_key() is a pointer to tl=
d_object.
> > + * It should be declared as a stack variable and initialized via tld_o=
bject_init().
> > + *
> > + * Finally, just like user space programs, bpf programs can get a poin=
ter to a
> > + * TLD by calling tld_get_data(), with cached keys.
> > + *
> > + *     int *p;
> > + *
> > + *     p =3D tld_get_data(&tld_obj, prio, sizeof(int));
> > + *     if (p)
> > + *         // do something depending on *p
> > + */
> > +#include <errno.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +#define TLD_DATA_SIZE __PAGE_SIZE
> > +#define TLD_DATA_CNT 63
> > +#define TLD_NAME_LEN 62
> > +
> > +typedef struct {
> > +       __s16 off;
> > +} tld_key_t;
> > +
> > +struct u_tld_data *dummy_data;
> > +struct u_tld_metadata *dummy_metadata;
> > +
> > +struct tld_metadata {
> > +       char name[TLD_NAME_LEN];
> > +       __u16 size;
> > +};
> > +
> > +struct u_tld_metadata {
> > +       __u8 cnt;
> > +       __u8 padding[63];
> > +       struct tld_metadata metadata[TLD_DATA_CNT];
> > +};
> > +
> > +struct u_tld_data {
> > +       char data[TLD_DATA_SIZE];
> > +};
> > +
> > +struct tld_map_value {
> > +       struct u_tld_data __uptr *data;
> > +       struct u_tld_metadata __uptr *metadata;
> > +};
> > +
> > +struct tld_object {
> > +       struct tld_map_value *data_map;
> > +       struct tld_keys *key_map;
> > +};
> > +
> > +/*
> > + * Map value of tld_key_map for caching keys. Must be defined by the d=
eveloper.
> > + * Members should be tld_key_t and passed to the 3rd argument of tld_f=
etch_key().
> > + */
> > +struct tld_keys;
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > +       __uint(map_flags, BPF_F_NO_PREALLOC);
> > +       __type(key, int);
> > +       __type(value, struct tld_map_value);
> > +} tld_data_map SEC(".maps");
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > +       __uint(map_flags, BPF_F_NO_PREALLOC);
> > +       __type(key, int);
> > +       __type(value, struct tld_keys);
> > +} tld_key_map SEC(".maps");
> > +
> > +/**
> > + * tld_object_init() - Initializes a tld_object.
> > + *
> > + * @task: The task_struct of the target task
> > + * @tld_obj: A pointer to a tld_object to be initialized
> > + *
> > + * Returns 0 on success; -ENODATA if the task has no TLD; -ENOMEM if t=
he creation
> > + * of tld_key_map fails
> > + */
> > +__attribute__((unused))
> > +static int tld_object_init(struct task_struct *task, struct tld_object=
 *tld_obj)
> > +{
> > +       tld_obj->data_map =3D bpf_task_storage_get(&tld_data_map, task,=
 0, 0);
> > +       if (!tld_obj->data_map)
> > +               return -ENODATA;
> > +
> > +       tld_obj->key_map =3D bpf_task_storage_get(&tld_key_map, task, 0=
,
> > +                                               BPF_LOCAL_STORAGE_GET_F=
_CREATE);
> > +       if (!tld_obj->key_map)
> > +               return -ENOMEM;
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * tld_fetch_key() - Fetches the key to a TLD by name. The key has to =
be created
> > + * by user space first with tld_create_key().
> > + *
> > + * @tld_obj: A pointer to a valid tld_object initialized by tld_object=
_init()
> > + * @name: The name of the key associated with a TLD
> > + * @key: The key in struct tld_keys to be saved to
> > + *
> > + * Returns a positive integer on success; 0 otherwise
> > + */
> > +#define tld_fetch_key(tld_obj, name, key)                             =
         \
> > +       ({                                                             =
         \
> > +               (tld_obj)->key_map->key.off =3D __tld_fetch_key(tld_obj=
, name);   \
> > +       })
> > +
> > +__attribute__((unused))
> > +static u16 __tld_fetch_key(struct tld_object *tld_obj, const char *nam=
e)
> > +{
> > +       int i, meta_off, cnt;
> > +       void *metadata, *nm, *sz;
> > +       u16 off =3D 0;
> > +
> > +       if (!tld_obj->data_map || !tld_obj->data_map->metadata)
> > +               return 0;
> > +
> > +       cnt =3D tld_obj->data_map->metadata->cnt;
> > +       metadata =3D tld_obj->data_map->metadata->metadata;
> > +
> > +       bpf_for(i, 0, cnt) {
> > +               meta_off =3D i * sizeof(struct tld_metadata);
> > +               if (meta_off > TLD_DATA_SIZE - offsetof(struct u_tld_me=
tadata, metadata)
> > +                                          - sizeof(struct tld_metadata=
))
> > +                       break;
> > +
> > +               nm =3D metadata + meta_off + offsetof(struct tld_metada=
ta, name);
> > +               sz =3D metadata + meta_off + offsetof(struct tld_metada=
ta, size);
> > +
> > +               /*
> > +                * Reserve 0 for uninitialized keys. Increase the offse=
t of a valid key
> > +                * by one and subtract it later in tld_get_data().
> > +                */
> > +               if (!bpf_strncmp(nm, TLD_NAME_LEN, name))
> > +                       return off + 1;
>
> I think all this +1, -1 dance is doing is helping to catch an
> error when tld_get_data() is called without tld_fetch_key().
> I feel this is too defensive.
>
> Let tld_fetch_key() return proper negative error code.
>

I can certainly return negative error code.

But for the +1, -1 logic, I think is a simpler way to differentiate an
uninitialized key in tld_key_map from the first TLD (both key.off =3D=3D
0). After all, bpf programs can call tld_get_data() without
tld_fetch_key().

> > +
> > +               off +=3D *(u16 *)sz;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * tld_get_data() - Retrieves a pointer to the TLD associated with the=
 key.
> > + *
> > + * @tld_obj: A pointer to a valid tld_object initialized by tld_object=
_init()
> > + * @key: The key of a TLD saved in tld_maps
> > + * @size: The size of the TLD. Must be a known constant value
> > + *
> > + * Returns a pointer to the TLD data associated with the key; NULL if =
the key
> > + * is not valid or the size is too big
> > + */
> > +#define tld_get_data(tld_obj, key, size) \
> > +       __tld_get_data(tld_obj, (tld_obj)->key_map->key.off - 1, size)
> > +
> > +__attribute__((unused))
> > +__always_inline void *__tld_get_data(struct tld_object *tld_obj, u32 o=
ff, u32 size)
> > +{
> > +       return (tld_obj->data_map->data && off >=3D 0 && off < TLD_DATA=
_SIZE - size) ?
> > +               (void *)tld_obj->data_map->data + off : NULL;
>
> If we require users to call tld_fetch_key() first and check for errors
> tld_get_data() can be faster:
> #define tld_get_data(tld_obj, key)
>    (void *)tld_obj->data_map->data + tld_obj->key_map->key.off
>

tld_get_data() can be called in a bpf program without tld_fetch_key(),
so checking tld_obj->data_map->data is needed as the first load from
tld_obj->data_map->data yields a "mem_or_null".

I did try to save this uptr "mem" after null check to stack (e.g., in
a tld_object) so that we can save subsequent checks. However, the
compiler sometime will do a fresh load from map_ptr when reading
tld_obj->data_map->data. Might need some work or trick to make it
happen.

> I wouldn't bother with extra checks, especially for size.
>

It needs to be bound-checked. If tld_get_data() doesn't do it, bpf
programs have to do it before acceess. Otherwise:

; return (tld_obj->data_map->data && off >=3D 0) ? @ task_local_data.bpf.h:=
218
25: (bf) r3 =3D r1                      ; R1_w=3Dmem(sz=3D4096) R3_w=3Dmem(=
sz=3D4096)
26: (0f) r3 +=3D r2                     ;
R2_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D0xffff7fff,smax32=
=3D32766,var_off=3D(0x0;
0xffffffff)) R3_w=3Dmem(sz=3D4096,smin=3D0,smax=3Dumax=3D0xffffffff,var_off=
=3D(0x0;
0xfffffff)
; test_value1 =3D *int_p; @ test_task_local_data.c:63
27: (61) r2 =3D *(u32 *)(r3 +0)
R3 unbounded memory access, make sure to bounds check any such access

> Bigger question.. can we cache the whole pointer for each key ?
> and then
> #define tld_get_data(tld_obj, key) ld_obj->key_map->key

Maybe define the member type of tld_key_map as __uptr and allow bpf
programs to update a uptr field with a valid uptr?

