Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC75EC55B
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 16:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiI0OCY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiI0OB5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 10:01:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9367B793;
        Tue, 27 Sep 2022 07:01:11 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4McLlT52SzzlXJT;
        Tue, 27 Sep 2022 21:56:53 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 22:01:08 +0800
Message-ID: <30bbaf09-1c2f-72fb-98cd-afe75849261c@huawei.com>
Date:   Tue, 27 Sep 2022 22:01:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RESEND PATCH bpf-next 1/2] bpf, arm64: Jit BPF_CALL to direct
 call when possible
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <mark.rutland@arm.com>,
        <revest@chromium.org>
References: <20220919092138.1027353-1-xukuohai@huaweicloud.com>
 <20220919092138.1027353-2-xukuohai@huaweicloud.com>
 <21073277-5bbd-5555-88f2-76b07ad9b74f@iogearbox.net>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <21073277-5bbd-5555-88f2-76b07ad9b74f@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/27/2022 4:29 AM, Daniel Borkmann wrote:
> [ +Mark/Florent ]
> 
> On 9/19/22 11:21 AM, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> Currently BPF_CALL is always jited to indirect call, but when target is
>> in the range of direct call, BPF_CALL can be jited to direct call.
>>
>> For example, the following BPF_CALL
>>
>>      call __htab_map_lookup_elem
>>
>> is always jited to an indirect call:
>>
>>      mov     x10, #0xffffffffffff18f4
>>      movk    x10, #0x821, lsl #16
>>      movk    x10, #0x8000, lsl #32
>>      blr     x10
>>
>> When the target is in the range of direct call, it can be jited to:
>>
>>      bl      0xfffffffffd33bc98
>>
>> This patch does such jit when possible.
>>
>> 1. First pass, get the maximum jited image size. Since the jited image
>>     memory is not allocated yet, the distance between jited BPF_CALL
>>     instructon and call target is unknown, so jit all BPF_CALL to indirect
>>     call to get the maximum image size.
>>
>> 2. Allocate image memory with the size caculated in step 1.
>>
>> 3. Second pass, determine the jited address and size for every bpf instruction.
>>     Since image memory is now allocated and there is only one jit method for
>>     bpf instructions other than BPF_CALL, so the jited address for the first
>>     BPF_CALL is determined, so the distance to call target is determined, so
>>     the first BPF_CALL is determined to be jited to direct or indirect call,
>>     so the jited image size after the first BPF_CALL is determined. By analogy,
>>     the jited addresses and sizes for all subsequent BPF instructions are
>>     determined.
>>
>> 4. Last pass, generate the final image. The jump offset of jump instruction
>>     whose target is within the jited image is determined in this pass, since
>>     the target instruction address may be changed in step 3.
> 
> Wouldn't this require similar convergence process like in x86-64 JIT? You state
> the jump instructions are placed in step 4 because step 3 could have changed their
> offsets, but then after step 4, couldn't also again the offsets have changed for
> the target addresses from 3 again in some corner cases (given emit_a64_mov_i() is
> used also in jump encoding)?
> 

IIUC, the reason why there is a convergence process on x86 is that x86's jmp
instruction length varies with the size of immediate part, so after immediate
part is adjusted, the instruction length may change accordingly, and consequently
cause the positions of subsequent instructions to change, which in turn causes
the distance between instructions to change. However, arm64's instruction size
is fixed to 4 bytes and does not change with immediate part changes. So adjusting
the immediate part of arm64 jump instruction does not result in a change in
instruction length or position.

For BPF_CALL, arguments passed to emit_call() and emit_a64_mov_i() (if called)
do not change in pass 3 and 4, so the jited result does not change. This is also
true for other non-BPF_JMP instructions.

So no convergence is required on arm64.

>> Tested with test_bpf.ko and some arm64 working selftests, nothing failed.

[...]

