Return-Path: <bpf+bounces-19925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D568330F0
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5084288521
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D885A7AE;
	Fri, 19 Jan 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvcQGysy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62B59157
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704634; cv=none; b=aVVWp4nstwjMCO+WEvaO8XDeLIVJCLo5dNp8H/ppXTjX7FwswW4fxQBsSh8oZAbWjGigfmVpv8nqTdSAkptD4pq+/4uiXoObJkyr0HbJJOeuV5WdhVjqw/jLCQAreHBJc6ETDQq6kKshKeR1pwLWTCNMkBaC3DosoixdrWPauRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704634; c=relaxed/simple;
	bh=XbywLo7TLmwiVSYMFXgs0Q7tcoif4V/s/i7wQ9R8joQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cpUmFA8hGO2ngbCTP53I3WZx471Y87GoKpFRXzJNsny+cTh2CaW57oT3BOyVqBw/bidP/GiOHb4w4QC8k3TfkxG4o7V/5pJz8c3L4N4pg0Ed45qcCJNIUKe+1LzCJ0+aqGN28/IZ7CeZgCBhVxYJwGy3eQlnaW9Q4IZodPLkHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvcQGysy; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f69383e653so13773477b3.1
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 14:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705704631; x=1706309431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cX5edNAyRXlgv6ZNVD4EGw6vjLdbpUYx/HNHgTpU3w=;
        b=UvcQGysypUVdXjhzt6KD6olMH9WA+DjUcnfu/LfV996eDXCy090+Y3u42PPaYXg83P
         mh40Ph9f+ZKkCgB7OkPasK4gUYVdIDWLDxZ4tdASVZTRna/MDcvTh9Traup7wTpGd+2/
         yoUTkLxWFwCk/133vr+/Dz2X7h8OWkhR/A8LBRr+e7joB/uvNzxPJlDpEGxQ5hhPcHh5
         p3GtvEB2llmXYPzK/ZewDTUa+yGuJhMq6bnsbGgkPsoXerl95ChLbOEhKJuA9wdyJWaK
         FKMmAM0tfZP4tMvBzc+BIY6Eeb84+ITBqi9SixkkQcDOTmWFkLzahuIogZXFcFExnEAQ
         tg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704631; x=1706309431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cX5edNAyRXlgv6ZNVD4EGw6vjLdbpUYx/HNHgTpU3w=;
        b=ClUYz4yz3SU+rYkSeevrttMSTLGJipVHHphqufr6C3ytQ7PfAOzsplGVHuQ28NOrez
         OQJSvzY2UQI8yCjlSgSvCUt1isruirwvbipqd0cl9kyZyKqvUTHnCSQoXcwmDbsVxKGU
         2uTraxRjMevMTjzntHxpJ4gZ3JXJx+JjgcguyLhobiGUiJigpz8Qt81EmYoZQmSKhGCA
         UyCoMPUprgcM/o04bjacVUeLBXA8lnavX9iRYm6Oax+WcYMHsfghRi/HvniEhzKgPEOV
         4sJ19jI8V1cYqmxkVPdK4JciUBUtSCG53fanKL0prV32Tbq11fOPwc5vHnzsvHvBkroC
         mazA==
X-Gm-Message-State: AOJu0YwhE651p61XxCBIy2k/WmBFeftnJMYehY2TXX02JvzIa9xaq+i/
	GGQmmylXN533ni7Km+oGW7EJVTklK70KAaXpBE3ABKC0Z/OF2xbpm0dEEAP6
