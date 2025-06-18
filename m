Return-Path: <bpf+bounces-60996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE41ADF7DF
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5AB170651
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B117E220F55;
	Wed, 18 Jun 2025 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av9iExJ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F021C9F9
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279155; cv=none; b=NP5nqB7SQw9SS+2mEvGYzFjTn09xuj/flwfQ6Jx/KaIWPgUzIF/OtioKh0KU2/Kn8kduKWR1R7aroRzZm5HA/q3xY6oWar+DgNsIuSOl0DfHjaYltjxqp/1rPZu1yHdHcgdMSlblSkB5u2ZQL5d20NBKb4pSPvwoNS15ctEo904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279155; c=relaxed/simple;
	bh=RfZwp8zfvDa60LVHXBut6Lvkp7b0plnZXOiaISkEcYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Un//LXa62EnB/YbjAM0GBFNIGFpQOGdDkphrwvBGOpzyvX+3u48wJWa13wA09TBjoVkLcvVBSFCHdce4ubBWngQymv5ZsG4WvCcKhye1ZeSCR3UnUgMTCtxrWw4YTkujdASpK8ANCFeCVJBugswLeRhvEmwb18qZhy1gffQLrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=av9iExJ6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a575a988f9so79979f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750279151; x=1750883951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gi/s/eYaNVDSe4+YXxFv9q+zqYmt0tOIcbhuJpTI4A0=;
        b=av9iExJ66WqOQUh61ZxRbV93t0q59UAnKkjJtONPhWFgSdBkEx5leagtTaE5Lffatt
         HF+hscje1aUHiMS3UsFOn64dSO6TTZpHVFBUo8J1w09ZloRctJ5D5oCHFvaRoM43KOZH
         3+JX9cRU9WNKb8oi2OL4y/cbFX8iwQjCMydUTk/OD3bmzUOIKk/dzrr7qLsjrRA33VQN
         mNODUbBIo6XPMGaIgy06miWTIw8zQ/2R2O/IyVz9e1ymYCmrIcocSZH+vkYVAo9T1CKd
         GjVf07ywuFba7G7qREL2pQVWx4oQ2N0rwYnd6PLuTMbS3INH5GTisOXrOmaUwJZeAtG4
         IbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750279151; x=1750883951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi/s/eYaNVDSe4+YXxFv9q+zqYmt0tOIcbhuJpTI4A0=;
        b=ITOEjVUw4rtdJrWaVR29PGwnHivunJg9JlP1Fo6Bp4n2XllFIIDeNDUKRjtio/tmbH
         ahFz6FVP92oqHgqigL3uEMxYrtqELVQNH4ibhUAw4zhzlcAJLUnj3mflyZ7TCKAmSuxU
         9534+4KCFXb0ESLSDmE2ByyNZpkP7WDBdCFZZzJ9fYawxfj2esvA/aRRWqWJ2KpKUifY
         TfSJ1BlfCx8KsPQJJGccvpDMU0BgUfpvcAm7KRYlakX0Hw6QkwxZpIsoS85pMOqh8UPt
         f5FKJa7Hcrw3ffWZr5Hgq8k86BhtZsnlwE0GUyoJX+hhZLfDpyfDA825a2+wtHoh+cOp
         5UAg==
X-Gm-Message-State: AOJu0YwP30oWyXdJT1yWrNIK/IEmGex3MTm0lPb1yP6uXKMbOd5YzMoV
	IkWhQQa0DCYztTa8nPfjzT0V+VtFpz2JzQ6jRcGucuYpvX7i+Brv17fM48t7fg==
X-Gm-Gg: ASbGncs6njGKssGBZDyT3XME/5ovGG3AZWhie/RDKDkSFH1BDT5sKxt2Gnyrha6Ds7l
	GJQIfYOrZmyfZ8R3uBwANYcVP+Sx+Lu+7KVopcVK98+0k9Cl4+1DqP6s6HILML2JaKdsjigkqIk
	XNNqVRsD7ty11dmQLcbt/3UM++88GEl4A7cDapnpACLuItd8CEmTYBTVW2P3FV5a+PW+iIOhMsC
	BAiysWYzrXQu7L7oQXZ9hMdyrq/vXDSH8mJSf3wHDqaXSw9Lz7UBtqo0gP4ZSPn9HcGwYXQ3e/5
	qZOztpLbMvv15cphyL7Z4akMJuV2eN23+OP47bqtSTfZoJ9E6Ny6TGNLaG+n
