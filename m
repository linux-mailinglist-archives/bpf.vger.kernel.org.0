Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDBB6403DB
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 10:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiLBJ6L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 04:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiLBJ6K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 04:58:10 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94177DA51;
        Fri,  2 Dec 2022 01:58:08 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NNpKQ3nBCz4f3rVZ;
        Fri,  2 Dec 2022 17:58:02 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP2 (Coremail) with SMTP id Syh0CgCXrLcrzIljyuECBg--.34797S2;
        Fri, 02 Dec 2022 17:58:05 +0800 (CST)
Message-ID: <85c21f52-2059-f6bb-bbc1-d610cb107995@huaweicloud.com>
Date:   Fri, 2 Dec 2022 17:58:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf] riscv, bpf: Emit fixed-length imm64 for
 BPF_PSEUDO_FUNC
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
References: <20221130033806.2967822-1-pulehui@huaweicloud.com>
 <87h6yg1xlo.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87h6yg1xlo.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCXrLcrzIljyuECBg--.34797S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw15ZF4xKry3WrWUXF1xGrg_yoW5XF13pF
        WUKw4fCF4kXr1xKr1aqr4Yqr1YyF40qF47Wr1aqay5Kryj9Fn29F1DKws8KasxZry8GF13
        JFyjgrnxCa4DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/11/30 19:38, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> For BPF_PSEUDO_FUNC instruction, verifier will refill imm with
>> correct addresses of bpf_calls and then run last pass of JIT.
>> Since the emit_imm of RV64 is variable-length, which will emit
>> appropriate length instructions accorroding to the imm, it may
>> broke ctx->offset, and lead to unpredictable problem, such as
>> inaccurate jump. So let's fix it with fixed-length imm64 insns.
> 
> Ah, nice one! So, the the invariant doesn't hold (the image grow in the
> last pass).
> 
>> Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> 
> This is odd? This can't be the right Fixes-tag...
> 

Only BPF_PSEUDO_FUNC instruction need extra jit pass after refill imm in 
jit_subprogs. Others, like bpf helper call, will update ctx->offset in 
jit iterations. So the fixes-tag is 69c087ba6225.

>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit_comp64.c | 31 ++++++++++++++++++++++++++++++-
>>   1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index eb99df41fa33..f984d5fa014b 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -139,6 +139,30 @@ static bool in_auipc_jalr_range(s64 val)
>>   		val < ((1L << 31) - (1L << 11));
>>   }
>>   
>> +/* Emit fixed-length instructions for 32-bit imm */
>> +static void emit_fixed_imm32(u8 rd, s32 val, struct rv_jit_context *ctx)
>> +{
>> +	s32 upper = (val + (1U << 11)) >> 12;
>> +	s32 lower = ((val & 0xfff) << 20) >> 20;
>> +
>> +	emit(rv_lui(rd, upper), ctx);
>> +	emit(rv_addi(rd, rd, lower), ctx);
>> +}
>> +
>> +/* Emit fixed-length instructions for 64-bit imm */
>> +static void emit_fixed_imm64(u8 rd, s64 val, struct rv_jit_context *ctx)
>> +{
>> +	/* Compensation for sign-extension of rv_addi */
>> +	s32 imm_hi = (val + (1U << 31)) >> 32;
>> +	s32 imm_lo = val;
>> +
>> +	emit_fixed_imm32(rd, imm_hi, ctx);
>> +	emit_fixed_imm32(RV_REG_T1, imm_lo, ctx);
>> +	emit(rv_slli(rd, rd, 32), ctx);
>> +	emit(rv_add(rd, rd, RV_REG_T1), ctx);
>> +}
> 
> Hmm, will this really be fixed? We can end up with compressed
> instructions, which can then be a non-compressed in the last pass, and
> we have the same problem?
> 
> The range of valid address for RV64 (sv39 to sv57) are
> 0xffffffff00000000 to 0xffffffffffffffff, so I think we can do better
> than 6 insn, no? My gut feeling (I need to tinker a bit) is that 4
> should be sufficient.
> 
> Note that worst case for a imm64 load are 8 instructions, but this is
> not the general case.
> 
> 
> Björn

