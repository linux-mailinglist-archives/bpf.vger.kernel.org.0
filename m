Return-Path: <bpf+bounces-21823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF9852772
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 03:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63757281A39
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068ED28F4;
	Tue, 13 Feb 2024 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtHalAkJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4FB4687;
	Tue, 13 Feb 2024 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790579; cv=none; b=WJr9xd5FJ7B2umjpekyD2CKxY7eZUmDP5OQUvV0RX0ej4F2gujwqkIXvPPGLhbth/5dw3LApfgA4LAHi85eObO55O98rVCFqFuMXQU4PpU1C4TWgxKkDbSx7MEn98e7ZgSXpknXJNroX3r4bBDxChTFX2PE2G+6Mz08U7oepl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790579; c=relaxed/simple;
	bh=ty0y12ccrilaLih8qfreo65Q0+FgKEBI+/xq5U1o9j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qih/EG336UBMU3jZ+xroOo6CawQk5+phUZ3mRXhrPk/CVazKjvRSKOnXWhN1ne9GBN3P8D+c3dnLdq+Hd1qVV5HMgUK9ncY+mGTru4w2sQsuC98v6A4zhTDHEsYQX+6IYl/QW88VEJ4dSXSOylQMH9X0C8axUqp6t9gswOSh4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtHalAkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FB2C43390;
	Tue, 13 Feb 2024 02:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707790579;
	bh=ty0y12ccrilaLih8qfreo65Q0+FgKEBI+/xq5U1o9j0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gtHalAkJgvRwtxczNrbnpUoyeZq7Flya0bZHuIpYpLyrzR5soOAspxG3CNxvJgsMr
	 f4GUUnP61xpwuQjDNes8iBh6DPvoLrFpwg+IpAnhfriPRo80wAjU5h+8cpytAy7lSH
	 hJsjR2g6aWdggimBHI/ip3fe0H0SuTLMrJQpMtnVGexjtBMjF1OSWs0ukZmD8/ypqF
	 CYq36aG0afkGYbFjqpm6yqnPsqtHAxkpPH0XzjmN4KiUVwemeYtl7n9pZH+wBFOBfI
	 miJsKT6Nm2U9+OiBMfxXiT4Woco6a7d13uQNjmHbTfgM0RZhCRUO5FEMruDgsJqJk7
	 dIYnFymHdWVXg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5114c05806eso6139491e87.1;
        Mon, 12 Feb 2024 18:16:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/auaq3mAADwVYBYVTx7JY+cWCDvgZXyb2/awn3vTIgB6CnfIcD9bZsIqsn5hiOG6ScUj0YkjP0DcQdOBnjGcl18R2gak6xTF8WdHl9fPyTL/iJ/f4Bvc8eWf+j5pG4HGVZNeicAqPOhTV3v34jHCtnmWuIV7f7sQm
X-Gm-Message-State: AOJu0YxslYGxlW8Urii+D73uj79QND/LSoQ5Jh2x6LMGN369u59lrZsE
	mvkgi7Osi6/+0h0HBJJgFR74CWt7HFtXUwzbcJZMfcyEuGr8k6Eix6HJZ233PArpGISgxbp1PIp
	LBV1hXesm5Z7Y1KT9rOn1SUjeNEE=
X-Google-Smtp-Source: AGHT+IG9j8eTC9+yJGwI8ky9byJ8ZPRIRKeG6Cx3N/flyKj2qKucQfTBRZZ4ol1ObYo8aeFycKZw2PbtXxlgx1Rjly4=
X-Received: by 2002:ac2:4c0e:0:b0:511:68e9:f698 with SMTP id
 t14-20020ac24c0e000000b0051168e9f698mr5407394lfq.61.1707790577582; Mon, 12
 Feb 2024 18:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-fix-elf-type-btf-vmlinux-bin-o-big-endian-v2-1-22c0a6352069@kernel.org>
In-Reply-To: <20240212-fix-elf-type-btf-vmlinux-bin-o-big-endian-v2-1-22c0a6352069@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 13 Feb 2024 11:15:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATK=8V+BroyN+uo9OynkfR6s6HtRgh=LF7yan7cPkbaTA@mail.gmail.com>
Message-ID: <CAK7LNATK=8V+BroyN+uo9OynkfR6s6HtRgh=LF7yan7cPkbaTA@mail.gmail.com>
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


Thanks.

I will wait for a few days until
the reviewers come back to give Reviewed-by again.





> ---
> Changes in v2:
> - Rather than change the seek value for dd, update the entire e_type
>   field (Masahiro). Due to this change, I did not carry forward the
>   tags of v1.
> - Slightly update commit message to remove mention of ET_EXEC, which
>   does not match the dump (Masahiro).
> - Update comment to mention binutils 2.35+ has the same behavior as LLD
>   (Fangrui).
> - Link to v1: https://lore.kernel.org/r/20240208-fix-elf-type-btf-vmlinux=
-bin-o-big-endian-v1-1-cb3112491edc@kernel.org
> ---
>  scripts/link-vmlinux.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a432b171be82..7862a8101747 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -135,8 +135,13 @@ gen_btf()
>         ${OBJCOPY} --only-section=3D.BTF --set-section-flags .BTF=3Dalloc=
,readonly \
>                 --strip-all ${1} ${2} 2>/dev/null
>         # Change e_type to ET_REL so that it can be used to link final vm=
linux.
> -       # Unlike GNU ld, lld does not allow an ET_EXEC input.
> -       printf '\1' | dd of=3D${2} conv=3Dnotrunc bs=3D1 seek=3D16 status=
=3Dnone
> +       # GNU ld 2.35+ and lld do not allow an ET_EXEC input.
> +       if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> +               et_rel=3D'\0\1'
> +       else
> +               et_rel=3D'\1\0'
> +       fi
> +       printf "${et_rel}" | dd of=3D${2} conv=3Dnotrunc bs=3D1 seek=3D16=
 status=3Dnone
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
>


--=20
Best Regards
Masahiro Yamada

