Return-Path: <bpf+bounces-61534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B1AE8787
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E176B176D5A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109F826A0C5;
	Wed, 25 Jun 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5qpdKsj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED8263F40
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864266; cv=none; b=hO5s1Zy1UpajIA+j/Xi0rVhcvOg7M6ksx1dlfjAVE7Tq04o4O82h7yncmunM8B2Yu7eW0Ltrs77VuuQPosyJurN9gK76wipRJAL9u2t/BJbYa/1erbUlKVw+AMNNuWhnjM6hJJGUSV4KdOgNYEKtPh+L/Ykq/bjvAxJAUsMq1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864266; c=relaxed/simple;
	bh=UEOeBSrjzdVUL5ZqJCdDZhx32YLw0Y/pk4ww/CvCKuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jcKo8rVs+T3AvhUidkIcazgc3JQWlUPk5LsWgMIndREgkvL8ZrWfR+QTupNjHBSmH5bKTD8Im2nW/NluBuSrIl6YOuat0HftUCh4/c8nmooIS59VMTQ28of02CEGewUvcdAZL8uu3xu+9fxtj+uyupcAQOMuU3Quunv6rHRylCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5qpdKsj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a53359dea5so3334338f8f.0
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750864263; x=1751469063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPRnWSPaVcIk+ktD+4Q2+rLDIxS2CgRGs+96l5gby+8=;
        b=U5qpdKsjq5Zv/MnLR8Zbo/DjvSzEno4gnPJkrJL6CB0GCGXr+sncBOa8lVpJVHMVGf
         epE6pOuy2ZBx98WKVwg1ILs542naoox2xmLdVuvSLIXuQYhg3wejudhuO964Bk4zDUgS
         8+tNtEaX10RRZy6FxpGRD12grUGdTI+ddL2gOukm3f+V7z/WMTws3iFDevyqxDRNIdW+
         rh5m/16nMV8Q1mT/QbNop8bheiNP5U5QucaHJJA7pvwyePdXqIERg9aVU9ATApqC3tqh
         USwDFY/wfiRKsKh+dko3aP8QqzrFLcLB+J0Xg7iC50MR05Iszg6C/hATKFExUNpwmgmR
         5USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864263; x=1751469063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPRnWSPaVcIk+ktD+4Q2+rLDIxS2CgRGs+96l5gby+8=;
        b=w4J9JUmYFipdUM8RhCXejz7o6wBi0nVHptfcfQGeo0Cr55WiJmgAghQyqtgmOL4b10
         mCJzdmKZ429X19Zq09L2THvtD4QKo4qIa5mdG36xQmcsYnO6GtngrY9Nm/WVDVpqGVrW
         +7v0CiKAV8axPKvhi5MeZwAifj8gNY5SMGdWEnanC6cXi92z7ofBLeyPxGOrLyT+LuQr
         lguEc1Posyrz65ccf9B5tPueXKeLaPQvJaWTQjyttPLoYx+yJUKYTWC0EnT96a1fyeGL
         uwQ9KFQrEBAiS4gkscwx4l8ui9hBRKNKZRjmTqtvVaiPxCzlnvgBAZantk+of6qx8NWG
         XLWg==
X-Gm-Message-State: AOJu0YwIQvZIfshQTaA654hFcZpOckkUMXbmHEiWCuyh0F9/EJNYJMBQ
	NRcWjQtLwoVnQBl/G5eOeVGeZ1wSjMoXCzkE3hwitSnzRDwb3Nk50Oxfi/Z7JQ==
X-Gm-Gg: ASbGncvk4HB8LDwLxKqZjBADhkkCnOrqtffHMbRpMT0LsuQVCEaMYxn0t7Q/oT5Tgbj
	yBIbac/S2VFfjN+X2mhQUZvQmLKTE0bNOGrQEhKtnjSb6yXnL/8Jd1VqOHq8ltdxIOuer4Pyd0G
	jubaYgQm0L/k8bRMt7QTSBPAqk6Rh3D52F47sbPSHm6vPyAJJBeaPmNBR0+FIoZfGPvf8HSokCD
	F6UMlFLg0ev1zBxJ2hmtWiUIl3pHEe51YE47nwSYygRBO4twQKfyZSvdFqqDnZGIMxQFDX2inXM
	1tSCQT8CR98hSAQYXnEQjHjtmwjUDEGRX/lq/u3jIxES5lNkzdb/LqrgTcIGFruigy1qHnlMoHO
	TrFv2Yzg=
