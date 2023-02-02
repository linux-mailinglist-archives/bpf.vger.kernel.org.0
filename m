Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51CD6875E1
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 07:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBBGbf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 01:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBGbe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 01:31:34 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D9447E685;
        Wed,  1 Feb 2023 22:31:30 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxLuvBWNtjkSgMAA--.24557S3;
        Thu, 02 Feb 2023 14:31:29 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axvr6_WNtjUScnAA--.16445S3;
        Thu, 02 Feb 2023 14:31:28 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] tools/bpf: Use tab instead of white spaces to sync bpf.h
Date:   Thu,  2 Feb 2023 14:31:25 +0800
Message-Id: <1675319486-27744-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1675319486-27744-1-git-send-email-yangtiezhu@loongson.cn>
References: <1675319486-27744-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Axvr6_WNtjUScnAA--.16445S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrZFykXw4xKry8Aw4fCrWrAFb_yoWfCFcEk3
        43Cw4xGryDury7Xw17uan8Zrn5t34fA34v9F1rtr17CFy3Zw45K34kAF97Gw4Y93ZrGr4k
        tF13urW0qrsxWjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vD73UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Just silence the following build warning:

Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/include/uapi/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f024ac..ba0f0cf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5817,8 +5817,8 @@ enum {
 	BPF_F_ADJ_ROOM_ENCAP_L4_UDP	= (1ULL << 4),
 	BPF_F_ADJ_ROOM_NO_CSUM_RESET	= (1ULL << 5),
 	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
-	BPF_F_ADJ_ROOM_DECAP_L3_IPV4    = (1ULL << 7),
-	BPF_F_ADJ_ROOM_DECAP_L3_IPV6    = (1ULL << 8),
+	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
+	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
 };
 
 enum {
-- 
2.1.0

