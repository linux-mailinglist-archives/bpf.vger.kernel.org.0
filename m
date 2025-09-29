Return-Path: <bpf+bounces-69993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C81BBAAA74
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 23:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475011C03B1
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A0259CB9;
	Mon, 29 Sep 2025 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hi8kKuxH"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30FF25784E;
	Mon, 29 Sep 2025 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759181734; cv=none; b=s9QubE87SopVvyuz0dcKoHFcGVGx00Oso88lR6+eQWBqFafj9LhvuCPWUz1cPkheYXHerGr6qxb1X3j/tme4vgHbzE2bS7jiM5oemUEC5O+qwhhecnE7NkY6XBq45mJIHwbdkM2E1HnCKQ6Co4gYgOCxRr0QYc5bk6ln8oyFrrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759181734; c=relaxed/simple;
	bh=1ogjZPfGvdRGMXeq4ltonFGtRcvbiN3n7hZPSjnGr38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bj1qK778ABGsnyTYeFVkpqKZ+1mI3e7GqTHa4IWV20iaiBc91Ir94BsROW/ZVY7IXHezqzDKDn/UgEuMJUXOGboSoIoOYjLYHv0DnmDtg4ucfZVvknIeWR+5AborYQN3f6tGnfegJU6s9tt9vWurWy41UMpZrqUl8DAadgFZ3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hi8kKuxH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id C488C201CEF2;
	Mon, 29 Sep 2025 14:35:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C488C201CEF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759181731;
	bh=NJ0pS0k7flc9QSKhJlzGKAkc9AjbiTcT+RfbRRrlyiM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hi8kKuxHw6945GgKiu5a03+5o0xJrsHOQub47HARg7hisvRN2xtauNSqrw50vm+2H
	 5bfRMMVCCHRGV/gArTxMFyXV6gOrAPDZvDNF0licCzmFjf3tqmEvDwrF5Gl22FBdsw
	 2vhCaB9iWRX+PuBozY/wThtGEKTOZ/OEEdAeA3NQ=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kpsingh@kernel.org,
	bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	James.Bottomley@hansenpartnership.com,
	wufan@linux.microsoft.com,
	qmo@kernel.org
Subject: [PATCH bpf-next v2 3/3] bpftool: Add support for signing program and map hash chains
Date: Mon, 29 Sep 2025 14:34:27 -0700
Message-ID: <20250929213520.1821223-4-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new mode of operation for program loading which supports the
generation of signed hash chains for light skeletons, using the new
signed map hash chain UAPI additions.

e.g bpftool prog load -S -M -k <private_key> -i <identity_cert> fentry_test.bpf.o

The -M or --sign-maps command line switch is introduced. It generates
a hash chain such that:

H(program, maps) = sha256(sha256(program), sha256(map[0]))

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  7 ++++-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/gen.c                       | 27 ++++++++++++++++++-
 tools/bpf/bpftool/main.c                      |  9 ++++++-
 tools/bpf/bpftool/main.h                      |  1 +
 tools/bpf/bpftool/sign.c                      | 16 ++++++++---
 tools/lib/bpf/libbpf.h                        |  3 ++-
 tools/lib/bpf/skel_internal.h                 |  6 ++++-
 8 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index d0a36f442db72..b632ab87adf20 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 
 **bpftool** [*OPTIONS*] **gen** *COMMAND*
 
-*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ { **-S** | **--sign** } {**-k** <private_key.pem>} **-i** <certificate.x509> ] }
+*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ { **-S** | **--sign** } { **-M** | **--sign-maps** } {**-k** <private_key.pem>} **-i** <certificate.x509> ] }
 
 *COMMAND* := { **object** | **skeleton** | **help** }
 
@@ -190,6 +190,11 @@ OPTIONS
     For skeletons, generate a signed skeleton. This option must be used with
     **-k** and **-i**. Using this flag implicitly enables **--use-loader**.
 
+-M --sign-maps
+    For skeletons, generate a signed skeleton that includes a hash chain for the
+    skeletons maps. This option must be used with **-k** and **-i**. Using this
+    flag implicitly enables **--use-loader** and **--sign**.
+
 -k <private_key.pem>
     Path to the private key file in PEM format, required for signing.
 
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 53bcfeb1a76e6..f8c217f09989c 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -262,7 +262,7 @@ _bpftool()
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
         local c='--version --json --pretty --bpffs --mapcompat --debug \
-            --use-loader --base-btf --sign -i -k'
+            --use-loader --base-btf --sign --sign-maps -i -k'
         COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
         return 0
     fi
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 993c7d9484a46..1c4278e2a662b 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -699,6 +699,9 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	if (sign_progs)
 		opts.gen_hash = true;
 
+	if (sign_maps)
+		opts.sign_maps = true;
+
 	err = bpf_object__gen_loader(obj, &opts);
 	if (err)
 		return err;
@@ -793,6 +796,8 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	if (sign_progs) {
 		sopts.insns = opts.insns;
 		sopts.insns_sz = opts.insns_sz;
+		sopts.data = opts.data;
+		sopts.data_sz = opts.data_sz;
 		sopts.excl_prog_hash = prog_sha;
 		sopts.excl_prog_hash_sz = sizeof(prog_sha);
 		sopts.signature = sig_buf;
@@ -822,6 +827,13 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		\n\
 		\";\n");
 
+		if (sign_maps) {
+			codegen("\
+			\n\
+				static const int opts_signature_maps[1] __attribute__((__aligned__(8))) = {0}; \n\
+			");
+		}
+
 		codegen("\
 		\n\
 			opts.signature = (void *)opts_sig;			\n\
@@ -830,6 +842,19 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 			opts.excl_prog_hash_sz = sizeof(opts_excl_hash) - 1;	\n\
 			opts.keyring_id = skel->keyring_id;			\n\
 		");
