Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537C5301E89
	for <lists+bpf@lfdr.de>; Sun, 24 Jan 2021 20:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhAXTvb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jan 2021 14:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbhAXTvb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jan 2021 14:51:31 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7BAC061756
        for <bpf@vger.kernel.org>; Sun, 24 Jan 2021 11:50:50 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id e15so8200744qte.9
        for <bpf@vger.kernel.org>; Sun, 24 Jan 2021 11:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bgwHnddA87j7JijmqCmS9KXHtF7iZ3lpnr+15jvvlw=;
        b=XOAoQMGCgTfr/k7ln5hp1N5Uikzo1o6raE59fePhu66I7dTbCJBcOl7qQPU1x3dZbo
         YkKeANmEYgRDJcgA9OSlfBpeS9nfek6fZZwMtpA1SthMGvdPJ4EMByDCNfdv4uEjyHGP
         RM9auruL0OB3l3WjFXLSdYiM67KSxKL5fFoET5rPQAF8lZcvtVZpJtI7x3GO37QEZ+I7
         bhGeHxGccq62morqOobf3cHMjhgPqUC3De2eDCFzUvd0VORqMzEVPzlwKLSCxE/NW9Vn
         OhlCJw3Z9A6LfnLjI5O2w/9XTwf+c4/aUD4fs/b5j2bCgEjdb4zpYpYpGMcxLZ2BfZPn
         DNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bgwHnddA87j7JijmqCmS9KXHtF7iZ3lpnr+15jvvlw=;
        b=P5ednexKe/P0stP+U9DKwd9GUxjqgbFwq4wyfpWnvqn59XV4rM6Sh8pn9Bd/S8yOdD
         TdWlQtDNUMRFxxuUUSd6DoPa87IUyAf7JGruISjTVhfTAdXcQR+DvyqhxOY+RMYgOpy9
         EAWZ0pZIWvn6JP4PirKbfmROJDaxMn+CH/IGpds2IVDy6Rxcz4vjbTCrOTjhQqQ5qb9S
         dLUUjz5dYqqw5KVvxuehNsOO9VTZ6iwukQCIV7UMaYK+BJxachQXL19g0lzLiKw6Bv3q
         11yGeAlInS24ZbsTfvwuoE8kv/rYjkbjqWix8QAnI+rHK16dEIW+gDJcVN5yiFrihYv8
         BFLQ==
X-Gm-Message-State: AOAM5322oa1dnu+/YswO2T4p9aq1ltdmDYtgDcOZdHHq2kJDcQzgsfSd
        ysN6YbSf3IeLCjzsM0ttVrEi5Ae5SXkvTA==
X-Google-Smtp-Source: ABdhPJyRnpm2T1SMboF22cHHkptradcG73fjD7ptaQ2ZlNwzQp8qOQPMqyFjAS27h1ppofLAFV0wWQ==
X-Received: by 2002:ac8:7304:: with SMTP id x4mr1666536qto.338.1611517849496;
        Sun, 24 Jan 2021 11:50:49 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id o75sm4661995qke.77.2021.01.24.11.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 11:50:48 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v2 3/5] selftest/bpf: verifier tests for var-off access
Date:   Sun, 24 Jan 2021 14:49:07 -0500
Message-Id: <20210124194909.453844-4-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210124194909.453844-1-andreimatei1@gmail.com>
References: <20210124194909.453844-1-andreimatei1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests for the new functionality - reading and writing to the stack
through a variable-offset pointer.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 .../testing/selftests/bpf/verifier/var_off.c  | 92 ++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index 49b78a1a261b..a03ad17d73fa 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -31,14 +31,102 @@
 	 * we don't know which
 	 */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* dereference it */
+	/* dereference it for a stack read */
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "R2 variable stack access prohibited for !root",
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+},
+{
+	"variable-offset stack read, uninitialized",
+	.insns = {
+	/* Get an unknown value */
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
+	/* Make it small and 4-byte aligned */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
+	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 8),
+	/* add it to fp.  We now have either fp-4 or fp-8, but
+	 * we don't know which
+	 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
+	/* dereference it for a stack read */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "variable stack access var_off=(0xfffffffffffffff8; 0x4)",
 	.result = REJECT,
+	.errstr = "invalid variable-offset read from stack R2",
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
+{
+	"variable-offset stack write, priv vs unpriv",
+	.insns = {
+	/* Get an unknown value */
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
+	/* Make it small and 8-byte aligned */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 8),
+	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
+	/* add it to fp.  We now have either fp-8 or fp-16, but
+	 * we don't know which
+	 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
+	/* dereference it for a stack write */
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	/* Variable stack access is rejected.
+	 */
+	.errstr_unpriv = "R2 variable stack access prohibited for !root",
+	.result_unpriv = REJECT,
+	.result = ACCEPT,
+},
+{
+	"variable-offset stack write clobbers spilled regs",
+	.insns = {
+	/* Dummy instruction; needed because we need to patch the next one
+	 * and we can't patch the first instruction.
+	 */
+	BPF_MOV64_IMM(BPF_REG_6, 0),
+	/* Make R0 a map ptr */
+	BPF_LD_MAP_FD(BPF_REG_0, 0),
+	/* Get an unknown value */
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
+	/* Make it small and 8-byte aligned */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 8),
+	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
+	/* Add it to fp. We now have either fp-8 or fp-16, but
+	 * we don't know which.
+	 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
+	/* Spill R0(map ptr) into stack */
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
+	/* Dereference the unknown value for a stack write */
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
+	/* Fill the register back into R2 */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -8),
+	/* Try to dereference R2 for a memory load */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 8),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_8b = { 1 },
+	/* The unpriviledged case is not too interesting; variable
+	 * stack access is rejected.
+	 */
+	.errstr_unpriv = "R2 variable stack access prohibited for !root",
+	.result_unpriv = REJECT,
+	/* In the priviledged case, dereferencing a spilled-and-then-filled
+	 * register is rejected because the previous variable offset stack
+	 * write might have overwritten the spilled pointer (i.e. we lose track
+	 * of the spilled register when we analyze the write).
+	 */
+	.errstr = "R2 invalid mem access 'inv'",
+	.result = REJECT,
+},
 {
 	"indirect variable-offset stack access, unbounded",
 	.insns = {
-- 
2.27.0

