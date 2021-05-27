Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A511F3935C1
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 20:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhE0TAy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 15:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhE0TAy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 15:00:54 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4FC061574;
        Thu, 27 May 2021 11:59:20 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z38so2125121ybh.5;
        Thu, 27 May 2021 11:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8n60UirrOu7zWtXoi//ILGQaJH0mhZHxjrkUjLqafa4=;
        b=MBOr37VjHcCA/2yTcayx4gKJoFF1y2Hn8H6Vx1S63gQ1mmgVdVmTvdsuCO5roiqAXR
         cggsRxzqhpl/9T8otLvCcD61P3Yh1IKYlW4esJLUs8+gipGMoWvH9BoFjQz18rDedrv4
         gi0EOyeH7E/SW6drSTy/51TJner0qKFM9qKCoVZV1l15RGpQR+h6eDbnA+n8TVmcbZ02
         b649b97frl2gfvisBAiK/x4kDEChVaY31VgBxacI/fo6iqkCY8gCyFMCCgxRnrndcLU3
         DQeiOHFffkvjGgDKXDZpcgBMEl9b+mS7JbmhnjsPmOvhE/zMacJZ0RFJlhHchjf0G/Kk
         P4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8n60UirrOu7zWtXoi//ILGQaJH0mhZHxjrkUjLqafa4=;
        b=m6M7LvApWLpe3AkXwPFTRIoE/36ss7VhHlQg5VjhWXx58xFryW4NftJ67PsKbd6gpC
         DRHy41ym1yYmkNLnGuZ8cR5bfr6DAwMt/MFDbh11VNJk9S+0rDBG9j7HWManzQtmrLbM
         OKmOnRJehuCkdbcqafdXZUu6/EVfYNxNgtmBDCWsurA7SHvkTzQ6AljghaxKfzomXV1P
         WX48cy6+OifBv2MDm5XzwoskLKWT95fPkTvx21rLVLXNMK6RAC6T9g5YCFcKz48TrEv1
         Xh7J0xvtyf0omN5M6aPA/6K6GxW+KdCZuCxalPtwLi+bg43e5HBkxioGaFRMkyESNjXj
         aFNQ==
X-Gm-Message-State: AOAM532VxQRXAltaGGJ0p/6onxhSv33uKaQ4BbKPD8xJHk7QcBip0w5M
        MR0fIWuLGjIGP+1U6raPQrsfPCSNKHH1nOGOEIeFCr9wzDLRKQ==
X-Google-Smtp-Source: ABdhPJxMr+KyTX0ZsjMwftn5QpUJN3W3Kr1/GkjwNzIV/I25DLkDjCpIOZ5KO+4s5lkTVCjQax1jhcEP9PfXRrnDK1I=
X-Received: by 2002:a25:9942:: with SMTP id n2mr7261704ybo.230.1622141959752;
 Thu, 27 May 2021 11:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210526215228.3729875-1-javierm@redhat.com>
In-Reply-To: <20210526215228.3729875-1-javierm@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 May 2021 11:59:08 -0700
Message-ID: <CAEf4BzYfvJ0dc-VojXOGBWVx1WOW2hoRQ91=c0LpVm-7K9MdeQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: quote OBJCOPY var to avoid a pahole call break
 the build
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 2:52 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The ccache tool can be used to speed up cross-compilation, by calling the
> compiler and binutils through ccache. For example, following should work:
>
>     $ export ARCH=arm64 CROSS_COMPILE="ccache aarch64-linux-gnu-"
>
>     $ make M=drivers/gpu/drm/rockchip/
>
> but pahole fails to extract the BTF info from DWARF, breaking the build:
>
>       CC [M]  drivers/gpu/drm/rockchip//rockchipdrm.mod.o
>       LD [M]  drivers/gpu/drm/rockchip//rockchipdrm.ko
>       BTF [M] drivers/gpu/drm/rockchip//rockchipdrm.ko
>     aarch64-linux-gnu-objcopy: invalid option -- 'J'
>     Usage: aarch64-linux-gnu-objcopy [option(s)] in-file [out-file]
>      Copies a binary file, possibly transforming it in the process
>     ...
>     make[1]: *** [scripts/Makefile.modpost:156: __modpost] Error 2
>     make: *** [Makefile:1866: modules] Error 2
>
> this fails because OBJCOPY is set to "ccache aarch64-linux-gnu-copy" and
> later pahole is executed with the following command line:
>
>     LLVM_OBJCOPY=$(OBJCOPY) $(PAHOLE) -J --btf_base vmlinux $@
>
> which gets expanded to:
>
>     LLVM_OBJCOPY=ccache aarch64-linux-gnu-objcopy pahole -J ...
>
> instead of:
>
>     LLVM_OBJCOPY="ccache aarch64-linux-gnu-objcopy" pahole -J ...
>
> Fixes: 5f9ae91f7c0 ("kbuild: Build kernel module BTFs if BTF is enabled and pahole supports it")

I replaced 5f9ae91f7c0 with 5f9ae91f7c0d to have a recommended 12
characters hash. Applied to bpf tree, thanks.

> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>
> Changes in v2:
> - Add collected Acked-by tags.
> - Also quote on a similar assignment in scripts/link-vmlinux.sh (masahiroy)
>
>  scripts/Makefile.modfinal | 2 +-
>  scripts/link-vmlinux.sh   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index dd87cea9fba..a7883e45529 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -59,7 +59,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>  quiet_cmd_btf_ko = BTF [M] $@
>        cmd_btf_ko =                                                     \
>         if [ -f vmlinux ]; then                                         \
> -               LLVM_OBJCOPY=$(OBJCOPY) $(PAHOLE) -J --btf_base vmlinux $@; \
> +               LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J --btf_base vmlinux $@; \
>         else                                                            \
>                 printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
>         fi;
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index f4de4c97015..0e0f6466b18 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -240,7 +240,7 @@ gen_btf()
>         fi
>
>         info "BTF" ${2}
> -       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${extra_paholeopt} ${1}
> +       LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${extra_paholeopt} ${1}
>
>         # Create ${2} which contains just .BTF section but no symbols. Add
>         # SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
> --
> 2.31.1
>
