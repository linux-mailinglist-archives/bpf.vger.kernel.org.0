Return-Path: <bpf+bounces-7659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE69779F54
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 12:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA5F1C2088A
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5875220F6;
	Sat, 12 Aug 2023 10:50:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE6F370
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 10:50:53 +0000 (UTC)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614DE30F7;
	Sat, 12 Aug 2023 03:50:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RNHDW45mCzB03Lp;
	Sat, 12 Aug 2023 18:37:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXC7scY9dkThi9AA--.8440S14;
	Sat, 12 Aug 2023 11:49:00 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	jarkko@kernel.org,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 12/13] tools/digest-lists: Add rpm digest list generator and parser
Date: Sat, 12 Aug 2023 12:46:15 +0200
Message-Id: <20230812104616.2190095-13-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwBXC7scY9dkThi9AA--.8440S14
X-Coremail-Antispam: 1UD129KBjvAXoWfJr17Jw1DuF1UWFWkurykKrg_yoW8XF45uo
	Zaga13Gan0kr18uF4vkFy3Xa1ayanYya1UA3yrWryqq3W8AFy0g3Z5KanrXrW7ur4rJryS
	qr4Iq343Aw4xW3s5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYt7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj46UtAAAse
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a generator to generate an rpm digest list from one or multiple RPM
package headers. The digest list contains the RPM magic string, the content
of the RPMTAG_IMMUTABLE section, and the user asymmetric key signature
(module-style) converted from the PGP signature in the RPMTAG_RSAHEADER
section.

This generator has as prerequisite gpg support for a new command
--conv-kernel, which converts the PGP format to a user asymmetric key
signature.

Also add a parser of rpm digest list, to show the content (digest algorithm
and value, and file path), and to add/remove the security.digest_list xattr
to/from each file in the RPM packages.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/digest-lists/.gitignore              |   2 +
 tools/digest-lists/Makefile                |  10 +-
 tools/digest-lists/generators/generators.h |   2 +
 tools/digest-lists/generators/rpm.c        | 257 +++++++++++++++++++++
 tools/digest-lists/manage_digest_lists.c   |   2 +
 tools/digest-lists/parsers/parsers.h       |   2 +
 tools/digest-lists/parsers/rpm.c           | 169 ++++++++++++++
 7 files changed, 442 insertions(+), 2 deletions(-)
 create mode 100644 tools/digest-lists/generators/rpm.c
 create mode 100644 tools/digest-lists/parsers/rpm.c

diff --git a/tools/digest-lists/.gitignore b/tools/digest-lists/.gitignore
index 9a75ae766ff..51ca25f3b50 100644
--- a/tools/digest-lists/.gitignore
+++ b/tools/digest-lists/.gitignore
@@ -3,3 +3,5 @@ manage_digest_lists
 manage_digest_lists.1
 libgen-tlv-list.so
 libparse-tlv-list.so
+libgen-rpm-list.so
+libparse-rpm-list.so
diff --git a/tools/digest-lists/Makefile b/tools/digest-lists/Makefile
index 23f9fa3b588..2c8089affb8 100644
--- a/tools/digest-lists/Makefile
+++ b/tools/digest-lists/Makefile
@@ -15,8 +15,8 @@ CFLAGS=-ggdb -Wall
 
 PROGS=manage_digest_lists
 
-GENERATORS=libgen-tlv-list.so
-PARSERS=libparse-tlv-list.so
+GENERATORS=libgen-tlv-list.so libgen-rpm-list.so
+PARSERS=libparse-tlv-list.so libparse-rpm-list.so
 
 MAN1=manage_digest_lists.1
 
@@ -31,9 +31,15 @@ manage_digest_lists: manage_digest_lists.c common.c $(GENERATORS) $(PARSERS)
 libgen-tlv-list.so: generators/tlv.c common.c
 	$(CC) $(CFLAGS) -fPIC --shared -Wl,-soname,libgen-tlv-list.so $^ -o $@
 
+libgen-rpm-list.so: generators/rpm.c common.c
+	$(CC) $(CFLAGS) -fPIC --shared -Wl,-soname,libgen-rpm-list.so $^ -o $@ -lrpm -lrpmio
+
 libparse-tlv-list.so: parsers/tlv.c common.c ../../lib/tlv_parser.c
 	$(CC) $(CFLAGS) -fPIC --shared -Wl,-soname,libparse-tlv-list.so $^ -o $@ -I parsers
 
