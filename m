Return-Path: <bpf+bounces-58742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5A8AC1216
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27849E58C5
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46E7198E6F;
	Thu, 22 May 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXEC2chm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEE191F89;
	Thu, 22 May 2025 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934865; cv=none; b=igDzuU7oacrhqGqaZYnjab1p8SniApQMHvQfodOpik1MITIR1+APZgO5hIbxClsEZ44msvGEzpd8nGcIsEEPL56rxZzexkS10ZsAknQ2O54TC7D3h40VlUNk6JwlpQwNycU0QRIAOD6h45G317gRoG7FaWgZ7uEJ0KkV3iBe9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934865; c=relaxed/simple;
	bh=8M+vsbAnWHZbs6ctWGuja8i5Gmbw6mn8b8DkMQg2w+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRL1bAvfp0gX2aYuPpRuKpSKcf8SyVpmWG5Y+9DVt5IS2kBMYa0I6vM6zD0B29gK76KgTBhpe38g+PqrmIUviWOGcgmri/bUZd2KqZaAdMkBMjnmJ9PpLOiaNwNgJF5fuY6miIoHyfchpDCNTp7XoynRiDtgLEdd/AYi5j2irQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXEC2chm; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7d5f3e6169so1947066276.3;
        Thu, 22 May 2025 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747934861; x=1748539661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJjqfm0wmq5HhNp0hjdzV0SAIZAvsS604ZIDl8zR8hY=;
        b=KXEC2chmlcnyQghe17qoEdbrcLnYkmyWOnnlyxo4sIl6tQWByn6YuUixiaAMl+3Qii
         RgFvN0Zn0T7dP8TDqlDAqf/h9CV0k3MAiJgHtrltHxvhbaMVZ+2B2tFNYdfK45qMsdco
         RnPh4ew2jPOAuzif6gNSh4iS+MUnYfXWXw4x8QiqRDNi38FHu3JRpKO8oLdvgwX3Bzyr
         gxqSzl048XCtWdRATvEIipOdQBmJ98L3Tqt5tq8LwVQ5PhPazVbJ240TeRbGH9r9Rd62
         kXbr1MFE5k2gt46zw2dWwS/JhtaWBaCgEzNep822HLoFjbEOXMJh7bcdfGaPQU/KTwPI
         XSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747934861; x=1748539661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJjqfm0wmq5HhNp0hjdzV0SAIZAvsS604ZIDl8zR8hY=;
        b=ZZeHD3W0NPNjmLScQrrYZJjslRD/HBahV4ieejn/T6dM9VEThxdNeD4h4G0iFO7TJl
         AfMNcNyyi3QAOdiVDBwwZaCAYJokGP1cEtlw3q8waAmXNjq97mN3DPvOT4Rg1t3MXw66
         5kjplntf9pFLztdgGMQrvPQ/LSorf3XvJRysPCpt1Iee5rhBGEcgewM1i70aRVnQmDyD
         nG/KS8LnVu0zNiKzhG2t3NXpIrS68I7CvTXeusso59sMGdf6RX5wKTLjExBfWascVKkJ
         CTvEx/Lb1nRVH+EIRUzrU7o671tNRVzHZS6RL7wKa3qTGuJf2JgTiJFthhvefT/M8Sm4
         LJKA==
X-Forwarded-Encrypted: i=1; AJvYcCUqpIdrOsMoz4yWrPSxsTxWg1pLc/RQUu36RvbfyAVQrdn+63Wtn3cwEjr9hlxcEzBNaUP6i8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx67dcKQPPgzZjAx2/pX5AQ603bYwEWxNxt8+InG+zcr5nucx1z
	DLibWrhUeKpZeoVpA2pyt6cmZjvh5HsheONQMQFYJ7QPH4ZpIZy58/xCHDSfArAkPtG4M+HUlTt
	pWWCjyLNmkB+IAINKZP03VKuXDm9lgEU=
X-Gm-Gg: ASbGnct0rOM2UddkTc32YTYt3QJJfq+a8pFu1xhZv5LoohPz6whIDkExXLHJTzhS0TM
	vxy0Uap1DOBpINnTo37q8zYqo105Z1bhIQMUbOv8667GT4qiOxOm6LN7JC79CRZHMvzDQitdaDV
	3MRG0o+6GyyD0cwCDxZmknHX8T3VkSgboHU99d/U+qoRV3RSs=
X-Google-Smtp-Source: AGHT+IFAO8LJ5LcZ2JHrnBG+tHKEap6/iQ/EwGMx9iyX7hZvZVRTn4AhEQwmy5B9gWrEdDfzFsAIgbeYL4hjgYGbmkg=
X-Received: by 2002:a05:6902:2b12:b0:e7d:783b:5bc1 with SMTP id
 3f1490d57ef6-e7d783b5c47mr2423740276.6.1747934861073; Thu, 22 May 2025
 10:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515211606.2697271-1-ameryhung@gmail.com> <20250515211606.2697271-2-ameryhung@gmail.com>
 <CAEf4BzZp4BKBaw=j1o9+mPv_EG0VWM5WGoG-ddxe7Fv1OXjP3A@mail.gmail.com>
In-Reply-To: <CAEf4BzZp4BKBaw=j1o9+mPv_EG0VWM5WGoG-ddxe7Fv1OXjP3A@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 22 May 2025 10:27:30 -0700
X-Gm-Features: AX0GCFthxzWfAHpIDZNLFNGByWZIe7_GQrU2hmAdin7mMjpZMvvtzWdarkTVe38
Message-ID: <CAMB2axNNpCRje=cAChkg=jE1NrPmkvU_Q54jxJWKDfQxOVXoGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 3:58=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
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
>
> this is a lot of pollution of user applications with generic names...
> consider TLD_ prefixing all of them?
>

I will make the name more specific by adding TLD_ prefix.

> > +
> > +#define TLD_DATA_SIZE PAGE_SIZE
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
>
> [...]
>
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
> task_fd can be zero, so >=3D 0 and init to -1; same in init_metadata

Yeah. I will fix this in the next respin.

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
>
> typo: succeeded

Will fix the typo. Thanks

>
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
> I'd record actual requested size, but internally round up to 8 where
> necessary (see below)
>
> > +
> > +       for (i =3D 0; i < TLD_DATA_CNT; i++) {
> > +retry:
> > +               cnt =3D __atomic_load_n(&tld_metadata_p->cnt, __ATOMIC_=
RELAXED);
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
>
> do you check mismatched size for the same key? if not, should it be check=
ed?
>
> but if name and size matches, shouldn't this be a success instead of
> -EEXIST error?...
>

I think users should only call tld_create_key() once for a TLD.
Returning an -EEXIST gives us a way to detect conflict. If users knows
that they will be calling tld_create_key() for a TLD in multiple
places, they could still do it by treating -EEXIST as success.

Therefore, no checking mismatching size here.

>
> > +
> > +                       off +=3D sz;
>
> you should probably specify alignment guarantees explicitly and round
> that up somewhere here, so that if you allocate bool and then u64, u64
> is properly 8 byte aligned and internally you know that the size was 1
> and 8? With BPF ringbuf we guarantee 8 byte alignment, and so far it
> worked out great, so I'd just document 8 and go with that.
>

Thanks for the suggestion. I will document the alignment guarantee.

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
>
> [...]
>
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
>
> tld_obj?

Will fix the typo

>
> > + *     if (err)
> > + *         return 0;
> > + *
> > + *     tld_fetch_key(&tld_obj, "priority", prio);
> > + *     tld_fetch_key(&tld_obj, "in_critical_section", in_cs);
> > + *
>
> [...]

