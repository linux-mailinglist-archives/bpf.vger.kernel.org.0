Return-Path: <bpf+bounces-77033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ADDCCD710
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 20:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6130302C739
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA0F248886;
	Thu, 18 Dec 2025 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLF9sZaG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0B244664
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087513; cv=none; b=dmEmYGDYA38L1Emc3HIiCMV0H6D/A/RjrHNXtdABCEhHgFd3PbiyzW/YuAVydOHGNutKXNTwC+lM4w3/V8EA7KLYjRGspOuOeV1PyipeBnY/kCvjm3oF7NtjkAI+ugoIMmrZlDloMS7JpbDV5plt+A1S0rfiPgCx0ajRo/GpC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087513; c=relaxed/simple;
	bh=UG8wtVehnYupYtHAY5Ot7xrvisW4HhBVMg45UlTB6zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BG2cYRRcUiMG1ixzlgGm2w7RdW2hvn2L9/gnPvsnZnfh8xkoUXlB6lR8NAWgGW23nw6uJmkQUu2nKBKIWe3z3i46omOYcV9hXT2vlfVF2yKdG6ssYjZ6sm5/hJx1PmvQGkbjzDRtMFkq3/7qnC8HjmmM7ZlIvskraH0GFAhh/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLF9sZaG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so909026a12.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766087511; x=1766692311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C63H+Q0LBcr5iHhH3l69u6dfCNmkUhMAEU6dY0As97A=;
        b=fLF9sZaGlTVSLNxoSVasr672pQcC33CE1CxpwVFS5+7FWNgM0Y6Ur+ita9XmcgxFHd
         73QfqvKCaxORyJqcL5K0DcL7GztNWtR/W4tXRTglXIyzEOjUNK+N/grvayAkfHPLkcF+
         icjnat7SoHX+2vVAuqKNzgQdak4K0H1nvm2uzLbuHMa15Hp53+k/I52owh8rMfgWejgv
         wwu0247ksllLkAqa3gXgaLurBjEhibOHRJNF7bEu/zQC935T8OA76KT1Ryhi9+OshNSo
         QmvU10gc3g/ODo5+gGZY8lPKz104e2Aca9wqPDsldQf6Yr4aEU74IdnfXdBwdlA69YXX
         bMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766087511; x=1766692311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C63H+Q0LBcr5iHhH3l69u6dfCNmkUhMAEU6dY0As97A=;
        b=XPI3hkJKvkS2B0Lbm3iY2Wa/qXtitJ5zoPlJHvnPRahmPFQuOTL/cpKUUAsBsErzVu
         tC4JhjvhiudmbUFM4M7/ZpqX2SzBm7HUFJoLREm+6e5YtrrIOXO4mmxhawVxsFoucGAe
         BqMqawiZhmEi+NRF+xQpI/vU9PZDm5ciFHjlJMgL8wRmtw6IRbNrFgg5NCrtz2XjqjAn
         0rN8fzO5IQ3UyUuH2M74J/AVnD4FMWiZk5uuIhsgu5qCT0nMbp8pC0xi7OALPwl76Nij
         u7TGhppznEuiykLg/2KC5WQ5AInh7sdW9ABd71UNQ0TCvItwXzCZaEZw8/G3RDo3kSlK
         7mSA==
X-Forwarded-Encrypted: i=1; AJvYcCWuxB9Sbp2eCQEUsRzkyNRUasHD0+uX5TVUjGX6XPaeSAD1ZkjEvdDBExqxkMyktP5YF7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1cjq8NF09nCZmlvJwVD5v9m9tJ6K/pkUELVLZzmxEXnJ3o+y
	LWzjoDm+S9PY3k7bXjjqV/33v5XI7l/n16O6bnTkYRRhDEwydHdnnqEBuQDZ9XQA5nc8bF/EW2F
	hqbZn5KJiyorpUtQu/mEjNyrXX0tFDhQ=
X-Gm-Gg: AY/fxX7BntJWzj29mxeXneKaaWTdLLLmPucGBbh46Axqf1kGtEqvhq/9rbzl4GDFCls
	2LiqqXEyxRLUWOnfABt08Mn+4n8g5mV6rtZSbVjcZXpSocAAdVZyC+u8kTsQKIfyLd7Ilu42B1C
	rJHXozunXkKEYl789DjF9YepTzqcbOEMU9aZTni7FbordpUefiOVeNLkp2KeUSvshh2kXgL6URD
	w7AxOSlamuUCvBX+OUcGd4PCr3WX33ncUD8qz7VrRAvbrRRPbdVnMGJblP7GPWGyRqBJzXPetjQ
	ia09K2coOn4=
X-Google-Smtp-Source: AGHT+IEWhe7bv32T+uDEnTLomzrXVkDcdio5VPeba8Lb88GM19tn066r4eU5nxiaGkuMZVdgvFNvFM5Rn8urP76u1tk=
X-Received: by 2002:a17:90b:4c41:b0:34c:2e8a:ea42 with SMTP id
 98e67ed59e1d1-34e90d6a375mr708436a91.7.1766087511281; Thu, 18 Dec 2025
 11:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218005818.614819-1-shakeel.butt@linux.dev>
