Return-Path: <bpf+bounces-37305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D631953C81
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03301C244C8
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F2914EC56;
	Thu, 15 Aug 2024 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdpPbquH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120614E2DF
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756693; cv=none; b=V38ecNitxgOo+wfKD/mAWWbEfaz0Lexyky4DKJTTT00bcCq68nqRilhYsM8J7h9EjVBInL/ORByu7XMLQhH1VMgeUqIRtzOc6ngV+cHGdjcz8UETj7HyTRfYevWb/FOzq5jDrAaX9vIyEqWy4xuH99p3MJkcgdlLTILhieyxtq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756693; c=relaxed/simple;
	bh=VKjcgEQhniXt9+xrHJtQm4Ima9Qph2VbEIbRCvnMpHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uz98+ZoaYharmsc/tkJz7RwZvZAxvfDvFTpOi/r6uWkd3OyRz4xocvWO3E+n5I1BTFl2lGfxzSNDPoFjPs7Qj+iqaCccBFpYfNzhh7tXhlWzlFzrfR8gjyi3MAd8PWGD5xYtCPEnVfyWxVg+O8UhgIIocr485xh43FT2fdTfavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdpPbquH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3d0b06a2dso626447a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723756691; x=1724361491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ALW/OJKyCb8xpaYf8HixuokefByHqqkft5Q4bEKUjM=;
        b=gdpPbquHiNDGlzN70J0vEnzrzHbDYhYtz3SJJvFgRjPdZVMtL/knkVyJEnfyk3hLoq
         2tztg+Hs620u/MEctwvt3UZN5kn5iArNTok0NPAxSGsfnwIMs9ZMig2C0qky0tQq2UD1
         tE+/2C8QKJrXmAA3fNdNCgpwUdZuqXGZKhvVoJOB2pyokC5Pvmk5cRDxm5OvZ7095OmM
         BtebqkiKkgfoDoEbadwtiRsJ4XYWj7P9LXWMddwLSuh9btrHXoCmp+NqGi976zwo9XvV
         l+eoIVGHgbmtjSO30Dz7AP2fhSzxLZ34seBn5zEqFfQrHLkbbLt2lW/Eiytvtgk8/97C
         t6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756691; x=1724361491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ALW/OJKyCb8xpaYf8HixuokefByHqqkft5Q4bEKUjM=;
        b=wWn9rlsUF6XQ7D82Hx275+Pg7ODGbr2Eb23Y95jdTSaGHfjpo0HQijrb6tWr/RaSAH
         gZzLzdmKU4XxL6oVJkZiFBoPK6EuxvOgQDqnYVUZtOcHCaw6AtJYUBSwWd2OA22YkvYL
         TwcfE9tJkDwqxZtxEDpwmU+/LdDH+AoLwsmlYf1U6jwUtVPBmrKrjMbLDbPZtopk926k
         qRvZYsUgdXHnW9mDK+On2+eRC8NJ0qbYows9+OxKvXEG/Wn5mxfQjni+SYodfc0QsOsR
         vhdniSzIK+gd2ZXDlKk2t6FjdjZE+J5NjcI1yunl+MEwNxBEfH6YXZ9UQC7RxiErwwNf
         Fb1g==
X-Gm-Message-State: AOJu0YzyXaRLoDN7OS6zgTcIOdyjoPC91YbAsxfL4XFjpQY+Ij171DCe
	SdWnN6t5nI51bi95ZD5niKguJMAl07TaTEje23ie0Jy95dZVBIgi/4oHfGx/KzY1IwGfc3yYO5T
	AynymCZ8cUfNwuX9uB0ob+Qzxdy0=
X-Google-Smtp-Source: AGHT+IFwT7iODQEC1aQUJ4Ujz48PFDFex6fAB+XiTpJrltAs0b3cfcWT8N+EcOmwIq7Q4BygW8J+xijvhE/VRHgJdbM=
X-Received: by 2002:a17:90a:de86:b0:2d3:bd6f:a31e with SMTP id
 98e67ed59e1d1-2d3e00ecdffmr1018107a91.28.1723756690612; Thu, 15 Aug 2024
 14:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815205449.242556-1-eddyz87@gmail.com> <20240815205449.242556-3-eddyz87@gmail.com>
