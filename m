Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5267E649AC8
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 10:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiLLJME (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 04:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiLLJLm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 04:11:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A0F95B8
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 01:11:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d7so11403003pll.9
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 01:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZbjWg99T0mF9ybfX9oHUGyVFLlYExb0Y4gq5Et7mlk=;
        b=PC7vTUvil9hArj9YSMnK+tbcmI2PGAbYo//3TFRvBVnBeGH0WNx7NkdBLeeviwedo0
         XHNJCA48wPviCCdcSVfDQujh8oL7InTsMqlTmd5tAYQgnZORBh8BhljTFBBpn2PymFS8
         SnVU6QEy7mTmPie9PoB1O50SfwNRIepG1TK962Xl65a4+LrSvugjcVwEEFFs+IsydDl2
         8Ym8Im3N5PXn48tviaulhaGfusjhitOHlY6CLN789uMxElc3RuypMgVbj1wZTVsi3ODe
         Es6YCn+eVqKSkXFIzD25ToGa7235E96YIh437+8imd2TVDRZKhOPYZn4epQ5QIRaJ6J+
         sehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZbjWg99T0mF9ybfX9oHUGyVFLlYExb0Y4gq5Et7mlk=;
        b=LFMXB5Mdv8lrsnaTDBocxWYLexVxQNcaMpXDPUQZZUyD88Pfk+iv4q/bL/RqT2J8kI
         HGqY2D+AdURwhsTL2lnGXcmbhF9CtGVanoWSjviW8NBnF2aNuFKQN+T90YqeHopfhLYv
         HjVBSIddPP2/p/CAICXr/gO6TGY1NzBBEQYINjX6Y1VB/NO3FSzHznXnXlt5+sxW7v2s
         BLXnMVe1A9cfUgTIoKlqqrNi+u8YsQEz6P1s8PnbXPFIOxKh63IL+xpswiNkhd7s0aYX
         Cma1tZ3JJ6Ciu7JWEKq7jhavVE0BHmwoaC3QRhX4du0XzKepsypuy1vd240OvbNvA0p4
         s9IQ==
X-Gm-Message-State: ANoB5pm/0svd0BPLMdA61c5FGwRXSUCZg97IXtpla8ow1o08raEVTRBL
        O9JIJyfTuE+DAExIH+JmXy6wFvlgUvY=
X-Google-Smtp-Source: AA0mqf5mZpOOAiU+pO87py1cP3gurBPMJB4B3nNcbMWHQwxNMAKJwqkS2KWon3KS154Y+oNLt/7dtg==
X-Received: by 2002:a17:902:eccc:b0:189:cb73:75f0 with SMTP id a12-20020a170902eccc00b00189cb7375f0mr20991385plh.8.1670836301112;
        Mon, 12 Dec 2022 01:11:41 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b00189422a6b8bsm5829371plh.91.2022.12.12.01.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 01:11:40 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     hengqi.chen@gmail.com, yangtiezhu@loongson.cn
Subject: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
Date:   Mon, 12 Dec 2022 17:11:36 +0800
Message-Id: <20221212091136.969960-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add PT_REGS macros for LoongArch64.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/bpf_tracing.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 2972dc25ff72..2d7da1caa961 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -32,6 +32,9 @@
 #elif defined(__TARGET_ARCH_arc)
 	#define bpf_target_arc
 	#define bpf_target_defined
+#elif defined(__TARGET_ARCH_loongarch)
+	#define bpf_target_loongarch
+	#define bpf_target_defined
 #else

 /* Fall back to what the compiler says */
@@ -62,6 +65,9 @@
 #elif defined(__arc__)
 	#define bpf_target_arc
 	#define bpf_target_defined
+#elif defined(__loongarch__) && __loongarch_grlen == 64
+	#define bpf_target_loongarch
+	#define bpf_target_defined
 #endif /* no compiler target */

 #endif
@@ -258,6 +264,21 @@ struct pt_regs___arm64 {
 /* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
 #define PT_REGS_SYSCALL_REGS(ctx) ctx

+#elif defined(bpf_target_loongarch)
+
+#define __PT_PARM1_REG regs[5]
+#define __PT_PARM2_REG regs[6]
+#define __PT_PARM3_REG regs[7]
+#define __PT_PARM4_REG regs[8]
+#define __PT_PARM5_REG regs[9]
+#define __PT_RET_REG regs[1]
+#define __PT_FP_REG regs[22]
+#define __PT_RC_REG regs[4]
+#define __PT_SP_REG regs[3]
+#define __PT_IP_REG csr_era
+/* loongarch does not select ARCH_HAS_SYSCALL_WRAPPER. */
+#define PT_REGS_SYSCALL_REGS(ctx) ctx
+
 #endif

 #if defined(bpf_target_defined)
--
2.31.1
