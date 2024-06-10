Return-Path: <bpf+bounces-31716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF7902272
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 15:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCAF1C21F32
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A10823CB;
	Mon, 10 Jun 2024 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6M0HsFM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D381AA3;
	Mon, 10 Jun 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025019; cv=none; b=WHxEekg5nn+4klm41+v4QNRJYtPLnNDpmqbmr5d2qZRqxk6hREA0EY6eiouJFJ87sQY3echscNLN10MSB89gl2zzDZoBqeMYxtMyd89YW8w3Sd4GkPgwO4CTuOZIsak9kAVpzQMMylr4WxQMePSZs5M4IN1ieXs5SgnoXoXhNaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025019; c=relaxed/simple;
	bh=rpnzjkzZRJoH5xNjY/jyUr59J9J55liY1k0khb0kVqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASA74I5sPPHTOgTA38Ys3+PdXnDOnc2WtEY+G/5aacRa5tENvcoLUKYmw2m9FyDXMrs+At69jZxD8Dm7LvpaXRl1NxxcCYr3ckpYaD3d0zJQbrKhmnZVsVX73pgC+0c6Ckir0ynmwVa/0w2r+YWe/VPnv9SV3zQ4B6rnfYoLQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6M0HsFM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f47f07acd3so40441465ad.0;
        Mon, 10 Jun 2024 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718025017; x=1718629817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JqQv+T68Z77ieKbOSSWpRumFodMN2xfZwuCPpy+rybg=;
        b=Z6M0HsFMFHLOMdYhqo2/HQNk1sOLLwKSHCN1sMJXb9gzrAT00VS4oYi1UBB8PXZIJA
         Of07mZwbuCk5ggSB5rcjjuNm3wVyvbGQK6YmWR5thP9Cd1FirDa961uO6bnXhugFKZOz
         E0+Qgdecj3drFfDxpXRnjYcZiLFPwh4RlmRb9P1u4hK2pKz5PQcWTP9OwyddxKLxE7ed
         9VfB68EHFSzKcwR2EY2koQb+IaWZAucu1ujqufdUko1lNgqp2tQ9oAkEaUiJ7u04G27i
         kvVVsJnL9EPix0crXH5ssdZ1ULSBve2qPy3cPcHi1CcbEGR6YAmVpNE+u8qu2cu9rraS
         wh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718025017; x=1718629817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqQv+T68Z77ieKbOSSWpRumFodMN2xfZwuCPpy+rybg=;
        b=rgyB1ObmcpM15qxjg1ut8M4fVExLOai97oF5HBi+y5EQmIpQUhkbCA+6PsPTTlWq0p
         IRqqN02Uu3Zx5sIPaNfj3t7ncQKGpQ+Qgk9qFDu+6Aeu44yAxVNl3uis9H3eJ6DPpV2l
         pUaXUqx2Z6KRTdKltxpOMIsWu8CC1ecxuTBnzTHFnyQjen4uJtj+UcPqbxg08DQZtPbY
         2SEdrZOIu3G2UVKnW+5OY/o8G3VmY0BSVEaydzbNcGKnO9dczbhV6gA1vpONQFNVnIGM
         kgOG4IeGMBUBuXBzy73EWdgrCVhUwC6dYcVdQh/Yo0IBtudj2STHHYqEq8vvICpDF359
         qXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX13MI6lTxr3ypRWpqljhuTN9fke5ztDjkDgN4NsFqzqMxUDUh1rkMoMfRjq9Jd6twfH3Mb7VVHzc1AwjhA5aZAtBaoc/bnm9wgyMc5VqtElegOKnJfYR1oXZZASUKpE2FLZHCxEZtfUOc/YWoOXhNwzhRnZncHtl5x/ub57a/VyeYNNBaiyl7v/801cPbXVOn8pPXb7XQ3hbh3rXRxesLUAQGoTpa1j3kK+A==
X-Gm-Message-State: AOJu0Yw4rMZQ31Il8oKE9WM1YpRtmrOW9gFg3YLIXfH6joJYilZwpg2h
	kMqG5bePrwwOrW94K28RBdX2POOkhhbElrWZr/Av9fpsHSUj9Lxe
X-Google-Smtp-Source: AGHT+IFEw7OtWfkzx2pwUoIKN7qZKIAsOjNAjB8U7pQ6n7MIYx7TDtVWcRYxQ55Lvb2r/mqRzscouw==
X-Received: by 2002:a17:903:183:b0:1f6:6426:8da4 with SMTP id d9443c01a7336-1f6d03c14demr118275555ad.66.1718025016816;
        Mon, 10 Jun 2024 06:10:16 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e3e66sm81938285ad.182.2024.06.10.06.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 06:10:16 -0700 (PDT)
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
Subject: [PATCH v1] perf trace: BTF-based enum pretty printing
Date: Mon, 10 Jun 2024 21:10:32 +0800
Message-ID: <20240610131032.516323-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a feature implemented on the basis of the previous bug fix
https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4c951cb90@web.de/T/#t

