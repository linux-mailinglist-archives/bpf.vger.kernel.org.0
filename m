Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91206477C50
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 20:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhLPTRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 14:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbhLPTRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 14:17:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6BEC061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 11:17:10 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id l22so51557417lfg.7
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 11:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CeAbDqQVJZTM66ES85ssc7ES4kZBm5FRz8B7DywloJM=;
        b=cgSRgD5OaZuIdQHRi+e9iJl7q/tVHZ57Aiq8kaW7oU4t59vV3SFFGs0eD7w91qjr7p
         nDB2IXbxJS4aBWHlR6S6GY331p5vxKfC5RNqpBJm58WX4PY/4cM+ZoE/Ep/aihJ2bZPO
         fw3pxy/Xbsz6hcjlS5Ao6Yd9qLHb37rpb/Lw2jHjocu2KvdNWDwXfQTl46VGr9kXfVjn
         a7Updw+c2G5XsT1rAxBbmyhCac9OD1OyQK1mHGJxX5h+cPshAjRL4WefvbqUJDR12TbW
         I2bRY+OIjM5Em5OP0H6rCcLhq0AFG/5pLvmqYD12598mhOlrX83juKNeXuI+R3kVE3XJ
         Av4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CeAbDqQVJZTM66ES85ssc7ES4kZBm5FRz8B7DywloJM=;
        b=eTUa+mmx0p14iGYsgeVGirupWVFa/0/BbtzOawXa1jRMtHb0te2aDSyEKn4b8htPUV
         360ECqNLcDXFxtCmJvmf01ryjTCZSAHw/BlHyu60mFdxlFCmCqY92XGotlJ7r+guY+Vi
         iSexvFbSqt3hN8oEcogPKB5ysjN3g4fr4BXJf2KTjHOD9jng1Ny4C+xJIS889QHpNZKN
         X8KuB4n2ohSEfhcVhi5oYGZde+JEWghXYEgkBlwYJTLzXynw6B2H4Jj3DHCrFw9kMv1e
         WWiI7RTV4xgHh4uf+PCYkk9r3QrMfEGBoFDb5fzj3+MssdOQqy73SMO1SIsd+LVt/PA6
         yItA==
X-Gm-Message-State: AOAM532J+tLH0D94E7ouu3MiUj163P11+0KZSnlAVJErq6aqBDX2lgj8
        ZVTkLoTdj2C7suANBltAJ50x0WJ+IM9m34hHDKSHQA==
X-Google-Smtp-Source: ABdhPJzQ7775nxrt1oIiY3S+R+5BbjqeTRLcI9Ct5YM1KdXk4rl0d0yKyysga4uDHO/bnJSEbiJZ8X4DkE0MUH9ALeY=
X-Received: by 2002:ac2:4db3:: with SMTP id h19mr5742153lfe.82.1639682228050;
 Thu, 16 Dec 2021 11:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20211216163842.829836-1-jean-philippe@linaro.org> <20211216163842.829836-2-jean-philippe@linaro.org>
In-Reply-To: <20211216163842.829836-2-jean-philippe@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 16 Dec 2021 11:16:56 -0800
Message-ID: <CAKwvOdmLYKV9UEg4_NV2EdPqF6VqboaY0gVDw1WEkmrvES8jvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] tools: Help cross-building with clang
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, nathan@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 8:50 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Cross-compilation with clang uses the -target parameter rather than a
> toolchain prefix. Just like the kernel Makefile, add that parameter to
> CFLAGS when CROSS_COMPILE is set.
>
> Unlike the kernel Makefile, we use the --sysroot and --gcc-toolchain
> options because unlike the kernel, tools require standard libraries.
> Commit c91d4e47e10e ("Makefile: Remove '--gcc-toolchain' flag") provides
> some background about --gcc-toolchain. Normally clang finds on its own
> the additional utilities and libraries that it needs (for example GNU ld
> or glibc). On some systems however, this autodetection doesn't work.
> There, our only recourse is asking GCC directly, and pass the result to
> --sysroot and --gcc-toolchain. Of course that only works when a cross
> GCC is available.
>
> Autodetection worked fine on Debian, but to use the aarch64-linux-gnu
> toolchain from Archlinux I needed both --sysroot (for crt1.o) and
> --gcc-toolchain (for crtbegin.o, -lgcc). The --prefix parameter wasn't
> needed there, but it might be useful on other distributions.
>
> Use the CLANG_CROSS_FLAGS variable instead of CLANG_FLAGS because it
> allows tools such as bpftool, that need to build both host and target
> binaries, to easily filter out the cross-build flags from CFLAGS.
>
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> Most tools I looked at needed additional changes to support cross-build
> with clang. I've only done the work for bpf tools.
> ---
>  tools/scripts/Makefile.include | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index 071312f5eb92..b0be5f40a3f1 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -87,7 +87,18 @@ LLVM_STRIP   ?= llvm-strip
>
>  ifeq ($(CC_NO_CLANG), 1)
>  EXTRA_WARNINGS += -Wstrict-aliasing=3
> -endif
> +
> +else ifneq ($(CROSS_COMPILE),)
> +CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
> +GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc))
> +ifneq ($(GCC_TOOLCHAIN_DIR),)
> +CLANG_CROSS_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
> +CLANG_CROSS_FLAGS += --sysroot=$(shell $(CROSS_COMPILE)gcc -print-sysroot)

^ this is a neat trick; it does rely on having $(CROSS_COMPILE)gcc
installed though. Technically only the header include path is needed
and the path to the cross libc shared object.  I think we should take
this patch&series as a starting point, but there might be future
revisions here to support environments that don't have
$(CROSS_COMPILE)gcc (such as Android's build env).

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the series!

> +CLANG_CROSS_FLAGS += --gcc-toolchain=$(realpath $(GCC_TOOLCHAIN_DIR)/..)
> +endif # GCC_TOOLCHAIN_DIR
> +CFLAGS += $(CLANG_CROSS_FLAGS)
> +AFLAGS += $(CLANG_CROSS_FLAGS)
> +endif # CROSS_COMPILE
>
>  # Hack to avoid type-punned warnings on old systems such as RHEL5:
>  # We should be changing CFLAGS and checking gcc version, but this
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
