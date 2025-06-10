Return-Path: <bpf+bounces-60227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EECAD4286
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 21:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE6D17AC21
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA9125FA03;
	Tue, 10 Jun 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsq4VUha"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C12F85B
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582531; cv=none; b=ACp8N5eexMGU23a5M0qItue8bU3GokiuGmxNKf9WFt9rtCdA83CFDrWvfRkmOG2iQ8IGfQ3R4zVIHu9LSkuDktevZTEsuX34+meUOMzlfuHY6LO18j0TvZ7QlBmV7Y6j3s9Qael9KgeYEjXnEwv2kJC9JmyDE8AYoF1GqW0BGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582531; c=relaxed/simple;
	bh=BlS3KWnOWvWFlWGzGIKlZYYQ56MxR906FKao0xQtBCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg+RujxB7IdNXYDjmCCwhonz/QjTdjJPn7qGoRQAZvSGXh3+kN6iCJLQBIjlSHIhBdJdHu79vN2iwxGqJf8mIkW5S3BaNGbd4SrImwcMPSMIgfsVJ4PHHzWv385rM9AN9BtrMfMX1jZ0eFHOP/GSD4nciLgAcnAL1/daJnotVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wsq4VUha; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-addcea380eeso833173866b.0
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749582528; x=1750187328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr8MLyzmXzA3gwzS1jT54QkKycDkQOEXb7e/ZkEoDdM=;
        b=Wsq4VUhahgPNfOrq4Q03nmn37rCiwOxk0pSK12KHTrwKkBxvr+E9IT8Zqf5nWgwHU/
         DFFp3sB/MuIRZdrcQjGvibDARL880jCg3jh6RjHdBfYdaAVxZzCfkt4y2CgGbBmao0Tt
         7eOn3KlzLrEXfrpAjToHjKi5WTB3r5NI+GN6LT2mlsYJr8uWgfYKY+YijEFk8055bIrA
         UJmSK8NNsGCT0LmCEGusd8av0pE7deZ0P7BlDBpcxzZpnyHLH+yVaQwQ78a7BCetHdW3
         mtfX2e6wMjl9sFem28V6nM1qhKaG3EbDqEj++m0ZA8+NfvqOiBZpruYwL+GTw5Y1KbEN
         w46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749582528; x=1750187328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr8MLyzmXzA3gwzS1jT54QkKycDkQOEXb7e/ZkEoDdM=;
        b=L5dmaWCPfzq2ZAlrYkuKf/8SzdYek0sxtgwO/5EssLT1Vu4FtgP9i+JC+NsXl+cpOb
         mwxDdc7+j2kKj2RoKPF2UQbNIbKGIekci64J7tBdJUPJeR772ygYsekdXoAzOd8mq6Vg
         AI7VzGgv6coAV5r4OsZtliQT2zCqT00yA71KLuGlzYZcr/KWPX4ctk8LReqqMj4Vmetk
         rllIG96rw5HhdYN40X67fKrFoDlGa390zFBP62coofyKU75hYGHXitXOsXkqlq3fsjYM
         c2e+bg5/lexnMBoEAat1s4fOWJGLzbDxYwOYsqbO5W8vHs/DZRJsP1Gg3/Z6jHhiQH/2
         KxRw==
X-Gm-Message-State: AOJu0YzJ6M2Dwilr89lJF+VEBd1eaVnI4x8vZOlG1Uz4IWbj8Gbm+FxR
	vSKl8IJghDA65kO2VK6sLE2y0Gk7GQ38mBE5Ss40wXuUR+CwfbLW+iPy8IZvaWqkY7c=
X-Gm-Gg: ASbGncvo8QZA4so//xS7rkpO1VuxlYEeHK+7sYy2vmHSZUBBh9W4bYOx7vABXurHbsf
	5Qj55Ng4fO5VZcpGk6HNrVfy5/VkOBQZ21FreixmPlJh9UQ7vSf1A5SCe8QN14nje84FkhhciHg
	aD4ZZErW2+qKuO8tbowz1TXl0zpWl/ZpXd1YoHwINr6KzikpS3BHICsIRAasgL32PDzQpw4Dy5o
	wGW39zifUjm9A7t15pJHZODVQ5qu2pJqlVb6k+UTtzXKgqnCf7ZX2LTSTyVuDGI/QZNRnam1EZx
	7EmSM7tTitxzTnOLqq/Lij/jPDvKFUZZI/4VQlEmJQ==
