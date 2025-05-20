Return-Path: <bpf+bounces-58525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C17BABCFB8
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 08:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C5D1BA06F8
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 06:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2225E462;
	Tue, 20 May 2025 06:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLquSZP0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943825D21C;
	Tue, 20 May 2025 06:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723478; cv=none; b=i/i9a/1oZrf8anMyc+qDLZepXs8I0w1JXTYwiQC7Bb06j9P/A4wI9kcsIUTJlpmhWeXPKORPqVrcRll3Ha+DcBL0FXNCP14f4iVksms1UR8dCnkHYiRcsf+A55dme0I46/hhURxM0/TBbkR6SF+LyPiA9l//DTcHv7yWCdeV/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723478; c=relaxed/simple;
	bh=gzGIir2F/RYTKkc9z3kC/mDrlI0OBmrxwQCPXxcO+/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzhcO5MXavyuN1Q7DnVwYYNDMMcmZEdl50JR7DcfLEpuHIqP4SPnbKmPGkFXLBq4km0F5zBsfGCRrdWsslyCjLjl250Gu6nXr0lwd6FrAhvvfzGRL0/uz0ityjXYPvSfz/nl/ucSfmcapVX5EN6OkqAomtx6w6rkbjt4ZfTbFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLquSZP0; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7b8673ff36so2817627276.2;
        Mon, 19 May 2025 23:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747723475; x=1748328275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufpbIcD1nnlFO+YuOZyPO5+OmfJ1C/cl6AJ3HJfGCac=;
        b=lLquSZP0F68gIAhW3J5piUAvZDGKcUVL9xsrpsWmRF23VeDsH2A3GWjcsKSpCcABN6
         3NCBwCjP9bATIMLVKBZbsWYP+U7n1TzjgfCQnObDrFk+Q1i95KvizX7z+fNRC7VTr+aL
         88kALzZW2KJ3xdz6li2nckWMnGDZBKKnZ7GSp5G+9sND6busCP0cLRQFMr9b+JUmyEEO
         w9UvPISryEkfz2y/PUVk8fpLnJdHpMdzi3C705Q6FmT8fG7YBvw5CkDdDfpuiJ0r3tDW
         +GOvNf8XnfuJlrdg+MyDLooT2YRhNSlP1rqVIYxNuBT3xpG8FxFAdqpTed5ag3qi/VsQ
         qhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747723475; x=1748328275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufpbIcD1nnlFO+YuOZyPO5+OmfJ1C/cl6AJ3HJfGCac=;
        b=qXf8pHR8J9pbN5usB50D4n3LaKVIVzB/jri/LJ03iJag8KN6oDEPNm2mpTmnDGabRX
         64MaMsbiibftFakpw7RijQrw+bohFgi6J9ppX6Q+N46Lnm640kSpXxxyrNS0h2TxRTgX
         KmyvZFOVr3YSJ2HOfpRLENFJgK2/p/WD5n/PlSkCvSC6d8xcdGek01n9EcXHXlrSf8TO
         qyPSwmgwSGvWa55EvVTi/P5ZRYTnK84ciBPRBwMcaQ7qaavp9F1ERg2nidJPjdv+kcI3
         Z0WjguP/9bcO/T1C9eIBRHuFozwueFaxRWF/8/s2g8yF14HROC9n1GFXHXJHB9OcPo+X
         TTOg==
X-Forwarded-Encrypted: i=1; AJvYcCVfCMrMxlr4JunbrbZvaDgQG5Mb4axtqozTzR+b4Ssx0OI/uafx+sqLuXbjNgTOdMPS6ToQc4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6tRrHATEE8duxgbGavYCGc399trbN6ANQGGe+UmWo37iI8quv
	0Z39uSUJbIgvTi3z6fBphvYdm+Myynaqcj+/pRW2HOim4Kz363jv74pww7k5TrM0AjuTenj71X9
	3RnnU3vtMQ5GVA7VtEZnuHKGh8O3K/no=
X-Gm-Gg: ASbGncvjoBm5wTXpmGvIVxVJtX4SFcqqK9r9w0+b2ZA/N6XAJAKZ7FWzaP5nr3JmSgN
	rcJYjcLBcdnnbV8QxRIznAiK2JbRfPTSmSI3FWPC06YLm7pIPAiyOikrvb0UebU9Xo+Gu32GqtA
	I4ZJGj6fG044buvlDWNmpHesDYM+wVUNO4
