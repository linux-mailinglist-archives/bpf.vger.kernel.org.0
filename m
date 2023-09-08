Return-Path: <bpf+bounces-9511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02CB798911
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03181C20EA2
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8BC6AA4;
	Fri,  8 Sep 2023 14:43:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB865231
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 14:43:25 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C11FC0;
	Fri,  8 Sep 2023 07:43:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so261528066b.2;
        Fri, 08 Sep 2023 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694184202; x=1694789002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1QyEsWglzsKtSFRl6GqbG8YUnWZHW9/8Dm/6UtUzbY=;
        b=sX2b1lqvasFf4+rivGpfZS1wT+EO4lBhbJQJzyp6SHlIn3kJ+qLhgmfhcW4bip+21a
         xbvJuWWAqg9G3wBX+/FlQt5gQN8pHQdObsEx+9RYSV3U55uTjUKEQiGdj8KoeeNmSS8H
         Ib/w/5Ixy6r52Ld/TFatCRwuZgPbeJEopWGNJDikljvMLzDAJzZURRsz6i3lQm4KpmV3
         sNoliNSKMfvK70aWiJSSAKWaW1lDGb0aj2f0Gm31l10l/bi9TpjRQuoCNEH5kgY+v5Aw
         uIU7S6f01YtSeJNSFTD7xaAFN1rb6AHycjUvG5nhuh5f6Nd8aCqP6TK2oGRT8mwUnuF+
         5+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694184202; x=1694789002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1QyEsWglzsKtSFRl6GqbG8YUnWZHW9/8Dm/6UtUzbY=;
        b=UH1AnObqD6oz1LImZWiX1TfwwBGVwHIs2vw8IvFWSQW95Y6CUVNzaTafR+5Q1xJ4ob
         q+OWZMI5ACcc6r3+qUDBRaAB3ZT8pOQIhrxKw2RldeKXcPpaAFPTOnPDA4xpHBs1w3DC
         5jD5NqMRp8+k4+kHdYJgOTK+GbvXjDGhNd9sUFfWsdJlc0Np+3THlhfm6QPlQKEIrQUa
         D6NcMhTRRcVieUaFQ9gZGB+QDYZf6u9FezBFGblSYIg/NG048ZmDkVnyD7BlpbUaylwl
         1siVfe4Zfw6SbPVWwnqnaLHblzzF+FWwzhZVtzsk364BwZUccqdHN15fEdC+ES1l63gz
         De1Q==
X-Gm-Message-State: AOJu0YxXdVkl2YoPVGBRx+S1OesY++sBgrabtapK9pTphrpiKEMt8KJK
	sXcZa0GS5/quvt5LqtoprYcWglwvOfY5x14YHaiHSQ==
X-Google-Smtp-Source: AGHT+IEzWM9tlE4k/vQsSnrED1cgEwDPDtRDd6Z3U7kUSH/qSX4ARaU+ud4z+lvVsM+ZaPaKPvKraQ==
X-Received: by 2002:a17:907:7759:b0:9a9:e393:8bcd with SMTP id kx25-20020a170907775900b009a9e3938bcdmr1942854ejc.5.1694184202216;
        Fri, 08 Sep 2023 07:43:22 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-217-129-48.eu-west-1.compute.amazonaws.com. [54.217.129.48])
        by smtp.gmail.com with ESMTPSA id lz5-20020a170906fb0500b0098e78ff1a87sm1099436ejb.120.2023.09.08.07.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:43:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/3] arm64: patching: Add aarch64_insn_copy()
Date: Fri,  8 Sep 2023 14:43:18 +0000
Message-Id: <20230908144320.2474-2-puranjay12@gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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
 arch/arm64/include/asm/patching.h |  1 +
 arch/arm64/kernel/patching.c      | 41 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index b4835f6d594b..243d6ae8d2d8 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -105,6 +105,47 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
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
+	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);
+
+	return dst;
+}
+
 int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 {
 	u32 *tp = addr;
-- 
2.40.1


