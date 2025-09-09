Return-Path: <bpf+bounces-67886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45100B50271
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B921749BF
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CA035209B;
	Tue,  9 Sep 2025 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d1B5gu2I"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415C350D79;
	Tue,  9 Sep 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435045; cv=none; b=S9I64rFZvUOd3KaGs37slYxhrD0n4kBNU6pMTsV/NOVa9bchg2BiZggFUATfzuD0tUAUc0OZpr5FhATNj2BgF7JR+13Xfm7R71QJnlHDm3LOKpn6IkZSK20N2eNlvXIS7rggTzJWWqbBKyrKwosJx475sUYD5rcM7KtQSEw6V6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435045; c=relaxed/simple;
	bh=I32WngEpEkzMhJkylrVhFdmVlSiCTuqpVVsRlHBU8v4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOZiOD2D6ezap3FfpgInVzJCfVwLDCqWBDLUj4w62GnhPjLSLzLUI5WG4hUIKmQZ0zzksAQ+8wabs6JAXOOA9PiTTLaN5IQuGUL9VQSDOExZDXbpbGOCwRvL1rjWjUCf97WYnvfJZfAQ6kQbrBIBwXhTZvRvBb4ew8D2Jla1UkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d1B5gu2I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id DCE2B211AA25;
	Tue,  9 Sep 2025 09:23:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCE2B211AA25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757435037;
	bh=D4yo43ZMZEZO65LVJTXGntngPaYaKdzB0OWLprFptuE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=d1B5gu2I75OIFfPD78ouwb+u+jc/4ouebRThY7a2iuKF6Xl0savLUVlnO9YnovWxx
	 OpW3Wa1BkaEMiHLDqK4qLIvhWq71rB6VikrPdZCWKEznaysJqqNUTxiqU6wE5cIu5/
	 41l5c5H9Si1h8x5oaC2KJtq4K3EVP5tGRkqbH5ys=
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
	wufan@linux.microsoft.com
Subject: [RFC 2/2] libbpf: Add hash chain signing support to light skeletons.
Date: Tue,  9 Sep 2025 09:20:59 -0700
Message-ID: <20250909162345.569889-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909162345.569889-1-bboscaccy@linux.microsoft.com>
References: <20250909162345.569889-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a hash chain signing support for light-skeleton
assets. A new flag '-M' is added which constructs a hash chain with
the loader program and the target payload.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 tools/bpf/bpftool/gen.c       | 25 +++++++++++++++++++++++++
 tools/bpf/bpftool/main.c      |  8 +++++++-
 tools/bpf/bpftool/main.h      |  1 +
 tools/bpf/bpftool/sign.c      | 17 ++++++++++++++---
 tools/lib/bpf/libbpf.h        |  3 ++-
 tools/lib/bpf/skel_internal.h |  6 +++++-
 6 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ab6fc86598ad3..e660fbc701c5d 100644
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
@@ -821,6 +826,13 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
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
@@ -829,6 +841,19 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 			opts.excl_prog_hash_sz = sizeof(opts_excl_hash) - 1;	\n\
 			opts.keyring_id = KEY_SPEC_SESSION_KEYRING;		\n\
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
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index fc25bb390ec71..287e8205494cb 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -34,6 +34,7 @@ bool use_loader;
 struct btf *base_btf;
 struct hashmap *refs_table;
 bool sign_progs;
+bool sign_maps;
 const char *private_key_path;
 const char *cert_path;
 
@@ -477,7 +478,7 @@ int main(int argc, char **argv)
 	bin_name = "bpftool";
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "VhpjfLmndSi:k:B:l",
+	while ((opt = getopt_long(argc, argv, "VhpjfLmndSMi:k:B:l",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -527,6 +528,11 @@ int main(int argc, char **argv)
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
index f921af3cda87f..805c3d87a1330 100644
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
index f0b5dd10a46b2..d5514b7d2b82d 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 
 #include <bpf/skel_internal.h>
+#include <bpf/libbpf_internal.h>
 
 #include "main.h"
 
@@ -129,8 +130,18 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	long actual_sig_len = 0;
 	X509 *x509 = NULL;
 	int err = 0;
-
-	bd_in = BIO_new_mem_buf(opts->insns, opts->insns_sz);
+	unsigned char hash[SHA256_DIGEST_LENGTH  * 2];
+	unsigned char term[SHA256_DIGEST_LENGTH];
+
+	if (sign_maps) {
+		libbpf_sha256(opts->insns, opts->insns_sz, hash, SHA256_DIGEST_LENGTH);
+		libbpf_sha256(opts->data, opts->data_sz, hash + SHA256_DIGEST_LENGTH,
+			      SHA256_DIGEST_LENGTH);
+		libbpf_sha256(hash, sizeof(hash), term, sizeof(term));
+		bd_in = BIO_new_mem_buf(term, sizeof(term));
+	} else {
+		bd_in = BIO_new_mem_buf(opts->insns, opts->insns_sz);
+	}
 	if (!bd_in) {
 		err = -ENOMEM;
 		goto cleanup;
@@ -171,7 +182,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	EVP_Digest(opts->insns, opts->insns_sz, opts->excl_prog_hash,
 		   &opts->excl_prog_hash_sz, EVP_sha256(), NULL);
 
-		bd_out = BIO_new(BIO_s_mem());
+	bd_out = BIO_new(BIO_s_mem());
 	if (!bd_out) {
 		err = -ENOMEM;
 		goto cleanup;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 7cad8470d9ebe..aad0288cd05e3 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1827,9 +1827,10 @@ struct gen_loader_opts {
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
index 5b6d1b09dc8a6..c25a4f1308e44 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -74,6 +74,8 @@ struct bpf_load_and_run_opts {
 	__u32 keyring_id;
 	void * excl_prog_hash;
 	__u32 excl_prog_hash_sz;
+	const int *signature_maps;
+	__u32 signature_maps_sz;
 };
 
 long kern_sys_bpf(__u32 cmd, void *attr, __u32 attr_size);
@@ -351,7 +353,7 @@ static inline int skel_map_freeze(int fd)
 
 static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 {
-	const size_t prog_load_attr_sz = offsetofend(union bpf_attr, keyring_id);
+	const size_t prog_load_attr_sz = offsetofend(union bpf_attr, signature_maps_size);
 	const size_t test_run_attr_sz = offsetofend(union bpf_attr, test);
 	int map_fd = -1, prog_fd = -1, key = 0, err;
 	union bpf_attr attr;
@@ -394,6 +396,8 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
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


