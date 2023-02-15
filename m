Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91753697A5C
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 12:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBOLBV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 06:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBOLBU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 06:01:20 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FD7B728B;
        Wed, 15 Feb 2023 03:01:14 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxC9p5u+xjpuUAAA--.2271S3;
        Wed, 15 Feb 2023 19:01:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+R4u+xjg9UzAA--.61731S2;
        Wed, 15 Feb 2023 19:01:13 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Fix build error for LoongArch
Date:   Wed, 15 Feb 2023 19:01:07 +0800
Message-Id: <1676458867-22052-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Cxf+R4u+xjg9UzAA--.61731S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tF1kGryxWF47Gr1rCFykKrg_yoW8Jw4fpa
        ykCrs0kr4FgrW7Cwn5Ar12qryUG395Wr40qFy8Zw1DCFWFq3yDXF4xKFnIyF1fJa10qFyr
        A347Kry3Zw1DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
        W8JbIYCTnIWIevJa73UjIFyTuYvjxU2ID7UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There exists build error when make -C tools/testing/selftests/bpf/
on LoongArch:

  BINARY   test_verifier
In file included from test_verifier.c:27:
tools/include/uapi/linux/bpf_perf_event.h:14:28: error: field 'regs' has incomplete type
   14 |         bpf_user_pt_regs_t regs;
      |                            ^~~~
make: *** [Makefile:577: tools/testing/selftests/bpf/test_verifier] Error 1
make: Leaving directory 'tools/testing/selftests/bpf'

Add missing uapi header for LoongArch to use the following definition:
typedef struct user_pt_regs bpf_user_pt_regs_t;

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/include/uapi/asm/bpf_perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/asm/bpf_perf_event.h b/tools/include/uapi/asm/bpf_perf_event.h
index d7dfeab..ff52668 100644
--- a/tools/include/uapi/asm/bpf_perf_event.h
+++ b/tools/include/uapi/asm/bpf_perf_event.h
@@ -6,6 +6,8 @@
 #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
 #elif defined(__riscv)
 #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
+#elif defined(__loongarch__)
+#include "../../arch/loongarch/include/uapi/asm/bpf_perf_event.h"
 #else
 #include <uapi/asm-generic/bpf_perf_event.h>
 #endif
-- 
2.1.0

