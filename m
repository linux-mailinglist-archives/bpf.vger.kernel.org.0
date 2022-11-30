Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A2863CCC1
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 02:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiK3BRQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 20:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiK3BRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 20:17:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40CF6F832;
        Tue, 29 Nov 2022 17:17:13 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NMLrb3r1qzmWGY;
        Wed, 30 Nov 2022 09:16:31 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 09:17:11 +0800
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 09:17:11 +0800
Message-ID: <58c3e30e-f283-5d50-5aba-1fe16f1257a3@huawei.com>
Date:   Wed, 30 Nov 2022 09:17:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH bpf] bpf, docs: Correct the example of BPF_XOR
To:     David Vernet <void@manifault.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <corbet@lwn.net>,
        <bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221129134558.2757043-1-zhengyejian1@huawei.com>
 <Y4ZVUiwGnVIj/V4U@maniforge.lan>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <Y4ZVUiwGnVIj/V4U@maniforge.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/11/30 02:54, David Vernet wrote:
> On Tue, Nov 29, 2022 at 09:45:58PM +0800, Zheng Yejian wrote:
>> Refer to description of BPF_XOR, dst_reg should be used but not src_reg
>> in the examples.
>>
>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>> ---
>>   Documentation/bpf/instruction-set.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
>> index 5d798437dad4..e672d5ec6cc7 100644
>> --- a/Documentation/bpf/instruction-set.rst
>> +++ b/Documentation/bpf/instruction-set.rst
>> @@ -122,11 +122,11 @@ BPF_END   0xd0   byte swap operations (see `Byte swap instructions`_ below)
>>   
>>   ``BPF_XOR | BPF_K | BPF_ALU`` means::
>>   
>> -  src_reg = (u32) src_reg ^ (u32) imm32
>> +  dst_reg = (u32) dst_reg ^ (u32) imm32
> 
> Shouldn't this be
> 
> dst_reg = (u32) dst_reg ^ (u32) src_reg
> 
> Same idea below for 64 bit

See Chapter 'Instruction classes', BPF_K means "use 32-bit immediate as 
source operand", so it should be 'imm32' instead of 'src_reg'.

> 
>>   
>>   ``BPF_XOR | BPF_K | BPF_ALU64`` means::
>>   
>> -  src_reg = src_reg ^ imm32
>> +  dst_reg = dst_reg ^ imm32
>>   
>>   
>>   Byte swap instructions
>> -- 
>> 2.25.1
>>
> 
