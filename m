Return-Path: <bpf+bounces-74737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B577C645A6
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCCDA4EA850
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10592334699;
	Mon, 17 Nov 2025 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZoXMYHy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B7332ED8
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386002; cv=none; b=VapZcogAtKy4ft/fayeMgxmM8Zu5c2okeslj0imbFL8jNnpcUf55VJXrUxCCoQUy2aXFZdcsAPQO+i6BuyfKStas//kyHqOFW8fKN1N4PlGiqb2DBV3e5CdUKb5Q5JUR2nfuOM9IcpY1WD+pfoesG9sHjzv3IHcPBGJ9e1WM3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386002; c=relaxed/simple;
	bh=gKhZlZG9Uptrdn86em/7HgNFouQXhzpq2vdn6XCl1dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ghAFcC9zKAr7gIetZp13kz15yyMRkSXqKLOx0F1+aYME2gfeDCw91UHQ/U5dcnj+yftyxZMuxWByRyYEbhm4t4uohndZNfsKuNFvW+PS12Krk1DyyX6xt/q3MCifNeeI+vEI4RG2EByg0BUJbwHEPy628xFMciKw3A3N5yHIEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZoXMYHy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3410c86070dso3212623a91.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 05:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763386000; x=1763990800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjdSgxLBu++Fq6ABtVyHLvDR0wgeK7sjNIs7L3tmdN8=;
        b=KZoXMYHygxsgjfcj3iiWtF3l0jGoAHL4DA0/mT/F+49ky2EP7wefpHtKNVBe5kO5HR
         9H2LgG+qGuG1cVk+Naah/JXTF6hgyad/La8MwCto3PwTtdTpHauDh/Q4yuoJh0qu55m+
         Py1IJ22QqMit+hBEzg/nccf8zHL8HhoU7TFB78hNZdAxzRS4XTQsO1MHrH/+JGPI1hxY
         /B60ne+TPKGZQ9WCl6Zzi1MviMNbkRGOraQtEOnc1pIMSnXKGzUKDpmnGTx4Wt5v6YHy
         3BaE9xuGDJMpnx/unqkA7dfpPuKUjkMzveJp0NpMxaJbZkoEz17UdE8/+T8YKm+Ux8CI
         u2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763386000; x=1763990800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mjdSgxLBu++Fq6ABtVyHLvDR0wgeK7sjNIs7L3tmdN8=;
        b=C3WOntGO2T7SYyxH7Evk1Gy6ghpal+l1C06QyvYH59Gg80hPGvgUZ9y79keHnRv/jz
         S2kPnKX5vECCXGptrJYMQ+VhIY//Cp9xW/AR64tKk7iBQjgOMmHitfI+Ax1CJGZAtlzV
         OZMdGBj+Dpg5EW0GTCE6Uz8ryMxmOFnYrkn9OIEqueg/Yt71wcFlJr1Y9eGJf79kUmO6
         SuEz6zGjtINix+PzGN3EO4FAfnHCEVgeAnP6s3BE6t0B1zVTMixii1BPNKXjFvOtlbRj
         PAkx1h/WLkNVhvK2rq8/bEIXJLBT+Whgp+aFFlEF+HZQYBS8BBqGfg8FSjevquYf78Vi
         5B2A==
X-Forwarded-Encrypted: i=1; AJvYcCVZCHyrcd+SpcKZBijq3zrHMKQGbHrwYv0EF8pD+cSh0GW6MeZ+RNE1kvLLAe6LXMHlaGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/GHqCsBfTiLtYxuaLM39JrpuQfsBPXRgtujU1SFfqrvSI41G
	+nR/LME2h596ldTQ/hXRV9tEnk4NH7BXm1pNb6NsdbLKnk/JSx5+PdWZ
X-Gm-Gg: ASbGncso/dOzSX1QDMRwr6xs2yrIT4jXXNhLBIiL6ADuOxZREo9dYVV0xD6+Tn5W+in
	yqxuETfvIdZaYVID1y+EyF1MksOo8sNqhVRc9rQhT5gs/k1Ar8R+Gvp7k4gDeXgYZ6I1d1sZgVS
	M2K3EkSfmlwu8glIbMotWeRfC75wR+U43kpnN7ZLUdVSXOXp9mtaUiCcTvDuJfb5uyJlKL8YqVA
	baXuXcvE/SqEHDhHTk08jlPsrJECrMdrcxlDtN+44MEVOhbZrI13WnV2DYUlzptA7E1i0T0QW4W
	73LWqDwJKeOgLvipcNHn+LDf8Od9Fc13QHK8ibgNM4xFqlkyhMY88od6h2DScwG0FNC/s5quTlX
	vY4KiUUS4eD1C9SVCsAaaSv8LupQ9jGpC9uMuuGUyYnsZG8tjnzGKtOB3PKnWcQpvFGNOpbD+Q8
	dlGd5jesvKS2jWjFbL
