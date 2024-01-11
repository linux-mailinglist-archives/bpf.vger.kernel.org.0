Return-Path: <bpf+bounces-19350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFCA82A578
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 02:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6541F241D3
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 01:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD376642;
	Thu, 11 Jan 2024 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="blWKCJb5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6qbys8UN"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5643393
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 38ADB3200B2E;
	Wed, 10 Jan 2024 20:14:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Jan 2024 20:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1704935673; x=1705022073; bh=nU6UHq0Mdw8aLMpakLjSb
	tsUPdN/kDXb+cvXQ3/kF5Y=; b=blWKCJb584jRj7uS6XAuzm6QgyLySDi74NmAj
	y0a0RHqq1iizmduPMQ0/8lMtP5cqCRcIiJn1Umjf0p6UNPIFTkEi2zxmN5pkORo8
	Newf3r2Su0rYy2p3sqq1pdbJF3U/+eoG5t1S80sOeW67mHNqh1Ex+tD4T5K6utQp
	ytYRhLPibs5cZYS2R64KZAwQZR/dWSMIXWBTg6qPH0m82Mg6koR06hoqYxxQ02FY
	P+XtMT/i6kcXWjIYI+yVAJHV0NWBjCqXrhPZQKQeXGHLl+reRK9UklTgRVx9PGpC
	xg13XeMDi7p3EFKs8FP87bdBIg/RkGJEIgul7PLNo/DmnEfqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704935673; x=1705022073; bh=nU6UHq0Mdw8aLMpakLjSbtsUPdN/
	kDXb+cvXQ3/kF5Y=; b=6qbys8UN09jI2hDHGGdEAFnY+em4SJnnSjQNEUVxF724
	NSYWJIhv9USDUm5lznKbvspEZ/by5xcqmb2hEmWD4LJkcitribMpHHPC5uOC4nNl
	ZMQUUncbcryJ5ydEyQURYjXkSvW5PkKR1f5mOeEvU6dAhIZsNUWaKczcIW2NZwHV
	smQ8xIPe8cuKxrmPGg6Y3fo9GA5y56nRqA/IO0UxvG9weKkyEN33mt86VMMvIXC0
	S8jT8mwfinw36HSvcPZHsxHyMCHs6/2kSO/xsSq34VPwAIWi6ABa/651V+Rnw/kp
	rhBpGx4CVDMy10q6tqpse6aJJeKMuN0yirvFHDsDtw==
X-ME-Sender: <xms:-UCfZeDBoLFCFUYrPlswGTw_a26VY3aBls3-SvESwVrRcVVwUMPW2A>
    <xme:-UCfZYjoF1JCEkqNo3awCOPzSZgQ1Rmc_C0B6vPrkPkRSEuRv4kJcPXy7THIwnKM1
    utI1ZyeoQ0-QuRiPQ>
X-ME-Received: <xmr:-UCfZRmK2LO-sTJCGRfMcm-yiBSX1o5ysNBG32ihMsTfnTdvNC8zwoBRAn-uVNQ4LWE-GDn8rv5XvJJnp6Oqk_0ILpOQ1X8mnwRMWi1BYxf_AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:-UCfZcyuNGGpWhN1HSVZDFv1o2Md72LpF6qEfM82I-k_2whYY8bEzA>
    <xmx:-UCfZTR5zQDUdq-cUF978HETmq51FAQIn_kWJbGBhVEJX3Oa8wfDTQ>
    <xmx:-UCfZXbvN0deJD5iKcr-wWsf0PysEzo1b38LIpuHJdf42p_g__V8Yg>
    <xmx:-UCfZUKmUj8i2d949CmKibfyfnvw8SnFQfLB8OV08-oDZr-Ek7YBOg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 20:14:32 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves v2] pahole: Inject kfunc decl tags into BTF
Date: Wed, 10 Jan 2024 18:14:25 -0700
Message-ID: <85caea4c48659502544329e6cd8b41c12ab50dfc.1704929857.git.dxu@dxuuu.xyz>
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
        120

        $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
        [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
        [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1

This enables downstream users and tools to dynamically discover which
kfuncs are available on a system by parsing vmlinux or module BTF, both
available in /sys/kernel/btf.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

---
Changes from v1:
* Fix resource leaks
* Fix callee -> caller typo
* Rename btf_decl_tag from kfunc -> bpf_kfunc
* Only grab btf_id_set funcs tagged kfunc
* Presort btf func list

 btf_encoder.c | 324 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 324 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index fd04008..2a4d4b4 100644
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
@@ -94,6 +100,11 @@ struct btf_encoder {
 	} functions;
 };
 
+struct btf_func {
+	const char *name;
+	int	    type_id;
+};
+
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
 
@@ -1352,6 +1363,310 @@ out:
 	return err;
 }
 
