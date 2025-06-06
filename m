Return-Path: <bpf+bounces-59975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA325AD0A50
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFD01737F2
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6366241136;
	Fri,  6 Jun 2025 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OobKMgsM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220AF23ED74;
	Fri,  6 Jun 2025 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252585; cv=none; b=d24ZBtpu426rWJ1DArVcOU/972pEEsMfuGdsGpxgGpnP3ab/l9tIqJ8q33yFEQ4SeK9M4C5EktrDpwjGfD2C+qjNDvNjletQzxIeM27/1NIxDkJ9dC20NrbvuZqmZDDi5TO90h+4AZNLm8UvKw9/w6Ky3cMvvc+bvdTC5VMFjzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252585; c=relaxed/simple;
	bh=HWCrzzK2+ZTEFSuVsgxo2Hw0vHzWImqUTo04vWQW0Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GV3tnPFM4l/G80XYDEfyIyKjmRiMlv9boytYr8A5EGbPAVXsODu97EDwSvsfxUV++rX4H1A3KQhf5VYde7oriPpM6QhoZ8fYgh3Y7K3+ySQcgExgNuhLckL/c1PEU1NgLovHhCHlbkk+pONEqq8RoKCAXfm/edCMULyCFyRDqns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OobKMgsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF06C4CEEE;
	Fri,  6 Jun 2025 23:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749252585;
	bh=HWCrzzK2+ZTEFSuVsgxo2Hw0vHzWImqUTo04vWQW0Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OobKMgsM59oi5fMANncmnAOdph/jXdcuLduUPhsljUm7ZTiiPOVNEfoCamDIG+/iX
	 /99LPi9vpKX4aaTmNEOGNlRrlqt9j3WR7Zk+XsB2TiQhlzzuNFmDFzta1hqbgTj5Tq
	 mMwCKd/lkx5l5SSEKxOVbzwqbsXBLqZ0E7PbrAJgtV4xzK9ouypIWc0X848YqbvmT2
	 BemTBz96cYFb+GLlhcNM2hyJYVgMy4jrqZAQqHnRM/6JEEcckqPOH7XV4/OlT/cJUM
	 pr4XA64z8act5XbXYM/VkKz0dkI2TmpXbDpK9DJF5NLfCErWPjpHTxIKAL9EKnOCof
	 yGjCKKM6R1A2A==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH 11/12] bpftool: Add support for signing BPF programs
Date: Sat,  7 Jun 2025 01:29:13 +0200
Message-ID: <20250606232914.317094-12-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606232914.317094-1-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two modes of operation being added:

Add two modes of operation:

* For prog load, allow signing a program immediately before loading. This
  is essential for command-line testing and administration.

      bpftool prog load -S -k <private_key> -i <identity_cert> fentry_test.bpf.o

* For gen skeleton, embed a pre-generated signature into the C skeleton
  file. This supports the use of signed programs in compiled applications.

      bpftool gen skeleton -S -k <private_key> -i <identity_cert> fentry_test.bpf.o

Generation of the loader program and its metadata map is implemented in
libbpf (bpf_obj__gen_loader). bpftool generates a skeleton that loads
the program and automates the required steps: freezing the map, creating
an exclusive map, loading, and running. Users can use standard libbpf
APIs directly or integrate loader program generation into their own
toolchains.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  12 +
 .../bpftool/Documentation/bpftool-prog.rst    |  12 +
 tools/bpf/bpftool/Makefile                    |   6 +-
 tools/bpf/bpftool/cgroup.c                    |   5 +-
 tools/bpf/bpftool/gen.c                       |  58 ++++-
 tools/bpf/bpftool/main.c                      |  21 +-
 tools/bpf/bpftool/main.h                      |  11 +
 tools/bpf/bpftool/prog.c                      |  25 +++
 tools/bpf/bpftool/sign.c                      | 211 ++++++++++++++++++
 9 files changed, 352 insertions(+), 9 deletions(-)
 create mode 100644 tools/bpf/bpftool/sign.c

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index ca860fd97d8d..2997313003b1 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -185,6 +185,18 @@ OPTIONS
     For skeletons, generate a "light" skeleton (also known as "loader"
     skeleton). A light skeleton contains a loader eBPF program. It does not use
     the majority of the libbpf infrastructure, and does not need libelf.