X-Google-Smtp-Source: AGHT+IEhHi7O4yt0EMTyloFaD8KlYsdb2aEOshF+gKxXsgJ79nlgnHKhh5nGs3RcG3o+qFAumLcqCw==
X-Received: by 2002:a17:90b:1807:b0:340:ac7c:6387 with SMTP id 98e67ed59e1d1-343f9e90659mr16368075a91.7.1763386000187;
        Mon, 17 Nov 2025 05:26:40 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924cd89bcsm13220953b3a.15.2025.11.17.05.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:26:39 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v6 3/7] tools/resolve_btfids: Add --btf_sort option for BTF name sorting
Date: Mon, 17 Nov 2025 21:26:19 +0800
Message-Id: <20251117132623.3807094-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117132623.3807094-1-dolinux.peng@gmail.com>
References: <20251117132623.3807094-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

This patch introduces a new --btf_sort option that leverages libbpf's
btf__permute interface to reorganize BTF layout. The implementation
sorts BTF types by name in ascending order, placing anonymous types at
the end to enable efficient binary search lookup.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 scripts/Makefile.btf            |   2 +
 scripts/Makefile.modfinal       |   1 +
 scripts/link-vmlinux.sh         |   1 +
 tools/bpf/resolve_btfids/main.c | 203 ++++++++++++++++++++++++++++++++
 4 files changed, 207 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index db76335dd917..d5eb4ee70e88 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -27,6 +27,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
 
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
+module-resolve_btfid-flags-y = --distilled_base
 endif
 
 endif
@@ -35,3 +36,4 @@ pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
 export PAHOLE_FLAGS := $(pahole-flags-y)
 export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
+export MODULE_RESOLVE_BTFID_FLAGS := $(module-resolve_btfid-flags-y)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 542ba462ed3e..4481dda2f485 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -40,6 +40,7 @@ quiet_cmd_btf_ko = BTF [M] $@
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	else								\
 		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
+		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $(MODULE_RESOLVE_BTFID_FLAGS) --btf_sort $@;	\
 		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
 	fi;
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 433849ff7529..f21f6300815b 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -288,6 +288,7 @@ if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	if is_enabled CONFIG_WERROR; then
 		RESOLVE_BTFIDS_ARGS=" --fatal_warnings "
 	fi
+	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} --btf_sort "${VMLINUX}"
 	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} "${VMLINUX}"
 fi
 
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d47191c6e55e..778909fe2faa 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -768,6 +768,198 @@ static int symbols_patch(struct object *obj)
 	return err < 0 ? -1 : 0;
 }
 
