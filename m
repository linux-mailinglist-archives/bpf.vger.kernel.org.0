Return-Path: <bpf+bounces-8476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBD787047
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 15:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7CF1C20E32
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5332890B;
	Thu, 24 Aug 2023 13:31:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AE4288E6
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 13:31:41 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A5D19A5;
	Thu, 24 Aug 2023 06:31:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso3094275f8f.1;
        Thu, 24 Aug 2023 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692883898; x=1693488698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOjnMoCdk8ero0eIWnTRV8IDjWokCkOdT233dw8f8cM=;
        b=iMnUSfI2+Q9SIs1K6hZhMo+Arr01ZqvJxwD3uxjGKTxs2C3mOEX8zTkSa/iw1/ea+A
         1obGFCB1YEh4uU1B9tgX84lYcb0Efl5eHke1ZttpwSWnkzqrkRoI8QXmaqnlazK0TD5+
         9tsnxUjQJNkcnAO60l48rHELcsLqQKRjrtwVMkLHZFhD3Fsa/mrCPT4+o+K9IrXPhiaG
         sYLcigRuUCUk0huxgn6LcK5vsuf1FNxZqb/70GapWKjid2DGaXJagHrHYax7v/q3dpy1
         5uX+gS81yYp8mQKkfYi+eMqRjrxMSLuHa0Vdk/52tySindL0WVTzzrxO7oz8N0y0DGq0
         OKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883898; x=1693488698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOjnMoCdk8ero0eIWnTRV8IDjWokCkOdT233dw8f8cM=;
        b=KO35PbABhT8Cxpr45wwdSlZAnxIVJzW/qBfd6OPzxNVkMDORIbf88l+obGdGbCQnNN
         fn6daZM1EqysyLdTU8EQd+NdSISnBFEGYJP7bBDvF/1WJP25S2OdssMU7sdynaDtNSfp
         I5JPARHuh/iCTs0eh8VGi0PrL0h4eCEhatAOaR5/P4jUJSIlvNfxPIT2n0xH7VjByWLR
         fg53b9mx9RKCP9trsEZWViO8D2qydI0oTUALlhzPHnpRKzNhSbxcXA+9Q2Tbc3tw/Swd
         Jkp915WfofUMs0rq3ilF1S6jptKLUbqOxUc9atAWsciFAhc5wv/5k7RMUIbSVY+GUf4M
         W9tA==
X-Gm-Message-State: AOJu0YwS/yezglvDbNw9iSAMBWn3tQikdxMIft2DnpuAAnbJNvFc1w8J
	ESuHCoQOyLLiO1kWd9GqRvU=
X-Google-Smtp-Source: AGHT+IGYrNSHQo0VfFl5CRfj3Gtb5eiirSq1QGjvtMJU8Gr4wK3Ak9RlHQPqQpRwwQlFkga9ww4Lcg==
X-Received: by 2002:a5d:62cf:0:b0:319:79a9:4d9e with SMTP id o15-20020a5d62cf000000b0031979a94d9emr11901798wrv.44.1692883898481;
        Thu, 24 Aug 2023 06:31:38 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d548b000000b00317e77106dbsm22396112wrv.48.2023.08.24.06.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:31:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/3] riscv: extend patch_text_nosync() for multiple pages
Date: Thu, 24 Aug 2023 13:31:33 +0000
Message-Id: <20230824133135.1176709-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230824133135.1176709-1-puranjay12@gmail.com>
References: <20230824133135.1176709-1-puranjay12@gmail.com>
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

The patch_insn_write() function currently doesn't work for multiple
pages of instructions, therefore patch_text_nosync() will fail with a
page fault if called with lengths spanning multiple pages.

This commit extends the patch_insn_write() function to support multiple
pages by copying at max 2 pages at a time in a loop. This implementation
is similar to text_poke_copy() function of x86.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/kernel/patch.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 575e71d6c8ae..465b2eebbc37 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -53,12 +53,18 @@ static void patch_unmap(int fixmap)
 }
 NOKPROBE_SYMBOL(patch_unmap);
 
-static int patch_insn_write(void *addr, const void *insn, size_t len)
+static int __patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	void *waddr = addr;
 	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
 	int ret;
 
+	/*
+	 * Only two pages can be mapped at a time for writing.
+	 */
+	if (len > 2 * PAGE_SIZE)
+		return -EINVAL;
+
 	/*
 	 * Before reaching here, it was expected to lock the text_mutex
 	 * already, so we don't need to give another lock here and could
@@ -74,7 +80,7 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 		lockdep_assert_held(&text_mutex);
 
 	if (across_pages)
-		patch_map(addr + len, FIX_TEXT_POKE1);
+		patch_map(addr + PAGE_SIZE, FIX_TEXT_POKE1);
 
 	waddr = patch_map(addr, FIX_TEXT_POKE0);
 
@@ -87,15 +93,38 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 
 	return ret;
 }
-NOKPROBE_SYMBOL(patch_insn_write);
+NOKPROBE_SYMBOL(__patch_insn_write);
 #else
-static int patch_insn_write(void *addr, const void *insn, size_t len)
+static int __patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	return copy_to_kernel_nofault(addr, insn, len);
 }
-NOKPROBE_SYMBOL(patch_insn_write);
+NOKPROBE_SYMBOL(__patch_insn_write);
 #endif /* CONFIG_MMU */
 
+static int patch_insn_write(void *addr, const void *insn, size_t len)
+{
+	size_t patched = 0;
+	size_t size;
+	int ret = 0;
+
+	/*
+	 * Copy the instructions to the destination address, two pages at a time
+	 * because __patch_insn_write() can only handle len <= 2 * PAGE_SIZE.
+	 */
+	while (patched < len && !ret) {
+		size = min_t(size_t,
+			     PAGE_SIZE * 2 - offset_in_page(addr + patched),
+			     len - patched);
+		ret = __patch_insn_write(addr + patched, insn + patched, size);
+
+		patched += size;
+	}
+
+	return ret;
+}
+NOKPROBE_SYMBOL(patch_insn_write);
+
 int patch_text_nosync(void *addr, const void *insns, size_t len)
 {
 	u32 *tp = addr;
-- 
2.39.2


