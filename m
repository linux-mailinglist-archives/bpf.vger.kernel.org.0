Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3639A98E
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 19:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFCRxQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Jun 2021 13:53:16 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:40836 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhFCRxQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Jun 2021 13:53:16 -0400
Received: by mail-yb1-f182.google.com with SMTP id e10so10014746ybb.7
        for <bpf@vger.kernel.org>; Thu, 03 Jun 2021 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cak9h6ceuUB+DR4AQXw0ZsMQ8v6Il/Kf7CNDtMUfk6I=;
        b=kaZb2nKd2lWe3rt2h/r6Og0xgtzfJ/irctzskvusGTlbOyQ7tJaHFv+aqx91DBzvkI
         7rloGSKfEyMvi49bbb3qyJN9oXHaq8eo/vN+uZRNlUUw9AYQ+rXaqMMLQQ+dr/LvfbyA
         4L4WozrquQWdpZmAgOFQmX/LbWKl1HWtFTUcK34cRNWk5nq1CUbOHvQI/a37D12cPrDv
         US1y73PFYruK6S3+GO5ol716aMj5IZ+Q17NxvxYFXIb9ZC/VfaxB3hO/MgF6+K0Bn8wT
         g/TDxYIXeAfrYRdwHfQUyswgYBdCRKk8e49OQ0Eok4xohstksq82b2d5MTZ34XVTs/Bn
         kQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cak9h6ceuUB+DR4AQXw0ZsMQ8v6Il/Kf7CNDtMUfk6I=;
        b=acVSDtYW+9v8vUMcln5hClsdZvM8jSrIJ4YfQmF0EGtXXKc8tyoU0s9LFr4SsmkHu8
         pUbH6Tx3iTD/lsE8+kJfIWVVuOoil9Zps28q9VI+JHHJR8RtT5wWUH5pfcssixelnIOH
         KGhi+CVEQfVscQv+L/nZo8vNy6ckn+z6g5ob01/2vsy2AzsW/CLo05mnLLQW1k0ayrev
         4akGLucQwpAMsHfSOsSOz3ydiCfa1NJ3jfcalaJjw6S3VSKiQU98Pk9TmE72hfRmtSdY
         uDZDk48aB5M5MtNMObtnLPcFvoOmkWHiERqGiRpZIJppPcRlJdu7CG7UAXx8nLbEyIMO
         5OEQ==
X-Gm-Message-State: AOAM532nNAOaKcro7v0McKOnrboQJVHUDqWdIpjw3/ADm1Vg7RBWf61C
        rC1Mwg2Fr5y91BrglAtMEitjrqDLFsHFh9CKdlU=
X-Google-Smtp-Source: ABdhPJyp12uQS+KzZIWDR3gtGq4qYehckeVTJ5TpvRzlYk+U8wwNbAqmD6gtpanEmyHHgoyMAbnP32LErHwNQBw9o2k=
X-Received: by 2002:a25:6612:: with SMTP id a18mr392511ybc.347.1622742618958;
 Thu, 03 Jun 2021 10:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210603170515.1854642-1-jean-philippe@linaro.org>
In-Reply-To: <20210603170515.1854642-1-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Jun 2021 10:50:08 -0700
Message-ID: <CAEf4BzZqNjBhMVk7T_XZt2NTtDsajECGmHX-n71GBRjK6TmSWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/bpftool: Fix cross-build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 3, 2021 at 10:06 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> When the bootstrap and final bpftool have different architectures, we
> need to build two distinct disasm.o objects. Add a recipe for the
> bootstrap disasm.o
>
> Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")

Did this commit break something specifically?

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/bpf/bpftool/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index d16d289ade7a..d73232be1e99 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -136,7 +136,7 @@ endif
>
>  BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
>
> -BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o) $(OUTPUT)disasm.o
> +BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
>  OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
>
>  VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)                           \
> @@ -180,6 +180,9 @@ endif
>
>  CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
>
> +$(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
> +       $(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD -o $@ $<
> +
>  $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c

maybe just do

$(BOOTSTRAP_OUTPUT)disasm.o $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c

?

>         $(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
>
> --
> 2.31.1
>
