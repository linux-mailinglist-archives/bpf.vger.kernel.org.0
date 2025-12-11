Return-Path: <bpf+bounces-76455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F77CB4854
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 03:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A58D3002142
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 02:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1422C0307;
	Thu, 11 Dec 2025 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J8LP7FCT"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516F2BDC32;
	Thu, 11 Dec 2025 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419208; cv=none; b=pRwwY94xtkNEIbhqO+488wjtSuTDtPihb3HU9os/dVjz1X832kDT7/6XHv0VvSQloDzRaGANoNXy3fxOg64qNhMYId6vI3cPPMjnBpXmxrhlQ75H0Yblqvqjv9r395nX91naHdHOSTmXmqPiUgroq9Ec+/hflEWQ8rLCbIJRS2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419208; c=relaxed/simple;
	bh=38eFVkVie/Vy+ZY3T+ue8ul1yRsyl1JiEYo5u8TdQh4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqbU/qI5+dv12Z3ve6FqLEACbYwXvopN81J6lyTaaCTxjsuhXVbq5lNAku3Ng1Vx+pYwo7DLqTXo7C53bpPmXT4qFeaLeudMqdgMjVId2cBbUQn0IHlKqAKNsL6pjPep5s+IiGxIGMDJhORv51sPwqxi3eqMSSRC9YFj8ygBD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J8LP7FCT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 820AC2116049;
	Wed, 10 Dec 2025 18:13:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 820AC2116049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765419205;
	bh=19gqP6RcNdFMv4Osb1338Yn4ALv5mzANh2hYkAKtQvk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J8LP7FCTwgS0jDD29ahXIkFw1jfcadSXGptr09O4xCC5/SrfUaGQCEvog1udXqGWB
	 6rPuED66XsV6bq2bMYCHTgxX4/7rRI2MtI39W8RIrETuOv5jE1ns5EWF3juIItDG8k
	 689kEZHSmRcU6cyY/OzoipFOyPi8EHYqWB8LxZys=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC 09/11] hornet: Introduce gen_sig
Date: Wed, 10 Dec 2025 18:12:04 -0800
Message-ID: <20251211021257.1208712-10-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This introduces the gen_sig tool. It creates a pkcs#7 signature of a
data payload. Additionally it appends a signed attribute containing a
set of hashes.

Typical usage is to provide a payload containing the light skeleton
ebpf syscall program binary and it's associated maps, which can be
extracted from the auto-generated skeleton header.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 scripts/Makefile            |   1 +
 scripts/hornet/Makefile     |   5 +
 scripts/hornet/gen_sig.c    | 392 ++++++++++++++++++++++++++++++++++++
 scripts/hornet/write-sig.sh |  27 +++
 4 files changed, 425 insertions(+)
 create mode 100644 scripts/hornet/Makefile
 create mode 100644 scripts/hornet/gen_sig.c
 create mode 100755 scripts/hornet/write-sig.sh

diff --git a/scripts/Makefile b/scripts/Makefile
index 46f860529df5e..a2cace05d7342 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -57,6 +57,7 @@ subdir-$(CONFIG_GENKSYMS) += genksyms
 subdir-$(CONFIG_GENDWARFKSYMS) += gendwarfksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 subdir-$(CONFIG_SECURITY_IPE) += ipe
+subdir-$(CONFIG_SECURITY_HORNET) += hornet
 
 # Let clean descend into subdirs
 subdir-	+= basic dtc gdb kconfig mod
