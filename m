Return-Path: <bpf+bounces-58530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F25ABD08B
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0193B16C3
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01B25DAE7;
	Tue, 20 May 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9q6Dcy3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A725D1E9;
	Tue, 20 May 2025 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747726622; cv=none; b=luu2dOHZ+UvYcJRTjb5K6EypyVU74G+UmNuQaSaOz+i/qW2mZOJ0nd1ptyy8+/at6VLuObtap0J+DQS+enLaRhXj1Xbqdf5hhhQqDOYbC044zDgYABf18fZukDhehgsVAPU0bzRHjcd8ZW4fmDEEPglg37fIapy2yNKNWXkMBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747726622; c=relaxed/simple;
	bh=NHEBjn3h4n4DDTnu1IB9lEeYt+RuzF4s5EKTPXHWsNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/j2Q3h+Dt+eGfaz8b9To5X9GALZvnOEu8BxFAoNqgrfLWZBCVpoE9O60+U0DFtkR+ollyKRKGjHmVvcIz/GSY4vi6HmYBYRJ3nBh/e6eFx5ZX67RNd4J4Jf/h8dSDbzJ8U/9ZEA829f3IGTtTt+Xngc9oWBynNQTWf9+NsLbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9q6Dcy3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7b85f1cbacso2974466276.3;
        Tue, 20 May 2025 00:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747726619; x=1748331419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SCyZPpdq+wFhX3tRG5eLVn/Oqz1YknXLKihKSrQHhY=;
        b=X9q6Dcy3kBfyAJDwLq4EynFkfavWERYoVQjI9XMbya55O4Kdnw0RHzo5s3QTDidllb
         bvCuAd1r6LxryUn24LzOGk05FgGveV4taD7i1b3rzXTEOfK7gcwmkKix9w7rebzZBcok
         vLB26NKP2bsUXN11ayYMgcut/EAcMhg+x0o7cb6g08nrdOmw3NStFKi3GmTIk7EebvQ1
         1YJSvE94sX+4u9f9orIA2q+ZYmg2mGGGdMIqJKnauzTtuX8jaB157TZHjiDW+EZ8slrj
         y2uF/8LPcSC2XHRWdWXV5grhk5jn2Tg/ml3KZWH7VB7ZCZYrZZw/dU+OwUlyEYOHqp0F
         42Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747726619; x=1748331419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SCyZPpdq+wFhX3tRG5eLVn/Oqz1YknXLKihKSrQHhY=;
        b=d3IKbq9QMbeR8/yNJAnfga+tn6mztIZCtX49MDXP+PDiZOtjI54XTKqrPPiYXNFb+j
         Co1ywmAiyP4neQy1ZrPxk06wBUoiNmNhi4iGpaySbI0YcjsrVxgKINUAWRfCbZv9WfBR
         JXLAa2SMXOTj4RsFQ404SY+fDdikMUWSSbyzhG81ZRnk3CgSHReG6lCDS9xRZ1qvClZI
         JETaBZXlCchp3kikcMZ0FTuOANUzp6syU+7FmmGjlnIPjq+gS7UsfB/bzjjBox7kbHFf
         ShJLTT04HIsZwRa8ZWk4XfNE2W6BCien6WVV2aXeTR9VDxfNZHObTbow7hoFV3scMBtE
         1FfA==
X-Forwarded-Encrypted: i=1; AJvYcCUDxDIL8v6SGim1Cu5c6PndeUfv5sG3qwmdN1XVb45wgWJOS0HveQNQp+YkBkIXqHpPHERj2Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJ1WOGkf74U/d2mq/WFT2NGolOcjNuTx3GG4f+YFf4S5Inzlk
	GAE/DHtzWH/UxS4pkAAF+JdM/442MAoxsYyPYPKIDhlJ50glJwOe9fxdpghEeC4M401ZUly5sKy
	29hVzlMLCkFHWi3UDnmBVVukI6FXbobk=
X-Gm-Gg: ASbGncs3nDYEFe7r5RJfwnsbX+muoam0jN6ixw1cigJ/lmo3ua2VxCmyglJ7jVCh2r8
	qi7Zmu+pxnALPHQwICj7MR0U08JWcOL5fIpdlWfm+ybfeeLg7UJmVVXBByQp/EF+my4gt+xojUN
	KKOPtXoOqrCk5HWc4rqJrMgNkjd/TN5M8s
