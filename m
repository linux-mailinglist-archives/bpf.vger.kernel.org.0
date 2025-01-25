Return-Path: <bpf+bounces-49724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F8A1BF8E
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B14F3AC674
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 00:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3CD1367;
	Sat, 25 Jan 2025 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwpsTANU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC71E521
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737763758; cv=none; b=bCaOfYMM2u7ma/fkTi0jBCkyw+rp6s9bC9I6h0QqrNO3E9wRX9jGw0wIflsTlV12xzwT0G7s1Dndy/juPbuamcaMnRiKoV6CNMTau33+BZrhDScGi62nLFcHBZc0tZFBh1GCsZ1LJrOG88OO91xeb1nxY2eJzxkWSv/awdwqV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737763758; c=relaxed/simple;
	bh=10rPhfxVEp3plKDhSNtMcI0sw0nubKnNoFFxz3D6FqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fl1jAEPsFkZBNSz4EvmVkPJ5uBId6HM8Awl1IbsqP3GSZf9oDucx+g6lfU7RWbgGvN3PQkFOJy21X8R+idZUCaoxdSevobqt69JC2qtRaxib2Cs38V3P8uT+tmafVjEHA4rMEG7tTdlnl/dqvAL2I2+qsARXYICxqhzbYwCR8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwpsTANU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab633d9582aso458340666b.1
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 16:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737763753; x=1738368553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hl+KiFhn0qyQzxsQhytCkRSC033pK7LTwYTo6zdlpd0=;
        b=EwpsTANURVoDK/+F0twNIq70WpK2ZyAlxg9LRVimwlUJj7vZwFHAi9rkcQ1KoA5iqj
         NTp+iFUXLSbx98YbNcZK1v8Q1kgAh53NsfyhIN43AyxP1+US3v6nZ1uNmGhUdd0dd/4J
         RpLK9ZGJ9Gm3F7ehki/xwFLh5miQE9+h+Ieqt25L+qK68QpFvpBR1BimnTwh6NDZR+Dg
         FwJrXSpT+aKj2aZfEU9NE48HODBtJt3smk5wFR/a1az3/WvREO9nxzDSpGGuLbD0J1TW
         +3Q4jhNUfDISt1pDLa4SeAWMzQEJalUH/eHUXlwZ3uexVwL91nZajV9W5D1W3hH7ZZ1y
         BRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737763753; x=1738368553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hl+KiFhn0qyQzxsQhytCkRSC033pK7LTwYTo6zdlpd0=;
        b=R8lp61umDcBMvf0fTrGN/HudEO9gr8JrQtyp6xuMk1XvzIsfA29h1sD5V6DhdroXIL
         hZGhV8TimlzQUQqLVeQAmjGQX1z3B23J6mdLPSL2RSZpWgH4KVeCrHPey2cX/6z6bb+Y
         vEeLGTMWL//7+Dmdm785SCEpiE1FA+3OpZmbN9WoLktyxT7yzq0V3j9oFEZA9SXv1iK2
         +ZMOPVryoZwN/NbrM2wxt6ktYcElVaHdnGEKCY9w9UvhTzG2dVvFiEaFQ/lRRJZ3gV5g
         oEDn7V7iPWM05x/TVl7ETtdHKJj+utkSVYCj6LipIJKbL9z3B97gPH3SO8xZmHjQRi5/
         zgXA==
X-Gm-Message-State: AOJu0Yw7OrFMIT1b+7hEOebYMKtLE3o6OMzqcbQ2znrDEuFOx9PmOzhZ
	JHvSbVnLKNnV0OMK4bACeO6htjHlwKOEnVWamxHP62k+VNgh+KGWCfh19PviTmy8Ni4O4QCmEcA
	A6fo1iNZFxoFEgO3D5OdEY/D+lRc=
X-Gm-Gg: ASbGncsxogNwHe1OIQ53k/xx+hrPLkn0hff93W+WFP7D7uY/Gxo3yZcQ3/Mz/NfIUa8
	PpHL09m29n9vfg9sTwEBmDkvnopFk+bS0Xz5ebL1gplTFKEgtJDB7TMmVQVYZ
