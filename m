Return-Path: <bpf+bounces-53924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CB3A5E46F
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14BF7ACA2D
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05A24BBEF;
	Wed, 12 Mar 2025 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRQfoE6m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF321D9A54
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807910; cv=none; b=D6An6PJclTeQS9vzboTQ4WUkQEbM4TOJHlLP9NQrNLY4e9jYaj4FP0b2SvJ7aciZLQVumoQmWiX+J9kfvXGuPKW6n8VvssQGe2lA65Kwj61xJ7xwV3veL+Gy8xX8siStj5i3cTwWCuaEmPuz1vEv8FFM8FXv0k/4W0F6JcVHEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807910; c=relaxed/simple;
	bh=njTkUx6/rVmCdoP8IYvPKvdO32QP8noAcUW2WxXWqrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWvqGcuauEeZKoVwau3uHzwuOb8gj2888omgM753qnUSt8Hv1/SNb6jj620EyTc4IDdTyc2Yv5FCm2+D8DNy2yRcEBpxU51CkTsfzcU9GFjFpf8YJgPogvQbgmckWlSe/znjfegGv08Z2P7fvqHI+GgXAQ+kUggbUX5IPRad1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRQfoE6m; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2243803b776so6309045ad.0
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741807908; x=1742412708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDYUFwQ2z5MYdqVqQT0HPZYxwkbzBCCCbmlibajhrSo=;
        b=hRQfoE6mDoxttKowpV4oBBJ7NmtaCpSOCxSK9VZ+gGSfsHVsqa8k82bvSs8zZRt/ce
         ZMchVEENgozn7b5vHIJh6/ai9Hk35QzunVvObkL7H7+ZOU9ZF+BtjVQwRWp6CWG4PFtd
         LsxIzVm6MGsS8msRL/zbbap59+PfoD4hLfYXZVYgMhops5Sfu+MJVOQbxErHxab2+VQ8
         qGa3d25wh2y9MadMB5PHYApSLifTM62eYKOI65tN7CKIgJKhqduxNeW9dw2YR73I9C5+
         7GmQ1mKAjZB7BOJt7535Q30iz1cB71aDw+CFq2TYLYmilIZpIgZtUZzWD5JUK2e6y6fs
         XtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807908; x=1742412708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDYUFwQ2z5MYdqVqQT0HPZYxwkbzBCCCbmlibajhrSo=;
        b=ZptWrWaIb6OwuKbBpjIS9f07ACX35QcBFuvzWZHC9WsOsrqlvOyO0vafBJvbOO9kqd
         OXQtT7l6fY0qrcdSExBE/fo980yssDlKIcoWyqzA1jrJDmHVfobahY8zlCldElDFC0G8
         Z6xfT3JhXXJ/F02w64cjnFIGSKosNxxQCk48NF+4m7Ya+06yFOV3xAc0DeT1Jx/nJx5Z
         TI7p/08mTumz62NTPy7zFP3alyxtHTlt2hr8wNRQ79eb4Q3kiK8yg3ymv9rE68pmc0pX
         60D7RhJyxuBSrLOuY4d31GfPVpF9n68Rr4+9jr33xxa3/DkcOLj8HATx1FHhWHZVDq+v
         aPyA==
X-Gm-Message-State: AOJu0YyDH/yu3/Pb2qs7Yy05zSHDztkuIDQDu5KnnP016e+G+/8yw3iA
	M7Dz0u8fFJUVA0adVI9aV5kFfLjpCGVS+c1Dj5Ot0jqcmR4gY51vD+BmnilLnQY80Ni3athcO0X
	VM1IOJ8QwP9cxkxYTgEhCeGJXxy8=
X-Gm-Gg: ASbGncsQEbR2uF35PVZ/+fqVM5UFuUC44iWfBkB15yF3LhxJamWhuZSj1LiBnwy6nYB
	jlZSc88CvCKi5OJDbk7ckJRpvheI7w3i4sqbpc4VjRZqYGkb0WYSxyibizPjXBw8AAXmJEUzE8o
	vWrcj00fkwcEobx7SDediBo02hKvoZzwlftKovCydDbg==
X-Google-Smtp-Source: AGHT+IHw/XjiNMmxJpEylVrTmMlBBbGIa4dxnBMGb1I0fzC4nqiXC0+Hr/nRyQ0Qs8bVuQX2bolyU+8HyMHkmULy5sE=
X-Received: by 2002:a17:902:e74f:b0:224:76f:9e44 with SMTP id
 d9443c01a7336-2242887b531mr298797795ad.8.1741807908052; Wed, 12 Mar 2025
 12:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312010358.3468811-1-linux@jordanrome.com>
 <CAEf4Bzb_TqinCgS92ehz8p00PQ=Z3U-8cTKBn9gfDu0Dh4EcNg@mail.gmail.com> <CA+QiOd66W5hajNCCbL+07xcCBnGUuSORwfDW5XC0Ev-w5Hgk+A@mail.gmail.com>
