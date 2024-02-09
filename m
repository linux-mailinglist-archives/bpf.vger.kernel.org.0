Return-Path: <bpf+bounces-21592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A13684EF8C
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB951C23596
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6D5226;
	Fri,  9 Feb 2024 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clp5xwBJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122B5695
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451609; cv=none; b=QwkyyoEOnofLzx0dcfQRShx0IPsofW08BRWFo2KEUY5wtI/BYhZC5i7rkOqQpGdFMUbFXz4QvgoCqFmxhdiBM4H7IZCKCue20qWo7evqLsX4eGYOQfJZ37n+oKVOY/Flz1mz+QiAHanHXpiy5Xh1cBKkOHh3VepCx80dwAC5oT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451609; c=relaxed/simple;
	bh=J1UZVDn6uI5UtDGhH2/mRbk7fjIbvzhRqLYTqIkwRcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s9i27zVRk0HK95vQagoD36bvYuUFGrprlbTFHZlr5xJD7cQIHR/IjFL20ohXKu0pRNGOldyxqlK6Ua1ALnoOXcxhWMrb7WKvhiBZ4wjEe3Lr7xQlYZiui6ovcSpxLfm4AB0f0arvJwQxxio3gsMI3AX7SqzK72gL0P3CKeQzv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clp5xwBJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dc20645871so378409a12.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451607; x=1708056407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxmcZQXB6hILUuERStuFRZ0MPT4uFMATBLnu6rXBqLE=;
        b=clp5xwBJAUtOYMWoLVu0ggjk3ruhFZflB1j4SWHMUGJ7dlywXV3L9nlzROrsbN+bGX
         HWvvf8jx+0x2HXij6LZRhhCb+K4tHPrP+dHzagoqCIOl3RAgS48D/exucDlxKaOz6pP1
         ziMSOrzVAadOy5gU/bFJoiHJqukRSEHMpLJY1J4vlox8waI3wEOOW+RgUkgMpPHwSt4Q
         hXBLgVtivG3SgmSSm4P0mXvPLQoHVQ42abVziICcNnM1UuOpxAMIQmWMFEe67Kw07X4I
         99y/mcVRAc6qqLo/DU1WaIktPHrO2WzElbeq65O8QornM9X1qDMhpiJBgnM+WQAvd11j
         Juug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451607; x=1708056407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxmcZQXB6hILUuERStuFRZ0MPT4uFMATBLnu6rXBqLE=;
        b=wFOLCsvV+K3PysZ5VcaH2Q7bX6DaOIZYDUNpBWoRPOoBbFKSq4f5pT3iAO4fgxsg+t
         hFQWzzRhUIBFfZcfaLwtvHFZJ5UMCpEOUlTv/6vQZuzUVP0Cl8htsQUfDw/DLZIAHPLM
         +IMjNOcu7cPxcLxeb0vKodiBaS4HldZFgdUE1sPU59zzm52hKUG2JGANeF1SZ4ZqI8Rt
         F8rrwOF67oMaq8gCxwklIepPaB6SHdb09GWtWvC5VTYElZpubhDWbeWL1KoUXb0b+Arr
         TGxIe1mk0FRaWp/4VlHKjCY6/tC2cRMTMjm24ijFolCePXVMxBTb82RDH0SorMosoFo1
         8j2Q==
X-Gm-Message-State: AOJu0Yyc5viY84m3f60/3BZhfEK5r/Cq0SjISUXaCnSvMWTMv3fjk8Gx
	BiuWWvSoih6wbdQV7XEfodtpir7+1wgDcDEkUuS6OaeFmouYFHqJqS7vka6k
X-Google-Smtp-Source: AGHT+IHuqaEsk6hY3MyoaXGt78Tnlu+oap9lHuWJS3aqvunCJMIGEmoL01w5jyIJ2MTY+5Q0V0YZ4g==
X-Received: by 2002:a17:90a:c291:b0:296:fff3:cf33 with SMTP id f17-20020a17090ac29100b00296fff3cf33mr1016964pjt.8.1707451606688;
        Thu, 08 Feb 2024 20:06:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYw8ifD9te6TKOQruqSWHsfeyVWflUrl1SO2obE7M4KjqFDUY4tyAd7G+fW4weZ61H3tBeM7iE9QrtVUgUuqPkA3BqbcV/uqVtAYEMOdzBtNJ7moG+4HEo4Yrf8pUTvj0KhqQp2Ld60XtdpyNfIMydcJU0tnH+GgOO/Ir40yeps53JAqQY/ou32WGYozZ2TQUdJn/A04Fs+czxvy4plVwfCv1hwqMwa2KJUO7JBAlDbj2wEEWXbOZcNbE/o8UjskjgDrBXgRZh0EXhh2tx/MKhK2g1C+sdFMWpUb6Rk0/njLS/4TTplFl0/c9Po2lLk7OZzJFytqqZ5A6DCtSe9uqoRXyqYMZDfBGZ7eXuH9eKfEt9KVfxjg==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id gz21-20020a17090b0ed500b00296b90d93absm631254pjb.29.2024.02.08.20.06.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 08/20] bpf: Add x86-64 JIT support for bpf_cast_user instruction.
Date: Thu,  8 Feb 2024 20:05:56 -0800
Message-Id: <20240209040608.98927-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
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