X-Google-Smtp-Source: AGHT+IHpFZyhoOeFwU0XXlxiMSB22oyBAxWPYydzOI6GcVJ8Nctm9/dzNA50oaXKuVjdwe+BoUsaKkC8tMd1CmuqP2Y=
X-Received: by 2002:a05:6902:32a3:b0:e7b:826f:6365 with SMTP id
 3f1490d57ef6-e7b826f6bacmr14302130276.27.1747726619313; Tue, 20 May 2025
 00:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515211606.2697271-1-ameryhung@gmail.com> <20250515211606.2697271-2-ameryhung@gmail.com>
 <CAADnVQLPyHnqEbPowpN+JuMwH+iMX4=dZZu2chMaiexwAVxxJA@mail.gmail.com>
 <CAMB2axPpAdhkc0wvHY6VEKjRKti_85MMPo2eJ07T2w+kgV3YjQ@mail.gmail.com> <CAADnVQK30M9+eJz8OjFpteGXfpF6DoQqNxXJa3p5YGmxyG7xJw@mail.gmail.com>
In-Reply-To: <CAADnVQK30M9+eJz8OjFpteGXfpF6DoQqNxXJa3p5YGmxyG7xJw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 20 May 2025 00:36:48 -0700
X-Gm-Features: AX0GCFtQvV8nvezGhac_rpM7y3xPhKm-3wchTOdM_-btYKDgJYAUukGsVWf9dT4
Message-ID: <CAMB2axOdJPakK3=vNXYXoUUji3wfO-HT5j1j3ox3Z=QKK6=X3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 3:22=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 16, 2025 at 1:41=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > > > +       size =3D round_up(size, 8);
> > >
> > > why roundup ? and to 8 in particular?
> > > If user space wants byte size keys, why not let it?
> >
> > I will remove it. This was to prevent breaking using TLD in atomic
> > operations, but it should be very unlikely as they are thread
> > specific.
>
> You mean for a case where one part of the app (like a shared library)
> is using u32, but the other is using u64 and doing atomic ops on it?
>
> Make sense to align the off set by tld_create_key(),
> but it can be done without rounding up all previous keys to 8.
> 63 bytes in the header are wasted. So use 2 as an offset.
> A single cmpxchg 4 byte can update cnt+offset.
> Actually why store size in each tld_metadata ?
> Won't the logic will be simpler if it's an offset ?
> bpf side tld_fetch_key() wouldn't need to count.
>

I changed to size since metadata is initialized to 0 and size =3D=3D 0 can
be used to signal pending metadata update, while 0 is a valid offset.

I will save offset in metadata in the next respin. Tejun suggested a
run-length key encoding, and there are other fields in the metadata
that can be used for the signaling.

> > > > +               if (i < cnt) {
> > > > +                       /*
> > > > +                        * Pending tld_create_key() uses size to si=
gnal if the metadata has
> > > > +                        * been fully updated.
> > > > +                        */
> > > > +                       while (!(sz =3D __atomic_load_n(&tld_metada=
ta_p->metadata[i].size,
> > > > +                                                     __ATOMIC_ACQU=
IRE)))
> > > > +                               sched_yield();
> > > > +
> > > > +                       if (!strncmp(tld_metadata_p->metadata[i].na=
me, name, TLD_NAME_LEN))
> > > > +                               return (tld_key_t) {.off =3D -EEXIS=
T};
> > > > +
> > > > +                       off +=3D sz;
> > > > +                       continue;
> > > > +               }
> > > > +
> > > > +               if (off + size > TLD_DATA_SIZE)
> > > > +                       return (tld_key_t) {.off =3D -E2BIG};
> > > > +
> > > > +               /*
> > > > +                * Only one tld_create_key() can increase the curre=
nt cnt by one and
> > > > +                * takes the latest available slot. Other threads w=
ill check again if a new
> > > > +                * TLD can still be added, and then compete for the=
 new slot after the
> > > > +                * succeeding thread update the size.
> > > > +                */
> > > > +               if (!__atomic_compare_exchange_n(&tld_metadata_p->c=
nt, &cnt, cnt + 1, true,
> > > > +                                                __ATOMIC_RELAXED, =
__ATOMIC_RELAXED))
> > >
> > > weak and relaxed/relaxed ?
> >
> > I can't see reordering issue with cnt so I choose to use relax. I can
> > change to strong acq/rel just to be safe.
> >
> > > That's unusual.
> > > I don't know what it is supposed to do.
> > > I think weak=3Dfalse and __ATOMIC_ACQUIRE, __ATOMIC_RELAXED
> > > would look as expected.
> > >
> >
> > Do you mean weak=3Dfalse and __ATOMIC_RELAXED, __ATOMIC_ACQUIRE?
>
> no idea. I just grepped the kernel and saw:
> TEST_KERNEL_LOCKED(atomic_builtin_with_memorder,
>                    __atomic_compare_exchange_n(flag, &v, 1, 0,
> __ATOMIC_ACQUIRE, __ATOMIC_RELAXED),
>                    __atomic_store_n(flag, 0, __ATOMIC_RELEASE));
> TEST_KERNEL_LOCKED(atomic_builtin_wrong_memorder,
>                    __atomic_compare_exchange_n(flag, &v, 1, 0,
> __ATOMIC_RELAXED, __ATOMIC_RELAXED),
>                    __atomic_store_n(flag, 0, __ATOMIC_RELAXED));
>
> I'd just use __ATOMIC_SEQ_CST everywhere.
> Speed is not important here.

