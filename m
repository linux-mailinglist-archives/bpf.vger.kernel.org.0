Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDE3467E10
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382814AbhLCTWp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:22:45 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:43743 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382791AbhLCTWm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:22:42 -0500
Received: by mail-wm1-f47.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2944478wmc.2;
        Fri, 03 Dec 2021 11:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KR1wOyB3kNoW7FP/I+yuMQcxT0W2OZp0Q9fo3BHND/Q=;
        b=g9xj7xevVrp22AhKX1XFYBoc03rIHAnRSshTEmyA17n94mdCosFze3p4apVcDT3aaW
         zgnPfb2eNqh7bI01km8wT4oMtnY8je3PPhfEytQt08GVgHSFntglLpqGw29Nb5fzuUUk
         IHrRtNlqfN73cQKgkPCLZ6wmQmhqy0Jiq5bJggzZ+jcnCJuAJeNP19ytWmQhjcwdAcM3
         VSNhkB4aI1PqFeuF7eUsNslZSjUKf4iMCoHMQs/FIwBc3cPd+9mIU6pAfbsMXaQz3n1k
         oIq20YXLmJDgzqM38yXCBAzOibW7QIH/EfGLhbRcz0TguXJjGLXRsCEBQ/9mRn72LZpq
         5S2A==
X-Gm-Message-State: AOAM532Q6faaZqCaG6nZTt2YREoQ4fhOtlm6NaxEa7QffYB7tfeQ4cL8
        m94OEHDo7btyB61FAkK5vbEi89sc6iRIzQ==
X-Google-Smtp-Source: ABdhPJzYmD/MXu+n5HV3Fz5vrL+iNwZVXJSi+Qm/rOEsYMm+H+82Qk0imxL3y0tuD2nuEV7D5C4A3g==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr17331907wmq.148.1638559156285;
        Fri, 03 Dec 2021 11:19:16 -0800 (PST)
Received: from t490s.teknoraver.net (net-37-117-189-149.cust.vodafonedsl.it. [37.117.189.149])
        by smtp.gmail.com with ESMTPSA id z14sm3472374wrp.70.2021.12.03.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:19:15 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next 3/3] bpftool: add signature in skeleton
Date:   Fri,  3 Dec 2021 20:18:44 +0100
Message-Id: <20211203191844.69709-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203191844.69709-1-mcroce@linux.microsoft.com>
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

When generating the skeleton, allow to add a signature.
The signature will be passed to the kernel in the newly added field.
As in sign-file, allow specifying "pkcs11:..." as key file, to use the
openssl engine.
Still as in sign-file, read the environment variable KBUILD_SIGN_PIN.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 tools/bpf/bpftool/Makefile     |  14 ++-
 tools/bpf/bpftool/gen.c        |  33 +++++
 tools/bpf/bpftool/main.c       |  28 +++++
 tools/bpf/bpftool/main.h       |   7 ++
 tools/bpf/bpftool/sign.c       | 218 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |   2 +
 tools/lib/bpf/skel_internal.h  |   4 +
 7 files changed, 303 insertions(+), 3 deletions(-)
 create mode 100644 tools/bpf/bpftool/sign.c

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 42eb8eee3d89..d2645c2f4bc9 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -96,9 +96,9 @@ RM ?= rm -f
 
 FEATURE_USER = .bpftool
 FEATURE_TESTS = libbfd disassembler-four-args reallocarray zlib libcap \
-	clang-bpf-co-re
+	clang-bpf-co-re libcrypto
 FEATURE_DISPLAY = libbfd disassembler-four-args zlib libcap \
-	clang-bpf-co-re
+	clang-bpf-co-re libcrypto
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
@@ -131,6 +131,11 @@ CFLAGS += -DUSE_LIBCAP
 LIBS += -lcap
 endif
 
+ifeq ($(feature-libcrypto), 1)
+CFLAGS_CRYPTO := -DUSE_SIGN
+LIBS += -lcrypto
+endif
+
 include $(wildcard $(OUTPUT)*.d)
 
 all: $(OUTPUT)bpftool
