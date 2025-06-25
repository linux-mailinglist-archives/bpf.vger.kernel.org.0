Return-Path: <bpf+bounces-61551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF8CAE8B1B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FF516ED19
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800952E6D3F;
	Wed, 25 Jun 2025 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOoYjeT1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608C25C80E
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870773; cv=none; b=gWuBzna+siusavLRrVvR8fhYetaLEdx9TYAPEy7fEkYytP0IniE7wD2CD0yW/tosAa1OqCd0YiC0HkHNcuUh0O6kGrUW8Mc1/555L+5q5BIFvvYgIwA1AL3yn+9cQv/X4hkWALyy6MRiaHw9OODki1d+hybXcuS1zjxtv+MIhQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870773; c=relaxed/simple;
	bh=cm8P7NvjmQ9LxR+6twdZcoL8PWlmVBlrZzcY9CxNzpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlPFCz9Bh40XByrOegM1peyysDdgQfVq/fNMXagFP6xW3ozjSWWQQoIUhgiyqn9ByD2Ea4XwYCibzOa4RKWJHeOBCtPJnt9b3kfmd6cnktXjSMMREnxFS3lG9I0y6XG3P3sXvJVZG7V3KG+ws59Ga1EsYEq5JLIAXK6JmV6hTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOoYjeT1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so77484a12.2
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750870769; x=1751475569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9GERqsvsj78K4OVtkYCEyEN7BbiMMXLJjrmUzkiml8=;
        b=LOoYjeT17Z/zy6gVAbM9zU/tsnW7W0nybL4oTaIuzhHPELhLYRiymOCGUFdrJOMNOW
         +VSWRVv5wxWwFCgfk7vExfcBq/rdS0CmktVZP+yCT80kkpaebUUN25oJsZ3/h00B/2L8
         MSIFumjh0U3jeXsGXNwOUlIIRMD2fGz8lJIkNLr9I0F4zpPv99mVKGraaLIGOfh34ITW
         acjh6VI4djnjRiPh2yGTdxpzdxzERkoHeKlUKj8J2zC3iPvFOlTIhjLghMAXHG7bORgt
         o5xQoZSto+AQrbuhHEHJElO+othFsV+HjoMPKhgoOUH9K3RwnaP/btLpczx3ImyV+eDp
         o/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870769; x=1751475569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9GERqsvsj78K4OVtkYCEyEN7BbiMMXLJjrmUzkiml8=;
        b=xQPogbrtGwSwGhwQaZVvyPpSUYkPImWgn8uJMwfOHizILQ4WiQZkeanBdXJTH+paKF
         BQBKYLefDrQP1xU3VfJCnsrkELqltFcp46FbxMJaQ4uCxMkp53i6T2zILZCbI+rZxEzI
         vVKLrcotEKXCacugNSQVbNYQZ4WnnZfUfdaSSzhtO31x/a3Q/bkybJPFTLGHvRjxq2m6
         VGMiheCJ8yaM3JftCAuh0maYZJ4Eiw8OwR2N/NJ8fLrRAe349zIjIaj7htme1GJ7hmSI
         JbgJFLAzGFy1rUGfMPLQ4w3MS34w5l9uRiNdoT98Mm00QQrgBaF0Fvh65MGePah3M++j
         MxKw==
X-Gm-Message-State: AOJu0YyZ4t3f/TX4rVcBqnNgt/LGb6oYVphb/5p/XBAADPVYBwewcNJt
	aqe4iUEolBC7zPXMQ2xVFxlcGwc/+F1JE6T1gPUC9rj5742W325wNLqHWXqmgl3R
X-Gm-Gg: ASbGncstXQ4AINU/Hpo2aZBhXbz598iAIpIAfiL2N93WwpyXA3P1zp1WF7BFPSYtypq
	6joukR3bs/2Gdu94zOP/sy3dcYvLpd7aup5dChSHhaezF8OUAcVnhY/DqYezXIzyDmIr3P5w70n
	czns0CS7ghXR/n9LbfbvzOJq9pdHEy5MpGM+Yrt4Cf/Zz+NeZNnt0LW4hPL3ZznBlXP5qFNo7l/
	oIOfvDbTkhZJ+Kk2P2vlJ8T+jlhC54csI3B8WUAEA8iMIDFKkbz049r41zOZF8SQx4CbKUN8+uI
	IYlrGUsxSZrIkwuXFPsKPcSnmdsH5a6YCkBsF6AU0w==
