Return-Path: <bpf+bounces-59784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9C9ACF74E
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7EA17A303
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0219827E1C3;
	Thu,  5 Jun 2025 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe+KomcB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907827A46A
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148614; cv=none; b=n5ekDJ5Y096bu8x/Ic6s2pFu3vgu0p3gJ2VOJQnPz0PuKtAzFUPJD3J+HMpWEqzLZ7M9Z6jyyiUFZ9QzNFTveC2SInSj7QL8IWVv75E0PejNTZIKPNwoV/3p7eZq0GhBOlyUA4iu2H3JlhzZO0ADKQyv5VHFiSBk+WZxR/Q20+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148614; c=relaxed/simple;
	bh=feUZGaX1Ma1gpkMD4UT3SEipboh2fgKlrjSyrTsoRx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhOBmR2WAdHLTM2RWaOkMQzDXW5BQmsmZ8zL2PbWlXuIqb25ag8E/u9vMD2bnRYQq4QHjkZxCzd8AtQdWkvFf1tnJ252wd/ptE2QjyxQFfGzgrY2OVHgZeQpT+SNdu5Q6Bl4oR4VkbARuXAjjYSQlGsEbKDY//L6ewa2gexkr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe+KomcB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-606b6dbe316so2327022a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749148611; x=1749753411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4evGhVXmNbz2EMXDnGKXDlPcx+RUvTs6qdzWKZAQgc=;
        b=fe+KomcB5zncosXXyhF2TMXu7KofKATpAGtqebiY6DN6QlC/Xwq8+bJd8JDTQKDokO
         IqnYL29QGbM/Hs1rbljFdpuQL2G/e52b+wgnCont+owcLTyl9IGTOXEXoCEHJPlutNFi
         E5zPgDgofj34RxthjK7jEfnfWfljuMsakFBIgV7y54G1ObOcxCmMCB/eJyd/jJTLx9ck
         4MhAFz5BcdHuwJ7h6cZ1fl1wRzJ2bVIoZSLV3lSwN302wHAl8ZrzwIDFA8xTb+T0pgRo
         WMOGUkY08BBjMncTFOTOJKDjCP/YihCVlDfL6wFVrb1ciNZQXpjAjenJWHev67nmCC4P
         TyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749148611; x=1749753411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4evGhVXmNbz2EMXDnGKXDlPcx+RUvTs6qdzWKZAQgc=;
        b=xC6bsioHR0pitLrxrs6mEPcDlOrhy/Y+MPNb3K+LiRjVob+Ft9jVc4U+0IOfS6ZU7P
         FMv1iiTVTveEPhyCZpaltGE41Z4lBWaTTmnozlIO+53yykOelBKfXL1C6+gHy3/kjOBt
         Cf102rndeEoOme6AmmSP+mFq2UdgWm5WWignapX717R0J+s4ynuUeWBZT3ZUTru4Nu4G
         ARri7M/3THc6F8b7M5AsH1akwiz84qa+mkR8SJMUMJNFpKlqZ4VJOfhP3U6XeSDVzAHK
         41Haw/ZJ6mLD2UcpgcdruwDdu5kBZdAsvOS7C0pr33UvJGZNkKcWJKk/vKGbWZWpvAfG
         ycGA==
X-Gm-Message-State: AOJu0YxX1zt0oYFQjps6/jdcMTZ7ql1oWVP0rf1N6zsPIzdDpvv337Eq
	SHukTu+LI/RQxtEON37fK9D03/a+fegYO91e+mbYxnTRopwXteqw89zeVHftvu+rdYo=
X-Gm-Gg: ASbGncvsbZMH5NxCOPUm5z8klt98v+KBaTrpGFaG+vk9tFcCtJXbAxIQLH+OSR9jK4j
	SvLXEj/tyroiESUOHXKgr8fTZI07X8wh2BleWEIsZhesF18/xMLIY2Wf1aroq6M2Hzw5L/G2GsX
	YrqrtCcBH0ug03vapP13ix3h13jdwP1MmBUbjXFCyMymtBQunYTaFUREIMUayo41XkOnrifa2O9
	j16vN+RZ9PNuXLROafetDRiLguIAZ/91yoDFlLqIrZDDd8gi8d7Ll5Xr5qas4AWPOwSZNw4G52a
	zBeasmNP55LqKG//bsno/u7Hh1Mry50=
