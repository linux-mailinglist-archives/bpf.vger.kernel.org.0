Return-Path: <bpf+bounces-28177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D064D8B64AF
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446721F22558
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3500718410B;
	Mon, 29 Apr 2024 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr1OM3bY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633561836D3
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426575; cv=none; b=bF7buQ+b2FdzvQA9SyMxJ1NhKNJBmiQMUCBtwVJ7SAtyUXQ7vj+4X9b+Zf5IJ4wJfnf2KyQUWmldU6kX4O3MI5SoBxkL485dmy6QjJ9xLFl5o2RgIzbPpy2DN2oMntD9eAOTZNovVStotx1gy0NbC03Ab4Mp+NUegGlxtyUnQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426575; c=relaxed/simple;
	bh=Uqyx1b4ju9DUldDzncpwOrl3eanbI/lLteuJ3sVxMPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tbq2vk4UF6iDMp4etMSphwGNNUnElNrNzfhJryh6Br16y8OP3C770Fqnh9raQPxqmtd8idX/9ouqQ9D4uDy/mYflnuJgJuzOzSUxlhL5dm3mypWyluTHb+sYdXQwYKZzz5Zd0h7tUERIkVYNE0iySD6hOPMYcLci9yISzInZzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr1OM3bY; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c709e5e4f9so3159137b6e.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426573; x=1715031373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOV52fyH/vltZ6XgT2t4cJ1myqxEU4aZMpQVbrAe+Yg=;
        b=Kr1OM3bY9AcKVSbxDetNpC70I/rV1D+r/J56xpKaPcq4ijGM74oelYIR/SNTeSnSQd
         XSac9pFQA9eEpMWUokh5OKCqLCLbNNci6SWMb4eb7omVHIi4QPWKkISr3T/6t7j+p2x/
         O5Z73rlXN88hOIT32Ef0JZTHhdIE40+dwTQHZgJGLLE07N2bPn9DlhQ02O5XtE9AtSg8
         6siiO4a2L0KrroUWvLIbGvYS7EQi5NWdIuADWDWTHHXWWDm4JuGcEUgG6F0YCnGVDPct
         XMgG2DuS9L7G/G9/GxY+7IoXR0drky3KUFwpH9dE2+KicJbaD4j7A0/0BLvrMrGL6tfy
         Lj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426573; x=1715031373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOV52fyH/vltZ6XgT2t4cJ1myqxEU4aZMpQVbrAe+Yg=;
        b=nxunA91Am97NgKg6SwHAvuSoQaDPSb9bGTFW73CuNcW1pddlM+fhkbGbK0b3yLYS6y
         bz9DiJwaDHkhsFwzCNcC9ZRphDrazJpE85a/H7TC9ZQafu26fMgqKe0xOZyaxMm9fU8G
         2A2Wf3PPoMw4cRmJVJib0uleIGLt7JEqIFw5VJJL3e3F2NxY+phDzPuJxhNzPfVMNVEO
         naT4onNupRmEtodXlLT7xBdHjKtVYccejNyPPaWGdVtaMfjQlgESSJgVXOzObiD+rmWK
         JHX9wvTp+k3cNWmJRzfn6KFcra/XYZDBQZG3BfA0gLLVYgytSC0QqF+N0mXypAJLtSWn
         iqJw==
X-Gm-Message-State: AOJu0YxFQqDKCGbTbS+Y8Jr0OQU6vpYG2eKayPXeaSI0uOfzXrCnVVwa
	pGB9VM7XbGiWUlvXXnlK9Zl9FDIMdN89cr4eucO7E42aBRrPBOZizZbf6g==
