Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0328264AC3D
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 01:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiLMASq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 19:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiLMASI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 19:18:08 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEADAE4A
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 16:17:53 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id t17so32635372eju.1
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 16:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yatmxdOGZpuiuEupWBUTOisiH+cXWWGTwCwezTkAaTY=;
        b=nGfx567+4/sn5AYkkKmVnbrLmM2yzE0hjCWO84k1FAbQlE2U/tJ41uviJyJuZs4NG3
         lauEdjZq6KIMjbmBGPmpSmNJRSanWLa66n9QHWozLEjPvErx0KdLHpdnakNsIo8L4w2Q
         fNq39/W9WvzjLmLrsiM47Y+UniW+J7TuCRoO6KtRX9IFRyh2kPSMm3woags9krBcOH0P
         SK0fLTDPTp4buAWexPypykRDpTzGNOBxULcCOpYtMC/xI+IBb4hltoxtmoQS03r5YORb
         3mS8EjNWohsED8lIkypufEvBEg3HXclFyUsaf+OVg5XdihGKrRoAYHbhWO50vV60dHML
         VpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yatmxdOGZpuiuEupWBUTOisiH+cXWWGTwCwezTkAaTY=;
        b=kvxIyQFO17z25aZl5/oTsCYjc1FwiasfusOJjclmoRi9elR13IWz1N+yEONPsIlboc
         E0fdYbxbE9rrgOWTX9NQ93O0DgBOEv0ytF8QSZfP7kZBwEKUMm2VNN3EBAEpNGcYDJ3B
         N4jKHnsN2bGSZXA9+TWM0H32i8eLY7HRllyI9SClsvFrNAq+UOGZRk1GS3A+J1YAl6It
         cL5CTWAkIoecf1pfHm3GQPq8hN8OOKGewV92acGmfSH0M2OsCPs0gM/DxhXBxcJvgh1p
         WoV5GIzAITlcX7OLkbKXfBWljmEnLGd8KjlGhVEWD81pcx90VBDk9DceXo0xWeqk8buK
         K+jA==
X-Gm-Message-State: ANoB5pm+m0nO3SxliFHpsntkw9jSIjwjzOLk1RH6ocxa7oTq+16shzOl
        pHYeUryaKr3/5Gn93CDtxmcHrqF20XD4rmZ8r5mk5sByhDk=
X-Google-Smtp-Source: AA0mqf6Rg5ZE/R+WcL2e2J3RpF5FS6tbC6zgb+/5uz3PjSbjB/2hwR5TeRRs+PmdBAbN1cJrFKvJ48UQKpjvTuc6uSQ=
X-Received: by 2002:a17:906:6403:b0:7b2:9667:241e with SMTP id
 d3-20020a170906640300b007b29667241emr81633480ejm.115.1670890671902; Mon, 12
 Dec 2022 16:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20221212091136.969960-1-hengqi.chen@gmail.com>
In-Reply-To: <20221212091136.969960-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Dec 2022 16:17:39 -0800
Message-ID: <CAEf4BzaxYmBxYx=rfAyOn0kBHf3qOt6mPCPsyfrM+3rYcQ8MMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, yangtiezhu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 1:11 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add PT_REGS macros for LoongArch64.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 2972dc25ff72..2d7da1caa961 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -32,6 +32,9 @@
>  #elif defined(__TARGET_ARCH_arc)
>         #define bpf_target_arc
>         #define bpf_target_defined
> +#elif defined(__TARGET_ARCH_loongarch)
> +       #define bpf_target_loongarch
> +       #define bpf_target_defined
>  #else
>
>  /* Fall back to what the compiler says */
> @@ -62,6 +65,9 @@
>  #elif defined(__arc__)
>         #define bpf_target_arc
>         #define bpf_target_defined
> +#elif defined(__loongarch__) && __loongarch_grlen == 64
> +       #define bpf_target_loongarch
> +       #define bpf_target_defined
>  #endif /* no compiler target */
>
>  #endif
> @@ -258,6 +264,21 @@ struct pt_regs___arm64 {
>  /* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
>  #define PT_REGS_SYSCALL_REGS(ctx) ctx
>
> +#elif defined(bpf_target_loongarch)
> +
> +#define __PT_PARM1_REG regs[5]
> +#define __PT_PARM2_REG regs[6]
> +#define __PT_PARM3_REG regs[7]
> +#define __PT_PARM4_REG regs[8]
> +#define __PT_PARM5_REG regs[9]
> +#define __PT_RET_REG regs[1]
> +#define __PT_FP_REG regs[22]
> +#define __PT_RC_REG regs[4]
> +#define __PT_SP_REG regs[3]
> +#define __PT_IP_REG csr_era
> +/* loongarch does not select ARCH_HAS_SYSCALL_WRAPPER. */
> +#define PT_REGS_SYSCALL_REGS(ctx) ctx

Is there some online documentation explaining this architecture's
calling conventions? It would be useful to include that as a comment
to be able to refer back to it. On a related note, are there any
syscall specific calling convention differences, similar to
PT_REGS_PARM1_SYSCALL for arm64 or PT_REGS_PARM4_SYSCALL for x86-64?

> +
>  #endif
>
>  #if defined(bpf_target_defined)
> --
> 2.31.1
