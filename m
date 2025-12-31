Return-Path: <bpf+bounces-77557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65322CEAFED
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 02:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2584D301EC5D
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 01:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ACE1FE44B;
	Wed, 31 Dec 2025 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jbp05A7L"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9086352;
	Wed, 31 Dec 2025 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767144374; cv=none; b=XHrlWlyH3syhKeyKYODWotbRGUJ94pe+1IEtrT5jcPh87qHMQ/dQ5WMnv24jDqB4VtQOVxAGDJbis7vrqwZqWkT9mRiQ6v5HPO+Xf18glXAQwrOpg62AGT/2I5daoPPoLYPt622NEQSV4BK18skPcSJXsE2qA5i3xpXBz5DzZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767144374; c=relaxed/simple;
	bh=EP81NzZERTa4WpEj5g0CAj0u3mjOAYp9iIlHjG7ghQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nk2P0Us92GN0c/MLo4hXYlSpnt4/atjXNAg7uU1vyXmrJv81nTeK7dPTeV9v9kdvKw0ELAywD7SCL/5bLsU2DYX1eJxeIAZTseiDjGP/E6Byb3VQNb4AdYUxZVCSpbldYgl+5SSSpT9l7zul+VVBCvGXCN8KT9OMFxhVe3m+4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jbp05A7L; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767144368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oW1Reu5DMmVKSwa9Snx8B+yvijdb2ZtOnW+HkCnezlk=;
	b=Jbp05A7Lwo6Z90OwyUIpXaFeUGIHS//O9l9zgriLwjjJKkuzlner+CkFFQn6D20MNYtSo7
	nIIJ/n5TsO0jDT0UnGT9GZ9ISYdr2qZOb0rXlZSf8vBbC2DJLtujMeey1LGLDNbvOl41mh
	Fwxwg9Hq3vW8vIbchXum4meie4bf9Mg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v2] resolve_btfids: Implement --patch_btfids
Date: Tue, 30 Dec 2025 17:25:57 -0800
Message-ID: <20251231012558.1699758-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Recent changes in BTF generation [1] rely on ${OBJCOPY} command to
update .BTF_ids section data in target ELF files.

This exposed a bug in llvm-objcopy --update-section code path, that
may lead to corruption of a target ELF file. Specifically, because of
the bug st_shndx of some symbols may be (incorrectly) set to 0xffff
(SHN_XINDEX) [2][3].

While there is a pending fix for LLVM, it'll take some time before it
lands (likely in 22.x). And the kernel build must keep working with
older LLVM toolchains in the foreseeable future.

Using GNU objcopy for .BTF_ids update would work, but it would require
changes to LLVM-based build process, likely breaking existing build
environments as discussed in [2].

To work around llvm-objcopy bug, implement --patch_btfids code path in
resolve_btfids as a drop-in replacement for:

    ${OBJCOPY} --update-section .BTF_ids=${btf_ids} ${elf}

Which works specifically for .BTF_ids section:

    ${RESOLVE_BTFIDS} --patch_btfids ${btf_ids} ${elf}

This feature in resolve_btfids can be removed at some point in the
future, when llvm-objcopy with a relevant bugfix becomes common.

[1] https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/20251224005752.201911-1-ihor.solodrai@linux.dev/
[3] https://github.com/llvm/llvm-project/issues/168060#issuecomment-3533552952

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

Successful BPF CI run: https://github.com/kernel-patches/bpf/actions/runs/20608321584
---
 scripts/gen-btf.sh                   |   2 +-
 scripts/link-vmlinux.sh              |   2 +-
 tools/bpf/resolve_btfids/main.c      | 117 +++++++++++++++++++++++++++
 tools/testing/selftests/bpf/Makefile |   2 +-
 4 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index 12244dbe097c..0aec86615416 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -123,7 +123,7 @@ embed_btf_data()
 	fi
 	local btf_ids="${ELF_FILE}.BTF_ids"
 	if [ -f "${btf_ids}" ]; then
-		${OBJCOPY} --update-section .BTF_ids=${btf_ids} ${ELF_FILE}
+		${RESOLVE_BTFIDS} --patch_btfids ${btf_ids} ${ELF_FILE}
 	fi
 }
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index e2207e612ac3..1915adf3249b 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -266,7 +266,7 @@ vmlinux_link "${VMLINUX}"
 
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	info OBJCOPY ${btfids_vmlinux}
-	${OBJCOPY} --update-section .BTF_ids=${btfids_vmlinux} ${VMLINUX}
+	${RESOLVE_BTFIDS} --patch_btfids ${btfids_vmlinux} ${VMLINUX}
 fi
 
 mksysmap "${VMLINUX}" System.map
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 2cbc252259be..df39982f51df 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -862,8 +862,119 @@ static inline int make_out_path(char *buf, u32 buf_sz, const char *in_path, cons
 	return 0;
 }
 
