Return-Path: <bpf+bounces-50984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D063FA2EED9
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C9F1885320
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05623099F;
	Mon, 10 Feb 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkHzEnub"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E1221DA9
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195509; cv=none; b=Y7xAyKb5xifdNp+uQBbnxgYEx3+PwtHwcPCRyhuWQvcIoG93dSRBeulmFq05ycF3/a3HLY1OZBjB0sSLhFY4x7dKIZ2+TW/OR8UYbFg0u27Puj0/j11XKeVxyamQ1oJFF6CBgazji43GluoYPJ2Iy+KfLkRCCsAZnrgTgFaiTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195509; c=relaxed/simple;
	bh=AgX3h+oN3rNmw43BPwcBG+d3WGcPvc63GupzXv7KCOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNw2LzG1gn2bR04pPU4mZk7M18Dry2EXWk6dh7YG4agCha8Cx6cXzTMEUrIck5ssv4q/z4hmIeqG/ynjJuk2WUXui3HpaAuRZotN6QzX0v3v1u6KEB3Dn9lPHSIWcAVr2lhGwVApq/TGxPvwtjbefY3hb2o9sLWMX25oXsaYoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkHzEnub; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso769667866b.1
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 05:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739195505; x=1739800305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhjUF94I2toFb69ngG7iNXH+Ot85k4MD5Q7sIDwOlT0=;
        b=TkHzEnubUHy0gREh6OhNWeAIFKei/wGRwqHLEOZzNb82Xosyx1NM7Omp/zzcZFi7CF
         Wz34/N22r1ypDQGybagBRYzXmfLuYKaD23pcfc4VXtNLAIZ+M2bsK01kZX2zRVcZJh74
         ceqBm98zG4ZXD5GX/WG3N8THO/dVteeDdzJETfc/nrjEx0I+GwTnzLKJtnZwofemIxDZ
         2MBie6Pxy9T5FMk+dkcbc4bvH/Q7EMn1D88R5rlZdDvkFKV8j6dGLKMZ5TRKLRfP1oQv
         LteXBBQpNyww/bymCiPEB0LIcXmVu3ZQSrqDc1CE4OrDs74A1FiyJyjacA4PUEQwJr3m
         NImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739195505; x=1739800305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhjUF94I2toFb69ngG7iNXH+Ot85k4MD5Q7sIDwOlT0=;
        b=r7TxlkHyZqGhtDrBCacjSMvW08PVZedli1ArNMj19obPTYD/uz1tsKf1UoKpOAdX6K
         JBPBUzMlVDlVscnQiC6j1xqUcO+lOUQhTUBHkWyxsk7a+eHhYG3h0BZL7Nf+9G7DOLN1
         22Z3SXuD7Hf67xkHG7gF6S25gd2e+iYB37s/exZW0suvTOyNCr+3+Kbvh0wWSalWT0e8
         OwUAo1k/I4UMZD/HGGyf0wU1ux7OJ9J3JEVeB+lLkUUQcJKNbf4nh3xg9nF5isWh/dMA
         4O20eaoCKAakfPtwnNYUaGx9cDIbwgjfF2j1ACsGlwugxHad8RMvRW+B3HCNT149xQfX
         noKg==
X-Gm-Message-State: AOJu0YzTxxfvXnwFIhTFVSDoA0cI9Ugij9Xe36Gv2ZY748nmzj7jCHmK
	sw0Xc5bg+LqVolyzioYyEQOjejsETpEDdeNOSQyYZtxysXswGg6TZg7tkg==
X-Gm-Gg: ASbGncsZPWkHHMI4O4xUZD2D00WsC3RaS+p7xNu+seBJrXkbtS06ku3JluOX7uJ8Cs4
	nvPXNafdpuIccJZFGmsSEy1VbG8/PkKwllXU7daq3LgA8N92AD63cfBKW7JJb6NaE6p0xmgAwQn
	xVTJStDCzOQ1svfELxP7Sp/CtcA5uVFOx6/u1x9AgV2mk/WQztjgqVQJjp8xzWNiTADQ0AD19wt
	l0EWAdjDeAFzbuHyBCE7pw//IyGW1RWe8+ktSQ8gnwZu04p/6Edpnudaig4zGk5HtRTzadx/Dfp
	MiS2jBitSWKfkHqNojTeppO/u7gQ
X-Google-Smtp-Source: AGHT+IHp6lJMyTn6bsIK7ewv5ivhIhWakDJT1n4ZY7l3jz98PF0w8RHHWRDtUBDaSpgex+z9ugkadw==
X-Received: by 2002:a17:907:97c3:b0:ab7:84bc:3233 with SMTP id a640c23a62f3a-ab789b21154mr1235552366b.28.1739195504896;
        Mon, 10 Feb 2025 05:51:44 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:400::5:db8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e71f1sm878261566b.92.2025.02.10.05.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:51:44 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: implement setting global variables in veristat
