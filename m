Return-Path: <bpf+bounces-62047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8CDAF0923
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7F5423149
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54A61DEFDD;
	Wed,  2 Jul 2025 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeB4nwW0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEED1DE8AF
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426281; cv=none; b=uVRB519/ZLc8YNyF8RT/Zt6FphOdYdAAHmXqMAI7bJcWFTbMiu41EW4ye4IaKwc/dIEujvDoEoWTYi1aVo0o4YSw1BRc2VRRvmrTEJ4PGJQiVVkN+DQ+1m+0SYWbNWLVe13eT4SQ1zHPcTff9L8ct8yyt9RLESdDy6gaTN73Mmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426281; c=relaxed/simple;
	bh=+SywL4i1FXK6144IiY8WPrwQfHcovBgpqtZkb3Rg0TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtwTyHQmG3/AegplgN8VHt7KWx69wQVMcMLny/c5HUcxqhfdRr46JC33a8NzrgdM1NHiVS28YKLpeVF6APFpXmrD690Fm0Z/B8kgujuy9GCpS/LQc1u+8AHc4zEQq/AJnJdBQ7LrujWa8ZZD3OXVeluVYztQoku/UaTf/UdZevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeB4nwW0; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo7007665a12.3
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426278; x=1752031078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfHKfiURsJ/MjgoWT7GCTInYVnEwlxZrub602vzqVTQ=;
        b=CeB4nwW0YzHjQ+tuYB7mq962e9QLO1hcNryQ7wSE3ML09v/QUeGuvKQ8xCFfAvGxn9
         dX/0WzX13pxXuI9UKXv3y6CjMkWc+jnXkM08e9DCsshneHMloZGsyMMIFZcVt2b/k2Fn
         JpTT6pQaKuBTkyjQfo27ZejG0bpeQV1pjY9x31P7MwUNM/0ftYb1KcB+ep5cM0IwnjHy
         7gY8vDe0wjVkqQ9F167Dq91q4qc/edrdke3JI1d6lhdDzpDm8e4gwXoOyGZyDGZEExQX
         uKY3bmcTFqH+5aASG4fu/Qe3gGIgpYogVk0E10i346/IF5kr9s0yYtjMxQXU4NOgOvBq
         KwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426278; x=1752031078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfHKfiURsJ/MjgoWT7GCTInYVnEwlxZrub602vzqVTQ=;
        b=m3kbnVwN5jabmIAyg5T5xmX764SQIjcC8LYtijDWdYv2EmM2k7MdkLRe3OJzWfaiKI
         hcN51zsaLPcIIqt7diD+27Dav9/fxumclLO/Jxi7UPVJMPO8VlgUnPx2d9M0F6GHbi2H
         njgNT3yNVg8uuhOpS14uXKffz5/3I6adc4aUVInEbGhOsBcT0Uln8maKLXMufWpOJ9Ee
         kM1P/nQRuw8x9R2ZgMJuRu+8G/+Ziso4szQHzlIvl6DqA17HreWpbyl8bpxaUsZlRM1r
         JRfchBEOhTeA1Tz9kj6p6eRuOGaPv4kbJShNcl4YKWxmNS+XTxYoQyX9l2sQWn6Gwb1m
         T0JA==
X-Gm-Message-State: AOJu0Yy/o4CqPGT+TCi+qFtiRKRoqO409eJY6zAtV+9rXpkMh7I28Sin
	ohouZ7OTXsHn7VObkpONe5NiTG3Il5gZyGiiDfpi+m1cMfwj5HfhwUoq9+gDJk7hssk=
X-Gm-Gg: ASbGncthB3UP4uLBI3yHUuEN4wYsJoHX4cBy2j+hOwJpa9cpQxE7f6JJvvTZhtljd0i
	+jzwoO1eaudm+uOuVOSr8i04TbAOx0XSQTVZFJ/Yes9PN+Nz+qnBXhpDkg66NhptRzn176Aw3oy
	dlBhOAj70N5uJAlVASvO2qkC+FtBaVuDSxo9LZsCIia3oIk4NNjnQ42y2eQwoSn5r8n82FU9qqn
	7KIZ6e1DVSecNmVmmn9IZEzm4EyLDBXY4cjhS6bCxV/QvZN0g1s6TmqvGhjao6/lUk9haKY6jFc
	gTjVq33BAjI7zHlO4OWIkSROMSy29pvURMm+j4zWutDzXpgvOxc=
X-Google-Smtp-Source: AGHT+IH+1bPhIhB/4rc/VZPmanwzGyFeHxisB25pPeY5nLG3J1ws9w06PwXUyw5s6mhpcadfaIrkNQ==
X-Received: by 2002:a17:907:7f87:b0:ae3:7283:b9d7 with SMTP id a640c23a62f3a-ae3c2ddb652mr106927566b.46.1751426277606;
        Tue, 01 Jul 2025 20:17:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363afdcsm979530666b.29.2025.07.01.20.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 11/12] bpftool: Add support for dumping streams
Date: Tue,  1 Jul 2025 20:17:36 -0700
Message-ID: <20250702031737.407548-12-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5472; h=from:subject; bh=+SywL4i1FXK6144IiY8WPrwQfHcovBgpqtZkb3Rg0TY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFR1cBJO8iiDYlcv2/cMIteqVRvetSjW3k3VYbU mw7DzvaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUQAKCRBM4MiGSL8Ryqa4D/ wIfIlSsJTsE8snCm7acfgPhf0LoHphqYbROJ5fY9PK3odYXpue2BaCIdK8LsyDEZnfIU1HYwn/7kBB J54R4IL15ZRDjvwOZzMxSGDBTqqfUDnR+TUzCGvhMg/vDxKobZrdgKMaxFqtMLinoPim2ri2Keof8K xDBJD5hAyglp2bCJEcmFwOah4LJwxQwLGrMxIeQ1hT5odh21b2iwI1JH+LI8dw3MAKInvXXnPHW6M4 4ZbKmBlVHiT+f8/UdaK8MARU6pk/vdUATcKGmAo6pAk3jLODba2lsM2yw+j5VsW3fs4SIq4na/ss/4 74KNMLc+FXw+/WCg4oQmndJ95DFLA//xlZixR1fDKArPbhAyPVGuVH0+llvDA+qt4nUcDmi0gboFH9 Rb0jDTBQfnlkLC8jIYn6twbktOQLVyCtJRpZs3bA4+uWd3JK20ICDHuNdCUhtDO/5ki7AEE7bvAkOc rEJ+rK4cVLyiI04IP0ecPHdlxUtgr7Jq7sCgmqY1Nzy2YM2jmNj6+fxALXg/viOPBCq4cNoSs49mNq QEKB+SAl2e4AMCiljAlFB3kJvgMLjvjU/iPVRu9n/mxpSOG3y8dsgTZmzlMq5qL0BRkDmf5LXyfgIL VpMyfpaHUBWKDVtKYpCeyqmV8lspLFpCHmqBA73HUrJ89gtZYXOPYLtP1PjQ==
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


