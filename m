Return-Path: <bpf+bounces-18119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AEF815E08
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D861F225A8
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FEB23DE;
	Sun, 17 Dec 2023 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgrqd/LO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830223A3
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e4ecb50894so9700087b3.0
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 00:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800709; x=1703405509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63EpXtP1JVD2Wcbe/nP8ectQQByJE8JMz5G3IRPRHus=;
        b=fgrqd/LOupiF/GO+3WAQhafz9XVRPKSBDUjip3Q0BTlYRD77WIzAbEFmRKT3vp0fix
         qfDEjhD3C4C7ikqoyhaem0Z3ahtFt2olEuSGe4/ZkO0F8E418myxwvrJIWwJXDJLlgjU
         /JaA15lUIihGbBGb9lcfLyHCSOwSw1RcSk7n0ZOQxtTscJTOOeu0jkFdFAfaTE6THIyy
         61xcla/HlKq4te56d4ptao4giuJyck//oVzuH/NSh94f/Pv6PbthYAyhoxO3PAPhF//V
         RtBjT2rWq8tTHy1M2fy0eh54mk0mPWMNwg4MNI8aakMYTHrL8SL4RVqch1n/rari+yb5
         wscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800709; x=1703405509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63EpXtP1JVD2Wcbe/nP8ectQQByJE8JMz5G3IRPRHus=;
        b=AcMFl6GtnU0uZGozemGQbfp+v2qlFtN+qD8oQQs/1Vmy365RKPNB4uR22SZc5j8Mhy
         98d2omEcTBz2//3NA8tfH8m+hiJmQEm7N39r5PpR1JWNu9NfCQYZsm7i8oHtYKz22anD
         zYUBQK4rW3+tASI9i9jfQ4JCOFsqSq0h/n8QYN64pudIkFifzxWJSxESfvy648t0KWt8
         X7L/xeDjqBvGMimCPZnJJ6icsyzTetq8Toyxwx9mfDNoeM8RB1nmEX6ot/Jq5tUrdCUT
         bcW/y09qcDtJl3OVpC1cEvtzh4S0AEfDOPo3Ar9KQctOKoCQx7E5u6TLJguEVuZx8usq
         jeQA==
X-Gm-Message-State: AOJu0Yx+K5IuYj6WqdOwJIv2HcXBDApsSooG0d91YKSz/KSmHrFkfNQt
	2RnMK68b4z5V0YaF+NRw6/ybpKNsgTs=
X-Google-Smtp-Source: AGHT+IEAhlnLA8at9FbwBg4Phu3GGSqfwEliya/RdXTDJC5hH3f80kw0Yy8Sda5XPz9fDMrpzFdJKw==
X-Received: by 2002:a0d:cc47:0:b0:5d7:1941:2c12 with SMTP id o68-20020a0dcc47000000b005d719412c12mr10889829ywd.63.1702800709267;
        Sun, 17 Dec 2023 00:11:49 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:48 -0800 (PST)
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
Subject: [PATCH bpf-next v14 06/14] bpf: pass btf object id in bpf_map_info.
Date: Sun, 17 Dec 2023 00:11:23 -0800
Message-Id: <20231217081132.1025020-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217081132.1025020-1-thinker.li@gmail.com>
References: <20231217081132.1025020-1-thinker.li@gmail.com>
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
index 432f37c979ff..469d26d27e64 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1740,6 +1740,7 @@ struct bpf_dummy_ops {
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
+void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 #else
 static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
 {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e0545201b55f..7ab00babcccc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6529,7 +6529,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__u32 btf_vmlinux_id;
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 2b0c402740cc..679bcdf763ef 100644
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
index d63c1ed42412..54a97c269e7a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4726,6 +4726,8 @@ static int bpf_map_get_info_by_fd(struct file *file,
 		info.btf_value_type_id = map->btf_value_type_id;
 	}
 	info.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
+	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS)
+		bpf_map_struct_ops_info_fill(&info, map);
 
 	if (bpf_map_is_offloaded(map)) {
 		err = bpf_map_offload_info_fill(&info, map);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e0545201b55f..7ab00babcccc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6529,7 +6529,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__u32 btf_vmlinux_id;
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
-- 
2.34.1


