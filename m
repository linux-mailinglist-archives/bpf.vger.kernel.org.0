Return-Path: <bpf+bounces-5636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2173875CFB5
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0DA281AF2
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D723BC9;
	Fri, 21 Jul 2023 16:36:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098F26B61
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:36:15 +0000 (UTC)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E4A30D2;
	Fri, 21 Jul 2023 09:35:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4R6vyK645Dz9xFfT;
	Sat, 22 Jul 2023 00:24:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3hl1bs7pkcDDSBA--.22409S13;
	Fri, 21 Jul 2023 17:35:02 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	jarkko@kernel.org,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 11/12] tools/digest-lists: Add tlv digest list generator and parser
Date: Fri, 21 Jul 2023 18:33:25 +0200
Message-Id: <20230721163326.4106089-12-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
References: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwC3hl1bs7pkcDDSBA--.22409S13
X-Coremail-Antispam: 1UD129KBjvAXoWfXr1xCr18urykKr43AFW5Wrg_yoW8WFWxZo
	ZaqF43Gw48Jr129F4kuF43ZF47Wa9Yqay5Aw1rGrWDX3WFyF18Ka1qka13Ja13Zw18trWj
	v3W0q3yagw48KrZ7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOo7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
	Aaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIF
	yTuYvjxUxrcTDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj5DJRQACsv
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a generator of tlv digest lists. It will store the digest
algorithm, the digest and path of each file provided as input.

Also add a parser of tlv digest lists. It will display the content (digest
algorithm and value, and file path), and will add/remove the
security.digest_list xattr to/from each file in the digest list.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/digest-lists/.gitignore              |   2 +
 tools/digest-lists/Makefile                |  22 ++-
 tools/digest-lists/generators/generators.h |  16 ++
 tools/digest-lists/generators/tlv.c        | 168 ++++++++++++++++++
 tools/digest-lists/manage_digest_lists.c   |   5 +
 tools/digest-lists/parsers/parsers.h       |  14 ++
 tools/digest-lists/parsers/tlv.c           | 195 +++++++++++++++++++++
 tools/digest-lists/parsers/tlv_parser.h    |  38 ++++
 8 files changed, 458 insertions(+), 2 deletions(-)
 create mode 100644 tools/digest-lists/generators/generators.h
 create mode 100644 tools/digest-lists/generators/tlv.c
 create mode 100644 tools/digest-lists/parsers/parsers.h
 create mode 100644 tools/digest-lists/parsers/tlv.c
 create mode 100644 tools/digest-lists/parsers/tlv_parser.h

diff --git a/tools/digest-lists/.gitignore b/tools/digest-lists/.gitignore
index 1b8a7b9c205..9a75ae766ff 100644
--- a/tools/digest-lists/.gitignore
+++ b/tools/digest-lists/.gitignore
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 manage_digest_lists
 manage_digest_lists.1
+libgen-tlv-list.so
+libparse-tlv-list.so
diff --git a/tools/digest-lists/Makefile b/tools/digest-lists/Makefile
index 05af3a91c06..23f9fa3b588 100644
--- a/tools/digest-lists/Makefile
+++ b/tools/digest-lists/Makefile
@@ -1,13 +1,23 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../scripts/Makefile.include
+include ../scripts/Makefile.arch
 include ../scripts/utilities.mak
+
 BINDIR=usr/bin
+ifeq ($(LP64), 1)
+  LIBDIR=usr/lib64
+else
+  LIBDIR=usr/lib
+endif
 MANDIR=usr/share/man
 MAN1DIR=$(MANDIR)/man1
 CFLAGS=-ggdb -Wall
 
 PROGS=manage_digest_lists
 
+GENERATORS=libgen-tlv-list.so
+PARSERS=libparse-tlv-list.so
+
 MAN1=manage_digest_lists.1
 
 A2X=a2x
@@ -15,9 +25,15 @@ a2x_path := $(call get-executable,$(A2X))
 
 all: man $(PROGS)
 
-manage_digest_lists: manage_digest_lists.c common.c
+manage_digest_lists: manage_digest_lists.c common.c $(GENERATORS) $(PARSERS)
 	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS) -lcrypto
 
