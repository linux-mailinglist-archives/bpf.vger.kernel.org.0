Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5C75F9BEC
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 11:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiJJJck (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 05:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiJJJcj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 05:32:39 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BA4631EDA;
        Mon, 10 Oct 2022 02:32:36 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOCl5kNjKPwpAA--.21250S2;
        Mon, 10 Oct 2022 17:32:22 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 0/7] LoongArch: Switch to relative extable and other improvements
Date:   Mon, 10 Oct 2022 17:32:13 +0800
Message-Id: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxkOCl5kNjKPwpAA--.21250S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWxKFykWr13XFyDGF17ZFb_yoW8CrWfpr
        9rZr93GFs5Gr93Zwnxt34IgF1rGF48Gw42q3WSv348Cw42qr10qr18Kr9rXFyDAa95JF40
        qryFgw1YgF48A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY
        04v7MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        CFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bw0PhUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar as other architectures such as arm64, x86 and so on, use
offsets relative to the exception table entry values rather than
absolute addresses for both the exception locationand the fixup.
And recently, arm64 and x86 remove anonymous out-of-line fixups, we
want to acchieve the same result.

Implementing the relative extable will facilitate subsequent kernel
relocation support, which can reduce relocation operations to the
extable (thanks to Jinyang for the suggestion).

At the same time, add BPF exception tables handling.


Youling Tang (7):
  LoongArch: Consolidate __ex_table construction
  LoongArch: Switch to relative exception tables
  LoongArch: extable: Add `type` and `data` fields
  LoongArch: Add gpr-num.h
  LoongArch: extable: Add a dedicated uaccess handler
  LoongArch: vmlinux.lds.S: Remove `.fixup` section
  LoongArch: bpf: Add BPF exception tables

 arch/loongarch/include/asm/asm-extable.h | 65 ++++++++++++++++++
 arch/loongarch/include/asm/extable.h     | 49 ++++++++++++++
 arch/loongarch/include/asm/futex.h       | 27 ++------
 arch/loongarch/include/asm/gpr-num.h     | 22 +++++++
 arch/loongarch/include/asm/uaccess.h     | 24 ++-----
 arch/loongarch/kernel/fpu.S              |  5 +-
 arch/loongarch/kernel/vmlinux.lds.S      |  4 +-
 arch/loongarch/lib/clear_user.S          | 17 ++---
 arch/loongarch/lib/copy_user.S           | 19 ++----
 arch/loongarch/mm/extable.c              | 60 ++++++++++++++---
 arch/loongarch/net/bpf_jit.c             | 84 ++++++++++++++++++++++--
 arch/loongarch/net/bpf_jit.h             |  2 +
 scripts/mod/modpost.c                    | 13 ++++
 scripts/sorttable.c                      |  2 +-
 14 files changed, 312 insertions(+), 81 deletions(-)
 create mode 100644 arch/loongarch/include/asm/asm-extable.h
 create mode 100644 arch/loongarch/include/asm/extable.h
 create mode 100644 arch/loongarch/include/asm/gpr-num.h

-- 
2.36.1