diff --git a/scripts/hornet/Makefile b/scripts/hornet/Makefile
new file mode 100644
index 0000000000000..3ee41e5e9a9ff
--- /dev/null
+++ b/scripts/hornet/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+hostprogs-always-y	:= gen_sig
+
+HOSTCFLAGS_gen_sig.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
+HOSTLDLIBS_gen_sig = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
new file mode 100644
index 0000000000000..1d501efeb8f13
--- /dev/null
+++ b/scripts/hornet/gen_sig.c
@@ -0,0 +1,392 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+ *
+ * Generate a signature for an eBPF program along with appending
+ * map hashes as signed attributes
+ *
+ * Copyright © 2025      Microsoft Corporation.
+ *
+ * Authors: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1
+ * of the licence, or (at your option) any later version.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <err.h>
+
+#include <openssl/cms.h>
+#include <openssl/err.h>
+#include <openssl/evp.h>
+#include <openssl/pkcs7.h>
+#include <openssl/x509.h>
+#include <openssl/pem.h>
+#include <openssl/objects.h>
+#include <openssl/asn1.h>
+#include <openssl/asn1t.h>
+#include <openssl/opensslv.h>
+#include <openssl/bio.h>
+#include <openssl/stack.h>
+
+#if OPENSSL_VERSION_MAJOR >= 3
+# define USE_PKCS11_PROVIDER
+# include <openssl/provider.h>
+# include <openssl/store.h>
+#else
+# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+#  define USE_PKCS11_ENGINE
+#  include <openssl/engine.h>
+# endif
+#endif
+#include "../ssl-common.h"
+
+#define SHA256_LEN 32
+#define BUF_SIZE   (1 << 15) // 32 KiB
+#define MAX_HASHES 64
+
+struct hash_spec {
+	char *file;
+};
+
+typedef struct {
+	ASN1_INTEGER *index;
+	ASN1_OCTET_STRING *hash;
+
+} HORNET_MAP;
+
+DECLARE_ASN1_FUNCTIONS(HORNET_MAP)
+ASN1_SEQUENCE(HORNET_MAP) = {
+	ASN1_SIMPLE(HORNET_MAP, index, ASN1_INTEGER),
+	ASN1_SIMPLE(HORNET_MAP, hash, ASN1_OCTET_STRING)
+} ASN1_SEQUENCE_END(HORNET_MAP);
+
+IMPLEMENT_ASN1_FUNCTIONS(HORNET_MAP)
+
+DEFINE_STACK_OF(HORNET_MAP)
+
+typedef struct {
+	STACK_OF(HORNET_MAP) * maps;
+} MAP_SET;
+
+DECLARE_ASN1_FUNCTIONS(MAP_SET)
+ASN1_SEQUENCE(MAP_SET) = {
+	ASN1_SET_OF(MAP_SET, maps, HORNET_MAP)
+} ASN1_SEQUENCE_END(MAP_SET);
+
+IMPLEMENT_ASN1_FUNCTIONS(MAP_SET)
+
+#define DIE(...) do { fprintf(stderr, __VA_ARGS__); fputc('\n', stderr); \
+		exit(EXIT_FAILURE); } while (0)
+
+static BIO *bio_open_wr(const char *path)
+{
+	BIO *b = BIO_new_file(path, "wb");
+
+	if (!b) {
+		perror(path);
+		ERR_print_errors_fp(stderr);
+		exit(EXIT_FAILURE);
+	}
+	return b;
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"Usage:\n"
+		"  %s -data content.bin -cert signer.crt -key signer.key [-pass pass]\n"
+		"     -out newsig.p7b \n"
+		"     --add-hash FILE [--add-hash FILE ...]\n",
+		prog);
+}
+
+static const char *key_pass;
+
+static int pem_pw_cb(char *buf, int len, int w, void *v)
+{
+	int pwlen;
+
+	if (!key_pass)
+		return -1;
+
+	pwlen = strlen(key_pass);
+	if (pwlen >= len)
+		return -1;
+
+	strcpy(buf, key_pass);
+
+	key_pass = NULL;
+
+	return pwlen;
+}
+
+static EVP_PKEY *read_private_key(const char *private_key_name)
+{
+	EVP_PKEY *private_key;
+	BIO *b;
+
+	b = BIO_new_file(private_key_name, "rb");
+	ERR(!b, "%s", private_key_name);
+	private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
+					      NULL);
+	ERR(!private_key, "%s", private_key_name);
+	BIO_free(b);
+
+	return private_key;
+}
+
+static X509 *read_x509(const char *x509_name)
+{
+	unsigned char buf[2];
+	X509 *x509;
+	BIO *b;
+	int n;
+
+	b = BIO_new_file(x509_name, "rb");
+	ERR(!b, "%s", x509_name);
+
+	/* Look at the first two bytes of the file to determine the encoding */
+	n = BIO_read(b, buf, 2);
+	if (n != 2) {
+		if (BIO_should_retry(b)) {
+			fprintf(stderr, "%s: Read wanted retry\n", x509_name);
+			exit(1);
+		}
+		if (n >= 0) {
+			fprintf(stderr, "%s: Short read\n", x509_name);
+			exit(1);
+		}
+		ERR(1, "%s", x509_name);
+	}
+
+	ERR(BIO_reset(b) != 0, "%s", x509_name);
+
+	if (buf[0] == 0x30 && buf[1] >= 0x81 && buf[1] <= 0x84)
+		/* Assume raw DER encoded X.509 */
+		x509 = d2i_X509_bio(b, NULL);
+	else
+		/* Assume PEM encoded X.509 */
+		x509 = PEM_read_bio_X509(b, NULL, NULL, NULL);
+
+	BIO_free(b);
+	ERR(!x509, "%s", x509_name);
+
+	return x509;
+}
+
+static int sha256(const char *path, unsigned char out[SHA256_LEN], unsigned int *out_len)
+{
+	FILE *f;
+	int rc;
+	EVP_MD_CTX *ctx;
+	unsigned char buf[BUF_SIZE];
+	size_t n;
+	unsigned int mdlen = 0;
+
+	if (!path || !out)
+		return -1;
+
+	f = fopen(path, "rb");
+	if (!f) {
+		perror("fopen");
+		return -2;
+	}
+
+	ERR_load_crypto_strings();
+
+	rc = -3;
+	ctx = EVP_MD_CTX_new();
+	if (!ctx) {
+		rc = -4;
+		goto done;
+	}
+
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+	if (EVP_DigestInit_ex2(ctx, EVP_sha256(), NULL) != 1) {
+		rc = -5;
+		goto done;
+	}
+#else
+	if (EVP_DigestInit_ex(ctx, EVP_sha256(), NULL) != 1) {
+		rc = -5;
+		goto done;
+	}
+#endif
+	while ((n = fread(buf, 1, sizeof(buf), f)) > 0) {
+		if (EVP_DigestUpdate(ctx, buf, n) != 1) {
+			rc = -6;
+			goto done;
+		}
+	}
+	if (ferror(f)) {
+		rc = -7;
+		goto done;
+	}
+
+	if (EVP_DigestFinal_ex(ctx, out, &mdlen) != 1) {
+		rc = -8;
+		goto done;
+	}
+	if (mdlen != SHA256_LEN) {
+		rc = -9;
+		goto done;
+	}
+
+	if (out_len)
+		*out_len = mdlen;
+	rc = 0;
+
+done:
+	EVP_MD_CTX_free(ctx);
+	fclose(f);
+	ERR_free_strings();
+	return rc;
+}
+
+static void add_hash(MAP_SET *set, unsigned char *buffer, int buffer_len, int index)
+{
+	HORNET_MAP *map = NULL;
+
+	map = HORNET_MAP_new();
+	ASN1_INTEGER_set(map->index, index);
+	ASN1_OCTET_STRING_set(map->hash, buffer, buffer_len);
+	sk_HORNET_MAP_push(set->maps, map);
+}
+
+int main(int argc, char **argv)
+{
+	const char *cert_path = NULL;
+	const char *key_path = NULL;
+	const char *data_path = NULL;
+	const char *out_path = NULL;
+
+	X509 *signer;
+	EVP_PKEY *pkey;
+	BIO *data_in;
+	CMS_ContentInfo *cms_out;
+	struct hash_spec hashes[MAX_HASHES];
+	int hash_count = 0;
+	int flags;
+	CMS_SignerInfo *si;
+	MAP_SET *set;
+	unsigned char hash_buffer[SHA256_LEN];
+	unsigned int hash_len;
+	ASN1_OBJECT *oid;
+	unsigned char *der = NULL;
+	int der_len;
+	int err;
+	BIO *b_out;
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "-cert") && i+1 < argc)
+			cert_path = argv[++i];
+		else if (!strcmp(argv[i], "-data") && i+1 < argc)
+			data_path = argv[++i];
+		else if (!strcmp(argv[i], "-key") && i+1 < argc)
+			key_path  = argv[++i];
+		else if (!strcmp(argv[i], "-pass") && i+1 < argc)
+			key_pass  = argv[++i];
+		else if (!strcmp(argv[i], "-out") && i+1 < argc)
+			out_path  = argv[++i];
+		else if (!strcmp(argv[i], "--add-skip-check")) {
+			hashes[hash_count++].file = NULL;
+			i++;
+		} else if (!strcmp(argv[i], "--add-hash") && i+1 < argc) {
+			hashes[hash_count++].file = argv[++i];
+		} else {
+			usage(argv[0]);
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (!cert_path || !key_path || !out_path || !data_path) {
+		usage(argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	OpenSSL_add_all_algorithms();
+	ERR_load_crypto_strings();
+
+	signer = read_x509(cert_path);
+	if (!signer) {
+		ERR_print_errors_fp(stderr);
+		DIE("Load cert failed");
+	}
+
+	pkey = read_private_key(key_path);
+	if (!pkey) {
+		ERR_print_errors_fp(stderr);
+		DIE("Load key failed");
+	}
+
+	data_in = BIO_new_file(data_path, "rb");
+	if (!data_in) {
+		ERR_print_errors_fp(stderr);
+		DIE("Load data failed");
+	}
+
+	cms_out = CMS_sign(NULL, NULL, NULL, NULL,
+					    CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY | CMS_DETACHED);
+
+	if (!cms_out) {
+		ERR_print_errors_fp(stderr);
+		DIE("create cms failed");
+	}
+
+	flags = CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY | CMS_NOSMIMECAP | CMS_DETACHED;
+
+	si = CMS_add1_signer(cms_out, signer, pkey, EVP_sha256(), flags);
+	if (!si)
+		DIE("add signer failed");
+
+	set = MAP_SET_new();
+	set->maps = sk_HORNET_MAP_new_null();
+
+	for (i = 0; i < hash_count; i++) {
+		if (hashes[i].file) {
+			sha256(hashes[i].file, hash_buffer, &hash_len);
+		} else {
+			memset(hash_buffer, 0, SHA256_LEN);
+			hash_len = SHA256_LEN;
+		}
+		add_hash(set, hash_buffer, hash_len, i);
+	}
+
+	oid = OBJ_txt2obj("2.25.316487325684022475439036912669789383960", 1);
+	if (!oid) {
+		ERR_print_errors_fp(stderr);
+		DIE("create oid failed");
+	}
+
+	der_len = ASN1_item_i2d((ASN1_VALUE *)set, &der, ASN1_ITEM_rptr(MAP_SET));
+	CMS_signed_add1_attr_by_OBJ(si, oid, V_ASN1_SEQUENCE, der, der_len);
+
+	err = CMS_final(cms_out, data_in, NULL, CMS_NOCERTS | CMS_BINARY);
+	if (err == 0)
+		ERR_print_errors_fp(stderr);
+
+	OPENSSL_free(der);
+	MAP_SET_free(set);
+
+	b_out = bio_open_wr(out_path);
+	if (!b_out) {
+		ERR_print_errors_fp(stderr);
+		DIE("opening output path failed");
+	}
+
+	i2d_CMS_bio_stream(b_out, cms_out, NULL, 0);
+
+	BIO_free(data_in);
+	BIO_free(b_out);
+	EVP_cleanup();
+	ERR_free_strings();
+	return 0;
+}
diff --git a/scripts/hornet/write-sig.sh b/scripts/hornet/write-sig.sh
new file mode 100755
index 0000000000000..7eaabe3bab9aa
--- /dev/null
+++ b/scripts/hornet/write-sig.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Microsoft Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+
+function usage() {
+    echo "Sample for rewriting an autogenerated eBPF lskel headers"
+    echo "with a new signature"
+    echo ""
+    echo "USAGE: header_file sig"
+    exit
+}
+
+ARGC=$#
+
+EXPECTED_ARGS=2
+
+if [ $ARGC -ne $EXPECTED_ARGS ] ; then
+    usage
+else
+    SIG=$(xxd -p $2 | tr -d '\n' | sed 's/\(..\)/\\\\x\1/g')
+    sed '/const char opts_sig/,/;/c\\tstatic const char opts_sig[] __attribute__((__aligned__(8))) = "\\\n'"$(printf '%s\n' "$SIG")"'\";' $1
+fi
-- 
2.52.0


