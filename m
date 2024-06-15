Return-Path: <bpf+bounces-32211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B07D909568
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 03:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2869D1F2391C
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 01:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889F04683;
	Sat, 15 Jun 2024 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+GeYPp8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C2C153;
	Sat, 15 Jun 2024 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416426; cv=none; b=a2aly9Rqg5rU9NQ0Q2OVnnTTGrrKN1g2JFpas1gKU3wfc7dZYGS1uxYY4d+nbK2P7fs49ByrqWlapqmH+84BorX2g68wfPcoeKDxq+RgRM9+A+5WeNA/F5aoKwi6LaQxnDqn5Rgb5CJlUIG97Wa+DLTagvPgtZwkLAYkg94NRoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416426; c=relaxed/simple;
	bh=qY19UZhPA2bTp4GBh41w50lOAkvM+FXG8RAsmb/Nv/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfzFaVcCjxFPUcVnze0QKQ6dqt7nDGo7g19YEbi6vkwk0dmArU041wiRZgx39f91AW/l0v35VkN5uPrW5Vu9aMhhWDgxmH8RDc58bE/VcVALXgm9bAcZldGNnG7M6LlBDcxzHXKgeMrqgH0g/Tj4boIT7+gr3vzfwOyxdJ7qaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+GeYPp8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b45d6abso21666915ad.0;
        Fri, 14 Jun 2024 18:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718416424; x=1719021224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5t3lCO/aliWaX3lRu3qs/sWr5aScOQ+/zbL8ye5TNf0=;
        b=g+GeYPp8heHpjQXKwW61qst1z9ORgUVsbJPNqgvqV+I2/AP/zQbwU/AHQx+ZW/2HWh
         gAtX/9HhxAZHHHwIVy0+vLcz22PDvr/wnUs4xLyfnZ3MaNT2DYeIAmk1ptIkpT7uc/dz
         bCyAC60jmF4VKOvrWmEeXamAc4rMI6js8oy8lhPZqiLW8Jp/R7f7BBE+ZP3eSUeGvybE
         2Lb80jxkW2L06Pbig9f+cYJF6ej21izJ20uy+QyjHJUdVniQ54TAiegvsXKhHNm/8mvX
         PA+8ki0Okwh4cs5JxI36e2SJya0I5X10OHpToNk54PEXI5drtJjndIRLFb6aLSKaKlDQ
         nPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718416424; x=1719021224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t3lCO/aliWaX3lRu3qs/sWr5aScOQ+/zbL8ye5TNf0=;
        b=YeOj7tjAP7rbpisfpa6VPZkRISjvH5TaCV0VtIBdqnyap9KKjO/OaiXTe587YRqnu8
         KIc4UB/18CqYQlFKcIXDSqnwexo2DFxOu6R08zb9QVu0Hi9z+XUr3wm3x+DzbUimEHKu
         33RsHbvphAvBdaSibyp2yWAp1d1DS25gNJhdW3q2gO0ItZ8Tuc3teijoJ46EeGCo6+lK
         jS6Jg8arXhkcBHOlTrGuQRyLaGhXtmGtAUZQjwJfmRedw10E1t3+nTn4/UEzVB1gHKRE
         uWl9pm23Tt2xcp0DYqkztfuDDJ98S5HrYhyBcPlVntFCNYO+AKMlesUm1kHmnuKTuN9/
         cKSA==
X-Forwarded-Encrypted: i=1; AJvYcCVm458OmTMy//84nm0iF1pqiM+bqW8nx4FEpUN+pt+ny3PV2sKgsvHBsEBdA0/wkm/CiejCpaPzOVU4NU9VjkdCJECqypgli/GGUnPoeqsYoOSLESuvkiwcnIC+PC7RTN+6BPqeIMX7q3rd/UFg4kYt+cizN5TGrOKMY1QnSmBHwq6wbiz4XisHwUdlRo2LNUlKK6hnRmKCE/kRRZjGxaQmiRiO+cVPz7BFoA==
X-Gm-Message-State: AOJu0YzNZ5t6gnwH7bIlj2WTnkx8oXMIKaB0DOG21GU/PycFW37Kxo1f
	+FTXotDbY8DdSB3rH5AEMGrm+yJAqUkpkaY8nCPaMuGyEFQm3GCmVSq1/oKGlPeZww==
