Return-Path: <bpf+bounces-61569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3456DAE8EB2
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB36B3B5AF1
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7702DAFDC;
	Wed, 25 Jun 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZepoUoS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703F25D521
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879739; cv=none; b=lYcoRI4dIsO9dORwfTn3AZdkQPHL5gQ1Hu8cPqRcVOk889eR/DiZuMvwJ1RPibOMocpAGQvZOs/Xv1FVUoH0mgO7y4wbsL+WfMTd6F/tAfZ6MeEzAeG9q+Vg+aNrxIg++8rS/prga0D0s+WSp/SUYZSkhe9vBTKRbmJyVnMhtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879739; c=relaxed/simple;
	bh=jGx7BM/V2EvVM/FRo/HhKjSRQpNqrgZ3lNa68E5luT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocGgBic7UKet9q7afuBlingRjIg0309983eKKwzoC1kmn7XuAWV8O8x20bg4C1DpE2/ufhYa3LEd4ScTMDutfOhdsoLJQ8WjSPHBPFePsjzaLvFXxbPd3FlMDrXYeJUjCEHfaxeMMEkweG/LRsF6F82a5uPbFkQEDdpkYfK/9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZepoUoS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so197564a91.1
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750879737; x=1751484537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZiAY2wDDJTbulFAoj64aJZ/PYDQKNB1ZELyW3Brw6U=;
        b=aZepoUoStvsiDZ39UgFYDLAsFOxngD6p3YzX7fzHh0lvqMoKBT8fRBWASCnd7E3M2y
         7QrgyM9RpIKRZA+q7tUaLAPFBbxELTLA2Ozdpl/uNZLkRfPpAzp1omwoa2GhxPaMzEwO
         cnOvDtW0Fy0vzAEv94W1RXyr3QmFR2LSusCVDLbD1zL0zr1to9ZHJNhnqH9+XwydEmqO
         Ol4YcG6hUfo9l2Z6oABUi/O3XNmcAvpMuDFqnrYHyDTDIZxwZGp7r1BrPRaWF39ZQT0O
         cQocuRndY2g7JKbXS1Xl2DGTqb6ZYrstUr9fyCVWaGMIAZ15FAZWuPU6nxtK0tdrBx80
         xYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750879737; x=1751484537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZiAY2wDDJTbulFAoj64aJZ/PYDQKNB1ZELyW3Brw6U=;
        b=aZJDZrFfynXdDAKFtNfiRZ5liqcafrcqVee+KxB689Zo3P0wiRJmW42mZ/TYLuG9ZR
         dx2GnukQrApunu79bDrMR97dOV20Fy+nYLRoPUbLFeRmN6nDaiGE8c9bNxmoGm3tsf4U
         Vsr1qQ/OG1yW7hDnkaxkSJfftkB9bxC5YJe4RtG/QXWsTL1zJGhVQnMimuQAhKVd3vFy
         UnmIoLwMZZIHDSYCjhQtGbUr/GUBNoCOJRtu/SxwgrvTqcg/uSoZ8NJO3YqPgOJ4wpi3
         8iqTkvHkKvw3d7r7h7z4qnxVNo+4sp2e9WRBqAH+7veqHJjApbiKIg4SBOC4KmyXtQNV
         iipw==
X-Gm-Message-State: AOJu0YyTSKYvvqwjT1yzPJGju/kZ/0Xz+aH930O8/HcNV5wgT5AZ+uTT
	xMxgxSyRrAR+k9zvs36k0CGUqb6oR+NoOcMJD8er346AeS41bCic54f4x6sVC71Whfwg6Vu2h8j
	hE/Tq3n6Dj1KU0bkkp1YgvQNBrM+WWF22ltPf
X-Gm-Gg: ASbGncu0ZCdI2vXfqZhIAGYXDjkh+hL0LbZntGw7hHCv/HbHE2129eMInCkCMxlKbzf
	XAYvRMpypPc+/vcdl5wApQev8zTS0vCSku41YV4rPhZSXhswOXcc9NIEnvboVm9WlTyGm72uuvl
	Y63WWkWNAn23wJZtYXMmk561C3teM4oyFc6u3qnE/QAntTYKDS32pOl59Q0wQ=
X-Google-Smtp-Source: AGHT+IEkvwk86swXl1Pm6baVTCFdYBpzJ41LxrJwDm/La3vdZKfxEsqK3GKraipEx0fnZFIXoyMTQedItTOatq6ShFA=
X-Received: by 2002:a17:90b:3c07:b0:311:ad7f:329f with SMTP id
 98e67ed59e1d1-315f269d81bmr4861113a91.31.1750879737475; Wed, 25 Jun 2025
 12:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625050215.2777374-1-amscanne@meta.com>
