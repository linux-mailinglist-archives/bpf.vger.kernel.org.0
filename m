Return-Path: <bpf+bounces-8857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE75D78B5BC
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 19:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C623280E65
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED2913AEA;
	Mon, 28 Aug 2023 17:00:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C411CBE
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:00:04 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9B111D;
	Mon, 28 Aug 2023 10:00:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so32492835e9.0;
        Mon, 28 Aug 2023 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693242000; x=1693846800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LWkgqqgT3SYbdvjKemhvyvHh20vmLJOrYQ40cB6+Bg=;
        b=LUnBiaJR9HNaMKr1LuClW/7FqoIw2PQ2Z0IFqenS3bm2yHyyauI3R+G0/pkbbIlTwM
         JXYCQCPKcVJBt1h/jgluTZ6LzA1ef5zEIsYPv6yzmSeqJ51D4L56T7I8Wj33cjBmXgwx
         U7wMjawAfgvz7kO2+1t8lFdCnGx+mOcjw6h6AHkr1PhO12yF3s4GEEbMQ57zlCv/CLJ4
         GzgMByWTJY2zUZC1C6msIRPHXQkVyCK/vGjHes4pUyHjF+64MhI0UclPrAj5TeXrApSm
         qVdKj0V5BXMEiYQcFLbch9V32NTKrI92AAhpsDoL1HuP1YfJkxDJw9crejzS3o7llWtd
         hz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242000; x=1693846800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LWkgqqgT3SYbdvjKemhvyvHh20vmLJOrYQ40cB6+Bg=;
        b=PM1rqi9kQv+sWHOUY+zjWLVza4IYMU1OBBDEVklrJRPbq8ud+kKY1MGdvh+pc9oHU6
         XmsFf+iR523NE/cHdSGeqzq1xTq8mN5hRBHhleR36j6XN1Ev2RC5m8dhyGDzqxd7thBS
         nqNxuLSivnYUj53qh3Lg4wsKPXBOoZl1thY+Up0bm9M8bBHERiouUuLzncixf4Ywn3K1
         sUWXsco2IffmTDWujBsbqg4Z+ReG1Jty3iYTRko0pTwuUZ4QI7ZISrJzt95ZzbtYXkeF
         e8GX/PXx+Byj3+171Eq8ZS9C4YpYdLDZy9QRzrxZQ03CuCvnBHt6QS/n8fPove8Yc9Gw
         QmOg==
X-Gm-Message-State: AOJu0Yxr81L1ptoA10cI77D8JRP0VE+rjqaKBdVwxMoIz9RxTSyNs1PM
	VduAjxv8hj5fAyHYjkqB9nA=
X-Google-Smtp-Source: AGHT+IFRrBHo12Q5/MEtLWE7+/3+VDZFt/AjYftAS8bvWk0LIUMvDzPM19Se5PuDWca75Z9332GiBQ==
X-Received: by 2002:a05:600c:21d5:b0:401:b6f6:d90c with SMTP id x21-20020a05600c21d500b00401b6f6d90cmr7298424wmj.35.1693242000307;
        Mon, 28 Aug 2023 10:00:00 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b0031ad5fb5a0fsm11033613wrx.58.2023.08.28.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 10:00:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/3] riscv: implement a memset like function for text
Date: Mon, 28 Aug 2023 16:59:57 +0000
Message-Id: <20230828165958.1714079-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828165958.1714079-1-puranjay12@gmail.com>
References: <20230828165958.1714079-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The BPF JIT needs to write invalid instructions to RX regions of memory to
invalidate removed BPF programs. This needs a function like memset() that
can work with RX memory.

Implement patch_text_set_nosync() which is similar to text_poke_set() of
x86.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/patch.c      | 77 ++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index 63c98833d510..e88b52d39eac 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -7,6 +7,7 @@
 #define _ASM_RISCV_PATCH_H
 
 int patch_text_nosync(void *addr, const void *insns, size_t len);
+int patch_text_set_nosync(void *addr, u8 c, size_t len);
 int patch_text(void *addr, u32 *insns, int ninsns);
 
 extern int riscv_patch_in_stop_machine;
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 2c97e246f4dc..13ee7bf589a1 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -6,6 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/memory.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/stop_machine.h>
 #include <asm/kprobes.h>
@@ -53,6 +54,39 @@ static void patch_unmap(int fixmap)
 }
 NOKPROBE_SYMBOL(patch_unmap);
 
+static int __patch_insn_set(void *addr, u8 c, size_t len)
+{
+	void *waddr = addr;
+	bool across_pages = (((uintptr_t)addr & ~PAGE_MASK) + len) > PAGE_SIZE;
+
+	/*
+	 * Only two pages can be mapped at a time for writing.
+	 */
+	if (len + offset_in_page(addr) > 2 * PAGE_SIZE)
+		return -EINVAL;
+	/*
+	 * Before reaching here, it was expected to lock the text_mutex
+	 * already, so we don't need to give another lock here and could
+	 * ensure that it was safe between each cores.
+	 */
+	lockdep_assert_held(&text_mutex);
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
@@ -95,6 +129,14 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
 }
 NOKPROBE_SYMBOL(__patch_insn_write);
 #else
+static int __patch_insn_set(void *addr, u8 c, size_t len)
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
@@ -102,6 +144,41 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
 NOKPROBE_SYMBOL(__patch_insn_write);
 #endif /* CONFIG_MMU */
 
+static int patch_insn_set(void *addr, u8 c, size_t len)
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
+		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched), len - patched);
+		ret = __patch_insn_set(addr + patched, c, size);
+
+		patched += size;
+	}
+
+	return ret;
+}
+NOKPROBE_SYMBOL(patch_insn_set);
+
+int patch_text_set_nosync(void *addr, u8 c, size_t len)
+{
+	u32 *tp = addr;
+	int ret;
+
+	ret = patch_insn_set(tp, c, len);
+
+	if (!ret)
+		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
+
+	return ret;
+}
+NOKPROBE_SYMBOL(patch_text_set_nosync);
+
 static int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	size_t patched = 0;
-- 
2.40.1


