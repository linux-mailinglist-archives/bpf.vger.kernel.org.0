Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7B59B7C8
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 04:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiHVCt7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 22:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiHVCt6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 22:49:58 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50A22205C4
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 19:49:55 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOLK7gJjViYHAA--.31929S3;
        Mon, 22 Aug 2022 10:49:47 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 3/4] LoongArch: Add BPF JIT support
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn>
 <1660996260-11337-4-git-send-email-yangtiezhu@loongson.cn>
 <1a68f4f3-7a9e-6cf9-c4d5-98b8b874de31@loongson.cn>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9db12c0b-6cb0-c1e9-0c1b-4d60cc4a10ab@loongson.cn>
Date:   Mon, 22 Aug 2022 10:49:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1a68f4f3-7a9e-6cf9-c4d5-98b8b874de31@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxYOLK7gJjViYHAA--.31929S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWfurWrAw1fCw48JrW7twb_yoW8CF1xpF
        y293y8Gr48Jr9rWFyDXw45Zr1fZrs3W3yq9F1Dtw4Sya1DXFy8GFyxK3yYkFyqkw4DuF4I
        gw1jyw18uF45ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbPEf7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 08/22/2022 09:58 AM, Youling Tang wrote:
> On 08/20/2022 07:50 PM, Tiezhu Yang wrote:
>> BPF programs are normally handled by a BPF interpreter, add BPF JIT
>> support for LoongArch to allow the kernel to generate native code
>> when a program is loaded into the kernel, this will significantly
>> speed-up processing of BPF programs.

[...]

>> +#define DEF_EMIT_REG1I20_FORMAT(NAME, OP)                \
>> +static inline void emit_##NAME(union loongarch_instruction *insn,    \
>> +                   enum loongarch_gpr rd, int imm)        \
>> +{                                    \
>> +    insn->reg1i20_format.opcode = OP;                \
>> +    insn->reg1i20_format.immediate = imm;                \
>> +    insn->reg1i20_format.rd = rd;                    \
>> +}
>> +
>> +DEF_EMIT_REG1I20_FORMAT(lu12iw, lu12iw_op)
>> +DEF_EMIT_REG1I20_FORMAT(lu32id, lu32id_op)
>
> We can delete the larch_insn_gen_{lu32id, lu52id, jirl} functions in
> inst.c and use emit_xxx.
>
> The implementation of emit_plt_entry() is similarly modified as follows:
> struct plt_entry {
>         union loongarch_instruction lu12iw;
>         union loongarch_instruction lu32id;
>         union loongarch_instruction lu52id;
>         union loongarch_instruction jirl;
> };
>
> static inline struct plt_entry emit_plt_entry(unsigned long val)
> {
>         union loongarch_instruction *lu12iw, *lu32id, *lu52id, *jirl;
>
>         emit_lu32id(lu12iw, LOONGARCH_GPR_T1, ADDR_IMM(val, LU12IW));
>         emit_lu32id(lu32id, LOONGARCH_GPR_T1, ADDR_IMM(val, LU32ID));
>         emit_lu52id(lu52id, LOONGARCH_GPR_T1, LOONGARCH_GPR_T1,
> ADDR_IMM(val, LU52ID));
>         emit_jirl(jirl, LOONGARCH_GPR_T1, 0, (val & 0xfff) >> 2);
>
>         return (struct plt_entry) { *lu12iw, *lu32id, *lu52id, *jirl };
> }
>
> Thanks,
> Youling

Hi Youling,

Yes, this is the benefit we define the instructions in inst.h,
but these changes are not much related with this patch series,
I think we can do it after this patch series is merged.

Thanks,
Tiezhu

