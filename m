Return-Path: <bpf+bounces-58329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF0AB8BD6
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 18:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA817A56FF
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC305218AA3;
	Thu, 15 May 2025 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgYdCd+/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E61A5BB1;
	Thu, 15 May 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325035; cv=none; b=FLBNV+gSC7zhhakM9628dUVbYezHpdb/HB/MTByQE9Ot57JN21CxpoDCgPVlcq8W8+iE+RFOGR/XKDoPEHZxLnJw90WwbyLkveSbt8umHftjCiWVIgoxA7TbCGgYdMKMc5DvwuS6kYAQKyU6RqAopTEmV0uwRyCC5CcL6J1UHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325035; c=relaxed/simple;
	bh=nvjc/Lk5BrAlP27T30+ARUsGXUd0a7PMDJD9kxSZ4Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIK0nd5dcoI6g4GF+6nZ+P/2uK7TpDhai7SQlYujPEe0iTi/azvh6Md4KOSYgc5zECuGAGnAxoh/cWiyylZeO6N4eVQ5IcTjBmsZC/nrRFQyyEa3MSFHWWtnTAyr79C0e78LI9z3IcsBUWkVPq1Kou8daRYXfv379DKPb1md4us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgYdCd+/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so1098377a91.3;
        Thu, 15 May 2025 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747325033; x=1747929833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQIzojvdBrCvjCTQup3lWYpKZ6WvBhI3Efadpz4Nhvg=;
        b=FgYdCd+/1r6RzoXrmTglW07CFuFV8BvjuYQiteYB5IvxD1/S9P5yg/C/kRB5DKsOwF
         r0bjxv57ZVWPfmW7hbf/NeFHJiCro3MTtaKyZ9qSh7iDcTWdacLcJY4N0J+KEP7uXmSq
         vWPhPvSQinF0seXAntUrbwiey4+wl/pJ/aO13dIuJaAyQJ2Xz8Zut03iuCXjWH0cd0eL
         A/1WPf2T6e4y56mms4TcJ441U0Wop8d1faT7p2fetySOJf4fX4qademRV1YioxEzjVbD
         dcAIOmZctdNgiElv+C3glVCdxhv/7NoSKPzwIyvGVzzod0jwwSM4x0bVPHoleEu5Vezt
         Tp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747325033; x=1747929833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQIzojvdBrCvjCTQup3lWYpKZ6WvBhI3Efadpz4Nhvg=;
        b=sYJXhOEyHttzU/3da+OGAXChmVWlRBiniEbNx9AjDcJw6agtYoa3CTzMhBcqgzIvWm
         Xm/hAFJkTHoZtHbSY2AQ0gEypGLWfHOLRn+rE6apIL3s0LoqCz8rAYedxJ6kASVNccKd
         6aj/P2BpDPfrGQJre92LaOVpcT6SeTjAVmoXcCjZW0C0xUbtXz0oDQLm8u7pLOKNXt88
         WVzVCvZU67Dz6KXU0Sap+m4L+pXmCJOewxB4LkunFbALUkxHmLIh3MgpkCkr0lIFsDFy
         +CuXXXqUXbrjJPqiYZTtC/QZDJmjqnd+qVJBtmeG15MH4C+pX50TcBOsXoB6xhJagWTS
         Ty/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjYrI8p7CbiSr4lg/EL5T1NtQIKcS/NYi6nVyQhCjdY9OKSkaO63s6w3D27Y3gwBQyQmhtsaH5hjIqruM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2MW++fvT+6L7C/bHAqQVoPOz4a9pS4lcRUYjS8DbIs/XVTP6o
	v5RyMQs7oj171Q7mhbmIPidyR24IVKdrqmU1wBFvlGGAYfcTRkwVmTg/4LSYB7KBLG54C5+3n1E
	soAOQ/n8xpI/RhaZT44Kpa1vio0U=
X-Gm-Gg: ASbGncsmDWmZ/uKEY67ESwabwuTBI5eZGL79PgbryTBrCjJb/Dj7aVYpCa+E58bwf41
	jwC9Y79bLeS7chBrhqNIb2RwZX9fq1cnTcrGxjnuvwNhlWuMmEN5LMifLpvCmeylDIyFkVNGqYC
	1rjUtR7GkOWeXsJOimh+9O2Xl/6i+oY77rTTUF/evBr7Zexlhx
X-Google-Smtp-Source: AGHT+IGLnmAyTn+jbsZIBQgkJ5Sm1BS3PdUGW0qm7m2ynVGjjj2unFwpaUwcZfyE3ODVEoU9zApvt4zXrBJffr61fDg=
X-Received: by 2002:a17:90b:3d8d:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-30e2e59bd13mr11340591a91.6.1747325032753; Thu, 15 May 2025
 09:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515065018.240188-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250515065018.240188-1-jiayuan.chen@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 09:03:39 -0700
