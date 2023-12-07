Return-Path: <bpf+bounces-16961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB459807DFD
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7B41C2116C
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C0617E6;
	Thu,  7 Dec 2023 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqq/RW3h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C838D44
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 17:40:08 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5cbcfdeaff3so1623997b3.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 17:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701913207; x=1702518007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km4TXXSd+uwocwonn71lwEI7U13N596mmYzVO8jal0Q=;
        b=bqq/RW3htgUrRrqiDRN07bqD/t3gipiv852cFOjXAqqzDbSaJ5Ep/fDmAeq4v8tONn
         XRdBT+gvYNWXXb8yAcxrHlic5mSyCsh3RlbbRcSPLgY5d/yhIi0PRErIexRM1t0WwwVA
         J0lwuR7xHSDbCgyBfsgj8g5uZRKwpKljZEh9zoopenQK7rUS/zkBV0wxgXdVmnj8tJI7
         s0KDWFXvh8m6xh434kAxxk/5VybXWKYA1mo2qMeaFr7XbKkgFWiGffqqlIi8SjbnC0P5
         R6KfsLUvTikdUcAD2OtRzNT2xlnaw9cYlT81NrjYb2xUks6G/4ouob54+B9/NSCyCH52
         EWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913207; x=1702518007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km4TXXSd+uwocwonn71lwEI7U13N596mmYzVO8jal0Q=;
        b=qiwVCR774llPYCLPROJQCrrLN3ojSakOcSPXQOS0XsLBkLGKeKRcNnDTb0VafcxeeN
         M2wIpW0LYZd8BImZUxra32LhPK/5OXbGusFhaqfkmBgbroAMsy03v2FgrU4TJKFXvCZX
         xtXVkXEtS8YbqXiv8oCfSRafysDum53O1GowODuwscZ/p9BvyqN9t9VcyWGEfABwz2Ng
         dj/otoz/q7i0GmeNxHHs5/VsiRGINLYU20xDCtiYn1ZzMlVJc1dwkAx5/e2l8Z/er6nL
         hwJ3XTMctDPCEE0+nhJiU77unowx9SV8UcnevGNHig40fbFuOYAJk+J5umw/1bfzayk0
         emAw==
X-Gm-Message-State: AOJu0YwmhgNpiZuAng6qsK7ph/EpXFqwacwfMDeynYvZN9crIXmCDi8B
	Pnr80bw87VYJqyTFmdZ1p/fYYR9ExDU=
X-Google-Smtp-Source: AGHT+IHoPKTzSmOGvUQL80R8cUAkqwVYUCgSjowDCWWs61TDDrMiJiRmyVoTrV1Yy6tog5u57p1U4Q==
X-Received: by 2002:a81:af61:0:b0:5d2:9344:e623 with SMTP id x33-20020a81af61000000b005d29344e623mr1663338ywj.40.1701913207016;
        Wed, 06 Dec 2023 17:40:07 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c8f2:3a3b:3003:f559])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b005d997db3b2fsm60768ywa.23.2023.12.06.17.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:40:06 -0800 (PST)
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
Subject: [PATCH bpf-next v12 02/14] bpf: get type information with BPF_ID_LIST
Date: Wed,  6 Dec 2023 17:39:38 -0800
Message-Id: <20231207013950.1689269-3-thinker.li@gmail.com>
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

Get ready to remove bpf_struct_ops_init() in the future. By using
BPF_ID_LIST, it is possible to gather type information while building
instead of runtime.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 813220c58cd3..409ab0327469 100644
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


