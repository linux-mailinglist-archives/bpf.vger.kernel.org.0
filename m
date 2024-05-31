Return-Path: <bpf+bounces-31063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D5F8D694F
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 20:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84DA3B24576
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE87F499;
	Fri, 31 May 2024 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nryb5NDs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E757D40E
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181886; cv=none; b=h9SGKTUMOBfNL0sYV3j0Ol5j6TXEr545P1y7548mEolMjaU9duJu/spnIMMkTzZFuLdO/vMUtoUR2WTCflR5WcBA/AjeHIVvtqRNzI4mZXhfgFPAEivO9/IU/nucjCN7x6+rouuukxehUWIQG1gmEdN+YgvlA8/ikrkR4xJtWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181886; c=relaxed/simple;
	bh=rqYo8eNLu5fGHX6BldStI6pNC9fDj6xd+LwIcSu6nYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyllIoIFceulO3cy0jdl8wXV26Te1dY+IdYJT7m8QjZdxIBFSynGq/5xWLxexRwEQ8aUDtl7XHThVG8pC7SGq4P4sicBY8s0pHeSPi3cf3JKIzYCPXDxK3qQbbLO7K6mzUA42sxDyI29UWhz57NzBF2tY9v6jEyW2Cc37F+ytNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nryb5NDs; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-681953ad4f2so1700973a12.2
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717181885; x=1717786685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SRub7z8jyW/Y6egcZ7vi+jQUBgA5i40V6zqCpTBx7A=;
        b=Nryb5NDs4+xVeiTGMbMUjj4etKawhVI6gEYEkV0rgpK3GZ+ij75fVZbADQd+6BPEQP
         35gFgOepSHF/1o8nEHP/AgKSpW5fLns7VDKAWAT+SGLFYr/GVs/Sm/qo0ZIq6zyH/c32
         GadFgkEgeFKII6rAv4l6rKKRcEXhz19+Xhltw5j8yWBIUuk8o6QbsyE42DVPvOfc5SBG
         QaMKzaRGXM4kdL2QlyJ5xNXcw6yrUThNcfR1f2SBMLflYnfShwKb149zqpzbM9kKAnJ5
         0gBZp/IsfJwMlFl0WYMg13DcUc2XccXHOpMetojpQJvaf5hhZG95OEqJxNrHcoFWSHQj
         vGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717181885; x=1717786685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SRub7z8jyW/Y6egcZ7vi+jQUBgA5i40V6zqCpTBx7A=;
        b=Lx73jsUsqSDZqrHfcCioI0kVJKVhqaOFjd7KcF9ZQ9AKF5jpclBY+e6MiiLuBo0piP
         qzBN9EjEagHMRInKa7KATm93TzoYYNyTxfy77uEiKB7VNGtZADglF2it+I5ypQFWp+67
         hC4NcAtaD+AZDnEUqSHqN80y34Eunkchj1+w+oRD8RN/tQXsefrNMFxLAGgOVJgdGMNH
         JU61fwNL932V0VLIvy5vECY68pVUao2x5NnibnsaCyFADVCLX5uwHxvoaI13d90R+0bj
         lai8Pin/aTBQlD7C5Q88VCuUYcv2ojgf0/sQio9ek6LcvOSzeLBZNc5NUEuiN2AQ55br
         Z99Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlZo7o01O2fHyaYQPStoiUsk1BieKB13zNEgCW12a1umou9ooggEhDinaVllW3gHVMZZJiOIugbdowG6n3eZ1GJIAx
X-Gm-Message-State: AOJu0Yzh///H1YahQZ+I+J3ORn/0/2Kywvpc03Z3G301hRV4mmaV/5ja
	S/+SU1U+f5NSVq9BPNZoh1rCVlOCMqb1ebXjCGhA1peuREZritbgK5xnwFyTPzKD5lp1nAVGl0d
	/9dvo3QFoPdIGKMbLmH3d2qFsap8=
X-Google-Smtp-Source: AGHT+IFAwYIB2LQZRQa7Y5MXk/af392rG/YpDAG/oXvJ1EUJS7nMR23ehpZK6MTsqIbuJAevmvNKeP9uZKa+uP/k0VY=
X-Received: by 2002:a17:90b:fc4:b0:2bd:d2f9:c22a with SMTP id
 98e67ed59e1d1-2c1dc59b6aemr2560211a91.29.1717181884701; Fri, 31 May 2024
 11:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122408.3154936-1-alan.maguire@oracle.com> <20240528122408.3154936-6-alan.maguire@oracle.com>
