Return-Path: <bpf+bounces-14315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1467E2DEA
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBF01C20828
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B422E3F0;
	Mon,  6 Nov 2023 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXGSfgpy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5902DF7D
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:13:05 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E76010E2
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:13:03 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a82c2eb50cso52770697b3.2
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 12:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699301582; x=1699906382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrSMHJTFN4VS+bJTktR0aBlANVua2h1i4VPb1Ipn4eE=;
        b=TXGSfgpyn6wJ/EHT0r2WfI/SEMLtnte7OasSB8phCnkKSykaq/aVtOs1wzkMyckAR9
         eZjMkOYQoKXUsoVhUp4Wi5/+9Pi4A/gd1kz3bp48sXz1e6UzRgPGki8Ya52sy81yH8Fj
         IQCGnqE+xDiW3+SGthCbJg2V4UKlJKm2vCgRvNl2XYufWFXiYRUu7Y2RtoWDWXr6hjlG
         Wh7Wn0H1Qgx3eEnopIJDVYmZzeCBPhLaG0HkYPaNo7Z6JlGVm9A00s9oLw4EMCqJ6VwW
         0tpPQ4ZxNBAYGJGYPHtnsZ3S/CV6mzqqqlftR8L8CJaZE1joyRbiTBwqxBxaU5K0rU5G
         /pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301582; x=1699906382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrSMHJTFN4VS+bJTktR0aBlANVua2h1i4VPb1Ipn4eE=;
        b=Jj1FIHjHFwusV2s7Hj3/Wk7Uk2sHriMhhfgIZObEcn8dD67kjkIi4DtkM7svDco75h
         56VZITM7s133bbzu3YGbEaig8oHsuZ0dplBhsaoa9Lmy0xmQ5ouraqq543T3Oox5MekM
         fC03AqE85VthJfxh68T2D6heiHHt+BMUBnpnvMzPeU/3LeIBh0zvtDzfanip7Smb4B4Z
         /Z+Ofy7z9t+Apye9qwAOkShJ1Xp9CADtS8rT627q4AGq6MjyQm8/JKjKQy2PrUR/s+4u
         upuGkVInuJ3AZ7AZz2Tyytp4dCqa1ewL+6vf5V1phY4+RrszyAkabc+2Mt60Ee0ohHmo
         7nWw==
X-Gm-Message-State: AOJu0YwNLL5Z2c6I0tKp9aVVwi3ruLxq6yRIahd/U6fUS0LNc7rZ/zco
	Oz8HIXOk68H5r2dQFlocV8Lc1fblRuM=
X-Google-Smtp-Source: AGHT+IG0IvVO7ii86dE7HioRR2rU+4pzupzNSE1gNZWFeThSTLUSUqvaaBtmC3+Vm6NKlvKJMlyn5A==
X-Received: by 2002:a0d:d8d1:0:b0:5af:7330:9f1e with SMTP id a200-20020a0dd8d1000000b005af73309f1emr8873298ywe.28.1699301581771;
        Mon, 06 Nov 2023 12:13:01 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:446d:cdea:6fa5:5630])
        by smtp.gmail.com with ESMTPSA id e65-20020a816944000000b0058427045833sm4760611ywc.133.2023.11.06.12.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:12:59 -0800 (PST)
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
Subject: [PATCH bpf-next v11 02/13] bpf: get type information with BPF_ID_LIST
Date: Mon,  6 Nov 2023 12:12:41 -0800
Message-Id: <20231106201252.1568931-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106201252.1568931-1-thinker.li@gmail.com>
References: <20231106201252.1568931-1-thinker.li@gmail.com>
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


