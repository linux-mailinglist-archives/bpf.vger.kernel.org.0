Return-Path: <bpf+bounces-76254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AA3CABFC0
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 04:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 450913048429
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08F8225A35;
	Mon,  8 Dec 2025 03:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GP8K/Okx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBB1E3DDE
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165839; cv=none; b=uUo/nHhusRIM2ZDDwsgiKgesBROcAbw3B5w30nmKDi//R3Qrg523t4VA+L69Ala0ksbrt7T5op3b/fDbxlVmtx0iglYwAvZc+4fgRJvEYaZ8CodC2IoQvsc42k6L53g3FK9vCsS40Mk3B5GloRWo7qn1RvacB1LfHhP4k66DcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165839; c=relaxed/simple;
	bh=2S8VdCVOVRMhLF5pnwGHAuQCvqrTtPFg5LvAxtmaqpI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPAOG+oOOGgtuELcjtGze0TzJRX5dOkwQre/bW6S+oNbooz5hhwBHuoceavsjpVEWsuK9GsF3/sL5cl88L4IUoNUCBrxUXWO21n9Am6uOYOIsUaP4YkXIoRtPKyUegDcDHupNLri+caZ7Gu/yDhHA3aAd8p42oB1Us5WTz7LRZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GP8K/Okx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2984dfae0acso75608075ad.0
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 19:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765165837; x=1765770637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcDdbeyUjaIQvBTZiz9kFlENYKGodkKBU6I+HMWpHSE=;
        b=GP8K/Okx3N6vWGjppOI88KOBfYqSf1V3UlBtdJyfMuLh6eCaxTpXLaeKksSm9IT+m9
         mPATWk1BPUJf2RRQc852zyuDovq70mTuhO8g4yweZrrcJw+ghoUrW39yplewOhObnw9f
         YQ/6k1/oDauYfGqQoQu5iThvfmOUk2MvBCS83WttHro/v/mF8ZWf6MXZe03q29bP1qbk
         RuOM5THrG+41098kgwOsAFb21jcyRUOWQao9XhZcmlWaZS2zQ2dPR7coaM7HR/DBl+RQ
         mbaQThjElI5UfHfexoh3JRVep5N9OMZlYYgv7+6mqysmh9aHrtZV5EUkWrDocBHYGbVK
         3RQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765165837; x=1765770637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TcDdbeyUjaIQvBTZiz9kFlENYKGodkKBU6I+HMWpHSE=;
        b=UIte3f2iq69cpojC2MsYT0C3kGIukiG2gsNmYJdEwWbh/PbwCZbvxyV6ABI6Iktcpa
         bnsPlBWLVRFc9axMzTIT5I4ZhOaOtsuNMBlCH5MDYJajGFCtmv+I4uvpXSieHB4I0h1v
         HMd8fMjbE97qMV5mVrsWwrp6qclznAQGKxsS5d+bR475NOGubufeVyeiauNCCpJfBjCG
         x6YOyHrgBhJBhOFo0snxQJn6Z59WPoFXcW3wtdXnm9B6wITMBmjPZfGMfMDPm06/Ln6o
         k116ptpxv0nRp/iRN3HZqeHm/76hY6I5a+V46ix+BcB/EAV3EOxKLadrg+Z3gNFH3vPo
         68ww==
X-Forwarded-Encrypted: i=1; AJvYcCXVASKDjdg9u/1i8iO0k8bKEDb7hMRGHPf1AUb0XFce+yu/w3EauIZA1fkl0iftArZ/TXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4ZocgNhEce+mUV6VAP2m6K9fniZOkJhqGlSZd89oy/4diD0M
	mfda1y08pNVygMt0wErYHWshVu+WB/48LwDh2qHKPToPpBaNUFWgNsXQZ2jtcxTKmJ0=
X-Gm-Gg: ASbGncsbOtMRYTKHc7PCqeXCYavy0txtQJ+g3Ww1ZPNsuMMolHOfqTbSGOBhf0kNo6j
	ouViWFwRN/k9goIZiaV9HV+n73tDYrlyyFk8debZriFwVdm+hK1Ih9GIL9EbjUQ3CRk3KyijYEO
	Edm3B2b9xDjSburZOAvuV+cF46/mw62GDjjYYvGJ9dhXDgoagekIVtJLuMv/XRlx0MGYatyz+Km
	KMmm7cf9ynfc4t13QJhyG78ZGdqUN3zkncDPbChZQ+eGp/TXpjiZn4vmnoOkt2d3x8Db0R6OdR2
	tyvO3YQjOf6vljcJfAVbUQGqbV010lzuQTOOarImhidffhbT0AzNn/pLGt26ueGeMoZ3gkmxz0U
	ZU7dYkivnZus6NdCwvdxdC6vdD2NVxzv3cf92pg2fRPSzL2qtT/XqEGH9yfO7kEFS1iY1awQQ/U
	JbraAATtnfqDTkGfgnNjwGpXwrDYTm+hTR2r1BJ8Mj9vlB
