Return-Path: <bpf+bounces-7653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B302D779F1D
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 12:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6829E2810CB
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450F20F6;
	Sat, 12 Aug 2023 10:48:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B751FB7
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 10:48:53 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1844A2D5B;
	Sat, 12 Aug 2023 03:48:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RNHCP2p8vz9yyf1;
	Sat, 12 Aug 2023 18:36:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXC7scY9dkThi9AA--.8440S8;
	Sat, 12 Aug 2023 11:48:04 +0100 (CET)
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
Subject: [RFC][PATCH v2 06/13] integrity/digest_cache: Parse rpm digest lists
Date: Sat, 12 Aug 2023 12:46:09 +0200
Message-Id: <20230812104616.2190095-7-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwBXC7scY9dkThi9AA--.8440S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Gry7tFW5KryrWw1rXry8uFg_yoW3trWkpa
	4DKFy8trWkXF1Skws7AF12kr1Sq3yqgFnFqrZ8uFn0yFZIvryjva18AryxZryrJr4DZFy7
	Gr4YqF129F4DtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5KVZQADsS
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Implement a simple parser of RPM headers, that extracts the digest and the
algorithm of the packaged files from the RPMTAG_FILEDIGESTS and
RPMTAG_FILEDIGESTALGO section, and add them to the digest cache.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/Makefile                   |   3 +-
 security/integrity/digest_cache.c             |   2 +
 .../integrity/digest_list_parsers/parsers.h   |   2 +
 security/integrity/digest_list_parsers/rpm.c  | 215 ++++++++++++++++++
 4 files changed, 221 insertions(+), 1 deletion(-)
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
index 818ac0ac0bf..fc392b925a5 100644
--- a/security/integrity/digest_cache.c
+++ b/security/integrity/digest_cache.c
@@ -144,6 +144,8 @@ static int digest_cache_parse_digest_list(struct digest_cache *digest_cache,
 
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
index 00000000000..df2029d042f
--- /dev/null
+++ b/security/integrity/digest_list_parsers/rpm.c
@@ -0,0 +1,215 @@
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
+
+#include "parsers.h"
+
+#define RPMTAG_FILEDIGESTS 1035
+#define RPMTAG_FILEDIGESTALGO 5011
+
+#define RPM_INT32_TYPE 4
+#define RPM_STRING_ARRAY_TYPE 8
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
+	const unsigned char rpm_header_magic[8] = {
+		0x8e, 0xad, 0xe8, 0x01, 0x00, 0x00, 0x00, 0x00
+	};
+	const struct rpm_hdr *hdr;
+	const struct rpm_entryinfo *entry;
+	uint32_t tags, max_tags, datasize;
+	uint32_t digests_count, max_digests_count;
+	uint32_t digests_offset, algo_offset;
+	uint32_t digest_len, pkg_pgp_algo, i;
+	bool algo_offset_set = false, digests_offset_set = false;
+	enum hash_algo pkg_kernel_algo = HASH_ALGO_MD5;
+	u8 rpm_digest[SHA512_DIGEST_SIZE];
+	int ret;
+
+	if (data_len < sizeof(*hdr)) {
+		pr_debug("Not enough data for RPM header, current %ld, expected: %ld\n",
+			 data_len, sizeof(*hdr));
+		return -EINVAL;
+	}
+
+	if (memcmp(data, rpm_header_magic, sizeof(rpm_header_magic))) {
+		pr_debug("RPM header magic mismatch\n");
+		return -EINVAL;
+	}
+
+	hdr = (const struct rpm_hdr *)data;
+	data += sizeof(*hdr);
+	data_len -= sizeof(*hdr);
+
+	tags = __be32_to_cpu(hdr->tags);
+	max_tags = data_len / sizeof(*entry);
+
+	/* Finite termination on tags loop. */
+	if (tags > max_tags)
+		return -EINVAL;
+
+	datasize = __be32_to_cpu(hdr->datasize);
+	if (datasize != data_len - tags * sizeof(*entry))
+		return -EINVAL;
+
+	pr_debug("Scanning %d RPM header sections\n", tags);
+	for (i = 0; i < tags; i++) {
+		if (data_len < sizeof(*entry))
+			return -EINVAL;
+
+		entry = (const struct rpm_entryinfo *)data;
+		data += sizeof(*entry);
+		data_len -= sizeof(*entry);
+
+		switch (__be32_to_cpu(entry->tag)) {
+		case RPMTAG_FILEDIGESTS:
+			if (__be32_to_cpu(entry->type) != RPM_STRING_ARRAY_TYPE)
+				return -EINVAL;
+
+			digests_offset = __be32_to_cpu(entry->offset);
+			digests_count = __be32_to_cpu(entry->count);
+			digests_offset_set = true;
+
+			pr_debug("Found RPMTAG_FILEDIGESTS at offset %u, count: %u\n",
+				 digests_offset, digests_count);
+			break;
+		case RPMTAG_FILEDIGESTALGO:
+			if (__be32_to_cpu(entry->type) != RPM_INT32_TYPE)
+				return -EINVAL;
+
+			algo_offset = __be32_to_cpu(entry->offset);
+			algo_offset_set = true;
+
+			pr_debug("Found RPMTAG_FILEDIGESTALGO at offset %u\n",
+				 algo_offset);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!digests_offset_set)
+		return -EINVAL;
+
+	if (algo_offset_set) {
+		if (algo_offset >= data_len)
+			return -EINVAL;
+
+		if (data_len - algo_offset < sizeof(uint32_t))
+			return -EINVAL;
+
+		pkg_pgp_algo = *(uint32_t *)&data[algo_offset];
+		pkg_pgp_algo = __be32_to_cpu(pkg_pgp_algo);
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
+	if (digests_offset > data_len)
+		return -EINVAL;
+
+	/* Worst case, every digest is a \0. */
+	max_digests_count = data_len - digests_offset;
+
+	/* Finite termination on digests_count loop. */
+	if (digests_count > max_digests_count)
+		return -EINVAL;
+
+	ret = digest_cache_init_htable(digest_cache, digests_count);
+	if (ret < 0)
+		return ret;
+
+	ret = -ENOENT;
+
+	for (i = 0; i < digests_count; i++) {
+		if (digests_offset == data_len)
+			return -EINVAL;
+
+		if (!data[digests_offset]) {
+			digests_offset++;
+			continue;
+		}
+
+		if (data_len - digests_offset < digest_len * 2 + 1)
+			return -EINVAL;
+
+		ret = hex2bin(rpm_digest, (const char *)&data[digests_offset],
+			      digest_len);
+		if (ret < 0) {
+			pr_debug("Invalid hex format for digest %s\n",
+				 &data[digests_offset]);
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = digest_cache_add(digest_cache, rpm_digest);
+		if (ret < 0)
+			return ret;
+
+		digests_offset += digest_len * 2 + 1;
+	}
+
+	return ret;
+}
-- 
2.34.1


