Return-Path: <bpf+bounces-2832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E8373515C
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 12:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2A2280FAF
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A5C8C2;
	Mon, 19 Jun 2023 10:01:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B1C2EA
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 10:01:51 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C07D1BE;
	Mon, 19 Jun 2023 03:01:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so3231696f8f.1;
        Mon, 19 Jun 2023 03:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687168883; x=1689760883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9REFMTd6lRNNEelcN/tfneZyz71MzFoj98cDgvpdoUg=;
        b=AvcEfz2bWWnx1FsfFiWeo2EpAqHkH84mshYwS3CEbdpCXr4jftHxlJvyV6U1exEWRE
         J5/4OtQ8KKd7TjbUbPJ4sgx1zo/h4kehvWGpG8QS5Co50CYV7J7veWOqGCATmuyRrnzG
         dW86jOmF+JwCtJ8+gNmpjkPQRTUDgn8G8Ig/BZ+5YQ2sf1uZx1jjNOHGPwRTo3z4fnqa
         GD8i9z3ZInjdR1ujlg+W8OOCFQH15xccSku8jIAg2zPc6WhVciHVB1mn9S88c3fcSEyS
         RYDGMyYNrqhqDH1zHvWpaL2uRXrxpFpgHPFgBVmWyXsADXWgnhF9XpH3GnU1i43jitHk
         jQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687168883; x=1689760883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9REFMTd6lRNNEelcN/tfneZyz71MzFoj98cDgvpdoUg=;
        b=VK2DK6scYHRnoy/Ya8Um1rHECfCPI1vbyOlav2DEUSgDSEv0L7N3eZaK2fN5U/HBSu
         clkgDZhItVtgaSBOEl9nDNQiDC+m4iAizHSI6otDh0ckir5PVjRUJED+QqUN38JL6cJe
         mYyg0VQo24TaSDzrm4+iIaZG125jWaa5oxEk7JgODjijkbuPLVdnsV+b3boHyrLvr+Ej
         dsbPpVkA2OIq6wpS8IKgHNjuMgSWyIxgSYq4IJQ7bb+/WQHVYP3BKssG5UboZhdncDma
         IHnucwj9fqjXSYE+cPZgeyRy89LDmpJfYvu5qZR9nJ/XffnsZt2oZyW5EuV6aaf00Lv2
         eQaw==
X-Gm-Message-State: AC+VfDy2CQwNOWLUvW0Fe9UZb8SQG3XjvghH+3zAWlf8KEq5lAj9Bqz2
	FKEKvEY5TCbz9hmwbO8/7fo=
X-Google-Smtp-Source: ACHHUZ5d+P77ReekMD4/QzGWh2U7zpoBrdO8ZxiseRWdurChvXg92s1jN/Q/VRIolLOER/63E5xy+w==
X-Received: by 2002:a5d:468d:0:b0:30a:f2a0:64fa with SMTP id u13-20020a5d468d000000b0030af2a064famr8242914wrq.10.1687168882983;
        Mon, 19 Jun 2023 03:01:22 -0700 (PDT)
Received: from ip-172-31-22-112.eu-west-1.compute.internal (ec2-54-154-23-32.eu-west-1.compute.amazonaws.com. [54.154.23.32])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b0030ae3a6be4asm31352451wrf.72.2023.06.19.03.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:01:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/3] bpf: make bpf_prog_pack allocator portable
Date: Mon, 19 Jun 2023 10:01:19 +0000
Message-Id: <20230619100121.27534-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619100121.27534-1-puranjay12@gmail.com>
References: <20230619100121.27534-1-puranjay12@gmail.com>
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
Changes in V2 => V3:
- No changes

Changes in v1 => v2:
- No code changes.
- Added Acked-by: Song Liu <song@kernel.org>

kernel/bpf/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dc85240a0134..599136cb5096 100644
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
2.40.1


