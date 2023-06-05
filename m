Return-Path: <bpf+bounces-1797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD3C721FD1
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 09:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6371C20ABF
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7614811CB7;
	Mon,  5 Jun 2023 07:40:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03911CA4
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 07:40:30 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B00D3;
	Mon,  5 Jun 2023 00:40:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so45672305e9.3;
        Mon, 05 Jun 2023 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685950827; x=1688542827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkzqYxL73s22EAwsna++GGXRkm1HvzsrQXeSnzKLJ6M=;
        b=ad1sTI8nqnhQ4S/1WnIPW6zm48etDauqxoNS4yAm8F/DkP+AJY3rZU6ft/MBECBmMb
         8F29zfFuogHVFdyX+p0h627jFsihUhI+MZrV4E4xFEuBWhoo0iFHN7HEUNxT79PjePaz
         +OscpeOPWhNmq9mW15hMqAabb4Fm1MjCFVWwut+poRj6rFEvyyXhz9ey5BpE6FTxpnrR
         QHqIXTmpLEefs/M+wfYU967NOJITwOMCfXsOGa+tn8EA457L1tuFaRi6+MoeqHipcZmw
         IlKuB8RufCWHnEqiToTsqgaZzPE30xdn6xutUufEjbRcTpN07qItho2sPv/8hxbKlYxK
         Fipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950827; x=1688542827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkzqYxL73s22EAwsna++GGXRkm1HvzsrQXeSnzKLJ6M=;
        b=ImvDZRSEIXrA/ZdqOvLVubkN7hG7Od92b+QNcatLglVqDmU+GBL3sAKS+4XXhIg9d6
         urSUw+mfpKtcdk5QUZDC7+7SGhBaCU/z5FLTxYQSXJrbFj4NqDHYkN5Isi9JsWNFegzV
         wiESdEWxnUTDGzm39eWLGwovy7F6Wimbodzuddw8AIoBS5un2L3qQYtlB1JafgiE11Kk
         4NF+XcCHn6oB9vy2SLtx8EegZGI+WkrKzBxSxIwnUYsw0vuB+ZkBSyhwfPTEL3vopW53
         PYSD7FVd9bwokk/NkRxeOTiYtwO7uRy0xgrQ3tIdAPeW/RrZF9hIt3Y5nb9BDxk6e6TV
         XLeA==
X-Gm-Message-State: AC+VfDz94mUR1jj0BU7Lk9CjIoxuWbTQJFJFpdj3qr5hJCBXuW+IQypc
	DghgSHqtZM2nHgiJjqzOhVA=
X-Google-Smtp-Source: ACHHUZ7Ls9cXd9bOy8NVrhksZPkskca3CwSJJZLtxIsyFgHq0GzJNJ2CJ6bYNnwlMBoG7rmQWQMQgg==
X-Received: by 2002:a7b:ca46:0:b0:3f1:789d:ad32 with SMTP id m6-20020a7bca46000000b003f1789dad32mr8195807wml.11.1685950826769;
        Mon, 05 Jun 2023 00:40:26 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-34-244-49-215.eu-west-1.compute.amazonaws.com. [34.244.49.215])
        by smtp.gmail.com with ESMTPSA id c18-20020adfed92000000b0030ae499da59sm8882103wro.111.2023.06.05.00.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:40:26 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/3] arm64: patching: Add aarch64_insn_copy()
Date: Mon,  5 Jun 2023 07:40:23 +0000
Message-Id: <20230605074024.1055863-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605074024.1055863-1-puranjay12@gmail.com>
References: <20230605074024.1055863-1-puranjay12@gmail.com>
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
---
 arch/arm64/include/asm/patching.h |  1 +
 arch/arm64/kernel/patching.c      | 39 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
index 68908b82b168..dba9eb392bf1 100644
--- a/arch/arm64/include/asm/patching.h
+++ b/arch/arm64/include/asm/patching.h
@@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
 int aarch64_insn_write(void *addr, u32 insn);
 
 int aarch64_insn_write_literal_u64(void *addr, u64 val);
+void *aarch64_insn_copy(void *addr, const void *opcode, size_t len);
 
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index b4835f6d594b..48c710f6a1ff 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -105,6 +105,45 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
 	return ret;
 }
 
+/**
+ * aarch64_insn_copy - Copy instructions into (an unused part of) RX memory
+ * @addr: address to modify
+ * @opcode: source of the copy
+ * @len: length to copy
+ *
+ * Useful for JITs to dump new code blocks into unused regions of RX memory.
+ */
+noinstr void *aarch64_insn_copy(void *addr, const void *opcode, size_t len)
+{
+	unsigned long flags;
+	size_t patched = 0;
+	size_t size;
+	void *waddr;
+	void *dst;
+	int ret;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+
+	while (patched < len) {
+		dst = addr + patched;
+		size = min_t(size_t, PAGE_SIZE - offset_in_page(dst),
+			     len - patched);
+
+		waddr = patch_map(dst, FIX_TEXT_POKE0);
+		ret = copy_to_kernel_nofault(waddr, opcode + patched, size);
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
+	return addr;
+}
+
 int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 {
 	u32 *tp = addr;
-- 
2.39.2


