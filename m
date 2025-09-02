Return-Path: <bpf+bounces-67237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAECFB410CE
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 01:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E13E16EDD6
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 23:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4631B27F4E7;
	Tue,  2 Sep 2025 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr5XxH4s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3F279359
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856128; cv=none; b=YJOX5V4+XQ4tedeRJb5u42qtnXLyp3O+Yo5IvLY9Gc53oqwpQejauFhflGg8/iztqayq/9JoMKv4iGIsNnHqYLQq7P0TYiieI9acy2ckRD9hO/aHQP+FUr4yBVtCcfwslDLUjzIdWb4/mW4XeXYSB0JWurTpaOUqAFEOpUPi6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856128; c=relaxed/simple;
	bh=Tzji6uW1YHUdfttGls+Xx4Ay9u/6IBabN25aoGu0rQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7aPaRYKoo3zBNvc1kKBULPGx7udJCED88VfJpID2ofT6FJ9LhBCe9f3dUT2dTGrUtyOAXXnLk81Vs3vP52JQZoxpVAuUtiMdzXPQJ1qGBg/AgNJY/MRVSUaZfD3gNC5dC6yo8yccmPiAAck2ZgS5nTct50KsQeo2qusRN7/7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr5XxH4s; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so40797265e9.1
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756856125; x=1757460925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+fK1vB36tzEFIw3XNBo644ZltjdgbBEAeFC987REN4=;
        b=Wr5XxH4s1hgXq07LJOUoHw4xLXQQc6sbxiCdRGCW869z5fV62SvMxi+ZIozo5SNUoZ
         7ubccoV4YTB7Pniq7ze6wXeb1tox819oSzAOQOdso775XOuzSTfcLfFi3pUKVldxzQsd
         pDTt+27e+kyCGtCpBocZeJOibCryg9tkhBGc8H2cLJWr55NACCG7TCHZmB+dZiyLUfns
         RWC1XyIjuSPk6/9ycZXUMQOao2HnnqfskNxcRnZ5mrMRYNax4ZNYBfP/ekxrZWwVnkbD
         6EDZfomEjnebwiMaZ0bV67QMkL7TJuN9IrqtrKhRRnASyUeLBOgqE2yhL1qgNIbwWglS
         3YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756856125; x=1757460925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+fK1vB36tzEFIw3XNBo644ZltjdgbBEAeFC987REN4=;
        b=OpYleHHp2ejSHlBezgHUIsAwmD82xoHHfDsDSbe2KNTO+C3EhIIeR4iXbUhuXnhDI6
         QhaK0i/ZLXMNQm+llimRpAd6PVQFX/GWijEfuNakEfBxL+ZwQYgSv8y+K6l6dhsRkDxs
         anHp0u85jgZf1PHw56W4HaYE85Cm74GX04tCkwKha/bFXPhMfnvoliMvDQZ6vgl8HuBP
         BCY3G5Fq70yC/R7Bq5NLUFm4FCH1O/SwEiSlGwviTEAy50tSpRoxeX1bt/0XFqa12Xoz
         HDzD3uzS7zjKT/+BSVlTzlovXIsv2zGlikQNBbmbxOYJ4AsyZT83yzo5mEGjfkFR3SHi
         nwcg==
X-Gm-Message-State: AOJu0YxuG6dNKKponiw+pHJaxwpPiXY5dwj0o9URkL3GzsnZNOizhALt
	/edzRaB/a+Q7/gKB0nDZDcIvYLL6Zbi0wZoA7B+7Su9t3PopO4Z+JF2bWjqkMg==
X-Gm-Gg: ASbGncsh9p4e9LnsQhFHymf0L+AgS+vqKZJ0tvZYakARGwnIEAu1dAcxGXm+sHe406Y
	NUXPFNmeL2VnWGTcuWHYA1XS+OYyHkabj3FNHlOd9QIQSwXx4LulL6OeuKE9B1aKkXSD7REUr7e
	0bqiLjXY3AJeCgs+0wq1JTNsX/06UbBjbVJAAfPd3sBQ0SKNvZLfhSyfIb4SXnxdKIVHcJUAVte
	HJga07tycKTioCdsVwogJ5ZTrPma1b2moKoOfflXNpYwpzxOytxyHcIUopzYIByXXwV2U8TSviS
	KeV9FrkP0N8kifqp6ad5QR/RRLngoH1xoc9fkWhAyG85w+wLsN0uUt4SJDnuXmq8I8XxH1jQPoe
	sIUYW9ywnMgCy+KJt/eyKu4K7WGFWMzY=
