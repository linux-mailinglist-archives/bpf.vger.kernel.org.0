Return-Path: <bpf+bounces-74958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3B6C696B1
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3008D2B500
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C97C1E1E12;
	Tue, 18 Nov 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVOei3An"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B33563D7
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469444; cv=none; b=WzacgXWzxHcGtrNyR51fqKvmW5jBm9DFWfYqc9KQgSdw7JzDZUgmpXlxmjm6QfhgwY2S0g9aaxrpRb8o4iHCRksCboX9eC7Ea6IztStGRdA8zHBxPL1kpSuG6UVgpLyn7eF5khhNPVPYMht/tZmTZAdeoK4c82KbjuN974nUfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469444; c=relaxed/simple;
	bh=A189KruAXLdLXnVG6BxgtUuscbMj8iOLzy3Zi4GQuZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbT93W9Kkz1raCq1t/LoOV7sfAuzLYZe0P4NOyvPJFM3cXioJVvKuZiirM18Sf4WfErLLruHZbyvi27XqbgHxWPhIyjbZ9eAP+PCCT6QdTUXMkVzha4z69fYoY2K3woO/OqZutN/F3/0QWbnaIk1u/MrMxmOx8+cTxOpMV3eWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVOei3An; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso4749660b3a.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 04:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469441; x=1764074241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2DQCf6tSRMTRKkx+h6Y6ZXBkfTNVyQ5trU9zCAP1Bg=;
        b=OVOei3Anc9xdJdzzpxFS1gH3c8EAGMKUtNyxW0BMV15H8Z9VFy3Wrct1xjz7d7V99S
         +XrNWFHVfQG+tfyJgXiDgtb1c24hJZBTc2lUCaEJoZylZ9TfxUhqPqpkN9gps7LmAJNJ
         lOEw37l0/fteqz8WIi47Sbo2DRHqHEEhPdSTGwV+AxVrw36cglZqzLlwlh1HoNwx469T
         4EePjGeB9BL8r3QERphyyYLqprfX9QOvYOy/IINOET9eedOIg25pM43PKH3Y3LudY2gZ
         8XxVX5bud9SJzxf+8FNEWhrJApCaS8SrfyB6Thg+PlC61wXIEHS+M42K9lN2WxLhkS0U
         RfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469441; x=1764074241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b2DQCf6tSRMTRKkx+h6Y6ZXBkfTNVyQ5trU9zCAP1Bg=;
        b=YDhQG9AfKfo6WsPVUxYy/tR62Uo8aYwnoMO/u93Acpahf42ShRDStVVPD4HfQ7m9vS
         yZr5agBX9yn20+N6bW+aX2AfXwipFzKT+Tvw+sKCesciv06a4qdb6meyZzox5XHrwjCA
         bk88hgYomtrSWzl9fd82/r9hE/PCugOCzXtUCm8MAkoHaX9Obi/p2vtlQeqBa5izMFJ6
         xtyTfzSi8vWuFpZJDY+9xYCHOvf02mwcI6l8CrKNCHkWcTP/YVi/TrZaKKwINtbsX7gN
         tXuetg0GiZ6x7ssNyg+L6gzewpbVXfZbGav9u+BrXzG1+rzc9qBkDoUAYKd+xODRtsHh
         0d4g==
X-Forwarded-Encrypted: i=1; AJvYcCWTpKhPQUtyYaaZImoO8GOQgKwbaXVARfLQUP/U4iCsk/Yl/PWIfIOsAyeDhDWA3S+gL74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9VYE5GZ+cwcCvE9ZktE6H3DDPlmly3h1LeDqZ/4EWTFGKti0D
	jUd1OAlEtNuwUk6Mm3ULSMmcpKkkxY2wsIWkwKB8Ke79lYoCRfhBkM1i
X-Gm-Gg: ASbGncsedQNPo9OoiLKnMznFaUrZWHVQGW51ld0E1fg/MBosMYRJNQBFVuC8GiiRcwC
	qWHggFpyCKBZS5jdf3M0OTeqITNmvE6sQngA522Re4BMHWtc/lqTbXyjOw7fk2448AMFBE1gRdm
	MuQK1fxzpHMXFYg40RmWfrEEia+G9+CAs/HYI/GHjowYXUNMwu7mbae4FxUGpdkImFasrE4sVeS
	6kEzPYOjP/q3IpuQarQk1/kfqKSBafrVYNdbSfvlY1f1o6OH+nk+wEcgIH+vSlYeY03iT8AlgSD
	0Kmj/VBymrncl3St5Al19bP04kQMs0Vyei4F1sRAnGx16r4lg35cfYisiyMT1ges+9Vq5uT0rFc
	NDuWqOd52PkaWuxsBUD12Ao5aR/0q19D2v+ffx8w3pCUSUM/0ppLhzrP/612t2Cw4csBxMK/O1c
	rYkyngWpXE3m0=
