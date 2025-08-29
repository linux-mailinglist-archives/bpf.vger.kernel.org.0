Return-Path: <bpf+bounces-66981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EDBB3BC83
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 15:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828B13B2FBE
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98F314B82;
	Fri, 29 Aug 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QphZIPv/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0D29D267
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756474113; cv=none; b=S9JePiXnYdKsbzxEEfMcU9BXkibRyGkQKQuZlaAwtuSo7pTorZnbAwYBO513N0wFK49zjCSdc8xu4iXbNQ7fANMNxz1PuZ0yDz5E89Mj4LSmlzrep/ki3CEvWzdS0jdrtDOdnzbAHAwEdGkvOFq6GZpFpVKp6qNvR8gfS/EzxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756474113; c=relaxed/simple;
	bh=m2w7J/BmEkKNK0Nfik2B9EcbF78wa0J9LOhx6vAmtsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VB25bUa16/x4zoElD6mKjwfQmwM2rXb7Zw6fJRNStPIpPGKgF6p2SACEL/RZGGs5R85FPjrdfML69BaG+pLgWZqsgGLRO/Uk3ljGlct1TPxqYJHzXhsjX0XHKEyfAPT5OJmagDMa3MRxcxEpBopjMvG427MZ8pxrAhMUBYmVoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QphZIPv/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b82a21eeeso3621285e9.2
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 06:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756474110; x=1757078910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17u74bjVCEa7IlbKmae/+ywIyEMnxWgnm4Z9JL0BgL8=;
        b=QphZIPv/1CGXmEUeqGdt4LKwGZ53mPMfTtrCLnT76MB7Q0qzkUrCxg0Qw7trtJBXjA
         Kq2pRxWbzCy+usoMqJGHoHJZ28Od4OIotoo2YFkhUxlAGpSX1qU8Jq57fSBI/I3ejMim
         3gZapIoYtm0n6CEZ8HMj2NySeZ0QvYJpi52QJxa6FuPS0OXmPvNSZHHhSSCBd6yTNXMS
         q7bNOix9dCU5fStfzbX2X39bvwaWcFEdGq3jKOmiXkeK4S27roM856fFeoW2gGfz3Ykg
         ByWKqgdn7qSaBkw3rIEVoA6sw0qv+vl+udxeeqdQmCwjNRVEN7oszRQM1IjjltL7r0t+
         7nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756474110; x=1757078910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17u74bjVCEa7IlbKmae/+ywIyEMnxWgnm4Z9JL0BgL8=;
        b=mb3x7zvbtdJYgEhExYwAuMsAScQoCpR/6GvAYAPB5eOCZmPURYN727KmrCuCz5hVyc
         qsROrSBQ3EGTFW2YdofyzH02rBD2FbAt/Zc7R0GlNbc6lALy5yVe1CVOtKAIuSP4uSmI
         w6R/w7pYYep/xDftXaQfXL+OL0/CPMEvzdp8fsfSmJBX8mkP3yeCURJxJ4NxFY58x13u
         dTEV1pzYgle1p4WI6Io7dfS2NClCoZvE/MqEcBjmZ9OpbbzyBX530aa1IZmUAJAcbZsL
         d4Djn+orGZpmI6C427PTzXKzrJSsqaTup/F8JP6+oL9Wr3URVIwRAqc6UOh+JTj+gV/0
         ddHA==
X-Gm-Message-State: AOJu0Yw1+zmGdnssUe87zYWMWsuMfVO/5SMTrBuQB0YypKuhuu4xILK1
	fQsLK17hdwsDRVrxw55z1eiw/FjPj8pLoKKs6Ii78HQ/KNHQSeTBVYjzh+hYTQ==
X-Gm-Gg: ASbGncvzv5QcdSuWs+jLcjKjy6ZWVpOgRKLLRKs3Ux0giy4OPy8BMI9b5MNyTCFaHev
	irE+378qBpo5WC+dIFONi/XFLspZAgU/zr/erFJT3TGwaScNNY7mRiAlRK/bXTgdW1mVQzDIAQL
	w0ASwrBuqtT8Bm5AYLuoR1cQXcvd1fETinZx21QQD6ZJv/aecOjdZI+juQGjkOSMU24DfRJyDjY
	MYsmi8MgzZvmfkz+cMdAUde2VGq3rwgO6IkGp+CAfkrWAb6bgFU0MAB2+Rc6ALRyv0AVnhmO9na
	RnWObEHDxOhipCelsi0aFT0Ba0RpRvEvMsgaFVccMdpAGfTnvPAjgtQj/dOk1Z2sXk+AvNcf4Hu
	jR4CJQf/i3TbM
X-Google-Smtp-Source: AGHT+IEa9FwJ3QxqADYmt946/45w5PacFuP1hzQakjYrZEba/1+cS2T3I1JdcQ3xOHoG9cy+gJIT9A==
X-Received: by 2002:a05:600c:8b85:b0:45b:581c:ad0d with SMTP id 5b1f17b1804b1-45b6211d560mr177193155e9.8.1756474109517;
        Fri, 29 Aug 2025 06:28:29 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:4e0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d204asm3428277f8f.24.2025.08.29.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 06:28:29 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4] selftests/bpf: add BPF program dump in veristat