@@ -138,6 +143,9 @@ all: $(OUTPUT)bpftool
 BFD_SRCS = jit_disasm.c
 
 SRCS = $(filter-out $(BFD_SRCS),$(wildcard *.c))
+ifneq ($(feature-libcrypto), 1)
+SRCS := $(filter-out sign.c,$(SRCS))
+endif
 
 ifeq ($(feature-libbfd),1)
   LIBS += -lbfd -ldl -lopcodes
@@ -224,7 +232,7 @@ $(BOOTSTRAP_OUTPUT)%.o: %.c $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS) | $(BOOTSTRAP_OUTP
 		-c -MMD $< -o $@
 
 $(OUTPUT)%.o: %.c
-	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
+	$(QUIET_CC)$(CC) $(CFLAGS) $(CFLAGS_CRYPTO) -c -MMD $< -o $@
 
 feature-detect-clean:
 	$(call QUIET_CLEAN, feature-detect)
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 997a2865e04a..c9f09b222986 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -491,6 +491,10 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	struct bpf_map *map;
 	char ident[256];
 	int err = 0;
+#ifdef USE_SIGN
+	char *signature = NULL;
+	int sig_len = 0;
+#endif
 
 	err = bpf_object__gen_loader(obj, &opts);
 	if (err)
@@ -510,6 +514,19 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	 * are populated with the loader program.
 	 */
 
+#ifdef USE_SIGN
+	if (sign_bpf) {
+		sig_len = sign(sign_hash, sign_key, sign_cert,
+			       opts.insns, opts.insns_sz,
+			       (unsigned char **)&signature);
+		if (sig_len <= 0) {
+			p_err("failed to sign instructions");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+#endif
+
 	/* finish generating 'struct skel' */
 	codegen("\
 		\n\
@@ -592,6 +609,18 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		",
 		opts.insns_sz);
 	print_hex(opts.insns, opts.insns_sz);
+#ifdef USE_SIGN
+	if (sign_bpf) {
+		codegen("\
+			\n\
+			\";						    \n\
+				opts.sig_sz = %d;			    \n\
+				opts.signature = (void *)\"\\		    \n\
+			",
+			sig_len);
+		print_hex(signature, sig_len);
+	}
+#endif
 	codegen("\
 		\n\
 		\";							    \n\
@@ -1090,6 +1119,10 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
+#ifdef USE_SIGN
+		"                    {-s|--sign} | {-H|--hash} |\n"
+		"                    {-c|--cert} | {-k|--key} |\n"
+#endif
 		"                    {-L|--use-loader} }\n"
 		"",
 		bin_name, "gen");
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 8b71500e7cb2..cea3d07e98e0 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -31,6 +31,10 @@ bool block_mount;
 bool verifier_logs;
 bool relaxed_maps;
 bool use_loader;
+bool sign_bpf;
+const char *sign_hash;
+const char *sign_cert;
+const char *sign_key;
 bool legacy_libbpf;
 struct btf *base_btf;
 struct hashmap *refs_table;
@@ -403,6 +407,12 @@ int main(int argc, char **argv)
 		{ "use-loader",	no_argument,	NULL,	'L' },
 		{ "base-btf",	required_argument, NULL, 'B' },
 		{ "legacy",	no_argument,	NULL,	'l' },
+#ifdef USE_SIGN
+		{ "sign",	no_argument,	NULL,	's' },
+		{ "hash",	required_argument, NULL, 'H' },
+		{ "cert",	required_argument, NULL, 'c' },
+		{ "key",	required_argument, NULL, 'k' },
+#endif
 		{ 0 }
 	};
 	bool version_requested = false;
@@ -416,7 +426,11 @@ int main(int argc, char **argv)
 	bin_name = argv[0];
 
 	opterr = 0;
+#ifdef USE_SIGN
+	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:lsH:c:k:",
+#else
 	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:l",
+#endif
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -466,6 +480,20 @@ int main(int argc, char **argv)
 		case 'l':
 			legacy_libbpf = true;
 			break;
+#ifdef USE_SIGN
+		case 's':
+			sign_bpf = true;
+			break;
+		case 'H':
+			sign_hash = optarg;
+			break;
+		case 'c':
+			sign_cert = optarg;
+			break;
+		case 'k':
+			sign_key = optarg;
+			break;
+#endif
 		default:
 			p_err("unrecognized option '%s'", argv[optind - 1]);
 			if (json_output)
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 8d76d937a62b..ef82219d3f52 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -91,6 +91,10 @@ extern bool verifier_logs;
 extern bool relaxed_maps;
 extern bool use_loader;
 extern bool legacy_libbpf;
+extern bool sign_bpf;
+extern const char *sign_hash;
+extern const char *sign_cert;
+extern const char *sign_key;
 extern struct btf *base_btf;
 extern struct hashmap *refs_table;
 
@@ -260,4 +264,7 @@ static inline bool hashmap__empty(struct hashmap *map)
 	return map ? hashmap__size(map) == 0 : true;
 }
 
+int sign(const char *hash_algo, const char *key_path, const char *x509_path,
+	 const char *indata, int indatalen, unsigned char **outdata);
+
 #endif
diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
new file mode 100644
index 000000000000..ca09dc5f93aa
--- /dev/null
+++ b/tools/bpf/bpftool/sign.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Sign a module file using the given key and certificate.
+ *
+ * Inspired by Linux scripts/sign-file.c
+ * Copyright (C) 2021 Matteo Croce <mcroce@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1
+ * of the licence, or (at your option) any later version.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <err.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include <openssl/opensslv.h>
+#include <openssl/bio.h>
+#include <openssl/evp.h>
+#include <openssl/pem.h>
+#include <openssl/err.h>
+#include <openssl/engine.h>
+#include <openssl/cms.h>
+
+#include "main.h"
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
+static void display_openssl_errors(void)
+{
+	const char *file;
+	char buf[120];
+	int e, line;
+
+	if (!ERR_peek_error())
+		return;
+
+	while ((e = ERR_get_error_line(&file, &line))) {
+		ERR_error_string(e, buf);
+		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+	}
+}
+
+static EVP_PKEY *read_private_key(const char *key_path)
+{
+	EVP_PKEY *private_key;
+
+	if (!strncmp(key_path, "pkcs11:", 7)) {
+		ENGINE *e;
+
+		ENGINE_load_builtin_engines();
+		display_openssl_errors();
+		e = ENGINE_by_id("pkcs11");
+		if (!e)
+			return NULL;
+
+		if (!ENGINE_init(e)) {
+			display_openssl_errors();
+			return NULL;
+		}
+		display_openssl_errors();
+
+		if (key_pass)
+			if (!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0))
+				return NULL;
+		private_key = ENGINE_load_private_key(e, key_path, NULL, NULL);
+	} else {
+		BIO *b;
+
+		b = BIO_new_file(key_path, "rb");
+		if (!b)
+			return NULL;
+		private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb, NULL);
+		BIO_free(b);
+	}
+
+	return private_key;
+}
+
+static X509 *read_x509(const char *x509_path)
+{
+	unsigned char buf[2];
+	X509 *x509 = NULL;
+	BIO *b;
+	int n;
+
+	b = BIO_new_file(x509_path, "rb");
+	if (!b) {
+		display_openssl_errors();
+		return NULL;
+	}
+
+	/* Look at the first two bytes of the file to determine the encoding */
+	n = BIO_read(b, buf, 2);
+	if (n != 2) {
+		if (BIO_should_retry(b))
+			fprintf(stderr, "%s: Read wanted retry\n", x509_path);
+		if (n >= 0)
+			fprintf(stderr, "%s: Short read\n", x509_path);
+		display_openssl_errors();
+		goto out_free;
+	}
+
+	if (BIO_reset(b)) {
+		display_openssl_errors();
+		goto out_free;
+	}
+
+	if (buf[0] == 0x30 && buf[1] >= 0x81 && buf[1] <= 0x84)
+		/* Assume raw DER encoded X.509 */
+		x509 = d2i_X509_bio(b, NULL);
+	else
+		/* Assume PEM encoded X.509 */
+		x509 = PEM_read_bio_X509(b, NULL, NULL, NULL);
+
+	if (!x509)
+		display_openssl_errors();
+
+out_free:
+	BIO_free(b);
+
+	return x509;
+}
+
+int sign(const char *hash_algo, const char *key_path, const char *x509_path,
+	 const char *indata, int indatalen, unsigned char **outdata)
+{
+	CMS_ContentInfo *cms = NULL;
+	const EVP_MD *digest_algo;
+	EVP_PKEY *private_key;
+	X509 *x509;
+	BIO *bm;
+
+	OpenSSL_add_all_algorithms();
+	ERR_load_crypto_strings();
+	ERR_clear_error();
+
+	key_pass = getenv("KBUILD_SIGN_PIN");
+
+	/* Open the module file */
+	bm = BIO_new_mem_buf(indata, indatalen);
+	if (!bm) {
+		display_openssl_errors();
+		return -1;
+	}
+
+	/* Read the private key and the X.509 cert the PKCS#7 message
+	 * will point to.
+	 */
+	private_key = read_private_key(key_path);
+	if (!private_key)
+		goto out_free;
+
+	x509 = read_x509(x509_path);
+	if (!x509)
+		goto out_free;
+
+	/* Digest the module data. */
+	OpenSSL_add_all_digests();
+	display_openssl_errors();
+
+	digest_algo = EVP_get_digestbyname(hash_algo);
+	if (!digest_algo) {
+		display_openssl_errors();
+		goto out_free;
+	}
+
+	/* Load the signature message from the digest buffer. */
+	cms = CMS_sign(NULL, NULL, NULL, NULL, CMS_NOCERTS | CMS_PARTIAL |
+		       CMS_BINARY | CMS_DETACHED | CMS_STREAM);
+	if (!cms) {
+		display_openssl_errors();
+		goto out_free;
+	}
+
+	if (!CMS_add1_signer(cms, x509, private_key, digest_algo,
+			     CMS_NOCERTS | CMS_BINARY | CMS_NOSMIMECAP |
+			     CMS_NOATTR)) {
+		display_openssl_errors();
+		goto out_free;
+	}
+
+	if (CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0)
+		display_openssl_errors();
+
+out_free:
+	BIO_free(bm);
+
+	if (!cms)
+		return -1;
+
+	return i2d_CMS_ContentInfo(cms, outdata);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c26871263f1f..bbb4435c7586 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1346,6 +1346,8 @@ union bpf_attr {
 		__aligned_u64	fd_array;	/* array of FDs */
 		__aligned_u64	core_relos;
 		__u32		core_relo_rec_size; /* sizeof(struct bpf_core_relo) */
+		__aligned_u64	signature;	/* instruction's signature */
+		__u32		sig_len;	/* signature size */
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 0b84d8e6b72a..7c987b79568b 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -52,8 +52,10 @@ struct bpf_load_and_run_opts {
 	struct bpf_loader_ctx *ctx;
 	const void *data;
 	const void *insns;
+	const void *signature;
 	__u32 data_sz;
 	__u32 insns_sz;
+	__u32 sig_sz;
 	const char *errstr;
 };
 
@@ -93,6 +95,8 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
 	attr.insns = (long) opts->insns;
 	attr.insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
+	attr.signature = (long) opts->signature;
+	attr.sig_len = opts->sig_sz;
 	attr.license = (long) "Dual BSD/GPL";
 	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
 	attr.fd_array = (long) &map_fd;
-- 
2.33.1

