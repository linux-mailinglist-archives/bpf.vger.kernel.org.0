Return-Path: <bpf+bounces-14569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB9A7E66BA
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 10:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455122812F0
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F29125C4;
	Thu,  9 Nov 2023 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVzg02K2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62FE11C92
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C99C433C8;
	Thu,  9 Nov 2023 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699522134;
	bh=ltR3BdlouSxCGOR4eQ7j2p0cTYtgZixLT+uPzxkoPgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVzg02K258JohgD5/ZcCmTqNPayEEbPU17dumtJW3AF87igxh0PinzBCXse7X4tUf
	 MTVXjRwQ7nxltAz1oWLv2lcx/2eGYe3m/j4EX9AYwRwEnP5zOcyDZAkacsKZQMOC9t
	 5XkL6lGrRZkvTCU7U/kq2852d9Wz/WcTpbXcf7OSuxkIY90tWTnU75O8C5MbFS6dFy
	 nwB2+bs8AZAQjOvodYgHs0qD8nBX6fMwETKSwTTwE2AKSBLR2ZN/d19tzsLq4zGQnV
	 mr0dNekntk0wMie6ZMQO46xItjU3GsFACVTA+7MVHWmxtt883cQhutuZenJs8s+lj/
	 FQqmuJvaSrS2Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv2 bpf-next 1/6] libbpf: Add st_type argument to elf_resolve_syms_offsets function
Date: Thu,  9 Nov 2023 10:28:33 +0100
Message-ID: <20231109092838.721233-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109092838.721233-1-jolsa@kernel.org>
References: <20231109092838.721233-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to get offsets for static variables in following changes,
so making elf_resolve_syms_offsets to take st_type value as argument
and passing it to elf_sym_iter_new.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/elf.c                                        | 5 +++--
 tools/lib/bpf/libbpf.c                                     | 2 +-
 tools/lib/bpf/libbpf_internal.h                            | 3 ++-
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 2a62bf411bb3..b02faec748a5 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -407,7 +407,8 @@ static int symbol_cmp(const void *a, const void *b)
  * size, that needs to be released by the caller.
  */
 int elf_resolve_syms_offsets(const char *binary_path, int cnt,
-			     const char **syms, unsigned long **poffsets)
+			     const char **syms, unsigned long **poffsets,
+			     int st_type)
 {
 	int sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
 	int err = 0, i, cnt_done = 0;
@@ -438,7 +439,7 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
 		struct elf_sym_iter iter;
 		struct elf_sym *sym;
 
-		err = elf_sym_iter_new(&iter, elf_fd.elf, binary_path, sh_types[i], STT_FUNC);
+		err = elf_sym_iter_new(&iter, elf_fd.elf, binary_path, sh_types[i], st_type);
 		if (err == -ENOENT)
 			continue;
 		if (err)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067be95da3c..ea9b8158c20d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11447,7 +11447,7 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 			return libbpf_err_ptr(err);
 		offsets = resolved_offsets;
 	} else if (syms) {
-		err = elf_resolve_syms_offsets(path, cnt, syms, &resolved_offsets);
+		err = elf_resolve_syms_offsets(path, cnt, syms, &resolved_offsets, STT_FUNC);
 		if (err < 0)
 			return libbpf_err_ptr(err);
 		offsets = resolved_offsets;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index f0f08635adb0..b5d334754e5d 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -594,7 +594,8 @@ int elf_open(const char *binary_path, struct elf_fd *elf_fd);
 void elf_close(struct elf_fd *elf_fd);
 
 int elf_resolve_syms_offsets(const char *binary_path, int cnt,
-			     const char **syms, unsigned long **poffsets);
+			     const char **syms, unsigned long **poffsets,
+			     int st_type);
 int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
 				 unsigned long **poffsets, size_t *pcnt);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index cd051d3901a9..ece260cf2c0b 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -249,7 +249,7 @@ static void __test_link_api(struct child *child)
 	int link_extra_fd = -1;
 	int err;
 
-	err = elf_resolve_syms_offsets(path, 3, syms, (unsigned long **) &offsets);
+	err = elf_resolve_syms_offsets(path, 3, syms, (unsigned long **) &offsets, STT_FUNC);
 	if (!ASSERT_OK(err, "elf_resolve_syms_offsets"))
 		return;
 
-- 
2.41.0


