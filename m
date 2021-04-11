Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB735B31D
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhDKKZI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 06:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhDKKZH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Apr 2021 06:25:07 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B542C061574
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 03:24:52 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f15so1644667iob.5
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rphTlXOqALXPKna3fvNrTY89WtlrF5oPY3OG8AKE0sA=;
        b=IvMBNodDuxLM5R3RXz/mYrcHKbM3rGXhBiGkgvJqTx18MA3xcTj97Z0o83Q2a5c3Pt
         zaySSYvU/oJBTvJMSP3Ql8HdsOpjIkyMYfZWTWB+j9T1j+9lE/9W4TRvcbwgTXOGBbpb
         lbuub29lc4G/BSA9w48pBjXR29W1kP3VUMIkzDF/DOVTeA/WRoTqYPYpIsMAHD9V4q7F
         NRwj82UxTCngI1L/VgRFRzfJ9blln6X9RtXUX+hKBERgUOKdWbQBCbzDcPI2PXml3R2x
         aawcCrZcLz8q+Xi/jSnmVPrmRWQCA6tGj3n5j3cG58rt5YdR3WxlOYfakRkwbUE0zc98
         ukuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rphTlXOqALXPKna3fvNrTY89WtlrF5oPY3OG8AKE0sA=;
        b=gl+wGAwvSjAwO5R0hAYhNJth5c66iWqIwQz/v93Yp0kNPHzRcZrYRNgSNVvQaW62M9
         wpJ00KX1CP+yLkyw6tLLEvRZsBj96cNBlLUGfVQTxOpdFQhmnweE2oa1TEE+h/icnO1D
         in7t5AuEwULf5EW5ZBiTJCI1BPljRUyNbjCahSkM+urjmNedfMd8Gaf0u2to6HGeioLe
         4K1yhOlgQ+6HqBlLfBbCJsHrUBZxMdrWHQmluef10JhnV9FA+mlYDV0vAGlC2OfdQII1
         2pJ3k6cBfyAc9Bphf5NQIb/s47yZZmt6662fyezIOWcMsvM9T1n0UCA+qFM/kgsgP2de
         gX8A==
X-Gm-Message-State: AOAM5314yGqjTOSwoLzUGTcR2bmZuoDM8p0wwNHE4ixb/RAfB9Ojtn8I
        swJvO9SEJqySf3wJSD2HTm/fXhjUwPdGUhj0FIA=
X-Google-Smtp-Source: ABdhPJwxbI3uVw0ylFqYuhPe7v9SOSPU6C/Abclw3DowoVHb8hm0JmPLdQiy2wNYRGgsBjTnJnDHGOGBkiA0A7/lkxM=
X-Received: by 2002:a6b:8d88:: with SMTP id p130mr1127319iod.75.1618136691505;
 Sun, 11 Apr 2021 03:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164935.769789-1-yhs@fb.com>
In-Reply-To: <20210410164935.769789-1-yhs@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 11 Apr 2021 12:24:15 +0200
Message-ID: <CA+icZUVztyjfRrN1HweGPz6ASjVAEs7cSf72-Fbjm2H4FQBZ0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] tools: allow proper CC/CXX/... override with
 LLVM=1 in Makefile.include
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>
> selftests/bpf/Makefile includes tools/scripts/Makefile.include.
> With the following command
>   make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1 V=1
> some files are still compiled with gcc. This patch
> fixed the case if CC/AR/LD/CXX/STRIP is allowed to be
> overridden, it will be written to clang/llvm-ar/..., instead of
> gcc binaries. The definition of CC_NO_CLANG is also relocated
> to the place after the above CC is defined.
>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/scripts/Makefile.include | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index a402f32a145c..91130648d8e6 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -39,8 +39,6 @@ EXTRA_WARNINGS += -Wundef
>  EXTRA_WARNINGS += -Wwrite-strings
>  EXTRA_WARNINGS += -Wformat
>
> -CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
> -
>  # Makefiles suck: This macro sets a default value of $(2) for the
>  # variable named by $(1), unless the variable has been set by
>  # environment or command line. This is necessary for CC and AR
> @@ -52,12 +50,22 @@ define allow-override
>      $(eval $(1) = $(2)))
>  endef
>
> +ifneq ($(LLVM),)
> +$(call allow-override,CC,clang)
> +$(call allow-override,AR,llvm-ar)
> +$(call allow-override,LD,ld.lld)
> +$(call allow-override,CXX,clang++)
> +$(call allow-override,STRIP,llvm-strip)

Use here $(CROSS_COMPILE) prefix like below for people using an LLVM
cross-toolchain?

- Sedat -

> +else
>  # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
>  $(call allow-override,CC,$(CROSS_COMPILE)gcc)
>  $(call allow-override,AR,$(CROSS_COMPILE)ar)
>  $(call allow-override,LD,$(CROSS_COMPILE)ld)
>  $(call allow-override,CXX,$(CROSS_COMPILE)g++)
>  $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
> +endif
> +
> +CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
>
>  ifneq ($(LLVM),)
>  HOSTAR  ?= llvm-ar
> --
> 2.30.2
>
