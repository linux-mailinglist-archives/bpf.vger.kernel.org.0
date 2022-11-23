Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57363614B
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 15:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiKWORJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 09:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbiKWORG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 09:17:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398782F666;
        Wed, 23 Nov 2022 06:17:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g10so16741782plo.11;
        Wed, 23 Nov 2022 06:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRaTwuIMRWrYWwIXhrHstpbQDW7uacrpldkEzAXLU14=;
        b=Tq3xBJdWm5dmTk18oYM136Mh/nt2ofDpg7fYxLQpxQOfTBGdADqSbE7tvb+YjT5t3m
         8jcUJl48+HzMR0pvdmdrjb53zaDNh3p49Hx2kGRaAl1ahiGxf2/yPUJoGv3bn5FFr02V
         amscHI1kzsQzJGS8u/4H/yA/V/zEF3/rIdqR3h7qwDQCwqO3OlMYsCWVI1sQYkUH/4N+
         YIlSQMBeoUQYElZMaFznS1vLkmsYEMMGCHaOFDKyEzquuOHlika+hr9vavH7F9VfFTB6
         jttGC2EVVueXLnNVHMC9maq8gbES5QHYQw5IWjpVDxS67anL9YkedCV3+kIqLinJ2Y1O
         e5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRaTwuIMRWrYWwIXhrHstpbQDW7uacrpldkEzAXLU14=;
        b=Bhv9Biiyuvhs55tyEuiQ6kucNwsSxxRbp3IqWtfgmdvMvGjQaAPHFW70BBjETodyOl
         dHKxSc+srgMcO4OjsYqWzRjIKKoQdlcf6e8HxxAwwrJ7F+Kg/exhM9/J2CVxANohxY4k
         gunvpNrFcovWsKJqgWNNN+bHntYAgUj+xRwIe3jFkq+62eBFGfOcGIb3XZUp8QBexnPd
         9+sNg+3ip8XGnvzt5OD0gV1AXWPoFPgKnOKfRawVi5DrIKYa8b76DACdX5ZOkPq4Jntt
         Em/s69sklQI/yxXDIdujBPorq2dJr73NQ96mNx1bWJZ/9rpR6+t5X97EQBabATWwq5FK
         BFbw==
X-Gm-Message-State: ANoB5pm86cRVfoD4grPxs8r5cShqfNGttDXuyMet5XQMfI3Ow+Z9ttc5
        aT3wUpzTfo4cylYak0gVpB5v3ZXkW7bx
X-Google-Smtp-Source: AA0mqf4QmwAIZsbynn/gYyxYY0Fksor1yjWZBBOZMoWZYusB0cmyWSc+v5G0RkuIy857AtUX5qYF0A==
X-Received: by 2002:a17:902:eb85:b0:186:5f86:da41 with SMTP id q5-20020a170902eb8500b001865f86da41mr10708699plg.73.1669213024363;
        Wed, 23 Nov 2022 06:17:04 -0800 (PST)
Received: from pc.localdomain ([166.111.83.15])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b001868ed86a95sm14371878plg.174.2022.11.23.06.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:17:04 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next 1/3] bpf: Sanitize STX/ST in jited BPF progs with KASAN
Date:   Wed, 23 Nov 2022 22:15:44 +0800
Message-Id: <20221123141546.238297-2-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123141546.238297-1-sunhao.th@gmail.com>
References: <20221123141546.238297-1-sunhao.th@gmail.com>
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

Make the verifier sanitize STX/ST insns in jited BPF programs
by dispatching addr to kernel functions that are instrumented
by KASAN.

Only STX/ST insns that aren't in patches added by other passes
using REG_AX or dst_reg isn't R10 are sanitized. The former
confilicts with us, the latter are trivial for the verifier to
check, skip them to reduce the footprint.

The instrumentation is conducted in two places: fixup and jit.
During fixup, R0 and R1 are backed up or exchanged with dst_reg,
and the address to check is stored into R1, and the corresponding
bpf_asan_storeN() is inserted. In jit, R1~R5 are pushed on stack
before calling the sanitize function. The sanitize functions are
instrumented with KASAN and they simply write to the target addr
for certain bytes, KASAN conducts the actual checking. An extra
Kconfig is used to enable this.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c |  32 +++++++++++
 include/linux/bpf.h         |   9 ++++
 kernel/bpf/Kconfig          |  14 +++++
 kernel/bpf/verifier.c       | 102 ++++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index cec5195602bc..ceaef69adc49 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -338,7 +338,39 @@ static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
 
 static int emit_call(u8 **pprog, void *func, void *ip)
 {
+#ifdef CONFIG_BPF_PROG_KASAN
+	s64 offset;
+	u8 *prog = *pprog;
+	bool is_sanitize =
+		func == bpf_asan_store8 || func == bpf_asan_store16 ||
+		func == bpf_asan_store32 || func == bpf_asan_store64;
+
+	if (!is_sanitize)
+		return emit_patch(pprog, func, ip, 0xE8);
+
+	/* Six extra bytes from push insns */
+	offset = func - (ip + X86_PATCH_SIZE + 6);
+	BUG_ON(!is_simm32(offset));
+
+	/* R1 has the addr to check, backup R1~R5 here, we don't
+	 * have free regs during the fixup.
+	 */
+	EMIT1(0x57); /* push rdi */
+	EMIT1(0x56); /* push rsi */
+	EMIT1(0x52); /* push rdx */
+	EMIT1(0x51); /* push rcx */
+	EMIT2(0x41, 0x50); /* push r8 */
+	EMIT1_off32(0xE8, offset);
+	EMIT2(0x41, 0x58); /* pop r8 */
+	EMIT1(0x59); /* pop rcx */
+	EMIT1(0x5a); /* pop rdx */
+	EMIT1(0x5e); /* pop rsi */
+	EMIT1(0x5f); /* pop rdi */
+	*pprog = prog;
+	return 0;
+#else
 	return emit_patch(pprog, func, ip, 0xE8);
+#endif
 }
 
 static int emit_jump(u8 **pprog, void *func, void *ip)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c9eafa67f2a2..a7eb99928fee 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2835,4 +2835,13 @@ static inline bool type_is_alloc(u32 type)
 	return type & MEM_ALLOC;
 }
 
