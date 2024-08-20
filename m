Return-Path: <bpf+bounces-37639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608D958B26
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 17:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E2DB240D0
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3BB195809;
	Tue, 20 Aug 2024 15:24:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DA194A5C
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167495; cv=none; b=e/MURgFAcd+iG19mK/PSeSOv5MOXTYViXimtBdbDSBypoBAO7+iaqrzyuIJW546PIPyhH7YxKzTVORVQ49HQbcYAmNrRPUBt+5/jndPpHLpks17EBLXkAtJdNHxtaCeQ2MjSAHtvwnqJn3Aetm+1XRpYGumlWDcvnMyq/0OH+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167495; c=relaxed/simple;
	bh=H+Ge3DYxzo47a5UGNh9QIIyiyVnN4lysgC6KDJmhx3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcpFDko5mnNxGaj+OkskrS/4tjLDuw5j0KW00S2tOYfQ3vDKyk7zYcr9V1CRRDbYp/4whxcKwV51tmUEDZGQ5oAcn12lII9LJCc7kV47Xp+Y5ewHey1qTXVDPnBX2ZlxCUx64/NxjL7kDB+YkoHuwqAsmfMqab+DFU+NTusafFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428243f928fso62345935e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 08:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167491; x=1724772291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+h/RXTkWQXZzTfJ4VCq1a0E/4OOQuApyMjo6wBIuc38=;
        b=rl/KpECzEHoJ0j0C+hY9MUeSfnXAMW0nuzV/z++apRW8lXeLnQJqIa9Iq9kaHk0Fsh
         qQlvSfh7EWlF/yIjyHfIyqfMzq0WPIb1QDWDMtB3IdM83TfA9pPaJ+hH1t4E4Riv2anG
         S+o+Vbbw5Hh3fjgiehHdD7cSXKtNSZEamdvhbaDcktrAcTMAtO8pyYoslVcZD9vDZTXL
         Pju1yx+wF5b++mnoq8hTBr5IBIa3l1DSABJywnAWTPQF13/C+TeICgwcaDwEpZVituFB
         yNlmzvTIwxv84Wuz/Sjg8pioQzIOctJzzt+NcmMD/QUf6+svLIcjGuH0jaoJOgB1COf9
         QivA==
X-Gm-Message-State: AOJu0YyENhdN6t/onuk3OFa1qzIihpeQJKcISwZ8dV88FqZ4SyB/Dkmi
	JR0IVgJzI89LSXWlVNAer/+2tNnLW3dQ0hBe5GlIO0WHVgAiJyaUTzljeA==
X-Google-Smtp-Source: AGHT+IHuMgr8TK0Xp6+dNuO1O64o4H8aGTFFqIst+nyP/1+JDxdi2VrCpImaquff7QP5J/I2DMeFJQ==
X-Received: by 2002:a05:600c:3104:b0:426:6ee7:d594 with SMTP id 5b1f17b1804b1-429ed784076mr106612275e9.7.1724167490841;
        Tue, 20 Aug 2024 08:24:50 -0700 (PDT)
