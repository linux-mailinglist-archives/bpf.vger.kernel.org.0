Return-Path: <bpf+bounces-60093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E81AD28DB
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C29E189237F
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA5D221281;
	Mon,  9 Jun 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF8L/EjI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38A1F4608
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505021; cv=none; b=lIrJAguwylDEvVjK/WWE8tG3CvYeVxTx4gWDBiTLo4q0RJO4UwQskm+CVsFXp9MB6SwADRU8474VAxeqqUIClsRKOGAzgduGUas0+gzyMMOmsOQTEJ2oCBsdi27HO4Zu6xkG+9/h7hAXoO+GAw+RfBNgXIKuYWmZEEXEnb12T28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505021; c=relaxed/simple;
	bh=WiX1KurRRgAHNKr27jx6nanWSSmVmmvmwfeaAwsHMIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtEFPXIxe33i+vbtStxJaGreFhXTkKrzVG0Vn0jT9vnldBFyVWThanIFq7tDTDoqQTzcOl0w8XXmBTeOgtQo1oDdj+VSMAPX1b65Z0QQizTB6gK08UoHp+y30uL/Z5Vk5JBl1GJ1KuwvDqF6RYp2sRVoOO/FrFNgeyikigRreLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF8L/EjI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742caef5896so3935691b3a.3
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749505019; x=1750109819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLkd3AspEBuF+jMWQEvNOKpHzKaV6BTz05xuPRiio+U=;
        b=TF8L/EjIsDHzGFtiDEmsZRmlRjjQ/JxwQZs0gRrdwkYapTiccHBoxvzc/xO1NmMFN/
         HgKYWFBbQuoavCvdtjefNjwXhfajS4NJl1MAddWIhtu473D3/mEykPE8dhjnyBrYb5sZ
         n9aW2ZwltKhn/dNA9ipdTWqhdwN99OqnAiCN5yb7oVI5umTU3lzrlrslfmLMjl8mP5/B
         AXzp+TIwTwDcswub8P9HcqvF2x1olXiwSxLZavGJZFTjLU1bjxMRjwbbX9o45Uqk3i4Y
         Xxgnapn1H/3ZvYB7PHCI/8kfl/fvLFfnF7uXxV7lP/XRyAArIgYKolns6a7/LwxBZBQx
         A1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749505019; x=1750109819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLkd3AspEBuF+jMWQEvNOKpHzKaV6BTz05xuPRiio+U=;
        b=RrL1cZReQ2RbOrg/5UMmd2KrxLRRS9/U/fjjQY6t9PYXT8OwXI6L+K4fYX8iJHXXAN
         nBZDptyBuPyM68HEuAee88foWYPET7BRfycpJtCsg0mnlm/j8PsPZWAUjo1B9t9BzwEs
         iDBzRjd5WWhVIM2r+93emjdOPia6kC+a9ZveiHBg2MxraBsX1vQ5IvvAYY9qxBuDMxl/
         OYnfNhaAQKzCJgbsYDdVLY0GAY/pVndbUvAk1fqBjEQU+qI+tXjiWai3rbgCmvoU9b/v
         faPYfDuYJcdYOkmnvZgyVrqhyv/88CMCO64bsYfbpzzQh8cC1rdn5h3/XcLMYlAL1ger
         z9bA==
X-Gm-Message-State: AOJu0Yyzeg0USGHJW9/c2WkaiGFftvMiM3N0o+C+vi7JjDL+nxp25SzB
	A4bltya5OL7O+yNiQJCP6SN/EXfAlz20AUoWHZN3xJ/t6ZrErahMm15nslmnRBAUr2MO2xsyht/
	EWZvyGc/bK+U3O6Z75VI7UqZIqC9h31g1jtKkHH4=
X-Gm-Gg: ASbGncsJg2XqbIYJQuDdreKmNrwscz/vVUR+lwa87mgIrHQoZqp0bFVZxvQY5x/ILB5
	Q3w8vD9AdMNgpO9RwWoJtBDccAKW14ejytH2T0vVV+eLcRn3wdzpaaK48IDVth5j5RGDnM6ZNXD
	2DqmhfzSXPnEPqSbi7gNQvhxhZf8zxebhshBWDewRzlrD2zrnJlxb20l1O7Ks=
X-Google-Smtp-Source: AGHT+IEcwdTFM1qt4ctAv30K+fHgB9pf23D2XnxlumdGdLoRdUcDGgz6AruROG30j3LjeUCQe4PPs0Ynm2+LtgiesAo=
X-Received: by 2002:a05:6a00:4fcf:b0:73e:2dc5:a93c with SMTP id
 d2e1a72fcca58-74861867674mr190399b3a.11.1749505018743; Mon, 09 Jun 2025
 14:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605183642.1323795-1-mykyta.yatsenko5@gmail.com> <20250605183642.1323795-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250605183642.1323795-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Jun 2025 14:36:45 -0700
X-Gm-Features: AX0GCFtcTeXuNOTOUBcC2WojuxC3cuoR27dhVEpsHEvrHP2Y6W6YLLMZC_0wiNE
Message-ID: <CAEf4Bza8t4ByfQJy8q_KpnSWRBBpG5iywBVSBg2GJgx+DedsZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: separate var preset
 parsing in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 11:36=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Refactor var preset parsing in veristat to simplify implementation.
> Prepare parsed variable beforehand so that parsing logic is separated
> from functionality of calculating offsets and searching fields.
> Introduce variant struct, storing either int or enum (string value),
> will be reused in the next patch, extract parsing variant into a
> separate function.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 159 ++++++++++++++++---------
>  1 file changed, 102 insertions(+), 57 deletions(-)
>

[...]

>  static int process_prog(const char *filename, struct bpf_object *obj, st=
ruct bpf_program *prog)
>  {
>         const char *base_filename =3D basename(strdupa(filename));
> @@ -1363,13 +1402,35 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>         return 0;
>  };
>
> +static int parse_var_atoms(const char *full_var, struct var_preset *pres=
et)
> +{
> +       char expr[256], *name, *saveptr;
> +
> +       snprintf(expr, sizeof(expr), "%s", full_var);
> +       preset->atom_count =3D 0;
> +       while ((name =3D strtok_r(preset->atom_count ? NULL : expr, ".", =
&saveptr))) {
> +               int i =3D preset->atom_count;
> +
> +               preset->atoms =3D reallocarray(preset->atoms, i + 1, size=
of(*preset->atoms));

leaking memory here if reallocarray fails

pw-bot: cr

> +               if (!preset->atoms) {
> +                       preset->atom_count =3D 0;
> +                       return -ENOMEM;
> +               }
> +               preset->atom_count++;
> +
> +               preset->atoms[i].name =3D strdup(name);
> +               if (!preset->atoms[i].name)
> +                       return -ENOMEM;
> +       }
> +       return 0;
> +}
> +

[...]

