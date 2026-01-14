Return-Path: <bpf+bounces-78788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D994D1BCE6
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 007F63007929
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DAA21FF4D;
	Wed, 14 Jan 2026 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mftuFepV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22669214204
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350609; cv=none; b=oUuioj9eedPt8KWmnvq+QJmV2aIGnXVC1OiyKqbjy90mYpm9vI81mf0WnDvbF9ZJZSb8L5kYl4iH1VW32K+OmUlwjjPfhrFVZf1yaCSaY8wsYNxfQMIuJSAkKvA6jWyp8/qkpP5nIuFUWeWLzQBgInlfKdCE6+mZtyEwRN2kW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350609; c=relaxed/simple;
	bh=oJwerbI7TseVd/GEskSTNqii/TFwE1Z75eYj5fehGmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6NXLQiM26E67ek/uXOk86TxR7+6FvJXjgom3UgRd9WJmtpV/G+rv6bCmfcLmFeNLwQicCZO0KrSlZLyuaS+s6ctmp6csrJBBG4fP6en3iTj1P45GLs0pUho0c4JPpPnz1m6LXoSKGCE+rnf/qektQ25rHdWjX05oAnGoagGn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mftuFepV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0833b5aeeso80351705ad.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 16:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768350607; x=1768955407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpGxcvxtMHzQEmkHNiQnqVvcOxNLdo3XrNPEh053AxE=;
        b=mftuFepVYcDleNpd/6+H6Vlxcw4qNztsGPnbmcQRxlrDXQI93hy8s5VZ45zo70WDKZ
         s3wXJOpdMgi/EeLPoRlQFwOnATT347eJcF3WcK3m+aXHNT+0YHqebevjvE7eKLh5abIA
         Dc/d+pacfDj1yjhHBeqDGBVb0isJ/+yh8aqdtGrgeiJEX1nZr4VWhKYIIplmEULuRyr9
         Z7D5b3HL3XO5/XKTRd4rb3O9rReag+w0YldkUrQsiOgKge7xL0a/hH8+WfNP3VqCRv1K
         18TfmtjaQg8ubtTJODONifmaRQMnkV8EC5lNd1Rf0foFM+S7VjbtFZKhUtYjdjiKSEf7
         UwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768350607; x=1768955407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KpGxcvxtMHzQEmkHNiQnqVvcOxNLdo3XrNPEh053AxE=;
        b=w1j6gn8PKQkevIntQ8AfEEm/mPbcQ/EKDNVaNvv0gENcaLamaG06Pp1NYGGI5HJQvt
         4TeJVdyc7Aa007BlJFYLFkYej/BbwbYn43tZaV4IP9Z9aTcnOha75CI7k6jmUi87wzB8
         bFd0hUj0Nf2lgkGo7c0tXJ0rlDVl6DrInUh+bXnCNlzDLgmXwK7Lp6yhLE+wwxcHqjJ5
         8NiQmFnhHjru/0kkaAvsGl3Mp4jJMyuHOoy70MnyCBzCBq+aVpxibVVEGhNHSizegP7n
         kly1/XK4Hie3c/FEy6kGt//+ikEuMLQLI65eGbQV2so55gkbodj3VYbeoSQ0ZUF0ps2w
         mYrg==
X-Forwarded-Encrypted: i=1; AJvYcCXqB7hGKwDTG7t/2O77NYx7DYyjBth4vprH2iWa8/pjUobTQ3aXFc24V0PpzoTCxPaZQCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7wSkAv/6ak6jGl/gW9VUV1QS286sgGMCns6yYkY16q09zyqa
	U/Bx4da9toQrg+ioZxDSRvXsOkVpOG3w54Ur/NRdjFwI5lXWpOJHwUWmJvfznnMaEnwPQBKff6i
	DQeVmQbUfdw+w6LxSWS/LYlbw/tlZcX4=
X-Gm-Gg: AY/fxX5JGusCSfJgRYwWCosfskkrw4LyoMs+71yXs/42V7ziSrk+mffaKl6Qen6LrZL
	msR5LCRu/rtkyOZnuEthO9NTuMMSyS8GgE2lFGdNUvAg19I2Phb0T1yLxm9IRyB8Myw6SGtCp7N
	Zrt55lDmTVLU4bKbVdJJpJvXnzMxngxa9WQ/ps0gBARhP6YzwQ9vBYP4XXy9kfLXnqz7V63gxg3
	zQrBac0uqQRbT14jCbFgIDrO4R6RZsQSZjeQ2faur8UtggYIAkuFrbtyqHK3FC2sMGT37c2drxX
	OhV96ZPGzw0=
X-Received: by 2002:a17:902:da87:b0:2a0:d33d:a8f0 with SMTP id
 d9443c01a7336-2a599e50598mr8987625ad.50.1768350607330; Tue, 13 Jan 2026
 16:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com> <20260109130003.3313716-11-dolinux.peng@gmail.com>
In-Reply-To: <20260109130003.3313716-11-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 16:29:47 -0800
X-Gm-Features: AZwV_QgjCccdeltyiORAbLABm4w94V1mugSdWm8Q7wW0ar8zTgcUD8X7rXSvnjY
Message-ID: <CAEf4BzYYQzeuqVF95YZobvQAU8uhmgUSLE+ov5zUds+eH5Efwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 10/11] libbpf: Optimize the performance of determine_ptr_size
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:00=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: Donglin Peng <pengdonglin@xiaomi.com>
>
> Leverage the performance improvement of btf__find_by_name_kind() when
> BTF is sorted. For sorted BTF, the function uses binary search with
> O(log n) complexity instead of linear search, providing significant
> performance benefits, especially for large BTF like vmlinux.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/btf.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>

This change will be beneficial only if btf is sorted, otherwise the
previous approach is generally faster. So on older kernels this will
be significantly slower.

If we want to optimize determine_ptr_size() at all, I think we will
have to take into account whether BTF is sorted or not.

Or just not bother at all with this optimization.

I'll drop this patch.


> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9a864de59597..918d9fa6ec36 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -659,29 +659,21 @@ static int determine_ptr_size(const struct btf *btf=
)
>                 "int long unsigned",
>         };
>         const struct btf_type *t;
> -       const char *name;
> -       int i, j, n;
> +       int i, id;
>
>         if (btf->base_btf && btf->base_btf->ptr_sz > 0)
>                 return btf->base_btf->ptr_sz;
>
> -       n =3D btf__type_cnt(btf);
> -       for (i =3D 1; i < n; i++) {
> -               t =3D btf__type_by_id(btf, i);
> -               if (!btf_is_int(t))
> +       for (i =3D 0; i < ARRAY_SIZE(long_aliases); i++) {
> +               id =3D btf__find_by_name_kind(btf, long_aliases[i], BTF_K=
IND_INT);
> +               if (id < 0)
>                         continue;
>
> +               t =3D btf__type_by_id(btf, id);
>                 if (t->size !=3D 4 && t->size !=3D 8)
>                         continue;
>
> -               name =3D btf__name_by_offset(btf, t->name_off);
> -               if (!name)
> -                       continue;
> -
> -               for (j =3D 0; j < ARRAY_SIZE(long_aliases); j++) {
> -                       if (strcmp(name, long_aliases[j]) =3D=3D 0)
> -                               return t->size;
> -               }
> +               return t->size;
>         }
>
>         return -1;
> --
> 2.34.1
>