In-Reply-To: <20250625050215.2777374-1-amscanne@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Jun 2025 12:28:43 -0700
X-Gm-Features: Ac12FXyp4lMbWo6ZSACurKgpRmetL0ZpWxfBMToC1AYR7zSk6mHclb0GTMuER0o
Message-ID: <CAEf4BzaT5_GGFsjzCJurXxYCUf9+-RJd6d716NTA8cqPry79Nw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] libbpf: fix possible use-after-free for externs
To: Adin Scannell <amscanne@meta.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 10:02=E2=80=AFPM Adin Scannell <amscanne@meta.com> =
wrote:
>
> The `name` field in `obj->externs` points into the BTF data at initial
> open time. However, some functions may invalidate this after opening and
> before loading (e.g. `bpf_map__set_value_size`), which results in
> pointers into freed memory and undefined behavior.
>
> The simplest solution is to simply `strdup` these strings, similar to
> the `essent_name`, and free them at the same time.
>
> In order to test this path, the `global_map_resize` BPF selftest is
> modified slightly to ensure the presence of an extern, which causes this
> test to fail prior to the fix. Given there isn't an obvious API or error
> to test against, I opted to add this to the existing test as an aspect
> of the resizing feature rather than duplicate the test.
>
> Fixes: 9d0a23313b1a ("libbpf: Add capability for resizing datasec maps")
> Signed-off-by: Adin Scannell <amscanne@meta.com>
> ---
>  tools/lib/bpf/libbpf.c                           | 10 +++++++---
>  .../selftests/bpf/progs/test_global_map_resize.c | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
>

LGTM, thanks, applied to bpf tree. But for the future, please split
out selftests into separate patch from both libbpf and kernel changes.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e9c641a2fb20..52e353368f58 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -597,7 +597,7 @@ struct extern_desc {
>         int sym_idx;
>         int btf_id;
>         int sec_btf_id;
> -       const char *name;
> +       char *name;
>         char *essent_name;
>         bool is_set;
>         bool is_weak;
> @@ -4259,7 +4259,9 @@ static int bpf_object__collect_externs(struct bpf_o=
bject *obj)
>                         return ext->btf_id;
>                 }
>                 t =3D btf__type_by_id(obj->btf, ext->btf_id);
> -               ext->name =3D btf__name_by_offset(obj->btf, t->name_off);
> +               ext->name =3D strdup(btf__name_by_offset(obj->btf, t->nam=
e_off));
> +               if (!ext->name)
> +                       return -ENOMEM;
>                 ext->sym_idx =3D i;
>                 ext->is_weak =3D ELF64_ST_BIND(sym->st_info) =3D=3D STB_W=
EAK;
>
> @@ -9138,8 +9140,10 @@ void bpf_object__close(struct bpf_object *obj)
>         zfree(&obj->btf_custom_path);
>         zfree(&obj->kconfig);
>
> -       for (i =3D 0; i < obj->nr_extern; i++)
> +       for (i =3D 0; i < obj->nr_extern; i++) {
> +               zfree(&obj->externs[i].name);
>                 zfree(&obj->externs[i].essent_name);
> +       }
>
>         zfree(&obj->externs);
>         obj->nr_extern =3D 0;
> diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b=
/tools/testing/selftests/bpf/progs/test_global_map_resize.c
> index a3f220ba7025..ee65bad0436d 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_map_resize.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
> @@ -32,6 +32,16 @@ int my_int_last SEC(".data.array_not_last");
>
>  int percpu_arr[1] SEC(".data.percpu_arr");
>
> +/* at least one extern is included, to ensure that a specific
> + * regression is tested whereby resizing resulted in a free-after-use
> + * bug after type information is invalidated by the resize operation.
> + *
> + * There isn't a particularly good API to test for this specific conditi=
on,
> + * but by having externs for the resizing tests it will cover this path.
> + */
> +extern int LINUX_KERNEL_VERSION __kconfig;
> +long version_sink;
> +
>  SEC("tp/syscalls/sys_enter_getpid")
>  int bss_array_sum(void *ctx)
>  {
> @@ -44,6 +54,9 @@ int bss_array_sum(void *ctx)
>         for (size_t i =3D 0; i < bss_array_len; ++i)
>                 sum +=3D array[i];
>
> +       /* see above; ensure this is not optimized out */
> +       version_sink =3D LINUX_KERNEL_VERSION;
> +
>         return 0;
>  }
>
> @@ -59,6 +72,9 @@ int data_array_sum(void *ctx)
>         for (size_t i =3D 0; i < data_array_len; ++i)
>                 sum +=3D my_array[i];
>
> +       /* see above; ensure this is not optimized out */
> +       version_sink =3D LINUX_KERNEL_VERSION;
> +
>         return 0;
>  }
>
> --
> 2.48.1
>

