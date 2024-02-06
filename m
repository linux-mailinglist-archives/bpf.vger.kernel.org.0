Return-Path: <bpf+bounces-21372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C653C84BFC2
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E5B281230
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675A1CF8F;
	Tue,  6 Feb 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/thiNcO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C011C68A
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257116; cv=none; b=u2LlnPJQ3MEzii0hJObSHP3L1JeQ961zWF9J9DAoiwiUuKuVIHKPsPUsF8eRPs9BIKAw2bPWGy++G5NpVjZ62nNUDZxmOyKcB1+UIGtHkgNyhg5rQWl9GkbXESPo+D/FXHOri3et8/9WGmz4rR3EDSNfBhc1bJpgZnnvbOAW0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257116; c=relaxed/simple;
	bh=J1UZVDn6uI5UtDGhH2/mRbk7fjIbvzhRqLYTqIkwRcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vASa/WsDG5L8ziWDpxhlD0bdCo8eC2fPDNw55G+xQSJsxHtnBtBxgypIhWFish1p6OufPEFnl4UwYAeuCP2roVjKWQ9U903SKJRllJN4bw9FWszjytctrYjntMUsS5NI7taJ91b8X3L7z23Bi+AizoR61zMcmSQ406sWtVlygDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/thiNcO; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2909a632e40so4683520a91.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257113; x=1707861913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxmcZQXB6hILUuERStuFRZ0MPT4uFMATBLnu6rXBqLE=;
        b=T/thiNcOXgEhyEUgcmaRUCDCLqMy+LSsGRa4ywXlH9SovKEdN0mC4gaT45jjhoYZJZ
         ltGC/b3pzbjHTg8x70a46N5F0RaKDelxHeyhdT7RlhhZj6ia53rZ5ejqTc9gEma9uQd/
         HULtAg72CK5fiQgitJCSQAsfWoO4qkdlwMOz8I2GZS+TtVWIq2wm3v31mAzRGpjBhSf+
         WLrijyavBXcHGRW4Bp7Qg/aCHTBQnzRGD7yPa65oCJ4PmclXJm0vU6DtCicEgIFH33B2
         HZxoQt7bWE3rV/WqzJn2sAQShZQfQ2ToUnmTxMXvY9wCuCXzrZZ/Hw9SMpxTKTGFeorp
         AUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257113; x=1707861913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxmcZQXB6hILUuERStuFRZ0MPT4uFMATBLnu6rXBqLE=;
        b=n8bHtUTdl3BiGMeQbJtekdjTEvdmJOOS+iAZX6ePi7WmB/80CQ7u1MWKxuzMvkjNpL
         n9VFjjwShCXEKrhbuRYVFbzladGGoIVS2kkGMLWNCezslBDDTM6janofBVdA+NkG6ydu
         1MGFQ0hk1hoh0EwAzRseREFLnl5qo/b6f0EEe78wcznv2VyFOY3A4MYB5S0isLTTVidb
         IMj/vKgAUw4f7GCjIt/8bZa7N2rCyVyegu3raJgDULTvZ3T81RzFEW+/1aKRoBjxhWjx
         d6RlvFAMPhdBshs15R8pAVwgcZJhgBDHnQCKQiPVeBqIz+bYwcWwPeD0LRvmjJLVRPa8
         4SMg==
X-Gm-Message-State: AOJu0YypOfjfEGw2Fh8MxHky6wwAU//JAwCKhQrV1gCcRgsZPR91E1GL
	iUxDv0CPnIQClHxxLemzTgo7uiglqsS1pMQUrJt4ZFXjzWXp+6kS7m++PBXU