+/*
+ * If `sym` is a set8, returns the number of entries in the set8.
+ *
+ * Returns:
+ *	0 if `sym` does not point to a set8.
+ *	Negative on error.
+ */
+static int get_kfunc_set_cnt(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
+{
+	int *ptr = idlist->d_buf;
+	bool is_kfunc, is_set8;
+	int idx, flags;
+
+	/* kfuncs are only found in BTF_SET8's */
+	is_set8 = !strncmp(name, BTF_ID_SET8_PFX, sizeof(BTF_ID_SET8_PFX) - 1);
+	if (!is_set8)
+		return 0;
+
+	idx = sym->st_value - idlist_addr;
+	if (idx >= idlist->d_size) {
+		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
+		return -1;
+	}
+
+	/* Check the set8 flags to see if it was marked as kfunc */
+	idx = idx / sizeof(int);
+	flags = ptr[idx + 1];
+	is_kfunc = flags & BTF_SET8_KFUNCS;
+	if (!is_kfunc)
+		return 0;
+
+	return sym->st_size / sizeof(uint64_t) - 1;
+}
+
+/*
+ * Parse BTF_ID symbol and return the kfunc name.
+ *
+ * Returns:
+ *	Caller-owned string containing kfunc name if successful.
+ *	NULL if !kfunc or on error.
+ */
+static char *get_kfunc_name(const char *sym)
+{
+	char *kfunc, *end;
+
+	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
+		return NULL;
+
+	/* Strip prefix */
+	kfunc = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
+
+	/* Strip suffix */
+	end = strrchr(kfunc, '_');
+	if (!end || *(end - 1) != '_') {
+		free(kfunc);
+		return NULL;
+	}
+	*(end - 1) = '\0';
+
+	return kfunc;
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
+	int set_cnt = 0;
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
+	/*
+	 * Look for __BTF_ID__func__ symbols in .BTF_ids section and
+	 * inject BTF decl tags for each of them.
+	 */
+	if (!gelf_getshdr(symscn, &shdr)) {
+		elf_error("Failed to get ELF symbol table header");
+		goto out;
+	}
+
+	err = btf_encoder__collect_btf_funcs(encoder);
+	if (err) {
+		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
+		goto out;
+	}
+
+	nr_syms = shdr.sh_size / shdr.sh_entsize;
+	for (i = 0; i < nr_syms; i++) {
+		char *kfunc, *name;
+		int new_set_cnt;
+		GElf_Sym sym;
+		int err;
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
+		new_set_cnt = get_kfunc_set_cnt(&sym, name, idlist, idlist_addr);
+		if (new_set_cnt < 0) {
+			err = new_set_cnt;
+			goto out;
+		} else if (new_set_cnt) {
+			if (set_cnt)
+				fprintf(stderr, "%s: warning: overlapping set8 '%s'\n",
+					__func__, name);
+			set_cnt = new_set_cnt;
+			continue;
+		}
+
+		if (!set_cnt)
+			continue;
+		set_cnt--;
+
+		kfunc = get_kfunc_name(name);
+		if (!kfunc)
+			continue;
+
+		err = btf_encoder__tag_kfunc(encoder, kfunc);
+		if (err) {
+			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, kfunc);
+			free(kfunc);
+			goto out;
+		}
+		free(kfunc);
+	}
+
+	err = 0;
+out:
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
@@ -1366,6 +1681,14 @@ int btf_encoder__encode(struct btf_encoder *encoder)
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
@@ -1712,6 +2035,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 
 	btf_encoders__delete(encoder);
 	__gobuffer__delete(&encoder->percpu_secinfo);
+	__gobuffer__delete(&encoder->btf_funcs);
 	zfree(&encoder->filename);
 	btf__free(encoder->btf);
 	encoder->btf = NULL;
-- 
2.42.1


