Return-Path: <bpf+bounces-27877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B148B8B2E0C
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 02:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55B01C22514
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 00:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E6A380;
	Fri, 26 Apr 2024 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="gVrhZ9Z4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fiB0GiXu"
X-Original-To: bpf@vger.kernel.org
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C3EBE
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091361; cv=none; b=qpuSDTIz+LE4GvIg0fv1jU08s0EtYd3JHgKTTE0TKqfqYqc1LQr/5WbjRuEtU7XlrXaaUkvx+Wz23WIhwcQ5IkgLScv5hf07DUXjM3TRJjkpmuxwtn7cZfE730iiqSdOHjnj9CRVEHJ5Q8X6Z5u83H6GZrSCz+BvaMhC20MynYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091361; c=relaxed/simple;
	bh=+1zRurmXTNb25e1fX9JWVoWUaLIaG8FI3UWP41oQr5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX7hEpOr25+rhlWeYKp6ZV7xKi6+GZ5laJdAi5ol3Da8lT9nOkk7ScVFxsAFjX0HE2f5dYj6urGQjzctQ2Cw0KuuXYIGjANcVK7MA/MgJ9azqtxOKE8ws6zzGJTKYYzx510JOgFLCIKOjdT9WuL5FPU7RVbh1A7CdHwteqtRFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=gVrhZ9Z4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fiB0GiXu; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id A7CCF1C0011C;
	Thu, 25 Apr 2024 20:29:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Apr 2024 20:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1714091357; x=
	1714177757; bh=rvXmPxpa/nUeVaXB3lKOgQrpGPNTVyW2igoGF6ftcLw=; b=g
	VrhZ9Z4ofk+zqCd4HJMVBlUchgwo4NjXyaqUBdZ+wX8QYQNcNHKKbg6Cq3wU92SZ
	IKR7ANH+fjV27lAeRLWEbkNK7Gct+J+FxTxS3E81Xw3ujLjp5I/unsqRm1QZhFO1
	/mhH9rH/Gu3xeFBwZNqDoA17rtbT/VBSYxEZxnCTg9SB4AdPM6zOKhEpW7xV064k
	0qOhBMNFDJYswlJYdLN/J4O6/YcO2O5CHpE0Z9lnvwYM1E4BR+44uifTbinmscqf
	yw4LU16/V0LfAzu3WzA1GgfwEx43MoeBceG+NucQ9066qpDOhotFZC69RgBgvka4
	Mewx5AOUnXOl1Pe7Ijf7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714091357; x=
	1714177757; bh=rvXmPxpa/nUeVaXB3lKOgQrpGPNTVyW2igoGF6ftcLw=; b=f
	iB0GiXulWCUurRX0rfYZbB5IOgg9DGcer9P95ojVOXcWd4JCMuHGJvaWZfSVSAG1
	67fKdaTzm10/y28HR48uOetsXw4zUh5sOUIw9pLqTjCD7qeTxbjhu2Q4rj3hqZNn
	Zv2uRSljXCIC1h8lVT83u5tHIUsl1dL+Mu1stcv4c/2iwuindsEet3L9sLJ9fVXh
	KVPMlqsLEigjUM+purNg5gWOgu92cQ0b2Wsd35zOJSJxEc1c0+BjBZj08MtyzH4h
	Cd0AxTqLBXjRPwE+ofAWHaCs4AZjl25cZJ5JvPU1gTDwjrRoqpe5Y5SHUdbl+D4W
	e6gigHOJnmMVockfDGWgQ==
X-ME-Sender: <xms:XPUqZnKEuTeu-9R_llpqHwlQVuY06psWtnGibdng_8Gbi0HUfRjGkQ>
    <xme:XPUqZrLsCaT34cbE__Sb8UQBpTTz_TlIpziWNjxFgMSf_uSwpGcl4OnRdBLGZPNoU
    X3ySLUfIrns2YZPtQ>
X-ME-Received: <xmr:XPUqZvsLWkpEa7OAuUsF0ChubhSwCX1DdMEsNdJqjMTaib1HqJSUFuBfY95P9J6qkx844tZxJRkO5tgKNgcjgu6QlcgMdWtXNy4wKMGkudI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelkedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:XPUqZgYIYon2fTwu87H-6m2KyeUXbsjEkBXXj9XTIADPwbdUuFjwEA>
    <xmx:XfUqZuaSvmcU2G1NA-TV10rDi-0BV8uCO573ADmgEKdC3yHnOilwkA>
    <xmx:XfUqZkDMDcWjgJ5cDUNENkIVmXdwaWnIJTS-yPiWcWfKU3_EoTYTXA>
    <xmx:XfUqZsYI_4kXxsIJvVy_eqR-VF3at_c-eHTOecoyTtOJuI5JkofI5g>
    <xmx:XfUqZkk2waVpvzZvSjzb8saKyTqF4CYGH4Hs4J8X6RO0bl-7My6tDHxk>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 20:29:16 -0400 (EDT)
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
Subject: [PATCH dwarves v8 3/3] pahole: Inject kfunc decl tags into BTF
Date: Thu, 25 Apr 2024 18:28:41 -0600
Message-ID: <1f82795e9ae651a3d303d498e2ce71540170b781.1714091281.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714091281.git.dxu@dxuuu.xyz>
References: <cover.1714091281.git.dxu@dxuuu.xyz>
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
index f0ef20a..02f0cbb 100644
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


