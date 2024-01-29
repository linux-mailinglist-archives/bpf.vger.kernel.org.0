Return-Path: <bpf+bounces-20534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E783FBD2
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 02:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EF41C2106D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98DDDC1;
	Mon, 29 Jan 2024 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="uf1PSJc4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cu1bLcdt"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A99DDA0
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706491833; cv=none; b=fTwzt0Yyy1k8x15Dzj74vF0kqZtBLnLREecR5OdysTh3vJnBBfhHo91K1FvC8uGsh/0jlOmJ6Vxl+DkctCMgJwiLxytGuw7UsGHbSCnvbdS/w3M4Fz+uWVSIT/KgpbxmnpgZMWSX2kyzFQPEdkNFj3XA9Y/6xWT2pKUMVpyU7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706491833; c=relaxed/simple;
	bh=oj5FWZ7y935nnq5OXl2PilJRRYz0/U4SKTNMvq3c1VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pi673PuM0zjEpGREucL7xPrfaGtb6ZqljEXBAXV1LjbggAjDiVCaw4q8VUeikf+XD23/4APITTf8dFEpBQbguF0LYPyAB4gV6oZF9EL+aCpudJ1GnDvujvEWMSx0Gu9KsGrtw8F5wKOjpYk5C2wUv23x2LJ7C4WCrJ4X8HRWLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=uf1PSJc4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cu1bLcdt; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 86BED3200A16;
	Sun, 28 Jan 2024 20:30:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 28 Jan 2024 20:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1706491830; x=1706578230; bh=HhirP/F5MiUHQGjnIdvlP
	MBZ9mYyPChXmEcBuGPlzeU=; b=uf1PSJc4Zi7teKfpR3tdAY3DI9gHxIYim5XxD
	PEQB1wurpyf+OrI3xImYqMHV3m8Ur1wSyIHiijlt3kx4tEw/AD9zkw+Zdw1JJt9t
	WuDSA36xBWUXMB42TDJlOfCkM+z5vyETj+DBwkeZ1o5N77W3ejlecJkvZyrQ3Sp+
	dlzMxdYsxpwJ7ICAQSLe/C3E3poC1Vk+m+18sGq89i9QxMmNmtX2VOSeSUN+giJa
	CA16f91ywn76z6tap9umsCdDjGZ+E8Dl2nKdUDN9HCqBL5XkVMJ6CjWX6QgEvIxU
	WrpKKox9ZsivUV06seTGJ28kDx0rz2/iV7wjrGOGMQlpyH0yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706491830; x=1706578230; bh=HhirP/F5MiUHQGjnIdvlPMBZ9mYy
	PChXmEcBuGPlzeU=; b=Cu1bLcdtUeEXPzHtahRqprv1laTaD/Cytlu8xxG84/4S
	lboiMvKVk2bhC9Jk9IMmZHDG0oic6orUWZ4iTOwZz526BJ8lG8wob4XKIwdO4qmK
	dY6QJn3WrZV0UUi62le+tkEkwCN4+EcsqWWEEco6KbPoqA7GYrfXHe4iuY9UHbl7
	vBQ+3l6g7GzzveNUz/Mt2TVkN1fFplqKKvv1y2EfSTQ8qKU1xjuMFZT8IPqSJMvH
	K3rJn4gi/t5PN5tNIKFTVPT/Rv1OK9vHeSRCvg3fSY457v93U+vsUvHlK66oTiXB
	+qkDC7UgPz9404cwJdJou5hKs7xvzzcMZc6SObkv1g==
X-ME-Sender: <xms:tf-2ZRp2jvCUHyg5tbjEqnilX953BEtOrXSY343WuRffQj5tk5obUg>
    <xme:tf-2ZTrBsR5Lr_-KNw0wc_d-A8WqdPZVmk87-RIXvvI6j9epFe8p9zuP9SByxSmTt
    I0s28fzKacX_TQw5w>
X-ME-Received: <xmr:tf-2ZeO5ISrV9ovZLMTCdDN7G4OyJaJ4mP-EM_mHqFsecCvzebFCSCINS9x0WtM202LDm7JaA8Z8CM2tgcVGOg0EHdrgas55XZMibRgm-oZkKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtfedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:tf-2Zc6DhbmsFLHlc8OLZnLtbfHbDwdehnDtRPH2aafpr3gYPin1YA>
    <xmx:tf-2ZQ73b1Ssy3M3bEQpMkubqpT68lMdsc5p_WXt6ZEeRR98EqglyA>
    <xmx:tf-2ZUhhcfEJJsgdQu92A8VjqPMQRXv3fMQaBbslDFNCabk8PapW1A>
    <xmx:tv-2ZaQLTdy_tjqnxdGhEBfrROuEyZ2Z10rAaTFlzdVwTWeWzM2Wcw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jan 2024 20:30:28 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves v3] pahole: Inject kfunc decl tags into BTF
