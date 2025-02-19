Return-Path: <bpf+bounces-52003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC0EA3CDA0
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B31A3B4726
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 23:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C77261366;
	Wed, 19 Feb 2025 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP2GG0Sg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26AD1D79BE
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007867; cv=none; b=FF9Pl/mj7L7KEeYNdQ3znj3AGuScOgLXSUnEYjcIDxyGdbiHYSa1UWR7wZF3CG4aoLdSd1h2cDEgna9e6ceA5C9NrJdAs0ggG5iPcp1e9g9n3PGc6nz2vRvqUh1zKudff4af6zNmOSgLDijDUtGNREMRdy0oVtALKH1IaZzuuvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007867; c=relaxed/simple;
	bh=4ZOyBJIn3TP5lfu46/1v/rlActWY3+22dgp54mLf4b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMXIfez1XWp/XEbM0Bva1jl8WsVwvz7U+MIBOczlGJn2r2D4AmdkoAYTpoE093yx+fl9yjdc0sB2K7kyT8Y0vpvUeez4HFl3WSj9wYi8y96ab4atKuM+jIagxWqtNwHEc4FzQcASndU5euN0QFPEA6FGec+Rpp1UXoOCK/yDyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP2GG0Sg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f31f7732dso226127f8f.1
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 15:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007864; x=1740612664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olk1ID+c/nSeUhKEzW6L9waOKhyuVDLIZnc3+wKeWlo=;
        b=FP2GG0SgNretS4ZhFVGVzGuBlJ8eruP3ZsiI8tTN+dQctYyR2E/g3SQUr39bY79eMD
         skOiWFjWdxNK52oRXsyL1TQxrTcpm963QEXdx5oSFQrfGvSpnijg3DaPrvFue+5Z7u0m
         FY7R1rVVknRAZotjySRWSIJ8y2aIvlTnbUuQ4woX3WCUvbmq3ZoRJkfWp1PPemRUJa5W
         gehLwTSlZwhn3s4Y3gv5PUgC6zTtlXTeiuUFrrOC5jjIT4B5hW2G5cg9zXrPd2fHLFk8
         6s30K1OMyHgsRzBnfPsmx9tQa8flTYSp36K4/OC48lwv1zirz/f3vZ9zj2VlyMtEWqBO
         7UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007864; x=1740612664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olk1ID+c/nSeUhKEzW6L9waOKhyuVDLIZnc3+wKeWlo=;
        b=p3WAGFWVs50sJ7c/9JHH/MIjbazDxZjb1WN+mPxDgMKMPw9gs368fy2akhrAPEBxTW
         cDCWIynSlpKR9u2+wZGUwz1IMkAm53TcypFGEjyfoplVnjVHhS3ma0to6hGfUvO/jqQ9
         ZU6ATbnM7XentacCqR3AxgyN0FrMhY1dfdsjeX9DwSg5NnjOlDSIMFbEnZSRDbFROVE/
         w756xODMZCrbHjkRmmg6ujicHB7z97k2mt323UJT4Jn5O8IjA9rvAaRu7mF9GaleiYhZ
         r1vkwWouGGDerry9zZtZ/Cjiw5FAf2hpdGg4gH4kHiV2W8vtqelqUqpVbrsoqY27Jnij
         MV5Q==
X-Gm-Message-State: AOJu0YzLG8fU0jrzeLN0DN2VjY38g5l3D21WVsIV/Ax2SfSL+JkRlY8J
	6t0gVg4PGS9uKA+Mtei8AnprqZ33p8wH97/x3xIrfqYEurCa3OS2t1tjYw==
X-Gm-Gg: ASbGncsYvkbuay3rOf6Aylq0lmPYi5QWzjBt7owdJw/e0YXaxFBwEs5x/uxD91gi4QI
	/l80+oW/Y5kXROCX/nZRqAMYEh0Vc/jyRiiFrQZXBHP1ErkHBwmFDlrjqGK7XVBhqHjrrPSOudK
	aXRCchlrthy0VjYMgL8o5WBJiHOwfPwYGWkTG2rsNDMgWMzTw3MZZRkvXFK2rU0ob382Daf+uUF
	IKrqx9N7hhjfZeXAQKCerUXfg7KgsoL5sCZhrOVlYlL0kqj5Xb0ex32AdnFZZw24Se1LS+88iG9
	xtJYxkgCfJNakKLZ0iK5My4cV9RmPqODVMkVWK+MzBF4/klL31Ku6ae0VHKdgMtsSaOw3g5s7k0
	PAcZIEmDX8AeGDwen9gzv
