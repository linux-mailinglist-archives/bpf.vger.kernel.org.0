Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6108C493FFE
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 19:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344714AbiASSeE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 13:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245537AbiASSeD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 13:34:03 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD3C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:34:03 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r204so220697iod.10
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rt7sAjx7RcX2GmG3D3v8dmsUM0G63nnz+k4FBQChu+U=;
        b=Qz1S5cKnJAWLyM+kDOAw8ur9k2cUYR/kbW+qcMgswBVkpiHleyLqNHoVxDMqv/IJjY
         293neKBDH82YlBTgnPCAysrkRpXb5dv82PqhlCx9SEgrtsCh013QVUhq7g1wovf9Pol6
         eKx7vFflQHTdLNma4sPut4v8puP7Z7ukD7m2PsZ+M+Z6NVqK1bzIEwFUKu6qqtHCGe8D
         ngSEu9JVGrCk2+Kr9uBrXIxYBRUNA6wPMRdpYLOS4wClQuYD6Eqik1YxULObGDXwn6bE
         5xXgykaqSYeonrj2ovdFabrV3Mml0QH+FhTOIk1IYkG0DRTxrqce+h2fV6M3+ImPCnno
         DBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rt7sAjx7RcX2GmG3D3v8dmsUM0G63nnz+k4FBQChu+U=;
        b=v2OgKYt65y4RbEjLUf3EllbOSYg+rk3NsugCQZmjSczwPOENhkjOCFa9/MS6FEOBcO
         Rh3YmFfDMP14FwgRK/EOUBC98gBepL7Vp51s4An0IKuuou32QQfgD9z+WiWP9Ndlpu37
         6RNY/n2rt+O4bJ6M8V4aT2OF0gby2aXe71IhAkAGxOP+Vcfkvgl5MXqn3LM1G5UGhZYD
         ARsUIlEPiLfU9rCOjjX01dCxRlsIk7JmHNi9YB9vnbZlZqWNAvHeGigAvh1hrK8Iv24H
         WHl4da1EhCar7saRpgy1u98Daoj5RSfkrKrWZ+PngXnFppjdi3ADP5NLNhqex2n/u0iq
         8HsA==
X-Gm-Message-State: AOAM533maB2SA2rFnbQF+k6ivTB0zck0mRwTz89zxWpcnp6TIyPOxy2B
        W/1d7M1awo2B7tNdlHQIFywbUEh6cF23npMlbo0=
X-Google-Smtp-Source: ABdhPJz85OwM+2nDPdm0CylW3P+nWFXTAJ+fbuzmPLc7HxVJw2pMz0cVWyhH900lNscjPLmnWBFPtqFpkCYoZu6HTQg=
X-Received: by 2002:a05:6638:2a7:: with SMTP id d7mr14669860jaq.93.1642617242947;
 Wed, 19 Jan 2022 10:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20220119131209.36092-1-Kenta.Tada@sony.com> <20220119131209.36092-3-Kenta.Tada@sony.com>
In-Reply-To: <20220119131209.36092-3-Kenta.Tada@sony.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Jan 2022 10:33:51 -0800
Message-ID: <CAEf4Bza9A+iC49bZRiSPWNuy+=qG3sc=_XvKem4Fj2zZF8merg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] libbpf: Fix the incorrect register read for
 syscalls on x86_64
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

On Wed, Jan 19, 2022 at 5:13 AM Kenta Tada <Kenta.Tada@sony.com> wrote:
>
> Currently, rcx is read as the fourth parameter of syscall on x86_64.
> But x86_64 Linux System Call convention uses r10 actually.
> This commit adds the wrapper for users who want to access to
> syscall params to analyze the user space.
>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 90f56b0f585f..81673a24973e 100644
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
> @@ -263,6 +265,26 @@ struct pt_regs;
>
>  #endif
>
> +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
> +#define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
> +#define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
> +#ifdef __PT_PARM4_REG_SYSCALL
> +#define PT_REGS_PARM4_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCALL)
> +#else /* __PT_PARM4_REG_SYSCALL */
> +#define PT_REGS_PARM4_SYSCALL(x) PT_REGS_PARM4(x)
> +#endif
> +#define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
> +
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
> +#define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
> +#define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
> +#ifdef __PT_PARM4_REG_SYSCALL
> +#define PT_REGS_PARM4_CORE_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG_SYSCALL)

did you check PT_REGS_PARM4_CORE() definition? This should be

BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG_SYSCALL)

> +#else /* __PT_PARM4_REG_SYSCALL */
> +#define PT_REGS_PARM4_CORE_SYSCALL(x) PT_REGS_PARM4_CORE(x)
> +#endif
> +#define PT_REGS_PARM5_CORE_SYSCALL(x) PT_REGS_PARM5_CORE(x)
> +
>  #else /* defined(bpf_target_defined) */
>
>  #define PT_REGS_PARM1(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> @@ -290,6 +312,18 @@ struct pt_regs;
>  #define BPF_KPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
>  #define BPF_KRETPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
>
> +#define PT_REGS_PARM1_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> +#define PT_REGS_PARM2_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> +#define PT_REGS_PARM3_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> +#define PT_REGS_PARM4_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> +#define PT_REGS_PARM5_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> +
> +#define PT_REGS_PARM1_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> +#define PT_REGS_PARM2_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> +#define PT_REGS_PARM3_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> +#define PT_REGS_PARM4_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> +#define PT_REGS_PARM5_CORE_SYSCALL(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
> +
>  #endif /* defined(bpf_target_defined) */
>
>  #ifndef ___bpf_concat
> --
> 2.32.0
>
