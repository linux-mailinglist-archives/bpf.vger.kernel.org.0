Return-Path: <bpf+bounces-69107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD27B8CC66
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8243AF7A2
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A4F2F5472;
	Sat, 20 Sep 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYxh/lxP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E942836A0
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383829; cv=none; b=Cn/FHMSLxWjrINYD0W0XV+eFn3tl9vY+TuGZ1zjKx3PUC3SKQBTY+lpvc/Sh/U6psPyg8K/2ibSlHggBxiRCq+bdk9ok4wfX7rOQlzR3gNeEvKz8JEiwdgLnbktP9EiSNXUY8rNnxxwF0fgzXYSqpqkgkmoNZ2zo8ecYALuEuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383829; c=relaxed/simple;
	bh=AQBj9kWJnBNzivMSpd2Div0+z2rPQXFUWRGTn23wAgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiSi2YMCActyEi6M8f3IPyXxwCapk8czB+v7WZ8ce4WOd6PggLrJVIE5FtOLqJhJ7wOg5Jks0lJnk5FecJjsaa1AKcz2ykr0aLbPqCGoLqxJbV9DiKhXIDTkzUrJEgdlTMfDpiMIhttkelrV4jHvpVMjPZTb2yDlhEkBRPskHw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYxh/lxP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso19803605e9.3
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758383826; x=1758988626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJKrHjM2zPx/eikfNCBvrnVsffjY7Q7oScehGkXaVbo=;
        b=KYxh/lxPdeUy1tjvNfcm8jKWpdtmPihrikgqLsbZWvDrVkvKi3xJxmhrBw2XWUkqaM
         3CtlE4wFa8QKFefb/3tx3Bn4XKsh3l6sh7Aukxeoc3c4lFopR5zwPwZXIw6nJalOacTh
         IQm3xQFQNGBuUPwb0Sg662sWOzw2qtOYAsWASDd12od0vVTKy/oNKdevUS3VuZZTOzEm
         V5DDlG+nPZlaVp8XAkEuCKg+c2D9iEEIvLUCwlm6cN6ca9Bw02IMNXsfK6TBzMHHV9Dn
         5cOJ9iEt2JMNTlwa7wiY4W2SA4euc4r17q17CWsDgQDg1ScvCngCoutraM4mfQ27ldSu
         qxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758383826; x=1758988626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJKrHjM2zPx/eikfNCBvrnVsffjY7Q7oScehGkXaVbo=;
        b=egpQa9WgQVa8RI+Nm/pQomRBgLUPtxn5J7zIK9yIPa6nkZCca4prbX0zBcQ1g6B6ua
         +UQt3O5HfWzgll+iupULjzZhuNf0WhwcWu/nwvJdoaLfEXa0Cgc9BQxuQcj+i1btFBZV
         oNtAMtEgkT2cZE+CrjNAcOpGgGfOHpuzvEEDRSnAOe54rXY7hr7JK3KCOb0t2hSVpDvd
         1BggxGOTYL1E8rgCpH906/FMMflb6vZmgSt8MHEZbkaZdHWxDvYJfEP1YGnRisgnQyCj
         VhnbjXWxNbxSX0tCAndn1UW1eaXPBmLNS3UrO76U5YxyFD7nGOqybU8xXgDih39CRVs5
         /oWg==
X-Gm-Message-State: AOJu0YzDBF9z4+RiNvWefnzyatAabRXcFVd7DiBG1HbhDpg+SXYBuEY4
	n4nHFbTADS7KfYt7fp8MhdO7ftnaZRKwW0qwMzf4YwzY5aFcHb7e6QrmtnaRgP9S7HN2HUmbbtC
	kB1LWebvb2nJt0E/6X7T92bM6RnFFpN3gLQ==
X-Gm-Gg: ASbGncutMqJs6U09OoztFtvEOG+x1k3zloVvMTlRWZlN9mthXRMpjqYDKds9M35yIyS
	PgMafnukn6iR1q5gsWbPQOdDMGwFE3X6UVqQCUQDHMQ6ytqBCMdAQG+uNdsg/Zpw47tuOIKOYea
	esFxeQtOh3TKPPqzSMydOHbj2d5Z8NXBtUg9rREZIU9y7pwmfRn8Df+Pw7Zqs7kGbMm9tTHyFZF
	BzDS+RfviU6WN36KvizezE9pMLk7FJ4me2G
X-Google-Smtp-Source: AGHT+IFN9DpsKIAOmo3ntHnZHKiP605IwlGdmWolTTFF8ubM2yl+6yvWEBH84dN5jNIsAU9FXPODkCIMnTqWY4LWOXE=
X-Received: by 2002:a05:600c:3114:b0:456:13b6:4b18 with SMTP id
 5b1f17b1804b1-467ebbc0427mr72238035e9.31.1758383826018; Sat, 20 Sep 2025
 08:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920153531.3675700-1-yonghong.song@linux.dev>
In-Reply-To: <20250920153531.3675700-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 20 Sep 2025 08:56:53 -0700
X-Gm-Features: AS18NWCehyps27OOW4kX3Ap1PB54S6kFP7tFNKGZhzUQBgiz_kv9rgEUSKtc3Lg
Message-ID: <CAADnVQJ-28Oy9OoKXtnDOZBxkDofuwfWS-cdSFHd1uqpOmNLmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Silence newly-added and unused sections
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 8:35=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> With latest llvm22, when building bpf selftest, I got the following info
> emitted by libbpf:
>   ...
>   libbpf: elf: skipping unrecognized data section(14) .comment
>   libbpf: elf: skipping section(15) .note.GNU-stack (size 0)
>   ...
>
> The reason is due to llvm patch [1]. Previously, bpf class BPFMCAsmInfo
> inherits class MCAsmInfo. With [1], BPFMCAsmInfo inherits class
> MCAsmInfoELF. Such a change added two more sections in the bpf binary, e.=
g.
>   [Nr] Name              Type            Address          Off    Size   E=
S Flg Lk Inf Al
>   ...
>   [23] .comment          PROGBITS        0000000000000000 0035ac 00006d 0=
1  MS  0   0  1
>   [24] .note.GNU-stack   PROGBITS        0000000000000000 003619 000000 0=
0      0   0  1
>   ...
>
> Adding the above two sections in elf section ignore list can avoid the
> above info dump during selftest build.
>
>   [1] https://github.com/llvm/llvm-project/commit/d9489fd073c0e100c6fbb1e=
5aef140b00cf62b81

Can we revert this instead?
Why do we need these sections if we're not doing anything with them?

> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 5161c2b39875..34aed7904039 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3788,6 +3788,14 @@ static bool ignore_elf_section(Elf64_Shdr *hdr, co=
nst char *name)
>         if (is_sec_name_dwarf(name))
>                 return true;
>
> +       /* .comment section */
> +       if (strcmp(name, ".comment") =3D=3D 0)
> +               return true;
> +
> +       /* .note.GNU-stack section */
> +       if (strcmp(name, ".note.GNU-stack") =3D=3D 0)
> +               return true;
> +
>         if (str_has_pfx(name, ".rel")) {
>                 name +=3D sizeof(".rel") - 1;
>                 /* DWARF section relocations */
> --
> 2.47.3
>