X-Google-Smtp-Source: AGHT+IHxicVlGrQSgsm6c8LHmC3h2EpF1Etqq6g0ocCqn4N4d8Z4nMnukY2I2WC8LiJWLxFb2/1quQ==
X-Received: by 2002:a05:6000:1563:b0:38f:4ca6:5fc6 with SMTP id ffacd0b85a97d-38f615bc84bmr924795f8f.14.1740007863849;
        Wed, 19 Feb 2025 15:31:03 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7998sm18779048f8f.82.2025.02.19.15.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:31:02 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 1/2] selftests/bpf: implement setting global variables in veristat
Date: Wed, 19 Feb 2025 23:30:44 +0000
Message-ID: <20250219233045.201595-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219233045.201595-1-mykyta.yatsenko5@gmail.com>
References: <20250219233045.201595-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

To better verify some complex BPF programs we'd like to preset global
variables.
This patch introduces CLI argument `--set-global-vars` or `-G` to
veristat, that allows presetting values to global variables defined
in BPF program. For example:

prog.c:
```
enum Enum { ELEMENT1 = 0, ELEMENT2 = 5 };
const volatile __s64 a = 5;
const volatile __u8 b = 5;
const volatile enum Enum c = ELEMENT2;
const volatile bool d = false;

char arr[4] = {0};

SEC("tp_btf/sched_switch")
int BPF_PROG(...)
{
	bpf_printk("%c\n", arr[a]);
	bpf_printk("%c\n", arr[b]);
	bpf_printk("%c\n", arr[c]);
	bpf_printk("%c\n", arr[d]);
	return 0;
}
```
By default verification of the program fails:
```
./veristat prog.bpf.o
```
By presetting global variables, we can make verification pass:
```
./veristat wq.bpf.o  -G "a = 0" -G "b = 1" -G "c = 2" -G "d = 3"
```

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 282 +++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 06af5029885b..8a540c4b4bba 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -154,6 +154,16 @@ struct filter {
 	bool abs;
 };
 
