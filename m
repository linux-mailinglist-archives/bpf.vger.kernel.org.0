Return-Path: <bpf+bounces-70323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF498BB7DE3
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 20:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 401B94E1999
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE68255F28;
	Fri,  3 Oct 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhRq6vcW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6D13A258
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515394; cv=none; b=Hat3DqkD0fZAfrXTW+yEQv//p1uyHPteqH6xZBEzlYiTUf+mWvkk1f6VOr8BmXluUV65W4g0u4GTEKs+lCBKG3EUnkpOzJyrd66z+W+0dxxZnSrQZoIvhuhIkSWPcnpTXKL4hE+EvXG485P/dk2+7b/WKYoFoZD5kDFVzAffzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515394; c=relaxed/simple;
	bh=L8UD/Huu6Wgtge12JBlZaEq7pAMkOwmNDJKY2VqFOLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIfANlA967dHVm00x6ENxLuqnItowRtM9LBZR74qJHYD5im98M3F7UD1ddYqfNzc3Reg34lm36THj8Hsj7Dn27QA2zx8FeZblmXX2nlFgTDLEKWpSYgAF3sI+V0vzXx1xlJxbVG+JpO4IVaeAI2Ity8Wc03evgPZsGIA4uTOqKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhRq6vcW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2250169b3a.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759515392; x=1760120192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5bKRljfOu8PyAarrpGvAa1GdkqBdHuCRZ2LMIg9fDo=;
        b=GhRq6vcWgpKpzrTAj7KnnAv5/v7dxN4WVstZxdJmO7V48r/y6svcn1JVmt+Er2yftS
         2FuFJ1B1IwZ2Cm71jozUgs+6dVfNgU07QLmDwMRTT8N0t+QaP/WWorpTtoJ7pjaeznGI
         NNAUT4Fjb67syxGvP3uEX5ddun4GicrK4ZgXV+mLdbezjgJSvXDtkikkL/sY+aA43Moa
         hyJGJ4huiJhRJg2WtwNtnZPH0axO+DAbVSrml4bUAk8HRR40fLZgLFt17mJXXBcFTFM5
         hotQJHV7Ijuawejq/NSVxK8tkT1e/sl6V2rrSg/35o7xqbOoTSdWPmiaDWFwQGf6rcgo
         5Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515392; x=1760120192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5bKRljfOu8PyAarrpGvAa1GdkqBdHuCRZ2LMIg9fDo=;
        b=gzF+xfvxljV4wa6CPwfQmYNDoodobA+fX+SDy3+e/9YhtwRzunqmWu+8/M5/q+3LLO
         Sk47lRzyJfEUvZBcWTSaP0ePUpQhoC6rQ8dYK/lFDcMwcPITEk93iMoB/SwTkX9n+CeH
         n4g7xu4P44GeJtuWbCwgrlSuuk0UUkyEGNJ8OyFIrx7XQbPUMKCA1ELez0xYaGaNpGJS
         agaHpuP9htTjiPjQO2S3gHsDNqdYdDd52K8RncxKN3XHzCRJA4A5fRe+WYSowm0Emscb
         d6fHg08DL+moNIEIO1odTsxlx9SoktpN/VcumjZQiDfoNjx/vDH6SX0iRcyrHRlA5suK
         6cJQ==
X-Gm-Message-State: AOJu0YxEqMafbK6842t3N8dSt6szbdgYWoOamyjNCidg6YReelGCoJxA
	5CVIyWLFzAd/AlIhBJooWHGjwTday4P9e4wnMxCboTZZ1BtFtrbzngQl75ytqTZBgTdt13DpZ2u
	Ij7wTeyCagnN2QcQW8WvDthVyyYpRMjs=
X-Gm-Gg: ASbGncvK4njSOatlfDkOjVeqwJ+7eI2qAnqoEaI+9Qsyh+8oZHUfzQfjCrRA8CANNxB
	W84EhPIyvf5D0e8RadBZpkPGCAayEmCK9mDFeAHTcEHC6DkI4VqyJls2zKt5X8ayL39CKWwrWga
	C90HAhy0tl8ES2VJ0xUhnoIYBaoV6SMKyeSEJ4uwjWPVy95+ra1Rd2OHhZ8xXYX0OiXL71STzBU
	rwLEWijIioqaEt/a8xDK31YW5qfMZ4aN54gc4z9se4szz0=
