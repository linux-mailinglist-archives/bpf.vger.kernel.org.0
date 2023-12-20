Return-Path: <bpf+bounces-18447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6181A929
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 23:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FA41F23FBE
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 22:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6B4BA8C;
	Wed, 20 Dec 2023 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg7FKwEa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5EB4AF64
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5d33574f64eso2288747b3.3
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703111225; x=1703716025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBckEIyOqZvZi8R62hE2+xzlmO/rkSDYaY/KvybsdI4=;
        b=Yg7FKwEasbyQfmZWbB8kS/qSA/nWgseA+LyarTgPtuTesaUf7PYYfpIIXWzuUoFKBL
         l1qUZGXiKvCuIaqr5qF4bxxjc0l0Uhs2zRDmRe9WKpp7NhL66K1o1YfT/U09kgMfnTLR
         tQ+iq1JgudUa6bqLymYF9R0MBRl1bDk6pxXO/SDn5lQEdc9pRLoLTdP4vOYx1ub8t3Vj
         tH0UgiKI1G5+9bw4bIy81NeykR3XjPgZcBn8ehAglQTP8ZFG4WWeK4Y0DbjPoxJddpdM
         +rOArDr/GXQUyU3sF8H49SqoZNUjnubiYWymBjJtmnRDXdWa8YWLXnMKoHfAVqJdtuPJ
         UYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111225; x=1703716025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBckEIyOqZvZi8R62hE2+xzlmO/rkSDYaY/KvybsdI4=;
        b=ibv126vfufPXQi1yn7dn8CGffNMMumhNPp17Bgi67CCbmiRoKvrXip0IMWmPIBab/s
         I5b8rhVBjJHk+3MarcUesnB7UnxkiiKk1uuOs2kg/OnTIM2iyVzlIJbiWm/ojG4gruHq
         mhJ+7q6BKqy+oSNaU529QbPcMNYHxi4pZeuY7InO6mgTwWN1IMcKjxa7sZtVjzu0B5FI
         o092DLf7TXdRyw1UuL0ZDsW7J2yGG7zqRwLC6vUeW3CAaYbJMora38Mma546SPfPJp4W
         qP5nxuTfbl6sJpDtnWd/4MZEGd8haHKNZr6mY6E2p5JGHbQzDvF15oasKpZsLxhY+uh0
         LPbg==
X-Gm-Message-State: AOJu0Yx2ates4s6UQIWxnZpuGHFI0MYbGHvGSmmUiRQ6ohZiVjzLZ6g+
	L2CqRwz3HvQHs3rjCo8KTo9TnXNVN1s=
X-Google-Smtp-Source: AGHT+IGgQIRxTmFWSeeBgCSEofXtfesQjTYxUv5D1UUOcLZDYizrf6A7YjujermchKJ4jZi3OgUU6Q==
X-Received: by 2002:a81:4914:0:b0:5e7:a909:fa00 with SMTP id w20-20020a814914000000b005e7a909fa00mr446327ywa.29.1703111224778;
        Wed, 20 Dec 2023 14:27:04 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8cc1:afcb:3651:3dad])
        by smtp.gmail.com with ESMTPSA id m125-20020a0dfc83000000b005ca4e49bb54sm284304ywf.142.2023.12.20.14.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:27:04 -0800 (PST)
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
Subject: [PATCH bpf-next v15 06/14] bpf: pass btf object id in bpf_map_info.
Date: Wed, 20 Dec 2023 14:26:46 -0800
Message-Id: <20231220222654.1435895-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220222654.1435895-1-thinker.li@gmail.com>
References: <20231220222654.1435895-1-thinker.li@gmail.com>
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
 include/linux/bpf.h            | 1 +
 include/uapi/linux/bpf.h       | 2 +-
 kernel/bpf/bpf_struct_ops.c    | 7 +++++++
 kernel/bpf/syscall.c           | 2 ++
 tools/include/uapi/linux/bpf.h | 2 +-
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fd2506385dd9..240885fffa19 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1731,6 +1731,7 @@ struct bpf_dummy_ops {
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
+void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 #else
 static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
 {
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
index 1bf9805ee185..44b07a08295c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4657,6 +4657,8 @@ static int bpf_map_get_info_by_fd(struct file *file,
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


