Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AED6DA7AC
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 04:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbjDGCVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 22:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbjDGCVn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 22:21:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3223376BF;
        Thu,  6 Apr 2023 19:21:40 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bxedkzfi9kaKoXAA--.36673S3;
        Fri, 07 Apr 2023 10:21:39 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxbb4vfi9ki8MXAA--.48021S2;
        Fri, 07 Apr 2023 10:21:35 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH bpf-next] tools headers: Remove s390 ptrace.h in check-headers.sh
Date:   Fri,  7 Apr 2023 10:21:30 +0800
Message-Id: <1680834090-2322-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Bxbb4vfi9ki8MXAA--.48021S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tr13WF15tw4rWFWrury7GFg_yoW8Gr1fp3
        ZxCFs5Ww45Gr1FyF4UJanrXrWDJ3y8uFyYq347Kryjyrsa9F1kArWSkFn0krnIqFWDtF9x
        WFy3Kry5J3WkXaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After commit 1f265d2aea0d ("selftests/bpf: Remove not used headers"),
tools/arch/s390/include/uapi/asm/ptrace.h has been removed, so remove
it in check-headers.sh too, otherwise we can see the following build
warning:

  diff: tools/arch/s390/include/uapi/asm/ptrace.h: No such file or directory

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304050029.38NdbQPf-lkp@intel.com/
Fixes: 1f265d2aea0d ("selftests/bpf: Remove not used headers")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

commit 1f265d2aea0d ("selftests/bpf: Remove not used headers") is in
bpf-next tree, so I prefer this patch can be applied to bpf-next tree.

 tools/perf/check-headers.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index eacca9a..e4a8b53 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -52,7 +52,6 @@ arch/x86/include/uapi/asm/vmx.h
 arch/powerpc/include/uapi/asm/kvm.h
 arch/s390/include/uapi/asm/kvm.h
 arch/s390/include/uapi/asm/kvm_perf.h
-arch/s390/include/uapi/asm/ptrace.h
 arch/s390/include/uapi/asm/sie.h
 arch/arm/include/uapi/asm/kvm.h
 arch/arm64/include/uapi/asm/kvm.h
-- 
2.1.0

