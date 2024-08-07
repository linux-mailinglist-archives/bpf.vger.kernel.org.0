Return-Path: <bpf+bounces-36580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71AA94AC1E
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519421F21803
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF5A81AB1;
	Wed,  7 Aug 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1cvL25C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0182823AF
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043532; cv=none; b=a5XzJB+bSpdl0xlZQaLF3z45GHffx6VbJa0YO+pb7QiKNmGgjVcgtSoakK8fXHN+/t/2PgfmciP4kBfXcXsqubdVvwpuEv1STvoFG4u/ubK9a3x37uRi3NB0GuqO3FSeIcsRUyCN92ODLBVQjPp62mKg5FB1s0Q3x7sJukfE0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043532; c=relaxed/simple;
	bh=bRKUi30RMYxqN1vImSNMcupQ8hYprU/b2OCvXF7tbnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6e6WxyZi4JwS8oBZNFRJ4quKgyRXE1l/Y48JHuckH1jio8dD0+M4OJyU0qkBGEsbrUmPtiUjpM0SHIesdyD3NQoafPR+gFRAaobc7Q+6of0j5C4fEMAkR64wyTIhz8qnRFkaM7WIK9YTEYYo8q300m5FIs09uLBWr0kt3lMU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1cvL25C; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so32597a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723043525; x=1723648325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Reg64BzTEW8POxvEfp7qJ6INaoy1Bvbz936jHnsbN1I=;
        b=q1cvL25CMZ9lsSNiaMHvlwD7kUPAGjrEn2phJWuy2j0av/ft7jLKOJC8tfxlmHWDfB
         Uh64gaD060+P4BG+WAycNXG77DMTfRLPJuptD3Douw098TjYjSVX3h2kQdZaFw2oAE06
         uXpogDPYDlX3SmWfrkK+idQ8bEjAc+KtEnhPCFTOwocQmTV00u9gn+ddqmkhGvqPSpf4
         6SkQGpdWCg9mUV2a34XX2+qCiDbE3FBk+xRtDK9KrldPDafTBcs2hKjcYxle48XdhU4x
         z9rRqk4uC56bXEVE7F1sisiGNnHHMavDQrgbfXE4csF9tpOC1CczIGrjzeFG+i7JG+B4
         ShZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723043525; x=1723648325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Reg64BzTEW8POxvEfp7qJ6INaoy1Bvbz936jHnsbN1I=;
        b=RY8USHXOtvAHH7CEwTEGe0f6kxQZV4L6ig9vY07yL2/tm9bFuhhheh0R892pF20Ghx
         /h25SnUYqzlATrNl0nG/YfDs0uhp4cFbBttlZd4C9yfeIFkuKAkTAqCOsIZtgV7HYYTS
         ror+4ae+oCANEowYuobfux109JCK86Rt4Jlg3op6QF4NRCrr1O4pnrXKr5ja+IJLonbu
         6BSWjSOr06QL90M8+7+QZyqSNDMUWIxDmDN0nmgZZ1lzRDp81lxJl/jijKI6FEFNDxc1
         p7dFfxaIKTfQuTgAo01j3NKyV99iTbkXGiEd6TuvBHrSFXb2CJT9W1OI1LzH3fww41cZ
         +Pag==
X-Gm-Message-State: AOJu0YyIEOGlbRW2EukBk8hjcyjU/1O+hojw8Nt0RPiYsY8s3UsCYD93
	6FRjTo4jf0NdHApj1LrZtykKzY9BvhRaiHFaTD3OPBVnVn2DBSkikGagtE609zFGCibPlhFXUkK
	9Gk3Hz5iSEwI+AzaernTg0LkRNo0vbuExAcDK
X-Google-Smtp-Source: AGHT+IFU/HjdkrHlEqJan0IsMYPZd15vMCc+0df0XMOugJDHHaYzhvcCr4V4IffSa5d9d6d78evOeFUAbReExjzgqQ8=
X-Received: by 2002:a05:6402:26cb:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5bba35640c3mr140510a12.3.1723043524550; Wed, 07 Aug 2024
 08:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730203914.1182569-1-andrii@kernel.org> <20240730203914.1182569-2-andrii@kernel.org>
