Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D9686609
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 13:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjBAMgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 07:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjBAMgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 07:36:44 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 104CD5B5B2;
        Wed,  1 Feb 2023 04:36:40 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxUvDXXNpjXHkLAA--.23879S3;
        Wed, 01 Feb 2023 20:36:39 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxOL3WXNpjUXImAA--.10032S3;
        Wed, 01 Feb 2023 20:36:39 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/4] bpf: Add new macro BPF_ALU32 and BPF_JMP64
Date:   Wed,  1 Feb 2023 20:36:35 +0800
Message-Id: <1675254998-4951-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
References: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8AxOL3WXNpjUXImAA--.10032S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kw1xGF17Cw48tw1xXFWDurg_yoW8Xr4kpF
        s3Xr47Ar4DWFWfuryxu3ySq3sxX3yUCr1rKayYg34jkF43t34xXFs0g3ZFvryfXr4kXa1a
        q3429rW5W340qr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07jnAwxUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the current code, BPF_ALU means BPF_ALU32, but BPF_JMP means BPF_JMP64,
it is a little confusing at the first glance, add new macro BPF_ALU32 and
BPF_JMP64, then we can replace the ambiguos macro BPF_ALU and BPF_JMP with
new macro BPF_ALU32 and BPF_JMP64 step by step, BPF_ALU and BPF_JMP can be
removed from the uapi header file in some day.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/uapi/linux/bpf.h       | 2 ++
 tools/include/uapi/linux/bpf.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ba0f0cf..a118c43 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -15,6 +15,8 @@
 
 /* instruction classes */
 #define BPF_JMP32	0x06	/* jmp mode in word width */
+#define BPF_JMP64	0x05	/* jmp mode in double word width */
+#define BPF_ALU32	0x04	/* alu mode in word width */
 #define BPF_ALU64	0x07	/* alu mode in double word width */
 
 /* ld/ldx fields */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f024ac..014b449 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -15,6 +15,8 @@
 
 /* instruction classes */
 #define BPF_JMP32	0x06	/* jmp mode in word width */
+#define BPF_JMP64	0x05	/* jmp mode in double word width */
+#define BPF_ALU32	0x04	/* alu mode in word width */
 #define BPF_ALU64	0x07	/* alu mode in double word width */
 
 /* ld/ldx fields */
-- 
2.1.0

