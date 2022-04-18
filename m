Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712CA505E3F
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 21:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245191AbiDRTNw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347571AbiDRTNv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 15:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A032ED0
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 12:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94E5D60C51
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 19:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4CBC385B8;
        Mon, 18 Apr 2022 19:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309071;
        bh=MSCDJnw1/K9quNUiPMqH7e7yiqW+OPSSFVw1XfBUK0o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RIv0SmqwZb2XQYUcwcpq8lKeKxxfzRMP8SZuzHzYwP0prdSrNoqiKzyDwArXuqkex
         yv1dUCHSzgmVezdU/crYUeissw9uK+bG4jtQz55mi+Xb7M3bAQsl71pZ/59FfshUPe
         EGgLL8mQZ2A0NPzegJW1iIBB1nBExZdTmVjgSL31BXuWnLRdwAoVohFJhk2SXTFrpi
         sXUGzSDJ0nQWWdhyG9AipwdVOyO5jyi7tBVja8tjj3Wfa8+2XTycfTDgSJiQv2DVEA
         HHhqwqPpWdkruIyUgipx4ssS5NntUqCsrab3X3zwSz5trPeGXfLhWwvZ1CWweLVonF
         Oin4m34uDn9HQ==
Message-ID: <5f9fb005-6028-b20d-93cd-1f4f1439dbc8@kernel.org>
Date:   Mon, 18 Apr 2022 12:11:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARC: bpf: define uapi for BPF_PROG_TYPE_PERF_EVENT
 program type
Content-Language: en-US
To:     Sergey Matyukevich <geomatsi@gmail.com>, bpf@vger.kernel.org
Cc:     Vladimir Isaev <isaev@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Sergey Matyukevich <sergey.matyukevich@synopsys.com>
References: <20220414081126.3176820-1-geomatsi@gmail.com>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20220414081126.3176820-1-geomatsi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/14/22 01:11, Sergey Matyukevich wrote:
> From: Sergey Matyukevich <sergey.matyukevich@synopsys.com>
>
> Define appropriate uapi for the BPF_PROG_TYPE_PERF_EVENT program type
> by exporting the user_regs_struct structure instead of the pt_regs
> structure that is in-kernel only.
>
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich@synopsys.com>
> ---
>
> Originally I sent this patch via linux-snps-arc mailing list: see [1].
> However this patch accompanies ARC support for libbpf bpf_tracing.h
> accepted to bpf kernel tree: see [2].
>
> So it looks like it makes sense to post this patch here as well.
> I will also update linux-snps-arc patch series accordingly.
>
> Regards,
> Sergey

Applied !

Thx,
-Vineet

>
> [1] https://lore.kernel.org/linux-snps-arc/20220408155804.587197-1-geomatsi@gmail.com/
> [2] https://lore.kernel.org/bpf/20220408224442.599566-1-geomatsi@gmail.com/
>
>
>   arch/arc/include/asm/perf_event.h          | 4 ++++
>   arch/arc/include/uapi/asm/bpf_perf_event.h | 9 +++++++++
>   2 files changed, 13 insertions(+)
>   create mode 100644 arch/arc/include/uapi/asm/bpf_perf_event.h
>
> diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
> index 4c919c0f4b30..d5719a260864 100644
> --- a/arch/arc/include/asm/perf_event.h
> +++ b/arch/arc/include/asm/perf_event.h
> @@ -63,4 +63,8 @@ struct arc_reg_cc_build {
>   
>   #define PERF_COUNT_ARC_HW_MAX	(PERF_COUNT_HW_MAX + 8)
>   
> +#ifdef CONFIG_PERF_EVENTS
> +#define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
> +#endif
> +
>   #endif /* __ASM_PERF_EVENT_H */
> diff --git a/arch/arc/include/uapi/asm/bpf_perf_event.h b/arch/arc/include/uapi/asm/bpf_perf_event.h
> new file mode 100644
> index 000000000000..6cb1c2823288
> --- /dev/null
> +++ b/arch/arc/include/uapi/asm/bpf_perf_event.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
> +#define _UAPI__ASM_BPF_PERF_EVENT_H__
> +
> +#include <asm/ptrace.h>
> +
> +typedef struct user_regs_struct bpf_user_pt_regs_t;
> +
> +#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */

