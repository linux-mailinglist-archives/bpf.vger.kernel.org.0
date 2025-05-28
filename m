Return-Path: <bpf+bounces-59198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35EEAC7303
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 23:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACAF3ABD40
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AE52222AB;
	Wed, 28 May 2025 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GUmaaosP"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95215221268;
	Wed, 28 May 2025 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469060; cv=none; b=ULDRkRH+StnS4779C5IR6ChTemXEpPdRLqO+9psfVEEjAPBfiT93Grpo3FcoQrTs9SM1GBT35x7a8AZMRiQVmgD5KHr7FwbwHfILyivrAP+uTHsX3XRaC8W7h4tijg1i0UXn18lLEkdruxCpVITDMew25D8/VekdNHluMsr4YIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469060; c=relaxed/simple;
	bh=QKXLmeM2oyiRMNJR+WCzcUeqU86YQJ4nAcMTTGapJfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLF80soz8GLqq4cJYMporJZTiDFLMSmMywLFbkBG85AeC3NGaer47CupMXEaDcC5Yc63GHaEKz792YP/5og7JDu9S/7wtt+hTFW3xD7oMx5Waee9j0K8/h4S2bxMWdhffvN/wFkjj89ooa7+je5kyNpQh7OJLPO5Xthetc8nCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GUmaaosP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id E9C2A2078610;
	Wed, 28 May 2025 14:50:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9C2A2078610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748469058;
	bh=1BxLDLtBZo60Kp/D8p5d9bRrFm8Z8mtILTlhMSyJ2VU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GUmaaosPMYvCtCTsv2Kg4lPh/7MnOWk0/Vy1yUqhS30r0rmgOe9AknLajBOsoCgVe
	 Y/1WmnXyd+7kp+swuCBwylLgmIXULEBhfMG2EolwB2+CmkH793u0hX55GvUb7wVmcZ
	 JKhnvM6NXW4ac0o3MxzByA3Qi6tA7eYzlji5GPcQ=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>,
	bboscaccy@linux.microsoft.com,
	jarkko@kernel.org,
	zeffron@riotgames.com,
	xiyou.wangcong@gmail.com,
	kysrinivasan@gmail.com,
	code@tyhicks.com,
	linux-security-module@vger.kernel.org,
	roberto.sassu@huawei.com,
	James.Bottomley@hansenpartnership.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Quentin Monnet <qmo@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	Jordan Rome <linux@jordanrome.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Matteo Croce <teknoraver@meta.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH 3/3] bpftool: Allow signing of light-skeleton programs
Date: Wed, 28 May 2025 14:49:05 -0700
Message-ID: <20250528215037.2081066-4-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces hash-chain signature support into bpftool. The
signature generated code was adapted from sign-file and follows a
similar set of command line switches.  The algorithm used here
supports the signature of both the loader program and it's map
containing the target program.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 tools/bpf/bpftool/Makefile |   4 +-
 tools/bpf/bpftool/common.c | 204 +++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/gen.c    |  66 +++++++++++-
 tools/bpf/bpftool/main.c   |  24 ++++-
 tools/bpf/bpftool/main.h   |  23 +++++
 tools/lib/bpf/libbpf.h     |   4 +
 6 files changed, 321 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 9e9a5f006cd2..b17e295f4954 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
 endif
 endif
 
-LIBS = $(LIBBPF) -lelf -lz
-LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
+LIBS = $(LIBBPF) -lelf -lz -lcrypto
+LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz -lcrypto
 
 ifeq ($(feature-libelf-zstd),1)
 LIBS += -lzstd
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index ecfa790adc13..e6cfb855fc8a 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -5,6 +5,7 @@
 #define _GNU_SOURCE
 #endif
 #include <ctype.h>
+#include <err.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <ftw.h>
@@ -31,6 +32,24 @@
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
 #include <bpf/btf.h>
 
+#include <openssl/opensslv.h>
+#include <openssl/bio.h>
+#include <openssl/evp.h>
+#include <openssl/pem.h>
+#include <openssl/err.h>
+#include <openssl/cms.h>
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
+#include "../../scripts/ssl-common.h"
+
 #include "main.h"
 
 #ifndef BPF_FS_MAGIC
@@ -1181,3 +1200,188 @@ int pathname_concat(char *buf, int buf_sz, const char *path,
 
 	return 0;
 }
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
+	/* If it's wrong, don't keep trying it. */
+	key_pass = NULL;
+
+	return pwlen;
+}
+
+static EVP_PKEY *read_private_key_pkcs11(const char *private_key_name)
+{
+	EVP_PKEY *pk = NULL;
+#ifdef USE_PKCS11_PROVIDER
+	OSSL_STORE_CTX *store;
+
+	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+		ERR(1, "OSSL_PROVIDER_try_load(default)");
+
+	store = OSSL_STORE_open(private_key_name, NULL, NULL, NULL, NULL);
+	ERR(!store, "OSSL_STORE_open");
+
+	while (!OSSL_STORE_eof(store)) {
+		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
+
+		if (!info) {
+			drain_openssl_errors(__LINE__, 0);
+			continue;
+		}
+		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
+			pk = OSSL_STORE_INFO_get1_PKEY(info);
+			ERR(!pk, "OSSL_STORE_INFO_get1_PKEY");
+		}
+		OSSL_STORE_INFO_free(info);
+		if (pk)
+			break;
+	}
+	OSSL_STORE_close(store);
+#elif defined(USE_PKCS11_ENGINE)
+	ENGINE *e;
+
+	ENGINE_load_builtin_engines();
+	drain_openssl_errors(__LINE__, 1);
+	e = ENGINE_by_id("pkcs11");
+	ERR(!e, "Load PKCS#11 ENGINE");
+	if (ENGINE_init(e))
+		drain_openssl_errors(__LINE__, 1);
+	else
+		ERR(1, "ENGINE_init");
+	if (key_pass)
+		ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
+	pk = ENGINE_load_private_key(e, private_key_name, NULL, NULL);
+	ERR(!pk, "%s", private_key_name);
+#else
+	fprintf(stderr, "no pkcs11 engine/provider available\n");
+	exit(1);
+#endif
+	return pk;
+}
+
+EVP_PKEY *read_private_key(const char *private_key_name)
+{
+	if (!strncmp(private_key_name, "pkcs11:", 7)) {
+		return read_private_key_pkcs11(private_key_name);
+	} else {
+		EVP_PKEY *pk;
+		BIO *b;
+
+		b = BIO_new_file(private_key_name, "rb");
+		ERR(!b, "%s", private_key_name);
+		pk = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
+					     NULL);
+		ERR(!pk, "%s", private_key_name);
+		BIO_free(b);
+
+		return pk;
+	}
+}
+
+X509 *read_x509(const char *x509_name)
+{
+	unsigned char buf[2];
+	X509 *x509_cert;
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
+		x509_cert = d2i_X509_bio(b, NULL);
+	else
+		/* Assume PEM encoded X.509 */
+		x509_cert = PEM_read_bio_X509(b, NULL, NULL, NULL);
+
+	BIO_free(b);
+	ERR(!x509_cert, "%s", x509_name);
+
+	return x509_cert;
+}
+
+BIO* generate_signature(const void *buffer, size_t length)
+{
+	const EVP_MD *digest_algo;
+	unsigned int use_signed_attrs;
+#ifndef USE_PKCS7
+	CMS_ContentInfo *cms = NULL;
+	unsigned int use_keyid = 0;
+#else
+	PKCS7 *pkcs7 = NULL;
+#endif
+	BIO *mem = BIO_new_mem_buf(buffer, length);
+	BIO *bd = BIO_new(BIO_s_mem());
+
+#ifndef USE_PKCS7
+	use_signed_attrs = CMS_NOATTR;
+#else
+	use_signed_attrs = PKCS7_NOATTR;
+#endif
+	/* Digest the module data. */
+	OpenSSL_add_all_digests();
+	drain_openssl_errors(__LINE__, 0);
+	digest_algo = EVP_get_digestbyname(hash_algo);
+	ERR(!digest_algo, "EVP_get_digestbyname");
+
+#ifndef USE_PKCS7
+	/* Load the signature message from the digest buffer. */
+	cms = CMS_sign(NULL, NULL, NULL, NULL,
+		       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY |
+		       CMS_DETACHED | CMS_STREAM);
+	ERR(!cms, "CMS_sign");
+
+	ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
+			     CMS_NOCERTS | CMS_BINARY |
+			     CMS_NOSMIMECAP | use_keyid |
+			     use_signed_attrs),
+	    "CMS_add1_signer");
+	ERR(CMS_final(cms, mem, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
+	    "CMS_final");
+
+#else
+	pkcs7 = PKCS7_sign(x509, private_key, NULL, mem,
+			   PKCS7_NOCERTS | PKCS7_BINARY |
+			   PKCS7_DETACHED | use_signed_attrs);
+	ERR(!pkcs7, "PKCS7_sign");
+#endif
+
+#ifndef USE_PKCS7
+	ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) != 1, "%s", "bpftool");
+#else
+	ERR(i2d_PKCS7_bio(bd, pkcs7) != 1, "%s", "bpftool");
+#endif
+	return bd;
+}
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 67a60114368f..318b1f36d869 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -20,6 +20,7 @@
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <bpf/btf.h>
+#include <openssl/sha.h>
 
 #include "json_writer.h"
 #include "main.h"
