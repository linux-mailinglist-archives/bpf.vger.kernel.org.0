Return-Path: <bpf+bounces-46390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C959E95E9
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 14:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFCB166351
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 13:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C0E22B5A7;
	Mon,  9 Dec 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2qRppsK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89170229B3A
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749526; cv=none; b=iTtFK/tDoicwrwJudSLTRRyqPFrnbhv718pk5ZZvL8r8RqIxjEYGDxhfcx5iEaMGEigrjCgpJ6ZVkBiilF/tEJM0DKf/GwZl63JTXYBlNbGMquYJzbPWOfv7uglc6CmbUm+P1tj4K/ZLQZO7+6G/gZEYolLLJduE9DJfL/3vg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749526; c=relaxed/simple;
	bh=l0u88IU1D1mEB24tMzYOFijsnSd5NBAPSrQeXv5IAYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvGGQwftHh6DIKP9f0rfCGs6aK/isdlVCDkXk1wPj/Z0E1e4oTG4YJQY7SIY25RLW9IG+B6kSwmeD6wC0v6g+G48Nj0EgcpNUXQvX33xZfLW5G0DTZe1Us9/x/msx0M2HEHjMm5FSweY1h5CspSLa6fibvCxrdhAkS91DKg2PcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2qRppsK; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa69251292dso121118066b.2
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 05:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733749523; x=1734354323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gpk7Wf4ECMJtSn7weUyp295VgiJ+vAYQMXjGP+etwrs=;
        b=F2qRppsKvVi/MNgLSMiGK7fDashcPLVnfTVZKpaJcihjTbBwpojHiPNioJSOxTUChG
         U49vZc0cAfLXujBUn8LpxJpJ7sSGQSkpMzvjx1V34V2Ln1wt2mDsZa0XXSUPNQSV/hMO
         EZAtqd0/H1CfbFDZFBCuo8k4crNtYFs3NFPb5anXFYn7u6FX326vszbD6d//m7UvQxs1
         RdwtZW55XJgmZ3Rwmzc2zVCwNjtKGhnzcbnoaE/tRAqA5BSBKN734CFaywsmnRYR6Z+o
         awuu/PoPaPtEHBdQ+fXy8vnPefjHvuSiXKoCYY/ZAoUxpEfXf4ayunsmuYX6jsYsBiZg
         DDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749523; x=1734354323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gpk7Wf4ECMJtSn7weUyp295VgiJ+vAYQMXjGP+etwrs=;
        b=nq/Jiy8WY4AJevdxJFkSlBLoMdBbhwKFh5hrSC3kz0Z6oC26vwiGvmbTajuMkYludu
         /hn9/swJtYUlTO352kG363xeahUAYuLlxqn/IM4z/wLRgLZ4VE8uSQkj2sMKod9dNhmJ
         Hniz2Knh4RIds16OxO2QWuOl+NpiKlJWWBM1uJtvFQM3gmGBa9k81WcedIWEwX94V7em
         75EZDmBt2A4WNZcChW9Swkwxz/ZZEbgdvU/PIZNk/+HP95rzzP8ehC6QLaqBxwsu3ipr
         BJbnXRALwRpHmcP3iE1jnmljtr+vQB9uy6g9bOWiH3SvHQPy1y2lG3thHRYjFtIv8UOv
         RWGA==
X-Gm-Message-State: AOJu0YyBV4iEYS9LPaTFSFvNJPORwC5YuRgn+l6NtnrHcozQYRaZLdm0
	SXV30Nh2YucOGRkS9tgHsPqmY5KVwv6FzBRSd31OMHzfsop9cKaqIXq63Q==
X-Gm-Gg: ASbGncuqeXABKPDzbg+Yp+VTfW9Y1ZL+XsZlLOOiWwaupgad9PTFFD0n6H/YwrGorsL
	VkBXvrh2Ml+zOO3WfnaNkY6Bph8WOTt2MruZDcXHep0kzswZn3oeTwGSlru9LqtnUdpo2h52wkc
	q3OYgYJU4kQ5cxtBICXpd6r1imm6c6xfzs4GIIpsuEIlEObndIop7jEXv6Ts8952bHsK1UkIaHT
	m7/rG3KXQJf0iyZ3ghizUInnuWBFm7Hgu6BBPBJvXH2bVmBHwXnaDXkS4RYT6Voi3AqpwVKney0
X-Google-Smtp-Source: AGHT+IFuStn6i5wynpR3K9VWsybYjHlC3mHyhVambVZrfGHHEZhHp+My9fbmITbQK7yYEvpVa94MQQ==
X-Received: by 2002:a17:906:3292:b0:aa5:199f:2bf2 with SMTP id a640c23a62f3a-aa63a073670mr1271240466b.29.1733749522512;
        Mon, 09 Dec 2024 05:05:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:a302:ae00:6eb3:da82:a6be:6559])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68c4b52b8sm124741466b.52.2024.12.09.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:05:22 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3] selftests/bpf: add more stats into veristat
