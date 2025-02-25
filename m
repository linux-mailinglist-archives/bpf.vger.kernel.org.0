Return-Path: <bpf+bounces-52521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A74A44463
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7920A188200B
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C424926BDAF;
	Tue, 25 Feb 2025 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5LpAEJe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64A267B9D
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497309; cv=none; b=qnavOPgjiUTE/Vj1AHnMbh3PUxHeQJY3gqjxRY7gcUVL3y/SqPRFF+JbO9OBZ6gHLZzzkkrNV4ybRrIUw9YwhB/yuQrIhq9xlXjOtbfd7/M1m+c+qtv2bNYZui3XqL4nVaYXL/w3Ov/AoFJdhz8pkhjMDF+ponH0D1+dDjiW2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497309; c=relaxed/simple;
	bh=royKt41FIIqKZjTyAmx9ogIDixOOYrK/CyLg4+LAOj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSe+jo/u9E29C6eF9juYmMoY94kVXGLdC/SR4Pk7oJYVeqMjz63topFGE4842ZMnzLuMvAFgUzsl0BahJ5hwHB3OTEgvTYuyG/omxPSPGb0QdO9ytJ0ltlUJ04LXlmwUAqg60y4SV+EsEpvCODX7ZUxpf1wofUu7s7m9HWIxSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5LpAEJe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d39a5627so89493955ad.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 07:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740497307; x=1741102107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/g9QfC1L0o6PIjs+Bu+zdCazeO4dbb1s7pjI67ryNc=;
        b=k5LpAEJeE51B6WMMppVSG5OfDzXOLhsvDMX0OY6eWKRo3Ir2rUPw7eewiPWqPd01GC
         uZPpoSht4ep9n5laIhHeXM0iovP72sKK6ybsAnMjpfXeUfceXAj9Qlda45WAGcj4cjL8
         ipX3PSk2TJW4nOrxDSSS0swuHwD/fd97o47l/ZwLG1GX5sNqRsMZhWA9cJmOJfKzIFJm
         GHDQ9PyOw2AD/rQCV/pCCu28JVV6Ql23q7UMBRIE1rviU6MFyea/KrxZqkL08y610LGo
         4G0RpaxabjU7WdTP0pCmgyPDL5iThmbMnl+db8TBz/Ihl2dU5+G/vf1gBT6SmgpL/s9W
         qpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497307; x=1741102107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/g9QfC1L0o6PIjs+Bu+zdCazeO4dbb1s7pjI67ryNc=;
        b=wYws5wfBE2WTjg8J4GRt/pH72q79C5VTase36d538pKJb4yEDx2xkqibYYkP0KuswT
         z1v5LSxWk++2zt762lvmJF4bhKAtYPqu78I/CcgFh3Hl5fXhrwkXbxJE8FAy2/9sGB/G
         9wMrx5MqjTp92OxgVhZCeqy4xa6HaHjh9kjwGkGJ120EtdMQLTRsMBpAngl+OV0J4+25
         MLP30SnI7yJEP2L7INzpteVsQiO6cbGqvVHcqOUaYZ6TRia/tQprs4P02ddZQ9vBpg9E
         ubqZuNvIUwec/ysUmP/HMAuw1K5oYS6R3XxCP58PmyklLKfAM37HC0YsKTMqjAgAkAub
         zcBw==
X-Gm-Message-State: AOJu0YzkA8btNlaHoa4sQfTQaBwTSsmexm9ja6CtID5YIuX3OMfCFLEQ
	pJJXcdLz7rqIkDD2G0CD+KEXrUCdCrgrcZogKfA+Y7HI37BqOTqNl1rQq7jIzR6SlAb6hCT901B
	wH1m/EeiOVajKOaSfTVwr1UPXuLXrYA==
X-Gm-Gg: ASbGncsIDExObaaOBaE/If3jp7iDJzYv4rpSUibJ2eYfCmPNEjdOOBFfi57ss2ciZme
	BCY0gUcO280GCP2uhJlDAD4hrdIrTb/CxiPwmaLkW/keIcw4r82iUWNZMJou16/Iq93TRDlQ3vG
	KNpC+mvQ==
X-Google-Smtp-Source: AGHT+IG/PmKJ4OjQsLmkz0zKeb0gmh6InPwuEz0Qx4UxUwYD5mTbNQHELIjv8svSiquXb97p3C1syAG/kljdtUIIaPQ=
X-Received: by 2002:a17:90b:3ece:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-2fce78b77eemr33191467a91.17.1740497306964; Tue, 25 Feb 2025
 07:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com>
 <20250221221400.672980-3-mykyta.yatsenko5@gmail.com> <CAEf4BzbNs0AXncqci66XZpUsyMTTEYoa7-bfpUT8zwaMmKo5iA@mail.gmail.com>
 <137a8ca2-c140-4b28-893d-0a4f528a9a83@gmail.com>
