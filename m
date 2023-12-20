Return-Path: <bpf+bounces-18443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15AA81A925
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 23:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5FDB210C9
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631CB4AF63;
	Wed, 20 Dec 2023 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6rPsay8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA774AF64
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e7409797a1so2480447b3.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 14:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703111220; x=1703716020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDr+NjtX2UDLWx9szIwoRGkmVQoh5QgUN+RdNYwqcvY=;
        b=e6rPsay8scYC4C+kuhj2QHRu3Ieb0FO2GcegbOKVb0kRqqPmZStQZ79011Lo7i0y2p
         YbW7cnNQmajmOBb67nmP3jKL75yOvc1/8k6IYyvhSHA6zFXyYy65RPrjHvEBRYhNaTkU
         x7ENxs82c2sY2i0GFTiHPfPu2FLUcarzjr6nr39woQhh8dsZ1otsvwYF0Z84qVWI/qt6
         IsBsTHQ+QOkyeUcIHZteVs3CJ/pmp6BElgqIysDgZIzorBA1B1IJTJSOm/3nph8dQ9kD
         gzaK355eLk9mXI4TXCdHvr6V5im3yjv6oaQsoV0XAHoFg8PTqUzKqIJo1SSKrWQmsZ6a
         M/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111220; x=1703716020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDr+NjtX2UDLWx9szIwoRGkmVQoh5QgUN+RdNYwqcvY=;
        b=Sds9/d0eYmsr5ehkUYqDNPoSV63oezlAWfhu4ZMXihLKITX1tXoWunDaBCzsBZDKxL
         XPwuQVrR7Lx0rlGpybMvUNtuPdFi+GIlwZZzn56QohAA8j8+mf4fNY3XkqhDg2ZC4+8k
         SjpRWZKcTj8jEC0ua5akt2EnBMyCMYigT7yzjADZERUapSLVEl434j46UcSGQge+LPTt
         dXW27WLUwpcsk8vMXRfbsGnU+PiY5SLvsPebv6N02GtemvlAdvHyMs8wjEmzMEV20JuF
         NOU0xZ51kiYxa0zpdmR+J6es4XWXy/2yxI0EoO69+KGpqZc61xOfer28Adzwp3FWSsUJ
         /j8g==
X-Gm-Message-State: AOJu0YzwC6QxCV9o4MTPfEEJF9VOMGKUJH4zkNgHzN4yix4CfPP5drOD
	LuDMlqvkaJlbRHGZVYvuSHpUXW/Z2Nc=
X-Google-Smtp-Source: AGHT+IEBHgx3p/CSlPCQYKyBbZ8Urmy2ZYZy+xFoPrTlDbWLdvFawjbNSRBds9E+J/TY+h9fZWkbPg==
X-Received: by 2002:a81:5406:0:b0:5e8:7677:f244 with SMTP id i6-20020a815406000000b005e87677f244mr493875ywb.43.1703111220051;
        Wed, 20 Dec 2023 14:27:00 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8cc1:afcb:3651:3dad])
        by smtp.gmail.com with ESMTPSA id m125-20020a0dfc83000000b005ca4e49bb54sm284304ywf.142.2023.12.20.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:26:59 -0800 (PST)
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
Subject: [PATCH bpf-next v15 02/14] bpf: get type information with BTF_ID_LIST
Date: Wed, 20 Dec 2023 14:26:42 -0800
Message-Id: <20231220222654.1435895-3-thinker.li@gmail.com>
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

Get ready to remove bpf_struct_ops_init() in the future. By using
BTF_ID_LIST, it is possible to gather type information while building
instead of runtime.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 96cba76f4ac3..5b3ebcb435d0 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -108,7 +108,12 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 #endif
 };
 
-static const struct btf_type *module_type;
+BTF_ID_LIST(st_ops_ids)
+BTF_ID(struct, module)
+
+enum {
+	IDX_MODULE_ID,
+};
 
 static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 				    struct btf *btf,
@@ -197,7 +202,6 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 {
 	struct bpf_struct_ops *st_ops;
-	s32 module_id;
 	u32 i;
 
 	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
@@ -205,13 +209,6 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 #include "bpf_struct_ops_types.h"
 #undef BPF_STRUCT_OPS_TYPE
 
-	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
-	if (module_id < 0) {
-		pr_warn("Cannot find struct module in %s\n", btf_get_name(btf));
-		return;
-	}
-	module_type = btf_type_by_id(btf, module_id);
-
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
 		st_ops = bpf_struct_ops[i];
 		bpf_struct_ops_init_one(st_ops, btf, log);
@@ -387,6 +384,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 	const struct bpf_struct_ops *st_ops = st_map->st_ops;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
+	const struct btf_type *module_type;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops->type;
 	struct bpf_tramp_links *tlinks;
@@ -434,6 +432,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	image = st_map->image;
 	image_end = st_map->image + PAGE_SIZE;
 
+	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
-- 
2.34.1


