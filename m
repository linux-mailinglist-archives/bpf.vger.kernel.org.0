Return-Path: <bpf+bounces-66000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33746B2C0D2
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EB31BC733A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08FE32BF55;
	Tue, 19 Aug 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2D75BiT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029C32BF3B
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603828; cv=none; b=SWOBPdKEd3oQBhxBcbce83UzRmsnmGmSBm8giYnW7daALsoZeOu5OT0fzyNJSmq+3yed/vEMAc9ElBJ3+HGZLPZjtv0V/2DkaL+q9dZE+ur/XMooarpL+MwxHMBa0OmBhyWib973V6LPLBi94jEyGGtS0TI26GuCQnMwxrygFQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603828; c=relaxed/simple;
	bh=dkqCUznKgep3cOyVvACShFWjBJMXeAixkxK5IioNqbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=socU5ABhq6IlBTcgpIJxIQ1N0VOtPRk+Xhont8LBWMprICH7l6f5+PcojOnjHdHOj73I9Kglrw4kOmzdTydrK/nNDsoLXMstGrojoApguiYKorsRUwNC+iyYiIAZbKkMjEE8hL/Jpm1an3Vv6hSHPN7uW+tGAxNIQxOYFQcqG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2D75BiT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9e4193083so4701743f8f.3
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755603825; x=1756208625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nbboTrM7JfxgzftW4IvVRhQ8xn7Vbb+d0BAmWTLtN4=;
        b=V2D75BiTZDsH0me5SRvx7ODHEpAb6ZwpwRMN6eXLcTecbRYZBkiZr54rd005O3a7A4
         KtIIR5XcTcwCvPQOPFM26KBi39Abz+aH5AWFhoe53ARIs61K3oHDT794J4VHKFgpmEmt
         0ZX/h2MKCqMfjTushw/CP+L8J+tkxq1plxWPPbH3G7n6kShYaGIn7iEgP88vej2BMvkY
         s/q6wFYyjXrZ63rOXSfXgMfAf1yvAgHKiuG2KScNg+LAyvNJkzDWZ5r42gvcrro961V9
         bIP3jxXc9/Nr0e2vrMlrgFHb9Q3w5LuDQFZmni+WWIx8/GG3Rz/lhSZsMl2VP38Re4kr
         YbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603825; x=1756208625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nbboTrM7JfxgzftW4IvVRhQ8xn7Vbb+d0BAmWTLtN4=;
        b=XySLykk0RDtZCJI+NvHVBLroNb77gLHHW0KJwu++Kkuj3VcWdgRDQgsYp7//bn9ncw
         N71Tlk1uF4NRPpoJA0HTzEMuigOU+D2JQbbQ4cH12ks0ynuFsqMa9dZ2SPsfyL7ktFgW
         E96vOvLNZF4oKkTfXZosHJ442YUBWP46fMO48jHzQjfaAwNEIrV/pYqWozBqmw+Z78g/
         3sJVc1sd6PttVfpAnHN8bdmidNPuGn9/FFlNRQBdDAaFs2+VQLo6Ew5lxSKMgFz6Vd5y
         DIkdboTn7xJr6mMfLfUZatkKxVZfdGTk2GpkihzFdJ/C7MvZOrVhqb9iAgK7O1P64Akz
         FxDQ==
X-Gm-Message-State: AOJu0YyqFT3brmyysmi5YG/3q5leYVcMBL+y/ubs/qjl311DmHyUH4Fw
	wBirHNNRf2TysqeBUtuwz6QtNUzajl0NgWvwempuxCXswTeINvjpDESPABJ4Gw==
X-Gm-Gg: ASbGncvkLtg02bolTblMNh7xJlnrZ7azjkXUOWuew+Qi3DgLL3RwUzAZFsxhLe053B/
	DMNm8Fsqt6Ro23bPn4q00k67mY/dqz7u6AgATRZs6+Eonf+p9oOajUL9aA6Q9eYcUV6ANOlP65L
	HtvAcuz5LZAau6rA4T4OyrtiUZFttHbkgewFlwTlSRRZHrSpkJ/PCZTFIGMMEA3FcwYfiRBICuT
	Ho9cZqhT89QDk+OIkda7X1xZZcFiQ9LrsAp+WiQJxDNlzc/WyVRPre+KAfJ6QQ1+iZFsLKuHIpM
	pg+8Kg3SuTj/dFqFueU9jFiDOOxWUHnAG3Y4aenFE9PMxdqgZcRnIvrLrfOMVNs2UhZyAyMUuy5
	WZQ==
X-Google-Smtp-Source: AGHT+IHi/dEdJLBecJgheighRIzOTukGR5jeqyITHgHn0KmZUGh/1UYEiKKL9SaOP+RCuC2Nvj4ykQ==
X-Received: by 2002:a05:6000:4284:b0:3bb:2fb3:9c7e with SMTP id ffacd0b85a97d-3c0e2c89fbcmr1729720f8f.21.1755603824800;
        Tue, 19 Aug 2025 04:43:44 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:853d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1a12sm3342200f8f.34.2025.08.19.04.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:43:44 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3] selftests/bpf: add BPF program dump in veristat
Date: Tue, 19 Aug 2025 12:43:40 +0100
Message-ID: <20250819114340.382238-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/veristat.c | 34 +++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index d532dd82a3a8..a4ecbc12953e 100644
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
+	{ "dump", 'p', "DUMP_MODE", 0, "Print BPF program dump (xlated, jited)" },
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
@@ -1554,6 +1572,17 @@ static int parse_rvalue(const char *val, struct rvalue *rvalue)
 	return 0;
 }
 
+static void dump(__u32 prog_id, const char *prog_name)
+{
+	char command[64];
+
+	snprintf(command, sizeof(command), "bpftool prog dump %s id %u",
+		 env.dump_mode == JITED ? "jited" : "xlated", prog_id);
+	printf("Prog's '%s' dump:\n", prog_name);
+	system(command);
+	printf("\n");
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1630,8 +1659,11 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 
 	memset(&info, 0, info_len);
 	fd = bpf_program__fd(prog);
-	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0)
+	if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) == 0) {
 		stats->stats[JITED_SIZE] = info.jited_prog_len;
+		if (env.dump_mode != NO_DUMP)
+			dump(info.id, prog_name);
+	}
 
 	parse_verif_log(buf, buf_sz, stats);
 
-- 
2.50.1


