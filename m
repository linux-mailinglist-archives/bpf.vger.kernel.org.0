Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C856A761D
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 22:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCAVXi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 16:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCAVXY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 16:23:24 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A3F15C89
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 13:23:22 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5160A240600
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 22:23:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677705801; bh=jm+cz+/1EMqRaNDTGquLqgSG2HyX+x8A8ELTbu2nE7M=;
        h=From:To:Subject:Date:From;
        b=mW1Z5hBs0tCYJhpRDOViXCgGQYrpBerxmDdtNXwwaGf63cUFhd7hP4shDSD8WAMp+
         QBdRAVz/vXd2kjKRK5inGKnZSgA35rDFsfQsYui8vWUZ0Ick6JrCHhSYU4ZtO5BdOp
         Ix3p5rJiVhl7MAZb0lj4igDJc6El+bU+5uehKPcgifnaa8+bzs04gZCc6tZYBIhvIK
         mZ5M/tft2zELVpzVXEhJNyj5a5c1+S+glCRbcRJM3ySAwKTNs/p31yCDrcjM/WPQhn
         mHyNMzdVUMSH1N5tBu4TyxpOiOlFv2/KRp1qUVSOk80x2YaH4eMdGX1wpXjghY52SS
         1HRmf3pCLqbeQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PRnK44m4lz6tqm;
        Wed,  1 Mar 2023 22:23:20 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: [PATCH bpf-next v4 3/3] libbpf: Add support for attaching uprobes to shared objects in APKs
Date:   Wed,  1 Mar 2023 21:23:08 +0000
Message-Id: <20230301212308.1839139-4-deso@posteo.net>
In-Reply-To: <20230301212308.1839139-1-deso@posteo.net>
References: <20230301212308.1839139-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change adds support for attaching uprobes to shared objects located
in APKs, which is relevant for Android systems where various libraries
may reside in APKs. To make that happen, we extend the syntax for the
"binary path" argument to attach to with that supported by various
Android tools:
  <archive>!/<binary-in-archive>

For example:
  /system/app/test-app/test-app.apk!/lib/arm64-v8a/libc++_shared.so

APKs need to be specified via full path, i.e., we do not attempt to
resolve mere file names by searching system directories.

We cannot currently test this functionality end-to-end in an automated
fashion, because it relies on an Android system being present, but there
is no support for that in CI. I have tested the functionality manually,
by creating a libbpf program containing a uretprobe, attaching it to a
function inside a shared object inside an APK, and verifying the sanity
of the returned values.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/libbpf.c | 91 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4543e9..1a0f97 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -53,6 +53,7 @@
 #include "libbpf_internal.h"
 #include "hashmap.h"
 #include "bpf_gen_internal.h"
+#include "zip.h"
 
 #ifndef BPF_FS_MAGIC
 #define BPF_FS_MAGIC		0xcafe4a11
@@ -10702,6 +10703,68 @@ static long elf_find_func_offset_from_file(const char *binary_path, const char *
 	return ret;
 }
 
+/* Find offset of function name in archive specified by path. Currently
+ * supported are .zip files that do not compress their contents, as used on
+ * Android in the form of APKs, for example. "file_name" is the name of the ELF
+ * file inside the archive. "func_name" matches symbol name or name@@LIB for
+ * library functions.
+ *
+ * An overview of the APK format specifically provided here:
+ * https://en.wikipedia.org/w/index.php?title=Apk_(file_format)&oldid=1139099120#Package_contents
+ */
+static long elf_find_func_offset_from_archive(const char *archive_path, const char *file_name,
+					      const char *func_name)
+{
+	struct zip_archive *archive;
+	struct zip_entry entry;
+	long ret;
+	Elf *elf;
+
+	archive = zip_archive_open(archive_path);
+	if (IS_ERR(archive)) {
+		ret = PTR_ERR(archive);
+		pr_warn("zip: failed to open %s: %ld\n", archive_path, ret);
+		return ret;
+	}
+
+	ret = zip_archive_find_entry(archive, file_name, &entry);
+	if (ret) {
+		pr_warn("zip: could not find archive member %s in %s: %ld\n", file_name,
+			archive_path, ret);
+		goto out;
+	}
+	pr_debug("zip: found entry for %s in %s at 0x%lx\n", file_name, archive_path,
+		 (unsigned long)entry.data_offset);
+
+	if (entry.compression) {
+		pr_warn("zip: entry %s of %s is compressed and cannot be handled\n", file_name,
+			archive_path);
+		ret = -LIBBPF_ERRNO__FORMAT;
+		goto out;
+	}
+
+	elf = elf_memory((void *)entry.data, entry.data_length);
+	if (!elf) {
+		pr_warn("elf: could not read elf file %s from %s: %s\n", file_name, archive_path,
+			elf_errmsg(-1));
+		ret = -LIBBPF_ERRNO__LIBELF;
+		goto out;
+	}
+
+	ret = elf_find_func_offset(elf, file_name, func_name);
+	if (ret > 0) {
+		pr_debug("elf: symbol address match for %s of %s in %s: 0x%x + 0x%lx = 0x%lx\n",
+			 func_name, file_name, archive_path, entry.data_offset, ret,
+			 ret + entry.data_offset);
+		ret += entry.data_offset;
+	}
+	elf_end(elf);
+
+out:
+	zip_archive_close(archive);
+	return ret;
+}
+
 static const char *arch_specific_lib_paths(void)
 {
 	/*
@@ -10787,9 +10850,10 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
 				const struct bpf_uprobe_opts *opts)
 {
-	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
+	const char *archive_path = NULL, *archive_sep = NULL;
 	char errmsg[STRERR_BUFSIZE], *legacy_probe = NULL;
-	char full_binary_path[PATH_MAX];
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
+	char full_path[PATH_MAX];
 	struct bpf_link *link;
 	size_t ref_ctr_off;
 	int pfd, err;
@@ -10806,21 +10870,34 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	if (!binary_path)
 		return libbpf_err_ptr(-EINVAL);
 
-	if (!strchr(binary_path, '/')) {
-		err = resolve_full_path(binary_path, full_binary_path,
-					sizeof(full_binary_path));
+	/* Check if "binary_path" refers to an archive. */
+	archive_sep = strstr(binary_path, "!/");
+	if (archive_sep) {
+		full_path[0] = '\0';
+		libbpf_strlcpy(full_path, binary_path,
+			       min(sizeof(full_path), (size_t)(archive_sep - binary_path + 1)));
+		archive_path = full_path;
+		binary_path = archive_sep + 2;
+	} else if (!strchr(binary_path, '/')) {
+		err = resolve_full_path(binary_path, full_path, sizeof(full_path));
 		if (err) {
 			pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
 				prog->name, binary_path, err);
 			return libbpf_err_ptr(err);
 		}
-		binary_path = full_binary_path;
+		binary_path = full_path;
 	}
 	func_name = OPTS_GET(opts, func_name, NULL);
 	if (func_name) {
 		long sym_off;
 
-		sym_off = elf_find_func_offset_from_file(binary_path, func_name);
+		if (archive_path) {
+			sym_off = elf_find_func_offset_from_archive(archive_path, binary_path,
+								    func_name);
+			binary_path = archive_path;
+		} else {
+			sym_off = elf_find_func_offset_from_file(binary_path, func_name);
+		}
 		if (sym_off < 0)
 			return libbpf_err_ptr(sym_off);
 		func_offset += sym_off;
-- 
2.39.2

