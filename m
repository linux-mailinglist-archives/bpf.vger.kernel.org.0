Return-Path: <bpf+bounces-46178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8EE9E5ECE
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 20:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384771689D0
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1785522577B;
	Thu,  5 Dec 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ9tFfzM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2921E492
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427254; cv=none; b=EXgXeucN5pwZDriYmBUSzw2q2VkwxIciH0gx6qKMs/og1lBZrDcsNwRRySShE7eKW6mGVDOIUYioe5w1s+VgGGiMSWYFqJMo39viRcHiPgxuUxVxzgw2kuvTkhtbH1Gagf+mZyb99hzSUuhAJXI7e2lGXprzQE5yFhNBPHfTF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427254; c=relaxed/simple;
	bh=dvQu9oAf+NEofjCok/8IinkRcqBbBsazLiD9NSRtZx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wzy/lZwiTieS8eQBIOi49bW843Q9H6XX6N7YjlU2vutQQpKMpYfPguQKOBJ7imuqEGMMN9lySdjPq5eu3tR4teqqIdounLj5GoA+G1pS8yCmVcmS94OwmkUtkY+KroW30bIhu1PvTNoAl/Q2vk1eTQHYbVajYx+uoLzCRnS7WCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ9tFfzM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa629402b53so148570466b.3
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 11:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733427251; x=1734032051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0x6D2qcCTwYQDAwRUTeJ9zBzcUX0GmIopK74pO3ReAo=;
        b=MJ9tFfzMpeCyZQHW1yLfD+5aLXcTutIER3/UhcUI6Z6zKuMZX2r/SHGoCGfA4IK/Aq
         3G6ihANxyIejSIJDYAnGCaqlG8RVul+EazqoN+OxKEdOkS55aUX5I5Xbf8eQYZZGBfCw
         /hONwQx6DHp1G9lo4p5sVQmwYLX+c9AMB0dpN5cB8nJ70qHrF1v74thKeMd6XRP36IG4
         LZoBTPMOqVvXzzaCEDvan1VBkorz55eNMUpgcUXKC+vqnNPF93LJCRZhnD5LUdf47jd9
         OyLODCgzlzKOzzc/9mCvOwGtV1+cjj/oR3z7F+0KnU2Mhis75+wVXw1r28O0DoLREgti
         p89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733427251; x=1734032051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0x6D2qcCTwYQDAwRUTeJ9zBzcUX0GmIopK74pO3ReAo=;
        b=Z8ziR0LOfXapzliLPOWrNjAascmZcX829VphwTOliJKpRpnjhDbkBjwA9CoGl9DQ4W
         d09TeaRay2aBXp8v5mZwF9Ch0DAVitDLRUJiJAG/uSAZjKFrDAAlUxaPXQxKsIrEVtEn
         8ucGDYRvlcKa9dz79lFswgKe9zacRQI4lcVNCVsZOZJZHLsilUil8e4l4AnYOSU6KP18
         KCj1b76F2b/vQ4YLjdrksLTEiKnarZmc3m7eWi3SBQdOZW4jVd7tRLzGTBh2sBGBQ+ql
         3oJiaML77SZ7eDxhxVpEZFAHVA6RK9dsZvT+l0kwNY5HHSfBx/t808vB+RHFKOI22sYD
         IeiQ==
X-Gm-Message-State: AOJu0YxcYd68aV0iBD4O2M198q3eEToLJwD0mCuUOoUGlsEqKikGoLsM
	B5SSdaMEWuC0AUiLqll6JQIIzS5R0rteyHCvljbKi5CNI0ZCfOaAqL/igQ==
X-Gm-Gg: ASbGncvzjmb+sOLiB/M3LDxaCOjixB29aPPYYlZEiixoudNKu5ymgbtqwLxpmZu9ePD
	sZAY3Rw6Ipz3TaRJY24Q7cO7/k6sCn4mYBhnkrlOUrm/O5MEaykwYgK/Mpesrb9K6ZialPiVhJr
	+G2D0zY0Q/8z9XoyTAmxt4ynY2xRDH0PoyS9ZDmQb1Fz8vvju6br/IIzgtgvXj8+sAX8voVCxZD
	ybCpgnODRj/vpYghq1fsg1e8+veIiwEqf4kSvujalTIl9VKOyKJlr/3iRWWG/ONAl6z+1ObyEi5
