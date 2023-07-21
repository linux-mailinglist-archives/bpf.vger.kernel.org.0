Return-Path: <bpf+bounces-5631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0D275CF98
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131B8282389
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706571ED27;
	Fri, 21 Jul 2023 16:35:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45320FBD
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:35:46 +0000 (UTC)
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA8E10CE;
	Fri, 21 Jul 2023 09:35:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6vvQ0JSVz9v7cT;
	Sat, 22 Jul 2023 00:21:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3hl1bs7pkcDDSBA--.22409S8;
	Fri, 21 Jul 2023 17:34:24 +0100 (CET)
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
Subject: [RFC][PATCH 06/12] integrity/digest_cache: Parse rpm digest lists
Date: Fri, 21 Jul 2023 18:33:20 +0200
Message-Id: <20230721163326.4106089-7-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwC3hl1bs7pkcDDSBA--.22409S8
X-Coremail-Antispam: 1UD129KBjvJXoW3AFWkAr1xCw17Xr13ZryxXwb_yoWxKw1fpa
	sxKFy8KrWkXF1Sk3yxAF12kF1Sq3yjg3W2qrW5urn0yFZ7Zr1jvw18GryxZryrJr4DZFy7
	Kr4YqF1I9F4qqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4zMlgAAsk
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Implement a simple parser of RPM headers, that extracts the digest of the
packaged files from the RPMTAG_FILEDIGESTS and RPMTAG_FILEDIGESTALGO
section, and add them to the digest cache.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/Makefile                   |   3 +-
 security/integrity/digest_cache.c             |   2 +
 .../integrity/digest_list_parsers/parsers.h   |   2 +
 security/integrity/digest_list_parsers/rpm.c  | 174 ++++++++++++++++++
 4 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/digest_list_parsers/rpm.c

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 3765b004e66..c4c17a57d84 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -13,7 +13,8 @@ integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyrin
 integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
 integrity-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o \
 					      digest_cache_iter.o \
-					      digest_list_parsers/tlv.o
+					      digest_list_parsers/tlv.o \
+					      digest_list_parsers/rpm.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digest_cache.c b/security/integrity/digest_cache.c
index a486dc1ff50..3bf0e6d06bf 100644
--- a/security/integrity/digest_cache.c
+++ b/security/integrity/digest_cache.c
@@ -129,6 +129,8 @@ static int digest_cache_parse_digest_list(struct digest_cache *digest_cache,
 
 	if (!strncmp(digest_list_path->dentry->d_name.name, "tlv-", 4))
 		ret = digest_list_parse_tlv(digest_cache, data, data_len);
+	else if (!strncmp(digest_list_path->dentry->d_name.name, "rpm-", 4))
+		ret = digest_list_parse_rpm(digest_cache, data, data_len);
 
 	return ret;
 }
diff --git a/security/integrity/digest_list_parsers/parsers.h b/security/integrity/digest_list_parsers/parsers.h
index e8fff2374d8..f86e58e9806 100644
--- a/security/integrity/digest_list_parsers/parsers.h
+++ b/security/integrity/digest_list_parsers/parsers.h
@@ -11,3 +11,5 @@
 
 int digest_list_parse_tlv(struct digest_cache *digest_cache, const u8 *data,
 			  size_t data_len);
