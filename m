Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0E63840D
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 07:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKYGg5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 01:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiKYGgz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 01:36:55 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11C329838;
        Thu, 24 Nov 2022 22:36:48 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b62so3221929pgc.0;
        Thu, 24 Nov 2022 22:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBJjxQmOrEZrnpEuQrvFjGMPHF9guw+LWjz0eneC8SE=;
        b=BiH1Nypr9XqG9qII974B13vHBqKSfJOB+OrFzA0+L2WUCatoReNQS/f4d49Ls/4j8t
         K9Wi7Uu71i6dZawT2IhD2GeJGojOn2UQjAksAJPL88Har5uTiFCAZlmckU7tCR7mPFD+
         uTcNFKi/aAu6X7nQc5ooqdDOzKhGdo0vO9xAELTV1pBSPmOfkrCBZTxZbPim5k0kUyuK
         PrAhc0ZtVjBwwj07CpN12+5kK4lIYcmTgba/RXuwIX3zizYFrTGiIjVt6PtqxY0u8mz5
         qPO7qzffSPnfclXmiWO9jAbJh/aDGVMt2UPLXW+InxhvqZZyPMYrOgzs5spH9Jv1q7zP
         SUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBJjxQmOrEZrnpEuQrvFjGMPHF9guw+LWjz0eneC8SE=;
        b=Dn4FhZdcSRCWPWsI1gYYQ+ctmA4bPtTYaQp0wVnGQyBSHsLOxn49DUc8Fo2DBhePZR
         55p9TIL0aoIVeYuxS4+7xbf1IvBWvJQFIOrgIF89ZhvdcenY5djBmHRi1hZx6F3ujYYq
         TzJ/LXqna/snQLK2tW6+i3ayXI/fZBXssVoZvRAZkXmzTirsg2F9tBLseLZaBFtBmajy
         frRspPZ0SIJV/LSAHbOt+KBEv7JjRas7sAu6sRLmak8BDR7/kcHH05fTfCVXQo9bzxul
         6o5i1OFrNn9Qqi6WisVNtrdg6LH15s3nOnc5BBN8FEVLNVvIpZXw7BuvM8BFsQKXTNBW
         Aq+Q==
X-Gm-Message-State: ANoB5plp/w8R937ABmVaLw4S7X6HGYZ9So5Pm+6f3md68NSE+ZWF1wyS
        pVqro4vctwwb+giNp9RdhWBqPjHFtcZV
X-Google-Smtp-Source: AA0mqf4oCs/QdvP+mdX80RRoFYB5hNLGW2SwBhzt7ikPxK+XDbFgE3xrLijFcyFXlOoK0adZ6zKi6g==
X-Received: by 2002:a63:1e62:0:b0:46b:3acb:77b2 with SMTP id p34-20020a631e62000000b0046b3acb77b2mr13934331pgm.560.1669358207936;
        Thu, 24 Nov 2022 22:36:47 -0800 (PST)
Received: from pc.localdomain ([166.111.83.15])
        by smtp.gmail.com with ESMTPSA id nm18-20020a17090b19d200b001fd6066284dsm2214891pjb.6.2022.11.24.22.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 22:36:47 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v2 2/3] bpf: Sanitize LDX in jited BPF progs with KASAN
Date:   Fri, 25 Nov 2022 14:36:29 +0800
Message-Id: <20221125063630.536657-3-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125063630.536657-1-sunhao.th@gmail.com>
References: <20221125063630.536657-1-sunhao.th@gmail.com>
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

Make the verifier sanitize LDX insns in jited BPF programs. The
dst_reg and AX are free here, different insns that backup R0&R1
are inserted based on their relationships with dst_reg and src,
all the scratch regs are backed up to extended stack space before
calling the checking functions. Finally, the checking funcs are
inserted, and regs are restored.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/verifier.c | 90 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5519c24c5bd4..4e253fc20bf2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15344,6 +15344,17 @@ BPF_ASAN_STORE(16);
 BPF_ASAN_STORE(32);
 BPF_ASAN_STORE(64);
 
+#define BPF_ASAN_LOAD(n)                         \
+	notrace u64 bpf_asan_load##n(u##n *addr) \
+	{                                        \
+		return *addr;                    \
+	}
+
+BPF_ASAN_LOAD(8);
+BPF_ASAN_LOAD(16);
+BPF_ASAN_LOAD(32);
+BPF_ASAN_LOAD(64);
+
 #endif
 
 /* Do various post-verification rewrites in a single program pass.
@@ -15588,6 +15599,85 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			insn = new_prog->insnsi + i + delta;
 			continue;
 		}
+
+		/* Sanitize LDX operation*/
+		if (BPF_CLASS(insn->code) == BPF_LDX) {
+			struct bpf_insn sanitize_fn;
+			struct bpf_insn *patch = &insn_buf[0];
+			bool dst_is_r0 = insn->dst_reg == BPF_REG_0;
+			bool dst_is_r1 = insn->dst_reg == BPF_REG_1;
+
+			if (in_patch_use_ax || insn->src_reg == BPF_REG_10)
+				continue;
+
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_B:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_load8);
+				break;
+			case BPF_H:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_load16);
+				break;
+			case BPF_W:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_load32);
+				break;
+			case BPF_DW:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_load64);
+				break;
+			}
+
+			/* Backup R0 and R1, REG_AX and dst_reg are free. */
+			if (insn->src_reg == BPF_REG_1) {
+				if (!dst_is_r0)
+					*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_0);
+			} else if (insn->src_reg == BPF_REG_0) {
+				if (!dst_is_r1)
+					*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
+			} else if (!dst_is_r1) {
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, insn->src_reg);
+				if (!dst_is_r0)
+					*patch++ = BPF_MOV64_REG(insn->dst_reg, BPF_REG_0);
+			} else {
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, insn->src_reg);
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_0);
+			}
+			if (insn->off != 0)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, insn->off);
+			BACKUP_SCRATCH_REGS;
+			/* Invoke sanitize fn, R1~R5 are stored to stack during jit. */
+			*patch++ = sanitize_fn;
+			RESTORE_SCRATCH_REGS;
+			if (insn->off != 0)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -insn->off);
+			if (insn->src_reg == BPF_REG_1) {
+				if (!dst_is_r0)
+					*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_AX);
+			} else if (insn->src_reg == BPF_REG_0) {
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+				if (!dst_is_r1)
+					*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_AX);
+			} else if (!dst_is_r1) {
+				if (!dst_is_r0)
+					*patch++ = BPF_MOV64_REG(BPF_REG_0, insn->dst_reg);
+				if (insn->src_reg == insn->dst_reg)
+					*patch++ = BPF_MOV64_REG(insn->src_reg, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_AX);
+			} else {
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_AX);
+			}
+			*patch++ = *insn;
+			cnt = patch - insn_buf;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta += cnt - 1;
+			env->prog = prog = new_prog;
+			insn = new_prog->insnsi + i + delta;
+			continue;
+		}
 #endif
 
 		if (insn->code != (BPF_JMP | BPF_CALL))
-- 
2.38.1