+/* Anonymous types (with empty names) are considered greater than named types
+ * and are sorted after them. Two anonymous types are considered equal. Named
+ * types are compared lexicographically.
+ */
+static int cmp_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	const struct btf_type *ta = btf__type_by_id(btf, *(__u32 *)a);
+	const struct btf_type *tb = btf__type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+
+	if (!ta->name_off && tb->name_off)
+		return 1;
+	if (ta->name_off && !tb->name_off)
+		return -1;
+	if (!ta->name_off && !tb->name_off)
+		return 0;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	return strcmp(na, nb);
+}
+
+static int update_elf(const char *path, const struct btf *btf,
+				  const char *btf_secname)
+{
+	GElf_Shdr shdr_mem, *shdr;
+	Elf_Data *btf_data = NULL;
+	Elf_Scn *scn = NULL;
+	Elf *elf = NULL;
+	const void *raw_btf_data;
+	uint32_t raw_btf_size;
+	int fd, err = -1;
+	size_t strndx;
+
+	fd = open(path, O_RDWR);
+	if (fd < 0) {
+		pr_err("FAILED to open %s\n", path);
+		return -1;
+	}
+
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		pr_err("FAILED to set libelf version");
+		goto out;
+	}
+
+	elf = elf_begin(fd, ELF_C_RDWR, NULL);
+	if (elf == NULL) {
+		pr_err("FAILED to update ELF file");
+		goto out;
+	}
+
+	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
+
+	elf_getshdrstrndx(elf, &strndx);
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		char *secname;
+
+		shdr = gelf_getshdr(scn, &shdr_mem);
+		if (shdr == NULL)
+			continue;
+		secname = elf_strptr(elf, strndx, shdr->sh_name);
+		if (strcmp(secname, btf_secname) == 0) {
+			btf_data = elf_getdata(scn, btf_data);
+			break;
+		}
+	}
+
+	raw_btf_data = btf__raw_data(btf, &raw_btf_size);
+
+	if (btf_data) {
+		if (raw_btf_size != btf_data->d_size) {
+			pr_err("FAILED: size mismatch");
+			goto out;
+		}
+
+		btf_data->d_buf = (void *)raw_btf_data;
+		btf_data->d_type = ELF_T_WORD;
+		elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
+
+		if (elf_update(elf, ELF_C_WRITE) >= 0)
+			err = 0;
+	}
+
+out:
+	if (fd != -1)
+		close(fd);
+	if (elf)
+		elf_end(elf);
+	return err;
+}
+
+static int sort_update_btf(struct object *obj, bool distilled_base)
+{
+	struct btf *base_btf = NULL;
+	struct btf *btf = NULL;
+	int start_id = 0, nr_types, id;
+	int err = 0, offs, i;
+	__u32 *permute_ids = NULL, *id_map = NULL, btf_size;
+	const void *btf_data;
+	int fd;
+
+	if (obj->base_btf_path) {
+		base_btf = btf__parse(obj->base_btf_path, NULL);
+		err = libbpf_get_error(base_btf);
+		if (err) {
+			pr_err("FAILED: load base BTF from %s: %s\n",
+			       obj->base_btf_path, strerror(-err));
+			return -1;
+		}
+	}
+
+	btf = btf__parse_elf_split(obj->path, base_btf);
+	err = libbpf_get_error(btf);
+	if (err) {
+		pr_err("FAILED: load BTF from %s: %s\n", obj->path, strerror(-err));
+		goto out;
+	}
+
+	if (base_btf)
+		start_id = btf__type_cnt(base_btf);
+	nr_types = btf__type_cnt(btf) - start_id;
+	if (nr_types < 2)
+		goto out;
+
+	offs = base_btf ? 0 : 1;
+
+	permute_ids = calloc(nr_types, sizeof(*permute_ids));
+	if (!permute_ids) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	id_map = calloc(nr_types, sizeof(*id_map));
+	if (!id_map) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0, id = start_id; i < nr_types; i++, id++)
+		permute_ids[i] = id;
+
+	qsort_r(permute_ids + offs, nr_types - offs, sizeof(*permute_ids),
+		cmp_type_names, btf);
+
+	for (i = 0; i < nr_types; i++) {
+		id = permute_ids[i] - start_id;
+		id_map[id] = i + start_id;
+	}
+
+	err = btf__permute(btf, id_map, nr_types, NULL);
+	if (err) {
+		pr_err("FAILED: btf permute: %s\n", strerror(-err));
+		goto out;
+	}
+
+	if (distilled_base) {
+		struct btf *new_btf = NULL, *distilled_base = NULL;
+
+		if (btf__distill_base(btf, &distilled_base, &new_btf) < 0) {
+			pr_err("FAILED to generate distilled base BTF: %s\n",
+				strerror(errno));
+			goto out;
+		}
+
+		err = update_elf(obj->path, new_btf, BTF_ELF_SEC);
+		if (!err) {
+			err = update_elf(obj->path, distilled_base, BTF_BASE_ELF_SEC);
+			if (err < 0)
+				pr_err("FAILED to update '%s'\n", BTF_BASE_ELF_SEC);
+		} else {
+			pr_err("FAILED to update '%s'\n", BTF_ELF_SEC);
+		}
+
+		btf__free(new_btf);
+		btf__free(distilled_base);
+	} else {
+		err = update_elf(obj->path, btf, BTF_ELF_SEC);
+		if (err < 0) {
+			pr_err("FAILED to update '%s'\n", BTF_ELF_SEC);
+			goto out;
+		}
+	}
+
+out:
+	free(permute_ids);
+	free(id_map);
+	btf__free(base_btf);
+	btf__free(btf);
+	return err;
+}
+
 static const char * const resolve_btfids_usage[] = {
 	"resolve_btfids [<options>] <ELF object>",
 	NULL
@@ -787,6 +979,8 @@ int main(int argc, const char **argv)
 		.sets     = RB_ROOT,
 	};
 	bool fatal_warnings = false;
+	bool btf_sort = false;
+	bool distilled_base = false;
 	struct option btfid_options[] = {
 		OPT_INCR('v', "verbose", &verbose,
 			 "be more verbose (show errors, etc)"),
@@ -796,6 +990,10 @@ int main(int argc, const char **argv)
 			   "path of file providing base BTF"),
 		OPT_BOOLEAN(0, "fatal_warnings", &fatal_warnings,
 			    "turn warnings into errors"),
+		OPT_BOOLEAN(0, "btf_sort", &btf_sort,
+			    "sort BTF by name"),
+		OPT_BOOLEAN(0, "distilled_base", &distilled_base,
+			    "update distilled base"),
 		OPT_END()
 	};
 	int err = -1;
@@ -807,6 +1005,11 @@ int main(int argc, const char **argv)
 
 	obj.path = argv[0];
 
+	if (btf_sort) {
+		err = sort_update_btf(&obj, distilled_base);
+		goto out;
+	}
+
 	if (elf_collect(&obj))
 		goto out;
 
-- 
2.34.1


