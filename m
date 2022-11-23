Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8AB63614D
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 15:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbiKWORL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 09:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiKWORJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 09:17:09 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D4B30569;
        Wed, 23 Nov 2022 06:17:08 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id r18so16837893pgr.12;
        Wed, 23 Nov 2022 06:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il34hx3yTyq0XGrCJwbIooQuurpvZ+PhXZG2yVGC9M8=;
        b=W8mo7dQNWNEDXJnXDo+yvbtW1uSoZlH7Mts13sZpggOqdj2zKVNczdUk/eIOJEaHU3
         X76vg/D8EFFqR/JiC/6xYfBtPOaBMNgIx/VnJH6FaESFb8XGuZT6ykQ+ascdGiG6tCmj
         iJaBedlQkQQXrn/ZNoXd8KTYqbqC+FbvjYXYsuY9O8xaqbQ623YZevh1naHp6HjnlZea
         Sfh19NgsI/mjP3r+C2yXoAsdcW3OfLSXO4FeXnIim+ITodmIzs38Orry1yoRt5gVOol0
         8ZSiE30H/WHI7VJHIqtV0T6K0Pb4CpmpD4oH1wIa5zK0fGnWDAZwH+k7mrwLPkzXLNNW
         LUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Il34hx3yTyq0XGrCJwbIooQuurpvZ+PhXZG2yVGC9M8=;
        b=1MBRpvGMdmH9SfW5eMBlDeQftvpO/tks9eMjvUprdZ5r4dHb2Ho5EcCk0sViky5aJB
         qMGq+GyFmqwi8eqPzbHmV4CvlpI5s7on0bMHF0Bugg6i9LVh8msGf5McUceL5rLFdjaL
         QnNQqcfcEmVjHDst2iFhVBBSTOJ6HnoUDso6TshlKEwyl8uSN27KpaSSY4wLapDmcRkS
         O2c3zCm1W59MpO2yJ1rfKEeZDR/QFZ/dFs4X8TG06lnaONn0q6ItG3MthIVtosl/bNXX
         rCkyyMWgOd2AG+Xa2I/yX9HW4RYqXh6N5R4nZf9eKkProcGv4DtNWWLOd0kNmQTfNwiB
         tnGA==
X-Gm-Message-State: ANoB5pmgIRNuf5kWv8Eyoa2jziQcQGU6wKBbZvgOUYfochuO1yJRCw7f
        2XovfPmL7aiJjyDwo9ED9u4lE/8yjt/7
X-Google-Smtp-Source: AA0mqf6R9o/LUhjI7+St2OGdyn2PeKh4r2Rmzl8P6nI6Vb5yIsttawwukcgBVcfE5Oh4V/Ds8wnfQA==
X-Received: by 2002:a63:4a25:0:b0:46e:bcc0:c735 with SMTP id x37-20020a634a25000000b0046ebcc0c735mr25945498pga.483.1669213027998;
        Wed, 23 Nov 2022 06:17:07 -0800 (PST)
Received: from pc.localdomain ([166.111.83.15])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b001868ed86a95sm14371878plg.174.2022.11.23.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:17:07 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next 2/3] bpf: Sanitize LDX in jited BPF progs with KASAN
Date:   Wed, 23 Nov 2022 22:15:45 +0800
Message-Id: <20221123141546.238297-3-sunhao.th@gmail.com>
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

Make the verifier sanitize LDX insns in jited BPF programs, a little
more complicated than STX/ST. The dst_reg and AX are free here,
different insns that backup R0&R1 are inserted before calling the
checking functions based on their relationships with dst_reg and
src_reg, the checking funcs are then inserted, and finally regs
are restored.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c |  4 +-
 include/linux/bpf.h         |  5 +++
 kernel/bpf/verifier.c       | 88 +++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ceaef69adc49..0fc67383ffa8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -343,7 +343,9 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 	u8 *prog = *pprog;
 	bool is_sanitize =
 		func == bpf_asan_store8 || func == bpf_asan_store16 ||
-		func == bpf_asan_store32 || func == bpf_asan_store64;
+		func == bpf_asan_store32 || func == bpf_asan_store64 ||
+		func == bpf_asan_load8 || func == bpf_asan_load16 ||
+		func == bpf_asan_load32 || func == bpf_asan_load64;
 
 	if (!is_sanitize)
 		return emit_patch(pprog, func, ip, 0xE8);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a7eb99928fee..350d890a39ac 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2842,6 +2842,11 @@ u64 bpf_asan_store16(u16 *addr);
 u64 bpf_asan_store32(u32 *addr);
 u64 bpf_asan_store64(u64 *addr);
 
+u64 bpf_asan_load8(u8 *addr);
+u64 bpf_asan_load16(u16 *addr);
+u64 bpf_asan_load32(u32 *addr);
+u64 bpf_asan_load64(u64 *addr);
+
 #endif /* CONFIG_BPF_PROG_KASAN */
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af214f0191e0..c0c11d24dc7b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15238,6 +15238,17 @@ BPF_ASAN_STORE(16);
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
@@ -15454,6 +15465,83 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
+			/* Invoke sanitize fn, R1~R5 are stored to stack during jit. */
+			*patch++ = sanitize_fn;
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

