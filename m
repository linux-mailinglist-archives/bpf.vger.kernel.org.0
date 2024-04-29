Return-Path: <bpf+bounces-28202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD748B65E6
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432E2283204
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65352561F;
	Mon, 29 Apr 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="JM1hvzsK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G1xl6sko"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C218C1F
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430789; cv=none; b=ps67/DJ0a8zSFOwNoV1l+p0fY5QctlX0sW2cKXQvp8IN3tcSXGJw8hvB4agPDaaCRzYAf4HfuU3pBOIXHmg+kL2wcntYqZGH+o+vLYFhBP/KDA6tBlprdes+hrcayj+jIxj2lZJHIU24xVzVaQGFnjFwety+i2Ii3dXxxjRgrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430789; c=relaxed/simple;
	bh=VA1CmiFy4gKsCoOZM/fBiBUGSj7d/GaT8Wcfc8c98pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qx85+v0EhBoA25YKIrkn5ly5p/tEeTDcfK64kz37jigEmElEbU3QzyCXl9Gq5QokfDPNDN7CNoQCuFhim2lwBDIZ+bKcrqb0EnGOXPGpT7hHkUFDsneAkjasQz4fpA6dTwWV52hP2ybdrpLWIcrj+JD1KNrr/LybbCYrODg5euo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=JM1hvzsK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G1xl6sko; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1ACD1180018D;
	Mon, 29 Apr 2024 18:46:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 18:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714430785; x=
	1714517185; bh=iUxJ1AXeKAumBghb7XYqyLbgXhR3FVd2SdPo64+eEG0=; b=J
	M1hvzsKP/aqKGnMFWyKjC4hgBiM9AmPi1WcIXa1oumI+ZaNtuMPSvu2TcusmtGrN
	LIVpeBxcN1qXwbFPBWN3UHlRKtWBJwmHhoIXF3/2hKbC2A41VATGXW9x32wtsL9g
	1rvmBqD1X4S2cMrsThvW3QibS3pNNBtoZdXkB+lxFkba1op0h6q4EI8l7vhipETD
	1D3wZJ2efMMwFrnbPCHaNVmA9FDOCbzIO3X1X6nS0PV8IO8g+ya1xNqFSd+XBNeL
	9XzHIX8KVOAZgfsuVxqkK9Og8ZNfSWMdMorPeVcgfo4bpz6m2HsdH0FYdtkYzXTQ
	sZKYbbS7YBKFpvRasTxmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714430785; x=
	1714517185; bh=iUxJ1AXeKAumBghb7XYqyLbgXhR3FVd2SdPo64+eEG0=; b=G
	1xl6skoxL5g6QjiZw2Lg1mUHzy4r6Qmz7Eypib8PQl6OS1K+l9v1haSSXU0PZvWK
	8uvZ6tI6hsHUJS3S9HZYgxbwqMCMxPQmx3QsULvsbo7I3LTekZcPhmAN2LRVmPeu
	u75BJL5f/UGQ4FUDyVfrtZgGzQH/XE6ExAagL4Zf1z5AL6LMlKy/kFBZk3Zq/3qv
	r/oiAhgwWjbzSQ67/kubwgSCaqDkFjlOWmMb05x3YKCSSFT2OTzkDnG4HVUMGQCD
	/W5DzsYIoiZkqmVeZpUGmlP9QObMqd3AL/a5CwP11pftW2nkNL6SqpmJltIVqhPB
	egQhGbNNgwUz1qP7TeK0Q==
X-ME-Sender: <xms:QSMwZljkZpsraBSRvMd4EdI9ArNsuvpX2loTG8huLr2ydJteyN1nHg>
    <xme:QSMwZqBlDLX07y49IpnWtvPEY48RFEYFr47WnMb3Sn7_gOWrWND2ugvY1egdN9G7q
    1Mi1M7AC3i4spvwvg>
