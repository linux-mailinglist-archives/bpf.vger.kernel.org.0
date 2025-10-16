Return-Path: <bpf+bounces-71151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CADBE567E
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5043AAC66
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE42DF139;
	Thu, 16 Oct 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc1rXWJ2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65129298CBE
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646553; cv=none; b=LFMdRzbWUQADBnYP/eXh/ed60f1gFEPNu49DbOjWqoRIpPlVS170ef8pmE04nFazepb7cn7/jP4u+qypSkC8BzS7g4tE1jEfFDU+PKByi4+4SL3F3negQD7y/clhk8YZPESEIg9XHrHByWBlSJyx9m4lJXr5jwvJldnKtojTKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646553; c=relaxed/simple;
	bh=ttSw3/1q037rdg0AAOnOuAZwtoIsMdOv+UnK1ZDVr44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVhJPgf3PjcqCOvPDNEHahY2+s25S0d9lZRTL5SXhZsNmSp9vYaGSr2FZi10x1VO/qRVSp7L1zxitPdS+L+W4JFvViy0WcCA/o5i2AX+y2azr2lslFGgkUk4v8YdYt4yVz+p8LD1oLapnIgJE1FcBHtCy+JVjpOW97X6H4D27fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc1rXWJ2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bb0472889so1227809a91.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646552; x=1761251352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H31z3GplXWTDgSJBWrwQBVCp+uWMs7P8NecwPCRbEI=;
        b=Vc1rXWJ21n3uEb4F97wZkV0c+v8vaf9zU59SSx1m8QRMV8Naj9gCjqhbjmj58jDsHK
         Pq+/b1LePIOnLPFYkasNZVWjYYUe3LLPQ28QrNbACiojLrzrnY6WMnQ+9VBNMNSriAQO
         8BSPqhVXJDc5PyvJiwFs7AJSzr/u9VZZHHAmfJiQRhFZeSwF6Sw8EfpKILjS9coVrovg
         1IpwMxo3LaKGtuBj4sFSXDxbB4U8R/qQCt8XoKdu9RzVupl4VCoed9patHQeIuAKNuUG
         IpiPy5ODCrn9FWvVIXwRedkYg7nnIftJ4isMpB0kqrA4Q19jIpj3K0Zwi3A3tGZEJY3T
         gVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646552; x=1761251352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7H31z3GplXWTDgSJBWrwQBVCp+uWMs7P8NecwPCRbEI=;
        b=tlWIES8wvgWMzjTEbdmqUzMdcbG0IK9y5y0RaCu1ha6aSurQ5FXsxkD9jIHdIn/WBG
         5V30f6YAR7vtECPVGu86mUfrdVWOHUXswvh4/LFD8n/KwJG2LxCfP1mXRWm/t/puRZJO
         E/gEYTAnhVD6afFgwXJTH8y8P83O64VcthGCOIT1FbUzHAdyxwF7Wh9TqAYzdnPT+2dP
         FB4/IKeOUr/yyRk4QPWg40opYurfuNEkfUYQenIYiAeZ6F1g8oziLSZMqukUbt7uXveT
         NhfNGUIN3uytDN/VYqjk21wbupaa2m5BeSIGp+RmBxX0Q6osiY3n3owePDpoGX9E8cHB
         IPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJiN+NRrQlk46f7vAaYPCthhfjhLfzQnCYOdQ5o3aFy3S2N5p5ogrTkmIkixHD0guBSX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVX6QaxR+hBkorlYmH0VhNC48bEORO1LkmIfXXyR/0KnAZFWkv
	JOLteIeLXwxw8gMpsZBTUTNgJKnlgSHxC4RRKb67ADzYPADGtqNDl1aGa4BHXuNK+pG5WLZ2/O3
	dY+gUjmFB27mPKzEPsloM6j/gYRsEsH8KPg==
X-Gm-Gg: ASbGncstACfgTbuflvmpDegi70lurpE4v8n2YIRAmWv/qKWeEKIO60ZE9QWPHxiPJsJ
	YwNqp64iGGlyao6tdDhh0g4KKlX1HixIxUa+giSTwMmmAgLRUXO82goTX1uliHk8KNHsRJ/tvzT
	WKEiSn8i/0KTXQkZtZk0QJqYi7Ez4VUGDUGTOl+gXVEruZaiWhYrlBMdz7tm6shXldQpstvD0Sd
	f0CC/X2YC/SlfOGQjXRubEwMfdBaLNnVQ9BXwjUbNbzz9RYMPtUb5oKd9C77MKazxjGP6vZqMi5
	7XZKtYjcBB0=
