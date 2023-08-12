Return-Path: <bpf+bounces-7648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35723779F18
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 12:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B6828108C
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139020FB;
	Sat, 12 Aug 2023 10:47:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFED20F6
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 10:47:47 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840BB2133;
	Sat, 12 Aug 2023 03:47:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RNHBV6P44z9yydx;
	Sat, 12 Aug 2023 18:36:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXC7scY9dkThi9AA--.8440S3;
	Sat, 12 Aug 2023 11:47:17 +0100 (CET)
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
Subject: [RFC][PATCH v2 01/13] ima: Introduce hook DIGEST_LIST_CHECK
Date: Sat, 12 Aug 2023 12:46:04 +0200
Message-Id: <20230812104616.2190095-2-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwBXC7scY9dkThi9AA--.8440S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF13Wry5Gr4Uuw15Cw18uFg_yoW5Kr1rpa
	1DKa40kry5XFy2kFZ3C3W29FW8K3yfKF4UG39093WvyF13AF18Xryayr9F9F1rGr4YkFna
	qrnIgr43Aa1jy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8-TmDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj46UrgABsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce a new hook to check the integrity of digest lists, whose digests
are added to the digest cache.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/ABI/testing/ima_policy | 1 +
 include/linux/kernel_read_file.h     | 1 +
 security/integrity/ima/ima.h         | 1 +
 security/integrity/ima/ima_main.c    | 3 ++-
 security/integrity/ima/ima_policy.c  | 3 +++
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 49db0ff288e..14d92c687ef 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -36,6 +36,7 @@ Description:
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
 				[SETXATTR_CHECK][MMAP_CHECK_REQPROT]
+				[DIGEST_LIST_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 90451e2e12b..85f602e49e2 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -14,6 +14,7 @@
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(DIGEST_LIST, digest-list)	\
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c99..3aef3d8fb57 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -203,6 +203,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(KEY_CHECK, key)				\
 	hook(CRITICAL_DATA, critical_data)		\
 	hook(SETXATTR_CHECK, setxattr_check)		\
+	hook(DIGEST_LIST_CHECK, digest_list_check)	\
 	hook(MAX_CHECK, none)
 
 #define __ima_hook_enumify(ENUM, str)	ENUM,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 365db0e43d7..81abdc8b233 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -771,7 +771,8 @@ const int read_idmap[READING_MAX_ID] = {
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-	[READING_POLICY] = POLICY_CHECK
+	[READING_POLICY] = POLICY_CHECK,
+	[READING_DIGEST_LIST] = DIGEST_LIST_CHECK,
 };
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c9b3bd8f1bb..b32c83d8a72 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1287,6 +1287,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	case MODULE_CHECK:
 	case KEXEC_KERNEL_CHECK:
 	case KEXEC_INITRAMFS_CHECK:
+	case DIGEST_LIST_CHECK:
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
@@ -1530,6 +1531,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = CRITICAL_DATA;
 			else if (strcmp(args[0].from, "SETXATTR_CHECK") == 0)
 				entry->func = SETXATTR_CHECK;
+			else if (strcmp(args[0].from, "DIGEST_LIST_CHECK") == 0)
+				entry->func = DIGEST_LIST_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.34.1


