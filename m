Return-Path: <bpf+bounces-59783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5A1ACF752
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24991886DBD
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75C27C84B;
	Thu,  5 Jun 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avIrpeQr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75527B51A
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148612; cv=none; b=Xxtq+a7+IqBvvnk+QEzu+TFMRDfOcTAv+stfLuL036CJmViwchNGuGlb0kLQYQn8wkw/WAsNb6GLCvRi3upQsH3ydtTRumtTF4PEeYE/MBrQpsrFzP7ultnU+EY8de7zIgAhAVtpQjCr+9tGdGPcY+0rfac4fDHUN03b/9qiK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148612; c=relaxed/simple;
	bh=Hf7l0Vul9cPepgVAnPBiyLtwiGwAmSOkwNgr66v1Y98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3tdRhzJBo8pBHzzEmdtZOWYRCNMd9MjqAJ9BdNoeqWGr8fCK9l5evq0XrrDObP44ng62Aq/Jg8+Ojidek/KX6d8/4l/W3Bp4tnuwZqb5N2wBQY4lI7qD9zkQ6NTXh8zJeD9g1xm7Xf0lmIKEqAlROy+YK14Rj6PYzs/a+vPaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avIrpeQr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so2314174a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749148609; x=1749753409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zYuT94wawXhyZhGpeLk4v8VCaUbmKB7A8lni/+dMLc=;
        b=avIrpeQrbq1sTAX6sGsJvvqbnhO7JFAz3VIy2BK0UFlzKgGbwidgKKNvlIJiCvIs4L
         ApQrtnqXp85wL+ig1LmGnfia5sVw9sAtukNfh54jp6GvCl+EN4Nr11b7Oq/G2D9KWxNv
         C8d+NT/9vu6mJ5bj7HEHMJL6ZKW4WgGqkPMgc0TWoO4JH60vuQoL8qIovu6ofWKIiO1X
         XVJ1szSkMsClT3MiBtWEp9TQ8/buWxJw+CvDEbEhDVaaG5IkAbrMZhmV8XsmBjqLYumE
         0DhMnGDu8yhog7rdIdKXWrzU7Skzs/3kwM40JlQOaCLd4bvLBvESmk0VBnOBz7HKeewK
         oXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749148609; x=1749753409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zYuT94wawXhyZhGpeLk4v8VCaUbmKB7A8lni/+dMLc=;
        b=dy68FKuhL709HnjS/LfifjPA0kqQEm5l5onwtUBk2b2meVRUe+uECQRmYP9/ouG7DZ
         zR36h+onw/m30nffqIvnmk+S7YPtyaEieiUTWZyKcEvu2asMSGFkDgfHUz3WBluTVMn+
         eEPpFW4kIkioHwqoLmfMfhseLXwt6EF6jGIM55S7PFQOQ3a1IMUbElE/I8N3V9NvYeV2
         lmmiIdJZ0oTlFeMl3MpGUwJEEgxYOlIAT3ySa7coVuGfGpTZ3E9PS8Et/qscxoEG112C
         EQeE0z6lrYHJHfJy38yGZ1SPG9BgVQ7mKZ5W4leCizaAWK4foHjgoH+j/0VphLwDFscM
         lJVA==
X-Gm-Message-State: AOJu0Yxz4IADkDuEyBlJUrsso2tYqLLLoEivcP95CZgkskeE3P9jmo7p
	ig9AhIWC48ajRXBti3bPLrZLf+Iqxo8VKzPQHz6Ruy06pd+6TysamoiCSpD9jME/KBo=
X-Gm-Gg: ASbGncsPinS33AmHlAkudcKxPhYymROvqKsROmgZ5vWQFCcYbOJ/lk2MxBGtLjrFXYe
	2fgA3w3KDH2t5H7QPJYlZOXTfytOrYdxZgpJVzfpo56/ESewo/XHDtzAtTsJ2f7OM+pcyS8ejoV
	/KvlWuNuvZhm2jPCZE6knWKb/mDuW17C3LTdBFU3ejNc7gRO/lH5hxfF7+PSNNQh7FZzEycsazg
	fsiELRouos3mOt7TpblQklh6g6qEh57JlArBcsGT4FT9iqOQO0kjWCyDTlpeeYpWU+3Nd+wowRb
	NWXKqahaCeTNtLbfw8FAwtQmUnUSQ0Sp+eaVd0JjKCHZo7KnHHlB
X-Google-Smtp-Source: AGHT+IGm6Zw1qMkZMaYI9Ov3OFm37TNzPVEqvUDHoxSfP5h0BtbWq0PvSHxMpeEI4ML3JiYF7jdhiw==
X-Received: by 2002:a17:907:fdc1:b0:ad5:74cd:1824 with SMTP id a640c23a62f3a-ade1ab20872mr22449266b.38.1749148608908;
        Thu, 05 Jun 2025 11:36:48 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:1013])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6abc2sm1298101066b.173.2025.06.05.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:36:48 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: separate var preset parsing in veristat
Date: Thu,  5 Jun 2025 19:36:40 +0100
Message-ID: <20250605183642.1323795-2-mykyta.yatsenko5@gmail.com>
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

