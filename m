Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A1865BC5D
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 09:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjACIj6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 03:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjACIjr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 03:39:47 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32143BE1F;
        Tue,  3 Jan 2023 00:39:46 -0800 (PST)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NmQzh4gJHzJpXn;
        Tue,  3 Jan 2023 16:35:44 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 16:39:42 +0800
Message-ID: <09763a5e-22c9-513d-ca51-9234478b9c67@huawei.com>
Date:   Tue, 3 Jan 2023 16:39:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH bpf-next 3/4] riscv, bpf: Add bpf_arch_text_poke
 support for RV64
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
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
        Albert Ou <aou@eecs.berkeley.edu>
References: <20221219133736.1387008-1-pulehui@huaweicloud.com>
 <20221219133736.1387008-4-pulehui@huaweicloud.com>
 <87v8looypd.fsf@all.your.base.are.belong.to.us>
 <713f9f26-da42-eda8-c804-338d61b1557c@huawei.com>
 <877cy4xc2l.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <877cy4xc2l.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2023/1/3 16:21, Björn Töpel wrote:
> Pu Lehui <pulehui@huawei.com> writes:
> 
>> On 2023/1/3 15:37, Björn Töpel wrote:
>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>
>>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>>>> index bf4721a99a09..fa8b03c52463 100644
>>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>>
>>>> @@ -1266,7 +1389,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>>>    
>>>>    void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>>>>    {
>>>> -	int stack_adjust = 0, store_offset, bpf_stack_adjust;
>>>> +	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
>>>>    	bool is_main_prog = ctx->prog->aux->func_idx == 0;
>>>
>>> This line magically appeared, and makes it hard to apply the series
>>> without hacking the patches manually. Going forward, please supply a
>>> base tree commit to the series (or a link to a complete git tree).
>>>
>>
>> A rebase version has been resend as follow:
>>
>> https://lore.kernel.org/bpf/20221220021319.1655871-1-pulehui@huaweicloud.com/
> 
> Yes, but with the same issue:
> https://lore.kernel.org/bpf/20221220021319.1655871-4-pulehui@huaweicloud.com/
> 
> The "is_main_prog" line is still around in the resend.
> 

Oops, something was left when debugging mixing bpf2bpf and tailcalls. 
Sorry, will send v2.

> 
> Björn