In this patch, I use BTF to turn enum value to the corresponding name.
There is only one system call that uses enum value as its argument,
that is `landlock_add_rule`.

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

P.S.
If you don't apply the patch "perf trace: Fix syscall untraceable
bug", there will be no output whatsoever when running
`perf trace -e landlock_add_rule`

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 69 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5cbe1748911d..5acb9a910ea1 100644
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
@@ -110,6 +111,7 @@ struct syscall_arg_fmt {
 	const char *name;
 	u16	   nr_entries; // for arrays
 	bool	   show_zero;
+	bool	   is_enum;
 };
 
 struct syscall_fmt {
@@ -140,6 +142,7 @@ struct trace {
 #ifdef HAVE_BPF_SKEL
 	struct augmented_raw_syscalls_bpf *skel;
 #endif
+	struct btf		*btf;
 	struct record_opts	opts;
 	struct evlist	*evlist;
 	struct machine		*host;
@@ -887,6 +890,36 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
 
+static size_t btf_enum_scnprintf(char *bf, size_t size, int val,
+			  struct btf *btf, const char *type)
+{
+	const struct btf_type *bt;
+	struct btf_enum *e;
+	char enum_prefix[][16] = {"enum", "const enum"}, *ep;
+	int id;
+
+	for (size_t i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
+		ep = enum_prefix[i];
+		if (strlen(type) > strlen(ep) + 1 && strstr(type, ep) == type)
+			type += strlen(ep) + 1;
+	}
+
+	id = btf__find_by_name(btf, type);
+	if (id < 0)
+		return 0;
+
+	bt = btf__type_by_id(btf, id);
+	e = btf_enum(bt);
+
+	for (int i = 0; i < btf_vlen(bt); i++, e++) {
+		if (e->val == val)
+			return scnprintf(bf, size, "%s",
+					 btf__name_by_offset(btf, e->name_off));
+	}
+
+	return 0;
+}
+
 #define STRARRAY(name, array) \
 	  { .scnprintf	= SCA_STRARRAY, \
 	    .strtoul	= STUL_STRARRAY, \
@@ -1238,6 +1271,7 @@ struct syscall {
 	bool		    is_exit;
 	bool		    is_open;
 	bool		    nonexistent;
+	bool		    use_btf;
 	struct tep_format_field *args;
 	const char	    *name;
 	const struct syscall_fmt  *fmt;
@@ -1756,6 +1790,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			continue;
 
 		len = strlen(field->name);
+		arg->is_enum = false;
 
 		if (strcmp(field->type, "const char *") == 0 &&
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
@@ -1782,6 +1817,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
+		} else if (strstr(field->type, "enum")) {
+			arg->is_enum = true;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
@@ -1798,7 +1835,13 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 
 static int syscall__set_arg_fmts(struct syscall *sc)
 {
-	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
+	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args),
+				*field = sc->args;
+	struct syscall_arg_fmt *arg = sc->arg_fmt;
+
+	for (; field; field = field->next, ++arg)
+		if (arg->is_enum)
+			sc->use_btf = true;
 
 	if (last_field)
 		sc->args_size = last_field->offset + last_field->size;
@@ -1811,6 +1854,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	char tp_name[128];
 	struct syscall *sc;
 	const char *name = syscalltbl__name(trace->sctbl, id);
+	int err;
 
 #ifdef HAVE_SYSCALL_TABLE_SUPPORT
 	if (trace->syscalls.table == NULL) {
@@ -1883,7 +1927,17 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
-	return syscall__set_arg_fmts(sc);
+	err = syscall__set_arg_fmts(sc);
+
+	/* after calling syscall__set_arg_fmts() we'll know whether use_btf is true */
+	if (sc->use_btf && trace->btf == NULL) {
+		trace->btf = btf__load_vmlinux_btf();
+		if (verbose > 0)
+			fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
+							    "Failed to load vmlinux BTF\n");
+	}
+
+	return err;
 }
 
 static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
@@ -2050,7 +2104,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 				      unsigned char *args, void *augmented_args, int augmented_args_size,
 				      struct trace *trace, struct thread *thread)
 {
-	size_t printed = 0;
+	size_t printed = 0, p;
 	unsigned long val;
 	u8 bit = 1;
 	struct syscall_arg arg = {
@@ -2103,6 +2157,15 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
+			if (sc->arg_fmt[arg.idx].is_enum == true && trace->btf) {
+				p = btf_enum_scnprintf(bf + printed, size - printed, val,
+						       trace->btf, field->type);
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


