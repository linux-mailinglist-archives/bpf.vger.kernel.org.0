Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B86935E4
	for <lists+bpf@lfdr.de>; Sun, 12 Feb 2023 04:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBLDxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Feb 2023 22:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBLDxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Feb 2023 22:53:01 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF42E14228
        for <bpf@vger.kernel.org>; Sat, 11 Feb 2023 19:52:59 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m2so10468928plg.4
        for <bpf@vger.kernel.org>; Sat, 11 Feb 2023 19:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hA3IP0EbHRoML81/juFYStllsBM72tyAWPCxGp78Zw=;
        b=b3OB5PiJ1CXthmneNF/B9Wj2k4dwIrxhOSGQvSfxodeWP3/0sAn3wTh957DzP2T7V1
         0ivg7lf7yfWNKpjpc50dDcXJ/xuqsXxTxb2rLOYSUig+LtZWBc8WWs6n5yDoMD1HMGjC
         ohindg499u5UWix7AGserjKVxDcOcjWgPshN5OEEBkb2iBQXmdXYN6HMHtE6NrCefYu5
         VHd/XVW5Nn7bgEyOXuJYCX4cv8mGumwGyWtwdOi91VceUB8qd43M1U2xFDqZ8jwCuxyy
         MClSDaaW1STM2uR01dnftvXaAIU/xoRGx//LsGEm36RVKGBJjePPC4Sp8RNtZCydaBwI
         h5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hA3IP0EbHRoML81/juFYStllsBM72tyAWPCxGp78Zw=;
        b=FZptk58vF3+28n+DY4zQNGMw1QTJNC5WdeeNv0nJGrM3NyA0cAxX7n+AO3KTZoDPAJ
         238SFNzR7xps2tnA1pNFyjixWiPAM1Ngbdrwp4tovTdTBFJjsqfzg4cVUKAEwwy6mwUk
         SS1KvviXsflYG7BpE0gyXcbd16qJcCZQXeehThiLIYDn+uQTfiPb+X9bhVWJCI3QIsrG
         btCZWy/zU3ql2NiixfPHSSJKQZD2hUqVOSl84j/hHlLdKX5hLEwSjUtkWfcDiawZJEyN
         33OaLLUAyWtDw+F7DXqYzjmcRUDhR/+v0d8Qpe+UvSFhMxJFp8MLwOF1iljNDcqQjaNu
         XZIA==
X-Gm-Message-State: AO0yUKX2mrhrmVlCTgMnrRd2E2I2iuNe6TxWaRy67YqEOilImdeDB2TJ
        XY5LpOxYFX3vHIhU/bAxhv4RYNiJICs=
X-Google-Smtp-Source: AK7set/A1OcyJ2w19fBpsJRXWqZ4xbxNpu62Z9iwsaKHIgOI3LaasCYkYwOKGsY2P7362uHMki0AuA==
X-Received: by 2002:a05:6a20:6990:b0:b8:a17c:75e4 with SMTP id t16-20020a056a20699000b000b8a17c75e4mr22766775pzk.48.1676173979232;
        Sat, 11 Feb 2023 19:52:59 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id s1-20020a63dc01000000b004fab4455748sm5055399pgg.75.2023.02.11.19.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 19:52:58 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Cc:     hengqi.chen@gmail.com
Subject: [PATCH 1/2] LoongArch: BPF: Treat function address as 64-bit value
Date:   Sun, 12 Feb 2023 11:52:35 +0800
Message-Id: <20230212035236.1436532-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230212035236.1436532-1-hengqi.chen@gmail.com>
References: <20230212035236.1436532-1-hengqi.chen@gmail.com>
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

Let's always use 4 instructions for function address in JIT.
So that the instruction sequences don't change between the first
pass and the extra pass for function calls.

Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index c4b1947ebf76..2d952110be72 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -446,6 +446,27 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+static inline void emit_addr_move(struct jit_ctx *ctx, enum loongarch_gpr rd, u64 addr)
+{
+	u64 imm_11_0, imm_31_12, imm_51_32, imm_63_52;
+
+	/* lu12iw rd, imm_31_12 */
+	imm_31_12 = (addr >> 12) & 0xfffff;
+	emit_insn(ctx, lu12iw, rd, imm_31_12);
+
+	/* ori rd, rd, imm_11_0 */
+	imm_11_0 = addr & 0xfff;
+	emit_insn(ctx, ori, rd, rd, imm_11_0);
+
+	/* lu32id rd, imm_51_32 */
+	imm_51_32 = (addr >> 32) & 0xfffff;
+	emit_insn(ctx, lu32id, rd, imm_51_32);
+
+	/* lu52id rd, rd, imm_63_52 */
+	imm_63_52 = (addr >> 52) & 0xfff;
+	emit_insn(ctx, lu52id, rd, rd, imm_63_52);
+}
+
 static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool extra_pass)
 {
 	u8 tm = -1;
@@ -841,7 +862,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (ret < 0)
 			return ret;
 
-		move_imm(ctx, t1, func_addr, is32);
+		emit_addr_move(ctx, t1, func_addr);
 		emit_insn(ctx, jirl, t1, LOONGARCH_GPR_RA, 0);
 		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
 		break;
-- 
2.31.1

