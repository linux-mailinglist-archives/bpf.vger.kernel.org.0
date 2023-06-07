Return-Path: <bpf+bounces-1986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBBD7259F0
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 11:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFBC1C20A71
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7689C9446;
	Wed,  7 Jun 2023 09:18:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4C9444
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 09:18:22 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7101BC2;
	Wed,  7 Jun 2023 02:18:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30e5b017176so240054f8f.1;
        Wed, 07 Jun 2023 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686129497; x=1688721497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lkLOrfbLwxQBuKCgg2v6eUJGy7ljmtUTJaDjGst/PI=;
        b=ioemZU0vs4s2VNh5psWt9NncrDXdRyMwFpmB2vQSg/pzC5pqoKTYpw0ulo18s7d9Gt
         M2mtR68XGo+5O++/vXHwI6YEVPmvH9rYSyijzzPdCy2lJj94RwE2OkLwooNLTurj+yhr
         twTFNtPW7z/sd/vYEslIi3NtEZvFyS78g/lI1WoYmbSzGPIQ9uABsxb1izO+iu01fx0q
         HmKFipQuLMvRMGILVBVaAts5rP8TjVpvjZJBcr8Jcbh/eEXCyWwuWRVrL2m/m5hoGSy8
         P5CEIJQX7iHkR09yz1E0kNxF8GiO1FxmkGxfPdw1wBONI8H54093CdH7dz3KCUNXF5+H
         eD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129497; x=1688721497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lkLOrfbLwxQBuKCgg2v6eUJGy7ljmtUTJaDjGst/PI=;
        b=KwfiIr5gz8C+hRtyQdo10UJPmBUlJioEUhH9uu1E8qQ47uUM8ybcLAuxRUCLBmlI5p
         OrKT6Oq4e5sBLrlS/eImdEn6gmvRBGiKFdDJvhAZCv/pfxS3lNZKOUsY6SLw7zEljy0m
         JYEdktK94/vVwfDVNcWNof0IJLUX1NtMLcwOA84EYyTAkwGcHIRrsXXm7Fkce3/LqRBF
         pUAgcORz8IyUeGoHSjB2x3u4Npe5d4u22phy88K/yq19mTS07WSUKXsVmbpJa2NTUmGN
         bTnIkciZcYioafOfKVcZJZoDkXJzzy4zLJDUlkHlFlDAQd8UKR69ev6YGULOqErMFLUl
         nEhQ==
X-Gm-Message-State: AC+VfDwr9+mG0xLLMwV7vLvXBh2Xa3tytbsufVdHR1t7XtcOBt4sj/Iu
	aMcOxRYtE0Mla53UL/FzqBo=
X-Google-Smtp-Source: ACHHUZ5EnXF/NBVW4zZT1KeJPuaUv9qX/SlLTHEQB20HcWrVNWCm2ugTxoJhyB24jDt8yZY9pGDAxw==
X-Received: by 2002:a5d:614b:0:b0:306:2b40:1258 with SMTP id y11-20020a5d614b000000b003062b401258mr3249305wrt.21.1686129496853;
        Wed, 07 Jun 2023 02:18:16 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-54-74-169-43.eu-west-1.compute.amazonaws.com. [54.74.169.43])
        by smtp.gmail.com with ESMTPSA id cx14-20020a056000092e00b003078681a1e8sm15141958wrb.54.2023.06.07.02.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:18:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/3] arm64: patching: Add aarch64_insn_copy()
Date: Wed,  7 Jun 2023 09:18:13 +0000
Message-Id: <20230607091814.46080-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607091814.46080-1-puranjay12@gmail.com>
References: <20230607091814.46080-1-puranjay12@gmail.com>
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
2.39.2


