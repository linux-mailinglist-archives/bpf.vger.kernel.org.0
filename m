Return-Path: <bpf+bounces-40623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438C98B0AC
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 01:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B601F22B62
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8DC187322;
	Mon, 30 Sep 2024 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GII4iofS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BB5339F
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738135; cv=none; b=LkSClDuQdmevIpQDFBXfRF3h8fwy+XU8k3qUVmGeEZTN1G4SMO0kO/+mHrZC6d49GPCPw/RdJfemgB5UaE351s/sICQSuBtXzCds3VMMRshxQAq19alb4wTRe70PEsjd9UJuleS/Wt8l34NW1+vzil5FhHEI9vAHUZ+OdCf6sns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738135; c=relaxed/simple;
	bh=AhBs2kh6O1iSfEwO6OihVlDznJTjXkI73fNKIxkxsRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptsp4G7omFNi8sFNo1iQYV5fLIvOiWVLUNTvMgZ1BP50jB/E64uBGaZzx8ycTilxd1D4Y8HMsUusS6ISPIz09lnuOVzENhErLyxjxzU8sdBlhrEJ3K/hG3/ZIi3BzfyP3mBDPaMLbd56968ML09IRX9tKgj829F7AcuwW6ZC/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GII4iofS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso913305766b.1
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727738132; x=1728342932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N8wpEL7ax9yzf7RCQvozhQjj+r+cWppRynlUDA/vBD0=;
        b=GII4iofSBKr/5Nj7epr3a/40023wAAXWf5uVWCYWYx4b6MEjhJvVNq1BQfy4+q/KeT
         SAGBszUAKjAww5ZeqlE7c9D0kK15XYjmoBuzytOFSVgtzsvIvtrAJf2zmpv3OHZuCQxM
         sA8/M0ItA1IPYDHQIlJE9q0OTDpbay0yOzsnUQ7gIdvc5jPgnneGlPfvsfAxsU7BARKk
         bV6eG22zXA4CyGVKE31EV37DT3VwIIc/2A2iLUkNDLj8MG0PzM9ShUZcvH0pH1lA3lqq
         9NKKSyhd6fIAb5JqJgcJPbTd6A3yFY/PdH8B2KAGyHC64RhPIdCLuyn1H+xhf+XboA0/
         qf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738132; x=1728342932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8wpEL7ax9yzf7RCQvozhQjj+r+cWppRynlUDA/vBD0=;
        b=vbzGpFVy/YBxcc37nH2Or77sb8d8uDZQRNxsfzFL0s8oC3d9YMXOmPLpt15MTTuPVK
         xDvqwjdQfyAaeLAaSUINXAQrXur6AjSnz+0vtbZucRZwZsF9yF/JSVM3Zcq5ohN0xcGQ
         q4chndA1jVq1VrXRejetTzJw4VDkshU/yy8SelhPy0m+tjevbe/4vjo5miolIy4HrV1H
         SSl6ijnsaTojyckuxD0RDTZsIoj4KicKNUWltammOCMsxPkEoI5BiZ43iaEyVuhbnXXn
         CDoYVskTtc7Kg6HPyCSp60nYknZJ1ujVnRbTiF1MIlfM4RYAj/EbeVF/M4eOJKtaqrq/
         iPIw==
X-Gm-Message-State: AOJu0YxHDyGHPBY/Rk6N7ZIBk9h3+NQSJIUUgffcomQvEpcZWyRfIP3l
	SdewAj/5G7K0mxDoj8Swu0RRuxf/NixOmsmXL71V7cMMuJkIbHWnm/XUTQ==
X-Google-Smtp-Source: AGHT+IH0KqdMwuLdaAclbnQkUMaEBNeWbheztKRSzpZM1Ff3Ps39q5Dv0b9v8GscMJOUu5SJ7ev/0A==
X-Received: by 2002:a17:906:5f85:b0:a98:282:e676 with SMTP id a640c23a62f3a-a980282e87fmr22855566b.10.1727738132239;
        Mon, 30 Sep 2024 16:15:32 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947fbesm599993866b.128.2024.09.30.16.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:15:31 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3] selftests/bpf: emit top frequent code lines in veristat
Date: Tue,  1 Oct 2024 00:15:22 +0100
Message-ID: <20240930231522.58650-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.46.2
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

