Return-Path: <bpf+bounces-9866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2201E79DFD4
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06BC281E93
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394D171B6;
	Wed, 13 Sep 2023 06:15:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908BA45
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:15:14 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F3172E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:13 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-591ba8bd094so61430787b3.3
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694585713; x=1695190513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18QINMlxIJlMCCGDrWNRRANxqLxdZf6YN3ywwwPNYns=;
        b=Pf8x5RPCUVJlIRNjh6RmpiOOvcIvHUmkG7yPBAhhlvO1f/U2TQvNDGenK2ca8w5N/j
         FNZ1/S1+XKUCGc4xZiBQ96iqskvNkMKxBNuqT0YFyN7HzakUk07FKJI3qRkqz2sB8LxO
         G5JllcZgv4dRohbpazAY6YNcwRvl5IrKi7hp8eoo2ipzknju2WpUBoU8cK5daGWWM+2W
         A9fdf14TkBGxE6z2Z3sy+eH+L8cXCtFvekI9dqLyxmT8MzaxvDd040FmurcKLzzOloiB
         QG1pzFV5i8bTD9A2zDispzZSiUcKyZWbpuyYxAXOVpLFLnmSMgagKFO+U/5eqZ9fWRL4
         irsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694585713; x=1695190513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18QINMlxIJlMCCGDrWNRRANxqLxdZf6YN3ywwwPNYns=;
        b=ksQfFXwXzkuaa38V+ra8PAa0GP2y+ztSy6rT+1JeB/BtQ7xAq1i5s/4ZeyqDnotnEs
         O+eyUa7sZXqyc6cRyKSqMNZah2fkzPXOpRrsxcXN98vfFYgIogDCppniZ3qOLo+rFwbf
         dl572CjNMLEJB6i2LpclaFYzfAGj99ftcetXqjWzyLMVC9uXmFnv8s9uQwLCkDPgb7xB
         VW138DmiO+L2PbnQYxkIwsnLoU2Ub0fn6MBH0OX5+qVzufWUSEt6AK4XRWzm8otgccwp
         5pJvWIxUAuPtcat7gQ57ZmQq1ba7hu4oZT+R9DQoKf437gdDxZCbjnuUMi1p11zYE6gj
         9zAg==
X-Gm-Message-State: AOJu0YxkmBE2G9DDqYOt2FQvfhYFw39/T1jFL13z2BY4o85HV3r7BQlE
	ljojsFn6uT62jVR8E3Mpv2ya5xpwQOQ=
X-Google-Smtp-Source: AGHT+IG2Fq4fVsvptEF4i8LqG2hLX13k2/JI8rAAeWsQ7QCbcNyBU+PPvSFz8R28lDXtDzq+xUwGaQ==
X-Received: by 2002:a81:5e45:0:b0:577:a46:26e5 with SMTP id s66-20020a815e45000000b005770a4626e5mr1662520ywb.31.1694585712646;
        Tue, 12 Sep 2023 23:15:12 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34c0:240e:9597:d8ed])
        by smtp.gmail.com with ESMTPSA id b132-20020a0dd98a000000b0057a5302e2fesm2961454ywe.5.2023.09.12.23.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:15:12 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 5/9] bpf: hold module for bpf_struct_ops_map.
Date: Tue, 12 Sep 2023 23:14:45 -0700
Message-Id: <20230913061449.1918219-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913061449.1918219-1-thinker.li@gmail.com>
References: <20230913061449.1918219-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Ensure a module doesn't go away when a struct_ops map is still alive with a
struct_ops type defined by the module.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 34 ++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a9369f982cd5..236a53330c85 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1615,6 +1615,7 @@ struct bpf_struct_ops {
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
 	const struct btf *btf;
+	struct module *owner;
 	const struct btf_type *type;
 	const struct btf_type *value_type;
 	const char *name;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c93baf54a538..845873bc806d 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -101,6 +101,7 @@ static struct bpf_struct_ops *bpf_struct_ops_static[] = {
 static struct bpf_struct_ops **bpf_struct_ops;
 static int bpf_struct_ops_num;
 static int bpf_struct_ops_capacity;
+static DEFINE_MUTEX(bpf_struct_ops_mutex);
 
 const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
 };
@@ -307,7 +308,10 @@ int register_bpf_struct_ops(struct bpf_struct_ops_mod *mod)
 	}
 
 	bpf_struct_ops_init_one(st_ops, btf, log);
+	st_ops->owner = mod->owner;
+	mutex_lock(&bpf_struct_ops_mutex);
 	err = add_struct_ops(st_ops);
+	mutex_unlock(&bpf_struct_ops_mutex);
 
 errout:
 	kfree(log);
@@ -321,7 +325,9 @@ int unregister_bpf_struct_ops(struct bpf_struct_ops_mod *mod)
 	struct bpf_struct_ops *st_ops = mod->st_ops;
 	int err;
 
+	mutex_lock(&bpf_struct_ops_mutex);
 	err = remove_struct_ops(st_ops);
+	mutex_unlock(&bpf_struct_ops_mutex);
 	if (!err && st_ops->uninit)
 		err = st_ops->uninit();
 
@@ -334,34 +340,44 @@ extern struct btf *btf_vmlinux;
 static const struct bpf_struct_ops *
 bpf_struct_ops_find_value(u32 value_id, struct btf *btf)
 {
+	struct bpf_struct_ops *st_ops = NULL;
 	unsigned int i;
 
 	if (!value_id || !btf_vmlinux)
 		return NULL;
 
+	mutex_lock(&bpf_struct_ops_mutex);
 	for (i = 0; i < bpf_struct_ops_num; i++) {
 		if (bpf_struct_ops[i]->value_id == value_id &&
-		    bpf_struct_ops[i]->btf == btf)
-			return bpf_struct_ops[i];
+		    bpf_struct_ops[i]->btf == btf) {
+			st_ops = bpf_struct_ops[i];
+			break;
+		}
 	}
+	mutex_unlock(&bpf_struct_ops_mutex);
 
-	return NULL;
+	return st_ops;
 }
 
 const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf)
 {
+	struct bpf_struct_ops *st_ops = NULL;
 	unsigned int i;
 
 	if (!type_id || !btf_vmlinux)
 		return NULL;
 
+	mutex_lock(&bpf_struct_ops_mutex);
 	for (i = 0; i < bpf_struct_ops_num; i++) {
 		if (bpf_struct_ops[i]->type_id == type_id &&
-		    bpf_struct_ops[i]->btf == btf)
-			return bpf_struct_ops[i];
+		    bpf_struct_ops[i]->btf == btf) {
+			st_ops = bpf_struct_ops[i];
+			break;
+		}
 	}
+	mutex_unlock(&bpf_struct_ops_mutex);
 
-	return NULL;
+	return st_ops;
 }
 
 static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
@@ -749,6 +765,8 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 
 static void bpf_struct_ops_map_free(struct bpf_map *map)
 {
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+
 	/* The struct_ops's function may switch to another struct_ops.
 	 *
 	 * For example, bpf_tcp_cc_x->init() may switch to
@@ -766,6 +784,7 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	 */
 	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
 
+	module_put(st_map->st_ops->owner);
 	__bpf_struct_ops_map_free(map);
 }
 
@@ -799,6 +818,9 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	if (!st_ops)
 		return ERR_PTR(-ENOTSUPP);
 
+	if (!try_module_get(st_ops->owner))
+		return ERR_PTR(-EINVAL);
+
 	vt = st_ops->value_type;
 	if (attr->value_size != vt->size)
 		return ERR_PTR(-EINVAL);
-- 
2.34.1