In-Reply-To: <20240730203914.1182569-2-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 17:11:27 +0200
Message-ID: <CAG48ez16gwq4YZrnPn2OmuSyz2rXM0KKVgb+UjB5GocKZGNgQQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/10] lib/buildid: harden build ID parsing logic
To: Andrii Nakryiko <andrii@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Matthew and fsdevel list for pagecache question

On Tue, Jul 30, 2024 at 10:39=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> Harden build ID parsing logic, adding explicit READ_ONCE() where it's
> important to have a consistent value read and validated just once.
>
> Fixes tag below points to the code that moved this code into
> lib/buildid.c, and then subsequently was used in perf subsystem, making
> this code exposed to perf_event_open() users in v5.12+.

One thing that still seems dodgy to me with this patch applied is the
call from build_id_parse() to find_get_page(), followed by reading the
page contents. My understanding of the page cache (which might be
incorrect) is that find_get_page() can return a page whose contents
have not been initialized yet, and you're supposed to check for
PageUptodate() or something like that before reading from it.

Maybe Matthew can check if I understood that right?


Also, it might be a good idea to liberally spray READ_ONCE() around
all the remaining unannotated shared memory accesses in
build_id_parse(), get_build_id_32(), get_build_id_64() and
parse_build_id_buf().

> Cc: stable@vger.kernel.org
> Cc: Jann Horn <jannh@google.com>
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Fixes: bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  lib/buildid.c | 51 +++++++++++++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 24 deletions(-)
>
> diff --git a/lib/buildid.c b/lib/buildid.c
> index e02b5507418b..d21d86f6c19a 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -18,28 +18,29 @@ static int parse_build_id_buf(unsigned char *build_id=
,
>                               const void *note_start,
>                               Elf32_Word note_size)
>  {
> +       const char note_name[] =3D "GNU";
> +       const size_t note_name_sz =3D sizeof(note_name);
>         Elf32_Word note_offs =3D 0, new_offs;
> +       u32 name_sz, desc_sz;
> +       const char *data;
>
>         while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
>                 Elf32_Nhdr *nhdr =3D (Elf32_Nhdr *)(note_start + note_off=
s);
>
> +               name_sz =3D READ_ONCE(nhdr->n_namesz);
> +               desc_sz =3D READ_ONCE(nhdr->n_descsz);
>                 if (nhdr->n_type =3D=3D BUILD_ID &&
> -                   nhdr->n_namesz =3D=3D sizeof("GNU") &&
> -                   !strcmp((char *)(nhdr + 1), "GNU") &&
> -                   nhdr->n_descsz > 0 &&
> -                   nhdr->n_descsz <=3D BUILD_ID_SIZE_MAX) {
> -                       memcpy(build_id,
> -                              note_start + note_offs +
> -                              ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhd=
r),
> -                              nhdr->n_descsz);
> -                       memset(build_id + nhdr->n_descsz, 0,
> -                              BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> +                   name_sz =3D=3D note_name_sz &&
> +                   strcmp((char *)(nhdr + 1), note_name) =3D=3D 0 &&
> +                   desc_sz > 0 && desc_sz <=3D BUILD_ID_SIZE_MAX) {
> +                       data =3D note_start + note_offs + ALIGN(note_name=
_sz, 4);

I don't think we have any guarantee here that this addition won't
result in an OOB pointer?

> +                       memcpy(build_id, data, desc_sz);

I think this can access OOB data (because "data" can already be OOB
and because "desc_sz" hasn't been checked against the amount of
remaining space in the page).

> +                       memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX -=
 desc_sz);
>                         if (size)
> -                               *size =3D nhdr->n_descsz;
> +                               *size =3D desc_sz;
>                         return 0;
>                 }
> -               new_offs =3D note_offs + sizeof(Elf32_Nhdr) +
> -                       ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, =
4);
> +               new_offs =3D note_offs + sizeof(Elf32_Nhdr) + ALIGN(name_=
sz, 4) + ALIGN(desc_sz, 4);
>                 if (new_offs <=3D note_offs)  /* overflow */
>                         break;

You check whether "new_offs" has wrapped here, but then on the next
loop iteration, you check for "note_offs + sizeof(Elf32_Nhdr) <
note_size". So if new_offs is 0xffffffff at this point, then I think
the overflow check here will be passed, the loop condition will be
true on 32-bit kernels (on 64-bit kernels it won't be because the
addition happens on 64-bit numbers thanks to sizeof()), and "nhdr"
will point in front of the note?

>                 note_offs =3D new_offs;

