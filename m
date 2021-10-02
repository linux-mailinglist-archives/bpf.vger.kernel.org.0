Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22C41FD76
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhJBReN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Oct 2021 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBReN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Oct 2021 13:34:13 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DA6C0613EC
        for <bpf@vger.kernel.org>; Sat,  2 Oct 2021 10:32:27 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r1so27630597ybo.10
        for <bpf@vger.kernel.org>; Sat, 02 Oct 2021 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bIo+Z31tKOkBmfnn7cvdjeHAfTdWfBVWcIMP85tzvg=;
        b=V3bWB07ABnhkitFxsYNZQU4eJNreIxdUgjdOGipVEOI/nIcAl1XIVkVh/4nSOCvxVr
         asCeMEEO2Nf4ya4KB2MS2/8aPr38L363l4xFS3lf+sjlpLvslfOAD1wTTJmWtnMYjssV
         atHYWLU4mArwlvhRkErrqwqVZwlWWLR5BNdJOfLQdQ+AlZcP2UBJB9L+zpOi2l8zNnG3
         3m426q2W7NCmXURDKyncLyPUQuLVS3dleK0nmNJUUk4rQIijnXKqedbdKaFNUVHWVkUH
         17b2kjsm+FipT+EgTE3bKDhNF4k+HBeNYHk9M4h96NkGOGLMujUyBpg+MP4s2PN5tKC/
         0j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bIo+Z31tKOkBmfnn7cvdjeHAfTdWfBVWcIMP85tzvg=;
        b=AOL3BBB7M7cMoz9aEm0m7Z+VPuFOJO5v/53ujaDDSoLF7bJS6DAbdmzKOYBeDCz5Y1
         3RxEfsubr46VLb+UluOIq6Wi1c7gyh5P10zIuhs2cntKNayK4s2Q6hj6UTpVPyHe9sxr
         RYbwPUfFQc7wAxI574flzEdWL+sRQ305Zk7FDwClsn4byU5ntd8VH0im+vvd8F/ElzYo
         0Vq0pHvLZ6SrxAy/FgfIDyUQpgb2PT2JPXqmQLWxEPIrDgCi9tcFJ5I3KK4CdUwZyNQm
         HXcUDrfe3zDVvrApdgPszlTxrqSlcS5yEZaV9dnLgHEUgGwNZfhiL0jUHqU1kFt99hJo
         eorQ==
X-Gm-Message-State: AOAM533RlZRVJNAukLaGRCHv2V0UsvfZz74d0Sh8qnBR94XkgeZNHlfY
        VO7/j7otRr37cFU+fORL1OqmgWm/epadX8S+0QB8lQ==
X-Google-Smtp-Source: ABdhPJyvKkigKVy5xObNbnk1snkLLKuZpqpwxg7x0f76Ch3RPmL/TFOqMuYdizYBBub/O3Gg4gTg2os3BHl2IHtYP6Q=
X-Received: by 2002:a25:b904:: with SMTP id x4mr4565548ybj.48.1633195946435;
 Sat, 02 Oct 2021 10:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com> <8cb6a1725cf3c38ca90ed7f195f78a5b5a83bb25.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <8cb6a1725cf3c38ca90ed7f195f78a5b5a83bb25.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Sat, 2 Oct 2021 19:32:15 +0200
Message-ID: <CAM1=_QTaf0fhK4js=2=dZ2MXh6zHoUDzwn3Y-mXY5Fxo=rygpA@mail.gmail.com>
Subject: Re: [PATCH 5/9] powerpc/bpf: Fix BPF_MOD when imm == 1
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        bpf <bpf@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 1, 2021 at 11:15 PM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> Only ignore the operation if dividing by 1.
>
> Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

> ---
>  arch/powerpc/net/bpf_jit_comp64.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 3351a866ef6207..ffb7a2877a8469 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -391,8 +391,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
>                 case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
>                         if (imm == 0)
>                                 return -EINVAL;
> -                       else if (imm == 1)
> -                               goto bpf_alu32_trunc;
> +                       if (imm == 1) {
> +                               if (BPF_OP(code) == BPF_DIV) {
> +                                       goto bpf_alu32_trunc;
> +                               } else {
> +                                       EMIT(PPC_RAW_LI(dst_reg, 0));
> +                                       break;
> +                               }
> +                       }
>
>                         PPC_LI32(b2p[TMP_REG_1], imm);
>                         switch (BPF_CLASS(code)) {
> --
> 2.33.0
>
