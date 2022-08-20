Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B759ADA6
	for <lists+bpf@lfdr.de>; Sat, 20 Aug 2022 13:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbiHTLvK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Aug 2022 07:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345729AbiHTLvI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Aug 2022 07:51:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB4139D648
        for <bpf@vger.kernel.org>; Sat, 20 Aug 2022 04:51:06 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnmulygBjkwgGAA--.14449S2;
        Sat, 20 Aug 2022 19:51:01 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH bpf-next v1 0/4] Add BPF JIT support for LoongArch
Date:   Sat, 20 Aug 2022 19:50:56 +0800
Message-Id: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxnmulygBjkwgGAA--.14449S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW7Zw4rur1kuw1DJrW7CFg_yoW8Zr4kpa
        y3urn8KrWDGr1fXr1ft3yUuryrtF4fGry7Wa1ay348ArZ8ZF1jgFyxtw1DZFn5twsYgFy0
        qr1rKw12gF4DJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gw4l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgBcEUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The basic support for LoongArch has been merged into the upstream Linux
kernel since 5.19-rc1 on June 5, 2022, this patch series adds BPF JIT
support for LoongArch.

Here is the LoongArch documention:
https://www.kernel.org/doc/html/latest/loongarch/index.html

With this patch series, the test cases in lib/test_bpf.ko have passed
on LoongArch.

  # echo 1 > /proc/sys/net/core/bpf_jit_enable
  # modprobe test_bpf
  # dmesg | grep Summary
  test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
  test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
  test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

It seems that this patch series can not be applied cleanly to bpf-next
which is not synced to v6.0-rc1.

v1:
  -- Rebased series on v6.0-rc1
  -- Move {signed,unsigned}_imm_check() to inst.h
  -- Define the imm field as "unsigned int" in the instruction format
  -- Use DEF_EMIT_*_FORMAT to define the same kind of instructions
  -- Use "stack_adjust += sizeof(long) * 8" in build_prologue()

RFC:
  https://lore.kernel.org/bpf/1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn/

Tiezhu Yang (4):
  LoongArch: Move {signed,unsigned}_imm_check() to inst.h
  LoongArch: Add some instruction opcodes and formats
  LoongArch: Add BPF JIT support
  LoongArch: Enable BPF_JIT and TEST_BPF in default config

 arch/loongarch/Kbuild                      |    1 +
 arch/loongarch/Kconfig                     |    1 +
 arch/loongarch/configs/loongson3_defconfig |    2 +
 arch/loongarch/include/asm/inst.h          |  317 +++++++-
 arch/loongarch/kernel/module.c             |   10 -
 arch/loongarch/net/Makefile                |    7 +
 arch/loongarch/net/bpf_jit.c               | 1113 ++++++++++++++++++++++++++++
 arch/loongarch/net/bpf_jit.h               |  308 ++++++++
 8 files changed, 1744 insertions(+), 15 deletions(-)
 create mode 100644 arch/loongarch/net/Makefile
 create mode 100644 arch/loongarch/net/bpf_jit.c
 create mode 100644 arch/loongarch/net/bpf_jit.h

-- 
2.1.0

