Return-Path: <bpf+bounces-61550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E87EAE8B3C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8CE1885876
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3806C2E427E;
	Wed, 25 Jun 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8HWr/tR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B3286425
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870764; cv=none; b=qgTVxK3udNySl14/5egaFSA3n53Wi00zJel1rw6w2uHDI65yi9bXzOBXemKd3j134hgNxnfrna78n2rZSaWfWP1bJiy4qeaRr5zKpygVWfwV7wNpQRyWfwHBMJgGNk8kY+Hj/LIzvxdpROHKruwr7bgNmnxffqNWpLSid/5bSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870764; c=relaxed/simple;
	bh=QozY651s7jwWhBgdUWV2mpFXR2rZxEhp+vFJH3B1SNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBTX0aQJezgFpWi+X1xcLeNeu1BW0C53GI0T6euMluyvdO1t3LhsJN+3FluLV9ygQ0a61sMx6TTCNhQE4rwzdktZ0csaSWYpEhuo+0iRZW2luNjvuqd2fG5dUdD9qXhU2L0D7+7UUbm3GGrkZfITxUFFPesS1nyfxOsPQ7rtwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8HWr/tR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so39090a12.2
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750870761; x=1751475561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzG9V0iS2QMMJYnG4SiJcyj0vboQZdyvQ6ltU6SMI+k=;
        b=Q8HWr/tR5fnp1et/b97C7nsrYXQKETeLq6ifjnJYqnzIEtqDSBGR+LIovRybSBMnLt
         hmN5VEvAQNwM7Kv4hKt5089rbZvngByF1gqf3Bg/NgtERaSZYdCQqFlX/CdNPi88dOKm
         Uf4ZWLCr19zwthAqTSIP4XNmInGgoifnnULdNykM4vOI/ET6Dyszs50Mqixe1Cs+YJyN
         itYUSC/0C5uwfR1XRRK/K5HTkurRXLNEbpALHHUXtLWHbvcnqx5ZNCPeyxdj2uMnJ9WB
         qfT1w/rHoGXjgOfHu54d5jcYOSQjoD61cMDqzJenX5ytm38DAmZ4lT2LTwXnNU0z+IBh
         nORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870761; x=1751475561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzG9V0iS2QMMJYnG4SiJcyj0vboQZdyvQ6ltU6SMI+k=;
        b=uHcOeRn757XdjgTGLb2fuN5CqLj3PbjHNgmzOPuRt9k3QdsJCN5dJsq3la6e/FJnDt
         l7CacuM6kgm/SWhMfbLwrQ4YEdHrgUBaNsw3RhSlk01WOPU99ZkCJZL1x2YsEHOwMAzo
         OeD4h/G+EkEknolhyI6awPZRfOyn7S0BKAXElCEnXptzKJtyr7c7VqlMt4sig62e+x4f
         1shJf94JO+i6GkCgOJli3wtj9B4YtlzN7skvVzMEmcRgf7eEAufa4/rsu5jGRe0KIXWq
         Vh45LN6dFJrQa1JOrbdAuci/unEAouAuewJ5nRUGbIgMybiTMIaOqzib6LN0WGqLWXf4
         2MZw==
X-Gm-Message-State: AOJu0YzFq/9LDIz6P+h0fIl0NcYxDp7wtfg4oNEjFviGpPsXILsLKTpq
	tbnXv12YFUxCRe5MmzVGWHrUmoISCYR8i1uVjT8yn604AS+maEaMmK55rkqX/RjE
X-Gm-Gg: ASbGncuAyfeYYrBjOxVD4s1ZXkkbbRFUpC8CWpirXYt934sg7uWcFF6U1W4Yj8odfln
	RWkreoI7LXp+pXijdxgPsVFdA42HMw0FebWn9CC3gFVLInAM1s2slQEKWq0Cw5uW585d7HKbRhl
	gs0VplfpgIVFWEK4uZ3OPQF+W8M9FKRizhiycdaplmOpjI2LwUc+rguPkNEQlvh9gGbn3UyOqd1
	V8BwT0JIJx/QuJewHMmGFYWH9kk7NVGUYcI7kWO8PRFqkD7Vu5tUczb4SNOblYDDmJ+p0oTfVVK
	U6ltLBTv1lAarUh+xQog8TheNkU/YTFcAfk4vkGiag==
X-Google-Smtp-Source: AGHT+IEgexNfjfMXGjIaRlzEQoW5GH2DH+DOEZLjOgZ5Y2JUBcQjrwMbqP5/GMhk7zBpwk4PWVdkcA==
X-Received: by 2002:a05:6402:3586:b0:606:9211:e293 with SMTP id 4fb4d7f45d1cf-60c4dc96962mr3016454a12.9.1750870760674;
        Wed, 25 Jun 2025 09:59:20 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:b255])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f482e8csm2774131a12.59.2025.06.25.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:59:16 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 1/3] selftests/bpf: separate var preset parsing in veristat
