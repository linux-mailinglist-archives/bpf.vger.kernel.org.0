Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE85349264
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 13:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCYMuK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 08:50:10 -0400
Received: from mail.loongson.cn ([114.242.206.163]:34996 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229524AbhCYMuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 08:50:06 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxGcr6hlxgELMAAA--.2323S2;
        Thu, 25 Mar 2021 20:50:03 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v3] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS again
Date:   Thu, 25 Mar 2021 20:50:01 +0800
Message-Id: <1616676601-14478-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9CxGcr6hlxgELMAAA--.2323S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4rWFy3KF4fJF4kuFWUtwb_yoW8CF4xpa
        nYyas3Kr4UWrW5GF4vy3yxuryrJrZ7CrW3WF4ftF4Fvas09r98Xr4xKa13tryUZr4vqw1a
        93yUZa4UGaykCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xr1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1L0eDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After commit 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to
archs where they work"), bpf_probe_read{, str}() functions were no longer
available on MIPS, so there exist some errors when running bpf program:

root@linux:/home/loongson/bcc# python examples/tracing/task_switch.py
bpf: Failed to load program: Invalid argument
[...]
11: (85) call bpf_probe_read#4
unknown func bpf_probe_read#4
[...]
Exception: Failed to load BPF program count_sched: Invalid argument

ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE should be restricted to archs
with non-overlapping address ranges, but they can overlap in EVA mode
on MIPS, so select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA in
arch/mips/Kconfig, otherwise the bpf old helper bpf_probe_read() will
not be available.

This is similar with the commit d195b1d1d119 ("powerpc/bpf: Enable
bpf_probe_read{, str}() on powerpc again").

Fixes: 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to archs where they work")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v3: Select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA
    on MIPS.

v2: update the commit message to fix typos found by
    Sergei Shtylyov, thank you!

    not longer --> no longer
    there exists --> there exist

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 160b3a8..32158c2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -6,6 +6,7 @@ config MIPS
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE if !EVA
 	select ARCH_HAS_PTE_SPECIAL if !(32BIT && CPU_HAS_RIXI)
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
-- 
2.1.0

