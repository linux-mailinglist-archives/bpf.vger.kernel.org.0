Return-Path: <bpf+bounces-9059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160778EE3E
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25CB1C20971
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9344C11723;
	Thu, 31 Aug 2023 13:12:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549431171F
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 13:12:36 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C3CF3;
	Thu, 31 Aug 2023 06:12:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31dcd553fecso601618f8f.2;
        Thu, 31 Aug 2023 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693487553; x=1694092353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUYKChQYfJZZ8DPO0whW/zno6UWIarXDmyfOm92F8UA=;
        b=a7wmDT2IFZ4JxeJqW+YCZF2To/S86kH44zxt34Q3m9QEbpSnrpUZoAxE/Dq2G8V+Ur
         5xg01mJoc1HNha4xDw+ORjDcLaU0AcPnilvE55Qj26feD6CoYTH8juquKfntWhMLdBS3
         e+gIzy2pV4jKo+BSS/NNWnZo1G1yAmUr/G04maCjHWO9DRbaLGRCyGDSntpEjy+JkGdw
         ilj6/o8mtLyf5Wv2MnmOpkceenZEtZlbk06nYAqc1+GgKfvnxWRtlQY7yeUyyD6W3OEK
         gI9hzLMYdcCyCGCEtO9HZX3Xl5CK4K5sKzkes7PfJdmyjUCHxBSu0t+Ve3/nKkxMPWhc
         roaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487553; x=1694092353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUYKChQYfJZZ8DPO0whW/zno6UWIarXDmyfOm92F8UA=;
        b=cy4jqglSPXEJaQqnjifgcudOTy5p9SMssWaOwVZyz+fWnXmewqo8b1kMMttAjEJI20
         ijXCZmKvKpxuR36W941BcLPruRm9sJuVsEN/5vRxfmbZEeagOV3Fee8+DC7doT+hm8ej
         Shv5DmmfArJT3q/EKxKlMjnejkHV7DKBOCynQUOWjGaGXJdVZ1AWFBgkDpk9C8IrfKTq
         dK5+oRET4kfhAzGmn89+cZRwVwfGoi+6wNAVTtGZKcqrhyMG41EHkHsQYgAB5w/9FNa/
         XJKtAVeyLj8+cRgB/QVbQA3gjfHfrXti142VrZNpgTtb+cjBWVNr0eC2FSDc0x58EVMt
         KLdw==
X-Gm-Message-State: AOJu0YyzMnVPt3BTcADM/J+qcYbe/8jXlu0MPZrF1K5T/leGf1T0I6EP
	JVdausnrt8jSubvB1iXq9l0=
X-Google-Smtp-Source: AGHT+IEmRLcQA4Zh4qOEOVWO+OJdUOgzn5p2uNiV+/qiisIBP67acZzJXuCuSC/kJMqcbfCWT7qEVg==
X-Received: by 2002:a5d:668f:0:b0:317:6a7c:6e07 with SMTP id l15-20020a5d668f000000b003176a7c6e07mr3756142wru.32.1693487553087;
        Thu, 31 Aug 2023 06:12:33 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id a28-20020a5d457c000000b00317f70240afsm2206607wrc.27.2023.08.31.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:12:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/4] riscv: extend patch_text_nosync() for multiple pages
Date: Thu, 31 Aug 2023 13:12:27 +0000
Message-Id: <20230831131229.497941-3-puranjay12@gmail.com>
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

The patch_insn_write() function currently doesn't work for multiple pages
of instructions, therefore patch_text_nosync() will fail with a page fault
if called with lengths spanning multiple pages.

This commit extends the patch_insn_write() function to support multiple
pages by copying at max 2 pages at a time in a loop. This implementation
is similar to text_poke_copy() function of x86.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
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
2.39.2