Date: Fri, 29 Aug 2025 14:28:13 +0100
Message-ID: <20250829132813.105149-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add the ability to dump BPF program instructions directly from veristat.
Previously, inspecting a program required separate bpftool invocations:
one to load and another to dump it, which meant running multiple
commands.
During active development, it's common for developers to use veristat
for testing verification. Integrating instruction dumping into veristat
reduces the need to switch tools and simplifies the workflow.
By making this information more readily accessible, this change aims
to streamline the BPF development cycle and improve usability for
developers.
This implementation leverages bpftool, by running it directly via popen
to avoid any code duplication and keep veristat simple.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 75 +++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index d532dd82a3a8..c824f6e72e2f 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -181,6 +181,12 @@ struct var_preset {
 	bool applied;
 };
 
+enum dump_mode {
+	DUMP_NONE = 0,
+	DUMP_XLATED = 1,
+	DUMP_JITED = 2,
+};
+
 static struct env {
 	char **filenames;
 	int filename_cnt;
@@ -227,6 +233,7 @@ static struct env {
 	char orig_cgroup[PATH_MAX];
 	char stat_cgroup[PATH_MAX];
 	int memory_peak_fd;
+	__u32 dump_mode;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -271,6 +278,7 @@ const char argp_program_doc[] =
 enum {
 	OPT_LOG_FIXED = 1000,
 	OPT_LOG_SIZE = 1001,
+	OPT_DUMP = 1002,
 };
 
 static const struct argp_option opts[] = {
@@ -295,10 +303,12 @@ static const struct argp_option opts[] = {
 	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
 	{ "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines" },
 	{ "set-global-vars", 'G', "GLOBAL", 0, "Set global variables provided in the expression, for example \"var1 = 1\"" },
+	{ "dump", OPT_DUMP, "DUMP_MODE", OPTION_ARG_OPTIONAL, "Print BPF program dump (xlated, jited)" },
 	{},
 };
 
 static int parse_stats(const char *stats_str, struct stat_specs *specs);
+static int parse_dump_mode(char *mode_str, __u32 *dump_mode);
 static int append_filter(struct filter **filters, int *cnt, const char *str);
 static int append_filter_file(const char *path);
 static int append_var_preset(struct var_preset **presets, int *cnt, const char *expr);
@@ -427,6 +437,11 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return err;
 		}
 		break;
+	case OPT_DUMP:
+		err = parse_dump_mode(arg, &env.dump_mode);
+		if (err)
+			return err;
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -956,6 +971,32 @@ static int parse_stats(const char *stats_str, struct stat_specs *specs)
 	return 0;
 }
 
+static int parse_dump_mode(char *mode_str, __u32 *dump_mode)
+{
+	char *state = NULL, *cur;
+	int cnt = 0;
+
+	if (!mode_str) {
+		env.dump_mode = DUMP_XLATED;
+		return 0;
+	}
+
+	for (cur = mode_str; *cur; ++cur)
+		*cur = tolower(*cur);
+
+	while ((cur = strtok_r(cnt++ ? NULL : mode_str, ",", &state))) {
+		if (strcmp(cur, "jited") == 0) {
+			env.dump_mode |= DUMP_JITED;
+		} else if (strcmp(cur, "xlated") == 0) {
+			env.dump_mode |= DUMP_XLATED;
+		} else {
+			fprintf(stderr, "Unrecognized dump mode '%s'\n", cur);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
 {
 	int i;
@@ -1554,6 +1595,35 @@ static int parse_rvalue(const char *val, struct rvalue *rvalue)
 	return 0;
 }
 
+static void dump(__u32 prog_id, const char *file_name, const char *prog_name)
+{
+	char command[64], buf[1024];
+	enum dump_mode modes[2] = { DUMP_XLATED, DUMP_JITED };
+	const char *mode_lower[2] = { "xlated", "jited" };
+	const char *mode_upper[2] = { "XLATED", "JITED" };
+	FILE *fp;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(modes); ++i) {
+		if (!(env.dump_mode & modes[i]))
+			continue;
+		snprintf(command, sizeof(command), "bpftool prog dump %s id %u",
+			 mode_lower[i], prog_id);
+
+		fp = popen(command, "r");
+		if (!fp) {
+			fprintf(stderr, "Can't run bpftool\n");
+			return;
+		}
+
+		printf("%s/%s DUMP %s:\n", file_name, prog_name, mode_upper[i]);
+		while (fgets(buf, sizeof(buf), fp))
+			printf("%s", buf);
+		printf("\n");
+		pclose(fp);
+	}
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1630,8 +1700,11 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 
 	memset(&info, 0, info_len);
 	fd = bpf_program__fd(prog);
-	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0)
+	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0) {
 		stats->stats[JITED_SIZE] = info.jited_prog_len;
+		if (env.dump_mode != DUMP_NONE)
+			dump(info.id, base_filename, prog_name);
+	}
 
 	parse_verif_log(buf, buf_sz, stats);
 
-- 
2.51.0