Received: from localhost.localdomain (walt-20-b2-v4wan-167837-cust573.vm13.cable.virginm.net. [80.2.18.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aa8casm13517715f8f.93.2024.08.20.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:24:50 -0700 (PDT)
From: Mykyta@web.codeaurora.org, Yatsenko@web.codeaurora.org,
	mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: emit top frequent C code lines in veristat
Date: Tue, 20 Aug 2024 16:24:33 +0100
Message-ID: <20240820152433.777663-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Production BPF programs are increasing in number of instructions and states
to the point, where optimising verification process for them is necessary
to avoid running into instruction limit. Authors of those BPF programs
need to analyze verifier output, for example, collecting the most
frequent C source code lines to understand which part of the program has
the biggest verification cost.

This patch introduces `--top-lines` and `--include-instructions` flags in
veristat.
`--top-lines=N` makes veristat output N the most popular C sorce code
lines, parsed from verification log. `--include-instructions` enables
printing BPF instructions along with C source code.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 160 +++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 1ec5c4c47235..977ab54cba83 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -16,10 +16,12 @@
 #include <sys/stat.h>
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
+#include <bpf/hashmap.h>
 #include <libelf.h>
 #include <gelf.h>
 #include <float.h>
 #include <math.h>
+#include <linux/err.h>
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
@@ -179,8 +181,16 @@ static struct env {
 	int files_skipped;
 	int progs_processed;
 	int progs_skipped;
+	int top_lines;
+	bool include_insn;
 } env;
 
+struct line_cnt {
+	long cnt;
+	char *line;
+	char *insn;
+};
+
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
 {
 	if (!env.verbose)
@@ -206,6 +216,8 @@ const char argp_program_doc[] =
 enum {
 	OPT_LOG_FIXED = 1000,
 	OPT_LOG_SIZE = 1001,
+	OPT_TOP_LINES = 1002,
+	OPT_INCLUDE_INSN = 1003,
 };
 
 static const struct argp_option opts[] = {
@@ -228,6 +240,9 @@ static const struct argp_option opts[] = {
 	  "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STATE_FREQ program flag)" },
 	{ "test-reg-invariants", 'r', NULL, 0,
 	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
+	{ "top-lines", OPT_TOP_LINES, "N", 0, "Emit N the most frequent C source code lines." },
+	{ "include-instructions", OPT_INCLUDE_INSN, NULL, OPTION_HIDDEN,
+	  "If emitting the most frequent C source code lines, include their BPF instructions." },
 	{},
 };
 
@@ -337,6 +352,17 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return -ENOMEM;
 		env.filename_cnt++;
 		break;
+	case OPT_TOP_LINES:
+		errno = 0;
+		env.top_lines = strtol(arg, NULL, 10);
+		if (errno) {
+			fprintf(stderr, "invalid top lines N specifier: %s\n", arg);
+			argp_usage(state);
+		}
+		break;
+	case OPT_INCLUDE_INSN:
+		env.include_insn = true;
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -817,6 +843,24 @@ static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
 	free(stats);
 }
 
+static int line_cnt_cmp(const void *a, const void *b)
+{
+	const struct line_cnt **a_cnt = (const struct line_cnt **)a;
+	const struct line_cnt **b_cnt = (const struct line_cnt **)b;
+
+	return (*b_cnt)->cnt - (*a_cnt)->cnt;
+}
+
+static size_t str_hash_fn(long key, void *ctx)
+{
+	return str_hash((void *)key);
+}
+
+static bool str_equal_fn(long a, long b, void *ctx)
+{
+	return strcmp((void *)a, (void *)b) == 0;
+}
+
 static char verif_log_buf[64 * 1024];
 
 #define MAX_PARSED_LOG_LINES 100
@@ -854,6 +898,120 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 	return 0;
 }
 
+static char *parse_instructions(char *buf, char *buf_end)
+{
+	char *start = buf;
+
+	while (buf && buf < buf_end && *buf && *buf != ';') {
+		char *num_end = NULL;
+
+		strtol(buf, &num_end, 10);
+		if (!num_end || *num_end != ':')
+			break;
+
+		buf = strchr(num_end, '\n');
+	}
+
+	return start == buf ? NULL : strndup(start, buf - start);
+}
+
+static int print_top_lines(char * const buf, size_t buf_sz)
+{
+	struct hashmap *lines_map;
+	struct line_cnt **lines_cnt = NULL;
+	struct hashmap_entry *entry;
+	char *buf_end;
+	char *line;
+	int err = 0;
+	int unique_lines;
+	int bkt;
+	int i;
+
+	if (!buf || !buf_sz)
+		return -EINVAL;
+
+	buf_end = buf + buf_sz - 1;
+	*buf_end = '\0';
+	lines_map = hashmap__new(str_hash_fn, str_equal_fn, NULL);
+	if (IS_ERR(lines_map))
+		return PTR_ERR(lines_map);
+
+	for (char *line_start = buf; line_start < buf_end;) {
+		char *line_end = strchr(line_start, '\n');
+
+		if (!line_end)
+			line_end = buf_end;
+
+		if (*line_start == ';') {
+			struct line_cnt *line_cnt;
+
+			line_start++; /* skip semicolon */
+			*line_end = '\0';
+			if (hashmap__find(lines_map, line_start, &line_cnt)) {
+				line_cnt->cnt++;
+			} else {
+				char *insn = NULL;
+
+				line_cnt = malloc(sizeof(struct line_cnt));
+				if (!line_cnt) {
+					*line_end = '\n';
+					goto cleanup;
+				}
+				line = strdup(line_start);
+				if (!line) {
+					*line_end = '\n';
+					free(line_cnt);
+					goto cleanup;
+				}
+				if (env.include_insn)
+					insn = parse_instructions(line_end + 1, buf_end);
+				line_cnt->insn = insn;
+				line_cnt->line = line;
+				line_cnt->cnt = 1;
+				err = hashmap__add(lines_map, line, line_cnt);
+			}
+			*line_end = '\n';
+
+			if (err)
+				goto cleanup;
+		}
+		line_start = line_end + 1;
+	}
+	unique_lines = hashmap__size(lines_map);
+	if (!unique_lines)
+		goto cleanup;
+
+	lines_cnt = calloc(unique_lines, sizeof(struct line_cnt *));
+	if (!lines_cnt)
+		goto cleanup;
+
+	i = 0;
+	hashmap__for_each_entry(lines_map, entry, bkt)
+		lines_cnt[i++] = (struct line_cnt *)entry->value;
+
+	qsort(lines_cnt, unique_lines, sizeof(struct line_cnt *), line_cnt_cmp);
+
+	printf("Top C source code lines:\n");
+	for (i = 0; i  < min(unique_lines, env.top_lines); i++) {
+		printf("; [Count: %ld] %s\n", lines_cnt[i]->cnt, lines_cnt[i]->line);
+		if (env.include_insn)
+			printf("%s\n", lines_cnt[i]->insn);
+	}
+	printf("\n");
+
+cleanup:
+	hashmap__for_each_entry(lines_map, entry, bkt) {
+		struct line_cnt *line_cnt = (struct line_cnt *)entry->value;
+
+		free(line_cnt->insn);
+		free(line_cnt->line);
+		free(line_cnt);
+	}
+	hashmap__free(lines_map);
+	free(lines_cnt);
+	return err;
+}
+
 static int guess_prog_type_by_ctx_name(const char *ctx_name,
 				       enum bpf_prog_type *prog_type,
 				       enum bpf_attach_type *attach_type)
@@ -1048,6 +1206,8 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 		       filename, prog_name, stats->stats[DURATION],
 		       err ? "failure" : "success", buf);
 	}
+	if (env.top_lines)
+		print_top_lines(buf, buf_sz);
 
 	if (verif_log_buf != buf)
 		free(buf);
-- 
2.46.0