X-Google-Smtp-Source: AGHT+IF02wNfFmM5oRq65UDH61QwK65oAKendipSPJtcA7H9Z/YR7zqzKE8yT8Nd/qOfo1Y6eLK6oQ==
X-Received: by 2002:a05:6402:5244:b0:607:19b6:8cec with SMTP id 4fb4d7f45d1cf-60c66de30c0mr373406a12.33.1750870769018;
        Wed, 25 Jun 2025 09:59:29 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:b255])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f196f84sm2726679a12.14.2025.06.25.09.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:59:23 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 2/3] selftests/bpf: support array presets in veristat
Date: Wed, 25 Jun 2025 17:59:03 +0100
Message-ID: <20250625165904.87820-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
References: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/veristat.c | 239 +++++++++++++++++++------
 1 file changed, 189 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 483442c08ecf..9c67adcf0a33 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -165,7 +165,11 @@ struct rvalue {
 };
 
 struct field_access {
-	char *name;
+	enum { FIELD_NAME, ARRAY_INDEX } type;
+	union {
+		char *name;
+		struct rvalue index;
+	};
 };
 
 struct var_preset {
@@ -1629,28 +1633,60 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 		free(buf);
 
 	return 0;
-};
+}
+
+static int append_preset_atom(struct var_preset *preset, char *value, bool is_index)
+{
+	struct field_access *tmp;
+	int i = preset->atom_count;
+	int err;
+
+	tmp = reallocarray(preset->atoms, i + 1, sizeof(*preset->atoms));
+	if (!tmp)
+		return -ENOMEM;
+
+	preset->atoms = tmp;
+	preset->atom_count++;
+
+	if (is_index) {
+		preset->atoms[i].type = ARRAY_INDEX;
+		err = parse_rvalue(value, &preset->atoms[i].index);
+		if (err)
+			return err;
+	} else {
+		preset->atoms[i].type = FIELD_NAME;
+		preset->atoms[i].name = strdup(value);
+		if (!preset->atoms[i].name)
+			return -ENOMEM;
+	}
+	return 0;
+}
 
 static int parse_var_atoms(const char *full_var, struct var_preset *preset)
 {
-	char expr[256], *name, *saveptr;
+	char expr[256], var[256], *name, *saveptr;
+	int n, len, off;
 
 	snprintf(expr, sizeof(expr), "%s", full_var);
 	preset->atom_count = 0;
 	while ((name = strtok_r(preset->atom_count ? NULL : expr, ".", &saveptr))) {
-		struct field_access *tmp;
-		int i = preset->atom_count;
-
-		tmp = reallocarray(preset->atoms, i + 1, sizeof(*preset->atoms));
-		if (!tmp)
-			return -ENOMEM;
-
-		preset->atoms = tmp;
-		preset->atom_count++;
+		len = strlen(name);
+		/* parse variable name */
+		if (sscanf(name, "%[a-zA-Z0-9_] %n", var, &off) != 1) {
+			fprintf(stderr, "Can't parse %s\n", name);
+			return -EINVAL;
+		}
+		append_preset_atom(preset, var, false);
 
-		preset->atoms[i].name = strdup(name);
-		if (!preset->atoms[i].name)
-			return -ENOMEM;
+		/* parse optional array indexes */
+		while (off < len) {
+			if (sscanf(name + off, " [ %[a-zA-Z0-9_] ] %n", var, &n) != 1) {
+				fprintf(stderr, "Can't parse %s as index\n", name + off);
+				return -EINVAL;
+			}
+			append_preset_atom(preset, var, true);
+			off += n;
+		}
 	}
 	return 0;
 }
@@ -1660,7 +1696,7 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
 	void *tmp;
 	struct var_preset *cur;
 	char var[256], val[256];
