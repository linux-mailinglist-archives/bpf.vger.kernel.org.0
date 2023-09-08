Return-Path: <bpf+bounces-9513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958F9798915
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B82281E7D
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2374F4FD;
	Fri,  8 Sep 2023 14:43:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE036AB0
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 14:43:27 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3E11FC7;
	Fri,  8 Sep 2023 07:43:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a65f9147ccso269889466b.1;
        Fri, 08 Sep 2023 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694184203; x=1694789003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geTOUCxTmcSiHqyGx2hqKaQzZpq5Bo0J+ZmY8mDoL5I=;
        b=redhaDcReeZeWNFv9unlnZuwgnr7kn3pW7CDTe0OnQrCO0zV/flXOV5xisomr8P29p
         lj+mJXFYbtXn1UvMFrSevZ/yGGIf9gcqxRPIKhYSLkIkPjKf8xw3twT0XCzhjcDGOLQd
         egkaCzRkR1PA55wm0cebNGLyH+Gc3yFb43B966yvEpTVdB23YRxhnuqLuOsqXM7WtnaZ
         toBRLq6cAykXejFJ8wDnNJOX6xzuPM0ijnyUQvfUBbuiJSqcjUNg29biRsxQzb3IHfAT
         fmJdTErEmO4g2CqsCpG+C3ID7choJZIIdqOXXp6xdbiEOiSh1JiJtOS4cSEan8qRVRR2
         sxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694184203; x=1694789003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geTOUCxTmcSiHqyGx2hqKaQzZpq5Bo0J+ZmY8mDoL5I=;
        b=iMhSxnkVzbNm/xj05r13ph60JNNEhp+5TU2hLVsN3TswEL5NaeDDHeJRci6w9br5Py
         y78oAngfBu+zZpB4CDxtXQvWu2obMDf0OPZ0/sjOQPNU4a79p2WXD4JRHIjM+EVVNAzv
         QJEgfUIVbqwm7Xo6/D7G9NH+2DpQ9D/6N68CtmO3aYl9Ajwp/1ZEZ2/36/ELMzC1ui2S
         qeXdswar+hDPcNT1/0NfTsdQB/T9UoV2KTYh7/GFzSxjRjfCG3KzqQwic2593YclqFwY
         B3Q3RwSqRA7y+0hy6zsdiXVqFS1MKOz9i9oniWpgVjHycPR/k9k3fc4bEaUaGXGz+Yxv
         BUqQ==
X-Gm-Message-State: AOJu0YxfWMijZ7+oDBQG5gt++D5gUw5F8hPU8DUSAt6XrtKmLfyt4mH+
	/bLfqzsuWnnh9uGr34BsyO4=
X-Google-Smtp-Source: AGHT+IEdr7xbSNR70+wGqTJtJ5GiKmEoHBsDLRokeEybNzgpCH2cmd9O0NEJ9/eTJCMX5IpFjjt+RQ==
X-Received: by 2002:a17:906:18:b0:9a1:c00e:60cb with SMTP id 24-20020a170906001800b009a1c00e60cbmr2376381eja.10.1694184203160;
        Fri, 08 Sep 2023 07:43:23 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-217-129-48.eu-west-1.compute.amazonaws.com. [54.217.129.48])
        by smtp.gmail.com with ESMTPSA id lz5-20020a170906fb0500b0098e78ff1a87sm1099436ejb.120.2023.09.08.07.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:43:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/3] arm64: patching: Add aarch64_insn_set()
Date: Fri,  8 Sep 2023 14:43:19 +0000
Message-Id: <20230908144320.2474-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908144320.2474-1-puranjay12@gmail.com>
References: <20230908144320.2474-1-puranjay12@gmail.com>
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

Implement aarch64_insn_set() which is similar to text_poke_set() of x86.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/include/asm/patching.h |  1 +
 arch/arm64/kernel/patching.c      | 40 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
index f78a0409cbdb..551933338739 100644
--- a/arch/arm64/include/asm/patching.h
+++ b/arch/arm64/include/asm/patching.h
@@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
 int aarch64_insn_write(void *addr, u32 insn);
 
 int aarch64_insn_write_literal_u64(void *addr, u64 val);
+int aarch64_insn_set(void *dst, const u32 insn, size_t len);
 void *aarch64_insn_copy(void *dst, const void *src, size_t len);
 
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 243d6ae8d2d8..63d9e0e77806 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -146,6 +146,46 @@ noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
 	return dst;
 }
 
+/**
+ * aarch64_insn_set - memset for RX memory regions.
+ * @dst: address to modify
+ * @c: value to set
+ * @len: length of memory region.
+ *
+ * Useful for JITs to fill regions of RX memory with illegal instructions.
+ */
+noinstr int aarch64_insn_set(void *dst, const u32 insn, size_t len)
+{
+	unsigned long flags;
+	size_t patched = 0;
+	size_t size;
+	void *waddr;
+	void *ptr;
+
+	/* A64 instructions must be word aligned */
+	if ((uintptr_t)dst & 0x3)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+
+	while (patched < len) {
+		ptr = dst + patched;
+		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
+			     len - patched);
+
+		waddr = patch_map(ptr, FIX_TEXT_POKE0);
+		memset32(waddr, insn, size / 4);
+		patch_unmap(FIX_TEXT_POKE0);
+
+		patched += size;
+	}
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+
+	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);
+
+	return 0;
+}
+
 int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 {
 	u32 *tp = addr;
-- 
2.40.1