In-Reply-To: <20251218005818.614819-1-shakeel.butt@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 11:51:39 -0800
X-Gm-Features: AQt7F2qMfWT3bgYpN_4cYf67W4wNT-xNaPH-YHCiCZYNMobBBdufEt-Lx4wkFGI
Message-ID: <CAEf4BzZrU9xA=S9BFy5MHhmBi_S33yjGWYK1Wx8gs5RdEcjbYQ@mail.gmail.com>
Subject: Re: [PATCH] lib/buildid: use __kernel_read() for sleepable context
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Shaurya Rane <ssrane_b23@ee.vjti.ac.in>, 
	"Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 4:59=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> For the sleepable context, convert freader to use __kernel_read()
> instead of direct page cache access via read_cache_folio(). This
> simplifies the faultable code path by using the standard kernel file
> reading interface which handles all the complexity of reading file data.
>
> At the moment we are not changing the code for non-sleepable context
> which uses filemap_get_folio() and only succeeds if the target folios
> are already in memory and up-to-date. The reason is to keep the patch
> simple and easier to backport to stable kernels.
>
> Syzbot repro does not crash the kernel anymore and the selftests run
> successfully.
>
> In the follow up we will make __kernel_read() with IOCB_NOWAIT work for
> non-sleepable contexts. In addition, I would like to replace the
> secretmem check with a more generic approach and will add fstest for the
> buildid code.
>
> Reported-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D09b7d050e4806540153d
> Fixes: ad41251c290d ("lib/buildid: implement sleepable build_id_parse() A=
PI")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  lib/buildid.c | 47 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/lib/buildid.c b/lib/buildid.c
> index aaf61dfc0919..e7e258532720 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -5,6 +5,7 @@
>  #include <linux/elf.h>
>  #include <linux/kernel.h>
>  #include <linux/pagemap.h>
> +#include <linux/fs.h>
>  #include <linux/secretmem.h>
>
>  #define BUILD_ID 3
> @@ -37,6 +38,29 @@ static void freader_put_folio(struct freader *r)
>         r->folio =3D NULL;
>  }
>
> +/*
> + * Data is read directly into r->buf. Returns pointer to the buffer
> + * on success, NULL on failure with r->err set.
> + */
> +static const void *freader_fetch_sync(struct freader *r, loff_t file_off=
, size_t sz)
> +{
> +       ssize_t ret;
> +       loff_t pos =3D file_off;
> +       char *buf =3D r->buf;
> +
> +       do {
> +               ret =3D __kernel_read(r->file, r->buf, sz, &pos);

r->buf -> buf

(and please add [PATCH bpf] for next revision)

pw-bot: cr


> +               if (ret <=3D 0) {
> +                       r->err =3D ret ?: -EIO;
> +                       return NULL;
> +               }
> +               buf +=3D ret;
> +               sz -=3D ret;
> +       } while (sz > 0);
> +
> +       return r->buf;
> +}
> +
>  static int freader_get_folio(struct freader *r, loff_t file_off)
>  {
>         /* check if we can just reuse current folio */
> @@ -46,20 +70,9 @@ static int freader_get_folio(struct freader *r, loff_t=
 file_off)
>
>         freader_put_folio(r);
>
> -       /* reject secretmem folios created with memfd_secret() */
> -       if (secretmem_mapping(r->file->f_mapping))
> -               return -EFAULT;
> -
> +       /* only use page cache lookup - fail if not already cached */
>         r->folio =3D filemap_get_folio(r->file->f_mapping, file_off >> PA=
GE_SHIFT);
>
> -       /* if sleeping is allowed, wait for the page, if necessary */
> -       if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->=
folio))) {
> -               filemap_invalidate_lock_shared(r->file->f_mapping);
> -               r->folio =3D read_cache_folio(r->file->f_mapping, file_of=
f >> PAGE_SHIFT,
> -                                           NULL, r->file);
> -               filemap_invalidate_unlock_shared(r->file->f_mapping);
> -       }
> -
>         if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
>                 if (!IS_ERR(r->folio))
>                         folio_put(r->folio);
> @@ -97,6 +110,16 @@ const void *freader_fetch(struct freader *r, loff_t f=
ile_off, size_t sz)
>                 return r->data + file_off;
>         }
>
> +       /* reject secretmem folios created with memfd_secret() */
> +       if (secretmem_mapping(r->file->f_mapping)) {
> +               r->err =3D -EFAULT;
> +               return NULL;
> +       }
> +
> +       /* use __kernel_read() for sleepable context */
> +       if (r->may_fault)
> +               return freader_fetch_sync(r, file_off, sz);
> +
>         /* fetch or reuse folio for given file offset */
>         r->err =3D freader_get_folio(r, file_off);
>         if (r->err)
> --
> 2.47.3
>

