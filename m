Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601FC57CABE
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiGUMji (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 08:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiGUMjh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 08:39:37 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 05:39:35 PDT
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB07538E;
        Thu, 21 Jul 2022 05:39:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LpWRs64fYz6S3Md;
        Thu, 21 Jul 2022 20:03:21 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP1 (Coremail) with SMTP id cCh0CgAnLWHKQNliUh8JBA--.48026S2;
        Thu, 21 Jul 2022 20:04:27 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Will Deacon <will@kernel.org>, Yonghong Song <yhs@fb.com>,
        Zi Shen Lim <zlim.lnx@gmail.com>
Subject: [PATCH bpf-next] bpf, arm64: Fix compile error in dummy_tramp()
Date:   Thu, 21 Jul 2022 08:13:19 -0400
Message-Id: <20220721121319.2999259-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAnLWHKQNliUh8JBA--.48026S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxCF15uw18tFWfAF45trb_yoW8GF1kpw
        1UCrnxC3yqgF4DGa4rXa1fXF15tF4qqFWa9rW2grW5tF9FvryUGr4fKw1kWrZxJr1Fva1r
        AFWjkwn5A3Wvv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

dummy_tramp() uses "lr" to refer to the x30 register, but some assembler
does not recognize "lr" and reports a build failure:

/tmp/cc52xO0c.s: Assembler messages:
/tmp/cc52xO0c.s:8: Error: operand 1 should be an integer register -- `mov lr,x9'
/tmp/cc52xO0c.s:7: Error: undefined symbol lr used as an immediate value
make[2]: *** [scripts/Makefile.build:250: arch/arm64/net/bpf_jit_comp.o] Error 1
make[1]: *** [scripts/Makefile.build:525: arch/arm64/net] Error 2

So replace "lr" with "x30" to fix it.

Fixes: b2ad54e1533e ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index dcc572b7d4da..7ca8779ae34f 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -610,8 +610,8 @@ asm (
 #if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)
 "	bti j\n" /* dummy_tramp is called via "br x10" */
 #endif
-"	mov x10, lr\n"
-"	mov lr, x9\n"
+"	mov x10, x30\n"
+"	mov x30, x9\n"
 "	ret x10\n"
 "	.size dummy_tramp, .-dummy_tramp\n"
 "	.popsection\n"
-- 
2.30.2

