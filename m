Return-Path: <bpf+bounces-46270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE19E6F83
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 14:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537B8165436
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC57F206F05;
	Fri,  6 Dec 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWGDkh+g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1EB36126
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493080; cv=none; b=uJ7ZJpFXhoOBSPIFCfG6YwtMcZ78PJZvB8Lw7qInK4orM6dEElTFoIKtEPbbKBeisp4JEF2OlNNsYfWWuLnqx+WmqbtTuZnu9oR5Q6fb7feQzOlX1NdO4D1PGC7dSDW20LN/Ntw099jtJtWZrdziVr8rpJj/pNiI/ZYy1xOP1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493080; c=relaxed/simple;
	bh=flb9X79dVczEQtRy+EBWyvZseaZjWqP3zbiN8GfjliI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODWUsedJI/v8flMDtInJFqQNj6Lep8pNT9D8ywloLMfwBXioJGpNdbc0JXI6QFmCjwE8mQmRv6zb/w2iuvu+/O1FqZhObG2kWgSOktnaNMHT+ZVZmQFxcOrdxS9oxEp3ESgjSdzqkNMu+0pC+TEM+hp/DgxuQ8NJORXtRlL4Ahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWGDkh+g; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0bf6ac35aso2715087a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 05:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733493076; x=1734097876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uGKSR12r+zerPCTvf6AiC9ygtM26GAh4pdaRvq70OVY=;
        b=DWGDkh+g7NkdoooHjaT8BW9J+Ve/KI8gNi75PsEumKs1b3Q2eR4Ppm8YDGPSYqql5K
         UdFKc6s4Eu5Vt725tYLAmP/Fgwz4bySvY9bDi1U3kfW88lI9xgTlMIWvoWlRZSzoaKTE
         8HB+y96wg80l0MzDiahmBzLwu/RzJNnUjidy+MKOZL2bWmkR7nzglGWblEasaGFS7tsJ
         094p6indSp0L50GqmKzmP2ivRq6AV8TM5YLSV3U56ErQp2y2oTT957fpgTgea+GQt5KP
         Q+33Uma1Qwvw6NboIJJb5TY9wXI2sIU1jBzvLlQa1MldXxWcU//B0FP3YWwTjtLEAbpA
         Xd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733493076; x=1734097876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGKSR12r+zerPCTvf6AiC9ygtM26GAh4pdaRvq70OVY=;
        b=En18TZES23ZuzTM+5HHKPaNc4kShn0skw9k5f3/kx+7BNY/yUJOsbDzjDX37MIl6ZE
         DF7/mmHkjJCaHrY7qpejn65u8fto69e9tJTq5Oj5Wy9pQxNJjiCN76wJE0MpgZ4A84bc
         6zpCfRTmrow2fNuey9XFQfDBlENUGFeIxr8O5y145SFCc/uBeViV87encOOlPKIcvRzC
         aV6BZja4IAt56t8fEWhd+lwVwHmie9t0VXOAOghlM65Atr2UBcaJIv9XFfFcd6lNkK67
         jwsNiyP4nV8w+eDH3F9NdFFvq+Bzhea2wEjB5+/EkaLS3jqSSMJ6JQDPV1Qa+5g9Q4dZ
         BO/w==
X-Gm-Message-State: AOJu0YwnQwMMpnie9qxUs9Bf05TqoEGrfgAFTqPS6xoBtwlAq60+a5Wa
	mK9R+AMHH/WKt+BRRhe33VByDsQcAMyjj+mWbNJYB/unNUeRiaBBRLd9Sg==
X-Gm-Gg: ASbGncsT54R+YX98m74MwumfklIEIVxMomF+SLYZLZOaAUvBskWTBbsrE55EszPQzpS
	Wr2E+vaoFvckpYibolto+7rs8zzrFY67wcjfGpn52T3P+Fcp/NtBPCxPGsZ74JSpT+bBG87yVFf
	5UD+iCKAvZt+GZj3HaKoCvPbww2T0scYKeDh0cAjavxBIMAbTEnzrjcJwK9ahze3dmgWxPxr4lJ
	t3wCbHnexRR2DSi+LzeEvAlvMivgsAVCn29KhIVvzgAw47YdYZMuSacc5ReHIL4Qf2Fe5IpqQ7/
