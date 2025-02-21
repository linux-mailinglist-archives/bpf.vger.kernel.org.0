Return-Path: <bpf+bounces-52221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E893A402BF
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 23:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D513AB99F
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993E3254AE0;
	Fri, 21 Feb 2025 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjkFrVqJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C501D5166
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177190; cv=none; b=CokhZP7/qvu093fEt/2LGxGWxwYi2lamGbVQDhKXq2DpMOuEe3c8P0w0rLhUAWXWpV+CYRihyZnp0SASDSBkzNFm0i4CXzaqwllgzuZP95kIOUw+FNqUwEtDHi9VSpSqr8We2U3fsFwOfZDC1zZr7ExXbReJav+JZWlmgNYdrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177190; c=relaxed/simple;
	bh=/PxES7+BEp+M+hHHqYaYtdFuTrN0PdgHWaL6/mFUUTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtdYYtEbkur4pD3bd0ga1v/w+omlU0UmIs+nfCgCNmv8xhixBUNVc5ZvESL1zA88g6hFTRMic1oG3sepbSG5n1lU/kkJHqyVKjLHwDa7HJDM7r1NZ5iok5Vs8xP1gt44+lBX7clO+if3aMYgjziGO/Nd2yzQUT7CObxcx5jqQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjkFrVqJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f488f3161so1337801f8f.3
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 14:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740177186; x=1740781986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BymxdMYqwrSOwcEow1U+AyDnWv4+A2Km0uzPBONtq0E=;
        b=gjkFrVqJrx2Zrh0vfh0o4eU83hvl2Ww1KzS4loTWZCFw66P/WkcpHerg0XtKkVmTIh
         lmnw4RwYJlLW8WV6QqTfJV+34UGH/iiosPKBQFsw7naLU4u1x13dNtzDwxriUyJGU+8i
         cIMzJYa20ioEEvMqIzHA1vA+mlvShNtU9yoUGz60PC2ouwvdj/ULilJ0ehojSvtH7lkY
         21BEEIhOaIItWBgu6Gs9zKKMb5+ybt7JIChOlhj4SjKVzxRH8hdsSvD2XcTg9IZOXZdG
         Sw+IdpzxNLiCZEsdufyB93sYHgJ55VJuWGC88SkUDTEUna7KRursmYRiMYdYa4HAsjrR
         xMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177186; x=1740781986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BymxdMYqwrSOwcEow1U+AyDnWv4+A2Km0uzPBONtq0E=;
        b=dWpjI0Pkq+aRHDbAJmB/T5KniKiyfMHf5ePRyH+qthNgKqYUWDaBjJ7aebT0uArnn+
         518vkwEFgMNTLZkx77M+wjHIu0fD5IPQ2kMNwfvReWc+eYiH89a9jFkS4bIHbpFH05uL
         UtByMwQ7QvQ3b+5LzFs+9jyNhH6yqQzq6vvntkLjXVmg0xetpC3pgXceFCjXI5lNfU+y
         FG1PD5xGItVG5OOr74wA6x1xH+Nh7iZPOP2GWpoGsM/7ywSWs5nqmS3drLRZHftiw451
         NgriZUGsbJy07aHi/fBF3sE7pjcvqwkKqSiqr2SeHVDtsp6V9hnOtsp8Ad8ampulr0Li
         9uBQ==
X-Gm-Message-State: AOJu0YyoyMF2ZjOJN+HYg6hWFWhskVe30liYzKVqjjsnrfYsTlNSYyNo
	ZnQp04FSV73Gf9FYpSkr8oGETYTGxgvgnnSppcfwlYKMZh27lpoGxuD7Pw==
X-Gm-Gg: ASbGncuU9y+PVpFVscZvD4ewqHkt3dl1zxFLojjtvGuv/mqPOjVJJPm5zwDDxONwx9F
	uBehWc8bazyrL7SY8sNcHfl6bjky5U6VH9rFlvm76R6p9pZ85KlNmOullqOx8VWlh5uJnStKlv7
	EahHS9AYQv2Tw9YogSKem20acTlM9/OMKTiiCeN7bp8d4ARymTtcy0KhEL87WIu5GT4/t5jGKbe
	l6FUyrggmKDH3QRxM9g+oj2AuW5SUy04qda7b4AKXGDv7l9X1GInKyqs0vCwsFPopev+7rq6I6j
	3IE4w3M25Ga1o+dhq6TJcP8iBt9nqxEsTHdklhYb1jWQQW/OaT3HEv1chcwH3ROs3mY32SshEdb
	/9CX3GZz2rN7/f3xh6+P5k0wiEXFQLR0=
X-Google-Smtp-Source: AGHT+IGEshjZXQXxqKrhqTBx3TLfnNKdfZNnDXgcWPk/ZZuJ6a9kiDrVpHMNdL8DCEvA1D+FqhcncA==
X-Received: by 2002:a05:6000:4014:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-38f70772b46mr3972214f8f.8.1740177186119;
        Fri, 21 Feb 2025 14:33:06 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d9be9sm24880003f8f.79.2025.02.21.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:33:05 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 1/2] selftests/bpf: implement setting global variables in veristat
Date: Fri, 21 Feb 2025 22:32:58 +0000
Message-ID: <20250221223259.677471-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221223259.677471-1-mykyta.yatsenko5@gmail.com>
References: <20250221223259.677471-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/veristat.c | 290 ++++++++++++++++++++++++-
 1 file changed, 289 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 06af5029885b..1e1bc0dfa50a 100644
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
@@ -632,7 +660,7 @@ static int append_filter_file(const char *path)
 	f = fopen(path, "r");
 	if (!f) {
 		err = -errno;
-		fprintf(stderr, "Failed to open filters in '%s': %d\n", path, err);
+		fprintf(stderr, "Failed to open filters in '%s': %s\n", path, strerror(err));
 		return err;
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
@@ -2460,5 +2742,11 @@ int main(int argc, char **argv)
 		free(env.deny_filters[i].prog_glob);
 	}
 	free(env.deny_filters);
+	for (i = 0; i < env.npresets; ++i) {
+		free(env.presets[i].name);
+		if (env.presets[i].type == NAME)
+			free(env.presets[i].svalue);
+	}
+	free(env.presets);
 	return -err;
 }
-- 
2.48.1