X-Google-Smtp-Source: AGHT+IG8oAHzR3nsr++sOa64aFqWnOY2L1+MMxXsvlNE4aY5ZiS0oyor0jQVKD0uoMrje1RiSvSdsA==
X-Received: by 2002:a17:90b:350c:b0:296:c1a:f651 with SMTP id ls12-20020a17090b350c00b002960c1af651mr884749pjb.36.1707257113308;
        Tue, 06 Feb 2024 14:05:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfwYB7FRrQvWfTk6tEr+uUBGbmaCq7+V+6esU7E5tJSAj1KK9tCNvR2xsEZBB081Xgy46YpR2sEOIbwIiK/1CsFdSNyQsZddCFwiLLxjRVFRaNhwuCFDq191OQ8uonJA+2UerpQK+JRy9zZAlFHa1wanOWMMIS+Hq7SpgXQH9IqaaVBQYUqYpa2d39hQfaUwO1B6BULxhIfZ+C2s4IrW++qdX5AoMMGyC9BAWf+AY6fWAWyCtugRHgQWZ74iaZkRKe4wMe8lkrZkmmvR1EPCVE9kBbPDe3DnDo
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id li4-20020a17090b48c400b00296b2f99946sm7168pjb.30.2024.02.06.14.05.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:12 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 07/16] bpf: Add x86-64 JIT support for bpf_cast_user instruction.
Date: Tue,  6 Feb 2024 14:04:32 -0800
Message-Id: <20240206220441.38311-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

LLVM generates bpf_cast_kern and bpf_cast_user instructions while translating
pointers with __attribute__((address_space(1))).

rX = cast_kern(rY) is processed by the verifier and converted to
normal 32-bit move: wX = wY

bpf_cast_user has to be converted by JIT.

rX = cast_user(rY) is

aux_reg = upper_32_bits of arena->user_vm_start
aux_reg <<= 32
wX = wY // clear upper 32 bits of dst register
if (wX) // if not zero add upper bits of user_vm_start
  wX |= aux_reg

JIT can do it more efficiently:

mov dst_reg32, src_reg32  // 32-bit move
shl dst_reg, 32
or dst_reg, user_vm_start
rol dst_reg, 32
xor r11, r11
test dst_reg32, dst_reg32 // check if lower 32-bit are zero
cmove r11, dst_reg	  // if so, set dst_reg to zero
			  // Intel swapped src/dst register encoding in CMOVcc

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 41 ++++++++++++++++++++++++++++++++++++-
 include/linux/filter.h      |  1 +
 kernel/bpf/core.c           |  5 +++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 883b7f604b9a..a042ed57af7b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1272,13 +1272,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 	bool tail_call_seen = false;
 	bool seen_exit = false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
-	u64 arena_vm_start;
+	u64 arena_vm_start, user_vm_start;
 	int i, excnt = 0;
 	int ilen, proglen = 0;
 	u8 *prog = temp;
 	int err;
 
 	arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
+	user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
 
 	detect_reg_usage(insn, insn_cnt, callee_regs_used,
 			 &tail_call_seen);
@@ -1346,6 +1347,39 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			break;
 
 		case BPF_ALU64 | BPF_MOV | BPF_X:
+			if (insn->off == BPF_ARENA_CAST_USER) {
+				if (dst_reg != src_reg)
+					/* 32-bit mov */
+					emit_mov_reg(&prog, false, dst_reg, src_reg);
+				/* shl dst_reg, 32 */
+				maybe_emit_1mod(&prog, dst_reg, true);
+				EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
+
+				/* or dst_reg, user_vm_start */
+				maybe_emit_1mod(&prog, dst_reg, true);
+				if (is_axreg(dst_reg))
+					EMIT1_off32(0x0D,  user_vm_start >> 32);
+				else
+					EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
+
+				/* rol dst_reg, 32 */
+				maybe_emit_1mod(&prog, dst_reg, true);
+				EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
+
+				/* xor r11, r11 */
+				EMIT3(0x4D, 0x31, 0xDB);
+
+				/* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
+				maybe_emit_mod(&prog, dst_reg, dst_reg, false);
+				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
+
+				/* cmove r11, dst_reg; if so, set dst_reg to zero */
+				/* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
+				maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
+				EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
+				break;
+			}
+			fallthrough;
 		case BPF_ALU | BPF_MOV | BPF_X:
 			if (insn->off == 0)
 				emit_mov_reg(&prog,
@@ -3424,6 +3458,11 @@ void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 	}
 }
 
+bool bpf_jit_supports_arena(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index cd76d43412d0..78ea63002531 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -959,6 +959,7 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
+bool bpf_jit_supports_arena(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2539d9bfe369..2829077f0461 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2926,6 +2926,11 @@ bool __weak bpf_jit_supports_far_kfunc_call(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_arena(void)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend satisfies the following two conditions:
  * 1) JIT backend supports atomic_xchg() on pointer-sized words.
  * 2) Under the specific arch, the implementation of xchg() is the same
-- 
2.34.1