X-Google-Smtp-Source: AGHT+IEz3tqHfzi1Zc2IMuoDBm+aIpBECwsYOuuMutIho2brubCMWflO3g+yWu7IJkXurQMVUm/IYg==
X-Received: by 2002:a05:6402:1ec2:b0:5d0:cfad:f71 with SMTP id 4fb4d7f45d1cf-5d3be7215damr7635177a12.32.1733493075646;
        Fri, 06 Dec 2024 05:51:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:a302:ae00:6eb3:da82:a6be:6559])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260a35d3sm240937566b.158.2024.12.06.05.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:51:15 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] selftests/bpf: add more stats into veristat
Date: Fri,  6 Dec 2024 13:49:29 +0000
Message-ID: <20241206134929.89997-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/veristat.c | 68 +++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index e12ef953fba8..cda8c83ebf24 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -26,6 +26,9 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
+#define _STR(x) #x
+#define STR(x) _STR(x)
+
 enum stat_id {
 	VERDICT,
 	DURATION,
@@ -34,6 +37,11 @@ enum stat_id {
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
@@ -640,19 +648,21 @@ static int append_filter_file(const char *path)
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
 
@@ -688,6 +698,11 @@ static struct stat_def {
 	[PEAK_STATES] = { "Peak states", {"peak_states"}, },
 	[MAX_STATES_PER_INSN] = { "Max states per insn", {"max_states_per_insn"}, },
 	[MARK_READ_MAX_LEN] = { "Max mark read length", {"max_mark_read_len", "mark_read"}, },
+	[SIZE] = { "Prog size", {"prog_size"}, },
+	[JITED_SIZE] = { "Jited size", {"prog_size_jited"}, },
+	[STACK] = {"Stack depth", {"stack_depth", "stack"}, },
+	[PROG_TYPE] = { "Program type", {"prog_type"}, },
+	[ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
 };
 
 static bool parse_stat_id_var(const char *name, size_t len, int *id,
@@ -835,7 +850,8 @@ static char verif_log_buf[64 * 1024];
 static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *s)
 {
 	const char *cur;
-	int pos, lines;
+	int pos, lines, sub_stack;
+	char *save_ptr, *token, stack[PATH_MAX + 1] = {'\0'};
 
 	buf[buf_sz - 1] = '\0';
 
@@ -853,15 +869,24 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 
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
 
+		if (1 == sscanf(cur, "stack depth %" STR(PATH_MAX) "s", stack))
+			continue;
+	}
+	token = strtok_r(stack, "+", &save_ptr);
+	while (token && token - stack < PATH_MAX) {
+		if (sscanf(token, "%d", &sub_stack) == 0)
+			break;
+		s->stats[STACK] += sub_stack;
+		token = strtok_r(NULL, "+", &save_ptr);
+	}
 	return 0;
 }
 
@@ -1146,8 +1171,11 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
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
@@ -1196,6 +1224,14 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	stats->file_name = strdup(base_filename);
 	stats->prog_name = strdup(bpf_program__name(prog));
 	stats->stats[VERDICT] = err == 0; /* 1 - success, 0 - failure */
+	stats->stats[SIZE] = bpf_program__insn_cnt(prog);
+	stats->stats[PROG_TYPE] = bpf_program__type(prog);
+	stats->stats[ATTACH_TYPE] = bpf_program__expected_attach_type(prog);
+	fd = bpf_program__fd(prog);
+	memset(&info, 0, info_len);
+	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0)
+		stats->stats[JITED_SIZE] = info.jited_prog_len;
+
 	parse_verif_log(buf, buf_sz, stats);
 
 	if (env.verbose) {
@@ -1309,6 +1345,11 @@ static int cmp_stat(const struct verif_stats *s1, const struct verif_stats *s2,
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
@@ -1523,12 +1564,27 @@ static void prepare_value(const struct verif_stats *s, enum stat_id id,
 		else
 			*str = s->stats[VERDICT] ? "success" : "failure";
 		break;
+	case ATTACH_TYPE:
+		if (!s)
+			*str = "N/A";
+		else
+			*str = libbpf_bpf_attach_type_str(s->stats[ATTACH_TYPE]) ? : "N/A";
+		break;
+	case PROG_TYPE:
+		if (!s)
+			*str = "N/A";
+		else
+			*str = libbpf_bpf_prog_type_str(s->stats[PROG_TYPE]) ? : "N/A";
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