+/*
+ * Patch the .BTF_ids section of an ELF file with data from provided file.
+ * Equivalent to: objcopy --update-section .BTF_ids=<btfids> <elf>
+ *
+ * 1. Find .BTF_ids section in the ELF
+ * 2. Verify that blob file size matches section size
+ * 3. Update section data buffer with blob data
+ * 4. Write the ELF file
+ */
+static int patch_btfids(const char *btfids_path, const char *elf_path)
+{
+	Elf_Scn *scn = NULL;
+	FILE *btfids_file;
+	size_t shdrstrndx;
+	int fd, err = -1;
+	Elf_Data *data;
+	struct stat st;
+	GElf_Shdr sh;
+	char *name;
+	Elf *elf;
+
+	elf_version(EV_CURRENT);
+
+	fd = open(elf_path, O_RDWR, 0666);
+	if (fd < 0) {
+		pr_err("FAILED to open %s: %s\n", elf_path, strerror(errno));
+		return -1;
+	}
+
+	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
+	if (!elf) {
+		close(fd);
+		pr_err("FAILED cannot create ELF descriptor: %s\n", elf_errmsg(-1));
+		return -1;
+	}
+
+	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
+
+	if (elf_getshdrstrndx(elf, &shdrstrndx) != 0) {
+		pr_err("FAILED cannot get shdr str ndx\n");
+		goto out;
+	}
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+
+		if (gelf_getshdr(scn, &sh) != &sh) {
+			pr_err("FAILED to get section header\n");
+			goto out;
+		}
+
+		name = elf_strptr(elf, shdrstrndx, sh.sh_name);
+		if (!name)
+			continue;
+
+		if (strcmp(name, BTF_IDS_SECTION) == 0)
+			break;
+	}
+
+	if (!scn) {
+		pr_err("FAILED: section %s not found in %s\n", BTF_IDS_SECTION, elf_path);
+		goto out;
+	}
+
+	data = elf_getdata(scn, NULL);
+	if (!data) {
+		pr_err("FAILED to get %s section data from %s\n", BTF_IDS_SECTION, elf_path);
+		goto out;
+	}
+
+	if (stat(btfids_path, &st) < 0) {
+		pr_err("FAILED to stat %s: %s\n", btfids_path, strerror(errno));
+		goto out;
+	}
+
+	if ((size_t)st.st_size != data->d_size) {
+		pr_err("FAILED: size mismatch - %s section in %s is %zu bytes, %s is %zu bytes\n",
+		       BTF_IDS_SECTION, elf_path, data->d_size, btfids_path, (size_t)st.st_size);
+		goto out;
+	}
+
+	btfids_file = fopen(btfids_path, "rb");
+	if (!btfids_file) {
+		pr_err("FAILED to open %s: %s\n", btfids_path, strerror(errno));
+		goto out;
+	}
+
+	pr_debug("Copying data from %s to %s section of %s (%zu bytes)\n",
+		 btfids_path, BTF_IDS_SECTION, elf_path, data->d_size);
+
+	if (fread(data->d_buf, data->d_size, 1, btfids_file) != 1) {
+		pr_err("FAILED to read %s\n", btfids_path);
+		fclose(btfids_file);
+		goto out;
+	}
+	fclose(btfids_file);
+
+	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
+	if (elf_update(elf, ELF_C_WRITE) < 0) {
+		pr_err("FAILED to update ELF file %s\n", elf_path);
+		goto out;
+	}
+
+	err = 0;
+out:
+	elf_end(elf);
+	close(fd);
+
+	return err;
+}
+
 static const char * const resolve_btfids_usage[] = {
 	"resolve_btfids [<options>] <ELF object>",
+	"resolve_btfids --patch_btfids <.BTF_ids file> <ELF object>",
 	NULL
 };
 
@@ -880,6 +991,7 @@ int main(int argc, const char **argv)
 		.funcs    = RB_ROOT,
 		.sets     = RB_ROOT,
 	};
+	const char *btfids_path = NULL;
 	bool fatal_warnings = false;
 	char out_path[PATH_MAX];
 
@@ -894,6 +1006,8 @@ int main(int argc, const char **argv)
 			    "turn warnings into errors"),
 		OPT_BOOLEAN(0, "distill_base", &obj.distill_base,
 			    "distill --btf_base and emit .BTF.base section data"),
+		OPT_STRING(0, "patch_btfids", &btfids_path, "file",
+			   "path to .BTF_ids section data blob to patch into ELF file"),
 		OPT_END()
 	};
 	int err = -1;
@@ -905,6 +1019,9 @@ int main(int argc, const char **argv)
 
 	obj.path = argv[0];
 
+	if (btfids_path)
+		return patch_btfids(btfids_path, obj.path);
+
 	if (load_btf(&obj))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f28a32b16ff0..9488d076c740 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -657,7 +657,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 	$$(if $$(TEST_NEEDS_BTFIDS),						\
 		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
 		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
-		$(OBJCOPY) --update-section .BTF_ids=$$@.BTF_ids $$@)
+		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
 
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\
-- 
2.52.0


