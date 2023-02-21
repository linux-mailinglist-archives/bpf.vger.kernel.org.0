Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22F369EB67
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 00:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBUXpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 18:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBUXpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 18:45:32 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DC72CFF0
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 15:45:31 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E76E2240760
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 00:45:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677023129; bh=E5bwJxYBhQCm83HSmRUS6YqYenbAEm4H3FW5vqf3hzo=;
        h=From:To:Subject:Date:From;
        b=WH7M2AZwDiNY6zeTXuA98Z4cdPX1OQRfzNx2wKhd2ALo3LYeGxM8k9UoHE4qJxV9T
         UfgLl3YVnpPy2RU+rAKI0MVhtfN/Conu4nKu4Cb4wb4g1EolAEb84Y7XZS+tuxuoX4
         8xoNARE3MVSRxeyNXeWaLtRFv005a/F6dECRIN6eyl7F04mgFQ5ecAb7uM2ezFmGMc
         0qf0OGNR3MW/0FG44xWSKQCU9oGolziFMjdcuFBjBCwQTBS6oodyvTFD7Ym8UgQydz
         aNYM6a7C80/c7sK8/4FQ86dFFYealRZLr02gaTSmZKH7VawqXmog4UAtqZN4tmp/qO
         JxZspz/BXoiNg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PLwrn22zCz6tmN;
        Wed, 22 Feb 2023 00:45:29 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/3] libbpf: Add support for attaching uprobes to shared objects in APKs
Date:   Tue, 21 Feb 2023 23:45:00 +0000
Message-Id: <20230221234500.2653976-4-deso@posteo.net>
In-Reply-To: <20230221234500.2653976-1-deso@posteo.net>
References: <20230221234500.2653976-1-deso@posteo.net>
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
 tools/lib/bpf/libbpf.c | 87 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4543e9..a41993b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -53,6 +53,7 @@
 #include "libbpf_internal.h"
 #include "hashmap.h"
 #include "bpf_gen_internal.h"
+#include "zip.h"
 
 #ifndef BPF_FS_MAGIC
 #define BPF_FS_MAGIC		0xcafe4a11
@@ -10702,6 +10703,65 @@ static long elf_find_func_offset_from_file(const char *binary_path, const char *
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
+	long ret = -ENOENT;
+	Elf *elf;
+
+	archive = zip_archive_open(archive_path);
+	if (!archive) {
+		pr_warn("zip: failed to open %s\n", archive_path);
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+
+	if (zip_archive_find_entry(archive, file_name, &entry)) {
+		pr_warn("zip: could not find archive member %s in %s\n", file_name, archive_path);
+		ret = -LIBBPF_ERRNO__FORMAT;
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
+		ret = -LIBBPF_ERRNO__FORMAT;
+		goto out;
+	}
+
+	ret = elf_find_func_offset(elf, file_name, func_name);
+	if (ret > 0) {
+		ret += entry.data_offset;
+		pr_debug("elf: symbol address match for %s of %s in %s: 0x%lx\n", func_name,
+			 file_name, archive_path, ret);
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
@@ -10787,9 +10847,10 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
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
@@ -10806,21 +10867,33 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	if (!binary_path)
 		return libbpf_err_ptr(-EINVAL);
 
-	if (!strchr(binary_path, '/')) {
-		err = resolve_full_path(binary_path, full_binary_path,
-					sizeof(full_binary_path));
+	/* Check if "binary_path" refers to an archive. */
+	archive_sep = strstr(binary_path, "!/");
+	if (archive_sep) {
+		full_path[0] = '\0';
+		libbpf_strlcpy(full_path, binary_path, archive_sep - binary_path + 1);
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
2.30.2

