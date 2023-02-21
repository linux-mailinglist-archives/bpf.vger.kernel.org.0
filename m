Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CA869E17E
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 14:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjBUNkB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 08:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjBUNkA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 08:40:00 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F7029412;
        Tue, 21 Feb 2023 05:39:54 -0800 (PST)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PLgM547Jhz16Nj4;
        Tue, 21 Feb 2023 21:37:21 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Feb 2023 21:39:49 +0800
Message-ID: <1a02055f-deff-649f-9564-417ae916ddb3@huawei.com>
Date:   Tue, 21 Feb 2023 21:39:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next v2] riscv, bpf: Add kfunc support for RV64
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
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <87h6vffqlo.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <87h6vffqlo.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2023/2/21 15:02, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> On 2023/2/20 22:34, Björn Töpel wrote:
>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> As another important missing piece of RV64 JIT, kfunc allow bpf programs
>>>> call kernel functions. For now, RV64 is sufficient to enable it.
>>>
>>> Thanks Lehui!
>>>
>>> Maybe we can reword/massage the commit message a bit? What do you think
>>> about something like:
>>>
>>> "Now that the BPF trampoline is supported by RISC-V, it is possible to
>>> use BPF programs with kfunc calls.
>>>
>>
>> kfunc and bpf trampoline are functionally independent. kfunc [1], like
>> bpf helper functions, allows bpf programs to call exported kernel
>> functions, while bpf trampoline provides a more efficient way than
>> kprobe to act as a mediator between kernel functions and bpf programs,
>> and between bpf programs.
>>
>> In fact, it was already supported before the bpf trampoline
>> implementation, I just turned it on.
> 
> Good point. I guess my (incorrect) kfunc mental model was that
> struct_ops and kfunc were tightly coupled. (Then again, w/o struct_ops
> working kfunc is a bit half-working in my view.)
> 
> Fair enough. I'm still a bit confused about the commit message, but
> happy with the patch.
>  > Acked-by: Björn Töpel <bjorn@rivosinc.com>

Thanks Bjorn, will rewrite commit message to make more sense, and send 
new soon.
