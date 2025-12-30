Return-Path: <bpf+bounces-77537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D2CEA822
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 19:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E17DC302176E
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 18:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EAB320CA7;
	Tue, 30 Dec 2025 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGdIpuo/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED692749E0
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767120865; cv=none; b=WV7DmVIKj+9OrYGNG/ns8FMVkFPP5GpD41ZM2ZFb83xs5KYI93WOHcLMyAELAVRsXxVlM5ez7vEe0T4fj0MrXHEvJpYTgseWsHVEajYcZ2IwAN+VEjLossBc8tCig+DHh4DlWZLCyCqgUiqqZNvsCxB/0zVsZd3GnNfU2AbLW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767120865; c=relaxed/simple;
	bh=bwBQoDsrR5ZTPISamJQ6/ETGzsI8HpMF3yru58EHxIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0WNtZdZXRpE5BbT0BWGqx+jEDdrwIypLiTVnrwhcfIFSiD59sGtoMGcp3s5pCBOkMO5RbPMU/YO/PZo6hIe3Z0AFW12I6py2cLmLgTxz8W5O1co2OhBVNEmmfadcTo+ISwqJ2HCnadlS9UTgAh07rI9JZc170vptm7AMcrVJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGdIpuo/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so78304065e9.2
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 10:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767120862; x=1767725662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfTnoTlVXZzJ6ncSJiOcRGLtsetmUBc6i4wR9Q+Yo4U=;
        b=eGdIpuo/USoAOJ1xn/Il39Ncun9aEIA4I7PbO/UrNCqv0fP/W0SHk5WN1gDCEcrcad
         xWKzSnRZg58zsApi7Tii22Ny7W4W8h3j4aPhkVQVIeDYZXm6toqz4HVsixY6kHuXU/3b
         Dg9N/TxPJCgPRg+D2JH7NusMU+i3eF4XDXm90P1gMYyBlxKWLa/0GpfVYvobFlgp8QaK
         5KwQtfMdwK8BYLAkeqtcf8G+OJTU+0h6HxfTVW2QfW2ASUV7QqEoDjWot1L8gx17JRp/
         b1tjN4PgZUDroalp+V5p74JRcODcGnR/50QwJpMI4Ot9b11dcp6m7TBQQKguI/sOd/BH
         rGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767120862; x=1767725662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FfTnoTlVXZzJ6ncSJiOcRGLtsetmUBc6i4wR9Q+Yo4U=;
        b=ny7uRnhH8BK2Jt+e0wBIy7Zvj+EPIf3uyGGPgxwDBUrIqrMgK0b0o3i5p9N2ozX4Ol
         ipQHr+nlDHRbdaFQvUIJxV/wCfPnJGtlBI6tHSlyymXAJ3LOS8FxQ/0V1sf7CPx7dcJG
         S8Jyb+i4HKDCDZlJci9DPB8fX8N6n4uZqCKzHP1bD1PnR08+49Qr3YGXdRt+kbFksJ8g
         nVSBuklwphtf257lJRsUz+f1m5o1WDq92j9LNyxmxw056sVxhMzWtpqV0J5IOs2t0TT0
         4ReW+0sSRC9f0O/8OPGZMps5LFfy9Na0+zFnecgTclFdwtV18//sUwwR/bzJDRLilLIu
         zaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUHk8NKvYX/XC+C8++5RG4jiHe5wIk7BE9sDe3G3kpHc47D7Wb9WWuT/EBPIT9pCVL6uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwtJ+iLUZxL4D71pdRW6jC8IZZ7+GpGB9ihAeZQv+v9GXamXt
	8Baygw9lXxAhetJWPTuAo/MCkre8b5XwsxwBA8+3+bs/YVNsCrmzv06KOnx1LspqO+wVRxQufk4
	/ZWnhcACGBc6qIC7YZBuTnLdaHqzpNIk=
