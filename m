Return-Path: <bpf+bounces-31681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D415D9016FB
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 18:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1AD1F21257
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C337E481CD;
	Sun,  9 Jun 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYUWWaSf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B6246544;
	Sun,  9 Jun 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717949543; cv=none; b=qcEsfVYXGzY/Ydd4qNgwTHxZl8RwBce+9bGSxeB14glN46kHMZ4MgoUVggIuX5QpZUBarIwmuRWsfN0HC+N04/OSVlR85F8SINgpTsshW19a9ADpWEiiFLvrj5+CkjDkH6ROVYWhwJquS3ArGNI5CqWWC339Exb/hz+80Eks/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717949543; c=relaxed/simple;
	bh=kWFlcAu/JlVbwxvBpYD5IuZFqHrl3ca1ptLM3BJem4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGlfPKa52p2zNvmwSBVFEO+YEQ0n7uFNEdIwTVKOWQ4X/BXiH3XlhMpFxf0c4qjt+e7HgEkY/INoHNg+rRsiPOKz4fWperHp6eC0Gz1E0JFmGEvMg14qa7NjHbXPxuQWOIYGSagc4jvRkIHCKPC0fzTf4LQogkcD3YwPJnIktY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYUWWaSf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso5151038a12.1;
        Sun, 09 Jun 2024 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717949539; x=1718554339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7jO8ToH6ML8/Ro+TVs1hT7bnnXDtzqgaXtS36NqMwE=;
        b=TYUWWaSfiLvhZgGu+tAskVnA6qKn4Kwhhfkd9ilQJR0oBOjgQBR/pVAhlWZ4KFlSw6
         wc/n3cfqSonDTNgXm1iAMzpWVq7t9SsQLagn0UtCTll5FCITDi/vTHDvKS1uO3yImQmC
         vWP67HPlqvNH6gRTkrIc6/CZ/FIRTiCHDXw8Bg6NhTJYfd7i2Vd5gq5wB9vFC1f8R3Sb
         jGbJvQguBUbssSk8oJrGtwG4vn0/ZWS6loydC5jfJbO9gOL00YsiZUkt9hZ7Z+v7TdAc
         p1OjwSCAd6fknlOkP8jK3Cu3DDs/RPOXBmrcKJPe6qC2j+be79Wi/INyElWYmXIQ8l2c
         JXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717949539; x=1718554339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7jO8ToH6ML8/Ro+TVs1hT7bnnXDtzqgaXtS36NqMwE=;
        b=UboIy6GIN49hZ0oUcDu9O7babrfew5CkgYXuD88yd+bYdDhq1t9X7NVo6wQ+sYEhjF
         S38JCVnNHj/f4r6LHr46oX+VVma2sexV53dUVR4l/7wAPzHmhBmuZnBIV9djnGCU4tLM
         UD37L9RXFtKCDLIIMU8Vuafp3l5lDWBrDSw6CFSHy6Iyez6epKIGwo2undt5VAkAMYY2
         EbFwfdoM/wrEJCiso0CAmTuGvP0ToJ/4/qHPVQYhAci9sGjpBlucW1KfK++R7De2Xkmw
         DVRa+4SO347MHsOF5oEEG2ML9jWcP1SD+snQBoT3MYhvKVdHyK3lrOqOw8xEwQReKLMt
         Eb4A==
X-Forwarded-Encrypted: i=1; AJvYcCXfNFQJjqYy/ZjzcnUIFlxm1yAswDAwwzIuilWJiiGHeVFm2XPef/iiBx8R3E9E0u/UQlhFhVAEmkzruneSxx5QPdbHLhI597jREbNI12dnMXYrymSsuzhwPvGAZqTx1Y29
X-Gm-Message-State: AOJu0YyJ5aqqeD4WLL9v4NGfXm6jME68uqO8Fgf13A5Iyb6ZauQjidKt
	NDywpmdkS5vgmRONSsuyxgWl4fBc22fhdAnibrf3/O0JIR9vIZ7XJWV9QFje7EEiMDyxW2A5te8
	lkpxHZdHd8EfaEji9gdhvZbJZaK0=
