Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A4358D887
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 14:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiHIMB6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 08:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbiHIMB5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 08:01:57 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58D2F248C3
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 05:01:55 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxKsyqTPJiJhYLAA--.5282S3;
        Tue, 09 Aug 2022 20:01:47 +0800 (CST)
Subject: Re: [RFC PATCH 1/5] LoongArch: Fix some instruction formats
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn>
 <1660013580-19053-2-git-send-email-yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        loongarch@lists.linux.dev
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <41d7214b-54db-6637-ee8b-2f94ca2b70c5@loongson.cn>
Date:   Tue, 9 Aug 2022 20:01:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1660013580-19053-2-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxKsyqTPJiJhYLAA--.5282S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1fWry3Zr18JFy8KF1kAFb_yoW5XrW5pF
        s2yw1DKrWkGr1IvF1rJws5WFyfAw4fG3s2qFWaqryUGryYqFn8X343K345AFWkGw48uF1j
        vrW3Z347CF4DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUeWlkDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Tiezhu

On 08/09/2022 10:52 AM, Tiezhu Yang wrote:
> struct reg2i12_format is used to generate the instruction lu52id
> in larch_insn_gen_lu52id(), according to the instruction format
> of lu52id in LoongArch Reference Manual [1], the type of field
> "immediate" should be "signed int" rather than "unsigned int".
>
> There are similar problems in the other structs reg0i26_format,
> reg1i20_format, reg1i21_format and reg2i16_format, fix them.
>
> [1] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_lu12i_w_lu32i_d_lu52i_d
>
> Fixes: b738c106f735 ("LoongArch: Add other common headers")
 >
We may not be able to say "Fixes" here, because it is also correct to
treat each field of the instruction as an "unsinged int" type (signed
or not has no effect on the machine instruction stream, but it does
affect the programmer).

For example, when reg2i12_format.immediate is changed to "signed" type,
the immediate judgment in is_stack_alloc_ins() can be simplified,

static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
{
     /* addi.d $sp, $sp, -imm */
     return ip->reg2i12_format.opcode == addid_op &&
         ip->reg2i12_format.rj == LOONGARCH_GPR_SP &&
         ip->reg2i12_format.rd == LOONGARCH_GPR_SP &&
-        is_imm12_negative(ip->reg2i12_format.immediate);
+        (ip->reg2i12_format.immediate < 0;
}


Thanks,
Youling
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/include/asm/inst.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index 7b07cbb..ff51481 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -53,35 +53,35 @@ enum reg2i16_op {
>  };
>
>  struct reg0i26_format {
> -	unsigned int immediate_h : 10;
> -	unsigned int immediate_l : 16;
> +	signed int immediate_h : 10;
> +	signed int immediate_l : 16;
>  	unsigned int opcode : 6;
>  };
>
>  struct reg1i20_format {
>  	unsigned int rd : 5;
> -	unsigned int immediate : 20;
> +	signed int immediate : 20;
>  	unsigned int opcode : 7;
>  };
>
>  struct reg1i21_format {
> -	unsigned int immediate_h  : 5;
> +	signed int immediate_h  : 5;
>  	unsigned int rj : 5;
> -	unsigned int immediate_l : 16;
> +	signed int immediate_l : 16;
>  	unsigned int opcode : 6;
>  };
>
>  struct reg2i12_format {
>  	unsigned int rd : 5;
>  	unsigned int rj : 5;
> -	unsigned int immediate : 12;
> +	signed int immediate : 12;
>  	unsigned int opcode : 10;
>  };
>
>  struct reg2i16_format {
>  	unsigned int rd : 5;
>  	unsigned int rj : 5;
> -	unsigned int immediate : 16;
> +	signed int immediate : 16;
>  	unsigned int opcode : 6;
>  };
>
>

