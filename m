Return-Path: <bpf+bounces-32350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7F890BD12
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 23:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6524DB21678
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1B8198848;
	Mon, 17 Jun 2024 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2qZXpHw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFC194ADC
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661071; cv=none; b=b3hvlQ86DkeThZkUPO4C8GPMz34PN+0cXydzNL5GuvKxiZQRWc4eMnu/zWzySvFIOsyktFoYgNU3OqKFArPZ6/WnZ8fSA+/hvwTrJDqTOLF7Tz7df3tSIuibqAHbJkm1/sAPpQICHGklGfuuUQmBccbKCv1IQv8VqdIrhduIPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661071; c=relaxed/simple;
	bh=OQeqT99AW89dKGgzAfBxiql4EcJevq+yBaUn4BaiCos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXHWq6o5jkGD9QWfTLQ96AYD4Fc4jP/dbYJYniw9SCIuGLRrbc6cu5NepUDEF3mdC4NYFifK2RalPwlG3IGmRpSPMWOcb31SI0LGYo1squGAyukp7gIx8I77Nbe+Fcn/gdtFxdu8ih2SCLlauFj8hFiOKnH0iD8VHDOgrZ1hGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2qZXpHw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e41550ae5bso3475763a12.3
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661070; x=1719265870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50EesF6PZar821ZOdu2yMbx7ROb2NuQJu+X1dXvIJTU=;
        b=M2qZXpHwHxaRruA6ovDd75sKsaxh1vKYPfraurgIKJqOmNJrZJ+dB5DJPaw8at+JR8
         Y2pwc+7Cg4n0WwEw2pa9Keant+M3zPb2NK6qGM8x1rr6DV36dNLjDRU/b11k4/43xPL8
         +eCpe71qPR9JOwsSWwYSf7GIwaLFudzIHFU4r45wDXxcPl5acZzFWaqHsPTge8D3dzRJ
         CM0kAL3cNfeUnOfYxQhMCjn6uIGSVprjSiPSRtxsa5tw6vlDyRAkaubwvrWk/RqBYRPL
         h9/vQRKbYkQIWRiHMNPkdxe08JXgaHAhu8tRrgCaU9ESwmJh+XNJ+Rq6QAfk39CcJHV8
         FLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661070; x=1719265870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50EesF6PZar821ZOdu2yMbx7ROb2NuQJu+X1dXvIJTU=;
        b=Y6NVOFCWuEH+k7BqhMxa4FT1PMXZyWASK9t4dPTgyNQuVnJLODtgzey760bnfm9lTQ
         0mvNnYuW9bsVQCzVBeJtiRjdAdqtaJIzGNBOXiFX/ivRKeAfYd8KRD5yek/m9BslxF6J
         41LUUE+AlM2MqRAYagbwFOybxRci5F4V/RNBuZg8n4Cx0Jgsds8fbaJ5NXbOnF8wcOAF
         BNIPwL7j8ftsQumd41/ZftJfpQbpO8HOFvghGrewVzVF9ka+1Y/Zo9X6eWJrA5hdrfXv
         KGUXcSNEwoaegGkkKEab8hjCD9nEBbKEraSktTNQ5uUeCoRYITOyeIyYBkeB45SKMBQ3
         986g==
X-Forwarded-Encrypted: i=1; AJvYcCWvqIhuvdnVeWWSlJWyLznLHidGnv9TB6dwUr+sDqilQZvwAyzsZzYWEicvIKxlefhoTj8LJdQKHULvU6+GVZRT4j0F
X-Gm-Message-State: AOJu0Yzx3a0vzqNoibbnhg+4dWVcbuBfzsmMcSkMgATqfadxIDYL+3UH
	mRNYqvHHCIvq0+9Mfl1uQzmmwWI4FMo6lR98P5JgQrn6xA5PsUHFT9CJ3gNwFtfi9YVD7XDcn+B
	6l3pzBJy1UNNv7eL7OfRwALDQ5ow=
X-Google-Smtp-Source: AGHT+IEOzy6b/JwoPvf44Tpg+QNuUuZ03e7/b0eMAU7X5BBldMB6HG9LEt5ma02ONTf50Q6+4ogNRcyfWHq2TPLx5hE=
X-Received: by 2002:a17:90a:4491:b0:2c4:c2d3:c061 with SMTP id
 98e67ed59e1d1-2c4db24d283mr10677360a91.18.1718661069828; Mon, 17 Jun 2024
 14:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613095014.357981-1-alan.maguire@oracle.com> <20240613095014.357981-8-alan.maguire@oracle.com>
In-Reply-To: <20240613095014.357981-8-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 17 Jun 2024 14:50:56 -0700
Message-ID: <CAEf4Bzag5mh9ot5oVYR6-HabpFWa8iEZE0bDxLFfKkoAtjL+Kw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 7/9] module, bpf: store BTF base pointer in
 struct module
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 2:51=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
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
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/module.h | 2 ++
>  kernel/module/main.c   | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index ffa1c603163c..ccc5cc5e0850 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -510,6 +510,8 @@ struct module {
>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>         unsigned int btf_data_size;
>         void *btf_data;
> +       unsigned int btf_base_data_size;
> +       void *btf_base_data;

Please reorder, we don't need unnecessary padding between the fields
(so easily avoidable)



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

