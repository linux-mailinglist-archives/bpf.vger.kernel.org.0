Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF452643BEE
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 04:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiLFDh4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 22:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFDhz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 22:37:55 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E45D1CB1B;
        Mon,  5 Dec 2022 19:37:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NR5hq3Tbxz4f3p0S;
        Tue,  6 Dec 2022 11:37:47 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP4 (Coremail) with SMTP id gCh0CgDX+tcNuY5jyn7xBg--.3634S2;
        Tue, 06 Dec 2022 11:37:50 +0800 (CST)
Message-ID: <0ade59ea-6863-4d68-607c-22e4b9405a0d@huaweicloud.com>
Date:   Tue, 6 Dec 2022 11:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf v2] riscv, bpf: Emit fixed-length instructions for
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
References: <20221202094837.3872444-1-pulehui@huaweicloud.com>
 <87y1rq848x.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87y1rq848x.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDX+tcNuY5jyn7xBg--.3634S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw15ZF4ftw15Zw17WrW3ZFb_yoW5WF48pr
        W5KFy3CayvqrnrGF12yr4jvr1aqF4vqayxKr1UK34Yk3W2gF4IkF1DG390k3Z5ZFW8Gw13
        JF4j9rsxCa4DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/12/2 18:54, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> For BPF_PSEUDO_FUNC instruction, verifier will refill imm with
>> correct addresses of bpf_calls and then run last pass of JIT.
>> Since the emit_imm of RV64 is variable-length, which will emit
>> appropriate length instructions accorroding to the imm, it may
>> broke ctx->offset, and lead to unpredictable problem, such as
>> inaccurate jump. So let's fix it with fixed-length instructions.
>>
>> Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> Suggested-by: Björn Töpel <bjorn@rivosinc.com>
>> ---
>>   arch/riscv/net/bpf_jit_comp64.c | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index eb99df41fa33..9723f34f7a06 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -139,6 +139,19 @@ static bool in_auipc_jalr_range(s64 val)
>>   		val < ((1L << 31) - (1L << 11));
>>   }
>>   
>> +/* Emit fixed-length instructions for address */
>> +static void emit_addr(u8 rd, u64 addr, struct rv_jit_context *ctx)
>> +{
>> +	u64 ip = (u64)(ctx->insns + ctx->ninsns);
>> +	s64 off = addr - ip;
>> +	s64 upper = (off + (1 << 11)) >> 12;
>> +	s64 lower = ((off & 0xfff) << 52) >> 52;
>> +
>> +	emit(rv_auipc(rd, upper), ctx);
>> +	emit(rv_addi(rd, rd, lower), ctx);
>> +}
> 
> Nice! Two instructions are better than 6! :-)
> 
> One final thing. Please add a sanity check, that the range is correct,
> e.g.:
> 
>    if (!(addr && in_auipc_addi_range(off)))
>       return -1;
> 

Hi Björn,

Sorry for replying so late. For BPF_PSEUDO_FUNC instruction, verifier 
will set insn[0].imm and insn[1].imm to 1 that make addr to 0x100000001 
before extra pass, and also ctx->insns is NULL in iteration stage, all 
of these make off out of range of AUIPC-ADDI range, and return failed. 
We could add some special handling at different stages, but that seems a 
little weird. By the way, I do not really like emit_addr function with 
return value.

While a proper address is at least 2B alignment, and the valid address 
is from 0xffffffff00000000 to 0xffffffffffffffff, we can make address 
shifed 1 place to right, and addr >> 1 will always in the range of 
AUIPC-ADDI range. We can get rid of the range detection. The 
implementation is as follows:

static void emit_addr(u8 rd, u64 addr, struct rv_jit_context *ctx)
{
          s64 imm = addr >> 1;
          s64 upper = (imm + (1 << 11)) >> 12;
          s64 lower = imm & 0xfff;

          emit(rv_lui(rd, upper), ctx);
          emit(rv_addi(rd, rd, lower), ctx);
          emit(rv_slli(rd, rd, 1), ctx);
}

What do you think?

Regards,
Lehui

> Have a look at emit_jump_and_link().
> 
> 
> Thanks!
> Björn

