Return-Path: <bpf+bounces-30539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FE38CEC69
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 00:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4172829EE
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719D8128375;
	Fri, 24 May 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azdYprYg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0B86252
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716589845; cv=none; b=S0Sx6WU16mdrh+et30S9sCYs+mq5qfTvGztLQV/BmCz7R9wKsfmWfSj4BoANegZ6M2cT+iJPL93IUnw2LEZcT7Yh8PBJSiY5avfdCmNi4G1YwYcpRczBZYFt8Ey+0NroqvgqHHy8dvRuLu0a6O5hxoY/6dCilfglYd+1uw/YPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716589845; c=relaxed/simple;
	bh=xppD84te++LZ4ApfbZ1oIZIJ9J0Hv6djDyNJeWeu1pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ILC3i60g62IzppKcEJHFG7EgNXak4CvG+Q7xsPGbG4zMDgZ8P9Q9aJoobUvkAI0WC8/SjgssnskO9uk8IxmO28vOfsFSlOahr7MZ7VHabhmKB3mtk2AocwEVHIhBmuxufaZHZf5TU22esZeUHyG9NbM8dbfuDDKUD/PTHFIDfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azdYprYg; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a08b1a81bso12972397b3.3
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716589842; x=1717194642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuNnsh+t+vm30XUZlxFAiVM4aWEhFtEMhV1CFeDWxlE=;
        b=azdYprYgL5d3cXejgTnaKrIR8qbAPjGfvUz0znLoqyKU8DElNzPMVaPf1+wRDND9HG
         GAfhvgvJiAb8oxrbRiricKlGX2vBjm2qKdGnaoucHHTSR5x0sQmm3klAPaGb4LiTU7pu
         R0amrX8a7jPNe7iaHhkltegFWRnDBCSQtk0LURH2PUcMU07JiyHe5nyaWRXvHDMB6mkd
         9BeWF0llWr1oVvXwqN9CFmJZ7CuTNqKlwqncJsdIRmPHcn157Gtteh5gwBOckv3aK5xh
         aLGLFTQT9MFGi1NI9UTYN0YlU+XKgXQfBCS7TcRIKFNXgPtOVJS15OnIbOULK765ahIX
         KTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716589842; x=1717194642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuNnsh+t+vm30XUZlxFAiVM4aWEhFtEMhV1CFeDWxlE=;
        b=LuLmoNuOuVPob3ES0hgBy68xgDDIeR1dUuDc/XKg5ordG++vlrVaEWYzKa/D/mnKAN
         q1ocX0qsIkzT73iZSvNqJSKj3rz9goRRRFtZPdOlqsjmHsDJrNJ/URhDP4qFID3rsDV2
         O2v0AK/eaxGRoz5xSKJUJRokykWmvy41XlgFxRABUA6YRNUtF8bPmSgAVloDreA6Lv22
         nelyK4KZIFaJ0pPNb0f9QmfDUBRPQ32qnFLApnfuJrcOhQyLPHQPJe5lSkbb94ZgYBzV
         IQlSiA74rZoBDroxO/qt49xDtTQwn8BarFqvL82G+tJIM3TEgfPtDCa59y7AFCxGz4uV
         DMfw==
X-Gm-Message-State: AOJu0YxK/bakrLPJ4r6994wcijNM2PlnWRDxyVR+SpNBTB1RzoCAaiQz
	Yl2XuM9WkSk+SC7s44m/SizwvccMrL2NPWmJipYsgx0suHuRMXHaAJ50hA==
X-Google-Smtp-Source: AGHT+IGoZoWrujF1sxhjGZa0nox3LxgMmmzlkshUYUH3kXV3GiAXvdAvCZD//FH9ku4wag6EBx28Rw==
X-Received: by 2002:a0d:d509:0:b0:615:79df:e7ff with SMTP id 00721157ae682-62a08dbfb49mr35927407b3.29.1716589842052;
        Fri, 24 May 2024 15:30:42 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6aeb:e91b:f49d:e77d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3bfa19sm4169987b3.44.2024.05.24.15.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 15:30:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 2/8] bpf: enable detaching links of struct_ops objects.
Date: Fri, 24 May 2024 15:30:30 -0700
Message-Id: <20240524223036.318800-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524223036.318800-1-thinker.li@gmail.com>
References: <20240524223036.318800-1-thinker.li@gmail.com>
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
 kernel/bpf/bpf_struct_ops.c | 53 ++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1542dded7489..f2439acd9757 100644
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
+		err = -ENOLINK;
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
+		return 0;
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
@@ -1176,13 +1208,22 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out;
 
+	/* Init link->map before calling reg() in case being detached
+	 * immediately.
+	 */
+	RCU_INIT_POINTER(link->map, map);
+
+	mutex_lock(&update_mutex);
 	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
 	if (err) {
+		RCU_INIT_POINTER(link->map, NULL);
+		mutex_unlock(&update_mutex);
 		bpf_link_cleanup(&link_primer);
+		/* The link has been free by bpf_link_cleanup() */
 		link = NULL;
 		goto err_out;
 	}
-	RCU_INIT_POINTER(link->map, map);
+	mutex_unlock(&update_mutex);
 
 	return bpf_link_settle(&link_primer);
 
-- 
2.34.1


