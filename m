Return-Path: <bpf+bounces-2889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD338736664
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D8C1C20BDF
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38523AD56;
	Tue, 20 Jun 2023 08:37:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479D848A
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB89C433C8;
	Tue, 20 Jun 2023 08:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250243;
	bh=87ltz8OFoHjN13nhur6YjnSHECjD0n5EokxPHu4lJSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LtKx6enx80yuG4RJ8mcO7Q+8/c3q0hJRIOFNAISBB/zH1YW1IQky/Z8SRtwEZp9/O
	 65PnMGoBkwdknRV9AhVvf1OzwIATo94Nlt5OxrhvjJMOa8zeSMgx4ltf75UrdrAQLX
	 lll81hGJ33oNefT3IqeGODHBUIe4SqvneKAVLG9n68lv6YNL/jbxA+OksMiOU992Q8
	 EWxKB+5NiMihu/crIo2p7BwNNBrLhRx2tiFM6fRqyuD6g4OJYutLc0x3AVQnrif193
	 aZnR+VRRGD2bWSG4pdlBypO61Pmhhjwa5qMhAukbEy0WF150uQt3/KSG8jjFaxfavx
	 3Itlfo/UazVwg==
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
Subject: [PATCHv2 bpf-next 09/24] libbpf: Add elf_find_pattern_func_offset function
Date: Tue, 20 Jun 2023 10:35:35 +0200
Message-ID: <20230620083550.690426-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding elf_find_pattern_func_offset function that looks up
offsets for symbols specified by pattern argument.

The 'pattern' argument allows wildcards (*?' supported).

Offsets are returned in allocated array together with its
size and needs to be released by the caller.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 78 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  3 ++
 2 files changed, 81 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1c310b718961..3e5c88caf5d5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11165,6 +11165,84 @@ int elf_find_multi_func_offset(const char *binary_path, int cnt,
 	return ret;
 }
 
+static int
+__elf_find_pattern_func_offset(Elf *elf, const char *binary_path, const char *pattern,
+			       const char ***pnames, unsigned long **poffsets, size_t *pcnt)
+{
+	int sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
+	struct elf_symbol_offset *func_offs = NULL;
+	unsigned long *offsets = NULL;
+	const char **names = NULL;
+	size_t func_offs_cnt = 0;
+	size_t func_offs_cap = 0;
+	int err = 0, i;
+
+	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
+		struct elf_symbol_iter iter;
+		struct elf_symbol *sym;
+
+		if (elf_symbol_iter_new(&iter, elf, binary_path, sh_types[i]))
+			continue;
+
+		while ((sym = elf_symbol_iter_next(&iter))) {
+			if (!glob_match(sym->name, pattern))
+				continue;
+
+			err = libbpf_ensure_mem((void **) &func_offs, &func_offs_cap,
+						sizeof(*func_offs), func_offs_cnt + 1);
+			if (err)
+				goto out;
+
+			func_offs[func_offs_cnt].offset = sym->offset;
+			func_offs[func_offs_cnt].name = strdup(sym->name);
+			func_offs_cnt++;
+		}
+
+		/* If we found anything in the first symbol section,
+		 * do not search others to avoid duplicates.
+		 */
+		if (func_offs_cnt)
+			break;
+	}
+
+	offsets = calloc(func_offs_cnt, sizeof(*offsets));
+	names = calloc(func_offs_cnt, sizeof(*names));
+	if (!offsets || !names) {
+		free(offsets);
+		free(names);
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < func_offs_cnt; i++) {
+		offsets[i] = func_offs[i].offset;
+		names[i] = func_offs[i].name;
+	}
+
+	*pnames = names;
+	*poffsets = offsets;
+	*pcnt = func_offs_cnt;
+out:
+	free(func_offs);
+	return err;
+}
+
+int elf_find_pattern_func_offset(const char *binary_path, const char *pattern,
+				 const char ***pnames, unsigned long **poffsets,
+				 size_t *pcnt)
+{
+	struct elf_fd elf_fd = {};
+	long ret = -ENOENT;
+
+	ret = open_elf(binary_path, &elf_fd);
+	if (ret)
+		return ret;
+
+	ret = __elf_find_pattern_func_offset(elf_fd.elf, binary_path, pattern, pnames, poffsets, pcnt);
+	close_elf(&elf_fd);
+	return ret;
+}
+
 /* Find offset of function name in ELF object specified by path. "name" matches
  * symbol name or name@@LIB for library functions.
  */
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 13d5c12fbd0b..22b0834e7fe1 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -579,4 +579,7 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts);
 
 int elf_find_multi_func_offset(const char *binary_path, int cnt,
 			       const char **syms, unsigned long **poffsets);
+int elf_find_pattern_func_offset(const char *binary_path, const char *pattern,
+				 const char ***pnames, unsigned long **poffsets,
+				 size_t *pcnt);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.41.0


