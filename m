Return-Path: <bpf+bounces-42236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF659A1418
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 22:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA25B22489
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 20:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2991216A29;
	Wed, 16 Oct 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQZdaKtE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130A4176AB6
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110868; cv=none; b=jmvjS2asAqmrBs841kHtBFupKBXSCjMOXGKgZ1+mFnFIvYz15vc7oXED8CD4BSC7sCXwS88jdC40nFHPTQ2KMtkPdVa/GrzunezJRr6vAmx74zBFRURDyBtGDw3dbjMZJQ4JPhgRSDwPYfbHD+NCpsGxPkvYKUpNELp6JJrqAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110868; c=relaxed/simple;
	bh=Ow17KVAyVZJ9K54HtF2YmLrwJv/aWN+D9iyX+/pi6Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMn9ixYSxPpHXsZnJZOtzGDN/oV4QG+NqWjQE8GIQHq0pX++rriq/b8qBsFkySyLxg+bxQMQJ51xqrHnk82uV5VdpoCOFeYmoOmVmjUQ1LxcbX/AvE5AtOrce+KWUKVLsXQJaxllJRaD+A1gK2+9z/JS/sjxH597PAnqLw9GSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQZdaKtE; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so189361a91.0
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729110866; x=1729715666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2229NehUggK9szlzuuEkxo5UTNg3Fu01Y2dY8YiB58=;
        b=mQZdaKtE3qzOeShJLzQsMZiL0QDvKiywspdBYeECYqMHPJxnQ0HKvvnFPNQ77NNg3b
         SWGGG0G30IZjalq2067GqnRB0YiSa1gkw5QD9gHnC8sbGxR0Xo6l6twOO3Tcq4ma1ljq
         xHKt3yDAwijKrPkclnAeUT6J69OK3w3M0AT8RyHUIL8PmtUwQ1x4Vk3m+okeovyKaIHC
         zAihrS4Do/L/ASonhosnKl6WtwR2ZbPq8PUAyApDETTzJAGTy0qtX7X9kqzFAqwFkRUN
         Tb5Qm9sO4cIdxbzh2R8Rbbms1lJv6BgakT16S3F+gyn/bV6Icxef6+6ddm2gSQdpOdp5
         OxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110866; x=1729715666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2229NehUggK9szlzuuEkxo5UTNg3Fu01Y2dY8YiB58=;
        b=JLzvfOn8xeI1BdSK2LFc5Keg4OWMk+/YT5SpV4kHSoBlXfTOni2VIvhlYpnk/ai8E/
         nBFaWmTA+cKDDKZYQZD3ym07KJO87/0O/Wu2hKtETGMcHRaAd0zZjteN9/BhCILvBwAW
         bnXWqKB7hqkO6tyztwTRurroJs1lwacc5njFb1rx3wwsOUP1NNrgSsEBj2uIB4VAL6iA
         1BHQ5qXEiAye10pUmXU1eCA+W5UaZ0EZObYRwno92LGKfjqZ6YPi2FuewoDYnPCSSZPD
         breItci/qpEZyeKRVP3D5n69kDeINLSzANX5N5xLUkQGnHyb3pWRYv7BPajAHQntGI4x
         ihtg==
X-Gm-Message-State: AOJu0Yx5RIlZ1Ny1D2N9gIg1vgzc21Qq975259g0PoUs/T0ugFXSMiir
	Uu3mSIquKDb6VtWlMtC6ESSAIleuNA9+KI+RsqYjIlj1Y9a2VJUsv2jzwQKuM56pbi5MSUFT4S7
	nqsa9rKwDMrecZlITDiYV6GZLUXs=
X-Google-Smtp-Source: AGHT+IE0P0gE7yZZ4jhNleKd2XnQXYE0YThYHa0I++n3edxgdUxwG+wEU0S0LxQUretdorwVS8qCtqpVgF1ELGEH5GM=
X-Received: by 2002:a17:90b:360b:b0:2e2:8995:dd1b with SMTP id
 98e67ed59e1d1-2e2f0a5d65emr21071101a91.3.1729110866298; Wed, 16 Oct 2024
 13:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728975031.git.vmalik@redhat.com> <507d699068777b78a5720e617c99fb19a9bb8a89.1728975031.git.vmalik@redhat.com>
In-Reply-To: <507d699068777b78a5720e617c99fb19a9bb8a89.1728975031.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Oct 2024 13:34:13 -0700
Message-ID: <CAEf4BzYJQMFv=BaB0=foVyAPVazhPreVx7c0PVWK28cLuELbtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpftool: Prevent setting duplicate
 _GNU_SOURCE in Makefile
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:55=E2=80=AFPM Viktor Malik <vmalik@redhat.com> w=
rote:
>
> When building selftests with CFLAGS set via env variable, the value of
> CFLAGS is propagated into bpftool Makefile (called from selftests
> Makefile). This makes the compilation fail as _GNU_SOURCE is defined two
> times - once from selftests Makefile (by including lib.mk) and once from
> bpftool Makefile (by calling `llvm-config --cflags`):
>
>     $ CFLAGS=3D"" make -C tools/testing/selftests/bpf
>     [...]
>     CC      /bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf=
.o
>     <command-line>: error: "_GNU_SOURCE" redefined [-Werror]
>     <command-line>: note: this is the location of the previous definition
>     cc1: all warnings being treated as errors
>     [...]
>
> Let bpftool Makefile check if _GNU_SOURCE is already defined and if so,
> do not let llvm-config add it again.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/bpf/bpftool/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index ba927379eb20..2b5a713d71d8 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -147,7 +147,13 @@ ifeq ($(feature-llvm),1)
>    # If LLVM is available, use it for JIT disassembly
>    CFLAGS  +=3D -DHAVE_LLVM_SUPPORT
>    LLVM_CONFIG_LIB_COMPONENTS :=3D mcdisassembler all-targets
> -  CFLAGS  +=3D $(shell $(LLVM_CONFIG) --cflags)
> +  # When bpftool build is called from another Makefile which already set=
s
> +  # -D_GNU_SOURCE, do not let llvm-config add it again as it will cause =
conflict.
> +  ifneq ($(filter -D_GNU_SOURCE=3D,$(CFLAGS)),)
> +    CFLAGS +=3D $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cfla=
gs))

why not always do filter-out and avoid this ugly ifneq?

> +  else
> +    CFLAGS +=3D $(shell $(LLVM_CONFIG) --cflags)
> +  endif
>    LIBS    +=3D $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENT=
S))
>    ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
>      LIBS +=3D $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COM=
PONENTS))
> --
> 2.47.0
>