Date: Mon,  9 Dec 2024 13:04:55 +0000
Message-ID: <20241209130455.94592-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend veristat to collect and print more stats, namely:
  - program size in instructions
  - jited program size in bytes
  - program type
  - attach type
  - stack depth

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 64 +++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index e12ef953fba8..162fe27d06f8 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -34,6 +34,11 @@ enum stat_id {
 	PEAK_STATES,
 	MAX_STATES_PER_INSN,
 	MARK_READ_MAX_LEN,
+	SIZE,
+	JITED_SIZE,
+	STACK,
+	PROG_TYPE,
+	ATTACH_TYPE,
 
 	FILE_NAME,
 	PROG_NAME,
@@ -640,19 +645,21 @@ static int append_filter_file(const char *path)
 }
 
 static const struct stat_specs default_output_spec = {
-	.spec_cnt = 7,
+	.spec_cnt = 8,
 	.ids = {
 		FILE_NAME, PROG_NAME, VERDICT, DURATION,
-		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
+		TOTAL_INSNS, TOTAL_STATES, SIZE, JITED_SIZE
 	},
 };
 
 static const struct stat_specs default_csv_output_spec = {
-	.spec_cnt = 9,
+	.spec_cnt = 14,
 	.ids = {
 		FILE_NAME, PROG_NAME, VERDICT, DURATION,
 		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
 		MAX_STATES_PER_INSN, MARK_READ_MAX_LEN,
+		SIZE, JITED_SIZE, PROG_TYPE, ATTACH_TYPE,
+		STACK,
 	},
 };
 
@@ -688,6 +695,11 @@ static struct stat_def {
 	[PEAK_STATES] = { "Peak states", {"peak_states"}, },
 	[MAX_STATES_PER_INSN] = { "Max states per insn", {"max_states_per_insn"}, },
 	[MARK_READ_MAX_LEN] = { "Max mark read length", {"max_mark_read_len", "mark_read"}, },
+	[SIZE] = { "Program size", {"prog_size"}, },
+	[JITED_SIZE] = { "Jited size", {"prog_size_jited"}, },
+	[STACK] = {"Stack depth", {"stack_depth", "stack"}, },
+	[PROG_TYPE] = { "Program type", {"prog_type"}, },
+	[ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
 };
 
 static bool parse_stat_id_var(const char *name, size_t len, int *id,
@@ -835,7 +847,8 @@ static char verif_log_buf[64 * 1024];
 static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *s)
 {
 	const char *cur;
-	int pos, lines;
+	int pos, lines, sub_stack, cnt = 0;
+	char *state = NULL, *token, stack[512];
 
 	buf[buf_sz - 1] = '\0';
 
@@ -853,15 +866,22 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 
 		if (1 == sscanf(cur, "verification time %ld usec\n", &s->stats[DURATION]))
 			continue;
-		if (6 == sscanf(cur, "processed %ld insns (limit %*d) max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",
+		if (5 == sscanf(cur, "processed %ld insns (limit %*d) max_states_per_insn %ld total_states %ld peak_states %ld mark_read %ld",
 				&s->stats[TOTAL_INSNS],
 				&s->stats[MAX_STATES_PER_INSN],
 				&s->stats[TOTAL_STATES],
 				&s->stats[PEAK_STATES],
 				&s->stats[MARK_READ_MAX_LEN]))
 			continue;
-	}
 
+		if (1 == sscanf(cur, "stack depth %511s", stack))
+			continue;
+	}
+	while ((token = strtok_r(cnt++ ? NULL : stack, "+", &state))) {
+		if (sscanf(token, "%d", &sub_stack) == 0)
+			break;
+		s->stats[STACK] += sub_stack;
+	}
 	return 0;
 }
 
@@ -1146,8 +1166,11 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	char *buf;
 	int buf_sz, log_level;
 	struct verif_stats *stats;
+	struct bpf_prog_info info;
+	__u32 info_len = sizeof(info);
 	int err = 0;
 	void *tmp;
+	int fd;
 
 	if (!should_process_file_prog(base_filename, bpf_program__name(prog))) {
 		env.progs_skipped++;
@@ -1196,6 +1219,15 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	stats->file_name = strdup(base_filename);
 	stats->prog_name = strdup(bpf_program__name(prog));
 	stats->stats[VERDICT] = err == 0; /* 1 - success, 0 - failure */
+	stats->stats[SIZE] = bpf_program__insn_cnt(prog);
+	stats->stats[PROG_TYPE] = bpf_program__type(prog);
+	stats->stats[ATTACH_TYPE] = bpf_program__expected_attach_type(prog);
+
+	memset(&info, 0, info_len);
+	fd = bpf_program__fd(prog);
+	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0)
+		stats->stats[JITED_SIZE] = info.jited_prog_len;
+
 	parse_verif_log(buf, buf_sz, stats);
 
 	if (env.verbose) {
@@ -1309,6 +1341,11 @@ static int cmp_stat(const struct verif_stats *s1, const struct verif_stats *s2,
 	case PROG_NAME:
 		cmp = strcmp(s1->prog_name, s2->prog_name);
 		break;
+	case ATTACH_TYPE:
+	case PROG_TYPE:
+	case SIZE:
+	case JITED_SIZE:
+	case STACK:
 	case VERDICT:
 	case DURATION:
 	case TOTAL_INSNS:
@@ -1523,12 +1560,27 @@ static void prepare_value(const struct verif_stats *s, enum stat_id id,
 		else
 			*str = s->stats[VERDICT] ? "success" : "failure";
 		break;
+	case ATTACH_TYPE:
+		if (!s)
+			*str = "N/A";
+		else
+			*str = libbpf_bpf_attach_type_str(s->stats[ATTACH_TYPE]) ?: "N/A";
+		break;
+	case PROG_TYPE:
+		if (!s)
+			*str = "N/A";
+		else
+			*str = libbpf_bpf_prog_type_str(s->stats[PROG_TYPE]) ?: "N/A";
+		break;
 	case DURATION:
 	case TOTAL_INSNS:
 	case TOTAL_STATES:
 	case PEAK_STATES:
 	case MAX_STATES_PER_INSN:
 	case MARK_READ_MAX_LEN:
+	case STACK:
+	case SIZE:
+	case JITED_SIZE:
 		*val = s ? s->stats[id] : 0;
 		break;
 	default:
-- 
2.47.1