X-Google-Smtp-Source: AGHT+IFc0Ai1JPV4smVJAJjKFhFB99blytMwnKZYRpwghR0wZEMcSqwi2xybojEg/1MUTWny57daAg==
X-Received: by 2002:a0d:e904:0:b0:5ff:90e7:4149 with SMTP id s4-20020a0de904000000b005ff90e74149mr560810ywe.22.1705704631251;
        Fri, 19 Jan 2024 14:50:31 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b170:5bda:247f:8c47])
        by smtp.gmail.com with ESMTPSA id s184-20020a819bc1000000b005ffa70964f4sm411770ywg.115.2024.01.19.14.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:50:31 -0800 (PST)
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
Subject: [PATCH bpf-next v17 05/14] bpf: make struct_ops_map support btfs other than btf_vmlinux.
Date: Fri, 19 Jan 2024 14:49:56 -0800
Message-Id: <20240119225005.668602-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119225005.668602-1-thinker.li@gmail.com>
References: <20240119225005.668602-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Once new struct_ops can be registered from modules, btf_vmlinux is no
longer the only btf that struct_ops_map would face.  st_map should remember
what btf it should use to get type information.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 9774f7824e8b..5ddcca4c4fba 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -46,6 +46,8 @@ struct bpf_struct_ops_map {
 	 * "links[]".
 	 */
 	void *image;
+	/* The owner moduler's btf. */
+	struct btf *btf;
 	/* uvalue->data stores the kernel struct
 	 * (e.g. tcp_congestion_ops) that is more useful
 	 * to userspace than the kvalue.  For example,
@@ -314,7 +316,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
-static int check_zero_holes(const struct btf_type *t, void *data)
+static int check_zero_holes(const struct btf *btf, const struct btf_type *t, void *data)
 {
 	const struct btf_member *member;
 	u32 i, moff, msize, prev_mend = 0;
@@ -326,8 +328,8 @@ static int check_zero_holes(const struct btf_type *t, void *data)
 		    memchr_inv(data + prev_mend, 0, moff - prev_mend))
 			return -EINVAL;
 
-		mtype = btf_type_by_id(btf_vmlinux, member->type);
-		mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
+		mtype = btf_type_by_id(btf, member->type);
+		mtype = btf_resolve_size(btf, mtype, &msize);
 		if (IS_ERR(mtype))
 			return PTR_ERR(mtype);
 		prev_mend = moff + msize;
@@ -401,12 +403,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (*(u32 *)key != 0)
 		return -E2BIG;
 
-	err = check_zero_holes(st_ops_desc->value_type, value);
+	err = check_zero_holes(st_map->btf, st_ops_desc->value_type, value);
 	if (err)
 		return err;
 
 	uvalue = value;
-	err = check_zero_holes(t, uvalue->data);
+	err = check_zero_holes(st_map->btf, t, uvalue->data);
 	if (err)
 		return err;
 
@@ -442,7 +444,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
-		ptype = btf_type_resolve_ptr(btf_vmlinux, member->type, NULL);
+		ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
 				goto reset_unlock;
@@ -467,8 +469,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		if (!ptype || !btf_type_is_func_proto(ptype)) {
 			u32 msize;
 
-			mtype = btf_type_by_id(btf_vmlinux, member->type);
-			mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
+			mtype = btf_type_by_id(st_map->btf, member->type);
+			mtype = btf_resolve_size(st_map->btf, mtype, &msize);
 			if (IS_ERR(mtype)) {
 				err = PTR_ERR(mtype);
 				goto reset_unlock;
@@ -607,6 +609,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 					     struct seq_file *m)
 {
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 	void *value;
 	int err;
 
@@ -616,7 +619,8 @@ static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 
 	err = bpf_struct_ops_map_sys_lookup_elem(map, key, value);
 	if (!err) {
-		btf_type_seq_show(btf_vmlinux, map->btf_vmlinux_value_type_id,
+		btf_type_seq_show(st_map->btf,
+				  map->btf_vmlinux_value_type_id,
 				  value, m);
 		seq_puts(m, "\n");
 	}
@@ -726,6 +730,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	st_map->btf = btf_vmlinux;
+
 	mutex_init(&st_map->lock);
 	bpf_map_init_from_attr(map, attr);
 
-- 
2.34.1


