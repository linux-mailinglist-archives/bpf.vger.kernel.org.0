Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBC26ED202
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjDXQGP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjDXQGP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC986A69
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ECCC60C7A
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C52C433D2;
        Mon, 24 Apr 2023 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352373;
        bh=seAKlsjYskREnG4tQ1+NlssuXIJTxUZaDQir7NEaDCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKwfwatHunBMHHlj+vbn1e1sZq7PLbkIxgNKmaqo7V3naDf9ME4as4u+eRrVrBHKd
         XGmp9sPJWTzxn3YPX5Kh0wEE19bHGPLrgNDweOoTAh6dlMyIaoJ8Yrc2ciubWDwU5W
         Ihtj53OoMCy2pejsY922vB8HIPG9myZAGZSSEUcTbanblBO5nCWOyaMgitOi41V6Ax
         LtcwX+GjFysyPF//ym8OYkzS+9TO/e5b9riuqNv4q/nXlmDOW7VtLPUEKoQ5fuenCi
         6WyBmUTiwUm5/KIsdSsTglt8vkBp7q2tsqZ+ARn+pzkO+TLnhPlMVb967QboHGQYUt
         CiAjskLAA1GUA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 08/20] libbpf: Add elf_find_patern_func_offset function
Date:   Mon, 24 Apr 2023 18:04:35 +0200
Message-Id: <20230424160447.2005755-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding elf_find_patern_func_offset function that looks up
offsets for symbols specified by pattern argument.

The 'pattern' argument allows wildcards (*?' supported).

Offsets are returned in allocated array together with its
size and needs to be released by the caller.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 121 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |   7 +++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 129 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0b15609d4573..7eb7035f7b73 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11052,6 +11052,127 @@ elf_find_multi_func_offset(const char *binary_path, int cnt,
 	return ret;
 }
 
+struct match_pattern_data {
+	const char *pattern;
+	struct elf_func_offset *func_offs;
+	size_t func_offs_cnt;
+	size_t func_offs_cap;
+};
+
+static int pattern_done(void *_data)
+{
+	struct match_pattern_data *data = _data;
+
+	// If we found anything in the first symbol section, do not search others
+	// to avoid duplicates.
+	return data->func_offs_cnt;
+}
+
+static int pattern_match(Elf *elf, const char *binary_path, const char *sname,
+			 GElf_Sym *sym, void *_data)
+{
+	struct match_pattern_data *data = _data;
+	unsigned long offset;
+	Elf_Scn *sym_scn;
+	GElf_Shdr sym_sh;
+	int err;
+
+	if (!glob_match(sname, data->pattern))
+		return 0;
+	sym_scn = elf_getscn(elf, sym->st_shndx);
+	if (!sym_scn)
+		return 0;
+	if (!gelf_getshdr(sym_scn, &sym_sh))
+		return 0;
+
+	err = libbpf_ensure_mem((void **) &data->func_offs, &data->func_offs_cap,
+				sizeof(*data->func_offs), data->func_offs_cnt + 1);
+	if (err)
+		return err;
+
+	offset = sym->st_value - sym_sh.sh_addr + sym_sh.sh_offset;
+	data->func_offs[data->func_offs_cnt].offset = offset;
+	data->func_offs[data->func_offs_cnt].name = strdup(sname);
+	data->func_offs_cnt++;
+	return 0;
+}
+
+static int
+__elf_find_patern_func_offset(Elf *elf, const char *binary_path, const char *pattern,
+			      const char ***pnames, unsigned long **poffsets, size_t *pcnt)
+{
+	struct match_pattern_data data = {
+		.pattern = pattern,
+	};
+	unsigned long *offsets = NULL;
+	const char **names = NULL;
+	size_t cnt = 0;
+	int err, i;
+
+	err = elf_for_each_symbol(elf, binary_path, pattern_match, pattern_done, &data);
+	if (err)
+		goto out;
+
+	cnt = data.func_offs_cnt;
+	if (!cnt) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	offsets = calloc(cnt, sizeof(*offsets));
+	names = calloc(cnt, sizeof(*names));
+	if (!offsets || !names) {
+		free(offsets);
+		free(names);
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		offsets[i] = data.func_offs[i].offset;
+		names[i] = data.func_offs[i].name;
+	}
+
+out:
+	*pnames = names;
+	*poffsets = offsets;
+	*pcnt = cnt;
+	free(data.func_offs);
+	return err;
+}
+
+LIBBPF_API int
+elf_find_patern_func_offset(const char *binary_path, const char *pattern,
+			    const char ***pnames, unsigned long **poffsets, size_t *pcnt)
+{
+	char errmsg[STRERR_BUFSIZE];
+	long ret = -ENOENT;
+	Elf *elf;
+	int fd;
+
+	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		ret = -errno;
+		pr_warn("failed to open %s: %s\n", binary_path,
+			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
+		return ret;
+	}
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		pr_warn("failed to init libelf for %s\n", binary_path);
+		return -LIBBPF_ERRNO__LIBELF;
+	}
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!elf) {
+		pr_warn("elf: could not read elf from %s: %s\n", binary_path, elf_errmsg(-1));
+		close(fd);
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+	ret = __elf_find_patern_func_offset(elf, binary_path, pattern, pnames, poffsets, pcnt);
+	elf_end(elf);
+	close(fd);
+	return ret;
+}
+
 /* Find offset of function name in ELF object specified by path. "name" matches
  * symbol name or name@@LIB for library functions.
  */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b1b159263d47..96ed109ae011 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1655,6 +1655,13 @@ LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
 LIBBPF_API int elf_find_multi_func_offset(const char *binary_path, int cnt,
 					  const char **syms, unsigned long **poffsets);
 
+/**
+ * @brief *elf_find_patern_func_offset()* return symbols and offsets for given *pattern*
+ */
+LIBBPF_API int
+elf_find_patern_func_offset(const char *binary_path, const char *pattern,
+			    const char ***pnames, unsigned long **poffsets, size_t *pcnt);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7b1bf3f9ce4f..2f091a0f093b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -391,4 +391,5 @@ LIBBPF_1.2.0 {
 		bpf_map_get_info_by_fd;
 		bpf_prog_get_info_by_fd;
 		elf_find_multi_func_offset;
+		elf_find_patern_func_offset;
 } LIBBPF_1.1.0;
-- 
2.40.0

