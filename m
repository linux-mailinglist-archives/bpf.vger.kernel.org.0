Return-Path: <bpf+bounces-75183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0C5C7639A
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 21:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 12DFA29F82
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902FD2F999F;
	Thu, 20 Nov 2025 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpuaaBrE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE92D8375
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763671639; cv=none; b=iTZz87qIMEllGeZzS1+Q7lf34xrvBRDcy/0egcJ5HsGi/ZgSTbpsfM42TGtQ98hsBSiJGVSuec9PvxmjqMRvv/U1aSM5PFRerNfF5hetog790zPPiW4oSrWwP8NDkNa+L9ZzWivhcW1jmzlNFlYn3Wz+rnRc/xo6ACbhfoLfhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763671639; c=relaxed/simple;
	bh=2K94P+UBEZaujybTCq3ooUqrsVw+dPtWDCc/H848xlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrKHvE3DC0SXgbropUenLKgeU+SA1Wsz77eo42xA1Xc5lRwnO0BhiRqmkEjyCNTz+etKT3CVSALqO/BTQku2JbI/hRBW/AMl2ARxGwcHgoPxN68Wh+eHGZNCGs9XiHF0tL2N4Rhp+54+8XcRbjolSBBOXa82vYek8qSHeD6X+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpuaaBrE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b75e366866so639282b3a.2
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 12:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763671637; x=1764276437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRzELrjyv1B9QTTtAz67bzAu36xbnz7eTr+g1Rji/MQ=;
        b=GpuaaBrE8zT6xpj3xVVjsmQXnQFrHurpo7aCfuNkd9qOi6FhSsI6JN9/zYX2Lmn5JQ
         UgVls2JGKMMCyRmX4Dm/GgJBDIcB7ZswE4J3tVhS77idj1DILHNuweCyboE6MLm7cGrY
         oUDqW87rYuF+0ElFsa9nShfFQzYa9PSir+kPKMlAvR8mbDPxkM4O8y1EQXNEGXp4xjUm
         RGBU0u84wiQe46k59xjH5C0mdDv9zmO2TdPtJqdLkn2uyiPcYpxb7xEwRZssX3j8vg4j
         t5dAY5hp7IURNQLiO1z74tV+1Hnc8SwKuAfV0r32TDlBlCwMgTxyHuDG6LddZ8HIHoMT
         UiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763671637; x=1764276437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mRzELrjyv1B9QTTtAz67bzAu36xbnz7eTr+g1Rji/MQ=;
        b=HdwHKB+QNLgcSqvAqoXt3qAOobReJNS9g4lB5Xwq6u/SJ4yaQuEn9S7QjIZ1aepI6n
         pYn6ewRke5Uj6G3/hyvTGTYQ0fYH/Dh2ZB1+b7ovPJLVO3U+JtH//k3Sbllz8PyOd1qW
         M7kzwTqqD0icAmhAgk43VkLuGa/rfGRDweDiZAhqdd7qABnbfPW4dK+/zmPPiH+ebYCP
         EXoa/er4dlm2J/g7ALZ+IGTCNEt0SKoTrPaX5VuTHHPdnzHyAolh4MCXon6TfaXhf5pF
         6Yl6FbDckjFr1ujz9//G0GUA4wHiVs1L/egnihAGHd4iETyl3EsrVuJEVykJsC1yXvZS
         UwOA==
X-Forwarded-Encrypted: i=1; AJvYcCUW5jXAPr4DhMjr4zsyKcE+O76lVwawOf7lUG+io9hDeqzwsSWpUYDrVaSWCOZYqzRr14M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzszdtaZwEBbOpfE4SACbrm79jaRglfdZ5yd6X1Czq0oPJZmmxL
	uiqIHIZX5KbdXOopZLXRpM2I45YbjrBcpu2CEa+Cqu/kHaV7qRCmcoIa
