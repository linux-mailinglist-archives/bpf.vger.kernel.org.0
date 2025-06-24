Return-Path: <bpf+bounces-61348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95AAE5A6C
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AE2165C67
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BF421FF58;
	Tue, 24 Jun 2025 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFejN0EK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B21F5849
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734792; cv=none; b=JDk9CGGgHk1SU2hcxtVZDAJPNnEkd6v6O4YgN6oNoBvQEAfNjlD1sKD0O4ctvsPI/vmC/vHkgJBE9gwpQB49Pr3yzoLKR3GmcnsqeFyFnWF5Est9TKWcOozVKP0sX/rCwBZ5z/PKCCUNd3AC+XknLorAwL+LCeJ4yOsDr1EHYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734792; c=relaxed/simple;
	bh=+SywL4i1FXK6144IiY8WPrwQfHcovBgpqtZkb3Rg0TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUMdUJ5gBBhIiQ7pgTjTd4Ief6gFIn5uRqBdyhyvSHN33ggYW59BAkURm5qm713IaMxkIXhr5Yw3uKthS/aXnLqFqyuQ24SJ1n8Kr/LjQC/2GZ2dqmlSClTQfidEA2zUyjSEH08ArZBIfb3sztqHQ78ASX6nLtabj1isDnplJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFejN0EK; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ade4679fba7so925172166b.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734788; x=1751339588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfHKfiURsJ/MjgoWT7GCTInYVnEwlxZrub602vzqVTQ=;
        b=BFejN0EKy2s3dtrML//m1eu7GYJ9U4FfcE+s3dm147SOMK5rE8eT97mGfCoHbKU4SK
         VeXBoAnq9Lp8P7W9oV8OlU/+TBqkhfeJu5aNF/UXpxWQWsMMYx8t5cKvqFFIyDQwiVU1
         as9DXXSO5hcOdp7MYHmNwXRiRwqNDyojai7+UTJlG55rH8iTV3QAETcBkLy+WknoWFOi
         k1WNNH9V1I0+xQHaSn2qLhJDxi0TX0r3IE0Iaavx4L2NV74hkYm8VMn14gzE1KUw4DSr
         2sjQfOv+niC16szlku/MfboeUkFiLXWRcavee23mTcc4YyuumI7FfvXu5MOWpzURSyBZ
         C02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734788; x=1751339588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfHKfiURsJ/MjgoWT7GCTInYVnEwlxZrub602vzqVTQ=;
        b=AbCRlJcL2HXRn8NS8Ofdpx73JMoN35+t+B5Y2YyewI+rIAsESxLC3N8SQLZjNnCgWR
         hiy843sm2jfLLZR9dR2HKIdi/0+zFON3qBjc+jDulFASd3MPjgkL3oVL9O+vLB5k1/ht
         eDddv5TpAiMSYTbvuloK7+r3pPsABkqd/dwrCjb6ag1RHA2j2qfm2ouimyFR8V5nk6N6
         HQMcOPY5nPhoOLF0iZCD4FhDoAyKIhPCbQ/bJMf+tOoE7BZ0PG8MUHLoa2KIXdNYDkn9
         77jxq5sJHg4fNah6FW4uhoFh556UjwrPalLVnO29WBJNj0iysGB1T10FJQQbjff5/R1O
         kD9g==
X-Gm-Message-State: AOJu0YylHuHK4UuXTqWpt466s2BGJLWc3yZzdVK1RVsCeihCvYJNUfuO
	Ohj/az/5+U1Qub08MOy540KNjz5NQ8cIdGcX5UETf7yqFA//QrzpqDDkBBVjkTRdyDtxnw==
X-Gm-Gg: ASbGncusc52/Yz2Rfjbp6gl1TsfwdKuOI2wmNFevFjXXVnohin9tDHdoqyHb8UXEYF/
	c9SPdg0OByryK0rz2wxgxVmcfNHn3yxgFwR1MUo1a+Xl/9TNqCDtLwb40J5BxJL26/wsdzYt+MU
	XLUCROYuMY2/NE8aw5pmCwhTz8h1gd6FGM6TJVknrFStH9iF1KrHKM22Iui9vqiWoPuXw4zlHIp
	bTGKUHo1b+qDCLvNKDuZyJqo7XVjQtuAMtsI+4HIi5xZ+yjv0zQt4B6UqHavdnlCGj2zkjhJAWY
	SRBCqidNOa1It+HWVro50I+9iZu4OZ6ocI9KxMpPm9uFqdPMJJ0=
