Return-Path: <bpf+bounces-22032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C8B8554FC
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 22:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562631C21BE4
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 21:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA8B13F003;
	Wed, 14 Feb 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/X0U+Jq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505941B7E2;
	Wed, 14 Feb 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946689; cv=none; b=TmLDGa0drVyEz6b3uJujsptBI0Y1HF25omJLsl2R/082M055fEnSDB4b/4gzth0/2KIcWUhnPTNM85PSwAux+bNDqKlE4YRDJ91eVl2hmHteu970Hj3GtBVc+ZCXgr98yviRD+a6rtOVwRfCjhbjpE8/LTA7vy8fWiN8NbPZp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946689; c=relaxed/simple;
	bh=UUPKAcrXV3sriobv5a2MejWKkdWDLFLi5VZHMfDG010=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CW7VkYQAMMsuSEEWaTtSf3sf9KWxj77qKLZqO0iquOYS9A/X5s3DZJNUYpOY/i5N0MAH+vRLVBYGbj5gUEe9hEzyYUjjCxK16aHi4lczqzq9cr3IVlAceC0AqKp28Gbsb5+P8FdznoXE4tc7vxy5xPn9ZSzxF19RuJF2oqmz1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/X0U+Jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA19C43394;
	Wed, 14 Feb 2024 21:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707946689;
	bh=UUPKAcrXV3sriobv5a2MejWKkdWDLFLi5VZHMfDG010=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u/X0U+JqFqRNrle6IPy7xdizrvaz3w5fRFbyoqrUiaiJlrKgKcKMx7PgqLeGr4Xr+
	 A8OahwP6epdjZgFXgJp9etsF42qn1YNLAzEoNquyTvQn04s/HuDPNSYQ75mJRqil6o
	 iFL30I83YlRm0BkOeGXyvIibjhmqIslDKIWkxSHp5Cu0b3JYXKC+ftnguU4BSRaUv7
	 vFLHEezVEDfSF+h86rJ59/eAuA8uSDyGG0zx/HHWae92vnPYBhJhLqwUdLmX3cytIg
	 M/vF+UxTGRRg8l3p8Jb/Hn19d4ty/6QmtpKryPL64pkOay57Tokhs1bVZtSbVq93BL
	 D/wuRiM9XEZaQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511a45f6a57so215515e87.2;
        Wed, 14 Feb 2024 13:38:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUywtNjOwHk3lE9Sx593u7f7KSmhkFa6ja5XqUp4Upd0vzNJsJP7CfC4bmZqwbDmPvnlZk68mRXSbMUPJfp3ZBI8lvWXNH8LZIITcA476a8q/V8HPtQMPlQt/FG+j5DuZxD2RjKdK1l6FfK2uoeinlg/ID/7HAyM+bK
X-Gm-Message-State: AOJu0YxxEs21+5faBkLf6CmU+8OYdGuzjL2cvwUZKBVI5lrNDRACgNg5
	Yaf/qL7zE3aoV0hr+Bq07NdVqS4giz0AN/R9sYfhTJ9fCQJ2lcFXI7vcBQEhBgFEfxSaG4kZRMt
	0fvroHu7BB7mwuBZ7SdouDP48dCY=
X-Google-Smtp-Source: AGHT+IGaYKxN9IyHvOKM2lTDAnhg9bpSWHXdMQSUzrkADaDd9GpHqhCli3rtc+UYqlFqe/KCZCHWjCJQjugyya5+E0A=
X-Received: by 2002:a05:6512:781:b0:511:a690:45dd with SMTP id
 x1-20020a056512078100b00511a69045ddmr31552lfr.16.1707946687494; Wed, 14 Feb
 2024 13:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-fix-elf-type-btf-vmlinux-bin-o-big-endian-v2-1-22c0a6352069@kernel.org>
In-Reply-To: <20240212-fix-elf-type-btf-vmlinux-bin-o-big-endian-v2-1-22c0a6352069@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Feb 2024 06:37:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZAh9fa8rd6jLwdEGUBHkAs9e4hZh=WvKeNLkGs2=8Aw@mail.gmail.com>
Message-ID: <CAK7LNATZAh9fa8rd6jLwdEGUBHkAs9e4hZh=WvKeNLkGs2=8Aw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Fix changing ELF file type for output of
 gen_btf for big endian
To: Nathan Chancellor <nathan@kernel.org>
Cc: nicolas@fjasle.eu, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, keescook@chromium.org, maskray@google.com, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:06=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> Commit 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> changed the ELF type of .btf.vmlinux.bin.o to ET_REL via dd, which works
> fine for little endian platforms:
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
> Fix this by updating the entire 16-bit e_type field rather than just a
> single byte, so that everything works correctly for all platforms and
> linkers.
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
> While in the area, update the comment to mention that binutils 2.35+
> matches LLD's behavior of rejecting an ET_EXEC input, which occurred
> after the comment was added.
>
> Cc: stable@vger.kernel.org
> Fixes: 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> Link: https://github.com/llvm/llvm-project/pull/75643
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Applied to linux-kbuild/fixes.
Thanks.


--=20
Best Regards
Masahiro Yamada

