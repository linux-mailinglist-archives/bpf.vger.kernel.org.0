Return-Path: <bpf+bounces-36184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D93943852
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5C7B20F05
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123C16CD18;
	Wed, 31 Jul 2024 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqd7J+VQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD9166308
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462974; cv=none; b=PBsa00VHW+ty0EQNGxNJ4jLfuAjSbYEBBbpgSU/hw0D2pH5+LmZvBYO9CprumJARyqMMbjUf7SBCUtT8Y5mie2MLZukkWccBfMVDKOpc2xM4/pQQOEkBKWmDFD2O6WWkJMOAggLc3uaqjluv5KUuSPE6AdxqcAbq7myXQ+1U+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462974; c=relaxed/simple;
	bh=/LMmPzuGZB5+BVgttQJSmgXwm5baOKj5D53FnCeEKNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piNukezBtElpHTaEWG+K1xiKUWWtyXm3AOdxEvYvZhIOFx1dryh2tiXtos4obIzO136D09BJFzT7sjFncyAIcF5XY4+9O5US/ZrVE4h78r2GTaxzZFkbK+igIZPsCcDNveioo3JimyhRhK3tdZs9QLt6DXz4rkrwyW6O+jBMlVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqd7J+VQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso4042377a91.3
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722462972; x=1723067772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iTY5UqVu8uZVhVMhHr7OAfSPC1ARBRldJ7iTIrUPv4=;
        b=jqd7J+VQC1O5XjwWNViw0kqY3jT83+eZYb+SRABc96652TMoVGfAHMpq1DCY6d6CzD
         J7hmHur0sL+VM1Zs6Mi0jRcOQ7WCkROtI+wzjKMVnCh0+SS5h4GSIUlOoLjVESu5zbb3
         z1gSqslcpOu0eVzC/OSklWvZFNsHK7M7cv8f/EXnGMH2mzbEsBqzpjox1TT8ZjtQAkWf
         ejFuwUCHY5+vAXl7dt6aSDLRMsSmJpHsuMkZUoviiE3NfD9UwecvmPThoFCEszWkkvse
         ZP+mlErsOvv9EYjYQmrFoyc6P/PkHcu6sv2izwDGdsWAOE2iwYBStvtdyZQkBTIn8X+L
         Oyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722462972; x=1723067772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iTY5UqVu8uZVhVMhHr7OAfSPC1ARBRldJ7iTIrUPv4=;
        b=OurvfhV+IJxK53EfqRn0uWkb+trQMyj9gmC2yABsZNEi0Uj1kBu6xDpxHTpLdHDr1U
         mtkXYhw1M21J/nKrUQwpiVU8fG7VbXWhp2FKApRX02iBUeU7vjP2U127xurpOyHUSPMB
         iP2cKn8ueTYvGbYTfYk03pGoR1Xsmbw26MSrPodUiMcrhooTRin6aNlqDnvvFUWiU3cd
         u6sOfCm5qAFclEGJR+X3VkjJcJEjykmXl/YIq2TwEF7so0K4FlFAtv+PqX9QGcisqiMv
         4BKAosoT441bwBJOphlE5laSPy30wlO1bWlBgMW8z3sxLSauRy4nS5/n0ZORJ07u+WiC
         GS4A==
X-Gm-Message-State: AOJu0YxXmqVqZm5MkbmagBvT97TDz/p7k38Nc3tvMl7dWimZCWqqR9rS
	fGVWVlIXn0kfdxRMgPIEu3X0t7Mneq5srrvkAAfLWW8zRI7tW6t6+YeZIPOvVWh1i9sBfurwhPD
	PYe9H/O9UFi+vI3iTgu8mivBI0Mg=
X-Google-Smtp-Source: AGHT+IE+7C1Z1ljiOO1HRIW3D2FiNaeVWWq8y9+LOitbh1kE3c69ST+B0ykHqjJmAwjq2dXv/p2L8L0pmmMv/ty4POM=
X-Received: by 2002:a17:90b:4a8f:b0:2c9:9eb3:8477 with SMTP id
 98e67ed59e1d1-2cfe7871306mr752884a91.16.1722462972221; Wed, 31 Jul 2024
 14:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730203914.1182569-1-andrii@kernel.org> <20240730203914.1182569-7-andrii@kernel.org>
In-Reply-To: <20240730203914.1182569-7-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 Jul 2024 14:56:00 -0700
Message-ID: <CAEf4BzZ7hGgBeLgLnALM8fuFJw+UqdPPJ4E4a1sAdvWttaBSpw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/10] lib/buildid: implement sleepable
 build_id_parse() API
