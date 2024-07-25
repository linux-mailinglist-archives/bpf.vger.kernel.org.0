Return-Path: <bpf+bounces-35661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8A93C937
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 21:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D037283534
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB36BFCA;
	Thu, 25 Jul 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDYLFYvW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC563C7
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937498; cv=none; b=SFj8dIBCl+gNIp+ZFkTfEq8VykA4tDRy9OqkSpQUYadQD1gxKDjO9dbWveOWHEsjbpTn4tbm7fSsz5JZa+ckMIjELCBsGlX0QEB5cezF+g5jPS7GT33qSKEEFsJkCwbLo1X+Zo093cqFgUSu6ho+/istRTkon8r3FJNQIc+Ekdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937498; c=relaxed/simple;
	bh=HKqFPaLFJu87DJWhbhNRj1w5zOOZRtaREU+gtctLvnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiztaKax9lD3Ek/kYalua1y7Wy4/u/+0YGb3QK6jGwXoCWYq6FiEahnzAnV5iZZ+DnZ927pQO9T2hm/eWofNrFXHTzgauOVS/yTX/pm/Lq93fTTpdpaJcunPQeRVjnjdc9piVoIZgk7P7J0cK0Rg11RQd2LsVOW+uXAzsndfLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDYLFYvW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb57e25387so184469a91.3
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721937496; x=1722542296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Acxl1eLWMLAI+YhoDcfLtTaqlryH06l7E5ascqhYRFA=;
        b=BDYLFYvW60qA7MnVRsE6gnp9qBrGhi2qdR0MtAjMF+BtVS00nxhcwaWBiG0/Vfrmgd
         1pYa4CKFl2tLMPxDv9vBclu08690Nj9fKMnZdoX9L2EOv0PNDaUIIDW4DFuVMM3gCDRi
         zhGy4BtEbq4GR4/oa961/zxltRhsBXomqFIuboP+WjWSafuZPKMFXwo9q0B+A03ZTTFK
         lmXAA/NIrsyXcY1PPhb9j6jF+YDDJr9B/+q1BMXvCQkplLBZlJqaP0vLlcTiyX5qvN0k
         5t6Vzdb7iX0ba3kgWIab1HxswSY+ItF02EJqeNgQwnnd7aDgRMoy5ccpV2lPjvHPUhtW
         H89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937496; x=1722542296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Acxl1eLWMLAI+YhoDcfLtTaqlryH06l7E5ascqhYRFA=;
        b=XCtKY8TJcgYWvYazs5g+5IGMTQ6O3+jYNQqyPmmyYKs+zhWljz7A5/GO4jdUfEXTvn
         xl9aKLn9+vkPprkiMYmG1KHMZhvCqDAik9hn3DxE5Fbs0JBbMIirCosJ+2OlEEB38zBb
         IP3P4ECrzrt79EbOMiWju/b+MxPEpEa6OijsTetcflWL1kA/SW7sHX0ene6cFtD90+Yl
         wLr2PSZlML5qnS8skg4v7F5Z4QIQwOcUpJgcr08h45n+IDjFpHlUhoBlw4Vr3o1ze589
         Or/FvhjKcz4ft29LUNX8QZUknTPy3aqtohsfWbi+t8TEOLvgOq18xMs6YclmDl+9On94
         RMYA==
X-Forwarded-Encrypted: i=1; AJvYcCU66PHKye0TJpff6iZH2SZFenuE7tGz/fSIRQZv7iuo2IB8AXkszh/sKdG6ik5/sfvhF/4bRoxVKqhFVEJTNypAJh9A
X-Gm-Message-State: AOJu0Yziji7wuaGw2LNjogJpCceR4qo8HT6dywquj3wb/15cdzeulGtw
	G/n4HekJAdkAMbYN17J15bqZgXl+1A6cmCGamzcbhk/YSUaZN35zegUtCMlZIqjshP1uWDfxWgV
	QfKLUOe1pY7EkVFzYmqixzoPlB3Q=
X-Google-Smtp-Source: AGHT+IFVfiZkVAZzL4l1tpvsMn9FT2/kmsEdXVqvIU9SUFMXrzcluVqbGU/RUNs8ApC8jDFtL4bUkVGRlMfud4zDs9w=
X-Received: by 2002:a17:90a:ce94:b0:2c9:7f3d:6aea with SMTP id
 98e67ed59e1d1-2cf2eb6b0demr3310880a91.32.1721937496438; Thu, 25 Jul 2024
 12:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-2-andrii@kernel.org>
 <ZqI_I2iDLwNTJy4h@krava>
In-Reply-To: <ZqI_I2iDLwNTJy4h@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jul 2024 12:58:04 -0700
Message-ID: <CAEf4Bza5pLkH4QAxD6dmWUcZcV4Tth2QDQ-K6PXhByCXgAu8UQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/10] lib/buildid: add single page-based file
 reader abstraction
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:03=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Jul 24, 2024 at 03:52:01PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > +static int freader_get_page(struct freader *r, u64 file_off)
> > +{
> > +     pgoff_t pg_off =3D file_off >> PAGE_SHIFT;
> > +
> > +     freader_put_page(r);
> > +
> > +     r->page =3D find_get_page(r->mapping, pg_off);
> > +     if (!r->page)
> > +             return -EFAULT; /* page not mapped */
> > +
> > +     r->page_addr =3D kmap_local_page(r->page);
> > +     r->file_off =3D file_off & PAGE_MASK;
> > +
> > +     return 0;
> > +}
> > +
> > +static const void *freader_fetch(struct freader *r, u64 file_off, size=
_t sz)
> > +{
> > +     int err;
> > +
> > +     /* provided internal temporary buffer should be sized correctly *=
/
> > +     if (WARN_ON(r->buf && sz > r->buf_sz)) {
> > +             r->err =3D -E2BIG;
> > +             return NULL;
> > +     }
>
> what's the benefit of having err, would it be easier just to return
> error pointer like ERR_PTR(-E2BIG)
>

There are many calls into freader_fetch() and I didn't want to have a
very distracting

p =3D freader_fetch(...)
if (IS_ERR(p)) {
    err =3D PTR_ERR(p);
    ...
}

pattern everywhere

> SNIP
>
> > +static void freader_cleanup(struct freader *r)
> > +{
> > +     freader_put_page(r);
> > +}
> > +
> >  /*
> >   * Parse build id from the note segment. This logic can be shared betw=
een
> >   * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
> >   * identical.
> >   */
> > -static int parse_build_id_buf(unsigned char *build_id,
> > -                           __u32 *size,
> > -                           const void *note_start,
> > -                           Elf32_Word note_size)
> > +static int parse_build_id_buf(struct freader *r,
> > +                           unsigned char *build_id, __u32 *size,
> > +                           u64 note_offs, Elf32_Word note_size)
> >  {
> > -     Elf32_Word note_offs =3D 0, new_offs;
> > +     const char note_name[] =3D "GNU";
>
> could be static ?

could be, but why? it's a 4 byte value, compiler might as well
optimize any sort of note_name[i] access into known constants

>
> SNIP
>
> >  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 b=
uf_size)
> >  {
> > -     return parse_build_id_buf(build_id, NULL, buf, buf_size);
> > +     struct freader r;
> > +
> > +     freader_init_from_mem(&r, buf, buf_size);
> > +
> > +     return parse_build_id_buf(&r, build_id, NULL, 0, buf_size);
>
> could use a coment in here why freader_cleanup is not needed
>

probably better to just include freader_cleanup() call, just in case?

> jirka
>
> >  }
> >
> >  #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE=
_INFO)
> > --
> > 2.43.0
> >
> >

