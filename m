Return-Path: <bpf+bounces-22359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F75A85CD68
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252C5284E02
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 01:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB334694;
	Wed, 21 Feb 2024 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq3HXVDD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514F443E
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478629; cv=none; b=HOh61Mx8iVWle0kO43KJph019wXiiOLSzW/FonP72Q5eJw0gfNQ5xCW9Ma3/ZOiclwqpQawBvZ2+HyxqkZZroA3Zr1LVh5905dFOpzDHiFaH5eDlusLVtmbxzQaw1XPNBNxsfUur0SurtwVDt78VXJpBtr544Ru90Hos054vjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478629; c=relaxed/simple;
	bh=JYlor7liByBS2LlEYz/edKDIPn+GA8eleujRxigKJPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hwv1zlafjidARfk54tZruqJDu07T8hVzmqsWkGWTgn00b5obZ71Rlt3xqBEev+PfigmSNwb2CIQ9Ve582DyC0rS/VFn3CKApyx+MXq4C1SBRdmnVNiejH+7sejzwCsCcvIL521D2UcnZV2UE/6FzRs2BV6MAUv2o3zt4sYCUksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq3HXVDD; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607f8894550so612187b3.1
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708478627; x=1709083427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtHDSZGnVRHo3SsKsHaqf43fpvkFwz2UT1hdwLb4lMI=;
        b=Kq3HXVDDtP5PFVM//F6j9D9Mm3JkWNM6a37OXKRHfAg+EqD4y6wfW8VH/ZTVR+v78a
         ytN6sFmhV3UAWUJhNGo4myet0zvNS2fdevX5FoRAW9HiMBXR/5LlqE4mPQSe4hl7Pl82
         /XpFsU0Zak/btTcsyizSuTCGQ0AveyS0/uA12Z7fFtw9TlNcF018bGSNtPdu1Ao6iRW/
         IqbQHvXByLxSv90cpO7MUPbZxZGqJGpj0PRarJMaZEOhXEC21ie0EE1Hy0kViK+4sGj1
         RbPCumkwnU5I3f40G2sK7PXFTQ5fvT0ie+Nk11a+mnLIcoLrINg2tG38S4eQonP7W9vs
         TP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708478627; x=1709083427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtHDSZGnVRHo3SsKsHaqf43fpvkFwz2UT1hdwLb4lMI=;
        b=Hz6oOAZI1/4NUco+AYweZKHkHGCENzASLvZ8E8dO2kDOkc8xOeM0A6JMO9eVkfSMtF
         HdV5X0wxqJmJsBDaDE+KNNsEfQ6jpHCimjwXr9B+NJDJ7cItng6itwWP4AXQzd0KZJYN
         i8dF1LVLBe/Cem/ABvEeef5dzcAXrxUExLrRtg+H86wlsd8AqTVOEzJYDDSu6AO623Hs
         SXBTnB8znFHLi0DsP08WwEomZDZDkPsGVsIVZryOmZnk9mp6eAwrHBxopd89gW6B/E40
         eZB/K4iheBPybbuASrRHtqBXxvysheuUGHSwD5Xzy8eLsOqoAmOJBnbTau8RvKP4lGLu
         dC2g==
X-Gm-Message-State: AOJu0Yw+J1YoOnZ6hViLy50aHbgMPRL2LNEIH/AHBAlFmZ7IT4ho08iD
	CMQ/NqZB6Wa/TIpB9RW+03EyTrvkB2SKCWdOwD++Y2keKg4Ppd3zfmF8i8KU
X-Google-Smtp-Source: AGHT+IGG+KeAjxFotUr0bjjFkGRXsl7zhQ5bIb9hgUkQjMH3wn9NhRC9qAzaavVNyVX0MBs3t0i5Og==
X-Received: by 2002:a81:b243:0:b0:5fb:da77:af07 with SMTP id q64-20020a81b243000000b005fbda77af07mr15135691ywh.32.1708478626649;
        Tue, 20 Feb 2024 17:23:46 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id j64-20020a0de043000000b00607ef065781sm2396801ywe.138.2024.02.20.17.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 17:23:46 -0800 (PST)
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
Subject: [PATCH bpf-next v3 3/5] libbpf: Convert st_ops->data to shadow type.
Date: Tue, 20 Feb 2024 17:23:27 -0800
Message-Id: <20240221012329.1387275-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221012329.1387275-1-thinker.li@gmail.com>
References: <20240221012329.1387275-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Convert st_ops->data to the shadow type of the struct_ops map. The shadow
type of a struct_ops type is a variant of the original struct type
providing a way to access/change the values in the maps of the struct_ops
type.

bpf_map__initial_value() will return st_ops->data for struct_ops types. The
skeleton is going to use it as the pointer to the shadow type of the
original struct type.

One of the main differences between the original struct type and the shadow
type is that all function pointers of the shadow type are converted to
pointers of struct bpf_program. Users can replace these bpf_program
pointers with other BPF programs. The st_ops->progs[] will be updated
before updating the value of a map to reflect the changes made by users.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 465b50235a01..becbb4d81012 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1102,6 +1102,9 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		if (btf_is_ptr(mtype)) {
 			struct bpf_program *prog;
 
+			/* Update the value from the shadow type */
+			st_ops->progs[i] = *(struct bpf_program **)mdata;
+
 			prog = st_ops->progs[i];
 			if (!prog)
 				continue;
@@ -1172,6 +1175,36 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 	return 0;
 }
 
+/* Convert the data of a struct_ops map to shadow type.
+ *
+ * The function pointers are replaced with the pointers of bpf_program in
+ * st_ops->progs[].
+ */
+static void struct_ops_convert_shadow(struct bpf_map *map,
+				      const struct btf_type *t)
+{
+	struct btf *btf = map->obj->btf;
+	struct bpf_struct_ops *st_ops = map->st_ops;
+	const struct btf_member *m;
+	const struct btf_type *mtype;
+	char *data;
+	int i;
+
+	data = st_ops->data;
+
+	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
+		mtype = skip_mods_and_typedefs(btf, m->type, NULL);
+
+		if (btf_kind(mtype) != BTF_KIND_PTR)
+			continue;
+		if (!resolve_func_ptr(btf, m->type, NULL))
+			continue;
+
+		*((struct bpf_program **)(data + m->offset / 8)) =
+			st_ops->progs[i];
+	}
+}
+
 static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 				int shndx, Elf_Data *data, __u32 map_flags)
 {
@@ -7531,6 +7564,19 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 	return 0;
 }
 
+/* Convert the data to the shadow type for each struct_ops map. */
+static void bpf_object__init_shadow(struct bpf_object *obj)
+{
+	struct bpf_map *map;
+
+	bpf_object__for_each_map(map, obj) {
+		if (!bpf_map__is_struct_ops(map))
+			continue;
+
+		struct_ops_convert_shadow(map, map->st_ops->type);
+	}
+}
+
 static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 					  const struct bpf_object_open_opts *opts)
 {
@@ -7631,6 +7677,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 		goto out;
 
 	bpf_object__elf_finish(obj);
+	bpf_object__init_shadow(obj);
 
 	return obj;
 out:
@@ -9880,6 +9927,12 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 
 void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
 {
+	if (bpf_map__is_struct_ops(map)) {
+		if (psize)
+			*psize = map->def.value_size;
+		return map->st_ops->data;
+	}
+
 	if (!map->mmaped)
 		return NULL;
 	*psize = map->def.value_size;
-- 
2.34.1


