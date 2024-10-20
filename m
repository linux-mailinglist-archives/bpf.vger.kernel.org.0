Return-Path: <bpf+bounces-42529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6BC9A5554
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B461B21E9E
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 17:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A291946C7;
	Sun, 20 Oct 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEy7vy7Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC8173
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729445104; cv=none; b=UyxikinTHujF3N05FMZ7nZAa89jxdNgi2yGnY5OJkbYi0BRkOV2jPVHD/N7NT45wsxR/VsjpecKDQHiu3RkczloG92lkB3n0TV2bMv8TZTylvvzpQs+is4ikFDpnxF7qqGBT8KlfuUB6CKU3iR3A7H4IFYNCwL7NFdFoHr0Mgds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729445104; c=relaxed/simple;
	bh=1s/1ngEpSxvYLHhRMqbNOnmtcZPdfXfw573cltQDWzk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3QwcXlIU++817pDQ514g/4Mm1VUB+L8ekkBaNETN2TYJ9S95kjwpyHaErQCTlcXeHkjDpTkZjlAvHgXaqPIEelnDnNFM4YLblweCOv8iKM9j0/H3qb0mk8z7yaBjcyYhjXCKrl8XLZIis/ot85mp4CV+O/WbbfdgQRmzrQBkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEy7vy7Z; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so2682944f8f.1
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729445101; x=1730049901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfhvtwqfwubBefSjd8MUuAJm0YTqbkM2rch4ueVN9+w=;
        b=QEy7vy7ZFCJyOpCPObbIYnoVuTWB05sEMFD9tjouA02Ey1NykxAX5JXNgNp9e9m7rz
         hDqOJNz0oXa0trt76s+WI4Mgfnyid9ExsRE1drv18Qtgsqg9g2m8NXDaY6xHfrTZTLW5
         mFruy5Mlndr9vvKtRWhT2dqY/63yQceOdHr2OOwkmOzwpyx5Rl69Flyvl5i/eRLaBOjc
         ADRccCH8/8XGLtHKrsye7l3kZAqWGOtXtcKE1Sgdb065HR3tyunnI/Ko35SCvFOzY7n1
         JLy0RGavgCyCYdbAyWQH+nIWNqM97Ydd32z1vcw/74PdVH6jMqz/nBb7rl7vEyytIwPt
         owfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729445101; x=1730049901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfhvtwqfwubBefSjd8MUuAJm0YTqbkM2rch4ueVN9+w=;
        b=sYZJXVnZKs0sI6f6Y1yRQ3/n0Na7bgW1P8WL2l9Ou8ypDb0OxI17qyEZB0/3LcK8JZ
         Fi8AiAScQF8G5unkYWQ/BRlaKQq5UgklHD+xv7Gh21KwJsNWYGKEN1E69occyySgPKq8
         vkpmgL3DL24q5PjQnbVdWc8tpfl/OWfnGFEgzEAxSTcQDC8Xd4trDhGH2RJHPFxHt09n
         M1DZcXBZ7xnXpaATj2iKRO3XM+r7vk1pVdyiD76vrz6DUeJeiKb4I2rwBL11f6H2WuCZ
         C6UiBONf4IC+CWuPE1yMqehDGA85KCKUY1JzMpJ9+SrqRKBmU90EjC5vfYHwo8GLQxfv
         m/3g==
X-Gm-Message-State: AOJu0Yw/VHnlLeuTobTT6bZODUI/WtlCyLQVR+sVdBg0N74fHhqSfmzG
	2ldSaI29CMHb9/NiqhnOYTNqx1yNQNT30MxsUXs6G3dOwsUDmF47
X-Google-Smtp-Source: AGHT+IH22vMBqi5RqO8fk46yWCyhxDYcNBHcC7/LCn3FRfgCoHplICH7lK3bTCRiozwF9WQTrIpRdA==
X-Received: by 2002:a5d:4d03:0:b0:374:b35e:ea6c with SMTP id ffacd0b85a97d-37eb487a49amr6344017f8f.40.1729445100401;
        Sun, 20 Oct 2024 10:25:00 -0700 (PDT)
Received: from krava (85-193-35-5.rib.o2.cz. [85.193.35.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b813sm2157201f8f.58.2024.10.20.10.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 10:24:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 20 Oct 2024 19:24:57 +0200
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Disable warnings on
 unused flags for Clang builds
Message-ID: <ZxU86eN6kMrgmuaV@krava>
References: <cover.1729233447.git.vmalik@redhat.com>
 <370c84ee3a0e8627a09d89fff12f7a285565fb46.1729233447.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370c84ee3a0e8627a09d89fff12f7a285565fb46.1729233447.git.vmalik@redhat.com>

On Fri, Oct 18, 2024 at 08:49:01AM +0200, Viktor Malik wrote:
> There exist compiler flags supported by GCC but not supported by Clang
> (e.g. -specs=...). Currently, these cannot be passed to BPF selftests
> builds, even when building with GCC, as some binaries (urandom_read and
> liburandom_read.so) are always built with Clang and the unsupported
> flags make the compilation fail (as -Werror is turned on).
> 
> Add -Wno-unused-command-line-argument to these rules to suppress such
> errors.
> 
> This allows to do things like:
> 
>     $ CFLAGS="-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1" \
>       make -C tools/testing/selftests/bpf

hi,
might be my fedora setup, but this example gives me compile error below
even with the patch applied:

  EXT-OBJ  [test_progs] testing_helpers.o
In file included from testing_helpers.c:10:
disasm.h:11:10: fatal error: linux/stringify.h: No such file or directory
   11 | #include <linux/stringify.h>
      |          ^~~~~~~~~~~~~~~~~~~

jirka

> 
> Without this patch, the compilation would fail with:
> 
>     [...]
>     clang: error: argument unused during compilation: '-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1' [-Werror,-Wunused-command-line-argument]
>     make: *** [Makefile:273: /bpf-next/tools/testing/selftests/bpf/liburandom_read.so] Error 1
>     [...]
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 1fc7c38e56b5..3da1a61968b7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -273,6 +273,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
>  		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
>  		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
> +		     -Wno-unused-command-line-argument \
>  		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
>  		     -Wl,--version-script=liburandom_read.map \
>  		     -fPIC -shared -o $@
> @@ -281,6 +282,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
>  		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
> +		     -Wno-unused-command-line-argument \
>  		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
>  		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
>  		     -Wl,-rpath=. -o $@
> -- 
> 2.47.0
> 

