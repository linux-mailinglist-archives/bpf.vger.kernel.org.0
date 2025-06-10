Return-Path: <bpf+bounces-60228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC60AAD4287
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2DC3A53A1
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C44A2609C1;
	Tue, 10 Jun 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT3NXDwJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0C725F99F
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582532; cv=none; b=QPFSgEQAqX5SeWSEBoZpae5RMpwR1tmQaGGixwzKXyQMjZDXveCw9OT9wG2ZyZVTsMipTvfdG8QT0MwW7Olwyvx0qRvrHgJPadWnn7lH4o4zYdrlaPKTZz2622pP5e3g/yi7HEr5Ei9H7ediOGbbqeNnwg4cF+NLgHFa9r5p+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582532; c=relaxed/simple;
	bh=QCle0bjh/aGCSSxKd/XYVJuEOZ2wTl0ahfdMWyaAj8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPd7mVVjOhIfFQ6AP4t4hCo8h5ZKl8dlotOG2no2/3lz5Y2Pyoe+5D767Nf2MVRBdPyFZY02hYBdNEpM72XNLlrlbKXnNkDVnO40QBCjHc//YyMGeNHqEHlCAVKdCTOkwR3a8t1e6QI3TXJtvUW4y/hlthXox6ASn8iON07NiCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NT3NXDwJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-addda47ebeaso1125560866b.1
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749582529; x=1750187329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRCmsVCtMk5VhiGbydKe2MYFeCZFlB1rAQiFqT/6R8o=;
        b=NT3NXDwJt4CeU3tSGqbPafd95XD4a9tYhbWJpnoNHzGdYuqNji9WvgzVrgsz/6CrIM
         kRfURGy3nT75IanuJAghEauyKhRGMWxoQjTTiFHPsmzwh0hXG+WtAA9G3xoOmNBOsM2q
         dPU9gZVASKLVxLGyoXzrkcfCRhfpTCcH2WMcJ/lyORzVtlEhPpTLagCFyZlD2fZNfi9x
         LE1h9oq4KnrbbDCRB0jck2PY7qDHISTdkvFRh3cvio3ohEMUdZFsTIH6rJJ3ixQfapkK
         hDk6c1kS56TG1FQPW+gLNjsze81D1uKz1QjG5j8vSTLDjxPNdc9F+hPpm2aUtRf4x2tT
         mmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749582529; x=1750187329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRCmsVCtMk5VhiGbydKe2MYFeCZFlB1rAQiFqT/6R8o=;
        b=lT5bITGk6ctrhbzA+rMPr5LW0U8B5srYByq/Nw2wxj9y1jXaaMvisjsg22zaBdNjSq
         N+mJIG7bugWKd77hWqQ3oY90nCF7D1F0rYK5ad1JhTerwFyC76NXcuEbU7pRJfCMSa8x
         O8/BF72SZdTwKyJxeBsPAolzCkPkmHfI7Xymu6fHCLe3UnrMYrK5UlpG9NZxRz7O3EY5
         pMsuf0ZWzXAXUajsPapuN8SWV0issVZ+fCvL3OXs+DXnQZ/mOqiQfvi1AfYq6EoMqWVk
         B72UXRVusAUsY98q66vJviTFSmSH1kYgc6yT4O1U0/En8UJfTW8CBk1WuAT/ERSZIedM
         j9SQ==
X-Gm-Message-State: AOJu0YwAadzOeQdUIR6QXvgvtNuyzn9O27wM06Lewj6rVPH1P/b/I0zW
	R087rmp7Yi3KnMcaABz7gTsSP/u5HLg/DbedIWVYZqOVjHWxSJ56O51N3JDrAn0k+2M=
X-Gm-Gg: ASbGncsgAHHxAxqp76bcdDs+hfARQgddZbFTzASe/bIRtmkv/qLymbujTMQvFvOwiFl
	vOw4QqDFU1ZuG8FPHfTfMCN8j2Gdmwt/zL/DZGwfAXMfb2X3PUcPDZa3OfBMMVHvfhRBOzbq/es
	5issi+MAYBdzi/CPpvAwBL7pcn5S1qBLIEFiV9wHSa2woB7X5AjlafF1UWKxOPqVfhYTYtNUM4b
	3ssFHcSGVQgJZvgvGZPxhRygDDzcbUBg3wEfGKr//yiZgnsrUBynBhpvgPByQYWHFLeErvgbvwm
	PfEyhtALcQa0dPWr7bkZnZUZyIpou+qqQMZVIDoX9w==
X-Google-Smtp-Source: AGHT+IEYn3+NCyO9asWE7bGu8qO8hiiMsKxmZ9AbePmz2PUfjF/XXFQd/wjjOK9szX5yDnU9hVMBnQ==
X-Received: by 2002:a17:907:9812:b0:add:f189:1214 with SMTP id a640c23a62f3a-ade8c712fb8mr3062066b.24.1749582528862;
        Tue, 10 Jun 2025 12:08:48 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:1505])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d7541f2sm764052666b.7.2025.06.10.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:08:48 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in veristat
Date: Tue, 10 Jun 2025 20:08:39 +0100
Message-ID: <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/veristat.c | 164 +++++++++++++++++++++----
 1 file changed, 142 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 8291de199aab..bc9ebf5a2985 100644
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
@@ -1419,9 +1421,25 @@ static int parse_var_atoms(const char *full_var, struct var_preset *preset)
 		preset->atoms = tmp;
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
@@ -1441,7 +1459,7 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
 	memset(cur, 0, sizeof(*cur));
 	(*cnt)++;
 
