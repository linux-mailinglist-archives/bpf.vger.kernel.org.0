Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B347A656635
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 01:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiL0ANt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Dec 2022 19:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiL0ANs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Dec 2022 19:13:48 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C525E6
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 16:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1672100020; bh=ORItN6HMFDhSfD5AXRtkrNg+ZN77mDIU+g1ZnrIzloI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Qc/d73mA+Ctu9mXfY+hpOnKyMLzZydaW7/ky1g2FXhj7UvhaFO2raCsQCiKzE/dwY
         fXR6ZavQqWaalLV1tFjW7/xlDStf4nfW81dBZC4cOqRFR2Ff9QtT02DqkGqHjEvGpq
         KRX+pEjWw2PWvom6cMJOdEsKlm+eMboMRmdWFurI=
Received: from [192.168.9.172] (unknown [101.88.134.93])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 538D2600DA;
        Tue, 27 Dec 2022 08:13:40 +0800 (CST)
Message-ID: <45308e1d-4cbb-5f77-f66d-94917b7e26a4@xen0n.name>
Date:   Tue, 27 Dec 2022 08:13:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Firefox/110.0 Thunderbird/110.0a1
Subject: Re: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
To:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
        loongarch@lists.linux.dev, andrii@kernel.org
References: <20221225120138.1236072-1-hengqi.chen@gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20221225120138.1236072-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 12/25/22 20:01, Hengqi Chen wrote:
> Add PT_REGS macros for LoongArch64 ([0]).
>
>    [0]: https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   tools/lib/bpf/bpf_tracing.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 2972dc25ff72..5a8a0830d133 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -32,6 +32,9 @@
>   #elif defined(__TARGET_ARCH_arc)
>   	#define bpf_target_arc
>   	#define bpf_target_defined
> +#elif defined(__TARGET_ARCH_loongarch)
> +	#define bpf_target_loongarch
> +	#define bpf_target_defined
>   #else
>
>   /* Fall back to what the compiler says */
> @@ -62,6 +65,9 @@
>   #elif defined(__arc__)
>   	#define bpf_target_arc
>   	#define bpf_target_defined
> +#elif defined(__loongarch__) && __loongarch_grlen == 64

Isn't the whole patch independent of bitness? I'd suggest just removing 
this GRLen check so we don't need another change when we want 
LoongArch32 too.

Please adjust the commit message wording accordingly too.

> +	#define bpf_target_loongarch
> +	#define bpf_target_defined
>   #endif /* no compiler target */
>
>   #endif
> @@ -258,6 +264,21 @@ struct pt_regs___arm64 {
>   /* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
>   #define PT_REGS_SYSCALL_REGS(ctx) ctx
>
> +#elif defined(bpf_target_loongarch)
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
>   #endif
>
>   #if defined(bpf_target_defined)
> --
> 2.31.1
>
-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

