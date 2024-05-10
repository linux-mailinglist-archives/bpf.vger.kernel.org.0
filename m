Return-Path: <bpf+bounces-29414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81D8C1BC0
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DAB1F21597
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD25339D;
	Fri, 10 May 2024 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX8I5dyg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E24C7D
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300989; cv=none; b=YSLCWzDeB72fGHscex0YC1VzYEaHwdX4cfVBqblxV++ROyWper9mbO3CrHUbDPF12Oimc636VeRiEYL1zFL1QzCgViDs4xhKdfET0SNJ/r2l6d+PZHEaH3CLZfw5/N3f3C4vv95ySFSMdrtFK6kejg2OxQ3pyoA/V8bidJNsq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300989; c=relaxed/simple;
	bh=HWs/ISbPlESsrkP0SvzIrIGbtO3Zf2ve0IcdgaB1iFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oy/6vcbqjQr2uWgVkynu9LY2GhO70/x+U4UoMm+gCv/g8BF/vDv8mNi3lmdtvIpU30FYTG802sogmUiPNzvtPrXY4F7XvWVrX1WimCexG/g78bOFWdomYyWuCb1UhzyQd3mL60fFoReB/yB4ASh6yU737Ugk3nakdYyFGfI45xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX8I5dyg; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9996178faso24979b6e.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715300987; x=1715905787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwzSOLipthCVO++sk5fkDnUQ7UJc91lhr4BYqbA2DO8=;
        b=dX8I5dygrlGPvGVDbobco2g+iMolaE93el/T8FA1DUvZco1bl3XVf3/dqbmCGtR4hC
         A7ev69J+lLbf+Z8VGMN2s/+g2Ad2cAvODtQQjhMOmlhrorBwv7PIwEdncXnTG6+Kz5WY
         mZoUCmcZGveg1UAJRBJBNYUt2JAxgGri9fQvYnrv8icGZEggdvfTI9hqlAbY4SNz5+mO
         jA/FVdNc95P0cKep6JPZVxLbk2vnFt7tpM+QnI0VKtM/QEFJP3bgCCJ4TpGVeng1GC5T
         EtaggCmivYG6yT+5w0g1ad2FxNNcvH6xMYZXIGBH1AbbuciKeFbg5cgkhIED6YsGgEt/
         4EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300987; x=1715905787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwzSOLipthCVO++sk5fkDnUQ7UJc91lhr4BYqbA2DO8=;
        b=gm9LaAMsahJBur3JMkl2QNPONyVxtIqLD8CymF8NsxtIYTCcTXM4Cz3/Dp7PLN43sP
         5TfiiZRVGIwUkhhJ/PFaVplOktaZ5gopfDemDdIAT/NQpRjuEMxbYl/zyVM1BnzW+8J4
         Cj45Dij7xMdcSliABy3HX/aMp3xDpmgAKZoJpkk18jtQgMVnojLP9nWWot6rhLBIS2ti
         5BJ7DjoltpKk+18rFz08rSUBmFeSeYSxLYhzjN1y12RtlFPbYsVrhkdoH5Ympiqb3rjM
         edLlVEjNBMmhc/9StVcYATqiIHYgZjatFmbF/kytaxVBSoRNpNZ7y0w4mQ9RtGuvL5dM
         Ctag==
X-Gm-Message-State: AOJu0YzLBNubliHtKzrCg2DFo+zJn5GavDGhtkvVMts/CWYPaW3pnXLY
	8D1LSNMstUUfRmUV7dpyn2wX+79CSOFbzbNOglHA4rTdAol6/5l/PmeGdA==
X-Google-Smtp-Source: AGHT+IFPxhnPXD6rO8f1yJseYyMwB+SugNC3zyO2yN9Fwbx0O6lUqTZOGmI+fPSNK0EREWO2hU6gHg==
X-Received: by 2002:a54:4415:0:b0:3c8:430c:ab4f with SMTP id 5614622812f47-3c9971dd2famr1358826b6e.55.1715300987064;
        Thu, 09 May 2024 17:29:47 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c98fc7e00bsm433251b6e.4.2024.05.09.17.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 17:29:46 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/7] bpf: enable detaching links of struct_ops objects.
Date: Thu,  9 May 2024 17:29:37 -0700
Message-Id: <20240510002942.1253354-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510002942.1253354-1-thinker.li@gmail.com>
References: <20240510002942.1253354-1-thinker.li@gmail.com>
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
 kernel/bpf/bpf_struct_ops.c | 50 ++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1542dded7489..7e270ee15f6e 100644
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
@@ -1176,13 +1208,19 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out;
 
+	/* Init link->map before calling reg() in case being detached
+	 * immediately.
+	 */
+	RCU_INIT_POINTER(link->map, map);
+
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


