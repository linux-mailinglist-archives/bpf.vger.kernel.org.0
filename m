Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404DA65A5BC
	for <lists+bpf@lfdr.de>; Sat, 31 Dec 2022 17:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLaQcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Dec 2022 11:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiLaQb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Dec 2022 11:31:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7865860DC
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:57 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bq39so28070455lfb.0
        for <bpf@vger.kernel.org>; Sat, 31 Dec 2022 08:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTwJ2nVIbZLOrmwr84DjM066lT1iOvHJx4fc7Eomo04=;
        b=KURCfXZtzJPcUKe5O/IVhILqL+r1hy9KuT53h1HOMNU8gmYJG9jB1PlKzMQu3dcS9N
         x9/Qyg/rQgOlRBovWQn8IRQ1TJMIU/n3AxkxEykKu1qsHuupdZrqoCGP0lwSnhqSeMm7
         aWTBfuc8nRwDebBQI4RA6xcpDSGopAVTN8xqFHxQIQPD1e6fxlRr8SkvV6vL84twZKfP
         uS14u2VXUo8DWfrhNsHQ61AToTx4R7eArRsl6zXpaTS0zcYQvQwDU2cc6mHE00FW36Dw
         T5xClia69FRwAXmFF+sdyMxCHZ+sldsTJDaRcyQuyINmI3XGVgdNmbsMfETVnpO7eDYj
         mVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTwJ2nVIbZLOrmwr84DjM066lT1iOvHJx4fc7Eomo04=;
        b=X53D5sw2GGCCR7nQPZj32aTy3xIYNHlrV4HcJ0tttZ/iP0fAtajFtAhZiaDuEzMyYt
         uFNsvFyVPiJ2uyHAYZdbu4Nx7/dCSfdud8MAgk1m4uf3P2PQJQgeH+JDqawxUfMuANaX
         O92X5zMODSLO61UmAwVOMEaYkP2+b2MK8jbNeUbbocQdqE7tSkZWISQXPh/VUfeL5wVq
         UPnQ4552sD1wHKyRyUItvRRgrg9FsEizoAnaIbp9qCBUPvxM6GSIF8bS/+jeC+7HEgVO
         nw1/S0Bf+Vd8HfZhOgVUR8kLeDVngecVLd0+HM+NWtAqALGqGBE0pSafaMSZtiQmw0yd
         ewAQ==
X-Gm-Message-State: AFqh2kpATtBFfuU7ptKcfqJW1TqiYgzw7niA1pZlKCLBwkY+VgcnT6Oc
        YiNWKL0OlxDEHgK54kpi2ffypiYsLmE=
X-Google-Smtp-Source: AMrXdXsWHjgnl85BfbfaAupHzVDXMKfRzd10yxACNfJ6YCc7Iy6+C5iU6gfVFAXzasUEmJfCZBsEyA==
X-Received: by 2002:ac2:414b:0:b0:4b5:3505:d7f9 with SMTP id c11-20020ac2414b000000b004b53505d7f9mr9403839lfi.35.1672504315709;
        Sat, 31 Dec 2022 08:31:55 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a19e34a000000b004b4930d53b5sm3876784lfk.134.2022.12.31.08.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:31:55 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 2/5] selftests/bpf: check if verifier tracks constants spilled by BPF_ST_MEM
Date:   Sat, 31 Dec 2022 18:31:19 +0200
Message-Id: <20221231163122.1360813-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231163122.1360813-1-eddyz87@gmail.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Check that verifier tracks the value of 'imm' spilled to stack by
BPF_ST_MEM instruction. Cover the following cases:
- write of non-zero constant to stack;
- write of a zero constant to stack.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/verifier/bpf_st_mem.c       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/verifier/bpf_st_mem.c

diff --git a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
new file mode 100644
index 000000000000..d3aa293f1a9d
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
@@ -0,0 +1,29 @@
+{
+	"BPF_ST_MEM stack imm non-zero",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 42),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, -42),
+	/* if value is tracked correctly R0 is zero */
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ST_MEM stack imm zero",
+	.insns = {
+	/* mark stack 0000 0000 */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	/* read and sum a few bytes */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_10, -8),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_10, -4),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_10, -1),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	/* if value is tracked correctly R0 is zero */
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
-- 
2.39.0

