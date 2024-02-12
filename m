Return-Path: <bpf+bounces-21722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BE7850CF6
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 03:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0BD28738C
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C7468D;
	Mon, 12 Feb 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PahwK4Ny"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDEAD533
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706539; cv=none; b=d+YU9d7UWvlSv0gpAiTALkuuxeowu1QGrmvutst9ibwRsIVf9YNPoLvYBLU9ZtwKjA+XMHgNZWyqgVL+I4OYT2jF5idR4GLDvEbnTg7EYRQGg20QhUpctaxUWlqjMTd94C5r9wiRpTQ8IWYKsk4/iI/fTkJxT8GPdiGvxCAOQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706539; c=relaxed/simple;
	bh=AXO7VsflvKGWTnEvz0+V2dNgfy1ulMK/F7UiLVzpIV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lc9gBmOmd1tV16r+IqcLCHluFrEFPuWxO412JGK79/9RweQN7bB0UAIiiiQ8hcTUc+0TB+Q6pMS/3NFBgzEz61Ur5n63MOnYUukseqKU27rbMlWPpDfs4Tq2LKLkeNQ5XNIwIhXn4ognLHfRTFw7nJHJLmSoaq2ZiYei3b+Aptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PahwK4Ny; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d93edfa76dso22188435ad.1
        for <bpf@vger.kernel.org>; Sun, 11 Feb 2024 18:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707706535; x=1708311335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J8NdLE0ucNiNKFND0rK4zdkXC5jx9zUaL7zwsJdJPc=;
        b=PahwK4NyuQ04a94ZVkBg4mEywR/its8gyuo29TCJ/e+ePRZn8l6xK6IWUJqJybOS4F
         jG4XsUxVw0Lsck4UQaXaVTpH6bLu3cwQ5Uh0AtCjpaCoEkduPPtFSU0FC8RgCJ2r8lX3
         UxxXpxa7nljntlZNP+UrtM1PSimWng9GA0iEtai+Y7eheAgFOEYAUY5N1DtWTrKwVvhP
         ZYCeu5dlM5Yy4/Eu3DwwquIw0Zdeh9JhvatjA+Wqemw4w/BvfeFJYunENmvcxPPDbkCd
         RSHaLwsURRGW2qwRygAUONw5jKoQ22F0KVpMcuHTh0VW2CXG8so0AHr4tRm9bqLLhZS8
         HB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707706535; x=1708311335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J8NdLE0ucNiNKFND0rK4zdkXC5jx9zUaL7zwsJdJPc=;
        b=XnP9h8l/+YcjH/92LwtDPB11S7QOzPtCe4bcw4L9xFmE0kGQK6ueDEI7/IctHnjNFH
         3j5H3ynxhMsSh1SbyWfraQA4sDPA4klwSZ2p9TCGyzMcqlwzbtVGVb3SUvo/DkAPBhuN
         2RF5CEVfUAQ6dCwlqbCCQQ3l6qeFoHlGMZIrq/QOeopGlCKXUgJVgykepfFqwB9MOniO
         FuVt5TCKHUbLbvh8uPgy2tc0LK36eQu3HctptMNSg4JkEXGSiRtm/iuk+6CL5a1jG55x
         U7LD7Pbt5f78wY56WX/xErwF8KKhrcBtxgB4rAeARtjqbBdVlF+iZM/vF7uRO5WRLIzp
         voCg==
X-Forwarded-Encrypted: i=1; AJvYcCWN7Z0lD2sHhOWmmVjzB8SH0tv7vmCjIY6MZnwW8vEyK0CdKZa/UVtbt6ayehVZV/3rbp2y+url93EMXP//2+xDII3p
X-Gm-Message-State: AOJu0YyP5YFg1Ahb393XCWj7/VO03v9eQJGb2pqJByj9UIT/Pw131usf
	4u7k8zNxHA4H3zrdLXDTcg0ZnNVhbBSXzAEbqQtDec15Ib1gceu7NwhIxhXXi7c=
X-Google-Smtp-Source: AGHT+IFUXXjAhYh8fPaDzJdt/6c0qL5uB2s4002mQVmQJYBv4oZI2UnLxM9T/HLUqj7hh7tlkNZOxg==
X-Received: by 2002:a17:903:25d2:b0:1d9:ed80:607f with SMTP id jc18-20020a17090325d200b001d9ed80607fmr5933876plb.41.1707706535523;
        Sun, 11 Feb 2024 18:55:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMVP8J2/uywWjIa8v+LtUBwTbCg6k4nUS11lldS4d4SPpgOkiUESJKifpQiePYf+5sb5RPwR8/2RD7ppjseWiDMb+tH3c47JIEhVd/KYoxUfEzqxLbMUoa1Z6QGicm0wv/0P7m6Mt2up3tJ9kh5+AfUU29Up1ThFadmZrNYH3Ghb/6ZESNPzpIMTLZVkLg6+08WA==
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d9af77893esm4906443plb.58.2024.02.11.18.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:55:35 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org
Subject: [PATCH 5/7] riscv: Pass patch_text() the length in bytes
Date: Sun, 11 Feb 2024 18:55:16 -0800
Message-ID: <20240212025529.1971876-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212025529.1971876-1-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

