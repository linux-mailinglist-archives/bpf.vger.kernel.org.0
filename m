Return-Path: <bpf+bounces-20327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FA283C3AD
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 14:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0741F267DA
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0C56B66;
	Thu, 25 Jan 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6zXWlq0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63C55C3E;
	Thu, 25 Jan 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189550; cv=none; b=m7DFSWYv1LX1JwCmnixtZjLXXLBrSENU0jFMH79vo4/U8/gPtAt80VAnr2vKve39O1jivGyV5+mOtFfcwNd4PpsHv+fEf9VQMdkqe7g8Me0XuYxHHui9wjAaIFLC9MKnaoSFbek7CAdcpzUBS+i80kTLatgo/g4X+JcLoMie6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189550; c=relaxed/simple;
	bh=jZDJv0ysjPvVF3fqpYH9nGSFDwIoB/LyXOKFUfIztt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icGm947kEG/UL2yqZRVykrS+07nCIPmifSq5vtrG1at5jo2LZiCY7SsYJ3ypVP9eaB0TSxRHOoqSMxJjJKVRvVstshWNcXKj09XhmRcffUgzyaFM4D6Nk2n5kPMIccPkALxdMy7S9NPTDEgxAwM5/Taw+xNfRARs67/RDUHgTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6zXWlq0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337b8da1f49so5945778f8f.0;
        Thu, 25 Jan 2024 05:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706189546; x=1706794346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI4++Tri0XwJHgi/SwI3tIuIhoPqQHm+YqaSOpS3kwM=;
        b=T6zXWlq0SLlVgNqn1F1rStqkWh3Xly7sO2GhXk8tZFU9S91gr3oEdRvUWOWm40VDvk
         xBQw5XkDWWq84Okr0Es7oW3w+rQz4Gji9PaDwbiBWnLP9j3oc0f/kVfh4VSlaUPP9fKH
         H39a3QFe75nteJ/FKreOKykYBW5IpbotWA/e4Tw3knHF6BY7Z9WuQZrgFU9UbkOz6f58
         S6qYHYZ7aKttnrSNdmseyXcqqoN8syYmznGW3c+N6717b0wv37g1CPqLdCA7Vaus9C/t
         5zkpYeClig3IwMxCyu9vZ04rW0SiHXDCWU1OSvo2OTO9Ux2Y8dU+BBbMqAIEVawv1EGX
         5bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706189546; x=1706794346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI4++Tri0XwJHgi/SwI3tIuIhoPqQHm+YqaSOpS3kwM=;
        b=Drm2dPEnVuKvLROeUJnK8y7vQ+Mci+Bupf6DTfGl3JvTfP12Ns5895fgIPrGxnzmXl
         EBTHR9p0dq8uo1zkSgHiKlmmRIPVsewUlNssHjpBDk/o8Pk6VRzDWSPvUMYWVrUWPJ8T
         Ql/bsosBLloN1mJrdh1J22NUQR2fsj4WDOMFsc7uSkTEY1PtO0kcGUcl+0lWxP2tJJS0
         Z7KbxcNIuIWHw+9covBplv8X3K2t/3hO46QCnCtl++f42yNtd+aF+lSp+Zx69qmN6ETB
         4RQa97IkTu4Ay1DBkLLggVHp5Z8O/Ez9K2rDWVy4OZQo1HRj9TZproh5dyLBVHV7m8aP
         532g==
X-Gm-Message-State: AOJu0YyVJcbjqZWjYS9h6OGpRgfR98jX3b6RzXqDqw2nYEZ7NJ7GqBMT
	TxIA0lULtNgmEXT3pnMN+lzHmRyi1P5R/iaic27k/XcxqJtpBLZIZwMhvBhoLtooQA==
