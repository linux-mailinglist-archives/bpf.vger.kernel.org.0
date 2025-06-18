Return-Path: <bpf+bounces-60995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7905FADF7E1
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0181BC32BA
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C2C2206BC;
	Wed, 18 Jun 2025 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUw9iWYw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D46220686
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279153; cv=none; b=EX3Ay92pcNu7LWfSKPNx2uuvP0yYB7/YoSDY4BX1z4uIMf9ZxncJK38LjpryeltYToJ+CHl7DEGFxDCpKdUxF7hneSs9RmlhmA9G7hZBAQCLyM6nzP/HmC/BsqmNweBVtTdjn1W7ka2mxQZRfJN5k+4vOj63J0qyRPkmM62HTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279153; c=relaxed/simple;
	bh=FBHVpKLJ0z34qIVrH8RfQzTv2FHImgmFhdW2U3koPCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLhMVSjcPIZq0bYXyBAYR6azHJbp2b85XPl0uIf3VsoseLJNW19+/iBj4ssi2O1OZIZiOlrDOlrlyBm5y3hvY37HAiSBY9q8RLzOZfr0sPGfW2OTLJAsTKYHZIPJo/mevH1nJOlVYC37evJktrMcd+pwHUESbmzPIOD1t38jbRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUw9iWYw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a53359dea5so85720f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750279150; x=1750883950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYBLNefZNoKUX7/UZPyPxa+NtyxY70MyvDcrpP+fp9U=;
        b=PUw9iWYwjZgFKooBfhT9d//VSpF870GmOjaMmrnqO65T06/Zt3WyjsD3JQVaOdf0Km
         +telHsW8sDG8XSTZhmq4CHVuuwqCoxkf6Tn6IWaf+fJK2RPjZOBVIfHBQT75sTIISs5Y
         dC593oz9MxLo2Z9qQiBw/itES4TKYs51U7sxGLeuz4jGXpNz8k2+PHSPS8ie0KqiV2wj
         J60Ri8ILuNicywYMZSrJBsH6o8CVaiC4oUX09H3JS6c2yhjE7CqZgmV1qb6x0ZbiXhb7
         7uZiDIRJJGcsg3l6s94Pk0rzbhoSRxq7hi/kW8gE7AOdGGeAxivjImmA4gabhJ72uOmO
         5vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750279150; x=1750883950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYBLNefZNoKUX7/UZPyPxa+NtyxY70MyvDcrpP+fp9U=;
        b=ak4BHHB//Gt3erjcmbsbKgCIT8/0oi8SqikSyOpTXi6uOMhSmgFP2ApIUlCnA1xlsA
         7ODmLwfgms7HIwskfzO9BeLuC0rEHQCc/qCtbGadV5tgmUIhL8w2gq5PKSI586UMCOuD
         lfo1JlrX+H1K5FfFlt2bX4GBgjT8t6H9fjSb3pDFlZkhqwGr5HyqkGaDvUUTPGrO11oU
         03OMTt4nUnGuyaLymhwJa3d1BR3rit73St8IcRdUssUI3DZQ+Qz0EdEajUF/0SaB3b+S
         6sURMqBtmmrcHYyWjzTS4VeQ6V0PNzQ48tc+PY+c2vJtg11DifY8/FDZc6d4jB6gOAPx
         AWvw==
X-Gm-Message-State: AOJu0YzCvdOxi/G1995DC/jq02SUTouWPepKhsJwUjyCOOoM1ZeH3oGy
	sQSb1hRH7cN/XHQrGecCJpIhkGJryvIym4undzXaY7g3y5lwbBoFyi0Mmf8iog==
X-Gm-Gg: ASbGncvmJQTayJcrZHpMVf30TOx5CQ68wcEeC2bcGkV1qeRYRRoojI0UqrA7h5jrFTV
	O+0JrfHgLPR/nY+w/Le6DgcTkXRWPZ9CKoZgVpB3HEuToYnFDKze8FkchnmEUNrLO0mGEWUQv5H
	OW+NisMCvMYaQWJ7qhASySAA5PsZ2mtrEJw6Bl616FM306bd1mMkV+Ge9UifulPCTS1oYZLgTqD
	+EWWwB7PTooZAahMiiB0VQoVzOqFFuHWmwzyN67Kh0p9Nh55Mp0EB3h6PFLOKfGM6E60I5s1lPo
	+b9ALBHLSmA9s+0w4TFEanX0KMWt1j/JAGZLwDbkHLgda44YL4VcpDgUN8BL
X-Google-Smtp-Source: AGHT+IEkMM33L2Klzoq7Tcv5xks5t/nQlwExQzwbhMeiQ7wmLjTYGzoWl8pbzB1k3XhS83rYX2O1sQ==
X-Received: by 2002:a5d:5f4f:0:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3a5723715e5mr14716825f8f.13.1750279149474;
        Wed, 18 Jun 2025 13:39:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a53f79sm17578018f8f.4.2025.06.18.13.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:39:08 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 1/3] selftests/bpf: separate var preset parsing in veristat
Date: Wed, 18 Jun 2025 21:39:01 +0100
Message-ID: <20250618203903.539270-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
References: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
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
2.49.0