X-Google-Smtp-Source: AGHT+IG+OCGepNquCFlHZZQFZboGnUgXhyoyfaUs9VkFsaKHaEfjRzIoympu2Owks0XqkwQSOhKzbVscB/ASMCEFIws=
X-Received: by 2002:a05:6902:250e:b0:e7b:9354:239b with SMTP id
 3f1490d57ef6-e7b93542474mr12631609276.14.1747723475213; Mon, 19 May 2025
 23:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515211606.2697271-1-ameryhung@gmail.com> <20250515211606.2697271-2-ameryhung@gmail.com>
 <aCuOsXKCkwa8zkwR@slm.duckdns.org>
In-Reply-To: <aCuOsXKCkwa8zkwR@slm.duckdns.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 19 May 2025 23:44:24 -0700
X-Gm-Features: AX0GCFu9sQo73EupEQi40uYbLuvaZc-ovgSK5NFBFMw43QSXvWZBhnPqwNkVoPk
Message-ID: <CAMB2axNTyTaqBcFRLQ0VueztMdunv71jygeij00gDNY7i9=K6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
To: Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 1:04=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, May 15, 2025 at 02:16:00PM -0700, Amery Hung wrote:
> ...
> > +#define PAGE_SIZE 4096
>
> This might conflict with other definitions. Looks like non-4k page sizes =
are
> a lot more popular on arm. Would this be a problem?
>
> > +static int __tld_init_metadata(int map_fd)
> > +{
> > +     struct u_tld_metadata *new_metadata;
> > +     struct tld_map_value map_val;
> > +     int task_fd =3D 0, err;
> > +
> > +     task_fd =3D syscall(SYS_pidfd_open, getpid(), 0);
> > +     if (task_fd < 0) {
> > +             err =3D -errno;
> > +             goto out;
> > +     }
> > +
> > +     new_metadata =3D aligned_alloc(PAGE_SIZE, PAGE_SIZE);
>
> Is 4k size limit from UPTR? Is it still 4k on machines with >4k pages? If
> this isn't a hard limit from UPTR, would it make sense to encode the size=
 in
> the header part of the metadata?
>

UPTR size limit is a page. I will make PAGE_SIZE arch dependent. For
metadata, since all threads of a process share one metadata page, I
think it is okay to make it a fixed size. For data, I think it makes
sense to encode it in the header of metadata.

> > +static int __tld_init_data(int map_fd)
> > +{
> > +     struct u_tld_data *new_data =3D NULL;
> > +     struct tld_map_value map_val;
> > +     int err, task_fd =3D 0;
> > +
> > +     task_fd =3D syscall(SYS_pidfd_open, gettid(), PIDFD_THREAD);
> > +     if (task_fd < 0) {
> > +             err =3D -errno;
> > +             goto out;
> > +     }
> > +
> > +     new_data =3D aligned_alloc(PAGE_SIZE, TLD_DATA_SIZE);
>
> Ditto.
>
> Noob question. Does this means that each thread will map a 4k page no mat=
ter
> how much data it actually uses?

Unfortunately this is the case currently, but hey maybe we can make
data size dynamic

>
> > +__attribute__((unused))
> > +static tld_key_t tld_create_key(int map_fd, const char *name, size_t s=
ize)
> > +{
> > +     int err, i, cnt, sz, off =3D 0;
> > +
> > +     if (!READ_ONCE(tld_metadata_p)) {
> > +             err =3D __tld_init_metadata(map_fd);
> > +             if (err)
> > +                     return (tld_key_t) {.off =3D err};
> > +     }
> > +
> > +     if (!tld_data_p) {
> > +             err =3D __tld_init_data(map_fd);
> > +             if (err)
> > +                     return (tld_key_t) {.off =3D err};
> > +     }
> > +
> > +     size =3D round_up(size, 8);
> > +
> > +     for (i =3D 0; i < TLD_DATA_CNT; i++) {
> > +retry:
> > +             cnt =3D __atomic_load_n(&tld_metadata_p->cnt, __ATOMIC_RE=
LAXED);
> > +             if (i < cnt) {
> > +                     /*
> > +                      * Pending tld_create_key() uses size to signal i=
f the metadata has
> > +                      * been fully updated.
> > +                      */
> > +                     while (!(sz =3D __atomic_load_n(&tld_metadata_p->=
metadata[i].size,
> > +                                                   __ATOMIC_ACQUIRE)))
> > +                             sched_yield();
> > +
> > +                     if (!strncmp(tld_metadata_p->metadata[i].name, na=
me, TLD_NAME_LEN))
> > +                             return (tld_key_t) {.off =3D -EEXIST};
> > +
> > +                     off +=3D sz;
> > +                     continue;
> > +             }
> > +
> > +             if (off + size > TLD_DATA_SIZE)
> > +                     return (tld_key_t) {.off =3D -E2BIG};
> > +
> > +             /*
> > +              * Only one tld_create_key() can increase the current cnt=
 by one and
> > +              * takes the latest available slot. Other threads will ch=
eck again if a new
> > +              * TLD can still be added, and then compete for the new s=
lot after the
> > +              * succeeding thread update the size.
> > +              */
> > +             if (!__atomic_compare_exchange_n(&tld_metadata_p->cnt, &c=
nt, cnt + 1, true,
> > +                                              __ATOMIC_RELAXED, __ATOM=
IC_RELAXED))
> > +                     goto retry;
> > +
> > +             strncpy(tld_metadata_p->metadata[i].name, name, TLD_NAME_=
LEN);
> > +             __atomic_store_n(&tld_metadata_p->metadata[i].size, size,=
 __ATOMIC_RELEASE);
> > +             return (tld_key_t) {.off =3D off};
> > +     }
> > +
> > +     return (tld_key_t) {.off =3D -ENOSPC};
> > +}
>
> This looks fine to me but I wonder whether run-length encoding the key
> strings would be more efficient and less restrictive in terms of key leng=
th.
> e.g.:
>
> struct key {
>         u32 data_len;
>         u16 key_off;
>         u16 key_len;
> };
>
> struct metadata {
>         struct key      keys[MAX_KEYS];
>         char            key_strs[SOME_SIZE];
> };
>
> The logic can be mostly the same. The only difference would be that key
> string is not inline. Determine winner in the creation path by compxchg'i=
ng
> on data_len, but set key_off and key_len only after key string is updated=
.
> Losing on cmpxhcg or seeing an entry where key_len is zero means that tha=
t
> one lost and should relax and retry. It can still use the same 4k metadat=
a
> page but will likely be able to allow more keys while also relaxing
> restrictions on key length.
>
> Hmm... maybe making the key string variably sized makes things difficult =
for
> the BPF code. If so (or for any other reasons), please feel free to ignor=
e
> the above.

I think this is a great suggestion. The current implementation may
waste spaces in metadata if a key does not use all 62 bytes. I don't
see an obvious obstacle in bpf. I will try to incorporate this in the
next respin.

>
> > +#endif /* __TASK_LOCAL_DATA_H */
> > diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/=
tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> > new file mode 100644
> > index 000000000000..5f48e408a5e5
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> ...
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
> > +     __tld_get_data(tld_obj, (tld_obj)->key_map->key.off - 1, size)
> > +
> > +__attribute__((unused))
> > +__always_inline void *__tld_get_data(struct tld_object *tld_obj, u32 o=
ff, u32 size)
> > +{
> > +     return (tld_obj->data_map->data && off >=3D 0 && off < TLD_DATA_S=
IZE - size) ?
> > +             (void *)tld_obj->data_map->data + off : NULL;
> > +}
>
> Neat.
>
> Generally looks great to me. The only thing I wonder is whether the data
> area sizing can be determined at init time rather than fixed to 4k.
>

I think we can achieve it by first limiting tld_create_key() to the
init phase (i.e., only calling them in C/C++ constructor). Then,
tld_create_key() will not allocate memory for data. Instead, on the
first call to tld_get_data(), we freeze the size of the data area and
allocate the memory just enough or round up to the power of two.

For C, we can define a new macro API (e.g., tld_define_key()) that
generates a __attribute__((constructor)) function that in turn calls
tld_create_key().

> Thanks.
>
> --
> tejun

