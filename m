Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC49B669900
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 14:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbjAMNtQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 08:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241876AbjAMNsi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 08:48:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC61FF
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 05:43:53 -0800 (PST)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NtjJT5SbjzRrDL;
        Fri, 13 Jan 2023 21:42:01 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 21:43:46 +0800
Message-ID: <b048fd6a-d3aa-ca03-2518-e7199dd9718b@huawei.com>
Date:   Fri, 13 Jan 2023 21:43:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next 07/25] libbpf: complete riscv arch spec in
 bpf_tracing.h
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Alan Maguire <alan.maguire@oracle.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Vladimir Isaev <isaev@synopsys.com>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Florent Revest <revest@chromium.org>
References: <20230113083404.4015489-1-andrii@kernel.org>
 <20230113083404.4015489-8-andrii@kernel.org>
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230113083404.4015489-8-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2023/1/13 16:33, Andrii Nakryiko wrote:
> Add PARM6 through PARM8 definitions for RISC V (riscv) arch. Leave the
> link for ABI doc for future reference.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/lib/bpf/bpf_tracing.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 0f9640ddbe1c..579e2f830532 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -268,12 +268,19 @@ struct pt_regs___arm64 {
>   
>   #elif defined(bpf_target_riscv)
>   
> +/*
> + * https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc#risc-v-calling-conventions
> + */
> +
>   #define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
>   #define __PT_PARM1_REG a0
>   #define __PT_PARM2_REG a1
>   #define __PT_PARM3_REG a2
>   #define __PT_PARM4_REG a3
>   #define __PT_PARM5_REG a4
> +#define __PT_PARM6_REG a5
> +#define __PT_PARM7_REG a6
> +#define __PT_PARM8_REG a7
>   #define __PT_RET_REG ra
>   #define __PT_FP_REG s0
>   #define __PT_RC_REG a0

Hi Andrii,

Looks fine and tests passed as follow:

#233     uprobe_autoattach:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

#19      bpf_syscall_macro:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Tested-by: Pu Lehui <pulehui@huawei.com> # RISC-V

Best Regards,
Lehui
