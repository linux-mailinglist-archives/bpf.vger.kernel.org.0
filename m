Return-Path: <bpf+bounces-30173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145FE8CB62D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F991C21C99
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67970149E1A;
	Tue, 21 May 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQVnqGWh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65228168BD
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331986; cv=none; b=LxHfUgTS+0t/bKApLL1poQ7E8AKWAbhCSRlzWfU7/DRgwEA2ouBdv+MJpW1zkM9KexWwXW05x6yhb8H6+22LKvWxdwhOsW9zgaqxw8inRVAF6Q6bXFf7S4lUGs5Z5fpF+rink6EUxtFLrqSk3wGjtBfsJUzyRUdUXas6k1hrxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331986; c=relaxed/simple;
	bh=SN+VBDApFs6v6iui55nDMM2xqXaNc7HG3UYrm+zjXfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKCOQCIZSMcBPAqe8EezTHy9BVbUYBZeZ1RWapahG/qTJNt/mG9GgqjgFJrQ/TkwWq5zBAxLvVetXW2BC4CKoiGgyXpeFn9/ko7VzsNK4PuL+hwL4LbyWMpAGoYU7PviaJub5LJ0EpoxcIb/5/8LrdPLOfK1DNopQW+g+VHXGC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQVnqGWh; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-deb99fa47c3so4420575276.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716331983; x=1716936783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chpm7+dADH4AMcj76DQLCHu1k8L/vbJZBmWRkL9eTOU=;
        b=RQVnqGWhFER48aHCxZIns9MnF9TgIlRbP75VsFuIGOBpNSxXWlfU+JBbdCiSc0GMRn
         aiJ7WlvG4Mvc8W2LeVL5qej08JpdE6plMEnap4vZmucC8iEQdbUnPbsYBnMCpNrscIZO
         AckHYHjV3QU6Ma3qIRrN6YzhSdsy8lAGOUjP7CudXcosOVaQHSmWhqg4HdxTdpG820gT
         zLYysNnkmxCLn3uliiu6vZpykNfJSHu/04yi2wSvALZL+n7t1fV/nZSgltP8PFx6lJHz
         jP1pmFLq47k5v++k770YK4kj4G9noCRxxHCnpbOxQvndelcAftu6mxqoN6E5mmttZz5A
         BT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716331983; x=1716936783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chpm7+dADH4AMcj76DQLCHu1k8L/vbJZBmWRkL9eTOU=;
        b=qAvC/cCvoXEbB6Oc0JoJzvF20Zm5/KFUsvMc8GEvqgY2HxxOsw6+mEA4k6GDtEXo0k
         Q5WNGfddR6J+BvZ4AVgulK4+WKHuGaGC41ILjFGX6VQ+l61jTCMKPhFkVA4R7xF9hVje
         FXZ1JwJO5e7wibWtfLkx5Jsbi3ZAI9Ok+RaGHFpaf8sn3j2TNPVyHzFXKLjzll8Al7fz
         uVpThU+uNAAQlMU2untv9bClr9bnpkZqU0C5ZlMIzLmXDjgUThofMXoMQlHH36Lv2xsA
         EWBvr8khmWaKU3cKYLarXoJm9GJ5giIaPNWcEnkwJmEg+2bdLn3ai4Nc+3GP8Z5BBewA
         hVtA==
X-Gm-Message-State: AOJu0Yyd4CDt5dGxSjRY0mO+zmxSUX+VSrZYx5dJrDTJcGbijRxQDpmO
	dZ4LO2Vi12JjMF9ADAYkDj9X61HVhYLh0LB8K2AexK8K/SKX4MjcDNhnMw==
X-Google-Smtp-Source: AGHT+IFT9eU65Z0U6F7MypaIQKICz+/pondI0stiL9wQlMy8/++ZLl/tnxfM3CBJGXTSNGU5P3L91Q==
X-Received: by 2002:a25:3343:0:b0:de5:9f08:d30f with SMTP id 3f1490d57ef6-df4e0e1eb18mr404391276.42.1716331982866;
        Tue, 21 May 2024 15:53:02 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1437:59a6:29be:9221])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd385be51sm5584956276.54.2024.05.21.15.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:53:02 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 2/7] bpf: enable detaching links of struct_ops objects.
