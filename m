Return-Path: <bpf+bounces-28760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3CD8BDAE7
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241DD2829B8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 05:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958BF6E5FE;
	Tue,  7 May 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsOp4G1y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B16CDC2
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061377; cv=none; b=dN8F2ydwl3ELZAq5hP4qMAUdgD5uUL+IbZOqZDMksrsK4pgTOfCXCLJ93pEdjh6kqV2k8LPJbOEkXfjvclJAIFeRgIiVNUdceERhRF5qM8iJs8XsHXhnb5Sejj+YofQoruhZ6BRYNcIk9nKz7NT93sBytaL/ae4PU6I130Ln+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061377; c=relaxed/simple;
	bh=uPWmX1ZDl3Scvkwd+Qvm9qmW/Y8tT2udwqye4SlcwTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n6dO0YjumdNs/RMOqBiLz3iDzgCOZHorE7gvnrR6DTdEkur4RuajegOCsjb8lu/pckxGuu+Qh9GMPeiwoUy0lx4e6IuD4KvWZGIJYagM860MyHfqmiAm+OzaiNzNVQmoWM52VQyLdruvjKqI/IWgNz/YvNq/u/4Cs1d1fzySp4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsOp4G1y; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ad2da2196aso1927273eaf.2
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 22:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061374; x=1715666174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxv0UXm5oo+YZjnDWncrtkmdeIpbDTLDENA9DNvs+KE=;
        b=fsOp4G1ylKanap1EXQm//hd/mK+79drHveT9XLf4rIONNcf3ggqCp/Co9KFDxcwsdF
         TkeYJnBlo4k/kXw8ykQ+tScK/NZ2HZGVHedc5Ve/f2vM5si5xr6f7PoHX6CvCw81qgyC
         Y0DNuQmVuC6RtLRZbCyLgqidt5imZ5hm6NJQM8NuIFQRG5mVt+MTHkn+Tf+FDmn1ws2v
         xH7gQ/HzU+x1xcCgnightkwQ0GtTDawfcsaZ4KrD5KbzUGG/LZ1S8usv6fq5iQT3GXt6
         xCSyqutcC0vq5qtvXvcQQ854iT2jLwpXAQspNsLP3ySRsQcWWxtYT71dE6iyj09BoIMD
         teoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061374; x=1715666174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxv0UXm5oo+YZjnDWncrtkmdeIpbDTLDENA9DNvs+KE=;
        b=LPP34+LBCPbn6falmRx3OLwzEquU2sFnZ+ZYPUlbgnOSuQZuFeuUwH5ANLbupleyBv
         MQ57n1hPElXKdSzL+VU4amFsUXnEBZyAhB6XXODPlTZE+DvoHE2DfWeZfwgqnxZRG5s9
         5IfWtVeKbskeFXun8cki9wXuGFR/VSOQZs/v65QtaEksrFoFG2DgwPKXbziDeYS828yh
         UE0vNUe8Ip0TZenwtyDP2yqttIMyhMr7gVApxF1a/N2rtr3eKPBRmhOqk3mLQcKoRYC8
         hKdKFLm2ehiwPWfh0tkpJ3lSfgv0ot+6CZricK4/KjKI8UdNwdk23ENvukS36seil3z9
         Njzw==
X-Gm-Message-State: AOJu0YxteBi+nH7u7z2xqZktqdF/40gYxm7nZOm4f1ZwGRiCgz11Np1I
	5/pyxn4GYhXJoVYPABzJqQ1Gj7wZq8ujYSILBBBmKLnXuAAjZSpJTMENQQ==
X-Google-Smtp-Source: AGHT+IH0Mw25n2gpbZRZwUFApn8LnWMvDAQKOface0kRX4XseZ3Qj+PbcepQ9N7Et0YJjMJ/DPgIXw==
X-Received: by 2002:a4a:8c22:0:b0:5b2:2f55:e26 with SMTP id u31-20020a4a8c22000000b005b22f550e26mr1799700ooj.8.1715061374534;
        Mon, 06 May 2024 22:56:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2e7d:922e:d30d:e503])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a586b0906esm2317011oob.26.2024.05.06.22.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 22:56:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/6] bpf: enable detaching links of struct_ops objects.
Date: Mon,  6 May 2024 22:55:56 -0700
Message-Id: <20240507055600.2382627-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507055600.2382627-1-thinker.li@gmail.com>
References: <20240507055600.2382627-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the detach callback in bpf_link_ops for struct_ops. The
subsystems that struct_ops objects are registered to can use this callback
to detach the links being passed to them.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 50 ++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 390f8c155135..bd2602982e4d 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1057,9 +1057,6 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 	st_map = (struct bpf_struct_ops_map *)
 		rcu_dereference_protected(st_link->map, true);
 	if (st_map) {
-		/* st_link->map can be NULL if
-		 * bpf_struct_ops_link_create() fails to register.
-		 */
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, st_link);
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
+	map = rcu_dereference_protected(st_link->map, true);
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
+		rcu_assign_pointer(link->map, NULL);
 		bpf_link_cleanup(&link_primer);
+		/* The link has been free by bpf_link_cleanup() */
 		link = NULL;
 		goto err_out;
 	}
-	RCU_INIT_POINTER(link->map, map);
 
 	return bpf_link_settle(&link_primer);
 
-- 
2.34.1