X-Google-Smtp-Source: AGHT+IEsyS70YjfqcY6uDUzuCw0QsSiDGBq56vWCrB/xumiB1z4Fux5bNgh47wXnVIwNcfKaN47/fA==
X-Received: by 2002:a17:902:cf0f:b0:297:c4b0:8d53 with SMTP id d9443c01a7336-29df5e1b2femr51595245ad.54.1765165836888;
        Sun, 07 Dec 2025 19:50:36 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6d96sm108871275ad.102.2025.12.07.19.50.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Dec 2025 19:50:36 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andii@kernel.org,
	andybnac@gmail.com,
	apatel@ventanamicro.com,
	ast@kernel.org,
	ben.dooks@codethink.co.uk,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	charlie@rivosinc.com,
	cl@gentwo.org,
	conor.dooley@microchip.com,
	cuiyunhui@bytedance.com,
	cyrilbur@tenstorrent.com,
	daniel@iogearbox.net,
	debug@rivosinc.com,
	dennis@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk,
	martin.lau@linux.dev,
	palmer@dabbelt.com,
	pjw@kernel.org,
	puranjay@kernel.org,
	pulehui@huawei.com,
	ruanjinjie@huawei.com,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	sdf@fomichev.me,
	song@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	thuth@redhat.com,
	yonghong.song@linux.dev,
	yury.norov@gmail.com,
	zong.li@sifive.com
Subject: [PATCH v2 2/3] riscv: introduce percpu.h into include/asm
Date: Mon,  8 Dec 2025 11:49:43 +0800
Message-Id: <20251208034944.73113-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251208034944.73113-1-cuiyunhui@bytedance.com>
References: <20251208034944.73113-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current percpu operations rely on generic implementations, where
raw_local_irq_save() introduces substantial overhead. Optimization
is achieved through atomic operations and preemption disabling.

