Return-Path: <bpf+bounces-27711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A0B8B111C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 19:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D0B1C23B1E
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80716D4FB;
	Wed, 24 Apr 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="L9Ab+mXI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RsUDyKco"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177616D4EC
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980092; cv=none; b=Ga8cSsGon02WzpWuHJ8zdSlhFenRk8ot3Fqfyh3lTBe2eb1d2g7iWpjmbnFZ5BzxfJMqrE2OBItX4GVZ9qyaqR53bzQF8PHJAbhCuntAejNvBeaFlXevOuPSiVL6p0BAFryILWSGtVsrO0nH2cB3bzZXVmcn8HZ/rawextRxn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980092; c=relaxed/simple;
	bh=RwByOirmi6ATY77LeF3vE9WHjPKc+wseXXggJu8DOD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyJxS9/X1VbL9DlcVTRrivMorU0q1SG1g7C462yLzE/7Wd+98Cr1zw8lunNOTHaRZOls5yj5/mnSRxVWSE8vir/nwD3yawnduTnHZIfUko1XjPoMD0ysN893kfiZwFnbv2fT6IxUSlt1yC66gJwzeI31pgqc95jcldKNcpvMZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=L9Ab+mXI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RsUDyKco; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D3AC111400B6;
	Wed, 24 Apr 2024 13:34:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 24 Apr 2024 13:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1713980089; x=
	1714066489; bh=vRuNAidZqsLlrAMITucjIXWpJfz3G/Qsuca+6EhZEB4=; b=L
	9Ab+mXILP81dyuf2mURRluQWGEgUOvxoMBIX+vy8geHxZidKoCLG8Nr65KZGuLbd
	K2Zqx0yYzZdqCQnyDA3bHnbVpvlmdJDQVbd2x8+X0xhOP3vz/tcFN2h9SeqevuZ1
	Pv7s8SysTaozJQL/6NVHCNbTInS0Wk90kUVyf9bqZfRBUS/kKQR+KeMscatsXFdJ
	cSb1rHKxexWgq8OnZX96h79YU3Y6WAZI9gZJCRT7Nap2UFMTCIuzw4WgG8pLkHdm
	G/MWN9AZt37UlUlTtrB/UyZzGA115Pu71vlWcGkyRb7c1rUq6nmuiXdSmQQRSPlM
	D36b8X2K5tix1u1nGZokw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713980089; x=
	1714066489; bh=vRuNAidZqsLlrAMITucjIXWpJfz3G/Qsuca+6EhZEB4=; b=R
	sUDyKco1TbsWxoH4z76fIcgcBtRyvpscyggITnQmuRXdgGd4lWvcaG93BZ9BzamI
	+4M8mNOdkY/B1pN+NDgY7qegAlv0pNc9ucJu9MPkl6q9ghUT9uMLDyOkzeF8zYRN
	BQoDaaLvyyp01oAzEtk1AFlGCBnNOCfqm1UipWkOAWPSs2o6Dmz0ciCj3y2Rswfi
	naaC0HIoHzgG3uBEGVFLGMD/Oadzf5DKR3Y3ZpQoOqnOa90HDPXcMdp5vpY/O0P4
	bTQeShXexj1dZbJr1dueDAHlPARsKJFjoHrfXEpYBvj6FTOBNavJ06maoojF8YRB
	4G9nlXrUZzZF8zi9S48Yw==
X-ME-Sender: <xms:uUIpZnMEqMY59TIx5e4jH587Sh9SlX_GZwcEnMk8FLu_f9sC9m4z5w>
    <xme:uUIpZh9Tg6XApIwEDEq5anFmHqz_4jeCM5_ooO_uglH1BfINfnPXMY56h954zLjvc
    jYodcMfIZANH0ZWSw>
X-ME-Received: <xmr:uUIpZmSWjO_eoD8wKLFOfjvuIoN5LKV-EsXgSWGffhkEJB_9ON7AHyyfjx5B2v98gBs998UygUmnCC7b83FssX_rIK4p9C0XFWMGLfNRE9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelhedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:uUIpZrtMDe92XGBg_gr0VPxXuQDLms2w2O9fRqyBz9NpRtmf6KzHXA>
    <xmx:uUIpZvdxQd6xSlZ1TSYOiP9BOrSfj83Np800dRa4tGyj-gK0N6GcdQ>
    <xmx:uUIpZn0M3DB89QGUMwHrViHJ7rcghnuHB0VJ13KbTTeJQQm-A63nnA>
    <xmx:uUIpZr8ww9ym_vNtJLdczObnrzKi6YEmGclAZT1bYDYk4bC8iyTuXQ>
    <xmx:uUIpZj4Sy87HfznfwGOFggVPII61UR0DdZfKLKtrSeN0ymk_P5dcK-d0>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 13:34:48 -0400 (EDT)
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
Subject: [PATCH dwarves v7 2/2] pahole: Inject kfunc decl tags into BTF
Date: Wed, 24 Apr 2024 11:33:52 -0600
Message-ID: <bd853cc2c6da4c29984b8751c0adf81a3ba0b8a3.1713980005.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713980005.git.dxu@dxuuu.xyz>
References: <cover.1713980005.git.dxu@dxuuu.xyz>
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
index 850e36f..d326404 100644
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
@@ -75,6 +90,7 @@ struct btf_encoder {
 			  verbose,
 			  force,
 			  gen_floats,
+			  skip_encoding_decl_tag,
 			  tag_kfuncs,
 			  is_rel;
 	uint32_t	  array_index_id;
@@ -94,6 +110,17 @@ struct btf_encoder {
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
 
@@ -1363,8 +1390,343 @@ out:
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
+	if (strlen(func) < 2) {
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
+	const char *filename = encoder->filename;
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
@@ -1377,6 +1739,15 @@ int btf_encoder__encode(struct btf_encoder *encoder)
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
@@ -1660,6 +2031,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->force		 = conf_load->btf_encode_force;
 		encoder->gen_floats	 = conf_load->btf_gen_floats;
 		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
+		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
-- 
2.44.0