@@ -493,6 +494,30 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 	return map_sz;
 }
 
+static int sign_loader_and_map(struct gen_loader_opts *opts)
+{
+	BIO *bo;
+	BUF_MEM *bptr;
+	unsigned char hash[SHA256_DIGEST_LENGTH  * 2];
+	unsigned char term[SHA256_DIGEST_LENGTH];
+
+	if (!x509)
+		return 0;
+
+	SHA256((const unsigned char *)opts->insns, opts->insns_sz, hash);
+	SHA256((const unsigned char *)opts->data, opts->data_sz, hash + SHA256_DIGEST_LENGTH);
+	SHA256(hash, sizeof(hash), term);
+
+	bo = generate_signature(term, sizeof(term));
+	if (IS_ERR(bo))
+		return -EINVAL;
+	BIO_get_mem_ptr(bo, &bptr);
+	opts->signature = bptr->data;
+	opts->signature_sz = bptr->length;
+
+	return 0;
+}
+
 /* Emit type size asserts for all top-level fields in memory-mapped internal maps. */
 static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 {
@@ -701,6 +726,11 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		p_err("failed to load object file");
 		goto out;
 	}
+	err = sign_loader_and_map(&opts);
+	if (err) {
+		p_err("failed to sign loader");
+		goto out;
+	}
 	/* If there was no error during load then gen_loader_opts
 	 * are populated with the loader program.
 	 */
@@ -778,20 +808,54 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 			static const char opts_insn[] __attribute__((__aligned__(8))) = \"\\\n\
 		");
 	print_hex(opts.insns, opts.insns_sz);
