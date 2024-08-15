Return-Path: <bpf+bounces-37301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAEC953C52
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1731C21C6E
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FAD14F102;
	Thu, 15 Aug 2024 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2bgDAAZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4992814D6EE
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756025; cv=none; b=iIaQ+oqnNeQMVJz3tgq5OzRxRN2GQ6wqqsxsKCLjJxsMf5lWzEDM44qJLYyfsmLoE7LsdTgF+7Htom5+0oJ0KxydvdikgFcoTvxiWFrhnnrdj+deoSFQhLnJL2TVT7T1UPpEwAMkLpesTcrykQVVmycW8YPXQiVEjVQanaICkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756025; c=relaxed/simple;
	bh=UVj4pghlIhC4NDmJvho0LgSI+JNI5ot6nF25j1mfq3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbYwyLfEQ7BI4lLZFtYvuqZZO5K+U40xrtmelQSD2iFEavcalSiCvaAqFSE5ETiuyFo016uerqan5kq9ovWlUa9AYTP9Q2avc0LhQdFsxuITlxF/3pfZ16dZy3tQfZgQQGnRVkei5D7oExLZksaooUoyZFCkH9wHoyzjWmG49to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2bgDAAZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d28023accso1108610b3a.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723756022; x=1724360822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU2q/0ZYzW+TiAAQubm11O0aAniWYlyS446+Vk2qMcs=;
        b=m2bgDAAZDabDYLoJ+vBP+IKHWAX5+Qpbez5oCebcHLJfmqAW05noI0owpyiR42OuDC
         seZHZNQpP3eT+o12S99D6NHND0iLByqKHUrYYqP1IZyYImIJjK3THWJfw5LQqWw58XZ7
         W8muNMy4rditfDFOTlOADfPXmVIReAF6B7CrprhdNEUr42YuCFWPHTYXHpIbDXpCu0CE
         jVy08xDyIIGU8KbC7EHuAyGdl+tSN+9gNGwtG6S4RaGq2UTliuZLswG2ANQjM3d0XxCJ
         qwh2C5RPgwLbiwNzXluke6wRAFE/tBbyi/mZnR99zVIFyhTeNa3BG6O611GejNkEEa3h
         eGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756022; x=1724360822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU2q/0ZYzW+TiAAQubm11O0aAniWYlyS446+Vk2qMcs=;
        b=V5+5vAeDvLnlAnXHSkLzJX87/OgC9aTDspZEtKW4q/2OA2IvUGr3rC9KUcjsGZx6Yw
         yVXCqONp2JXaV9W2ra3miUohv61wcC5ap5pt9qnTHGpRAzyfhzoWbBltUjeoxbPlh7Z9
         eXEWehPWEPl7ByWLTuuIv/T5WasY8uBkUpnkQI9oGxQt/k3ejGqlmeqUqx3QT7U+0Zeb
         Ipy9r3sQi0YJXXK1nZ0BtKbrh9KMCE5HHWENR0OyX2dRYMTbOVD6LZx39TrhqLC7kmMm
         KnIGglD1MV/piVzLIRAdDehwT/V1ytVgaRL/U4E3kkU4DoGkbipNQowNg7UYUjqEqdYb
         SQHg==
X-Gm-Message-State: AOJu0YzsmYJ/c2CxbF6huyr1vwhm7+/IxGAa09YT8m6ly9QUV0V4eV4W
	C84trsX57r9FNWzEsGUVoAN/Wdem6AokObW3KSCE0+u5AwWVjaXMfBRllyp/wpIFAFfqNNyDLrN
	mHU5dCN8uxItciyE429SQPzgfXt4=
X-Google-Smtp-Source: AGHT+IFRodCW82IchxMnQiLeM4MZGNl7maFrNIAZD2b59cCQFBf1ktCYiJJRoJQzOIJAIXDHEbO3TqsiEG2ED/+xEdI=
X-Received: by 2002:a05:6a20:d498:b0:1c6:ed3e:3e24 with SMTP id
 adf61e73a8af0-1c904f8ffabmr1343777637.19.1723756022332; Thu, 15 Aug 2024
 14:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809010518.1137758-1-eddyz87@gmail.com> <20240809010518.1137758-3-eddyz87@gmail.com>
