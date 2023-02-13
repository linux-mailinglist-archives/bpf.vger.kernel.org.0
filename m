Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502D0693CD6
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 04:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBMDTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Feb 2023 22:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMDTG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Feb 2023 22:19:06 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA4DB9EFC
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 19:19:04 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx_eohrOljReYRAA--.35230S3;
        Mon, 13 Feb 2023 11:18:57 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxOL0crOljjgcyAA--.27717S3;
        Mon, 13 Feb 2023 11:18:52 +0800 (CST)
Subject: Re: [PATCH 1/2] LoongArch: BPF: Treat function address as 64-bit
 value
To:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20230212035236.1436532-1-hengqi.chen@gmail.com>
 <20230212035236.1436532-2-hengqi.chen@gmail.com>
 <07edfd3b-9895-f711-47a7-a805a4e92691@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a10cea86-8dd2-d256-055e-73f7d91930e7@loongson.cn>
Date:   Mon, 13 Feb 2023 11:18:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <07edfd3b-9895-f711-47a7-a805a4e92691@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxOL0crOljjgcyAA--.27717S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWruw4fCr48JFyxGw13GryfWFg_yoWDuwc_WF
        yxA34xWws8Ja4rAa4DKryrXFyDGFWrJF1rAFnxWrs7Aa45XFs8Ar48t34rA34qgr4rCrs8
        ArZ7XF93Cw12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        97kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1l
        x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
        v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
        x2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZF
        pf9x07j0FALUUUUU=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 02/13/2023 11:01 AM, Tiezhu Yang wrote:
> Hi Hengqi,
>
> On 02/12/2023 11:52 AM, Hengqi Chen wrote:
>> Let's always use 4 instructions for function address in JIT.
>> So that the instruction sequences don't change between the first
>> pass and the extra pass for function calls.
>>
>> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  arch/loongarch/net/bpf_jit.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index c4b1947ebf76..2d952110be72 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
>> @@ -446,6 +446,27 @@ static int add_exception_handler(const struct
>> bpf_insn *insn,
>>      return 0;
>>  }
>>
>> +static inline void emit_addr_move(struct jit_ctx *ctx, enum
>> loongarch_gpr rd, u64 addr)

Small nit:

Maybe use move_addr() ( like move_imm() ) is better than
emit_addr_move()?

Thanks,
Tiezhu

