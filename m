Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EC8627907
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 10:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiKNJcE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 04:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiKNJb5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 04:31:57 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7639BE03;
        Mon, 14 Nov 2022 01:31:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4N9kbT1kGLz4f3thC;
        Mon, 14 Nov 2022 17:31:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgB3m9gGC3JjGIwHAg--.15506S4;
        Mon, 14 Nov 2022 17:31:52 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>, houtao1@huawei.com,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf] perf, bpf: Use subprog name when reporting subprog ksymbol
Date:   Mon, 14 Nov 2022 17:57:33 +0800
Message-Id: <20221114095733.158588-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3m9gGC3JjGIwHAg--.15506S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw43Zr17Wr4xtw48CF1UAwb_yoW8Ww1kpF
        yUtr10k34UKF4jk347AFWSq3yUArs8W3yxtw1rtr4a9w47WrykWay7Wa90vr90vryftFyS
        v3yqyrW3tr98JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Since commit bfea9a8574f3 ("bpf: Add name to struct bpf_ksym"), when
reporting subprog ksymbol to perf, prog name instead of subprog name is
used. The backtrace of bpf program with subprogs will be incorrect as
shown below:

  ffffffffc02deace bpf_prog_e44a3057dcb151f8_overwrite+0x66
  ffffffffc02de9f7 bpf_prog_e44a3057dcb151f8_overwrite+0x9f
  ffffffffa71d8d4e trace_call_bpf+0xce
  ffffffffa71c2938 perf_call_bpf_enter.isra.0+0x48

overwrite is the entry program and it invokes the overwrite_htab subprog
through bpf_loop, but in above backtrace, overwrite program just jumps
inside itself.

Fixing it by using subprog name when reporting subprog ksymbol. After
the fix, the output of perf script will be correct as shown below:

  ffffffffc031aad2 bpf_prog_37c0bec7d7c764a4_overwrite_htab+0x66
  ffffffffc031a9e7 bpf_prog_c7eb827ef4f23e71_overwrite+0x9f
  ffffffffa3dd8d4e trace_call_bpf+0xce
  ffffffffa3dc2938 perf_call_bpf_enter.isra.0+0x48

Fixes: bfea9a8574f3 ("bpf: Add name to struct bpf_ksym")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717003d5..8b50ef2569d9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9030,7 +9030,7 @@ static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
 				PERF_RECORD_KSYMBOL_TYPE_BPF,
 				(u64)(unsigned long)subprog->bpf_func,
 				subprog->jited_len, unregister,
-				prog->aux->ksym.name);
+				subprog->aux->ksym.name);
 		}
 	}
 }
-- 
2.29.2