X-ME-Received: <xmr:QSMwZlFddaBdpZ8SjVQtAmvxQJUO_r3CiWtUHs9TsRxencEsCFtK_jXEw2IhBFhuwlRWUzoZQQO-IDaMMmJq3iqRxMUTMo98v-u1hZXne50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:QSMwZqTtXk0p_TjyBUwG7YJ2vTN85w7q0uDfXGCgHuVL7FLtJUcJMg>
    <xmx:QSMwZixLYMJ2PuDBnl9eLERm_PombgFsq3e8zl_WN2a0j8W3GYRs-w>
    <xmx:QSMwZg4mADy5-3lSgRjSiJ8tDirC5kWQ4iD0J1OZ0ZZpVI8JIf0pQA>
    <xmx:QSMwZnxZxlmnI5Bz3IKSfRDsf7hSJhBhoxvCe1Jfw8ymyTUS581ikA>
    <xmx:QSMwZme_Wq4FUF_z_OpfsfskGHpNpQ93722Ziwfucv7v9TpjPO2cGzBw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 18:46:24 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves v9 3/3] pahole: Inject kfunc decl tags into BTF
Date: Mon, 29 Apr 2024 16:46:00 -0600
Message-ID: <26ec519a00aa47f25bc6b4c7e4e15e5191ba4d45.1714430735.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714430735.git.dxu@dxuuu.xyz>
References: <cover.1714430735.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit teaches pahole to parse symbols in .BTF_ids section in
vmlinux and discover exported kfuncs. Pahole then takes the list of
kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.

