Return-Path: <bpf+bounces-62015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EFFAF0580
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 23:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7761C05C30
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8FF244688;
	Tue,  1 Jul 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHP9EShH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA781CA81
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404612; cv=none; b=SNlysHW7OnLeU65R6zkbSa5nBo4VhGh51suTKWxInDj/6U1IxC0g7H73SEFBbnhxfpQOFU0gor3TZdvnBerVq+kklvEqyZbNktVLgnPWEdsqz4VU1MbDkpc5spDC1t+hI80a15mjv1T5CtYUqskxTTBJvvCkbs7vN/vIH+buUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404612; c=relaxed/simple;
	bh=6Kdysf0bM/zC7IZkrrhrsYDx1Uk68jOJV2hJxPqenEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=My2izB9kjJZirwXu3q8bU+okfUK3NkbknopWC4oEQ4UVToICa+lWNZa9taeIZFgYfpfvhfSWvIW2nbmMWeStZsNN2WFQOR6v+WNU8WdATTckulqUPmDwPUQ1vV9AAdvOy47vOHp+E5sMMhzRsLTZgpcFdLJ8rGq4uSMDBz+9A5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHP9EShH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3139027b825so2506165a91.0
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751404610; x=1752009410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVd3ccOYWf0E5sX7tEPAxf2nNYyoU9IZn+6Fm2hV6tk=;
        b=dHP9EShHlWEK5j3LRn9d3WWEW33jQnPtjoVQhZoxQy6XUSIhy1r1p1uU76OUcQAfx4
         GUV/6YWcaIXptl/QvFnuReAQVg1Wi7wp9QfxJP0tTKj1HiAGHnM5yqQ7FbLAe72TIoww
         mZjCljeJNVNVYLwsqmqEu6yPgJrtAojxjSM8Iots9lf8OcXfI9g0wPCFdrT4rd49qfq5
         +kvPjv7GUORkaBzG4JDh1rpIz/mw4MFBxQBPKIOzNwQcZWrWmyuKhfPvH2ZGoa6W15Sg
         nmZylFfREpuNzEj77RhffQuHGXu/p15vmlcUeeqvvdGsMwlWa8AhZJCT0dMKsyokJedD
         +6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751404610; x=1752009410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVd3ccOYWf0E5sX7tEPAxf2nNYyoU9IZn+6Fm2hV6tk=;
        b=QnAPlLX/TSJ+OXNGTUZjUIGSlAyxE8MqQ/WHr0Xq+6/xSgw0a3m8i5sQNL9IhccJab
         BSMlJtberWJQkxLhAa40lUX3Ya8SXBTIzT5M59zGOa7QZlBF25TxE9y0bHoXlkdTpME8
         3e5oiLQvVXOde4L5KSDoaegNiOmWyV3qCNStsnDcjN2Y2PDiOOg5o3adXKLRu5s3hS1y
         +Oo+HJEZdpH/9erfRuQ69JgxXGItc+7ZE/QQjKhBZK2qVztU3uLa5wAnQ/61XRbigkTM
         XDFCX0vrgnpWrYrGr52iJhDuJZabJyjiHN8S+3KkveUlX38MbT4x/Bd2U03IjAUQjyxT
         9T0Q==
X-Gm-Message-State: AOJu0YxZGGK5Rku84BBI1rTgmeJixtcnF7AOEEEejgDmqHaKU7rJMPh5
	mEXcLpBzJ7DwNVlb8dbJb9vsebsqTvLkVRNXTI5ze0Upr3qg1GazozcCjfsHvnsFbrx4DxDZAZN
	e4asoISBYH8z45VGWzOsLNv/NnY9c5ZU=
X-Gm-Gg: ASbGncuZIud8Papf2eF7TWYV929sDJHxSzicTMcakTr18Hp7g8+9IBxYvtB932vWyPV
	GpF15EuWt6ywmCyrbRBuVqN0J1wHfa+1s5nCmS+WSqK9b6Ps1LSD6rQaAFCsILJgAtMRg1d56dj
	CAkQEM0B+EVm3v4DtdM5aiEvaFeRoUDDCIh9vHwY+DXZa4Txd0aaFNX2TW7o0=
