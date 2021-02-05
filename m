Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6831137B
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhBEV1S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 16:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhBEPBT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 10:01:19 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5521DC06178A;
        Fri,  5 Feb 2021 08:39:19 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id f6so7745141ioz.5;
        Fri, 05 Feb 2021 08:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SnNRtmhDAWSQM3xrLpXKWdGaXUIh2OW900Y2bpJfut4=;
        b=UY+PP84lCjsq45pPZGTUbH/YMfxSh9MqVOhpE/CKzaNDLv5xv2637woN5szF4JiPTN
         3LfdNqlzQq/aKFqaExW1VXy1wuw1ASiFwibgnc7FIwRMAYgD5YKYJnoQKmXHn3bjbaDo
         9q6pQzX/v5wt5JBA/SnqZ8y08l87UNeGO5UzDK4hAe+CX65+KXlIID0Vh05QfPv2rjbY
         Sw00FX549xWGt4WrmESzg09ikDZGXDR7QQWmYLOouF/xML46U0JX1/HHDKR2Gv0cnLzf
         bmNJ7SJ4YjKuhQaTm8MJgnkEUojIrN5/PNtMtfuds/lNgaRt4y8pfZvd9aZOLEutWZis
         tyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SnNRtmhDAWSQM3xrLpXKWdGaXUIh2OW900Y2bpJfut4=;
        b=dKmGzU2yCJp/TKjV4Hf15l+ggDDK6pQ5ZC0KpeM/wFiuuG2MQjpna1A3GQcrHCuVLq
         FTGzOp0F2q9LuUI3CxfOiQ+b9Xh51X5odEJ8jEDImvAMTLdM63kvI0WnFZ0+zmrTZNf1
         JH0fGLhOOo9bndFDbVAJ2BSO/quIbEQExHpS5R1hwrjurTP9aDpo7hO5lT6MgNPyLou4
         Y1wL0k/ClulG7shtb3TB/XVe5EVvovosVvDteSMn4XWPQrKTsPJj1/CdClzusow6YeVc
         CSNaqoM7iu/qRUU5c892puHtDAkuJRHcnIhh0+ytB+sKBzgootSwwzDD7Ai1Yhyx72SI
         1gKA==
X-Gm-Message-State: AOAM530gn8isQYH+2tB+u+Ce/wrh9K3+9wDykULsyP2X7k1uxCO8nBEG
        QstuX9zwk3trUEwuMEdJMwpw2XtlYEBPikUSyID/20NRyJvDIZme
X-Google-Smtp-Source: ABdhPJziPeDiEUXX5CJ/NNYEkGfmB66ge2x81u7NsGb7H/+nHMpmEQPx6GcwBDMycSMWACOFlUIz3pRSsmzHpgomQl4=
X-Received: by 2002:a05:6e02:d0:: with SMTP id r16mr4094604ilq.112.1612536088465;
 Fri, 05 Feb 2021 06:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
In-Reply-To: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Feb 2021 15:41:17 +0100
Message-ID: <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 3:37 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi,
>
> when building with pahole v1.20 and binutils v2.35.2 plus Clang
> v12.0.0-rc1 and DWARF-v5 I see:
> ...
> + info BTF .btf.vmlinux.bin.o
> + [  != silent_ ]
> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
>  BTF     .btf.vmlinux.bin.o
> + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> .tmp_vmlinux.btf
> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> Encountered error while encoding BTF.

Grepping the pahole sources:

$ git grep DW_ATE
dwarf_loader.c:         bt->is_bool = encoding == DW_ATE_boolean;
dwarf_loader.c:         bt->is_signed = encoding == DW_ATE_signed;

Missing DW_ATE_unsigned encoding?

- Sedat -
