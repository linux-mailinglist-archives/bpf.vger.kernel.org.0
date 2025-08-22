Return-Path: <bpf+bounces-66305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68695B32288
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 21:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024AA7B3EF1
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD92C375A;
	Fri, 22 Aug 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHGCFvCM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3182C21D4;
	Fri, 22 Aug 2025 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889280; cv=none; b=bJEqL71dHZgw07HrSUeBwM/rE8odDBzs348PUSP2KBgah7LetkhRJMzdPkggg+VGb6fFu089XrqKGlU1UUrRpDRK5l+4PHrm239H3oIStjIMharyP7Ba711c/wTUgEHDItKJbuGCf/lAQQTfnbu+2zFJOWD2Cb5XNiWZthuhexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889280; c=relaxed/simple;
	bh=MmmXQmiYtuiUZvLDCzhyQq0oQAsG8MaMCnLc2t8LIuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvMkk3qivvVJkaUByMKzlFE7cSuYuCTj+mEy55kH3qvAKlx0L66OIYf91U1rOjBAC2SkCJYvjF7zrTrvN9bsRM/XGQcimAbqstHDdVDU7IaDT1DsACuRIRPR4h/9pTRQzwdrlO4nE5T5tEZD9uXrlGYudQgMyw+yGxjquLiAr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHGCFvCM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso2025794a91.3;
        Fri, 22 Aug 2025 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755889253; x=1756494053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G4uVOcBa/iivnMpGsqEmtusc+mONUzr/xNCqDruNEw=;
        b=fHGCFvCMqISo+AyWNyNg9B/4Wo7Ml5UIt0KXLjgy2BB2subAYmvnWHcXX58UwAMyft
         pV5KfEavIJJMdiF1iThezpkne0PxyOSwJqGaxdFnkc8pLHDpGFY6db9Ao4s+7HHV0mzO
         LPFsXG31zP+VjS769+6fIVPTQ3/ZaAG39KNSfCy6zsAGCjyewk3tLw1ylkYXW94RlWZY
         WSDQPxjkQqoJYDrGd6oCqdDYJajFU5wzBeZqoXeedaSEef6eHqkEN+3EaOhAVGgPK2zk
         rvgjNZMbXngGO/cupjILQqeaYmFat72uMxChHUcP13tjXm2o2UQ+IScqE3famS9+KDYK
         4Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889253; x=1756494053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G4uVOcBa/iivnMpGsqEmtusc+mONUzr/xNCqDruNEw=;
        b=lDC+CRYLlLmNV8U6YNHVq0vDH0689PdPy6OMLLo8Tza8Kg7md2rFrrAQfCv6aGcryh
         kjDvu9qdjDJRdMuaJ+Xo/tGbs+6Iabb+5lVItCWB3mfszlrl8ZK6zuMprm770DwoKKt/
         Ar3g6OyX1RDQ0hcn69SE69UwkAT0TURH3oONJOQyEaNgqPUUjC7cUj87/xgwLqVUgvt4
         sHANRuaihP/p31Q0joz/m1unV7nTiKZGBnWapG/EQmEIn16jH8r2JOJCh+78OIu1j+qe
         z0m5X8mxqSqdB4DLeSfPCpJw+0o9dGyoWMyPkWpk0Miut7J00ZGfOkO5Myx4SDTyeEzv
         r9fw==
X-Forwarded-Encrypted: i=1; AJvYcCVUu+5Mk5tIoophRpri4YLsvTtJ481jM0XJZz6wF0vqr60FdnIvopWzy5DHTc181cjWay7JmSS3ToNzoUsv@vger.kernel.org, AJvYcCX5yulaBmljrTYc4/F7d1TSKCidA22Qa4KscsPBqAiqOtscqNbEmY4XlWVk6y8j54BZTzg=@vger.kernel.org, AJvYcCXDW+MQRfGOaoc0pFABV+DKN3NsdC6S2VaQC6IjjpUZ94WD+o+hrZtQGTFKbjCFDHwiYUdvEJBj@vger.kernel.org
X-Gm-Message-State: AOJu0YzzPh1z2pm980NDJP1IwvvGkLURHxpkw98VfDUjf1P14bGCt25a
	8ozgWuDfAR/VzTZ900h/f30jv3BDXOcCw9rysPeqTYwYTXgAsGeuNJf0AgoJyGdANTcR8t+wQSL
	pNL/yuBGjByyVnOMmyqMLsrMOSyPdZvE=
X-Gm-Gg: ASbGncuVJ0vMGfeXy3qPj/RYeD1/ScN8KHCYdzvBm0AaS7mmdvIu0s29aQE2+kI+bj7
	cX7eAZ92NS+s9rMCiD0JX3cFZmqblVTbIi78SDwyKQK/GNMww+yC0XCUZPz2ArkY+uol+C8OsIr
	/1qlAszrwqTKosa/iFF9S3by8KT3HYrkPj9jrZa+uPaj6OF9CiYS/FwPGF/6FlvAmT8PXXpsSFI
	bCgFA8yMybF6s6uZaxzf9wHlimdtiGmFg==
X-Google-Smtp-Source: AGHT+IFqeDt4xyP9+GIOv8ChYUNwdA+7nFMivdwPnGvNMZIkoKl9VMhe4tBx9FuuBlBI10NSV6shvJM3cPBvU7ZmrYU=
X-Received: by 2002:a17:90b:3c47:b0:324:fbbe:a457 with SMTP id
 98e67ed59e1d1-32517748ee5mr5102753a91.21.1755889252885; Fri, 22 Aug 2025
 12:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813073955.1775315-1-maze@google.com> <6df59861-8334-49ac-8dca-2b0bac82f2d7@linux.dev>
 <CANP3RGcJ06uRUBF=RR6bjqNnxdaSdpBpynGzNTSms0jA-ZpW6w@mail.gmail.com> <a3d437ce-c91d-47c6-9590-88b716fb6690@linux.dev>