X-Google-Smtp-Source: AGHT+IFrFTJwYcyYiLvznLF1avtEfr5FdfWmSDQDOLQODwZS4oLM3i6c1zBj4nmaAZ2zzOZXSi3LDliMcHLYFv/EJOk=
X-Received: by 2002:a50:9b57:0:b0:57c:7f3a:6c81 with SMTP id
 4fb4d7f45d1cf-57c7f3ac25amr735794a12.8.1717949539152; Sun, 09 Jun 2024
 09:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608140835.965949-1-dolinux.peng@gmail.com> <20240609162327.ce8bd5fdfffd6b01ad92d8c5@kernel.org>
In-Reply-To: <20240609162327.ce8bd5fdfffd6b01ad92d8c5@kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 10 Jun 2024 00:12:07 +0800
Message-ID: <CAErzpmt69A3B4ynjZ2UEK6FJZL0TcX7=7oS3C+FaXEOezxEXGw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, song@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, haoluo@google.com, yonghong.song@linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 3:23=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> Hi
>
> On Sat,  8 Jun 2024 07:08:35 -0700
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > Currently, we are only using the linear search method to find the type =
id
> > by the name, which has a time complexity of O(n). This change involves
> > sorting the names of btf types in ascending order and using binary sear=
ch,
> > which has a time complexity of O(log(n)). This idea was inspired by the
> > following patch:
> >
> > 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_nam=
e()").
> >
> > At present, this improvement is only for searching in vmlinux's and
> > module's BTFs.
> >
> > Another change is the search direction, where we search the BTF first a=
nd
> > then its base, the type id of the first matched btf_type will be return=
ed.
> >
> > Here is a time-consuming result that finding 87590 type ids by their na=
mes in
> > vmlinux's BTF.
> >
> > Before: 158426 ms
> > After:     114 ms
> >
> > The average lookup performance has improved more than 1000x in the abov=
e scenario.
>
> This looks great improvement! so searching function entry in ~2us?

Yes, it is the average test result on a Ubuntu VM. However, if you are
specifically
searching for a particular btf_type, it may take more time due to cache mis=
ses.

The data is obtained from the following test code:

 /*
  * total: the number of btf_type
  * nr_names: the number of btf_type that has a name
  *
  */

 pr_info("Begin to test ... total: %d, nr_names: %d\n", total, nr_names);

 t0 =3D ktime_get_ns();
 for (i =3D 0; i < nr_names; i++) {
         if (btf_find_by_name_kind(btf, tn[i].name, tn[i].kind) <=3D 0) {
                 pr_err("Find failed: name: %s, kind: %d\n",
tn[i].name, tn[i].kind);
                 break;
         }

         if ((i & 0xfff) =3D=3D 0)
                 touch_nmi_watchdog();
 }
 delta =3D ktime_get_ns() - t0;

 pr_info("Consume total: %llu ms,  Per btf_type: %llu ns\n", delta /
NSEC_PER_MSEC, delta / nr_names);


Using binary search:
[   40.381095] Begin to test ... total: 155010, nr_names: 87596
[   40.493024] Consume total: 111 ms,  Per btf_type: 1275 ns

Using linear search:
[   56.464520] Begin to test ... total: 155003, nr_names: 87591
[  213.344919] Consume total: 156880 ms,  Per btf_type: 1791054 ns

> BTW, I have some comments below, but basically it looks good to me and
> it passed my ftracetest.

Thank you.

>
> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

I will include this in v4.

