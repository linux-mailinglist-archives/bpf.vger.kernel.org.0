Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1915758D226
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 04:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiHICxO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 22:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHICxL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 22:53:11 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E2681E3DB
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 19:53:10 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxvyMNzPFiwLAKAA--.4926S2;
        Tue, 09 Aug 2022 10:53:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Subject: [RFC PATCH 0/5] Add BPF JIT support for LoongArch
Date:   Tue,  9 Aug 2022 10:52:55 +0800
Message-Id: <1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxvyMNzPFiwLAKAA--.4926S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW7Zw4rur1kuw1DCrWruFg_yoW8CrW7pa
        y3urn3Kr4DGryfJwsaq3yDuF1FyF4fGr17Wa13tryUCrZIqF1j9w18G3yqvFs0y3yFgFy0
        qrn5K3W7K3W8Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOa9fUUUUU=
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

This patch series is based on the loongarch-next branch of
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/

With this patch series, the test cases in lib/test_bpf.ko have passed
on LoongArch.

  # echo 1 > /proc/sys/net/core/bpf_jit_enable
  # modprobe test_bpf
  # dmesg | grep Summary
  test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
  test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
  test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

This version is RFC, I am working on it to do some more optimizations and
looking forward to your feedback, any comments will be much appreciated.
After the merge window, I will rebase and address the review comments.

Tiezhu Yang (5):
  LoongArch: Fix some instruction formats
  LoongArch: Add some instruction opcodes and formats
  LoongArch: Add BPF JIT support
  LoongArch: Update loongson3_defconfig to make it clean
  LoongArch: Enable BPF_JIT and TEST_BPF in loongson3_defconfig

 arch/loongarch/Kbuild                      |    1 +
 arch/loongarch/Kconfig                     |    1 +
 arch/loongarch/configs/loongson3_defconfig |   58 +-
 arch/loongarch/include/asm/inst.h          |  147 +++-
 arch/loongarch/net/Makefile                |    7 +
 arch/loongarch/net/bpf_jit.c               | 1119 ++++++++++++++++++++++++++++
 arch/loongarch/net/bpf_jit.h               |  946 +++++++++++++++++++++++
 7 files changed, 2222 insertions(+), 57 deletions(-)
 create mode 100644 arch/loongarch/net/Makefile
 create mode 100644 arch/loongarch/net/bpf_jit.c
 create mode 100644 arch/loongarch/net/bpf_jit.h

-- 
2.1.0

