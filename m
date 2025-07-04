Return-Path: <bpf+bounces-62450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3271AF9CA6
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A20F586E69
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14BC28D8D5;
	Fri,  4 Jul 2025 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc4lBHrm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847D1991D2
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751670248; cv=none; b=ZFi97F0mjbp9+G4xlmle2GIUeDXnKNeXkCrzTnS7K6YyOqrQTJIo9aJS+tvai/EpsnEhYB1RRoLZ0iI+wkiYkcyM6Inh1nNFuX1OKQ7z6KiDbhY7u6x9yDAAVMwLISbbUPexjza0nhxXumHCE2mTvBklo+LJNOD/K/bivKAd/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751670248; c=relaxed/simple;
	bh=gCBBB+ejaILUrFvIpozjEL7nZWtazdHYdkMdLjrg8dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPDupU5AFhuf/JRJ5eBCobTclhGHIWifCwsVt/HR5E4hxl7DKGWVPQHpnVvomOl+fwVXBgWJkreE578IlWLwlHGXvPb0WaIFG5npqxoPU9k7xR+roiY9Ch9zHoqT2WjL7V4+AHFS52ZxpuoUObr6zWk9WkC85lNnMKI1cC+Tnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc4lBHrm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso763639b3a.0
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751670246; x=1752275046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2r0fktLIfgW5vZwZfWXp23mKFAJM12SJm2PSbOr8lE=;
        b=bc4lBHrm+hKKBs7DgeedxWhD9XOF4ZBiNCRsERIimsFfHGk3lQEqOYb0491mgDmwVe
         mkIZRw0C87QSHhZA7APlouKFj/QUysKFobaGrMfq35Goo9PFBbnssT2i7qC5IjatnHm/
         cKM5PYfBgkPxyckJixNx/ZKIF2TTVvzFN/DfiOR3VYrA/om5hFkKzE3bYZkBbSvYIuph
         A74SXtx8eAtlygE9BCJcE1wPou/ocVzX1LdFZfBjICJraVHVMTq/9nDXzBwiYPFN1V/l
         L2ynORZeDV26Ez/KYMVDy5yM7ULaEp1uLmGUJaFm/1lBh9l1gyYpKjWZexC7AVTkA9Of
         F5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751670246; x=1752275046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2r0fktLIfgW5vZwZfWXp23mKFAJM12SJm2PSbOr8lE=;
        b=fVcfVJMpzk4mFlSyTrua780ch/VuGCVlKhSv9FlfWfMFdnoSnHVobN3POBYS9QZwQy
         bpCgHAgHFi8X7XncnmmC0KlfHZ5yiBvjdzrDjQRh2kGbJ2kh27+uyGP7SW7Nb2D7Hy8R
         az/uvLhJhNrk35mRds1tJi/x1OEqMddxM+2rzZWXnHaEaEc9WrONUmuWhr8U9vBwQKfJ
         8tXMLuKLIoUDMJG4vCUPvZNJWilS/NvNrRv6WBJOskSLYRpHVpd3azSFcqZMTjsH4FLC
         t2zE2li329wOuiH/yeLtMBP7ZOivl10rwmMK9YyEW7GC00c9Cj3LNiu7U7rYSHXjYhg+
         I04Q==
X-Gm-Message-State: AOJu0YxgnYt3kQ4XUeYtvTYv5GEnrC3OAJcKTbpj8ZrKx9nja9QT1R+r
	cFM94bCUITcjMH6D/pdfR2OverPfGC/019nXdZRMLP8s1xA4KpPOgCE0/mZ95Q==
X-Gm-Gg: ASbGnctRtDQcCJD1hQas4floR2MitA/ltOTHBjA/jLEaGWaqJuWH8N0wyEJ0j+1MZBX
	OQPx2cu50ZnAbDQg3cjWm2e8m5S0ptreRmqzSDWMlDchCD1iMUSls8MmQiaRLU0esRjaiADROwS
	KvkiKG88Vkfsn+/t6LwpqgXQanNKgYowTzsPsYu/5JDTB7NAP/WDbXCDdKHGyU8e1KlHx9rirKr
	gM9vt7dqlA3u3xbT8SMF7kd2PtQYr8HatdIoZL3u3zmdGBDlEfycEe6sBYgV5P+enj93ECdYYO0
	ncWp2Ku6xeRR/2QicoCv0a6OLekYQJ7nfl7+QUbdzFXEOnGiqj4ItH/kkQ==