X-Google-Smtp-Source: AGHT+IGhJ37kPuUCZxzeMgClTpuCeIujQBHkw8Q0RKX9meW7yCg9prrqEDtm/CkL0BkPHWyI0JwNq27/M58USDzYO1A=
X-Received: by 2002:a17:90b:3b87:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-339c28008efmr5310946a91.33.1759515391566; Fri, 03 Oct 2025
 11:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com> <20251003160416.585080-5-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251003160416.585080-5-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Oct 2025 11:16:14 -0700
X-Gm-Features: AS18NWC7WZsntVc0X2HD_lGs3E80pUEbn3gklozNXFFtCpHA3tzmvF-A3J23z7E
Message-ID: <CAEf4BzZLvt1kqFsVjG2oC6yf980Y_p8zW0QXu18EWWi8-S4KjA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 04/10] lib/freader: support reading more than 2 folios
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:04=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> freader_fetch currently reads from at most two folios. When a read spans
> into a third folio, the overflow bytes are copied adjacent to the second
> folio=E2=80=99s data instead of being handled as a separate folio.
> This patch modifies fetch algorithm to support reading from many folios.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  lib/freader.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/lib/freader.c b/lib/freader.c
> index 32a17d137b32..f73b594a137d 100644
> --- a/lib/freader.c
> +++ b/lib/freader.c
> @@ -105,17 +105,22 @@ const void *freader_fetch(struct freader *r, loff_t=
 file_off, size_t sz)
>         folio_sz =3D folio_size(r->folio);
>         if (file_off + sz > r->folio_off + folio_sz) {
>                 int part_sz =3D r->folio_off + folio_sz - file_off;

AI suggests this should be size_t or u64, it's not strictly necessary,
probably better to have all the offsets and sizes of the same bitness

> -
> -               /* copy the part that resides in the current folio */
> -               memcpy(r->buf, r->addr + (file_off - r->folio_off), part_=
sz);
> -
> -               /* fetch next folio */
> -               r->err =3D freader_get_folio(r, r->folio_off + folio_sz);
> -               if (r->err)
> -                       return NULL;
> -
> -               /* copy the rest of requested data */
> -               memcpy(r->buf + part_sz, r->addr, sz - part_sz);
> +               size_t dst_off =3D 0, src_off =3D file_off - r->folio_off=
;
> +
> +               do {
> +                       memcpy(r->buf + dst_off, r->addr + src_off, part_=
sz);
> +                       sz -=3D part_sz;
> +                       if (sz =3D=3D 0)
> +                               break;
> +                       /* fetch next folio */
> +                       r->err =3D freader_get_folio(r, r->folio_off + fo=
lio_sz);
> +                       if (r->err)
> +                               return NULL;
> +                       folio_sz =3D folio_size(r->folio);
> +                       src_off =3D 0; /* read from the beginning, starti=
ng second folio */
> +                       dst_off +=3D part_sz;
> +                       part_sz =3D min_t(u64, sz, folio_sz);
> +               } while (sz);

it's a bit sloppy that we have sz check twice, what if we rewrite it a bit

u64 part_sz =3D r->folio_off + folio_size(r->folio) - file_off, off;

/* copy the part that resides in the first folio */
memcpy(r->buf, r->addr + (file_off - r->folio_off), part_sz);
off =3D part_sz;

while (off < sz) {
    /* fetch next folio */
    r->err =3D freader_get_folio(r, file_off + off);
    if (r->err)
        return NULL;

    part_sz =3D min(u64, file_off + sz - r->folio_off, folio_ssize(r->folio=
));
    memcpy(r->buf + off, r->addr, part_sz);

    off +=3D part_sz;
}

>
>                 return r->buf;
>         }
> --
> 2.51.0
>