-	if (sscanf(expr, "%s = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
+	if (sscanf(expr, "%[][a-zA-Z0-9_.] = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
 		fprintf(stderr, "Failed to parse expression '%s'\n", expr);
 		return -EINVAL;
 	}
@@ -1534,6 +1552,75 @@ static bool is_preset_supported(const struct btf_type *t)
 	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
 }
 
+static int find_enum_value(const struct btf *btf, const char *name, long long *value)
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
+			*value = lvalue;
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
+	long long index;
+	int tid;
+
+	if (!btf_is_array(t))
+		return -EINVAL;
+
+	barr = btf_array(t);
+	tid = btf__resolve_type(btf, barr->type);
+	type = btf__type_by_id(btf, tid);
+	if (!btf_is_int(type) && !btf_is_any_enum(type) && !btf_is_composite(type)) {
+		fprintf(stderr,
+			"Unsupported array element type for variable %s. Only int, enum, struct, union are supported\n",
+			var_atom->name);
+		return -EINVAL;
+	}
+	switch (var_atom->index.type) {
+	case INTEGRAL:
+		index = var_atom->index.ivalue;
+		break;
+	case ENUMERATOR:
+		if (find_enum_value(btf, var_atom->index.svalue, &index) != 0) {
+			fprintf(stderr, "Can't resolve %s enum as an array index",
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
+		fprintf(stderr, "Preset index %lld is invalid or out of bounds [0, %u]\n",
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
@@ -1541,7 +1628,7 @@ const int btf_find_member(const struct btf *btf,
 			  int *member_tid,
 			  __u32 *member_offset)
 {
-	int i;
+	int i, err;
 
 	if (!btf_is_composite(parent_type))
 		return -EINVAL;
@@ -1550,37 +1637,57 @@ const int btf_find_member(const struct btf *btf,
 		const struct btf_member *member;
 		const struct btf_type *member_type;
 		int tid;
+		const char *name;
+		u32 offset;
 
 		member = btf_members(parent_type) + i;
 		tid =  btf__resolve_type(btf, member->type);
 		if (tid < 0)
 			return -EINVAL;
 
+		name = btf__name_by_offset(btf, member->name_off);
+		if (name[0] != '\0' && strcmp(var_atom->name, name) != 0)
+			continue;
+
+		if (btf_member_bitfield_size(parent_type, i) != 0) {
+			fprintf(stderr, "Bitfield presets are not supported %s\n",
+				name);
+			return -EINVAL;
+		}
+
 		member_type = btf__type_by_id(btf, tid);
-		if (member->name_off) {
-			const char *name = btf__name_by_offset(btf, member->name_off);
+		offset = parent_offset + member->offset;
 
-			if (strcmp(var_atom->name, name) == 0) {
-				if (btf_member_bitfield_size(parent_type, i) != 0) {
-					fprintf(stderr, "Bitfield presets are not supported %s\n",
-						name);
-					return -EINVAL;
-				}
-				*member_offset = parent_offset + member->offset;
-				*member_tid = tid;
-				return 0;
-			}
-		} else if (btf_is_composite(member_type)) {
+		if (name[0] == '\0' && btf_is_composite(member_type)) { /* anon struct/union */
 			int err;
 
-			err = btf_find_member(btf, member_type, parent_offset + member->offset,
+			err = btf_find_member(btf, member_type, offset,
 					      var_atom, member_tid, member_offset);
 			if (!err)
 				return 0;
+		} else if (name[0] && btf_is_array(member_type)) {
+			struct btf_var_secinfo sinfo = {.offset = 0};
+
+			err = adjust_array_secinfo(btf, member_type, var_atom, &sinfo);
+			if (err)
+				return err;
+
+			*member_tid = sinfo.type;
+			*member_offset = offset + sinfo.offset * 8;
+			return 0;
+		} else if (name[0]) {
+			if (var_atom->index.type != NONE) {
+				fprintf(stderr, "Array index is not expected for %s\n", name);
+				return -EINVAL;
+			}
+
+			*member_offset = offset;
+			*member_tid = tid;
+			return 0;
 		}
 	}
 
-	return -EINVAL;
+	return -ESRCH;
 }
 
 static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
@@ -1591,6 +1698,15 @@ static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
 	__u32 member_offset = 0;
 
 	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
+	if (btf_is_array(base_type)) {
+		err = adjust_array_secinfo(btf, base_type, &preset->atoms[0], sinfo);
+		if (err)
+			return err;
+		base_type = btf__type_by_id(btf, sinfo->type);
+	} else if (preset->atoms[0].index.type != NONE) {
+		fprintf(stderr, "Array index is not expected for %s\n", preset->atoms[0].name);
+		return -EINVAL;
+	}
 
 	for (i = 1; i < preset->atom_count; ++i) {
 		err = btf_find_member(btf, base_type, 0, &preset->atoms[i],
@@ -1742,6 +1858,7 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 		if (!presets[i].applied) {
 			fprintf(stderr, "Global variable preset %s has not been applied\n",
 				presets[i].full_name);
+			err = -EINVAL;
 		}
 		presets[i].applied = false;
 	}
@@ -2929,8 +3046,11 @@ int main(int argc, char **argv)
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


