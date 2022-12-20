Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453FE6518C6
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 03:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiLTCch (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 21:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiLTCch (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 21:32:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9458DE0BA;
        Mon, 19 Dec 2022 18:32:35 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NbgYx6xz5zJqV7;
        Tue, 20 Dec 2022 10:31:33 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 10:32:32 +0800
Message-ID: <a2bf7ed9-4977-608c-d5a5-8ee6a520cf52@huawei.com>
Date:   Tue, 20 Dec 2022 10:32:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH RESEND bpf-next 1/4] bpf: Rollback to text_poke when
 arch not supported ftrace direct call
Content-Language: en-US
To:     Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>
References: <20221220021319.1655871-1-pulehui@huaweicloud.com>
 <20221220021319.1655871-2-pulehui@huaweicloud.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <20221220021319.1655871-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/20/2022 10:13 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> The current bpf trampoline attach to kernel functions via ftrace direct
> call API, while text_poke is applied for bpf2bpf attach and tail call
> optimization. For architectures that do not support ftrace direct call,
> text_poke is still able to attach bpf trampoline to kernel functions.
> Let's relax it by rollback to text_poke when architecture not supported.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   kernel/bpf/trampoline.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index d6395215b849..386197a7952c 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -228,15 +228,11 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
>   static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>   {
>   	void *ip = tr->func.addr;
> -	unsigned long faddr;
>   	int ret;
>   
> -	faddr = ftrace_location((unsigned long)ip);
> -	if (faddr) {
> -		if (!tr->fops)
> -			return -ENOTSUPP;
> +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) &&
> +	    !!ftrace_location((unsigned long)ip))
>   		tr->func.ftrace_managed = true;
> -	}
>

After this patch, a kernel function with true trace_location will be patched
by bpf when CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is disabled, which means
that a kernel function may be patched by both bpf and ftrace in a mutually
unaware way. This will cause ftrace and bpf_arch_text_poke to fail in a
somewhat random way if the function to be patched was already patched
by the other.

>   	if (bpf_trampoline_module_get(tr))
>   		return -ENOENT;