X-Gm-Gg: AY/fxX4nZDE/HtUEiQdg8aVeNLLIwIMuwMcas2FOo2v7zvEXlhGZ3MGhh2Kd59z9nhT
	OqdE+hJ7e3cedBpCTVyZ2N5/GpmvNgmSjKtpTgZ9XpnLZJMmTc68hi4VBG+7ZR9PypSuL+1cppC
	BmIF753/MZ1QcI0aG+FfLzrqwAFklxsJqw9J9padV6N6wU8ZzFBqXnOiASJy532wNGKnIB+Cnlb
	qyBlf4yqMw2KK8wqRkmGr3FvbOFdOym0KYUa58v3RESaZbeVl3M4ouw2r8S1Mdy/ijh2rmk+GUg
	e5jxthjgXnbXk8ToLtV9rpY6cIpLU3n+LoNCD+Y=
X-Google-Smtp-Source: AGHT+IFWuMCPYACqR9rny76OQbZst+hV5SZZZq6+g06y2WDpnTFZheIshlPIQ8dticF4izLeGSJo7mIk5Zort2KSJmo=
X-Received: by 2002:adf:b605:0:b0:432:7d2a:2be4 with SMTP id
 ffacd0b85a97d-4327d2a2d3dmr18936149f8f.60.1767120862080; Tue, 30 Dec 2025
 10:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224005752.201911-1-ihor.solodrai@linux.dev>
 <9edd1395-8651-446b-b056-9428076cd830@linux.dev> <af906e9e-8f94-41f5-9100-1a3b4526e220@linux.dev>
 <20251229212938.GA2701672@ax162> <6b87701b-98fb-4089-a201-a7b402e338f9@linux.dev>
 <CAADnVQ+X-a92LEgcd-HjTJUcw2zR_jtUmD9U-Z6OtNnvpVwfiw@mail.gmail.com> <6f845383-563e-49a7-941c-03e9db6158cc@linux.dev>
In-Reply-To: <6f845383-563e-49a7-941c-03e9db6158cc@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Dec 2025 10:54:10 -0800
X-Gm-Features: AQt7F2qfm0IOYJ36x71n6KBCccrNrZZfYjIji8zwMhgtT2E3g8iPqSCrCXot0LM
Message-ID: <CAADnVQLr3HqooTM6Ok768BHeCTp+LQegtdcS3La3dknGbCJ5Vw@mail.gmail.com>
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

