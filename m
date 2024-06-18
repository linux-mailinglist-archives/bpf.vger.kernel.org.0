Return-Path: <bpf+bounces-32473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BBE90DF59
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 00:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EAC1F21F45
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F416B3B2;
	Tue, 18 Jun 2024 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+q6bAyk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203111779A9
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750921; cv=none; b=hSZCKthV+sWUkEJ/lYcr9gYwNv3p9DsiquUae14nwgnmEiMOhGnD58D+NWRNkuD1qYdSSQWRdvj6dBw6CDmtjmMy35TddHVec/tl1F2gnjShUNLHDtszo0YHwOWkKsHAE/0aunh90+s2V6OZhlPQPcP3DuNM+1beNteliIRhczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750921; c=relaxed/simple;
	bh=5ldMZC25Pkv8yiGmJaszpYOxfZllTnbCUsZNR1JOzYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y85YYCxXrh4salGV2ckJjPJysN/wyafxX6fZsUEdkoaTyNdk5SjnxdxGk7jpCd+j8HnuXq6Qw0ivuC98qZLKlvtf77ZzAf7khxwlf8OdzWc0XyxsJfK3LiESj9A6r+govXilv/F3btHGZyVzgtftl55knpE1lcSErgDSTCiQ+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+q6bAyk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-705bf368037so5433538b3a.0
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 15:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718750919; x=1719355719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRrSRsw/rw4lTKu58wDUZSX7V3conaNw7GoymOlFSIU=;
        b=f+q6bAyk/cBm+8bq8GyK+/rVmh9XWLkplWAp77cBqWnSUFHKVzvnWoYb5TALrHOiWI
         w9V1ZZu3RYY2rwUyrqqVgwnr+pU3sK2qnp9AHYs2+6dm6V0TP4Bo92v5bIZsy3Yc6M27
         YYlTGC9nNRU+7fZm+WJ8+12lix3BuiMZFbL1KebArTIAALLbJdtliaci61ZNxm1bT5MW
         GmK2cg5NQhSnEAlcRbIRlbuuKVTCPKsb1pvYZce9Xk4l/QZHiVv7feiamBhyUXTu5NxA
         iqC+Ppuy4jXwf94KJqh2hQCOPWpABxwFNFK8dJ06T9k7p65XTVS0fYUbffuHQyyBJ1tZ
         0X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718750919; x=1719355719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRrSRsw/rw4lTKu58wDUZSX7V3conaNw7GoymOlFSIU=;
        b=wn/aDLGNMTe99VGODpMydImeXybQmdXz3x+53HQN/Zc2iY9dw6ZzCu3hRQUsh+3eqq
         MYZXFBIoa5FsScJCpw4rZgo3My9XzYAmjIZU5r9Z1gs9+qJMMBn+6JiNXZ7TfNnoFCDw
         PmzAzfbo8PRE7TpqLpCg7iA1zsxhECOFHNfMdnRllS1T2xGSYMNVriEGiSFI4alLEOIH
         7/dPIfCz57tjp+1w5BGgxknfJA3pKbtPlUDLCFt/uIUtRGCELpF+Utru/q3gErCoGcdW
         q5WzqyVg+WdS0iwBrjpsyQiq+wXpGX6m7gzD5FweZXLSx40N/R1MBd/ahiEW6yeZTbIm
         cEpw==
X-Forwarded-Encrypted: i=1; AJvYcCUpNRG2UVqCb0oBc1vo7FWGbgmbjiU4eY88j8d1aMAadgO03dKRLdMLEAFjViwSi/RueFagJxhP4ci80cZhJ34V4ZkR
X-Gm-Message-State: AOJu0Yx+se1Wz0R+z37OdMl9dyDxYXTkXS67XDXn4j+GWHmKk0KqXnet
	Qesw+NMXyp8ggjsAkzBUqvuwzmJlWchAPXaKXlq9Yq2CdtfTNkGXgSKu6jCyL02Icbpy6tsf0by
	lrreSpU73Wk0wmEJAaH00b05zxLY=
X-Google-Smtp-Source: AGHT+IEeMWqYz2K011egpscLEzuOaBmBONlXHzA/GnwQMkbENRsYf192POF9ITSTiqhmvL7vDZx3djOzvaoey26ccNw=
X-Received: by 2002:a17:90b:ec6:b0:2c4:aa67:895c with SMTP id
 98e67ed59e1d1-2c7b5c759a9mr1077787a91.17.1718750919312; Tue, 18 Jun 2024
 15:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618162449.809994-1-alan.maguire@oracle.com> <20240618162449.809994-3-alan.maguire@oracle.com>
In-Reply-To: <20240618162449.809994-3-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 18 Jun 2024 15:48:27 -0700
Message-ID: <CAEf4BzaxC2PSCzH_BzGrFNqmEP3YmOac1QxfL1MQcvLBM0K9Yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] module, bpf: store BTF base pointer in
 struct module
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, acme@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com, bentiss@kernel.org, 
	tanggeliang@kylinos.cn, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 9:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> ...as this will allow split BTF modules with a base BTF
> representation (rather than the full vmlinux BTF at time of
> BTF encoding) to resolve their references to kernel types in a
> way that is more resilient to small changes in kernel types.
>
> This will allow modules that are not built every time the kernel
> is to provide more resilient BTF, rather than have it invalidated
> every time BTF ids for core kernel types change.
>
> Fields are ordered to avoid holes in struct module.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/module.h | 2 ++
>  kernel/module/main.c   | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/include/linux/module.h b/include/linux/module.h
> index ffa1c603163c..b79d926cae8a 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -509,7 +509,9 @@ struct module {
>  #endif
>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>         unsigned int btf_data_size;
> +       unsigned int btf_base_data_size;
>         void *btf_data;
> +       void *btf_base_data;
>  #endif
>  #ifdef CONFIG_JUMP_LABEL
>         struct jump_entry *jump_entries;
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d18a94b973e1..d9592195c5bb 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2166,6 +2166,8 @@ static int find_module_sections(struct module *mod,=
 struct load_info *info)
>  #endif
>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>         mod->btf_data =3D any_section_objs(info, ".BTF", 1, &mod->btf_dat=
a_size);
> +       mod->btf_base_data =3D any_section_objs(info, ".BTF.base", 1,
> +                                             &mod->btf_base_data_size);
>  #endif
>  #ifdef CONFIG_JUMP_LABEL
>         mod->jump_entries =3D section_objs(info, "__jump_table",
> @@ -2590,8 +2592,9 @@ static noinline int do_init_module(struct module *m=
od)
>         }
>
>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> -       /* .BTF is not SHF_ALLOC and will get removed, so sanitize pointe=
r */
> +       /* .BTF is not SHF_ALLOC and will get removed, so sanitize pointe=
rs */
>         mod->btf_data =3D NULL;
> +       mod->btf_base_data =3D NULL;
>  #endif
>         /*
>          * We want to free module_init, but be aware that kallsyms may be
> --
> 2.31.1
>