+-S, --sign
+    For skeletons, generate a signed skeleton. This option must be used with
+    **-k** and **-i**. Using this flag implicitly enables **--use-loader**.
+    See the "Signed Skeletons" section in the description of the
+    **gen skeleton** command for more details.
+
+-k <private_key.pem>
+    Path to the private key file in PEM format, required for signing.
+
+-i <certificate.x509>
+    Path to the X.509 certificate file in PEM or DER format, required for
+    signing.
 
 EXAMPLES
 ========
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index d6304e01afe0..dbfc7a496569 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -235,6 +235,18 @@ OPTIONS
     creating the maps, and loading the programs (see **bpftool prog tracelog**
     as a way to dump those messages).
 
+-S, --sign
+    Enable signing of the BPF program before loading. This option must be
+    used with **-k** and **-i**. Using this flag implicitly enables
+    **--use-loader**.
+
+-k <private_key.pem>
+    Path to the private key file in PEM format, required when signing.
+
+-i <certificate.x509>
+    Path to the X.509 certificate file in PEM or DER format, required when
+    signing.
+
 EXAMPLES
 ========
 **# bpftool prog show**
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 9e9a5f006cd2..586d1b2595d1 100644
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
@@ -194,7 +194,7 @@ endif
 
 BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
-BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o)
+BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o sign.o)
 $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
 
 OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 944ebe21a216..90c9aa297806 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (C) 2017 Facebook
 // Author: Roman Gushchin <guro@fb.com>
-
+#undef GCC_VERSION
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #define _XOPEN_SOURCE 500
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 67a60114368f..f4a211daa729 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -688,10 +688,17 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *header_guard)
 {
 	DECLARE_LIBBPF_OPTS(gen_loader_opts, opts);
+	struct bpf_load_and_run_opts sopts = {};
+	char sig_buf[MAX_SIG_SIZE];
+	__u8 prog_sha[SHA256_DIGEST_LENGTH];
 	struct bpf_map *map;
+
 	char ident[256];
 	int err = 0;
 
+	if (sign_progs)
+		opts.gen_hash = true;
+
 	err = bpf_object__gen_loader(obj, &opts);
 	if (err)
 		return err;
@@ -701,6 +708,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		p_err("failed to load object file");
 		goto out;
 	}
+
 	/* If there was no error during load then gen_loader_opts
 	 * are populated with the loader program.
 	 */
