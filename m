Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2DD64AE0C
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 04:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiLMDFj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 22:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiLMDFc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 22:05:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173B81A209;
        Mon, 12 Dec 2022 19:05:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so2124552pjm.2;
        Mon, 12 Dec 2022 19:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8wKW76JtFs2F5+hWCFZWeal4WDxfruIrmk6Ywx4Si4=;
        b=nMyvyxUJTgQlDMX08Le+mw3awdPBeGMcnKlhZx4cReQRGaNqBtTgMabpUeS++olgHa
         gIrQubgHL+pXSdRjAQpL7sKpal0+oOfxKX2KhmxIWH01fKapkp6k+LWWH3lBk5/DhXyG
         /UcG06Gtd+CBtBM1Mrs2l2Ocm9muOTfhOMFZvmLv3WCPgNt8rhj29ABSSHMHrxN8vJE2
         +o7O3ibuJOJmeQZpVo9ad9uTQ3EfkcSmcxU2OekPSJKcx9l1hUm5pLRlxHg1m5QwymDW
         3VwVw+5+tOgbYfMbdoQnBfE4sYJA0ldZ08bh2yQIeDyU7qye/7sYLBzzkaMKSTDqfD3E
         PcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8wKW76JtFs2F5+hWCFZWeal4WDxfruIrmk6Ywx4Si4=;
        b=UPwAQEbdvsa5yhz6W+vZFSzXU6pp8/B1wF3NbrfYqfiSnBC5feshNdhXRb2m9U6oQM
         BcFuRKENGYz+Jv4WnuHoPriQcoK5J8wQpDIyCeDC4/0D1voC7Qd6uVgSX9O0pibMFSzD
         uG3dhrGtoh7ArMjfThEb7MeR0GRGEp+ML2uRSkYLOa58IrPzNFxAKp5pIH+IGPnQnfMm
         QHBIm7E2yWYQfVEl9JvJnNb5t10H1IDfGaCCg50lTqTGXJ6BX8FG6N04JtS22MCNOteT
         9wj+xM0T8866GVZ89ahABU34DmVDprzO5OcO8sNCwazWZqtK05qydFnmb5SP8tZIakQQ
         aXXw==
X-Gm-Message-State: ANoB5pm/OjaF9EagP++Uf9JDII+SsZsIa7h5RXRdC9OMy2r7sZwwE21t
        IY+ixh4xZFqaQZ/xY+jEMCPgVZ35Y22V
X-Google-Smtp-Source: AA0mqf4jMuhgu2xaWXPmqap5CNcPUFjcJ/bD9N3t0xLKi8jYQXOMj/VRXxwRZSbdYxvdEne0tks+Lg==
X-Received: by 2002:a05:6a21:3397:b0:a5:70ed:bda9 with SMTP id yy23-20020a056a21339700b000a570edbda9mr32647414pzb.26.1670900730224;
        Mon, 12 Dec 2022 19:05:30 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id z21-20020aa79495000000b005746c3b2445sm6481716pfk.151.2022.12.12.19.05.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Dec 2022 19:05:29 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: check null propagation only neither reg is PTR_TO_BTF_ID
Date:   Tue, 13 Dec 2022 11:04:36 +0800
Message-Id: <20221213030436.17907-2-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221213030436.17907-1-sunhao.th@gmail.com>
References: <20221213030436.17907-1-sunhao.th@gmail.com>
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

Verify that nullness information is not porpagated in the branches
of register to register JEQ and JNE operations if one of them is
PTR_TO_BTF_ID.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/verifier/jeq_infer_not_null.c         | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
index 67a1c07ead34..b2b215227d97 100644
--- a/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
@@ -172,3 +172,25 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.result = ACCEPT,
 },
+{
+	"jne/jeq infer not null, PTR_TO_MAP_OR_NULL unchanged with PTR_TO_BTF_ID reg",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	/* r6 = bpf_map->inner_map_meta; */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 8),
+	/* r0 = map_lookup_elem(r1, r2); */
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	/* if (r0 == r6) read *r0; */
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_6, BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_8b = { 3 },
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.result = REJECT,
+	.errstr = "R0 invalid mem access 'map_value_or_null'",
+},
-- 
2.38.1