+struct var_preset {
+	char *name;
+	enum { INTEGRAL, NAME } type;
+	union {
+		long long ivalue;
+		char *svalue;
+	};
+	bool applied;
+};
+
 static struct env {
 	char **filenames;
 	int filename_cnt;
@@ -195,6 +205,8 @@ static struct env {
 	int progs_processed;
 	int progs_skipped;
 	int top_src_lines;
+	struct var_preset *presets;
+	int npresets;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -246,12 +258,15 @@ static const struct argp_option opts[] = {
 	{ "test-reg-invariants", 'r', NULL, 0,
 	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
 	{ "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines" },
+	{ "set-global-vars", 'G', "GLOBALS", 0, "Set global variables provided in the expression, for example \"var1 = 1\"" },
 	{},
 };
 
 static int parse_stats(const char *stats_str, struct stat_specs *specs);
 static int append_filter(struct filter **filters, int *cnt, const char *str);
 static int append_filter_file(const char *path);
+static int append_var_preset(struct var_preset **presets, int *cnt, const char *expr);
+static int append_var_preset_file(const char *filename);
 
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
@@ -363,6 +378,19 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return -ENOMEM;
 		env.filename_cnt++;
 		break;
+	case 'G': {
+		if (arg[0] == '@') {
+			if (append_var_preset_file(arg + 1)) {
+				fprintf(stderr, "Could not parse global variables preset: %s\n",
+					arg);
+				argp_usage(state);
+			}
+		} else if (append_var_preset(&env.presets, &env.npresets, arg)) {
+			fprintf(stderr, "Could not parse global variables preset: %s\n", arg);
+			argp_usage(state);
+		}
+		break;
+	}
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -1292,6 +1320,249 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	return 0;
 };
 
+static int append_var_preset(struct var_preset **presets, int *cnt, const char *expr)
+{
+	void *tmp;
+	struct var_preset *cur;
+	char var[256], val[256];
+
+	tmp = realloc(*presets, (*cnt + 1) * sizeof(**presets));
+	if (!tmp)
+		return -ENOMEM;
+	*presets = tmp;
+	cur = &(*presets)[*cnt];
+	cur->applied = false;
+
+	if (sscanf(expr, "%s = %s\n", var, val) != 2) {
+		fprintf(stderr, "Could not parse expression %s\n", expr);
+		return -EINVAL;
+	}
+
+	if (isalpha(*val)) {
+		cur->svalue = strdup(val);
+		cur->type = NAME;
+	} else if (*val == '-' || isdigit(*val)) {
+		long long value;
+
+		errno = 0;
+		value = strtoll(val, NULL, 0);
+		if (errno == ERANGE) {
+			errno = 0;
+			value = strtoull(val, NULL, 0);
+		}
+		cur->ivalue = value;
+		cur->type = INTEGRAL;
+		if (errno) {
+			fprintf(stderr, "Could not parse integer value %s\n", val);
+			return -EINVAL;
+		}
+	} else {
+		fprintf(stderr, "Could not parse value %s\n", val);
+		return -EINVAL;
+	}
+	cur->name = strdup(var);
+	(*cnt)++;
+	return 0;
+}
+
+static int append_var_preset_file(const char *filename)
+{
+	char buf[1024];
+	FILE *f;
+	int err = 0;
+
+	f = fopen(filename, "rt");
+	if (!f) {
+		err = -errno;
+		fprintf(stderr, "Failed to open presets in '%s': %d\n", filename, err);
+		return -EINVAL;
+	}
+
+	while (fscanf(f, " %1023[^\n]\n", buf) == 1) {
+		if (buf[0] == '\0' || buf[0] == '#')
+			continue;
+
+		err = append_var_preset(&env.presets, &env.npresets, buf);
+		if (err)
+			goto cleanup;
+	}
+
+cleanup:
+	fclose(f);
+	return err;
+}
+
+static bool is_signed_type(const struct btf_type *t)
+{
+	if (btf_is_int(t))
+		return btf_int_encoding(t) & BTF_INT_SIGNED;
+	if (btf_is_any_enum(t))
+		return btf_kflag(t);
+	return true;
+}
+
+static int enum_value_from_name(const struct btf *btf, const struct btf_type *t,
+				const char *evalue, long long *retval)
+{
+	if (btf_is_enum(t)) {
+		struct btf_enum *e = btf_enum(t);
+		int i, n = btf_vlen(t);
+
+		for (i = 0; i < n; ++i, ++e) {
+			const char *cur_name = btf__name_by_offset(btf, e->name_off);
+
+			if (strcmp(cur_name, evalue) == 0) {
+				*retval = e->val;
+				return 0;
+			}
+		}
+	} else if (btf_is_enum64(t)) {
+		struct btf_enum64 *e = btf_enum64(t);
+		int i, n = btf_vlen(t);
+
+		for (i = 0; i < n; ++i, ++e) {
+			const char *cur_name = btf__name_by_offset(btf, e->name_off);
+			__u64 value =  btf_enum64_value(e);
+
+			if (strcmp(cur_name, evalue) == 0) {
+				*retval = value;
+				return 0;
+			}
+		}
+	}
+	return -EINVAL;
+}
+
+static bool is_preset_supported(const struct btf_type *t)
+{
+	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
+}
+
+static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct btf_type *t,
+			  struct bpf_map *map, struct btf_var_secinfo *sinfo,
+			  struct var_preset *preset)
+{
+	const struct btf_type *base_type;
+	void *ptr;
+	long long value = preset->ivalue;
+	size_t size;
+
+	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
+	if (!base_type) {
+		fprintf(stderr, "Could not resolve type %d\n", t->type);
+		return -EINVAL;
+	}
+	if (!is_preset_supported(base_type)) {
+		fprintf(stderr, "Setting global variable for btf kind %d is not supported\n",
+			btf_kind(base_type));
+		return -EINVAL;
+	}
+
+	if (preset->type == NAME && btf_is_any_enum(base_type)) {
+		if (enum_value_from_name(btf, base_type, preset->svalue, &value) != 0) {
+			fprintf(stderr, "Could not find integer value for enum element %s\n",
+				preset->svalue);
+			return -EINVAL;
+		}
+	}
+
+	/* Check if value fits into the target variable size */
+	if  (sinfo->size < sizeof(preset->ivalue)) {
+		bool is_signed = is_signed_type(base_type);
+		__u32 unsigned_bits = sinfo->size * 8 - (is_signed ? 1 : 0);
+		long long max_val = 1ll << unsigned_bits;
+
+		if (preset->ivalue >= max_val || preset->ivalue < -max_val) {
+			fprintf(stderr,
+				"Variable %s value %lld is out of range [%lld; %lld]\n",
+				btf__name_by_offset(btf, t->name_off), preset->ivalue,
+				is_signed ? -max_val : 0, max_val - 1);
+			return -EINVAL;
+		}
+	}
+
+	ptr = (void *)bpf_map__initial_value(map, &size);
+	if (!ptr || (sinfo->offset + sinfo->size > size))
+		return -EINVAL;
+
+	if (__BYTE_ORDER == __LITTLE_ENDIAN) {
+		memcpy(ptr + sinfo->offset, &value, sinfo->size);
+	} else if (__BYTE_ORDER == __BIG_ENDIAN) {
+		__u8 src_offset = sizeof(value) - sinfo->size;
+
+		memcpy(ptr + sinfo->offset, (void *)&value + src_offset, sinfo->size);
+	}
+	return 0;
+}
+
+static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, int npresets)
+{
+	struct btf_var_secinfo *sinfo;
+	const char *sec_name;
+	const struct btf_type *t;
+	struct bpf_map *map;
+	struct btf *btf;
+	int i, j, k, n, cnt, err = 0;
+
+	if (npresets == 0)
+		return 0;
+
+	btf = bpf_object__btf(obj);
+	if (!btf)
+		return -EINVAL;
+
+	cnt = btf__type_cnt(btf);
+	for (i = 1; i != cnt; ++i) {
+		t = btf__type_by_id(btf, i);
+
+		if (!btf_is_datasec(t))
+			continue;
+
+		sinfo = btf_var_secinfos(t);
+		sec_name = btf__name_by_offset(btf, t->name_off);
+		map = bpf_object__find_map_by_name(obj, sec_name);
+		if (!map)
+			continue;
+
+		n = btf_vlen(t);
+		for (j = 0; j < n; ++j, ++sinfo) {
+			const struct btf_type *var_type = btf__type_by_id(btf, sinfo->type);
+			const char *var_name;
+
+			if (!btf_is_var(var_type))
+				continue;
+
+			var_name = btf__name_by_offset(btf, var_type->name_off);
+
+			for (k = 0; k < npresets; ++k) {
+				if (strcmp(var_name, presets[k].name) != 0)
+					continue;
+
+				if (presets[k].applied) {
+					fprintf(stderr, "Variable %s is set more than once",
+						var_name);
+					return -EINVAL;
+				}
+
+				err = set_global_var(obj, btf, var_type, map, sinfo, presets + k);
+				if (err)
+					return err;
+
+				presets[k].applied = true;
+				break;
+			}
+		}
+	}
+	for (i = 0; i < npresets; ++i) {
+		if (!presets[i].applied) {
+			fprintf(stderr, "Global variable preset %s has not been applied\n",
+				presets[i].name);
+		}
+		presets[i].applied = false;
+	}
+	return err;
+}
+
 static int process_obj(const char *filename)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1341,6 +1612,11 @@ static int process_obj(const char *filename)
 	if (prog_cnt == 1) {
 		prog = bpf_object__next_program(obj, NULL);
 		bpf_program__set_autoload(prog, true);
+		err = set_global_vars(obj, env.presets, env.npresets);
+		if (err) {
+			fprintf(stderr, "Failed to set global variables\n");
+			goto cleanup;
+		}
 		process_prog(filename, obj, prog);
 		goto cleanup;
 	}
@@ -1355,6 +1631,12 @@ static int process_obj(const char *filename)
 			goto cleanup;
 		}
 
+		err = set_global_vars(tobj, env.presets, env.npresets);
+		if (err) {
+			fprintf(stderr, "Failed to set global variables\n");
+			goto cleanup;
+		}
+
 		lprog = NULL;
 		bpf_object__for_each_program(tprog, tobj) {
 			const char *tprog_name = bpf_program__name(tprog);
-- 
2.48.1