> >
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> > Changes in RFC v3:
> >  - Sort the btf types during the build process in order to reduce memor=
y usage
> >    and decrease boot time.
> >
> > RFC v2:
> >  - https://lore.kernel.org/all/20230909091646.420163-1-pengdonglin@sang=
for.com.cn
> > ---
> >  include/linux/btf.h |   1 +
> >  kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++---
> >  tools/lib/bpf/btf.c | 195 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 345 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index f9e56fd12a9f..1dc1000a7dc9 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -214,6 +214,7 @@ bool btf_is_kernel(const struct btf *btf);
> >  bool btf_is_module(const struct btf *btf);
> >  struct module *btf_try_get_module(const struct btf *btf);
> >  u32 btf_nr_types(const struct btf *btf);
> > +u32 btf_type_cnt(const struct btf *btf);
> >  bool btf_member_is_reg_int(const struct btf *btf, const struct btf_typ=
e *s,
> >                          const struct btf_member *m,
> >                          u32 expected_offset, u32 expected_size);
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 821063660d9f..5b7b464204bf 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -262,6 +262,7 @@ struct btf {
> >       u32 data_size;
> >       refcount_t refcnt;
> >       u32 id;
> > +     u32 nr_types_sorted;
> >       struct rcu_head rcu;
> >       struct btf_kfunc_set_tab *kfunc_set_tab;
> >       struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
> > @@ -542,23 +543,102 @@ u32 btf_nr_types(const struct btf *btf)
> >       return total;
> >  }
> >
> > -s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 =
kind)
> > +u32 btf_type_cnt(const struct btf *btf)
> > +{
> > +     return btf->start_id + btf->nr_types;
> > +}
> > +
> > +static s32 btf_find_by_name_bsearch(const struct btf *btf, const char =
*name,
> > +                                 int *start, int *end)
> >  {
> >       const struct btf_type *t;
> > -     const char *tname;
> > -     u32 i, total;
> > +     const char *name_buf;
> > +     int low, low_start, mid, high, high_end;
> > +     int ret, start_id;
> > +
> > +     start_id =3D btf->base_btf ? btf->start_id : 1;
> > +     low_start =3D low =3D start_id;
> > +     high_end =3D high =3D start_id + btf->nr_types_sorted - 1;
> > +
> > +     while (low <=3D high) {
> > +             mid =3D low + (high - low) / 2;
> > +             t =3D btf_type_by_id(btf, mid);
> > +             name_buf =3D btf_name_by_offset(btf, t->name_off);
> > +             ret =3D strcmp(name, name_buf);
> > +             if (ret > 0)
> > +                     low =3D mid + 1;
> > +             else if (ret < 0)
> > +                     high =3D mid - 1;
> > +             else
> > +                     break;
> > +     }
> >
> > -     total =3D btf_nr_types(btf);
> > -     for (i =3D 1; i < total; i++) {
> > -             t =3D btf_type_by_id(btf, i);
> > -             if (BTF_INFO_KIND(t->info) !=3D kind)
> > -                     continue;
> > +     if (low > high)
> > +             return -ESRCH;
>
> nit: -ENOENT ?

Good, I will update it in the v4.

>
> >
> > -             tname =3D btf_name_by_offset(btf, t->name_off);
> > -             if (!strcmp(tname, name))
> > -                     return i;
> > +     if (start) {
> > +             low =3D mid;
> > +             while (low > low_start) {
> > +                     t =3D btf_type_by_id(btf, low-1);
> > +                     name_buf =3D btf_name_by_offset(btf, t->name_off)=
;
> > +                     if (strcmp(name, name_buf))
> > +                             break;
> > +                     low--;
> > +             }
> > +             *start =3D low;
> >       }
> >
> > +     if (end) {
> > +             high =3D mid;
> > +             while (high < high_end) {
> > +                     t =3D btf_type_by_id(btf, high+1);
> > +                     name_buf =3D btf_name_by_offset(btf, t->name_off)=
;
> > +                     if (strcmp(name, name_buf))
> > +                             break;
> > +                     high++;
> > +             }
> > +             *end =3D high;
> > +     }
> > +
> > +     return mid;
> > +}
> > +
> > +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 =
kind)
> > +{
> > +     const struct btf_type *t;
> > +     const char *tname;
> > +     int start, end;
> > +     s32 id, total;
> > +
> > +     do {
> > +             if (btf->nr_types_sorted) {
> > +                     /* binary search */
> > +                     id =3D btf_find_by_name_bsearch(btf, name, &start=
, &end);
> > +                     if (id > 0) {
> > +                             while (start <=3D end) {
> > +                                     t =3D btf_type_by_id(btf, start);
> > +                                     if (BTF_INFO_KIND(t->info) =3D=3D=
 kind)
> > +                                             return start;
> > +                                     start++;
> > +                             }
> > +                     }
> > +             } else {
> > +                     /* linear search */
> > +                     total =3D btf_type_cnt(btf);
> > +                     for (id =3D btf->base_btf ? btf->start_id : 1;
> > +                             id < total; id++) {
> > +                             t =3D btf_type_by_id(btf, id);
> > +                             if (BTF_INFO_KIND(t->info) !=3D kind)
> > +                                     continue;
> > +
> > +                             tname =3D btf_name_by_offset(btf, t->name=
_off);
> > +                             if (!strcmp(tname, name))
> > +                                     return id;
> > +                     }
> > +             }
> > +             btf =3D btf->base_btf;
> > +     } while (btf);
> > +
> >       return -ENOENT;
> >  }
> >
> > @@ -5979,6 +6059,56 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log =
*log, enum bpf_prog_type prog_ty
> >       return kctx_type_id;
> >  }
> >
> > +static int btf_check_sort(struct btf *btf, int start_id)
> > +{
> > +     int i, n, nr_names =3D 0;
> > +
> > +     n =3D btf_nr_types(btf);
> > +     for (i =3D start_id; i < n; i++) {
> > +             const struct btf_type *t;
> > +             const char *name;
> > +
> > +             t =3D btf_type_by_id(btf, i);
> > +             if (!t)
> > +                     return -EINVAL;
> > +
> > +             name =3D btf_str_by_offset(btf, t->name_off);
> > +             if (!str_is_empty(name))
> > +                     nr_names++;
>
> else {
>         goto out;
> }
> ? (*)
>

No need for that. The purpose of the for loop here is to count the
number of btf_types
with names. If the BTF file is sorted, the btf_types with names will
be placed at the
beginning, while the btf_types without names will be appended at the end.

> > +     }
> > +
> > +     if (nr_names < 3)
> > +             goto out;
>
> What does this `3` mean?

It is just my own opinion. The binary search method does not offer any
superiority if there
 are only 1 or 2 btf_types with names.

>
> > +
> > +     for (i =3D 0; i < nr_names - 1; i++) {
> > +             const struct btf_type *t1, *t2;
> > +             const char *s1, *s2;
> > +
> > +             t1 =3D btf_type_by_id(btf, start_id + i);
> > +             if (!t1)
> > +                     return -EINVAL;
> > +
> > +             s1 =3D btf_str_by_offset(btf, t1->name_off);
> > +             if (str_is_empty(s1))
> > +                     goto out;
>
> Why not continue? This case is expected, or the previous block (*)
> must go `out` at that point.

The purpose of the for loop here is to verify whether the first
nr_name btf_types are sorted
or not. If the BTF file is indeed sorted, btf_types with names will be
placed at the beginning,
and the number of btf_types with names is equal to nr_names. However,
if a btf_type without a
name is found within the first nr_name btf_types, it indicates that
the BTF file is not sorted.

>
> > +
> > +             t2 =3D btf_type_by_id(btf, start_id + i + 1);
> > +             if (!t2)
> > +                     return -EINVAL;
> > +
> > +             s2 =3D btf_str_by_offset(btf, t2->name_off);
> > +             if (str_is_empty(s2))
> > +                     goto out;
>
> Ditto.
>

Ditto.

> > +
> > +             if (strcmp(s1, s2) > 0)
> > +                     goto out;
> > +     }
> > +
> > +     btf->nr_types_sorted =3D nr_names;
> > +out:
> > +     return 0;
> > +}
> > +
> >  BTF_ID_LIST(bpf_ctx_convert_btf_id)
> >  BTF_ID(struct, bpf_ctx_convert)
> >
> > @@ -6029,6 +6159,10 @@ struct btf *btf_parse_vmlinux(void)
> >       if (err)
> >               goto errout;
> >
> > +     err =3D btf_check_sort(btf, 1);
>
> Why `1`?

