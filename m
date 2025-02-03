Return-Path: <bpf+bounces-50320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FB5A26066
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 17:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F905166199
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2420B205;
	Mon,  3 Feb 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9A1VaK8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532D20B202
	for <bpf@vger.kernel.org>; Mon,  3 Feb 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600869; cv=none; b=IO6j+XnxKBN8OtfGgCw8vvyD2fw/P/89TxMFbZRYvMvHz7cP/0UFfyCAHIGZmPTcwD+ZKD8JG1d+458j/yWAG2iO7RSHz01/XXHpFuhN8OJWKOGOuNZyHpWyx/X46DIBF9d3qnxjbrj6aeJQJ+82OYHu9N5pY/GdQJTyWmPkqmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600869; c=relaxed/simple;
	bh=XtDCPw1ytFODeqPeR4EEYP9eJaQAFgYIXlvCcdv5LDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frbHtIyRodwfdrD5mXSciUawIzwM1KqPQZ+xoYAIXG3WU2/X/esaKA8AqH8fFL12gZl52vcTqEvwECJwyF0FO0dImDdE9y8LZJJggKp1V1KzMcpbq2b+9LOqT/lId5LzKTkABumksD31UENSF95ieI3T0KOKRu3+zNIhhjoSy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9A1VaK8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso7558164a12.0
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2025 08:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738600864; x=1739205664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nT8j5nK13OkjQ9ZQ1rZ+zgvvoN+ItL52RU4wTVXYxAY=;
        b=A9A1VaK8EQ4P5M2a2M4WnkCO9cw9NrXtybvORS8npiQHY7pk1tAXqHMhaSGYf5qQXH
         tL2vhpC1tCPvjDuxdxnjhRuNOWBP2SGXfqB13YU5vBO5G/UZjV6s0iox9eWkimonU5AC
         galpD65CyB7IXZYh4m5G6xXymAtEtjgJWze6erjYSKL2N0UWb1tAa5YN4ipzN+m1T5wj
         Ze+PDTgVbIyk8w+pUnZ6KckdkOdBoIFBXCwnb+gtze8lfkvbs0TcVQdJr1aJ1s5GzQtN
         RsvFkkXP+hPjV/a9xxs8LA2m6QXBbugbT4HWY8BBQWISxRiBF+KVxW0FUAfYNaXsbKLk
         Dptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738600864; x=1739205664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT8j5nK13OkjQ9ZQ1rZ+zgvvoN+ItL52RU4wTVXYxAY=;
        b=DKtM+SChp72srfT1g2mlz5/KIpxb/96B+DHs82rneIKFHezh9JG+LC7oaFaGx8lZXA
         uqVC6/ebFLvNXmNdTBiGiMq4I3Hne+VyC4TNfahNyVI8Jy1eu5ePXTuuwhzEISpYcEwO
         vYGzvQxtyV9gvqpILYEB74m41XWYHG7qr/G8NOIPlq7+J8/DqwO7rGqcT1h4Qz6dCbAN
         yO8pHjLAbhNwrE2el341IjopkuixkTwu+XqYjj4I03/6QuFyeGUjCyq7XB5RIWupQQQ5
         JWrcVlyG/u2M91xS2u6UfItCEGf8FHlIu1hfu2cPLM8mEUm6oP/eAT8oHYOEi5B/y5EL
         a3CQ==
X-Gm-Message-State: AOJu0Yy2D8wPnH2ReE4NsMxdRDzESisLkoSyvAcsnt8IJgaR7mpz3+9x
	yQ91CmoL1HurNVF/aIyoFjBxbToPgCHclp48DMkbrVZefzTeW4T9VLioCw==
X-Gm-Gg: ASbGnctg7SW5i5QqFZpw70sL7LMVxvWk6qDgKFEi/v/ej+Ro9WQj5RqAjvcuMODMJAV
	Tg4J8MD8x5KE0hCoa4h+TrMAp5ex3CPqt5tR009GwDIzjcVr+HJtXZd3WLYFH2vCUWpmHC5sMOA
	1rzLXSlB1d3ObAUDUdTt7kKvze/p1C/hSAp/HpqoZjzSAurgEx2eClXMUFjWDzXEHLRmy5U5dro
	p2IpPde2W20+5eqJqZaQD31nVggbjYfkpGYECePHeUR8wNLjNYg2WNgRLeOFRgjprYl+OIZmtdI
	z6PyX3813jwiF48HJw3S48l3W9K7kA==
X-Google-Smtp-Source: AGHT+IHCDuGOD//wuKFZDvU8KE847JlCWzN8e2esrj69ILJluEDdpT3kcNly4kGmkPyt8aqCcWqOyg==
X-Received: by 2002:a05:6402:2388:b0:5dc:7464:2239 with SMTP id 4fb4d7f45d1cf-5dc74642547mr16185516a12.7.1738600863976;
        Mon, 03 Feb 2025 08:41:03 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::7:d6e6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724c93cesm8005595a12.75.2025.02.03.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:41:03 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: implement setting global variables in veristat
