Return-Path: <bpf+bounces-26340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C0089E702
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22690283F96
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1E1C2E;
	Wed, 10 Apr 2024 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrKoFGM9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62931EC2
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709720; cv=none; b=o/G3sb0NPktT0ZHlSvvKyFO9hwygrc9Xrlz/FHNys08+fsH2f2pCRRPTYer1CVs7Tp2CImMDy/wtyI/19jS7XTYgUbgv/UBje/1eKtUtBBOBmrU58ucCJYrweUzuRCqeJk1YUTk+7b4WXhQtvFj2KaNt2m9eVn199RuhgPIvj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709720; c=relaxed/simple;
	bh=phr5fzU13/yD+OD2OqdLQym/DIXjKDKCgTubLtxOQj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPkMddl/kLc9wLtJj41IFk0saDQgeQQeB04AJdj+2bVCuNKI91h4gBeoILQmJxaO/FF0moYfFOxK5v5tsfLwzoAyqCgozzDti0jjEPRBSI07+cmtII73XejZ179kW550Fk7lGtTV4gRutLThZue43kUv3eIy8BYE2u3T//wL6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrKoFGM9; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c3aeef1385so3510565b6e.3
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709718; x=1713314518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FYAFbUvqMWEFSTQq3pdH/nIomxwhfiPGGthCbFBfE4=;
        b=RrKoFGM9LZG7kPtsegKaYbAxF+HGAtJhgdWYNXo8kvni/jNBiBQoxVbUlqgquTfSVR
         x3Rq/ZQbIiDJkFcbHdPRRgeN0HUy/BrW0Mi1zrKvjOMl7dCuHzRou9qWUH9qhsM3yXoe
         5pwlVED1NSaJ8wfXNU9B8DxQYtX/SWgoOvYE4cjy0+RxMOFaNMNPA2SEYP7K2upa6YS0
         xiLLlLITaZULU6vtuRWDjCVtcFPQbteJcbnlvcE8I8Fm7qIgoDuhIKKN5CzKz3+cpKbT
         LiR56vD5L3lHL4DKKLCZRiHtcxgsBBCXqWgjcrb/XbTxZt6ydLE4DBN6c8WzjcbB+b0r
         oYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709718; x=1713314518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FYAFbUvqMWEFSTQq3pdH/nIomxwhfiPGGthCbFBfE4=;
        b=kB2aqrYfX8RwV4LDTnRLhuzNT00jqDSyP6HR29IT4dkR9MnQukzzcK8+rRq3atjlIV
         KYlNtp/CC3sFeMuLzQpQIjTc+Tu+4K4B9jXMGyzK+syUq2zMGkZwjpk0dwvcfQMvTenn
         GB2aEOoDnwfce6XBkm1t9uwymZcnJZ4bFt+tRQSwmV07ODkmv8wiMtLSfAtLvmJJwzOf
         hqU19E38OS+5Zh0X2TMKrs0tu3QHJ4vxwto4xQRCCZB9TfjFLRJqa6GLnZh+IOd3GG4P
         WQ3kPz8zCLqfauPtcAubai46YifCzHvTftNC+cGu8JoP+gD0KKUn3TYRE/XwUdVTYMi9
         yUxA==
X-Gm-Message-State: AOJu0YwECo3WIXQuLGYdSR9oN66vHxe8oeVyr/cUvVL9IGQDKuRHsVqR
	R/vCI8nPP0NfrT92/x2uXSWnyVvFCV5w/Z2RkG37Av9R1b3j9eakvnCB1GTM
X-Google-Smtp-Source: AGHT+IH5puw4V85rCxgQpODJ0ep/jqvoMzwRF01l9v5PIqT5+yBLr1ce1mBotTeEGAi/I4ycoLKrLA==
X-Received: by 2002:aca:1309:0:b0:3c5:e551:2770 with SMTP id e9-20020aca1309000000b003c5e5512770mr1045094oii.31.1712709718246;
        Tue, 09 Apr 2024 17:41:58 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:41:57 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 04/11] bpf: check_map_kptr_access() compute the offset from the reg state.
Date: Tue,  9 Apr 2024 17:41:43 -0700
Message-Id: <20240410004150.2917641-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410004150.2917641-1-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, check_map_kptr_access() assumed that the accessed offset was
identical to the offset in the btf_field. However, once field array is
supported, the accessed offset no longer matches the offset in the
bpf_field. It may refer to an element in an array while the offset in the
bpf_field refers to the beginning of the array.

To handle arrays, it computes the offset from the reg state instead.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/verifier.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 86adacc5f76c..34e43220c6f0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5349,18 +5349,19 @@ static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr
 }
 
 static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
-				 int value_regno, int insn_idx,
+				 u32 offset, int value_regno, int insn_idx,
 				 struct btf_field *kptr_field)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	int class = BPF_CLASS(insn->code);
-	struct bpf_reg_state *val_reg;
+	struct bpf_reg_state *val_reg, *reg;
 
 	/* Things we already checked for in check_map_access and caller:
 	 *  - Reject cases where variable offset may touch kptr
 	 *  - size of access (must be BPF_DW)
 	 *  - tnum_is_const(reg->var_off)
-	 *  - kptr_field->offset == off + reg->var_off.value
+	 *  - kptr_field->offset + kptr_field->size * i / kptr_field->nelems
+	 *    == off + reg->var_off.value where n is an index into the array
 	 */
 	/* Only BPF_[LDX,STX,ST] | BPF_MEM | BPF_DW is supported */
 	if (BPF_MODE(insn->code) != BPF_MEM) {
@@ -5393,8 +5394,9 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 			return -EACCES;
 	} else if (class == BPF_ST) {
 		if (insn->imm) {
-			verbose(env, "BPF_ST imm must be 0 when storing to kptr at off=%u\n",
-				kptr_field->offset);
+			reg = reg_state(env, regno);
+			verbose(env, "BPF_ST imm must be 0 when storing to kptr at off=%llu\n",
+				reg->var_off.value + offset);
 			return -EACCES;
 		}
 	} else {
@@ -6781,7 +6783,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			kptr_field = btf_record_find(reg->map_ptr->record,
 						     off + reg->var_off.value, BPF_KPTR);
 		if (kptr_field) {
-			err = check_map_kptr_access(env, regno, value_regno, insn_idx, kptr_field);
+			err = check_map_kptr_access(env, regno, off, value_regno,
+						    insn_idx, kptr_field);
 		} else if (t == BPF_READ && value_regno >= 0) {
 			struct bpf_map *map = reg->map_ptr;
 
-- 
2.34.1


