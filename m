Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305794598B6
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 00:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhKWAAu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWAAu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:00:50 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0D3C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:57:43 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id i12so17591795pfd.6
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KdhUfB49PKbAftJjKDBIPJ/fgwdLalrEdHwJeWyF7cY=;
        b=girTWKYy47721NqMcMFFST//5y+iXAqev4NmYvBtkZf4VCZ/PWH4Jp9AJ6VHVxXmJk
         BseF8jUHzbmMttj34XJ0xro/8meV37wqro/ccJW3TjDvGutEtQMaTZKvj/HCVZZ4l+f7
         r9DzKXAA1H99gvwzsXmLdNzzKnA4YBkWoe1fL8hwNNCQ7BCXgXD4KDfwpwI0CtYkEN22
         7fCSoSWqnTZli77b9OrReF+6RbqgegZpo/8YcypCsiawul50wV+VF8iRB6Mg3JIFau9b
         yumKIwu56lNoWt4UGl+GKcaABba14nj5Kse6fLAdjpZ5BK46uXpAFlAOBAercAp9WW8P
         kHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KdhUfB49PKbAftJjKDBIPJ/fgwdLalrEdHwJeWyF7cY=;
        b=hJ4ucJtYgVZEvBQh1DqcvctQtSkBZrf7qIU0kUgihA37vTC4SevQjYab65t/Cp+1w8
         CuNY/65F3QIMU32/j1Pfdtr3YxyieWjMFNB0sZENg2TV2gg+VMGLk6orujgTFapZVpJq
         IxRHcg/TluA7h9XrR2rgtvm1AM7kq8tPK9lsgI0n2iYWDlIpqm78daCWzFkDw9J5lEkd
         L4QOnd8/k+2MB8h4qmM9CsappdQX3uS48YfBO64ahShN1xi4krPbcDce7bh9gohMfWK7
         0wVRNkTM9XKd3Q89zu0qU9Yxk+doXJg6jhCy0OGU70UT6rXH8FUBt3RROUZTFO8ljWQO
         ER6w==
X-Gm-Message-State: AOAM530Iz5g6bCMQjhzMY/pBj5XG1F1gi5sWKAMW+kLsoCIjSsIZOTuV
        aTqCsT4vTKC8WoMZZhm7lJH2W8fnVMM=
X-Google-Smtp-Source: ABdhPJz0AJNU2nVq0I8nDnouXJGNTq3lkfh75rWNK1iEp4OTsmuJq1pqxKtGYZYTVjPTRsV+amAxRg==
X-Received: by 2002:a05:6a00:2186:b0:47c:f63:a6e9 with SMTP id h6-20020a056a00218600b0047c0f63a6e9mr1215637pfi.26.1637625462510;
        Mon, 22 Nov 2021 15:57:42 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id z71sm7115464pgz.52.2021.11.22.15.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:57:42 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 2/3] libbpf: Avoid double stores for success/failure case of ksym relocations