X-Google-Smtp-Source: AGHT+IHFBdK+WyHnLif3XKFwjd4MeyYbAq4HfocJrho0FlTvd/Urt52b98hD75P07xYdVGihv9TbBg==
X-Received: by 2002:a05:600c:3b01:b0:45b:88c6:709d with SMTP id 5b1f17b1804b1-45b88c67339mr88766505e9.25.1756856124924;
        Tue, 02 Sep 2025 16:35:24 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3db9b973869sm2372359f8f.18.2025.09.02.16.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:35:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5] selftests/bpf: add BPF program dump in veristat
Date: Wed,  3 Sep 2025 00:35:02 +0100
Message-ID: <20250902233502.776885-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/veristat.c | 69 +++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index d532dd82a3a8..e27893863400 100644
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
@@ -295,6 +303,7 @@ static const struct argp_option opts[] = {
 	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
 	{ "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines" },
 	{ "set-global-vars", 'G', "GLOBAL", 0, "Set global variables provided in the expression, for example \"var1 = 1\"" },
+	{ "dump", OPT_DUMP, "DUMP_MODE", OPTION_ARG_OPTIONAL, "Print BPF program dump (xlated, jited)" },
 	{},
 };
 
@@ -427,6 +436,16 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return err;
 		}
 		break;
+	case OPT_DUMP:
+		if (!arg || strcasecmp(arg, "xlated") == 0) {
+			env.dump_mode |= DUMP_XLATED;
+		} else if (strcasecmp(arg, "jited") == 0) {
+			env.dump_mode |= DUMP_JITED;
+		} else {
+			fprintf(stderr, "Unrecognized dump mode '%s'\n", arg);
+			return -EINVAL;
+		}
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -1554,6 +1573,49 @@ static int parse_rvalue(const char *val, struct rvalue *rvalue)
 	return 0;
 }
 
+static void dump(__u32 prog_id, enum dump_mode mode, const char *file_name, const char *prog_name)
+{
+	char command[64], buf[4096];
+	ssize_t len, wrote, off;
+	FILE *fp;
+	int status;
+
+	status = system("which bpftool > /dev/null 2>&1");
+	if (status != 0) {
+		fprintf(stderr, "bpftool is not available, can't print program dump\n");
+		return;
+	}
+	snprintf(command, sizeof(command), "bpftool prog dump %s id %u",
+		 mode == DUMP_JITED ? "jited" : "xlated", prog_id);
+	fp = popen(command, "r");
+	if (!fp) {
+		fprintf(stderr, "Can't run bpftool\n");
+		return;
+	}
+
+	printf("%s/%s DUMP %s:\n", file_name, prog_name, mode == DUMP_JITED ? "JITED" : "XLATED");
+	fflush(stdout);
+	do {
+		len = read(fileno(fp), buf, sizeof(buf));
+		if (len < 0)
+			goto error;
+
+		for (off = 0; off < len;) {
+			wrote = write(STDOUT_FILENO, buf + off, len - off);
+			if (wrote <= 0)
+				goto error;
+			off += wrote;
+		}
+	} while (len > 0);
+	write(STDOUT_FILENO, "\n", 1);
+	goto out;
+error:
+	fprintf(stderr, "Could not write BPF prog dump. Error: %s (errno=%d)\n", strerror(errno),
+		errno);
+out:
+	pclose(fp);
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1630,8 +1692,13 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 
 	memset(&info, 0, info_len);
 	fd = bpf_program__fd(prog);
-	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0)
+	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0) {
 		stats->stats[JITED_SIZE] = info.jited_prog_len;
+		if (env.dump_mode & DUMP_JITED)
+			dump(info.id, DUMP_JITED, base_filename, prog_name);
+		if (env.dump_mode & DUMP_XLATED)
+			dump(info.id, DUMP_XLATED, base_filename, prog_name);
+	}
 
 	parse_verif_log(buf, buf_sz, stats);
 
-- 
2.51.0


