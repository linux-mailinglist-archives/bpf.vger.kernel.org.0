Return-Path: <bpf+bounces-31923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1249052CA
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 14:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E3A1C20DD6
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE3B172BDC;
	Wed, 12 Jun 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ0nYaWB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B417082A;
	Wed, 12 Jun 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196196; cv=none; b=Aw+Q01yiQHIVJxs6BaWCe+n+SIJqvMMfUqtPR/TQ6MdWwmVIuyTG7TptTlvKQY7HmmWKBuSUOXo9esAWkrOVdBJWn1XHW+jNHwIFfgwJuDupxUdi3+RI+wFitci7u1vJrkvHphz59jSNvVwr99rX1zcRN9lp4cMHPsz/lrwD17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196196; c=relaxed/simple;
	bh=R6d2Wsj4QxH0RDApbKmwweFfHUlf/fdhBjmP+MaQRG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kq0F0zHDgB5L387qb9f8iw78TblwS4gIAvNng3xjlPgoi6/H7xjbpLnAzldcN295scwsrRkiSb0nDsJx/rWhItWIBjsC5CH58z9JNInJwOehh37VNBomINg56fsvubS5H7nsrIKh77BoQXy683CdcfjcjnofQqvf7BYYwGqshUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ0nYaWB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f8395a530dso7738705ad.0;
        Wed, 12 Jun 2024 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718196194; x=1718800994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9SNFY3n97DVU3ATjWx5G0DI5PrBypnYbaH0Od/W/SAg=;
        b=DJ0nYaWBYG5Q1xZ6fFcMngBngYdRfxu+Hp06VHe08M5n4n8I8EDQDbHvLUHF80SiTc
         FowSVOM7CRqIUwwN3FdifA+ADmjwb72p9RVZJ2BBnC0SpyX0kNgANuRL2zDhGTdWQh81
         ZgakBt/b6zuD+8m1Q8u4NWtL4dRnbyBScmkAKyRkzowwC9VmhCJS4zRCtxEH5ebH/cvp
         UO+KRgRKUfPJ7lV9krXJwRUTV4p/I/QMLwvlotQNQuwVcoYOpVe9h6V8Q7DYwIv4QoCQ
         srOtZBzlvOFOFTsWPnASly4Cgz6NzfPbCpCe7n3/jd+9EbqfysCComAxvUYXzzZl6Mng
         zTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196194; x=1718800994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SNFY3n97DVU3ATjWx5G0DI5PrBypnYbaH0Od/W/SAg=;
        b=Li2Ua3dGumF+OqGZUpUEFbgycSjtv+TIDICw4SoSJ3lrWp9o7+uKnBjyRuXrhXrEnk
         qfB0Zoo0THXxHlOsB2H1mAKYTUpRV2eCEjkXS8/+zLdqYTpRtd4c3S7OcEqUs/9n4Rv0
         BrR/21SFsCchVaOt9xKyMLkXf/GOAEVpFg+2CATiPLRe1zDmF1leWXnTXd9mhNGUuBZ9
         jV9AJkaToXmTO6DI9TkjHFPD2W68A59P6Jl8Xv++gcmFK/51PtsZhq+0ObzPmwPP4LKF
         nhhft2dxjoCWM3TxfQa2z3EYfg6vrHll+LgXJysm3TSKvge2ptE7hK0Aj1J+LG9wNgIx
         0aVA==
X-Forwarded-Encrypted: i=1; AJvYcCXveuSShtJBwtnOumRQpwmklNwQzxmyoE+vzkLHJqHIz8TNeN/d2MiIxNo29rewnO2iqE2TUtoVxcQtijTCxXg5cTnXvka2+dnHN9StUIvdwddNZKYYEAL+WzbfjQ8/Z3R6aecCAbqUX0QC50oNcQSlqzmbOut0xpewP4ZWX6IgPhQe1trRjzs/PjiACjtG3DdrfbGnKFQFZZ5mSTqZMPm3mRnUeHLg8GWfMA==
X-Gm-Message-State: AOJu0Yxp1HW6tU1CGq0Kd5BOUoQAYjy+I0FPjzmFlSGqy0egEsl37ckg
	3Z5cGZQC6XZMQ/73ezcb/HiSkNKVFrDsu1vd7OJGA6JpUMH9Y78i4/l+IljxgjtkQA==
