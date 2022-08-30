Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66255A615A
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 13:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiH3LKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 07:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiH3LKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 07:10:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DED5459B6
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 04:10:18 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrmsS8A1jYF8MAA--.41314S2;
        Tue, 30 Aug 2022 19:10:10 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH bpf-next v2 0/4] Add BPF JIT support for LoongArch
Date:   Tue, 30 Aug 2022 19:10:05 +0800
Message-Id: <1661857809-10828-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxrmsS8A1jYF8MAA--.41314S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW7Zw4rur1kuw1DJrW7CFg_yoW8KF17pa
        y3CFn8KrWDGr1fXr1ft3yUuFyFyr4fGrW7W3W7A348Ars8ZF1jqa4xK3yDZFn8t39YgFy0
        qr93Kw1jgF4DJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4kMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5iZ2DUUUUU==
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
which is not synced to v6.0-rc3.

v2:
  -- Rebased series on v6.0-rc3
  -- Make build_epilogue() static
  -- Use alsl.d, bstrpick.d, [ld/st]ptr.[w/d] to save some instructions
  -- Replace move_imm32() and move_imm64() with move_imm() and optimize it
  -- Add code comments to explain the considerations of conditional jump

v1:
  -- Rebased series on v6.0-rc1
  -- Move {signed,unsigned}_imm_check() to inst.h
  -- Define the imm field as "unsigned int" in the instruction format
  -- Use DEF_EMIT_*_FORMAT to define the same kind of instructions
  -- Use "stack_adjust += sizeof(long) * 8" in build_prologue()
  https://lore.kernel.org/bpf/1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn/

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
 arch/loongarch/include/asm/inst.h          |  383 ++++++++-
 arch/loongarch/kernel/module.c             |   10 -
 arch/loongarch/net/Makefile                |    7 +
 arch/loongarch/net/bpf_jit.c               | 1160 ++++++++++++++++++++++++++++
 arch/loongarch/net/bpf_jit.h               |  282 +++++++
 8 files changed, 1831 insertions(+), 15 deletions(-)
 create mode 100644 arch/loongarch/net/Makefile
 create mode 100644 arch/loongarch/net/bpf_jit.c
 create mode 100644 arch/loongarch/net/bpf_jit.h

-- 
2.1.0

