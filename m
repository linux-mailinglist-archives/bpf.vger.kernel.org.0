Return-Path: <bpf+bounces-3778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F2E743767
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBC11C20BD6
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BC5A957;
	Fri, 30 Jun 2023 08:36:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0619A932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB78C433C0;
	Fri, 30 Jun 2023 08:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114162;
	bh=ksBU+QIJshjNzOO4TrnPBH/WUhA50RSmIomZyzng9Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQcYeEnvGDWlZ98Os16GIRfN9dnV96QKfgK68dA1159170TPKxNWDYN9wuAl/Kl7E
	 gkYBQ01vEE4btR5NttHT7f/l8WnuRdCyuHvUAdM3oyOLnW1FwyUTzKHheJx9j+3mc+
	 2LTKeEmdJXwBl89tK5Q92pRVcK9UGy7Y2lzxpdg2/vOYZ6guolgCsf5Hx2YPDcUnLM
	 euwQuTwjgjKF5E5oo6Y8vRsWXme/rWrV6s+WNB+dymyuixsSBz/cG/GZxCEHoe8jwA
	 kTLkEV5SFLVQzQQBs8D/MdLTZu6/LiYmxS4lona5rfhogA6a1p+at9L7xATYD0lGG1
	 HrU3J3FqGwkCQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf-next 11/26] libbpf: Add elf_resolve_pattern_offsets function
Date: Fri, 30 Jun 2023 10:33:29 +0200
Message-ID: <20230630083344.984305-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
References: <20230630083344.984305-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding elf_resolve_pattern_offsets function that looks up
offsets for symbols specified by pattern argument.

The 'pattern' argument allows wildcards (*?' supported).

Offsets are returned in allocated array together with its
size and needs to be released by the caller.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/elf.c             | 57 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          |  2 +-
 tools/lib/bpf/libbpf_elf.h      |  3 ++
 tools/lib/bpf/libbpf_internal.h |  1 +
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 7e2f3b2e1fb6..f2d1a8cc2f9d 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -376,3 +376,60 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
 	elf_close(&elf_fd);
 	return err;
 }
+
+int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
+				unsigned long **poffsets, size_t *pcnt)
+{
+	int sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
+	unsigned long *offsets = NULL;
+	size_t cap = 0, cnt = 0;
+	struct elf_fd elf_fd;
+	int err = 0, i;
+
+	err = elf_open(binary_path, &elf_fd);
+	if (err)
+		return err;
+
+	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
+		struct elf_sym_iter iter;
+		struct elf_sym *sym;
+
+		err = elf_sym_iter_new(&iter, elf_fd.elf, binary_path, sh_types[i], STT_FUNC);
+		if (err) {
+			if (err == -ENOENT)
+				continue;
+			goto out;
+		}
+
+		while ((sym = elf_sym_iter_next(&iter))) {
+			if (!glob_match(sym->name, pattern))
+				continue;
+
+			err = libbpf_ensure_mem((void **) &offsets, &cap, sizeof(*offsets),
+						cnt + 1);
+			if (err)
+				goto out;
+
+			offsets[cnt++] = elf_sym_offset(sym);
+		}
+
+		/* If we found anything in the first symbol section,
+		 * do not search others to avoid duplicates.
+		 */
+		if (cnt)
+			break;
+	}
+
+	if (cnt) {
+		*poffsets = offsets;
+		*pcnt = cnt;
+	} else {
+		err = -ENOENT;
+	}
+
+out:
+	if (err)
+		free(offsets);
+	elf_close(&elf_fd);
+	return err;
+}
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 093add8124d8..f33ef7cb1adc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10509,7 +10509,7 @@ struct bpf_link *bpf_program__attach_ksyscall(const struct bpf_program *prog,
 }
 
 /* Adapted from perf/util/string.c */
-static bool glob_match(const char *str, const char *pat)
+bool glob_match(const char *str, const char *pat)
 {
 	while (*str && *pat && *pat != '*') {
 		if (*pat == '?') {      /* Matches any single character */
diff --git a/tools/lib/bpf/libbpf_elf.h b/tools/lib/bpf/libbpf_elf.h
index 026c7b378727..0c75d3b2398b 100644
--- a/tools/lib/bpf/libbpf_elf.h
+++ b/tools/lib/bpf/libbpf_elf.h
@@ -18,4 +18,7 @@ long elf_find_func_offset_from_file(const char *binary_path, const char *name);
 
 int elf_resolve_syms_offsets(const char *binary_path, int cnt,
 			     const char **syms, unsigned long **poffsets);
+
+int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
+				 unsigned long **poffsets, size_t *pcnt);
 #endif /* *__LIBBPF_LIBBPF_ELF_H */
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e4d05662a96c..7d75b92e531a 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -577,4 +577,5 @@ static inline bool is_pow_of_2(size_t x)
 #define PROG_LOAD_ATTEMPTS 5
 int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts);
 
+bool glob_match(const char *str, const char *pat);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.41.0


