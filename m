Return-Path: <bpf+bounces-2833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754D573515F
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35331280F91
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9994C8CD;
	Mon, 19 Jun 2023 10:01:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A3C8C8
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 10:01:51 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2FEE4D;
	Mon, 19 Jun 2023 03:01:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31110aea814so3314286f8f.2;
        Mon, 19 Jun 2023 03:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687168884; x=1689760884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfL8kOHIfnY7PiBiCXPYIlsy0Fts7anKA/DneQ6qt2M=;
        b=FctDpddQkBXnzOoMsS1SofViEs4R2DxUET5Tefl8hEjNIY/Ao4Alj88BKwOeirwwAU
         hFf3x+XTPakAn+B5zlBv+57ObBx/Cbu0T+2qQ2Y07ojIatgvxHkpwklkIJkMz/I3CoKU
         J22O4pzjidWxgmYTa2P2ZgmBJs7ziIMiMKH8GCrmsySFgeWIu8u5T0yrqQ5Rv6MwpPpH
         nXoEfN5ipABKmZIdHYlaOS3Ru1c2OcZbEsGlotU8hKhgEU03r93xZumCopfcOSn1zkXD
         /i8xxcuIn5nA5ZtzkdbyQi0f4ebsUbw5+JQMLu93RvzBUo3bg1UJLL0ZaHPoC/nS+Btt
         wdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687168884; x=1689760884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfL8kOHIfnY7PiBiCXPYIlsy0Fts7anKA/DneQ6qt2M=;
        b=ZDrkuOfKvfbUkquhNEKWmI/DAMtOY1dxs2ITa5NjxNfoYgeP8CawsWmHNWu4CLKMdO
         MdJeqySi/e3Em9r9DgL7QfZDFlucBzYOV+cKwL5tCIfZ2DX7qZ9VgZYjyYuRxEa6fr3a
         5caMfVTfJ6FRTJU/sDQCQMrW1vmZvyNavGBDUlWrVQDBHtbV9bVP9AV8cETCbTvdJ/RO
         zC9OuaAdRIZk3uDA3Plzc01g0jgz21xsdaJUFbxNgMizB2siUrN/RXwPvr7nNv41qYYW
         /xNnCcApBPg0CfQ2i9jrelXZFg3c+b9V7E0MNo/G6n39qpzEmwpC8PTjjzuGMvZi5IZj
         rRGg==
X-Gm-Message-State: AC+VfDyfTArq/8aE3JYyTvuptfc9k75i+tEMn8Mkw0YhsHlXmB71VsDT
	oLAdWEUPdVVJI2ayo2g8sf0=
X-Google-Smtp-Source: ACHHUZ5GtcUkypYA3SHjL16gLS67dE/eMRqVmiWQ8WMBU18yMUOPhUtB3mKROVBzH9x9PT8vqX1uMQ==
X-Received: by 2002:a5d:6605:0:b0:311:e03:f644 with SMTP id n5-20020a5d6605000000b003110e03f644mr8435206wru.18.1687168883759;
        Mon, 19 Jun 2023 03:01:23 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-54-154-23-32.eu-west-1.compute.amazonaws.com. [54.154.23.32])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b0030ae3a6be4asm31352451wrf.72.2023.06.19.03.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:01:23 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v3 2/3] arm64: patching: Add aarch64_insn_copy()
Date: Mon, 19 Jun 2023 10:01:20 +0000
Message-Id: <20230619100121.27534-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619100121.27534-1-puranjay12@gmail.com>
References: <20230619100121.27534-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This will be used by BPF JIT compiler to dump JITed binary to a RX huge
page, and thus allow multiple BPF programs sharing the a huge (2MB)
page.

The bpf_prog_pack allocator that implements the above feature allocates
a RX/RW buffer pair. The JITed code is written to the RW buffer and then
this function will be used to copy the code from RW to RX buffer.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Acked-by: Song Liu <song@kernel.org>
---
Changes in v2 => v3
- No changes

Changes in v1 => v2:
- Renamed addr/opcode to dst/src.
- Added Acked-by: Song Liu <song@kernel.org>

 arch/arm64/include/asm/patching.h |  1 +
 arch/arm64/kernel/patching.c      | 39 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
index 68908b82b168..f78a0409cbdb 100644
--- a/arch/arm64/include/asm/patching.h
+++ b/arch/arm64/include/asm/patching.h
@@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
 int aarch64_insn_write(void *addr, u32 insn);
 
 int aarch64_insn_write_literal_u64(void *addr, u64 val);
+void *aarch64_insn_copy(void *dst, const void *src, size_t len);
 
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index b4835f6d594b..419a9428402e 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -105,6 +105,45 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
 	return ret;
 }
 
+/**
+ * aarch64_insn_copy - Copy instructions into (an unused part of) RX memory
+ * @dst: address to modify
+ * @src: source of the copy
+ * @len: length to copy
+ *
+ * Useful for JITs to dump new code blocks into unused regions of RX memory.
+ */
+noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
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
+		ptr = dst + patched;
+		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
+			     len - patched);
+
+		waddr = patch_map(ptr, FIX_TEXT_POKE0);
+		ret = copy_to_kernel_nofault(waddr, src + patched, size);
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
+	return dst;
+}
+
 int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 {
 	u32 *tp = addr;
-- 
2.40.1


