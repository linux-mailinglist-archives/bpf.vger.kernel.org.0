Return-Path: <bpf+bounces-77495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF71DCE8722
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 01:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD0C13001E1E
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B91A2DD5E2;
	Tue, 30 Dec 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9GPUvyh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AC2DCBFD
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055833; cv=none; b=YbewpDuw+7dZQJgZ1OxhsJgzS5qSPeqh58bFzhdigTmf/IzqVE6Usr4bHABZ3yp+sJkhKB2pduQSOPdnXdS/N7OMxQTESmL3/kPfBo4K2M05BTm8Oni7bwzCJfiSndWoRwXfLeEdPXA4b5GxNsdKjVvi/cQKytvWqXnL92lnLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055833; c=relaxed/simple;
	bh=8HTj28uuZFMxzEEKfVTXaF6eYTrr+djzclMLdY33CsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smCBjrZPOrvzR5JWmBFSiMJmHo4THV0Vjs2UhvcF79ZQEffR/AAmBQXAEKHX+DjNpylvwqVCuCZin1DgKEvds4jEF/IjsHuslXnH6ZuBDm5aVKlKv9ohAWMtN0rCz5rWv2bccLW+25nuNNevjiAqUqZJ2R/jspTjgFUTOQTu1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9GPUvyh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso4717421f8f.2
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 16:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767055829; x=1767660629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u5F/h588+teHhjrEaUKubm9KpGJAzuYhElAZ43Nr7U=;
        b=A9GPUvyhNhLa/gtCc/WeMz98AW7Wwu6WxaU9smLMWXeZKopx5lsw7qYMjJVb2+bfCF
         qIcPoSch1wvE0QVo7ifHpXsE+ZOl7WHc3cIKzGYWDsfffYEmHpo8OZBIStvdGaAVkfQn
         MO24vm7IS+grL2XjwVN/HXXsV4S1vZW7l1lV4Mkumds1/pk2ZCWc1IfCALgf8XXQrIz9
         cB5kRq/J61kEK7jp4ZcDn+Pk9cD3J/9hqxeqYZa8WT2JcfYZtqfFapCM0XFPSOq99hIJ
         8qUsgL1M0K8AJk55vQpyZwNV02CdjRUXxVPDR9aQgNBla78gsbmcyrrseumVQP8X7l8L
         DYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767055829; x=1767660629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7u5F/h588+teHhjrEaUKubm9KpGJAzuYhElAZ43Nr7U=;
        b=Gy2D19KhQlYsDX3BoSmVrRPeNyu4LkCJSvqN4bzcJWNlaC7zr3LOKk/vsymjwnar3O
         UG8RRR4v9oyz4SqTYS4ehHoipjRX1yO01Yn4+FnkBeAM9R4nM53Bu4rQNTjsFM0IadtL
         QoeDdrGhpFPObazE/0nw1NSf0RYeaEMIpUBzkaw+4UPT/QCGU2GxeMcHZfKXpTRwh6Tl
         pVEBYiB5Yu8qK3WNIzzYcA+SVOB/CwHakZJYYimtpc/9maEkriSc2KibKX3sFOsQMqlX
         XXC2x9Yc5ZP5XqXfjFKAOGAoZJ7jHw4k0sHifKYBeYwurtU83saYH+CrTGAI2LKFnIc0
         voyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkzD0Nb9jCcHkzdmihRj2M4bY4Rij5dBwk6e9VThHAJtSC03T0XljDC2Vponrc++cxR10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHROD4lL1t3WdJzp1oSAH42xz/3OC0Cnmat11uLZKqEhmIcJD
	PK6o3bhw4fhGB6IxW2UzggSXb/SW8JRwpECA1MxZM1l5IG/Ub5/67D0FmAUEMqmXufJMO5AuwYk
	zdTKnek2Xwd2wgaXAIUNOKyBiQEx7jCw=
X-Gm-Gg: AY/fxX7wVDPNJsIEaedVasEhTyMURIrArDiQDz3XZ5LwgZAibwe4FXjMyNXK30+6jB2
	YqWSoIqYL0yq6c2s7UWJ/uq0zc7BiS2Mbjqu8La78sQJyEDsWnoy9fVRsn6SAmy4HIdpGZP7VT7
	2+pvi2Cqhd/vM/FQz8eqFTGdUWwLgUEXzec3z8Y1bFjsQYmCXDOQ6oHAFlNYZyQ2kYMdaBiZzer
	FzkZWEEwufewt6Xnw8/QbiPly9IO2rEZzHXBUSm4WR4/0M++Y2vCrR14NG9NPg7KQb49iM7/7Nx
	EraUWQmCiBzlTkJDZO0UETZtHJ2A
