Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8363120AF
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 02:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBGBL4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 20:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhBGBLz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 20:11:55 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2372C061788
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 17:11:14 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id ew18so5406629qvb.4
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 17:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YkjvP0DdMns7yyDccaUP9qx46lk4M3AAq20jcDjy1Ns=;
        b=SA8H2KMr4RD3BbafeFVeuanYAImbKNt3S4RpJhid/OUs15iIOnfMFSZeBajwvstpL2
         NEEOp3X68FTOWtLjN6oKJLXmGtXI72h+K60Irt3OSLKzjMKrxVFGhnx8lfW6uIFjnPpy
         z9ru71GZswHMn7yJkj39T4taqpRxsmzvNA8S3rYxjhBF2UpNMIpVn1rY44NyNKW0e5YS
         N3ts69FAATsa08hPQ6s17k1jPbfY4RtkCbQpNG4JS4Q/fh6o6Ltwu4Vy8ucoDB+tCCi9
         JCGXF1h5a5AmA68JQ1SX5n8Rw/wRWom4Q+NvcUx9aQAzIlUfAhLNyCYSK30H1nQ9N7LK
         Y4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YkjvP0DdMns7yyDccaUP9qx46lk4M3AAq20jcDjy1Ns=;
        b=XmORG68lvFHtaG/6+NBzkUrM/7OxWpU28HvPllLZeHD9SpxcYDW0g3zOJJo93bxg+0
         p9TSuMxywTQUZmWASe1WI1iZYpHv4j8wYT363FeVsc19l/xhHTSyJi+qH3bHPrbyFdnY
         xFi+tXFAvcb1A6YqZTq1dKmXiPK5/svQijjsBi3xEuYRk032wfpDgjMUvnqHIYfwhXhb
         YmP8ufXHeS3A7zbnFGrytyw1pkKWVNA+fxRrY61S047YxYwxd80rw/mazZT2dSHZ4DdG
         MTyDdbHJzVeOML8xv3+J8rhZhfArSDMyjXeXa4CJeLSBsmFE3GWTC/z7+iN4blKWCnZM
         NIUg==
X-Gm-Message-State: AOAM532M9BtlJFKeONlW60tVV8Ci6aY9N6UGdwYkxBXvg/CwcO2PYvVE
        dZK2ralLHj1mA4YjSv9e1+waExXLjdPifg==
X-Google-Smtp-Source: ABdhPJzkNcUXxdeRj5oN1cQ2AiFz3YAem5ew+II7yh52rrBs1teaMsSFnTLyAwcEz+PLP+Z0NMtUiQ==
X-Received: by 2002:a0c:e48b:: with SMTP id n11mr10909332qvl.10.1612660273535;
        Sat, 06 Feb 2021 17:11:13 -0800 (PST)
Received: from localhost (pool-100-33-73-206.nycmny.fios.verizon.net. [100.33.73.206])
        by smtp.gmail.com with ESMTPSA id z6sm5788628qtu.8.2021.02.06.17.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 17:11:13 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v3 3/4] selftest/bpf: verifier tests for var-off access
Date:   Sat,  6 Feb 2021 20:10:26 -0500
Message-Id: <20210207011027.676572-4-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210207011027.676572-1-andreimatei1@gmail.com>
References: <20210207011027.676572-1-andreimatei1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests for the new functionality - reading and writing to the stack
through a variable-offset pointer.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 .../testing/selftests/bpf/verifier/var_off.c  | 99 ++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index 49b78a1a261b..eab1f7f56e2f 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -31,14 +31,109 @@
 	 * we don't know which
 	 */
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* dereference it */
+	/* dereference it for a stack read */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
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
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
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
+	/* Add it to fp.  We now have either fp-8 or fp-16, but
+	 * we don't know which
+	 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
+	/* Dereference it for a stack write */
+	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
+	/* Now read from the address we just wrote. This shows
+	 * that, after a variable-offset write, a priviledged
+	 * program can read the slots that were in the range of
+	 * that write (even if the verifier doesn't actually know
+	 * if the slot being read was really written to or not.
+	 */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	/* Variable stack access is rejected for unprivileged.
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