In-Reply-To: <20240528122408.3154936-6-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 May 2024 11:57:52 -0700
Message-ID: <CAEf4BzYrgm8N+scUtTyN2Nx8SRbandTE8n=o6OkPRYYyTd2K_Q@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 5/9] libbpf: make btf_parse_elf process
 .BTF.base transparently
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> From: Eduard Zingerman <eddyz87@gmail.com>
>
> Update btf_parse_elf() to check if .BTF.base section is present.
> The logic is as follows:
>
>   if .BTF.base section exists:
>      distilled_base :=3D btf_new(.BTF.base)
>   if distilled_base:
>      btf :=3D btf_new(.BTF, .base_btf=3Ddistilled_base)
>      if base_btf:
>         btf_relocate(btf, base_btf)
>   else:
>      btf :=3D btf_new(.BTF)
>   return btf
>
> In other words:
> - if .BTF.base section exists, load BTF from it and use it as a base
>   for .BTF load;
> - if base_btf is specified and .BTF.base section exist, relocate newly
>   loaded .BTF against base_btf.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 151 +++++++++++++++++++++++++++++---------------
>  tools/lib/bpf/btf.h |   1 +
>  2 files changed, 102 insertions(+), 50 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index cb762d7a5dd7..b57f74eedda0 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -114,7 +114,10 @@ struct btf {
>         /* a set of unique strings */
>         struct strset *strs_set;
>         /* whether strings are already deduplicated */
> -       bool strs_deduped;
> +       unsigned strs_deduped:1;
> +
> +       /* whether base_btf should be freed in btf_free for this instance=
 */
> +       unsigned owns_base:1;

nit: let's not do bit counting (i.e., bit fields for bool flags) on
rather big things like struct btf, which are only a few of them and
4/8 extra bytes just doesn't matter compared to all the other memory
used for actual data.

>
>         /* BTF object FD, if loaded into kernel */
>         int fd;
> @@ -969,6 +972,8 @@ void btf__free(struct btf *btf)
>         free(btf->raw_data);
>         free(btf->raw_data_swapped);
>         free(btf->type_offs);
> +       if (btf->owns_base)
> +               btf__free(btf->base_btf);
>         free(btf);
>  }
>
> @@ -1084,53 +1089,38 @@ struct btf *btf__new_split(const void *data, __u3=
2 size, struct btf *base_btf)
>         return libbpf_ptr(btf_new(data, size, base_btf));
>  }
>
> -static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> -                                struct btf_ext **btf_ext)
> +struct elf_sections_info {
> +       Elf_Data *btf_data;
> +       Elf_Data *btf_ext_data;
> +       Elf_Data *btf_base_data;

bikeshedding time: elf_sections_info -> btf_elf_data (or
btf_elf_secs), btf_data -> btf, btf_ext_data -> btf_ext, btf_base_data
-> btf_base ?

> +};
> +
> +static int btf_find_elf_sections(Elf *elf, const char *path, struct elf_=
sections_info *info)
>  {
> -       Elf_Data *btf_data =3D NULL, *btf_ext_data =3D NULL;
> -       int err =3D 0, fd =3D -1, idx =3D 0;
> -       struct btf *btf =3D NULL;
>         Elf_Scn *scn =3D NULL;
> -       Elf *elf =3D NULL;
> +       Elf_Data *data;
>         GElf_Ehdr ehdr;
>         size_t shstrndx;
> +       int idx =3D 0;

[...]

> +       if (!info.btf_data) {
>                 pr_warn("failed to find '%s' ELF section in %s\n", BTF_EL=
F_SEC, path);
>                 err =3D -ENODATA;
>                 goto done;
>         }
> -       btf =3D btf_new(btf_data->d_buf, btf_data->d_size, base_btf);
> +
> +       if (info.btf_base_data) {
> +               distilled_base_btf =3D btf_new(info.btf_base_data->d_buf,=
 info.btf_base_data->d_size,
> +                                            NULL);

with the above bikeshedding suggestion, and distilled_base_btf ->
dist_base_btf, let's get it to be a less verbose single-line statement

> +               err =3D libbpf_get_error(distilled_base_btf);

boo to using libbpf_get_error() in new code. btf_new() is internal, so
IS_ERR()/PTR_ERR(), please

pw-bot: cr


> +               if (err) {
> +                       distilled_base_btf =3D NULL;
> +                       goto done;
> +               }
> +       }
> +
> +       btf =3D btf_new(info.btf_data->d_buf, info.btf_data->d_size,
> +                     distilled_base_btf ? distilled_base_btf : base_btf)=
;

dist_base_btf ?: base_btf

>         err =3D libbpf_get_error(btf);

ditto, IS_ERR/PTR_ERR

>         if (err)
>                 goto done;
>
> +       if (distilled_base_btf && base_btf) {
> +               err =3D btf__relocate(btf, base_btf);
> +               if (err)
> +                       goto done;
> +               btf__free(distilled_base_btf);
> +               distilled_base_btf =3D NULL;
> +       }
> +
> +       if (distilled_base_btf)
> +               btf->owns_base =3D true;

should we reset this to false when changing base in btf__relocate()?

> +
>         switch (gelf_getclass(elf)) {
>         case ELFCLASS32:
>                 btf__set_pointer_size(btf, 4);

[...]