X-Gm-Features: AX0GCFv-OIxKCK9_Iw8tQ87ssy1Vb7qkSx0Tpb5CAtDvK01K1f2E5fqT1JWIn44
Message-ID: <CAEf4BzYf7+D_Jck6LH_tFTdsfNg+tWQvz-T2WccYYEefRHm3Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Add support for custom BTF path in
 prog load/loadall
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Tao Chen <chen.dylane@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 11:52=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> This patch exposes the btf_custom_path feature to bpftool, allowing users
> to specify a custom BTF file when loading BPF programs using prog load or
> prog loadall commands.
>
> The argument 'btf_custom_path' in libbpf is used for those kernes that
> don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform CO-RE
> relocations.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  7 ++++++-
>  tools/bpf/bpftool/bash-completion/bpftool        |  2 +-
>  tools/bpf/bpftool/prog.c                         | 12 +++++++++++-
>  3 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf=
/bpftool/Documentation/bpftool-prog.rst
> index d6304e01afe0..e60a829ab8d0 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -127,7 +127,7 @@ bpftool prog pin *PROG* *FILE*
>      Note: *FILE* must be located in *bpffs* mount. It must not contain a=
 dot
>      character ('.'), which is reserved for future extensions of *bpffs*.
>
> -bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *I=
DX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps =
*MAP_DIR*] [autoattach]
> +bpftool prog { load | loadall } *OBJ* *PATH* [type *TYPE*] [map { idx *I=
DX* | name *NAME* } *MAP*] [{ offload_dev | xdpmeta_dev } *NAME*] [pinmaps =
*MAP_DIR*] [autoattach] [kernel_btf *BTF_DIR*]
>      Load bpf program(s) from binary *OBJ* and pin as *PATH*. **bpftool p=
rog
>      load** pins only the first program from the *OBJ* as *PATH*. **bpfto=
ol prog
>      loadall** pins all programs from the *OBJ* under *PATH* directory. *=
*type**
> @@ -153,6 +153,11 @@ bpftool prog { load | loadall } *OBJ* *PATH* [type *=
TYPE*] [map { idx *IDX* | na
>      program does not support autoattach, bpftool falls back to regular p=
inning
>      for that program instead.
>
> +    The **kernel_btf** option allows specifying an external BTF file to =
replace
> +    the system's own vmlinux BTF file for CO-RE relocations. NOTE that a=
ny
> +    other feature (e.g., fentry/fexit programs, struct_ops, etc) will re=
quire
> +    actual kernel BTF like /sys/kernel/btf/vmlinux.
> +
>      Note: *PATH* must be located in *bpffs* mount. It must not contain a=
 dot
>      character ('.'), which is reserved for future extensions of *bpffs*.
>
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftoo=
l/bash-completion/bpftool
> index 1ce409a6cbd9..609938c287b7 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -511,7 +511,7 @@ _bpftool()
>                              ;;
>                          *)
>                              COMPREPLY=3D( $( compgen -W "map" -- "$cur" =
) )
> -                            _bpftool_once_attr 'type pinmaps autoattach'
> +                            _bpftool_once_attr 'type pinmaps autoattach =
kernel_btf'
>                              _bpftool_one_of_list 'offload_dev xdpmeta_de=
v'
>                              return 0
>                              ;;
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index f010295350be..3b6a361dd0f8 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1681,8 +1681,17 @@ static int load_with_options(int argc, char **argv=
, bool first_prog_only)
>                 } else if (is_prefix(*argv, "autoattach")) {
>                         auto_attach =3D true;
>                         NEXT_ARG();
> +               } else if (is_prefix(*argv, "kernel_btf")) {
> +                       NEXT_ARG();
> +
> +                       if (!REQ_ARGS(1))
> +                               goto err_free_reuse_maps;
> +
> +                       open_opts.btf_custom_path =3D GET_ARG();
>                 } else {
> -                       p_err("expected no more arguments, 'type', 'map' =
or 'dev', got: '%s'?",
> +                       p_err("expected no more arguments, "
> +                             "'type', 'map', 'dev', 'offload_dev', 'xdpm=
eta_dev', 'pinmaps', "
> +                             "'autoattach', or 'kernel_btf', got: '%s'?"=
,
>                               *argv);
>                         goto err_free_reuse_maps;
>                 }
> @@ -2474,6 +2483,7 @@ static int do_help(int argc, char **argv)
>                 "                         [map { idx IDX | name NAME } MA=
P]\\\n"
>                 "                         [pinmaps MAP_DIR]\n"
>                 "                         [autoattach]\n"
> +               "                         [kernel_btf BTF_DIR]\n"

Is it a DIR or a FILE/PATH?

>                 "       %1$s %2$s attach PROG ATTACH_TYPE [MAP]\n"
>                 "       %1$s %2$s detach PROG ATTACH_TYPE [MAP]\n"
>                 "       %1$s %2$s run PROG \\\n"
> --
> 2.47.1
>
>

