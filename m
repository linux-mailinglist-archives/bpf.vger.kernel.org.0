Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840C759B745
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 03:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiHVBgy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 21:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiHVBgv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 21:36:51 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3842620BEE
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 18:36:50 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32ur3QJjQx8HAA--.26440S3;
        Mon, 22 Aug 2022 09:36:43 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 0/4] Add BPF JIT support for LoongArch
To:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7af3c82c-220b-1e9c-765f-105480264ae6@loongson.cn>
Date:   Mon, 22 Aug 2022 09:36:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bx32ur3QJjQx8HAA--.26440S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyDAF4UuFWkuFW7KrykKrg_yoW8Kr18pa
        y3uFn5KrW8Gr1xJFn3K3yUuryYyr4fGrW7W3W3t348CrsxXF1jgFyxtrWDZFn5Kw4FgFy0
        qrn5Kw1jga1kJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07besqAUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 08/20/2022 07:50 PM, Tiezhu Yang wrote:
> The basic support for LoongArch has been merged into the upstream Linux
> kernel since 5.19-rc1 on June 5, 2022, this patch series adds BPF JIT
> support for LoongArch.
>
> Here is the LoongArch documention:
> https://www.kernel.org/doc/html/latest/loongarch/index.html
>
> With this patch series, the test cases in lib/test_bpf.ko have passed
> on LoongArch.
>
>   # echo 1 > /proc/sys/net/core/bpf_jit_enable
>   # modprobe test_bpf
>   # dmesg | grep Summary
>   test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
>   test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
>   test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
>
> It seems that this patch series can not be applied cleanly to bpf-next
> which is not synced to v6.0-rc1.


Hi Alexei, Daniel, Andrii,

Do you know which tree this patch series will go through?
bpf-next or loongarch-next?

I will wait for some more review comments and then send v2
to fix the build warning in patch #3 reported by test robot.

Thanks,
Tiezhu

>
> v1:
>   -- Rebased series on v6.0-rc1
>   -- Move {signed,unsigned}_imm_check() to inst.h
>   -- Define the imm field as "unsigned int" in the instruction format
>   -- Use DEF_EMIT_*_FORMAT to define the same kind of instructions
>   -- Use "stack_adjust += sizeof(long) * 8" in build_prologue()
>
> RFC:
>   https://lore.kernel.org/bpf/1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn/
>
> Tiezhu Yang (4):
>   LoongArch: Move {signed,unsigned}_imm_check() to inst.h
>   LoongArch: Add some instruction opcodes and formats
>   LoongArch: Add BPF JIT support
>   LoongArch: Enable BPF_JIT and TEST_BPF in default config
>
>  arch/loongarch/Kbuild                      |    1 +
>  arch/loongarch/Kconfig                     |    1 +
>  arch/loongarch/configs/loongson3_defconfig |    2 +
>  arch/loongarch/include/asm/inst.h          |  317 +++++++-
>  arch/loongarch/kernel/module.c             |   10 -
>  arch/loongarch/net/Makefile                |    7 +
>  arch/loongarch/net/bpf_jit.c               | 1113 ++++++++++++++++++++++++++++
>  arch/loongarch/net/bpf_jit.h               |  308 ++++++++
>  8 files changed, 1744 insertions(+), 15 deletions(-)
>  create mode 100644 arch/loongarch/net/Makefile
>  create mode 100644 arch/loongarch/net/bpf_jit.c
>  create mode 100644 arch/loongarch/net/bpf_jit.h
>

