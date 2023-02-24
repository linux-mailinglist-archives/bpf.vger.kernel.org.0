Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317226A1A6E
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 11:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBXKik (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 05:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBXKiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 05:38:00 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EBEC17146;
        Fri, 24 Feb 2023 02:36:58 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxYcxKk_hjBacEAA--.3713S3;
        Fri, 24 Feb 2023 18:36:58 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxQuVHk_hjToM6AA--.5828S4;
        Fri, 24 Feb 2023 18:36:57 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Check __TARGET_ARCH_loongarch if target is bpf for LoongArch
Date:   Fri, 24 Feb 2023 18:36:54 +0800
Message-Id: <1677235015-21717-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn>
References: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxQuVHk_hjToM6AA--.5828S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Aw1UGr45uw45Cw1DCFWfXwb_yoW8Cw4fpF
        WkCr9FyFWUurWFk3s5JFy09Fy7J3s7tr4UtFWFg34kWFWrJ3W8Gws2krZrCasaga97tFna
        9ry7K3y5Wa18Aw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8QJ57UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If target is bpf, there is no __loongarch__ definition, __BITS_PER_LONG
defaults to 32, __NR_nanosleep is not defined:

  #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
  #define __NR_nanosleep 101
  __SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
  #endif

Check __TARGET_ARCH_loongarch to include arch specified bitsperlong.h,
then __BITS_PER_LONG is 64, __NR_nanosleep can also be defined to fix
the following build errors:

  clang  -g -Werror -D__TARGET_ARCH_loongarch ... -target bpf -c progs/test_vmlinux.c ...
  progs/test_vmlinux.c:24:18: error: use of undeclared identifier '__NR_nanosleep'
          if (args->id != __NR_nanosleep)
                          ^
  progs/test_vmlinux.c:42:12: error: use of undeclared identifier '__NR_nanosleep'
          if (id != __NR_nanosleep)
                    ^
  progs/test_vmlinux.c:60:12: error: use of undeclared identifier '__NR_nanosleep'
          if (id != __NR_nanosleep)
                    ^
  3 errors generated.
  make: *** [Makefile:572: tools/testing/selftests/bpf/test_vmlinux.bpf.o] Error 1
  make: Leaving directory 'tools/testing/selftests/bpf'

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/include/uapi/asm/bitsperlong.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm/bitsperlong.h b/tools/include/uapi/asm/bitsperlong.h
index da52065..10b4023 100644
--- a/tools/include/uapi/asm/bitsperlong.h
+++ b/tools/include/uapi/asm/bitsperlong.h
@@ -17,7 +17,7 @@
 #include "../../../arch/riscv/include/uapi/asm/bitsperlong.h"
 #elif defined(__alpha__)
 #include "../../../arch/alpha/include/uapi/asm/bitsperlong.h"
-#elif defined(__loongarch__)
+#elif defined(__loongarch__) || defined(__TARGET_ARCH_loongarch)
 #include "../../../arch/loongarch/include/uapi/asm/bitsperlong.h"
 #else
 #include <asm-generic/bitsperlong.h>
-- 
2.1.0

