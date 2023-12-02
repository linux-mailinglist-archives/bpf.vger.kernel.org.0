Return-Path: <bpf+bounces-16488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E662F801957
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 02:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0278CB20E14
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 01:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F417EF;
	Sat,  2 Dec 2023 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YJXSAzVa"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B1D67;
	Fri,  1 Dec 2023 17:11:24 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B20Jvdr030346;
	Fri, 1 Dec 2023 17:06:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=hDEGkKbbp8VYXoOaK9j5yE/sckJlu0FKBCKFLv1+oiU=;
 b=YJXSAzVacAvCX1biZtd0DeouGZhncoIqAJuXn/p+7hhgEhOUXzlggxHVNcjOSF2i8bwJ
 M8tP/LzfHl5CqlX86pf8lWCoKDiPZJ8GAK7HUVkiBZqsUkUHwHm0hP/zP9t9bBiZCcye
 XodAK3Fg/tVYf2fCUfbMuuE+96MiwMCTMSGhwy0mZTp0McS8RbiyNpJIYMRjgLV7CuB0
 5m6M39wO+OE7pELQuDwaCgDtWFBKBM5NC1SOAO4H1cX/ouOCUsBHDZ+eTsrqN3tnDMy4
 PDO8TFzmCfUzAAAmIpke9UfZ1ZL4AZYzy8WJiypLFTdtkrG+9gVg2lzeSm6GLKoZxfdS pA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uqbjwnq64-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 01 Dec 2023 17:06:17 -0800
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 1 Dec 2023 17:06:15 -0800
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v7 2/3] bpf: crypto: add skcipher to bpf crypto
Date: Fri, 1 Dec 2023 17:06:03 -0800
Message-ID: <20231202010604.1877561-2-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231202010604.1877561-1-vadfed@meta.com>
References: <20231202010604.1877561-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BU18nEM-MOccMjfak0_AqYhfN7gbScuj
X-Proofpoint-ORIG-GUID: BU18nEM-MOccMjfak0_AqYhfN7gbScuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_24,2023-11-30_01,2023-05-22_02

Implement skcipher crypto in BPF crypto framework.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v6 - v7:
- style issues
v6:
- introduce new file
---
 kernel/bpf/Makefile          |  3 ++
 kernel/bpf/crypto_skcipher.c | 76 ++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 kernel/bpf/crypto_skcipher.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index bcde762bb2c2..f4827bb72bee 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -43,6 +43,9 @@ obj-${CONFIG_BPF_LSM} += bpf_lsm.o
 endif
 ifeq ($(CONFIG_CRYPTO),y)
 obj-$(CONFIG_BPF_SYSCALL) += crypto.o
+ifeq ($(CONFIG_CRYPTO_SKCIPHER),y)
+obj-$(CONFIG_BPF_SYSCALL) += crypto_skcipher.o
+endif
 endif
 obj-$(CONFIG_BPF_PRELOAD) += preload/
 
diff --git a/kernel/bpf/crypto_skcipher.c b/kernel/bpf/crypto_skcipher.c
new file mode 100644
index 000000000000..d036eb64c1e2
--- /dev/null
+++ b/kernel/bpf/crypto_skcipher.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Meta, Inc */
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/bpf_crypto.h>
+#include <crypto/skcipher.h>
+
+static void *bpf_crypto_lskcipher_alloc_tfm(const char *algo)
+{
+	return crypto_alloc_lskcipher(algo, 0, 0);
+}
+
+static void bpf_crypto_lskcipher_free_tfm(void *tfm)
+{
+	crypto_free_lskcipher(tfm);
+}
+
+static int bpf_crypto_lskcipher_has_algo(const char *algo)
+{
+	return crypto_has_skcipher(algo, CRYPTO_ALG_TYPE_LSKCIPHER, CRYPTO_ALG_TYPE_MASK);
+}
+
+static int bpf_crypto_lskcipher_setkey(void *tfm, const u8 *key, unsigned int keylen)
+{
+	return crypto_lskcipher_setkey(tfm, key, keylen);
+}
+
+static u32 bpf_crypto_lskcipher_get_flags(void *tfm)
+{
+	return crypto_lskcipher_get_flags(tfm);
+}
+
+static unsigned int bpf_crypto_lskcipher_ivsize(void *tfm)
+{
+	return crypto_lskcipher_ivsize(tfm);
+}
+
+static int bpf_crypto_lskcipher_encrypt(void *tfm, const u8 *src, u8 *dst,
+					unsigned int len, u8 *iv)
+{
+	return crypto_lskcipher_encrypt(tfm, src, dst, len, iv);
+}
+
+static int bpf_crypto_lskcipher_decrypt(void *tfm, const u8 *src, u8 *dst,
+					unsigned int len, u8 *iv)
+{
+	return crypto_lskcipher_decrypt(tfm, src, dst, len, iv);
+}
+
+static const struct bpf_crypto_type bpf_crypto_lskcipher_type = {
+	.alloc_tfm	= bpf_crypto_lskcipher_alloc_tfm,
+	.free_tfm	= bpf_crypto_lskcipher_free_tfm,
+	.has_algo	= bpf_crypto_lskcipher_has_algo,
+	.setkey		= bpf_crypto_lskcipher_setkey,
+	.encrypt	= bpf_crypto_lskcipher_encrypt,
+	.decrypt	= bpf_crypto_lskcipher_decrypt,
+	.ivsize		= bpf_crypto_lskcipher_ivsize,
+	.get_flags	= bpf_crypto_lskcipher_get_flags,
+	.owner		= THIS_MODULE,
+	.name		= "skcipher",
+};
+
+static int __init bpf_crypto_skcipher_init(void)
+{
+	return bpf_crypto_register_type(&bpf_crypto_lskcipher_type);
+}
+
+static void __exit bpf_crypto_skcipher_exit(void)
+{
+	int err = bpf_crypto_unregister_type(&bpf_crypto_lskcipher_type);
+	WARN_ON_ONCE(err);
+}
+
+module_init(bpf_crypto_skcipher_init);
+module_exit(bpf_crypto_skcipher_exit);
+MODULE_LICENSE("GPL");
-- 
2.39.3