X-Google-Smtp-Source: AGHT+IHYF1kg7lEYD3hrKWG9nsBvEr03AjbqXaDOXUHhDgx1fssUvuChaG0Qu/zvI8hSD1oVLBViJg==
X-Received: by 2002:a05:6a20:a125:b0:342:9cb7:64a3 with SMTP id adf61e73a8af0-35ba22a4fcdmr21086580637.34.1763469441102;
        Tue, 18 Nov 2025 04:37:21 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:37:20 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 5/6] bpf: specify the old and new poke_type for bpf_arch_text_poke
Date: Tue, 18 Nov 2025 20:36:33 +0800
Message-ID: <20251118123639.688444-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the origin logic, the bpf_arch_text_poke() assume that the old and new
instructions have the same opcode. However, they can have different opcode
if we want to replace a "call" insn with a "jmp" insn.

Therefore, add the new function parameter "old_t" along with the "new_t",
which are used to indicate the old and new poke type. Meanwhile, adjust
the implement of bpf_arch_text_poke() for all the archs.

"BPF_MOD_NOP" is added to make the code more readable. In
bpf_arch_text_poke(), we still check if the new and old address is NULL to
determine if nop insn should be used, which I think is more safe.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- fix compile error in powerpc

v2:
- add new function parameter to bpf_arch_text_poke instead of introduce
  bpf_arch_text_poke_type()
---
 arch/arm64/net/bpf_jit_comp.c   | 14 ++++++-------
 arch/loongarch/net/bpf_jit.c    |  9 +++++---
 arch/powerpc/net/bpf_jit_comp.c | 10 +++++----
 arch/riscv/net/bpf_jit_comp64.c |  9 +++++---
 arch/s390/net/bpf_jit_comp.c    |  7 ++++---
 arch/x86/net/bpf_jit_comp.c     | 37 +++++++++++++++++++--------------
 include/linux/bpf.h             |  6 ++++--
 kernel/bpf/core.c               |  5 +++--
 kernel/bpf/trampoline.c         | 20 ++++++++++++------
 9 files changed, 71 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0c9a50a1e73e..c64df579b7e0 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2923,8 +2923,9 @@ static int gen_branch_or_nop(enum aarch64_insn_branch_type type, void *ip,
  * The dummy_tramp is used to prevent another CPU from jumping to unknown
  * locations during the patching process, making the patching process easier.
  */
-int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
-		       void *old_addr, void *new_addr)
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+		       enum bpf_text_poke_type new_t, void *old_addr,
+		       void *new_addr)
 {
 	int ret;
 	u32 old_insn;
@@ -2968,14 +2969,13 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 		    !poking_bpf_entry))
 		return -EINVAL;
 
-	if (poke_type == BPF_MOD_CALL)
-		branch_type = AARCH64_INSN_BRANCH_LINK;
-	else
-		branch_type = AARCH64_INSN_BRANCH_NOLINK;
-
+	branch_type = old_t == BPF_MOD_CALL ? AARCH64_INSN_BRANCH_LINK :
+					      AARCH64_INSN_BRANCH_NOLINK;
 	if (gen_branch_or_nop(branch_type, ip, old_addr, plt, &old_insn) < 0)
 		return -EFAULT;
 
+	branch_type = new_t == BPF_MOD_CALL ? AARCH64_INSN_BRANCH_LINK :
+					      AARCH64_INSN_BRANCH_NOLINK;
 	if (gen_branch_or_nop(branch_type, ip, new_addr, plt, &new_insn) < 0)
 		return -EFAULT;
 
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index cbe53d0b7fb0..2e7dacbbef5c 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1284,11 +1284,12 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 	return ret ? ERR_PTR(-EINVAL) : dst;
 }
 
