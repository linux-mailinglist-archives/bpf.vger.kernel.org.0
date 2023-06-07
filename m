Return-Path: <bpf+bounces-1984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9B7259EC
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 11:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132321C20D18
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D65A8F7A;
	Wed,  7 Jun 2023 09:18:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504C8F47
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 09:18:21 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B9E19BD;
	Wed,  7 Jun 2023 02:18:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3063433fa66so6000915f8f.3;
        Wed, 07 Jun 2023 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686129496; x=1688721496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6Uppj2L6gcNwq0WUQbsPWgkus8exJN5v10BeGre/uY=;
        b=LkdeFZV14HqmY7jjdKucV4Ug1wKVdn6BKJ6VT2TsWcNkAzbMV/4uVxeur1uXrcccZA
         p4R+hxApHksn6Sl7gS6C7xyGa37wg+Va7LWIXh3c2U2GNY3TQaf+448yIXMxuzPi6x7a
         x8erRK9jXNL5MfSZP/R6In7v92OY9c8xRIQY6zMyBITN0fvmrhn25qKSLhpsIvWwXNVc
         h2kR4lLpvYixrEC6AeQxSG5KbFXFBNiNJa1tscBtEv92Re4YtFoX6QwTBC7zzqq1lNDb
         dlK6YMd8F0y3YaKtA/uVot3nFlrDnoKJosfd66W4/dkNHzPJv0y7wk4Fcs45/ttcRnCu
         PuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129496; x=1688721496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6Uppj2L6gcNwq0WUQbsPWgkus8exJN5v10BeGre/uY=;
        b=LVJLr4ZrTm5Fbm0qCqlHk7jtcUo7VARKiHeVH2CmcJxHLXXnRLlalpk7Tm8dD++45C
         f/ScAWhAGzg1cS9q684nWj0YlSpVJTSPRDCej7Qrp9kPeQrtE9U/5gRvKIuysI8NXjP2
         fOFCinZ6YrEO9lLUGqLDLwyyC/Gls1d7LoeqVk99j6Ld8zOeVc8cRi4dKsucbCkVdY9g
         YTsKcwIwEbkVw/iZQvumrDf1xDsdR6eGpBfWG6poaM10t212f19ZiklVarKUsIA6pgia
         mPe8zSQhZRghpUphsXOS4dTPdOFJo6Kfo+NxzRnTY6etKspD1Q3mxuQXUHt2iqeynnbk
         c0lw==
X-Gm-Message-State: AC+VfDwPIYQwOiOZAlxQDhHZRel0LAhofiFYCO/mjkR0+L7UjBNSbi6n
	XnqoIhVLtDo0i0dx5EAJR/k=
X-Google-Smtp-Source: ACHHUZ6fWYdp7Lua7CKdp+yQFwnOkFtOA2YLDXvuvLbB9rpyF1l73XYHBMSPmnzPLur7GbEFH44EhA==
X-Received: by 2002:a05:6000:12c4:b0:306:2d15:fc35 with SMTP id l4-20020a05600012c400b003062d15fc35mr4048090wrx.37.1686129496225;
        Wed, 07 Jun 2023 02:18:16 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-54-74-169-43.eu-west-1.compute.amazonaws.com. [54.74.169.43])
        by smtp.gmail.com with ESMTPSA id cx14-20020a056000092e00b003078681a1e8sm15141958wrb.54.2023.06.07.02.18.15
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
Subject: [PATCH bpf-next v2 1/3] bpf: make bpf_prog_pack allocator portable
Date: Wed,  7 Jun 2023 09:18:12 +0000
Message-Id: <20230607091814.46080-2-puranjay12@gmail.com>
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

The bpf_prog_pack allocator currently uses module_alloc() and
module_memfree() to allocate and free memory. This is not portable
because different architectures use different methods for allocating
memory for BPF programs. Like ARM64 uses vmalloc()/vfree().

Use bpf_jit_alloc_exec() and bpf_jit_free_exec() for memory management
in bpf_prog_pack allocator. Other architectures can override these with
their implementation and will be able to use bpf_prog_pack directly.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Acked-by: Song Liu <song@kernel.org>
---
Changes in v1 => v2:
- No code changes.
- Added Acked-by: Song Liu <song@kernel.org>

 kernel/bpf/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7421487422d4..2bc9092bf9be 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -860,7 +860,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 		       GFP_KERNEL);
 	if (!pack)
 		return NULL;
-	pack->ptr = module_alloc(BPF_PROG_PACK_SIZE);
+	pack->ptr = bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
 	if (!pack->ptr) {
 		kfree(pack);
 		return NULL;
@@ -884,7 +884,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	mutex_lock(&pack_mutex);
 	if (size > BPF_PROG_PACK_SIZE) {
 		size = round_up(size, PAGE_SIZE);
-		ptr = module_alloc(size);
+		ptr = bpf_jit_alloc_exec(size);
 		if (ptr) {
 			bpf_fill_ill_insns(ptr, size);
 			set_vm_flush_reset_perms(ptr);
@@ -922,7 +922,7 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 
 	mutex_lock(&pack_mutex);
 	if (hdr->size > BPF_PROG_PACK_SIZE) {
-		module_memfree(hdr);
+		bpf_jit_free_exec(hdr);
 		goto out;
 	}
 
@@ -946,7 +946,7 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
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


