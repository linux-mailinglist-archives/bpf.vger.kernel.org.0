Return-Path: <bpf+bounces-38296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE22962E5F
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF96B1F23132
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3369B1A4F28;
	Wed, 28 Aug 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESsOXIIo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7C8BF0;
	Wed, 28 Aug 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865792; cv=none; b=k5VFLltHdf46JnRbJbs6Y9PzP9LtlSW9+tu3kBASlgj+l9Vx5JrucXJLOM/bWUCPKZMkOoSj8aT5RND4bm+3mWJMj3plvM+x01gVAyoUtAn5G/FTbPi9I5EQigOWvIEewceFAfjI0uoM57GfhSq5RgOlHYK8Xj0OHAeAn3sqbmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865792; c=relaxed/simple;
	bh=hybDXOuqIXmVbR/WCrqw8fFSuGwRfUAvyFQjs0+1Cn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fz3djUM+vNnNLf5AoG2lD5Zh3rD9+Nd66KHGy0HAJstykAAFa7wiYVNJhacraHOBj6RE0tXhlrC2RfFB6ZMFsYjfcZNbtj5ZV+vN2uId8CNkIvFO0ioiYlezO3NX68jSQjBvqR8SDLyFMS7bSTHdB/JvylrWtv1DS7anznAXSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESsOXIIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEF9C4CEC1;
	Wed, 28 Aug 2024 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724865792;
	bh=hybDXOuqIXmVbR/WCrqw8fFSuGwRfUAvyFQjs0+1Cn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ESsOXIIozQLLKuMP6tBe0xhsvtjvBp9tSVJpOZNXE8Hx6Z/JBNNjgu4SFimGIg9ys
	 zdslVkCy+Pw+vrIeezj2u1Wioee/l4oJIX+X9VyoCsuBbT/Ioy0qk8dPExjYVfht3q
	 wIbGOKFtqjzcBt42zphJyl3xQxr77nxnz3RTUfMPaMRDcQQzsYgT/T+QhbkpxaejS8
	 D2Gfum1irIHrrE2dm+G3BtPhuoPkDUwb3uTajjZVxXCNYAZT8BAD1JKPtq5rlcvVqP
	 gfo8HyOVZf+BqVkmPhKMPHHpl737wCp3MYGvg1fN5Pkn436/q29AfwB0CirmiPWuJE
	 WqX349KFR4IvA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f51b67e16dso23825211fa.3;
        Wed, 28 Aug 2024 10:23:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU04obkoHTiWwfXVcBAOouxoKnt82+ozlGJQB/OmqVJ6rdF/opjvccP9gr2gKNT4VB6iLa62kzAgOrsRWCy@vger.kernel.org, AJvYcCX93B6/grQDWKWlLwKSgqjk4BMaxITb2nvlgatskU7cvF8LYI0JQZ/g9dmQ/1drn8BKAjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjD+l85DbXSSfyQZo1txBrsUFVEK/Yq/bN6rw6IhxG/no6mCT
	7imadtTNYXtpKNw6DABRIpuUqvkn6R0wEJ1Y5cL6Q6VR5zbuqP0EPec1Kiy+Vn1Diy4moB1LxHc
	rOLbQqCsakT9QJaslfXCkXY1lIrk=
X-Google-Smtp-Source: AGHT+IFZNwZKsaA0f4y7YUomHezLijWnK+nzzQ18nCGyui8ig/l+oImscn4vmsXmMEtAGhjLzuAmG2T/qVd6QojFjjo=
X-Received: by 2002:a05:651c:210d:b0:2f3:f690:17f3 with SMTP id
 38308e7fff4ca-2f610889e5bmr2524651fa.31.1724865790671; Wed, 28 Aug 2024
 10:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAQju8OeqW_8JtNXAQWow8Ho8778Rq-Y_v22PSrbB39L0g@mail.gmail.com>
 <20240828170635.4112907-1-legion@kernel.org>
In-Reply-To: <20240828170635.4112907-1-legion@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 29 Aug 2024 02:22:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNATb8dbhvdSgiNEMkdsgg93q4ZUGUxReZYNjOV3fDPnfyQ@mail.gmail.com>
Message-ID: <CAK7LNATb8dbhvdSgiNEMkdsgg93q4ZUGUxReZYNjOV3fDPnfyQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Remove custom build rule
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:07=E2=80=AFAM Alexey Gladkov <legion@kernel.org> =
wrote:
>
> According to the documentation, when building a kernel with the C=3D2
> parameter, all source files should be checked. But this does not happen
> for the kernel/bpf/ directory.
>
> $ touch kernel/bpf/core.o
> $ make C=3D2 CHECK=3Dtrue kernel/bpf/core.o
>
> Outputs:
>
>   CHECK   scripts/mod/empty.c
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      kernel/bpf/core.o
>
> As can be seen the compilation is done, but CHECK is not executed. This
> happens because kernel/bpf/Makefile has defined its own rule for
> compilation and forgotten the macro that does the check.
>
> There is no need to duplicate the build code, and this rule can be
> removed to use generic rules.
>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>


Did you compile-test this?

See my previous email.




I said this:

$ cat kernel/bpf/btf_iter.c
#include "../../tools/lib/bpf/btf_iter.c"


Same for
kernel/bpf/btf_relocate.c
kernel/bpf/relo_core.c











> ---
>  kernel/bpf/Makefile | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 0291eef9ce92..9b9c151b5c82 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -52,9 +52,3 @@ obj-$(CONFIG_BPF_PRELOAD) +=3D preload/
>  obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
> -
> -# Some source files are common to libbpf.
> -vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
> -
> -$(obj)/%.o: %.c FORCE
> -       $(call if_changed_rule,cc_o_c)
> --
> 2.46.0
>


--
Best Regards
Masahiro Yamada

