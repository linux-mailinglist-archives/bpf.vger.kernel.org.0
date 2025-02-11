Return-Path: <bpf+bounces-51186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B512FA31862
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 23:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1925318873B0
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 22:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC1268C65;
	Tue, 11 Feb 2025 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWrcTIAc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CD2641DF
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311665; cv=none; b=Uyvyd2CCUMNE2G45SfxgV/EWAQ8/Tef0SproXnHtc566ssnoXG7PxBKzW4sZAI5xgetQzapJzRCta+RcCvg44h9BEUjCDAMGaPYDNmngZgJiSSVbeNx0oW+7x9phLXeuTL5AEY9XJCRcnUog/bVShUb8Vf53ltIA1to2RgdMpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311665; c=relaxed/simple;
	bh=CYAh2c2dZoAQx3f5xwOPPv/5Z2qKqxVOaJarm1MX5uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shv4vOQm3hODfAjja98dHnGkjMDH/4TJSxHL0nl4aylmDskzajSUMbnTf/E8NGBK1QkdC0Th/dhBMB+YbElrCpnidACBx0VeN2gmiCm9jL0uwu4g/LiQ5Y+fn5BfJVYM5yVvTFQ/ODl7ny9SpnaY1GBfh7ZZ/gv1Rn8wOFFb54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWrcTIAc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so9357810a91.2
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739311663; x=1739916463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQiEQp2Wn/UFj5VBH1YBC/NtW/rLtpkeM2JH3Gt3fog=;
        b=fWrcTIAc26sodYXthshua1KEi0eHJJcFz2r/M1RZsgEy8be8sprc5ycMpp6RfFLBjy
         mZ1UM/BBzxrdVB8KN9jNepyQRtcjdO4BHSLnHXZ9Pr2yBsXmwvH1/mAapu7Ae5hhFLyR
         tZNgrnu0YjxRuyv9kvwEBfHfQLx/uE/IG/h74wvFD/hXHxQF1dmD+VJwMV/YbtBAYqkG
         VfSdQb6jHD4vU5uIOYA4C1nPGzHd7iaF/0yyPOmy4UF+FnGUcqY22hv+jaqEQQR4mz6g
         52WVwRxoGZ4+sBvmBGk+v5Wkv0kD1Rkurz2trLVemmHCW8/tMnJDh7NesETmwvoCTk+X
         pKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739311663; x=1739916463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQiEQp2Wn/UFj5VBH1YBC/NtW/rLtpkeM2JH3Gt3fog=;
        b=AToRjHuQtv2s7byMyMTYVuWChYKYKeg8Oz7lEf3g56yrasx3dPyXgsPqZIl7AY0a9w
         nxm1NDrg/RwKMpfNAoz7p7sfDNRP3XvfsXTVrAIssqNVMMRfZoG2UrG8CbNc80dqUNci
         0cHAe+WHweJQfa/ur3dKY8k+wyqjpDzKAltoSp945eE/P4dbAjybEzEXYLfHdRn3gRYA
         rPnHeNCL7UQahq1gfLC+o0GP7PKVEzHtJ9w6gFI+lTg60fNvzs6Zr3IRMZaC54y9CIEB
         e8mR4r2P3Lc00TMjpi5w3n8WUuV7DjSUW94ymvQvxijJ6oMpK3kYI9TRs9aTnublNp6b
         yCjg==
X-Gm-Message-State: AOJu0YwIy1nUbTp/mb/6bmXof35nEga2slaqLA63BQUMoIFofa5+93ad
	syWHoY2dqUV1ZaH5H/3ocaFGXfX5k/7PMI6d1uIBoE/DZddB9PicZSmBOQnRIcACIdtHmwe1mi+
	UWbGf1NfqMloSdvSq1jjkxvC7R4g=
X-Gm-Gg: ASbGnctCGB+ox9e4zpUO3KyMXA8gVLUn//FncOIXJ7gvbFXfdUhDfyr/eqSrX0yT5kq
	5j2TswgL0/9Y+SmzoAEAaDRdKuG3PJ/3mtuIEUf/sUf0u4/y/DtN2JEo8HXIBD4hDp9Lalln+jX
	5bsfkDlDsK+GXd
X-Google-Smtp-Source: AGHT+IEmrBMr+a0of/VHbtYIuWcJLPwUnCBRjOwFLE73bzk8Ek2S2SSnXzCAvwMnY4pnDVNfeiFTFty8THMIKy/eSi4=
X-Received: by 2002:a17:90b:4d0c:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2fbf5be093fmr1152423a91.8.1739311663210; Tue, 11 Feb 2025
 14:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210221626.2098522-1-linux@jordanrome.com>
In-Reply-To: <20250210221626.2098522-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Feb 2025 14:07:31 -0800
X-Gm-Features: AWEUYZlxg4NzGPm-M8G-0JJNSC3Y57lhia17wLJsu33851-u1Q0W3oihNFBnOPo
Message-ID: <CAEf4BzYjsLnrCV9PK8gmyiFw8idXea5ckPRvCqhFbyEU5Wcd9w@mail.gmail.com>
Subject: Re: [bpf-next v7 1/3] mm: add copy_remote_vm_str
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 2:23=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
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
>  mm/nommu.c         |  73 +++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..aee23d84ce01 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2486,6 +2486,9 @@ extern int access_process_vm(struct task_struct *ts=
k, unsigned long addr,
>  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>                 void *buf, int len, unsigned int gup_flags);
>
> +extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long add=
r,
> +               void *buf, int len, unsigned int gup_flags);
> +
>  long get_user_pages_remote(struct mm_struct *mm,
>                            unsigned long start, unsigned long nr_pages,
>                            unsigned int gup_flags, struct page **pages,
> diff --git a/mm/memory.c b/mm/memory.c
> index 539c0f7c6d54..e9d8584a7f56 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6803,6 +6803,125 @@ int access_process_vm(struct task_struct *tsk, un=
signed long addr,
>  }
>  EXPORT_SYMBOL_GPL(access_process_vm);
>
> +/*
> + * Copy a string from another process's address space as given in mm.
> + * If there is any error return -EFAULT.
> + */
> +static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr=
,
> +                             void *buf, int len, unsigned int gup_flags)
> +{
> +       void *old_buf =3D buf;
> +       int err =3D 0;
> +
> +       *(char *)buf =3D '\0';

LGTM overall:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

But note that all this unconditional buf access will be incorrect if
len =3D=3D 0. So either all of that has to be guarded with `if (len)`,
just dropped, or declared unsupported, depending on what mm folks
think. BPF helper won't ever call with len =3D=3D 0, so that's why my ack.

(And yes, it would be nice to hear from someone from the MM side at
this point, thank you!).

> +
> +       if (mmap_read_lock_killable(mm))
> +               return -EFAULT;
> +
> +       /* Untag the address before looking up the VMA */
> +       addr =3D untagged_addr_remote(mm, addr);
> +
> +       /* Avoid triggering the temporary warning in __get_user_pages */
> +       if (!vma_lookup(mm, addr)) {
> +               err =3D -EFAULT;
> +               goto out;
> +       }
> +

[...]

