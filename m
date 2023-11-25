Return-Path: <bpf+bounces-15843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BE37F8DF4
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6F8B2104F
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B614B2F85D;
	Sat, 25 Nov 2023 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPa/zh0o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C928E03
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 19:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4272FC433C8;
	Sat, 25 Nov 2023 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700940707;
	bh=Hh3QXieop/72+XuFkIceKRITvM/0eaPO9EkDAvY1l1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPa/zh0oKF2Ye1kFCSxqkRepbzYWjWbIZnU88Z8VqsMjfZM34246RloaUVCMUG1eV
	 yFjrabfMQPARm7np5fvSYz5dSwztJNuLhS2m9gWX8VPs3Q0FH8sOwP0+Y6tX+dW9LS
	 AIVJ9udiyPoBkSo6Hh19vWlqJUNIaEElWSNPcu6plPQJHRldImSyZio6ZPH0PHfqJm
	 1so329JDGHenI2MZf/AXndKlNrpvb+TVmWH29asHZjmPSv/oQf/2W4Uz6btgNH6bID
	 OksUpKJjt0HqegBTy3pEmRGan54rlFLMncgh8hVEtGoWIRRXU8IQ2ux8Ruai473keI
	 Lvov5XWYHxaUw==
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
Subject: [PATCHv4 bpf-next 1/6] libbpf: Add st_type argument to elf_resolve_syms_offsets function
Date: Sat, 25 Nov 2023 20:31:25 +0100
Message-ID: <20231125193130.834322-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231125193130.834322-1-jolsa@kernel.org>
References: <20231125193130.834322-1-jolsa@kernel.org>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
2.42.0