-int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
-		       void *old_addr, void *new_addr)
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+		       enum bpf_text_poke_type new_t, void *old_addr,
+		       void *new_addr)
 {
 	int ret;
-	bool is_call = (poke_type == BPF_MOD_CALL);
+	bool is_call;
 	u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
 	u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
 
@@ -1298,6 +1299,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	if (!is_bpf_text_address((unsigned long)ip))
 		return -ENOTSUPP;
 
+	is_call = old_t == BPF_MOD_CALL;
 	ret = emit_jump_or_nops(old_addr, ip, old_insns, is_call);
 	if (ret)
 		return ret;
@@ -1305,6 +1307,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	if (memcmp(ip, old_insns, LOONGARCH_LONG_JUMP_NBYTES))
 		return -EFAULT;
 
+	is_call = new_t == BPF_MOD_CALL;
 	ret = emit_jump_or_nops(new_addr, ip, new_insns, is_call);
 	if (ret)
 		return ret;
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 88ad5ba7b87f..5e976730b2f5 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -1107,8 +1107,9 @@ static void do_isync(void *info __maybe_unused)
  * execute isync (or some CSI) so that they don't go back into the
  * trampoline again.
  */
-int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
-		       void *old_addr, void *new_addr)
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+		       enum bpf_text_poke_type new_t, void *old_addr,
+		       void *new_addr)
 {
 	unsigned long bpf_func, bpf_func_end, size, offset;
 	ppc_inst_t old_inst, new_inst;
@@ -1119,7 +1120,6 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 		return -EOPNOTSUPP;
 
 	bpf_func = (unsigned long)ip;
-	branch_flags = poke_type == BPF_MOD_CALL ? BRANCH_SET_LINK : 0;
 
 	/* We currently only support poking bpf programs */
 	if (!__bpf_address_lookup(bpf_func, &size, &offset, name)) {
@@ -1132,7 +1132,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	 * an unconditional branch instruction at im->ip_after_call
 	 */
 	if (offset) {
-		if (poke_type != BPF_MOD_JUMP) {
+		if (old_t == BPF_MOD_CALL || new_t == BPF_MOD_CALL) {
 			pr_err("%s (0x%lx): calls are not supported in bpf prog body\n", __func__,
 			       bpf_func);
 			return -EOPNOTSUPP;
@@ -1166,6 +1166,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	}
 
 	old_inst = ppc_inst(PPC_RAW_NOP());
+	branch_flags = old_t == BPF_MOD_CALL ? BRANCH_SET_LINK : 0;
 	if (old_addr) {
 		if (is_offset_in_branch_range(ip - old_addr))
 			create_branch(&old_inst, ip, (unsigned long)old_addr, branch_flags);
@@ -1174,6 +1175,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 				      branch_flags);
 	}
 	new_inst = ppc_inst(PPC_RAW_NOP());
+	branch_flags = new_t == BPF_MOD_CALL ? BRANCH_SET_LINK : 0;
 	if (new_addr) {
 		if (is_offset_in_branch_range(ip - new_addr))
 			create_branch(&new_inst, ip, (unsigned long)new_addr, branch_flags);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 21c70ae3296b..5f9457e910e8 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -852,17 +852,19 @@ static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
 	return emit_jump_and_link(is_call ? RV_REG_T0 : RV_REG_ZERO, rvoff, false, &ctx);
 }
 
-int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
-		       void *old_addr, void *new_addr)
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+		       enum bpf_text_poke_type new_t, void *old_addr,
+		       void *new_addr)
 {
 	u32 old_insns[RV_FENTRY_NINSNS], new_insns[RV_FENTRY_NINSNS];
-	bool is_call = poke_type == BPF_MOD_CALL;
+	bool is_call;
 	int ret;
 
 	if (!is_kernel_text((unsigned long)ip) &&
 	    !is_bpf_text_address((unsigned long)ip))
 		return -ENOTSUPP;
 
+	is_call = old_t == BPF_MOD_CALL;
 	ret = gen_jump_or_nops(old_addr, ip, old_insns, is_call);
 	if (ret)
 		return ret;
@@ -870,6 +872,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	if (memcmp(ip, old_insns, RV_FENTRY_NBYTES))
 		return -EFAULT;
 
+	is_call = new_t == BPF_MOD_CALL;
 	ret = gen_jump_or_nops(new_addr, ip, new_insns, is_call);
 	if (ret)
 		return ret;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index cf461d76e9da..a2072cabba76 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2413,8 +2413,9 @@ bool bpf_jit_supports_far_kfunc_call(void)
 	return true;
 }
 
-int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-		       void *old_addr, void *new_addr)
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+		       enum bpf_text_poke_type new_t, void *old_addr,
+		       void *new_addr)
 {
 	struct bpf_plt expected_plt, current_plt, new_plt, *plt;
 	struct {
@@ -2431,7 +2432,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	if (insn.opc != (0xc004 | (old_addr ? 0xf0 : 0)))
 		return -EINVAL;
 
-	if (t == BPF_MOD_JUMP &&
+	if ((new_t == BPF_MOD_JUMP || old_t == BPF_MOD_JUMP) &&
 	    insn.disp == ((char *)new_addr - (char *)ip) >> 1) {
 		/*
 		 * The branch already points to the destination,
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 632a83381c2d..b69dc7194e2c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -597,7 +597,8 @@ static int emit_jump(u8 **pprog, void *func, void *ip)
 	return emit_patch(pprog, func, ip, 0xE9);
 }
 
-static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
+static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+				enum bpf_text_poke_type new_t,
 				void *old_addr, void *new_addr)
 {
 	const u8 *nop_insn = x86_nops[5];
@@ -607,9 +608,9 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	int ret;
 
 	memcpy(old_insn, nop_insn, X86_PATCH_SIZE);
-	if (old_addr) {
+	if (old_t != BPF_MOD_NOP && old_addr) {
 		prog = old_insn;
-		ret = t == BPF_MOD_CALL ?
+		ret = old_t == BPF_MOD_CALL ?
 		      emit_call(&prog, old_addr, ip) :
 		      emit_jump(&prog, old_addr, ip);
 		if (ret)
@@ -617,9 +618,9 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	}
 
 	memcpy(new_insn, nop_insn, X86_PATCH_SIZE);
-	if (new_addr) {
+	if (new_t != BPF_MOD_NOP && new_addr) {
 		prog = new_insn;
-		ret = t == BPF_MOD_CALL ?
+		ret = new_t == BPF_MOD_CALL ?
 		      emit_call(&prog, new_addr, ip) :
 		      emit_jump(&prog, new_addr, ip);
 		if (ret)
@@ -640,8 +641,9 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	return ret;
 }
 
-int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-		       void *old_addr, void *new_addr)
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+		       enum bpf_text_poke_type new_t, void *old_addr,
+		       void *new_addr)
 {
 	if (!is_kernel_text((long)ip) &&
 	    !is_bpf_text_address((long)ip))
@@ -655,7 +657,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	if (is_endbr(ip))
 		ip += ENDBR_INSN_SIZE;
 
-	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
+	return __bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
 }
 
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
@@ -897,12 +899,13 @@ static void bpf_tail_call_direct_fixup(struct bpf_prog *prog)
 		target = array->ptrs[poke->tail_call.key];
 		if (target) {
 			ret = __bpf_arch_text_poke(poke->tailcall_target,
-						   BPF_MOD_JUMP, NULL,
+						   BPF_MOD_NOP, BPF_MOD_JUMP,
+						   NULL,
 						   (u8 *)target->bpf_func +
 						   poke->adj_off);
 			BUG_ON(ret < 0);
 			ret = __bpf_arch_text_poke(poke->tailcall_bypass,
-						   BPF_MOD_JUMP,
+						   BPF_MOD_JUMP, BPF_MOD_NOP,
 						   (u8 *)poke->tailcall_target +
 						   X86_PATCH_SIZE, NULL);
 			BUG_ON(ret < 0);
@@ -3985,6 +3988,7 @@ void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 			       struct bpf_prog *new, struct bpf_prog *old)
 {
 	u8 *old_addr, *new_addr, *old_bypass_addr;
+	enum bpf_text_poke_type t;
 	int ret;
 
 	old_bypass_addr = old ? NULL : poke->bypass_addr;
@@ -3997,21 +4001,22 @@ void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 	 * the kallsyms check.
 	 */
 	if (new) {
+		t = old_addr ? BPF_MOD_JUMP : BPF_MOD_NOP;
 		ret = __bpf_arch_text_poke(poke->tailcall_target,
-					   BPF_MOD_JUMP,
+					   t, BPF_MOD_JUMP,
 					   old_addr, new_addr);
 		BUG_ON(ret < 0);
 		if (!old) {
 			ret = __bpf_arch_text_poke(poke->tailcall_bypass,
-						   BPF_MOD_JUMP,
+						   BPF_MOD_JUMP, BPF_MOD_NOP,
 						   poke->bypass_addr,
 						   NULL);
 			BUG_ON(ret < 0);
 		}
 	} else {
+		t = old_bypass_addr ? BPF_MOD_JUMP : BPF_MOD_NOP;
 		ret = __bpf_arch_text_poke(poke->tailcall_bypass,
-					   BPF_MOD_JUMP,
-					   old_bypass_addr,
+					   t, BPF_MOD_JUMP, old_bypass_addr,
 					   poke->bypass_addr);
 		BUG_ON(ret < 0);
 		/* let other CPUs finish the execution of program
@@ -4020,9 +4025,9 @@ void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 		 */
 		if (!ret)
 			synchronize_rcu();
+		t = old_addr ? BPF_MOD_JUMP : BPF_MOD_NOP;
 		ret = __bpf_arch_text_poke(poke->tailcall_target,
-					   BPF_MOD_JUMP,
-					   old_addr, NULL);
+					   t, BPF_MOD_NOP, old_addr, NULL);
 		BUG_ON(ret < 0);
 	}
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4187b7578580..d5e2af29c7c8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3708,12 +3708,14 @@ static inline u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
 #endif /* CONFIG_INET */
 
 enum bpf_text_poke_type {
+	BPF_MOD_NOP,
 	BPF_MOD_CALL,
 	BPF_MOD_JUMP,
 };
 
-int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-		       void *addr1, void *addr2);
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+		       enum bpf_text_poke_type new_t, void *old_addr,
+		       void *new_addr);
 
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 			       struct bpf_prog *new, struct bpf_prog *old);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ef4448f18aad..c8ae6ab31651 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3150,8 +3150,9 @@ int __weak skb_copy_bits(const struct sk_buff *skb, int offset, void *to,
 	return -EFAULT;
 }
 
