Return-Path: <bpf+bounces-9058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E995A78EE3A
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43602814DD
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416461171C;
	Thu, 31 Aug 2023 13:12:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA911713
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 13:12:35 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABE0BC;
	Thu, 31 Aug 2023 06:12:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so621541f8f.0;
        Thu, 31 Aug 2023 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693487552; x=1694092352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vw9aCO6QF7ehSGg3eSofLWFhJ8EHSCsmR6IG4YjeGA0=;
        b=eR0/AQcSqjr4CcKO192YlS1cYVIwnqbPfEE0ge7bwNI902wNHfCZrgs7wX1nX0ihKj
         Gkr0/EwZ9UB3jeZ9rGQnTjbKe08PiR8XAPjOKTaHaYdqzOl3O5ne3bDEfWIpzlu0MGV1
         KpOIHXScxF5azzHwjrSqyXSO6CKc47hvpw1SpdH63irucztblg/xaZQyYlJ3qxR8T5Xu
         YmLru+/aR1S6VAZvpo7lzvwnQ1kVrgXpgMEi5UzbZMOnEJk7plnUwIVWULKbnxeDX0Zr
         j9yrfexA/eaf+XcIrKjDgkh1DWQjhiiA6lOrCc+/7FASiqWB2jI2trK/m1s1Q3Jmv8Ad
         MbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487552; x=1694092352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vw9aCO6QF7ehSGg3eSofLWFhJ8EHSCsmR6IG4YjeGA0=;
        b=JV4fybsNq3aky03qRdtO7KmSGbrarZZMuWR6S9nW1ruQpf0qfnYQcUpxZ3ThF3saTM
         WAVidU+B0a2piQvsosbOGjX1vEZEnYnW3bWxIjmVbQBpx0pUFTxAwK5O/GLO5wd1qOE8
         pkmRsQBqwiJd9c7Zatvh7BGMDbATeshV81u+oNWrKgYvHJWJqwe5Y2sRwe+aGr3UhbL+
         zziY+HCHiWnuAFJam4WhOs3iVzyv6muVKyty59KOTutTXRIkZJD0enVS0az1eqxBnsQp
         jOJdSRLVX3VxWaCmpw8TPvaPEcgvU3PwtX06wl+GygnFnbbxvvLcqc1sPLQnJCrnnHYr
         2UYQ==
X-Gm-Message-State: AOJu0YxcR/R1WHqqn2MdZnVqCr9yG8UFthfNOWai/pL4+tELkRIvmaR+
	aVfSGvr4pjQvEPPQ8sP7Zuc=
X-Google-Smtp-Source: AGHT+IEV1nZTWVMPYeNOWwrZQScu0+JsXp36Y/oH9nCnr88bGLZYxfwLclYlSX63KCt8UHKIEmHBIA==
X-Received: by 2002:adf:e54f:0:b0:319:82c9:8e7d with SMTP id z15-20020adfe54f000000b0031982c98e7dmr3698994wrm.31.1693487551537;
        Thu, 31 Aug 2023 06:12:31 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id a28-20020a5d457c000000b00317f70240afsm2206607wrc.27.2023.08.31.06.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:12:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/4] bpf: make bpf_prog_pack allocator portable
Date: Thu, 31 Aug 2023 13:12:26 +0000
Message-Id: <20230831131229.497941-2-puranjay12@gmail.com>
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

The bpf_prog_pack allocator currently uses module_alloc() and
module_memfree() to allocate and free memory. This is not portable
because different architectures use different methods for allocating
memory for BPF programs. Like ARM64 and riscv use vmalloc()/vfree().

Use bpf_jit_alloc_exec() and bpf_jit_free_exec() for memory management
in bpf_prog_pack allocator. Other architectures can override these with
their implementation and will be able to use bpf_prog_pack directly.

On architectures that don't override bpf_jit_alloc/free_exec() this is
basically a NOP.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 kernel/bpf/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0f8f036d8bd1..4e3ce0542e31 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -870,7 +870,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 		       GFP_KERNEL);
 	if (!pack)
 		return NULL;
-	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
+	pack->ptr = bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
 	if (!pack->ptr) {
 		kfree(pack);
 		return NULL;
@@ -894,7 +894,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	mutex_lock(&pack_mutex);
 	if (size > BPF_PROG_PACK_SIZE) {
 		size = round_up(size, PAGE_SIZE);
-		ptr = module_alloc(size);
+		ptr = bpf_jit_alloc_exec(size);
 		if (ptr) {
 			bpf_fill_ill_insns(ptr, size);
 			set_vm_flush_reset_perms(ptr);
@@ -932,7 +932,7 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 
 	mutex_lock(&pack_mutex);
 	if (hdr->size > BPF_PROG_PACK_SIZE) {
-		module_memfree(hdr);
+		bpf_jit_free_exec(hdr);
 		goto out;
 	}
 
@@ -956,7 +956,7 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
 		list_del(&pack->list);
-		module_memfree(pack->ptr);
+		bpf_jit_free_exec(pack->ptr);
 		kfree(pack);
 	}
 out:
-- 
2.39.2