X-Google-Smtp-Source: AGHT+IGEUDoVk538reua1hYFmjrqZwDY1qJOSY+oeAiZyQ4t5fHOPdj/2e0YP+TTM6b+Mcr0B2jHlMqi5UHhOBeEzCo=
X-Received: by 2002:a17:90b:3e43:b0:32e:36f4:6fdc with SMTP id
 98e67ed59e1d1-33bcf86beaemr1396266a91.4.1760646551699; Thu, 16 Oct 2025
 13:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
 <20251015161155.120148-9-mykyta.yatsenko5@gmail.com> <a2b0241a646c991c280fbc35925e0a52d01b419a.camel@gmail.com>
 <0cb5dec3-5019-4ed9-8cf5-ed2ec0d8f74c@gmail.com> <aeeed0cab6875dbef70857868df003a638d647d8.camel@gmail.com>
In-Reply-To: <aeeed0cab6875dbef70857868df003a638d647d8.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 13:28:56 -0700
X-Gm-Features: AS18NWBHKIqDSO9Zs7pbZK0vhmPmPomoGayR_-29xNAVchXPfGBHa2kuyK4X_jE
Message-ID: <CAEf4BzZnxJE6q7Ww+KzYQGA1fMZ3Rprh72S40oKKLNMP31GcUg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/11] bpf: add kfuncs and helpers support for file dynptrs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-10-15 at 23:25 +0100, Mykyta Yatsenko wrote:
> > On 10/15/25 23:16, Eduard Zingerman wrote:
> > > On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> > >
> > > Overall, lgtm.
> > >
> > > [...]
> > >
> > > > @@ -4253,13 +4308,45 @@ __bpf_kfunc int bpf_task_work_schedule_resu=
me(struct task_struct *task, struct b
> > > >           return bpf_task_work_schedule(task, tw, map__map, callbac=
k, aux__prog, TWA_RESUME);
> > > >   }
> > > >
> > > > -__bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags,=
 struct bpf_dynptr *ptr__uninit)
> > > > +static int make_file_dynptr(struct file *file, u32 flags, bool may=
_sleep,
> > > > +                     struct bpf_dynptr_kern *ptr)
> > > >   {
> > > > + struct bpf_dynptr_file_impl *state;
> > > > +
> > > > + /* flags is currently unsupported */
> > > > + if (flags) {
> > > > +         bpf_dynptr_set_null(ptr);
> > > > +         return -EINVAL;
> > > > + }
> > > > +
> > > > + state =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_=
file_impl));
> > > > + if (!state) {
> > > > +         bpf_dynptr_set_null(ptr);
> > > > +         return -ENOMEM;
> > > > + }
> > > > + state->offset =3D 0;
> > > > + state->size =3D U64_MAX; /* Don't restrict size, as file may chan=
ge anyways */
> > >
> > > If ->size field can't be relied upon, why tracking it at all?
> > > Why not just return U64_MAX from __bpf_dynptr_size()?
> >
> > Good point. This is a little bit ugly part of the implementation
> > bpf_dynptr_adjust()
> > is still implemented for the file dynptr (for the sake of supporting
> > generic dynptr API),
> >   and it sets the size, because it makes sense that
> > bpf_dynptr_adjust(start, end) leaves dynptr
> > with size =3D end - start.
>
> I see, makes sense.
> Thank you for explaining.

Um... Not sure why it's ugly :) but I want to elaborate a bit (and
let's include those details in the commit itself, please).

For all dynptrs before file dynptr size serves double purpose. On
construction, it denotes actual size limitation beyond which it would
be unsafe to access contents. But it's also possible with
bpf_dynptr_adjust(), especially in combination with
bpf_dynptr_clone(), to create a more restricted view on the original
dynptr, which will artificially limit access to portions of dynptr
contents. Just like, e.g., in Go or Rust you can have an underlying
bigger array, but then create a smaller slice on top. Accessing
contents beyond imposed slice boundaries is invalid.

Same idea here as well. But for file dynptr, determining size
initially is a) not necessary (freader never knows the size, actually,
just attempts to get folio for given file offset) and b) if we ever
support creating file dynptr for non-locked binary (unlike vma's
vm_file, for example), then this size can increase or shrink anyways.
So initial size doesn't matter for file dynptr.

But the artificially limited size with bpf_dynptr_adjust() does make
sense to keep (you can imagine generic dynptr-based content hashing
functions, and you'll pass a small section of file for hashing into it
using bpf_dynptr_clone() + bpf_dynptr_adjust()). Which is why we track
it. And setting it to zero would be inconvenient for all the above
reasons, so U64_MAX is a better initial value (still prevents all the
potential size+offset overflows, without any extra logic).