Currently, since RISC-V does not support lr/sc.b/h, when ZABHA is
not supported, lr/sc.w needs to be used instead, which requires
some additional mask operations.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/percpu.h | 238 ++++++++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)
 create mode 100644 arch/riscv/include/asm/percpu.h

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
new file mode 100644
index 0000000000000..b173729926126
--- /dev/null
+++ b/arch/riscv/include/asm/percpu.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __ASM_PERCPU_H
+#define __ASM_PERCPU_H
+
+#include <linux/preempt.h>
+
+#include <asm/alternative-macros.h>
+#include <asm/cpufeature-macros.h>
+#include <asm/hwcap.h>
+
+#define PERCPU_RW_OPS(sz)						\
+static inline unsigned long __percpu_read_##sz(void *ptr)		\
+{									\
+	return READ_ONCE(*(u##sz *)ptr);				\
+}									\
+									\
+static inline void __percpu_write_##sz(void *ptr, unsigned long val)	\
+{									\
+	WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);				\
+}
+
+PERCPU_RW_OPS(8)
+PERCPU_RW_OPS(16)
+PERCPU_RW_OPS(32)
+PERCPU_RW_OPS(64)
+
+#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)			\
+static inline void							\
+__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)		\
+{									\
+	asm volatile (							\
+		"amo" #amo_insn #sfx " zero, %[val], %[ptr]"		\
+		: [ptr] "+A" (*(u##sz *)ptr)				\
+		: [val] "r" ((u##sz)(val))				\
+		: "memory");						\
+}
+
+#define PERCPU_OP(name, amo_insn)					\
+	__PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)			\
+	__PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
+
+PERCPU_OP(add, add)
+PERCPU_OP(andnot, and)
+PERCPU_OP(or, or)
+
+/*
+ * Currently, only this_cpu_add_return_xxx() requires a return value,
+ * and the PERCPU_RET_OP() does not account for other operations.
+ */
+#define __PERCPU_AMO_RET_OP_CASE(sfx, name, sz, amo_insn)		\
+static inline u##sz							\
+__percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long val)	\
+{									\
+	register u##sz ret;						\
+									\
+	asm volatile (							\
+		"amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"		\
+		: [ptr] "+A" (*(u##sz *)ptr), [ret] "=r" (ret)		\
+		: [val] "r" ((u##sz)(val))				\
+		: "memory");						\
+									\
+	return ret + val;						\
+}
+
+#define PERCPU_RET_OP(name, amo_insn)					\
+	__PERCPU_AMO_RET_OP_CASE(.w, name, 32, amo_insn)		\
+	__PERCPU_AMO_RET_OP_CASE(.d, name, 64, amo_insn)
+
+PERCPU_RET_OP(add, add)
+
+#define PERCPU_8_16_GET_SHIFT(ptr)	(((unsigned long)(ptr) & 0x3) * BITS_PER_BYTE)
+#define PERCPU_8_16_GET_MASK(sz)	GENMASK((sz)-1, 0)
+#define PERCPU_8_16_GET_PTR32(ptr)	((u32 *)((unsigned long)(ptr) & ~0x3))
+
+#define PERCPU_8_16_OP(name, amo_insn, sz, sfx, val_type, new_val_expr, asm_op)			\
+static inline void __percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)		\
+{												\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&						\
+		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {				\
+		asm volatile ("amo" #amo_insn #sfx " zero, %[val], %[ptr]"			\
+			: [ptr] "+A"(*(val_type *)ptr)						\
+			: [val] "r"((val_type)(new_val_expr))					\
+			: "memory");								\
+	} else {										\
+		u32 *ptr32 = PERCPU_8_16_GET_PTR32(ptr);					\
+		const unsigned long shift = PERCPU_8_16_GET_SHIFT(ptr);				\
+		const u32 mask = PERCPU_8_16_GET_MASK(sz) << shift;				\
+		const val_type val_trunc = (val_type)(new_val_expr);				\
+		u32 retx, rc;									\
+		val_type new_val_type;								\
+												\
+		asm volatile (									\
+			"0: lr.w %0, %2\n"							\
+			"and %3, %0, %4\n"							\
+			"srl %3, %3, %5\n"							\
+			#asm_op " %3, %3, %6\n"							\
+			"sll %3, %3, %5\n"							\
+			"and %1, %0, %7\n"							\
+			"or %1, %1, %3\n"							\
+			"sc.w %1, %1, %2\n"							\
+			"bnez %1, 0b\n"								\
+			: "=&r"(retx), "=&r"(rc), "+A"(*ptr32), "=&r"(new_val_type)		\
+			: "r"(mask), "r"(shift), "r"(val_trunc), "r"(~mask)			\
+			: "memory");								\
+		}										\
+}
+
+#define PERCPU_OP_8_16(op_name, op, expr, final_op)			\
+	PERCPU_8_16_OP(op_name, op, 8, .b, u8, expr, final_op);		\
+	PERCPU_8_16_OP(op_name, op, 16, .h, u16, expr, final_op)
+
+PERCPU_OP_8_16(add, add, val, add)
+PERCPU_OP_8_16(andnot, and, ~val, and)
+PERCPU_OP_8_16(or, or, val, or)
+
+#define PERCPU_8_16_RET_OP(name, amo_insn, sz, sfx, val_type, new_val_expr)			\
+static inline val_type __percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long val)	\
+{												\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&						\
+		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {				\
+		register val_type ret;								\
+		asm volatile ("amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"			\
+			: [ptr] "+A"(*(val_type *)ptr), [ret] "=r"(ret)				\
+			: [val] "r"((val_type)(new_val_expr))					\
+			: "memory");								\
+		return ret + (val_type)(new_val_expr);						\
+	} else {										\
+		u32 *ptr32 = PERCPU_8_16_GET_PTR32(ptr);					\
+		const unsigned long shift = PERCPU_8_16_GET_SHIFT(ptr);				\
+		const u32 mask = (PERCPU_8_16_GET_MASK(sz) << shift);				\
+		const u32 inv_mask = ~mask;							\
+		const val_type val_trunc = (val_type)(new_val_expr);				\
+		u32 old, new, tmp;								\
+												\
+		asm volatile (									\
+			"0: lr.w %0, %3\n"							\
+			"and %1, %0, %4\n"							\
+			"srl %1, %1, %5\n"							\
+			"add %1, %1, %6\n"							\
+			"and %1, %1, %7\n"							\
+			"sll %1, %1, %5\n"							\
+			"and %2, %0, %8\n"							\
+			"or %2, %2, %1\n"							\
+			"sc.w %2, %2, %3\n"							\
+			"bnez %2, 0b\n"								\
+			: "=r"(old), "=r"(tmp), "=&r"(new), "+A"(*ptr32)			\
+			: "r"(mask), "r"(shift), "r"(val_trunc), "r"(PERCPU_8_16_GET_MASK(sz)), \
+			"r"(inv_mask)								\
+			: "memory");								\
+		return (val_type)(tmp);								\
+	}											\
+}
+
+PERCPU_8_16_RET_OP(add, add, 8, .b, u8, val)
+PERCPU_8_16_RET_OP(add, add, 16, .h, u16, val)
+
+#define _pcp_protect(op, pcp, ...)					\
+({									\
+	preempt_disable_notrace();					\
+	op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);				\
+	preempt_enable_notrace();					\
+})
+
+#define _pcp_protect_return(op, pcp, args...)				\
+({									\
+	typeof(pcp) __retval;						\
+	preempt_disable_notrace();					\
+	__retval = (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);	\
+	preempt_enable_notrace();					\
+	__retval;							\
+})
+
+#define this_cpu_read_1(pcp)		_pcp_protect_return(__percpu_read_8, pcp)
+#define this_cpu_read_2(pcp)		_pcp_protect_return(__percpu_read_16, pcp)
+#define this_cpu_read_4(pcp)		_pcp_protect_return(__percpu_read_32, pcp)
+#define this_cpu_read_8(pcp)		_pcp_protect_return(__percpu_read_64, pcp)
+
+#define this_cpu_write_1(pcp, val)	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
+#define this_cpu_write_2(pcp, val)	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
+#define this_cpu_write_4(pcp, val)	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
+#define this_cpu_write_8(pcp, val)	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
+
+#define this_cpu_add_1(pcp, val)	_pcp_protect(__percpu_add_amo_case_8, pcp, val)
+#define this_cpu_add_2(pcp, val)	_pcp_protect(__percpu_add_amo_case_16, pcp, val)
+#define this_cpu_add_4(pcp, val)	_pcp_protect(__percpu_add_amo_case_32, pcp, val)
+#define this_cpu_add_8(pcp, val)	_pcp_protect(__percpu_add_amo_case_64, pcp, val)
+
+#define this_cpu_add_return_1(pcp, val)		\
+_pcp_protect_return(__percpu_add_return_amo_case_8, pcp, val)
+
+#define this_cpu_add_return_2(pcp, val)		\
+_pcp_protect_return(__percpu_add_return_amo_case_16, pcp, val)
+
+#define this_cpu_add_return_4(pcp, val)		\
+_pcp_protect_return(__percpu_add_return_amo_case_32, pcp, val)
+
+#define this_cpu_add_return_8(pcp, val)		\
+_pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
+
+#define this_cpu_and_1(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_8, pcp, ~val)
+#define this_cpu_and_2(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_16, pcp, ~val)
+#define this_cpu_and_4(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_32, pcp, ~val)
+#define this_cpu_and_8(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_64, pcp, ~val)
+
+#define this_cpu_or_1(pcp, val)	_pcp_protect(__percpu_or_amo_case_8, pcp, val)
+#define this_cpu_or_2(pcp, val)	_pcp_protect(__percpu_or_amo_case_16, pcp, val)
+#define this_cpu_or_4(pcp, val)	_pcp_protect(__percpu_or_amo_case_32, pcp, val)
+#define this_cpu_or_8(pcp, val)	_pcp_protect(__percpu_or_amo_case_64, pcp, val)
+
+#define this_cpu_xchg_1(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_2(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_4(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+#define this_cpu_xchg_8(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
+
+#define this_cpu_cmpxchg_1(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_2(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_4(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+#define this_cpu_cmpxchg_8(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+
+#define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
+
+#define this_cpu_cmpxchg128(pcp, o, n)					\
+({									\
+	u128 old__, new__, ret__;					\
+	typeof(pcp) *ptr__;						\
+	old__ = o;							\
+	new__ = n;							\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__ = cmpxchg128_local(ptr__, old__, new__);			\
+	preempt_enable_notrace();					\
+	ret__;								\
+})
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ASM_PERCPU_H */
-- 
2.39.5


