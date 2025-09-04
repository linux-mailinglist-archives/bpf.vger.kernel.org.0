Return-Path: <bpf+bounces-67493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D71B44681
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 21:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28A4A43A6F
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688F326C3AC;
	Thu,  4 Sep 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2nzdJJF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F626E153
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014628; cv=none; b=PyBNLvh4nRSZqwTmMt3JeYDwNekhIbKTZGqOHtm60mhAS7u78cKAqfO8QEAF0ZGt8H4+1nuNMhZSKGrrodm6BgebU41NSZRNmtqbjFGbiBq0rUdG7PqNL/JNwVwvEEmJUptHGVRLVEnusrL7KFmgS7BBCCA7a8Q4t3TrPZYiJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014628; c=relaxed/simple;
	bh=sZE8WdY0uq8fKBK7qi9OLLuVjJjsBJoi/NuVYfuSxG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiBfpc/APiwlPfzoeKimdECfGNzunmNRlQnRVDBzuqfUkG6HwMyod585eK6fooXVwPqVhoNHDrRRMcJI0QDnYHpAVewAcu1uURfglhjjBOJ3xpkS3Uat4MHHVlJPfA21ZE03q3MQI58Dtm2WlAdlrR39fGNStUOw3uhZGlvXpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2nzdJJF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so443627f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757014625; x=1757619425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt3Fucqx9vMz982b51ikzmclvFkLG2i5s/NnMv8+/Lo=;
        b=Q2nzdJJFkZPzSSJHFHwMkR+tPFnrhYvHH1BfTT1289WlHTFpkwvQo79RnIeU2kC8Kt
         S0p8WSzbNq3DRSXEeYjXdKts+qhCqZLTN/xWDkHiL4g4JIoRZ0tGBN6cZKxm3a7Cvacb
         JiWlumXr+ZrjibQKk0oo1yuajBlnFr2wjACla+o82EaGzzH2RPXn7e+sPU4PSRyzQbmt
         jmZCz1dmSvFOyG848+9QVhxdGASB4z4sf7brX/xD9/bJ3at0/GMbVaPuNblaaL2PmnqW
         MDDjS61FBr4yoX6yyPAYj3sjKVrUuwHXa5tn/tPKyhQldwaZ5F7//47V12V1A+GsADMb
         wB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014625; x=1757619425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt3Fucqx9vMz982b51ikzmclvFkLG2i5s/NnMv8+/Lo=;
        b=qZGDpu2hqxgJhE/3BXNLQUrCReMV1dUlfUnN8IHGWOZX8iEsGMkZm1tOeOkp2cPI+H
         Tl8W2FsWzP0sB17dhNDGQWCmSZz2Bl5v7phzUIND7bigT9XmQNLiSrJQU5NYyvaDwm7W
         EwJ0oT/VrXtGinE0YcpwAmcGF7tORrdRrjqW0yaiT+Qz8MpgPV8Yd2bNY6ET4pGihdoP
         KRV3G3qZiou/2oQYhtol97yi3hwnOTbytGTTLnCQzwjQkmelkdlz9xv406c+K2DKbpP5
         Pm8+xLy2gmiBDsG5VEIKBLdl2i6yFzbCrbW5k1QE/Ctm4x3De8j0kw62mkRJ4jgz8WEx
         Qd9A==
X-Gm-Message-State: AOJu0YzWvj0nhVaVv7cAAaOxo01F0Nyw8JaA5nluoflu2Tt1qRmnZc9e
	MjvOUodjM/kM5SyWjvj5mVKuITc9Auo9d6oTfqqXFhLf5733vxKUTPNw9lSJ3A==
X-Gm-Gg: ASbGnctxrrJ2oAfAQj0Eg0wEso2YjRcg7ZrUIM8PDC9Ex8Lbiph/RztBZiGBs6gtHot
	X8GcUMX0aV+eg1XOVf1v2K1Bx2tRs3kwUrFYkBXGIb2vvmkDrTy2yV5eUIG0V5Q88v1Tbp0WW2J
	SCTe6ztgW/ifpYF/nDx3RNHTILsd2ajOF1P3NZdS2Bxw2fRGzKLRGmeSOG+kY70QrOkDBTQ+s4F
	8PNqMaCpFW9H2Il/v54nU7o501kZGn77azVdQhSwSjJFEa1NKxPgZ1XSH7TeqMUCElmtM/MzwSf
	61E7C2nKwP+vVP+ZOwIN+3oMWwdcB2fdTmiNn4j9zNv6PYStFSCE0MVJVFSrMKaPGSZ8OUUOVxa
	zXw==
X-Google-Smtp-Source: AGHT+IF2kDsEGIXt8cQVaxMAbvORXtAN3zZ7k8xJiDd8oIXN6WAsybLsymVig0zH7APLTXdL9JPP8Q==
X-Received: by 2002:a05:6000:26c1:b0:3c2:502:d944 with SMTP id ffacd0b85a97d-3e2faa20867mr778765f8f.0.1757014625195;
        Thu, 04 Sep 2025 12:37:05 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:217c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e23d29bb9esm2112989f8f.4.2025.09.04.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 12:37:04 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v6] selftests/bpf: add BPF program dump in veristat
Date: Thu,  4 Sep 2025 20:36:49 +0100
Message-ID: <20250904193649.1296718-1-mykyta.yatsenko5@gmail.com>
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
index d532dd82a3a8..5bb6bdf86041 100644
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
@@ -1554,6 +1573,55 @@ static int parse_rvalue(const char *val, struct rvalue *rvalue)
 	return 0;
 }
 
+static void dump(__u32 prog_id, enum dump_mode mode, const char *file_name, const char *prog_name)
+{
+	char command[64], buf[4096];
+	size_t len, wrote, off;
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
+		fprintf(stderr, "bpftool failed with error: %d\n", errno);
+		return;
+	}
+
+	printf("%s/%s DUMP %s:\n", file_name, prog_name, mode == DUMP_JITED ? "JITED" : "XLATED");
+	fflush(stdout);
+	do {
+		len = fread(buf, 1, sizeof(buf), fp);
+		if (ferror(fp)) {
+			if (errno != EINTR)
+				goto error;
+			clearerr(fp);
+		}
+
+		for (off = 0; off < len;) {
+			wrote = fwrite(buf + off, 1, len - off, stdout);
+			if (ferror(stdout) || !wrote) {
+				if (errno != EINTR)
+					goto error;
+				clearerr(stdout);
+			}
+			off += wrote;
+		}
+	} while (!feof(fp));
+	fwrite("\n", 1, 1, stdout);
+	fflush(stdout);
+	goto out;
+error:
+	fprintf(stderr, "Failed to dump BPF prog with error: %d\n", errno);
+out:
+	pclose(fp);
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1630,8 +1698,13 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 
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


