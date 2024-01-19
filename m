Return-Path: <bpf+bounces-19926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22948330F1
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6B79B21CE7
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ACC5915C;
	Fri, 19 Jan 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfcX4wdG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003885914A
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704635; cv=none; b=HCebcM928xfOYIrwOz/WqgQixyU60b8x88cE7mp6RyyLAPhepg3LNSX5ZlNjhscOcO8qSEe+nPUDAYsPupyIEhwnnlfF3DOEnVlPjtFDClpDIR4wCZ9bgsv5oHD4orjtDdLNgQ1AMoN9WtPnS9hhTp9qY6TEUl0tTmeTeZ/ashY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704635; c=relaxed/simple;
	bh=04DImXziOmlnzNsJGM4VPXFBqgtAcg0rLPXCydzCQ1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRUcmCcPheNAJTNfRQXF9BE18yVmtE7ddEoFSY39cl6S+Fxm6s3qG9wbDePB57gJrxQOc269kxE9dS7A0qKvjBKskrUxacpNxua72MBn6YpTFDkcsiaaBYjWMotFrt6kzqKNmFnnFBTDfegVkT/d0aRRKH5/E5S3PLeZ6kL8Nh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfcX4wdG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ff7a8b5e61so11981977b3.2
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 14:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705704632; x=1706309432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyVgIYMQBw2UWRe76Yr77nhCLHUKftUbs9mM2o8wz8s=;
        b=IfcX4wdGX4vTaTx7EieVLNoq/xzF+bDHhDQaA9rvH+j0RSzaqrG4PloT9TnluM9CP9
         iqEvML6vdbweNogoOuKhIzssRdN1UmJ+yQd7kewb0m2jhdXBtS2tUjkLme05CrnT9nSm
         ghpjXYApwS4kg2SlaKVmwO1F6lpyxVHQVFS92xsh1JyEvdz26Zr38AFyJ29iE+DQGFa0
         0p2StfvvApBYaruM7QFps9SX3ztchW9sfK9QEeSUlvoIEv9y9yYUTXShCHURY+4wIKxu
         e+4+f16N1jrnw3/xFAK/Mvqwz0fau9B+/mTyjAyxcKKEYuIRLJzn1xTchmtwcKsI3Tfi
         zERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704632; x=1706309432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyVgIYMQBw2UWRe76Yr77nhCLHUKftUbs9mM2o8wz8s=;
        b=QxrphHjHaOg5MP/pPE//oYvLJmBFDRv6m7Jz2+wmWiGzl1TSQaTi95yZxitWolAN9o
         9mylfvktoqtZVe6X9tQ685kjhfBJBZHM+akYL9E4wO7YrvT7bzZ1DprKrTMbiLCUShdV
         zHTG9x2jGho3EQNipH3eoZwEAx2TZJrWukTAxc4hCw0HEIjiYTq7YycTjH8jsPx2Kniu
         VobcNbe1Meibv/F2UqqfIqLlHs/jPpVFgCU0xP1SxQeYuCCTxg7qb+gOawjeSzFoxPde
         vXEcuNRzyGQP8LeWNFRZuLk1ArxxMi+SEstQx3yvnb++hQcIVIKd5J88lNpyPURAQb+i
         ffgg==
X-Gm-Message-State: AOJu0YwqP44MAB8qp5ZCDENJysI4gqL+E32dbhQs2k56BbgispGtZzWF
	DoOeiS2i15jG1IzqZTt2N4CoAtw2ZuoNmke22AUUgnxyW5dPqL87vsLP+S35
X-Google-Smtp-Source: AGHT+IEOOc/Eiw/EkamnAe+lELfFUahQ5WB8l3YcZNMNucutvxE4HQWgW2Tb5jKCSC5R4gUNe4uhdg==
X-Received: by 2002:a0d:db84:0:b0:5f6:e0f3:e8a6 with SMTP id d126-20020a0ddb84000000b005f6e0f3e8a6mr585259ywe.8.1705704632463;
        Fri, 19 Jan 2024 14:50:32 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b170:5bda:247f:8c47])
        by smtp.gmail.com with ESMTPSA id s184-20020a819bc1000000b005ffa70964f4sm411770ywg.115.2024.01.19.14.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:50:32 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v17 06/14] bpf: pass btf object id in bpf_map_info.
Date: Fri, 19 Jan 2024 14:49:57 -0800
Message-Id: <20240119225005.668602-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119225005.668602-1-thinker.li@gmail.com>
References: <20240119225005.668602-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Include btf object id (btf_obj_id) in bpf_map_info so that tools (ex:
bpftools struct_ops dump) know the correct btf from the kernel to look up
type information of struct_ops types.

Since struct_ops types can be defined and registered in a module. The
type information of a struct_ops type are defined in the btf of the
module defining it.  The userspace tools need to know which btf is for
the module defining a struct_ops type.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h            | 4 ++++
 include/uapi/linux/bpf.h       | 2 +-
 kernel/bpf/bpf_struct_ops.c    | 7 +++++++
 kernel/bpf/syscall.c           | 2 ++
 tools/include/uapi/linux/bpf.h | 2 +-
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1e4a05741c0d..f53d07931ad4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1732,6 +1732,7 @@ struct bpf_dummy_ops {
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
+void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 #else
 static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
 {
@@ -1759,6 +1760,9 @@ static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
 {
 	return -EOPNOTSUPP;
 }
+static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
+{
+}
 
 #endif
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 754e68ca8744..8eb949b52102 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6487,7 +6487,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__u32 btf_vmlinux_id;
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 5ddcca4c4fba..5e98af4fc2e2 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -947,3 +947,10 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	kfree(link);
 	return err;
 }
+
+void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+
+	info->btf_vmlinux_id = btf_obj_id(st_map->btf);
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a1f18681721c..05fe78ecc441 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4687,6 +4687,8 @@ static int bpf_map_get_info_by_fd(struct file *file,
 		info.btf_value_type_id = map->btf_value_type_id;
 	}
 	info.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
+	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS)
+		bpf_map_struct_ops_info_fill(&info, map);
 
 	if (bpf_map_is_offloaded(map)) {
 		err = bpf_map_offload_info_fill(&info, map);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f24d898efbb..1949d881f230 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6487,7 +6487,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__u32 btf_vmlinux_id;
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
-- 
2.34.1


