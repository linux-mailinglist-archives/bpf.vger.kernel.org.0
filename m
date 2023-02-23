Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8686A05AE
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 11:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjBWKKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 05:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjBWKK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 05:10:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D9F4ECEB
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 02:10:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso12290841pjb.5
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 02:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8pTyXMbqgjmHwENw9d+YaYdxp8SYMRKyJFLzvCwDT8=;
        b=pr+OJuJc0aIQruCQBm/G/I0SmMi+9ve74/N02LFBP2SF9YF1UCP9B0lIgbsJQ7wdZz
         RT9/2kaH0WUYA1nfmPjFddcx8OY7O5EndTfpmV0+lZsEVYSMrkP7VcYZtGWC8rbqSYsB
         LhfUz5KB1QoRcvaHPPxKWlUww2/C5cj3ApuLobKu5JmhQkgoirvXRIT9MBnYSQZuJIti
         vAmxndH/YLCvSjNSEgbodAt0gyY2dp6SYvfhmqAobI4nqmYYAOBqgvK4Hms6q/xsa7dZ
         CSwKzq0ivytwyXfzyUhQPm8jehE/P18C+7osTa5kwBDthfy8UPebUW3q+gtExz2VVyzn
         d2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8pTyXMbqgjmHwENw9d+YaYdxp8SYMRKyJFLzvCwDT8=;
        b=pWrnBzYk6VDVQQNBmIiQilEx+twCOTtcOtOwdR0c7cdT5MxvPo8eTmt9AS6owc8X8I
         utv7H0CFh9tfXGvO34SI4a2hAXIVgoWoT216r6Gcz0LTGIZdJNRSEv5fFnIK+o3SSqZk
         s+BFgXeVM40kwUNbd2FoaS3ghjT34w0XAe9w6miwfv784NoIeBpqRLTC7ODjSWAWybaZ
         RZuUiZBqv+x56dgy3ZFfmLDQ0xDIHbGjoY6p4tJKnoSLrQiGBWCkuyGgBYlaTA6tkqF+
         IEr8ziC7Kk8OW2tXUL3WxZqi2YNKAHM6QEMTKh4E+8CQyjSyrSTYrdq6d5wbavrK+fEH
         JnJA==
X-Gm-Message-State: AO0yUKW72sZwk0tm9BNtrEhMilYvgE7d5IJFFTEr6dlLNOR5Xf7PwgqB
        BNjjup3Sy/ib1ZwsZesSq2RYlLlmeW7k6m4s3xddFw==
X-Google-Smtp-Source: AK7set/yNWJYaO4UBy+wk5SROh+wtuNxdnuOXVrvBeF3/ECsNSOG69Dgi0lLlVMfqwUfcoUOs63KHq0HprhgR9E35jc=
X-Received: by 2002:a17:90b:384d:b0:237:50b6:983c with SMTP id
 nl13-20020a17090b384d00b0023750b6983cmr1044697pjb.116.1677147018158; Thu, 23
 Feb 2023 02:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com> <20230222161222.11879-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20230222161222.11879-2-jiaxun.yang@flygoat.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Thu, 23 Feb 2023 11:10:07 +0100
Message-ID: <CAM1=_QQRmTaAnn0w6wteQ_FKgoF=vGX_okfbiUHdyUB0ZzNghQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: ebpf jit: Implement DADDI workarounds
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, paulburton@kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 5:12 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> For DADDI errata we just workaround by disable immediate operation
> for BPF_ADD / BPF_SUB to avoid generation of DADDIU.

Good, this is an elegant solution to trigger fallback to the
register-only operation. Does the DADDI errata only affect the DADDIU,
not DADDI?

>
> All other use cases in JIT won't cause overflow thus they are all safe.

There are quite a few other places where DADDIU is emitted. How do you
know those are safe? I am interested in your reasoning here, as I
don't know what would be safe and not.

>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/Kconfig            | 1 -
>  arch/mips/net/bpf_jit_comp.c | 8 ++++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 37072e15b263..df0910e3895c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -64,7 +64,6 @@ config MIPS
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_DYNAMIC_FTRACE
>         select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
> -                               !CPU_DADDI_WORKAROUNDS && \
>                                 !CPU_R4000_WORKAROUNDS && \
>                                 !CPU_R4400_WORKAROUNDS
>         select HAVE_EXIT_THREAD
> diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
> index b17130d510d4..7110a6687f7a 100644
> --- a/arch/mips/net/bpf_jit_comp.c
> +++ b/arch/mips/net/bpf_jit_comp.c
> @@ -218,9 +218,17 @@ bool valid_alu_i(u8 op, s32 imm)
>                 /* All legal eBPF values are valid */
>                 return true;
>         case BPF_ADD:
> +#ifdef CONFIG_64BIT

DADDI/DADDIU are only available on 64-bit CPUs, so the errata would
only be applicable to that. No need for the CONFIG_64BIT conditional.

> +               if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
> +                       return false;
> +#endif
>                 /* imm must be 16 bits */
>                 return imm >= -0x8000 && imm <= 0x7fff;
>         case BPF_SUB:
> +#ifdef CONFIG_64BIT
> +               if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
> +                       return false;
> +#endif
>                 /* -imm must be 16 bits */
>                 return imm >= -0x7fff && imm <= 0x8000;
>         case BPF_AND:
> --
> 2.37.1 (Apple Git-137.1)
>
