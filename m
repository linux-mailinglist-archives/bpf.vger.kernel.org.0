Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2353B4D9259
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 02:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245421AbiCOB4S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 21:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiCOB4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 21:56:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393A33A726
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 18:55:07 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KHbzP6VdLzfZ7q;
        Tue, 15 Mar 2022 09:53:37 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 09:55:04 +0800
Message-ID: <e87d000c-8f1c-2826-115b-89044ca28fc6@huawei.com>
Date:   Tue, 15 Mar 2022 09:55:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH bpf-next v2] bpf, arm64: Optimize BPF store/load using
 str/ldr with immediate offset
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hou Tao <houtao1@huawei.com>, Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>
References: <20220314084850.1329209-1-xukuohai@huawei.com>
 <fe0af43b-b675-18bd-dede-3d79baa94f06@iogearbox.net>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <fe0af43b-b675-18bd-dede-3d79baa94f06@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/3/15 6:11, Daniel Borkmann wrote:
> On 3/14/22 9:48 AM, Xu Kuohai wrote:
>> The current BPF store/load instruction is translated by the JIT into two
>> instructions. The first instruction moves the immediate offset into a
>> temporary register. The second instruction uses this temporary register
>> to do the real store/load.
>>
>> In fact, arm64 supports addressing with immediate offsets. So This patch
>> introduces optimization that uses arm64 str/ldr instruction with 
>> immediate
>> offset when the offset fits.
>>
>> Example of generated instuction for r2 = *(u64 *)(r1 + 0):
>>
>> without optimization:
>> mov x10, 0
>> ldr x1, [x0, x10]
>>
>> with optimization:
>> ldr x1, [x0, 0]
>>
>> If the offset is negative, or is not aligned correctly, or exceeds max
>> value, rollback to the use of temporary register.
>>
>> Result for test_bpf:
>>   # dmesg -D
>>   # insmod test_bpf.ko
>>   # dmesg | grep Summary
>>   test_bpf: Summary: 1009 PASSED, 0 FAILED, [997/997 JIT'ed]
>>   test_bpf: test_tail_calls: Summary: 8 PASSED, 0 FAILED, [8/8 JIT'ed]
>>   test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> [...]
> 
> Thanks for working on this and also including the result for test_bpf! 
> Does it also contain corner cases where the rollback to the temporary register is
> triggered? (If not, lets add more test cases to it.)

Yes, I'll check and add some corner cases.

> 
> Could you split this into two patches, one that touches 
> arch/arm64/lib/insn.c
> and arch/arm64/include/asm/insn.h for the instruction encoder, and then the
> other part for the JIT-only bits?

OK, will split in v3.

> 
> Will, would you be okay if we route this via bpf-next with your Ack, or 
> do we need to pull feature branch again?
> 

I'm fine with bpf-next.

> Thanks,
> Daniel
> .

