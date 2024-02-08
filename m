Return-Path: <bpf+bounces-21548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACEE84EAD4
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E05B1F25EFB
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 21:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1F84F5F3;
	Thu,  8 Feb 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyXd0Q2v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41F4F5E5
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429045; cv=none; b=DuQmdtV5Z+E82lfsLbWkGY7y/ubu/afNGkQFeRxwllSIbrpujI+cmHAHjM16LqzjIjkTYNqym5IPp8UeoR6OZW9doTNH2nqjup8AnltWyUcD3XEetdoarAYpC+uJRcLjV6Ijwr+V6VFhCHWmaJwm5kFyFXpBgVivjSccxkXdcJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429045; c=relaxed/simple;
	bh=kUygteJBS6KCH//gRa+4ItB8/T9NYxGBC59L0JWpVSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHLw0s8XAUQBU/gRXOs0VxZam69w4DI4PEIA/C6S269UkYbRj2GsRai13xltR2E8jz0SHBeiBCHvykFxd9TXGLS3fgP9PrBYldqtOnX6V/kdskOFc364U+5z9U4yR9+dEwVv/+0NuIXuFtL7wZS7G0lJqkn5DdgNW9Oqsv/ON0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyXd0Q2v; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3566c0309fso35795066b.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 13:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707429042; x=1708033842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk2Mf+CYgNj0rrQ4AtP2FsCs3Z7W5vLJ8AK+GUlsuys=;
        b=WyXd0Q2vVI3up9xny/h7wHXd+hutHmY/PqjLQKhMXoOtXxu78K7WC6ZJyllrbHUCbA
         lKbETycZzjHnKIPtsAxlvylGJDB9VEYu1EfiAbTy9xNgafzgvpMWrujbN/AQCRFGqEv/
         uT214YQXfL9d8jbeq5OwioI+N9Qp16szXGDYSp4OdLnJcr8k9066h9OWI8bmMEMvtD/q
         u09UL6KFoK29UuYN8G3K5+pruDZ83pAEeMcHVH+rF3CPqKlrIyHbvPngtN6J2GfGNgGf
         Emqu/P5826ry+2awo19cEOLjxCSVJQYsUDBgbbRtVjvc58wTpU4vlL4VKl1cdzNyaXGK
         9DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429042; x=1708033842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rk2Mf+CYgNj0rrQ4AtP2FsCs3Z7W5vLJ8AK+GUlsuys=;
        b=n7KpnX10TMqsex7spqtNUb27ooKYzN6NisTv2N61Lz04MaE5c9RQ08U5FgGa3O/De1
         3Hq9xzj7jfT/sHllCyPUyvnthWvk3qvqydm9mJrAGVnMR9FMAUNmfzBa2o7wQXFlcAUR
         UaArp1jIeKNyZPJNR2qZZNjYdsJzWz6MgpeZ2w0omL44eBxanGZHHBBd8rcwktSRCAFa
         peJKZL891duNSD9Lm83Uw5nUdWXBiAOEiFnobavjy21tTs1v7qA0qgTrpSQyC/o4EoX9
         e6zCkT44S6prcce8gOUMDFrVTFRpbgn0wxGF4atdHmk7IrgYHgI+ksEP9wYmdILVKHGw
         WW3w==
X-Gm-Message-State: AOJu0YwLPXCmXrRJbbewVFxxrVuxT/jvaY6zK7wY0KE54gozsBnoazdw
	jzI3fCzzFA/XLl8IUt03OGh5XsGnC+cAOkEYJxYd9ZP2Fi3+iTmuWa05Nbt9x+80LPVFQQNJ6jo
	7DkV5IiaRWgHQp+hlKshoaXwysltGGrh7qsrV
X-Google-Smtp-Source: AGHT+IHJV6Lqt0M69QP75rhTnc4EGw8bgsYHixzIOWzmQ/W0T5fBOc4OYsmaq0/5BaxifVnY2kb+0zD0SFv1RUA+6eM=
X-Received: by 2002:a17:907:39a:b0:a38:5302:89ec with SMTP id
 ss26-20020a170907039a00b00a38530289ecmr380516ejb.42.1707429041842; Thu, 08
 Feb 2024 13:50:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org>
In-Reply-To: <20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 8 Feb 2024 13:50:29 -0800
Message-ID: <CAFhGd8pfMjkdTWx3HnVRpZNgbOy7KkvuD5vytP0G+0ByY_++9w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix changing ELF file type for output of gen_btf
 for big endian
To: Nathan Chancellor <nathan@kernel.org>
Cc: masahiroy@kernel.org, nicolas@fjasle.eu, ndesaulniers@google.com, 
	morbo@google.com, keescook@chromium.org, maskray@google.com, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 12:21=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Commit 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> changed the ELF type of .btf.vmlinux.bin.o from ET_EXEC to ET_REL via
> dd, which works fine for little endian platforms:
>
>    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF.....=
.......|
>   -00000010  03 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |.........=
.......|
>   +00000010  01 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |.........=
.......|
>
> However, for big endian platforms, it changes the wrong byte, resulting
> in an invalid ELF file type, which ld.lld rejects:
>
>    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF.....=
.......|
>   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
.......|
>   +00000010  01 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
.......|
>
>   Type:                              <unknown>: 103
>
>   ld.lld: error: .btf.vmlinux.bin.o: unknown file type
>
> Fix this by using a different seek value for dd when targeting big
> endian, so that the correct byte gets changed and everything works
> correctly for all linkers.
>
>    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF.....=
.......|
>   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
.......|
>   +00000010  00 01 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
.......|
>
>   Type:                              REL (Relocatable file)
>
> Cc: stable@vger.kernel.org
> Fixes: 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> Link: https://github.com/llvm/llvm-project/pull/75643
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Justin Stitt <justinstitt@google.com>

> ---
>  scripts/link-vmlinux.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a432b171be82..8a9f48b3cb32 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -135,8 +135,15 @@ gen_btf()
>         ${OBJCOPY} --only-section=3D.BTF --set-section-flags .BTF=3Dalloc=
,readonly \
>                 --strip-all ${1} ${2} 2>/dev/null
>         # Change e_type to ET_REL so that it can be used to link final vm=
linux.
> -       # Unlike GNU ld, lld does not allow an ET_EXEC input.
> -       printf '\1' | dd of=3D${2} conv=3Dnotrunc bs=3D1 seek=3D16 status=
=3Dnone
> +       # Unlike GNU ld, lld does not allow an ET_EXEC input. Make sure t=
he correct
> +       # byte gets changed with big endian platforms, otherwise e_type m=
ay be an
> +       # invalid value.
> +       if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> +               seek=3D17
> +       else
> +               seek=3D16
> +       fi
> +       printf '\1' | dd of=3D${2} conv=3Dnotrunc bs=3D1 seek=3D${seek} s=
tatus=3Dnone
>  }
>
>  # Create ${2} .S file with all symbols from the ${1} object file
>
> ---
> base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
> change-id: 20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-dbc55a1e129=
6
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>

