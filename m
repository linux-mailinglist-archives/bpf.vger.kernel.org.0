Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341DD5745DC
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 09:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiGNH3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGNH3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 03:29:51 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C997B31DEA;
        Thu, 14 Jul 2022 00:29:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJI8bZq_1657783782;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VJI8bZq_1657783782)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 15:29:47 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] x86/bugs: make retbleed_strings static
Date:   Thu, 14 Jul 2022 15:29:39 +0800
Message-Id: <20220714072939.71162-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This symbol is not used outside of bugs.c, so marks it static.

arch/x86/kernel/cpu/bugs.c:796:12: warning: symbol 'retbleed_strings' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0dd04713434b..3a0787a36910 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -793,7 +793,7 @@ enum retbleed_mitigation_cmd {
 	RETBLEED_CMD_IBPB,
 };
 
-const char * const retbleed_strings[] = {
+static const char * const retbleed_strings[] = {
 	[RETBLEED_MITIGATION_NONE]	= "Vulnerable",
 	[RETBLEED_MITIGATION_UNRET]	= "Mitigation: untrained return thunk",
 	[RETBLEED_MITIGATION_IBPB]	= "Mitigation: IBPB",
-- 
2.20.1.7.g153144c

