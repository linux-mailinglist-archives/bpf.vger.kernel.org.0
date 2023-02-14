Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDDA696806
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjBNP0s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 10:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjBNP0r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 10:26:47 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5E127D4E
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 07:26:46 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z3so4206010pfw.7
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 07:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTX2F2TrplX3EhIegiab/3E+IwCv8ZrrolJOY/X43qI=;
        b=cVBk39aHq03A7S4pjaSi9XwIDsVx3qTb3qzFJn2KvBXcqjs0zuREdv/SGmq5/yDq7w
         kuyAPoL2/rXQtr9IC2n/gztkvHBjERvbg4s1xAJwtbn0Mqb9zcRbrOlkWSCCK4a5VNsz
         mKDPbr0IVMgu4/Tf9lVcKJmomkOjlNnpzcrwu3EY0j/hfpMzNceqE78hSXFAVj4+t+Ig
         UEvT49IzIN9yrK9LL/5ny+3Q9ltDYp4fp2qz/lEsozizZiO04+egopaq0gArba1MxtSt
         VaNFV4H6moYXI54sY3djmPd1RK+bpuCSJ0XzVUXxlmE33KXf0IoKOy76lk8WoPLtESh3
         ydOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTX2F2TrplX3EhIegiab/3E+IwCv8ZrrolJOY/X43qI=;
        b=whZeQu2565Dm9d3BsjK+OCOGG3erO/mui+hYsw11WyVqt2m6ldHdrBx6d9ggdIK85M
         ixyiD0KrqnGhSlUcmoEgaJ5wKYCVvQXzH0NWOkLAgEvcFhSC5Au7hV+tkzmzhWyJrk4t
         JWQub9quWkFoLqT5i+YxphHOrJxcVQdNigCHNUN7/VQoRgFs/cppAddRF8Nt+IrElo9w
         wOMGfWAWney2O+fxopnf2kiSym967/iEkN9hmdXxIDFBZJ0fEyRhaPQYxRsA/2gW4AyC
         qwwZdZLsOTyyLIWMv15h84bR/xIznwtStJYVxwOHvlF81lEIX4H3U4fV8qazBglwFuX5
         fp/g==
X-Gm-Message-State: AO0yUKV7Tj1JUmc6y2+DUGiQiAkMvVyG27XIxLtrD610IQLSGqyfMbqa
        Whs//XO1uF99B5XHq4hzPss+OyYgbcY=
X-Google-Smtp-Source: AK7set/tDKzzBEnN43HEgzoCe5LIepdUP8bXEDO8AG49ol8YYY7wy25/WjsRd4CCUMrEeYgg2yWmzw==
X-Received: by 2002:a62:30c4:0:b0:590:921d:5740 with SMTP id w187-20020a6230c4000000b00590921d5740mr1795217pfw.13.1676388405969;
        Tue, 14 Feb 2023 07:26:45 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78151000000b005810a54fdefsm9951938pfn.114.2023.02.14.07.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:26:45 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Cc:     hengqi.chen@gmail.com
Subject: [PATCH v2] LoongArch: BPF: Use 4 instructions for function address in JIT
Date:   Tue, 14 Feb 2023 15:26:33 +0000
Message-Id: <20230214152633.2265699-1-hengqi.chen@gmail.com>
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

This patch fixes the following issue of function calls in JIT, like:

  [   29.346981] multi-func JIT bug 105 != 103

The issus can be reproduced by running the "inline simple bpf_loop call"
verifier test.

This is because we are emiting 2-4 instructions for 64-bit immediate moves.
During the first pass of JIT, the placeholder address is zero, emiting two
instructions for it. In the extra pass, the function address is in XKVRANGE,
emiting four instructions for it. This change the instruction index in
JIT context. Let's always use 4 instructions for function address in JIT.
So that the instruction sequences don't change between the first pass and
the extra pass for function calls.

Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c |  2 +-
 arch/loongarch/net/bpf_jit.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index c4b1947ebf76..288003a9f0ca 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -841,7 +841,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		if (ret < 0)
 			return ret;

-		move_imm(ctx, t1, func_addr, is32);
+		move_addr(ctx, t1, func_addr);
 		emit_insn(ctx, jirl, t1, LOONGARCH_GPR_RA, 0);
 		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
 		break;
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index ca708024fdd3..c335dc4eed37 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -82,6 +82,27 @@ static inline void emit_sext_32(struct jit_ctx *ctx, enum loongarch_gpr reg, boo
 	emit_insn(ctx, addiw, reg, reg, 0);
 }

+static inline void move_addr(struct jit_ctx *ctx, enum loongarch_gpr rd, u64 addr)
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
 static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm, bool is32)
 {
 	long imm_11_0, imm_31_12, imm_51_32, imm_63_52, imm_51_0, imm_51_31;
--
2.31.1
