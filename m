Return-Path: <bpf+bounces-72631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE6C16B51
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 21:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37D87356DF0
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 20:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05FF2BE058;
	Tue, 28 Oct 2025 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afq+vWdF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F118BC3D
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681704; cv=none; b=gCAZdzO5r834kgLlbnJw0dmWfB+P/+V/OIkzin35wytW0LFDju+nmq7MokVTQjBToi3dqM/n1gjhZnxJERR3w09RuohVgonWkzmdMFV8liFAUev/3W0kscW08D8OABgYJP1w7cr4n8l/i1Vb+DWYh18f8QQzPapy/yVP5M1pE3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681704; c=relaxed/simple;
	bh=l5GWGsEPwiz3diUb/H7ixbLuiHzV4WUv52e+zTyFpmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGzRFbOT9SA+wux/8EWiOIgZ1dvfuCOxUm/jmUy5iM2801Ex+O8rH8EIWgOXGx+qbRX8G5SWpI8E7Zurug26xrT9CgMIp+nQSxGN5J7pfn9MnwbYes2i14e1HE24R1VjLNw97JiyGXcLgzhMODnUbHrWYjcTOdgH1ECp30+aRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afq+vWdF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so95417405ad.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761681702; x=1762286502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV1N2sx1naYFzQgwrZAVyW1JQu2elLYK102Eub4nNUM=;
        b=Afq+vWdFfuFgCDW4EZOD3MPh+z961wsEsUYrAY+wTmXQ0XDGUPhWvRr7cOqdQ4B1Eb
         IVHSlFvq3emDV6lAOqZuaSlsv5/teq3Wk57pMOfQ/CEpPqiZ3eJEqsNcHfrrs4cfRyc1
         6O2bNEHoNliqc+TJgmtbUgaCAd2IZGfMFPJB/aTOzv7uXWrcCv71xZ39ohldWmwXK1BS
         AE2PMkNXvMk4LLjibzIyZnWGlqc2/Wfe+cu2cqxmUKVEP3HXewBPKahi4XlQNFw/xBFq
         Q+JB0IGNLFKIsABRT9jTxJL6Wkjyqtgbyn+0zvfmrNAqOQKHuIUTFZcqvgLaFba+KiIq
         XVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681702; x=1762286502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pV1N2sx1naYFzQgwrZAVyW1JQu2elLYK102Eub4nNUM=;
        b=WVDbd5OnKfz66okkvh8fsRgR0d0xpXiH+19HTIF2CrS5J7CriOFamC8ZGanhJli7gc
         cLHzPznOaCOtJUcmRx9JIZneEvgFhPTXbhF95xZnYkfYDtbEnZmENVPhDQUWayvH14d0
         uuEmy7oWBepONShp83ip1pycXVi4/D6GT+qRH+k/GfZ0AUvZv2eCo68zZbtG1qKyY1lA
         7RAUzTXmT+HsVq/zop8PNUGl2foKHzFLA0ZRaS7/++OUchyr7MxupadTdp8Kwh6EOlIf
         zjoOGV5ExTg5enQNineJ1tl9SeD/OsAZmIlJlsEzgGPILiwi5VkS8d4Jipmyw86zmvm0
         6vfA==
X-Forwarded-Encrypted: i=1; AJvYcCXv3Jth7KxGSJT1lDYMN7y+lqxo5kGw5mulifcWrDSymUBQoYEeuvRL3oPCCyV9q9UfCD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3v3cza9ESYjGNgBt5cOAMSKZONvg3AAk/z/rz4bNsLjRVqk9
	SPCm3ztgCfeneTw6efazmO8LdcbzwQObdAoUBPY6iFG27xwX+626UGGlv4mDeU8kUSMf2HgA7il
	DhBhD/Ro7CqlxltiVHl+qbBlruOpsYnM=
X-Gm-Gg: ASbGncvtckXK1jPBln+HChEO34XXNEzjRA2baMzOIp80tgcodQUHMgSqtjP7duhAWnT
	tgp9SV3c2zhewaFjfJFVEK+n5ac+ymLBCe8UOZZe8lYkrodqW1fAhTA5JmB7BO/FDEVseDjm5M2
	HGCRQVt+8aZPttbzU9ogYwN0EnXac3tCyV3I77hngyC/S56XLI5Tklh44A1NEXvHR7hR3lPkBd8
	VaZhkLNEfYr/ulwE/RqLud898LSagaTwxd1xEhRnyGyTovs3X673MXbBEEn3EScWU+kOIL9SjTs
X-Google-Smtp-Source: AGHT+IHhS4UiVyVmYgZDECC81lzJtRbtlF0gnYw9+MVoUKNcZUofCGd5E9Wixn57uB9ZQxo4s4jM3kORgzFoQDYFV3k=
X-Received: by 2002:a17:903:2451:b0:26a:8171:dafa with SMTP id
 d9443c01a7336-294dee30b1bmr5260275ad.21.1761681701933; Tue, 28 Oct 2025
 13:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028155709.1265445-1-alan.maguire@oracle.com> <20251028155709.1265445-2-alan.maguire@oracle.com>
In-Reply-To: <20251028155709.1265445-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 13:01:24 -0700
X-Gm-Features: AWmQ_bkyQOcsoL5z7MaDwqcLGhswEGr4C34PAbFrfQ_jnkBT3oXazLnBTX2ttHk
Message-ID: <CAEf4BzbKd26Tsk2XhfSnscdJJxfto2P25yvqDPA2-0YA3dHJUg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: Fix parsing of multi-split BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	ihor.solodrai@linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 8:57=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> When creating multi-split BTF we correctly set the start string offset
> to be the size of the base string section plus the base BTF start
> string offset; the latter is needed for multi-split BTF since the
> offset is non-zero there.
>
> Unfortunately the BTF parsing case needed that logic and it was
> missed.
>
> Fixes: 4e29128a9ace ("libbpf/btf: Fix string handling to support
> multi-split BTF")

please make sure commit references are not wrapped when used as part
of Fixes: tag, I had to manually fix it


> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 18907f0fcf9f..9f141395c074 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1061,7 +1061,7 @@ static struct btf *btf_new(const void *data, __u32 =
size, struct btf *base_btf, b
>         if (base_btf) {
>                 btf->base_btf =3D base_btf;
>                 btf->start_id =3D btf__type_cnt(base_btf);
> -               btf->start_str_off =3D base_btf->hdr->str_len;
> +               btf->start_str_off =3D base_btf->hdr->str_len + base_btf-=
>start_str_off;
>         }
>
>         if (is_mmap) {
> @@ -5818,7 +5818,7 @@ void btf_set_base_btf(struct btf *btf, const struct=
 btf *base_btf)
>  {
>         btf->base_btf =3D (struct btf *)base_btf;
>         btf->start_id =3D btf__type_cnt(base_btf);
> -       btf->start_str_off =3D base_btf->hdr->str_len;
> +       btf->start_str_off =3D base_btf->hdr->str_len + base_btf->start_s=
tr_off;
>  }
>
>  int btf__relocate(struct btf *btf, const struct btf *base_btf)
> --
> 2.39.3
>