Date: Mon, 10 Feb 2025 13:51:28 +0000
Message-ID: <20250210135129.719119-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/veristat.c | 319 ++++++++++++++++++++++++-
 1 file changed, 307 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 06af5029885b..b4521ebb6e6a 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -154,6 +154,15 @@ struct filter {
 	bool abs;
 };
 
+struct var_preset {
+	char *name;
+	enum { INTEGRAL, NAME } type;
+	union {
+		long long ivalue;
+		char *svalue;
+	};
+};
+
 static struct env {
 	char **filenames;
 	int filename_cnt;
@@ -195,6 +204,8 @@ static struct env {
 	int progs_processed;
 	int progs_skipped;
 	int top_src_lines;
+	struct var_preset *presets;
+	int npresets;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -246,12 +257,16 @@ static const struct argp_option opts[] = {
 	{ "test-reg-invariants", 'r', NULL, 0,
 	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
 	{ "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines" },
+	{ "set-global-vars", 'G', "GLOBALS", 0, "Set global variables provided in the expression, for example \"var1 = 1\"" },
 	{},
 };
 
 static int parse_stats(const char *stats_str, struct stat_specs *specs);
 static int append_filter(struct filter **filters, int *cnt, const char *str);
 static int append_filter_file(const char *path);
+static int parse_var_presets(char *expr, struct var_preset **presets, int *capacity, int *size);
+static int parse_var_presets_from_file(const char *filename, struct var_preset **presets,
+				       int *capacity, int *size);
 
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
@@ -363,6 +378,24 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return -ENOMEM;
 		env.filename_cnt++;
 		break;
+	case 'G': {
+		static int presets_cap;
+		char *expr = strdup(arg);
+
+		if (expr[0] == '@') {
+			if (parse_var_presets_from_file(expr + 1, &env.presets,
+							&presets_cap, &env.npresets)) {
+				fprintf(stderr, "Could not parse global variables preset: %s\n",
+					arg);
+				argp_usage(state);
+			}
+		} else if (parse_var_presets(expr, &env.presets, &presets_cap, &env.npresets)) {
+			fprintf(stderr, "Could not parse global variables preset: %s\n", arg);
+			argp_usage(state);
+		}
+		free(expr);
+		break;
+	}
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -1292,6 +1325,273 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	return 0;
 };
 
+static int parse_var_presets(char *expr, struct var_preset **presets, int *capacity, int *size)
+{
+	char *eq_ptr = strchr(expr, '=');
+	char *name_ptr = expr;
+	char *name_end = eq_ptr - 1;
+	char *val_ptr = eq_ptr + 1;
+	long long value;
+
+	if (!eq_ptr) {
+		fprintf(stderr, "No assignment in expression\n");
+		return -EINVAL;
+	}
+
+	while (isspace(*name_ptr))
+		++name_ptr;
+	while (isspace(*name_end))
+		--name_end;
+	while (isspace(*val_ptr))
+		++val_ptr;
+
+	if (name_ptr > name_end) {
+		fprintf(stderr, "Empty variable name in expression %s\n", expr);
+		return -EINVAL;
+	}
+
+	if (*size >= *capacity) {
+		*capacity = max(*capacity * 2, 1);
+		*presets = realloc(*presets, *capacity * sizeof(**presets));
+	}
+
+	if (isalpha(*val_ptr)) {
+		char *value_end = val_ptr + strlen(val_ptr) - 1;
+
+		while (isspace(*value_end))
+			--value_end;
+		*(value_end + 1) = '\0';
+
+		(*presets)[*size].svalue = strdup(val_ptr);
+		(*presets)[*size].type = NAME;
+	} else if (*val_ptr == '-' || isdigit(*val_ptr)) {
+		errno = 0;
+		value = strtoll(val_ptr, NULL, 0);
+		if (errno == ERANGE) {
+			errno = 0;
+			value = strtoull(val_ptr, NULL, 0);
+		}
+		(*presets)[*size].ivalue = value;
+		(*presets)[*size].type = INTEGRAL;
+		if (errno) {
+			fprintf(stderr, "Could not parse integer value %s\n", val_ptr);
+			return -EINVAL;
+		}
+	} else {
+		fprintf(stderr, "Could not parse value %s\n", val_ptr);
+		return -EINVAL;
+	}
+	*(name_end + 1) = '\0';
+	(*presets)[*size].name = strdup(name_ptr);
+	(*size)++;
+	return 0;
+}
+
+static int parse_var_presets_from_file(const char *filename, struct var_preset **presets,
+				       int *capacity, int *size)
+{
+	FILE *f;
+	char line[256];
+	int err = 0;
+
+	f = fopen(filename, "rt");
+	if (!f) {
+		fprintf(stderr, "Could not open file %s\n", filename);
+		return -EINVAL;
+	}
+
+	while (fgets(line, sizeof(line), f)) {
+		int err = parse_var_presets(line, presets, capacity, size);
+
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
+	if (btf_is_enum(t))
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
+		for (i = 0; i < n; ++i) {
+			const char *cur_name = btf__name_by_offset(btf, e[i].name_off);
+
+			if (strcmp(cur_name, evalue) == 0) {
+				*retval = e[i].val;
+				return 0;
+			}
+		}
+	} else if (btf_is_enum64(t)) {
+		struct btf_enum64 *e = btf_enum64(t);
+		int i, n = btf_vlen(t);
+
+		for (i = 0; i < n; ++i) {
+			struct btf_enum64 *cur = e + i;
+			const char *cur_name = btf__name_by_offset(btf, cur->name_off);
+			__u64 value =  btf_enum64_value(cur);
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
+		/* Convert enum element name into integer */
+		long long ivalue;
+
+		if (enum_value_from_name(btf, base_type, preset->svalue, &ivalue) != 0) {
+			fprintf(stderr, "Could not find integer value for enum element %s\n",
+				preset->svalue);
+			return -EINVAL;
+		}
+		free(preset->svalue);
+		preset->ivalue = ivalue;
+		preset->type = INTEGRAL;
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
+		memcpy(ptr + sinfo->offset, &preset->ivalue, sinfo->size);
+	} else if (__BYTE_ORDER == __BIG_ENDIAN) {
+		__u8 src_offset = sizeof(preset->ivalue) - sinfo->size;
+
+		memcpy(ptr + sinfo->offset, (void *)&preset->ivalue + src_offset, sinfo->size);
+	}
+	return 0;
+}
+
+static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, int npresets)
+{
+	struct btf_var_secinfo *sinfo;
+	const char *sec_name;
+	const struct btf_type *type;
+	struct bpf_map *map;
+	struct btf *btf;
+	bool *set_var;
+	int i, j, k, n, cnt, err = 0;
+
+	if (npresets == 0)
+		return 0;
+
+	btf = bpf_object__btf(obj);
+	if (!btf)
+		return -EINVAL;
+
+	set_var = calloc(npresets, sizeof(bool));
+	for (i = 0; i < npresets; ++i)
+		set_var[i] = false;
+
+	cnt = btf__type_cnt(btf);
+	for (i  = 0; i != cnt; ++i) {
+		type = btf__type_by_id(btf, i);
+
+		if (!btf_is_datasec(type))
+			continue;
+
+		sinfo = btf_var_secinfos(type);
+		sec_name = btf__name_by_offset(btf, type->name_off);
+		map = bpf_object__find_map_by_name(obj, sec_name);
+		if (!map)
+			continue;
+
+		n = btf_vlen(type);
+		for (j = 0; j < n; ++j, ++sinfo) {
+			const struct btf_type *var_type = btf__type_by_id(btf, sinfo->type);
+			const char *var_name = btf__name_by_offset(btf, var_type->name_off);
+
+			if (!btf_is_var(var_type))
+				continue;
+
+			for (k = 0; k < npresets; ++k) {
+				if (strcmp(var_name, presets[k].name) != 0)
+					continue;
+
+				if (set_var[k]) {
+					fprintf(stderr, "Variable %s is set more than once",
+						var_name);
+				}
+
+				err = set_global_var(obj, btf, var_type, map, sinfo, presets + k);
+				if (err)
+					goto out;
+
+				set_var[k] = true;
+				break;
+			}
+		}
+	}
+	for (i = 0; i < npresets; ++i) {
+		if (!set_var[i]) {
+			fprintf(stderr, "Global variable preset %s has not been applied\n",
+				presets[i].name);
+		}
+	}
+out:
+	free(set_var);
+	return err;
+}
+
 static int process_obj(const char *filename)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1299,7 +1599,7 @@ static int process_obj(const char *filename)
 	struct bpf_program *prog, *tprog, *lprog;
 	libbpf_print_fn_t old_libbpf_print_fn;
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
-	int err = 0, prog_cnt = 0;
+	int err = 0;
 
 	if (!should_process_file_prog(base_filename, NULL)) {
 		if (env.verbose)
@@ -1334,17 +1634,6 @@ static int process_obj(const char *filename)
 
 	env.files_processed++;
 
-	bpf_object__for_each_program(prog, obj) {
-		prog_cnt++;
-	}
-
-	if (prog_cnt == 1) {
-		prog = bpf_object__next_program(obj, NULL);
-		bpf_program__set_autoload(prog, true);
-		process_prog(filename, obj, prog);
-		goto cleanup;
-	}
-
 	bpf_object__for_each_program(prog, obj) {
 		const char *prog_name = bpf_program__name(prog);
 
@@ -1355,6 +1644,12 @@ static int process_obj(const char *filename)
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


