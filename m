Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E080B65BAF8
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 07:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjACGxo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 01:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjACGxn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 01:53:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE1B48
        for <bpf@vger.kernel.org>; Mon,  2 Jan 2023 22:53:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C94CEB80E14
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 06:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E037C433EF
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 06:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672728819;
        bh=wbWN2d3IanVfbt0qnVLEs1kFgkAHIJ7y4rljhzLPY8U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qjrhz9ud2ZdY5LEz7riR0Atr5StTgwPHE6xvDOBcoQl6jMqUgE+QWn02erYe4a//v
         Ego/2Saxw7Zv0yS+HtVYq24qll4+0YaOh8bLb0wHFPMQmW7QtuWc5+75ovzyJPLEEC
         FYFPtR4y9BGoXcE74hnI3Q1j8B6QCLi+mbWCZhHTqP9GPIbXCKK/mM6AX/Nm+B+eu6
         v2niHbIkcH3Of2vFUplrCIptJN/srX8Cq7IDdPKJad0CVx4hXBeWEpoLHngRpEDvhh
         Cl5eEsTW8zQ06fF50Pdr/jzjxezwUJBvvKx0O2XujKhW4f12752WUb6fgzjfGY0Gbz
         +cwv1pKNnzzmQ==
Received: by mail-ed1-f54.google.com with SMTP id u28so37763985edd.10
        for <bpf@vger.kernel.org>; Mon, 02 Jan 2023 22:53:39 -0800 (PST)
X-Gm-Message-State: AFqh2kp8BB80EcIBYIX48a2YARKU6ClHcFsPuPxkndDhfi/2LvJgrGRR
        GnBuVhkXjXmHwdxOxY/D51+gbeJXLKxbzWL9N5k=
X-Google-Smtp-Source: AMrXdXtsCm2upyz5f+49LawIIF8A7kWqG7pOZzLb+iBBtm0rcndCRzkmW6uY8SF8DerP1ABCrUAJDqvFp3GsAT3vLPA=
X-Received: by 2002:aa7:d44e:0:b0:47f:5431:89ea with SMTP id
 q14-20020aa7d44e000000b0047f543189eamr3703643edr.284.1672728817812; Mon, 02
 Jan 2023 22:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20221231100757.3177034-1-hengqi.chen@gmail.com>
In-Reply-To: <20221231100757.3177034-1-hengqi.chen@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 3 Jan 2023 14:53:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6hdXXE4EwFe66rUxJMixc=s7PYuxeyCjaQ5z3Fck40jA@mail.gmail.com>
Message-ID: <CAAhV-H6hdXXE4EwFe66rUxJMixc=s7PYuxeyCjaQ5z3Fck40jA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LGTM, I will queue this patch for loongarch-next if no one has
objections. Thank you.


On Sat, Dec 31, 2022 at 6:08 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add PT_REGS macros for LoongArch ([0]).
>
>   [0]: https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 9c1b1689068d..bdb0f6b5be84 100644
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
> +#elif defined(__loongarch__)
> +       #define bpf_target_loongarch
> +       #define bpf_target_defined
>  #endif /* no compiler target */
>
>  #endif
> @@ -258,6 +264,23 @@ struct pt_regs___arm64 {
>  /* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
>  #define PT_REGS_SYSCALL_REGS(ctx) ctx
>
> +#elif defined(bpf_target_loongarch)
> +
> +/* https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html */
> +
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
>