X-Google-Smtp-Source: AGHT+IGTXSgEdVfDv8xDTMjnEY0lXKoVvrkgY2rKi1nNLcJAIgee1rL7X5GpGs5GlgJtxXL4iNWWv/5vFPjoCHoVZFE=
X-Received: by 2002:a17:90b:54d0:b0:311:fde5:c4be with SMTP id
 98e67ed59e1d1-31a90c352d5mr683025a91.35.1751404610152; Tue, 01 Jul 2025
 14:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630212113.573097-1-isolodrai@meta.com> <20250630212113.573097-2-isolodrai@meta.com>
In-Reply-To: <20250630212113.573097-2-isolodrai@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Jul 2025 14:16:36 -0700
X-Gm-Features: Ac12FXx83vjJSze8bYYXLS10QgSujKlRlY0ecvX0w0pDKSyY4yU-4QegLjVLyWw
Message-ID: <CAEf4BzbT+ge3UNz-RQVTZ3rujJ2xi_Eg5bYeQjd13JqHr0PgFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_dynptr_memset() kfunc
To: ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com, 
	mykyta.yatsenko5@gmail.com, mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 2:21=E2=80=AFPM Ihor Solodrai <isolodrai@meta.com> =
wrote:
>
> Currently there is no straightforward way to fill dynptr memory with a
> value (most commonly zero). One can do it with bpf_dynptr_write(), but
> a temporary buffer is necessary for that.
>
> Implement bpf_dynptr_memset() - an analogue of memset() from libc.
>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  kernel/bpf/helpers.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index f48fa3fe8dec..415b50415598 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2907,6 +2907,52 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr =
*dst_ptr, u32 dst_off,
>         return 0;
>  }
>
> +/**
> + * bpf_dynptr_memset() - Fill dynptr memory with a constant byte.
> + * @ptr: Destination dynptr - where data will be filled
> + * @offset: Offset into the dynptr to start filling from
> + * @size: Number of bytes to fill
> + * @val: Constant byte to fill the memory with
> + *
> + * Fills the size bytes of the memory area pointed to by ptr

nit: looking at other doc comments, you should use @size when
referring to parameter (same for @ptr, though nit-within-nit: we seem
to be using "p" for similar functions)

> + * at offset with the constant byte val.
> + * Returns 0 on success; negative error, otherwise.
> + */
> + __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *ptr, u32 offset, u=
32 size, u8 val)
> + {
> +       struct bpf_dynptr_kern *p =3D (struct bpf_dynptr_kern *)ptr;
> +       u32 chunk_sz, write_off;
> +       char buf[256];
> +       void* slice;
> +       int err;
> +
> +       if (__bpf_dynptr_is_rdonly(p))
> +               return -EINVAL;
> +
> +       err =3D bpf_dynptr_check_off_len(p, offset, size);
> +       if (err)
> +               return err;
> +
> +       slice =3D bpf_dynptr_slice_rdwr(ptr, offset, NULL, size);
> +       if (likely(slice)) {
> +               memset(slice, val, size);
> +               return 0;
> +       }

I think what (I believe, Mykyta) was saying is that by doing

slice =3D bpf_dynptr_slice_rdwr(...);
if (likely(slice)) {
    memset(...);
    return 0;
}

if (__bpf_dynptr_is_rdonly(p))
    return -EINVAL;

err =3D bpf_dynptr_check_off_len(...);
if (err)
    return err;


we have the fastest possible expected happy case, and we'll do all the
sanity checking if happy path fails either due to non-contiguity of
memory or due to invalid size/offset/read-write permission

pw-bot: cr



> +
> +       /* Non-linear data under the dynptr, write from a local buffer */
> +       chunk_sz =3D min_t(u32, sizeof(buf), size);
> +       memset(buf, val, chunk_sz);
> +
> +       for (write_off =3D 0; write_off < size; write_off +=3D chunk_sz) =
{
> +               chunk_sz =3D min_t(u32, sizeof(buf), size - write_off);
> +               err =3D __bpf_dynptr_write(p, offset + write_off, buf, ch=
unk_sz, 0);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>         return obj;
> @@ -3735,6 +3781,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
>  BTF_ID_FLAGS(func, bpf_dynptr_copy)
> +BTF_ID_FLAGS(func, bpf_dynptr_memset)
>  #ifdef CONFIG_NET
>  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
>  #endif
> --
> 2.47.1
>

