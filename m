Return-Path: <bpf+bounces-32320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C43790B7A1
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFCB1C2337E
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2263B16CD09;
	Mon, 17 Jun 2024 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCggwVVd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C516C874
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644698; cv=none; b=eTE9khCEgv4Zl23XRFI5AMaEpzV1DksOzPXepusRmNKgzU4JwgarxI6U/z5L61ycmgc3KmTUoIZwfn/BXHlhXiOUcNK4Zdtk1IQjqmRXnSGURaKYUhFBKJfaq8PvV1vNhMb09D4JnDpR4zvtCid4a6yrjkqUlvTT/E+caNOwFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644698; c=relaxed/simple;
	bh=jrWUFyXw7bSFapoiWDDTTreT7Wah+xdQzcGgV47Lmhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oD/T7XLFGGPG9U1XG9GxFVCC0Q347Edjkmt5KGY+P4IZkKZNY9W2SBoziHygFu4zGeWzCjywX8wiZvzYx/iU7tmGiSrMdjY7TANfRw4CLS19WwE38sH0fCZgdUlB0EyS9BL9ZYVM28N4En7Ubr31xxebnIvx7nfJw3Q9WBMffkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCggwVVd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70109d34a16so3998788b3a.2
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718644695; x=1719249495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRMSZk33uwiyXCtlUWxJoFzKd+8mmYGFFIEUj1CLNaE=;
        b=kCggwVVdnFwUTzdq0mDXSr52j00NY470p+wAj6DeoXYrtE8tV1bs1TGA27MDSW0zKV
         Qz/TT6UsirqZZo9ZPaMxjDLUI7kM6eS5ZrTfYUylPET8ZfNKZYAuIEE+oIjWS4f/dH2g
         9oXmxYH750v3C4rpAkYW5DtFhfT+kixbP6nUQtJWbqtHQxAW+z2o0FtmQnGPamdBkeZX
         vxCPUraefhscYI2KkfDov+MQC47dbA2tUQ5CkPY3gnVLFNI8jBCzYzFNkwinUZ60EdXS
         b6vU4G7zg3i7gzUvPEa9mdFV5nDjxiIRa3MlCIyiHIw/OLyUyYJoGKTbWbT5MWatmprS
         WAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718644695; x=1719249495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRMSZk33uwiyXCtlUWxJoFzKd+8mmYGFFIEUj1CLNaE=;
        b=iqR2ChiaAsHKmE8lA2m7yE/bK7M8mI0G4UQTv8KJ0axCsJRkAcvAzO2oNYMF6KbbKO
         qkft1AD/3g26I/n1Lj/CZAJUkLCK3RE9DPGQg2L6jlA5qj1gss596Yg23mABevOHxW9X
         fZ5u6XClhId5l2etOuxe7B9hzniv+fPuZdw94thH2yDa9UAgknx2L7xRuWQ8368XlYT7
         2a+Pqx2VEqOPfO9qeDgS8dE73DHcnhd3TjMLY7ksyzrz2vWz/kwsiO5pTmYby4Sm5Zej
         I1MADe0YH1KEcNlGZ5qP3DiypCAzv9fZ01zQUvFqA14NiqSXXsuXU6FwO9RIlIA/JbBp
         hS0g==
X-Gm-Message-State: AOJu0YwqK3NcxBGJn8gyNGSXs5KsjnApGwytIVU1662KyvklI/TXffGw
	Ut8Nr2qF5L5pnQjJhX98aJ3aOwsPAQ9oc04U9nOUCiXBr8SBeQ1L1FofCQ==
X-Google-Smtp-Source: AGHT+IFNkfvh9iKErjmCKjs+klcpQ91gCVccQ4x3toGJQqzCzBOhfpKvsuCgsTkqrh4NpRaEcoRtWg==
X-Received: by 2002:a05:6a20:3c90:b0:1b8:6ed5:a70 with SMTP id adf61e73a8af0-1bae823dc4fmr12559726637.49.1718644695526;
        Mon, 17 Jun 2024 10:18:15 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::6:45a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5654bsm81673875ad.45.2024.06.17.10.18.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Jun 2024 10:18:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	pengfei.xu@intel.com,
	brho@google.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf] bpf: Fix remap of arena.
Date: Mon, 17 Jun 2024 10:18:12 -0700
Message-Id: <20240617171812.76634-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The bpf arena logic didn't account for mremap operation. Add a refcnt for
multiple mmap events to prevent use-after-free in arena_vm_close.

Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Closes: https://lore.kernel.org/bpf/Zmuw29IhgyPNKnIM@xpf.sh.intel.com/
Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 583ee4fe48ef..fe35b45cf6f8 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -212,6 +212,7 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
 struct vma_list {
 	struct vm_area_struct *vma;
 	struct list_head head;
+	atomic_t mmap_count;
 };
 
 static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
@@ -221,20 +222,32 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
 	vml = kmalloc(sizeof(*vml), GFP_KERNEL);
 	if (!vml)
 		return -ENOMEM;
+	atomic_set(&vml->mmap_count, 1);
 	vma->vm_private_data = vml;
 	vml->vma = vma;
 	list_add(&vml->head, &arena->vma_list);
 	return 0;
 }
 
+static void arena_vm_open(struct vm_area_struct *vma)
+{
+	struct bpf_map *map = vma->vm_file->private_data;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct vma_list *vml = vma->vm_private_data;
+
+	atomic_inc(&vml->mmap_count);
+}
+
 static void arena_vm_close(struct vm_area_struct *vma)
 {
 	struct bpf_map *map = vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
-	struct vma_list *vml;
+	struct vma_list *vml = vma->vm_private_data;
 
+	if (!atomic_dec_and_test(&vml->mmap_count))
+		return;
 	guard(mutex)(&arena->lock);
-	vml = vma->vm_private_data;
+	/* update link list under lock */
 	list_del(&vml->head);
 	vma->vm_private_data = NULL;
 	kfree(vml);
@@ -287,6 +300,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 }
 
 static const struct vm_operations_struct arena_vm_ops = {
+	.open		= arena_vm_open,
 	.close		= arena_vm_close,
 	.fault          = arena_vm_fault,
 };
-- 
2.43.0