Refactor var preset parsing in veristat to simplify implementation.
Prepare parsed variable beforehand so that parsing logic is separated
from functionality of calculating offsets and searching fields.
Introduce variant struct, storing either int or enum (string value),
will be reused in the next patch, extract parsing variant into a
separate function.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 159 ++++++++++++++++---------
 1 file changed, 102 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b2bb20b00952..bd6f907f3868 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -155,13 +155,23 @@ struct filter {
 	bool abs;
 };
 
-struct var_preset {
-	char *name;
-	enum { INTEGRAL, ENUMERATOR } type;
+struct variant {
+	enum { NONE, INTEGRAL, ENUMERATOR } type;
 	union {
 		long long ivalue;
 		char *svalue;
 	};
+};
+
+struct var_preset_atom {
+	char *name;
+};
+
+struct var_preset {
+	struct var_preset_atom *atoms;
+	int atom_count;
+	char *full_name;
+	struct variant value;
 	bool applied;
 };
 
@@ -1278,6 +1288,35 @@ static int max_verifier_log_size(void)
 	return log_size;
 }
 
+static int parse_variant(const char *val, struct variant *variant)
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
+		variant->ivalue = value;
+		variant->type = INTEGRAL;
+	} else {
+		/* if not a number, consider it enum value */
+		variant->svalue = strdup(val);
+		if (!variant->svalue)
+			return -ENOMEM;
+		variant->type = ENUMERATOR;
+	}
+	return 0;
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1363,13 +1402,35 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	return 0;
 };
 
+static int parse_var_atoms(const char *full_var, struct var_preset *preset)
+{
+	char expr[256], *name, *saveptr;
+
+	snprintf(expr, sizeof(expr), "%s", full_var);
+	preset->atom_count = 0;
+	while ((name = strtok_r(preset->atom_count ? NULL : expr, ".", &saveptr))) {
+		int i = preset->atom_count;
+
+		preset->atoms = reallocarray(preset->atoms, i + 1, sizeof(*preset->atoms));
+		if (!preset->atoms) {
+			preset->atom_count = 0;
+			return -ENOMEM;
+		}
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
@@ -1384,32 +1445,18 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
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
+	err = parse_variant(val, &cur->value);
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
 
@@ -1489,7 +1536,7 @@ static bool is_preset_supported(const struct btf_type *t)
 const int btf_find_member(const struct btf *btf,
 			  const struct btf_type *parent_type,
 			  __u32 parent_offset,
-			  const char *member_name,
+			  struct var_preset_atom *var_atom,
 			  int *member_tid,
 			  __u32 *member_offset)
 {
@@ -1512,7 +1559,7 @@ const int btf_find_member(const struct btf *btf,
 		if (member->name_off) {
 			const char *name = btf__name_by_offset(btf, member->name_off);
 
-			if (strcmp(member_name, name) == 0) {
+			if (strcmp(var_atom->name, name) == 0) {
 				if (btf_member_bitfield_size(parent_type, i) != 0) {
 					fprintf(stderr, "Bitfield presets are not supported %s\n",
 						name);
@@ -1526,7 +1573,7 @@ const int btf_find_member(const struct btf *btf,
 			int err;
 
 			err = btf_find_member(btf, member_type, parent_offset + member->offset,
-					      member_name, member_tid, member_offset);
+					      var_atom, member_tid, member_offset);
 			if (!err)
 				return 0;
 		}
@@ -1536,22 +1583,20 @@ const int btf_find_member(const struct btf *btf,
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
+		err = btf_find_member(btf, base_type, 0, &preset->atoms[i],
+				      &member_tid, &member_offset);
 		if (err) {
-			fprintf(stderr, "Could not find member %s for variable %s\n", name, var);
+			fprintf(stderr, "Could not find member %s for variable %s\n",
+				preset->atoms[i].name, preset->atoms[i - 1].name);
 			return err;
 		}
 		member_type = btf__type_by_id(btf, member_tid);
@@ -1569,7 +1614,7 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf,
 {
 	const struct btf_type *base_type;
 	void *ptr;
-	long long value = preset->ivalue;
+	long long value = preset->value.ivalue;
 	size_t size;
 
 	base_type = btf__type_by_id(btf, btf__resolve_type(btf, sinfo->type));
@@ -1583,17 +1628,18 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf,
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
@@ -1660,20 +1706,16 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
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
@@ -1683,7 +1725,7 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 				}
 				tmp_sinfo = *sinfo;
 				err = adjust_var_secinfo(btf, var_type,
-							 &tmp_sinfo, presets[k].name);
+							 &tmp_sinfo, presets + k);
 				if (err)
 					return err;
 
@@ -1698,7 +1740,7 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 	for (i = 0; i < npresets; ++i) {
 		if (!presets[i].applied) {
 			fprintf(stderr, "Global variable preset %s has not been applied\n",
-				presets[i].name);
+				presets[i].full_name);
 		}
 		presets[i].applied = false;
 	}
@@ -2826,7 +2868,7 @@ static int handle_replay_mode(void)
 
 int main(int argc, char **argv)
 {
-	int err = 0, i;
+	int err = 0, i, j;
 
 	if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
 		return 1;
@@ -2885,9 +2927,12 @@ int main(int argc, char **argv)
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
2.49.0


