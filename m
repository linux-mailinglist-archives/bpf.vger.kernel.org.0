Return-Path: <bpf+bounces-27007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F2F8A75DC
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 22:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF782826AC
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8055A0F1;
	Tue, 16 Apr 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Mlbz1PrV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29332535A5;
	Tue, 16 Apr 2024 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713300056; cv=none; b=q3sqjkJbfJ6wt/YxBLbFpf8F1mhd8smJj7aIJGdFcH7LukzRU2J+9mmK4REHItVJ16Tj3UxxZspkn5v/UgThBaN4hhqOLuc1J4QerjOMwPLqsiw25lhnRfiDvabldQ6AW6+QPVDJv0UqxvVFvSaazYAYmCD5HZck3bzNAxf/d5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713300056; c=relaxed/simple;
	bh=/tpqiYLuqqoTef6twpLEacwLPQ0aqdS8lSI6lGPht+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1+7E7uh5W+SNyCPU45hO55ZOEuK93/ifE+VXmsuZJLWzRFX4pvzNkAyknazOLGygVky+qAhRmr1Eyr7HESOOJyr64giD9I8XZWvQ/OL6dzKC1pn1aaKriRlqP0PZNKhs3LXJ44KqMQbBIAO+3w28XDAwCPUPbbgZxyNnBFhtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Mlbz1PrV; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GKeb19011767;
	Tue, 16 Apr 2024 13:40:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=hgzjivbHOs/OEhvFcnO+bCh7luZIjNOj/mljRZ7xxMM=;
 b=Mlbz1PrV9WPlTEZ8ym+Ad+VKAk6JAomwFMkD00tVDfh++vS1lmAuk8YJbBjRB8gCQIeq
 dQGpaSuOhdtvgXuh5LiW30xvWbDGaP9elN+a7jT4QDXz+51i6KeYkJ6XoYFlHCskacGn
 sblZEG4BTHdcw3nSw6dPWbyd86YrLo7WpVbQky8HZMlGnj93vyYp7LJ1jZ+qssEThwQ4
 MG49lEaf6J1y3MiLgAfg2sedzA9eecYUqtYFK3WIZ3dvZfRKfP2cn2lFz8feFYjxI6Wi
 aoyPx5J4J8Q9txRYQB43c7qpn7rwNEUDj91DOaq7k6Bkc3dc6LXPGfn8TF3AoYR7rQvd Lw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xhbv96v3m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Apr 2024 13:40:42 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server id
 15.1.2507.35; Tue, 16 Apr 2024 13:40:22 -0700
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
Subject: [PATCH bpf-next v9 2/4] bpf: crypto: add skcipher to bpf crypto
Date: Tue, 16 Apr 2024 13:40:02 -0700
Message-ID: <20240416204004.3942393-3-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416204004.3942393-1-vadfed@meta.com>
References: <20240416204004.3942393-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TeIRETN0Oez23GXbCu00SWcxYfDe0Ieq
X-Proofpoint-ORIG-GUID: TeIRETN0Oez23GXbCu00SWcxYfDe0Ieq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02

Implement skcipher crypto in BPF crypto framework.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
v8 -> v9:
- add Herbert's Ack
v7 -> v8:
- Move bpf_crypto_skcipher.c to crypto and make it part of
  skcipher module. This way looks more natural and makes bpf crypto
  proper modular. MAINTAINERS files is adjusted to make bpf part
  belong to BPF maintainers.
v6 - v7:
- style issues
v6:
- introduce new file
---
 MAINTAINERS                  |  8 ++++
 crypto/Makefile              |  3 ++
 crypto/bpf_crypto_skcipher.c | 82 ++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 crypto/bpf_crypto_skcipher.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a233e1a3cf2..c9f887fbb477 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3822,6 +3822,14 @@ F:	kernel/bpf/tnum.c
 F:	kernel/bpf/trampoline.c
 F:	kernel/bpf/verifier.c
 
+BPF [CRYPTO]
+M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	crypto/bpf_crypto_skcipher.c
+F:	include/linux/bpf_crypto.h
+F:	kernel/bpf/crypto.c
+
 BPF [DOCUMENTATION] (Related to Standardization)
 R:	David Vernet <void@manifault.com>
 L:	bpf@vger.kernel.org
diff --git a/crypto/Makefile b/crypto/Makefile
index 408f0a1f9ab9..538124f8bf8a 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -20,6 +20,9 @@ crypto_skcipher-y += lskcipher.o
 crypto_skcipher-y += skcipher.o
 
 obj-$(CONFIG_CRYPTO_SKCIPHER2) += crypto_skcipher.o
+ifeq ($(CONFIG_BPF_SYSCALL),y)
+obj-$(CONFIG_CRYPTO_SKCIPHER2) += bpf_crypto_skcipher.o
+endif
 
 obj-$(CONFIG_CRYPTO_SEQIV) += seqiv.o
 obj-$(CONFIG_CRYPTO_ECHAINIV) += echainiv.o
diff --git a/crypto/bpf_crypto_skcipher.c b/crypto/bpf_crypto_skcipher.c
new file mode 100644
index 000000000000..b5e657415770
--- /dev/null
+++ b/crypto/bpf_crypto_skcipher.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Meta, Inc */
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
+static unsigned int bpf_crypto_lskcipher_statesize(void *tfm)
+{
+	return crypto_lskcipher_statesize(tfm);
+}
+
+static int bpf_crypto_lskcipher_encrypt(void *tfm, const u8 *src, u8 *dst,
+					unsigned int len, u8 *siv)
+{
+	return crypto_lskcipher_encrypt(tfm, src, dst, len, siv);
+}
+
+static int bpf_crypto_lskcipher_decrypt(void *tfm, const u8 *src, u8 *dst,
+					unsigned int len, u8 *siv)
+{
+	return crypto_lskcipher_decrypt(tfm, src, dst, len, siv);
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
+	.statesize	= bpf_crypto_lskcipher_statesize,
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
2.43.0


