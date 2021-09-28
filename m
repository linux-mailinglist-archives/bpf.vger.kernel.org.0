Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3141A6A3
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 06:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhI1EiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 00:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhI1Eh7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 00:37:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B7AC061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 21:36:20 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f133so28946378yba.11
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 21:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=77ggUPbWFSJLwNW1d/8Ugg2qoAsMrhx74Bbrwh0ezHE=;
        b=WMQOiWxPKF9DEihUCfixFmUujVEBpUCir8zkNsqY57D0LtczCRJjEI8qMJqILgJlo0
         K/9jsty6HLq/rphu6Et8qNMsfpOKLc6UsWMwNI/GzltvYlYIlJV7j8REbMWppPQbtUpv
         LhagGsUtuyXPB5JZfdubGO+esSpxYfo2AY4Q4CUkyc0mKx5QrI/AVRd+HVPsqkFSPJLX
         7/yvSVUa++1CH9sk1Yb+HoPwjKwkaNIdILqLZXsU2gxkteWlNpYv52OaBSFmhsJ9TphJ
         CqRUjV+Oz/73dBhjRB5ad8zazuXznYxiR7uFefc/RrVRgobW7E6wYVGPZ4ADKehqOOVV
         +RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=77ggUPbWFSJLwNW1d/8Ugg2qoAsMrhx74Bbrwh0ezHE=;
        b=g1tCW2L78kbxtRKVvFM2eNEugDkMD3z3Mc1QB+aJaoJLRPQ7wLx1Yjfokt0Bv/Xcny
         +tZGG0vnTeydDIcxnFwon3icJjurvGSmLgBTVLjQc2Pu7LOUNy5VVkuD5UtMQo2DLFeF
         Ii4bHKE7o46RRjc1r53VFAVXYhVIHOGf6kX0XDPtvTlBflI7QsoKbRfe+DNF6Fvf8UW0
         k6dkpxYYVCoimuUaf+tEWyWogEO1zzwvchcgZJa+YunhsCbDmCrzCV9MAaDc87Xl6ONM
         Uh8EB40zu4pF2IwMWtjttuvRnO+2XIEq6UGRHcxfaieNzwxCiN8tyz85JMLpUWQoKlcc
         x1Dw==
X-Gm-Message-State: AOAM5325idR7rjeFTqavsOMV/9UjQuz/mFrQaw91bvjZ/d517uw4nOxo
        BEIp5btAPyqnVfY5wkdGuMIrEqBrgb5cJRaO3nE=
X-Google-Smtp-Source: ABdhPJwlGWo8TowZOVgE0XowdKQh4/wRPnV0LJxj/4o7HOZkuneJpFN+THo02AgInNpVLTs6n+8lW/YIxwsNe8JOq4Y=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr4082985ybt.433.1632803779908;
 Mon, 27 Sep 2021 21:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210928041329.1735524-1-memxor@gmail.com>
In-Reply-To: <20210928041329.1735524-1-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Sep 2021 21:36:09 -0700
Message-ID: <CAEf4BzaCyCZoUGjY8_-+WUV6DMxHvcJLGLb+gYxZrA5YDwbU=w@mail.gmail.com>
Subject: Re: [PATCH bpf] samples: bpf: Fix vmlinux.h generation for XDP samples
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 9:16 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Generate vmlinux.h only from the in-tree vmlinux, and remove enum
> declarations that would cause a build failure in case of version
> mismatches.
>
> There are now two options when building the samples:
> 1. Compile the kernel to use in-tree vmlinux for vmlinux.h
> 2. Override VMLINUX_BTF for samples using something like this:
>    make VMLINUX_BTF=3D/sys/kernel/btf/vmlinux -C samples/bpf
>
> This change was tested with relative builds, e.g. cases like:
>  * make O=3Dbuild -C samples/bpf
>  * make KBUILD_OUTPUT=3Dbuild -C samples/bpf
>  * make -C samples/bpf
>  * cd samples/bpf && make
>
> When a suitable VMLINUX_BTF is not found, the following message is
> printed:
> /home/kkd/src/linux/samples/bpf/Makefile:333: *** Cannot find a vmlinux
> for VMLINUX_BTF at any of "  ./vmlinux", build the kernel or set
> VMLINUX_BTF variable.  Stop.
>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Fixes: 384b6b3bbf0d (samples: bpf: Add vmlinux.h generation support)
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  samples/bpf/Makefile                     | 13 ++++++-------
>  samples/bpf/xdp_redirect_map_multi.bpf.c |  5 -----
>  2 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 4dc20be5fb96..a05130e91403 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -324,15 +324,9 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.=
h
>
>  VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                          =
 \
>                      $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
> -                    ../../../../vmlinux                                \
> -                    /sys/kernel/btf/vmlinux                            \
> -                    /boot/vmlinux-$(shell uname -r)
> +                    ./vmlinux

isn't this relative to samples/bpf subdirectory, so shouldn't it be
../../vmlinux?

>  VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))=
)
>
> -ifeq ($(VMLINUX_BTF),)
> -$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_P=
ATHS)")
> -endif
> -

[...]
