Return-Path: <bpf+bounces-22533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D508605A9
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 23:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1552E284605
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC3137928;
	Thu, 22 Feb 2024 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFZAxIkz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2D137912
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640794; cv=none; b=VeIPprcsL8rKvhH/PDFXAF8OxkOfPOYPmbSfnkPb+mubh9xnevrIidCzc/2nKIGqn2M/IpyCLUuAaq2SNguIsECTdmHbagHx1BeYBi4k562bZwpz2d2B7WA5SYpwTtvzYk2wa+w51vjVj85CcMI0O/qb3mQDu1IMizE8OyBm0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640794; c=relaxed/simple;
	bh=JYlor7liByBS2LlEYz/edKDIPn+GA8eleujRxigKJPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTy/GCVscfaqhLBFtdEOCj8ezyFeBBi26N0wulmpIaGRZolKpjJhbMnBjCkwXhTiB/6H+XY3AIFFwpeeDOfK/x4lTx0pX/v6rrw0Gj1pUKb2KCn/jgtGN+PQYv+9KceSQNQWBc8argzYRRlhfxsewpanZkD9M1R3PkwWy0piw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFZAxIkz; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607d8506099so3094517b3.0
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 14:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708640791; x=1709245591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtHDSZGnVRHo3SsKsHaqf43fpvkFwz2UT1hdwLb4lMI=;
        b=bFZAxIkzO3fOpSL7Zm79zwPQbqVRoqRg7Kok6I44pJxwjfZuXUbxQZ6VYhmPzP3eBG
         nW7+PizjqOLP+btuNCkmYljEzVHVaWUhZz06oEMnLwmLT1wI97b2+JaMGpa+w4IjkwjE
         rOJbRjhx+9bYRvnUUY73iTrdrNkWCiD1K+BKs63UUDf8csv+nDaYOYX0J5ct8UgVWB4t
         UNhJGylkONA5UT6OHJEVrqrqsGgW0GvUwIVoEVG21wb0lm9oliUXlbzY75V0rxgO9Mu7
         0cawedyfu0kKHTtfrdyWnGop0RNhHFk5nG67MuRsyb0G3Iub94zzWEXBX56P2NEKXG2b
         s1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640791; x=1709245591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtHDSZGnVRHo3SsKsHaqf43fpvkFwz2UT1hdwLb4lMI=;
        b=ZEDJfSICUDt5yl6MsWfScN5MdqUnNx5gHKKRSqXuur/U1I55CaLlkAmApkWiHVaTqI
         fCNoKqTBRY7w4oLBU/sKbNEVh+3T648hqtc4truuDQpq89XcXx3liNMpxZzikTWfdmYa
         KkEvCvI2hDSwUjd2jASLmOI6IlWlU3dXJIGm1s8zWJDMQMD1lMJFLFqm/GfEfTDLkzse
         iaauD55SykRtiOxxAai+wYFnFkp4UhmWirS9uBt50o7AqmKxV7WWW5YpfSSTGF34eBnp
         86KrW2VFnLAbZouYIYb+FWUh8MY/cn77Y+u3yIDu5IjKXi60uDyxpPX+x1Re2OzxL/dR
         kZqA==
X-Gm-Message-State: AOJu0YwDaDJr4kBME8kghG06k02fPBMyRkYD/utn06T1tAT92r3CYRdT
	YeiWuoOBQ+j12hHfUPpNbFcudFkHnsRR0w3S2YO1RaCO34q9hjfjfToUUUXq
X-Google-Smtp-Source: AGHT+IEGhDpv6gtauv4IYtJ72FMmifU1GWzDrnYhK6DFaF7zN22B/oY5Rx6T1uhx3ewk7KphojXTIg==
X-Received: by 2002:a05:690c:84:b0:608:b439:4779 with SMTP id be4-20020a05690c008400b00608b4394779mr594049ywb.0.1708640791017;
        Thu, 22 Feb 2024 14:26:31 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34d2:7236:710a:117c])
        by smtp.gmail.com with ESMTPSA id e129-20020a0df587000000b00604a2e45cf2sm3280666ywf.140.2024.02.22.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:26:30 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 3/6] libbpf: Convert st_ops->data to shadow type.
Date: Thu, 22 Feb 2024 14:26:21 -0800
Message-Id: <20240222222624.1163754-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222222624.1163754-1-thinker.li@gmail.com>
References: <20240222222624.1163754-1-thinker.li@gmail.com>
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


