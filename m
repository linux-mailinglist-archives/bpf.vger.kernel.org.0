Return-Path: <bpf+bounces-67565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F70B45A15
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4511CC3170
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 14:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C677B35E4D1;
	Fri,  5 Sep 2025 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNqTRxwU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7D356902
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081322; cv=none; b=Vg+DyKz7W2mLLMmpFSeCr1nmJEnO/g70JGOTOefCrtA4Jvj5U2Gt7HEf8OqCjN75UPhrpPMOl2ZH38rZ0eHhn0HpsS5oNguAnD+l1WK8BTWlidgY12Z9BKbxNADtq8IqxBUnlJ4eLQKjULKsBg3ALKNzdtpcFsePI3G3K8kvvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081322; c=relaxed/simple;
	bh=ejbXKOl4RrJzvR5J7sIZYucuiOeEtKgg0aIslwhVNoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUoxJiDdPyJ9qVGwHxtNAKQiU3OAAAJMl+QwViZwXQ40ykrTVjwPzU4kppeUiKZU6uRMxzxZIBzfoW5+DicjQWAHqEIG9Lw9jeg2/qswlgaAthzffkjIdrGE1w7NqeKT7UUhnH69Cc5QCvSb2LjVPkmRhUMR5PZ2HpZSSBWGZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNqTRxwU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e07ffffb87so984395f8f.2
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757081319; x=1757686119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vnh7jtBP6w8GkPdrcuIFWQMC8ZqFnWcCMPq0NL2lcpU=;
        b=DNqTRxwUmu34GUygqFPXCJtNXnenMdLUuYmidAarob99dkHmPfncQdsmtrU14l6YAm
         4cpCXLpdpWCXVV6dBhsg75e3eGup2PoMxhBSMalPJfa9QXdN19eqRiT+gLKhgGTOY1zf
         qa2sQ0aKTGTwTzhrv89odws12DmdFJ8p3c2T8StYAuK8MOIkvfWn2cZyBYq/2rCuolu+
         ABXpaoIgIqthI/9CQDxGHRMO7DPFeCylJGVCmb9eUxQZZJsayqmHywqGEFfEnu2ydY8X
         WKNIftX9lk8Xh8OqDNc77O/eLbxrlCTvcfU4n+5VQcY7sKfqC/eVAmiyeKBikBvmG+t6
         Gitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757081319; x=1757686119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnh7jtBP6w8GkPdrcuIFWQMC8ZqFnWcCMPq0NL2lcpU=;
        b=CFaQvV4bybwQOeIQEtDMxndR4m1ELpFDcJLZdz1ICa0lsu3d5OclkrXdbzWceKFBto
         W7ZMVnppr8yPbqrMZ/zhFi4X9sSYujiXeJ6U9zJxgT9PlwsYixHV7fuqrwm8uQxZ28UN
         djg5IUuotfEaBXDbqMF6snuhXDMgaHBKz9S86ruubzwcOvSQI5hMdRU82Eg2asgE8yN2
         J47tgrbj2GtOO4naBgdaIeXTSP113jmTZo0ZQE+gHCMMfoIeUP2mx3h0aadOJ8XQDNQR
         F4+12e7oYD1OFHb8zwtWs2wrNDk6g+pGDAd4ZyIxlsrFciREo7QvFa+ZesLtMXkxNNBL
         P4FQ==
X-Gm-Message-State: AOJu0YywKx8DOuSc5OvLTjwZMo+HQaOFUnR8TFouxHD3mBsnY2d9zp6b
	7itboda1D9lRi6EwDtlOtwgtw/6ifE/s1kLiyOTLMGafx3Wrzxl4fHrw/mjtpg==
X-Gm-Gg: ASbGncsAWEBZuNsp1q6imxsjdNdfBtGTmb5Ipe+mJ+5F7VfenRo/3osNjRv4wEcSI+h
	3uXD0LxJr9syMMUR9v25OcBjDFrVJG0jHcwSwJeaJkZFfGd4x6VFzsWGPoUIkyHCNaFd/p6v18T
	Xh4p2dVhx5TqPTPFXE26gzWkouG0monPu/il5Kbtj21gbyYzaaVd9pPQfqCcf9e0qkJ5zZPQnRI
	zMZ2sKwj3XB0CQ0uDmat+n5e6H08/4OaMkRHh09Ij9REa6EfrhcrnfInBZT6B0MbA9+2JQEVTiv
	B81JzA2jrT952vL7WGmX+/81szg9hsm/yamNKfEsTmFiZzuOh8TjMFUROs34qZxkL8W1QqP6W67
	Z9dUVOOwbDDVHrK9HshB1PFACgfjkI3s=
X-Google-Smtp-Source: AGHT+IHLK2u69RpvdFdJiP3yMmhgx0fOcqDlhkU1omgz/MEGprkgIM+1ifwLCk8CQtUsWvgWjDA35w==
X-Received: by 2002:a05:6000:4403:b0:3d4:15a2:11e9 with SMTP id ffacd0b85a97d-3d415a21498mr10131030f8f.61.1757081318579;
        Fri, 05 Sep 2025 07:08:38 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0a1f807f9sm30830514f8f.38.2025.09.05.07.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:08:38 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v7] selftests/bpf: add BPF program dump in veristat
Date: Fri,  5 Sep 2025 15:08:35 +0100
Message-ID: <20250905140835.1416179-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/veristat.c | 55 +++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index d532dd82a3a8..85ae7f6fee90 100644
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
@@ -1554,6 +1573,35 @@ static int parse_rvalue(const char *val, struct rvalue *rvalue)
 	return 0;
 }
 
+static void dump(__u32 prog_id, enum dump_mode mode, const char *file_name, const char *prog_name)
+{
+	char command[64], buf[4096];
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
+	while (fgets(buf, sizeof(buf), fp))
+		fputs(buf, stdout);
+
+	if (ferror(fp))
+		fprintf(stderr, "Failed to dump BPF prog with error: %d\n", errno);
+
+	pclose(fp);
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1630,8 +1678,13 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 
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