X-Google-Smtp-Source: AGHT+IHRBbU6N6tCxc5X6jt7eouN1BMNkyvMjIA8uDYP9C5/s5KJmmEGEm9PBXbexO0lAvnO9EFq/A==
X-Received: by 2002:a17:902:eb82:b0:1f7:90e:6d47 with SMTP id d9443c01a7336-1f8625cf286mr44852325ad.25.1718416423470;
        Fri, 14 Jun 2024 18:53:43 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e5fsm39246745ad.59.2024.06.14.18.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 18:53:43 -0700 (PDT)
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
Subject: [PATCH v1] perf trace: Augment enum syscall arguments with BTF
Date: Sat, 15 Jun 2024 09:54:00 +0800
Message-ID: <20240615015400.1889540-1-howardchu95@gmail.com>
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

In this patch, BTF is used to turn enum value to the corresponding
enum variable name. There is only one system call that uses enum value
as its argument, that is `landlock_add_rule()`.

The vmlinux btf is loaded lazily, when user decided to trace the
`landlock_add_rule` syscall. But if one decides to run `perf trace`
without any arguments, the behaviour is to trace `landlock_add_rule`,
so vmlinux btf will be loaded by default.

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

This patch can be tested using this program, calling landlock_add_rule
syscall (created by Arnaldo Carvalho de Melo <acme@kernel.org>):

#include <linux/landlock.h>  /* Definition of LANDLOCK_* constants */
#include <sys/syscall.h>     /* Definition of SYS_* constants */
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>
#include <stdio.h>

/* Provide own perf_event_open stub because glibc doesn't */
__attribute__((weak))
int landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type, const void *rule_attr, uint32_t flags)
{
        return syscall(SYS_landlock_add_rule, ruleset_fd, rule_type, rule_attr, flags);
}

int main(int argc, char *argv[])
{
        struct landlock_path_beneath_attr attr = { .allowed_access = 1, };
        int err = landlock_add_rule(1, LANDLOCK_RULE_PATH_BENEATH, &attr, 0);

        printf("landlock_add_rule(1, LANDLOCK_RULE_PATH_BENEATH, { .allowed_access = 1, }, 0) = %d (%s)\n", err, strerror(errno));

        attr = (struct landlock_path_beneath_attr){ .parent_fd = 222, };

        err = landlock_add_rule(2, LANDLOCK_RULE_NET_PORT, &attr, 0);

        printf("landlock_add_rule(2, LANDLOCK_RULE_NET_PORT, { .parent_fd = 222, }, 0) = %d (%s)\n", err, strerror(errno));

        return err;
}

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>

---
 tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c4fa8191253d..d93f34e9af74 100644
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
+		void	*entries;
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
@@ -897,6 +904,56 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 	    .strtoul	= STUL_STRARRAY_FLAGS, \
 	    .parm	= &strarray__##array, }
 
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
+	arg_fmt->btf_entry.entries    = btf_enum(bt);
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
+	if (arg_fmt->btf_entry.entries == NULL)
+		if (btf_enum_find_entry(btf, type, arg_fmt))
+			return 0;
+
+	be = (struct btf_enum *)arg_fmt->btf_entry.entries;
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
 #include "trace/beauty/arch_errno_names.c"
 #include "trace/beauty/eventfd.c"
 #include "trace/beauty/futex_op.c"
@@ -1699,6 +1756,15 @@ static void trace__symbols__exit(struct trace *trace)
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
@@ -1744,7 +1810,7 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
 }
 
 static struct tep_format_field *
-syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
+syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field, bool *use_btf)
 {
 	struct tep_format_field *last_field = NULL;
 	int len;
@@ -1782,6 +1848,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
+		} else if (strstr(field->type, "enum") && use_btf != NULL) {
+			*use_btf = arg->is_enum = true;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
@@ -1796,9 +1864,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 	return last_field;
 }
 
-static int syscall__set_arg_fmts(struct syscall *sc)
+static int syscall__set_arg_fmts(struct syscall *sc, bool *use_btf)
 {
-	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
+	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
+									  use_btf);
 
 	if (last_field)
 		sc->args_size = last_field->offset + last_field->size;
@@ -1810,7 +1879,9 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 {
 	char tp_name[128];
 	struct syscall *sc;
+	int err;
 	const char *name = syscalltbl__name(trace->sctbl, id);
+	bool use_btf = false;
 
 #ifdef HAVE_SYSCALL_TABLE_SUPPORT
 	if (trace->syscalls.table == NULL) {
@@ -1883,7 +1954,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
-	return syscall__set_arg_fmts(sc);
+	err = syscall__set_arg_fmts(sc, &use_btf);
+
+	if (use_btf && trace->btf == NULL)
+		trace__load_vmlinux_btf(trace);
+
+	return err;
 }
 
 static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
@@ -1891,7 +1967,7 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
 	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
 	if (fmt != NULL) {
-		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
+		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
 		return 0;
 	}
 
@@ -2103,6 +2179,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
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