@@ -780,14 +788,56 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	print_hex(opts.insns, opts.insns_sz);
 	codegen("\
 		\n\
-		\";							    \n\
-									    \n\
+		\";\n");
+
+	if (sign_progs) {
+		sopts.insns = opts.insns;
+		sopts.insns_sz = opts.insns_sz;
+		sopts.excl_prog_hash = prog_sha;
+		sopts.excl_prog_hash_sz = sizeof(prog_sha);
+		sopts.signature = sig_buf;
+		sopts.signature_sz = MAX_SIG_SIZE;
+		sopts.keyring_id = KEY_SPEC_SESSION_KEYRING;
+
+		err = bpftool_prog_sign(&sopts);
+		if (err < 0)
+			return err;
+
+		codegen("\
+		\n\
+			static const char opts_sig[] __attribute__((__aligned__(8))) = \"\\\n\
+		");
+		print_hex((const void *)sig_buf, sopts.signature_sz);
+		codegen("\
+		\n\
+		\";\n");
+
+		codegen("\
+		\n\
+			static const char opts_excl_hash[] __attribute__((__aligned__(8))) = \"\\\n\
+		");
+		print_hex((const void *)prog_sha, sizeof(prog_sha));
+		codegen("\
+		\n\
+		\";\n");
+
+		codegen("\
+		\n\
+			opts.signature = (void *)opts_sig;			\n\
+			opts.signature_sz = sizeof(opts_sig) - 1;		\n\
+			opts.excl_prog_hash = (void *)opts_excl_hash;		\n\
+			opts.excl_prog_hash_sz = sizeof(opts_excl_hash) - 1;	\n\
+			opts.keyring_id = KEY_SPEC_SESSION_KEYRING;		\n\
+		");
+	}
+
+	codegen("\
+		\n\
 			opts.ctx = (struct bpf_loader_ctx *)skel;	    \n\
 			opts.data_sz = sizeof(opts_data) - 1;		    \n\
 			opts.data = (void *)opts_data;			    \n\
-			opts.insns_sz = sizeof(opts_insn) - 1;		    \n\
 			opts.insns = (void *)opts_insn;			    \n\
-									    \n\
+			opts.insns_sz = sizeof(opts_insn) - 1;		    \n\
 			err = bpf_load_and_run(&opts);			    \n\
 			if (err < 0)					    \n\
 				return err;				    \n\
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index cd5963cb6058..e69a8fa2c99b 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -33,6 +33,9 @@ bool relaxed_maps;
 bool use_loader;
 struct btf *base_btf;
 struct hashmap *refs_table;
+bool sign_progs;
+const char *private_key_path;
+const char *cert_path;
 
 static void __noreturn clean_and_exit(int i)
 {
@@ -447,6 +450,7 @@ int main(int argc, char **argv)
 		{ "nomount",	no_argument,	NULL,	'n' },
 		{ "debug",	no_argument,	NULL,	'd' },
 		{ "use-loader",	no_argument,	NULL,	'L' },
+		{ "sign",	required_argument, NULL, 'S'},
 		{ "base-btf",	required_argument, NULL, 'B' },
 		{ 0 }
 	};
@@ -473,7 +477,7 @@ int main(int argc, char **argv)
 	bin_name = "bpftool";
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "VhpjfLmndB:l",
+	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -519,6 +523,16 @@ int main(int argc, char **argv)
 		case 'L':
 			use_loader = true;
 			break;
+		case 'S':
+			sign_progs = true;
+			use_loader = true;
+			break;
+		case 'k':
+			private_key_path = optarg;
+			break;
+		case 'i':
+			cert_path = optarg;
+			break;
 		default:
 			p_err("unrecognized option '%s'", argv[optind - 1]);
 			if (json_output)
@@ -536,6 +550,11 @@ int main(int argc, char **argv)
 	if (version_requested)
 		return do_version(argc, argv);
 
+	if (sign_progs && (private_key_path == NULL || cert_path == NULL)) {
+		p_err("-i <identity_x509_cert> and -k <private> key must be supplied with -S for signing");
+		return -EINVAL;
+	}
+
 	ret = cmd_select(commands, argc, argv, do_help);
 
 	if (json_output)
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 9eb764fe4cc8..3832322ad7c3 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -6,9 +6,14 @@
 
 /* BFD and kernel.h both define GCC_VERSION, differently */
 #undef GCC_VERSION
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <stdbool.h>
 #include <stdio.h>
+#include <errno.h>
 #include <stdlib.h>
+#include <bpf/skel_internal.h>
 #include <linux/bpf.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
@@ -51,6 +56,7 @@ static inline void *u64_to_ptr(__u64 ptr)
 	})
 
 #define ERR_MAX_LEN	1024
+#define MAX_SIG_SIZE	4096
 
 #define BPF_TAG_FMT	"%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
 
@@ -84,6 +90,9 @@ extern bool relaxed_maps;
 extern bool use_loader;
 extern struct btf *base_btf;
 extern struct hashmap *refs_table;
+extern bool sign_progs;
+extern const char *private_key_path;
+extern const char *cert_path;
 
 void __printf(1, 2) p_err(const char *fmt, ...);
 void __printf(1, 2) p_info(const char *fmt, ...);