The start ID for the sorted btf_types in vmlinux's BTF is 1, as the
btf_void is placed before
the sorted types.

>
> > +     if (err)
> > +             goto errout;
> > +
> >       /* btf_parse_vmlinux() runs under bpf_verifier_lock */
> >       bpf_ctx_convert.t =3D btf_type_by_id(btf, bpf_ctx_convert_btf_id[=
0]);
> >
> > @@ -6111,6 +6245,10 @@ static struct btf *btf_parse_module(const char *=
module_name, const void *data, u
> >       if (err)
> >               goto errout;
> >
> > +     err =3D btf_check_sort(btf, btf_nr_types(base_btf));
> > +     if (err)
> > +             goto errout;
> > +
> >       btf_verifier_env_free(env);
> >       refcount_set(&btf->refcnt, 1);
> >       return btf;
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 2d0840ef599a..93c1ab677bfa 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1,6 +1,9 @@
> >  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  /* Copyright (c) 2018 Facebook */
> >
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> >  #include <byteswap.h>
> >  #include <endian.h>
> >  #include <stdio.h>
> > @@ -3072,6 +3075,7 @@ static int btf_dedup_ref_types(struct btf_dedup *=
d);
> >  static int btf_dedup_resolve_fwds(struct btf_dedup *d);
> >  static int btf_dedup_compact_types(struct btf_dedup *d);
> >  static int btf_dedup_remap_types(struct btf_dedup *d);
> > +static int btf_sort_type_by_name(struct btf *btf);
> >
> >  /*
> >   * Deduplicate BTF types and strings.
> > @@ -3270,6 +3274,11 @@ int btf__dedup(struct btf *btf, const struct btf=
_dedup_opts *opts)
> >               pr_debug("btf_dedup_remap_types failed:%d\n", err);
> >               goto done;
> >       }
> > +     err =3D btf_sort_type_by_name(btf);
> > +     if (err < 0) {
> > +             pr_debug("btf_sort_type_by_name failed:%d\n", err);
> > +             goto done;
> > +     }
> >
> >  done:
> >       btf_dedup_free(d);
> > @@ -5212,3 +5221,189 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_=
ext, str_off_visit_fn visit, void
> >
> >       return 0;
> >  }
> > +
> > +static int btf_compare_type_name(const void *a, const void *b, void *p=
riv)
> > +{
> > +     struct btf *btf =3D (struct btf *)priv;
> > +     __u32 ta =3D *(const __u32 *)a;
> > +     __u32 tb =3D *(const __u32 *)b;
> > +     struct btf_type *bta, *btb;
> > +     const char *na, *nb;
> > +
> > +     bta =3D (struct btf_type *)(btf->types_data + ta);
> > +     btb =3D (struct btf_type *)(btf->types_data + tb);
> > +     na =3D btf__str_by_offset(btf, bta->name_off);
> > +     nb =3D btf__str_by_offset(btf, btb->name_off);
> > +
> > +     return strcmp(na, nb);
> > +}
> > +
> > +static int btf_compare_offs(const void *o1, const void *o2)
> > +{
> > +     __u32 *offs1 =3D (__u32 *)o1;
> > +     __u32 *offs2 =3D (__u32 *)o2;
> > +
> > +     return *offs1 - *offs2;
> > +}
> > +
> > +static inline __u32 btf_get_mapped_type(struct btf *btf, __u32 *maps, =
__u32 type)
> > +{
> > +     if (type < btf->start_id)
> > +             return type;
> > +     return maps[type - btf->start_id] + btf->start_id;
> > +}
> > +
> > +/*
> > + * Collect and move the btf_types with names to the start location, an=
d
> > + * sort them in ascending order by name, so we can use the binary sear=
ch
> > + * method.
> > + */
> > +static int btf_sort_type_by_name(struct btf *btf)
> > +{
> > +     struct btf_type *bt;
> > +     __u32 *new_type_offs =3D NULL, *new_type_offs_noname =3D NULL;
> > +     __u32 *maps =3D NULL, *found_offs;
> > +     void *new_types_data =3D NULL, *loc_data;
> > +     int i, j, k, type_cnt, ret =3D 0, type_size;
> > +     __u32 data_size;
> > +
> > +     if (btf_ensure_modifiable(btf))
> > +             return libbpf_err(-ENOMEM);
> > +
> > +     type_cnt =3D btf->nr_types;
> > +     data_size =3D btf->type_offs_cap * sizeof(*new_type_offs);
> > +
> > +     maps =3D (__u32 *)malloc(type_cnt * sizeof(__u32));
> > +     if (!maps) {
> > +             ret =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     new_type_offs =3D (__u32 *)malloc(data_size);
>
> nit:
> new_type_offs =3D (__u32 *)calloc(btf->type_offs_cap, sizeof(*new_type_of=
fs))

Okay, I will update it in v4.

>
> > +     if (!new_type_offs) {
> > +             ret =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     new_type_offs_noname =3D (__u32 *)malloc(data_size);
> > +     if (!new_type_offs_noname) {
> > +             ret =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     new_types_data =3D malloc(btf->types_data_cap);
> > +     if (!new_types_data) {
> > +             ret =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     memset(new_type_offs, 0, data_size);
>
> Then this memset is not required.

Good, I will update it in v4.

>
> Thank you,
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

