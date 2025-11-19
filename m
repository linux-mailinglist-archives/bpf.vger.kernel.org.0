Return-Path: <bpf+bounces-75037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6EC6C934
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C4B5D2CA7B
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402C92F49E3;
	Wed, 19 Nov 2025 03:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTi6vDp/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1642F3C0E
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522512; cv=none; b=SW/CKvXrtfxXTQ+z5ss4adJdenl/pcp/oNIwOAh8FRAi8ROeroZ8LK5qU+QdCYYthG12/Xi88Ja39MqTHaSh5n44bRTsF3szXIeUQUKE9+cHBK+tmrOdW5J2a4LD5/yUgtcF0EhyjYHQtV3ewbInAE3bZRKSm7LKeOUclhpdtuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522512; c=relaxed/simple;
	bh=ATdrgW6KFELBRafH05kQcV6AsqpZhc9TKNlK93XOfh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1l2Rr/7u55jsnmheZkMW16TSOH/RWUnvhsSFBKwFh0FBTzzSguGOHeYKVJPZcG4lI9djPyMpgKh6xL0f6ibyypgJQObL6i40A2z90GaWgoWaxU+UaHe+arlkEjO8qWv4pQwwpq9nuD6P/90vc8b5TW+ajnCH2nPIkV0jrUsoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTi6vDp/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29568d93e87so56508155ad.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763522510; x=1764127310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiOGMko7D822DO4lbsrwsnsdnh27mz9D9I0b0hHBK4I=;
        b=TTi6vDp/6tE8bT1rf/j67kJqK/ckszuy+NCIASbOT4VoNQeAe4SK8zewDOShJ5GNWW
         LFx5kJHKmfMaOqYh3rf43x1vY9fT1aLM/YlZG2ErVE3nK1Ka7CCu5At9OGqhMmDLZtzx
         XrWwMTn1RehL23LFZdiQZQREn4g2QC8DJejBILAbpuc60TcibFw6QVUqueJAVUoY0VrJ
         7DxFLvgyh6b2aqYmHs4s2R+hRM+owr0LHjHSZKcDQctMz6Fsr7B8NrKUnT4CyFM1otYN
         SicUC7xt+eZqM90+QXI88itzxn1bdr80e8KIn/QMi59q5MgVMvnofsWmSNvbIrQHgtyF
         +10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763522510; x=1764127310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiOGMko7D822DO4lbsrwsnsdnh27mz9D9I0b0hHBK4I=;
        b=w3nEixVet7je2Hvuz6qy4zRPdbpNZuV5bmgHCj+rNW1MBGv7vReGeka3Ez5bab/qL3
         zZUKD5eZebxFl0lK8RF/tk++C9WYCAr5LRR840rE/iGtaiWLZXuN4nnoUATsTc4gm359
         5fBFNF2P5TNCAVmOs9iYMuQtMZkLonMiL5MmSUvbi94W0Z3zPr4WX9GYGczdOdpnAH9O
         QM7RD6cQJSHXpVTjxligiA09nfhfePx+WkbeFT/Gb82ZCMqeM+F6RSAxo7h+EIXhE0xA
         L3DWSK9LqLq2vAwKW0jU7vxLT9yZrGZZjqEaLfJwEOS3NbNXAhx9xLQTyqb088AiU7bG
         bW1w==
X-Forwarded-Encrypted: i=1; AJvYcCXtJGFrJYAO/750raV0X/Mpaa14fD+0Z06H2E5piawHbHUvLvwDoIMro+LR1LSCK2t+LRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CNFYMC+dS6hACycO3iAOjuxZ1Bh5i2vl4Fj3g+Dx1vfTuEXA
	KnuPOsT3dZI4lytbI/ywRWP6xXBSKp8/Sn2y1QySiC0E7StaYXtACHSI
