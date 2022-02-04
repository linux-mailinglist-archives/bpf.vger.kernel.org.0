Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC904A9356
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 06:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiBDFWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 00:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiBDFWj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 00:22:39 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB17C061714
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 21:22:39 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id 15so3946766ilg.8
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 21:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94/aY3KSsj/UaPZqjFC+Qcvdm5V4I3iobuicVDul0rI=;
        b=E1dFjXKIb1L28spl73WbHUcYRuWChyyQKu+3HkG6cTB5xwLpED+pSw5hERn8rivqAV
         2s+TZGWRDmMZ/BVyaLWdJbC6KD2KY5CIZw64Gyw6B2DnHtqnWrNEru3d1vRn4sYlh/q1
         txgQNafKDv013TlTuHIcF+pWjVEDfDI0fk1ISdPZ6izSroX0KJFpkDL4tejqdwPO4jzw
         G7a0f9T1y9yw1wNgknxiyq6bfeGYcTx5k/Cyv6HK3/tsnIlMez31a3z3PHyTWYrrkfBy
         NoCmVQ2YBBQeYwWF2BnHHFrP64TNJDp+2mR1JI+/sInamy/34KDx9JSNMguK5eoJqEaQ
         +J5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94/aY3KSsj/UaPZqjFC+Qcvdm5V4I3iobuicVDul0rI=;
        b=CmE7ezK5C6w9aXEJ+FOQWG5TSEshxaCKLs2nPFh6DfvruHL5LsjG1klyyc9JRsS6Xa
         N/p4UsPDycSRnYOSWeZWzbC/2XqAGqTGAEGGQKGGHf0cU0DSnaXrfFAuGkHcGRRoi9Fd
         LcC/CU3znArU31QLuAUTjQcQHsEBN5gwaM5G6hhfttUH2u1x70l2tKgUED0JSnNotJsD
         OfcbW0mk2kyz4aFZ4bfLx5uWqhJc0mbnpFX6tYeUF1vA7XOvKInscvi5r7hBHUQdq0rd
         p8XcTceO1i+8rrOKcVGcfEKZ4dECs+NokOcpibV7zosa+SYbjkNEYzOTdt/pBlmqvHRK
         Z5Xw==
X-Gm-Message-State: AOAM532Kg62NOVWM75sUM+2GVOpd5t3QirdGb7PNueNr1IYcYBEr9QGe
        wimOktX4F60QScspvP8zwwkLHO+U3EUirwipZ88=
X-Google-Smtp-Source: ABdhPJwN8V0P2GCOq7aPOMlkcdGPH4yPyCV6AQ74CHwkTWw5wkecUd17+7WXYpD0UAjDfhbu7IMAI1MRMaH4hSTglcM=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr668252ilu.71.1643952158793;
 Thu, 03 Feb 2022 21:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20220204041955.1958263-1-iii@linux.ibm.com> <20220204041955.1958263-6-iii@linux.ibm.com>
In-Reply-To: <20220204041955.1958263-6-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Feb 2022 21:22:27 -0800
Message-ID: <CAEf4Bzbz-MP9QX-SaZ4+we1UnWvgiym_+aR580WdpewzmRKKNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/10] libbpf: Add PT_REGS_SYSCALL macro
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
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 3, 2022 at 8:20 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Some architectures pass a pointer to struct pt_regs to syscall
> handlers, others unpack it into individual function parameters.
> Introduce a macro to describe what a particular arch does, using
> `passing pt_regs *` as a default.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 30f0964f8c9e..400a4f002f77 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -334,6 +334,15 @@ struct pt_regs;
>
>  #endif /* defined(bpf_target_defined) */
>
> +/*
> + * When invoked from a syscall handler kprobe, returns a pointer to a
> + * struct pt_regs containing syscall arguments and suitable for passing to
> + * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().
> + */
> +#ifndef PT_REGS_SYSCALL
> +#define PT_REGS_SYSCALL(ctx) ((struct pt_regs *)PT_REGS_PARM1(ctx))
> +#endif

maybe PT_REGS_SYSCALL_REGS? It returns regs, not the "syscall".
PT_REGS prefix is for consistency with all other pt_regs macros, but
"SYSCALL_REGS" is specifying what is actually returned by the macro

> +
>  #ifndef ___bpf_concat
>  #define ___bpf_concat(a, b) a ## b
>  #endif
> --
> 2.34.1
>