Example of encoding:

        $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
        121

        $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
        [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
        [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1

This enables downstream users and tools to dynamically discover which
kfuncs are available on a system by parsing vmlinux or module BTF, both
available in /sys/kernel/btf.

This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 btf_encoder.c | 372 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 372 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index f0ef20a..6cb0c8f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -34,6 +34,21 @@
 #include <pthread.h>
 
 #define BTF_ENCODER_MAX_PROTO	512
+#define BTF_IDS_SECTION		".BTF_ids"
+#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
+#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
+#define BTF_SET8_KFUNCS		(1 << 0)
+#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
+
+/* Adapted from include/linux/btf_ids.h */
+struct btf_id_set8 {
+        uint32_t cnt;
+        uint32_t flags;
+        struct {
+                uint32_t id;
+                uint32_t flags;
+        } pairs[];
+};
 
 /* state used to do later encoding of saved functions */
 struct btf_encoder_state {
@@ -76,6 +91,7 @@ struct btf_encoder {
 			  verbose,
 			  force,
 			  gen_floats,
+			  skip_encoding_decl_tag,
 			  tag_kfuncs,
 			  is_rel;
 	uint32_t	  array_index_id;
@@ -95,6 +111,17 @@ struct btf_encoder {
 	} functions;
 };
 
+struct btf_func {
+	const char *name;
+	int	    type_id;
+};
+
+/* Half open interval representing range of addresses containing kfuncs */
+struct btf_kfunc_set_range {
+	uint64_t start;
+	uint64_t end;
+};
+
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
 
@@ -1364,8 +1391,343 @@ out:
 	return err;
 }
 
+/* Returns if `sym` points to a kfunc set */
+static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
+{
+	void *ptr = idlist->d_buf;
+	struct btf_id_set8 *set;
+	int off;
+
+	/* kfuncs are only found in BTF_SET8's */
+	if (!strstarts(name, BTF_ID_SET8_PFX))
+		return false;
+
+	off = sym->st_value - idlist_addr;
+	if (off >= idlist->d_size) {
+		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
+		return false;
+	}
+
+	/* Check the set8 flags to see if it was marked as kfunc */
+	set = ptr + off;
+	return set->flags & BTF_SET8_KFUNCS;
+}
+
+/*
+ * Parse BTF_ID symbol and return the func name.
+ *
+ * Returns:
+ *	Caller-owned string containing func name if successful.
+ *	NULL if !func or on error.
+ */
+static char *get_func_name(const char *sym)
+{
+	char *func, *end;
+
+	/* Example input: __BTF_ID__func__vfs_close__1
+	 *
+	 * The goal is to strip the prefix and suffix such that we only
+	 * return vfs_close.
+	 */
+
+	if (!strstarts(sym, BTF_ID_FUNC_PFX))
+		return NULL;
+
+	/* Strip prefix and handle malformed input such as  __BTF_ID__func___ */
+	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
+	if (!strstr(func, "__")) {
+                free(func);
+                return NULL;
+        }
+
+	/* Strip suffix */
+	end = strrchr(func, '_');
+	if (!end || *(end - 1) != '_') {
+		free(func);
+		return NULL;
+	}
+	*(end - 1) = '\0';
+
+	return func;
+}
+
+static int btf_func_cmp(const void *_a, const void *_b)
+{
+	const struct btf_func *a = _a;
+	const struct btf_func *b = _b;
+
+	return strcmp(a->name, b->name);
+}
+
+/*
+ * Collects all functions described in BTF.
+ * Returns non-zero on error.
+ */
+static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder, struct gobuffer *funcs)
+{
+	struct btf *btf = encoder->btf;
+	int nr_types, type_id;
+	int err = -1;
+
+	/* First collect all the func entries into an array */
+	nr_types = btf__type_cnt(btf);
+	for (type_id = 1; type_id < nr_types; type_id++) {
+		const struct btf_type *type;
+		struct btf_func func = {};
+		const char *name;
+
+		type = btf__type_by_id(btf, type_id);
+		if (!type) {
+			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
+				__func__, type_id);
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (!btf_is_func(type))
+			continue;
+
+		name = btf__name_by_offset(btf, type->name_off);
+		if (!name) {
+			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
+				__func__, type_id);
+			err = -EINVAL;
+			goto out;
+		}
+
+		func.name = name;
+		func.type_id = type_id;
+		err = gobuffer__add(funcs, &func, sizeof(func));
+		if (err < 0)
+			goto out;
+	}
+
+	/* Now that we've collected funcs, sort them by name */
+	gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp);
+
+	err = 0;
+out:
+	return err;
+}
+
+static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc)
+{
+	struct btf_func key = { .name = kfunc };
+	struct btf *btf = encoder->btf;
+	struct btf_func *target;
+	const void *base;
+	unsigned int cnt;
+	int err = -1;
+
+	base = gobuffer__entries(funcs);
+	cnt = gobuffer__nr_entries(funcs);
+	target = bsearch(&key, base, cnt, sizeof(key), btf_func_cmp);
+	if (!target) {
+		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc);
+		goto out;
+	}
+
+	/* Note we are unconditionally adding the btf_decl_tag even
+	 * though vmlinux may already contain btf_decl_tags for kfuncs.
+	 * We are ok to do this b/c we will later btf__dedup() to remove
+	 * any duplicates.
+	 */
+	err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, -1);
+	if (err < 0) {
+		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
+			__func__, kfunc, err);
+		goto out;
+	}
+
+	err = 0;
+out:
+	return err;
+}
+
+static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
+{
+	const char *filename = encoder->source_filename;
+	struct gobuffer btf_kfunc_ranges = {};
+	struct gobuffer btf_funcs = {};
+	Elf_Data *symbols = NULL;
+	Elf_Data *idlist = NULL;
+	Elf_Scn *symscn = NULL;
+	int symbols_shndx = -1;
+	size_t idlist_addr = 0;
+	int fd = -1, err = -1;
+	int idlist_shndx = -1;
+	size_t strtabidx = 0;
+	Elf_Scn *scn = NULL;
+	Elf *elf = NULL;
+	GElf_Shdr shdr;
+	size_t strndx;
+	char *secname;
+	int nr_syms;
+	int i = 0;
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open %s\n", filename);
+		goto out;
+	}
+
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		elf_error("Cannot set libelf version");
+		goto out;
+	}
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (elf == NULL) {
+		elf_error("Cannot update ELF file");
+		goto out;
+	}
+
+	/* Locate symbol table and .BTF_ids sections */
+	if (elf_getshdrstrndx(elf, &strndx) < 0)
+		goto out;
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		Elf_Data *data;
+
+		i++;
+		if (!gelf_getshdr(scn, &shdr)) {
+			elf_error("Failed to get ELF section(%d) hdr", i);
+			goto out;
+		}
+
+		secname = elf_strptr(elf, strndx, shdr.sh_name);
+		if (!secname) {
+			elf_error("Failed to get ELF section(%d) hdr name", i);
+			goto out;
+		}
+
+		data = elf_getdata(scn, 0);
+		if (!data) {
+			elf_error("Failed to get ELF section(%d) data", i);
+			goto out;
+		}
+
+		if (shdr.sh_type == SHT_SYMTAB) {
+			symbols_shndx = i;
+			symscn = scn;
+			symbols = data;
+			strtabidx = shdr.sh_link;
+		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
+			idlist_shndx = i;
+			idlist_addr = shdr.sh_addr;
+			idlist = data;
+		}
+	}
+
+	/* Cannot resolve symbol or .BTF_ids sections. Nothing to do. */
+	if (symbols_shndx == -1 || idlist_shndx == -1) {
+		err = 0;
+		goto out;
+	}
+
+	if (!gelf_getshdr(symscn, &shdr)) {
+		elf_error("Failed to get ELF symbol table header");
+		goto out;
+	}
+	nr_syms = shdr.sh_size / shdr.sh_entsize;
+
+	err = btf_encoder__collect_btf_funcs(encoder, &btf_funcs);
+	if (err) {
+		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
+		goto out;
+	}
+
+	/* First collect all kfunc set ranges.
+	 *
+	 * Note we choose not to sort these ranges and accept a linear
+	 * search when doing lookups. Reasoning is that the number of
+	 * sets is ~O(100) and not worth the additional code to optimize.
+	 */
+	for (i = 0; i < nr_syms; i++) {
+		struct btf_kfunc_set_range range = {};
+		const char *name;
+		GElf_Sym sym;
+
+		if (!gelf_getsym(symbols, i, &sym)) {
+			elf_error("Failed to get ELF symbol(%d)", i);
+			goto out;
+		}
+
+		if (sym.st_shndx != idlist_shndx)
+			continue;
+
+		name = elf_strptr(elf, strtabidx, sym.st_name);
+		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
+			continue;
+
+		range.start = sym.st_value;
+		range.end = sym.st_value + sym.st_size;
+		gobuffer__add(&btf_kfunc_ranges, &range, sizeof(range));
+	}
+
+	/* Now inject BTF with kfunc decl tag for detected kfuncs */
+	for (i = 0; i < nr_syms; i++) {
+		const struct btf_kfunc_set_range *ranges;
+		unsigned int ranges_cnt;
+		char *func, *name;
+		GElf_Sym sym;
+		bool found;
+		int err;
+		int j;
+
+		if (!gelf_getsym(symbols, i, &sym)) {
+			elf_error("Failed to get ELF symbol(%d)", i);
+			goto out;
+		}
+
+		if (sym.st_shndx != idlist_shndx)
+			continue;
+
+		name = elf_strptr(elf, strtabidx, sym.st_name);
+		func = get_func_name(name);
+		if (!func)
+			continue;
+
+		/* Check if function belongs to a kfunc set */
+		ranges = gobuffer__entries(&btf_kfunc_ranges);
+		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
+		found = false;
+		for (j = 0; j < ranges_cnt; j++) {
+			size_t addr = sym.st_value;
+
+			if (ranges[j].start <= addr && addr < ranges[j].end) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			free(func);
+			continue;
+		}
+
+		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
+		if (err) {
+			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
+			free(func);
+			goto out;
+		}
+		free(func);
+	}
+
+	err = 0;
+out:
+	__gobuffer__delete(&btf_funcs);
+	__gobuffer__delete(&btf_kfunc_ranges);
+	if (elf)
+		elf_end(elf);
+	if (fd != -1)
+		close(fd);
+	return err;
+}
+
 int btf_encoder__encode(struct btf_encoder *encoder)
 {
+	bool should_tag_kfuncs;
 	int err;
 
 	/* for single-threaded case, saved funcs are added here */
@@ -1378,6 +1740,15 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	if (btf__type_cnt(encoder->btf) == 1)
 		return 0;
 
+	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
+	 * take care to call this before btf_dedup().
+	 */
+	should_tag_kfuncs = encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag;
+	if (should_tag_kfuncs && btf_encoder__tag_kfuncs(encoder)) {
+		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
+		return -1;
+	}
+
 	if (btf__dedup(encoder->btf, NULL)) {
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
@@ -1662,6 +2033,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
 		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
+		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
-- 
2.44.0


