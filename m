Return-Path: <bpf+bounces-60112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAFCAD2A80
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378251890B0B
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0BB22B8A2;
	Mon,  9 Jun 2025 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJPzbuSw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208B22AE6D
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511672; cv=none; b=Cb2tQWVDfeSPEmJ7xrYAM5EjeaQoMHbUyv7iyV+wDzbRC5eDlW509yKyRpK7rNzsididFke1MhsP3TGtZXTDiRMAGaxn63igYvrffMoGgqKMSwMCgWW6f4LH391S0OQNhk+B+W7EYiCqgrDgknfLI3+N0ScTSa+ntybr7/5sCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511672; c=relaxed/simple;
	bh=hZ7oQT4QfFeBJy7Eo9HE107jt0if/uMqI6ArptE7OmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXh41yK7c0wB+xVYQG9lv9ltOwI2MyRRXmYxH/QiX2cKwjvcZUO+RpW7fFLvOCdkEe/lr7ewMqMrVTAezP39apN18+3NLGvBdOMucAEVkJ/+Di/YadYkkIgpTHWhJRe985R2cRNUqMCTDj9n3jAnLlJexxg4WMAEatPW9P8VONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJPzbuSw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234d3261631so33857975ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749511670; x=1750116470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtGLNdP8hS2jdtf1n+/wXHOYIPhcMa/Og6Hf+vKph4M=;
        b=nJPzbuSwzAniyAnM/fF58YQf+UIOsvWU1lKTyl5R6tkxpUiNmbmPz/RNdTwiROv3/P
         BcbKqjeOCom64UYNYyPdMIuPJKd0t027OB0mzRT8Lne7dnxY/sk1nhAblF30TNkVMxcA
         f/n5YWLOVFyI/zrLP5vYAZlfvuI/Sj/w/zVW/EhPOc3CyVUCly30rHuF/wtuVG0RI8il
         Nc0B1KybddezIGKCKg5oHEoz20Mv0Bie62QKcx0kC1KdjDfCp3zcIazwYf+t/ifAZz7H
         JUA4cQW7yuvynEngRc0WyRARmEk+AZ+//srzPqlAfud3aE07OrBojmK/StffXF6Bb6t1
         xV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749511670; x=1750116470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtGLNdP8hS2jdtf1n+/wXHOYIPhcMa/Og6Hf+vKph4M=;
        b=pO/aEZvVfFNct9cGQEyQng3tgpFecA6uiamPZjrGnax5Tf49wvBQbpiVgAhLtWd4rC
         KuB32YcSc2RO1OHmUuD2dtJ3wHjSaLeXzlXplWQZBPWBcH6xLXjITkIEaxLtELbrTV2Y
         Y9n1uACi5WI2mmwI+NKQ931/hijP0DzIFXHTq6/SSqGl3brktso2cfwYX4PLYIKwGgTo
         GmpYfc4atFdktyUbHB4S5XnIJ8EJsMYTBu7RvOXjDjOqH1+5m0SVQJJiJmvmln4aRCW3
         1emVy6uE5cDxwpL2RNJuTAM432B1026zh49YI9dz/FpMFtG0YNzoZjWPY99iqS8WtA6e
         KMoA==
X-Gm-Message-State: AOJu0YwKCyEdk2hTJhnltmEr7eIbbT7ISuKg3OAI8NZR4atDa79504hf
	V7FUjJNWISuebkL5nW1VAI06xQSedtxDYq7I5D3tNafIRrt2tv6my4yG5wyDZA==
X-Gm-Gg: ASbGncv/YluhCyHLvU+nBYRIRq0bZ961x8qtJNg6ZM19V/mCbjIGc/7Hn85gcAXnzpU
	mIDiwv9776aEn3cFAI9J71rM7Hj2dzVArIA8gyEsP+Xzp3Nwm8xqumqZgy7r000xO7eclFSDW9Y
	8eqhCCvKMlahZDdYxMCG5ODlIWTLAfQNaXbcu4V5NQKLS1CF84Ao0MPAirRAS07vzbLY1AtR5Cl
	mAf8pI0V0XXrape95b+ykMBhOqSpCiw0TiInCz1f+vR04B+TvVSIvcXyxkH+U0gjAt46Zh8dm1X
	fAgZRWB4KoiMK+rRDNOWsljLHyZWzSU/fPMRhBepD06HVFUqbuV2EA==
X-Google-Smtp-Source: AGHT+IGn0jw4PXQrOc10sH9p8vXl1Vm2VtJwlDJ82jJEUOJ5bUsL2rCoz/3M/S/O5Fp+68CndI1H/Q==
X-Received: by 2002:a17:903:8c6:b0:235:f55d:99cd with SMTP id d9443c01a7336-23601d04741mr216730335ad.9.1749511669540;
        Mon, 09 Jun 2025 16:27:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236038712b8sm58950545ad.88.2025.06.09.16.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 16:27:49 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/4] bpf: Save struct_ops instance pointer in bpf_prog_aux
Date: Mon,  9 Jun 2025 16:27:43 -0700
Message-ID: <20250609232746.1030044-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows struct_ops implementors to infer the calling struct_ops instance
inside a kfunc through prog->aux->this_st_ops. A new field, flags, is
added to bpf_struct_ops. If BPF_STRUCT_OPS_F_THIS_PTR is set in flags,
a pointer to the struct_ops structure registered to the kernel (i.e.,
kvalue->data) will be saved to prog->aux->this_st_ops. To access it in
a kfunc, use BPF_STRUCT_OPS_F_THIS_PTR with __prog argument [0]. The
verifier will fixup the argument with a pointer to prog->aux. this_st_ops
is protected by rcu and is valid until a struct_ops map is unregistered
updated.

