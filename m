Return-Path: <bpf+bounces-28179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE88B64B1
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297671F224C5
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3C818411D;
	Mon, 29 Apr 2024 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1FZ9ZkZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DDF1836D3
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426578; cv=none; b=FQ1ZPew7awp7evCoVQpnC75+c1IsN0Z+pJ9AnKNQX6kccbAjtMpHofUz9Q/SC0Kpmi9W/ev11zVj3Q5YTm6GNWeKa3s4nZfLzqWYlfzTuT12FbVEsRF7l6iywQWo/0qbNGthGh59wKtMM7PQKSzJG1Iw4ulvStoJZPEx89O5dTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426578; c=relaxed/simple;
	bh=4uakBWvaHA1KxlgcBwgGIfbSSivWPoJn0awGMiKF3PU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPHj24+BIY2fm/ci3FHacX3kwlR6/Kd4hrAZjA8KNYkdQ00GbnNaRLwW1rOD+yQu06awH45q01vSfQOenO1zt58bcCb2I79EqSyiG6q6D2GOI6ZIpPt1E9jbQHZfNfQX7g52F500C2mpnYYcOjP+CUkLL68D/+ShEsbEduaIMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1FZ9ZkZ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c8641b41e7so1031127b6e.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426575; x=1715031375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTnbJwGNcO/RFWMVGphrMvNsaylBPZQXpHG6wXSmgfw=;
        b=S1FZ9ZkZqR6yOVO06MlJGk7nsFScfUW9Ll9jjwhGRP2kNRafUwV56xt7lOm5UiIIhh
         azlwXPYVK4Y+RVnU8yOImZNlp2n7MpWkf7ox0COUpHGIKGFrMYqjLFm2MTwau4y+nkCc
         +xOZozEZbagaXPvojFStdtxeBU5BMB9M5D7nXMdQDFwW+8dKSa6ggoafTkhJmFV1GTjM
         js7/d1SOFxZnScy7gdn0XuI2gE4TUqRXWjuHrsQf+4MM+/Rd488IDDN2iMq8KBe+b/l4
         byQY+1S+7eF3n652n/J+ObBFJUJHOuRXZkHX4EStcuOqsZ22VsFsLXA6zObEVuSulKGj
         vKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426576; x=1715031376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTnbJwGNcO/RFWMVGphrMvNsaylBPZQXpHG6wXSmgfw=;
        b=TQv6ASRB2XAsZdsP9uQZt6cIWpcYYQZ/BPQS76PHNaiu0jLlyaQqwLXVxxmXoB8T/d
         LvN2DDyBRA/ZnRdU6MnRzqZEiGbSPCopoLHA+0zEvkRhnBUj8pQh7YY7lWrykHyK4abt
         zwP5lr7syo14VMAYWp20mPgMoa3+TCuSeC8QRObBDdZVxK5ahOV19OJGhDDIjKOzb8tC
         167MyFcB8EPcIvEQhP6MBTWGUEb30d4BbPt9BjqhfY+hgd1cFnZghrb+N6bkYwA80QeE
         /k/LipJvXUduNl+r2yGDJ/BrRl+Yr2joRzmtaPFU4EkkkNW2NBihtVPNMYI0WZddT14A
         Ecew==
X-Gm-Message-State: AOJu0YzOIezNdRWGtumZZi5wXLqsopNQKp3GhTsJdZsJTExKH5/FwN7Z
	tDOUZf0oH730nsnJl++BWwOFu82EdtdWB1WybZ9ZLUDsLsTkNNAiwN057w==
X-Google-Smtp-Source: AGHT+IFdXfEjMzMa14okT2LtWsnbYfAG2UcSHCK1peFu+3Nl3EPd6b+BlpPOUFfiEJ+bISA1W7LpOA==
X-Received: by 2002:aca:2814:0:b0:3c7:306f:c7b with SMTP id 20-20020aca2814000000b003c7306f0c7bmr1096273oix.19.1714426575561;
        Mon, 29 Apr 2024 14:36:15 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b805:4ca7:fd75:4bf])
        by smtp.gmail.com with ESMTPSA id x5-20020a05680801c500b003c8642321c9sm714034oic.50.2024.04.29.14.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:36:15 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/6] bpf: provide a function to unregister struct_ops objects from consumers.
Date: Mon, 29 Apr 2024 14:36:06 -0700
Message-Id: <20240429213609.487820-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429213609.487820-1-thinker.li@gmail.com>
References: <20240429213609.487820-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_struct_ops_kvalue_unreg() unregisters the struct_ops map specified by
the pointer passed in. A subsystem could use this function to unregister a
struct_ops object that was previously registered to it.

In effect, bpf_struct_ops_kvalue_unreg() detaches the corresponding st_map
of an object from the link if there is one.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  6 +++
 kernel/bpf/bpf_struct_ops.c | 97 ++++++++++++++++++++++++++++++++++---
 2 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8a1500764332..eeeed4b1bd32 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1793,6 +1793,7 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 		module_put(owner);
 }
 int bpf_struct_ops_link_create(union bpf_attr *attr);
