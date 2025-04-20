Return-Path: <bpf+bounces-56285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D628A94785
	for <lists+bpf@lfdr.de>; Sun, 20 Apr 2025 12:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278273AF4F1
	for <lists+bpf@lfdr.de>; Sun, 20 Apr 2025 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734601E570A;
	Sun, 20 Apr 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2zBdvGj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AC1E0E0D
	for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146569; cv=none; b=IUWUamo4uuCy2VNQV3ZVrB2tjoPzfNGGU2J71T5I2L9xOD0GLbUiz2EC2uXvNxP1hCi61a8jFOOsSyxbdIC0eyZ4ZOzObRhGrgtjdTAjoTJ986+MdO3wi33/dnfOmj7sB7F+H035ngJfPpV8MLngciQpex+D9nH7N7FFUL1tjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146569; c=relaxed/simple;
	bh=Hjw/si8/6UpYIIqiV+wShdHr6ktaRv3NfD7q2Dmmxa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnstG/gQywb+NglewD1FNcTL6YWUytb18b7nCr18QmlfiaULPilNAFipcnn7C0d5DSzQwnMGtlWO8AsRHsBquj5665oUQRjH/MpYQN4V/rnR3qdYLm56+f+Zanv+hQinWw9BkMOgVTaTPPZXDa1+0Aa0jztcmH3yXAuuBhl26Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2zBdvGj; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476a720e806so28942781cf.0
        for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 03:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745146566; x=1745751366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9tnsbtdRqh42D4kpVAB7LzejKhTV9IwvJWD0iGoO1c=;
        b=h2zBdvGjWOrudeDgXmHypq2edTI6jovMUp5D5JWMZamBJWulEd2PexNZhWq0EA88qk
         JOJfVwS4NS0WiS0wzDeBI5GSmIDdgypdxDwEHgFrZ/cb+1iKUDQUTOd+FqvEG0NK9wLc
         vMXc41WytKRtlk7+QafzsPsuL9d06JiUOK+n/8EIy9arY2DE4nniE2g64ymdz8XS8c4l
         MWdsLim2Uyw59LVqwssK1Vej5qqXips4Edax1k9U/CgNvIJ5hNzfZIBEH5rBiDzJAUIn
         q9CjNcH5B1kKJiTAcGI9UKEmtD4CCqwoggigIo6JhQ+pSRnY1Xvm+knslSHXoV1MToW9
         Czzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745146566; x=1745751366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9tnsbtdRqh42D4kpVAB7LzejKhTV9IwvJWD0iGoO1c=;
        b=RW/9hwctTQ2rM1CYzclpZs+L+PwulnAa8sNdQtxdKipL/lBaX7Lmuw2tcFh6K3a3Yw
         lOKol+I8rBprldxaCkU/SXiP8H/mMQvxU2nCzdex9R12WLJWgpUKulJst16hTorSzpJ+
         iiNKRp51v9m9621ozMjlB4pcqT3ksJ02fsWz4ZfGlgzlpV6BP7ZG7MDYJoi73pjfaYSd
         e2bclJv885UeQ5ZLNlmwZgZ3ZIn2NHIZ2goyIx3YeXIwLN26+DTxI4IsjT2rz07huPab
         X+zoGag7F3BqWIFZTyQgV4RMeBGOFjnL67CrGWRhomRjIlNQK1iKFpKYA1/JvBLbCImJ
         pyVg==
X-Gm-Message-State: AOJu0Yz0NYFigDmeK75YbKeeg7n5gCEr4YAtJwXi0DpVz7PhoffPOVgb
	GCJqFL5R4dospJ/4O+iHQWKrBpRRJiTPAH7gf0FPApxKfMrD86rKUsLlY1QA
X-Gm-Gg: ASbGncsZQBzbVuHeSYsGbk9ZzuiZdnrQdVszyu4Wk1sWD49dnYqsx5yia5I+m6FibED
	23SMZDbEds44qQGyabM2NL7qbLGf1nmI26lIedDVchE0ral0E5lyqopjab0ClK9vmjyEnHXiPfm
	Y7cax3so19iFyzxxAncfbxaP8CF1UNSDdv1bZrBFvH632MCI0LRTmGNyGwGps6nPmPRjC4PGDF9
	avLZ+rX4XZ8cwbDYMgrTEaynSRDG4RRcEt4iJSDHyH8qfvEWnMqx492nrL5CU59kCDVGvBK++xH
	vKGoLJVL8zaL4osl43Vh0woRGKYXNvhlTQKcfzO2aRw/Hoyq
X-Google-Smtp-Source: AGHT+IFBWHZc7Eg7fiq8BTG3MKe9iC8KqBTK9IrqUH5QHEfYtOe5UXaWLr9eChVWDmoAQr2iXuUFcQ==
X-Received: by 2002:ac8:5947:0:b0:477:c04:b511 with SMTP id d75a77b69052e-47aec3cbf5cmr137555561cf.31.1745146566081;
        Sun, 20 Apr 2025 03:56:06 -0700 (PDT)
Received: from rajGilbertMachine.. ([2607:b400:30:a100:a5e9:b904:d3d9:b816])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c4c608sm30851771cf.41.2025.04.20.03.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 03:56:05 -0700 (PDT)
From: Raj Sahu <rjsu26@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	sidchintamaneni <sidchintamaneni@vt.edu>,
	Raj <rjsu26@gmail.com>
