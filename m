Return-Path: <bpf+bounces-32022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04259061C4
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599A21F21BE2
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192AD7E116;
	Thu, 13 Jun 2024 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBCjddFi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D85E093;
	Thu, 13 Jun 2024 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245667; cv=none; b=CPcNhDpJ2pyIoQzzY2XLwtdg13fkzzycamn7KqOviI54Sozguh/JFEBJ4/udFTIGS88rnHUfpBTm5dG2CJgdPIxYGAPkiCYmpSAnnYgbxCtN0Zj2f9aKvSlIysnMNY6FwHBoeP80zKfWIxM1lS+J56ps6NSSnmfbC2bhe4x7g2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245667; c=relaxed/simple;
	bh=t5yuDcQ0ykKMEHpsggeG5waeTS4s07O/fuE7rJ8o46Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=igkZTdXG1cwLITh5WJXPANZk1le9JDOcaWPG0hXlTWWoKZxYeL6vteHZ0ydB0zCZMSiHcJ2vQYpwIszsToeGs8xfSsFQgCESkT92U9JbTUyMcLoXBofnLfNIYlCXyOX7u6K9WFxXqr4LYII1jY/RoZIZfXD8CP3NXgIt5FdlSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBCjddFi; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d226aff122so244286b6e.2;
        Wed, 12 Jun 2024 19:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245665; x=1718850465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9ywzJRQTh8DPOaRceemdt4DVGPTa3CulQ7K7ijUVuE=;
        b=fBCjddFiULuPNXUnULrpjJCHkMZdoKMpzIT/e7f+D205nKA5A/LvwL5QEOdo/yY5nN
         uvO6127/BIzySndnqW8Yg0f7P3jx9GHsvu98MhW1NDqcfp8K4opuA0hPE+HL4tlg+GaV
         yYUB4akjpBX8UdfUF1F1JECe2r815M7gEG+L/b6o84YUQMmZ5rv642GE3eFdV6pEopGx
         28Ftp1r3bvLpC2D/EASa/mqiyEXDEEtp3eK8ro9IstqhPhJ+dkK0wVDE5fJhFUISTRag
         rpbIkb9g2tvsS/aA4eTurtHkoxPWANDdYJ6ZkK6qvMNyIip+cSISy/GTwl3gyOXG0u9c
         27XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245665; x=1718850465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9ywzJRQTh8DPOaRceemdt4DVGPTa3CulQ7K7ijUVuE=;
        b=j1+2HFMn8AcLIiAoEqIN/A8y9v3gCA0Ak7mzilduuLp7+HPnaWo5alQjiy1a4qY0mJ
         J5y9ruH3qYMhEj3p/0dSNp3i7idMMUzCwqVq2Ai6xhCdNVLqd2aGXp6H6tbIxBM7tmaS
         aGFZKasLUqUIi9yM3xG00KxAFC0EGsrrSMnIS3vOsa31UMM9FVAovMI6F/iyNLyvsCkU
         Lj/k80MaTubqJ3fjr6ok6KGJWBR45orbFLxJ/sd9rSRjQdYewrWPJ7dEMYXAIvAGVFWB
         wR4GCp+D1kRAV1WGInToChf5NnHVD8ch0/VnC3Z2S9x2aVlGjYpFLRAQCgobP6bJDiSR
         O6+A==
X-Forwarded-Encrypted: i=1; AJvYcCUla0ytOpKulKyEbkB1DTiMDwGYNWk4iGZt8nk74+9LIBV7o3Ddg1nEXyfKRlXcB90EsFXiSURXibXaRZfkpO64x62OJka60jVB2mE79/XP5l5dwQ8yh2jai6rsItYpe8WHi+G6jnGfvaDczjsss4PnedYgf2UjjvKUE2Y0e5FQ356+Xw8O+5vrUi4pQe47kBcMBcJjLduKhnV1N+sva/IKAO4OMXqGs1UYug==
X-Gm-Message-State: AOJu0YyPooW6/zC4e1JJ3qu+Q6/94AJVdk+rY8o/GXa23jjtPMI672u/
	ZN6bhhD3ZuMK6bfXTu2vhuwZ5WC80sdcfDOl+/OZD9PZJztUQCVN
X-Google-Smtp-Source: AGHT+IE29/IbzvDrj9TG3ggdYIaewSZdxbagQlBFXyR8OR4Le6RUvpt/RxApwu5nZA0XBdlWWWaQFg==
X-Received: by 2002:a05:6808:1315:b0:3d2:2848:4c91 with SMTP id 5614622812f47-3d23e011ab9mr3912526b6e.28.1718245664872;
        Wed, 12 Jun 2024 19:27:44 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc964a5asm260392b3a.47.2024.06.12.19.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 19:27:44 -0700 (PDT)
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
Subject: [PATCH v3] perf trace: BTF-based enum pretty printing
Date: Thu, 13 Jun 2024 10:27:57 +0800
Message-ID: <20240613022757.3589783-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in v3:

- Fixed another awkward formatting issue in trace__load_vmlinux_btf()

changes in v2:

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

This is the new member btf_entry. 'struct btf_member' object, so that
we don't have to do btf__find_by_name(), btf__type_by_id(), btf_enum(),
and btf_vlen() everytime a landlock_add_rule() syscall entered.

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
 tools/perf/builtin-trace.c | 97 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5cbe1748911d..740285a1f189 100644
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
@@ -1699,6 +1757,15 @@ static void trace__symbols__exit(struct trace *trace)
 	symbol__exit();
 }
 
+static void trace__load_vmlinux_btf(struct trace *trace)
+{
+	trace->btf = btf__load_vmlinux_btf();
+	if (verbose > 0) {
+		fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
+						    "Failed to load vmlinux BTF\n");
+	}
+}
+
 static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
 	int idx;
@@ -1744,7 +1811,8 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
 }
 
 static struct tep_format_field *
-syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
+syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field,
+			    bool *use_btf)
 {
 	struct tep_format_field *last_field = NULL;
 	int len;
@@ -1756,6 +1824,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			continue;
 
 		len = strlen(field->name);
+		arg->is_enum = false;
 
 		if (strcmp(field->type, "const char *") == 0 &&
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
@@ -1782,6 +1851,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
+		} else if (strstr(field->type, "enum") && use_btf != NULL) {
+			*use_btf = arg->is_enum = true;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
@@ -1798,7 +1869,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 
 static int syscall__set_arg_fmts(struct syscall *sc)
 {
-	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
+	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
+									  &sc->use_btf);
 
 	if (last_field)
 		sc->args_size = last_field->offset + last_field->size;
@@ -1811,6 +1883,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	char tp_name[128];
 	struct syscall *sc;
 	const char *name = syscalltbl__name(trace->sctbl, id);
+	int err;
 
 #ifdef HAVE_SYSCALL_TABLE_SUPPORT
 	if (trace->syscalls.table == NULL) {
@@ -1883,7 +1956,13 @@ static int trace__read_syscall_info(struct trace *trace, int id)
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
@@ -1891,7 +1970,7 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
 	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
 	if (fmt != NULL) {
-		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
+		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
 		return 0;
 	}
 
@@ -2103,6 +2182,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
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


