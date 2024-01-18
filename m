Return-Path: <bpf+bounces-19775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B0831107
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0146328782A
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB5F33CF;
	Thu, 18 Jan 2024 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZM42qMr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2428FD
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542592; cv=none; b=jo8GLPJHWqBMweYr6Yrk0JDC5lvQSI/pJsZxZzzyekxiHdKhJP7YDR8HpksoDuj3TTg0j/AZGaJ0gjx0mwhpj3VAVLF33QVdTKEawg5Ch58gAaCkCTHn7WXmf7N2G1TEufdEav5pFxLaTUpXcHgtygqs3N90MIqV0C1vve80Rv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542592; c=relaxed/simple;
	bh=95a0yqhJqEJ2eSnmB0Bwv/kLPu1mLnX1I+z6KNpil6k=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=IVXT65PbKqlNzqo45O498LVEksFo4ILvvEpPZrm1OJPrIaQ5a+4aVutpRjF5lsoQllonD46kKdSWzXllwqMJHYYM9ImMAZT+QdwqfHY0ULrzB+xaYKqnLohY1aW2l5AZPz3spiFjizSDJcB+s+gjoTebjjLZqz03FaA7IlL52Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZM42qMr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff6d3504d5so10993187b3.3
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542590; x=1706147390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDr+NjtX2UDLWx9szIwoRGkmVQoh5QgUN+RdNYwqcvY=;
        b=hZM42qMr/7vBoofNyCakWAadJiT6QAUDG8BJHs8x0HHE0HQoKo5eBLKMacWaoucU00
         2IkS3a0y9vpw3EISLH5zC0V3hRE3MlA4FoDEMCXW//Tm3/VLakGk1a5+8t1bNsKomCNM
         3SIlf8UAled9eRxHino0MfqgjHKK2hasfvzTOC1xZyYcLxyRm8dClrXaStp0OH7QjReL
         SG1mxNLbD/OBjMeZkU+VOtyL+ZGoLIU2nmfLSVAzKI5ifCMX76fGel3L6H3GVo9ujCPg
         e9348imA+4EIm1mE3FE9JgO1ul9YggceimcNJ5ZXyrJGFXR0ORfV8/4xgGtR3tyGPhr+
         dWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542590; x=1706147390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDr+NjtX2UDLWx9szIwoRGkmVQoh5QgUN+RdNYwqcvY=;
        b=K+fW/b6ueu8ocm157F4Ylhm1DKWBhnsEm9qId7rM0iIva4Uox/UnKuOHo+ZBEhcfXj
         8K/N2ZC+Pp1k4y1JZZYeLmPqOyYGseGRdrlmkOh7qeCmwYl8b22JeZikSMS6KEiuuqpZ
         NgN5dxxQfKwXPETLDArli53g9b0yRdFUtRYGN6KtHy0Uz83PeD5T28f8onuT+rvzPPPW
         t31uCl+QqsB3X3oXS6W+EO2+5NS9TSMgwonH60Emw0yxzpxUUMhNR6G64+0IJdPbJn5r
         Q/ROyRkRCN55uIt3QW2huO95ZOBrPewSjaCvT57/t64HDjZquLHGBpU4O1xU8nXLXql0
         84qA==
X-Gm-Message-State: AOJu0YyqKm1PweRH4Z/rmF8Idf1JCxsBvE5Wq5VRoIjPdL++OJocwllD
	vmZAyKYdN6ollHl/K663bICSurmEgTU+96R45LPzKCdUOXbGA/nSujrzRoye
X-Google-Smtp-Source: AGHT+IEQZFnakNp2YCjhk5y17jUZfhUadA1ILoaz7yXpUybXc4LklfCQnFgJnEHL8Q3/0mv0Sgy/HA==
X-Received: by 2002:a81:6504:0:b0:5f1:f638:2bd8 with SMTP id z4-20020a816504000000b005f1f6382bd8mr112896ywb.31.1705542590047;
        Wed, 17 Jan 2024 17:49:50 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:49:49 -0800 (PST)
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
Subject: [PATCH bpf-next v16 02/14] bpf: get type information with BTF_ID_LIST
Date: Wed, 17 Jan 2024 17:49:18 -0800
Message-Id: <20240118014930.1992551-3-thinker.li@gmail.com>
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


