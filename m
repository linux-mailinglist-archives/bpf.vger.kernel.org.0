Return-Path: <bpf+bounces-61428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50AAE6F9E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E583A3D5A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEBE26AAB2;
	Tue, 24 Jun 2025 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxwDL52o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9624169A
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793514; cv=none; b=DcuA8tKmcCIG7BLVT1nbMDt4dHU+/Le2KnQNnClhXO/ef3g+Mv6IUedMdofHlnMJfpibpksf86+au3Y8tgsKplYuJ/GEDSfUybEWB9eX71Unj+IH+czeUgk7GDH+Rf0iqwM6evZUbIzTk6sUuEugQXIaQN2uEyitTRtRui1zTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793514; c=relaxed/simple;
	bh=TTpIAe+r4qZIMND8c/QIolov560/nCHmvf/RjvyTHbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMDbUn1OpwPfQaBNMN87rIYdAPFEOOtnSrAzVGh2zu+UBcCa0UPBl3rp0HrgJ1rxU+GoVcNP4SDQ6w1gMsXg5yRDRSg4hlcv5iPVbBZ8iAbOJoWXjNL6HOKCpga1ENNYqu+Xbe7lkWfdb/WJZY6dCaSOaIhi47pcA/TkfEYNBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxwDL52o; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453647147c6so9258985e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750793510; x=1751398310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao/A3f0CHV32D8vrlNke2o6S9RTMQZcejJKBKvgRpfY=;
        b=QxwDL52op/1raDalWxPEUxbnqi8xAp+ua+HXDJzpVmAwJuYseBfVls7/XVlx4UfruK
         0VqlDZPJcKx8lmQ53FM9wBUUxj3aHULHPH9/wZ0C2Nt5PvmQ6+ht6nVLdfQo0Ul7Wbrz
         vZn5EhmSq/osLthNhRYvMmjcPRUMNJisWfkaNkmYpQ4ZMKf+LgGH/7ytzXV6Ym/n1iqp
         PFJQonh78Qo/gg9OEbmA8mF1gqJ/iRoJ/CTdtMAOrSZuYWC0CVSjUzRoslXObqkZJORf
         e9DhPhs56ql3egK0Zei9jhozdQDIeHkCvrfamZamLuXwVzORvSxFaIXNW/wKUa3zJsG2
         6mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793510; x=1751398310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ao/A3f0CHV32D8vrlNke2o6S9RTMQZcejJKBKvgRpfY=;
        b=dprZ+g36+RitW+1NLxt4YW+iuyRkwPgu9r3CeojW4SXulI1JnR5nhx2pUtclsQZ78t
         st7YzV16Oxp5sROUyFUdVIf5uevq5dwNotyuC1IFttvSldtrzBCgkV/qp3UbDhlBawSd
         CfPSjV0vUJ7Yc9HF2oQhHSlF0sg5oCkaBmyTOssCVIT/xmibagDEb5OwFHsGIQS+IoZE
         yF5y2jx7J88fvLB1ES3E6iLRurd2ZnBnEPWISfYVgBuhZ9w3DrRRA5dXEcA+o+ATU1Sv
         AvxTv+u30vVc8msVibJKCO0F/QnPOr6CqP7zY9hK0gVtLcALyaEhjneJHRZRFdIzFL4a
         3Zow==
X-Gm-Message-State: AOJu0YyjTvQPQ5ffptYO6WBASgwmUB+UhPVEeCCXaB/fku8h8jM+r/LR
	5ZRus++OsrmOlViQwC1HsCTkmlFiz6HEiIJzwqbYxttmdaTRneOhpabLU13/fg==