For a struct_ops map with BPF_STRUCT_OPS_F_THIS_PTR, to make sure all
programs in it have the same this_st_ops, cmpxchg is used. Only if a
program is not already used in another struct_ops map also with
BPF_STRUCT_OPS_F_THIS_PTR can it be assigned to the current struct_ops
map.

[0]
commit bc049387b41f ("bpf: Add support for __prog argument suffix to
pass in prog->aux")
https://lore.kernel.org/r/20250513142812.1021591-1-memxor@gmail.com

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h         | 10 ++++++++++
 kernel/bpf/bpf_struct_ops.c | 38 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 83c56f40842b..25c3488ab926 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1640,6 +1640,11 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	/* pointer to struct_ops struct registered to the kernel.
+	 * Only valid when BPF_STRUCT_OPS_F_THIS_PTR is set in
+	 * bpf_struct_ops.flags
+	 */
+	void __rcu *this_st_ops;
 };
 
 struct bpf_prog {
@@ -1788,6 +1793,10 @@ struct bpf_token {
 struct bpf_struct_ops_value;
 struct btf_member;
 
+#define BPF_STRUCT_OPS_F_THIS_PTR BIT(0)
+
+#define BPF_STRUCT_OPS_FLAG_MASK BPF_STRUCT_OPS_F_THIS_PTR
+
 #define BPF_STRUCT_OPS_MAX_NR_MEMBERS 64
 /**
  * struct bpf_struct_ops - A structure of callbacks allowing a subsystem to
@@ -1853,6 +1862,7 @@ struct bpf_struct_ops {
 	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
+	u32 flags;
 };
 
 /* Every member of a struct_ops type has an instance even a member is not
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 96113633e391..717a2cec0b0f 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -533,6 +533,17 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
+static void bpf_struct_ops_map_clear_this_ptr(struct bpf_struct_ops_map *st_map)
+{
+	u32 i;
+
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->links[i])
+			break;
+		RCU_INIT_POINTER(st_map->links[i]->prog->aux->this_st_ops, NULL);
+	}
+}
+
 static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map *st_map)
 {
 	int i;
@@ -695,6 +706,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (flags)
 		return -EINVAL;
 
+	if (st_ops->flags & ~BPF_STRUCT_OPS_FLAG_MASK)
+		return -EINVAL;
+
 	if (*(u32 *)key != 0)
 		return -E2BIG;
 
@@ -801,6 +815,19 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			goto reset_unlock;
 		}
 
+		if (st_ops->flags & BPF_STRUCT_OPS_F_THIS_PTR) {
+			/* Make sure a struct_ops map will not have programs with
+			 * different this_st_ops. Once a program is associated with
+			 * a struct_ops map, it cannot be used in another struct_ops
+			 * map also with BPF_STRUCT_OPS_F_THIS_PTR
+			 */
+			if (cmpxchg(&prog->aux->this_st_ops, NULL, kdata)) {
+				bpf_prog_put(prog);
+				err = -EINVAL;
+				goto reset_unlock;
+			}
+		}
+
 		link = kzalloc(sizeof(*link), GFP_USER);
 		if (!link) {
 			bpf_prog_put(prog);
@@ -894,6 +921,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	bpf_struct_ops_map_free_ksyms(st_map);
 	bpf_struct_ops_map_free_image(st_map);
 	bpf_struct_ops_map_put_progs(st_map);
+	if (st_ops->flags & BPF_STRUCT_OPS_F_THIS_PTR)
+		bpf_struct_ops_map_clear_this_ptr(st_map);
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
 unlock:
@@ -919,6 +948,8 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 	switch (prev_state) {
 	case BPF_STRUCT_OPS_STATE_INUSE:
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, NULL);
+		if (st_map->st_ops_desc->st_ops->flags & BPF_STRUCT_OPS_F_THIS_PTR)
+			bpf_struct_ops_map_clear_this_ptr(st_map);
 		bpf_map_put(map);
 		return 0;
 	case BPF_STRUCT_OPS_STATE_TOBEFREE:
@@ -1194,6 +1225,8 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 		rcu_dereference_protected(st_link->map, true);
 	if (st_map) {
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
+		if (st_map->st_ops_desc->st_ops->flags & BPF_STRUCT_OPS_F_THIS_PTR)
+			bpf_struct_ops_map_clear_this_ptr(st_map);
 		bpf_map_put(&st_map->map);
 	}
 	kfree(st_link);
@@ -1268,6 +1301,9 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	if (err)
 		goto err_out;
 
+	if (st_map->st_ops_desc->st_ops->flags & BPF_STRUCT_OPS_F_THIS_PTR)
+		bpf_struct_ops_map_clear_this_ptr(st_map);
+
 	bpf_map_inc(new_map);
 	rcu_assign_pointer(st_link->map, new_map);
 	bpf_map_put(old_map);
@@ -1294,6 +1330,8 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 	st_map = container_of(map, struct bpf_struct_ops_map, map);
 
 	st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
+	if (st_map->st_ops_desc->st_ops->flags & BPF_STRUCT_OPS_F_THIS_PTR)
+		bpf_struct_ops_map_clear_this_ptr(st_map);
 
 	RCU_INIT_POINTER(st_link->map, NULL);
 	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
-- 
2.47.1


