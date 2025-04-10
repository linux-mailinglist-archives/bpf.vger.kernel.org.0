Return-Path: <bpf+bounces-55686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F50A84B4D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF484E3EBF
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1CA28EA74;
	Thu, 10 Apr 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la11uUvA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9827EC7C
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306809; cv=none; b=r7a6QEYcLLQojxCYcjZ3CylbQGZtYtL+fCTlTQpbBnmyIEjBX9EktmkwztF3k3r2h3Somy678YcuGsaH4LeCc928BE+rXMfcO0TkUBqYDp8M/SekuzLjhTuxll2yMy+WNyQGz8prELIVgfVdZF0eNhNuwTsR+BDt/kPSuYeGnFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306809; c=relaxed/simple;
	bh=/QY0OUD74xC6ub9tTN7cXB+XDq5m9DDuxwRk2aSbyjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5zGviMmUyihYVDwO0CSKlye2gZYPb0KRB+L28D6FGCgI1J1n0exCr8lZrWjX13/hS2Hi/GQBowKo5A0zWPkUmwVUJcm3s1bawNjI2cKbZxgZfou2SD8tmzDygZwNgvykze7s2JJTT1LhIgQQ0OBsceXJJhGHDDfoJzFX/zStRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la11uUvA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so1087432b3a.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744306807; x=1744911607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWLxg7YSdy1xycho3fz494JGp1UvdqfonTlamsRaPUg=;
        b=la11uUvAhpKUCpOkbQK6SgjymjzZfNXin0wbq5rSVwqjKyOqi3qHF1KUg78DEd44+B
         oOHRcbRq9NBMwq0ns56X7+QfM8Z8AXpb6cxoZfUiQYvfGewMO+bcK4XTOPaQfDhfVfiI
         nYc2tgfArFhwtyicmDurjoTzA/OAr3DrDjhu4mDakpvwbA6oGbbDJk66LFk36QiSRAuC
         AJKOda4xSIRSFDRQ/OJoYEpAtH3ouALecCpeX3OYjv/J+9kRUrPEn7xSz2+eO0HATN8d
         WO72Mf4oLbNp3uGoTH6TMzdIgcS5WVI0EYt8/++NUcug/yz0LME1oLNY+dSpSOBVGaHz
         mJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306807; x=1744911607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWLxg7YSdy1xycho3fz494JGp1UvdqfonTlamsRaPUg=;
        b=MrPyMIztvTVCuusfVH7cClc3PZnHtbepFN9sd2kaOBXPL5jMIAyFcZrJu6rCNtkzF0
         +H/RadlwzYof02dYvMwCD69tAIbNNDz75cvCIPDShSJ20kdn2Y//dfoDhb4aOdv2vcvf
         yBuqRazdpeA90lQpD+Qwrw6rw2na8vdaiDn5OQZA9r4cENGm18MMpRjpbWUQpCI5y/sZ
         c+1clOVML1VBVQpveB54n+77tOvaxAeM4hMNUvjya99zZv3K9yT2WFhInKYeJhsTYRn2
         LqZwfTXhEe7rfxSl+2k5enirPd41y/7BS4REwtbax5Q9bv91wi2UMGwS8h/gTuVvxGa2
         tY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaKmSCNQIU55kaBe5vYoBfHGZ4Br7CznBsf4phY1SfhMWE4t9kHMI1nmSOasox3nIykTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgoA/JX+968LY68KTmgzKbNNgedqIWAZigvhtOMxf2YBYMjWH
	DbWZAPmgBFO4T1ANJMNdssa3tYRaMA0btYnArpvx9Dhhw0uRn5z6lQ5///IRmMm6cWK+xXCueUB
	KCgpC3zYvQnJKxu5SqTr5DfTSXC0=
X-Gm-Gg: ASbGncv4GNuyWy9DUJgBJ9pBg8ugo1rlL2hQgznTKYFwAPxYMmHKNuGoM348adSMqfO
	rEdw+0oIh2OIWyH5eVbR3nTYIvEmaXmG9wUZHFw9URxxCZp+RY4uxsYSWl92lRNohdvHI6yMrVV
	eTLY6KuUJUUbYlNyTz5hX5fP0uJRAHCdHfVH7L
