Return-Path: <bpf+bounces-22872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8A86B17E
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E6D289D1A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D96159591;
	Wed, 28 Feb 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEToAbZY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31290159583;
	Wed, 28 Feb 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129930; cv=none; b=hl86C4AHcUzQtAyh41oe/YB+ki9KZuVKRpaTwwt3HEonscwmP0630kSGo9s0sO/kUFq5RZ98dM7h+VrRCMimIvrA8LUHFu3nV3fYpk4Z4yh6GI2FThlkXnxeVr7ni+8LmJnRAPEURc271xcJCxJJChrWjATLB9fX9S4gbJvF6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129930; c=relaxed/simple;
	bh=ji9XrjR2l6IynyyqHZa6QyN4+F+AU1KRVcNv88MANkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikzhsRjb+rMnzllB/phMKlInXnh4l3L+tamM7F6CNk5ABdKOEyUegZI/RRpcQ5F/haO307AO4WKfgbTRdyUl7b8tqf2sMnLeHRWI7k6Oq10fIYPwo+pAea7DQExV5uA6q08iCBm07oXfUnuZ+xdGawXV8hoDjwvjY1nsqyPqV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEToAbZY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d28468666so4672661f8f.0;
        Wed, 28 Feb 2024 06:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709129927; x=1709734727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJut5fiJS301DH5MoBc/mIfNczO2XYfdN68aAnP3/sk=;
        b=cEToAbZYbRM8BpgnLJner5ASYxqgjAMEXsEGRQXKDgJN4d4NyZWRbGiyKo9jqj4r6O
         N/dvOpGAfEJrgHfy9PRcN6uVw4uXlkowWaAimcHjzaQbdBrHd8Ut728iLOsFXqnHIceq
         5SXesbH0F8c2+RGEJHnQusXnYsnWMIWFtAQ6Ndem+hfGbnhQWpBr3oZ6LfqHH1J4ckCs
         WGC7ZUMUfPKxxyuIbMNqgrvJD3KpGjUY2cIwVqq0isuCCwXg8+wuvR2pQa/mFsBTaxhu
         Fo6cxKLGxrFnm1VOtTqpQHRNqJbmufRFA499Mo6wDXVxZ3xEQhbTrZ/5Mz4E1G0StRY3
         eVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709129927; x=1709734727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJut5fiJS301DH5MoBc/mIfNczO2XYfdN68aAnP3/sk=;
        b=K+KMVLYKe9R7yOUxC5Ye+BhYLgSdevA6NvMMsC541I19kthov5OOIcjIafU/IaJw4J
         OA0xWE84tvviSBKTJTq/krKnH/ZNu6g5t170Xi22YOtxJsCq5M4qRGfoiMviY4K+Icr9
         r6c0lcwua8WZmWfMBDmuTZ+jKn2ttF7ELNlsVZxElg9XV5Y8DJdQZVILPb+aExEJr9Vl
         9n3Yag1p/ZLKGKx+Y85o4Ha762MCE+kCUTMDdmPCUwGL9hSCLvwfjtwaI6WmzL2cQr/9
         pmCLRzHxLerusn6Zjc5RmF8jnnK+MU5ATpQlg9TjMdnPwGHBu6rEbfj9kpkorj1QVMCr
         5bMw==
X-Forwarded-Encrypted: i=1; AJvYcCVKd8wPuLVq0YKhUj+tgliIn2VPKEgRAL6Cv9qekpL0iMUr/TEkJRdYSMuTtGj+KFc8nmlCSAZA+uIqk4CwRtZwxrE9saGetC91GpaNalTwnoQ8lQBIXJ/BzjXE7uUQJMD9
X-Gm-Message-State: AOJu0YzZb9hAdQX/TW+Mrl8/B30Kc+GZv1svVnc65CHHG5BQGnZod+hE
	4Z6yklnDJd4/V1iVJ/gbL5nrA5BM7D3o8fsfDqWzfl4+3SPLM6QE
X-Google-Smtp-Source: AGHT+IGZKCeHbdpZnC4EweEwQmwtBWRZ+S4sbJW/37Uh5PCThKo1erX7w5/3y46PUkfco7QUlVNAYg==
X-Received: by 2002:adf:f44f:0:b0:33d:2b46:3ee3 with SMTP id f15-20020adff44f000000b0033d2b463ee3mr8723764wrp.22.1709129927170;
        Wed, 28 Feb 2024 06:18:47 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d564a000000b0033e0523b829sm549869wrw.13.2024.02.28.06.18.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:18:46 -0800 (PST)
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
Subject: [PATCH bpf-next v9 1/2] arm64: patching: implement text_poke API
Date: Wed, 28 Feb 2024 14:18:23 +0000
Message-ID: <20240228141824.119877-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240228141824.119877-1-puranjay12@gmail.com>
References: <20240228141824.119877-1-puranjay12@gmail.com>
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/patching.h |  2 +
 arch/arm64/kernel/patching.c      | 75 +++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

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
index b4835f6d594b..255534930368 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -105,6 +105,81 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
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
2.42.0