In-Reply-To: <20240809010518.1137758-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 14:06:50 -0700
Message-ID: <CAEf4Bzatz89TPfCtK5i2UmCsc7D8Dx=udjQqe52-WzRH+DDC1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: utility function to get
 program disassembly after jit
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, hffilwlqm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
>     int get_jited_program_text(int fd, char *text, size_t text_sz)
>
> Loads and disassembles jited instructions for program pointed to by fd.
> Much like 'bpftool prog dump jited ...'.
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
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |  51 +++-
>  .../selftests/bpf/jit_disasm_helpers.c        | 228 ++++++++++++++++++
>  .../selftests/bpf/jit_disasm_helpers.h        |  10 +
>  4 files changed, 288 insertions(+), 2 deletions(-)
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
>  SCRATCH_DIR :=3D $(OUTPUT)/tools
>  BUILD_DIR :=3D $(SCRATCH_DIR)/build
>  INCLUDE_DIR :=3D $(SCRATCH_DIR)/include
> @@ -488,6 +525,7 @@ define DEFINE_TEST_RUNNER
>
>  TRUNNER_OUTPUT :=3D $(OUTPUT)$(if $2,/)$2
>  TRUNNER_BINARY :=3D $1$(if $2,-)$2
> +TRUNNER_BASE_NAME :=3D $1
>  TRUNNER_TEST_OBJS :=3D $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,     =
 \
>                                  $$(notdir $$(wildcard $(TRUNNER_TESTS_DI=
R)/*.c)))
>  TRUNNER_EXTRA_OBJS :=3D $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,         =
 \
> @@ -611,6 +649,10 @@ ifeq ($(filter clean docs-clean,$(MAKECMDGOALS)),)
>  include $(wildcard $(TRUNNER_TEST_OBJS:.o=3D.d))
>  endif
>
> +# add per extra obj CFGLAGS definitions
> +$(foreach N,$(patsubst $(TRUNNER_OUTPUT)/%.o,%,$(TRUNNER_EXTRA_OBJS)), \
> +       $(eval $(TRUNNER_OUTPUT)/$(N).o: CFLAGS +=3D $($(N).c-CFLAGS)))
> +
>  $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:                          \
>                        %.c                                              \
>                        $(TRUNNER_EXTRA_HDRS)                            \
> @@ -627,6 +669,9 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
>         $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
>  endif
>
> +$(OUTPUT)/$(TRUNNER_BINARY): LDLIBS +=3D $$($(TRUNNER_BASE_NAME)-LDLIBS)
> +$(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS +=3D $$($(TRUNNER_BASE_NAME)-LDFLAG=
S)

is there any reason why you need to have this blah-LDFLAGS convention
and then applying that with extra pass, instead of just writing

$(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS +=3D $(LLVM_LDFLAGS)

I'm not sure I understand the need for extra logical hops to do this

> +
>  # some X.test.o files have runtime dependencies on Y.bpf.o files
>  $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
>
> @@ -636,7 +681,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)    =
               \
>                              $(TRUNNER_BPFTOOL)                         \
>                              | $(TRUNNER_BINARY)-extras
>         $$(call msg,BINARY,,$$@)
> -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> +       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LDFLAG=
S) -o $$@
>         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpft=
ool \
>                    $(OUTPUT)/$(if $2,$2/)bpftool
> @@ -655,6 +700,7 @@ TRUNNER_EXTRA_SOURCES :=3D test_progs.c              =
 \
>                          cap_helpers.c          \
>                          unpriv_helpers.c       \
>                          netlink_helpers.c      \
> +                        jit_disasm_helpers.c   \
>                          test_loader.c          \
>                          xsk.c                  \
>                          disasm.c               \
> @@ -797,7 +843,8 @@ EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)  =
                 \
>         $(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h   \
>                                no_alu32 cpuv4 bpf_gcc bpf_testmod.ko    \
>                                bpf_test_no_cfi.ko                       \
> -                              liburandom_read.so)
> +                              liburandom_read.so)                      \
> +       $(OUTPUT)/FEATURE-DUMP.selftests
>
>  .PHONY: docs docs-clean

[...]

