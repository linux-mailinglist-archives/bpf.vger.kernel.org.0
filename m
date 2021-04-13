Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4993235D5D1
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 05:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbhDMDSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 23:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbhDMDSk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 23:18:40 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E57FC061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 20:18:21 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 65so16577652ybc.4
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 20:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePMLtCLxBYkSpjYGDqu8+pyxoeek59tqLO5Zupz/XUQ=;
        b=EdkPS9tnnNN0EIGr2jIZXo3QRdAmWHMRdYBK2zVq1ALmxRk3ThIJ6WNMs5gJJ/rupk
         CsYqzf4hMebVhdlK+bUM9bHBeultwCw3nRGYx0MOuwYcBdWTtLnPzPoEK4fYfXWqiWoe
         pFQ/do+fR5TTzcTzjlqmeVj3wErvODit9F8caenxApih4fY9L7iEKMd9yDjKSkMQhqFz
         LCPBt6017crI8IrP3OBAzHFv3hlcfOG7VboZJn5KLmKAASQobaW9/25uHPxi/tlxLcg3
         GiYZR2j+bz8poLKWwN0UN+8PEgVkzsJt52kqosKsHqV5LVovCemeFZvk47tGcrof4tDk
         JhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePMLtCLxBYkSpjYGDqu8+pyxoeek59tqLO5Zupz/XUQ=;
        b=k3hDtnOXCZ3TaXdoLF47bRuIT2kOzxzTOTjj4l16gyG5EleYyAwfbggIv9m9PiDrxt
         /oBtYvDHSDTHEVatwAaR6Hipzuvb6Iaxb4FQFsM+Z85HOCekGU+9I5trYBt1mXkau9gK
         e5byIF26+c+saR3PHCIutQNkHdA3XYTTPNoUPpdZmz5yHR2kfEVUZvjKm9eM+KtmNy5Z
         pRRK2/GutepTiqzAtKp2pvZpNXVNSBCsMRkgqIpxunW0YPWYmNDiLrdBFGMOBT3WECPN
         MlQVpUhB6Y/0Lo4eGxRcqciCmwQtFOuYwpHkacmt+SM18kBFnfOysdi5NEoCv5K4VIvf
         NHGA==
X-Gm-Message-State: AOAM531F2JK6NrZXqCO7rCmBsaJBhXHTKrgKEErtozpLZJGKNHSaxQQa
        pZjptjDeSebJLTr/OAo6rttdsAI4cXYZVyHtWrSrQYFFGOc=
X-Google-Smtp-Source: ABdhPJzdp6zs4DItmt4P7uCxK2En8tNBKDfWLH6cCWTaU8heJsSbABc9+12V9r1vNGM1KS2JNMkPfMveGI/yBvoP+Nk=
X-Received: by 2002:a25:3357:: with SMTP id z84mr32848188ybz.260.1618283900425;
 Mon, 12 Apr 2021 20:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210412215629.17865-1-iii@linux.ibm.com>
In-Reply-To: <20210412215629.17865-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Apr 2021 20:18:09 -0700
Message-ID: <CAEf4BzbCzjrMofz-k4-a_xR0XZG49ZMLHhFzU2rZBkiXPqfddA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Generate BTF_KIND_FLOAT when linking vmlinux
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 2:56 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> pahole v1.21 supports the --btf_gen_floats flag, which makes it
> generate the information about the floating-point types [1].
>
> Adjust link-vmlinux.sh to pass this flag to pahole in case it's
> supported, which is determined using a simple version check.
>
> [1] https://lore.kernel.org/dwarves/YHRiXNX1JUF2Az0A@kernel.org/
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

few nits below, but otherwise looks good:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  scripts/link-vmlinux.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 3b261b0f74f0..392c7fb94d3e 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -227,8 +227,13 @@ gen_btf()
>
>         vmlinux_link ${1}
>
> +       local extra_paholeopt=

let's keep variables together, can you move it up to `local
pahole_ver` above? btw, does it need `=`, or `local paholeopt` will
just create it as an empty variable?

> +       if [ "${pahole_ver}" -ge "121" ]; then
> +               extra_paholeopt="${extra_paholeopt} --btf_gen_floats"
> +       fi
> +
>         info "BTF" ${2}
> -       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> +       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J${extra_paholeopt} ${1}

it looks weird that there is no space between -J and $extra_paholeopt,
why complicating things? extra space isn't a big deal in command
invocation, imo

>
>         # Create ${2} which contains just .BTF section but no symbols. Add
>         # SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
> --
> 2.29.2
>