-	int n, err;
+	int n, err, i;
 
 	tmp = realloc(*presets, (*cnt + 1) * sizeof(**presets));
 	if (!tmp)
@@ -1670,10 +1706,16 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
 	memset(cur, 0, sizeof(*cur));
 	(*cnt)++;
 
-	if (sscanf(expr, "%s = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
+	if (sscanf(expr, " %[][a-zA-Z0-9_. ] = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
 		fprintf(stderr, "Failed to parse expression '%s'\n", expr);
 		return -EINVAL;
 	}
+	/* Remove trailing spaces from var, as scanf may add those */
+	for (i = strlen(var) - 1; i > 0; --i) {
+		if (!isspace(var[i]))
+			break;
+		var[i] = '\0';
+	}
 
 	err = parse_rvalue(val, &cur->value);
 	if (err)
@@ -1763,22 +1805,96 @@ static bool is_preset_supported(const struct btf_type *t)
 	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
 }
 
-const int btf_find_member(const struct btf *btf,
-			  const struct btf_type *parent_type,
-			  __u32 parent_offset,
-			  const char *member_name,
-			  int *member_tid,
-			  __u32 *member_offset)
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
+static int resolve_rvalue(struct btf *btf, const struct rvalue *rvalue, long long *result)
+{
+	int err = 0;
+
+	switch (rvalue->type) {
+	case INTEGRAL:
+		*result = rvalue->ivalue;
+		return 0;
+	case ENUMERATOR:
+		err = find_enum_value(btf, rvalue->svalue, result);
+		if (err) {
+			fprintf(stderr, "Can't resolve enum value %s\n", rvalue->svalue);
+			return err;
+		}
+		return 0;
+	default:
+		fprintf(stderr, "Unknown rvalue type\n");
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int adjust_var_secinfo_array(struct btf *btf, int tid, struct field_access *atom,
+				    const char *array_name, struct btf_var_secinfo *sinfo)
+{
+	const struct btf_type *t;
+	struct btf_array *barr;
+	long long idx;
+	int err;
+
+	tid = btf__resolve_type(btf, tid);
+	t = btf__type_by_id(btf, tid);
+	if (!btf_is_array(t)) {
+		fprintf(stderr, "Array index is not expected for %s\n",
+			array_name);
+		return -EINVAL;
+	}
+	barr = btf_array(t);
+	err = resolve_rvalue(btf, &atom->index, &idx);
+	if (err)
+		return err;
+	if (idx < 0 || idx >= barr->nelems) {
+		fprintf(stderr, "Array index %lld is out of bounds [0, %u]: %s\n",
+			idx, barr->nelems, array_name);
+		return -EINVAL;
+	}
+	sinfo->size = btf__resolve_size(btf, barr->type);
+	sinfo->offset += sinfo->size * idx;
+	sinfo->type = btf__resolve_type(btf, barr->type);
+	return 0;
+}
+
+static int adjust_var_secinfo_member(const struct btf *btf,
+				     const struct btf_type *parent_type,
+				     __u32 parent_offset,
+				     const char *member_name,
+				     struct btf_var_secinfo *sinfo)
 {
 	int i;
 
-	if (!btf_is_composite(parent_type))
+	if (!btf_is_composite(parent_type)) {
+		fprintf(stderr, "Can't resolve field %s for non-composite type\n", member_name);
 		return -EINVAL;
+	}
 
 	for (i = 0; i < btf_vlen(parent_type); ++i) {
 		const struct btf_member *member;
 		const struct btf_type *member_type;
-		int tid;
+		int tid, off;
 
 		member = btf_members(parent_type) + i;
 		tid =  btf__resolve_type(btf, member->type);
@@ -1786,6 +1902,7 @@ const int btf_find_member(const struct btf *btf,
 			return -EINVAL;
 
 		member_type = btf__type_by_id(btf, tid);
+		off = parent_offset + member->offset;
 		if (member->name_off) {
 			const char *name = btf__name_by_offset(btf, member->name_off);
 
@@ -1795,15 +1912,16 @@ const int btf_find_member(const struct btf *btf,
 						name);
 					return -EINVAL;
 				}
-				*member_offset = parent_offset + member->offset;
-				*member_tid = tid;
+				sinfo->offset += off / 8;
+				sinfo->type = tid;
+				sinfo->size = member_type->size;
 				return 0;
 			}
 		} else if (btf_is_composite(member_type)) {
 			int err;
 
-			err = btf_find_member(btf, member_type, parent_offset + member->offset,
-					      member_name, member_tid, member_offset);
+			err = adjust_var_secinfo_member(btf, member_type, off,
+							member_name, sinfo);
 			if (!err)
 				return 0;
 		}
@@ -1815,26 +1933,39 @@ const int btf_find_member(const struct btf *btf,
 static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
 			      struct btf_var_secinfo *sinfo, struct var_preset *preset)
 {
-	const struct btf_type *base_type, *member_type;
-	int err, member_tid, i;
-	__u32 member_offset = 0;
+	const struct btf_type *base_type;
+	const char *prev_name;
+	int err, i;
+	int tid;
+
+	assert(preset->atom_count > 0);
+	assert(preset->atoms[0].type == FIELD_NAME);
 
-	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
+	tid = btf__resolve_type(btf, t->type);
+	base_type = btf__type_by_id(btf, tid);
+	prev_name = preset->atoms[0].name;
 
 	for (i = 1; i < preset->atom_count; ++i) {
-		err = btf_find_member(btf, base_type, 0, preset->atoms[i].name,
-				      &member_tid, &member_offset);
-		if (err) {
-			fprintf(stderr, "Could not find member %s for variable %s\n",
-				preset->atoms[i].name, preset->atoms[i - 1].name);
-			return err;
+		struct field_access *atom = preset->atoms + i;
+
+		switch (atom->type) {
+		case ARRAY_INDEX:
+			err = adjust_var_secinfo_array(btf, tid, atom, prev_name, sinfo);
+			break;
+		case FIELD_NAME:
+			err = adjust_var_secinfo_member(btf, base_type, 0, atom->name, sinfo);
+			prev_name = atom->name;
+			break;
+		default:
+			fprintf(stderr, "Unknown field_access type\n");
+			return -EOPNOTSUPP;
 		}
-		member_type = btf__type_by_id(btf, member_tid);
-		sinfo->offset += member_offset / 8;
-		sinfo->size = member_type->size;
-		sinfo->type = member_tid;
-		base_type = member_type;
+		if (err)
+			return err;
+		base_type = btf__type_by_id(btf, sinfo->type);
+		tid = sinfo->type;
 	}
+
 	return 0;
 }
 
@@ -1853,8 +1984,8 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf,
 		return -EINVAL;
 	}
 	if (!is_preset_supported(base_type)) {
-		fprintf(stderr, "Setting value for type %s is not supported\n",
-			btf__name_by_offset(btf, base_type->name_off));
+		fprintf(stderr, "Can't set %s. Only ints and enums are supported\n",
+			preset->full_name);
 		return -EINVAL;
 	}
 
@@ -1971,6 +2102,7 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 		if (!presets[i].applied) {
 			fprintf(stderr, "Global variable preset %s has not been applied\n",
 				presets[i].full_name);
+			err = -EINVAL;
 		}
 		presets[i].applied = false;
 	}
@@ -3164,11 +3296,18 @@ int main(int argc, char **argv)
 	free(env.deny_filters);
 	for (i = 0; i < env.npresets; ++i) {
 		free(env.presets[i].full_name);
-		for (j = 0; j < env.presets[i].atom_count; ++j)
-			free(env.presets[i].atoms[j].name);
+		for (j = 0; j < env.presets[i].atom_count; ++j) {
+			switch (env.presets[i].atoms[j].type) {
+			case FIELD_NAME:
+				free(env.presets[i].atoms[j].name);
+				break;
+			case ARRAY_INDEX:
+				if (env.presets[i].atoms[j].index.type == ENUMERATOR)
+					free(env.presets[i].atoms[j].index.svalue);
+				break;
+			}
+		}
 		free(env.presets[i].atoms);
-		if (env.presets[i].value.type == ENUMERATOR)
-			free(env.presets[i].value.svalue);
 	}
 	free(env.presets);
 	return -err;
-- 
2.50.0


