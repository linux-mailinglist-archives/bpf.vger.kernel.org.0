Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66B4152088
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2020 19:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgBDSnT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Feb 2020 13:43:19 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34723 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgBDSnT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Feb 2020 13:43:19 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so9071823qvf.1
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2020 10:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPTUb+XuWTjEhi36AOz83oooxGPzo0YJ4+bTw4+rkm8=;
        b=K/Ql6pAXJBx2pFn6DVBQMBpGj4RI1P5q5hNcZFe98Jj0AC2gBoDxT5Jtzj8h0A4Fwz
         H9sfFJ6r+ZErjiuUKJfoW4tvLli77wREFERhPbz1GjOnipn+KdE+jiRg3hkhjbtoRw49
         vD1qscYwzpK+6HhempH79il0fxvvRCoxzT2T5ERgy5uFU78ztfDRsCjv8FgBoZeb36M3
         CARPDaUxJmksXq1rnszobnA/PYo1iG7VWGIrH+5Uz0G/4UvDweHZ708MFQVQEgDd3S8n
         i7C6qafxTAfJ4EzAeWO0Y6OTDps4uKzruzLq/ASC3NQRHf7F1QEggdry5SKyG6+T8j1i
         9Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPTUb+XuWTjEhi36AOz83oooxGPzo0YJ4+bTw4+rkm8=;
        b=sovW0rWBVRfjhLh7P8tkuRMPXCwGmU40SYxlW25z3ZyqoNHdrYMctFE9HLcgGE8NNX
         LUj6Lr3dRapLIQnFUjt6hJ4tghyqcgsgmklrFQeu/0P7VTFicxlKJdeAKJGUjbwN2SMW
         QAsOxqzzvl5lpXkn0cZgPeZ5MQzhzn5o1WamcsESuqvkg4F3o0LTY9WZ4Q4Y2wneMaLC
         kvHGYd0qXs864AwzjRFFm7QRV7nBIbIB35Vz6AJub2y3F3c4G8MhxQM2SXK8REN1FbtK
         IabZsy2fRRUo9D3G/cgINDJNIvj+IsBSDa24eVqztAYMq4Jen06pLJs4m22+O75TbgsN
         8E+A==
X-Gm-Message-State: APjAAAV30ckhQKDKOeCr2cnnlub1zWlG1hHsx1uQ+YYDa3fNfOLCXHrz
        Qj1JW1zmDY5ksqdT3I+ZniVlHTnworkZ6H5vHd37Eg==
X-Google-Smtp-Source: APXvYqxim7O0RM1XyNZs7fGPCDpm05ZSjxCaD0v8zOlBr7BJvh25U6aQ+J0iCIt9vTmjlPeqFjMzeC9fd/DDPEfIwbE=
X-Received: by 2002:a05:6214:8cb:: with SMTP id da11mr27650663qvb.228.1580841798363;
 Tue, 04 Feb 2020 10:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20200204175303.1423782-1-songliubraving@fb.com>
In-Reply-To: <20200204175303.1423782-1-songliubraving@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 Feb 2020 10:43:07 -0800
Message-ID: <CAEf4BzabT41Ls3CLmv9Vb-X_5NLwbMiQLLiNoK34svjKt4BxfA@mail.gmail.com>
Subject: Re: [PATCH] tools/bpf/runqslower: Rebuild libbpf.a on libbpf source change
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 4, 2020 at 9:54 AM Song Liu <songliubraving@fb.com> wrote:
>
> Add missing dependency of $(BPFOBJ) to $(LIBBPF_SRC), so that running make
> in runqslower/ will rebuild libbpf.a when there is change in libbpf/.
>
> Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
> Cc: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/bpf/runqslower/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
> index 87eae5be9bcd..ea89fcb6d68f 100644
> --- a/tools/bpf/runqslower/Makefile
> +++ b/tools/bpf/runqslower/Makefile
> @@ -75,7 +75,7 @@ $(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
>         fi
>         $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
>
> -$(BPFOBJ): | $(OUTPUT)
> +$(BPFOBJ): $(LIBBPF_SRC) | $(OUTPUT)

Let's instead update this rule to do what selftests/bpf do (watch *.c,
*.h and Makefile, and use all + install_headers to build libbpf and
generate bpf_helper_defs.h?

Please also specify (in subject) which tree (bpf or bpf-next) you are targeting.

>         $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)                         \
>                     OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
>
> --
> 2.17.1
>