To: Andrii Nakryiko <andrii@kernel.org>, shakeel.butt@linux.dev, 
	Johannes Weiner <hannes@cmpxchg.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	adobriyan@gmail.com, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 1:39=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Extend freader with a flag specifying whether it's OK to cause page
> fault to fetch file data that is not already physically present in
> memory. With this, it's now easy to wait for data if the caller is
> running in sleepable (faultable) context.
>
> We utilize read_cache_folio() to bring the desired file page into page
> cache, after which the rest of the logic works just the same at page leve=
l.
>
> Suggested-by: Omar Sandoval <osandov@fb.com>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  lib/buildid.c | 50 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 16 deletions(-)
>
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 5c869a2a30ab..6b5558cd95bf 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -20,6 +20,7 @@ struct freader {
>                         struct page *page;
>                         void *page_addr;
>                         u64 file_off;
> +                       bool may_fault;
>                 };
>                 struct {
>                         const char *data;
> @@ -29,12 +30,13 @@ struct freader {
>  };
>
>  static void freader_init_from_file(struct freader *r, void *buf, u32 buf=
_sz,
> -                                  struct address_space *mapping)
> +                                  struct address_space *mapping, bool ma=
y_fault)
>  {
>         memset(r, 0, sizeof(*r));
>         r->buf =3D buf;
>         r->buf_sz =3D buf_sz;
>         r->mapping =3D mapping;
> +       r->may_fault =3D may_fault;
>  }
>
>  static void freader_init_from_mem(struct freader *r, const char *data, u=
64 data_sz)
> @@ -60,6 +62,17 @@ static int freader_get_page(struct freader *r, u64 fil=
e_off)
>         freader_put_page(r);
>
>         r->page =3D find_get_page(r->mapping, pg_off);
> +
> +       if (!r->page && r->may_fault) {
> +               struct folio *folio;
> +
> +               folio =3D read_cache_folio(r->mapping, pg_off, NULL, NULL=
);
> +               if (IS_ERR(folio))
> +                       return PTR_ERR(folio);
> +
> +               r->page =3D folio_file_page(folio, pg_off);
> +       }
> +

mm folks, is this the sane way to do this? Can you please take a look
and provide your ack? Thank you!

>         if (!r->page)
>                 return -EFAULT; /* page not mapped */
>
> @@ -273,18 +286,8 @@ static int get_build_id_64(struct freader *r, unsign=
ed char *build_id, __u32 *si
>  /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
>  #define MAX_FREADER_BUF_SZ 64
>
> -/*
> - * Parse build ID of ELF file mapped to vma
> - * @vma:      vma object
> - * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> - * @size:     returns actual build id size in case of success
> - *
> - * Assumes no page fault can be taken, so if relevant portions of ELF fi=
le are
> - * not already paged in, fetching of build ID fails.
> - *
> - * Return: 0 on success; negative error, otherwise
> - */
> -int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *bu=
ild_id, __u32 *size)
> +static int __build_id_parse(struct vm_area_struct *vma, unsigned char *b=
uild_id,
> +                           __u32 *size, bool may_fault)
>  {
>         const Elf32_Ehdr *ehdr;
>         struct freader r;
> @@ -295,7 +298,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma=
, unsigned char *build_id,
>         if (!vma->vm_file)
>                 return -EINVAL;
>
> -       freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapp=
ing);
> +       freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapp=
ing, may_fault);
>
>         /* fetch first 18 bytes of ELF header for checks */
>         ehdr =3D freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
> @@ -323,6 +326,22 @@ int build_id_parse_nofault(struct vm_area_struct *vm=
a, unsigned char *build_id,
>         return ret;
>  }
>
> +/*
> + * Parse build ID of ELF file mapped to vma
> + * @vma:      vma object
> + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> + * @size:     returns actual build id size in case of success
> + *
> + * Assumes no page fault can be taken, so if relevant portions of ELF fi=
le are
> + * not already paged in, fetching of build ID fails.
> + *
> + * Return: 0 on success; negative error, otherwise
> + */
> +int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *bu=
ild_id, __u32 *size)
> +{
> +       return __build_id_parse(vma, build_id, size, false /* !may_fault =
*/);
> +}
> +
>  /*
>   * Parse build ID of ELF file mapped to VMA
>   * @vma:      vma object
> @@ -336,8 +355,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma=
, unsigned char *build_id,
>   */
>  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, =
__u32 *size)
>  {
> -       /* fallback to non-faultable version for now */
> -       return build_id_parse_nofault(vma, build_id, size);
> +       return __build_id_parse(vma, build_id, size, true /* may_fault */=
);
>  }
>
>  /**
> --
> 2.43.0
>
>