@@ -271,4 +280,6 @@ int pathname_concat(char *buf, int buf_sz, const char *path,
 /* print netfilter bpf_link info */
 void netfilter_dump_plain(const struct bpf_link_info *info);
 void netfilter_dump_json(const struct bpf_link_info *info, json_writer_t *wtr);
+int bpftool_prog_sign(struct bpf_load_and_run_opts *opts);
+__u32 register_session_key(const char *key_der_path);
 #endif
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f010295350be..e1dbbca91e34 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/perf_event.h>
 #include <linux/sizes.h>
+#include <linux/keyctl.h>
 
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
@@ -1875,6 +1876,8 @@ static int try_loader(struct gen_loader_opts *gen)
 {
 	struct bpf_load_and_run_opts opts = {};
 	struct bpf_loader_ctx *ctx;
+	char sig_buf[MAX_SIG_SIZE];
+	__u8 prog_sha[SHA256_DIGEST_LENGTH];
 	int ctx_sz = sizeof(*ctx) + 64 * max(sizeof(struct bpf_map_desc),
 					     sizeof(struct bpf_prog_desc));
 	int log_buf_sz = (1u << 24) - 1;
@@ -1898,6 +1901,24 @@ static int try_loader(struct gen_loader_opts *gen)
 	opts.insns = gen->insns;
 	opts.insns_sz = gen->insns_sz;
 	fds_before = count_open_fds();
+
+	if (sign_progs) {
+		opts.excl_prog_hash = prog_sha;
+		opts.excl_prog_hash_sz = sizeof(prog_sha);
+		opts.signature = sig_buf;
+		opts.signature_sz = MAX_SIG_SIZE;
+		opts.keyring_id = KEY_SPEC_SESSION_KEYRING;
+
+		err = bpftool_prog_sign(&opts);
+		if (err < 0)
+			return err;
+
+		err = register_session_key(cert_path);
+		if (err < 0) {
+			p_err("failed to add session key");
+			goto out;
+		}
+	}
 	err = bpf_load_and_run(&opts);
 	fd_delta = count_open_fds() - fds_before;
 	if (err < 0 || verifier_logs) {
@@ -1906,6 +1927,7 @@ static int try_loader(struct gen_loader_opts *gen)
 			fprintf(stderr, "loader prog leaked %d FDs\n",
 				fd_delta);
 	}
+out:
 	free(log_buf);
 	return err;
 }
@@ -1933,6 +1955,9 @@ static int do_loader(int argc, char **argv)
 		goto err_close_obj;
 	}
 
+	if (sign_progs)
+		gen.gen_hash = true;
+
 	err = bpf_object__gen_loader(obj, &gen);
 	if (err)
 		goto err_close_obj;
diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
new file mode 100644
index 000000000000..dde391da6b05
--- /dev/null
+++ b/tools/bpf/bpftool/sign.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Google LLC.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <string.h>
+#include <getopt.h>
+#include <err.h>
+#include <openssl/opensslv.h>
+#include <openssl/bio.h>
+#include <openssl/evp.h>
+#include <openssl/pem.h>
+#include <openssl/err.h>
+#include <openssl/cms.h>
+#include <linux/keyctl.h>
+#include <errno.h>
+
+#include <bpf/skel_internal.h>
+
+#include "main.h"
+
+
+#define OPEN_SSL_ERR_BUF_LEN 256
+
+static void display_openssl_errors(int l)
+{
+	char buf[OPEN_SSL_ERR_BUF_LEN];
+	const char *file;
+	const char *data;
+	unsigned long e;
+	int flags;
+	int line;
+
+	while ((e = ERR_get_error_all(&file, &line, NULL, &data, &flags))) {
+		ERR_error_string_n(e, buf, sizeof(buf));
+		if (data && (flags & ERR_TXT_STRING)) {
+			p_err("OpenSSL %s: %s:%d: %s\n", buf, file, line, data);
+		} else {
+			p_err("OpenSSL %s: %s:%d\n", buf, file, line);
+		}
+	}
+}
+
+#define DISPLAY_OSSL_ERR(cond)				 \
+	do {						 \
+		bool __cond = (cond);			 \
+		if (__cond && ERR_peek_error())		 \
+			display_openssl_errors(__LINE__);\
+	} while (0)
+
+static EVP_PKEY *read_private_key(const char *pkey_path)
+{
+	EVP_PKEY *private_key = NULL;
+	BIO *b;
+
+	b = BIO_new_file(pkey_path, "rb");
+	private_key = PEM_read_bio_PrivateKey(b, NULL, NULL, NULL);
+	BIO_free(b);
+	DISPLAY_OSSL_ERR(!private_key);
+	return private_key;
+}
+
+static X509 *read_x509(const char *x509_name)
+{
+	unsigned char buf[2];
+	X509 *x509 = NULL;
+	BIO *b;
+	int n;
+
+	b = BIO_new_file(x509_name, "rb");
+	if (!b)
+		goto cleanup;
+
+	/* Look at the first two bytes of the file to determine the encoding */
+	n = BIO_read(b, buf, 2);
+	if (n != 2)
+		goto cleanup;
+
+	if (BIO_reset(b) != 0)
+		goto cleanup;
+
+	if (buf[0] == 0x30 && buf[1] >= 0x81 && buf[1] <= 0x84)
+		/* Assume raw DER encoded X.509 */
+		x509 = d2i_X509_bio(b, NULL);
+	else
+		/* Assume PEM encoded X.509 */
+		x509 = PEM_read_bio_X509(b, NULL, NULL, NULL);
+
+cleanup:
+	BIO_free(b);
+	DISPLAY_OSSL_ERR(!x509);
+	return x509;
+}
+
+__u32 register_session_key(const char *key_der_path)
+{
+	unsigned char *der_buf = NULL;
+	X509 *x509 = NULL;
+	int key_id = -1;
+	int der_len;
+
+	if (!key_der_path)
+		return key_id;
+	x509 = read_x509(key_der_path);
+	if (!x509)
+		goto cleanup;
+	der_len = i2d_X509(x509, &der_buf);
+	if (der_len < 0)
+		goto cleanup;
+	key_id = syscall(__NR_add_key, "asymmetric", key_der_path, der_buf,
+			     (size_t)der_len, KEY_SPEC_SESSION_KEYRING);
+cleanup:
+	X509_free(x509);
+	OPENSSL_free(der_buf);
+	DISPLAY_OSSL_ERR(key_id == -1);
+	return key_id;
+}
+
+int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
+{
+	BIO *bd_in = NULL, *bd_out = NULL;
+	EVP_PKEY *private_key = NULL;
+	CMS_ContentInfo *cms = NULL;
+	long actual_sig_len = 0;
+	X509 *x509 = NULL;
+	int err = 0;
+
+	bd_in = BIO_new_mem_buf(opts->insns, opts->insns_sz);
+	if (!bd_in) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	private_key = read_private_key(private_key_path);
+	if (!private_key) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	x509 = read_x509(cert_path);
+	if (!x509) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	cms = CMS_sign(NULL, NULL, NULL, NULL,
+		       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY | CMS_DETACHED |
+			       CMS_STREAM);
+	if (!cms) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	if (!CMS_add1_signer(cms, x509, private_key, EVP_sha256(),
+			     CMS_NOCERTS | CMS_BINARY | CMS_NOSMIMECAP |
+			     CMS_USE_KEYID | CMS_NOATTR)) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	if (CMS_final(cms, bd_in, NULL, CMS_NOCERTS | CMS_BINARY) != 1) {
+		err = -EIO;
+		goto cleanup;
+	}
+
+	EVP_Digest(opts->insns, opts->insns_sz, opts->excl_prog_hash,
+		   &opts->excl_prog_hash_sz, EVP_sha256(), NULL);
+
+		bd_out = BIO_new(BIO_s_mem());
+	if (!bd_out) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	if (!i2d_CMS_bio_stream(bd_out, cms, NULL, 0)) {
+		err = -EIO;
+		goto cleanup;
+	}
+
+	actual_sig_len = BIO_get_mem_data(bd_out, NULL);
+	if (actual_sig_len <= 0) {
+		err = -EIO;
+		goto cleanup;
+	}
+
+	if ((size_t)actual_sig_len > opts->signature_sz) {
+		err = -ENOSPC;
+		goto cleanup;
+	}
+
+	if (BIO_read(bd_out, opts->signature, actual_sig_len) != actual_sig_len) {
+		err = -EIO;
+		goto cleanup;
+	}
+
+	opts->signature_sz = actual_sig_len;
+cleanup:
+	BIO_free(bd_out);
+	CMS_ContentInfo_free(cms);
+	X509_free(x509);
+	EVP_PKEY_free(private_key);
+	BIO_free(bd_in);
+	DISPLAY_OSSL_ERR(err < 0);
+	return err;
+}
-- 
2.43.0


