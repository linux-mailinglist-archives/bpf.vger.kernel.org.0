Return-Path: <bpf+bounces-34946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E29D933947
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 10:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01DF1C20FC2
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5C38FA1;
	Wed, 17 Jul 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="U3C21IwT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC638396
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205673; cv=none; b=UdJW7zvCi0nCxeJIYTt7MnmzA/qk3zAzLmo2qAsxZjRPm7Mz5ECaeKLg3JL74uPNpE8cHXE1bukIEEqyoJ5O7SDFUYShCcAuplQYsMNUg3210A++QrDh7/sfK9/9GvVpbLsmuwbW7Q6Jn5VlL5YUJyPZfKtZ3WpTOOc6LQssHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205673; c=relaxed/simple;
	bh=KK5J9UHEgpDapHfRC4BpEscuiXUgNWTNPIU6/AVK7P0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WPQJzspcllzIA7Q7YQ/FthfKaTW9oUBBwXOP6S1xrwWk+6szvBJSBcwtrdKUPMjNXkW6E8SYFaM/ODzk5VeLrWi5TlxQk4l/VgErvFeuyzsIuhwKez9NGrlJw+JyOa9ZD1abUyTtBzUS/tC2UrVbbg3o13yfEAhIIzpNqLq0J90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=U3C21IwT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so52416085e9.1
        for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721205670; x=1721810470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=viTeXUKki+C4RSOqEtc6JZRlZB9YfhZcpuRfiwEJWmA=;
        b=U3C21IwTITrFSZnvO65DBrN61BSNR/GD0ZFxjgBFp21pxXoNKuO4J5Z4Y7E0yFuXgv
         Xe1IVMOoaDHuSBZrPLO5pzu+dKCEFa85vl8jk7h/R95TImXGL9sMAjh5Lk1EYgb3lu7L
         6woTbl29BG3QqVk0Axb117RYdjaLvdT9zPQuB96pz6gNqqUeptwx1KypcrtVMGKil5aU
         rIUP3vSLB25iAivETfMu0j947Sr6d+VyiX0wnG/FUihikzQnJ5/vA5Q+SNNInlUqBcNd
         JOvbQWT+rdZWPTMJ8jKcBtSRuA+jj17JwRemIFgomAcp4LQmFaaxSU4W07aU7TBBd0tw
         w+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721205670; x=1721810470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viTeXUKki+C4RSOqEtc6JZRlZB9YfhZcpuRfiwEJWmA=;
        b=wDfZxLoEg+pqDwch0pzbwuPm5Vs4m6A/kG4sEV/y3ThZH+YFCyIevsegijCN7St5f9
         n1ZUcubLNj3+sjVNdh0CZczfTBLAog+TJ7+8hQqedx+3HhugmKhn4P3oyR6avBpTFy/T
         Sg/pJGRzwBxvs7Qd0+xRm7Q/gC3BuiqUh2Mc3UNZLpeA3ESBdKPGlf4q4hSEG2ibOA0Q
         yWyhwi/WNulKU4ZLlmGuYYJzrYW+ScLQ0H/h2Byr+zSrilZ/lBks8kedx5UxaGmoXwZ/
         ftmVpjmO+xyWPRzrF5tIegvcoJhioUlPndbrsCMic9m+nby6nQylhNo7AnSuGDXOO0+Y
         lBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbYB53UZI22SrbOwfdyDIFn5U4pORrS4lU/VDK4UZZAJtEocfQ+T5cBvVKF6VWAtqi/L2mtxWzhIq8mAZKaA8jR/tb
X-Gm-Message-State: AOJu0YxUN5e98ciM+nBiemamf+u3tZyQWtIYf4yB0G0uY0tZjv8nl/A6
	6538wcaeEHUxQ8g4M5WQZYUN+3OYOs2fTRKjDvYtFczwxsZiyZibowJViMrgC1U=
X-Google-Smtp-Source: AGHT+IHJRc0QXrVEpcHHfalimM+vrl4OVXAX7XvhAEimTQc8pDDZRyX0mHbtVfKgSdMOkO1myMU9og==
X-Received: by 2002:a05:600c:3595:b0:426:5c81:2538 with SMTP id 5b1f17b1804b1-427c2cb8a05mr7311085e9.14.1721205669874;
        Wed, 17 Jul 2024 01:41:09 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([193.33.57.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427ba20c8aasm29024645e9.0.2024.07.17.01.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 01:41:09 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] riscv: patch: Remove redundant functions
Date: Wed, 17 Jul 2024 10:41:02 +0200
Message-Id: <20240717084102.150914-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit edf2d546bfd6f5c4 ("riscv: patch: Flush the icache right after
patching to avoid illegal insns") removed the last differences between
patch_text_set_nosync() and patch_insn_set(), and between
patch_text_nosync() and patch_insn_write().

So remove the redundant *_nosync() functions.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/linux-riscv/CAMuHMdUwx=rU2MWhFTE6KhYHm64phxx2Y6u05-aBLGfeG5696A@mail.gmail.com/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/errata/sifive/errata.c |  4 ++--
 arch/riscv/errata/thead/errata.c  |  2 +-
 arch/riscv/include/asm/patch.h    |  3 +--
 arch/riscv/kernel/alternative.c   |  4 ++--
 arch/riscv/kernel/cpufeature.c    |  2 +-
 arch/riscv/kernel/jump_label.c    |  2 +-
 arch/riscv/kernel/patch.c         | 24 +-----------------------
 arch/riscv/net/bpf_jit_core.c     |  4 ++--
 8 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 716cfedad3a2..5253b205aa17 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -112,8 +112,8 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 		tmp = (1U << alt->patch_id);
 		if (cpu_req_errata & tmp) {
 			mutex_lock(&text_mutex);
-			patch_text_nosync(ALT_OLD_PTR(alt), ALT_ALT_PTR(alt),
-					  alt->alt_len);
+			patch_insn_write(ALT_OLD_PTR(alt), ALT_ALT_PTR(alt),
+					 alt->alt_len);
 			mutex_unlock(&text_mutex);
 			cpu_apply_errata |= tmp;
 		}
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index bf6a0a6318ee..0ce280a190b6 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -182,7 +182,7 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 				memcpy(oldptr, altptr, alt->alt_len);
 			} else {
 				mutex_lock(&text_mutex);
-				patch_text_nosync(oldptr, altptr, alt->alt_len);
+				patch_insn_write(oldptr, altptr, alt->alt_len);
 				mutex_unlock(&text_mutex);
 			}
 		}
diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index 9f5d6e14c405..6b0e9b8a321b 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -6,9 +6,8 @@
 #ifndef _ASM_RISCV_PATCH_H
 #define _ASM_RISCV_PATCH_H
 
+int patch_insn_set(void *addr, u8 c, size_t len);
 int patch_insn_write(void *addr, const void *insn, size_t len);
-int patch_text_nosync(void *addr, const void *insns, size_t len);
-int patch_text_set_nosync(void *addr, u8 c, size_t len);
 int patch_text(void *addr, u32 *insns, int ninsns);
 
 extern int riscv_patch_in_stop_machine;
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 0128b161bfda..a8b508d99cf8 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -83,7 +83,7 @@ static void riscv_alternative_fix_auipc_jalr(void *ptr, u32 auipc_insn,
 	riscv_insn_insert_utype_itype_imm(&call[0], &call[1], imm);
 
 	/* patch the call place again */
-	patch_text_nosync(ptr, call, sizeof(u32) * 2);
+	patch_insn_write(ptr, call, sizeof(u32) * 2);
 }
 
 static void riscv_alternative_fix_jal(void *ptr, u32 jal_insn, int patch_offset)
@@ -98,7 +98,7 @@ static void riscv_alternative_fix_jal(void *ptr, u32 jal_insn, int patch_offset)
 	riscv_insn_insert_jtype_imm(&jal_insn, imm);
 
 	/* patch the call place again */
-	patch_text_nosync(ptr, &jal_insn, sizeof(u32));
+	patch_insn_write(ptr, &jal_insn, sizeof(u32));
 }
 
 void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 5ef48cb20ee1..4c040a857c7e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -795,7 +795,7 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
 		altptr = ALT_ALT_PTR(alt);
 
 		mutex_lock(&text_mutex);
-		patch_text_nosync(oldptr, altptr, alt->alt_len);
+		patch_insn_write(oldptr, altptr, alt->alt_len);
 		riscv_alternative_fix_offsets(oldptr, alt->alt_len, oldptr - altptr);
 		mutex_unlock(&text_mutex);
 	}
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index e6694759dbd0..74b5ebfacf4a 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -36,6 +36,6 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	}
 
 	mutex_lock(&text_mutex);
-	patch_text_nosync(addr, &insn, sizeof(insn));
+	patch_insn_write(addr, &insn, sizeof(insn));
 	mutex_unlock(&text_mutex);
 }
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index ab03732d06c4..bf45b507f900 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -177,7 +177,7 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
 NOKPROBE_SYMBOL(__patch_insn_write);
 #endif /* CONFIG_MMU */
 
-static int patch_insn_set(void *addr, u8 c, size_t len)
+int patch_insn_set(void *addr, u8 c, size_t len)
 {
 	size_t patched = 0;
 	size_t size;
@@ -198,17 +198,6 @@ static int patch_insn_set(void *addr, u8 c, size_t len)
 }
 NOKPROBE_SYMBOL(patch_insn_set);
 
-int patch_text_set_nosync(void *addr, u8 c, size_t len)
-{
-	u32 *tp = addr;
-	int ret;
-
-	ret = patch_insn_set(tp, c, len);
-
-	return ret;
-}
-NOKPROBE_SYMBOL(patch_text_set_nosync);
-
 int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	size_t patched = 0;
@@ -230,17 +219,6 @@ int patch_insn_write(void *addr, const void *insn, size_t len)
 }
 NOKPROBE_SYMBOL(patch_insn_write);
 
-int patch_text_nosync(void *addr, const void *insns, size_t len)
-{
-	u32 *tp = addr;
-	int ret;
-
-	ret = patch_insn_write(tp, insns, len);
-
-	return ret;
-}
-NOKPROBE_SYMBOL(patch_text_nosync);
-
 static int patch_text_cb(void *data)
 {
 	struct patch_insn *patch = data;
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 0a96abdaca65..b053ae5c4191 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -226,7 +226,7 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 	int ret;
 
 	mutex_lock(&text_mutex);
-	ret = patch_text_nosync(dst, src, len);
+	ret = patch_insn_write(dst, src, len);
 	mutex_unlock(&text_mutex);
 
 	if (ret)
@@ -240,7 +240,7 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 	int ret;
 
 	mutex_lock(&text_mutex);
-	ret = patch_text_set_nosync(dst, 0, len);
+	ret = patch_insn_set(dst, 0, len);
 	mutex_unlock(&text_mutex);
 
 	return ret;
-- 
2.39.2


