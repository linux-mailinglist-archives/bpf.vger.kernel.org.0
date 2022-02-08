Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646314AE39D
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386969AbiBHWXI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387237AbiBHWJL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 17:09:11 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2EC0612B8
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 14:09:09 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id z7so187849ilb.6
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 14:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcniCPuqd7e/wg3ab1X2B5ypQ2QdbYNqK6WACDkmW+c=;
        b=L1NDCkGcQ9pORsZDWIEKiLsLr451fo6b4Hdx+yk7BO7knCK1IND4a31tiQdBE6MF2U
         sNBd/1FTqygdhubkZGXsbGyAzQaWkWA1gSShPSJdy62nYo2zxVRtoZtxn516C1rCcXBR
         k+QDqUeq5EklCBVokNzcZtx5LDaTgG5pKKsvwkxJwyF8ymuYxwwjpH1zSlVqx3WqBYqp
         oPQGwA9XaPjSGqTt4SQfzp299s0d6o9g79i1lpXW0K0iUk355PmdWW7G1XDrhhUrSUFb
         TrQGgIn5E0xsTN/9dV8Pm5QqAa3+f5r5DeSNKaFS3Flaclc7kDLw6JWe1IH2QzJQKc+b
         uf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcniCPuqd7e/wg3ab1X2B5ypQ2QdbYNqK6WACDkmW+c=;
        b=hhhzll5QfpzfvJow2PE/EGSh1caMrjREaDQO8feSdHI+2kVe+Ln2Yjd/K9Zaf2w74G
         AqJtMXXuIIPmwKq0laRehs7i0R6zXoNnxi9gYN0UuR8OUIvkFVixVpYv52ws3OBfAzup
         kjQXP4hr/mkFTVvSOsasbKnfLktRmdQcaLxJG7B5Yr9oILyMncdgXAcIGWksvGf9/QBu
         0AUOu94FLb8VhlIH0YbSkifxP011y0OOVgMdGLbENfP+gybZDKZII7wGmvIZjbC3t7Fn
         ZdPTNsdFlSpnt/DcZWSiB8f6jN8s8lIgPE6g/1i0Ojdo//dQhRs0h82tEE6YdNdwOcrt
         d5fg==
X-Gm-Message-State: AOAM531gEGiox+X+Ly8vO5YvewyDEfZV+Q47T6TtMywM/yj5ToMlHpEY
        0d+1ie6FrH/WOQPu1+zfoCAVMbkMPoEc2TFgU2A=
X-Google-Smtp-Source: ABdhPJwKGfPSPXUUIgA7la0pcGCwN20zRjqIo7njKfJ83nrOXt+ZSWP3PRpmWd7MGSGj1T9AajSaE/OE5zKOdmFSEoU=
X-Received: by 2002:a05:6e02:1a6c:: with SMTP id w12mr3220246ilv.305.1644358149288;
 Tue, 08 Feb 2022 14:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20220208051635.2160304-1-iii@linux.ibm.com> <20220208051635.2160304-7-iii@linux.ibm.com>
In-Reply-To: <20220208051635.2160304-7-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 14:08:58 -0800
Message-ID: <CAEf4BzagHVnAEz+22eFU=EeFuwvBGyGUbfT8XCmv4zF97KdUBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/14] libbpf: Add PT_REGS_SYSCALL_REGS macro
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
> Depending on whether or not an arch has ARCH_HAS_SYSCALL_WRAPPER,
> syscall arguments must be accessed through a different set of
> registers. Provide PT_REGS_SYSCALL_REGS macro to abstract away
> that difference.
>
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Co-developed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Again, there was nothing wrong with the way you did it in v3, please
revert to that one.

>  tools/lib/bpf/bpf_tracing.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 82f1e935d549..7a015ee8fb11 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -64,6 +64,8 @@
>
>  #if defined(bpf_target_x86)
>
> +#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> +
>  #if defined(__KERNEL__) || defined(__VMLINUX_H__)
>
>  #define __PT_PARM1_REG di
> @@ -114,6 +116,8 @@
>
>  #elif defined(bpf_target_s390)
>
> +#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> +
>  /* s390 provides user_pt_regs instead of struct pt_regs to userspace */
>  #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
>  #define __PT_PARM1_REG gprs[2]
> @@ -142,6 +146,8 @@
>
>  #elif defined(bpf_target_arm64)
>
> +#define __BPF_ARCH_HAS_SYSCALL_WRAPPER
> +
>  /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
>  #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
>  #define __PT_PARM1_REG regs[0]
> @@ -344,6 +350,17 @@ struct pt_regs;
>
>  #endif /* defined(bpf_target_defined) */
>
> +/*
> + * When invoked from a syscall handler BPF_KPROBE, returns a pointer to a
> + * struct pt_regs containing syscall arguments, that is suitable for passing to
> + * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().
> + */
> +#ifdef __BPF_ARCH_HAS_SYSCALL_WRAPPER
> +#define PT_REGS_SYSCALL_REGS(ctx) ((struct pt_regs *)PT_REGS_PARM1(ctx))
> +#else
> +#define PT_REGS_SYSCALL_REGS(ctx) ctx
> +#endif
> +
>  #ifndef ___bpf_concat
>  #define ___bpf_concat(a, b) a ## b
>  #endif
> --
> 2.34.1
>