X-Google-Smtp-Source: AGHT+IG4f+b6fXZKOIFRBwoh5K/nefBgxFcqSDYpBD8S4Bw22VM1TnG9LVvP/D9JdBXfGwTGfAFwtA==
X-Received: by 2002:a05:6000:2c0f:b0:3a5:1c71:432a with SMTP id ffacd0b85a97d-3a5723a1889mr17075209f8f.14.1750279151184;
        Wed, 18 Jun 2025 13:39:11 -0700 (PDT)
Received: from localhost ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97abdfsm7549335e9.4.2025.06.18.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:39:10 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: support array presets in veristat
Date: Wed, 18 Jun 2025 21:39:02 +0100
Message-ID: <20250618203903.539270-3-mykyta.yatsenko5@gmail.com>
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

Implement support for presetting values for array elements in veristat.
For example:
```
sudo ./veristat set_global_vars.bpf.o -G "arr[3] = 1"
```
Arrays of structures and structure of arrays work, but each individual
scalar value has to be set separately: `foo[1].bar[2] = value`.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 226 ++++++++++++++++++++-----
 1 file changed, 180 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 483442c08ecf..9942adbda411 100644
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
+			if (sscanf(name + off, "[%[a-zA-Z0-9_]] %n", var, &n) != 1) {
+				fprintf(stderr, "Can't parse %s as index\n", name + off);
+				return -EINVAL;
+			}
+			append_preset_atom(preset, var, true);
+			off += n;
+		}
 	}
 	return 0;
 }
@@ -1670,7 +1706,7 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
 	memset(cur, 0, sizeof(*cur));
 	(*cnt)++;
 
-	if (sscanf(expr, "%s = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
+	if (sscanf(expr, "%[][a-zA-Z0-9_.] = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
 		fprintf(stderr, "Failed to parse expression '%s'\n", expr);
 		return -EINVAL;
 	}
@@ -1763,17 +1799,103 @@ static bool is_preset_supported(const struct btf_type *t)
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
+static int resolve_rvalue(struct btf *btf, const struct rvalue *rvalue, long long *result)
+{
+	int err = 0;
+
+	switch (rvalue->type) {
+	case INTEGRAL:
+		*result = rvalue->ivalue;
+		break;
+	case ENUMERATOR:
+		err = find_enum_value(btf, rvalue->svalue, result);
+		if (err)
+			fprintf(stderr, "Can't resolve enum value %s\n", rvalue->svalue);
+		break;
+	}
+	return err;
+}
+
+/* Returns number of consumed atoms from preset, negative error if failed */
+static int adjust_var_secinfo_array(struct btf *btf, int tid, struct var_preset *preset,
+				    int atom_idx, struct btf_var_secinfo *sinfo)
+{
+	struct btf_array *barr;
+	int i = atom_idx, err;
+	const struct btf_type *t;
+	long long off = 0, idx;
+
+	if (atom_idx < 1) /* Array index can't be the first atom */
+		return -EINVAL;
+
+	tid = btf__resolve_type(btf, tid);
+	t = btf__type_by_id(btf, tid);
+	if (!btf_is_array(t)) {
+		fprintf(stderr, "Array index is not expected for %s\n",
+			preset->atoms[atom_idx - 1].name);
+		return -EINVAL;
+	}
+	do {
+		if (preset->atoms[i].type != ARRAY_INDEX) {
+			fprintf(stderr, "Array index is missing for %s\n",
+				preset->atoms[atom_idx - 1].name);
+			return -EINVAL;
+		}
+		err = resolve_rvalue(btf, &preset->atoms[i].index, &idx);
+		if (err)
+			return err;
+		barr = btf_array(t);
+		if (idx < 0 || idx >= barr->nelems) {
+			fprintf(stderr, "Array index %lld is out of bounds [0, %u]: %s\n",
+				idx, barr->nelems, preset->full_name);
+			return -EINVAL;
+		}
+		off *= barr->nelems;
+		off += idx;
+		tid = btf__resolve_type(btf, barr->type);
+		t = btf__type_by_id(btf, tid);
+		i++;
+	} while (btf_is_array(t));
+
+	sinfo->size = t->size;
+	sinfo->type = tid;
+	sinfo->offset += off * t->size;
+	return i - atom_idx;
+}
+
 const int btf_find_member(const struct btf *btf,
 			  const struct btf_type *parent_type,
 			  __u32 parent_offset,
 			  const char *member_name,
-			  int *member_tid,
-			  __u32 *member_offset)
+			  struct btf_var_secinfo *sinfo)
 {
 	int i;
 
-	if (!btf_is_composite(parent_type))
+	if (!btf_is_composite(parent_type)) {
+		fprintf(stderr, "Can't resolve field %s for non-composite type\n", member_name);
 		return -EINVAL;
+	}
 
 	for (i = 0; i < btf_vlen(parent_type); ++i) {
 		const struct btf_member *member;
@@ -1795,15 +1917,16 @@ const int btf_find_member(const struct btf *btf,
 						name);
 					return -EINVAL;
 				}
-				*member_offset = parent_offset + member->offset;
-				*member_tid = tid;
+				sinfo->offset += (parent_offset + member->offset) / 8;
+				sinfo->type = tid;
+				sinfo->size = member_type->size;
 				return 0;
 			}
 		} else if (btf_is_composite(member_type)) {
 			int err;
 
 			err = btf_find_member(btf, member_type, parent_offset + member->offset,
-					      member_name, member_tid, member_offset);
+					      member_name, sinfo);
 			if (!err)
 				return 0;
 		}