-	codegen("\
+	if (opts.signature) {
+		codegen("\
 		\n\
 		\";							    \n\
+			static const char opts_signature[] __attribute__((__aligned__(8))) = \"\\\n\
+		");
+		print_hex(opts.signature, opts.signature_sz);
+		codegen("\
+		\n\
+		\";							    \n\
+			static const int opts_signature_maps[1] __attribute__((__aligned__(8))) = {0}; \n\
+		");
+		codegen("\
+		\n\
 									    \n\
 			opts.ctx = (struct bpf_loader_ctx *)skel;	    \n\
 			opts.data_sz = sizeof(opts_data) - 1;		    \n\
 			opts.data = (void *)opts_data;			    \n\
 			opts.insns_sz = sizeof(opts_insn) - 1;		    \n\
 			opts.insns = (void *)opts_insn;			    \n\
+			opts.signature_sz = sizeof(opts_signature) - 1;	    \n\
+			opts.signature = (void *)opts_signature;	    \n\
+			opts.signature_maps_sz = 1;	                    \n\
+			opts.signature_maps = (void *)opts_signature_maps;  \n\
 									    \n\
 			err = bpf_load_and_run(&opts);			    \n\
 			if (err < 0)					    \n\
 				return err;				    \n\
 		");
+
+	} else {
+		codegen("\
+		\n\
+		\";							    \n\
+									    \n\
+			opts.ctx = (struct bpf_loader_ctx *)skel;	    \n\
+			opts.data_sz = sizeof(opts_data) - 1;		    \n\
+			opts.data = (void *)opts_data;			    \n\
+			opts.insns_sz = sizeof(opts_insn) - 1;		    \n\
+			opts.insns = (void *)opts_insn;			    \n\
+			opts.signature_sz  = 0;		                    \n\
+			opts.signature = NULL;			            \n\
+									    \n\
+			err = bpf_load_and_run(&opts);			    \n\
+			if (err < 0)					    \n\
+				return err;				    \n\
+		");
+	}
 	bpf_object__for_each_map(map, obj) {
 		const char *mmap_flags;
 
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index cd5963cb6058..01020e5f37c2 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -33,6 +33,9 @@ bool relaxed_maps;
 bool use_loader;
 struct btf *base_btf;
 struct hashmap *refs_table;
+const char *hash_algo;
+EVP_PKEY *private_key;
+X509 *x509;
 
 static void __noreturn clean_and_exit(int i)
 {
@@ -473,7 +476,7 @@ int main(int argc, char **argv)
 	bin_name = "bpftool";
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:l",
+	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:lH:lP:lX:l",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -519,6 +522,25 @@ int main(int argc, char **argv)
 		case 'L':
 			use_loader = true;
 			break;
+		case 'H':
+			hash_algo = optarg;
+			break;
+		case 'P':
+			private_key = read_private_key(optarg);
+			if (!private_key) {
+				p_err("failed to parse private key '%s': %d\n",
+				      optarg, -errno);
+				return -1;
+			}
+			break;
+		case 'X':
+			x509 = read_x509(optarg);
+			if (!x509) {
+				p_err("failed to parse x509 '%s': %d\n",
+				      optarg, -errno);
+				return -1;
+			}
+			break;
 		default:
 			p_err("unrecognized option '%s'", argv[optind - 1]);
 			if (json_output)
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 9eb764fe4cc8..2f4aee1a8da7 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -16,6 +16,22 @@
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h>
 
+#include <openssl/opensslv.h>
+#include <openssl/bio.h>
+#include <openssl/evp.h>
+#include <openssl/pem.h>
+#include <openssl/err.h>
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
+
 #include "json_writer.h"
 
 /* Make sure we do not use kernel-only integer typedefs */
@@ -84,6 +100,9 @@ extern bool relaxed_maps;
 extern bool use_loader;
 extern struct btf *base_btf;
 extern struct hashmap *refs_table;
+extern const char *hash_algo;
+extern EVP_PKEY *private_key;
+extern X509 *x509;
 
 void __printf(1, 2) p_err(const char *fmt, ...);
 void __printf(1, 2) p_info(const char *fmt, ...);
@@ -271,4 +290,8 @@ int pathname_concat(char *buf, int buf_sz, const char *path,
 /* print netfilter bpf_link info */
 void netfilter_dump_plain(const struct bpf_link_info *info);
 void netfilter_dump_json(const struct bpf_link_info *info, json_writer_t *wtr);
+
+X509 *read_x509(const char *x509_name);
+EVP_PKEY *read_private_key(const char *private_key_name);
+BIO *generate_signature(const void *buffer, size_t length);
 #endif
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e0605403f977..c6c67e8931a6 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1782,8 +1782,12 @@ struct gen_loader_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 	const char *data;
 	const char *insns;
+	const char *signature;
+	const int *signature_maps;
 	__u32 data_sz;
 	__u32 insns_sz;
+	__u32 signature_sz;
+	__u32 signature_maps_sz;
 };
 
 #define gen_loader_opts__last_field insns_sz
-- 
2.48.1


