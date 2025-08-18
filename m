Return-Path: <bpf+bounces-65919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C891AB2AFF4
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 20:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235127AFBA6
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5932BF4C;
	Mon, 18 Aug 2025 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7jK0HGl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEE32BF22
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540273; cv=none; b=TDv3H3NBJqat/GaeQd3WB+0UfU8JJ8bLzcUUZ+DMhDgPJIcM/7sGQwALcLlHYR0TSYyLrdnSKyAWJOTAJIK55EB4dgQgJxfGjG4MZokc9rTkTtgM1k9iNNphRK+3WccrTcFlNQMpp1mfJx9o+TJlqZbBhimuQefsqVVt1l6m1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540273; c=relaxed/simple;
	bh=6X6ma/9SMEBwS9juJZE4JC5rM9jKbVDFqX9Gb2SFy2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSanyyayiOBsnvTzyZ9l9e6BDB1WEDQKmZ4xWT5uil+t7WVmkFn52OY7+i0NK3WGC+OicWrywm7cRLQvZREC2iycVvaHMG7fK3APSLqePE4ZNqsjl8LDdZqi3JcM5JCluXt5U4FWy00pIph/sjJbxj9a3VI7jVond/gS9T/kbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7jK0HGl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so2179586f8f.0
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755540270; x=1756145070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K8kKROMHCHEvVYRUXu0HCig/D+4kefPLHb+bH8XmyQ0=;
        b=M7jK0HGlotE8vZ4m7DqKnm54pbS6+vHnuunZjcyOAhYiyYjx1Ho5KVpwX0R44JhZar
         xOWib5FBYD4JdcQO0M7pGcJRLWMf0pRX2Wqm7TrBukkF0MWeAmZpCnHayxjxqTEXpjje
         DNYF8H4aJEi8zMiih25LJdCYgXfg7MhQ/1VnTXvxvt0wHLbsYxeJD2ZvLNs1TJn3Af8v
         XTeo3R8aAcxkEFNxsnSSqfukiac/qr54RpAmYpthkPFxXj65BV/wJs1dvmye0JAv+pPc
         cHw/ag9SJB7QNsJrp4uikeP2JyecSoVUx3cQXBlh0uv4O1Ed/587vorvCWyi4E/YI1lG
         6OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755540270; x=1756145070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8kKROMHCHEvVYRUXu0HCig/D+4kefPLHb+bH8XmyQ0=;
        b=w9ZdVS4GbFimXGgaSm4ysECDSQXA5k5pO1lXoMcdf9EIu2z1CsevhE63sBvtURILRM
         o3q+79j0V7ZsiGQip2rGC8XAo6WUR7Y/KP0XoMsjCMzEImml+a4gouLsm4OIgKMgQfiI
         0nXYS8NBkFwFNU70UTG5Z6XERelWIElA6mY+qpJ11ik+pR1IKl5abq1YfT6q3oLcxJTP
         vVxuxPr1tmUrgQECxed7q9GFlC3zf+Ta9blDw7fmG5qj0U7FaitHq3Ewyd1l2IkMSGWa
         ptyYKVk/6IYfhc85dBWky9UI25YaZdC3wUEAjWTI2pmcnHt/J9YanLpEY+DahNO/zS44
         mh7w==
X-Gm-Message-State: AOJu0Yy2WD4CGUcfQZxGUdJsTPAaQn1bq9RrfSsbXo1Bzkyq6ietxF2B
	LKYPxkcy8XjKUmEKBE/K7D8aEHYfEn9ZxJIHosihmbAt/viHP8LfqkGZa8+DXQ==
X-Gm-Gg: ASbGncvw5hxjXBBgY2ZunxJuJi0ymVXbQBbJzATdiyxO/3KlEKzufgivtECF6iWCTl+
	nvDMJvE6ugXhxyTo7Kf6UvX82BEXhdLcOzEEzmiCxdUT6HqLauXeui15ma6XKZ6urpyWej9jJGd
	QMwvOQkJpDnTUO/oW43hB7wszYBCS139S+3qBgIpL0lxxxQW8JrcYcsT2RFwV6jciuVWPmVCU5L
	opWewM2qYSV7yOt0iEnu0MtEIk1JeR2KK39xS8dbY6LAXO2sxyj0MRme5F9w43fWATxizHlgm/z
	RFIviKilEyxXQYEaVypLx8a/nCN999iZDlNp2+Lhda2GWxaPxDMnPl0fOMCaQ2dnOnxZEe6g+U3
	XoTpI+O+xVsfohvjnBFfG
