Return-Path: <bpf+bounces-13944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC017DF272
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 13:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412FD281AD2
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F3C18E23;
	Thu,  2 Nov 2023 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKkPDNGw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF518E2D
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 12:30:48 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AFB18B;
	Thu,  2 Nov 2023 05:30:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40839807e82so5594685e9.0;
        Thu, 02 Nov 2023 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698928244; x=1699533044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ZqG4eXApU2XHK/8xC8VON8f1IHU1prc7SAhVA2sCKE=;
        b=MKkPDNGw7eEYiNg6WG7KibnuO0xxEtIxH5tIuzLRKQh8GFrKAyYwyOq8Vyhph3hLHR
         wfhtuA/G+pWDgABog9MawOBVW6WoduEGItdxAD+VEplwBVV9Ket3GTHe9lKKsOPzHLYe
         gaoL+Z9DbPtCNpMRtr2JlqFeaVGJFWJz4D6a0yCdGQYmCktnqfyQoJqyiQpn2yDe+g6Q
         FD0Gb5al+GcSJeNX3LJ99SGHcEsWx4NHmCApJaogFxvESTB2gh3kAT7srNRYTGjacyMu
         IoZOG0gXS5USMxdQNr3edUctwiXEuQ5mdmkMwhyQ0Pi9TFsakXT/Egz13957GtzXckj9
         7kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698928244; x=1699533044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZqG4eXApU2XHK/8xC8VON8f1IHU1prc7SAhVA2sCKE=;
        b=opUrei6cnSAUNpPg0ZccApaUMd5jJmRbQg/7BgXalN4evfVI1eKrFi/fXJZEk09Xbj
         PRR05/SPuee3FbnWVq3rX4TMXua1u99G/BsPcbGJwRV5w7V21UniK8fhs9qGLxs4GDlB
         i9A+TD0W9wJqT7b4zOlTnxHVgMRNV7bLuee3Wqf1G2oOrWEFbZvJYZZ8V9W4mH8JwzYu
         kbSc3YjzAjc474SoXQ378ZnXP9J8yeRAs5jQmTorzshJ7TkMkdWig8UNLPL6UQUUUwMU
         3V6GL5ibk/0JwueV30ZzN6FNOQCdm6tUk5b/TY5JYDk1FRzFRyp+CvTSEP4br2/a7nPf
         v90Q==
X-Gm-Message-State: AOJu0YwkyU/KMINOUhjXBZ1DSEEiJsWBhhbxu6JF9HxcYxzlFRf/LWnE
	cyK9KcZrfXMKKCA5eVqSZ71jm2ZR7qW1/g==
X-Google-Smtp-Source: AGHT+IF1JMuTcXHQV9/CxVeYbs66Idurde2ayMH9TFHtm2fwrzB74rfAHR3+dnuRM7ZrKFmvRxuQ3w==
X-Received: by 2002:a05:600c:2214:b0:408:33ba:569a with SMTP id z20-20020a05600c221400b0040833ba569amr6627963wml.8.1698928243923;
        Thu, 02 Nov 2023 05:30:43 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id fm15-20020a05600c0c0f00b003fee6e170f9sm2768435wmb.45.2023.11.02.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:30:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Nov 2023 13:30:41 +0100
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>, llvm@lists.linux.dev,
	Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v2] tools/build: Add clang cross-compilation flags to
 feature detection
Message-ID: <ZUOWcXDpCOzxbFW0@krava>
References: <20231102103252.247147-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231102103252.247147-1-bjorn@kernel.org>

On Thu, Nov 02, 2023 at 11:32:52AM +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> When a tool cross-build has LLVM=1 set, the clang cross-compilation
> flags are not passed to the feature detection build system. This
> results in the host's features are detected instead of the targets.
> 
> E.g, triggering a cross-build of bpftool:
> 
>   cd tools/bpf/bpftool
>   make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- LLVM=1
> 
> would report the host's, and not the target's features.
> 
> Correct the issue by passing the CLANG_CROSS_FLAGS variable to the
> feature detection makefile.
> 
> Fixes: cebdb7374577 ("tools: Help cross-building with clang")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/build/Makefile.feature |  2 +-
>  tools/build/feature/Makefile | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 934e2777a2db..25b009a6c05f 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -8,7 +8,7 @@ endif
>  
>  feature_check = $(eval $(feature_check_code))
>  define feature_check_code
> -  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)" CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
> +  feature-$(1) := $(shell $(MAKE) OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)" CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" CLANG_CROSS_FLAGS="$(CLANG_CROSS_FLAGS)" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
>  endef
>  
>  feature_set = $(eval $(feature_set_code))
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index dad79ede4e0a..c4458345e564 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -84,12 +84,12 @@ PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
>  
>  all: $(FILES)
>  
> -__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
> +__BUILD = $(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
>    BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
>    BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
>    BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd -lcap
>  
> -__BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
> +__BUILDXX = $(CXX) $(CXXFLAGS) $(CLANG_CROSS_FLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
>    BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
>  
>  ###############################
> @@ -259,10 +259,10 @@ $(OUTPUT)test-reallocarray.bin:
>  	$(BUILD)
>  
>  $(OUTPUT)test-libbfd-liberty.bin:
> -	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
> +	$(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty
>  
>  $(OUTPUT)test-libbfd-liberty-z.bin:
> -	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
> +	$(CC) $(CFLAGS) $(CLANG_CROSS_FLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
>  
>  $(OUTPUT)test-cplus-demangle.bin:
>  	$(BUILD) -liberty
> @@ -283,10 +283,10 @@ $(OUTPUT)test-libbabeltrace.bin:
>  	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
>  
>  $(OUTPUT)test-compile-32.bin:
> -	$(CC) -m32 -o $@ test-compile.c
> +	$(CC) $(CLANG_CROSS_FLAGS) -m32 -o $@ test-compile.c
>  
>  $(OUTPUT)test-compile-x32.bin:
> -	$(CC) -mx32 -o $@ test-compile.c
> +	$(CC) $(CLANG_CROSS_FLAGS) -mx32 -o $@ test-compile.c
>  
>  $(OUTPUT)test-zlib.bin:
>  	$(BUILD) -lz
> 
> base-commit: 21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
> -- 
> 2.40.1
> 

