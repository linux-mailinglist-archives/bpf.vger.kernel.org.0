Return-Path: <bpf+bounces-16974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFEC807E0C
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611DC1C20C48
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2AC5687;
	Thu,  7 Dec 2023 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwr14O3T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA635D5A
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 17:40:22 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5dd3affae03so1671317b3.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 17:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701913221; x=1702518021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BobD2h4ZSj1BUjb0ubp7sA/n0IgqP6CMYXGNQ6scVwc=;
        b=Wwr14O3TY8MXyj7nN4Dgw7pRHc9stZj1QDXTpdDNeYqHP4VBBzm2FEJ2h3kU8VLvkX
         rmboVJ5Kz7c1UxGDLl/N0/yEN9E5uCmGi7Ml7TpR14BJtGHfE1NuI1Ws/ZwgiT1Vnv6I
         0wF7lRlNnsahBQvxIf4fygAtrQSoIkqhbwCegU3HGuRG2h4JBV4LePkxlw2oJ8N4GcSB
         nldRdoS8t3X6xXNs6G4CYeh6GkazaIe8nvUXvj4AD+qGpbkFcRXTMtCtmAdbtOwKA03h
         FH6M3iMxmqrgXZNL2hC96rZQ+tjNfYuXiDqHT0BF9yluDeCH+rPfFBFDpmVjhxZrQ1KN
         REDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913221; x=1702518021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BobD2h4ZSj1BUjb0ubp7sA/n0IgqP6CMYXGNQ6scVwc=;
        b=TvMDhoDXfc7eXgy7NNTXT9uNtOItJx54IMA+pmMmvC+b7AAKrx1COadh76AXAKZkM2
         7Mi4HuPndRr8movuy9wX8adBH2lNsH5n8pR/ed/mPPFU/NcHnQDEegnvwMf7qZkJe+Gu
         fRiIcnuFqrQgx839bov7dPfp9/3tUpK0Qj9WEdwd8aOtKWh56puXZWNZJn5uJJPqIBnC
         SoFqOLylpAGrOF9Bf0XnZJURhZUiHedAOU4+STeGQFasvCWwb2C11DuwRiM00o0M1mX2
         JeXyJmpegfbvJktWhNjeWQ5dfShbO/vUlJxvqfDKy/TYR+FivGl6M/LUXAOXNfbbLp3O
         +dSA==
X-Gm-Message-State: AOJu0YynumY+OzC6HqBbFnNrofUKOfZqlU030Df7lVsntFNX43I7aT59
	xHUkaiUyTpYzXf2/xfR6fKLi1OKOTLU=
X-Google-Smtp-Source: AGHT+IG81kyFuxRKPaWqLkO2c0KxEyFWWd3aAgqHOUy6vVxfXLBSKfwEJpho/bwJ5M3VwlMxSCp5FQ==
X-Received: by 2002:a81:ac23:0:b0:5d3:c27c:8047 with SMTP id k35-20020a81ac23000000b005d3c27c8047mr1566687ywh.1.1701913221539;
        Wed, 06 Dec 2023 17:40:21 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c8f2:3a3b:3003:f559])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b005d997db3b2fsm60768ywa.23.2023.12.06.17.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:40:21 -0800 (PST)
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
Subject: [PATCH bpf-next v12 14/14] bpf: pass btf object id in bpf_map_info.
Date: Wed,  6 Dec 2023 17:39:50 -0800
Message-Id: <20231207013950.1689269-15-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207013950.1689269-1-thinker.li@gmail.com>
References: <20231207013950.1689269-1-thinker.li@gmail.com>
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
index fdfceae25e08..1cbaae59215c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3268,5 +3268,6 @@ struct bpf_struct_ops_##_name {					\
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log);
+void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8e5a188e2883..0d3262bb4dc0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6490,7 +6490,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__u32 btf_obj_id;
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 9ca166c79d19..3aab2efa855a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -974,3 +974,10 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	kfree(link);
 	return err;
 }
+
+void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+
+	info->btf_obj_id = btf_obj_id(st_map->btf);
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6df7edc4b5e3..9e8847ca8962 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4621,6 +4621,8 @@ static int bpf_map_get_info_by_fd(struct file *file,
 		info.btf_value_type_id = map->btf_value_type_id;
 	}
 	info.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
+	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS)
+		bpf_map_struct_ops_info_fill(&info, map);
 
 	if (bpf_map_is_offloaded(map)) {
 		err = bpf_map_offload_info_fill(&info, map);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8e5a188e2883..0d3262bb4dc0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6490,7 +6490,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__u32 btf_obj_id;
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
-- 
2.34.1


