Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA442ACD6
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhJLTCk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 15:02:40 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:38466 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhJLTCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 15:02:40 -0400
Received: by mail-ed1-f41.google.com with SMTP id d9so218055edh.5;
        Tue, 12 Oct 2021 12:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOG38WE5RpkzYuIYbxHzPrOYr2Z0+SH7ndCvTAuS/js=;
        b=qH++m1CGmaq6tn/X/RrhfUCvlaMmNURaDeTQA3YPSXjCvVCRUwHFvOipHCMxIBdLcC
         iFzMznJaRvjM6vje8eKyNralYBmoHOxym1YwRKXZ02m0IYoyXidj0T5mgxcrcpG55BPP
         zd4+9qw05TmjfKdNq0rRmSSyCv1xbRrs++CE5bLoFMwyRblbOZHVzF/F+6OXu+Dasumq
         /ytM5TKXuo+5l1ZKGdXEYD07qlWUFJuhBVDCGNnUWhTLxaQseSknVjX9tZtu7B6H2JAd
         Gsi/EXEGfYsn6ByL/3wkZEq4Rsilqg9Ot/uZFoW9PgLhVsqmIrI4WIkqBYfG430/hpLc
         c9aw==
X-Gm-Message-State: AOAM530jg6HXYYRCJvWTHScTjKdQ06MofC8wPrgBcDNma/hFyKMxY8St
        xJyJhGziFoaI5vec8lsfdoG2rKy4xQ0=
X-Google-Smtp-Source: ABdhPJzm6SaRpWUQTEUie868RrTgHfXrHpsqCHyqKPb8xPS2l7mTZHLcz0a9x4lHhSsSLHJ62/Uqhg==
X-Received: by 2002:a17:906:f109:: with SMTP id gv9mr33752553ejb.184.1634065236980;
        Tue, 12 Oct 2021 12:00:36 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-34-36-22.cust.vodafonedsl.it. [2.34.36.22])
        by smtp.gmail.com with ESMTPSA id g7sm4802965edu.48.2021.10.12.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 12:00:36 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC bpf-next 2/2] bpftool: add signature in skeleton
Date:   Tue, 12 Oct 2021 21:00:28 +0200
Message-Id: <20211012190028.54828-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012190028.54828-1-mcroce@linux.microsoft.com>
References: <20211012190028.54828-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

When generating the skeleton, allow to add a signature.
The signature will be passed to the kernel in the newly added field.
As in sign-file, allow specifing "pkcs11:..." as key file, to use the
openssl engine.
Still as in sign-file, read the environment variable KBUILD_SIGN_PIN.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 tools/bpf/bpftool/Makefile     |  14 ++-
 tools/bpf/bpftool/gen.c        |  33 +++++
 tools/bpf/bpftool/main.c       |  28 +++++
 tools/bpf/bpftool/main.h       |   7 ++
 tools/bpf/bpftool/sign.c       | 217 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |   2 +
 tools/lib/bpf/skel_internal.h  |   4 +
 7 files changed, 302 insertions(+), 3 deletions(-)
 create mode 100644 tools/bpf/bpftool/sign.c

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 1fcf5b01a193..b67d6e0b9067 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -78,9 +78,9 @@ RM ?= rm -f
 
 FEATURE_USER = .bpftool
 FEATURE_TESTS = libbfd disassembler-four-args reallocarray zlib libcap \
-	clang-bpf-co-re
+	clang-bpf-co-re libcrypto
 FEATURE_DISPLAY = libbfd disassembler-four-args zlib libcap \
-	clang-bpf-co-re
+	clang-bpf-co-re libcrypto
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
@@ -113,6 +113,11 @@ CFLAGS += -DUSE_LIBCAP
 LIBS += -lcap
 endif
 
+ifeq ($(feature-libcrypto), 1)
+CFLAGS_SSL := -DUSE_SIGN
+LIBS += -lssl -lcrypto
+endif
+
 include $(wildcard $(OUTPUT)*.d)
 
 all: $(OUTPUT)bpftool
@@ -120,6 +125,9 @@ all: $(OUTPUT)bpftool
 BFD_SRCS = jit_disasm.c
 
 SRCS = $(filter-out $(BFD_SRCS),$(wildcard *.c))
+ifneq ($(feature-libcrypto), 1)
+SRCS := $(filter-out sign.c,$(SRCS))
+endif
 
 ifeq ($(feature-libbfd),1)
   LIBS += -lbfd -ldl -lopcodes
