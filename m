Return-Path: <bpf+bounces-17280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31DE80B0F2
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47641C20BC4
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E9810;
	Sat,  9 Dec 2023 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNgMruqE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54881738
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:15 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d77a1163faso20608437b3.0
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081635; x=1702686435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQ882GQwuYeEMKBt97e8U9tmg5pMnTPPfdQENCg/vVo=;
        b=bNgMruqE8qY4zpx94sMAeZFbFWt7Ju9ZJbTW+gMA/nx9H7X46Zojo4NBXuhAGKHQAk
         1fJt7sbbLxZAuxpJob/SVP1l7msUehT9zDtG2YyHFg+ODWGnlYOClv0WiVYnQTTURVLU
         tPocGYoLaZmhccJrMXLOUXRyGa4JTaoktlPUgTRaajC1sOMGDe27z30ZU8gOgJnHHHlW
         bzsNCFOpScJwo/c3tgxs3ssa4BB+w7F6bhzoEle8u61o+P6so9Zz2O+ZBjLvG6uFS58f
         QrLdsub2qMT3Ljk1dtfdmmmYEeEyQaB59U7+4JthJWS2kc9X3uZSjHzVLoJl8koEQNOi
         Op5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081635; x=1702686435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ882GQwuYeEMKBt97e8U9tmg5pMnTPPfdQENCg/vVo=;
        b=a6eA/EqHauTazOY7dr2/ELb0WxJn2fxXs6K2oK04DnmYHnb7c1e8sAAmf+fH6NY/a1
         X4z8Pz8rRlrNYl9EOFRPSbvKk8VqE50TMMraK8ZBBXuiJ81PtWBhtjrvUucp9aDjX18C
         l0gZUnLie/dG4LD9RBSzZwHqIah9x1QHqp1J+XkZKyqmGKimjkiRARqtdnUr+GZ+Ys/C
         X44AAmYcD8bqVopKIJJmqU/TlCQTB0iZprJqIU8aF4wCG5z8vItY379AU7oJ8wZjZkh/
         YS/Jng9tOENfKZ/L3+jrDwui5OTJNH+2SRqRckh1x7qo3FYxdKJ6k/ai38uMHoxsABv1
         Yi6g==
X-Gm-Message-State: AOJu0Ywn5CNuzcgfrTVeO9dEbVQy/3+XCpgYsAjLmfHjJ3J3v9nZ4SMf
	xM5GftOvCQPeenVROI6o8Ocx4xR459rbcA==
X-Google-Smtp-Source: AGHT+IHg07SmBDSjabpvwe5D1cnfKjTUNoTOAD/jnQIsZMSw/KzHd2nQ8TM/5iqYahEp3rti/rdCOg==
X-Received: by 2002:a0d:eac1:0:b0:5d3:f9b6:34ea with SMTP id t184-20020a0deac1000000b005d3f9b634eamr970135ywe.17.1702081634788;
        Fri, 08 Dec 2023 16:27:14 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:14 -0800 (PST)
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
Subject: [PATCH bpf-next v13 02/14] bpf: get type information with BPF_ID_LIST
Date: Fri,  8 Dec 2023 16:26:57 -0800
Message-Id: <20231209002709.535966-3-thinker.li@gmail.com>
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

Get ready to remove bpf_struct_ops_init() in the future. By using
BPF_ID_LIST, it is possible to gather type information while building
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


