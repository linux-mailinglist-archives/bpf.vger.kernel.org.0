Return-Path: <bpf+bounces-40070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291C97C0F0
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C5E28108F
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB1D1CA6B7;
	Wed, 18 Sep 2024 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN83gzAA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC514B94A
	for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692021; cv=none; b=PJb1+TRG+N6DEsE1oMt3z1bliSWVZww2beLSfVKJipayU6zNszO/wLMwYpNkOC9rn6ev5ybrZw51xpU2cEoL6vyR+gLHoFQ530JLHfIhoWm9S6Vt9AHrUUggHgqKF+PHyDX96aBq44oVQpa3eGtnrZqk5oF/rIqOkS/sZuBuVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692021; c=relaxed/simple;
	bh=LeYWhgR0/DpNss1zqgbgkkvEjrOTrd/G6iIykZ2x0Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1boAQzZULfs7WPBWDkCa7t5L1FuI4cTC5Cw9o1XJqwQRUVDAoJCVuOsu3CW9bsa1/EVJa82hf6qofNeQnglC20ZNj3vWPL7HdvPqTETop7BGw8wKFU1XgYoAC8diY2dE28FGbaDT2p4MuSOlq0pl96lSE/PC+HiKOzvGH0cp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN83gzAA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so1025031fa.0
        for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726692018; x=1727296818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xwg6/TLdXT4osFqudFv+3uvy/fC0XIIV0QygwcFgL28=;
        b=QN83gzAA0V7KpBK8946B0ufCa9Y6qPnnJgAISjWThaqn9wLOvYLyZP7U2E03CPN8Ou
         s48KsfM9Yhqymkz3NDf/WIkC/lfwU5tHgmefh4FVnhxC1sPuNsQtV0gx7xUtcfPbPvwn
         6iS52eSkkMq1Bq8kNR0eUB8r7kQrK4nPeSrcn+xgDiWtklWSIlRQB7jxL16O7sUFqeQF
         V3zUuysown2rGA+rW+PdbC3W1UcHOTNn3LaO7iKst34pXRZQcpsmSHRgQAaZ9u1KM4f2
         OXHaKXTqGRTdEZN1cPOPeWaWqe1d1QmIQYGzDwUOt475+lev9+nQTZGwICXxpHVCvjt+
         /R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692018; x=1727296818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xwg6/TLdXT4osFqudFv+3uvy/fC0XIIV0QygwcFgL28=;
        b=LVyJXvSVEcLG2lW5H31JbVh0CjVI7V/dfPr9kJtPUD9lJ0tcZtfZ2OZ3P8Uq055xuf
         C8ty/B9hZ5IjnUrjP25fjHdUMSvsIFXkNwx+ZvuneC3ZtqVOQQGTujQiRUSzLC1ExBNM
         xxul4pM/vAwcEilBRaBT2HmpvtnDgaMia5/a/Jyt8H8DjbF2rOI1HssKAXbQZ41TmmX8
         6k8SibSRR4V7f1O99MmZ6jI3ftxWSvEIUtKjkNs35a20f9YEYY85R5i3VmTWSQjqdU1i
         LulRZ+PyUwjicgNAIJoYpl0ke8b0UwU3q+eIDNGhH6ff8sXJigcPA5f8a9RayINgkuZv
         6jdw==
X-Gm-Message-State: AOJu0YxwMzCNqHngKjLPPEk6d2eJ84swPQ2t79feD6Ulm/t/n2Ry9x84
	m5IYaFZ3G7QbNa8ZZDu95UX5emG/MaNJf5hqLl3xC8cWWjPJPpfJYN7dMA==
X-Google-Smtp-Source: AGHT+IE75GTigB20MCOZCblbRMCr+oY9dfqVh8SeZNmjvfCocxWcnv0gN0jfR+6a6ypjoAMLFrZVUw==
X-Received: by 2002:a05:651c:b1f:b0:2f7:52de:9a35 with SMTP id 38308e7fff4ca-2f791b5c567mr103701701fa.42.1726692017232;
        Wed, 18 Sep 2024 13:40:17 -0700 (PDT)
