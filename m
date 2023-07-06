Return-Path: <bpf+bounces-4258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC9749F55
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 16:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3D11C20D98
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11839472;
	Thu,  6 Jul 2023 14:45:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B39453
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 14:45:33 +0000 (UTC)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1CB1FEB;
	Thu,  6 Jul 2023 07:45:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QxfDh6JwQz9v7Gk;
	Thu,  6 Jul 2023 22:34:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHQg0y06ZkPxkwBA--.58122S3;
	Thu, 06 Jul 2023 15:44:44 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	jarkko@kernel.org,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org,
	wiktor@metacode.biz,
	devel@lists.sequoia-pgp.org,
	gnupg-devel@gnupg.org,
	ebiggers@kernel.org,
	Jason@zx2c4.com,
	mail@maciej.szmigiero.name,
	antony@vennard.ch,
	konstantin@linuxfoundation.org,
	James.Bottomley@HansenPartnership.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 01/10] crypto: Export public key algorithm information
Date: Thu,  6 Jul 2023 16:42:14 +0200
Message-Id: <20230706144225.1046544-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHQg0y06ZkPxkwBA--.58122S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy7ur13WrW8Gw47uw1UGFg_yoWrGFWDpr
	s09a1rX3y8ZFy7KryS9FyFyryft3yF9r15tanrXw1fAFn7tw18Jrs2vrZrCF1kXFsrJ3yr
	ua97ZF9rGw18GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr
	1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jxtxhUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4vZ6gAAsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Export the public keys algorithm identifiers, so that user space can
reference them when passing data to the kernel.

Define and export the pub_key_algo_name array, so that kernel subsystems
can get the string associated to the public key algorithm identifier.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/Kconfig                    |  3 +++
 crypto/Makefile                   |  1 +
 crypto/pub_key_info.c             | 20 ++++++++++++++++++++
 include/crypto/pub_key_info.h     | 15 +++++++++++++++
 include/uapi/linux/pub_key_info.h | 22 ++++++++++++++++++++++
 5 files changed, 61 insertions(+)
 create mode 100644 crypto/pub_key_info.c
 create mode 100644 include/crypto/pub_key_info.h
 create mode 100644 include/uapi/linux/pub_key_info.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 650b1b3620d..2558025461b 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1420,6 +1420,9 @@ endmenu
 config CRYPTO_HASH_INFO
 	bool
 
+config CRYPTO_PUB_KEY_INFO
+	bool
+
 if !KMSAN # avoid false positives from assembly
 if ARM
 source "arch/arm/crypto/Kconfig"
diff --git a/crypto/Makefile b/crypto/Makefile
index 953a7e105e5..fcdb5918e58 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -206,6 +206,7 @@ obj-$(CONFIG_XOR_BLOCKS) += xor.o
 obj-$(CONFIG_ASYNC_CORE) += async_tx/
 obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += asymmetric_keys/
 obj-$(CONFIG_CRYPTO_HASH_INFO) += hash_info.o
+obj-$(CONFIG_CRYPTO_PUB_KEY_INFO) += pub_key_info.o
 crypto_simd-y := simd.o
 obj-$(CONFIG_CRYPTO_SIMD) += crypto_simd.o
 
diff --git a/crypto/pub_key_info.c b/crypto/pub_key_info.c
new file mode 100644
index 00000000000..d12a08e5972
--- /dev/null
+++ b/crypto/pub_key_info.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Public key info: Public key algorithms information
+ */
+
+#include <linux/export.h>
+#include <crypto/pub_key_info.h>
+
+const char *const pub_key_algo_name[PKEY_ALGO__LAST] = {
+	[PKEY_ALGO_RSA]		= "rsa",
+	[PKEY_ALGO_ECDSA]	= "ecdsa",
+	[PKEY_ALGO_ECDSA_P192]	= "ecdsa-nist-p192",
+	[PKEY_ALGO_ECDSA_P256]	= "ecdsa-nist-p256",
+	[PKEY_ALGO_ECDSA_P384]	= "ecdsa-nist-p384",
+	[PKEY_ALGO_ECRDSA]	= "ecrdsa",
+	[PKEY_ALGO_SM2]		= "sm2",
+};
+EXPORT_SYMBOL_GPL(pub_key_algo_name);
diff --git a/include/crypto/pub_key_info.h b/include/crypto/pub_key_info.h
new file mode 100644
index 00000000000..ea411792778
--- /dev/null
+++ b/include/crypto/pub_key_info.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Public key info: Public key algorithms information
+ */
+
+#ifndef _CRYPTO_PUB_KEY_INFO_H
+#define _CRYPTO_PUB_KEY_INFO_H
+
+#include <uapi/linux/pub_key_info.h>
+
+extern const char *const pub_key_algo_name[PKEY_ALGO__LAST];
+
+#endif /* _CRYPTO_PUB_KEY_INFO_H */
diff --git a/include/uapi/linux/pub_key_info.h b/include/uapi/linux/pub_key_info.h
new file mode 100644
index 00000000000..a5595969156
--- /dev/null
+++ b/include/uapi/linux/pub_key_info.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Public key info: Public key algorithms information
+ */
+
+#ifndef _UAPI_LINUX_PUB_KEY_INFO_H
+#define _UAPI_LINUX_PUB_KEY_INFO_H
+
+enum pub_key_algo {
+	PKEY_ALGO_RSA,
+	PKEY_ALGO_ECDSA,
+	PKEY_ALGO_ECDSA_P192,
+	PKEY_ALGO_ECDSA_P256,
+	PKEY_ALGO_ECDSA_P384,
+	PKEY_ALGO_ECRDSA,
+	PKEY_ALGO_SM2,
+	PKEY_ALGO__LAST,
+};
+
+#endif /* _UAPI_LINUX_PUB_KEY_INFO_H */
-- 
2.34.1