+#ifdef CONFIG_BPF_PROG_KASAN
+
+u64 bpf_asan_store8(u8 *addr);
+u64 bpf_asan_store16(u16 *addr);
+u64 bpf_asan_store32(u32 *addr);
+u64 bpf_asan_store64(u64 *addr);
+
+#endif /* CONFIG_BPF_PROG_KASAN */
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 2dfe1079f772..aeba6059b9e2 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -99,4 +99,18 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_PROG_KASAN
+	bool "Enable BPF Program Address Sanitize"
+	depends on BPF_JIT
+	depends on KASAN
+	depends on X86_64
+    help
+	  Enables instrumentation on LDX/STX/ST insn to capture memory
+	  access errors in BPF programs missed by the verifier.
+
+	  The actual check is conducted by KASAN, this feature presents
+	  certain overhead, and should be used mainly by testing purpose.
+
+	  If you are unsure how to answer this question, answer N.
+
 endmenu # "BPF subsystem"
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9528a066cfa5..af214f0191e0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15221,6 +15221,25 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+#ifdef CONFIG_BPF_PROG_KASAN
+
+/* Those are functions instrumented with KASAN for actual sanitizing. */
+
+#define BPF_ASAN_STORE(n)                         \
+	notrace u64 bpf_asan_store##n(u##n *addr) \
+	{                                         \
+		u##n ret = *addr;                 \
+		*addr = ret;                      \
+		return ret;                       \
+	}
+
+BPF_ASAN_STORE(8);
+BPF_ASAN_STORE(16);
+BPF_ASAN_STORE(32);
+BPF_ASAN_STORE(64);
+
+#endif
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -15238,6 +15257,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, delta = 0;
+#ifdef CONFIG_BPF_PROG_KASAN
+	bool in_patch_use_ax = false;
+#endif
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		/* Make divide-by-zero exceptions impossible. */
@@ -15354,6 +15376,86 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
+#ifdef CONFIG_BPF_PROG_KASAN
+		/* Patches that use REG_AX confilict with us, skip it.
+		 * This starts with first use of REG_AX, stops only when
+		 * we see next ldx/stx/st insn with valid aux information.
+		 */
+		aux = &env->insn_aux_data[i + delta];
+		if (in_patch_use_ax && (int)aux->ptr_type != 0)
+			in_patch_use_ax = false;
+		if (insn->dst_reg == BPF_REG_AX || insn->src_reg == BPF_REG_AX)
+			in_patch_use_ax = true;
+
+		/* Sanitize ST/STX operation. */
+		if (BPF_CLASS(insn->code) == BPF_ST ||
+		    BPF_CLASS(insn->code) == BPF_STX) {
+			struct bpf_insn sanitize_fn;
+			struct bpf_insn *patch = &insn_buf[0];
+
+			/* Skip st/stx to R10, they're trivial to check. */
+			if (in_patch_use_ax || insn->dst_reg == BPF_REG_10 ||
+				BPF_MODE(insn->code) == BPF_NOSPEC)
+				continue;
+
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_B:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_store8);
+				break;
+			case BPF_H:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_store16);
+				break;
+			case BPF_W:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_store32);
+				break;
+			case BPF_DW:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_store64);
+				break;
+			}
+
+			/* Backup R0 and R1, store `dst + off` to R1, invoke the
+			 * sanitize fn, and then restore each reg.
+			 */
+			if (insn->dst_reg == BPF_REG_1) {
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_0);
+			} else if (insn->dst_reg == BPF_REG_0) {
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
+			} else {
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, insn->dst_reg);
+				*patch++ = BPF_MOV64_REG(insn->dst_reg, BPF_REG_0);
+			}
+			if (insn->off != 0)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, insn->off);
+			/* Call sanitize fn, R1~R5 are saved to stack during jit. */
+			*patch++ = sanitize_fn;
+			if (insn->off != 0)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -insn->off);
+			if (insn->dst_reg == BPF_REG_1) {
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_AX);
+			} else if (insn->dst_reg == BPF_REG_0) {
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_AX);
+			} else {
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, insn->dst_reg);
+				*patch++ = BPF_MOV64_REG(insn->dst_reg, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_AX);
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
+#endif
+
 		if (insn->code != (BPF_JMP | BPF_CALL))
 			continue;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
-- 
2.38.1

