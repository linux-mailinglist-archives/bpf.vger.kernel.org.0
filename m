Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B5E4DE6E4
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 09:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbiCSIBx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 04:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbiCSIBw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 04:01:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966ED39165
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 01:00:28 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KLCwk6s93zcb0d;
        Sat, 19 Mar 2022 16:00:22 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sat, 19 Mar 2022 16:00:25 +0800
Message-ID: <37ac211e-33cc-a7b5-ae75-89d1d6d91c11@huawei.com>
Date:   Sat, 19 Mar 2022 16:00:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH bpf-next v4 3/4] bpf, arm64: adjust the offset of
 str/ldr(immediate) to positive number
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
References: <20220317140243.212509-1-xukuohai@huawei.com>
 <20220317140243.212509-4-xukuohai@huawei.com>
 <b45a3be2-58f2-bbad-0ca2-32f3ffde130a@iogearbox.net>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <b45a3be2-58f2-bbad-0ca2-32f3ffde130a@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
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

On 2022/3/18 22:41, Daniel Borkmann wrote:
> On 3/17/22 3:02 PM, Xu Kuohai wrote:
>> The BPF STX/LDX instruction uses offset relative to the FP to address
>> stack space. Since the BPF_FP locates at the top of the frame, the offset
>> is usually a negative number. However, arm64 str/ldr immediate 
>> instruction
>> requires that offset be a positive number.  Therefore, this patch 
>> tries to
>> convert the offsets.
>>
>> The method is to find the negative offset furthest from the FP firstly.
>> Then add it to the FP, calculate a bottom position, called FPB, and then
>> adjust the offsets in other STR/LDX instructions relative to FPB.
>>
>> FPB is saved using the callee-saved register x27 of arm64 which is not
>> used yet.
>>
>> Before adjusting the offset, the patch checks every instruction to ensure
>> that the FP does not change in run-time. If the FP may change, no offset
>> is adjusted.
>>
>> For example, for the following bpftrace command:
>>
>>    bpftrace -e 'kprobe:do_sys_open { printf("opening: %s\n", 
>> str(arg1)); }'
>>
>> Without this patch, jited code(fragment):
>>
>>     0:   bti     c
>>     4:   stp     x29, x30, [sp, #-16]!
>>     8:   mov     x29, sp
>>     c:   stp     x19, x20, [sp, #-16]!
>>    10:   stp     x21, x22, [sp, #-16]!
>>    14:   stp     x25, x26, [sp, #-16]!
>>    18:   mov     x25, sp
>>    1c:   mov     x26, #0x0                       // #0
>>    20:   bti     j
>>    24:   sub     sp, sp, #0x90
>>    28:   add     x19, x0, #0x0
>>    2c:   mov     x0, #0x0                        // #0
>>    30:   mov     x10, #0xffffffffffffff78        // #-136
>>    34:   str     x0, [x25, x10]
>>    38:   mov     x10, #0xffffffffffffff80        // #-128
>>    3c:   str     x0, [x25, x10]
>>    40:   mov     x10, #0xffffffffffffff88        // #-120
>>    44:   str     x0, [x25, x10]
>>    48:   mov     x10, #0xffffffffffffff90        // #-112
>>    4c:   str     x0, [x25, x10]
>>    50:   mov     x10, #0xffffffffffffff98        // #-104
>>    54:   str     x0, [x25, x10]
>>    58:   mov     x10, #0xffffffffffffffa0        // #-96
>>    5c:   str     x0, [x25, x10]
>>    60:   mov     x10, #0xffffffffffffffa8        // #-88
>>    64:   str     x0, [x25, x10]
>>    68:   mov     x10, #0xffffffffffffffb0        // #-80
>>    6c:   str     x0, [x25, x10]
>>    70:   mov     x10, #0xffffffffffffffb8        // #-72
>>    74:   str     x0, [x25, x10]
>>    78:   mov     x10, #0xffffffffffffffc0        // #-64
>>    7c:   str     x0, [x25, x10]
>>    80:   mov     x10, #0xffffffffffffffc8        // #-56
>>    84:   str     x0, [x25, x10]
>>    88:   mov     x10, #0xffffffffffffffd0        // #-48
>>    8c:   str     x0, [x25, x10]
>>    90:   mov     x10, #0xffffffffffffffd8        // #-40
>>    94:   str     x0, [x25, x10]
>>    98:   mov     x10, #0xffffffffffffffe0        // #-32
>>    9c:   str     x0, [x25, x10]
>>    a0:   mov     x10, #0xffffffffffffffe8        // #-24
>>    a4:   str     x0, [x25, x10]
>>    a8:   mov     x10, #0xfffffffffffffff0        // #-16
>>    ac:   str     x0, [x25, x10]
>>    b0:   mov     x10, #0xfffffffffffffff8        // #-8
>>    b4:   str     x0, [x25, x10]
>>    b8:   mov     x10, #0x8                       // #8
>>    bc:   ldr     x2, [x19, x10]
>>    [...]
>>
>> With this patch, jited code(fragment):
>>
>>     0:   bti     c
>>     4:   stp     x29, x30, [sp, #-16]!
>>     8:   mov     x29, sp
>>     c:   stp     x19, x20, [sp, #-16]!
>>    10:   stp     x21, x22, [sp, #-16]!
>>    14:   stp     x25, x26, [sp, #-16]!
>>    18:   stp     x27, x28, [sp, #-16]!
>>    1c:   mov     x25, sp
>>    20:   sub     x27, x25, #0x88
>>    24:   mov     x26, #0x0                       // #0
>>    28:   bti     j
>>    2c:   sub     sp, sp, #0x90
>>    30:   add     x19, x0, #0x0
>>    34:   mov     x0, #0x0                        // #0
>>    38:   str     x0, [x27]
>>    3c:   str     x0, [x27, #8]
>>    40:   str     x0, [x27, #16]
>>    44:   str     x0, [x27, #24]
>>    48:   str     x0, [x27, #32]
>>    4c:   str     x0, [x27, #40]
>>    50:   str     x0, [x27, #48]
>>    54:   str     x0, [x27, #56]
>>    58:   str     x0, [x27, #64]
>>    5c:   str     x0, [x27, #72]
>>    60:   str     x0, [x27, #80]
>>    64:   str     x0, [x27, #88]
>>    68:   str     x0, [x27, #96]
>>    6c:   str     x0, [x27, #104]
>>    70:   str     x0, [x27, #112]
>>    74:   str     x0, [x27, #120]
>>    78:   str     x0, [x27, #128]
>>    7c:   ldr     x2, [x19, #8]
>>    [...]
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> Could you elaborate how this works across tail calls / bpf2bpf calls? 
> Could we
> run into a situation where is_lsi_offset() on off_adj doesn't hold true 
> anymore
> and we ended up emitting e.g. STR32I instead of MOV_I+STR32?
> 
> Thanks,
> Daniel
> .

Thanks for the pointing this out. There's a bug here.

1. The fp bottom is calculated in the prologue before tail call entry,
    so if the caller has a different fp bottom than the callee, the
    off_adj in callee's str/ldr will be wrong.

    For example, for the following two pieces of code, prog1 loads 64bits
    data from FP - 16, prog2 write 7 to FP - 8, when prog2 calls prog1
    via tail call, the data prog1 read out is 7!

    prog1:
     BPF_LDX_MEM(BPF_DW, R0, BPF_REG_FP, -16)
     BPF_EXIT_INSN()

    prog2:
     BPF_ALU64_IMM(BPF_MOV, R0, 7)
     BPF_STX_MEM(BPF_DW, BPF_REG_FP, R0, -8)
     TAIL_CALL(-1)

    The reason is that the fp bottom in prog2 is FP - 8, and the fp
    bottom is not updated during tail call, so when prog1 reads data from
    fp bottom, it acctually reads from FP - 8.

    jited prog1:
     sub x27, x25, #0x10 // calculate and store fp bottom, x27 = fp - 16
     bti j               // tail call entry     <----------------------
     ldr x7, [x27]       // load data from fp bottom + 0               |
                                                                       |
    jited prog2:                                                       |
     sub x27, x25, #0x8 // calculate and store fp bottom, x27 = fp - 8 |
     bti j                                                             |
     mov x7, #0x7                                                      |
     str x7, [x27]      // store 7 to fp bottom + 0                    |
     ...                                                               |
     br x10 // tail call prog1  ---------------------------------------

    This issue can be fixed by calculating fp bottom after the tail call
    entry:

     bti j               // tail call entry
     sub x27, x25, #0x10 // calculate and store fp bottom, x27 = fp - 16
     ldr x7, [x27]       // load data from bottom + 0

2. For bpf2bpf calls, the call entry is callee's first instruction, so
    the fp bottom will be updated every time, seems to be fine.
