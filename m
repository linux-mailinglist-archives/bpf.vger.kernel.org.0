Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB5E553E
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 22:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfJYUgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 16:36:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43033 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfJYUgp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 16:36:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id a194so2977354qkg.10
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 13:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NyhIbt74T865zG2a77zG8L2sey7fcgBlOoHBCyVjNw=;
        b=J/6fbXWgjMgXPdu7+YOXIqtKJsDT1lveVcaQ4t527Nba4lr7bhtUS5MlfvFVunW1Az
         JjLmLndTM4XHy049eZLNvwigpDiy4o1wBH0Nx4/R40NgwzcUbW6HaSymGyukqXNVnFre
         l9yyy2uEqhCWvrtbPliHpLiOheL24EtuKV8YK/ENm44lz6CnDZX0D1iYNWGiqnxppVwb
         jjM8gaI5A3htids7HpaI1pGkR+VaAP/RRLyl5WZPRIe++9mK4csOy3saFg1rVZGwboLb
         c/FSJ5pJjZr0C6NNJhKqUvSWoereOnzAtcMfX58D0Zt4msNqROuizDJnrEHU80+czqT1
         wsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NyhIbt74T865zG2a77zG8L2sey7fcgBlOoHBCyVjNw=;
        b=jyX0jW+FDrIGCnz7nTLp+LFzYDP2tL9kqwdKl7PPLns/EkI7zJ69KDIe1H0velXykD
         mGGoo6wHuPzfnSTEhdxJeQ1faAuMBIM6VyHMuZ3gWx/Ki7q+jqtF7/EcwfZrIBHd4LTo
         Nojm2M30DEPVH/41cv6+flDz30YceOUcnOCFfyjOMnjeSqQLSUBg8rRIoclzQ4IWHsgS
         2LTUXWQn9F5A52HGSU9E7XJl46N8ReVbHj61lyWSZGvCsX3jHwZpWGemSLGZuQUoYYih
         9I9yPqV7xIwzdWvwHz4Mr2h5aKrNvsktZPAmQ+iLeWOOcz0UPt/+JuJETprXtiM2XtOp
         3LDA==
X-Gm-Message-State: APjAAAWe9Qrl1Xrm/VWzza3GSocjEMRYxRo+04dXHLoW3BE047ME+Ahd
        gvPVpM1aBCIyfTzNhLm4NPnAr/IqZ8rz049ncwo=
X-Google-Smtp-Source: APXvYqyVWRiZ8yAZPsTsrH+J53hU1jXLb+SnxDDbmCBClH59Z2DlTwMiQoRb1evpt+akN2cRC5nQVrUlh3ceBFXIowQ=
X-Received: by 2002:a37:9a8a:: with SMTP id c132mr4780205qke.92.1572035802405;
 Fri, 25 Oct 2019 13:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191024184226.1851-1-iii@linux.ibm.com>
In-Reply-To: <20191024184226.1851-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 25 Oct 2019 13:36:31 -0700
Message-ID: <CAEf4BzYpkZRuM_srs6KwiDpJ8Z-saic22ha-7v+QxC50OsDK+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftest/bpf: Use -m{little,big}-endian for clang
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 25, 2019 at 11:51 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> When cross-compiling tests from x86 to s390, the resulting BPF objects
> fail to load due to endianness mismatch.
>
> Fix by using BPF-GCC endianness check for clang as well.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 11ff34e7311b..59b93a5667c8 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -131,10 +131,16 @@ $(shell $(1) -v -E - </dev/null 2>&1 \
>         | sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }')
>  endef
>
> +# Determine target endianness.
> +IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
> +                       grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
> +MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
> +
>  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
>  BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)                             \
>              -I. -I./include/uapi -I$(APIDIR)                           \
> -            -I$(BPFDIR) -I$(abspath $(OUTPUT)/../usr/include)
> +            -I$(BPFDIR) -I$(abspath $(OUTPUT)/../usr/include)          \
> +            $(MENDIAN)

minor nit: I'd put $(MENDIAN) next to -g and -D__TARGET_ARCH stuff and
keep a list of -Is at the end.

But besides that:

Acked-by: Andrii Nakryiko <andriin@fb.com>

>
>  CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
>                -Wno-compare-distinct-pointer-types
> @@ -271,12 +277,8 @@ $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
>
>  # Define test_progs BPF-GCC-flavored test runner.
>  ifneq ($(BPF_GCC),)
> -IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
> -                       grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
> -MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
> -
>  TRUNNER_BPF_BUILD_RULE := GCC_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(call get_sys_includes,gcc) $(MENDIAN)
> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(call get_sys_includes,gcc)
>  TRUNNER_BPF_LDFLAGS :=
>  $(eval $(call DEFINE_TEST_RUNNER,test_progs,bpf_gcc))
>  endif
> --
> 2.23.0
>
