Return-Path: <bpf+bounces-47315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08689F7AF5
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 13:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912B5188E300
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0BF224882;
	Thu, 19 Dec 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKPhY/bK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8A221DAE;
	Thu, 19 Dec 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734610072; cv=none; b=o+l1q2U64JSSH2qe7dmRxGesNJ5oa2biE2A5oxvAsqIivVTEFxjGlSSQpN/ENo+xC5LdTCa8C54u6u6xe/JYHMJ3OiGaINm0+RTqxsCiEM8w/qhAu8M41bYOAUrabTAN7oztAtgt+dGAGgFIP8OZ+YkOc6CEOMSWxwugknxYwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734610072; c=relaxed/simple;
	bh=vOgntCS18pN5Q5QIsU2FV4aSF2+wHhDktIW3xR3Sw0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Td9b4uRk2hIckIMvK6bO04z7zY+5v/w9iyBzJYEWTxfrBDviDsEcDxJwB9IHcrC5hFaJWAEfVFMblB5rbJ86dW2OQImKNyA8f0ZXmOQ82GjlP8GgphXzr6CxQ9VrBNV7TYPMcKemHcj68e8WE1RyM82MxfaBXP1huLuyKIsMZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKPhY/bK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143D1C4CECE;
	Thu, 19 Dec 2024 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734610072;
	bh=vOgntCS18pN5Q5QIsU2FV4aSF2+wHhDktIW3xR3Sw0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EKPhY/bK+AEMpHpgX9AHJ8AkM2dqufCwS8MmLj6H1SB0LdorXmnWS+AgQ2X9V3+tC
	 caPzSiBCTBpF1iB0AVVWcU9IV3GckBrIcK6a+LGR6mb+at1cdBYTK2jCMUiIq194uz
	 HqluTOJvahtyoTP5y6nBbEFr8EZusj45dwsklvcGI0CXVpSXM3Bv0RdkIujG5FCdnk
	 Whfyo1gxNS5aGQFjMNTFezh7NJTY2j71r8YVupNa3hAQaTOXkV8TKhR4v6lZToRoU9
	 B4+Q+Adkp9z+FWNHBLMPSfwC2l0GLAG9xtQU7NwbkX7BndZyZEScRbMEjnI0XQnNL8
	 00LXbOEc7wTdA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa689a37dd4so142597666b.3;
        Thu, 19 Dec 2024 04:07:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSkE/qMH4jwSJuu5E3djzIYgY5BLJxHORSLJ9W7WpTW4bLkIcMKlaaPGTY8yljL6CmDtFot+WUmslVULyf@vger.kernel.org, AJvYcCWnXUiTRX8lF+NOtJQNM+TLkiCPSNNnvml4IEYlobnpIHwdADYkFgfe0AneJ1SvSrF2jnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYbx/HA5FSVb7wTLJUWTbDE/4ycAGRBUEUBvTOc9VlF/khJYzi
	1k0VfGYrMI/3FJVLkCIdcUFgUbPp1WDAZmkN0Bs8C/dZ6tXmHatvzxmKMyGYm2SL+XmH8vTltZo
	CcJIxiNtC/C2GC5278pFbhkFQ1EQ=
X-Google-Smtp-Source: AGHT+IGWH2Fgy2bZcZQHKfbjlmi9TCd2UyCSQowbjzSildlYHuAaxq/5FR4Nb8FMZ/y9DnrdcJyRQZx/oeMFlNq8sB0=
X-Received: by 2002:a17:907:7719:b0:aa6:8186:5cab with SMTP id
 a640c23a62f3a-aac07b02132mr237409066b.54.1734610070657; Thu, 19 Dec 2024
 04:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219111506.20643-1-yangtiezhu@loongson.cn>
In-Reply-To: <20241219111506.20643-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Dec 2024 20:07:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7PYgiu-JtnVMkyH6-WCYU3D1HN13ESpawoT=xT_ftoVQ@mail.gmail.com>
Message-ID: <CAAhV-H7PYgiu-JtnVMkyH6-WCYU3D1HN13ESpawoT=xT_ftoVQ@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Use asm constraint "m" for LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Nathan Chancellor <nathan@kernel.org>, bpf@vger.kernel.org, 
	llvm@lists.linux.dev, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Thu, Dec 19, 2024 at 7:15=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Currently, LoongArch LLVM does not support the constraint "o" and no plan
> to support it, it only supports the similar constraint "m", so change the
> constraints from "nor" in the "else" case to arch-specific "nmr" to avoid
> the build error such as "unexpected asm memory constraint" for LoongArch.
>
> Cc: stable@vger.kernel.org
> Fixes: 630301b0d59d ("selftests/bpf: Add basic USDT selftests")
> Link: https://llvm.org/docs/LangRef.html#supported-constraint-code-list
> Link: https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/Loon=
gArch/LoongArchISelDAGToDAG.cpp#L172
> Suggested-by: Weining Lu <luweining@loongson.cn>
> Suggested-by: Li Chen <chenli@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/sdt.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/=
bpf/sdt.h
> index ca0162b4dc57..1fcfa5160231 100644
> --- a/tools/testing/selftests/bpf/sdt.h
> +++ b/tools/testing/selftests/bpf/sdt.h
> @@ -102,6 +102,8 @@
>  # define STAP_SDT_ARG_CONSTRAINT        nZr
>  # elif defined __arm__
>  # define STAP_SDT_ARG_CONSTRAINT        g
> +# elif defined __loongarch__
> +# define STAP_SDT_ARG_CONSTRAINT        nmr
>  # else
>  # define STAP_SDT_ARG_CONSTRAINT        nor
>  # endif
> --
> 2.42.0
>
>

