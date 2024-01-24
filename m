Return-Path: <bpf+bounces-20240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A841683AEB5
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB81E1C21CA2
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CFA7E599;
	Wed, 24 Jan 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7TAgAkx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C997E56D;
	Wed, 24 Jan 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115001; cv=none; b=qLdN9jp9NqmQ7mU9a4CAFwMjXGCmx+bLwxRn0EkfgCjTYRMwDta0Q1CC4s2EUFkxqcX5hyVlbww2fPQtw1YUE/LMzH/4Cfrbjlun0urepGfjaHDY+kxMOCc3TmQpVpZwIFe9V0Tmq/J0SynIkU8OuNI4xLp5qGBJAfMC0Hr3KpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115001; c=relaxed/simple;
	bh=jZDJv0ysjPvVF3fqpYH9nGSFDwIoB/LyXOKFUfIztt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chhTbkd4cO9DfcHzC28TCOAyRb/dBEuQofuv5Jf3vHXc/qieaaXZqLaUsRO5UzPwl8pO7l5zL5ujEGyrdQAzf3tTqLytTdGMuscEb6aZwlMAy9MARrW6dC0POJkcTZZ3eelHZMldgtwdUEKU4cQWKYSlaxoZvg3K9t3Db3aY3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7TAgAkx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ec6a002a7so8928195e9.2;
        Wed, 24 Jan 2024 08:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706114997; x=1706719797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI4++Tri0XwJHgi/SwI3tIuIhoPqQHm+YqaSOpS3kwM=;
        b=P7TAgAkxUBola3IQZI4pD+iw/bu0Jx2DrOEe4ToVS40hXeJM1RZdlstw0UFXDcol6A
         bnI6gKA5/3x6B/GfN1xdh9GmVVCxDM+jvk+y5Eoh6tdP8WOaXLcF7SHHdU7PomQABvn0
         vzax+9fMThDF95IsRiHWd2o4wYH6fMwMkWyIWqbph7GkbixS/zFYIRJuuOoqK1JA3+1u
         cGfnIhVQ03sGi+a/W9waoLvJUglhDSpKNCqOD1Uqbz6G6oiA3OeXSFB/RUuqHIRkziXJ
         b6/+WUkXt8FxoQYzeiPI3qtqWN7bFEXf8NCVKgAFnZB4cHAz27X1Fi97L2HJ8M2ro8w+
         H5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114997; x=1706719797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI4++Tri0XwJHgi/SwI3tIuIhoPqQHm+YqaSOpS3kwM=;
        b=kJWN7WmImSDU7BBDKu3jaSYJCWKcaplLMtOFCswY0BoyPwro6nTrM+j5oQlvyvOJ0F
         rfW6JTA6zl2gBQoN1pl5ZzWCUeNJb4zhqrJDGsTZYOGygRvljw7VSQS1WyCNgv9XBQnf
         LelaeqL/NTAe7bNJxS6rrL4unbLjKNawbjp3xom9TKEIk7fbuPkIJe45ux7cDF8OZW3S
         o/D9hHwaF7e+3s8mE0el9DWTt2cpeDEzYVFiUIN2g+guMQcSUJdADWJc3vBVDI7PD1J4
         uuMasW485+DCRWLsuSQ1JB8FhgmR4yUVg6zqOeXnzOR/bmq4Oot9CSaiTjVFGbm7V2yx
         jopg==
X-Gm-Message-State: AOJu0YzHHT0CJP75QGEeHzSc9k+JegKeozdVoc5Eo/GLDR7OkPKv14dA
	ZRGzqQw7/SM1SBG6maizLWgxdW/G6q9FFl05ZSYUARC3MQ1GXboI
X-Google-Smtp-Source: AGHT+IFCSFu0iKmzYfp54IeJH4ezMu880YeBMyFrPL0tYXcvZVSKNQnTOFuJLDPFKRl5i9eqgJYChg==
X-Received: by 2002:a05:600c:4aa9:b0:40e:877e:50e3 with SMTP id b41-20020a05600c4aa900b0040e877e50e3mr850305wmp.264.1706114997434;
        Wed, 24 Jan 2024 08:49:57 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b00339559262e5sm450339wrb.12.2024.01.24.08.49.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2024 08:49:57 -0800 (PST)
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
Subject: [PATCH bpf-next v6 1/2] arm64: patching: implement text_poke API
Date: Wed, 24 Jan 2024 16:49:16 +0000
Message-Id: <20240124164917.119997-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124164917.119997-1-puranjay12@gmail.com>
References: <20240124164917.119997-1-puranjay12@gmail.com>
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