X-Google-Smtp-Source: AGHT+IG4ZbBgQEBk8v2yBCa7NjcYqsAouaZfGP0ajqx40CotAzYVGnSEQfXLnzWDrTtq1K3MDPPftTxasCgVt/yRvT4=
X-Received: by 2002:a05:6a00:1147:b0:736:4abf:2961 with SMTP id
 d2e1a72fcca58-73bc0b8f4famr4316165b3a.17.1744306807423; Thu, 10 Apr 2025
 10:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408184104.3962949-1-ihor.solodrai@linux.dev>
 <CAEf4BzYwLHDMgWW8m2_exZvGmU7otODRueJx3CvbUPoMGEPNuA@mail.gmail.com> <9cc4191bf68d1943c49b68d8fefe89db8a114d2f@linux.dev>
In-Reply-To: <9cc4191bf68d1943c49b68d8fefe89db8a114d2f@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Apr 2025 10:39:55 -0700
X-Gm-Features: ATxdqUFoo0rbj-ppQs0XKfBQ3Zov7mzfWw7kwKY_Mxb6v6vwq0J7L8J5Cki4S0w
Message-ID: <CAEf4BzYDJM4MCHFAGhZaV9p4xByYuuWi-ZxXT1TDu4YTd9iZMQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: check for empty BTF data section in btf_parse_elf
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	bpf@vger.kernel.org, mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:34=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 4/9/25 4:14 PM, Andrii Nakryiko wrote:
> > On Tue, Apr 8, 2025 at 11:41=E2=80=AFAM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> A valid ELF file may contain a SHT_NOBITS .BTF section. This case is
> >> not handled correctly in btf_parse_elf, which leads to a segfault.
> >>
> >> Add a null check for a buffer returned by elf_getdata() before
> >> proceeding with its processing.
> >>
> >> Bug report: https://github.com/libbpf/libbpf/issues/894
> >>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  tools/lib/bpf/btf.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >> index 38bc6b14b066..90599f0311bd 100644
> >> --- a/tools/lib/bpf/btf.c
> >> +++ b/tools/lib/bpf/btf.c
> >> @@ -1201,6 +1201,12 @@ static struct btf *btf_parse_elf(const char *pa=
th, struct btf *base_btf,
> >>                 goto done;
> >>         }
> >>
> >> +       if (!secs.btf_data->d_buf) {
> >> +               pr_warn("BTF data is empty in %s\n", path);
> >> +               err =3D -ENODATA;
> >> +               goto done;
> >> +       }
> >> +
> >
> > let's handle this more generally for all BTF data sections in
> > btf_find_elf_sections()?
>
> Sure. I think it makes sense to check for the section type before
> attempting to load a buffer like this:
>
> @@ -1148,6 +1148,12 @@ static int btf_find_elf_sections(Elf *elf, const c=
har *path, struct btf_elf_secs
>                 else
>                         continue;
>
> +               if (sh.sh_type =3D=3D SHT_NOBITS) {
> +                       pr_warn("failed to get section(%d, %s) data from =
%s\n",
> +                               idx, name, path);
> +                       goto err;
> +               }
> +
>
> But then we might as well test for the expected section type, which is
> supposed to be SHT_PROGBITS, if I understand correctly.
>
> What I don't know is whether this is *the only* possible expected type
> (for ".BTF", ".BTF.ext" and ".BTF.base"), or are there others?
>
> Andrii, do you know if that's the case?

yeah, I think it has to be SHT_PROGBITS, everything else is either
zero-initialized section (SHT_NOBITS), which is useless for BTF data.
Or it's some other special type of section.

>
> >
> > let's also use similar style of warning messaging to others, maybe
> > something like
> >
> > "failed to get section(%s, %d) data from %s\n" ?
> >
> >
> > pw-bot: cr
> >
> >>         if (secs.btf_base_data) {
> >>                 dist_base_btf =3D btf_new(secs.btf_base_data->d_buf, s=
ecs.btf_base_data->d_size,
> >>                                         NULL);
> >> --
> >> 2.49.0
> >>
> >>

