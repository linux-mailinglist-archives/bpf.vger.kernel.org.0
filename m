Return-Path: <bpf+bounces-8478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5606A787049
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 15:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E20A2815AF
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 13:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712AF28915;
	Thu, 24 Aug 2023 13:31:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A4CA6E
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 13:31:44 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07FBE78;
	Thu, 24 Aug 2023 06:31:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31aeee69de0so4493952f8f.2;
        Thu, 24 Aug 2023 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692883901; x=1693488701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRbZ/8a2wFTgwFE+Czu2PpLLLzMWLxHTHSPnuA9Gm+o=;
        b=oYWYvKePLZGjS+ZoEl8nqGnfKWJ/5ZYZqjbab0+kcN0rDQKfC+uPSsnIgWkMRmchaP
         kmB/bloU4msL5s6GFjkSzVQf8js0C978vVWo4JbuGczsYJ/hiJcB914hx8ipwG2pLE4r
         5xV7/f4Hn73bYoAhdKka0EWmDvBuFjYAdFIL+QTaLTz04odlXiv4A1ZxyzykLLfmtDYe
         ZKWDxm+ZsoNc7WWZC2lUfFzhqCg8jcrKz+Y3S42S1EZz3NHqw0cr+G45BZdYegXPzh12
         3c6OYT7W+bmFMjwwWfodGWLxbHSaXz5xU5SccK3v8bNMhYtWEHJSa0F0Rpaz0D6PcFD3
         HFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883901; x=1693488701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRbZ/8a2wFTgwFE+Czu2PpLLLzMWLxHTHSPnuA9Gm+o=;
        b=iaIa1HkAWiYwS/tw2lTm31ZJouXm3/EqVyq5D1xyCx0un8V/35vlobPc5Zu/jFC+xA
         z5kpGqXOEgvmh1jNj6ya9Ju7VqR2xn/4M7RAesxGcjCnzPooUXjywboivQMB2HnqVfo/
         U1Bs+3zteMQeR+tKRaGr7y5VO0sjNNCoaHidIPoihcFA0Nwa4dF5aFO9TdHRX7dcPkMK
         fS/iLydRrU0V5rErm80kBTZkIR8HNcQBM5KOEj9GYczpLTzpTi4gb3weCu/NTUtBk4LX
         BqqgeyPHMLEBVZXqn9A0N+WakSYj9tGW4GUK1DGiDsi79z7NIGjI9qDiEGDAVoXWvSWd
         nJbQ==
X-Gm-Message-State: AOJu0YxitLs45Gpn1OG0akF//Vt1IuwnEoq7SanJ8WVWysod4QtryJS2
	tUqAKpaKVXM+lYZ1i/U/Njw=
X-Google-Smtp-Source: AGHT+IHSeNPDuiAo4mvJL6SeFZqm5Y/OINirWF+gSjBoFG2Ur8fcxnPmq3uvy/x+VkYH3pkNmTQiNA==
X-Received: by 2002:a5d:6084:0:b0:31a:d9bc:47a2 with SMTP id w4-20020a5d6084000000b0031ad9bc47a2mr13370813wrt.53.1692883901036;
        Thu, 24 Aug 2023 06:31:41 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d548b000000b00317e77106dbsm22396112wrv.48.2023.08.24.06.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:31:39 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	pulehui@huawei.com,
	conor.dooley@microchip.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v2 2/3] riscv: implement a memset like function for text
Date: Thu, 24 Aug 2023 13:31:34 +0000
Message-Id: <20230824133135.1176709-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230824133135.1176709-1-puranjay12@gmail.com>
References: <20230824133135.1176709-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The BPF JIT needs to write invalid instructions to RX regions of memory
to invalidate removed BPF programs. This needs a function like memset()
that can work with RX memory.

Implement patch_text_set_nosync() which is similar to text_poke_set() of
x86.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/patch.c      | 74 ++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index 63c98833d510..aa5c1830ea43 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -7,6 +7,7 @@
 #define _ASM_RISCV_PATCH_H
 
 int patch_text_nosync(void *addr, const void *insns, size_t len);
+int patch_text_set_nosync(void *addr, const int c, size_t len);
 int patch_text(void *addr, u32 *insns, int ninsns);
 
 extern int riscv_patch_in_stop_machine;
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 465b2eebbc37..24d49999ac1a 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -13,6 +13,7 @@
 #include <asm/fixmap.h>
 #include <asm/ftrace.h>
 #include <asm/patch.h>
+#include <asm/string.h>
 
 struct patch_insn {
 	void *addr;
@@ -53,6 +54,34 @@ static void patch_unmap(int fixmap)
 }
 NOKPROBE_SYMBOL(patch_unmap);
 
+static int __patch_insn_set(void *addr, const int c, size_t len)
+{
+	void *waddr = addr;
+	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
+	int ret;
+
+	/*
+	 * Only two pages can be mapped at a time for writing.
+	 */
+	if (len > 2 * PAGE_SIZE)
+		return -EINVAL;
+
+	if (across_pages)
+		patch_map(addr + PAGE_SIZE, FIX_TEXT_POKE1);
+
+	waddr = patch_map(addr, FIX_TEXT_POKE0);
+
+	memset(waddr, c, len);
+
+	patch_unmap(FIX_TEXT_POKE0);
+
+	if (across_pages)
+		patch_unmap(FIX_TEXT_POKE1);
+
+	return 0;
+}
+NOKPROBE_SYMBOL(__patch_insn_set);
+
 static int __patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	void *waddr = addr;
@@ -95,6 +124,14 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
 }
 NOKPROBE_SYMBOL(__patch_insn_write);
 #else
+static int __patch_insn_set (void *addr, const int c, size_t len)
+{
+	memset(addr, c, len);
+
+	return 0;
+}
+NOKPROBE_SYMBOL(__patch_insn_set);
+
 static int __patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	return copy_to_kernel_nofault(addr, insn, len);
@@ -102,6 +139,43 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
 NOKPROBE_SYMBOL(__patch_insn_write);
 #endif /* CONFIG_MMU */
 
+static int patch_insn_set(void *addr, const int c, size_t len)
+{
+	size_t patched = 0;
+	size_t size;
+	int ret = 0;
+
+	/*
+	 * __patch_insn_set() can only work on 2 pages at a time so call it in a
+	 * loop with len <= 2 * PAGE_SIZE.
+	 */
+	while (patched < len && !ret) {
+		size = min_t(size_t,
+			     PAGE_SIZE * 2 - offset_in_page(addr + patched),
+			     len - patched);
+		ret = __patch_insn_set(addr + patched, c, size);
+
+		patched += size;
+	}
+
+	return ret;
+}
+NOKPROBE_SYMBOL(patch_insn_set);
+
+int patch_text_set_nosync(void *addr, const int c, size_t len)
+{
+	u32 *tp = addr;
+	int ret;
+
+	ret = patch_insn_set(tp, c, len);
+
+	if (!ret)
+		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
+
+	return ret;
+}
+NOKPROBE_SYMBOL(patch_text_set_nosync);
+
 static int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	size_t patched = 0;
-- 
2.39.2