Date: Wed, 25 Jun 2025 17:59:02 +0100
Message-ID: <20250625165904.87820-2-mykyta.yatsenko5@gmail.com>
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

Refactor var preset parsing in veristat to simplify implementation.
Prepare parsed variable beforehand so that parsing logic is separated
from functionality of calculating offsets and searching fields.
Introduce rvalue struct, storing either int or enum (string value),
will be reused in the next patch, extract parsing rvalue into a
separate function.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 152 ++++++++++++++++---------
 1 file changed, 99 insertions(+), 53 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 56771650ee8c..483442c08ecf 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -156,13 +156,23 @@ struct filter {
 	bool abs;
 };
 
-struct var_preset {
-	char *name;
+struct rvalue {
 	enum { INTEGRAL, ENUMERATOR } type;
 	union {
 		long long ivalue;
 		char *svalue;
 	};
+};
+
+struct field_access {
+	char *name;
+};
+
+struct var_preset {
+	struct field_access *atoms;
+	int atom_count;
+	char *full_name;
+	struct rvalue value;
 	bool applied;
 };
 
@@ -1497,6 +1507,35 @@ static int reset_stat_cgroup(void)
 	return 0;
 }
 
+static int parse_rvalue(const char *val, struct rvalue *rvalue)
+{
+	long long value;
+	char *val_end;
+
+	if (val[0] == '-' || isdigit(val[0])) {
+		/* must be a number */
+		errno = 0;
+		value = strtoll(val, &val_end, 0);
+		if (errno == ERANGE) {
+			errno = 0;
+			value = strtoull(val, &val_end, 0);
+		}
+		if (errno || *val_end != '\0') {
+			fprintf(stderr, "Failed to parse value '%s'\n", val);
+			return -EINVAL;
+		}
+		rvalue->ivalue = value;
+		rvalue->type = INTEGRAL;
+	} else {
+		/* if not a number, consider it enum value */
+		rvalue->svalue = strdup(val);
+		if (!rvalue->svalue)
+			return -ENOMEM;
+		rvalue->type = ENUMERATOR;
+	}
+	return 0;
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1592,13 +1631,36 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	return 0;
 };
 
