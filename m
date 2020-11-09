Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC12AC5E7
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 21:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKIUXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 15:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgKIUXk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 15:23:40 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F49C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Nov 2020 12:23:40 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id c129so9437848yba.8
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXYuqbSb0umHjf/25ks2osRNJJwJ1GZalx75rhC58a4=;
        b=CdOi5J6QPaaxMvvUpeMtW7AR+nCbkvM9LyD8XiTejgNzXXIf0CdTU+8cSjHAbiTlaX
         cGwwBSNaAU+pNlRc8kUVdWGWewf4p67SPaLfnzEJfa1V5mPFiOJoUKD+vVWH5IXzh0rb
         wbZN22T5ZsHeJVRNIPOIOG0/BZabYQWfRQlqm3hj2EkYkkzMpv1QSZ3Olkia713GEoH2
         RKpIAYHyE7Qrmcrzh8m8quUiboDcdIaag6qHTNzmvkanUbGgP3GNiWN3sSwfVWoE6ViK
         3Mb9Ai9Gh+n9ma9eO8IpzdTJtMEu4EsNUZ+jAWOTnC0awCqH5GEeW2y7vp2bF0bI2jfL
         NlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXYuqbSb0umHjf/25ks2osRNJJwJ1GZalx75rhC58a4=;
        b=dBRwM+2rDMjzuYucUcKxaN7ZLjXLpiciLHiYREzRhqvvdv8Wc7OQwQ9Z0lk34hVOey
         NRUhtRxG2MU1mrDoXzmk3cF3k4Oj9CsIqUkoJ8Ba/Ya6YPJctZuEfDWmwkJa7SXjZYO8
         7aUnsbdhroNi11mVzinnC61cmmQdiRE6RK0Ni+KGKrGRTtXpDdxkxc+K5CVvCXW2jTEJ
         taxNeAflg/XfM2gVgdfT5g3nUJLWBHpTfia5M0ScWbOg5JLh1wV4LoZ9tctgPvCr7txq
         E8R/kB9RZ+EgIiIPte/T5FxFOJPaWOHOPOsf15HPLQsSHulvyROLGuX8P77mM68urhRm
         1OcA==
X-Gm-Message-State: AOAM533TfRjrc1rMdqY4wfvqMRYlTPc+BICGiOlXmuw7QmQAA8qvmixB
        8pccBg2OA7gh7mpOPba93+PlyWSb75jXIZegDaq7Ubq27Co=
X-Google-Smtp-Source: ABdhPJxCsE+o+ljhhFhLwISH1L8p/zq1qqv7otU0h51ks2/RbYeyThX0I3nZw6yyvYXUrmNDK5oDMgHOopxebu1rU9E=
X-Received: by 2002:a05:6902:72e:: with SMTP id l14mr19513640ybt.230.1604953419267;
 Mon, 09 Nov 2020 12:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20201109110929.1223538-1-jean-philippe@linaro.org> <20201109110929.1223538-6-jean-philippe@linaro.org>
In-Reply-To: <20201109110929.1223538-6-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Nov 2020 12:23:28 -0800
Message-ID: <CAEf4BzbdnJPr0FjdQmzNEYmUj8fTwVGu6ihqRB44L8ZS7FLVug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] tools/runqslower: Enable out-of-tree build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 9, 2020 at 3:11 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Enable out-of-tree build for runqslower. Only set OUTPUT=.output if it
> wasn't already set by the user.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/bpf/runqslower/Makefile | 45 +++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
> index bcc4a7396713..861f4dcde960 100644
> --- a/tools/bpf/runqslower/Makefile
> +++ b/tools/bpf/runqslower/Makefile
> @@ -1,15 +1,20 @@
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  include ../../scripts/Makefile.include
>
> -OUTPUT := .output
> +ifeq ($(OUTPUT),)
> +  OUTPUT = $(abspath .output)/
> +endif

OUTPUT ?= .. didn't work?

> +
>  CLANG ?= clang
>  LLC ?= llc
>  LLVM_STRIP ?= llvm-strip
> -DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
> +BPFTOOL_OUTPUT := $(OUTPUT)bpftool/
> +DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)bpftool
>  BPFTOOL ?= $(DEFAULT_BPFTOOL)
>  LIBBPF_SRC := $(abspath ../../lib/bpf)
> -BPFOBJ := $(OUTPUT)/libbpf.a
> -BPF_INCLUDE := $(OUTPUT)
> +BPFOBJ_OUTPUT := $(OUTPUT)libbpf/
> +BPFOBJ := $(BPFOBJ_OUTPUT)libbpf.a
> +BPF_INCLUDE := $(BPFOBJ_OUTPUT)
>  INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../lib)        \
>         -I$(abspath ../../include/uapi)
>  CFLAGS := -g -Wall
> @@ -20,7 +25,6 @@ VMLINUX_BTF_PATHS := /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_REL)
>  VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword                           \
>                                           $(wildcard $(VMLINUX_BTF_PATHS))))
>
> -abs_out := $(abspath $(OUTPUT))
>  ifeq ($(V),1)
>  Q =
>  else
> @@ -36,9 +40,13 @@ all: runqslower
>
>  runqslower: $(OUTPUT)/runqslower
>
> -clean:
> +clean: $(DEFAULT_BPFTOOL)-clean $(BPFOBJ)-clean

why separate targets for $(DEFAULT_BPFTOOL)-clean and $(BPFOBJ)-clean?
Are they intended to be called separately? I don't think
parallelization is that important for the clean up. Let's just keep
all the cleaning in one place, not spreading it across Makefile?

>         $(call QUIET_CLEAN, runqslower)
> -       $(Q)rm -rf $(OUTPUT) runqslower
> +       $(Q)$(RM) -r $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT)
> +       $(Q)$(RM) $(OUTPUT)*.o $(OUTPUT)*.d
> +       $(Q)$(RM) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
> +       $(Q)$(RM) $(OUTPUT)runqslower
> +       $(Q)$(RM) -r .output
>

[...]