Date: Tue, 21 May 2024 15:51:16 -0700
Message-Id: <20240521225121.770930-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521225121.770930-1-thinker.li@gmail.com>
References: <20240521225121.770930-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the detach callback in bpf_link_ops for struct_ops so that user
programs can detach a struct_ops link. The subsystems that struct_ops
objects are registered to can also use this callback to detach the links
being passed to them.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 63 +++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1542dded7489..fb6e8a3190ef 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1057,9 +1057,6 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 	st_map = (struct bpf_struct_ops_map *)
 		rcu_dereference_protected(st_link->map, true);
 	if (st_map) {
-		/* st_link->map can be NULL if
-		 * bpf_struct_ops_link_create() fails to register.
-		 */
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 		bpf_map_put(&st_map->map);
 	}
@@ -1075,7 +1072,8 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
 	rcu_read_lock();
 	map = rcu_dereference(st_link->map);
-	seq_printf(seq, "map_id:\t%d\n", map->id);
+	if (map)
+		seq_printf(seq, "map_id:\t%d\n", map->id);
 	rcu_read_unlock();
 }
 
@@ -1088,7 +1086,8 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
 	rcu_read_lock();
 	map = rcu_dereference(st_link->map);
-	info->struct_ops.map_id = map->id;
+	if (map)
+		info->struct_ops.map_id = map->id;
 	rcu_read_unlock();
 	return 0;
 }
@@ -1113,6 +1112,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	mutex_lock(&update_mutex);
 
 	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	if (!old_map) {
+		err = -EINVAL;
+		goto err_out;
+	}
 	if (expected_old_map && old_map != expected_old_map) {
 		err = -EPERM;
 		goto err_out;
@@ -1139,8 +1142,37 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	return err;
 }
 
+static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *st_link = container_of(link, struct bpf_struct_ops_link, link);
+	struct bpf_struct_ops_map *st_map;
+	struct bpf_map *map;
+
+	mutex_lock(&update_mutex);
+
+	map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	if (!map) {
+		mutex_unlock(&update_mutex);
+		return -EINVAL;
+	}
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+
+	st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
+
+	rcu_assign_pointer(st_link->map, NULL);
+	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
+	 * bpf_map_inc() in bpf_struct_ops_map_link_update().
+	 */
+	bpf_map_put(&st_map->map);
+
+	mutex_unlock(&update_mutex);
+
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_struct_ops_map_lops = {
 	.dealloc = bpf_struct_ops_map_link_dealloc,
+	.detach = bpf_struct_ops_map_link_detach,
 	.show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
 	.fill_link_info = bpf_struct_ops_map_link_fill_link_info,
 	.update_map = bpf_struct_ops_map_link_update,
@@ -1176,13 +1208,32 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out;
 
+	/* Init link->map before calling reg() in case being detached
+	 * immediately.
+	 */
+	RCU_INIT_POINTER(link->map, map);
+
+	/* Once reg() is called, the object and link is already available
+	 * to the subsystem, and it can call
+	 * bpf_struct_ops_map_link_detach() to unreg() it. However, it is
+	 * sfae not holding update_mutex here.
+	 *
+	 * In the case of failure in reg(), the subsystem has no reason to
+	 * call bpf_struct_ops_map_link_detach() since the object is not
+	 * accepted by it. In the case of success, the subsystem may call
+	 * bpf_struct_ops_map_link_detach() to unreg() it, but we don't
+	 * change the content of the link anymore except changing link->id
+	 * in bpf_link_settle(). So, it is safe to not hold update_mutex
+	 * here.
+	 */
 	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
 	if (err) {
+		RCU_INIT_POINTER(link->map, NULL);
 		bpf_link_cleanup(&link_primer);
+		/* The link has been free by bpf_link_cleanup() */
 		link = NULL;
 		goto err_out;
 	}
-	RCU_INIT_POINTER(link->map, map);
 
 	return bpf_link_settle(&link_primer);
 
-- 
2.34.1