+static int parse_var_atoms(const char *full_var, struct var_preset *preset)
+{
+	char expr[256], *name, *saveptr;
+
+	snprintf(expr, sizeof(expr), "%s", full_var);
+	preset->atom_count = 0;
+	while ((name = strtok_r(preset->atom_count ? NULL : expr, ".", &saveptr))) {
+		struct field_access *tmp;
+		int i = preset->atom_count;
+
+		tmp = reallocarray(preset->atoms, i + 1, sizeof(*preset->atoms));
+		if (!tmp)
+			return -ENOMEM;
+
+		preset->atoms = tmp;
+		preset->atom_count++;
+
+		preset->atoms[i].name = strdup(name);
+		if (!preset->atoms[i].name)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 static int append_var_preset(struct var_preset **presets, int *cnt, const char *expr)
 {
 	void *tmp;
 	struct var_preset *cur;
-	char var[256], val[256], *val_end;
-	long long value;
-	int n;
+	char var[256], val[256];
+	int n, err;
 
 	tmp = realloc(*presets, (*cnt + 1) * sizeof(**presets));
 	if (!tmp)
@@ -1613,32 +1675,18 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
 		return -EINVAL;
 	}
 
-	if (val[0] == '-' || isdigit(val[0])) {
-		/* must be a number */
-		errno = 0;
-		value = strtoll(val, &val_end, 0);
-		if (errno == ERANGE) {
-			errno = 0;
-			value = strtoull(val, &val_end, 0);
-		}
-		if (errno || *val_end != '\0') {
-			fprintf(stderr, "Failed to parse value '%s'\n", val);
-			return -EINVAL;
-		}
-		cur->ivalue = value;
-		cur->type = INTEGRAL;
-	} else {
-		/* if not a number, consider it enum value */
-		cur->svalue = strdup(val);
-		if (!cur->svalue)
-			return -ENOMEM;
-		cur->type = ENUMERATOR;
-	}
+	err = parse_rvalue(val, &cur->value);
+	if (err)
+		return err;
 
-	cur->name = strdup(var);
-	if (!cur->name)
+	cur->full_name = strdup(var);
+	if (!cur->full_name)
 		return -ENOMEM;
 
+	err = parse_var_atoms(var, cur);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -1765,22 +1813,20 @@ const int btf_find_member(const struct btf *btf,
 }
 
 static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
-			      struct btf_var_secinfo *sinfo, const char *var)
+			      struct btf_var_secinfo *sinfo, struct var_preset *preset)
 {
-	char expr[256], *saveptr;
 	const struct btf_type *base_type, *member_type;
-	int err, member_tid;
-	char *name;
+	int err, member_tid, i;
 	__u32 member_offset = 0;
 
 	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
-	snprintf(expr, sizeof(expr), "%s", var);
-	strtok_r(expr, ".", &saveptr);
 
-	while ((name = strtok_r(NULL, ".", &saveptr))) {
-		err = btf_find_member(btf, base_type, 0, name, &member_tid, &member_offset);
+	for (i = 1; i < preset->atom_count; ++i) {
+		err = btf_find_member(btf, base_type, 0, preset->atoms[i].name,
+				      &member_tid, &member_offset);
 		if (err) {
-			fprintf(stderr, "Could not find member %s for variable %s\n", name, var);
+			fprintf(stderr, "Could not find member %s for variable %s\n",
+				preset->atoms[i].name, preset->atoms[i - 1].name);
 			return err;
 		}
 		member_type = btf__type_by_id(btf, member_tid);
@@ -1798,7 +1844,7 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf,
 {
 	const struct btf_type *base_type;
 	void *ptr;
-	long long value = preset->ivalue;
+	long long value = preset->value.ivalue;
 	size_t size;
 
 	base_type = btf__type_by_id(btf, btf__resolve_type(btf, sinfo->type));
@@ -1812,17 +1858,18 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf,
 		return -EINVAL;
 	}
 
-	if (preset->type == ENUMERATOR) {
+	if (preset->value.type == ENUMERATOR) {
 		if (btf_is_any_enum(base_type)) {
-			if (enum_value_from_name(btf, base_type, preset->svalue, &value)) {
+			if (enum_value_from_name(btf, base_type, preset->value.svalue, &value)) {
 				fprintf(stderr,
 					"Failed to find integer value for enum element %s\n",
-					preset->svalue);
+					preset->value.svalue);
 				return -EINVAL;
 			}
 		} else {
 			fprintf(stderr, "Value %s is not supported for type %s\n",
-				preset->svalue, btf__name_by_offset(btf, base_type->name_off));
+				preset->value.svalue,
+				btf__name_by_offset(btf, base_type->name_off));
 			return -EINVAL;
 		}
 	}
@@ -1889,20 +1936,16 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 		for (j = 0; j < n; ++j, ++sinfo) {
 			const struct btf_type *var_type = btf__type_by_id(btf, sinfo->type);
 			const char *var_name;
-			int var_len;
 
 			if (!btf_is_var(var_type))
 				continue;
 
 			var_name = btf__name_by_offset(btf, var_type->name_off);
-			var_len = strlen(var_name);
 
 			for (k = 0; k < npresets; ++k) {
 				struct btf_var_secinfo tmp_sinfo;
 
-				if (strncmp(var_name, presets[k].name, var_len) != 0 ||
-				    (presets[k].name[var_len] != '\0' &&
-				     presets[k].name[var_len] != '.'))
+				if (strcmp(var_name, presets[k].atoms[0].name) != 0)
 					continue;
 
 				if (presets[k].applied) {
@@ -1912,7 +1955,7 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 				}
 				tmp_sinfo = *sinfo;
 				err = adjust_var_secinfo(btf, var_type,
-							 &tmp_sinfo, presets[k].name);
+							 &tmp_sinfo, presets + k);
 				if (err)
 					return err;
 
@@ -1927,7 +1970,7 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 	for (i = 0; i < npresets; ++i) {
 		if (!presets[i].applied) {
 			fprintf(stderr, "Global variable preset %s has not been applied\n",
-				presets[i].name);
+				presets[i].full_name);
 		}
 		presets[i].applied = false;
 	}
@@ -3061,7 +3104,7 @@ static int handle_replay_mode(void)
 
 int main(int argc, char **argv)
 {
-	int err = 0, i;
+	int err = 0, i, j;
 
 	if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
 		return 1;
@@ -3120,9 +3163,12 @@ int main(int argc, char **argv)
 	}
 	free(env.deny_filters);
 	for (i = 0; i < env.npresets; ++i) {
-		free(env.presets[i].name);
-		if (env.presets[i].type == ENUMERATOR)
-			free(env.presets[i].svalue);
+		free(env.presets[i].full_name);
+		for (j = 0; j < env.presets[i].atom_count; ++j)
+			free(env.presets[i].atoms[j].name);
+		free(env.presets[i].atoms);
+		if (env.presets[i].value.type == ENUMERATOR)
+			free(env.presets[i].value.svalue);
 	}
 	free(env.presets);
 	return -err;
-- 
2.50.0