X-Google-Smtp-Source: AGHT+IFfbljJEjZGZaAGma/kW2cY81yE6KzZkQrbO/d2ra2hmJAhD+ryGHCY6WopWTwemcaEQOy6bHLLV8D1VgAvhCQ=
X-Received: by 2002:a5d:5f85:0:b0:431:6ba:38bd with SMTP id
 ffacd0b85a97d-4324e4c715fmr42639014f8f.10.1767055828728; Mon, 29 Dec 2025
 16:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224005752.201911-1-ihor.solodrai@linux.dev>
 <9edd1395-8651-446b-b056-9428076cd830@linux.dev> <af906e9e-8f94-41f5-9100-1a3b4526e220@linux.dev>
 <20251229212938.GA2701672@ax162> <6b87701b-98fb-4089-a201-a7b402e338f9@linux.dev>
In-Reply-To: <6b87701b-98fb-4089-a201-a7b402e338f9@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 29 Dec 2025 16:50:17 -0800
X-Gm-Features: AQt7F2rm6FvvD5ZuZdGGJE9pNl2iGxXtYswxUDVcAyVM8QB1E7NaWycGUyO1_1U
Message-ID: <CAADnVQ+X-a92LEgcd-HjTJUcw2zR_jtUmD9U-Z6OtNnvpVwfiw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] module: Fix kernel panic when a symbol st_shndx is
 out of bounds
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 4:39=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 12/29/25 1:29 PM, Nathan Chancellor wrote:
> > Hi Ihor,
> >
> > On Mon, Dec 29, 2025 at 12:40:10PM -0800, Ihor Solodrai wrote:
> >> I think the simplest workaround is this one: use objcopy from binutils
> >> instead of llvm-objcopy when doing --update-section.
> >>
> >> There are just 3 places where that happens, so the OBJCOPY
> >> substitution is going to be localized.
> >>
> >> Also binutils is a documented requirement for compiling the kernel,
> >> whether with clang or not [1].
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/Documentation/process/changes.rst?h=3Dv6.18#n29
> >
> > This would necessitate always specifying a CROSS_COMPILE variable when
> > cross compiling with LLVM=3D1, which I would really like to avoid. The
> > LLVM variants have generally been drop in substitutes for several
> > versions now so some groups such as Android may not even have GNU
> > binutils installed in their build environment (see a recent build
> > fix [1]).
> >
> > I would much prefer detecting llvm-objcopy in Kconfig (such as by
> > creating CONFIG_OBJCOPY_IS_LLVM using the existing check for
> > llvm-objcopy in X86_X32_ABI in arch/x86/Kconfig) and requiring a workin=
g
> > copy (>=3D 22.0.0 presuming the fix is soon merged) or an explicit opt
> > into GNU objcopy via OBJCOPY=3D...objcopy for CONFIG_DEBUG_INFO_BTF to =
be
> > selectable.
>
> I like the idea of opt into GNU objcopy, however I think we should
> avoid requiring kbuilds that want CONFIG_DEBUG_INFO_BTF to change any
> configuration (such as adding an explicit OBJCOPY=3D in a build command).
>
> I drafted a patch (pasted below), introducing BTF_OBJCOPY which
> defaults to GNU objcopy. This implements the workaround, and should be
> easy to update with a LLVM version check later after the bug is fixed.
>
> This bit:
>
> @@ -391,6 +391,7 @@ config DEBUG_INFO_BTF
>         depends on PAHOLE_VERSION >=3D 122
>         # pahole uses elfutils, which does not have support for Hexagon r=
elocations
>         depends on !HEXAGON
> +       depends on $(success,command -v $(BTF_OBJCOPY))
>
> Will turn off DEBUG_INFO_BTF if relevant GNU objcopy happens to not be
> installed.
>
> However I am not sure this is the right way to fail here. Because if
> the kernel really does need BTF (which is effectively all kernels
> using BPF), then we are breaking them anyways just downstream of the
> build.
>
> An "objcopy: command not found" might make some pipelines red, but it
> is very clear how to address.
>
> Thoughts?
>
>
> From 7c3b9cce97cc76d0365d8948b1ca36c61faddde3 Mon Sep 17 00:00:00 2001
> From: Ihor Solodrai <ihor.solodrai@linux.dev>
> Date: Mon, 29 Dec 2025 15:49:51 -0800
> Subject: [PATCH] BTF_OBJCOPY
>
> ---
>  Makefile                             |  6 +++++-
>  lib/Kconfig.debug                    |  1 +
>  scripts/gen-btf.sh                   | 10 +++++-----
>  scripts/link-vmlinux.sh              |  2 +-
>  tools/testing/selftests/bpf/Makefile |  4 ++--
>  5 files changed, 14 insertions(+), 9 deletions(-)

All the makefile hackery looks like overkill and wrong direction.

What's wrong with kernel/module/main.c change?

Module loading already does a bunch of sanity checks for ELF
in elf_validity_cache_copy().

+ if (sym[i].st_shndx >=3D info->hdr->e_shnum)
is just one more.

Maybe it can be moved to elf_validity*() somewhere,
but that's a minor detail.

iiuc llvm-objcopy affects only bpf testmod, so not a general
issue that needs top level makefile changes.