In-Reply-To: <a3d437ce-c91d-47c6-9590-88b716fb6690@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 12:00:36 -0700
X-Gm-Features: Ac12FXxmgU6oECat9fB9U_9F3fWqtrlWLu_VfkCnOaPfi02VDFbJguKrIT9_vYY
Message-ID: <CAEf4BzabChgVsFBJPp6oKENJK=WAKPQahH8HO3fSBz_xWDH54Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: hashtab - allow BPF_MAP_LOOKUP{,_AND_DELETE}_BATCH
 with NULL keys/values.
To: Yonghong Song <yonghong.song@linux.dev>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:49=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/20/25 7:23 PM, Maciej =C5=BBenczykowski wrote:
> > On Mon, Aug 18, 2025 at 1:58=E2=80=AFPM Yonghong Song
> > <yonghong.song@linux.dev> wrote:
> > > On 8/13/25 12:39 AM, Maciej =C5=BBenczykowski wrote:
> > > > BPF_MAP_LOOKUP_AND_DELETE_BATCH keys & values =3D=3D NULL
> > > > seems like a nice way to simply quickly clear a map.
> > >
> > > This will change existing API as users will expect
> > > some error (e.g., -EFAULT) return when keys or values is NULL.
> >
> > No reasonable user will call the current api with NULLs.
>
> I do agree it is really unlikely users will have NULL keys or values.
>
> >
> > This is a similar API change to adding a new system call
> > (where previously it returned -ENOSYS) - which *is* also a UAPI
> > change, but obviously allowed.
> >
> > Or adding support for a new address family / protocol (where
> > previously it -EAFNOSUPPORT)
> > Or adding support for a new flag (where previously it returned -EINVAL)
> >
> > Consider why userspace would ever pass in NULL, two possibilities:
> > (a) explicit NULL - you'd never do this since it would (till now)
> > always -EFAULT,
> >   so this would only possibly show up in a very thorough test suite
> > (b) you're using dynamically allocated memory and it failed allocation.
> >   that's already a program bug, you should catch that before you call
> > bpf().
>
> Okay. What you describes make sense.

+1, I think there is no backwards compat concern with this extension.

> Could you add a selftest for this?

yes, please

> Could you add some comments in below uapi bpf.h header to new functionali=
ty?

+1, I'd also appreciate if you can incorporate that into libbpf API
doc comments in tools/lib/bpf/bpf.h, as we already have a decent
description of this rather complicated API, so it would be nice to
keep it up to date with this added semantics. Thanks!

Also, please shorten the subject, it's way too long.

pw-bot: cr

>
> >
> > > We have a 'flags' field in uapi header in
> > >
> > >          struct { /* struct used by BPF_MAP_*_BATCH commands */
> > >                  __aligned_u64   in_batch;       /* start batch,
> > >                                                   * NULL to start
> > from beginning
> > >                                                   */
> > >                  __aligned_u64   out_batch;      /* output: next
> > start batch */
> > >                  __aligned_u64   keys;
> > >                  __aligned_u64   values;
> > >                  __u32           count;          /* input/output:
> > >                                                   * input: # of
> > key/value
> > >                                                   * elements
> > >                                                   * output: # of
> > filled elements
> > >                                                   */
> > >                  __u32           map_fd;
> > >                  __u64           elem_flags;
> > >                  __u64           flags;
> > >          } batch;
> > >
> > > we can add a flag in 'flags' like BPF_F_CLEAR_MAP_IF_KV_NULL with a
> > comment
> > > that if keys or values is NULL, the batched elements will be cleared.
> >
> > I just don't see what value this provides.
> >
> > > > BPF_MAP_LOOKUP keys/values =3D=3D NULL might be useful if we just w=
ant
> > > > the values/keys and don't want to bother copying the keys/values...
> > > >
> > > > BPF_MAP_LOOKUP keys & values =3D=3D NULL might be useful to count
> > > > the number of populated entries.
> > >
> > > bpf_map_lookup_elem() does not have flags field, so we probably
> > should not
> > > change existins semantics.
> >
> > This is unrelated to this patch, since this only touches 'batch'
> > operation.
> > (unless I'm missing something)
> >
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > > > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > > > ---
> > > >   kernel/bpf/hashtab.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > > > index 5001131598e5..8fbdd000d9e0 100644
> > > > --- a/kernel/bpf/hashtab.c
> > > > +++ b/kernel/bpf/hashtab.c
> > > > @@ -1873,9 +1873,9 @@ __htab_map_lookup_and_delete_batch(struct
> > bpf_map *map,
> > > >
> > > >       rcu_read_unlock();
> > > >       bpf_enable_instrumentation();
> > > > -     if (bucket_cnt && (copy_to_user(ukeys + total * key_size, key=
s,
> > > > +     if (bucket_cnt && (ukeys && copy_to_user(ukeys + total *
> > key_size, keys,
> > > >           key_size * bucket_cnt) ||
> > > > -         copy_to_user(uvalues + total * value_size, values,
> > > > +         uvalues && copy_to_user(uvalues + total * value_size,
> > values,
> > > >           value_size * bucket_cnt))) {
> > > >               ret =3D -EFAULT;
> > > >               goto after_loop;
> > >
> >
> >
> > --
> > Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google
>
>