+libgen-tlv-list.so: generators/tlv.c common.c
+	$(CC) $(CFLAGS) -fPIC --shared -Wl,-soname,libgen-tlv-list.so $^ -o $@
+
+libparse-tlv-list.so: parsers/tlv.c common.c ../../lib/tlv_parser.c
+	$(CC) $(CFLAGS) -fPIC --shared -Wl,-soname,libparse-tlv-list.so $^ -o $@ -I parsers
+
 ifneq ($(findstring $(MAKEFLAGS),s),s)
   ifneq ($(V),1)
      QUIET_A2X = @echo '  A2X     '$@;
@@ -32,7 +48,7 @@ else
 endif
 
 clean:
-	rm -f $(MAN1) $(PROGS)
+	rm -f $(MAN1) $(PROGS) $(GENERATORS) $(PARSERS)
 
 man: $(MAN1)
 
@@ -43,6 +59,8 @@ install-man: man
 install-tools: $(PROGS)
 	install -d -m 755 $(INSTALL_ROOT)/$(BINDIR)
 	install -m 755 -p $(PROGS) "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
+	install -m 755 -p $(GENERATORS) "$(INSTALL_ROOT)/$(LIBDIR)/$(TARGET)"
+	install -m 755 -p $(PARSERS) "$(INSTALL_ROOT)/$(LIBDIR)/$(TARGET)"
 
 install: install-tools install-man
 .PHONY: all clean man install-tools install-man install