X-Google-Smtp-Source: AGHT+IEGgiHnJRBFQZRRPcAFSZMO+Gthat7fBOMCY/sbFMbFSBIyHApXykuPYZtaEAJOvCtfnHeXAn4gMLLrVLyipHk=
X-Received: by 2002:a17:907:7b89:b0:aaf:74dc:5dbc with SMTP id
 a640c23a62f3a-ab38b320334mr2478547666b.29.1737763753153; Fri, 24 Jan 2025
 16:09:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124181602.1872142-1-linux@jordanrome.com>
In-Reply-To: <20250124181602.1872142-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 16:08:53 -0800
X-Gm-Features: AWEUYZnaF7f5gKt5yInZK1OuHqd-R4iOPSbppSleaq4_dHY7tMzfvNFDkTUICxU
Message-ID: <CAEf4Bzb9EOwQnzCL4j6vGFdJ-hgPXif5Z8iXUT-sKvf+bgTfEg@mail.gmail.com>
Subject: Re: [bpf-next v3 1/3] mm: add copy_remote_vm_str
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 10:22=E2=80=AFAM Jordan Rome <linux@jordanrome.com>=
 wrote:
>
> Similar to `access_process_vm` but specific to strings.
> Also chunks reads by page and utilizes `strscpy`
> for handling null termination.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  include/linux/mm.h |   3 ++
>  mm/memory.c        | 119 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/nommu.c         |  68 ++++++++++++++++++++++++++
>  3 files changed, 190 insertions(+)
>

[...]

> +               maddr =3D kmap_local_page(page);
> +               retval =3D strscpy(buf, maddr + offset, bytes);
> +               unmap_and_put_page(page, maddr);
> +
> +               if (retval > -1 && retval < bytes) {
> +                       /* found the end of the string */
> +                       buf +=3D retval;
> +                       goto out;
> +               }
> +
> +               if (retval =3D=3D -E2BIG) {

nit: strscpy() can't return any other error, so I'd structure result
handling as:

if (retval < 0) {
  /* that annoying last byte copy */
  retval =3D bytes;
}
if (retval < bytes) {
    /* "we are done" handling */
}

/* common len, buf, addr adjustment logic stays here */


but also here's the question. If we get E2BIG, while bytes is exactly
how many bytes we have left in the buffer, the last byte should be
zero, no? So this should be cleanly handled, right? Or do we have a
test for that and it works already?

> +                       retval =3D bytes;
> +                       /*
> +                        * Because strscpy always null terminates we need=
 to
> +                        * copy the last byte in the page if we are going=
 to
> +                        * load more pages
> +                        */
> +                       if (bytes < len) {
> +                               end =3D bytes - 1;
> +                               copy_from_user_page(vma,
> +                                               page,
> +                                               addr + end,
> +                                               buf + end,

you don't need the `end` variable, just use `bytes - 1` twice?

> +                                               maddr + (PAGE_SIZE - 1),
> +                                               1);
> +                       }
> +               }
> +
> +               len -=3D retval;
> +               buf +=3D retval;
> +               addr +=3D retval;
> +       }
> +
> +out:
> +       mmap_read_unlock(mm);
> +       if (err)
> +               return err;
> +
> +       return buf - old_buf;
> +}
> +
> +/**
> + * copy_remote_vm_str - copy a string from another process's address spa=
ce.
> + * @tsk:       the task of the target address space
> + * @addr:      start address to read from
> + * @buf:       destination buffer
> + * @len:       number of bytes to transfer
> + * @gup_flags: flags modifying lookup behaviour
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destinati=
on).
> + * If the source string is shorter than @len then return the length of t=
he
> + * source string. If the source string is longer than @len, return @len.
> + * On any error, return -EFAULT.

strncpy_from_user_nofault() doc says:

  On success, returns the length of the string INCLUDING the trailing NUL

Is this the case with copy_remote_vm_str() as well? I.e., if the
source string is 5 bytes + NUL, dst buf is 10. Will we get 5 or 6
returned? We should be very careful with all this +/- 1 business in
corner cases, too easy to mess this up.

> + */
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +               void *buf, int len, unsigned int gup_flags)
> +{
> +       struct mm_struct *mm;
> +       int ret;
> +
> +       mm =3D get_task_mm(tsk);
> +       if (!mm)
> +               return -EFAULT;
> +
> +       ret =3D __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> +
> +       mmput(mm);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> +

[...]

