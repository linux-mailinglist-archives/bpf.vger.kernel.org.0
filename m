Return-Path: <bpf+bounces-18440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7881A902
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 23:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A2928DB37
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4FE49F91;
	Wed, 20 Dec 2023 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YuYyRBaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QqpZVnei"
X-Original-To: bpf@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8A8498AB
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 83CEA5C089D;
	Wed, 20 Dec 2023 17:20:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 20 Dec 2023 17:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1703110806; x=1703197206; bh=dXXygqrSmNsWtxlWdpGP7
	mjjyEs6GnFT6w2V/4mkzns=; b=YuYyRBaLypIE9YzyzZnDnlgF9oxRHh+yaHuZk
	DVq6i/WibX2ZEJcspP/pfpG5c7VwDqHgYDz0nlZWIZnvWSQsiau08XL7F7QR7Msh
	4dLT6MudAMFQRjZU7lkLc5rNgyLZ4D3uj6fXULf87qG0oY4s072pMEA06oGBpC+5
	YQNYmOYwig7pz64gy1OIAoSLCABsscOG7cOwOTjZ6GoWlVZL075NITG8ag7osjsz
	YyGkgrY47SjjyGVxUD1jDGu2k8bu4btNeIDtWtMiCtBfD3IOND9Hxmdkw0XXBHQN
	A2ihUOWaM6/XTf2jopayzi0hHTO8oTJPWvArdMztaKzLNuqbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703110806; x=1703197206; bh=dXXygqrSmNsWtxlWdpGP7mjjyEs6
	GnFT6w2V/4mkzns=; b=QqpZVneij+Qc+rW5wDqaoCKYKCVT21evdeQMTrwFdXmM
	ZicYp6lj9mHS0Dm2khL4TknQkHqG+2RDSPbAvEr+NTcA9Jnksj43StAwNU/LFzli
	KkEMQW4d+07aLUaccYLD2Q5tYm42tGvTKD2hq3IxDJU6k9IjFXcFPjUuQWf6p53o
	m3BbNPInRMQh01nRP7Wy48zrL8+D+w2+7rJG785ZSlFTMT+YT2BA30oncJjgtSgq
	PUNPIVzPsEuyUhB4ADzhcIv1MbDra6aOuVAA+f2azFdqZLMlj3pZBt8zzOSRpnHB
	GfVtj6/E5/U+XN0L2X8TiGiurcinz3+eri1K7kG+XQ==
X-ME-Sender: <xms:lmiDZT8VFrgNKlBUxfwRFVqU02krX7UAg0dBueUdYqWQR6zj9RKj-Q>
    <xme:lmiDZfvBh7gT-q08qASsAWjO7yBPIsHYJJ6ywSQaYN9KTbd8mTo2dHXFoSHaMf_8Q
    Ff-NEzTilf4XEOADg>
X-ME-Received: <xmr:lmiDZRBy2f64dRl1yIpeUA5ZvuW9l5M6epyf3WnPQxLs4YSlofVwEKwLNC2Ys4mVYXFB9kUjET1dsgsmXSCcu71tbZhdbGa1m-4H2Ez-NCAYcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvgefgtefgleehhfeufe
    ekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:lmiDZfdcsyofidWELjN038DdrJFPwIHUz07kUyWOo6jJG05T3Y_8FA>
    <xmx:lmiDZYND3HVWMzeH7G7TQ5QBh8NhkeHJxrwRhpSs6UWZrn1tpdCoCA>
    <xmx:lmiDZRkNG2sP8btxIKPE5QW672q-0-xcV-oPpCir8wegha07rRXtEw>
    <xmx:lmiDZX3sfD_GPRffJh2w3251rnnsPrHBO_gbq2McFFBfpXsD-Jjvyg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 17:20:05 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Date: Wed, 20 Dec 2023 15:19:52 -0700
Message-ID: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
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

This enables downstream users and tools to dynamically discover which
kfuncs are available on a system by parsing vmlinux or module BTF, both
available in /sys/kernel/btf.

Example of encoding:

        $ bpftool btf dump file .tmp_vmlinux.btf | rg DECL_TAG | wc -l
        388

        $ bpftool btf dump file .tmp_vmlinux.btf | rg 68940
        [68940] FUNC 'bpf_xdp_get_xfrm_state' type_id=68939 linkage=static
        [128124] DECL_TAG 'kfunc' type_id=68940 component_idx=-1

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 btf_encoder.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index fd04008..2697214 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -34,6 +34,9 @@
 #include <pthread.h>
 
 #define BTF_ENCODER_MAX_PROTO	512
+#define BTF_IDS_SECTION		".BTF_ids"
+#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
+#define BTF_KFUNC_TYPE_TAG	"kfunc"
 
 /* state used to do later encoding of saved functions */
 struct btf_encoder_state {
@@ -1352,6 +1355,200 @@ out:
 	return err;
 }
 
+/*
+ * Parse BTF_ID symbol and return the kfunc name.
+ *
+ * Returns:
+ *	Callee-owned string containing kfunc name if successful.
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
+static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, const char *kfunc)
+{
+	int nr_types, type_id, err = -1;
+	struct btf *btf = encoder->btf;
+
+	nr_types = btf__type_cnt(btf);
+	for (type_id = 1; type_id < nr_types; type_id++) {
+		const struct btf_type *type;
+		const char *name;
+
+		type = btf__type_by_id(btf, type_id);
+		if (!type) {
+			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
+				__func__, type_id);
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
+			goto out;
+		}
+
+		if (strcmp(name, kfunc))
+		    continue;
+
+		err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, type_id, -1);
+		if (err < 0) {
+			fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
+				__func__, kfunc, err);
+			goto out;
+		}
+
+		err = 0;
+		break;
+	}
+
+out:
+	return err;
+}
+
+static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
+{
+	const char *filename = encoder->filename;
+	GElf_Shdr shdr_mem, *shdr;
+	int symbols_shndx = -1;
+	int idlist_shndx = -1;
+	Elf_Scn *scn = NULL;
+	Elf_Data *symbols;
+	int fd, err = -1;
+	size_t strtabidx;
+	Elf *elf = NULL;
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
+		shdr = gelf_getshdr(scn, &shdr_mem);
+		if (shdr == NULL) {
+			elf_error("Failed to get ELF section(%d) hdr", i);
+			goto out;
+		}
+
+		secname = elf_strptr(elf, strndx, shdr->sh_name);
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
+		if (shdr->sh_type == SHT_SYMTAB) {
+			symbols_shndx = i;
+			symbols = data;
+			strtabidx = shdr->sh_link;
+		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
+			idlist_shndx = i;
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
+	scn = elf_getscn(elf, symbols_shndx);
+	if (!scn) {
+		elf_error("Failed to get ELF symbol table");
+		goto out;
+	}
+
+	shdr = gelf_getshdr(scn, &shdr_mem);
+	if (!shdr) {
+		elf_error("Failed to get ELF symbol table header");
+		goto out;
+	}
+
+	nr_syms = shdr->sh_size / shdr->sh_entsize;
+	for (i = 0; i < nr_syms; i++) {
+		char *kfunc, *name;
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
+	return err;
+}
+
 int btf_encoder__encode(struct btf_encoder *encoder)
 {
 	int err;
@@ -1366,6 +1563,11 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	if (btf__type_cnt(encoder->btf) == 1)
 		return 0;
 
+	if (btf_encoder__tag_kfuncs(encoder)) {
+		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
+		return -1;
+	}
+
 	if (btf__dedup(encoder->btf, NULL)) {
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
-- 
2.42.1


