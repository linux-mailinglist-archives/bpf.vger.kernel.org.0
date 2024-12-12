Return-Path: <bpf+bounces-46761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD34C9F002E
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB1218850DD
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE21DED40;
	Thu, 12 Dec 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSel8h+c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4821DE8BF
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046162; cv=none; b=ruC/EPuoF9Cr8j1WAEEWD8tgi6eaV7/X6ngkF6k/3DDZj4ZObAgCRr4iWr2v/t79svVVM+HASO5BW1bISBA1XCpGv4We0NSKCuUHgsbdDJ6MTtpgdGZ8454uBkpcGjE3jghUy9ggNTDkqjZUsGrh+mO93kSKAzS6l+lLI/9JBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046162; c=relaxed/simple;
	bh=Rsq4j45GyEHlVXFsoM1OGwHDUOI7HFo6ZdCW/4+klcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXQ8ZbuL11Gaurxoe0ocGbvGYhApsWcVrb0JcomQbqjG12FS2qb1uPWgzJPR9j7AUoDmqEFHwf9VZ6sqGISUqMF3IxoPR2qApop5GeFHqWugQVl6xjyF9LX6Z1lAQ/4TvvL4k/iHu7fu7swTqZZyTbOqKdiuKb8yquADAo4K+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSel8h+c; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so983681a91.3
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 15:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046160; x=1734650960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq0ZLj8Z6Xxm3HRaRG219JE/MzHXpx9y7aagL1ZsMig=;
        b=PSel8h+cqTTcKTXKJcN776CnNerDWGy2WeIOqa7JLNWu78inn1BFvR97LZH/ehafyV
         n+44uM72KOIIIWg0t97zTvzI/HX1Ro35xHw3rkwUZyq9pphhgWQWcc1KEwXTpCgySjMj
         L6Qeh2+ycVNTUD4yZSRukhjDrpkSlklnJpldEEvgaeYYeNIrx3AxDp4yesT/k2oVYpbS
         kIwz3CTDvSGM79ekJfql1fgJET9SsXZW77n+gdKRX+VwaZ/Y8F4kcXC7R7+xaVmcw2GQ
         wn8q8+TbSzyND9M2vouR2/YU9qFH7JXiMrGuOatOUcucTBCLyj/h9tAOIizgiYce9rH4
         boUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046160; x=1734650960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wq0ZLj8Z6Xxm3HRaRG219JE/MzHXpx9y7aagL1ZsMig=;
        b=KCnqWB0Q9+IvEtVlCT3w0ApKCcP+pLOsHRT7EkXhAKOUVfajiJC6tpBijImJy6ZeE+
         BLNbu5XQkcympkCUm8YpZNn3i2OqM53y2xnBKd4FI4OH4ERWkAC3sBhN6oaf1aRHVPvS
         jtKBz/mep+yDpWaZosD/+63OS62R6lrsGSe/FlKvgB2qNFI+sn3SFA8QICpof3zrZgKI
         xWYwIRrRyGAEUJaxfMFObeixbD137WvkQxYrC1TJ2BTIV1iprN9Vg5ZWv5y4c8q1lZBm
         HnYUq4N/48E2ehbtvttGSofIpksQL2BjB2P7BS9PkFfOQ+dcjJAyNQ0kErlAwMbQnPOA
         vXSg==
X-Gm-Message-State: AOJu0YwkBYMzG83cF/UsRPFv/cdK9T56gXU+BgTfs/GnRqO+yJ4NgfG+
	vAbbQ6TIWvdCkyDFSNDqwT0lKwLaY8QRrtgxNG8GkT7Wrw6qzlFzwdAfTzRtjGlbWeEmbpLND3m
	8g0RM+IpvOyDQPIbGxk3oEUNoOVY=
X-Gm-Gg: ASbGncv/jDj75NHCFJiLAz9VTjuwfcRyTYr8cwskRT4j/RDC37X9aVZoNXjSP8iMtfO
	G0UUH66BgQOEzlxxMMV1yEmusj0rfR7CB2MA3Q8x+eIWKbWBuKDVsIw==
X-Google-Smtp-Source: AGHT+IGchVMXXYNFgO5QvH9dTakqkhcTLO9/M+YDk2ad/5cP8c5o1UcHCmmy27bTs9luxCdzIN0jCWQp8p+3X52BY5w=
X-Received: by 2002:a17:90b:280a:b0:2ee:b4d4:69 with SMTP id
 98e67ed59e1d1-2f2903a450cmr878103a91.35.1734046160094; Thu, 12 Dec 2024
 15:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211164030.573042-1-ajor@meta.com> <20241211164030.573042-2-ajor@meta.com>
In-Reply-To: <20241211164030.573042-2-ajor@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 15:29:08 -0800
Message-ID: <CAEf4Bzanbwpe2ULqJb_GXjYsD8S4=nXv017nS+B4qbynTeZLnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: Pull file-opening logic up to
 top-level functions
To: Alastair Robertson <ajor@meta.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:40=E2=80=AFAM Alastair Robertson <ajor@meta.com> =
wrote:
>
> Move the filename arguments and file-descriptor handling from
> init_output_elf() and linker_load_obj_file() and instead handle them
> at the top-level in bpf_linker__new() and bpf_linker__add_file().
>
> This will allow the inner functions to be shared with a new,
> non-filename-based, API in the next commit.
>
> Signed-off-by: Alastair Robertson <ajor@meta.com>
> ---
>  tools/lib/bpf/linker.c | 83 +++++++++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 42 deletions(-)
>

[...]

> @@ -440,7 +439,7 @@ int bpf_linker__add_file(struct bpf_linker *linker, c=
onst char *filename,
>                          const struct bpf_linker_file_opts *opts)
>  {
>         struct src_obj obj =3D {};
> -       int err =3D 0;
> +       int err =3D 0, fd;
>
>         if (!OPTS_VALID(opts, bpf_linker_file_opts))
>                 return libbpf_err(-EINVAL);
> @@ -448,7 +447,16 @@ int bpf_linker__add_file(struct bpf_linker *linker, =
const char *filename,
>         if (!linker->elf)
>                 return libbpf_err(-EINVAL);
>
> -       err =3D err ?: linker_load_obj_file(linker, filename, opts, &obj)=
;
> +       fd =3D open(filename, O_RDONLY | O_CLOEXEC);
> +       if (fd < 0) {
> +               pr_warn("failed to open file '%s': %s\n", filename, errst=
r(errno));
> +               return -errno;

errno can be clobbered by pr_warn(), so need to save it like in
another pr_warn case above, fixed while applying

> +       }
> +
> +       obj.filename =3D filename;
> +       obj.fd =3D fd;
> +
> +       err =3D err ?: linker_load_obj_file(linker, &obj);
>         err =3D err ?: linker_append_sec_data(linker, &obj);
>         err =3D err ?: linker_append_elf_syms(linker, &obj);
>         err =3D err ?: linker_append_elf_relos(linker, &obj);
> @@ -534,8 +542,7 @@ static struct src_sec *add_src_sec(struct src_obj *ob=
j, const char *sec_name)
>         return sec;
>  }
>
> -static int linker_load_obj_file(struct bpf_linker *linker, const char *f=
ilename,
> -                               const struct bpf_linker_file_opts *opts,
> +static int linker_load_obj_file(struct bpf_linker *linker,
>                                 struct src_obj *obj)
>  {
>         int err =3D 0;

[...]

