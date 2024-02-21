Return-Path: <bpf+bounces-22407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857785E045
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 15:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE79286EE1
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40EF8003F;
	Wed, 21 Feb 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV79Gm12"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D647FBCE;
	Wed, 21 Feb 2024 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527093; cv=none; b=a6Z4xZXdkEZ8DwG8gVCIIUs6UOWezmFAEm+szxrd3LJZyCOGatB0EFL5FT0VfeD6ZnDEkhfW6WwfC4w6OlBIo9UWDIZjf16v1qQMWyi8v5M8Cj2Hg5SwRu7IBAc4ILJ0jCg61Uohhirl+KmMlcwatT30rTZ8mgui8kZommEv/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527093; c=relaxed/simple;
	bh=BSCGwts5clRet1ls8gtnwPAagJKD9ilBSXWbzEnIqsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3kXctJ5lwmiexBTyVhL9pjxhwbUVvebRiSSJMqyD4L6w37Jg057DwFSofb7Tm32FkwPQUqJFpPVwFJMi6ptcWvqJ1j+B0y2o2yhxvnOCdylp3//WGr5XiA9lVMwEdOyd9NNhcWaDIlTgZzdYaegQZosmE1M188rnqZDPyj+Ph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV79Gm12; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d10ad265d5so74090011fa.0;
        Wed, 21 Feb 2024 06:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708527090; x=1709131890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3fBbYBgwlF8mrXgT4JE//eUjXOu+3UQk4fgbjSlcgs=;
        b=IV79Gm12Bm70CT5chTCS2XvVo7eBjChKvVohxhgcjoADwOzfqD8zsJXwHG4Sx/gxgL
         V09mhzbsQIionSaU39RjLOPfwXerZWPYI0CsbZnRyb2Y0Os9LMbVV0o+4Ehf0M/HXJZ8
         gGqLHvy16Uh+vXKzaGP5VjxcLGvNjtDhjmn1HjydvpwA2nzwEXQQqHEi9yy61XEtVpAV
         JGrJTqQ7k2LVcBjm8T65y9Ot0J0KkKTKR55B+DioXe8NMuBhgEkXZbF8HtwXlRv3kBif
         ERp7TbWVz4nwKzJeCamm9Qj6c0PJMkBEHmdI4GQIAMLQ0g5hjfCzABA5+0uK2uuLfnaM
         1WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527090; x=1709131890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3fBbYBgwlF8mrXgT4JE//eUjXOu+3UQk4fgbjSlcgs=;
        b=ZLzn5oQpIYyFThj1Sx+HnuH/Ol+/GTuAlST92j9FrQmqsgsAUwUmwaZ4LuF09gumcb
         qjkDmEmBQ6grkmlx+oBRxwnfKub1XKWevtF3Q4YJfxraoU+J//NzwJ8qN2jMFo65RycD
         /yEBJyovF9d8N1Bv1BYnp/F36ClKiOAOSClRMxvF03KNIrhSg5zDojm8jYAGG/Uhzh6j
         Uq2oDJ4l9AuXflBQI+gWAiSykk7gcqDqV7YoBymHfIE0NfXDGWjk8pWQFTIa5BOOo2BX
         e4CeMYkH8DKNZPAgGuZ0Dy+f5tevONDAQAo70yg78WhiiZdYJGbU8PGoioMauGlX9tmc
         KQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCXWq2QC92ZnTGxyhd/rhPhk1q98NhQgvEtpHDCcTxf4bBp+TqsgleToy22sKzqYpQF1mOSfwGciUl6mgUCqlQDO+hP91wtef0z4Gb+VooSr0wKG/Hx/N5l6x/pcRVgiyn32
X-Gm-Message-State: AOJu0YwpLmLS1dnRCf2nTTxnwsWy1S8NrFGIiMqfoXrjmgNx+mkay1X6
	E4zIqJH/dI1P/ynffzjuPno5C84AgSgWxz27iPVclkCdvV3VHRWu
X-Google-Smtp-Source: AGHT+IE74i5KM/mL0gIjIZOJQvTSzd02fZpQK72KtRDA5UZnuZl0x4Sf7VNqb2l/lp4LqmgThu9zMw==
X-Received: by 2002:a05:651c:220c:b0:2d2:3129:3d93 with SMTP id y12-20020a05651c220c00b002d231293d93mr9476674ljq.51.1708527089520;
        Wed, 21 Feb 2024 06:51:29 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d610f000000b0033d4cf751b2sm10441233wrt.33.2024.02.21.06.51.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:51:29 -0800 (PST)
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
Subject: [PATCH bpf-next v8 1/2] arm64: patching: implement text_poke API
Date: Wed, 21 Feb 2024 14:51:05 +0000
Message-Id: <20240221145106.105995-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240221145106.105995-1-puranjay12@gmail.com>
References: <20240221145106.105995-1-puranjay12@gmail.com>
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
2.40.1


