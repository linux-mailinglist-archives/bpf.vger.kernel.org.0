Return-Path: <bpf+bounces-5632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59CC75CF9F
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DE6282403
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2380620F86;
	Fri, 21 Jul 2023 16:35:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26021500
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:35:49 +0000 (UTC)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D0B3C07;
	Fri, 21 Jul 2023 09:35:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4R6vxS4qdqz9xFfZ;
	Sat, 22 Jul 2023 00:23:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3hl1bs7pkcDDSBA--.22409S7;
	Fri, 21 Jul 2023 17:34:17 +0100 (CET)
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
Subject: [RFC][PATCH 05/12] integrity/digest_cache: Parse tlv digest lists
Date: Fri, 21 Jul 2023 18:33:19 +0200
Message-Id: <20230721163326.4106089-6-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwC3hl1bs7pkcDDSBA--.22409S7
X-Coremail-Antispam: 1UD129KBjvJXoWfGr47Jr17tFWDGw4xJFWkZwb_yoWDCry5pa
	sxKF18KrW7GF1fCw4xAF17Cr4fKrZ09rW7KFWruw1ayrWDZr1qk3Z2kFy8Zry5tr4DW3W7
	Jw4agF909r4DXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj5DJQgAAsq
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a parser for TLV-formatted (Type Length Value) digest lists. Their
structure is:

