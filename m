Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6272C68660B
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 13:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjBAMgr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 07:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjBAMgp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 07:36:45 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F24E5CE45;
        Wed,  1 Feb 2023 04:36:43 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxZ+naXNpjZHkLAA--.18171S3;
        Wed, 01 Feb 2023 20:36:42 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxOL3WXNpjUXImAA--.10032S6;
        Wed, 01 Feb 2023 20:36:42 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 4/4] bpf: Mark BPF_ALU and BPF_JMP as deprecated
Date:   Wed,  1 Feb 2023 20:36:38 +0800
Message-Id: <1675254998-4951-5-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
References: <1675254998-4951-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8AxOL3WXNpjUXImAA--.10032S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF17KrWkXw47ZFW5uF4xXrb_yoW8Gr15pF
        n5ZFW3trWkGay7u3s2v342gasxJr4DGF1UGay7WrWUGFy7tw4kZr4DWa1ayr1rXrWvvas0
        vwnF9w15W3s7XrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For now, BPF_ALU and BPF_JMP are not used by any kernel code, but we can
not remove them directly due to they are in the uapi header file, so just
mark them as deprecated.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/uapi/linux/bpf_common.h       | 4 ++--
 tools/include/uapi/linux/bpf_common.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf_common.h b/include/uapi/linux/bpf_common.h
index ee97668..75ae3dd 100644
--- a/include/uapi/linux/bpf_common.h
+++ b/include/uapi/linux/bpf_common.h
@@ -8,8 +8,8 @@
 #define		BPF_LDX		0x01
 #define		BPF_ST		0x02
 #define		BPF_STX		0x03
-#define		BPF_ALU		0x04
-#define		BPF_JMP		0x05
+#define		BPF_ALU		0x04 /* deprecated */
+#define		BPF_JMP		0x05 /* deprecated */
 #define		BPF_RET		0x06
 #define		BPF_MISC        0x07
 
diff --git a/tools/include/uapi/linux/bpf_common.h b/tools/include/uapi/linux/bpf_common.h
index ee97668..75ae3dd 100644
--- a/tools/include/uapi/linux/bpf_common.h
+++ b/tools/include/uapi/linux/bpf_common.h
@@ -8,8 +8,8 @@
 #define		BPF_LDX		0x01
 #define		BPF_ST		0x02
 #define		BPF_STX		0x03
-#define		BPF_ALU		0x04
-#define		BPF_JMP		0x05
+#define		BPF_ALU		0x04 /* deprecated */
+#define		BPF_JMP		0x05 /* deprecated */
 #define		BPF_RET		0x06
 #define		BPF_MISC        0x07
 
-- 
2.1.0