X-Google-Smtp-Source: AGHT+IHfxnxJFtybWOETRz8nFAUjRPtRPTMFfDOIh2cJHNF2VOy38bMQPBp+nS02/q9Bo62rS6aaoA==
X-Received: by 2002:a17:903:228e:b0:1f6:f1ca:2e18 with SMTP id d9443c01a7336-1f83b5df353mr21766865ad.17.1718196193525;
        Wed, 12 Jun 2024 05:43:13 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71b9dec2bsm51310775ad.186.2024.06.12.05.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:43:13 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	mic@digikod.net,
	gnoack@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] perf trace: BTF-based enum pretty printing
Date: Wed, 12 Jun 2024 20:43:25 +0800
Message-ID: <20240612124325.3149243-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in v2

- Fix formatting issues

- Pass a &use_btf to syscall_arg_fmt__init_array(), instead of
traversing all the arguments again.

- Add a trace__load_vmlinux_btf() function to load vmlinux BTF

- Add member 'btf_entry' in 'struct syscall_arg_fmt' to save the entry to
the corresponding 'struct btf_member' object, without having to do
btf__find_by_name(), btf__type_by_id(), btf_enum(), and btf_vlen()
everytime a syscall enters.

In 'struct syscall_arg_fmt':
```
	struct {
		void	*entry;
		u16	nr_entries;
	}	   btf_entry;
```

This is the new member btf_entry, it saves the 'struct btf_member' pointer
, so that we don't have to do btf__find_by_name(), btf__type_by_id(),
btf_enum(), and btf_vlen() everytime a landlock_add_rule() syscall entered.

Note that entry is of type 'void *', because this btf_entry can also be
applied to 'struct btf_member *' for 'BTF_KIND_STRUCT', hopefully in the
future.

===

This is a feature implemented on the basis of the previous bug fix
https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4c951cb90@web.de/T/#t

In this patch, BTF is used to turn enum value to the corresponding
name. There is only one system call that uses enum value as its
argument, that is `landlock_add_rule()`.

The vmlinux btf is loaded lazily, when user decided to trace the
`landlock_add_rule` syscall. But if one decide to run `perf trace`
without any arguments, the behaviour is to trace `landlock_add_rule`,
so vmlinux btf will be loaded by default.

The laziest behaviour is to load vmlinux btf when a
`landlock_add_rule` syscall hits. But I think you could lose some
samples when loading vmlinux btf at run time, for it can delay the
handling of other samples. I might need your precious opinions on
this...

before:

```
perf $ ./perf trace -e landlock_add_rule
     0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: 2)                                       = -1 EBADFD (File descriptor in bad state)
     0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: 1)                                       = -1 EBADFD (File descriptor in bad state)
```

after:

```
perf $ ./perf trace -e landlock_add_rule
     0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_NET_PORT)                  = -1 EBADFD (File descriptor in bad state)
     0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_PATH_BENEATH)              = -1 EBADFD (File descriptor in bad state)
```

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5cbe1748911d..a89379ccac39 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -19,6 +19,7 @@
 #ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include <bpf/btf.h>
 #ifdef HAVE_BPF_SKEL
 #include "bpf_skel/augmented_raw_syscalls.skel.h"
 #endif
