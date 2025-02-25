Return-Path: <bpf+bounces-52533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C50A44612
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA553189ACF7
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD92195381;
	Tue, 25 Feb 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOxfTgoS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41075194A6B
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501080; cv=none; b=KHrDGPTDyUZdUTfos3jhhoUiQAkFCu5XA4ybBLzfFlNzufqi/1kfLCpYmlpn5VcMWuurPKutAvheW3xh2ZujQjuNNyaOxsNe7TbDzgOh0/THvKQc8b3SBZBluq2Vl60XCfM+pbPSPQO7sphePFO0odT9zQWadqXiYIBvIxoohQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501080; c=relaxed/simple;
	bh=45heZ43Gxyj1mJzdSV29/4vg+iJKfk3pjD67FPp/P9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GICfl7FJXpmoYAmX4qTm0hpzJwueXqwE2Xmdj5Exc6lHHFW5q0wJteftNksar8RXGPlaC0kPefBSMq5VDkVl+aRMjt36YBzTCV2pIaFAcTTMSt0fmGZ4Z+dUUJhJY00gHda3eyVtVeHFnlQ03dnDwIzFWFps83pP4FXhpey6CyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOxfTgoS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e0516e7a77so8956600a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740501076; x=1741105876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCjRWIljGJY3OylRPsOqld9xrmrgeGsv01j80kgwRlU=;
        b=JOxfTgoSGNAquyMS/WpqnuR5/G6Gz88nybcRnCLIiFJ+aGahLE3ggyoF3XCq7q0qEJ
         Zes8vd3IgcfNCXSCdKsTdYVHiJycKJ4ZOGkmlIodXinVlogoacDEhDmziT9w5qb4mMPd
         DORrHt9HEvPauJryxlOMyck2XR6pl3K/mEgG1MirCWmPK6uCjyfQUidTGo/LaIju8W60
         orQQHW3Oh4LdzerEwlW948LGPZsTIl3Pzbn5q4LPTSf4WxJcq8rCDZkwYHdsuo5F8GgB
         L2zuEG+5Me2kvZE9cA2WE5uqokj5O5hD6hHtdUgWQwbVAC7HcBhwvbQMj5uk/5FS4bH1
         poOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501076; x=1741105876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCjRWIljGJY3OylRPsOqld9xrmrgeGsv01j80kgwRlU=;
        b=r8wow5YuwXatrzrXEGivVmxl0HDOSb0zaULTOnBweAJGHIjihQtbgnAUCA96OBZg8u
         JZGdnQ7/dJa2ZexogCkuVM21xDDYCvsGGiJppLR3sjt+wL4HrZA/ew5fSsDnf7RYVsLc
         7ptW9ekO2NE0APYN6qD0ZbI0K1ns5BYKu8m35iOC5DGBDFBVjmrgYf+yTITBjVw6x9E0
         wd+MPKBRhuqMIdhZiEND4d80cjZvgoiHRrRwxGoSsQDgbgl0+jNTtns4iCzcSblJEq0W
         aTgtvqWVFleU8pQ+6zd1Y5Y7lH9+GQfuRLLaIMae2rJS6GvOtQpAmonyYvnoC8lF8azk
         9R+Q==
X-Gm-Message-State: AOJu0Yw5SyeW169XX3+LIzQhwI3ckbDeN8vteatRPw6OhSeHMaHF2jJS
	seUSXddxW50KB1XzsR9jdB2O5Izwfc7cr42j8Hrt910wYqsK+lSUTOlFHw==
X-Gm-Gg: ASbGncvbIDl+CsTV+rlxjhH5yyKKwi6OzLqj6hKV7BMAKQEYO63mqFdRGZG45ZN5C7M
	Rk3LC05HXv1aBNNbEBUT/mv9nMlnfonEKV1aCVYwiw6SBHno8TDrR8x0Ve6o3xVYpKEBEpukYqc
	TdT8/k3awpKfH40USz5DsYNXD0htAE/0FHep4yYxVKAa5PWWSk7yTmDkM8HWM/nOZr2vhUWpk8Z
	rAWf3tcf2INAECudBgnVAgEWKECzjBDBhsT6ZDhpHtfUSxmGbSQYRcrmPk39lU4W/31zbDWoC94
	Sw6I6uTLnJd2GB2+bFPP8RNsRS/o/UdP97q/pbwK
X-Google-Smtp-Source: AGHT+IEb2mmciEVMv28Rt11YC01nK4DzqnNMdPAmbG1et9tgKWlVH+B9jqudRcZzh0IwyaaeyCpFEQ==
X-Received: by 2002:a17:906:c148:b0:ab7:b250:aaa with SMTP id a640c23a62f3a-abc0df5a73cmr1551960866b.54.1740501075982;
        Tue, 25 Feb 2025 08:31:15 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::7:2cec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2013321sm167178166b.96.2025.02.25.08.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:31:15 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 1/2] selftests/bpf: implement setting global variables in veristat
Date: Tue, 25 Feb 2025 16:31:00 +0000
Message-ID: <20250225163101.121043-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
References: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/veristat.c | 309 ++++++++++++++++++++++++-
 1 file changed, 308 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 06af5029885b..43f77f946501 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -154,6 +154,16 @@ struct filter {
 	bool abs;
 };
 