+bool bpf_struct_ops_kvalue_unreg(void *data);
 
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
@@ -1843,6 +1844,11 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
 {
 }
 
+static inline bool bpf_struct_ops_kvalue_unreg(void *data)
+{
+	return false;
+}
+
 #endif
 
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 072e3416c987..8e79b02a1ccb 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1077,9 +1077,6 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 	st_map = (struct bpf_struct_ops_map *)
 		rcu_dereference_protected(st_link->map, true);
 	if (st_map) {
-		/* st_link->map can be NULL if
-		 * bpf_struct_ops_link_create() fails to register.
-		 */
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
 		map_attached_null(st_map);
 		bpf_map_put(&st_map->map);
@@ -1087,6 +1084,83 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 	kfree(st_link);
 }
 
+/* Called from the subsystem that consume the struct_ops.
+ *
+ * The caller should protected this function by holding rcu_read_lock() to
+ * ensure "data" is valid. However, this function may unlock rcu
+ * temporarily. The caller should not rely on the preceding rcu_read_lock()
+ * after returning from this function.
+ *
+ * Return true if unreg() success. If a call fails, it means some other
+ * task has unrgistered or is unregistering the same object.
+ */
+bool bpf_struct_ops_kvalue_unreg(void *data)
+{
+	struct bpf_struct_ops_map *st_map =
+		container_of(data, struct bpf_struct_ops_map, kvalue.data);
+	enum bpf_struct_ops_state prev_state;
+	struct bpf_struct_ops_link *st_link;
+	bool ret = false;
+
+	/* The st_map and st_link should be protected by rcu_read_lock(),
+	 * or they may have been free when we try to increase their
+	 * refcount.
+	 */
+	if (IS_ERR(bpf_map_inc_not_zero(&st_map->map)))
+		/* The map is already gone */
+		return false;
+
+	prev_state = cmpxchg(&st_map->kvalue.common.state,
+			     BPF_STRUCT_OPS_STATE_INUSE,
+			     BPF_STRUCT_OPS_STATE_TOBEFREE);
+	if (prev_state == BPF_STRUCT_OPS_STATE_INUSE) {
+		st_map->st_ops_desc->st_ops->unreg(data);
+		/* Pair with bpf_map_inc() for reg() */
+		bpf_map_put(&st_map->map);
+		/* Pair with bpf_map_inc_not_zero() above */
+		bpf_map_put(&st_map->map);
+		return true;
+	}
+	if (prev_state != BPF_STRUCT_OPS_STATE_READY)
+		goto fail;
+
+	/* With BPF_F_LINK */
+
+	st_link = rcu_dereference(st_map->attached);
+	if (!st_link || !bpf_link_inc_not_zero(&st_link->link))
+		/* The map is on the way to unregister */
+		goto fail;
+
+	rcu_read_unlock();
+	mutex_lock(&update_mutex);
+
+	if (rcu_dereference_protected(st_link->map, true) != &st_map->map)
+		/* The map should be unregistered already or on the way to
+		 * be unregistered.
+		 */
+		goto fail_unlock;
+
+	st_map->st_ops_desc->st_ops->unreg(data);
+
+	map_attached_null(st_map);
+	rcu_assign_pointer(st_link->map, NULL);
+	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
+	 * bpf_map_inc() in bpf_struct_ops_map_link_update().
+	 */
+	bpf_map_put(&st_map->map);
+
+	ret = true;
+
+fail_unlock:
+	mutex_unlock(&update_mutex);
+	rcu_read_lock();
+	bpf_link_put(&st_link->link);
+fail:
+	bpf_map_put(&st_map->map);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bpf_struct_ops_kvalue_unreg);
+
 static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
 					    struct seq_file *seq)
 {
@@ -1096,7 +1170,8 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
 	rcu_read_lock();
 	map = rcu_dereference(st_link->map);
-	seq_printf(seq, "map_id:\t%d\n", map->id);
+	if (map)
+		seq_printf(seq, "map_id:\t%d\n", map->id);
 	rcu_read_unlock();
 }
 
@@ -1109,7 +1184,8 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
 	rcu_read_lock();
 	map = rcu_dereference(st_link->map);
-	info->struct_ops.map_id = map->id;
+	if (map)
+		info->struct_ops.map_id = map->id;
 	rcu_read_unlock();
 	return 0;
 }
@@ -1134,6 +1210,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	mutex_lock(&update_mutex);
 
 	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	if (!old_map) {
+		err = -EINVAL;
+		goto err_out;
+	}
 	if (expected_old_map && old_map != expected_old_map) {
 		err = -EPERM;
 		goto err_out;
@@ -1214,14 +1294,19 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out_attached;
 
+	/* Init link->map before calling reg() in case being unregistered
+	 * immediately.
+	 */
+	RCU_INIT_POINTER(link->map, map);
+
 	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
 	if (err) {
+		rcu_assign_pointer(link->map, NULL);
 		bpf_link_cleanup(&link_primer);
 		/* The link has been free by bpf_link_cleanup() */
 		link = NULL;
 		goto err_out_attached;
 	}
-	RCU_INIT_POINTER(link->map, map);
 
 	return bpf_link_settle(&link_primer);
 
-- 
2.34.1