Make sense. I will use __ATOMIC_SEQ_CST. Thanks for the suggestion.

>
> >
> > > > +                       goto retry;
> > > > +
> > > > +               strncpy(tld_metadata_p->metadata[i].name, name, TLD=
_NAME_LEN);
> > > > +               __atomic_store_n(&tld_metadata_p->metadata[i].size,=
 size, __ATOMIC_RELEASE);
> > > > +               return (tld_key_t) {.off =3D off};
> > > > +       }
> > > > +
> > > > +       return (tld_key_t) {.off =3D -ENOSPC};
> > > > +}
> > > > +
> > > > +__attribute__((unused))
> > > > +static inline bool tld_key_is_err(tld_key_t key)
> > > > +{
> > > > +       return key.off < 0;
> > > > +}
> > > > +
> > > > +__attribute__((unused))
> > > > +static inline int tld_key_err_or_zero(tld_key_t key)
> > > > +{
> > > > +       return tld_key_is_err(key) ? key.off : 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * tld_get_data() - Gets a pointer to the TLD associated with the =
key.
> > > > + *
> > > > + * @map_fd: A file descriptor of the underlying task local storage=
 map,
> > > > + * tld_data_map
> > > > + * @key: A key object returned by tld_create_key().
> > > > + *
> > > > + * Returns a pointer to the TLD if the key is valid; NULL if no ke=
y has been
> > > > + * added, not enough memory for TLD for this thread, or the key is=
 invalid.
> > > > + *
> > > > + * Threads that call tld_get_data() must call tld_free() on exit t=
o prevent
> > > > + * memory leak.
> > > > + */
> > > > +__attribute__((unused))
> > > > +static void *tld_get_data(int map_fd, tld_key_t key)
> > > > +{
> > > > +       if (!READ_ONCE(tld_metadata_p))
> > > > +               return NULL;
> > > > +
> > > > +       if (!tld_data_p && __tld_init_data(map_fd))
> > > > +               return NULL;
> > >
> > > Why call it again?
> > > tld_create_key() should have done it, no?
> > >
> >
> > A TLD is created by calling tld_create_key() once. Then, threads may
> > call tld_get_data() to get their thread-specific TLD. So it is
> > possible for a thread to call tld_get_data() with tld_data_p=3D=3DNULL.
>
> I see. Please add a comment.

I will explain it in the comment.

>
> > > > +
> > > > +       return tld_data_p->data + key.off;
> > > > +}
> > > > +
> > > > +/**
> > > > + * tld_free() - Frees task local data memory of the calling thread
> > > > + */
> > > > +__attribute__((unused))
> > > > +static void tld_free(void)
> > > > +{
> > > > +       if (tld_data_p)
> > > > +               free(tld_data_p);
> > > > +}
> > >
> > > Since this .h allocates tld_metadata_p, it probably needs
> > > a helper to free it too.
> > >
> > > > +
> > > > +#endif /* __TASK_LOCAL_DATA_H */
> > > > diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.=
h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> > > > new file mode 100644
> > > > index 000000000000..5f48e408a5e5
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> > > > @@ -0,0 +1,220 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef __TASK_LOCAL_DATA_BPF_H
> > > > +#define __TASK_LOCAL_DATA_BPF_H
> > > > +
> > > > +/*
> > > > + * Task local data is a library that facilitates sharing per-task =
data
> > > > + * between user space and bpf programs.
> > > > + *
> > > > + *
> > > > + * PREREQUISITE
> > > > + *
> > > > + * A TLD, an entry of data in task local data, first needs to be c=
reated by the
> > > > + * user space. This is done by calling user space API, tld_create_=
key(), with
> > > > + * the name of the TLD and the size.
> > > > + *
> > > > + *     tld_key_t prio, in_cs;
> > > > + *
> > > > + *     prio =3D tld_create_key("priority", sizeof(int));
> > > > + *     in_cs =3D tld_create_key("in_critical_section", sizeof(bool=
));
> > > > + *
> > > > + * A key associated with the TLD, which has an opaque type tld_key=
_t, will be
> > > > + * returned. It can be used to get a pointer to the TLD in the use=
r space by
> > > > + * calling tld_get_data().
> > > > + *
> > > > + *
> > > > + * USAGE
> > > > + *
> > > > + * Similar to user space, bpf programs locate a TLD using the same=
 key.
> > > > + * tld_fetch_key() allows bpf programs to retrieve a key created i=
n the user
> > > > + * space by name, which is specified in the second argument of tld=
_create_key().
> > > > + * tld_fetch_key() additionally will cache the key in a task local=
 storage map,
> > > > + * tld_key_map, to avoid performing costly string comparisons ever=
y time when
> > > > + * accessing a TLD. This requires the developer to define the map =
value type of
> > > > + * tld_key_map, struct tld_keys. It only needs to contain keys use=
d by bpf
> > > > + * programs in the compilation unit.
> > > > + *
> > > > + * struct tld_keys {
> > > > + *     tld_key_t prio;
> > > > + *     tld_key_t in_cs;
> > > > + * };
> > > > + *
> > > > + * Then, for every new task, a bpf program will fetch and cache ke=
ys once and
> > > > + * for all. This should be done ideally in a non-critical path (e.=
g., in
> > > > + * sched_ext_ops::init_task).
> > > > + *
> > > > + *     struct tld_object tld_obj;
> > > > + *
> > > > + *     err =3D tld_object_init(task, &tld);
> > > > + *     if (err)
> > > > + *         return 0;
> > > > + *
> > > > + *     tld_fetch_key(&tld_obj, "priority", prio);
> > > > + *     tld_fetch_key(&tld_obj, "in_critical_section", in_cs);
> > > > + *
> > > > + * Note that, the first argument of tld_fetch_key() is a pointer t=
o tld_object.
> > > > + * It should be declared as a stack variable and initialized via t=
ld_object_init().
> > > > + *
> > > > + * Finally, just like user space programs, bpf programs can get a =
pointer to a
> > > > + * TLD by calling tld_get_data(), with cached keys.
> > > > + *
> > > > + *     int *p;
> > > > + *
> > > > + *     p =3D tld_get_data(&tld_obj, prio, sizeof(int));
> > > > + *     if (p)
> > > > + *         // do something depending on *p
> > > > + */
> > > > +#include <errno.h>
> > > > +#include <bpf/bpf_helpers.h>
> > > > +
> > > > +#define TLD_DATA_SIZE __PAGE_SIZE
> > > > +#define TLD_DATA_CNT 63
> > > > +#define TLD_NAME_LEN 62
> > > > +
> > > > +typedef struct {
> > > > +       __s16 off;
> > > > +} tld_key_t;
> > > > +
> > > > +struct u_tld_data *dummy_data;
> > > > +struct u_tld_metadata *dummy_metadata;
> > > > +
> > > > +struct tld_metadata {
> > > > +       char name[TLD_NAME_LEN];
> > > > +       __u16 size;
> > > > +};
> > > > +
> > > > +struct u_tld_metadata {
> > > > +       __u8 cnt;
> > > > +       __u8 padding[63];
> > > > +       struct tld_metadata metadata[TLD_DATA_CNT];
> > > > +};
> > > > +
> > > > +struct u_tld_data {
> > > > +       char data[TLD_DATA_SIZE];
> > > > +};
> > > > +
> > > > +struct tld_map_value {
> > > > +       struct u_tld_data __uptr *data;
> > > > +       struct u_tld_metadata __uptr *metadata;
> > > > +};
> > > > +
> > > > +struct tld_object {
> > > > +       struct tld_map_value *data_map;
> > > > +       struct tld_keys *key_map;
> > > > +};
> > > > +
> > > > +/*
> > > > + * Map value of tld_key_map for caching keys. Must be defined by t=
he developer.
> > > > + * Members should be tld_key_t and passed to the 3rd argument of t=
ld_fetch_key().
> > > > + */
> > > > +struct tld_keys;
> > > > +
> > > > +struct {
> > > > +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > > > +       __uint(map_flags, BPF_F_NO_PREALLOC);
> > > > +       __type(key, int);
> > > > +       __type(value, struct tld_map_value);
> > > > +} tld_data_map SEC(".maps");
> > > > +
> > > > +struct {
> > > > +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > > > +       __uint(map_flags, BPF_F_NO_PREALLOC);
> > > > +       __type(key, int);
> > > > +       __type(value, struct tld_keys);
> > > > +} tld_key_map SEC(".maps");
> > > > +
> > > > +/**
> > > > + * tld_object_init() - Initializes a tld_object.
> > > > + *
> > > > + * @task: The task_struct of the target task
> > > > + * @tld_obj: A pointer to a tld_object to be initialized
> > > > + *
> > > > + * Returns 0 on success; -ENODATA if the task has no TLD; -ENOMEM =
if the creation
> > > > + * of tld_key_map fails
> > > > + */
> > > > +__attribute__((unused))
> > > > +static int tld_object_init(struct task_struct *task, struct tld_ob=
ject *tld_obj)
> > > > +{
> > > > +       tld_obj->data_map =3D bpf_task_storage_get(&tld_data_map, t=
ask, 0, 0);
> > > > +       if (!tld_obj->data_map)
> > > > +               return -ENODATA;
> > > > +
> > > > +       tld_obj->key_map =3D bpf_task_storage_get(&tld_key_map, tas=
k, 0,
> > > > +                                               BPF_LOCAL_STORAGE_G=
ET_F_CREATE);
> > > > +       if (!tld_obj->key_map)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * tld_fetch_key() - Fetches the key to a TLD by name. The key has=
 to be created
> > > > + * by user space first with tld_create_key().
> > > > + *
> > > > + * @tld_obj: A pointer to a valid tld_object initialized by tld_ob=
ject_init()
> > > > + * @name: The name of the key associated with a TLD
> > > > + * @key: The key in struct tld_keys to be saved to
> > > > + *
> > > > + * Returns a positive integer on success; 0 otherwise
> > > > + */
> > > > +#define tld_fetch_key(tld_obj, name, key)                         =
             \
> > > > +       ({                                                         =
             \
> > > > +               (tld_obj)->key_map->key.off =3D __tld_fetch_key(tld=
_obj, name);   \
> > > > +       })
> > > > +
> > > > +__attribute__((unused))
> > > > +static u16 __tld_fetch_key(struct tld_object *tld_obj, const char =
*name)
> > > > +{
> > > > +       int i, meta_off, cnt;
> > > > +       void *metadata, *nm, *sz;
> > > > +       u16 off =3D 0;
> > > > +
> > > > +       if (!tld_obj->data_map || !tld_obj->data_map->metadata)
> > > > +               return 0;
> > > > +
> > > > +       cnt =3D tld_obj->data_map->metadata->cnt;
> > > > +       metadata =3D tld_obj->data_map->metadata->metadata;
> > > > +
> > > > +       bpf_for(i, 0, cnt) {
> > > > +               meta_off =3D i * sizeof(struct tld_metadata);
> > > > +               if (meta_off > TLD_DATA_SIZE - offsetof(struct u_tl=
d_metadata, metadata)
> > > > +                                          - sizeof(struct tld_meta=
data))
> > > > +                       break;
> > > > +
> > > > +               nm =3D metadata + meta_off + offsetof(struct tld_me=
tadata, name);
> > > > +               sz =3D metadata + meta_off + offsetof(struct tld_me=
tadata, size);
> > > > +
> > > > +               /*
> > > > +                * Reserve 0 for uninitialized keys. Increase the o=
ffset of a valid key
> > > > +                * by one and subtract it later in tld_get_data().
> > > > +                */
> > > > +               if (!bpf_strncmp(nm, TLD_NAME_LEN, name))
> > > > +                       return off + 1;
> > >
> > > I think all this +1, -1 dance is doing is helping to catch an
> > > error when tld_get_data() is called without tld_fetch_key().
> > > I feel this is too defensive.
> > >
> > > Let tld_fetch_key() return proper negative error code.
> > >
> >
> > I can certainly return negative error code.
> >
> > But for the +1, -1 logic, I think is a simpler way to differentiate an
> > uninitialized key in tld_key_map from the first TLD (both key.off =3D=
=3D
> > 0). After all, bpf programs can call tld_get_data() without
> > tld_fetch_key().
>
> I'm saying we don't need to catch this case.
> progs should not call tld_get_data() without tld_fetch_key().
> If they do, it's a bug.
>

Got it. I will document this in the comment of tld_get_data().

> >
> > > > +
> > > > +               off +=3D *(u16 *)sz;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * tld_get_data() - Retrieves a pointer to the TLD associated with=
 the key.
> > > > + *
> > > > + * @tld_obj: A pointer to a valid tld_object initialized by tld_ob=
ject_init()
> > > > + * @key: The key of a TLD saved in tld_maps
> > > > + * @size: The size of the TLD. Must be a known constant value
> > > > + *
> > > > + * Returns a pointer to the TLD data associated with the key; NULL=
 if the key
> > > > + * is not valid or the size is too big
> > > > + */
> > > > +#define tld_get_data(tld_obj, key, size) \
> > > > +       __tld_get_data(tld_obj, (tld_obj)->key_map->key.off - 1, si=
ze)
> > > > +
> > > > +__attribute__((unused))
> > > > +__always_inline void *__tld_get_data(struct tld_object *tld_obj, u=
32 off, u32 size)
> > > > +{
> > > > +       return (tld_obj->data_map->data && off >=3D 0 && off < TLD_=
DATA_SIZE - size) ?
> > > > +               (void *)tld_obj->data_map->data + off : NULL;
> > >
> > > If we require users to call tld_fetch_key() first and check for error=
s
> > > tld_get_data() can be faster:
> > > #define tld_get_data(tld_obj, key)
> > >    (void *)tld_obj->data_map->data + tld_obj->key_map->key.off
> > >
> >
> > tld_get_data() can be called in a bpf program without tld_fetch_key(),
> > so checking tld_obj->data_map->data is needed as the first load from
> > tld_obj->data_map->data yields a "mem_or_null".
> >
> > I did try to save this uptr "mem" after null check to stack (e.g., in
> > a tld_object) so that we can save subsequent checks. However, the
> > compiler sometime will do a fresh load from map_ptr when reading
> > tld_obj->data_map->data. Might need some work or trick to make it
> > happen.
>
> likely because you do tld_obj->data_map->data twice.
>
> > > I wouldn't bother with extra checks, especially for size.
> > >
> >
> > It needs to be bound-checked. If tld_get_data() doesn't do it, bpf
> > programs have to do it before acceess. Otherwise:
> >
> > ; return (tld_obj->data_map->data && off >=3D 0) ? @ task_local_data.bp=
f.h:218
> > 25: (bf) r3 =3D r1                      ; R1_w=3Dmem(sz=3D4096) R3_w=3D=
mem(sz=3D4096)
> > 26: (0f) r3 +=3D r2                     ;
> > R2_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D0xffff7fff,sma=
x32=3D32766,var_off=3D(0x0;
> > 0xffffffff)) R3_w=3Dmem(sz=3D4096,smin=3D0,smax=3Dumax=3D0xffffffff,var=
_off=3D(0x0;
> > 0xfffffff)
> > ; test_value1 =3D *int_p; @ test_task_local_data.c:63
> > 27: (61) r2 =3D *(u32 *)(r3 +0)
> > R3 unbounded memory access, make sure to bounds check any such access
>
> That's easy to fix.
> Then something like:
> #define tld_get_data(tld_obj, key) \
>  ({
>     void * data =3D tld_obj->data_map->data;
>     if (data)
>          data +=3D tld_obj->key_map->key.off & (PAGE_SIZE - 1);
>     data;
>   })
>
> size is really not needed. The verifier sees it as one page.
> Bad bpf prog can write into the wrong key and the verifier cannot stop it=
.
>

key.off is a variable offset, so the verifier may assume key.off =3D=3D
PAGE_SIZE - 1. If a bpf program tries to dereference a pointer
returned by the proposed tld_get_data() as an int * without bound
check, the verifier will still consider this a potential out-of-bound
access:

invalid access to memory, mem_size=3D4096 off=3D4095 size=3D4

I think if there needs to be a bound check anyways, hiding it
tld_get_data() makes the user written part less complex.

> > > Bigger question.. can we cache the whole pointer for each key ?
> > > and then
> > > #define tld_get_data(tld_obj, key) ld_obj->key_map->key
> >
> > Maybe define the member type of tld_key_map as __uptr and allow bpf
> > programs to update a uptr field with a valid uptr?
>
> yeah. That indeed gets complicated. Maybe it's possible with some
> verifier changes, but let's not go there yet.
> The tld_get_data() proposed above is speedy enough.