X-Google-Smtp-Source: AGHT+IHEcj7MHowvez522AyjTukC5EOCCt5jndLkqWyhyTCFMJ2BLZ9QBiO0/mK5FXo8XLmTk/ZGlg==
X-Received: by 2002:a17:907:9307:b0:ad5:55db:e40d with SMTP id a640c23a62f3a-ade89782ab4mr46332766b.34.1749582527324;
        Tue, 10 Jun 2025 12:08:47 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:1505])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d755541sm762989366b.24.2025.06.10.12.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:08:46 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 1/3] selftests/bpf: separate var preset parsing in veristat
Date: Tue, 10 Jun 2025 20:08:38 +0100
Message-ID: <20250610190840.1758122-2-mykyta.yatsenko5@gmail.com>
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

Refactor var preset parsing in veristat to simplify implementation.
Prepare parsed variable beforehand so that parsing logic is separated
from functionality of calculating offsets and searching fields.
Introduce variant struct, storing either int or enum (string value),
will be reused in the next patch, extract parsing variant into a
separate function.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 160 ++++++++++++++++---------
 1 file changed, 103 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b2bb20b00952..8291de199aab 100644
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
@@ -1363,13 +1402,36 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	return 0;
 };
 
+static int parse_var_atoms(const char *full_var, struct var_preset *preset)
+{
+	char expr[256], *name, *saveptr;
+
+	snprintf(expr, sizeof(expr), "%s", full_var);
+	preset->atom_count = 0;
+	while ((name = strtok_r(preset->atom_count ? NULL : expr, ".", &saveptr))) {
+		struct var_preset_atom *tmp;
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
@@ -1384,32 +1446,18 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
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
 
@@ -1489,7 +1537,7 @@ static bool is_preset_supported(const struct btf_type *t)
 const int btf_find_member(const struct btf *btf,
 			  const struct btf_type *parent_type,
 			  __u32 parent_offset,
-			  const char *member_name,
+			  struct var_preset_atom *var_atom,
 			  int *member_tid,
 			  __u32 *member_offset)
 {
@@ -1512,7 +1560,7 @@ const int btf_find_member(const struct btf *btf,
 		if (member->name_off) {
 			const char *name = btf__name_by_offset(btf, member->name_off);
 
-			if (strcmp(member_name, name) == 0) {
+			if (strcmp(var_atom->name, name) == 0) {
 				if (btf_member_bitfield_size(parent_type, i) != 0) {
 					fprintf(stderr, "Bitfield presets are not supported %s\n",
 						name);
@@ -1526,7 +1574,7 @@ const int btf_find_member(const struct btf *btf,
 			int err;
 
 			err = btf_find_member(btf, member_type, parent_offset + member->offset,
-					      member_name, member_tid, member_offset);
+					      var_atom, member_tid, member_offset);
 			if (!err)
 				return 0;
 		}
@@ -1536,22 +1584,20 @@ const int btf_find_member(const struct btf *btf,
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
@@ -1569,7 +1615,7 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf,
 {
 	const struct btf_type *base_type;
 	void *ptr;
-	long long value = preset->ivalue;
+	long long value = preset->value.ivalue;
 	size_t size;
 
 	base_type = btf__type_by_id(btf, btf__resolve_type(btf, sinfo->type));
@@ -1583,17 +1629,18 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf,
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
@@ -1660,20 +1707,16 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
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
@@ -1683,7 +1726,7 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 				}
 				tmp_sinfo = *sinfo;
 				err = adjust_var_secinfo(btf, var_type,
-							 &tmp_sinfo, presets[k].name);
+							 &tmp_sinfo, presets + k);
 				if (err)
 					return err;
 
@@ -1698,7 +1741,7 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 	for (i = 0; i < npresets; ++i) {
 		if (!presets[i].applied) {
 			fprintf(stderr, "Global variable preset %s has not been applied\n",
-				presets[i].name);
+				presets[i].full_name);
 		}
 		presets[i].applied = false;
 	}
@@ -2826,7 +2869,7 @@ static int handle_replay_mode(void)
 
 int main(int argc, char **argv)
 {
-	int err = 0, i;
+	int err = 0, i, j;
 
 	if (argp_parse(&argp, argc, argv, 0, NULL, NULL))
 		return 1;
@@ -2885,9 +2928,12 @@ int main(int argc, char **argv)
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