+libparse-rpm-list.so: parsers/rpm.c common.c
+	$(CC) $(CFLAGS) -fPIC --shared -Wl,-soname,libparse-rpm-list.so $^ -o $@ -I parsers -lrpm -lrpmio
+
 ifneq ($(findstring $(MAKEFLAGS),s),s)
   ifneq ($(V),1)
      QUIET_A2X = @echo '  A2X     '$@;
diff --git a/tools/digest-lists/generators/generators.h b/tools/digest-lists/generators/generators.h
index 9830b791667..ff3ed6ac8d4 100644
--- a/tools/digest-lists/generators/generators.h
+++ b/tools/digest-lists/generators/generators.h
@@ -14,3 +14,5 @@
 void *tlv_list_gen_new(int dirfd, char *input, enum hash_algo algo);
 int tlv_list_gen_add(int dirfd, void *ptr, char *input);
 void tlv_list_gen_close(void *ptr);
+
+int rpm_list_gen_add(int dirfd, void *ptr, char *input);
diff --git a/tools/digest-lists/generators/rpm.c b/tools/digest-lists/generators/rpm.c
new file mode 100644
index 00000000000..29e7a6eb0ca
--- /dev/null
+++ b/tools/digest-lists/generators/rpm.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Generate rpm digest lists.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <limits.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+#include <linux/xattr.h>
+#include <rpm/rpmlib.h>
+#include <rpm/header.h>
+#include <rpm/rpmts.h>
+#include <rpm/rpmdb.h>
+#include <rpm/rpmlog.h>
+#include <rpm/rpmtag.h>
+#include <rpm/rpmpgp.h>
+#include <rpm/rpmmacro.h>
+#include <asm/byteorder.h>
+
+#include "../common.h"
+
+static int gen_filename(Header rpm, char *filename, int filename_len)
+{
+	char *_filename = headerFormat(rpm, "rpm-%{nvra}", NULL);
+
+	if (!_filename)
+		return -ENOMEM;
+
+	strncpy(filename, _filename, filename_len);
+	free(_filename);
+	return 0;
+}
+
+static int write_rpm_header(Header rpm, int dirfd, char *filename)
+{
+	rpmtd immutable;
+	ssize_t ret;
+	int fd;
+
+	fd = openat(dirfd, filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd < 0)
+		return -EACCES;
+
+	ret = _write(fd, (void *)rpm_header_magic, sizeof(rpm_header_magic));
+	if (ret != sizeof(rpm_header_magic)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	immutable = rpmtdNew();
+	headerGet(rpm, RPMTAG_HEADERIMMUTABLE, immutable, 0);
+	ret = _write(fd, immutable->data, immutable->count);
+	if (ret != immutable->count) {
+		ret = -EIO;
+		goto out;
+	}
+
+	rpmtdFree(immutable);
+out:
+	close(fd);
+
+	if (ret < 0)
+		unlinkat(dirfd, filename, 0);
+
+	return ret;
+}
+
+static int write_rpm_header_signature(Header rpm, int dirfd, char *filename)
+{
+	char sig_to_convert[] = "/tmp/sig_to_convert_XXXXXX";
+	char uasym_sig[] = "/tmp/uasym_sig_XXXXXX";
+	struct module_signature modsig = { 0 };
+	rpmtd signature = rpmtdNew();
+	__u8 buf[1024];
+	struct stat st;
+	int ret, n_read, status, fd, fd_sig_to_convert, fd_uasym_sig;
+
+	fd_sig_to_convert = mkstemp(sig_to_convert);
+	if (fd_sig_to_convert == -1)
+		return -errno;
+
+	fd_uasym_sig = mkstemp(uasym_sig);
+	if (fd_uasym_sig == -1) {
+		ret = -errno;
+		goto out;
+	}
+
+	headerGet(rpm, RPMTAG_RSAHEADER, signature, 0);
+	if (!signature->count) {
+		printf("Warning: no RPM signature for %s\n", filename);
+		ret = 0;
+		goto out_get;
+	}
+
+	ret = _write(fd_sig_to_convert, signature->data, signature->count);
+	if (ret != signature->count)
+		goto out_get;
+
+	close(fd_sig_to_convert);
+	fd_sig_to_convert = -1;
+
+	if (fork() == 0)
+		return execlp("gpg", "gpg", "--no-keyring", "--conv-kernel",
+			      "-o", uasym_sig, sig_to_convert, NULL);
+
+	wait(&status);
+	if (WEXITSTATUS(status)) {
+		ret = WEXITSTATUS(status);
+		goto out_get;
+	}
+
+	if (stat(uasym_sig, &st) == -1)
+		goto out_get;
+
+	fd = openat(dirfd, filename, O_WRONLY | O_APPEND);
+	if (fd < 0) {
+		ret = -errno;
+		goto out_get;
+	}
+
+	modsig.id_type = PKEY_ID_PGP;
+	modsig.sig_len = st.st_size;
+	modsig.sig_len = __cpu_to_be32(modsig.sig_len);
+
+	while ((n_read = read(fd_uasym_sig, buf, sizeof(buf))) > 0) {
+		ret = _write(fd, buf, n_read);
+		if (ret != n_read)
+			goto out_fd;
+	}
+
+	ret = _write(fd, &modsig, sizeof(modsig));
+	if (ret != sizeof(modsig))
+		goto out_fd;
+
+	ret = _write(fd, MODULE_SIG_STRING, sizeof(MODULE_SIG_STRING) - 1);
+	if (ret != sizeof(MODULE_SIG_STRING) - 1)
+		goto out_fd;
+
+	ret = 0;
+out_fd:
+	close(fd);
+
+	if (ret < 0)
+		unlinkat(dirfd, filename, 0);
+out_get:
+	rpmtdFree(signature);
+out:
+	close(fd_sig_to_convert);
+	unlink(sig_to_convert);
+	close(fd_uasym_sig);
+	unlink(uasym_sig);
+
+	return ret;
+}
+
+static void write_rpm_digest_list(Header rpm, int dirfd, char *filename)
+{
+	int ret;
+
+	ret = write_rpm_header(rpm, dirfd, filename);
+	if (ret < 0) {
+		printf("Cannot dump RPM header of %s\n", filename);
+		return;
+	}
+
+	ret = write_rpm_header_signature(rpm, dirfd, filename);
+	if (ret < 0)
+		printf("Cannot add signature to %s\n", filename);
+}
+
+int rpm_list_gen_add(int dirfd, void *ptr, char *input)
+{
+	char filename[NAME_MAX + 1], *selection;
+	rpmts ts = NULL;
+	Header hdr;
+	FD_t fd;
+	rpmdbMatchIterator mi;
+	rpmVSFlags vsflags = 0;
+	int ret;
+
+	ts = rpmtsCreate();
+	if (!ts) {
+		rpmlog(RPMLOG_NOTICE, "rpmtsCreate() error..\n");
+		ret = -EACCES;
+		goto out;
+	}
+
+	ret = rpmReadConfigFiles(NULL, NULL);
+	if (ret != RPMRC_OK) {
+		rpmlog(RPMLOG_NOTICE, "Unable to read RPM configuration.\n");
+		ret = -EACCES;
+		goto out_ts;
+	}
+
+	if (strncmp(input, "rpmdb", 5)) {
+		vsflags |= _RPMVSF_NODIGESTS;
+		vsflags |= _RPMVSF_NOSIGNATURES;
+		rpmtsSetVSFlags(ts, vsflags);
+
+		fd = Fopen(input, "r.ufdio");
+		if (!fd || Ferror(fd)) {
+			rpmlog(RPMLOG_NOTICE,
+			       "Failed to open package file %s, %s\n", input,
+			       Fstrerror(fd));
+			ret = -EACCES;
+			goto out_rpm;
+		}
+
+		ret = rpmReadPackageFile(ts, fd, "rpm", &hdr);
+		Fclose(fd);
+
+		if (ret != RPMRC_OK) {
+			rpmlog(RPMLOG_NOTICE,
+			       "Could not read package file %s\n", input);
+			goto out_rpm;
+		}
+
+		gen_filename(hdr, filename, sizeof(filename));
+
+		write_rpm_digest_list(hdr, dirfd, filename);
+		headerFree(hdr);
+		goto out_rpm;
+	}
+
+	mi = rpmtsInitIterator(ts, RPMDBI_PACKAGES, NULL, 0);
+	while ((hdr = rpmdbNextIterator(mi)) != NULL) {
+		gen_filename(hdr, filename, sizeof(filename));
+
+		/* Skip rpm- */
+		if (strstr(filename + 4, "gpg-pubkey"))
+			continue;
+
+		selection = strchr(input, ':');
+		if (selection && !strstr(filename + 4, selection + 1))
+			continue;
+
+		write_rpm_digest_list(hdr, dirfd, filename);
+	}
+
+	rpmdbFreeIterator(mi);
+out_rpm:
+	rpmFreeRpmrc();
+	rpmFreeCrypto();
+	rpmFreeMacros(NULL);
+out_ts:
+	rpmtsFree(ts);
+out:
+	return ret;
+}
diff --git a/tools/digest-lists/manage_digest_lists.c b/tools/digest-lists/manage_digest_lists.c
index 7caad681eee..3985bfcb827 100644
--- a/tools/digest-lists/manage_digest_lists.c
+++ b/tools/digest-lists/manage_digest_lists.c
@@ -33,10 +33,12 @@ const char *ops_str[OP__LAST] = {
 struct generator generators[] = {
 	{ .name = "tlv", .new = tlv_list_gen_new, .add = tlv_list_gen_add,
 	  .close = tlv_list_gen_close },
+	{ .name = "rpm", .add = rpm_list_gen_add },
 };
 
 struct parser parsers[] = {
 	{ .name = "tlv", .parse = tlv_list_parse },
+	{ .name = "rpm", .parse = rpm_list_gen_parse },
 };
 
 static int generator_add(struct generator *generator, int dirfd,
diff --git a/tools/digest-lists/parsers/parsers.h b/tools/digest-lists/parsers/parsers.h
index 708da7eac3b..ecefb2ec79b 100644
--- a/tools/digest-lists/parsers/parsers.h
+++ b/tools/digest-lists/parsers/parsers.h
@@ -12,3 +12,5 @@
 #include <errno.h>
 
 int tlv_list_parse(const char *digest_list_path, enum ops op);
+
+int rpm_list_gen_parse(const char *digest_list_path, enum ops op);
diff --git a/tools/digest-lists/parsers/rpm.c b/tools/digest-lists/parsers/rpm.c
new file mode 100644
index 00000000000..7dd063b64ac
--- /dev/null
+++ b/tools/digest-lists/parsers/rpm.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Parse rpm digest lists.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <limits.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+#include <linux/xattr.h>
+#include <rpm/rpmlib.h>
+#include <rpm/header.h>
+#include <rpm/rpmts.h>
+#include <rpm/rpmdb.h>
+#include <rpm/rpmlog.h>
+#include <rpm/rpmtag.h>
+#include <rpm/rpmpgp.h>
+#include <rpm/rpmmacro.h>
+#include <asm/byteorder.h>
+
+#include "../common.h"
+
+static const enum hash_algo pgp_hash_algorithms[PGPHASHALGO_SHA224 + 1] = {
+	[PGPHASHALGO_MD5]		= HASH_ALGO_MD5,
+	[PGPHASHALGO_SHA1]		= HASH_ALGO_SHA1,
+	[PGPHASHALGO_RIPEMD160]		= HASH_ALGO_RIPE_MD_160,
+	[PGPHASHALGO_SHA256]		= HASH_ALGO_SHA256,
+	[PGPHASHALGO_SHA384]		= HASH_ALGO_SHA384,
+	[PGPHASHALGO_SHA512]		= HASH_ALGO_SHA512,
+	[PGPHASHALGO_SHA224]		= HASH_ALGO_SHA224,
+};
+
+int rpm_list_gen_parse(const char *digest_list_path, enum ops op)
+{
+	rpmtd filedigestalgo, filedigests, basenames, dirnames, dirindexes;
+	rpmts ts = NULL;
+	Header hdr;
+	FD_t fd;
+	rpmVSFlags vsflags = 0;
+	char file_path[PATH_MAX];
+	enum hash_algo algo = HASH_ALGO_MD5;
+	const char *digest_str, *basename, *dirname;
+	__u32 dirindex, *pgp_algo_ptr;
+	size_t digest_list_path_len = strlen(digest_list_path);
+	int ret;
+
+	ts = rpmtsCreate();
+	if (!ts) {
+		rpmlog(RPMLOG_NOTICE, "rpmtsCreate() error..\n");
+		ret = -EACCES;
+		goto out;
+	}
+
+	ret = rpmReadConfigFiles(NULL, NULL);
+	if (ret != RPMRC_OK) {
+		rpmlog(RPMLOG_NOTICE, "Unable to read RPM configuration.\n");
+		ret = -EACCES;
+		goto out_ts;
+	}
+
+	vsflags |= _RPMVSF_NODIGESTS;
+	vsflags |= _RPMVSF_NOSIGNATURES;
+	rpmtsSetVSFlags(ts, vsflags);
+
+	fd = Fopen(digest_list_path, "r.ufdio");
+	if (!fd || Ferror(fd)) {
+		rpmlog(RPMLOG_NOTICE, "Failed to open package file %s, %s\n",
+		       digest_list_path, Fstrerror(fd));
+		ret = -EACCES;
+		goto out_rpm;
+	}
+
+	ret = rpmReadHeader(ts, fd, &hdr, NULL);
+	Fclose(fd);
+
+	if (ret != RPMRC_OK) {
+		rpmlog(RPMLOG_NOTICE, "Could not read package file %s\n",
+		       digest_list_path);
+		goto out_rpm;
+	}
+
+	filedigestalgo = rpmtdNew();
+	filedigests = rpmtdNew();
+	basenames = rpmtdNew();
+	dirnames = rpmtdNew();
+	dirindexes = rpmtdNew();
+
+	headerGet(hdr, RPMTAG_FILEDIGESTALGO, filedigestalgo, 0);
+	headerGet(hdr, RPMTAG_FILEDIGESTS, filedigests, 0);
+	headerGet(hdr, RPMTAG_BASENAMES, basenames, 0);
+	headerGet(hdr, RPMTAG_DIRNAMES, dirnames, 0);
+	headerGet(hdr, RPMTAG_DIRINDEXES, dirindexes, 0);
+
+	pgp_algo_ptr = rpmtdGetUint32(filedigestalgo);
+	if (pgp_algo_ptr && *pgp_algo_ptr <= PGPHASHALGO_SHA224)
+		algo = pgp_hash_algorithms[*pgp_algo_ptr];
+
+	while ((digest_str = rpmtdNextString(filedigests))) {
+		basename = rpmtdNextString(basenames);
+		dirindex = *rpmtdNextUint32(dirindexes);
+
+		rpmtdSetIndex(dirnames, dirindex);
+		dirname = rpmtdGetString(dirnames);
+
+		snprintf(file_path, sizeof(file_path), "%s%s", dirname,
+			 basename);
+
+		if (!strlen(digest_str))
+			continue;
+
+		switch (op) {
+		case OP_SHOW:
+			printf("%s:%s %s\n", hash_algo_name[algo], digest_str,
+			       file_path);
+			ret = 0;
+			break;
+		case OP_ADD_XATTR:
+			ret = lsetxattr(file_path, XATTR_NAME_DIGEST_LIST,
+					digest_list_path,
+					digest_list_path_len, 0);
+			if (ret < 0 && errno == ENODATA)
+				ret = 0;
+
+			if (ret < 0)
+				printf("Error setting %s on %s, %s\n",
+				       XATTR_NAME_DIGEST_LIST, file_path,
+				       strerror(errno));
+			break;
+		case OP_RM_XATTR:
+			ret = lremovexattr(file_path, XATTR_NAME_DIGEST_LIST);
+			if (ret < 0 && errno == ENODATA)
+				ret = 0;
+
+			if (ret < 0)
+				printf("Error removing %s from %s, %s\n",
+				       XATTR_NAME_DIGEST_LIST, file_path,
+				       strerror(errno));
+			break;
+		default:
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		if (ret < 0)
+			break;
+	}
+
+	rpmtdFree(filedigestalgo);
+	rpmtdFree(filedigests);
+	rpmtdFree(basenames);
+	rpmtdFree(dirnames);
+	rpmtdFree(dirindexes);
+	headerFree(hdr);
+out_rpm:
+	rpmFreeRpmrc();
+	rpmFreeCrypto();
+	rpmFreeMacros(NULL);
+out_ts:
+	rpmtsFree(ts);
+out:
+	return ret;
+}
-- 
2.34.1


