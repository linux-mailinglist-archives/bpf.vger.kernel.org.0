Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CAC6ED201
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjDXQGG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjDXQGF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:06:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4B272BD
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F8A861B47
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B64C433D2;
        Mon, 24 Apr 2023 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352363;
        bh=OTQYlcnuzdMEc76T8nbnYmY0E6KYAqPxBfN0HeJ4HL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVuKnvUr5vJ+wXTx5cwKzvQF9/SCAAmDOnMwfkTSbvl8Mh74SpBh/NR0XahdsCJ77
         uWD6tviJLAP52V3V92CEdf2eRsuQpZo7e9zSr+9SOKJUlZoy2yDYsSMYfFgOBUkSpg
         MtlJBSmy3e9A0GD7voIG7dRDtlIecoLnkjUi48BTwyRpor5ZjCFVdFcxEsB7i13fo9
         aE2lszOjUVobOn81+jiv+lPjLTNwXES7OQFhkvMqmXem+7s1xNb1SWuEyJMSuIbOBL
         jTUkQqYbrhB7nm+ouaXOZRAW8+0Hkr3DD6PacH0zCdLCQC2iniF+yuFOHdcG9clvcL
         n1X6q8VoR9Gnw==
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
Subject: [RFC/PATCH bpf-next 07/20] libbpf: Add elf_find_multi_func_offset function
Date:   Mon, 24 Apr 2023 18:04:34 +0200
Message-Id: <20230424160447.2005755-8-jolsa@kernel.org>
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

Adding elf_find_multi_func_offset function that looks up
offsets for symbols specified in syms array argument.

Offsets are returned in allocated array with the 'cnt' size,
that needs to be released by the caller.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 161 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |   6 ++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 168 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 92c92ed2101f..0b15609d4573 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10713,6 +10713,7 @@ struct elf_func_offset {
 	int last_bind;
 	size_t name_len;
 	bool is_name_qualified;
+	int idx;
 };
 
 static int single_done(void *_data)
@@ -10891,6 +10892,166 @@ static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *
 	return ret;
 }
 
+struct match_multi_data {
+	int cnt;
+	int cnt_done;
+	struct elf_func_offset *func_offs;
+};
+
+static int cmp_func_offset(const void *_a, const void *_b)
+{
+	const struct elf_func_offset *a = _a;
+	const struct elf_func_offset *b = _b;
+
+	return strcmp(a->name, b->name);
+}
+
+static int multi_done(void *_data)
+{
+	struct match_multi_data *data = _data;
+
+	return data->cnt == data->cnt_done;
+}
+
+static int multi_match(Elf *elf, const char *binary_path, const char *sname,
+		       GElf_Sym *sym, void *_data)
+{
+	struct match_multi_data *data = _data;
+	struct elf_func_offset *fo, func_offs = {
+		.name = sname,
+	};
+	Elf_Scn *sym_scn;
+	GElf_Shdr sym_sh;
+	int curr_bind;
+
+	fo = bsearch(&func_offs, data->func_offs, data->cnt, sizeof(*data->func_offs),
+		     cmp_func_offset);
+	if (!fo)
+		return 0;
+
+	curr_bind = GELF_ST_BIND(sym->st_info);
+
+	if (fo->offset > 0) {
+		/* handle multiple matches */
+		if (fo->last_bind != STB_WEAK && curr_bind != STB_WEAK) {
+			/* Only accept one non-weak bind. */
+			pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
+				sname, fo->name, binary_path);
+			return -LIBBPF_ERRNO__FORMAT;
+		} else if (curr_bind == STB_WEAK) {
+			/* already have a non-weak bind, and
+			 * this is a weak bind, so ignore.
+			 */
+			return 0;
+		}
+	}
+
+	/* Transform symbol's virtual address (absolute for
+	 * binaries and relative for shared libs) into file
+	 * offset, which is what kernel is expecting for
+	 * uprobe/uretprobe attachment.
+	 * See Documentation/trace/uprobetracer.rst for more
+	 * details.
+	 * This is done by looking up symbol's containing
+	 * section's header and using it's virtual address
+	 * (sh_addr) and corresponding file offset (sh_offset)
+	 * to transform sym.st_value (virtual address) into
+	 * desired final file offset.
+	 */
+	sym_scn = elf_getscn(elf, sym->st_shndx);
+	if (!sym_scn)
+		return 0;
+	if (!gelf_getshdr(sym_scn, &sym_sh))
+		return 0;
+
+	if (!fo->offset)
+		data->cnt_done++;
+
+	fo->offset = sym->st_value - sym_sh.sh_addr + sym_sh.sh_offset;
+	fo->last_bind = curr_bind;
+	return 0;
+}
+
+static int
+__elf_find_multi_func_offset(Elf *elf, const char *binary_path, int cnt,
+			     const char **syms, unsigned long **poffsets)
+{
+	struct match_multi_data data = {
+		.cnt = cnt,
+	};
+	struct elf_func_offset *func_offs;
+	unsigned long *offsets = NULL;
+	int err, i, idx;
+
+	data.func_offs = func_offs = calloc(cnt, sizeof(*func_offs));
+	if (!func_offs)
+		return -ENOMEM;
+
+	for (i = 0; i < cnt; i++) {
+		func_offs[i].name = syms[i];
+		func_offs[i].idx = i;
+	}
+
+	qsort(func_offs, cnt, sizeof(*func_offs), cmp_func_offset);
+
+	err = elf_for_each_symbol(elf, binary_path, multi_match, multi_done, &data);
+	if (err)
+		goto out;
+
+	if (cnt != data.cnt_done) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	offsets = calloc(cnt, sizeof(*offsets));
+	if (!offsets) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		idx = func_offs[i].idx;
+		offsets[idx] = func_offs[i].offset;
+	}
+
+out:
+	*poffsets = offsets;
+	free(func_offs);
+	return err;
+}
+
+LIBBPF_API int
+elf_find_multi_func_offset(const char *binary_path, int cnt,
+			   const char **syms, unsigned long **poffsets)
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
+	ret = __elf_find_multi_func_offset(elf, binary_path, cnt, syms, poffsets);
+	elf_end(elf);
+	close(fd);
+	return ret;
+}
+
 /* Find offset of function name in ELF object specified by path. "name" matches
  * symbol name or name@@LIB for library functions.
  */
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0b7362397ea3..b1b159263d47 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1649,6 +1649,12 @@ LIBBPF_API int libbpf_register_prog_handler(const char *sec,
  */
 LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
 
+/**
+ * @brief *elf_find_multi_func_offset()* return offsets for given *syms*
+ */
+LIBBPF_API int elf_find_multi_func_offset(const char *binary_path, int cnt,
+					  const char **syms, unsigned long **poffsets);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a5aa3a383d69..7b1bf3f9ce4f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -390,4 +390,5 @@ LIBBPF_1.2.0 {
 		bpf_link_get_info_by_fd;
 		bpf_map_get_info_by_fd;
 		bpf_prog_get_info_by_fd;
+		elf_find_multi_func_offset;
 } LIBBPF_1.1.0;
-- 
2.40.0