X-Gm-Gg: ASbGncs9tMkSxhqWYPpemmeApJLvlkurzn3eSqJhh5ehwdDAmt7J9tTOLREJtbSpwTK
	RVdeq6514No23Bxa55E699557NyfdAH67uT/jAuRyz6pcydEwtWz9EHIwOXkrh1k9FDF3x1nlau
	Tm6ukQ15ClBM62xQB09Rk7/O2A96gpbuDn3wYGd8TASniGnBKtBBx2RRmPW+7ISHnOHaqFh22Pf
	SlU3kdx/aK0hNwo4coCjcHblxUYnlM61jnEahtcCr4LZP2r10kqJNEhum6pTExIMcGJyMEkBAKP
	NFGsVuylZXV4twK/qJlECF9KynubkoHxfCvfi8+h2cpi0KqQH98Rqrcou17RDewPNFDbwggR1wj
	XnQRTg6I=
X-Google-Smtp-Source: AGHT+IGEFriIvA694QPNh2cjwv3UMsel/hszsArurt2OLdIThcFigfQsEcqY8XT8AOW5zY7LC8gGuw==
X-Received: by 2002:a05:600c:1c0d:b0:453:58e8:a445 with SMTP id 5b1f17b1804b1-45381af1bbfmr1634695e9.11.1750793509957;
        Tue, 24 Jun 2025 12:31:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4536470371csm149022455e9.30.2025.06.24.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:31:49 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] bpf: simplify code by exporting a btf helper
Date: Tue, 24 Jun 2025 19:36:55 +0000
Message-Id: <20250624193655.733050-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are places in code which can be simplified by using the
btf_type_is_regular_int() helper (slightly patched to add an
additional, optional, argument to check the exact size). So
patch the helper, export it, and simplify code in a few files.
(Suggested by Eduard in a bit different form in [1].)

[1] https://lore.kernel.org/bpf/7edb47e73baa46705119a23c6bf4af26517a640f.camel@gmail.com/

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/btf.h            |  1 +
 kernel/bpf/arraymap.c          | 11 +++------
 kernel/bpf/bpf_local_storage.c |  8 +------
 kernel/bpf/btf.c               | 43 +++++++++++++++++-----------------
 kernel/bpf/local_storage.c     |  9 +------
 5 files changed, 27 insertions(+), 45 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b2983706292f..dbd52be2dbc4 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -221,6 +221,7 @@ bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
 struct btf *btf_base_btf(const struct btf *btf);
