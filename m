Return-Path: <bpf+bounces-55600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22DDA8346A
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 01:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4CD19E7EA9
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0721C165;
	Wed,  9 Apr 2025 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixww29uC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6372192EE
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 23:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744240513; cv=none; b=PBFu5zaRjKeQRSspJeiu+1mziU2SmS8A2TQHxfN/VOIlXqXWGAMq1vGHXGucwUVteFjgJ4kGmGo3T4DwX529tbTrU5uynXuAGjr92ZYr89LOcONbcEl14iu4AAt7JdrNxqQyIFEUg5Ls+myrD9//Rnn3eJfBIwPPhCLOgfW1OOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744240513; c=relaxed/simple;
	bh=STuWCQ7UE0YtXVcBIj4RuCDxRlKTiuGWwSUoATMO7hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TI3EeHuQ3U4g6XJaxYt2Zr8swmDgS26tiNF6zpTfgau3mBNCQVrvUDfBwMHeK7+Avpq3nQdQ5ZHT5dyatr0W0Hpm8RQXturUBTHsM5R6oshKie7ivbtLNi2Oys4g81yHoI1nppTrJZJtYr8xvn5GMayd0Y+kyKn8VCe75D3kbSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixww29uC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2264aefc45dso2616295ad.0
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 16:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744240511; x=1744845311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6yV4Tzp5FU+RB6OpFb2EWb0/8XWtHblBWkDEVmwxU8=;
        b=ixww29uCe+wdGXrGk6ahxW5JUdHgBNJByZHTfzhKer/tq7qXmI8MbdYTBEzIbsTCaK
         ntkOQpwniiRh/Y7/hUGx74BHgsJ7fFTRgp4S1rjdjC50bs1cOM6/EkwZLHvDCU30rVKY
         T5ve2FkP2TUjvSuiWhpLAVQsL3M+F2DgGF3sbmWB3ydHB9r4Mdm5AS3bNlWSldG4u7Q6
         DsvPkgmfL75nfn8KA8SsfnmOAm+NUL308g6wUh/FKtD3TLuUkrBRAg+JpuAsMNMdEUhK
         MGVdR4p9flPpqrWZob/H2pHem/wrXhVpRkCIMF9yM1M5c8xZ8bI9yVnwxQobh73V+GfM
         elnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744240511; x=1744845311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6yV4Tzp5FU+RB6OpFb2EWb0/8XWtHblBWkDEVmwxU8=;
        b=kgnkTSg3N+2DDUKRUwB82sd8X2AjdUdzJrDHxmn440Onu7cG4f4o/IUq2gRLNlsIdl
         aya/3YTKcgQYYcTYBUZ/I5uKzylrHBP4Lh+N/3eMQ2OaomYP8jSZt8Zc/SIEh0ATSl3W
         lXFYgvj14RjK/NCVhfUoK9iWEG1tgCIcHhgXCG3nxpkkjJ0yM3eWW/RA9ywEK7+1bVFl
         u8KQXF7ba05TsYckQKZ3pTuQLuMy+6WLvSRq0H+1dMdAPqvbQ3XaZc6bpCSnhCqB4dXQ
         SR8qEKXyoFHuoy5LJUGImd2BGU1W6JX2/JttHXK+MbSF422y/FYdva91FL5ki7+ZPXXX
         SyGA==
X-Forwarded-Encrypted: i=1; AJvYcCU32XbX1ZSb+FTYK0Lz373tltApvVQfegTRFN3sSHcZxO/443r0gymTJ2QyX6hJ8k5Y8yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVhJdoDakVtpxFsJn3g9W6h/utadqLE1EZEC9EWoZtP5JzFd+E
	HB1v7A5Su4wCfXOg5CqU75V+rSBeOzONmySxTFgoiCT3PeOyz4TodY+pQJKh+N9hTgji496F5f0
	xr9Ntl9OjfyBM9P7J+SBWJbfIxaY=
X-Gm-Gg: ASbGnctau8Ygv7DTBhG387rL7y3gH46ltZNrQ3U0pT1tYScILoe0y3dpUoRJ7cSbbze
	pN8RUDLN5lhQiCA1HWkuh1W9UDBRfQRXMPbKBBiyd2lgge9E94B/WwfMTmQxU4hrng4Grp3wTSU
	5SjwZHIKyXPBfs2UvFJNha+OXafnbM4icsQMBpQw==
X-Google-Smtp-Source: AGHT+IFaOwJMl2aLrawFVFmBNJim/NoPFAAPWClySyT1QAwQnW+SvZTZRc0rT+b9Uz9P17J72ZfOMvBukGKPMSKeMkk=
X-Received: by 2002:a17:903:234d:b0:224:194c:6942 with SMTP id
 d9443c01a7336-22be03cf997mr836205ad.34.1744240511358; Wed, 09 Apr 2025
 16:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408184104.3962949-1-ihor.solodrai@linux.dev>
In-Reply-To: <20250408184104.3962949-1-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 9 Apr 2025 16:14:58 -0700
X-Gm-Features: ATxdqUHi1PjMhLu0PojLuIwl1xGBbh2PUrADPD62lA1CacnzrCv5XWHpBP1TIhM
Message-ID: <CAEf4BzYwLHDMgWW8m2_exZvGmU7otODRueJx3CvbUPoMGEPNuA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: check for empty BTF data section in btf_parse_elf
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	bpf@vger.kernel.org, mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 11:41=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> A valid ELF file may contain a SHT_NOBITS .BTF section. This case is
> not handled correctly in btf_parse_elf, which leads to a segfault.
>
> Add a null check for a buffer returned by elf_getdata() before
> proceeding with its processing.
>
> Bug report: https://github.com/libbpf/libbpf/issues/894
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/lib/bpf/btf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 38bc6b14b066..90599f0311bd 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1201,6 +1201,12 @@ static struct btf *btf_parse_elf(const char *path,=
 struct btf *base_btf,
>                 goto done;
>         }
>
> +       if (!secs.btf_data->d_buf) {
> +               pr_warn("BTF data is empty in %s\n", path);
> +               err =3D -ENODATA;
> +               goto done;
> +       }
> +

let's handle this more generally for all BTF data sections in
btf_find_elf_sections()?

let's also use similar style of warning messaging to others, maybe
something like

"failed to get section(%s, %d) data from %s\n" ?


pw-bot: cr

>         if (secs.btf_base_data) {
>                 dist_base_btf =3D btf_new(secs.btf_base_data->d_buf, secs=
.btf_base_data->d_size,
>                                         NULL);
> --
> 2.49.0
>
>

