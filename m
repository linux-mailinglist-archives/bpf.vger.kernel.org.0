Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22550669908
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbjAMNul (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 08:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjAMNuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 08:50:23 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBD5D6DBB0
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 05:45:09 -0800 (PST)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NtjGz746MzJqHV;
        Fri, 13 Jan 2023 21:40:43 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 21:44:53 +0800
Message-ID: <fe0c092e-acf2-2173-a927-15e7880479c9@huawei.com>
Date:   Fri, 13 Jan 2023 21:44:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next 21/25] libbpf: define riscv syscall regs spec in
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
 <20230113083404.4015489-22-andrii@kernel.org>
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230113083404.4015489-22-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2023/1/13 16:34, Andrii Nakryiko wrote:
> Define explicit table of registers used for syscall argument passing.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/lib/bpf/bpf_tracing.h | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index b05420b57889..7a4b8b1f0177 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -359,13 +359,21 @@ struct pt_regs___arm64 {
>   #define __PT_PARM6_REG a5
>   #define __PT_PARM7_REG a6
>   #define __PT_PARM8_REG a7
> +
> +/* riscv does not select ARCH_HAS_SYSCALL_WRAPPER. */
> +#define PT_REGS_SYSCALL_REGS(ctx) ctx
> +#define __PT_PARM1_SYSCALL_REG __PT_PARM1_REG
> +#define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
> +#define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
> +#define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
> +#define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
> +#define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
> +
>   #define __PT_RET_REG ra
>   #define __PT_FP_REG s0
>   #define __PT_RC_REG a0
>   #define __PT_SP_REG sp
>   #define __PT_IP_REG pc
> -/* riscv does not select ARCH_HAS_SYSCALL_WRAPPER. */
> -#define PT_REGS_SYSCALL_REGS(ctx) ctx
>   
>   #elif defined(bpf_target_arc)
>   

Tested-by: Pu Lehui <pulehui@huawei.com> # RISC-V