X-Gm-Gg: ASbGncue+9UVl731PIeKVBCJ1ZLfhxsSaaTLveLyiqBz93ho+3ssFdMS18+dVpj4mwN
	ICjoQUfRLBoBOviQK6ZrJHy0cgWyOVtg6yh04r4o1SBDuVphvFGosVTLvLQuro8pMmN91k5FrEf
	//95eznjGJFkiYkDQQzCtp5xmdVk/68I0NtAUX0ku/oqpqhuMLDu6YQfBNc5p2fa3IHR57EVqHL
	W87B3QSSUxJfGf2Wb7lpokO0ZsZT9EGTBlDhun/mVNq/pvxAHEDse95Klt8xVlmP/ZmUfLf1CC/
	XA4bnnR2I2UWBF9nDSoxzcoJE2KVqrLRfhYPVrsUA4haJK4n9V0oG7F+JJ1bvrxHIegCy8XFhSh
	RAwQNazWDNQa2XlmjseF9szLcCNYUTCJTcIRxe8G8k/a9+pztIFzLdnUCG/J3O9s8VLHs/i9cx9
	Hggr9ipVaVq65nuJ1XoT4EvbxyK6+Lc4NJF3CmrA==
X-Google-Smtp-Source: AGHT+IEvN38EIx6thP5o+/I1V8gBpMiGFxMzyd6hdKQk9DOpl4hluxga4rzDLLd9AUDpzqL+YKAcQQ==
X-Received: by 2002:a17:902:d54c:b0:295:ed6:4625 with SMTP id d9443c01a7336-2986a74f5ffmr216927215ad.47.1763522510224;
        Tue, 18 Nov 2025 19:21:50 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm188352485ad.88.2025.11.18.19.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:21:49 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v7 3/7] tools/resolve_btfids: Add --btf_sort option for BTF name sorting
Date: Wed, 19 Nov 2025 11:15:27 +0800
Message-Id: <20251119031531.1817099-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119031531.1817099-1-dolinux.peng@gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
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
 tools/bpf/resolve_btfids/main.c | 200 ++++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+)

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
index d47191c6e55e..dc0badd6f375 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -768,6 +768,195 @@ static int symbols_patch(struct object *obj)
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
+static int update_btf_section(const char *path, const struct btf *btf,
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
+	int start_id = 1, nr_types, id;
+	int err = 0, i;
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
+	qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_names, btf);
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
+		err = update_btf_section(obj->path, new_btf, BTF_ELF_SEC);
+		if (!err) {
+			err = update_btf_section(obj->path, distilled_base, BTF_BASE_ELF_SEC);
+			if (err < 0)
+				pr_err("FAILED to update '%s'\n", BTF_BASE_ELF_SEC);
+		} else {
+			pr_err("FAILED to update '%s'\n", BTF_ELF_SEC);
+		}
+
+		btf__free(new_btf);
+		btf__free(distilled_base);
+	} else {
+		err = update_btf_section(obj->path, btf, BTF_ELF_SEC);
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
@@ -787,6 +976,8 @@ int main(int argc, const char **argv)
 		.sets     = RB_ROOT,
 	};
 	bool fatal_warnings = false;
+	bool btf_sort = false;
+	bool distilled_base = false;
 	struct option btfid_options[] = {
 		OPT_INCR('v', "verbose", &verbose,
 			 "be more verbose (show errors, etc)"),
@@ -796,6 +987,10 @@ int main(int argc, const char **argv)
 			   "path of file providing base BTF"),
 		OPT_BOOLEAN(0, "fatal_warnings", &fatal_warnings,
 			    "turn warnings into errors"),
+		OPT_BOOLEAN(0, "btf_sort", &btf_sort,
+			    "sort BTF by name in ascending order"),
+		OPT_BOOLEAN(0, "distilled_base", &distilled_base,
+			    "distill base"),
 		OPT_END()
 	};
 	int err = -1;
@@ -807,6 +1002,11 @@ int main(int argc, const char **argv)
 
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


