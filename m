Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0754AE395
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbiBHWXG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387246AbiBHWMe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 17:12:34 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB1CC0612B8
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 14:12:32 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id c188so869917iof.6
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 14:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/JRuom9cxKorU/cRFTyfuqc+/tlOWGfQ5tERGHOm7Y=;
        b=H+LUp+guAYgCMg9MXnZ9qW1CAqS1ybgo7+B/OgD7t8ySt3/dB0nzzaOqPNGo3QVHHi
         SlRPmf6OKCPmzLdSe7teARWY1LklkfQPs041gquCJLCbc9Hz99CgVNDGh+OjrgFEqKTq
         gphjTqIkNY+FwaYIlqr4NINcNuoSYmwU4R6jLOqPqkbDxLi1SH+zzhSfCmIawalE6ZLG
         2Uk1QGFn/KoPTXx6IaQus/w7LZD4afvFNYOupYqRCMjIIQR3v3dErTm8wcnDFN3I7OO9
         zd/HqOR+ecA3OMZScDa5FvdqVX3bKKUdqJRYEF/ZvlXgXIF+BptXwXhEbORCJyuUAogZ
         m8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/JRuom9cxKorU/cRFTyfuqc+/tlOWGfQ5tERGHOm7Y=;
        b=3LG0OowEtV2HAzLaZtPTPIIeM2Th5aO3U4gkEgINBMek2PQpWNMud8RoXZIncKP4+W
         JiWjMlRu/aY+NXa85GnFKM7lxrVbupvBqGfmRv7SRCoO0euNCEOBPpz246QBaRVfWNwU
         QzpUOVwtOoKMYN+Jg4WWcvWx6AA4ESBbJBgWUBqbT8VSWgmYdTe2UwXkv2dHxCvrsPzD
         vqBtneluGRjhpaMXvIA6cIe769MeqR64zY8He1mc+Dxtd7kBu8siM+s8T4KdfGx4WCXi
         NSec+mbGoY1+AO/yVaLnE1HMZfT6T9xbLUKIR0DTi2MMnsCyaq34sN41/ADOIk9EYpjx
         GHTw==
X-Gm-Message-State: AOAM532M+jKlNKocOAFzEf5PbtRM3MtNbdyvHKLRg8NrTTmCa14hgYzi
        d+JzQi3J8jA1vmLYHwQ4P1DyRKYPK/KCf1+Metg=
X-Google-Smtp-Source: ABdhPJxZSdmJr+A2Lr7e7s66+W377Q+K8vzOZubQjGHhNaU2B58+/2eJW/u7wV5VQ6c9DaEdiuo/LZHkB4hyNNJ2LAk=
X-Received: by 2002:a02:1181:: with SMTP id 123mr3106870jaf.93.1644358351463;
 Tue, 08 Feb 2022 14:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20220208051635.2160304-1-iii@linux.ibm.com> <20220208051635.2160304-9-iii@linux.ibm.com>
In-Reply-To: <20220208051635.2160304-9-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 14:12:20 -0800
Message-ID: <CAEf4Bzbt4Bj=a0QmmDyrRE0dk1khvKE6XqErH2vimGp-Smi+oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 08/14] libbpf: Use struct pt_regs when
 compiling with kernel headers
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 7, 2022 at 9:16 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Andrii says: "... with CO-RE and vmlinux.h it would be more reliable
> and straightforward to just stick to kernel-internal struct pt_regs
> everywhere ...".
>
> Actually, if vmlinux.h is available, then it's ok to do so for both
> CO-RE and non-CO-RE cases, since the beginning of struct pt_regs must
> match (struct) user_pt_regs, which must never change.
>
> Implement this by not defining __PT_REGS_CAST if the user included
> vmlinux.h.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

If we are using CO-RE we don't have to assume vmlinux.h, we can define
our own definition of pt_regs with custom "flavor":

struct pt_regs___s390x {
    long gprs[10];
    long orig_gpr2; /* whatever the right types and names, but order
doesn't matter */
} __attribute__((preserve_access_index));


And then use `struct pt_regs__s390x` for s390x macros. That way we
don't assume any specific included header, we have minimal definition
we need (and it can be different for each architecture. It's still
CO-RE, still relocatable, and we don't need all these ugly #if
defined() checks.

>  tools/lib/bpf/bpf_tracing.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 7a015ee8fb11..07e291d77e83 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -118,8 +118,11 @@
>
>  #define __BPF_ARCH_HAS_SYSCALL_WRAPPER
>
> +#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
>  /* s390 provides user_pt_regs instead of struct pt_regs to userspace */
>  #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
> +#endif
> +
>  #define __PT_PARM1_REG gprs[2]
>  #define __PT_PARM2_REG gprs[3]
>  #define __PT_PARM3_REG gprs[4]
> @@ -148,8 +151,11 @@
>
>  #define __BPF_ARCH_HAS_SYSCALL_WRAPPER
>
> +#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
>  /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
>  #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
> +#endif
> +
>  #define __PT_PARM1_REG regs[0]
>  #define __PT_PARM2_REG regs[1]
>  #define __PT_PARM3_REG regs[2]
> @@ -207,7 +213,10 @@
>
>  #elif defined(bpf_target_riscv)
>
> +#if !defined(__KERNEL__) && !defined(__VMLINUX_H__)
>  #define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
> +#endif
> +
>  #define __PT_PARM1_REG a0
>  #define __PT_PARM2_REG a1
>  #define __PT_PARM3_REG a2
> --
> 2.34.1
>
