Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38D469B2F7
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBQTT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 14:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQTT2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 14:19:28 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D92153EDD
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 11:19:27 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id F3FC02403A0
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 20:19:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1676661566; bh=2t67PsuTcPgzpG0pzQcMjBQLDyw7ECrjL94jpIL4Cpg=;
        h=From:To:Subject:Date:From;
        b=LtHGAVk3OAjcoKfvGfAxZV+z07CJZYuILjZUgfNml9LtlV7EA1TUm9ldpn/u4KuP/
         V9p9GQK5suZcrDZHxS6oKZ20oGuL5DR8BnQfCMkeuppFz+VcUQ2xL+RWvGM4Tlfz5M
         MVwNDA+tB0PzE8ibTqoVXtl1qmke7tMMnuxrSKMsDYbLgbj+k7NiUzNg0DtTJ4/6dM
         gMXzjc9hORqIguDGtAq+U1HZIgcQJbdOwAxoZmz9PJbtUbwS+umdrBzR6VI8HPKrG8
         SPVCC2GL9x9gU4yPbhZQt0BQ8kqMDwhvoRJWYCwwHa2qbvLEukmwEuwDneXanNDORB
         WwUMue2AI1s/Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PJM7c5w87z9rxH;
        Fri, 17 Feb 2023 20:19:24 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: [PATCH bpf-next 3/3] libbpf: Add support for attaching uprobes to shared objects in APKs
Date:   Fri, 17 Feb 2023 19:19:08 +0000
Message-Id: <20230217191908.1000004-4-deso@posteo.net>
In-Reply-To: <20230217191908.1000004-1-deso@posteo.net>
References: <20230217191908.1000004-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 tools/lib/bpf/libbpf.c | 84 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a474f49..79ab85f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -53,6 +53,7 @@
 #include "libbpf_internal.h"
 #include "hashmap.h"
 #include "bpf_gen_internal.h"
+#include "zip.h"
 
 #ifndef BPF_FS_MAGIC
 #define BPF_FS_MAGIC		0xcafe4a11
@@ -10702,6 +10703,60 @@ static long elf_find_func_offset_from_elf_file(const char *binary_path, const ch
 	return ret;
 }
 
+/* Find offset of function name in archive specified by path. Currently
+ * supported are .zip files that do not compress their contents (as used on
+ * Android in the form of APKs, for example).  "file_name" is the name of the
+ * ELF file inside the archive.  "func_name" matches symbol name or name@@LIB
+ * for library functions.
+ */
+static long elf_find_func_offset_from_archive(const char *archive_path, const char *file_name,
+					      const char *func_name)
+{
+	struct zip_archive *archive;
+	struct zip_entry entry;
+	long ret = -ENOENT;
+	Elf *elf;
+
+	archive = zip_archive_open(archive_path);
+	if (!archive) {
+		pr_warn("failed to open %s\n", archive_path);
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+
+	if (zip_archive_find_entry(archive, file_name, &entry)) {
+		pr_warn("zip: could not find archive member %s in %s\n", file_name, archive_path);
+		ret = -LIBBPF_ERRNO__FORMAT;
+		goto out;
+	}
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
+		ret = -LIBBPF_ERRNO__FORMAT;
+		goto out;
+	}
+
+	ret = elf_find_func_offset(elf, file_name, func_name);
+	if (ret > 0) {
+		ret += entry.data_offset;
+		pr_debug("elf: symbol address match for '%s' in '%s': 0x%lx\n", func_name,
+			 archive_path, ret);
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
@@ -10789,6 +10844,9 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 {
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
 	char errmsg[STRERR_BUFSIZE], *legacy_probe = NULL;
+	const char *archive_path = NULL;
+	const char *archive_sep = NULL;
+	char full_archive_path[PATH_MAX];
 	char full_binary_path[PATH_MAX];
 	struct bpf_link *link;
 	size_t ref_ctr_off;
@@ -10806,9 +10864,21 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	if (!binary_path)
 		return libbpf_err_ptr(-EINVAL);
 
-	if (!strchr(binary_path, '/')) {
-		err = resolve_full_path(binary_path, full_binary_path,
-					sizeof(full_binary_path));
+	/* Check if "binary_path" refers to an archive. */
+	archive_sep = strstr(binary_path, "!/");
+	if (archive_sep) {
+		if (archive_sep - binary_path >= sizeof(full_archive_path)) {
+			return libbpf_err_ptr(-EINVAL);
+		}
+
+		strncpy(full_archive_path, binary_path, archive_sep - binary_path);
+		full_archive_path[archive_sep - binary_path] = 0;
+		archive_path = full_archive_path;
+
+		strcpy(full_binary_path, archive_sep + 2);
+		binary_path = full_binary_path;
+	} else if (!strchr(binary_path, '/')) {
+		err = resolve_full_path(binary_path, full_binary_path, sizeof(full_binary_path));
 		if (err) {
 			pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
 				prog->name, binary_path, err);
@@ -10820,7 +10890,13 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	if (func_name) {
 		long sym_off;
 
-		sym_off = elf_find_func_offset_from_elf_file(binary_path, func_name);
+		if (archive_path) {
+			sym_off = elf_find_func_offset_from_archive(archive_path, binary_path,
+								    func_name);
+			binary_path = archive_path;
+		} else {
+			sym_off = elf_find_func_offset_from_elf_file(binary_path, func_name);
+		}
 		if (sym_off < 0)
 			return libbpf_err_ptr(sym_off);
 		func_offset += sym_off;
-- 
2.30.2