In-Reply-To: <20240815205449.242556-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 14:17:58 -0700
Message-ID: <CAEf4BzZ2Z3P+m+ptHbMMwLhR=KvJZsd-w9z56=hGTCvbTzGhtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: utility function to get
 program disassembly after jit
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, hffilwlqm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 1:56=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> This commit adds a utility function to get disassembled text for jited
> representation of a BPF program designated by file descriptor.
> Function prototype looks as follows:
>
>     int get_jited_program_text(int fd, char *text, size_t text_sz)
>
> Where 'fd' is a file descriptor for the program, 'text' and 'text_sz'
> refer to a destination buffer for disassembled text.
>
> The code and makefile changes are inspired by jit_disasm.c from bpftool.
> Use llvm libraries to disassemble BPF program instead of libbfd to avoid
> issues with disassembly output stability pointed out in [1].
>
> Selftests makefile uses Makefile.feature to detect if LLVM libraries
> are available. If that is not the case selftests build proceeds but
> the function returns -ENOTSUP at runtime.
>
> [1] commit eb9d1acf634b ("bpftool: Add LLVM as default library for disass=
embling JIT-ed programs")
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |  51 +++-
>  .../selftests/bpf/jit_disasm_helpers.c        | 234 ++++++++++++++++++
>  .../selftests/bpf/jit_disasm_helpers.h        |  10 +
>  4 files changed, 294 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.h
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index 8f14d8faeb0b..7de4108771a0 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -8,6 +8,7 @@ test_lru_map
>  test_lpm_map
>  test_tag
>  FEATURE-DUMP.libbpf
> +FEATURE-DUMP.selftests
>  fixdep
>  /test_progs
>  /test_progs-no_alu32
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index f54185e96a95..b1a52739d9e7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -33,6 +33,13 @@ OPT_FLAGS    ?=3D $(if $(RELEASE),-O2,-O0)
>  LIBELF_CFLAGS  :=3D $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS    :=3D $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || e=
cho -lelf)
>
> +ifeq ($(srctree),)
> +srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
> +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> +endif
> +
>  CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                                   =
 \
>           -Wall -Werror -fno-omit-frame-pointer                         \
>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
> @@ -55,6 +62,11 @@ progs/test_sk_lookup.c-CFLAGS :=3D -fno-strict-aliasin=
g
>  progs/timer_crash.c-CFLAGS :=3D -fno-strict-aliasing
>  progs/test_global_func9.c-CFLAGS :=3D -fno-strict-aliasing
>
> +# Some utility functions use LLVM libraries
> +jit_disasm_helpers.c-CFLAGS =3D $(LLVM_CFLAGS)
> +test_progs-LDLIBS =3D $(LLVM_LDLIBS)
> +test_progs-LDFLAGS =3D $(LLVM_LDFLAGS)
> +
>  ifneq ($(LLVM),)
>  # Silence some warnings when compiled with clang
>  CFLAGS +=3D -Wno-unused-command-line-argument
> @@ -164,6 +176,31 @@ endef
>
>  include ../lib.mk
>
> +NON_CHECK_FEAT_TARGETS :=3D clean docs-clean
> +CHECK_FEAT :=3D $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOA=
LS), "none"))
> +ifneq ($(CHECK_FEAT),)
> +FEATURE_USER :=3D .selftests
> +FEATURE_TESTS :=3D llvm
> +FEATURE_DISPLAY :=3D $(FEATURE_TESTS)
> +
> +# Makefile.feature expects OUTPUT to end with a slash
> +$(let OUTPUT,$(OUTPUT)/,\
> +       $(eval include ../../../build/Makefile.feature))
> +endif
> +
> +ifeq ($(feature-llvm),1)
> +  LLVM_CFLAGS  +=3D -DHAVE_LLVM_SUPPORT
> +  LLVM_CONFIG_LIB_COMPONENTS :=3D mcdisassembler all-targets
> +  # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conf=
lict
> +  LLVM_CFLAGS  +=3D $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --=
cflags))
> +  LLVM_LDLIBS  +=3D $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMP=
ONENTS))
> +  ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
> +    LLVM_LDLIBS +=3D $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_=
LIB_COMPONENTS))
> +    LLVM_LDLIBS +=3D -lstdc++
> +  endif
> +  LLVM_LDFLAGS +=3D $(shell $(LLVM_CONFIG) --ldflags)
> +endif
> +

Seems like we raced between me commenting on v1 and you posting v2 :(

But I just noticed that formatting seems off here. Can you please
check space vs tabs issues?

>  SCRATCH_DIR :=3D $(OUTPUT)/tools
>  BUILD_DIR :=3D $(SCRATCH_DIR)/build
>  INCLUDE_DIR :=3D $(SCRATCH_DIR)/include
> @@ -488,6 +525,7 @@ define DEFINE_TEST_RUNNER
>
>  TRUNNER_OUTPUT :=3D $(OUTPUT)$(if $2,/)$2
>  TRUNNER_BINARY :=3D $1$(if $2,-)$2
> +TRUNNER_BASE_NAME :=3D $1

[...]

