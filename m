Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B25487DCA
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 21:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiAGUe5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 15:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiAGUe5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 15:34:57 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3DCC061574
        for <bpf@vger.kernel.org>; Fri,  7 Jan 2022 12:34:57 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q5so8570053ioj.7
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwejnykmxKgy1cX4GmV23flEB4t+ufvY0ZcKW/b87o8=;
        b=qDdsn7LLMNs6kOuWBf5y+PIUXtMUWnR8VxJ0trmFBLHIzvrgm1g8iIlhoPUGPa4Quz
         zLfyhQSIeUvvoXkLFswTyzdOxWUKrt0IY0r0okMdsoV4yyqxkiOGXyFayl0Q+K6s6Hvv
         X4TYdCNP/Iod1bCE+fEdxGCrYGXpwJjnfmKqoy6g5gRu/ZSXYUBDwSMXLdg380dWC4rF
         yCtvurFOueRGLnIBMoeqBFX1EzfRAZaR/VLkjnaUxT73ZsI6xaeQGLUubh4Df+9qtSmH
         E2frLEP284LDA0ZshObElpxqArSbl4vLS6aqLRsu/w5TWFUHtm7AEnzKf5g0RertNOV8
         eteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwejnykmxKgy1cX4GmV23flEB4t+ufvY0ZcKW/b87o8=;
        b=GoisOMXfmybL12nKwSC3UB3PPeNztxqb+AAb0Wp/uL7WwEq0P8LaiHPVLZm8HocK1g
         C79CbJzze7z8CZdSKUr3LkRFUtrxXUCGiCOtolhgLw0A2prNRbtdCCYIck+v5U91UjOy
         p79dogY8LX2AzSnC/a0FC/b8BpA4vSB7BH/QKIURW6f8AZuV7R5Fd6c2HPBlHj7GfHUB
         8+msbtc2a8GEKIyar6+xlQb2Bp8IUFL6rro2flyf/m5YJUod/zgl4rIFj470zFLgEsul
         727v8bMKrhHIg7YYuagcozD4nBi8PFHxJ/ReqvGrsBS6ZNusorrwwEKA/yiRLpK9BbSp
         Ph8A==
X-Gm-Message-State: AOAM5313r1qKjzVS/u8labIE/R76I3YHbZgc+a6lvuuydZ5pHL8xo2DM
        +Pkk33PiF7M7i7B4e59qWDBj54dxVuXWQIl65SI=
X-Google-Smtp-Source: ABdhPJx1v1VUaB0CTdw4DlMft5AD5cjuLOq+tk+oi1b8rM5nkuAheL0gdcgVgzKfpm+1l42APTrlgsbF5sp/jH7Mp0U=
X-Received: by 2002:a02:ce8f:: with SMTP id y15mr26011838jaq.234.1641587696650;
 Fri, 07 Jan 2022 12:34:56 -0800 (PST)
MIME-Version: 1.0
References: <TYCPR01MB593665A2C1E6C39169D10377F54D9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB593665A2C1E6C39169D10377F54D9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 7 Jan 2022 12:34:45 -0800
Message-ID: <CAEf4BzYWueWzBzVfW62augyDmLTN0ZW=mtE0xPFX7UrtG2BMPw@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Fix the incorrect register read for syscalls
 on x86_64
To:     Kenta Tada <Kenta.Tada@sony.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 6, 2022 at 6:39 PM <Kenta.Tada@sony.com> wrote:
>
> Currently, rcx is read as the fourth parameter of syscall on x86_64.
> But x86_64 Linux System Call convention uses r10 actually.
> This commit adds the wrapper for users who want to access to
> syscall params to analyze the user space.
>
> Changelog:
> ----------
> v1 -> v2:
> - Rebase to current bpf-next
> https://lore.kernel.org/bpf/20211222213924.1869758-1-andrii@kernel.org/
>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 90f56b0f585f..4c3df8c122a4 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -70,6 +70,7 @@
>  #define __PT_PARM2_REG si
>  #define __PT_PARM3_REG dx
>  #define __PT_PARM4_REG cx
> +#define __PT_PARM4_REG_SYSCALL r10 /* syscall uses r10 */
>  #define __PT_PARM5_REG r8
>  #define __PT_RET_REG sp
>  #define __PT_FP_REG bp
> @@ -99,6 +100,7 @@
>  #define __PT_PARM2_REG rsi
>  #define __PT_PARM3_REG rdx
>  #define __PT_PARM4_REG rcx
> +#define __PT_PARM4_REG_SYSCALL r10 /* syscall uses r10 */
>  #define __PT_PARM5_REG r8
>  #define __PT_RET_REG rsp
>  #define __PT_FP_REG rbp
> @@ -226,6 +228,7 @@ struct pt_regs;
>  #define PT_REGS_PARM2(x) (__PT_REGS_CAST(x)->__PT_PARM2_REG)
>  #define PT_REGS_PARM3(x) (__PT_REGS_CAST(x)->__PT_PARM3_REG)
>  #define PT_REGS_PARM4(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG)
> +#define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCALL)

Not all architectures define __PT_PARM4_REG_SYSCALL, but you are
assuming it does. I think you mixed up where to put these definitions,
see below.

>  #define PT_REGS_PARM5(x) (__PT_REGS_CAST(x)->__PT_PARM5_REG)
>  #define PT_REGS_RET(x) (__PT_REGS_CAST(x)->__PT_RET_REG)
>  #define PT_REGS_FP(x) (__PT_REGS_CAST(x)->__PT_FP_REG)
> @@ -237,6 +240,7 @@ struct pt_regs;
>  #define PT_REGS_PARM2_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM2_REG)
>  #define PT_REGS_PARM3_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_REG)
>  #define PT_REGS_PARM4_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG)
> +#define PT_REGS_PARM4_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG_SYSCALL)

Do we need CORE variants for _SYSCALL macro? I guess realistic
selftests would show that.

>  #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_REG)
>  #define PT_REGS_RET_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_RET_REG)
>  #define PT_REGS_FP_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_FP_REG)
> @@ -292,6 +296,22 @@ struct pt_regs;
>
>  #endif /* defined(bpf_target_defined) */
>
> +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> +#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
> +#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
> +#ifndef PT_REGS_PARM4_SYSCALL
> +#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
> +#endif
> +#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
> +
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> +#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
> +#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
> +#ifndef PT_REGS_PARM4_CORE_SYSCALL
> +#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
> +#endif
> +#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
> +

All this should be inside the `#if defined(bpf_target_defined)`
section, not after it. And then for PT_REGS_PARM4_SYSCALL you can just
do this:

#ifdef __PT_PARM4_REG_SYSCALL
#define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCALL)
#else /* __PT_PARM4_REG_SYSCALL */
#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
#endif


And I guess for completeness we need to define __BPF_TARGET_MISSING
variants if !defined(bpf_traget_defined), see how it's done for all
current PT_REGS_xxx

>  #ifndef ___bpf_concat
>  #define ___bpf_concat(a, b) a ## b
>  #endif
> --
> 2.32.0