In-Reply-To: <137a8ca2-c140-4b28-893d-0a4f528a9a83@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Feb 2025 07:28:13 -0800
X-Gm-Features: AWEUYZlXtSwRhGSk-ZpH7XgJmaEvYcIEzOdvGhmjdvbxfavLN1ingPIhQCUt3VI
Message-ID: <CAEf4BzantbSfaa4mLktg=-WAGyqy7gA_hkUfbspOrHJMUnqvKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf/helpers: introduce bpf_dynptr_copy kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:33=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 24/02/2025 23:23, Andrii Nakryiko wrote:
> > On Fri, Feb 21, 2025 at 2:14=E2=80=AFPM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Introducing bpf_dynptr_copy kfunc allowing copying data from one dynpt=
r to
> >> another. This functionality is useful in scenarios such as capturing X=
DP
> >> data to a ring buffer.
> >> The implementation consists of 4 branches:
> >>    * A fast branch for contiguous buffer capacity in both source and
> >> destination dynptrs
> >>    * 3 branches utilizing __bpf_dynptr_read and __bpf_dynptr_write to =
copy
> >> data to/from non-contiguous buffer
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   kernel/bpf/helpers.c | 55 ++++++++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 55 insertions(+)
> >>
> > LGTM, a bit of unnecessary code I pointed out, but I like how minimal
> > and clean all this looks, and completely reused pre-existing APIs.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> >
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 6600aa4492ec..264afa0effb0 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2770,6 +2770,60 @@ __bpf_kfunc int bpf_dynptr_clone(const struct b=
pf_dynptr *p,
> >>          return 0;
> >>   }
> >>
> >> +/**
> >> + * bpf_dynptr_copy() - Copy data from one dynptr to another.
> >> + * @dst_ptr: Destination dynptr - where data should be copied to
> >> + * @dst_off: Offset into the destination dynptr
> >> + * @src_ptr: Source dynptr - where data should be copied from
> >> + * @src_off: Offset into the source dynptr
> >> + * @size: Length of the data to copy from source to destination
> >> + *
> >> + * Copies data from source dynptr to destination dynptr
> >> + */
> >> +__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_o=
ff,
> >> +                               struct bpf_dynptr *src_ptr, u32 src_of=
f, u32 size)
> >> +{
> >> +       struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst_=
ptr;
> >> +       struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src_=
ptr;
> >> +       void *src_slice, *dst_slice;
> >> +       char buf[256];
> >> +       u32 off;
> >> +
> >> +       src_slice =3D bpf_dynptr_slice(src_ptr, src_off, NULL, size);
> >> +       dst_slice =3D bpf_dynptr_slice_rdwr(dst_ptr, dst_off, NULL, si=
ze);
> >> +
> >> +       if (src_slice && dst_slice) {
> >> +               memmove(dst_slice, src_slice, size);
> >> +               return 0;
> >> +       }
> >> +
> >> +       if (src_slice)
> >> +               return __bpf_dynptr_write(dst, dst_off, src_slice, siz=
e, 0);
> >> +
> >> +       if (dst_slice)
> >> +               return __bpf_dynptr_read(dst_slice, size, src, src_off=
, 0);
> >> +
> >> +       if (bpf_dynptr_check_off_len(dst, dst_off, size) ||
> >> +           bpf_dynptr_check_off_len(src, src_off, size))
> >
> > __bpf_dynptr_read() and __bpf_dynptr_write() do these checks, so
> > either it's unnecessary and we should keep all the sanity checking to
> > dynptr_{read,write}, OR we ensure __bpf_dynptr_read/write don't do
> > sanity checking every single time and we do full checking here, but
> > then we'll need to also check !dst->data ||
> > __bpf_dynptr_is_rdonly(dst)
> >
> > I think for now, I'd keep all the sanity checking to read/write and
> > not over-optimize. So let's drop these checks?
> I added this check to make the process of copying data chunk by chunk
> more transactional/atomic,
> trying to make the outcome of partial data copying less likely.
> Other checks I assume would equally fail/pass for the 1st and last
> chunk. Of course, we don't give
> any atomicity guarantee here, but I thought size mismatch could be a
> common case to handle.

Ah, makes sense. Because the generic read/write below will work on
small chunks we won't detect violation until much later. Ok, then I
guess this is fine as is.

> > pw-bot: cr
> >
> >> +               return -E2BIG;
> >> +
> >> +       off =3D 0;
> >> +       while (off < size) {
> >> +               u32 chunk_sz =3D min_t(u32, sizeof(buf), size - off);
> >> +               int err =3D 0;
> > nit: unnecessary =3D 0 initialization, you are overwriting it immediate=
ly below
> >
> >
> >> +
> >> +               err =3D __bpf_dynptr_read(buf, chunk_sz, src, src_off =
+ off, 0);
> >> +               if (err)
> >> +                       return err;
> >> +               err =3D __bpf_dynptr_write(dst, dst_off + off, buf, ch=
unk_sz, 0);
> >> +               if (err)
> >> +                       return err;
> >> +
> >> +               off +=3D chunk_sz;
> >> +       }
> >> +       return 0;
> >> +}
> >> +
> >>   __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> >>   {
> >>          return obj;
> >> @@ -3218,6 +3272,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_size)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_clone)
> >> +BTF_ID_FLAGS(func, bpf_dynptr_copy)
> >>   #ifdef CONFIG_NET
> >>   BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
> >>   #endif
> >> --
> >> 2.48.1
> >>
>

