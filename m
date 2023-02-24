Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3056A1A6D
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 11:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBXKij (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 05:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjBXKh7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 05:37:59 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D42A712BE0;
        Fri, 24 Feb 2023 02:36:58 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxUOVJk_hjAqcEAA--.3654S3;
        Fri, 24 Feb 2023 18:36:57 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxQuVHk_hjToM6AA--.5828S3;
        Fri, 24 Feb 2023 18:36:56 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/3] libbpf: Use struct user_pt_regs to define __PT_REGS_CAST() for LoongArch
Date:   Fri, 24 Feb 2023 18:36:53 +0800
Message-Id: <1677235015-21717-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn>
References: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxQuVHk_hjToM6AA--.5828S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF47GFWDKryDWr47tr1UZFb_yoW8Wr17pa
        4UC347KayrWw1j9a4kWr4avr4akrZ3Xw4kAFyxWw4ftFWkJ3yrXr129F43Gry3J3yrtw4Y
        vF93K3W5AF1UWw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vD73UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LoongArch provides struct user_pt_regs instead of struct pt_regs
to userspace, use struct user_pt_regs to define __PT_REGS_CAST()
to fix the following build error:

     CLNG-BPF [test_maps] loop1.bpf.o
  progs/loop1.c:22:9: error: incomplete definition of type 'struct pt_regs'
                                  m = PT_REGS_RC(ctx);
                                      ^~~~~~~~~~~~~~~
  tools/testing/selftests/bpf/tools/include/bpf/bpf_tracing.h:493:41: note: expanded from macro 'PT_REGS_RC'
  #define PT_REGS_RC(x) (__PT_REGS_CAST(x)->__PT_RC_REG)
                         ~~~~~~~~~~~~~~~~~^
  tools/testing/selftests/bpf/tools/include/bpf/bpf_helper_defs.h:20:8: note: forward declaration of 'struct pt_regs'
  struct pt_regs;
         ^
  1 error generated.
  make: *** [Makefile:572: tools/testing/selftests/bpf/loop1.bpf.o] Error 1
  make: Leaving directory 'tools/testing/selftests/bpf'

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/lib/bpf/bpf_tracing.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 6db88f4..137b13d 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -415,6 +415,8 @@ struct pt_regs___arm64 {
  * https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html
  */
 
+/* loongarch provides struct user_pt_regs instead of struct pt_regs to userspace */
+#define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
 #define __PT_PARM1_REG regs[4]
 #define __PT_PARM2_REG regs[5]
 #define __PT_PARM3_REG regs[6]
-- 
2.1.0