Received: from localhost.localdomain ([148.252.132.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb495b3sm5274447a12.20.2024.09.18.13.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 13:40:16 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] selftests/bpf: emit top frequent code lines in veristat
Date: Wed, 18 Sep 2024 21:39:25 +0100
Message-ID: <20240918203925.150231-1-mykyta.yatsenko5@gmail.com>
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
frequent source code lines to understand which part of the program has
the biggest verification cost.

This patch introduces `--top-src-lines` flag in veristat.
`--top-src-lines=N` makes veristat output N the most popular sorce code
lines, parsed from verification log.

An example:
```
$ sudo ./veristat --log-size=1000000000 --top-src-lines=4  pyperf600.bpf.o
Processing 'pyperf600.bpf.o'...
Top source lines (on_event):
 4697: (pyperf.h:0)	 
 2334: (pyperf.h:326)	event->stack[i] = *symbol_id; 
 2334: (pyperf.h:118)	pidData->offsets.String_data); 
 1176: (pyperf.h:92)	bpf_probe_read_user(&frame->f_back, 
...
```

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 132 ++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 1ec5c4c47235..854fa4459b77 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -143,6 +143,7 @@ static struct env {
 	char **filenames;
 	int filename_cnt;
 	bool verbose;
+	bool print_verbose;
 	bool debug;
 	bool quiet;
 	bool force_checkpoints;
@@ -179,11 +180,12 @@ static struct env {
 	int files_skipped;
 	int progs_processed;
 	int progs_skipped;
+	int top_src_lines;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
 {
-	if (!env.verbose)
+	if (!env.print_verbose)
 		return 0;
 	if (level == LIBBPF_DEBUG  && !env.debug)
 		return 0;
@@ -206,6 +208,7 @@ const char argp_program_doc[] =
 enum {
 	OPT_LOG_FIXED = 1000,
 	OPT_LOG_SIZE = 1001,
+	OPT_TOP_SRC_LINES = 1002,
 };
 
 static const struct argp_option opts[] = {
@@ -228,6 +231,7 @@ static const struct argp_option opts[] = {
 	  "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STATE_FREQ program flag)" },
 	{ "test-reg-invariants", 'r', NULL, 0,
 	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
+	{ "top-src-lines", OPT_TOP_SRC_LINES, "N", 0, "Emit N most frequent source code lines" },
 	{},
 };
 
@@ -249,10 +253,12 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 		break;
 	case 'v':
 		env.verbose = true;
+		env.print_verbose = true;
 		break;
 	case 'd':
 		env.debug = true;
 		env.verbose = true;
+		env.print_verbose = true;
 		break;
 	case 'q':
 		env.quiet = true;
@@ -337,6 +343,15 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return -ENOMEM;
 		env.filename_cnt++;
 		break;
+	case OPT_TOP_SRC_LINES:
+		errno = 0;
+		env.verbose = true;
+		env.top_src_lines = strtol(arg, NULL, 10);
+		if (errno) {
+			fprintf(stderr, "invalid top lines N specifier: %s\n", arg);
+			argp_usage(state);
+		}
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -854,6 +869,109 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 	return 0;
 }
 
+struct line_cnt {
+	char *line;
+	int cnt;
+};
+
+static int str_cmp(const void *a, const void *b)
+{
+	const char **str1 = (const char **)a;
+	const char **str2 = (const char **)b;
+
+	return strcmp(*str1, *str2);
+}
+
+static int line_cnt_cmp(const void *a, const void *b)
+{
+	const struct line_cnt *a_cnt = (const struct line_cnt *)a;
+	const struct line_cnt *b_cnt = (const struct line_cnt *)b;
+
+	return b_cnt->cnt - a_cnt->cnt;
+}
+
+static int print_top_src_lines(char * const buf, size_t buf_sz, const char *prog_name)
+{
+	int lines_cap = 1;
+	int lines_size = 0;
+	char **lines;
+	char *line = NULL;
+	char *state;
+	struct line_cnt *freq = NULL;
+	struct line_cnt *cur;
+	int unique_lines;
+	int err;
+	int i;
+
+	lines = calloc(lines_cap, sizeof(char *));
+	if (!lines)
+		return -ENOMEM;
+
+	while ((line = strtok_r(line ? NULL : buf, "\n", &state))) {
+		if (strncmp(line, "; ", 2))
+			continue;
+		line += 2;
+
+		if (lines_size == lines_cap) {
+			char **tmp;
+
+			lines_cap *= 2;
+			tmp = realloc(lines, lines_cap * sizeof(char *));
+			if (!tmp) {
+				err = -ENOMEM;
+				goto cleanup;
+			}
+			lines = tmp;
+		}
+		lines[lines_size] = line;
+		lines_size++;
+	}
+
+	if (!lines_size)
+		goto cleanup;
+
+	qsort(lines, lines_size, sizeof(char *), str_cmp);
+
+	freq = calloc(lines_size, sizeof(struct line_cnt));
+	if (!freq) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	cur = freq;
+	cur->line = lines[0];
+	cur->cnt = 1;
+	for (i = 1; i < lines_size; ++i) {
+		if (strcmp(lines[i], cur->line)) {
+			cur++;
+			cur->line = lines[i];
+			cur->cnt = 0;
+		}
+		cur->cnt++;
+	}
+	unique_lines = cur - freq + 1;
+
+	qsort(freq, unique_lines, sizeof(struct line_cnt), line_cnt_cmp);
+
+	printf("Top source lines (%s):\n", prog_name);
+	for (i = 0; i < min(unique_lines, env.top_src_lines); ++i) {
+		char *src_code;
+		char *src_line;
+
+		src_code = strtok_r(freq[i].line, "@", &state);
+		src_line = strtok_r(NULL, "\0", &state);
+		if (src_line)
+			printf("%5d: (%s)\t%s\n", freq[i].cnt, src_line + 1, src_code);
+		else
+			printf("%5d: %s\n", freq[i].cnt, src_code);
+	}
+
+cleanup:
+	free(freq);
+	free(lines);
+	return err;
+}
+
 static int guess_prog_type_by_ctx_name(const char *ctx_name,
 				       enum bpf_prog_type *prog_type,
 				       enum bpf_attach_type *attach_type)
@@ -1043,11 +1161,13 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	stats->stats[VERDICT] = err == 0; /* 1 - success, 0 - failure */
 	parse_verif_log(buf, buf_sz, stats);
 
-	if (env.verbose) {
+	if (env.print_verbose) {
 		printf("PROCESSING %s/%s, DURATION US: %ld, VERDICT: %s, VERIFIER LOG:\n%s\n",
 		       filename, prog_name, stats->stats[DURATION],
 		       err ? "failure" : "success", buf);
 	}
+	if (env.top_src_lines)
+		print_top_src_lines(buf, buf_sz, stats->prog_name);
 
 	if (verif_log_buf != buf)
 		free(buf);
@@ -1065,13 +1185,13 @@ static int process_obj(const char *filename)
 	int err = 0, prog_cnt = 0;
 
 	if (!should_process_file_prog(base_filename, NULL)) {
-		if (env.verbose)
+		if (env.print_verbose)
 			printf("Skipping '%s' due to filters...\n", filename);
 		env.files_skipped++;
 		return 0;
 	}
 	if (!is_bpf_obj_file(filename)) {
-		if (env.verbose)
+		if (env.print_verbose)
 			printf("Skipping '%s' as it's not a BPF object file...\n", filename);
 		env.files_skipped++;
 		return 0;
@@ -2116,13 +2236,15 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
-	if (env.verbose && env.quiet) {
+	if (env.print_verbose && env.quiet) {
 		fprintf(stderr, "Verbose and quiet modes are incompatible, please specify just one or neither!\n\n");
 		argp_help(&argp, stderr, ARGP_HELP_USAGE, "veristat");
 		return 1;
 	}
 	if (env.verbose && env.log_level == 0)
 		env.log_level = 1;
+	if (env.top_src_lines && env.log_level < 2)
+		env.log_level = 2;
 
 	if (env.output_spec.spec_cnt == 0) {
 		if (env.out_fmt == RESFMT_CSV)
-- 
2.46.0