X-Google-Smtp-Source: AGHT+IErVvAmC1lWkdqzxsd/zTEttPlXH7dAiyl8Y0ZWlMV79/mXq2SfVTX3nb7yFgVenATJkMTk3A==
X-Received: by 2002:a17:907:1b29:b0:ad8:9909:20a3 with SMTP id a640c23a62f3a-ae057b41278mr1331118066b.43.1750734787953;
        Mon, 23 Jun 2025 20:13:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6fa0sm791495366b.123.2025.06.23.20.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:13:07 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 11/12] bpftool: Add support for dumping streams
Date: Mon, 23 Jun 2025 20:12:51 -0700
Message-ID: <20250624031252.2966759-12-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5472; h=from:subject; bh=+SywL4i1FXK6144IiY8WPrwQfHcovBgpqtZkb3Rg0TY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWe1cBJO8iiDYlcv2/cMIteqVRvetSjW3k3VYbU mw7DzvaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVngAKCRBM4MiGSL8RyryED/ 0WWLURAyIOa5YHKXEvhfoF1v6RqqrP89tSTr2ij7rp6XgGbMb0ecxluXmVzYsS1w6crcaGlEHS7394 wxVH+oLd5mreOI4I5AsW69bBgunYg1FGCSG2b23Y+y79VoPgVWl3nNZWGcbRAOS0gCo0UyL3mX+SiE lpg9wK/nb73KxuvlffEK1ZaoIQVsYLDTsQ47EvqVw0C4As45HplqQTtdSAbTUj5RD+NJOZIpQRi6bY uzZro60BFXnca34gNVepdImLhmjmnM/5R58Ylrt91FkDH1G7lLu9Vz66pfYUKxZttoRNJ7hV29XaFR e80CLAQFqr6Ed7sw95YzCkFiLL44ECkxJhrFAjBkReBB8ratHllAi28b2fO2EhVq9vhaPPuWe1DDpX 9ZaWQ7m29mQz6Hw2qiSVb9tSVjwA4sX5qr7MQalyJWcRglBLTVgUk7MvRDYWkUULzpl6FJ0zBoULxq gVYBqF7aTQHRnrMlCmlRDdt4jBxy+PfXt0kPdN2p6vjEzcL4L8vUuE5spcB6pwkxzZxSw4DK1rt09l MYKEqTR4G65WPxxGn3zUWFvMxVEcLip+2BQipMaIOes3nyDTcN18onbKseXKuTOTHjZNxPJ0xKi0Sx 5mcFNq09xoq65fp+Dg6flPepAb1Q4TfXGpJrWiHH9pVUxSby04x/tfcNx2XQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add support for printing the BPF stream contents of a program in
bpftool. The new bpftool prog tracelog command is extended to take
stdout and stderr arguments, and then the prog specification.

The bpf_prog_stream_read() API added in previous patch is simply reused
to grab data and then it is dumped to the respective file. The stdout
data is sent to stdout, and stderr is printed to stderr.

Cc: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpftool/Documentation/bpftool-prog.rst    |  7 +++
 tools/bpf/bpftool/bash-completion/bpftool     | 16 +++++-
 tools/bpf/bpftool/prog.c                      | 49 ++++++++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index da3152c16228..f69fd92df8d8 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -35,6 +35,7 @@ PROG COMMANDS
 | **bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
 | **bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
 | **bpftool** **prog tracelog**
+| **bpftool** **prog tracelog** [ { **stdout** | **stderr**  } *PROG* ]
 | **bpftool** **prog run** *PROG* **data_in** *FILE* [**data_out** *FILE* [**data_size_out** *L*]] [**ctx_in** *FILE* [**ctx_out** *FILE* [**ctx_size_out** *M*]]] [**repeat** *N*]
 | **bpftool** **prog profile** *PROG* [**duration** *DURATION*] *METRICs*
 | **bpftool** **prog help**
