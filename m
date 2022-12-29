Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA62659312
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 00:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiL2XMB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 18:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiL2XMB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 18:12:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC433FF5
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 15:11:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g1so14266756edj.8
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 15:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fr5Dp6z4f+jilNzGhOxLLdNUpFY97wXoG/UnXaa4JzU=;
        b=S6wwXFolr/ilVUjRpBaJWRjhiDU+FZiMD6RDgZqX5qWFjIR3kzcMshAaPepDvivql1
         UeFWCJ+0pHg4CS9rmbJ+Tp9pyeRr/dhn9GWxTqQWCh/UCqjjMkswROYPXZ47t25PtG0X
         ir5MTNurB5Ue3ZFMVw163nvOQ37qtR6ysnpp45Y94lKH/Ib5rhSItAyw6/ERFnuIfpg0
         dp0479Nik1GUjrp3aCA2v5h3oIz0zXqeaEK+pgOKCHUaxCdnoldmyItsIIE7r5soz7JQ
         yk03fXD1wafsJWgJBKNMAm/mRbKg7yImq/eBLJ1w9VAuVWl8cKZSxsqxJ44EzPairvJw
         HVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fr5Dp6z4f+jilNzGhOxLLdNUpFY97wXoG/UnXaa4JzU=;
        b=3Ics8T2ZtEAqowX6d6OHeXpMnVNgKn0NL6OtFwlxL9+FIMnIlcla3Wr8PpFxcYX6EP
         FqSJu62m5ZM2PU/3xejKpUmWYJI5LI9tJu6wLEeahiP2L2w7HDzipARPHdzgOA3++3cS
         z9ds6vg6vNdypwv95au5+A9bearqRfomGzGqUERVTtFHNujhvyBG7kRSCjNcC4RcutQ4
         NQmw+L/eaORZpMO/opUChbO6fH3ZlYlPM43La4pDqFHvORStJZZw3tPENeg1vNbxZcA/
         W2gMQL3gGbE46vBYZUcBYupsTrXkJJ9zdcloHItKKm2aTtK6yQnRPVbcrPCI6VA619Pd
         sB0w==
X-Gm-Message-State: AFqh2koJsMxhG9vKaU7noNBhgpHQm2GcyycbtdZcjOkk10ooxFbZPg80
        iGCZMikO4pH1ZxWCgeT+8bXtnPhTUtZdZiVZSgY=
X-Google-Smtp-Source: AMrXdXsgC47xYvfabST0IS+bdmGgXf5W0aQFJNuccqvnuocz8xmo7N2LYY2P3zDLoNkOiG1zNlRKCAhNJKkTMRtg5Eg=
X-Received: by 2002:aa7:cb52:0:b0:484:93ac:33a6 with SMTP id
 w18-20020aa7cb52000000b0048493ac33a6mr1289797edt.81.1672355518400; Thu, 29
 Dec 2022 15:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20221225120138.1236072-1-hengqi.chen@gmail.com>
In-Reply-To: <20221225120138.1236072-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Dec 2022 15:11:46 -0800
Message-ID: <CAEf4BzYzjJWy=hYp0vQBTW1Q0UODLeeq+bHSdjvkhNXGGpp4wQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev, andrii@kernel.org
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

On Sun, Dec 25, 2022 at 4:02 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add PT_REGS macros for LoongArch64 ([0]).
>
>   [0]: https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 2972dc25ff72..5a8a0830d133 100644
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

please put https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html
in a comment somewhere here


> +#define __PT_PARM1_REG regs[4]
> +#define __PT_PARM2_REG regs[5]
> +#define __PT_PARM3_REG regs[6]
> +#define __PT_PARM4_REG regs[7]
> +#define __PT_PARM5_REG regs[8]
> +#define __PT_RET_REG regs[1]
> +#define __PT_FP_REG regs[22]
> +#define __PT_RC_REG regs[4]
> +#define __PT_SP_REG regs[3]
> +#define __PT_IP_REG csr_era
> +/* loongarch does not select ARCH_HAS_SYSCALL_WRAPPER. */
> +#define PT_REGS_SYSCALL_REGS(ctx) ctx
> +
>  #endif
>
>  #if defined(bpf_target_defined)
> --
> 2.31.1