Date: Mon,  3 Feb 2025 16:40:02 +0000
Message-ID: <20250203164002.128321-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
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
This patch introduces CLI argument `--set-global-vars` to veristat, that
allows presetting values to global variables defined in BPF program. For
example:

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
./veristat wq.bpf.o  --set-global-vars "a = 0; b = 1; c = 2; d = 3;"
```

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 189 +++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 06af5029885b..65bb8a773d23 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -154,6 +154,11 @@ struct filter {
 	bool abs;
 };
 
+struct var_preset {
+	char *name;
+	long long value;
+};
+
 static struct env {
 	char **filenames;
 	int filename_cnt;
@@ -195,6 +200,8 @@ static struct env {
 	int progs_processed;
 	int progs_skipped;
 	int top_src_lines;
+	struct var_preset *presets;
+	int npresets;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -246,12 +253,14 @@ static const struct argp_option opts[] = {
 	{ "test-reg-invariants", 'r', NULL, 0,
 	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
 	{ "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines" },
+	{ "set-global-vars", 'g', "GLOBALS", 0, "Set global variables provided in the expression, for example \"var1 = 1; var2 = 2\"" },
 	{},
 };
 
 static int parse_stats(const char *stats_str, struct stat_specs *specs);
 static int append_filter(struct filter **filters, int *cnt, const char *str);
 static int append_filter_file(const char *path);
+static int parse_var_presets(char *expr, struct var_preset *presets, int capacity, int *size);
 
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
@@ -363,6 +372,17 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return -ENOMEM;
 		env.filename_cnt++;
 		break;
+	case 'g': {
+		char *expr = strdup(arg);
+
+		env.presets = calloc(64, sizeof(*env.presets));
+		if (parse_var_presets(expr, env.presets, 64, &env.npresets)) {
+			fprintf(stderr, "Could not parse global variables preset: %s\n", arg);
+			argp_usage(state);
+		}
+		free(expr);
+		break;
+	}
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -1292,6 +1312,169 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	return 0;
 };
 
+static int parse_var_presets(char *expr, struct var_preset *presets, int capacity, int *size)
+{
+	char *state;
+	char *next;
+	int i = 0;
+
+	while ((next = strtok_r(i ? NULL : expr, ";", &state))) {
+		char *eq_ptr = strchr(next, '=');
+		char *name_ptr = next;
+		char *name_end = eq_ptr - 1;
+		char *val_ptr = eq_ptr + 1;
+
+		if (!eq_ptr)
+			continue;
+
+		if (i >= capacity) {
+			fprintf(stderr, "Too many global variable presets\n");
+			return -EINVAL;
+		}
+		while (isspace(*name_ptr))
+			++name_ptr;
+		while (isspace(*name_end))
+			--name_end;
+
+		*(name_end + 1) = '\0';
+		presets[i].name = strdup(name_ptr);
+		errno = 0;
+		presets[i].value = strtoll(val_ptr, NULL, 10);
+		if (errno == ERANGE) {
+			errno = 0;
+			presets[i].value = strtoull(val_ptr, NULL, 10);
+		}
+		if (errno) {
+			fprintf(stderr, "Could not parse integer value %s\n", val_ptr);
+			return -EINVAL;
+		}
+		++i;
+	}
+	*size = i;
+	return 0;
+}
+
+static bool is_signed_type(const struct btf_type *type)
+{
+	if (btf_is_int(type))
+		return btf_int_encoding(type) & BTF_INT_SIGNED;
+	return true;
+}
+
+static const struct btf_type *var_base_type(const struct btf *btf, const struct btf_type *type)
+{
+	switch (btf_kind(type)) {
+	case BTF_KIND_VAR:
+	case BTF_KIND_TYPE_TAG:
+	case BTF_KIND_CONST:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_DECL_TAG:
+		return var_base_type(btf, btf__type_by_id(btf, type->type));
+	}
+	return type;
+}
+
+static bool is_preset_supported(const struct btf_type *t)
+{
+	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
+}
+
+static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct btf_type *t,
+			  struct bpf_map *map, struct btf_var_secinfo *sinfo, long long new_val)
+{
+	const struct btf_type *base_type;
+	void *ptr;
+	size_t size;
+
+	base_type = var_base_type(btf, t);
+	if (!is_preset_supported(base_type)) {
+		fprintf(stderr, "Setting global variable for btf kind %d is not supported\n",
+			btf_kind(base_type));
+		return -EINVAL;
+	}
+
+	/* Check if value fits into the target variable size */
+	if  (sinfo->size < sizeof(new_val)) {
+		bool is_signed = is_signed_type(base_type);
+		__u32 unsigned_bits = sinfo->size * 8 - (is_signed ? 1 : 0);
+		long long max_val = 1ll << unsigned_bits;
+
+		if (new_val >= max_val || new_val < -max_val) {
+			fprintf(stderr,
+				"Variable %s value %lld is out of range [%lld; %lld]\n",
+				btf__name_by_offset(btf, t->name_off), new_val,
+				is_signed ? -max_val : 0, max_val - 1);
+			return -EINVAL;
+		}
+	}
+
+	ptr = (void *)bpf_map__initial_value(map, &size);
+	if (!ptr || (sinfo->offset + sinfo->size > size))
+		return -EINVAL;
+
+	memcpy(ptr + sinfo->offset, &new_val, sinfo->size);
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
+	int i, j, k, n, cnt, err, preset_cnt = 0;
+
+	if (npresets == 0)
+		return 0;
+
+	btf = bpf_object__btf(obj);
+	if (!btf)
+		return -EINVAL;
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
+				err = set_global_var(obj, btf, var_type, map, sinfo,
+						     presets[k].value);
+				if (err)
+					return err;
+
+				preset_cnt++;
+				break;
+			}
+		}
+	}
+	if (preset_cnt != npresets)
+		fprintf(stderr, "Some global variable presets have not been applied\n");
+
+	return 0;
+}
+
 static int process_obj(const char *filename)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1338,6 +1521,12 @@ static int process_obj(const char *filename)
 		prog_cnt++;
 	}
 
+	err = set_global_vars(obj, env.presets, env.npresets);
+	if (err) {
+		fprintf(stderr, "Failed to set global variables\n");
+		goto cleanup;
+	}
+
 	if (prog_cnt == 1) {
 		prog = bpf_object__next_program(obj, NULL);
 		bpf_program__set_autoload(prog, true);
-- 
2.48.1