Subject: [RFC bpf-next 2/4] bpftool/libbpf : Introduce bpf_prog_termination to trigger termination signal
Date: Sun, 20 Apr 2025 06:55:20 -0400
Message-ID: <20250420105524.2115690-3-rjsu26@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250420105524.2115690-1-rjsu26@gmail.com>
References: <20250420105524.2115690-1-rjsu26@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: sidchintamaneni <sidchintamaneni@vt.edu>

Introduces bpf_prog_termination API in libbpf to trigger termination
signal from userspace. Adds do_terminate functionality to bpftool to
use cmd line interface.

cmd - bpftool prog terminate id [] cpu []

Will split this commit to two (bpftool/ libbpf) while sending the
patches

Signed-off-by: Raj <rjsu26@gmail.com>
Signed-off-by: Siddharth <sidchintamaneni@gmail.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 tools/bpf/bpftool/prog.c       | 40 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 tools/lib/bpf/bpf.c            | 15 +++++++++++++
 tools/lib/bpf/bpf.h            | 10 +++++++++
 tools/lib/bpf/libbpf.map       |  1 +
 6 files changed, 76 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 71d5ac83cf5d..9b9061b9b8e1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -961,6 +961,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_PROG_TERMINATE,
 	__MAX_BPF_CMD,
 };
 
@@ -1842,6 +1843,10 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_PROG_TERMINATE command */
+		__u32		prog_id;
+		__u32		term_cpu_id;
+	} prog_terminate;
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f010295350be..77bf3fa10d46 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1968,6 +1968,44 @@ static int do_loadall(int argc, char **argv)
 	return load_with_options(argc, argv, false);
 }
 
+static int do_terminate(int argc, char **argv)
+{
+	int prog_id, cpu_id;
+
+	if (!REQ_ARGS(4))
+		return BAD_ARG();
+
+	if (!is_prefix(*argv, "id")) {
+		p_err("expected 'id', got: %s", *argv);
+		return -1;
+	}
+	NEXT_ARG();
+
+	prog_id = atoi(argv[0]);
+	if (prog_id <= 0) {
+		p_err("Invalid prog_id: %d\n", prog_id);
+		return -1;
+	}
+	NEXT_ARG();
+
+	if (!is_prefix(*argv, "cpu")) {
+		p_err("expected 'cpu', got: %s", *argv);
+		return -1;
+	}
+	NEXT_ARG();
+
+	cpu_id = atoi(argv[0]);
+	if (cpu_id < 0) {
+		p_err("Invalid cpu_id: %d\n", cpu_id);
+		return -1;
+	}
+
+	bpf_prog_terminate(prog_id, cpu_id);
+
+	return 0;
+
+}
+
 #ifdef BPFTOOL_WITHOUT_SKELETONS
 
 static int do_profile(int argc, char **argv)
@@ -2466,6 +2504,7 @@ static int do_help(int argc, char **argv)
 
 	fprintf(stderr,
 		"Usage: %1$s %2$s { show | list } [PROG]\n"
+		"	%1$s %2$s terminate PROG CPU\n"
 		"       %1$s %2$s dump xlated PROG [{ file FILE | [opcodes] [linum] [visual] }]\n"
 		"       %1$s %2$s dump jited  PROG [{ file FILE | [opcodes] [linum] }]\n"
 		"       %1$s %2$s pin   PROG FILE\n"
@@ -2525,6 +2564,7 @@ static const struct cmd cmds[] = {
 	{ "tracelog",	do_tracelog },
 	{ "run",	do_run },
 	{ "profile",	do_profile },
+	{ "terminate",	do_terminate },
 	{ 0 }
 };
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 71d5ac83cf5d..9b9061b9b8e1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -961,6 +961,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_PROG_TERMINATE,
 	__MAX_BPF_CMD,
 };
 
@@ -1842,6 +1843,10 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_PROG_TERMINATE command */
+		__u32		prog_id;
+		__u32		term_cpu_id;
+	} prog_terminate;
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a9c3e33d0f8a..0b9dc9b16e02 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1331,3 +1331,18 @@ int bpf_token_create(int bpffs_fd, struct bpf_token_create_opts *opts)
 	fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
+
+int bpf_prog_terminate(int prog_id, int cpu_id)
+{
+	int fd;
+	union bpf_attr attr;
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_terminate);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_terminate.prog_id = prog_id;
+	attr.prog_terminate.term_cpu_id = cpu_id;
+
+	fd = sys_bpf(BPF_PROG_TERMINATE, &attr, attr_sz);
+
+	return libbpf_err_errno(fd);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 777627d33d25..6d09d17467b7 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -704,6 +704,16 @@ struct bpf_token_create_opts {
 LIBBPF_API int bpf_token_create(int bpffs_fd,
 				struct bpf_token_create_opts *opts);
 
+
+/**
+ * @brief **bpf_prog_terminate()** when provided with prog id and cpu id
+ * of the running prog, it terminated the running BPF program.
+ *
+ * @param BPF program file descriptor
+ * @cpu_id cpu id of the running program
+ */
+LIBBPF_API int bpf_prog_terminate(int prog_id, int cpu_id);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1205f9a4fe04..80793f215464 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -443,4 +443,5 @@ LIBBPF_1.6.0 {
 		bpf_program__line_info_cnt;
 		btf__add_decl_attr;
 		btf__add_type_attr;
+		bpf_prog_terminate;
 } LIBBPF_1.5.0;
-- 
2.43.0