On Tue, Dec 30, 2025 at 10:45=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 12/29/25 4:50 PM, Alexei Starovoitov wrote:
> > On Mon, Dec 29, 2025 at 4:39=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> On 12/29/25 1:29 PM, Nathan Chancellor wrote:
> >>> Hi Ihor,
> >>>
> >>> On Mon, Dec 29, 2025 at 12:40:10PM -0800, Ihor Solodrai wrote:
> >>>> I think the simplest workaround is this one: use objcopy from binuti=
ls
> >>>> instead of llvm-objcopy when doing --update-section.
> >>>>
> >>>> There are just 3 places where that happens, so the OBJCOPY
> >>>> substitution is going to be localized.
> >>>>
> >>>> Also binutils is a documented requirement for compiling the kernel,
> >>>> whether with clang or not [1].
> >>>>
> >>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/tree/Documentation/process/changes.rst?h=3Dv6.18#n29
> >>>
> >>> This would necessitate always specifying a CROSS_COMPILE variable whe=
n
> >>> cross compiling with LLVM=3D1, which I would really like to avoid. Th=
e
> >>> LLVM variants have generally been drop in substitutes for several
> >>> versions now so some groups such as Android may not even have GNU
> >>> binutils installed in their build environment (see a recent build
> >>> fix [1]).
> >>>
> >>> I would much prefer detecting llvm-objcopy in Kconfig (such as by
> >>> creating CONFIG_OBJCOPY_IS_LLVM using the existing check for
> >>> llvm-objcopy in X86_X32_ABI in arch/x86/Kconfig) and requiring a work=
ing
> >>> copy (>=3D 22.0.0 presuming the fix is soon merged) or an explicit op=
t
> >>> into GNU objcopy via OBJCOPY=3D...objcopy for CONFIG_DEBUG_INFO_BTF t=
o be
> >>> selectable.
> >>
> >> I like the idea of opt into GNU objcopy, however I think we should
> >> avoid requiring kbuilds that want CONFIG_DEBUG_INFO_BTF to change any
> >> configuration (such as adding an explicit OBJCOPY=3D in a build comman=
d).
> >>
> >> I drafted a patch (pasted below), introducing BTF_OBJCOPY which
> >> defaults to GNU objcopy. This implements the workaround, and should be
> >> easy to update with a LLVM version check later after the bug is fixed.
> >>
> >> This bit:
> >>
> >> @@ -391,6 +391,7 @@ config DEBUG_INFO_BTF
> >>         depends on PAHOLE_VERSION >=3D 122
> >>         # pahole uses elfutils, which does not have support for Hexago=
n relocations
> >>         depends on !HEXAGON
> >> +       depends on $(success,command -v $(BTF_OBJCOPY))
> >>
> >> Will turn off DEBUG_INFO_BTF if relevant GNU objcopy happens to not be
> >> installed.
> >>
> >> However I am not sure this is the right way to fail here. Because if
> >> the kernel really does need BTF (which is effectively all kernels
> >> using BPF), then we are breaking them anyways just downstream of the
> >> build.
> >>
> >> An "objcopy: command not found" might make some pipelines red, but it
> >> is very clear how to address.
> >>
> >> Thoughts?
> >>
> >>
> >> From 7c3b9cce97cc76d0365d8948b1ca36c61faddde3 Mon Sep 17 00:00:00 2001
> >> From: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> Date: Mon, 29 Dec 2025 15:49:51 -0800
> >> Subject: [PATCH] BTF_OBJCOPY
> >>
> >> ---
> >>  Makefile                             |  6 +++++-
> >>  lib/Kconfig.debug                    |  1 +
> >>  scripts/gen-btf.sh                   | 10 +++++-----
> >>  scripts/link-vmlinux.sh              |  2 +-
> >>  tools/testing/selftests/bpf/Makefile |  4 ++--
> >>  5 files changed, 14 insertions(+), 9 deletions(-)
> >
> > All the makefile hackery looks like overkill and wrong direction.
> >
> > What's wrong with kernel/module/main.c change?
> >
> > Module loading already does a bunch of sanity checks for ELF
> > in elf_validity_cache_copy().
> >
> > + if (sym[i].st_shndx >=3D info->hdr->e_shnum)
> > is just one more.
> >
> > Maybe it can be moved to elf_validity*() somewhere,
> > but that's a minor detail.
> >
> > iiuc llvm-objcopy affects only bpf testmod, so not a general
> > issue that needs top level makefile changes.
>
> By the way, we don't have to put BTF_OBJCOPY variable in the top level
> Makefile.  It can be defined in Makefile.btf, which is included only
> with CONFIG_DEBUG_INFO_BTF=3Dy
>
> We have to define BTF_OBJCOPY in the top-level makefile *if* we want
> CONFIG_DEBUG_INFO_BTF to depend on it, and get disabled if BTF_OBJCOPY
> is not set/available.
>
> I was trying to address Nathan's concern, that some kernel build
> environments might not have GNU binutils installed, and kconfig should
> detect that.  IMO putting BTF_OBJCOPY in Makefile.btf is more
> appropriate, assuming the BTF_OBJCOPY variable is at all an acceptable
> workaround for the llvm-objcopy bug.

I feel that fallback to binutils objcopy is going to have its own
issues. It could have issues with cross compiling too.
Asking developers to setup cross compile with llvm toolchain and binutils
at the same time is imo too much.
If we cannot rely on objcopy then resolve_btfids should do the whole thing.