X-Google-Smtp-Source: AGHT+IGCcajNcEj6vSF4WGvJyxKz6qAVvZNucT704T84QZkZ0tC7a5W2ASHg4mqZVEEjJeN5npQtfA==
X-Received: by 2002:a05:6a20:158a:b0:220:879d:5632 with SMTP id adf61e73a8af0-22609a89767mr4469635637.17.1751670245661;
        Fri, 04 Jul 2025 16:04:05 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38f879d040sm1764447a12.44.2025.07.04.16.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:04:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 1/8] bpf: make makr_btf_ld_reg return error for unexpected reg types
Date: Fri,  4 Jul 2025 16:03:47 -0700
Message-ID: <20250704230354.1323244-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704230354.1323244-1-eddyz87@gmail.com>
References: <20250704230354.1323244-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-functional change:
mark_btf_ld_reg() expects 'reg_type' parameter to be either
SCALAR_VALUE or PTR_TO_BTF_ID. Next commit expands this set, so update
this function to fail if unexpected type is passed. Also update
callers to propagate the error.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 59 ++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0f6cc2275695..9e8328f40b88 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2796,22 +2796,28 @@ static void mark_reg_not_init(struct bpf_verifier_env *env,
 	__mark_reg_not_init(env, regs + regno);
 }
 
-static void mark_btf_ld_reg(struct bpf_verifier_env *env,
-			    struct bpf_reg_state *regs, u32 regno,
-			    enum bpf_reg_type reg_type,
-			    struct btf *btf, u32 btf_id,
-			    enum bpf_type_flag flag)
+static int mark_btf_ld_reg(struct bpf_verifier_env *env,
+			   struct bpf_reg_state *regs, u32 regno,
+			   enum bpf_reg_type reg_type,
+			   struct btf *btf, u32 btf_id,
+			   enum bpf_type_flag flag)
 {
-	if (reg_type == SCALAR_VALUE) {
+	switch (reg_type) {
+	case SCALAR_VALUE:
 		mark_reg_unknown(env, regs, regno);
-		return;
+		return 0;
+	case PTR_TO_BTF_ID:
+		mark_reg_known_zero(env, regs, regno);
+		regs[regno].type = PTR_TO_BTF_ID | flag;
+		regs[regno].btf = btf;
+		regs[regno].btf_id = btf_id;
+		if (type_may_be_null(flag))
+			regs[regno].id = ++env->id_gen;
+		return 0;
+	default:
+		verifier_bug(env, "unexpected reg_type %d in %s\n", reg_type, __func__);
+		return -EFAULT;
 	}
-	mark_reg_known_zero(env, regs, regno);
-	regs[regno].type = PTR_TO_BTF_ID | flag;
-	regs[regno].btf = btf;
-	regs[regno].btf_id = btf_id;
-	if (type_may_be_null(flag))
-		regs[regno].id = ++env->id_gen;
 }
 
 #define DEF_NOT_SUBREG	(0)
@@ -5965,6 +5971,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	int class = BPF_CLASS(insn->code);
 	struct bpf_reg_state *val_reg;
+	int ret;
 
 	/* Things we already checked for in check_map_access and caller:
 	 *  - Reject cases where variable offset may touch kptr
@@ -5998,8 +6005,11 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		/* We can simply mark the value_regno receiving the pointer
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
-		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, kptr_field->kptr.btf,
-				kptr_field->kptr.btf_id, btf_ld_kptr_type(env, kptr_field));
+		ret = mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID,
+				      kptr_field->kptr.btf, kptr_field->kptr.btf_id,
+				      btf_ld_kptr_type(env, kptr_field));
+		if (ret < 0)
+			return ret;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
 		if (!register_is_null(val_reg) &&
@@ -7298,8 +7308,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		clear_trusted_flags(&flag);
 	}
 
-	if (atype == BPF_READ && value_regno >= 0)
-		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
+	if (atype == BPF_READ && value_regno >= 0) {
+		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
@@ -7353,13 +7366,19 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 
 	/* Simulate access to a PTR_TO_BTF_ID */
 	memset(&map_reg, 0, sizeof(map_reg));
-	mark_btf_ld_reg(env, &map_reg, 0, PTR_TO_BTF_ID, btf_vmlinux, *map->ops->map_btf_id, 0);
+	ret = mark_btf_ld_reg(env, &map_reg, 0, PTR_TO_BTF_ID,
+			      btf_vmlinux, *map->ops->map_btf_id, 0);
+	if (ret < 0)
+		return ret;
 	ret = btf_struct_access(&env->log, &map_reg, off, size, atype, &btf_id, &flag, NULL);
 	if (ret < 0)
 		return ret;
 
-	if (value_regno >= 0)
-		mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_id, flag);
+	if (value_regno >= 0) {
+		ret = mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_id, flag);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.49.0


