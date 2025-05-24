Return-Path: <bpf+bounces-58885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFFDAC2CE1
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A0E7AFD0E
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374271E32D3;
	Sat, 24 May 2025 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJRTdIvJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2B1E2823
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049546; cv=none; b=dVAGgHn5PdvSVcwt0Lu72J+FVIPutXl5j/SVkPWyyM4fGQuoRESPqZJEn5DkLsSSnH8i4Dt43qNWiyalo5wMb/9UOAprqVQCMObxI00zOCMesNq7cXdq8rz0ZWDOleGMug8Y0Om6YjE8pztjbkyhSgpcVt3+ItB9EZW0nQhPuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049546; c=relaxed/simple;
	bh=CyeNfK+Fl0YFpN91WYy9iWEjtvGgEGtiRaJYjEDsqYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgC/+8LSWChi/COA+06ghD3SVvdKp3mG4aY/fC+TY8CnkPtFvM1cUuHZhg1rL9Yy5H1y0czhjEGBc0VKIE0LLI5gtBbbPLdSgsSbUhsVMMANVVw5OYXuJXrKwOnkBH0CVG+Ovv+tlH45mt5pb0CJlhAZFdZPECFNiedWT/q5TJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJRTdIvJ; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43cf257158fso2746825e9.2
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049543; x=1748654343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyw7VIRc8gbYGe9odxX1qfAFyOlOHPOdrM3v2kE1vIQ=;
        b=cJRTdIvJhzz5AZ7bDP4un7ppZ3OCCCD0PJ5QqTp5oASLGeaCUAppYA2JTUALvtny0P
         SXeEPXVxw0EYlSVoqa2X6MLHgujzp4JF0eTWPR2YLq6T3Kkql4evNgPH+cHBk8oA5g/R
         2zd1/UvqZCdNcYcWxMO1UK6eHDCNkj6maoRtt1LkBkvx0g95T0/s6SX+caYTg3Q2nyMA
         RFYAIfupTICUO2Ptx1HUL+RVmC3XLu9PPcwl09ZBJR6zI2+4qNswfP3EoGc9FD4FQilR
         QqFmwEYDb+VDTYmq/elHu71ZIUC5EVqhbH46nbD00XscR+rEQW5baBpYmLSoAAoPVu1R
         z3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049543; x=1748654343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyw7VIRc8gbYGe9odxX1qfAFyOlOHPOdrM3v2kE1vIQ=;
        b=sNKRvfzsozqM5ATRIHkE53Ic3kMnvIW/2L1tzmvbgWqqKUbTidIWZIjIUZ8r3E821c
         Q59cuDCxxk/cabBtLkv7FCF224e5HTVV0sILYDKtm1ytN7TvZqhPuBc0CV5mDg5NW1/A
         mYcU9iyra5ehL8to18NcOwcGOQaIoXxeO9p3PvsKGG++O6szEnKUT44dALZ3o2b+4g0I
         qWD6hl1Pp+TYU6ey4nd/xxdVXfSxIcUYoqMQsVT9gpTKBFxtfNqTTfE5w0e6es+eWfn4
         +wEqGUL0ge2FsB2iXVL0vAuXnCGz2qyEeBSalgWlR5ulWwlkJxL0TtbBsTbMT7uOaJSA
         fCOg==
X-Gm-Message-State: AOJu0YzCJs8hW0K94Ij4XcGXPyisOojC5bvbP+t/utPpfpmwZYBbZ4MZ
	JNLLoXJcN14pjlLVvNcTH/NRwdbqy8dFJDv0agStuQlrORb2piusBneld0982yUcNqA=
X-Gm-Gg: ASbGncv5wZINYWwlX7w12TNo18+JDuRIHBAa7x+aTuOQ7Mlj+GO8QOgBLf9kUo8KzAK
	Oz4FvnJaQfHWH7S2RxpJfGEs31xMbrIllSEz2W5urG4W1kT7+RnNyw5n2XJnADYHoz6tOqAi2mH
	Kd11SwBR3SmUBHYZCHs7osbOWPpIoOoAdpfNKiDo5P9tp4AKHS6JfcG9SllWk//eceysp3FFahB
	d4kqod58tp7ZSgkydPMmNI4YywOEowokKDvn6s8GZz6JA3M0RM/OgdOdyYU3to6gr8iCyiJfVF0
	47iG5NrA2VhzzK0OIVzi3cM4as3stPczMVrU8S58wQ==
