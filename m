Return-Path: <bpf+bounces-13823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E77DE6D2
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B901B1C20E1D
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 20:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81441134C5;
	Wed,  1 Nov 2023 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljfpt0+z"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965ED12B82
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:45:29 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8FC10E
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 13:45:27 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso192735276.2
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698871526; x=1699476326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hs19EOGILeVA5kNR+qeDJ5sjXf2T5Zz5YM5X3zU6k8=;
        b=ljfpt0+ztCKYdSUorm8+Ns0fO6fUwppRnqjJ5tTE2/bmPF+WsP4XvI1DvKLHVkWJsJ
         aaHtadwxDSPdXg5nJH6NSGT//Rr0TJeza1LIMK0wfwrgI2PGdKqW307Z2KoHZ/snepMd
         y6o0HNDqvUUmxRz2iuagpc+z64+eto+rvneIgfUdJdnh5MaawxcTH2fK29bWGkmVXwoc
         OV0bTQzMr5Bg6zIBnXzcJMq8GS3lMEceBuWu68aSKZ08Ci8NniUDlRE8sqKXEfcK7By1
         r+DZwhFWrmntSjiwI5nJB2tTVy5P9Xqo703MY27MvJXXejBgKg+jcHL/igQ2noKdRfRp
         9QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698871526; x=1699476326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hs19EOGILeVA5kNR+qeDJ5sjXf2T5Zz5YM5X3zU6k8=;
        b=rO99cSkrLbngTBbwr2plFt3GPWGHyxMerL8+ImQZblnx6zykrphEFYDdHjh75J7qb3
         Wn8zQNqFz08Y3UvR2XJXY3C2myEePkwsxjtUhqXNbqWFhC2Wwx+eurz7mMGZjV7FVqO9
         CIeVhlo9j3w3RAfsSWC77/rw939pZHZXjgq9Wy7BWk7OEK+wNzsAwWR8+S6ZKZla24k4
         pBpVbCUcuBLEV0J6x7RjU+wNG9a5AZ71JMpLMf8ry+V26lfieoYC+bRWc9mVpeop/AFi
         SX9IBwSNDCLzCIMj2TiIzwot2KZqEys6MlT7tWUN8cZrWNSUvWscGjP7AQw5RyVZmvhq
         ZvUg==
X-Gm-Message-State: AOJu0YyZz9G5bqeCHzSzgGH/On8vm9X9s2EWJIhYrXvVQfabbYv8nsOM
	apCJqBDrv4Vshv2sQm53nzd6dxXz+AQ=
X-Google-Smtp-Source: AGHT+IEqRJtWjH4pIgLG++HJM8H8sS987aqn28UQrarCn47qnRUFAUBfxp4uTFrH/bfE/Vlm+89ruA==
X-Received: by 2002:a25:f512:0:b0:da3:ab41:33c6 with SMTP id a18-20020a25f512000000b00da3ab4133c6mr3781719ybe.65.1698871526475;
        Wed, 01 Nov 2023 13:45:26 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:eea0:6f66:c57d:6b7c])
        by smtp.gmail.com with ESMTPSA id o83-20020a25d756000000b00da086d6921fsm342386ybg.50.2023.11.01.13.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:45:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 02/12] bpf: get type information with BPF_ID_LIST
Date: Wed,  1 Nov 2023 13:45:09 -0700
Message-Id: <20231101204519.677870-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101204519.677870-1-thinker.li@gmail.com>
References: <20231101204519.677870-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Get ready to remove bpf_struct_ops_init() in the future. By using
BPF_ID_LIST, it is possible to gather type information while building.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 627cf1ea840a..4ca4ca4998e0 100644
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
-		pr_warn("Cannot find struct module in btf_vmlinux\n");
-		return;
-	}
-	module_type = btf_type_by_id(btf, module_id);
-
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
 		st_ops = bpf_struct_ops[i];
 		bpf_struct_ops_init_one(st_ops, btf, log);
@@ -381,6 +378,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 	const struct bpf_struct_ops *st_ops = st_map->st_ops;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
+	const struct btf_type *module_type;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops->type;
 	struct bpf_tramp_links *tlinks;
@@ -428,6 +426,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	image = st_map->image;
 	image_end = st_map->image + PAGE_SIZE;
 
+	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
-- 
2.34.1