X-Google-Smtp-Source: AGHT+IHQIZJsJdAU+2qb2txKeOEYR7L1CR8S/iMgbYTmFiK9T+jtJK46ukwppWquTcpNEz5Z/6XRtw==
X-Received: by 2002:a05:6000:1757:b0:336:6920:d766 with SMTP id m23-20020a056000175700b003366920d766mr339879wrf.93.1706189546543;
        Thu, 25 Jan 2024 05:32:26 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm12418488wrr.1.2024.01.25.05.32.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2024 05:32:26 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	bpf@vger.kernel.org,
	kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xukuohai@huaweicloud.com
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v7 1/2] arm64: patching: implement text_poke API
Date: Thu, 25 Jan 2024 13:31:58 +0000
Message-Id: <20240125133159.85086-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240125133159.85086-1-puranjay12@gmail.com>
References: <20240125133159.85086-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The text_poke API is used to implement functions like memcpy() and
memset() for instruction memory (RO+X). The implementation is similar to
the x86 version.

This will be used by the BPF JIT to write and modify BPF programs. There
could be more users of this in the future.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/include/asm/patching.h |  2 +
 arch/arm64/kernel/patching.c      | 80 +++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
index 68908b82b168..587bdb91ab7a 100644
--- a/arch/arm64/include/asm/patching.h
+++ b/arch/arm64/include/asm/patching.h
@@ -8,6 +8,8 @@ int aarch64_insn_read(void *addr, u32 *insnp);
 int aarch64_insn_write(void *addr, u32 insn);
 
 int aarch64_insn_write_literal_u64(void *addr, u64 val);
+void *aarch64_insn_set(void *dst, u32 insn, size_t len);
+void *aarch64_insn_copy(void *dst, void *src, size_t len);
 
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index b4835f6d594b..5c2d34d890cf 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -105,6 +105,86 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
 	return ret;
 }
 
+typedef void text_poke_f(void *dst, void *src, size_t patched, size_t len);
+
+static void *__text_poke(text_poke_f func, void *addr, void *src, size_t len)
+{
+	unsigned long flags;
+	size_t patched = 0;
+	size_t size;
+	void *waddr;
+	void *ptr;
+	int ret;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+
+	while (patched < len) {
+		ptr = addr + patched;
+		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
+			     len - patched);
+
+		waddr = patch_map(ptr, FIX_TEXT_POKE0);
+		func(waddr, src, patched, size);
+		patch_unmap(FIX_TEXT_POKE0);
+
+		if (ret < 0) {
+			raw_spin_unlock_irqrestore(&patch_lock, flags);
+			return NULL;
+		}
+		patched += size;
+	}
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+
+	flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
+
+	return addr;
+}
+
+static void text_poke_memcpy(void *dst, void *src, size_t patched, size_t len)
+{
+	copy_to_kernel_nofault(dst, src + patched, len);
+}
+
+static void text_poke_memset(void *dst, void *src, size_t patched, size_t len)
+{
+	u32 c = *(u32 *)src;
+
+	memset32(dst, c, len / 4);
+}
+
+/**
+ * aarch64_insn_copy - Copy instructions into (an unused part of) RX memory
+ * @dst: address to modify
+ * @src: source of the copy
+ * @len: length to copy
+ *
+ * Useful for JITs to dump new code blocks into unused regions of RX memory.
+ */
+noinstr void *aarch64_insn_copy(void *dst, void *src, size_t len)
+{
+	/* A64 instructions must be word aligned */
+	if ((uintptr_t)dst & 0x3)
+		return NULL;
+
+	return __text_poke(text_poke_memcpy, dst, src, len);
+}
+
+/**
+ * aarch64_insn_set - memset for RX memory regions.
+ * @dst: address to modify
+ * @insn: value to set
+ * @len: length of memory region.
+ *
+ * Useful for JITs to fill regions of RX memory with illegal instructions.
+ */
+noinstr void *aarch64_insn_set(void *dst, u32 insn, size_t len)
+{
+	if ((uintptr_t)dst & 0x3)
+		return NULL;
+
+	return __text_poke(text_poke_memset, dst, &insn, len);
+}
+
 int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 {
 	u32 *tp = addr;
-- 
2.40.1