X-Google-Smtp-Source: AGHT+IHn2cxSPkkxXNuri4xKbUHF+CDyzP0GXedYYUwtgNrRo8fYzay83Pmj+6+jqpvpbhnCsm+BLA==
X-Received: by 2002:a05:6000:400b:b0:3b7:8914:cd94 with SMTP id ffacd0b85a97d-3bc6aa272c6mr7532134f8f.41.1755540269386;
        Mon, 18 Aug 2025 11:04:29 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b78fed0sm102844465e9.1.2025.08.18.11.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 11:04:29 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] selftests/bpf: add BPF program dump in veristat
Date: Mon, 18 Aug 2025 19:04:24 +0100
Message-ID: <20250818180424.58835-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch adds support for dumping BPF program instructions directly
from veristat.
While it is already possible to inspect BPF program dump using bpftool,
it requires multiple commands. During active development, it's common
for developers to use veristat for testing verification. Integrating
instruction dumping into veristat reduces the need to switch tools and
simplifies the workflow.
By making this information more readily accessible, this change aims
to streamline the BPF development cycle and improve usability for
developers.
This implementation leverages bpftool, by running it directly via popen
to avoid any code duplication and keep veristat simple.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 43 +++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index d532dd82a3a8..3ba06f532bfa 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -181,6 +181,12 @@ struct var_preset {
 	bool applied;
 };
 
+enum dump_mode {
+	NO_DUMP = 0,
+	XLATED,
+	JITED,
+};
+
 static struct env {
 	char **filenames;
 	int filename_cnt;
@@ -227,6 +233,7 @@ static struct env {
 	char orig_cgroup[PATH_MAX];
 	char stat_cgroup[PATH_MAX];
 	int memory_peak_fd;
+	enum dump_mode dump_mode;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -295,6 +302,7 @@ static const struct argp_option opts[] = {
 	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
 	{ "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines" },
 	{ "set-global-vars", 'G', "GLOBAL", 0, "Set global variables provided in the expression, for example \"var1 = 1\"" },
+	{ "dump", 'p', "DUMP", 0, "Print BPF program dump" },
 	{},
 };
 
@@ -427,6 +435,16 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return err;
 		}
 		break;
+	case 'p':
+		if (strcmp(arg, "jited") == 0) {
+			env.dump_mode = JITED;
+		} else if (strcmp(arg, "xlated") == 0) {
+			env.dump_mode = XLATED;
+		} else {
+			fprintf(stderr, "Unrecognized dump mode '%s'\n", arg);
+			return -EINVAL;
+		}
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -1554,6 +1572,26 @@ static int parse_rvalue(const char *val, struct rvalue *rvalue)
 	return 0;
 }
 
+static void dump(int prog_fd)
+{
+	char command[512];
+	char buf[1024];
+	FILE *fp;
+
+	snprintf(command, sizeof(command), "bpftool prog dump %s id %d",
+		 env.dump_mode == JITED ? "jited" : "xlated", prog_fd);
+	fp = popen(command, "r");
+	if (!fp) {
+		fprintf(stderr, "Can't run bpftool\n");
+		return;
+	}
+
+	while (fgets(buf, sizeof(buf), fp))
+		printf("%s", buf);
+
+	pclose(fp);
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1630,8 +1668,11 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 
 	memset(&info, 0, info_len);
 	fd = bpf_program__fd(prog);
-	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0)
+	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0) {
 		stats->stats[JITED_SIZE] = info.jited_prog_len;
+		if (env.dump_mode != NO_DUMP)
+			dump(info.id);
+	}
 
 	parse_verif_log(buf, buf_sz, stats);
 
-- 
2.50.1