@@ -110,6 +111,11 @@ struct syscall_arg_fmt {
 	const char *name;
 	u16	   nr_entries; // for arrays
 	bool	   show_zero;
+	bool	   is_enum;
+	struct {
+		void	*entry;
+		u16	nr_entries;
+	}	   btf_entry;
 };
 
 struct syscall_fmt {
@@ -140,6 +146,7 @@ struct trace {
 #ifdef HAVE_BPF_SKEL
 	struct augmented_raw_syscalls_bpf *skel;
 #endif
+	struct btf		*btf;
 	struct record_opts	opts;
 	struct evlist	*evlist;
 	struct machine		*host;
@@ -887,6 +894,56 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
 
+static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
+{
+	const struct btf_type *bt;
+	char enum_prefix[][16] = { "enum", "const enum" }, *ep;
+	int id;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
+		ep = enum_prefix[i];
+		if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
+			type += strlen(ep) + 1;
+	}
+
+	id = btf__find_by_name(btf, type);
+	if (id < 0)
+		return -1;
+
+	bt = btf__type_by_id(btf, id);
+	if (bt == NULL)
+		return -1;
+
+	arg_fmt->btf_entry.entry      = btf_enum(bt);
+	arg_fmt->btf_entry.nr_entries = btf_vlen(bt);
+
+	return 0;
+}
+
+static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struct btf *btf, char *type,
+				 struct syscall_arg_fmt *arg_fmt)
+{
+	struct btf_enum *be;
+	int i;
+
+	/* if btf_entry is NULL, find and save it to arg_fmt */
+	if (arg_fmt->btf_entry.entry == NULL)
+		if (btf_enum_find_entry(btf, type, arg_fmt))
+			return 0;
+
+	be = (struct btf_enum *)arg_fmt->btf_entry.entry;
+
+	for (i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
+		if (be->val == val) {
+			return scnprintf(bf, size, "%s",
+					 btf__name_by_offset(btf, be->name_off));
+		}
+	}
+
+	return 0;
+}
+
 #define STRARRAY(name, array) \
 	  { .scnprintf	= SCA_STRARRAY, \
 	    .strtoul	= STUL_STRARRAY, \
@@ -1238,6 +1295,7 @@ struct syscall {
 	bool		    is_exit;
 	bool		    is_open;
 	bool		    nonexistent;
+	bool		    use_btf;
 	struct tep_format_field *args;
 	const char	    *name;
 	const struct syscall_fmt  *fmt;
@@ -1699,6 +1757,14 @@ static void trace__symbols__exit(struct trace *trace)
 	symbol__exit();
 }
 
+static void trace__load_vmlinux_btf(struct trace *trace)
+{
+	trace->btf = btf__load_vmlinux_btf();
+	if (verbose > 0)
+		fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
+						    "Failed to load vmlinux BTF\n");
+}
+
 static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
 	int idx;
@@ -1744,7 +1810,8 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
 }
 
 static struct tep_format_field *
-syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
+syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field,
+			    bool *use_btf)
 {
 	struct tep_format_field *last_field = NULL;
 	int len;
@@ -1756,6 +1823,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			continue;
 
 		len = strlen(field->name);
+		arg->is_enum = false;
 
 		if (strcmp(field->type, "const char *") == 0 &&
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
@@ -1782,6 +1850,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
+		} else if (strstr(field->type, "enum") && use_btf != NULL) {
+			*use_btf = arg->is_enum = true;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
@@ -1798,7 +1868,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 
 static int syscall__set_arg_fmts(struct syscall *sc)
 {
-	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
+	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
+									  &sc->use_btf);
 
 	if (last_field)
 		sc->args_size = last_field->offset + last_field->size;
@@ -1811,6 +1882,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	char tp_name[128];
 	struct syscall *sc;
 	const char *name = syscalltbl__name(trace->sctbl, id);
+	int err;
 
 #ifdef HAVE_SYSCALL_TABLE_SUPPORT
 	if (trace->syscalls.table == NULL) {
@@ -1883,7 +1955,13 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
-	return syscall__set_arg_fmts(sc);
+	err = syscall__set_arg_fmts(sc);
+
+	/* after calling syscall__set_arg_fmts() we'll know whether use_btf is true */
+	if (sc->use_btf && trace->btf == NULL)
+		trace__load_vmlinux_btf(trace);
+
+	return err;
 }
 
 static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
@@ -1891,7 +1969,7 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
 	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
 	if (fmt != NULL) {
-		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
+		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
 		return 0;
 	}
 
@@ -2103,6 +2181,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
+			if (sc->arg_fmt[arg.idx].is_enum && trace->btf) {
+				size_t p = btf_enum_scnprintf(bf + printed, size - printed, val,
+							      trace->btf, field->type,
+							      &sc->arg_fmt[arg.idx]);
+				if (p) {
+					printed += p;
+					continue;
+				}
+			}
+
 			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
 								  bf + printed, size - printed, &arg, val);
 		}
-- 
2.45.2