+		if (sign_maps) {
+			codegen("\
+			\n\
+				opts.signature_maps = (void *)opts_signature_maps;	\n\
+				opts.signature_maps_sz = 1; 				\n\
+			");
+		} else {
+			codegen("\
+			\n\
+				opts.signature_maps = (void *)NULL;		\n\
+				opts.signature_maps_sz = 0;			\n\
+			");
+		}
 	}
 
 	codegen("\
@@ -1990,7 +2015,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
-		"                    {-L|--use-loader} | [ {-S|--sign } {-k} <private_key.pem> {-i} <certificate.x509> ]}\n"
+		"                    {-L|--use-loader} | [ {-S|--sign } {-M|--sign-maps } {-k} <private_key.pem> {-i} <certificate.x509> ]}\n"
 		"",
 		bin_name, "gen");
 
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index a829a6a49037a..47b14dcbae4ee 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -34,6 +34,7 @@ bool use_loader;
 struct btf *base_btf;
 struct hashmap *refs_table;
 bool sign_progs;
+bool sign_maps;
 const char *private_key_path;
 const char *cert_path;
 
@@ -452,6 +453,7 @@ int main(int argc, char **argv)
 		{ "debug",	no_argument,	NULL,	'd' },
 		{ "use-loader",	no_argument,	NULL,	'L' },
 		{ "sign",	no_argument,	NULL,	'S' },
+		{ "sign-maps",	no_argument,	NULL,	'M' },
 		{ "base-btf",	required_argument, NULL, 'B' },
 		{ 0 }
 	};
@@ -478,7 +480,7 @@ int main(int argc, char **argv)
 	bin_name = "bpftool";
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
+	while ((opt = getopt_long(argc, argv, "VhpjfLmndSMi:k:B:l",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -528,6 +530,11 @@ int main(int argc, char **argv)
 			sign_progs = true;
 			use_loader = true;
 			break;
+		case 'M':
+			sign_maps = true;
+			sign_progs = true;
+			use_loader = true;
+			break;
 		case 'k':
 			private_key_path = optarg;
 			break;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 1130299cede0b..d4e8b39d97746 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -92,6 +92,7 @@ extern bool use_loader;
 extern struct btf *base_btf;
 extern struct hashmap *refs_table;
 extern bool sign_progs;
+extern bool sign_maps;
 extern const char *private_key_path;
 extern const char *cert_path;
 
diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index b34f74d210e9c..6338f0309cd91 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -23,6 +23,7 @@
 #include <errno.h>
 
 #include <bpf/skel_internal.h>
+#include <bpf/libbpf_internal.h>
 
 #include "main.h"
 
@@ -130,8 +131,17 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	long actual_sig_len = 0;
 	X509 *x509 = NULL;
 	int err = 0;
-
-	bd_in = BIO_new_mem_buf(opts->insns, opts->insns_sz);
+	unsigned char hash[SHA256_DIGEST_LENGTH  * 2];
+	unsigned char term[SHA256_DIGEST_LENGTH];
+
+	if (sign_maps) {
+		libbpf_sha256(opts->insns, opts->insns_sz, hash);
+		libbpf_sha256(opts->data, opts->data_sz, hash + SHA256_DIGEST_LENGTH);
+		libbpf_sha256(hash, sizeof(hash), term);
+		bd_in = BIO_new_mem_buf(term, sizeof(term));
+	} else {
+		bd_in = BIO_new_mem_buf(opts->insns, opts->insns_sz);
+	}
 	if (!bd_in) {
 		err = -ENOMEM;
 		goto cleanup;
@@ -172,7 +182,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	EVP_Digest(opts->insns, opts->insns_sz, opts->excl_prog_hash,
 		   &opts->excl_prog_hash_sz, EVP_sha256(), NULL);
 
-		bd_out = BIO_new(BIO_s_mem());
+	bd_out = BIO_new(BIO_s_mem());
 	if (!bd_out) {
 		err = -ENOMEM;
 		goto cleanup;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e243..63946bdad41ad 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1858,9 +1858,10 @@ struct gen_loader_opts {
 	__u32 data_sz;
 	__u32 insns_sz;
 	bool gen_hash;
+	bool sign_maps;
 };
 
-#define gen_loader_opts__last_field gen_hash
+#define gen_loader_opts__last_field sign_maps
 LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
 				      struct gen_loader_opts *opts);
 
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 6a8f5c7a02eb9..11c2c19a5b2a4 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -74,6 +74,8 @@ struct bpf_load_and_run_opts {
 	__s32 keyring_id;
 	void *excl_prog_hash;
 	__u32 excl_prog_hash_sz;
+	const int *signature_maps;
+	__u32 signature_maps_sz;
 };
 
 long kern_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
@@ -352,7 +354,7 @@ static inline int skel_map_freeze(int fd)
 
 static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 {
-	const size_t prog_load_attr_sz = offsetofend(union bpf_attr, keyring_id);
+	const size_t prog_load_attr_sz = offsetofend(union bpf_attr, signature_maps_size);
 	const size_t test_run_attr_sz = offsetofend(union bpf_attr, test);
 	int map_fd = -1, prog_fd = -1, key = 0, err;
 	union bpf_attr attr;
@@ -395,6 +397,8 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 #ifndef __KERNEL__
 	attr.signature = (long) opts->signature;
 	attr.signature_size = opts->signature_sz;
+	attr.signature_maps = (long) opts->signature_maps;
+	attr.signature_maps_size = opts->signature_maps_sz;
 #else
 	if (opts->signature || opts->signature_sz)
 		pr_warn("signatures are not supported from bpf_preload\n");
-- 
2.48.1