An example of output:
```
sudo ./veristat  --top-src-lines=2   bpf_flow.bpf.o
Processing 'bpf_flow.bpf.o'...
Top source lines (_dissect):
    4: (bpf_helpers.h:161)	asm volatile("r1 = %[ctx]\n\t"
    4: (bpf_flow.c:155)	if (iph && iph->ihl == 5 &&
...
```

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 127 ++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 1ec5c4c47235..977c5eca56f7 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -179,6 +179,7 @@ static struct env {
 	int files_skipped;
 	int progs_processed;
 	int progs_skipped;
+	int top_src_lines;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -206,6 +207,7 @@ const char argp_program_doc[] =
 enum {
 	OPT_LOG_FIXED = 1000,
 	OPT_LOG_SIZE = 1001,
+	OPT_TOP_SRC_LINES = 1002,
 };
 
 static const struct argp_option opts[] = {
@@ -228,6 +230,7 @@ static const struct argp_option opts[] = {
 	  "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STATE_FREQ program flag)" },
 	{ "test-reg-invariants", 'r', NULL, 0,
 	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
+	{ "top-src-lines", OPT_TOP_SRC_LINES, "N", 0, "Emit N most frequent source code lines" },
 	{},
 };
 
@@ -337,6 +340,14 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return -ENOMEM;
 		env.filename_cnt++;
 		break;
+	case OPT_TOP_SRC_LINES:
+		errno = 0;
+		env.top_src_lines = strtol(arg, NULL, 10);
+		if (errno) {
+			fprintf(stderr, "invalid top lines N specifier: %s\n", arg);
+			argp_usage(state);
+		}
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -854,6 +865,115 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
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
+	int lines_cap = 0;
+	int lines_size = 0;
+	char **lines = NULL;
+	char *line = NULL;
+	char *state;
+	struct line_cnt *freq = NULL;
+	struct line_cnt *cur;
+	int unique_lines;
+	int err = 0;
+	int i;
+
+	while ((line = strtok_r(line ? NULL : buf, "\n", &state))) {
+		if (strncmp(line, "; ", 2) != 0)
+			continue;
+		line += 2;
+
+		if (lines_size == lines_cap) {
+			char **tmp;
+
+			lines_cap = max(16, lines_cap * 2);
+			tmp = realloc(lines, lines_cap * sizeof(*tmp));
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
+	if (lines_size == 0)
+		goto cleanup;
+
+	qsort(lines, lines_size, sizeof(*lines), str_cmp);
+
+	freq = calloc(lines_size, sizeof(*freq));
+	if (!freq) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	cur = freq;
+	cur->line = lines[0];
+	cur->cnt = 1;
+	for (i = 1; i < lines_size; ++i) {
+		if (strcmp(lines[i], cur->line) != 0) {
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
+		const char *src_code = freq[i].line;
+		const char *src_line = NULL;
+		char *split = strrchr(freq[i].line, '@');
+
+		if (split) {
+			src_line = split + 1;
+
+			while (*src_line && isspace(*src_line))
+				src_line++;
+
+			while (split > src_code && isspace(*split))
+				split--;
+			*split = '\0';
+		}
+
+		if (src_line)
+			printf("%5d: (%s)\t%s\n", freq[i].cnt, src_line, src_code);
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
@@ -1009,13 +1129,14 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	stats = &env.prog_stats[env.prog_stat_cnt++];
 	memset(stats, 0, sizeof(*stats));
 
-	if (env.verbose) {
+	if (env.verbose || env.top_src_lines > 0) {
 		buf_sz = env.log_size ? env.log_size : 16 * 1024 * 1024;
 		buf = malloc(buf_sz);
 		if (!buf)
 			return -ENOMEM;
 		/* ensure we always request stats */
-		log_level = env.log_level | 4 | (env.log_fixed ? 8 : 0);
+		log_level = (env.top_src_lines > 0 && env.log_level == 0 ? 2 : env.log_level)
+			| 4 | (env.log_fixed ? 8 : 0);
 	} else {
 		buf = verif_log_buf;
 		buf_sz = sizeof(verif_log_buf);
@@ -1048,6 +1169,8 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 		       filename, prog_name, stats->stats[DURATION],
 		       err ? "failure" : "success", buf);
 	}
+	if (env.top_src_lines > 0)
+		print_top_src_lines(buf, buf_sz, stats->prog_name);
 
 	if (verif_log_buf != buf)
 		free(buf);
-- 
2.46.2