X-Google-Smtp-Source: AGHT+IEvqJbcEci9+7v0HTHMPBTeeJTIMOH1WmnVJiYpje0EniwGeLCqUnBPabegAwVi+V8jL7EDJg==
X-Received: by 2002:a05:6000:184d:b0:3a2:595:e8cb with SMTP id ffacd0b85a97d-3a4cb47436fmr1234146f8f.45.1748049543029;
        Fri, 23 May 2025 18:19:03 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:46::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a368136014sm24210365f8f.92.2025.05.23.18.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:19:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 10/11] bpftool: Add support for dumping streams
Date: Fri, 23 May 2025 18:18:48 -0700
Message-ID: <20250524011849.681425-11-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5481; h=from:subject; bh=CyeNfK+Fl0YFpN91WYy9iWEjtvGgEGtiRaJYjEDsqYA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3QK2ZtI3XYiEOSyhxuwK/edYPVSFUXuRWa1q8H GHAfnByJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEd0AAKCRBM4MiGSL8RymtfEA CelR5cJI+jFQOSQLy5IrBsNvRa7U+Sg47TbArfyGevGp2VlPFRuwRjvmdBZiZ04UefcdwB7BdicfKW 8lFUo3yCx5SfN7sDX77yg54xApNf35By+r7VRwlo7AHG7kkDOOQGzQRQCOMxEJohrhz5icyj9z/Asj 6Q75+LEuzQT67DBiuyK5BwPgFjwrI4l1f5tgoPjUdQUtLwIKXW2UWC8nfcLwgSfRpSKH+NyDSixZAG 4rD/eL3yYWO/Tc0P5OZWLEnlCJtXpnuGwtrEDSvMguHzK8dc8Y5UUFJ0yFFHhX9YRam5GBvYbM1m4+ KNVYKKriK3kj8FtJRWLByfXz+asZZs8sRNtNPYhLA2GeE9Pvqn73icJwJYtOcuQbnAHmAeM8obTmzA bOnH1NJGS+sXojV+7yqC6FK+uEgYSKl8Sw00yuZ0TBxz/dbQTYJXswDqauc2IT4Cu9f4qimE97nI9e ArpzwlLR2jeOc85REpj88B5YGJwGUAlwGrBrp2oGCx1TgfJNCon/LW92erz+Hn8gkcnhEF/H1UWrSp kNzUPvb4QeC2lqp0oAj7g+sLAdQKwULN9ldNRcmzw+NqAubgQT7fws+12ZlEkOaYvkbQNbsCqcSSn4 9rnuqNDfMQpCn0NC4DHnCbY+Gz+trqGewnWFLkvnFsxFIYBThVoqTp/HdOhA==
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
 tools/bpf/bpftool/prog.c                      | 50 ++++++++++++++++++-
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index d6304e01afe0..d8aaac9363f3 100644
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
@@ -173,6 +174,12 @@ bpftool prog tracelog
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
index 1ce409a6cbd9..c7c0bf3aee24 100644
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
index f010295350be..3f31fbb8a99c 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1113,6 +1113,53 @@ static int do_detach(int argc, char **argv)
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
+	static char buf[512];
+	int ret;
+
+	ret = 0;
+	do {
+		ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf));
+		if (ret > 0) {
+			fwrite(buf, sizeof(buf[0]), ret, file);
+		}
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
@@ -2483,6 +2530,7 @@ static int do_help(int argc, char **argv)
 		"                         [repeat N]\n"
 		"       %1$s %2$s profile PROG [duration DURATION] METRICs\n"
 		"       %1$s %2$s tracelog\n"
+		"       %1$s %2$s tracelog { stdout | stderr } PROG\n"
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_MAP "\n"
@@ -2522,7 +2570,7 @@ static const struct cmd cmds[] = {
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