X-Google-Smtp-Source: AGHT+IE9zzXuVRTvCW8pq3+0O6Q+a6gcNCnLwlUgSF0rJnc+D9l4cl6791uXh6Hj7ZOsUfKl1I0vjw==
X-Received: by 2002:a05:6808:e85:b0:3c8:531f:ca40 with SMTP id k5-20020a0568080e8500b003c8531fca40mr15106373oil.35.1714426573302;
        Mon, 29 Apr 2024 14:36:13 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b805:4ca7:fd75:4bf])
        by smtp.gmail.com with ESMTPSA id x5-20020a05680801c500b003c8642321c9sm714034oic.50.2024.04.29.14.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:36:12 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/6] bpf: add a pointer of the attached link to bpf_struct_ops_map.
Date: Mon, 29 Apr 2024 14:36:04 -0700
Message-Id: <20240429213609.487820-2-thinker.li@gmail.com>
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

To facilitate the upcoming unregistring struct_ops objects from the systems
consuming objects, a pointer of the attached link is added to allow for
accessing the attached link of a bpf_struct_ops_map directly from the map
itself.

Previously, a st_map could be attached to multiple links. This patch now
enforces only one link attached at most.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 47 ++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 86c7884abaf8..072e3416c987 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -20,6 +20,8 @@ struct bpf_struct_ops_value {
 
 #define MAX_TRAMP_IMAGE_PAGES 8
 
+struct bpf_struct_ops_link;
+
 struct bpf_struct_ops_map {
 	struct bpf_map map;
 	struct rcu_head rcu;
@@ -39,6 +41,8 @@ struct bpf_struct_ops_map {
 	void *image_pages[MAX_TRAMP_IMAGE_PAGES];
 	/* The owner moduler's btf. */
 	struct btf *btf;
+	/* The link is attached by this map. */
+	struct bpf_struct_ops_link __rcu *attached;
 	/* uvalue->data stores the kernel struct
 	 * (e.g. tcp_congestion_ops) that is more useful
 	 * to userspace than the kvalue.  For example,
@@ -1048,6 +1052,22 @@ static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 		smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_READY;
 }
 
+/* Set the attached link of a map.
+ *
+ * Return the current value of the st_map->attached.
+ */
+static inline struct bpf_struct_ops_link *map_attached(struct bpf_struct_ops_map *st_map,
+						       struct bpf_struct_ops_link *st_link)
+{
+	return unrcu_pointer(cmpxchg(&st_map->attached, NULL, st_link));
+}
+
+/* Reset the attached link of a map */
+static inline void map_attached_null(struct bpf_struct_ops_map *st_map)
+{
+	rcu_assign_pointer(st_map->attached, NULL);
+}
+
 static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 {
 	struct bpf_struct_ops_link *st_link;
@@ -1061,6 +1081,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 		 * bpf_struct_ops_link_create() fails to register.
 		 */
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+		map_attached_null(st_map);
 		bpf_map_put(&st_map->map);
 	}
 	kfree(st_link);
@@ -1125,9 +1146,21 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		goto err_out;
 	}
 
+	if (likely(st_map != old_st_map) && map_attached(st_map, st_link)) {
+		/* The map is already in use */
+		err = -EBUSY;
+		goto err_out;
+	}
+
 	err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
-	if (err)
+	if (err) {
+		if (st_map != old_st_map)
+			map_attached_null(st_map);
 		goto err_out;
+	}
+
+	if (likely(st_map != old_st_map))
+		map_attached_null(old_st_map);
 
 	bpf_map_inc(new_map);
 	rcu_assign_pointer(st_link->map, new_map);
@@ -1172,20 +1205,28 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	}
 	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL);
 
+	if (map_attached(st_map, link)) {
+		err = -EBUSY;
+		goto err_out;
+	}
+
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-		goto err_out;
+		goto err_out_attached;
 
 	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
+		/* The link has been free by bpf_link_cleanup() */
 		link = NULL;
-		goto err_out;
+		goto err_out_attached;
 	}
 	RCU_INIT_POINTER(link->map, map);
 
 	return bpf_link_settle(&link_primer);
 
+err_out_attached:
+	map_attached_null(st_map);
 err_out:
 	bpf_map_put(map);
 	kfree(link);
-- 
2.34.1