@@ -202,7 +210,7 @@ $(BOOTSTRAP_OUTPUT)%.o: %.c | $(BOOTSTRAP_OUTPUT)
 	$(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD -o $@ $<
 
 $(OUTPUT)%.o: %.c
-	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
+	$(QUIET_CC)$(CC) $(CFLAGS) $(CFLAGS_SSL) -c -MMD -o $@ $<
 
 feature-detect-clean:
 	$(call QUIET_CLEAN, feature-detect)
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index cc835859465b..2551fe90dc89 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -434,6 +434,10 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
 	struct bpf_map *map;
 	int err = 0;
+#ifdef USE_SIGN
+	char *signature = NULL;
+	int sig_len = 0;
+#endif
 
 	err = bpf_object__gen_loader(obj, &opts);
 	if (err)
@@ -453,6 +457,19 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
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
@@ -537,6 +554,18 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
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
@@ -1037,6 +1066,10 @@ static int do_help(int argc, char **argv)
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
index 02eaaf065f65..4e70b89c5b22 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -30,6 +30,10 @@ bool block_mount;
 bool verifier_logs;
 bool relaxed_maps;
 bool use_loader;
+bool sign_bpf;
+const char *sign_hash;
+const char *sign_cert;
+const char *sign_key;
 struct btf *base_btf;
 struct pinned_obj_table prog_table;
 struct pinned_obj_table map_table;
@@ -398,6 +402,12 @@ int main(int argc, char **argv)
 		{ "debug",	no_argument,	NULL,	'd' },
 		{ "use-loader",	no_argument,	NULL,	'L' },
 		{ "base-btf",	required_argument, NULL, 'B' },
+#ifdef USE_SIGN
+		{ "sign",	no_argument,	NULL,	's' },
+		{ "hash",	required_argument, NULL, 'H' },
+		{ "cert",	required_argument, NULL, 'c' },
+		{ "key",	required_argument, NULL, 'k' },
+#endif
 		{ 0 }
 	};
 	int opt, ret;
@@ -414,7 +424,11 @@ int main(int argc, char **argv)
 	hash_init(link_table.table);
 
 	opterr = 0;
+#ifdef USE_SIGN
+	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:sH:c:k:",
+#else
 	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:",
+#endif
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -460,6 +474,20 @@ int main(int argc, char **argv)
 		case 'L':
 			use_loader = true;
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
index 90caa42aac4c..78742720447f 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -90,6 +90,10 @@ extern bool block_mount;
 extern bool verifier_logs;
 extern bool relaxed_maps;
 extern bool use_loader;
+extern bool sign_bpf;
+extern const char *sign_hash;
+extern const char *sign_cert;
+extern const char *sign_key;
 extern struct btf *base_btf;
 extern struct pinned_obj_table prog_table;
 extern struct pinned_obj_table map_table;
@@ -259,4 +263,7 @@ int do_filter_dump(struct tcmsg *ifinfo, struct nlattr **tb, const char *kind,
 
 int print_all_levels(__maybe_unused enum libbpf_print_level level,
 		     const char *format, va_list args);
+
+int sign(const char *hash_algo, const char *key_path, const char *x509_path,
+	 const char *indata, int indatalen, unsigned char **outdata);
 #endif
diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
new file mode 100644
index 000000000000..50b257a7177c
--- /dev/null
+++ b/tools/bpf/bpftool/sign.c
@@ -0,0 +1,217 @@
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
+	   display_openssl_errors();
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
index c2b8857b8a1c..b9d259f26e92 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1336,6 +1336,8 @@ union bpf_attr {
 		};
 		__u32		:32;		/* pad */
 		__aligned_u64	fd_array;	/* array of FDs */
+		__aligned_u64	signature;	/* instruction's signature */
+		__u32		sig_len;	/* signature size */
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 9cf66702fa8d..1ef2df16f90c 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -42,8 +42,10 @@ struct bpf_load_and_run_opts {
 	struct bpf_loader_ctx *ctx;
 	const void *data;
 	const void *insns;
+	const void *signature;
 	__u32 data_sz;
 	__u32 insns_sz;
+	__u32 sig_sz;
 	const char *errstr;
 };
 
@@ -84,6 +86,8 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
 	attr.insns = (long) opts->insns;
 	attr.insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
+	attr.signature = (long) opts->signature;
+	attr.sig_len = opts->sig_sz;
 	attr.license = (long) "Dual BSD/GPL";
 	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
 	attr.fd_array = (long) &map_fd;
-- 
2.33.0

