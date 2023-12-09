Return-Path: <bpf+bounces-17292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB280B101
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52207281C90
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDF187D;
	Sat,  9 Dec 2023 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMED1TCw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2A91723
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:32 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5dd3affae03so26694987b3.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081651; x=1702686451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsG6FGyrNczTTIsApLKp8t0L6LgFXKoLzWdNL1M+7v4=;
        b=FMED1TCw8b+ng1oNoHh24dJxSco6WwrAAE5/sUr0fcIjltt6368gL0EqbdtJVlMchI
         qQqSZTPtuwEhuZrgdAEriI39tFplDYuo8qbQ5iqvuVI1TdpWLAjsBpi1FEJdweUySmO7
         VFrZd947NIY6iFasjdAlsqG81RBGmRESuf30DjP8sluPob0H3EN8BAHEYncYyRe7A3Q8
         66I0ECUJ9YEl74AkGGbp+ANnVmQbjyJWhp1o8s6sbptUflksiJ3Mdp/UeS/AOlB14wJ8
         oTS2Qi7Dd2i8RGMqeTY+l1ANaWet+P6tk6B6Zddz2vgcTkK2fLVBskEqnTyw1FANWpA7
         eLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081651; x=1702686451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsG6FGyrNczTTIsApLKp8t0L6LgFXKoLzWdNL1M+7v4=;
        b=p/RMrUdGB1q1a7rRM6jn4BWlWgY5YciQRtC3Xvtyczu+Y7jhqeug3QwwrLDhQE0JBV
         d5HKlV2LPjPhNr2IUwx9w/flI5yZsPFleNFKVBkpIChb6kQi3b/vRHzoHLNVwaxtCAPD
         ErSSqO+uzi1/xhgMVPFhiygJLJN6r5wq0dmmSarD1lLajZJJT/gQQGNYqNMr6U1Gv2ws
         hC+8HYtW8Favc1awJpON+Ch0tCIANcuPxgp+Tp5Lm/0pNHtzrKraW2rhv0uuxWjL3FRz
         aV5M9KDReupqFIQkzEIWkQZsfKm/2FV5d5qo7USD9q1SshcKXD/yIE5QQVvWIu57tlql
         ZNEA==
X-Gm-Message-State: AOJu0YwHJttMZU5AIiKLVsfUorrLyen1Vdu2if7+j21OAdxPqTsYj1UP
	S4G57kk9oOmKFICu+em+ExEILYE8IfUCHA==
X-Google-Smtp-Source: AGHT+IFk18jPoI9B7RmsIMRiAR3BquIL9UsIxSJDJpKi2GMV8JSUpMwPwDuJkU8RH9cZhi+4aK3MKw==
X-Received: by 2002:a0d:c6c5:0:b0:5d7:1940:b383 with SMTP id i188-20020a0dc6c5000000b005d71940b383mr758923ywd.79.1702081651012;
        Fri, 08 Dec 2023 16:27:31 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:30 -0800 (PST)
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
Subject: [PATCH bpf-next v13 14/14] bpf: pass btf object id in bpf_map_info.
Date: Fri,  8 Dec 2023 16:27:09 -0800
Message-Id: <20231209002709.535966-15-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209002709.535966-1-thinker.li@gmail.com>
References: <20231209002709.535966-1-thinker.li@gmail.com>
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
index c881befa35f5..26103d8a4374 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3350,5 +3350,6 @@ struct bpf_struct_ops_##_name {					\
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log);
+void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 5c3838a97554..716c6b28764d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6534,7 +6534,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__u32 btf_obj_id;
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index fd26716fa0f9..51c0de75aa85 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -979,3 +979,10 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
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
index 4aced7e58904..3cab56cd02ff 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4715,6 +4715,8 @@ static int bpf_map_get_info_by_fd(struct file *file,
 		info.btf_value_type_id = map->btf_value_type_id;
 	}
 	info.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
+	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS)
+		bpf_map_struct_ops_info_fill(&info, map);
 
 	if (bpf_map_is_offloaded(map)) {
 		err = bpf_map_offload_info_fill(&info, map);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5c3838a97554..716c6b28764d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6534,7 +6534,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__u32 btf_obj_id;
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
-- 
2.34.1


