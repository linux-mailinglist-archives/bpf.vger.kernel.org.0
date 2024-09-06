Return-Path: <bpf+bounces-39161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47BE96FCFA
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D30A1C22642
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF19B14A095;
	Fri,  6 Sep 2024 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsBSAGO3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC051B85DF
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656592; cv=none; b=AVROhB9okdMIZ+BjLj0auxiK382v0rFpK03wtIouJzhbjI0gDAKWMMcx5mitdXn3rFVbLGbYtVIqS++kcQyvgRk4k4KufEdbaqKZk9ZkaiR2hhS+RRrFeaFS89aIhsmzBAlRkuojLEjQbXUdELGKBGFu68MaYglMCw5fGETCsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656592; c=relaxed/simple;
	bh=dAyciXS0T15BJoRSf55bodkdPgiX8Q894VkkPcmn3kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEWyPHI5u9djtPlssdUydRmtPsy+lgRt1p6bePDtcKsLXTKS7Ygz93LwPje1DmgNvhyZ3dI7GHMHzYN3a8uiBQX7ehV8A14XhpUm0k0DfF9R41bMVOfA4Iu0fvttBKnsP+ZyfE0aKLKIkguk2HsZnDHDu435zn9CDOuUL/OHUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsBSAGO3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8b96c18f0so1919883a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725656590; x=1726261390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5WNWbLa/RvlSRACSFrgHMQDIlWr9KLkQFngqAZoPpM=;
        b=hsBSAGO303icdMKru+iJ+9aKFPNNEotqkoSITuCd8a3BJYpGCpoLGwYHkCAO7LkFjv
         RzZ57dNtWmpDTGeBHCPLDzAioh0XvfxKQ4c4U8qtVGssk07nsZGZFjNf1RrtjmgCRhNW
         x5SuGls1WKeO+YrYxrq2jPkaO/4qpa1HxldgY2XHD14mlSmbhMcwJk1Lgm0LRiWr99yn
         EOj1I24Zdhqm3rJSQAfC/lKr9/8UunwD/NB0NjSRexfGxgF76KWaqQNDX9cm53Xz5ThO
         hoSJ2fmx/vlxmOwxZp2wcf7wvgXxEROUnaqDZIiQNt4OiZTIAo4DSAokuFhP4wPJfNmu
         yD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725656590; x=1726261390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5WNWbLa/RvlSRACSFrgHMQDIlWr9KLkQFngqAZoPpM=;
        b=WphSA+OqnFHwVN09UIVsH1rgTnu67bKgFNUb0b0tW7fhCJsebbf0KBn25S4TbkxjHB
         sEhO8EMU0CbwdGdoXFmi+ERXOYIv03jzav2fP4CmAoq83NbYffYx4ZIJFAdTqHAXRTf+
         NhXKq4cwxNm+bnh1XiX/Cg96KEXLgL56atOa14u1xfcoFd0tAY7dUL/0pRSGo/O/YxeZ
         0qhqH5D6vkcYyKGlOrtOSkAAgVr2HntwWf9JQZUhYn8X9PG+03dlSHGbySlkp/cCNz3t
         c1UreyfkIcozw2Ptp4107dI0eOlEMeHlVmDhCtepO3WA159ghpgrbbEWUvBYCywQdloB
         NEpA==
X-Gm-Message-State: AOJu0YxZiYYSHBOy61jgNeYAXeN+cYFjlI/awX6FVrRByf4iaQv6c7Bq
	k2aQFdE2tKSb9GOXzmVPNu+Jfp6GNpocuWmvYYjM+udHQ0WPZ6xZp2+DpaqUfbIhV54Ikf65531
	cYNiMVDa9+Jqekjg/fbw7V1nuvV8=
X-Google-Smtp-Source: AGHT+IEaFsSCme/Qj3QwB0Xh18wOgJEHch0r0XRfL5cigtZLCNXpm2bZ0rh3bB4Dd+LwG8WngG2xGI1hY780Yx0NQB0=
X-Received: by 2002:a17:90a:8a15:b0:2d8:99c4:3cd9 with SMTP id
 98e67ed59e1d1-2dad4de1392mr4372015a91.3.1725656590197; Fri, 06 Sep 2024
 14:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906135608.26477-1-daniel@iogearbox.net>
In-Reply-To: <20240906135608.26477-1-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:02:57 -0700
Message-ID: <CAEf4BzYBJWctucR6xmv9vRGzHph36kfNuV+MgAjiS2jmp0WraQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Fix bpf_strtol and bpf_strtoul
 helpers for 32bit
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, shung-hsi.yu@suse.com, andrii@kernel.org, 
	ast@kernel.org, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> The bpf_strtol() and bpf_strtoul() helpers are currently broken on 32bit:
>
> The argument type ARG_PTR_TO_LONG is BPF-side "long", not kernel-side "lo=
ng"
> and therefore always considered fixed 64bit no matter if 64 or 32bit unde=
rlying
> architecture.
>
> This contract breaks in case of the two mentioned helpers since their BPF=
_CALL
> definition for the helpers was added with {unsigned,}long *res. Meaning, =
the
> transition from BPF-side "long" (BPF program) to kernel-side "long" (BPF =
helper)
> breaks here.
>
> Both helpers call __bpf_strtoll() with "long long" correctly, but later a=
ssigning
> the result into 32-bit "*(long *)" on 32bit architectures. From a BPF pro=
gram
> point of view, this means upper bits will be seen as uninitialised.
>
> Therefore, fix both BPF_CALL signatures to {s,u}64 types to fix this situ=
ation.
>
> Now, changing also uapi/bpf.h helper documentation which generates bpf_he=
lper_defs.h
> for BPF programs is tricky: Changing signatures there to __{s,u}64 would =
trigger
> compiler warnings (incompatible pointer types passing 'long *' to paramet=
er of type
> '__s64 *' (aka 'long long *')) for existing BPF programs.
>
> Leaving the signatures as-is would be fine as from BPF program point of v=
iew it is
> still BPF-side "long" and thus equivalent to __{s,u}64 on 64 or 32bit und=
erlying
> architectures.
>
> Note that bpf_strtol() and bpf_strtoul() are the only helpers with this i=
ssue.
>

I think the bpf_helper_defs.h (and UAPI comment) side is completely
correct and valid. That "long" in BPF helpers is always s64 and we
rely on that on the BPF side. So I don't think we even need to change
anything there.

Perhaps the original intent was to do arch-native long, not sure...
But in any case, it's easy to check this in user code given we always
have full 64-bit result.

LGTM:

Acked-by: Andrii Nakryiko <andrii@kernel.org>



> Fixes: d7a4cb9b6705 ("bpf: Introduce bpf_strtol and bpf_strtoul helpers")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/bpf/481fcec8-c12c-9abb-8ecb-76c71c009959@io=
gearbox.net
> ---
>  v3 -> v4:
>  - added patch
>
>  kernel/bpf/helpers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 3956be5d6440..0cf42be52890 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -518,7 +518,7 @@ static int __bpf_strtoll(const char *buf, size_t buf_=
len, u64 flags,
>  }
>
>  BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
> -          long *, res)
> +          s64 *, res)
>  {
>         long long _res;
>         int err;
> @@ -543,7 +543,7 @@ const struct bpf_func_proto bpf_strtol_proto =3D {
>  };
>
>  BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
> -          unsigned long *, res)
> +          u64 *, res)
>  {
>         unsigned long long _res;
>         bool is_negative;
> --
> 2.43.0
>

