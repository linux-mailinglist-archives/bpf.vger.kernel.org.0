Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC4869B2F6
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 20:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBQTTZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 14:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQTTZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 14:19:25 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E160498BF
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 11:19:24 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id D3DFF24050C
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 20:19:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1676661562; bh=ow+O/w3nZNfiJVZ8THEXiHUzwqL8hCx/Uy/0IHWQaMM=;
        h=From:To:Subject:Date:From;
        b=E4YG4pBRV+U+WjzH2kHWhLiHW773Rs+Kx+iKkn0CwbxpGqdS+VFgPbPXA++lcgtJ/
         bh2TNJzkuBmCsQkQ1KB4N2Fp5MUErlKc4rb/T3EqWzMEIlXdjtzyw6ji77nwifLBID
         7L7dBFGe7llBpUC93J6uyx+4mQNN6UaRq3/tg4yFDvTRW1jrMD5IlYxfvc1k/klT0D
         AhCxibKIZGh3MvOi7yHfktAUyq0oagW48lEUkqQHvCYr/Po0e2TJqaTkCUdLL6RiKZ
         CrvbmtXhgLyIGpCh9Jn6j0icMkQ/vTIih5p7Y+fjTQMs5f2duqsK2XWAy2udPVlzlI
         PVwTJG6vI2DmA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PJM7Y6Fr2z9rxD;
        Fri, 17 Feb 2023 20:19:21 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: [PATCH bpf-next 2/3] libbpf: Introduce elf_find_func_offset_from_elf_file() function
Date:   Fri, 17 Feb 2023 19:19:07 +0000
Message-Id: <20230217191908.1000004-3-deso@posteo.net>
In-Reply-To: <20230217191908.1000004-1-deso@posteo.net>
References: <20230217191908.1000004-1-deso@posteo.net>
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

This change splits the elf_find_func_offset() function in two:
elf_find_func_offset(), which now accepts an already opened Elf object
instead of a path to a file that is to be opened, as well as
elf_find_func_offset_from_elf_file(), which opens a binary based on a
path and then invokes elf_find_func_offset() on the Elf object. Having
this split in responsibilities will allow us to call
elf_find_func_offset() from other code paths on Elf objects that did not
necessarily come from a file on disk.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/libbpf.c | 55 +++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 05c4db3..a474f49 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10531,32 +10531,19 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
 	return NULL;
 }
 
-/* Find offset of function name in object specified by path.  "name" matches
- * symbol name or name@@LIB for library functions.
+/* Find offset of function name in the provided ELF object.  "binary_path" is
+ * the path to the ELF binary represented by "elf", and only used for error
+ * reporting matters.  "name" matches symbol name or name@@LIB for library
+ * functions.
  */
-static long elf_find_func_offset(const char *binary_path, const char *name)
+static long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 {
-	int fd, i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
+	int i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
 	bool is_shared_lib, is_name_qualified;
-	char errmsg[STRERR_BUFSIZE];
 	long ret = -ENOENT;
 	size_t name_len;
 	GElf_Ehdr ehdr;
-	Elf *elf;
 
-	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		ret = -errno;
-		pr_warn("failed to open %s: %s\n", binary_path,
-			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
-		return ret;
-	}
-	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
-	if (!elf) {
-		pr_warn("elf: could not read elf from %s: %s\n", binary_path, elf_errmsg(-1));
-		close(fd);
-		return -LIBBPF_ERRNO__FORMAT;
-	}
 	if (!gelf_getehdr(elf, &ehdr)) {
 		pr_warn("elf: failed to get ehdr from %s: %s\n", binary_path, elf_errmsg(-1));
 		ret = -LIBBPF_ERRNO__FORMAT;
@@ -10682,6 +10669,34 @@ static long elf_find_func_offset(const char *binary_path, const char *name)
 		}
 	}
 out:
+	return ret;
+}
+
+/* Find offset of function name in ELF object specified by path.  "name" matches
+ * symbol name or name@@LIB for library functions.
+ */
+static long elf_find_func_offset_from_elf_file(const char *binary_path, const char *name)
+{
+	char errmsg[STRERR_BUFSIZE];
+	long ret = -ENOENT;
+	Elf *elf;
+	int fd;
+
+	fd = open(binary_path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		ret = -errno;
+		pr_warn("failed to open %s: %s\n", binary_path,
+			libbpf_strerror_r(ret, errmsg, sizeof(errmsg)));
+		return ret;
+	}
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!elf) {
+		pr_warn("elf: could not read elf from %s: %s\n", binary_path, elf_errmsg(-1));
+		close(fd);
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+
+	ret = elf_find_func_offset(elf, binary_path, name);
 	elf_end(elf);
 	close(fd);
 	return ret;
@@ -10805,7 +10820,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	if (func_name) {
 		long sym_off;
 
-		sym_off = elf_find_func_offset(binary_path, func_name);
+		sym_off = elf_find_func_offset_from_elf_file(binary_path, func_name);
 		if (sym_off < 0)
 			return libbpf_err_ptr(sym_off);
 		func_offset += sym_off;
-- 
2.30.2