+struct var_preset {
+	char *name;
+	enum { INTEGRAL, ENUMERATOR } type;
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
+	{ "set-global-vars", 'G', "GLOBAL", 0, "Set global variables provided in the expression, for example \"var1 = 1\"" },
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
@@ -632,7 +660,7 @@ static int append_filter_file(const char *path)
 	f = fopen(path, "r");
 	if (!f) {
 		err = -errno;
-		fprintf(stderr, "Failed to open filters in '%s': %d\n", path, err);
+		fprintf(stderr, "Failed to open filters in '%s': %s\n", path, strerror(err));
 		return err;
 	}
 
@@ -1292,6 +1320,268 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	return 0;
 };
 
+static int append_var_preset(struct var_preset **presets, int *cnt, const char *expr)
+{
+	void *tmp;
+	struct var_preset *cur;
+	char var[256], val[256];
+	long long value;
+	int r, n, val_len;
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
+	val_len = strlen(val);
+	errno = 0;
+	r = sscanf(val, "%lli %n", &value, &n);
+	if (r == 1 && n == val_len) {
+		if (errno == ERANGE) {
+			/* Try parsing as unsigned */
+			errno = 0;
+			r = sscanf(val, "%llu %n", &value, &n);
+			/* Try hex if not all chars consumed */
+			if (n != val_len) {
+				errno = 0;
+				r = sscanf(val, "%llx %n", &value, &n);
+			}
+		}
+		if (errno || r != 1 || n != val_len) {
+			fprintf(stderr, "Could not parse value %s\n", val);
+			return -EINVAL;
+		}
+		cur->ivalue = value;
+		cur->type = INTEGRAL;
+	} else {
+		/* If not a number, consider it enum value */
+		cur->svalue = strdup(val);
+		if (!cur->svalue)
+			return -ENOMEM;
+
+		cur->type = ENUMERATOR;
+	}
+
+	cur->name = strdup(var);
+	if (!cur->name)
+		return -ENOMEM;
+
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
+		fprintf(stderr, "Failed to open presets in '%s': %s\n", filename, strerror(err));
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
+		fprintf(stderr, "Setting value for type %s is not supported\n",
+			btf__name_by_offset(btf, base_type->name_off));
+		return -EINVAL;
+	}
+
+	if (preset->type == ENUMERATOR) {
+		if (btf_is_any_enum(base_type)) {
+			if (enum_value_from_name(btf, base_type, preset->svalue, &value) != 0) {
+				fprintf(stderr,
+					"Could not find integer value for enum element %s\n",
+					preset->svalue);
+				return -EINVAL;
+			}
+		} else {
+			fprintf(stderr, "Value %s is not supported for type %s\n",
+				preset->svalue, btf__name_by_offset(btf, base_type->name_off));
+			return -EINVAL;
+		}
+	}
+
+	/* Check if value fits into the target variable size */
+	if  (sinfo->size < sizeof(value)) {
+		bool is_signed = is_signed_type(base_type);
+		__u32 unsigned_bits = sinfo->size * 8 - (is_signed ? 1 : 0);
+		long long max_val = 1ll << unsigned_bits;
+
+		if (value >= max_val || value < -max_val) {
+			fprintf(stderr,
+				"Variable %s value %lld is out of range [%lld; %lld]\n",
+				btf__name_by_offset(btf, t->name_off), value,
+				is_signed ? -max_val : 0, max_val - 1);
+			return -EINVAL;
+		}
+	}
+
+	ptr = bpf_map__initial_value(map, &size);
+	if (!ptr || sinfo->offset + sinfo->size > size)
+		return -EINVAL;
+
+	if (__BYTE_ORDER == __LITTLE_ENDIAN) {
+		memcpy(ptr + sinfo->offset, &value, sinfo->size);
+	} else { /* __BYTE_ORDER == __BIG_ENDIAN */
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
@@ -1341,6 +1631,11 @@ static int process_obj(const char *filename)
 	if (prog_cnt == 1) {
 		prog = bpf_object__next_program(obj, NULL);
 		bpf_program__set_autoload(prog, true);
+		err = set_global_vars(obj, env.presets, env.npresets);
+		if (err) {
+			fprintf(stderr, "Failed to set global variables %d\n", err);
+			goto cleanup;
+		}
 		process_prog(filename, obj, prog);
 		goto cleanup;
 	}
@@ -1355,6 +1650,12 @@ static int process_obj(const char *filename)
 			goto cleanup;
 		}
 
+		err = set_global_vars(tobj, env.presets, env.npresets);
+		if (err) {
+			fprintf(stderr, "Failed to set global variables %d\n", err);
+			goto cleanup;
+		}
+
 		lprog = NULL;
 		bpf_object__for_each_program(tprog, tobj) {
 			const char *tprog_name = bpf_program__name(tprog);
@@ -2460,5 +2761,11 @@ int main(int argc, char **argv)
 		free(env.deny_filters[i].prog_glob);
 	}
 	free(env.deny_filters);
+	for (i = 0; i < env.npresets; ++i) {
+		free(env.presets[i].name);
+		if (env.presets[i].type == ENUMERATOR)
+			free(env.presets[i].svalue);
+	}
+	free(env.presets);
 	return -err;
 }
-- 
2.48.1


