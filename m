Return-Path: <bpf+bounces-8858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B578B5BD
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 19:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531C2280E3C
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3213AEE;
	Mon, 28 Aug 2023 17:00:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48013ADC
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:00:04 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6EEB8;
	Mon, 28 Aug 2023 10:00:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so23751975e9.3;
        Mon, 28 Aug 2023 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693242000; x=1693846800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8P7/Zkeac2PFc5cssTAi6ZYqGhNKmBRPTm9VR7EbbnQ=;
        b=k5b70U+ZUANzv/IDScpVmw3R2qaefcllK7WC8Nha9UpJvpdmbkS5pfzSapqRgPxfZo
         T9p177CuHrWQGR9yj5JGvAYv9zaYYH+05pfrcKjjwtHPb/eqXq5rOLWjgu6fwHagd7l7
         FwjMFX0biUYYB0LBJ/b/uvxG2jr+aFTe4MRBAeYHxcMeFsS/K7JZFkMCfDC2pYTF5UxV
         pmjptilC7+XLgYiVah62rVoqBxlNacLZEW/uFl2r++7kaQHKRqhmc+ZEXZ4/MgJadxiN
         SlZ9UxZ9lxzgzzjyg9R/9TyQNSNtqidAvkopPpQP3cU0w3DGRhIopD+MbMFu1DdfXQkN
         trUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242000; x=1693846800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8P7/Zkeac2PFc5cssTAi6ZYqGhNKmBRPTm9VR7EbbnQ=;
        b=lXd2R5KkJRDF2EB9bkzDUCROGllZKlIbxOGqnXcInE7Sqm1sDl4uAyAfDjnvmPEjVT
         CcfE4zOBKOFVBBISVYabOrzhEJo9Tz615DjIl/FoqURBLgaZ7az6ZEDRt4P9FTCk2Cpu
         W6oSnKS/q6Al1P1hVYZl5Sftxixos8vZNq8hgLSE/gJX+1NfCdvkzDoZaq3l0CYyzDmL
         mXTYmd0PgOOx67kr1Baxh4dg5qaLXBAyFCG++QXoe3uBgcwdLcymrpBp6ly1iLY+/kLT
         NfIQVEH5sipPptn+blUmTPe2+FRqg8IjhfTa/eYcWgX/JO3MaKn0oAALtiuEoadpxu7G
         iRfg==
X-Gm-Message-State: AOJu0YydY0EUTb27PFt25DuKMEXt5DiVzRHFuZlkFiplWiJFowo7tl56
	LP4LGHWYLeqABM21tCgp0CyANCGRq5TOOekCwUM=
X-Google-Smtp-Source: AGHT+IHEmWlVZTHQ0UdjiaiuoDBvpVXt9N2cIoSQkZkdFqsjMRcSrFBXHhd6HB1m2RxLs3sY30C9cg==
X-Received: by 2002:a1c:f304:0:b0:3fc:60:7dbf with SMTP id q4-20020a1cf304000000b003fc00607dbfmr20878500wmq.41.1693241999647;
        Mon, 28 Aug 2023 09:59:59 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b0031ad5fb5a0fsm11033613wrx.58.2023.08.28.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 09:59:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/3] riscv: extend patch_text_nosync() for multiple pages
Date: Mon, 28 Aug 2023 16:59:56 +0000
Message-Id: <20230828165958.1714079-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828165958.1714079-1-puranjay12@gmail.com>
References: <20230828165958.1714079-1-puranjay12@gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patch_insn_write() function currently doesn't work for multiple pages
of instructions, therefore patch_text_nosync() will fail with a page fault
if called with lengths spanning multiple pages.

This commit extends the patch_insn_write() function to support multiple
pages by copying at max 2 pages at a time in a loop. This implementation
is similar to text_poke_copy() function of x86.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/kernel/patch.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 575e71d6c8ae..2c97e246f4dc 100644
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
+	if (len + offset_in_page(addr) > 2 * PAGE_SIZE)
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
 
@@ -87,15 +93,36 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 
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
+		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched), len - patched);
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
2.40.1