@@ -179,6 +180,12 @@ bpftool prog tracelog
     purposes. For streaming data from BPF programs to user space, one can use
     perf events (see also **bpftool-map**\ (8)).
 
+bpftool prog tracelog { stdout | stderr } *PROG*
+    Dump the BPF stream of the program. BPF programs can write to these streams
+    at runtime with the **bpf_stream_vprintk**\ () kfunc. The kernel may write
+    error messages to the standard error stream. This facility should be used
+    only for debugging purposes.
+
 bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ctx_in *FILE* [ctx_out *FILE* [ctx_size_out *M*]]] [repeat *N*]
     Run BPF program *PROG* in the kernel testing infrastructure for BPF,
     meaning that the program works on the data and context provided by the
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 27512feb5c70..a759ba24471d 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -518,7 +518,21 @@ _bpftool()
                     esac
                     ;;
                 tracelog)
-                    return 0
+                    case $prev in
+                        $command)
+                            COMPREPLY+=( $( compgen -W "stdout stderr" -- \
+                                "$cur" ) )
+                            return 0
+                            ;;
+                        stdout|stderr)
+                            COMPREPLY=( $( compgen -W "$PROG_TYPE" -- \
+                                "$cur" ) )
+                            return 0
+                            ;;
+                        *)
+                            return 0
+                            ;;
+                    esac
                     ;;
                 profile)
                     case $cword in
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index deeaa5c1ed7d..9722d841abc0 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1113,6 +1113,52 @@ static int do_detach(int argc, char **argv)
 	return 0;
 }
 
+enum prog_tracelog_mode {
+	TRACE_STDOUT,
+	TRACE_STDERR,
+};
+
+static int
+prog_tracelog_stream(int prog_fd, enum prog_tracelog_mode mode)
+{
+	FILE *file = mode == TRACE_STDOUT ? stdout : stderr;
+	int stream_id = mode == TRACE_STDOUT ? 1 : 2;
+	char buf[512];
+	int ret;
+
+	ret = 0;
+	do {
+		ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf), NULL);
+		if (ret > 0)
+			fwrite(buf, sizeof(buf[0]), ret, file);
+	} while (ret > 0);
+
+	fflush(file);
+	return ret ? -1 : 0;
+}
+
+static int do_tracelog_any(int argc, char **argv)
+{
+	enum prog_tracelog_mode mode;
+	int fd;
+
+	if (argc == 0)
+		return do_tracelog(argc, argv);
+	if (!is_prefix(*argv, "stdout") && !is_prefix(*argv, "stderr"))
+		usage();
+	mode = is_prefix(*argv, "stdout") ? TRACE_STDOUT : TRACE_STDERR;
+	NEXT_ARG();
+
+	if (!REQ_ARGS(2))
+		return -1;
+
+	fd = prog_parse_fd(&argc, &argv);
+	if (fd < 0)
+		return -1;
+
+	return prog_tracelog_stream(fd, mode);
+}
+
 static int check_single_stdin(char *file_data_in, char *file_ctx_in)
 {
 	if (file_data_in && file_ctx_in &&
@@ -2493,6 +2539,7 @@ static int do_help(int argc, char **argv)
 		"                         [repeat N]\n"
 		"       %1$s %2$s profile PROG [duration DURATION] METRICs\n"
 		"       %1$s %2$s tracelog\n"
+		"       %1$s %2$s tracelog { stdout | stderr } PROG\n"
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_MAP "\n"
@@ -2532,7 +2579,7 @@ static const struct cmd cmds[] = {
 	{ "loadall",	do_loadall },
 	{ "attach",	do_attach },
 	{ "detach",	do_detach },
-	{ "tracelog",	do_tracelog },
+	{ "tracelog",	do_tracelog_any },
 	{ "run",	do_run },
 	{ "profile",	do_profile },
 	{ 0 }
-- 
2.47.1