diff --git a/tools/digest-lists/generators/generators.h b/tools/digest-lists/generators/generators.h
new file mode 100644
index 00000000000..9830b791667
--- /dev/null
+++ b/tools/digest-lists/generators/generators.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header for all digest list generators.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+
+void *tlv_list_gen_new(int dirfd, char *input, enum hash_algo algo);
+int tlv_list_gen_add(int dirfd, void *ptr, char *input);
+void tlv_list_gen_close(void *ptr);
diff --git a/tools/digest-lists/generators/tlv.c b/tools/digest-lists/generators/tlv.c
new file mode 100644
index 00000000000..cbc29a49f51
--- /dev/null
+++ b/tools/digest-lists/generators/tlv.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Generate tlv digest lists.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <limits.h>
+#include <sys/mman.h>
+#include <sys/xattr.h>
+#include <linux/xattr.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <linux/hash_info.h>
+#include <asm/byteorder.h>
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+#include "../../../include/uapi/linux/tlv_parser.h"
+#include "../../../include/uapi/linux/tlv_digest_list.h"
+#include "../common.h"
+
+struct tlv_struct {
+	__u8 *digest_list;
+	struct tlv_hdr *outer_hdr;
+	struct tlv_entry *outer_entry;
+	__u8 algo;
+	int fd;
+};
+
+static int new_digest_list(int dirfd, const char *input, struct tlv_struct *tlv)
+{
+	char filename[NAME_MAX + 1];
+	struct tlv_hdr *hdr;
+	const char *input_ptr;
+
+	input_ptr = strrchr(input, '/');
+	if (input_ptr)
+		input_ptr++;
+	else
+		input_ptr = input;
+
+	snprintf(filename, sizeof(filename), "tlv-%s", input_ptr);
+
+	tlv->fd = openat(dirfd, filename, O_RDWR | O_CREAT | O_TRUNC, 0644);
+	if (tlv->fd < 0) {
+		printf("Unable to create %s\n", filename);
+		return -errno;
+	}
+
+	ftruncate(tlv->fd, DIGEST_LIST_SIZE_MAX);
+	tlv->digest_list = mmap(NULL, DIGEST_LIST_SIZE_MAX,
+				PROT_READ | PROT_WRITE, MAP_SHARED, tlv->fd, 0);
+
+	if (tlv->digest_list == MAP_FAILED) {
+		printf("Cannot allocate buffer\n");
+		close(tlv->fd);
+		return -ENOMEM;
+	}
+
+	hdr = (struct tlv_hdr *)tlv->digest_list;
+	memset(hdr, 0, sizeof(*hdr));
+
+	hdr->data_type = __cpu_to_be64(DIGEST_LIST_FILE);
+	hdr->num_fields = 0;
+	hdr->total_len = 0;
+	return 0;
+}
+
+static void write_entry(struct tlv_hdr *hdr, struct tlv_entry **entry,
+			__u16 field, __u8 *data, __u32 data_len,
+			bool update_data)
+{
+	__u16 num_fields;
+	__u64 total_len;
+	__u64 entry_len;
+
+	num_fields = __be64_to_cpu(hdr->num_fields);
+	total_len = __be64_to_cpu(hdr->total_len);
+
+	(*entry)->field = __cpu_to_be64(field);
+	(*entry)->length = __cpu_to_be64(data_len);
+
+	if (update_data)
+		memcpy((*entry)->data, data, data_len);
+
+	num_fields++;
+	entry_len = sizeof(*(*entry)) + data_len;
+	total_len += entry_len;
+
+	hdr->num_fields = __cpu_to_be64(num_fields);
+	hdr->total_len = __cpu_to_be64(total_len);
+	(*entry) = (struct tlv_entry *)((__u8 *)*entry + entry_len);
+}
+
+void *tlv_list_gen_new(int dirfd, char *input, enum hash_algo algo)
+{
+	struct tlv_struct *tlv;
+	int ret;
+
+	tlv = malloc(sizeof(*tlv));
+	if (!tlv)
+		return NULL;
+
+	ret = new_digest_list(dirfd, input, tlv);
+	if (ret < 0) {
+		free(tlv);
+		return NULL;
+	}
+
+	tlv->outer_hdr = (struct tlv_hdr *)tlv->digest_list;
+	tlv->outer_entry = (struct tlv_entry *)(tlv->outer_hdr + 1);
+	tlv->algo = algo;
+
+	write_entry(tlv->outer_hdr, &tlv->outer_entry, DIGEST_LIST_ALGO,
+		    &tlv->algo, sizeof(tlv->algo), true);
+	return tlv;
+}
+
+int tlv_list_gen_add(int dirfd, void *ptr, char *input)
+{
+	struct tlv_struct *tlv = (struct tlv_struct *)ptr;
+	__u8 digest[SHA512_DIGEST_SIZE];
+	struct tlv_hdr *inner_hdr;
+	struct tlv_entry *inner_entry;
+	int ret;
+
+	ret = calc_file_digest(digest, input, tlv->algo);
+	if (ret < 0) {
+		printf("Cannot calculate digest of %s\n", input);
+		return ret;
+	}
+
+	inner_hdr = (struct tlv_hdr *)(tlv->outer_entry + 1);
+	inner_hdr->data_type = __cpu_to_be64(DIGEST_LIST_FILE);
+
+	inner_entry = (struct tlv_entry *)(inner_hdr + 1);
+
+	write_entry(inner_hdr, &inner_entry, ENTRY_DIGEST, digest,
+		    hash_digest_size[tlv->algo], true);
+	write_entry(inner_hdr, &inner_entry, ENTRY_PATH, (__u8 *)input,
+		    strlen(input) + 1, true);
+
+	write_entry(tlv->outer_hdr, &tlv->outer_entry, DIGEST_LIST_ENTRY, NULL,
+		    (__u8 *)inner_entry - (__u8 *)inner_hdr, false);
+	return 0;
+}
+
+void tlv_list_gen_close(void *ptr)
+{
+	struct tlv_struct *tlv = (struct tlv_struct *)ptr;
+
+	munmap(tlv->digest_list, DIGEST_LIST_SIZE_MAX);
+	ftruncate(tlv->fd, (__u8 *)tlv->outer_entry - (__u8 *)tlv->outer_hdr);
+	close(tlv->fd);
+	free(tlv);
+}
diff --git a/tools/digest-lists/manage_digest_lists.c b/tools/digest-lists/manage_digest_lists.c
index 9da62bd3570..db5680506a8 100644
--- a/tools/digest-lists/manage_digest_lists.c
+++ b/tools/digest-lists/manage_digest_lists.c
@@ -20,6 +20,8 @@
 #include <fts.h>
 
 #include "common.h"
