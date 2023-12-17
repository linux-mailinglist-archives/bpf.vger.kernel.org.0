Return-Path: <bpf+bounces-18115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9D815E01
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C526283C25
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5F1FBB;
	Sun, 17 Dec 2023 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0FNMV44"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132C1874
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dae7cc31151so1347235276.3
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 00:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800703; x=1703405503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4WcsjdsJ96j5IW78hLIoFA0V80WDEstbqvxVGpI+zc=;
        b=L0FNMV44DgZQLd5ChTtrN4SQeRG+Hi4JuN32cX4xhADxHZ1IIkPu9705enjSmDKUd2
         vKOJvWeJEkOZa0SStb3DHlzZLmy5DMPv45vQLaBWHprvu0GvRoWsf4ZnOG9kNB48+8vA
         ql6Pa8z5LVG6a2mXcN5p07tSceuNCc3RZYtg6QA0jbCova+ESorYle98ewxn/kVZtucW
         Qdtd2nyLKVO/OJF+J34a9qoH1lblRJwV73DtGRqLRk2C7A0ymrG0bEV1jt0vvx68rfw3
         BhvbqWWP7C1oaeuUWeyKH5/wFzipOZCbbp2AcXjBlAP9nG9ubutmhLi9Z3p4EEqx3k+9
         lRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800703; x=1703405503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4WcsjdsJ96j5IW78hLIoFA0V80WDEstbqvxVGpI+zc=;
        b=bk8S6twQCP/GOhYYLhjCeq3uljw1T2X5aVyfJS8t8ntKqlusRumwJNsjeTvxjeLUuw
         IC+8KqVe3T7+noa1P3QtrqWdddytWp47DjTPZmzhexXner7dni4vmNNldPJOl1IHPK7S
         KgrSuEEgCIoDCeIgyF2wGOdEZ/Q4FFhG9KI24gLe/HzRgGY90WO/Y8VgQcHexul0V54u
         Hb4Bp2SoBiGldF+N8Up/QfXA5CK/NqQvkxytv2jX55r+QTAxYUEYYjWADHcbKYcWdPQL
         oIVhJujxrQMz1/m+HozoCWzmXDBCqGURF8Wr6GxegB2l2As+V+Dab+Btqu4yCE8rtVbh
         z87Q==
X-Gm-Message-State: AOJu0YzTKS++UugeaM46Xu4i1otgffdPLUw1QnV4jXE7gGnDv87U4qr/
	6mp40wUQ0VCDX5anT91ohBsDivp10LY=
X-Google-Smtp-Source: AGHT+IFP/YxNLBowlztwHSGDdW/gTpU6jdf3OdcCHpSxsNVbHqZcvzb3m4ywSx08jgjt50M79ZBMRQ==
X-Received: by 2002:a0d:d793:0:b0:5e4:d126:28dd with SMTP id z141-20020a0dd793000000b005e4d12628ddmr2387595ywd.44.1702800703639;
        Sun, 17 Dec 2023 00:11:43 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:43 -0800 (PST)
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
Subject: [PATCH bpf-next v14 02/14] bpf: get type information with BTF_ID_LIST
Date: Sun, 17 Dec 2023 00:11:19 -0800
Message-Id: <20231217081132.1025020-3-thinker.li@gmail.com>
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

Get ready to remove bpf_struct_ops_init() in the future. By using
BTF_ID_LIST, it is possible to gather type information while building
instead of runtime.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 5714e7e54f9c..9f95e9fc00f3 100644
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
@@ -388,6 +385,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 	const struct bpf_struct_ops *st_ops = st_map->st_ops;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
+	const struct btf_type *module_type;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops->type;
 	struct bpf_tramp_links *tlinks;
@@ -435,6 +433,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	image = st_map->image;
 	image_end = st_map->image + PAGE_SIZE;
 
+	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
-- 
2.34.1