+bool btf_type_is_regular_int(const struct btf_type *t, size_t expected_size);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index eb28c0f219ee..f7f84800c1dc 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -530,8 +530,6 @@ static int array_map_check_btf(const struct bpf_map *map,
 			       const struct btf_type *key_type,
 			       const struct btf_type *value_type)
 {
-	u32 int_data;
-
 	/* One exception for keyless BTF: .bss/.data/.rodata map */
 	if (btf_type_is_void(key_type)) {
 		if (map->map_type != BPF_MAP_TYPE_ARRAY ||
@@ -544,14 +542,11 @@ static int array_map_check_btf(const struct bpf_map *map,
 		return 0;
 	}
 
-	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
-		return -EINVAL;
-
-	int_data = *(u32 *)(key_type + 1);
-	/* bpf array can only take a u32 key. This check makes sure
+	/*
+	 * Bpf array can only take a u32 key. This check makes sure
 	 * that the btf matches the attr used during map_create.
 	 */
-	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
+	if (!btf_type_is_regular_int(key_type, sizeof(u32)))
 		return -EINVAL;
 
 	return 0;
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index fa56c30833ff..1ea8fb93d55e 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -722,13 +722,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 				    const struct btf_type *key_type,
 				    const struct btf_type *value_type)
 {
-	u32 int_data;
-
-	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
-		return -EINVAL;
-
-	int_data = *(u32 *)(key_type + 1);
-	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
+	if (!btf_type_is_regular_int(key_type, sizeof(u32)))
 		return -EINVAL;
 
 	return 0;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 682acb1ed234..ea21b74d5027 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -857,27 +857,27 @@ const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id)
 }
 EXPORT_SYMBOL_GPL(btf_type_by_id);
 
-/*
- * Regular int is not a bit field and it must be either
- * u8/u16/u32/u64 or __int128.
- */
-static bool btf_type_int_is_regular(const struct btf_type *t)
+static bool btf_type_int_is_regular(const struct btf_type *t, size_t expected_size)
 {
-	u8 nr_bits, nr_bytes;
-	u32 int_data;
+	u32 int_data = btf_type_int(t);
+	u8 nr_bits = BTF_INT_BITS(int_data);
+	u8 nr_bytes = BITS_ROUNDUP_BYTES(nr_bits);
 
-	int_data = btf_type_int(t);
-	nr_bits = BTF_INT_BITS(int_data);
-	nr_bytes = BITS_ROUNDUP_BYTES(nr_bits);
-	if (BITS_PER_BYTE_MASKED(nr_bits) ||
-	    BTF_INT_OFFSET(int_data) ||
-	    (nr_bytes != sizeof(u8) && nr_bytes != sizeof(u16) &&
-	     nr_bytes != sizeof(u32) && nr_bytes != sizeof(u64) &&
-	     nr_bytes != (2 * sizeof(u64)))) {
-		return false;
-	}
+	return BITS_PER_BYTE_MASKED(nr_bits) == 0 &&
+	       BTF_INT_OFFSET(int_data) == 0 &&
+	       (nr_bytes <= 16 && is_power_of_2(nr_bytes)) &&
+	       (expected_size == 0 || nr_bytes == expected_size);
+}
 
-	return true;
+/*
+ * Check that the type @t is a regular int. This means that @t is not
+ * a bit field and it has the same size as either of u8/u16/u32/u64
+ * or __int128. If @expected_size is not zero, then size of @t should
+ * be the same.
+ */
+bool btf_type_is_regular_int(const struct btf_type *t, size_t expected_size)
+{
+	return btf_type_is_int(t) && btf_type_int_is_regular(t, expected_size);
 }
 
 /*
@@ -2180,7 +2180,7 @@ static int btf_int_check_kflag_member(struct btf_verifier_env *env,
 	u32 nr_copy_bits;
 
 	/* a regular int type is required for the kflag int member */
-	if (!btf_type_int_is_regular(member_type)) {
+	if (!btf_type_int_is_regular(member_type, 0)) {
 		btf_verifier_log_member(env, struct_type, member,
 					"Invalid member base type");
 		return -EINVAL;
@@ -2969,8 +2969,7 @@ static int btf_array_resolve(struct btf_verifier_env *env,
 		return env_stack_push(env, index_type, index_type_id);
 
 	index_type = btf_type_id_size(btf, &index_type_id, NULL);
-	if (!index_type || !btf_type_is_int(index_type) ||
-	    !btf_type_int_is_regular(index_type)) {
+	if (!index_type || !btf_type_is_regular_int(index_type, 0)) {
 		btf_verifier_log_type(env, v->t, "Invalid index");
 		return -EINVAL;
 	}
@@ -2995,7 +2994,7 @@ static int btf_array_resolve(struct btf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (btf_type_is_int(elem_type) && !btf_type_int_is_regular(elem_type)) {
+	if (btf_type_is_int(elem_type) && !btf_type_int_is_regular(elem_type, 0)) {
 		btf_verifier_log_type(env, v->t, "Invalid array of int");
 		return -EINVAL;
 	}
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 3969eb0382af..8645a39e8dd1 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -394,17 +394,10 @@ static int cgroup_storage_check_btf(const struct bpf_map *map,
 		if (!btf_member_is_reg_int(btf, key_type, m, offset, size))
 			return -EINVAL;
 	} else {
-		u32 int_data;
-
 		/*
 		 * Key is expected to be u64, which stores the cgroup_inode_id
 		 */
-
-		if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
-			return -EINVAL;
-
-		int_data = *(u32 *)(key_type + 1);
-		if (BTF_INT_BITS(int_data) != 64 || BTF_INT_OFFSET(int_data))
+		if (!btf_type_is_regular_int(key_type, sizeof(u64)))
 			return -EINVAL;
 	}
 
-- 
2.34.1