X-Google-Smtp-Source: AGHT+IEMPOuo73sQ5jtVrGMRLC7WCWgEtmBQaEOWrOiY74ETmOR0WmClXoRNfn1FHjn+4Cj99yQCag==
X-Received: by 2002:a17:907:94cc:b0:add:fa4e:8a61 with SMTP id a640c23a62f3a-ade1a9e805emr31013166b.38.1749148610686;
        Thu, 05 Jun 2025 11:36:50 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:1013])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e87esm1301764566b.63.2025.06.05.11.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:36:50 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: support array presets in veristat
Date: Thu,  5 Jun 2025 19:36:41 +0100
Message-ID: <20250605183642.1323795-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605183642.1323795-1-mykyta.yatsenko5@gmail.com>
References: <20250605183642.1323795-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Implement support for presetting values for array elements in veristat.
For example:
```
sudo ./veristat set_global_vars.bpf.o -G "arr[3] = 1"
```
Arrays of structures and structure of arrays work, but each individual
scalar value has to be set separately: `foo[1].bar[2] = value`.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 145 +++++++++++++++++++++----
 1 file changed, 126 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index bd6f907f3868..5358417099a9 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -165,6 +165,7 @@ struct variant {
 
 struct var_preset_atom {
 	char *name;
+	struct variant index;
 };
 
 struct var_preset {
@@ -1404,7 +1405,8 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 
 static int parse_var_atoms(const char *full_var, struct var_preset *preset)
 {
-	char expr[256], *name, *saveptr;
+	char expr[256], var[256], idx[256], *name, *saveptr;
+	int n, err;
 
 	snprintf(expr, sizeof(expr), "%s", full_var);
 	preset->atom_count = 0;
@@ -1418,9 +1420,25 @@ static int parse_var_atoms(const char *full_var, struct var_preset *preset)
 		}
 		preset->atom_count++;
 
-		preset->atoms[i].name = strdup(name);
-		if (!preset->atoms[i].name)
-			return -ENOMEM;
+		if (sscanf(name, "%[a-zA-Z0-9_][%[a-zA-Z0-9]] %n", var, idx, &n) == 2 &&
+		    strlen(name) == n) {
+			/* current atom is an array, parse index */
+			preset->atoms[i].name = strdup(var);
+			if (!preset->atoms[i].name)
+				return -ENOMEM;
+			err = parse_variant(idx, &preset->atoms[i].index);
+			if (err)
+				return err;
+		} else if (sscanf(name, "%[a-zA-Z0-9_] %n", var, &n) == 1 &&
+			   strlen(name) == n) {
+			preset->atoms[i].name = strdup(name);
+			if (!preset->atoms[i].name)
+				return -ENOMEM;
+			preset->atoms[i].index.type = NONE;
+		} else {
+			fprintf(stderr, "Could not parse '%s'", name);
+			return -EINVAL;
+		}
 	}
 	return 0;
 }
@@ -1440,7 +1458,7 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
 	memset(cur, 0, sizeof(*cur));
 	(*cnt)++;
 