@@ -1815,26 +1938,29 @@ const int btf_find_member(const struct btf *btf,
 static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
 			      struct btf_var_secinfo *sinfo, struct var_preset *preset)
 {
-	const struct btf_type *base_type, *member_type;
-	int err, member_tid, i;
-	__u32 member_offset = 0;
-
-	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
-
-	for (i = 1; i < preset->atom_count; ++i) {
-		err = btf_find_member(btf, base_type, 0, preset->atoms[i].name,
-				      &member_tid, &member_offset);
-		if (err) {
-			fprintf(stderr, "Could not find member %s for variable %s\n",
-				preset->atoms[i].name, preset->atoms[i - 1].name);
-			return err;
+	const struct btf_type *base_type;
+	int err, i = 1, n;
+	int tid;
+
+	tid = btf__resolve_type(btf, t->type);
+	base_type = btf__type_by_id(btf, tid);
+
+	while (i < preset->atom_count) {
+		if (preset->atoms[i].type == ARRAY_INDEX) {
+			n = adjust_var_secinfo_array(btf, tid, preset, i, sinfo);
+			if (n < 0)
+				return n;
+			i += n;
+		} else {
+			err = btf_find_member(btf, base_type, 0, preset->atoms[i].name, sinfo);
+			if (err)
+				return err;
+			i++;
 		}
-		member_type = btf__type_by_id(btf, member_tid);
-		sinfo->offset += member_offset / 8;
-		sinfo->size = member_type->size;
-		sinfo->type = member_tid;
-		base_type = member_type;
+		base_type = btf__type_by_id(btf, sinfo->type);
+		tid = sinfo->type;
 	}
+
 	return 0;
 }
 
@@ -1853,8 +1979,8 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf,
 		return -EINVAL;
 	}
 	if (!is_preset_supported(base_type)) {
-		fprintf(stderr, "Setting value for type %s is not supported\n",
-			btf__name_by_offset(btf, base_type->name_off));
+		fprintf(stderr, "Can't set %s. Only ints and enums are supported\n",
+			preset->full_name);
 		return -EINVAL;
 	}
 
@@ -1971,6 +2097,7 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 		if (!presets[i].applied) {
 			fprintf(stderr, "Global variable preset %s has not been applied\n",
 				presets[i].full_name);
+			err = -EINVAL;
 		}
 		presets[i].applied = false;
 	}
@@ -3164,11 +3291,18 @@ int main(int argc, char **argv)
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
2.49.0


