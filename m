Return-Path: <bpf+bounces-19779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078DC83110C
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6811F22A20
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB36B53BE;
	Thu, 18 Jan 2024 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjrNvu7q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A266106
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542598; cv=none; b=q2et7JKqWFENF0T1ItEyu80nAinhdRVXRU+QdmdbUmc2RtWbogW5gm+vqj3QCsqvBU6ky9/B2IjAjWc9K/bMGOMG5SXvAdEPgOSolMrQ0+CbNQz8FOnXu+p7ve++l7gU0mypWau3PiEddBovvAekarASSdEe47hj1sdFFTtIp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542598; c=relaxed/simple;
	bh=IOkgiO07bBK/wrJ4r9fDxQUgBloiAHVwSLk7tTq7/Os=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=hexM7aVmgXTBvnhc6lNv1YGdgiljBZy4+s2/gt3aseukU8dmvttOMbKUVN2dhrTi6M+b5rJgaG1jLhOcMcaKOVB4uhe4zN8SfScNhwYqrQMgqOBb8JK1ZJY+rmiPpgGYK82ZeV41hAQtod0J017WkF4ArIRiF5B1AX01cozUeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjrNvu7q; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e54d40cca2so91055987b3.3
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542595; x=1706147395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOEWFr262czTiNDRv4aa6h4SqGe3Y26acn2oWpaKI20=;
        b=OjrNvu7q7FFi7C4KFCWljTF4FxWmRzB2zLDmXXSSU6kMIcC+D1cbBa3qS68tW+fwYm
         Gxmu9326GK2F/Ks03hku198JU8ukggL5wswukdWg2i24L3+HQqLnsa8JDjrJg8VtoYfY
         +bnwPWsM2nLio6H7gQjQvQBqEz41zSdxvhPHcqUie5Rmm1KcVApH7MzYrZ3RdkFKI5lT
         XmxGe3q37bDMg0uNrOBDt02dcUW/ispWQRMAzQTdFq3jVmwJfnnwkjn2+1WaX4JTgcRm
         1PXlXXPadvO+pjJXBWEKAB4a00H1XcKpnuACAuji08cqBYKBXbHIxwhSqrQLmajM4Nci
         pEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542595; x=1706147395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOEWFr262czTiNDRv4aa6h4SqGe3Y26acn2oWpaKI20=;
        b=sDReBo1qCiKIgd5vk4foP2l4/rYO0WzuCP9OgGWsS6e8fseTwktRVK8oeBozK8UAih
         HEinhOpmW9DJh2jryTKlZj172SLdqutMUQvCY1RtJAJut+xFymXERlabQcD6q8NigTaI
         TxqzY2vW77p+fQ4oI7y30P74jqri/yN1V3ngy8UV1IHOYhcIEQ9Kly7BYGJAxxEpUzML
         PhKWpFTaeNSYpgQiOFDs1sX5FM+83LA1EbIN0Z7ugjGPLtGrBhZoUVer4xwh3Iid2jEW
         iJZFg2eHiEZFKWnvfNHTkBO4YB6zmrrr07+yR1Y+fsNaHCLzaGcvYu7dpB1ALq/NP9OZ
         7Ruw==
X-Gm-Message-State: AOJu0Yw0KtYyH+ierl4tKsL5+E7rxVC7lMJcvp9GihLLcs9cp2KlYbWX
	prw7oiYSzFX0AKZ/zGHbQtYb08bzUy59vKGYnnqu8odeIMOpl4/hIVCXHw1J
X-Google-Smtp-Source: AGHT+IHRGt3aedlVoJa2qLqspyceUocMHB4QDeiaffKxwTteV+pDjoe0rPEQ6z77nvdjbdpuunHtnA==
X-Received: by 2002:a0d:d5c8:0:b0:5ff:51f1:c2 with SMTP id x191-20020a0dd5c8000000b005ff51f100c2mr85410ywd.75.1705542595578;
        Wed, 17 Jan 2024 17:49:55 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:49:55 -0800 (PST)
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
Subject: [PATCH bpf-next v16 06/14] bpf: pass btf object id in bpf_map_info.
Date: Wed, 17 Jan 2024 17:49:22 -0800
Message-Id: <20240118014930.1992551-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118014930.1992551-1-thinker.li@gmail.com>
References: <20240118014930.1992551-1-thinker.li@gmail.com>
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
index ed4352f56d21..1e969d035b42 100644
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


