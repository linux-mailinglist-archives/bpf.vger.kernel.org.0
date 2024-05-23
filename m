Return-Path: <bpf+bounces-30439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E78CDD20
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F88A1F215DF
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363E6128808;
	Thu, 23 May 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyNKSq2w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965912838F
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505737; cv=none; b=R0i1PE2EAHllchfwsaADoT8O3Z8LGol+C6nmGOjrraFoAnru2J75FA07dJJ4QX9c2yzw1gt3gU5yxq3VS/0NoIEltvSSnsteEsz3F4nDZitNmg+dfekBZ32Vrf8colVkeEr1Rv8wgcEK1XkCrsxLRSqzb0X8QZpku4ByZaB5Vdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505737; c=relaxed/simple;
	bh=xppD84te++LZ4ApfbZ1oIZIJ9J0Hv6djDyNJeWeu1pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dqN7YCO07sUddBSUGUZwrhP5kkUmkDZXPxxdS1FMQqltMXbscyNxlsQ8ns2Dtbbk1oz8r3yyxCxP5rkKn50dpfGg5lmHZo6Yzslo3L0Ye5asVr0CM3724VSKUvI1DF3LjDAoLe15popeGEmrtedzD083idy0yB0DQch5SA4RnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyNKSq2w; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-627788ce780so29193257b3.0
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 16:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716505735; x=1717110535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuNnsh+t+vm30XUZlxFAiVM4aWEhFtEMhV1CFeDWxlE=;
        b=WyNKSq2wBOl6CjoM6yuYDyRW8jHJh1lMg6kSxp3L6vut4J490JgOXAdLHuhtu+O/Q8
         qrsj1vmipFUlTMlmXBYVkmipWRYqcTKvi8wEHAUbx/Xlmgouj4tq5b6Zwv5TjQGQ2jTF
         xLITWjuxP867plvF/FnhMahMM/vr5q/B+5M5qWa9c3H1RSYKZvw3QZued5OKCXaPZFe3
         GTKJZSQJ78RlINjQtpi9OviPZWAQ3O2/1yieGDDWMsuO9jLY67EUcGWhJfVETzPGbkk0
         x4Lg0l84XbMLE7F+jdzb7F/lRG2EYIZMqmoAbFIA46GY6hwPOA0uzLTpksjXzcYWQotS
         Jabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505735; x=1717110535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuNnsh+t+vm30XUZlxFAiVM4aWEhFtEMhV1CFeDWxlE=;
        b=D3MBFHbjhZiC2Y3qu6PuYqhf5fLyS6YndY6GKgn6+44chDcqlxTpdEk00NX6gWDzdR
         Mr0ArtYutWK9LYE6VRtTKpT3CCWuxJCAnxi7WySycBlgNJhjHGLldANqlMRIpfcOk9g2
         jrlHo7oTjsjitl9bXtWEtzYyl5ulRS7lppHScD7IHqCpoPs3Su2Ob0iMnuBMvgSe2dZ/
         qje6VViV8ySRICLgkctaKFmQPEvJKtzh89nj7pFlpkhrTZ+t98CQqA/I7WsKW1RWJPlH
         phI1Q0rGyF8rX+zUwZSBTnvbUqhAOzw3FIco+7ML3V3XH+0EavcJIVNRuCuVhsz3w/iV
         zKDA==
X-Gm-Message-State: AOJu0Yy4Xbp53xW3gb3+j1KqWm+5p5DyNJ2gbSJ3TtrXv9vsvA4ii4Fh
	h1JvhEBlo6DGre9w9dPi2AtzTvuebGbuia/cEi/NUxQrgDAF7PMNOXRxxw==
X-Google-Smtp-Source: AGHT+IG0z9m1wVo5wgQqNkltG/CeaTafiJIwgb+qSGSC31CAwEkOFRJ3MgKbY4DS9j6Jf+gB2u89iA==
X-Received: by 2002:a81:4ec1:0:b0:61b:33ae:e065 with SMTP id 00721157ae682-62a08b38427mr5872957b3.0.1716505734467;
        Thu, 23 May 2024 16:08:54 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b7f1:1457:70d4:ab6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a37d5d0sm474087b3.16.2024.05.23.16.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:08:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/8] bpf: enable detaching links of struct_ops objects.
Date: Thu, 23 May 2024 16:08:42 -0700
Message-Id: <20240523230848.2022072-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523230848.2022072-1-thinker.li@gmail.com>
References: <20240523230848.2022072-1-thinker.li@gmail.com>
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