X-Google-Smtp-Source: AGHT+IEFicZjluUN+GhShrLT1Nx6ftjsa/2jGCZvL98MyEuMLPL+A1SjGraXui+Yf0m2OH1aYm9eNQ==
X-Received: by 2002:a17:906:3291:b0:aa6:25c8:e75a with SMTP id a640c23a62f3a-aa63a088c55mr4657766b.27.1733427250941;
        Thu, 05 Dec 2024 11:34:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:a302:ae00:6eb3:da82:a6be:6559])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e92a9asm132465566b.56.2024.12.05.11.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:34:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: add more stats into veristat
Date: Thu,  5 Dec 2024 19:34:04 +0000
Message-ID: <20241205193404.629861-1-mykyta.yatsenko5@gmail.com>
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
- jited program size
- program type
- attach type
- stack depth

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 51 +++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index e12ef953fba8..0d7fb00175e8 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -38,8 +38,14 @@ enum stat_id {
 	FILE_NAME,
 	PROG_NAME,
 
+	SIZE,
+	JITED_SIZE,
+	STACK,
+	PROG_TYPE,
+	ATTACH_TYPE,
+
 	ALL_STATS_CNT,
-	NUM_STATS_CNT = FILE_NAME - VERDICT,
+	NUM_STATS_CNT = ATTACH_TYPE - VERDICT + 1,
 };
 
 /* In comparison mode each stat can specify up to four different values:
@@ -640,19 +646,22 @@ static int append_filter_file(const char *path)
 }
 
 static const struct stat_specs default_output_spec = {
-	.spec_cnt = 7,
+	.spec_cnt = 12,
 	.ids = {
 		FILE_NAME, PROG_NAME, VERDICT, DURATION,
-		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
+		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES, SIZE,
+		JITED_SIZE, PROG_TYPE, ATTACH_TYPE, STACK,
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
 
@@ -688,6 +697,11 @@ static struct stat_def {
 	[PEAK_STATES] = { "Peak states", {"peak_states"}, },
 	[MAX_STATES_PER_INSN] = { "Max states per insn", {"max_states_per_insn"}, },
 	[MARK_READ_MAX_LEN] = { "Max mark read length", {"max_mark_read_len", "mark_read"}, },
+	[SIZE] = { "Prog size", {"prog_size", "size"}, },
+	[JITED_SIZE] = { "Jited size", {"jited_size"}, },
+	[STACK] = {"Stack depth", {"stack_depth", "stack"}, },
+	[PROG_TYPE] = { "Program type", {"program_type", "prog_type"}, },
+	[ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
 };
 
 static bool parse_stat_id_var(const char *name, size_t len, int *id,
@@ -853,13 +867,16 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 
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
+
+		if (1 == sscanf(cur, "stack depth %ld", &s->stats[STACK]))
+			continue;
 	}
 
 	return 0;
@@ -1146,8 +1163,11 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	char *buf;
 	int buf_sz, log_level;
 	struct verif_stats *stats;
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
 	int err = 0;
 	void *tmp;
+	int fd;
 
 	if (!should_process_file_prog(base_filename, bpf_program__name(prog))) {
 		env.progs_skipped++;
@@ -1196,6 +1216,13 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	stats->file_name = strdup(base_filename);
 	stats->prog_name = strdup(bpf_program__name(prog));
 	stats->stats[VERDICT] = err == 0; /* 1 - success, 0 - failure */
+	stats->stats[SIZE] = bpf_program__insn_cnt(prog);
+	stats->stats[PROG_TYPE] = bpf_program__type(prog);
+	stats->stats[ATTACH_TYPE] = bpf_program__expected_attach_type(prog);
+	fd = bpf_program__fd(prog);
+	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0)
+		stats->stats[JITED_SIZE] = info.jited_prog_len;
+
 	parse_verif_log(buf, buf_sz, stats);
 
 	if (env.verbose) {
@@ -1309,6 +1336,11 @@ static int cmp_stat(const struct verif_stats *s1, const struct verif_stats *s2,
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
@@ -1523,12 +1555,21 @@ static void prepare_value(const struct verif_stats *s, enum stat_id id,
 		else
 			*str = s->stats[VERDICT] ? "success" : "failure";
 		break;
+	case ATTACH_TYPE:
+		*str = s ? libbpf_bpf_attach_type_str(s->stats[ATTACH_TYPE]) ? : "N/A" : "N/A";
+		break;
+	case PROG_TYPE:
+		*str = s ? libbpf_bpf_prog_type_str(s->stats[PROG_TYPE]) ? : "N/A" : "N/A";
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