X-Google-Smtp-Source: AGHT+IGnYSH3VjI0jz0iOGKG98SD71+tclVw1mL9CKRLXVEntEhXQdydH4DL+9hnubvqgWXhZaGUpA==
X-Received: by 2002:a5d:64cf:0:b0:3a4:dd16:a26d with SMTP id ffacd0b85a97d-3a6ed66a503mr2653653f8f.38.1750864262426;
        Wed, 25 Jun 2025 08:11:02 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f2a4csm4932331f8f.65.2025.06.25.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:11:01 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next] bpf: add btf_type_is_i{32,64} helpers
Date: Wed, 25 Jun 2025 15:16:21 +0000
Message-Id: <20250625151621.1000584-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are places in BPF code which check if a BTF type is an integer
of particular size. This code can be made simpler by using helpers.
Add new btf_type_is_i{32,64} helpers, and simplify code in a few
files. (Suggested by Eduard for a patch which copy-pasted such a
check [1].)

  v1 -> v2:
    * export less generic helpers (Eduard)
    * make subject less generic than in [v1] (Eduard)

[1] https://lore.kernel.org/bpf/7edb47e73baa46705119a23c6bf4af26517a640f.camel@gmail.com/
[v1] https://lore.kernel.org/bpf/20250624193655.733050-1-a.s.protopopov@gmail.com/

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/btf.h            |  2 ++
 kernel/bpf/arraymap.c          | 11 +++------
 kernel/bpf/bpf_local_storage.c |  8 +------
 kernel/bpf/btf.c               | 41 +++++++++++++++++++++-------------
 kernel/bpf/local_storage.c     |  9 +-------
 5 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b2983706292f..a40beb9cf160 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -221,6 +221,8 @@ bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
 struct btf *btf_base_btf(const struct btf *btf);
+bool btf_type_is_i32(const struct btf_type *t);
+bool btf_type_is_i64(const struct btf_type *t);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index eb28c0f219ee..3d080916faf9 100644
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
+	if (!btf_type_is_i32(key_type))
 		return -EINVAL;
 
 	return 0;
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index fa56c30833ff..b931fbceb54d 100644
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
+	if (!btf_type_is_i32(key_type))
 		return -EINVAL;
 
 	return 0;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 682acb1ed234..05fd64a371af 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -858,26 +858,37 @@ const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id)
 EXPORT_SYMBOL_GPL(btf_type_by_id);
 
 /*
- * Regular int is not a bit field and it must be either
- * u8/u16/u32/u64 or __int128.
+ * Check that the type @t is a regular int. This means that @t is not
+ * a bit field and it has the same size as either of u8/u16/u32/u64
+ * or __int128. If @expected_size is not zero, then size of @t should
+ * be the same. A caller should already have checked that the type @t
+ * is an integer.
  */
+static bool __btf_type_int_is_regular(const struct btf_type *t, size_t expected_size)
+{
+	u32 int_data = btf_type_int(t);
+	u8 nr_bits = BTF_INT_BITS(int_data);
+	u8 nr_bytes = BITS_ROUNDUP_BYTES(nr_bits);
+
+	return BITS_PER_BYTE_MASKED(nr_bits) == 0 &&
+	       BTF_INT_OFFSET(int_data) == 0 &&
+	       (nr_bytes <= 16 && is_power_of_2(nr_bytes)) &&
+	       (expected_size == 0 || nr_bytes == expected_size);
+}
+
 static bool btf_type_int_is_regular(const struct btf_type *t)
 {
-	u8 nr_bits, nr_bytes;
-	u32 int_data;
+	return __btf_type_int_is_regular(t, 0);
+}
 
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
+bool btf_type_is_i32(const struct btf_type *t)
+{
+	return btf_type_is_int(t) && __btf_type_int_is_regular(t, 4);
+}
 
-	return true;
+bool btf_type_is_i64(const struct btf_type *t)
+{
+	return btf_type_is_int(t) && __btf_type_int_is_regular(t, 8);
 }
 
 /*
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 3969eb0382af..632d51b05fe9 100644
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
+		if (!btf_type_is_i64(key_type))
 			return -EINVAL;
 	}
 
-- 
2.34.1


