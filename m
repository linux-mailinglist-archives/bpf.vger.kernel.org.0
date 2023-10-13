Return-Path: <bpf+bounces-12199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6607C9060
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6F8B20C51
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41172C84E;
	Fri, 13 Oct 2023 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBvbMkVw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8582C842
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 22:43:14 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600BC9
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:13 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7b91faf40so31913147b3.1
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697236992; x=1697841792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJG31ISWvKTgNfJuTjFh/5nAbkc59OAsCWWkmbBCCxY=;
        b=mBvbMkVwoU29LgSbUP+iVT8YmKCFTa/BJ2wpgmreVI92fRgpar7vE52nANUDD1a80W
         R5Cmey12EtYJw4HiPH5p7IJ8eKPvuVeXvncfoYkpXwPKIiab5PrFJqYA9OsJLnfNAH6S
         M8oRYfMDytYMfBOh41eJf6l39U1hh8NcP5b8ZNbiyNUjcJ0XJG4L2fMz4MqMhWNmASZl
         b7nUc8aB+YSmNncOPHoYg0IvzA/R/SnvPU9gr/9GXb4fEyBPOV27sBH5BPmrWG7xgcp2
         QQnxqgaropsj9qf2jvfS8OBFxa5ebcSiQ5dhzMRAS1G14NhloJti6adTWMMWPlK7u+ev
         yUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697236992; x=1697841792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJG31ISWvKTgNfJuTjFh/5nAbkc59OAsCWWkmbBCCxY=;
        b=OipgPVR4ucKYjpTzh81GrlcypImxAusQ0Zf9CvO9ybsbm1cT09Bhipz/zUwERJWo1Q
         LojXPVHtnHjUcPTUPPARGzneqgc48YSn8KTOErjREJFiZoBX+3j1lSHOzIa5iF9+bUfP
         W7p9/fREsnWfaSWzLyjPWBSKa1jJGKdeuaIb4P6b8gj6I1zZVX9FH72eA/6SCdr/mCbf
         /R5igeGyYaB1owQ0WXDv1mxj+vh1JnUNw1MCTxZ1ltmSCFWgIZXhrF9hTRME5qGVJro+
         o5go8RwXevcjPEA04IbXEh/jX/7wuhQom4ZpRw2n6zhjDIfXgZcsw14arxBXmyvhxeE2
         u8Pw==
X-Gm-Message-State: AOJu0YxPLA0cwfZB3MKQU9DCGzi/IDagOQLFdNhQEDzDtEyG+VaCpD9I
	O6QO1ikY/VTHKZqblYA/bGqqXx7DfHM=
X-Google-Smtp-Source: AGHT+IHRyigS6hGseUO48H0IyRGMtMlhg43gVv1afV34BJOCe8D92J0QblmlmkTuPOPwF9tT09RPjQ==
X-Received: by 2002:a81:8647:0:b0:595:89b0:6b56 with SMTP id w68-20020a818647000000b0059589b06b56mr31220598ywf.28.1697236992025;
        Fri, 13 Oct 2023 15:43:12 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:df89:3514:fdf4:ee2])
        by smtp.gmail.com with ESMTPSA id g141-20020a0ddd93000000b00592548b2c47sm101989ywe.80.2023.10.13.15.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:43:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/9] bpf: hold module for bpf_struct_ops_map.
Date: Fri, 13 Oct 2023 15:42:58 -0700
Message-Id: <20231013224304.187218-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013224304.187218-1-thinker.li@gmail.com>
References: <20231013224304.187218-1-thinker.li@gmail.com>
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


