Return-Path: <bpf+bounces-46116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862909E46EA
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C547283B30
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC9195B1A;
	Wed,  4 Dec 2024 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZrllgIX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF91922D7;
	Wed,  4 Dec 2024 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348196; cv=none; b=XqKzF7nqgWsPvAXCJmjGMAyz36sBnJElLuN64wcx0YMsOzP+hUlIvxr9txkKPjzKL+84wqeeG5TFjg04RqDXcG9RPPVO7ro4aYPh+Bp4jvXjq2wHFfzI/V63ZtURZrk7D94vY3whwSxakthBx3+Qk0ULgVDUA7C8PwhA0zZJ9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348196; c=relaxed/simple;
	bh=jlmY/d16hd2yWGESz2d7BSfN+1MNllSvrARNdqx6DgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbwCJeDuz2uAg+RlVqKE+tkYBlTGchFaRI9tUSsXuixnAJxhijW4uUUvBGZ1JfGRuxERICyA/JcfQpIu0tlorwVp3OXUqO34lX2RLxpgRkKkyHDWkr33MZoCuEZZnYMABAJcEK91zgVAL5Kr6Z/z+lJ9sFhhQcL7dQJ/LqT2U50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZrllgIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D631DC4CECD;
	Wed,  4 Dec 2024 21:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733348194;
	bh=jlmY/d16hd2yWGESz2d7BSfN+1MNllSvrARNdqx6DgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZrllgIX/Vem/uL/kq3DDs8xYZdu654Fi063fFBOj4ZsSRtkzbmSbxT3V75Vs3ccu
	 lweZO86ljseuuqIcXmSK0D50Q/ZbaZ8Xw4TEjDd3dqdnmZjakCRc8z5vhNHXiFRgCA
	 6M0PBUC3m/uiBT7gwJYeZGBnuPqsrHDeUim1QgTaz6OhkZT8CCvDJKHg9gAGzpGFcC
	 XdPpLrJUmrdwALFGZIc4ZTlOXWgJosJRLmEeYaesAJCQznOOQgJNUL9sGQZC9ALolo
	 nOcWezv49+yDjXfbi9LJx2RzLOJ0nRJgIj/Mav4/H0Cs6v36QkEy2mqgENCSO8rqYy
	 1oAzHQvG4+l5w==
Date: Wed, 4 Dec 2024 13:36:32 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpftool: Fix failure with static linkage
Message-ID: <Z1DLYCha0-o1RWkF@google.com>
References: <20241204213059.2792453-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204213059.2792453-1-leo.yan@arm.com>

Hi Leo,

On Wed, Dec 04, 2024 at 09:30:59PM +0000, Leo Yan wrote:
> When building perf with static linkage:
> 
>   make O=/build LDFLAGS="-static" -C tools/perf VF=1 DEBUG=1
>   ...
>   LINK    /build/util/bpf_skel/.tmp/bootstrap/bpftool
>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_compress':
>   (.text+0x113): undefined reference to `ZSTD_createCCtx'
>   /usr/bin/ld: (.text+0x2a9): undefined reference to `ZSTD_compressStream2'
>   /usr/bin/ld: (.text+0x2b4): undefined reference to `ZSTD_isError'
>   /usr/bin/ld: (.text+0x2db): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: (.text+0x5a0): undefined reference to `ZSTD_compressStream2'
>   /usr/bin/ld: (.text+0x5ab): undefined reference to `ZSTD_isError'
>   /usr/bin/ld: (.text+0x6b9): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: (.text+0x835): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: (.text+0x86f): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: (.text+0x91b): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: (.text+0xa12): undefined reference to `ZSTD_freeCCtx'
>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress':
>   (.text+0xbfc): undefined reference to `ZSTD_decompress'
>   /usr/bin/ld: (.text+0xc04): undefined reference to `ZSTD_isError'
>   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress_elf':
>   (.text+0xd45): undefined reference to `ZSTD_decompress'
>   /usr/bin/ld: (.text+0xd4d): undefined reference to `ZSTD_isError'
>   collect2: error: ld returned 1 exit status
> 
> Building bpftool with static linkage also fails with the same errors:
> 
>   make O=/build -C tools/bpf/bpftool/ V=1
> 
> To fix the issue, explicitly link libzstd.

I was about to report exactly the same. :)

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/bpf/bpftool/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index a4263dfb5e03..65b2671941e0 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
>  endif
>  endif
>  
> -LIBS = $(LIBBPF) -lelf -lz
> -LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
> +LIBS = $(LIBBPF) -lelf -lz -lzstd
> +LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz -lzstd
>  ifeq ($(feature-libcap), 1)
>  CFLAGS += -DUSE_LIBCAP
>  LIBS += -lcap
> -- 
> 2.34.1
> 

