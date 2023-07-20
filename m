Return-Path: <bpf+bounces-5492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1475B36E
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B564281E71
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A58618C2D;
	Thu, 20 Jul 2023 15:49:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF318C22
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:49:47 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB676135;
	Thu, 20 Jul 2023 08:49:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso8171075e9.2;
        Thu, 20 Jul 2023 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689868183; x=1690472983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TdRmj0UkAm5gPWjI6OLYQN5hjGdtS3ZVtVx8EMYM4Y=;
        b=F7yWBNeaU2+/3BBqgAuECm5xIe9Z49EL2iGWNoPjMiiSOa6u+saOFkPGbnxYdlUe8J
         Hu7XI/oX+2x/xn/pyzs/tvziKsRDPzA1cWMqNj+jvEMxUec5OXy72zcN6UNx893UAPKb
         fdNU/3kjaN/aa401cgeZxLYyUfa1QkkTSOL6j7JnazSTAYDjlAsR4e9Bx0ubQ6t5zU2F
         kIAOeLUBfuoVOJaAWI5hkY8H90OjfbjdRi9NwqDkFrxHYe6dQR3Jj607PDh4Og/o2LbE
         lp1q3TIbOpdzUHzO4e3DphgNIGi4F4CXjEO3oZAvRDLDNlStHvyCijkV9MVIj6e4ilv0
         Q8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868183; x=1690472983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TdRmj0UkAm5gPWjI6OLYQN5hjGdtS3ZVtVx8EMYM4Y=;
        b=Gj6kfTi9V2etMnhrflMKH7LxcIDtdbHZtI+8Bk5mB9DCzK67A5hzlnB0NQL86sJD7n
         URYYRdXcfHcEG1X9K5mCMzsmtYPyuyaTd+gIk+GyzEEQ9ZdA4HR7Mx15mZRwndxnj0YL
         aa4hrJtVw+ydrrjgOCCAQtDWYWIl2CT+hvrSxt7DaH/Uc/jqkgC4Ao2kh0jAevlj/OZf
         ifBNs/Wpjizml1p8Fl/LJ6SzHo/JqIMe2hwlsmXHizx0jiphd7E4XEW6HwzSoynKI+pz
         Ut9rJkVk+ULawAkv9uU4G9UmNyEiUzu6q4AEBLtvE4K51P+FreevFmEg95vVK2Ki30//
         yaCA==
X-Gm-Message-State: ABy/qLbN1Ezcqp6XsUK9Z2w6fQ7SS+gASJ7EkrjPp30fYe6qveY3fELl
	r4f4FJshCrm3QZUqZDtUC7U=
X-Google-Smtp-Source: APBJJlEuXMI5sektNSXxZZSfzFEf8zfF8nebOdPeEXqLNDX8t0fvGqMk9j5hKGKR3pU29ru33nGvrw==
X-Received: by 2002:a05:600c:3647:b0:3f9:8c3:6805 with SMTP id y7-20020a05600c364700b003f908c36805mr4563818wmq.7.1689868183273;
        Thu, 20 Jul 2023 08:49:43 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-34-244-51-157.eu-west-1.compute.amazonaws.com. [34.244.51.157])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b003fbdd9c72aasm1471021wmm.21.2023.07.20.08.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:49:43 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] riscv: Extend patch_text_nosync() for multiple pages
Date: Thu, 20 Jul 2023 15:49:40 +0000
Message-Id: <20230720154941.1504-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720154941.1504-1-puranjay12@gmail.com>
References: <20230720154941.1504-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patch_insn_write() function currently doesn't work for multiple
pages of instructions, therefore patch_text_nosync() will fail with a
page fault if called with lengths spanning multiple pages.

This commit extends the patch_insn_write() function to support multiple
pages by copying at max 2 pages at a time in a loop. This implementation
is similar to text_poke_copy() function of x86.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/kernel/patch.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 575e71d6c8ae..b2dbfcfdef85 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -53,7 +53,7 @@ static void patch_unmap(int fixmap)
 }
 NOKPROBE_SYMBOL(patch_unmap);
 
-static int patch_insn_write(void *addr, const void *insn, size_t len)
+static int __patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	void *waddr = addr;
 	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
@@ -74,7 +74,7 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 		lockdep_assert_held(&text_mutex);
 
 	if (across_pages)
-		patch_map(addr + len, FIX_TEXT_POKE1);
+		patch_map(addr + PAGE_SIZE, FIX_TEXT_POKE1);
 
 	waddr = patch_map(addr, FIX_TEXT_POKE0);
 
@@ -87,15 +87,34 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 
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
2.40.1


