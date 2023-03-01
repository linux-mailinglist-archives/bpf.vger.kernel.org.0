Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497076A73AC
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 19:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCASkx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 13:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCASkv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 13:40:51 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F3A2D67
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 10:40:40 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A404824058D
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 19:40:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677696038; bh=AfJ6rIICgvZyZ9scyDh4GBTSt5hLxSsCK0RjHWIGjYQ=;
        h=From:To:Subject:Date:From;
        b=YK8rHD0CQcq3EONQVPCFK4jk3tP/Qrt8Z0seGq4pLoa4R+AD4uUIDmcae3XJFtuPm
         BEQA/tpjTTaw39xexJZb84U5hzMTvcaYh366+5QJBDN2fT6daUz5K2I5Q/AnWSscDA
         boVt8boT2DwbEFRR+P35GteEDvwjNLYXpfA+wVVB4bkT4HfIy2+uWgrCJVHiz1jFLI
         EUmk3vA1u/K/E1i3NRg3Hi/5RmHhB8uXBqhqR1uF74L7/4gyo9FivdtI46FSfxj6TY
         LIjTFbzMsNc9Wa7tRP0g5DBc04MsG/zBet6XnuN0Z1vJILzoO/E6FcBSbZZ0DuC/pX
         DDPUYi0IjRHUw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PRjjK5ZnQz6trm;
        Wed,  1 Mar 2023 19:40:37 +0100 (CET)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/3] libbpf: Introduce elf_find_func_offset_from_file() function
Date:   Wed,  1 Mar 2023 18:40:25 +0000
Message-Id: <20230301184026.800691-3-deso@posteo.net>
In-Reply-To: <20230301184026.800691-1-deso@posteo.net>
References: <20230301184026.800691-1-deso@posteo.net>
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
elf_find_func_offset_from_file(), which opens a binary based on a
path and then invokes elf_find_func_offset() on the Elf object. Having
this split in responsibilities will allow us to call
elf_find_func_offset() from other code paths on Elf objects that did not
necessarily come from a file on disk.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/libbpf.c | 57 ++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 05c4db3..4543e9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10531,32 +10531,19 @@ static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn *scn)
 	return NULL;
 }
 
-/* Find offset of function name in object specified by path.  "name" matches
- * symbol name or name@@LIB for library functions.
+/* Find offset of function name in the provided ELF object. "binary_path" is
+ * the path to the ELF binary represented by "elf", and only used for error
+ * reporting matters. "name" matches symbol name or name@@LIB for library
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
@@ -10569,7 +10556,7 @@ static long elf_find_func_offset(const char *binary_path, const char *name)
 	/* Does name specify "@@LIB"? */
 	is_name_qualified = strstr(name, "@@") != NULL;
 
-	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol.  This search order is used because if
+	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is used because if
 	 * a binary is stripped, it may only have SHT_DYNSYM, and a fully-statically
 	 * linked binary may not have SHT_DYMSYM, so absence of a section should not be
 	 * reported as a warning/error.
@@ -10682,6 +10669,34 @@ static long elf_find_func_offset(const char *binary_path, const char *name)
 		}
 	}
 out:
+	return ret;
+}
+
+/* Find offset of function name in ELF object specified by path. "name" matches
+ * symbol name or name@@LIB for library functions.
+ */
+static long elf_find_func_offset_from_file(const char *binary_path, const char *name)
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
+		sym_off = elf_find_func_offset_from_file(binary_path, func_name);
 		if (sym_off < 0)
 			return libbpf_err_ptr(sym_off);
 		func_offset += sym_off;
-- 
2.39.2