X-Gm-Gg: ASbGncs7ywQo+xPMBHthm+xLHBwZ579a8PjVJd5uIwrw3eB/UXd3gIQgieSy2LRIbXK
	A9JurZ6yZq2yGJEemLLdw0RkIrvwr3IoAD0Q69BklrPnSar3JGyTxFQSDaRQhBtseEtOSwvrfEy
	pN9mhymtDqfukRx0EhYtjzsZWL7TcsPASo8+R8bA/EAuEp/df/jtTGdrzFjz+SwUwp3lPdMcPDR
	BQdvFpy+FfLG6wJ9oijV2A4PjXWBBe1ZI681R5fn99UCtJtpCAi6pfDgj4cy7Tq2FkYaSH4S01l
	k2R6+qmq8VJ4GLukEVkq0wVah7DW9eE6lwP2E/6sflXkF1fd1J/FbiEjUbYzKC2OESwBY7SJJ52
	htzpWAez0KhceZ26xd9C3ZCGQirdoFIxGVnVGKy1uEnjwIcGEj2Hw39dhQtQO2QyvKIJGWx369N
	emjxcQIpkUvLu8klTNeh75+SPe10QlqcxOGydv9GbpIenmnrID5RkrUjLWEDXdwNd586duiff3F
	JcGHQ==
X-Google-Smtp-Source: AGHT+IF/2lFZY3ga9vjA+9LkLYe1dsMZr1LawsGKiZs65uOepoeLssESml+r/W4m4LoCypHg3vBx8A==
X-Received: by 2002:a05:6a00:2e10:b0:7a4:f552:b524 with SMTP id d2e1a72fcca58-7c3f0d637d6mr5296963b3a.28.1763671636871;
        Thu, 20 Nov 2025 12:47:16 -0800 (PST)
Received: from prakrititz-UB.. ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed37ab3fsm3757537b3a.22.2025.11.20.12.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 12:47:16 -0800 (PST)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH v2] bpf: Document cfi_stubs and owner fields in struct bpf_struct_ops
Date: Fri, 21 Nov 2025 02:16:21 +0530
Message-ID: <20251120204620.59571-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <f87d1365-a3b6-4307-9d72-91d5f5b2c585@linux.dev>
References: <f87d1365-a3b6-4307-9d72-91d5f5b2c585@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing kernel-doc documentation for the cfi_stubs and owner
fields in struct bpf_struct_ops to fix the following warnings:

  Warning: include/linux/bpf.h:1931 struct member 'cfi_stubs' not
  described in 'bpf_struct_ops'
  Warning: include/linux/bpf.h:1931 struct member 'owner' not
  described in 'bpf_struct_ops'

The cfi_stubs field was added in commit 2cd3e3772e41 ("x86/cfi,bpf:
Fix bpf_struct_ops CFI") to provide CFI stub functions for trampolines,
and the owner field is used for module reference counting.

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
Changes in v2:
- Removed documentation for non-existent fields (type, value_type, type_id,
  value_id) that were moved to bpf_struct_ops_desc in commit 4c5763ed996a

 include/linux/bpf.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d808253f2e94..96851fa0494f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1905,12 +1905,14 @@ struct btf_member;
  *	      reason, if this callback is not defined, the check is skipped as
  *	      the struct_ops map will have final verification performed in
  *	      @reg.
- * @type: BTF type.
- * @value_type: Value type.
+ * @cfi_stubs: Pointer to a structure of stub functions for CFI. These stubs
+ *	       provide the correct Control Flow Integrity hashes for the
+ *	       trampolines generated by BPF struct_ops.
+ * @owner: The module that owns this struct_ops. Used for module reference
+ *	   counting to ensure the module providing the struct_ops cannot be
+ *	   unloaded while in use.
  * @name: The name of the struct bpf_struct_ops object.
  * @func_models: Func models
- * @type_id: BTF type id.
- * @value_id: BTF value id.
  */
 struct bpf_struct_ops {
 	const struct bpf_verifier_ops *verifier_ops;
-- 
2.48.1