+#include "generators/generators.h"
+#include "parsers/parsers.h"
 
 const char *ops_str[OP__LAST] = {
 	[OP_GEN] = "gen",
@@ -29,9 +31,12 @@ const char *ops_str[OP__LAST] = {
 };
 
 struct generator generators[] = {
+	{ .name = "tlv", .new = tlv_list_gen_new, .add = tlv_list_gen_add,
+	  .close = tlv_list_gen_close },
 };
 
 struct parser parsers[] = {
+	{ .name = "tlv", .parse = tlv_list_parse },
 };
 
 static int generator_add(struct generator *generator, int dirfd,
diff --git a/tools/digest-lists/parsers/parsers.h b/tools/digest-lists/parsers/parsers.h
new file mode 100644
index 00000000000..708da7eac3b
--- /dev/null
+++ b/tools/digest-lists/parsers/parsers.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header for all digest list parsers.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+
+int tlv_list_parse(const char *digest_list_path, enum ops op);
diff --git a/tools/digest-lists/parsers/tlv.c b/tools/digest-lists/parsers/tlv.c
new file mode 100644
index 00000000000..1c9909e80b9
--- /dev/null
+++ b/tools/digest-lists/parsers/tlv.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Parse tlv digest lists.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <limits.h>
+#include <sys/mman.h>
+#include <sys/xattr.h>
+#include <linux/xattr.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <linux/hash_info.h>
+#include <asm/byteorder.h>
+#include <tlv_parser.h>
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+#include "../../../include/uapi/linux/tlv_digest_list.h"
+#include "../common.h"
+
+struct tlv_parse_ctx {
+	const char *digest_list_path;
+	size_t digest_list_path_len;
+	enum hash_algo algo;
+	enum ops op;
+};
+
+const char *digest_list_types_str[] = {
+	FOR_EACH_DIGEST_LIST_TYPE(GENERATE_STRING)
+};
+
+const char *digest_list_fields_str[] = {
+	FOR_EACH_FIELD(GENERATE_STRING)
+};
+
+const char *entry_fields_str[] = {
+	FOR_EACH_ENTRY_FIELD(GENERATE_STRING)
+};
+
+static int parse_digest_list_algo(struct tlv_parse_ctx *ctx,
+				  enum digest_list_fields field,
+				  const __u8 *field_data, __u64 field_data_len)
+{
+	ctx->algo = *field_data;
+	return 0;
+}
+
+static int parse_entry_digest(struct tlv_parse_ctx *ctx,
+			      enum entry_fields field, const __u8 *field_data,
+			      __u64 field_data_len)
+{
+	int i;
+
+	if (ctx->op != OP_SHOW)
+		return 0;
+
+	printf("%s:", hash_algo_name[ctx->algo]);
+
+	for (i = 0; i < hash_digest_size[ctx->algo]; i++)
+		printf("%02x", field_data[i]);
+
+	return 0;
+}
+
+static int parse_entry_path(struct tlv_parse_ctx *ctx, enum entry_fields field,
+			    const __u8 *field_data, __u64 field_data_len)
+{
+	char *entry_path = (char *)field_data;
+	int ret;
+
+	switch (ctx->op) {
+	case OP_SHOW:
+		printf(" %s\n", entry_path);
+		ret = 0;
+		break;
+	case OP_ADD_XATTR:
+		ret = lsetxattr(entry_path, XATTR_NAME_DIGEST_LIST,
+				ctx->digest_list_path,
+				ctx->digest_list_path_len, 0);
+		if (ret < 0 && errno == ENODATA)
+			ret = 0;
+
+		if (ret < 0)
+			printf("Error setting %s on %s, %s\n",
+			       XATTR_NAME_DIGEST_LIST, entry_path,
+			       strerror(errno));
+		break;
+	case OP_RM_XATTR:
+		ret = lremovexattr(entry_path, XATTR_NAME_DIGEST_LIST);
+		if (ret < 0 && errno == ENODATA)
+			ret = 0;
+
+		if (ret < 0)
+			printf("Error removing %s from %s, %s\n",
+			       XATTR_NAME_DIGEST_LIST, entry_path,
+			       strerror(errno));
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int entry_callback(void *callback_data, __u64 field,
+			  const __u8 *field_data, __u64 field_data_len)
+{
+	struct tlv_parse_ctx *ctx = (struct tlv_parse_ctx *)callback_data;
+	int ret;
+
+	switch (field) {
+	case ENTRY_DIGEST:
+		ret = parse_entry_digest(ctx, field, field_data,
+					 field_data_len);
+		break;
+	case ENTRY_PATH:
+		ret = parse_entry_path(ctx, field, field_data, field_data_len);
+		break;
+	default:
+		pr_debug("Unhandled field %llu\n", field);
+		/* Just ignore non-relevant fields. */
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int parse_digest_list_entry(struct tlv_parse_ctx *ctx,
+				   enum digest_list_fields field,
+				   const __u8 *field_data, __u64 field_data_len)
+{
+	return tlv_parse(DIGEST_LIST_FILE, entry_callback, ctx, field_data,
+			 field_data_len, digest_list_types_str,
+			 DIGEST_LIST__LAST, entry_fields_str, ENTRY__LAST);
+}
+
+static int digest_list_callback(void *callback_data, __u64 field,
+				const __u8 *field_data, __u64 field_data_len)
+{
+	struct tlv_parse_ctx *ctx = (struct tlv_parse_ctx *)callback_data;
+	int ret;
+
+	switch (field) {
+	case DIGEST_LIST_ALGO:
+		ret = parse_digest_list_algo(ctx, field, field_data,
+					     field_data_len);
+		break;
+	case DIGEST_LIST_ENTRY:
+		ret = parse_digest_list_entry(ctx, field, field_data,
+					      field_data_len);
+		break;
+	default:
+		pr_debug("Unhandled field %llu\n", field);
+		/* Just ignore non-relevant fields. */
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+int tlv_list_parse(const char *digest_list_path, enum ops op)
+{
+	struct tlv_parse_ctx ctx = {
+		.op = op, .digest_list_path = digest_list_path,
+		.digest_list_path_len = strlen(digest_list_path)
+	};
+	unsigned char *data;
+	size_t data_len;
+	int ret;
+
+	ret = read_file(digest_list_path, &data_len, &data);
+	if (ret < 0)
+		return ret;
+
+	ret = tlv_parse(DIGEST_LIST_FILE, digest_list_callback, &ctx, data,
+			data_len, digest_list_types_str, DIGEST_LIST__LAST,
+			digest_list_fields_str, FIELD__LAST);
+
+	munmap(data, data_len);
+	return ret;
+}
diff --git a/tools/digest-lists/parsers/tlv_parser.h b/tools/digest-lists/parsers/tlv_parser.h
new file mode 100644
index 00000000000..3c9f54a97b3
--- /dev/null
+++ b/tools/digest-lists/parsers/tlv_parser.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file of TLV parser.
+ */
+
+#ifndef _TLV_PARSER_H
+#define _TLV_PARSER_H
+
+#include <stdio.h>
+#include <errno.h>
+#include <stddef.h>
+#include <asm/byteorder.h>
+#include <linux/tlv_parser.h>
+
+#ifdef TLV_DEBUG
+#define pr_debug(fmt, ...) printf(fmt, ##__VA_ARGS__)
+#else
+#define pr_debug(fmt, ...) { }
+#endif
+
+typedef int (*parse_callback)(void *, __u64, const __u8 *, __u64);
+
+int tlv_parse_hdr(const __u8 **data, size_t *data_len, __u64 *parsed_data_type,
+		  __u64 *parsed_num_fields, __u64 *parsed_total_len,
+		  const char **data_types, __u64 num_data_types);
+int tlv_parse_data(parse_callback callback, void *callback_data,
+		   __u64 parsed_num_fields, const __u8 *data, size_t data_len,
+		   const char **fields, __u64 num_fields);
+int tlv_parse(__u64 expected_data_type, parse_callback callback,
+	      void *callback_data, const __u8 *data, size_t data_len,
+	      const char **data_types, __u64 num_data_types,
+	      const char **fields, __u64 num_fields);
+
+#endif /* _TLV_PARSER_H */
-- 
2.34.1