patch_text_nosync() already handles an arbitrary length of code, so this
removes a superfluous loop and reduces the number of icache flushes.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/patch.h     |  2 +-
 arch/riscv/kernel/patch.c          | 15 +++++----------
 arch/riscv/kernel/probes/kprobes.c | 20 +++++++++++---------
 arch/riscv/net/bpf_jit_comp64.c    |  7 ++++---
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index 9f5d6e14c405..7228e266b9a1 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -9,7 +9,7 @@
 int patch_insn_write(void *addr, const void *insn, size_t len);
 int patch_text_nosync(void *addr, const void *insns, size_t len);
 int patch_text_set_nosync(void *addr, u8 c, size_t len);
-int patch_text(void *addr, u32 *insns, int ninsns);
+int patch_text(void *addr, u32 *insns, size_t len);
 
 extern int riscv_patch_in_stop_machine;
 
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 7f030b46eae5..9aa0050225c0 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -19,7 +19,7 @@
 struct patch_insn {
 	void *addr;
 	u32 *insns;
-	int ninsns;
+	size_t len;
 	atomic_t cpu_count;
 };
 
@@ -227,15 +227,10 @@ NOKPROBE_SYMBOL(patch_text_nosync);
 static int patch_text_cb(void *data)
 {
 	struct patch_insn *patch = data;
-	unsigned long len;
-	int i, ret = 0;
+	int ret = 0;
 
 	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
-		for (i = 0; ret == 0 && i < patch->ninsns; i++) {
-			len = GET_INSN_LENGTH(patch->insns[i]);
-			ret = patch_text_nosync(patch->addr + i * len,
-						&patch->insns[i], len);
-		}
+		ret = patch_text_nosync(patch->addr, patch->insns, patch->len);
 		atomic_inc(&patch->cpu_count);
 	} else {
 		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
@@ -247,13 +242,13 @@ static int patch_text_cb(void *data)
 }
 NOKPROBE_SYMBOL(patch_text_cb);
 
-int patch_text(void *addr, u32 *insns, int ninsns)
+int patch_text(void *addr, u32 *insns, size_t len)
 {
 	int ret;
 	struct patch_insn patch = {
 		.addr = addr,
 		.insns = insns,
-		.ninsns = ninsns,
+		.len = len,
 		.cpu_count = ATOMIC_INIT(0),
 	};
 
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index cbf8197072bf..a64461fa715c 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -23,14 +23,14 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
+	size_t len = GET_INSN_LENGTH(p->opcode);
 	u32 insn = __BUG_INSN_32;
-	unsigned long offset = GET_INSN_LENGTH(p->opcode);
 
-	p->ainsn.api.restore = (unsigned long)p->addr + offset;
+	p->ainsn.api.restore = (unsigned long)p->addr + len;
 
-	patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
-	patch_text_nosync(p->ainsn.api.insn + offset,
-			  &insn, 1);
+	patch_text_nosync(p->ainsn.api.insn, &p->opcode, len);
+	patch_text_nosync(p->ainsn.api.insn + len,
+			  &insn, GET_INSN_LENGTH(insn));
 }
 
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
@@ -117,16 +117,18 @@ void *alloc_insn_page(void)
 /* install breakpoint in text */
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
-	u32 insn = (p->opcode & __INSN_LENGTH_MASK) == __INSN_LENGTH_32 ?
-		   __BUG_INSN_32 : __BUG_INSN_16;
+	size_t len = GET_INSN_LENGTH(p->opcode);
+	u32 insn = len == 4 ? __BUG_INSN_32 : __BUG_INSN_16;
 
-	patch_text(p->addr, &insn, 1);
+	patch_text(p->addr, &insn, len);
 }
 
 /* remove breakpoint from text */
 void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
-	patch_text(p->addr, &p->opcode, 1);
+	size_t len = GET_INSN_LENGTH(p->opcode);
+
+	patch_text(p->addr, &p->opcode, len);
 }
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 719a97e7edb2..43be2585f0d4 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -14,6 +14,7 @@
 #include "bpf_jit.h"
 
 #define RV_FENTRY_NINSNS 2
+#define RV_FENTRY_NBYTES (RV_FENTRY_NINSNS * 4)
 
 #define RV_REG_TCC RV_REG_A6
 #define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
@@ -681,7 +682,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	if (ret)
 		return ret;
 
-	if (memcmp(ip, old_insns, RV_FENTRY_NINSNS * 4))
+	if (memcmp(ip, old_insns, RV_FENTRY_NBYTES))
 		return -EFAULT;
 
 	ret = gen_jump_or_nops(new_addr, ip, new_insns, is_call);
@@ -690,8 +691,8 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
-	if (memcmp(ip, new_insns, RV_FENTRY_NINSNS * 4))
-		ret = patch_text(ip, new_insns, RV_FENTRY_NINSNS);
+	if (memcmp(ip, new_insns, RV_FENTRY_NBYTES))
+		ret = patch_text(ip, new_insns, RV_FENTRY_NBYTES);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 
-- 
2.43.0