+int digest_list_parse_rpm(struct digest_cache *digest_cache, const u8 *data,
+			  size_t data_len);
diff --git a/security/integrity/digest_list_parsers/rpm.c b/security/integrity/digest_list_parsers/rpm.c
new file mode 100644
index 00000000000..a4c1d0350ec
--- /dev/null
+++ b/security/integrity/digest_list_parsers/rpm.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Parse an rpm digest list (RPM package header).
+ */
+
+#define pr_fmt(fmt) "RPM DIGEST LIST: "fmt
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/init_task.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+
+#define RPMTAG_FILEDIGESTS 1035
+#define RPMTAG_FILEDIGESTALGO 5011
+
+#include "parsers.h"
+
+struct rpm_hdr {
+	u32 magic;
+	u32 reserved;
+	u32 tags;
+	u32 datasize;
+} __packed;
+
+struct rpm_entryinfo {
+	s32 tag;
+	u32 type;
+	s32 offset;
+	u32 count;
+} __packed;
+
+enum pgp_algos {
+	DIGEST_ALGO_MD5		=  1,
+	DIGEST_ALGO_SHA1	=  2,
+	DIGEST_ALGO_RMD160	=  3,
+	/* 4, 5, 6, and 7 are reserved. */
+	DIGEST_ALGO_SHA256	=  8,
+	DIGEST_ALGO_SHA384	=  9,
+	DIGEST_ALGO_SHA512	= 10,
+	DIGEST_ALGO_SHA224	= 11,
+};
+
+static const enum hash_algo pgp_algo_mapping[DIGEST_ALGO_SHA224 + 1] = {
+	[DIGEST_ALGO_MD5]	= HASH_ALGO_MD5,
+	[DIGEST_ALGO_SHA1]	= HASH_ALGO_SHA1,
+	[DIGEST_ALGO_RMD160]	= HASH_ALGO_RIPE_MD_160,
+	[4]			= HASH_ALGO__LAST,
+	[5]			= HASH_ALGO__LAST,
+	[6]			= HASH_ALGO__LAST,
+	[7]			= HASH_ALGO__LAST,
+	[DIGEST_ALGO_SHA256]	= HASH_ALGO_SHA256,
+	[DIGEST_ALGO_SHA384]	= HASH_ALGO_SHA384,
+	[DIGEST_ALGO_SHA512]	= HASH_ALGO_SHA512,
+	[DIGEST_ALGO_SHA224]	= HASH_ALGO_SHA224,
+};
+
+int digest_list_parse_rpm(struct digest_cache *digest_cache, const u8 *data,
+			  size_t data_len)
+{
+	const u8 *bufp = data, *bufendp = data + data_len;
+	const u8 *datap, *digests = NULL, *algo_buf = NULL;
+	struct rpm_hdr *hdr = (struct rpm_hdr *)bufp;
+	struct rpm_entryinfo *entry;
+	u32 tags = be32_to_cpu(hdr->tags);
+	u32 digests_count = 0;
+	enum hash_algo pkg_kernel_algo = HASH_ALGO_MD5;
+	enum pgp_algos pkg_pgp_algo;
+	u8 rpm_digest[SHA512_DIGEST_SIZE];
+	int ret, i, digest_len;
+
+	const unsigned char rpm_header_magic[8] = {
+		0x8e, 0xad, 0xe8, 0x01, 0x00, 0x00, 0x00, 0x00
+	};
+
+	if (data_len < sizeof(*hdr)) {
+		pr_debug("Not enough data for RPM header, current %ld, expected: %ld\n",
+			 data_len, sizeof(*hdr));
+		return -EINVAL;
+	}
+
+	if (memcmp(bufp, rpm_header_magic, sizeof(rpm_header_magic))) {
+		pr_debug("RPM header magic mismatch\n");
+		return -EINVAL;
+	}
+
+	bufp += sizeof(*hdr);
+	datap = bufp + tags * sizeof(struct rpm_entryinfo);
+
+	pr_debug("Scanning %d RPM header sections\n", tags);
+
+	for (i = 0; i < tags && (bufp + sizeof(*entry)) <= bufendp;
+	     i++, bufp += sizeof(*entry)) {
+		entry = (struct rpm_entryinfo *)bufp;
+
+		switch (be32_to_cpu(entry->tag)) {
+		case RPMTAG_FILEDIGESTS:
+			digests = datap + be32_to_cpu(entry->offset);
+			digests_count = be32_to_cpu(entry->count);
+			pr_debug("Found RPMTAG_FILEDIGESTS at offset %ld, count: %d\n",
+				 digests - data, digests_count);
+			break;
+		case RPMTAG_FILEDIGESTALGO:
+			algo_buf = datap + be32_to_cpu(entry->offset);
+			pr_debug("Found RPMTAG_FILEDIGESTALGO at offset %ld\n",
+				 algo_buf - data);
+			break;
+		}
+
+		if (digests && algo_buf)
+			break;
+	}
+
+	if (!digests)
+		return 0;
+
+	if (algo_buf && algo_buf + sizeof(u32) <= bufendp) {
+		pkg_pgp_algo = be32_to_cpu(*(u32 *)algo_buf);
+		if (pkg_pgp_algo > DIGEST_ALGO_SHA224) {
+			pr_debug("Unknown PGP algo %d\n", pkg_pgp_algo);
+			return -EINVAL;
+		}
+
+		pkg_kernel_algo = pgp_algo_mapping[pkg_pgp_algo];
+		if (pkg_kernel_algo >= HASH_ALGO__LAST) {
+			pr_debug("Unknown mapping for PGP algo %d\n",
+				 pkg_pgp_algo);
+			return -EINVAL;
+		}
+
+		pr_debug("Found mapping for PGP algo %d: %s\n", pkg_pgp_algo,
+			 hash_algo_name[pkg_kernel_algo]);
+	}
+
+	digest_cache->algo = pkg_kernel_algo;
+	digest_len = hash_digest_size[pkg_kernel_algo];
+
+	ret = digest_cache_init_htable(digest_cache, digests_count);
+	if (ret < 0)
+		return ret;
+
+	ret = -ENOENT;
+
+	for (i = 0; i < digests_count && digests < bufendp; i++) {
+		if (!*digests) {
+			digests++;
+			continue;
+		}
+
+		if (digests + digest_len * 2 + 1 > bufendp) {
+			pr_debug("Read beyond end\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = hex2bin(rpm_digest, digests, digest_len);
+		if (ret < 0) {
+			pr_debug("Invalid hex format for digest %s\n", digests);
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = digest_cache_add(digest_cache, rpm_digest);
+		if (ret < 0)
+			return ret;
+
+		digests += digest_len * 2 + 1;
+	}
+
+	return ret;
+}
-- 
2.34.1