Date: Sun, 28 Jan 2024 18:30:19 -0700
Message-ID: <0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
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

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

---
Changes from v2:
* More reliably detect kfunc membership in set8 by tracking set addr ranges
* Rename some variables/functions to be more clear about kfunc vs func

Changes from v1:
* Fix resource leaks
* Fix callee -> caller typo
* Rename btf_decl_tag from kfunc -> bpf_kfunc
* Only grab btf_id_set funcs tagged kfunc
* Presort btf func list

 btf_encoder.c | 347 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 347 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index fd04008..4f742b1 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -34,6 +34,11 @@
 #include <pthread.h>
 
 #define BTF_ENCODER_MAX_PROTO	512
+#define BTF_IDS_SECTION		".BTF_ids"
+#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
+#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
+#define BTF_SET8_KFUNCS		(1 << 0)
+#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
 
 /* state used to do later encoding of saved functions */
 struct btf_encoder_state {
@@ -79,6 +84,7 @@ struct btf_encoder {
 			  gen_floats,
 			  is_rel;
 	uint32_t	  array_index_id;
+	struct gobuffer   btf_funcs;
 	struct {
 		struct var_info vars[MAX_PERCPU_VAR_CNT];
 		int		var_cnt;
@@ -94,6 +100,17 @@ struct btf_encoder {
 	} functions;
 };
 
+struct btf_func {
+	const char *name;
+	int	    type_id;
+};
+
+/* Half open interval representing range of addresses containing kfuncs */
+struct btf_kfunc_set_range {
+	size_t start;
+	size_t end;
+};
+
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
 
@@ -1352,6 +1369,327 @@ out:
 	return err;
 }
 
+/* Returns if `sym` points to a kfunc set */
+static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
+{
+	int *ptr = idlist->d_buf;
+	int idx, flags;
+	bool is_set8;
+
+	/* kfuncs are only found in BTF_SET8's */
+	is_set8 = !strncmp(name, BTF_ID_SET8_PFX, sizeof(BTF_ID_SET8_PFX) - 1);
+	if (!is_set8)
+		return false;
+
+	idx = sym->st_value - idlist_addr;
+	if (idx >= idlist->d_size) {
+		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
+		return false;
+	}
+
+	/* Check the set8 flags to see if it was marked as kfunc */
+	idx = idx / sizeof(int);
+	flags = ptr[idx + 1];
+	return flags & BTF_SET8_KFUNCS;
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
+	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
+		return NULL;
+
+	/* Strip prefix */
+	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
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
+static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder)
+{
+	struct gobuffer *funcs = &encoder->btf_funcs;
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
+	qsort((void *)gobuffer__entries(funcs), gobuffer__nr_entries(funcs),
+	      sizeof(struct btf_func), btf_func_cmp);
+
+	err = 0;
+out:
+	return err;
+}
+
+static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, const char *kfunc)
+{
+	struct btf_func key = { .name = kfunc };
+	struct btf *btf = encoder->btf;
+	struct btf_func *target;
+	const void *base;
+	unsigned int cnt;
+	int err = -1;
+
+	base = gobuffer__entries(&encoder->btf_funcs);
+	cnt = gobuffer__nr_entries(&encoder->btf_funcs);
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
+	Elf_Scn *symscn = NULL;
+	int symbols_shndx = -1;
+	int fd = -1, err = -1;
+	int idlist_shndx = -1;
+	Elf_Scn *scn = NULL;
+	size_t idlist_addr;
+	Elf_Data *symbols;
+	Elf_Data *idlist;
+	size_t strtabidx;
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
+	/* Location symbol table and .BTF_ids sections */
+	elf_getshdrstrndx(elf, &strndx);
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
+	err = btf_encoder__collect_btf_funcs(encoder);
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
+			if (ranges[j].start <= addr && addr < ranges[j].end) {
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			continue;
+
+		err = btf_encoder__tag_kfunc(encoder, func);
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
 	int err;
@@ -1366,6 +1704,14 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	if (btf__type_cnt(encoder->btf) == 1)
 		return 0;
 
+	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
+	 * take care to call this before btf_dedup().
+	 */
+	if (btf_encoder__tag_kfuncs(encoder)) {
+		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
+		return -1;
+	}
+
 	if (btf__dedup(encoder->btf, NULL)) {
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
@@ -1712,6 +2058,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 
 	btf_encoders__delete(encoder);
 	__gobuffer__delete(&encoder->percpu_secinfo);
+	__gobuffer__delete(&encoder->btf_funcs);
 	zfree(&encoder->filename);
 	btf__free(encoder->btf);
 	encoder->btf = NULL;
-- 
2.42.1


