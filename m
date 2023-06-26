Return-Path: <bpf+bounces-3423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7035373DA9E
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 10:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E121C2083C
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7436ABF;
	Mon, 26 Jun 2023 08:58:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7256AB1
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 08:58:17 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA1310C2;
	Mon, 26 Jun 2023 01:58:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3113dabc549so4588605f8f.1;
        Mon, 26 Jun 2023 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687769894; x=1690361894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g89tOe+fXjd3eCewwiEMcP/rgT7hBlO+AcyleoZQ3c4=;
        b=KY0lFmAyiGPNFi5tejVkCcdML67r0m78mXYhfhaNGCExzjzcs4nhYQIlel/8BYJRpz
         lfJONMAVjcHCJoBzkI699nWEtuBaxhq4kUnUzVfCp05RtNkxj/MNfRMmkwqF2dGcptlp
         K7WCs3Dpzq03D6B5J1Y+pYbq7jphYR0ctaBFILc+EgjFpGk/2jYY0JVpw6Mojp+pnkHF
         oXn0DUAwYrCVOM+Sv4+yZGrcQ6/BdpbMGLHoG/hTWFRe9VdFj+XLKbB9kG5C0ozms0N4
         L68Qd5rzZyyhPK6dC5WoUSjRvBj0BM37fSNgn8FGG5KJ0b6VIQDBl++oMAAX7fhemqfZ
         7+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687769894; x=1690361894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g89tOe+fXjd3eCewwiEMcP/rgT7hBlO+AcyleoZQ3c4=;
        b=XDoxSozuqgkdTcfrj7Ka/9+BcAvwdJ3d5/1jJaKbni0JDFfH+HXRo2KCoYbqaRyPQh
         KXwK3LeswYnNcAk+VxtEgxk1ppC4YMJp0qkgrUfuG88TyVTFUIXUp5f5/6r/6x4jYHZV
         2j6CWIxddU8LmzVMJpvqdJf95XAxTqQtKgVLix0i5es0FLRpgP3ef/hm4Li3etOmlpaO
         jgkzXylx4tCHu0bpEinpl2vPAOdrQ1wCuP4AygnvFtWjqUXnY4GiinsvoFUMNRyHlNdW
         sHQEc7RzNBwy8eH4AZ9uSEuSDgw+9YP6OIof+WZGxd/rYFnQYPRbArW+F5KctZ/keQhu
         3Qug==
X-Gm-Message-State: AC+VfDyIB4U66qL/3M/etS114rXIhgLMsQ65ZPo4gcvL/kFIF0Uv3/yv
	2h+MIUZiXnp7n3OkAQpw92E=
X-Google-Smtp-Source: ACHHUZ4m62deog5lFK8+0lA0KYE/r/VTwsXj5L2YGdFLyxwDG7jb6AmJwJCCJu5KOCig62//DhK1dw==
X-Received: by 2002:a05:6000:1004:b0:30a:dd26:63cd with SMTP id a4-20020a056000100400b0030add2663cdmr33892488wrx.5.1687769894028;
        Mon, 26 Jun 2023 01:58:14 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-34-242-96-229.eu-west-1.compute.amazonaws.com. [34.242.96.229])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b00313e8dc7facsm4883533wrt.116.2023.06.26.01.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 01:58:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/3] arm64: patching: Add aarch64_insn_copy()
Date: Mon, 26 Jun 2023 08:58:10 +0000
Message-Id: <20230626085811.3192402-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230626085811.3192402-1-puranjay12@gmail.com>
References: <20230626085811.3192402-1-puranjay12@gmail.com>
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
Changes in v3 => v4
- No changes

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


