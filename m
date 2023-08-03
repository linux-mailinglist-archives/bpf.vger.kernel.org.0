Return-Path: <bpf+bounces-6807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE3476E1AD
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1591C214D0
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA9134CB;
	Thu,  3 Aug 2023 07:36:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A988134AA
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98718C433C7;
	Thu,  3 Aug 2023 07:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691048185;
	bh=UFAtJW/kUi20OUAFfN9cQ/cXigtSrtYou4rmtbzMGxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaf0YwjzatFpo0c6nOIzHT2/eEngrr2SW97HTMKdY2KJV/J2caqG1hrw4+kvqzqSj
	 Ha/v6/Y9YiQN+WR6FrT50eVGMKeQuVCr6R254uDg3ko0X2s8OXcm9vie7qRv5X9Pe8
	 qp4Sr5riQTY0T4GBTg0aeCIYjyNz7O1wSFu/6fxCymIxQ322kEKdXIFAdbyMvTpdbw
	 eCvVvjS6iImvAbopImT4kLXvm6YTjqLLbIt+KthLjcSGNBbc2g0zTZSx2Sna8WrZtX
	 Gc+z6Z7mxHkSkzKbdmUxH7pYH+iJyezAqSpN+M6kbocbBtGJ43pKl+ZSNpDtE4Z6jT
	 hBrjt8S/o+EOA==
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
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv6 bpf-next 12/28] libbpf: Add elf_resolve_pattern_offsets function
Date: Thu,  3 Aug 2023 09:34:04 +0200
Message-ID: <20230803073420.1558613-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803073420.1558613-1-jolsa@kernel.org>
References: <20230803073420.1558613-1-jolsa@kernel.org>
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
 tools/lib/bpf/elf.c             | 61 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          |  2 +-
 tools/lib/bpf/libbpf_internal.h |  5 +++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 8c512641c1d7..9d0296c1726a 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -377,3 +377,64 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
 	elf_close(&elf_fd);
 	return err;
 }
+
+/*
+ * Return offsets in @poffsets for symbols specified by @pattern argument.
+ * On success returns 0 and offsets are returned in allocated @poffsets
+ * array with the @pctn size, that needs to be released by the caller.
+ */
+int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
+				unsigned long **poffsets, size_t *pcnt)
+{
+	int sh_types[2] = { SHT_SYMTAB, SHT_DYNSYM };
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
+		if (err == -ENOENT)
+			continue;
+		if (err)
+			goto out;
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
index 1bdda3f8c865..445953a4d8fc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10551,7 +10551,7 @@ struct bpf_link *bpf_program__attach_ksyscall(const struct bpf_program *prog,
 }
 
 /* Adapted from perf/util/string.c */
-static bool glob_match(const char *str, const char *pat)
+bool glob_match(const char *str, const char *pat)
 {
 	while (*str && *pat && *pat != '*') {
 		if (*pat == '?') {      /* Matches any single character */
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 92851c5f912d..ead551318fec 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -578,6 +578,8 @@ static inline bool is_pow_of_2(size_t x)
 #define PROG_LOAD_ATTEMPTS 5
 int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts);
 
+bool glob_match(const char *str, const char *pat);
+
 long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name);
 long elf_find_func_offset_from_file(const char *binary_path, const char *name);
 
@@ -591,4 +593,7 @@ void elf_close(struct elf_fd *elf_fd);
 
 int elf_resolve_syms_offsets(const char *binary_path, int cnt,
 			     const char **syms, unsigned long **poffsets);
+int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
+				 unsigned long **poffsets, size_t *pcnt);
+
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.41.0


