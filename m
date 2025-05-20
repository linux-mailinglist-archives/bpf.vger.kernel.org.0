Return-Path: <bpf+bounces-58622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8FABE7D0
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 00:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2760189E201
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 22:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09376261595;
	Tue, 20 May 2025 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQnyuq7X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1E256C87;
	Tue, 20 May 2025 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781888; cv=none; b=YjHWcZ+eg11cXy0WTgPwTQrtFUwUzCuvUhjMV5kcsOK9nK2h57vszs5/ZMy6vgv+gvSw8Wo6BpMYPH0hWM4C8OSMQ6obC/t3+XwRD0+gsbURrboH7ICB7t2WfNqbXtArUQzy8YD59ZA37ynfHBvnrUqyj6toXjflaWfhyWOwpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781888; c=relaxed/simple;
	bh=XzP+5m8xk7x4MZInL/NoPP5CSicxVSHLbn5F0aobsYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKuHKk/uWNXz9bQtRkwL+Gnuxkop2QU3x09aDCuKpAmOA5pRpX4R/Wh19Ug2Bn1k6y4C8PYNeFaJmovc+d5T8Y/BN6uWcHXynyTv70qt4VzL/fo5WGpGDZFWcBr2TlvrGuPIhlqKjCj4GxBCUXhCUoPG2VCLG4uVtBnE7DpVGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQnyuq7X; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b27015122c4so2344058a12.3;
        Tue, 20 May 2025 15:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781886; x=1748386686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdn4FYNKA18XjnYt/yhap27E578M25o0Nh0WoDRkv2U=;
        b=jQnyuq7XTaIRFQyCP0WkijISgTjBm6tNLllurzUodULSiD23PApzcxwlEP1anyo0Qf
         npB9wF4gRmU3jsDBkDC0y/prl1D03vDUKy32hvRH1aKRdXwB7WW4M1b844WGkFZWzySp
         1jvQ04lF61L+Tt51TAntT+P3CP/5X2XicmVcE1yzARPntwmo/CsGb0mhuKn8hi1RZh+3
         LcLISkvDvsvU718WKf+YMoPPcthsvSdNq1atqNdDIfn12wJ9txPhKU4/AYeVYIlGwl1L
         yF3CyYf6GSpF7U3ufQ2dMVzMTVI+ttqK7NwYzGPZM0AWPvoxASnZ8Ew7/Hxs2G1rOxnf
         TwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781886; x=1748386686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdn4FYNKA18XjnYt/yhap27E578M25o0Nh0WoDRkv2U=;
        b=OHtiWUJUikka8b4iNKY835W5yrnJx5miXnW29gepB4hgc1mQY+AfPABihdgZ9vXikD
         PAOkcazwFbvaDLsdueO4K+6uIGAymPnHIXV6NLkTaryUAppbCb541qmSGV8W3nGkm34c
         IF1Oy+HU5xeCEMrUDJrQKB8e+70q6gXM3T0xBHwLhTfadHm9liqhLladoOyksIZqqUuq
         A/ZDyziXKBEDc6VBNrF1LIBIJGuRgw9korMhOsb04NvRgd8/18MrJO6O0xP2eelEaEhE
         hG1VCtYqcODuzK310lAY386OBZJytODkQ/K8+j9QerQ/f9FRtAD8L1xwKRvtYWd9dAg2
         91vg==
X-Forwarded-Encrypted: i=1; AJvYcCXnhrRDD7t8RC87yH0rgAgLkmiZ9D2msV6QKJdqHZpGQqIeOSVNvsXGNU+IOQicdy+8uTfkBB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUuF14HWZwsPLk0OBmJ0ctvD4HaPaYxO7qm+cPhZu8oFVO607
	Ypqs0Y48L0JxOjxn3LhUe1tInbOo2ETQ9Nf01wHYo8O/4IzW/gyFm9t7BcMDKZP3an3fflKo848
	7xN/7zyGBOOjfLopYp9W5nd2tkqqzwCZd8+VN7Go=
X-Gm-Gg: ASbGnctI7QfcaH2i1Wh2cTZJYoXdvZHW0ko2pRxfB6IAvn7gliQyfBF29Qrs1xjcEyO
	nxvT0TxRimSaQY7K16NsJiKOF/nria2O7tNO4XtPpwQeERXpO6V8QSA3ump3wjF20zDf58Pf5Nm
	dw2xkUk4bNpTGaYCh7LH26g37fVCWMrKCy/1swhBqZglJXVUMI
X-Google-Smtp-Source: AGHT+IF5uZAV08xeVVbyLfE6q9m3onoLj6Y1YDWKj4eG2dqoC/ghI+/QcOPCtZ6ZVhDsPUQ/CywFVKCdIqxjGsEiRgw=
X-Received: by 2002:a17:90b:2f08:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-30e7d52b830mr25307381a91.13.1747781885885; Tue, 20 May 2025
 15:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515211606.2697271-1-ameryhung@gmail.com> <20250515211606.2697271-2-ameryhung@gmail.com>
In-Reply-To: <20250515211606.2697271-2-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 May 2025 15:57:53 -0700
X-Gm-Features: AX0GCFuT6voIrcNryQA9oEFujslkbIhzVqoEntd8g32sC_bW4dRA4YFAOqyR0nk
Message-ID: <CAEf4BzZp4BKBaw=j1o9+mPv_EG0VWM5WGoG-ddxe7Fv1OXjP3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
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

this is a lot of pollution of user applications with generic names...
consider TLD_ prefixing all of them?

> +
> +#define TLD_DATA_SIZE PAGE_SIZE
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

[...]

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

task_fd can be zero, so >=3D 0 and init to -1; same in init_metadata

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

typo: succeeded

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

I'd record actual requested size, but internally round up to 8 where
necessary (see below)

> +
> +       for (i =3D 0; i < TLD_DATA_CNT; i++) {
> +retry:
> +               cnt =3D __atomic_load_n(&tld_metadata_p->cnt, __ATOMIC_RE=
LAXED);
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

do you check mismatched size for the same key? if not, should it be checked=
?

but if name and size matches, shouldn't this be a success instead of
-EEXIST error?...


> +
> +                       off +=3D sz;

you should probably specify alignment guarantees explicitly and round
that up somewhere here, so that if you allocate bool and then u64, u64
is properly 8 byte aligned and internally you know that the size was 1
and 8? With BPF ringbuf we guarantee 8 byte alignment, and so far it
worked out great, so I'd just document 8 and go with that.

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

[...]

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

tld_obj?

> + *     if (err)
> + *         return 0;
> + *
> + *     tld_fetch_key(&tld_obj, "priority", prio);
> + *     tld_fetch_key(&tld_obj, "in_critical_section", in_cs);
> + *

[...]