In-Reply-To: <CA+QiOd66W5hajNCCbL+07xcCBnGUuSORwfDW5XC0Ev-w5Hgk+A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Mar 2025 12:31:36 -0700
X-Gm-Features: AQ5f1JpYUmevaUEITvbtSwK2JGyCyR0LFDkASCFAqs6IB6c1PQ0MnDwM_pFycIM
Message-ID: <CAEf4BzZwwAyaToxUtmVDB-dQ7HGNcZT1ZquLH81r76A8t8u6uA@mail.gmail.com>
Subject: Re: [bpf-next v4] bpf: adjust btf load error logging
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:21=E2=80=AFPM Jordan Rome <linux@jordanrome.com>=
 wrote:
>
> On Wed, Mar 12, 2025 at 2:40=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Mar 11, 2025 at 6:04=E2=80=AFPM Jordan Rome <linux@jordanrome.c=
om> wrote:
> > >
> > > For kernels where btf is not mandatory
> > > we should log loading errors with `pr_info`
> > > and not retry where we increase the log level
> > > as this is just added noise.
> > >
> > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > ---
> > >  tools/lib/bpf/btf.c             | 36 ++++++++++++++++++-------------=
--
> > >  tools/lib/bpf/libbpf.c          |  3 ++-
> > >  tools/lib/bpf/libbpf_internal.h |  2 +-
> > >  3 files changed, 23 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index eea99c766a20..7da4807451bb 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -1379,9 +1379,10 @@ static void *btf_get_raw_data(const struct btf=
 *btf, __u32 *size, bool swap_endi
> > >
> > >  int btf_load_into_kernel(struct btf *btf,
> > >                          char *log_buf, size_t log_sz, __u32 log_leve=
l,
> > > -                        int token_fd)
> > > +                        int token_fd, bool btf_mandatory)
> > >  {
> > >         LIBBPF_OPTS(bpf_btf_load_opts, opts);
> > > +       enum libbpf_print_level print_level;
> > >         __u32 buf_sz =3D 0, raw_size;
> > >         char *buf =3D NULL, *tmp;
> > >         void *raw_data;
> > > @@ -1435,22 +1436,25 @@ int btf_load_into_kernel(struct btf *btf,
> > >
> > >         btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
> > >         if (btf->fd < 0) {
> > > -               /* time to turn on verbose mode and try again */
> > > -               if (log_level =3D=3D 0) {
> > > -                       log_level =3D 1;
> > > -                       goto retry_load;
> > > +               if (btf_mandatory) {
> > > +                       /* time to turn on verbose mode and try again=
 */
> > > +                       if (log_level =3D=3D 0) {
> > > +                               log_level =3D 1;
> > > +                               goto retry_load;
> > > +                       }
> > > +                       /* only retry if caller didn't provide custom=
 log_buf, but
> > > +                        * make sure we can never overflow buf_sz
> > > +                        */
> > > +                       if (!log_buf && errno =3D=3D ENOSPC && buf_sz=
 <=3D UINT_MAX / 2)
> >
> > Original behavior was to go from log_level 0 to log_level 1 when the
> > user provided custom log_buf, which would happen even for
> > non-btf_mandatory case. I'd like to not change that behavior.
> >
>
> I don't quite understand why we want to increase the log level
> if btf is not mandatory. Users will still get an info message that
> btf failed to load and if they are still curious, they can increase
> the log level themselves right? The goal of this patch is to reduce
> log noise in cases where btf fails to load and is not mandatory.

Program's BTF is almost always not mandatory, so we'll basically never
log BTF verification failure (only for struct_ops stuff), even with
user-provided custom log buffer, which makes this whole logic much
less useful.

Perhaps we just need to keep existing logic as is? It's not expected
for BTF to fail to be loaded into the kernel, even for old kernels.
libbpf does BTF sanitization for that reason. So when this BTF loading
fails, it usually does indicate a real issue.

That's exactly what happened with the original issue that prompted
your patches. And that's a good thing that the user was bothered by
those warnings, which eventually led to fixing an issue with a missing
patch in their backported kernel, right?

Let's just keep things as is for now. I'd rather users complain about
this rather than these BTF upload failures go unnoticed forever.

>
> > Did you find some problem with the code I proposed a few emails back?
>
> Truth be told, I didn't like the added complexity in the conditionals.
> I tried something similar in an earlier version and it led to a SEGFAULT
> when trying to access `buf[0]` which had not been allocated.
>
> > If not, why not do that instead and preserve that custom log_buf and
> > log_level upgrade behavior?
> >
> > pw-bot: cr
> >

[...]

