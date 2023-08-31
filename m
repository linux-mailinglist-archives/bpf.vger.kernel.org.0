Return-Path: <bpf+bounces-9060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 363A778EE40
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6782C1C209C3
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C011172B;
	Thu, 31 Aug 2023 13:12:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A71171F
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 13:12:37 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931EDCFE;
	Thu, 31 Aug 2023 06:12:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401f68602a8so7361455e9.3;
        Thu, 31 Aug 2023 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693487554; x=1694092354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egv6cBK34EgIbjBrWp9fTvnprfq8zkhKE0zbSvUdTM8=;
        b=PmaaljAsEz33zaFyiUWyOTX45I7t0/skIOIhQ/XMivnzDE6qjcdKxmg2DrI31+dV6G
         qvDZ28Hv4zPEtXNdoya/bBnpX8ql2Mb6EwpFapj4Ag+PHuV8DMfL5ETjjxJmqBNblBwF
         cBMcBer7XZN2BjfDTwVcbXo1kLbzhXC1NmOF5vn2+/jD2TNBkToYcDECnEGT6anOq2Ug
         FmJP/gEjzq0MTFHBQODlBlIRshRSv9b057ua9JbLe65PeInmXvoCeRIVprsqZtB7Kch9
         mw4kwA3kXjATg8UN2EeyJdowa7aFnOKYRfcZG7posns0WhrsRDXPMeLA24+QGCUvxf6r
         OweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487554; x=1694092354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egv6cBK34EgIbjBrWp9fTvnprfq8zkhKE0zbSvUdTM8=;
        b=Ea+1NP7z0QCLSnpvf1TwnbzofGJFSBKo5bCF0P7oOhfq/e+AX++3loV9yWKWBUn5sI
         EAVxzQVhaHtjVRLVZjzUbTl57DBdFZo+2BJNLuxz3nrF/aZbH/V8F3JsopGPoHzuVNpa
         xXy5p1lU8bZ0f9+EJyLA1+5hV/Py0GBjWwUKW64E37GblCMiASLAB5mS5Z+kCWH6S3XA
         YVUdVhpDp2ULuPzZST4qnB9ugVfnwqZOhIbxVNen/ske9hXJM0rtMQ5p13qy//oED2B2
         mOx6SHM+4Bv839dxBARkWKHaWkro2txedk2IiyHsbNQLV+pDJLMwfH7LyEf/1pc/Ui1D
         uDyA==
X-Gm-Message-State: AOJu0YxK1BLh3qOCw6IV05XyeVMuQWLPjUjvQdnIuOR1TR23FMM7jYZL
	shgI74c8wYPyIFe8LluF+s4=
X-Google-Smtp-Source: AGHT+IFNloiz3CzOTUOmKRegrJpuf48gN1sNQVaqZVlmbqhoFqXkrky0uDTwEvywMEW/CZlXcMQGhQ==
X-Received: by 2002:a5d:5689:0:b0:31a:dbd1:bf6 with SMTP id f9-20020a5d5689000000b0031adbd10bf6mr4195294wrv.68.1693487553990;
        Thu, 31 Aug 2023 06:12:33 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id a28-20020a5d457c000000b00317f70240afsm2206607wrc.27.2023.08.31.06.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:12:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/4] riscv: implement a memset like function for text
Date: Thu, 31 Aug 2023 13:12:28 +0000
Message-Id: <20230831131229.497941-4-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230831131229.497941-1-puranjay12@gmail.com>
References: <20230831131229.497941-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The BPF JIT needs to write invalid instructions to RX regions of memory to
invalidate removed BPF programs. This needs a function like memset() that
can work with RX memory.

Implement patch_text_set_nosync() which is similar to text_poke_set() of
x86.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
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
2.39.2