Date:   Tue, 23 Nov 2021 05:27:32 +0530
Message-Id: <20211122235733.634914-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122235733.634914-1-memxor@gmail.com>
References: <20211122235733.634914-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4161; h=from:subject; bh=HfIzFg4IQ8Aaea1lGphsZW8wN+fZoSrIpFKfLtyc1FU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhnC22rs4XUTG+fYSGFDn91E7t+9SluXG2CHWsmqtH cR0KaKGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZwttgAKCRBM4MiGSL8RyvpzEA CWutoheiQiDs+Y70JnBH9n0BMdyMvmAmmXY0DEQ8Lywg5XZzpoZf5Cgk8UpFPvGc0zOMirRsI291qo Ugu0vW0L7g1eQ+mjeDTz8KzszMvF8wefADFX9RE32erfSwLN5+iHhg2LKzny+uxGBE8mmVjyeXAGpe q6bnKGcGZfyqo1lblCgcs2otcAVKR8yCit6BLyjRlrTUDvjIIBhk7oc9+BHeL5n89ykdYlBsRMp/vz fCHot+agBLCbl3PNIIwous7bPjvSm1ZRrw4L+blmMDLD8oxWPDrJAduuy0C4n4QDjnvAdLZYt0kmp/ k0YLq2zY1c/I1HKS5sSLNV32/WMIHNHIPQtERR8AgvW8wymN9GISAZHIQ9x/jI25Ck6Q7BRx7VnkbG IEMkyw2TOY0pV10l4FVp0B+ZvCf401LV2CaBFQ2WlNV7NINnyh34pI2CIShZlfNJBXqTUK5lRjeTYH FZSLi5c0CdyLbbfFeFSX6szDn4d7fdZcGUwQRVsymZa4GHGFrBji6jZauHECuGqT/zOplp9CTzNn4C GSdwxQkqM+pBcThZNOi0z2s+FpQAHZAIbb/Gcvp7NiLLuT8QA/eFIaEogTN1k8VHx9jjMIHoTVTvUA 2cgC59FUTMkam2UPNbSIWCvKqTQFaJGMakqA6ipOjxMhnJ5Y1tTw9syEc4aw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead, jump directly to success case stores in case ret >= 0, else do
the default 0 value store and jump over the success case. This is better
in terms of readability. Readjust the code for kfunc relocation as well
to follow a similar pattern, also leads to easier to follow code now.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/gen_loader.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 7b73f97b1fa1..88da09665eef 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -688,27 +688,29 @@ static void emit_relo_kfunc_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo
 		return;
 	}
 	kdesc->off = btf_fd_idx;
-	/* set a default value for imm */
+	/* jump to success case */
+	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
+	/* set value for imm, off as 0 */
 	emit(gen, BPF_ST_MEM(BPF_W, BPF_REG_8, offsetof(struct bpf_insn, imm), 0));
-	/* skip success case store if ret < 0 */
-	emit(gen, BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0, 1));
+	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), 0));
+	/* skip success case for ret < 0 */
+	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 10));
 	/* store btf_id into insn[insn_idx].imm */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_7, offsetof(struct bpf_insn, imm)));
+	/* obtain fd in BPF_REG_9 */
+	emit(gen, BPF_MOV64_REG(BPF_REG_9, BPF_REG_7));
+	emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_9, 32));
+	/* jump to fd_array store if fd denotes module BTF */
+	emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0, 2));
+	/* set the default value for off */
+	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), 0));
+	/* skip BTF fd store for vmlinux BTF */
+	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 4));
 	/* load fd_array slot pointer */
 	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
 					 0, 0, 0, blob_fd_array_off(gen, btf_fd_idx)));
-	/* skip store of BTF fd if ret < 0 */
-	emit(gen, BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0, 3));
 	/* store BTF fd in slot */
-	emit(gen, BPF_MOV64_REG(BPF_REG_9, BPF_REG_7));
-	emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_9, 32));
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_9, 0));
-	/* set a default value for off */
-	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), 0));
-	/* skip insn->off store if ret < 0 */
-	emit(gen, BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0, 2));
-	/* skip if vmlinux BTF */
-	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_9, 0, 1));
 	/* store index into insn[insn_idx].off */
 	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), btf_fd_idx));
 log:
@@ -817,17 +819,20 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
 	emit_bpf_find_by_name_kind(gen, relo);
 	if (!relo->is_weak)
 		emit_check_err(gen);
-	/* set default values as 0 */
+	/* jump to success case */
+	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
+	/* set values for insn[insn_idx].imm, insn[insn_idx + 1].imm as 0 */
 	emit(gen, BPF_ST_MEM(BPF_W, BPF_REG_8, offsetof(struct bpf_insn, imm), 0));
 	emit(gen, BPF_ST_MEM(BPF_W, BPF_REG_8, sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm), 0));
-	/* skip success case stores if ret < 0 */
-	emit(gen, BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0, 4));
+	/* skip success case for ret < 0 */
+	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 4));
 	/* store btf_id into insn[insn_idx].imm */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_7, offsetof(struct bpf_insn, imm)));
 	/* store btf_obj_fd into insn[insn_idx + 1].imm */
 	emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_7, 32));
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_7,
 			      sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm)));
+	/* skip src_reg adjustment */
 	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
 clear_src_reg:
 	/* clear bpf_object__relocate_data's src_reg assignment, otherwise we get a verifier failure */
-- 
2.34.0