-	if (sscanf(expr, "%s = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
+	if (sscanf(expr, "%[][a-zA-Z0-9_.] = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
 		fprintf(stderr, "Failed to parse expression '%s'\n", expr);
 		return -EINVAL;
 	}
@@ -1533,6 +1551,74 @@ static bool is_preset_supported(const struct btf_type *t)
 	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
 }
 
+static int find_enum_value(const struct btf *btf, const char *name, int *value)
+{
+	const struct btf_type *t;
+	int cnt, i;
+	long long lvalue;
+
+	cnt = btf__type_cnt(btf);
+	for (i = 1; i != cnt; ++i) {
+		t = btf__type_by_id(btf, i);
+
+		if (!btf_is_any_enum(t))
+			continue;
+
+		if (enum_value_from_name(btf, t, name, &lvalue) == 0) {
+			*value = (int)lvalue;
+			return 0;
+		}
+	}
+	return -ESRCH;
+}
+
+static int adjust_array_secinfo(const struct btf *btf, const struct btf_type *t,
+				const struct var_preset_atom *var_atom,
+				struct btf_var_secinfo *sinfo)
+{
+	struct btf_array *barr;
+	const struct btf_type *type;
+	int tid, index;
+
+	if (!btf_is_array(t))
+		return -EINVAL;
+
+	barr = btf_array(t);
+	tid = btf__resolve_type(btf, barr->type);
+	type = btf__type_by_id(btf, tid);
+	if (!btf_is_int(type) && !btf_is_any_enum(type) && !btf_is_composite(type)) {
+		fprintf(stderr,
+			"Unsupported array type for variable %s. Only int, enum, struct, union are supported\n",
+			var_atom->name);
+		return -EINVAL;
+	}
+	switch (var_atom->index.type) {
+	case INTEGRAL:
+		index = var_atom->index.ivalue;
+		break;
+	case ENUMERATOR:
+		if (find_enum_value(btf, var_atom->index.svalue, &index) != 0) {
+			fprintf(stderr, "Could not find array index as enum value %s",
+				var_atom->index.svalue);
+			return -EINVAL;
+		}
+		break;
+	case NONE:
+		fprintf(stderr, "Array index is expected for %s\n", var_atom->name);
+		return -EINVAL;
+	}
+
+	if (index < 0 || index >= barr->nelems) {
+		fprintf(stderr, "Preset index %d is invalid or out of bounds [0, %d]\n",
+			index, barr->nelems);
+		return -EINVAL;
+	}
+	sinfo->size = type->size;
+	sinfo->type = tid;
+	sinfo->offset += index * type->size;
+	return 0;
+}
+
 const int btf_find_member(const struct btf *btf,
 			  const struct btf_type *parent_type,
 			  __u32 parent_offset,
@@ -1540,7 +1626,7 @@ const int btf_find_member(const struct btf *btf,
 			  int *member_tid,
 			  __u32 *member_offset)
 {
-	int i;
+	int i, err;
 
 	if (!btf_is_composite(parent_type))
 		return -EINVAL;
@@ -1559,16 +1645,27 @@ const int btf_find_member(const struct btf *btf,
 		if (member->name_off) {
 			const char *name = btf__name_by_offset(btf, member->name_off);
 
-			if (strcmp(var_atom->name, name) == 0) {
-				if (btf_member_bitfield_size(parent_type, i) != 0) {
-					fprintf(stderr, "Bitfield presets are not supported %s\n",
-						name);
-					return -EINVAL;
-				}
-				*member_offset = parent_offset + member->offset;
-				*member_tid = tid;
-				return 0;
+			if (strcmp(var_atom->name, name) != 0)
+				continue;
+
+			if (btf_member_bitfield_size(parent_type, i) != 0) {
+				fprintf(stderr, "Bitfield presets are not supported %s\n",
+					name);
+				return -EINVAL;
+			}
+			*member_offset = parent_offset + member->offset;
+			*member_tid = tid;
+			if (btf_is_array(member_type)) {
+				struct btf_var_secinfo sinfo = {.offset = 0};
+
+				err = adjust_array_secinfo(btf, member_type,
+							   var_atom, &sinfo);
+				if (err)
+					return err;
+				*member_tid = sinfo.type;
+				*member_offset += sinfo.offset * 8;
 			}
+			return 0;
 		} else if (btf_is_composite(member_type)) {
 			int err;
 
@@ -1579,7 +1676,7 @@ const int btf_find_member(const struct btf *btf,
 		}
 	}
 
-	return -EINVAL;
+	return -ESRCH;
 }
 
 static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
@@ -1590,6 +1687,12 @@ static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
 	__u32 member_offset = 0;
 
 	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
+	if (btf_is_array(base_type)) {
+		err = adjust_array_secinfo(btf, base_type, &preset->atoms[0], sinfo);
+		if (err)
+			return err;
+		base_type = btf__type_by_id(btf, sinfo->type);
+	}
 
 	for (i = 1; i < preset->atom_count; ++i) {
 		err = btf_find_member(btf, base_type, 0, &preset->atoms[i],
@@ -1739,8 +1842,9 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 	}
 	for (i = 0; i < npresets; ++i) {
 		if (!presets[i].applied) {
-			fprintf(stderr, "Global variable preset %s has not been applied\n",
-				presets[i].full_name);
+			fprintf(stderr, "Global variable preset %s has not been applied %s\n",
+				presets[i].full_name, presets[i].atoms[0].name);
+			err = -EINVAL;
 		}
 		presets[i].applied = false;
 	}
@@ -2928,8 +3032,11 @@ int main(int argc, char **argv)
 	free(env.deny_filters);
 	for (i = 0; i < env.npresets; ++i) {
 		free(env.presets[i].full_name);
-		for (j = 0; j < env.presets[i].atom_count; ++j)
+		for (j = 0; j < env.presets[i].atom_count; ++j) {
 			free(env.presets[i].atoms[j].name);
+			if (env.presets[i].atoms[j].index.type == ENUMERATOR)
+				free(env.presets[i].atoms[j].index.svalue);
+		}
 		free(env.presets[i].atoms);
 		if (env.presets[i].value.type == ENUMERATOR)
 			free(env.presets[i].value.svalue);
-- 
2.49.0


