Return-Path: <bpf+bounces-12446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7C37CC8AE
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8B71C20C5D
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B79CA54;
	Tue, 17 Oct 2023 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm1QzRvA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40B3B2B1
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 16:23:16 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0733F0
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:14 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7afd45199so74400047b3.0
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697559793; x=1698164593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJG31ISWvKTgNfJuTjFh/5nAbkc59OAsCWWkmbBCCxY=;
        b=Nm1QzRvAo6HWgXQ6/rwG7qW5ZpPa/wMCZUh9V+hFx/E07C7lfdY2YmLW94kjYr6soC
         6UiLK8mLEVt7hMBJkxd0qmV5ryu2mf6OmclI39efgvG8oWcSQdBd60En+72sZmb5+dM5
         0dRhBNRBAxWdUFMrO9qydoeqjkRqMfW3way1FkXfkovPzGo/Apjr9tPSGEMVjr+X8iI+
         CGN3Nj9c1vZDeBN8MdQKYXQmSK6CX8uv3yCo0xdTDufF++j8UjxMhd0LP3SF4lAlHlUN
         0nC30lV/M9081iFi9//UsrC4dvvLth5IMesXRM50KT/gBDjI2wIIZ+Cy+OSr34xlvJUN
         DTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559793; x=1698164593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJG31ISWvKTgNfJuTjFh/5nAbkc59OAsCWWkmbBCCxY=;
        b=TjVjXpqgtxzsJYXIMyMs2i34CgAU+RRDUizOV80om4kZ65i7H/GEDyMvazc/FFcomg
         tEzGrUCngE9XKWaoeNTq+Q4RzzhfROompwXGSiJTA36tRHHwGnjo73q3FYz6ZBPbuc7w
         8wwfKL/0+CnXVRZa4yXjUQHUgfR50U5ULTVn3u19oghgpsupMn0q8SD7Cgi6a0iCIo+N
         MNJpQRvYYBZ7l+nqyfwho5GKTZB62Rwf/r17Brr0GcTfAXNNuobcXkAkSX9Os/yn/+lP
         TdwsQSDaZb0h03KzgVIuztbGA/NIMbeLDEttgZLxraHZsqcXdcQMm+evuj4J6auJ1uRx
         T1BA==
X-Gm-Message-State: AOJu0YwL27Fa1dZqhjCqg+zanAjwtqEoZ9BPiHztWXGWImaKTMkNuL0s
	Y9rumcSPYAJeCs6kYR80a4Lw2q/5W1k=
X-Google-Smtp-Source: AGHT+IGlwgaAxFpPzUqhV0rnRtqXzD0Kp4GuKCmaWfrEpjI+tQ8FVRRbJyGaSh0tmm15J3hFjLwQPQ==
X-Received: by 2002:a25:abac:0:b0:d9a:3ed1:e4ad with SMTP id v41-20020a25abac000000b00d9a3ed1e4admr2899215ybi.41.1697559793553;
        Tue, 17 Oct 2023 09:23:13 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ed01:b54a:4364:93cc])
        by smtp.gmail.com with ESMTPSA id r189-20020a2544c6000000b00d814d8dfd69sm623645yba.27.2023.10.17.09.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:23:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/9] bpf: hold module for bpf_struct_ops_map.
Date: Tue, 17 Oct 2023 09:23:00 -0700
Message-Id: <20231017162306.176586-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017162306.176586-1-thinker.li@gmail.com>
References: <20231017162306.176586-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

To ensure that a module remains accessible whenever a struct_ops object of
a struct_ops type provided by the module is still in use.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e6a648af2daa..1e1647c8b0ce 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1627,6 +1627,7 @@ struct bpf_struct_ops {
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
 	struct btf *btf;
+	struct module *owner;
 	const struct btf_type *type;
 	const struct btf_type *value_type;
 	const char *name;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 7758f66ad734..b561245fe235 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -112,6 +112,7 @@ static const struct btf_type *module_type;
 
 static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 				    struct btf *btf,
+				    struct module *owner,
 				    struct bpf_verifier_log *log)
 {
 	const struct btf_member *member;
@@ -186,6 +187,7 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 				st_ops->name);
 		} else {
 			st_ops->btf = btf;
+			st_ops->owner = owner;
 			st_ops->type_id = type_id;
 			st_ops->type = t;
 			st_ops->value_id = value_id;
@@ -193,6 +195,7 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 							    value_id);
 		}
 	}
+
 }
 
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
@@ -215,7 +218,7 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
 		st_ops = bpf_struct_ops[i];
-		bpf_struct_ops_init_one(st_ops, btf, log);
+		bpf_struct_ops_init_one(st_ops, btf, NULL, log);
 	}
 }
 
@@ -630,6 +633,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
+	module_put(st_map->st_ops->owner);
 	bpf_map_area_free(st_map);
 }
 
@@ -676,9 +680,18 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	if (!st_ops)
 		return ERR_PTR(-ENOTSUPP);
 
+	/* If st_ops->owner is NULL, it means the struct_ops is
+	 * statically defined in the kernel.  We don't need to
+	 * take a refcount on it.
+	 */
+	if (st_ops->owner && !btf_try_get_module(st_ops->btf))
+		return ERR_PTR(-EINVAL);
+
 	vt = st_ops->value_type;
-	if (attr->value_size != vt->size)
+	if (attr->value_size != vt->size) {
+		module_put(st_ops->owner);
 		return ERR_PTR(-EINVAL);
+	}
 
 	t = st_ops->type;
 
@@ -689,8 +702,10 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		(vt->size - sizeof(struct bpf_struct_ops_value));
 
 	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
-	if (!st_map)
+	if (!st_map) {
+		module_put(st_ops->owner);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	st_map->st_ops = st_ops;
 	map = &st_map->map;
-- 
2.34.1