[header: DIGEST_LIST_FILE, num fields, total len]
[field: DIGEST_LIST_ALGO, length, value]
[field: DIGEST_LIST_ENTRY#1, length, value (below)]
 |- [header: DIGEST_LIST_FILE, num fields, total len]
 |- [ENTRY#1_DIGEST, length, file digest]
 |- [ENTRY#1_PATH, length, file path]
[field: DIGEST_LIST_ENTRY#N, length, value (below)]
 |- [header: DIGEST_LIST_FILE, num fields, total len]
 |- [ENTRY#N_DIGEST, length, file digest]
 |- [ENTRY#N_PATH, length, file path]

Defined fields are sufficient for measurement/appraisal of file content.
More fields can be introduced later (e.g. for appraisal of file metadata).

This patch defines only the callbacks (handlers) for the defined fields.
The parsing logic is already introduced in lib/tlv_parser.c.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/uapi/linux/tlv_digest_list.h          |  59 ++++++
 security/integrity/Makefile                   |   3 +-
 security/integrity/digest_cache.c             |   4 +
 .../integrity/digest_list_parsers/parsers.h   |  13 ++
 security/integrity/digest_list_parsers/tlv.c  | 188 ++++++++++++++++++
 5 files changed, 266 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/tlv_digest_list.h
 create mode 100644 security/integrity/digest_list_parsers/parsers.h
 create mode 100644 security/integrity/digest_list_parsers/tlv.c

diff --git a/include/uapi/linux/tlv_digest_list.h b/include/uapi/linux/tlv_digest_list.h
new file mode 100644
index 00000000000..52987b63877
--- /dev/null
+++ b/include/uapi/linux/tlv_digest_list.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Export definitions of the tlv digest list.
+ */
+
+#ifndef _UAPI_LINUX_TLV_DIGEST_LIST_H
+#define _UAPI_LINUX_TLV_DIGEST_LIST_H
+
+#include <linux/types.h>
+
+#define FOR_EACH_DIGEST_LIST_TYPE(DIGEST_LIST_TYPE) \
+	DIGEST_LIST_TYPE(DIGEST_LIST_FILE) \
+	DIGEST_LIST_TYPE(DIGEST_LIST__LAST)
+
+#define FOR_EACH_FIELD(FIELD) \
+	FIELD(DIGEST_LIST_ALGO) \
+	FIELD(DIGEST_LIST_ENTRY) \
+	FIELD(FIELD__LAST)
+
+#define FOR_EACH_ENTRY_FIELD(ENTRY_FIELD) \
+	ENTRY_FIELD(ENTRY_DIGEST) \
+	ENTRY_FIELD(ENTRY_PATH) \
+	ENTRY_FIELD(ENTRY__LAST)
+
+#define GENERATE_ENUM(ENUM) ENUM,
+#define GENERATE_STRING(STRING) #STRING,
+
+/**
+ * enum digest_list_types - Type of digest list
+ *
+ * Enumerates the types of digest lists to parse.
+ */
+enum digest_list_types {
+	FOR_EACH_DIGEST_LIST_TYPE(GENERATE_ENUM)
+};
+
+/**
+ * enum fields - Digest list fields
+ *
+ * Enumerates the digest list fields.
+ */
+enum digest_list_fields {
+	FOR_EACH_FIELD(GENERATE_ENUM)
+};
+
+/**
+ * enum entry_fields - Entry-specific fields
+ *
+ * Enumerates the digest list entry-specific fields.
+ */
+enum entry_fields {
+	FOR_EACH_ENTRY_FIELD(GENERATE_ENUM)
+};
+
+#endif /* _UAPI_LINUX_TLV_DIGEST_LIST_H */
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index c856ed10fba..3765b004e66 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -12,7 +12,8 @@ integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
 integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
 integrity-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o \
-					      digest_cache_iter.o
+					      digest_cache_iter.o \
+					      digest_list_parsers/tlv.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digest_cache.c b/security/integrity/digest_cache.c
index 7537c7232db..a486dc1ff50 100644
--- a/security/integrity/digest_cache.c
+++ b/security/integrity/digest_cache.c
@@ -18,6 +18,7 @@
 #include <linux/module_signature.h>
 
 #include "integrity.h"
+#include "digest_list_parsers/parsers.h"
 
 #ifdef pr_fmt
 #undef pr_fmt
@@ -126,6 +127,9 @@ static int digest_cache_parse_digest_list(struct digest_cache *digest_cache,
 parse:
 	pr_debug("Parsing %s, size: %ld\n", digest_cache->path_str, data_len);
 
+	if (!strncmp(digest_list_path->dentry->d_name.name, "tlv-", 4))
+		ret = digest_list_parse_tlv(digest_cache, data, data_len);
+
 	return ret;
 }
 
diff --git a/security/integrity/digest_list_parsers/parsers.h b/security/integrity/digest_list_parsers/parsers.h
new file mode 100644
index 00000000000..e8fff2374d8
--- /dev/null
+++ b/security/integrity/digest_list_parsers/parsers.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Digest list parsers.
+ */
+
+#include "../digest_cache.h"
+
+int digest_list_parse_tlv(struct digest_cache *digest_cache, const u8 *data,
+			  size_t data_len);
diff --git a/security/integrity/digest_list_parsers/tlv.c b/security/integrity/digest_list_parsers/tlv.c
new file mode 100644
index 00000000000..239400f5786
--- /dev/null
+++ b/security/integrity/digest_list_parsers/tlv.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Parse a tlv digest list.
+ */
+
+#define pr_fmt(fmt) "TLV DIGEST LIST: "fmt
+#include <linux/fs.h>
+#include <linux/hash_info.h>
+#include <linux/tlv_parser.h>
+#include <uapi/linux/tlv_digest_list.h>
+
+#include "parsers.h"
+
+#define kenter(FMT, ...) \
+	pr_debug("==> %s("FMT")\n", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) \
+	pr_debug("<== %s()"FMT"\n", __func__, ##__VA_ARGS__)
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
+static int parse_digest_list_algo(struct digest_cache *digest_cache,
+				  enum digest_list_fields field,
+				  const u8 *field_data, u64 field_data_len)
+{
+	u8 algo;
+	int ret = 0;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	if (digest_cache->algo != HASH_ALGO__LAST) {
+		pr_debug("Digest algorithm already set to %s\n",
+			 hash_algo_name[digest_cache->algo]);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	if (field_data_len != sizeof(u8)) {
+		pr_debug("Unexpected data length %llu, expected %lu\n",
+			 field_data_len, sizeof(u8));
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	algo = *field_data;
+
+	if (algo >= HASH_ALGO__LAST) {
+		pr_debug("Unexpected digest algo %u\n", algo);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	digest_cache->algo = algo;
+	pr_debug("Digest algo: %s\n", hash_algo_name[algo]);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static int parse_entry_digest(struct digest_cache *digest_cache,
+			      enum entry_fields field, const u8 *field_data,
+			      u64 field_data_len)
+{
+	int ret = 0;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	if (field_data_len != hash_digest_size[digest_cache->algo]) {
+		pr_debug("Unexpected data length %llu, expected %d\n",
+			 field_data_len, hash_digest_size[digest_cache->algo]);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	digest_cache_add(digest_cache, (u8 *)field_data);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static int entry_callback(void *callback_data, u64 field, const u8 *field_data,
+			  u64 field_data_len)
+{
+	struct digest_cache *digest_cache;
+	int ret;
+
+	digest_cache = (struct digest_cache *)callback_data;
+
+	switch (field) {
+	case ENTRY_DIGEST:
+		ret = parse_entry_digest(digest_cache, field, field_data,
+					 field_data_len);
+		break;
+	case ENTRY_PATH:
+		ret = 0;
+		break;
+	default:
+		pr_debug("Unhandled field %s\n", entry_fields_str[field]);
+		/* Just ignore non-relevant fields. */
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int parse_digest_list_entry(struct digest_cache *digest_cache,
+				   enum digest_list_fields field,
+				   const u8 *field_data, u64 field_data_len)
+{
+	int ret;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	ret = tlv_parse(DIGEST_LIST_FILE, entry_callback, digest_cache,
+			field_data, field_data_len, digest_list_types_str,
+			DIGEST_LIST__LAST, entry_fields_str, ENTRY__LAST);
+
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static int digest_list_callback(void *callback_data, u64 field,
+				const u8 *field_data, u64 field_data_len)
+{
+	struct digest_cache *digest_cache;
+	int ret;
+
+	digest_cache = (struct digest_cache *)callback_data;
+
+	switch (field) {
+	case DIGEST_LIST_ALGO:
+		ret = parse_digest_list_algo(digest_cache, field, field_data,
+					     field_data_len);
+		break;
+	case DIGEST_LIST_ENTRY:
+		ret = parse_digest_list_entry(digest_cache, field, field_data,
+					      field_data_len);
+		break;
+	default:
+		pr_debug("Unhandled field %s\n",
+			 digest_list_fields_str[field]);
+		/* Just ignore non-relevant fields. */
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+int digest_list_parse_tlv(struct digest_cache *digest_cache, const u8 *data,
+			  size_t data_len)
+{
+	u64 parsed_data_type;
+	u64 parsed_num_fields;
+	u64 parsed_total_len;
+	int ret;
+
+	ret = tlv_parse_hdr(&data, &data_len, &parsed_data_type,
+			    &parsed_num_fields, &parsed_total_len,
+			    digest_list_types_str, DIGEST_LIST__LAST);
+	if (ret < 0)
+		return ret;
+
+	if (parsed_data_type != DIGEST_LIST_FILE)
+		return 0;
+
+	ret = digest_cache_init_htable(digest_cache, parsed_num_fields);
+	if (ret < 0)
+		return ret;
+
+	return tlv_parse_data(digest_list_callback, digest_cache,
+			      parsed_num_fields, data, data_len,
+			      digest_list_fields_str, FIELD__LAST);
+}
-- 
2.34.1