-int __weak bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-			      void *addr1, void *addr2)
+int __weak bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+			      enum bpf_text_poke_type new_t, void *old_addr,
+			      void *new_addr)
 {
 	return -ENOTSUPP;
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 04104397c432..0230ad19533e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -183,7 +183,8 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	if (tr->func.ftrace_managed)
 		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
 	else
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
+		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, BPF_MOD_NOP,
+					 old_addr, NULL);
 
 	return ret;
 }
@@ -200,7 +201,10 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 		else
 			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
 	} else {
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr);
+		ret = bpf_arch_text_poke(ip,
+					 old_addr ? BPF_MOD_CALL : BPF_MOD_NOP,
+					 new_addr ? BPF_MOD_CALL : BPF_MOD_NOP,
+					 old_addr, new_addr);
 	}
 	return ret;
 }
@@ -225,7 +229,8 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 			return ret;
 		ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
+		ret = bpf_arch_text_poke(ip, BPF_MOD_NOP, BPF_MOD_CALL,
+					 NULL, new_addr);
 	}
 
 	return ret;
@@ -336,8 +341,9 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	 * call_rcu_tasks() is not necessary.
 	 */
 	if (im->ip_after_call) {
-		int err = bpf_arch_text_poke(im->ip_after_call, BPF_MOD_JUMP,
-					     NULL, im->ip_epilogue);
+		int err = bpf_arch_text_poke(im->ip_after_call, BPF_MOD_NOP,
+					     BPF_MOD_JUMP, NULL,
+					     im->ip_epilogue);
 		WARN_ON(err);
 		if (IS_ENABLED(CONFIG_TASKS_RCU))
 			call_rcu_tasks(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
@@ -570,7 +576,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 		if (err)
 			return err;
 		tr->extension_prog = link->link.prog;
-		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
+		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_NOP,
+					  BPF_MOD_JUMP, NULL,
 					  link->link.prog->bpf_func);
 	}
 	if (cnt >= BPF_MAX_TRAMP_LINKS)
@@ -618,6 +625,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 	if (kind == BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
 		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
+					 BPF_MOD_NOP,
 					 tr->extension_prog->bpf_func, NULL);
 		tr->extension_prog = NULL;
 		guard(mutex)(&tgt_prog->aux->ext_mutex);
-- 
2.51.2


