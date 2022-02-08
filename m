Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5BB4AE361
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiBHWWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387192AbiBHWGI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 17:06:08 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5448C0612BC
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 14:06:07 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id s18so804620ioa.12
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiGyLg8cWadUpUV/dzImwc2YaiNNyLLzayweJorPV2g=;
        b=K8N2Xk5fXpj1dSzgipi45E6OlRo4tBgkgPty/ybzKtLMLsr87B9ogjUtjjxXxYbDJF
         xxe1Sl9Xc3c9tyR9p02SWCT9a4K7GVPB6jAdsIFBbtZWgJayi+PsqgYFj2s7kBXb8MtP
         5kgyYaYoBA50D3SQa7VMRXoI91GQSM3wt/pce+t1h5NBqs7TePXDpK+TXs8iJcpbaft0
         xESP44JQuRl2Mu0gkiERUihf4/swNbF92CoZ6YPEjfbe2jh9zIQiZzA7BdStimusRdaH
         qmrLXSLdjz7BxlfnxKq/3QwxICB59LEso0LgHrNaOzu6Ah/5tGJv9frNpktPuqNLfCmo
         ZsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiGyLg8cWadUpUV/dzImwc2YaiNNyLLzayweJorPV2g=;
        b=MSISM5dhN1zeNrCFm0bUdQG+gMaavf5e8s0sC1SCxb6PNWeuV1aDRaM2CbQ6HO13Bf
         RA5tGiwxUPmj3oqPGVICRkWRW2bLQXBRXG3zmvYd4QhGK8xuN5bmirSEBzSF95B/R/Ar
         aqI9r4sn/gwR80JfezjI67BdHV/Q15tai4cLykg5v7G7mgY56GwP1NSTGlFtmqA5pxt6
         YC0Eo5DQAWIC30myAAvb2mRKH0jEud766jhNWP2VOQBX7aZtY4v9TFV32kzHBK4nC5uQ
         Ml2jZYUBM233u+o6KSTNooROe4pFaalTHHrMvgSFdUMv8KYkXHiLSPJwHh2n/XIDpfgG
         YDtA==
X-Gm-Message-State: AOAM530N+/nrNZYxWVZ49O49jOCqcq/7CY5glaJDJFaucE9yWOdX5MtP
        /vWnMTSp0s2iKtKOuIFnkZpI+B4pu7aK/glxhJA=
X-Google-Smtp-Source: ABdhPJztLzdHcNkzyUCG1EVRSAMQ4cWv9ApMM2+cE6RHBVwrW4JWyPU+eBovXNXfzMIEMtXGRfZ9qJqvrZBuyoq0CXk=
X-Received: by 2002:a02:7417:: with SMTP id o23mr3270031jac.145.1644357966993;
 Tue, 08 Feb 2022 14:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20220208051635.2160304-1-iii@linux.ibm.com> <20220208051635.2160304-6-iii@linux.ibm.com>
In-Reply-To: <20220208051635.2160304-6-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 14:05:55 -0800
Message-ID: <CAEf4BzZCYa-wz5B7pwvo6R84vs70YFxJddSvA_FwCGDnUrHXFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/14] libbpf: Generalize overriding syscall
 parameter access macros
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 7, 2022 at 9:16 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Instead of conditionally overriding PT_REGS_PARM4_SYSCALL, provide
> default fallbacks for all __PT_PARMn_REG_SYSCALL macros, so that
> architectures can simply override a specific syscall parameter macro.
> Also allow completely overriding PT_REGS_PARM1_SYSCALL for
> non-trivial access sequences.
>
> Co-developed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 48 +++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 15 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index da7e8d5c939c..82f1e935d549 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -265,25 +265,43 @@ struct pt_regs;
>
>  #endif
>
> -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> -#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
> -#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
> -#ifdef __PT_PARM4_REG_SYSCALL
> +#ifndef __PT_PARM1_REG_SYSCALL
> +#define __PT_PARM1_REG_SYSCALL __PT_PARM1_REG
> +#endif
> +#ifndef __PT_PARM2_REG_SYSCALL
> +#define __PT_PARM2_REG_SYSCALL __PT_PARM2_REG
> +#endif
> +#ifndef __PT_PARM3_REG_SYSCALL
> +#define __PT_PARM3_REG_SYSCALL __PT_PARM3_REG
> +#endif
> +#ifndef __PT_PARM4_REG_SYSCALL
> +#define __PT_PARM4_REG_SYSCALL __PT_PARM4_REG
> +#endif
> +#ifndef __PT_PARM5_REG_SYSCALL
> +#define __PT_PARM5_REG_SYSCALL __PT_PARM5_REG
> +#endif
> +
> +#ifndef PT_REGS_PARM1_SYSCALL
> +#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM1_REG_SYSCALL)
> +#endif
> +#ifndef PT_REGS_PARM2_SYSCALL
> +#define PT_REGS_PARM2_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM2_REG_SYSCALL)
> +#endif
> +#ifndef PT_REGS_PARM3_SYSCALL
> +#define PT_REGS_PARM3_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM3_REG_SYSCALL)
> +#endif
> +#ifndef PT_REGS_PARM4_SYSCALL
>  #define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCALL)
> -#else /* __PT_PARM4_REG_SYSCALL */
> -#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
>  #endif
> -#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
> +#ifndef PT_REGS_PARM5_SYSCALL
> +#define PT_REGS_PARM5_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM5_REG_SYSCALL)
> +#endif
>
> -#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> -#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
> -#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
> -#ifdef __PT_PARM4_REG_SYSCALL
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM1_REG_SYSCALL)
> +#define PT_REGS_PARM2_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM2_REG_SYSCALL)
> +#define PT_REGS_PARM3_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_REG_SYSCALL)
>  #define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG_SYSCALL)
> -#else /* __PT_PARM4_REG_SYSCALL */
> -#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
> -#endif
> -#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
> +#define PT_REGS_PARM5_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_REG_SYSCALL)
>

No, please don't do it. It makes CORE variants too rigid. We agreed w/
Naveen that the way you did it in v2 is better and more flexible and
in v3 you did it the other way. Why?

>  #else /* defined(bpf_target_defined) */
>
> --
> 2.34.1
>
