Return-Path: <bpf+bounces-1796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C025721FD0
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 09:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2761C20ABF
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010F11CB6;
	Mon,  5 Jun 2023 07:40:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990F11CA1
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 07:40:30 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B79DCD;
	Mon,  5 Jun 2023 00:40:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30c5e5226bdso2755512f8f.2;
        Mon, 05 Jun 2023 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685950826; x=1688542826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pHD5vwavBvGsj8sNf9HQSglXSh8RHVyAD0WLni3C3s=;
        b=bu/NBxKUkF9CtjVI3uj8QZ1QwcCrIKeKY/dligJ87i9pSlv0nvmonF8zPHIXLwSpEk
         OYfpRhP0PUx2rSrf+PRN+XTnycoZzlGUkdnFDnmo90xU3LLRfp0K4AaJYxyKdiMNn51t
         UrkosQlFVB1IhXcanqQXDBfBylBmut/9yIpxUkiHZN8d9k9tQ1/IQrqiL9Iw/Vvja9xk
         /O/G4CBFAbkYM73sXL1ercfyUatJKHQ136/R464/dbRsHlEtIXJUiAKbtvVF3cCiW+8G
         sEeOe+lFLwyCDqoqIscA9bo3vneH40uzwhO/f8+4CWO+q/dbx3glsY9wxzgCxtqd2QwU
         Gqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950826; x=1688542826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pHD5vwavBvGsj8sNf9HQSglXSh8RHVyAD0WLni3C3s=;
        b=Fq0O6JYRSB9hYFW7BOT0EvlCtFMJB+JeZmWl/QJEaYz8JvI2It+OWLsFq5mR9UkS/Z
         eZ+ASH6bcq4Z0q738F4K0gtvZz2cNQQ8FbmiMQXT9zXTpkHD4Zkqs4+x8Y5PQ6sPDO4f
         3UMdWaz8tJstv+uFLs1DwFXBukaI8rLpON91Fuwy82mFFGDUbLUk1DHykegl+z9tLNAx
         SYJGb7SQQ4jwxGuXBlO5mjAZWlvCkdTaIBELWx1+CHhO5V/oaYBghjxmapGKbtpyVzSO
         OtUK6RXWYy29ut11vUg7KT6CIHgG77DIyIEHLTDy/bFrKHZ95WMGTltz8oF8Na8Q9xPV
         G0jA==
X-Gm-Message-State: AC+VfDzA2gHWlQc+RHBQNfqr8ds3szXoPTbS5MdEDxBzcfMk5BYtrAUd
	Vj8U1IQt27MIddrwh8ZyUP4=
X-Google-Smtp-Source: ACHHUZ6t1xZUQz6H8XdTyrJFyOohGdCQm57CG3WkeJlZ7Wilz4FOVCI9Y6y8nAhi7n6LNBLf3p9HkQ==
X-Received: by 2002:a05:6000:108b:b0:30a:f143:25d2 with SMTP id y11-20020a056000108b00b0030af14325d2mr4232918wrw.5.1685950826210;
        Mon, 05 Jun 2023 00:40:26 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-34-244-49-215.eu-west-1.compute.amazonaws.com. [34.244.49.215])
        by smtp.gmail.com with ESMTPSA id c18-20020adfed92000000b0030ae499da59sm8882103wro.111.2023.06.05.00.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:40:26 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/3] bpf: make bpf_prog_pack allocator portable
Date: Mon,  5 Jun 2023 07:40:22 +0000
Message-Id: <20230605074024.1055863-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605074024.1055863-1-puranjay12@gmail.com>
References: <20230605074024.1055863-1-puranjay12@gmail.com>
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
---
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


