Return-Path: <bpf+bounces-69866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31334BA511E
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 22:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5ACB7B5AF3
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02028504C;
	Fri, 26 Sep 2025 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qJr+mzS9"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A7826F29F;
	Fri, 26 Sep 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918682; cv=none; b=YZeWpGUaqr3tisjMiLlTzvrH/tqnY7RZ8dBOWOb1ctyUd1CcfW240CZRiaYmcAED/XvBn6nkqJv/4vSEf5eCjQDyV/G9nJVNXFWG28YFSk4+/grnir7ogLa+KcONP258ete4169GQEEVj2O58OGv8mqpjqbEujmXEQ2k/Je16g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918682; c=relaxed/simple;
	bh=oCC2y8bUsyvUbA204caGPNImuRxDFm1kgIF2PhkQgzs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isJeyHsX+y907JOPbvVMabuYx2M+Gky1z6hX89nlRn3N0mr12b+QnWl8LbRmHCytOZ2BOvqop7rX8fCqjp3RnNY+j6f9oyG7h1LvK7C51643WNf+0Y+fHRGLbRcUS0DFVwGb+OF19ZWPZiNPWixgJunm/1MoQfNlxN5Tjgj83UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qJr+mzS9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id A97BA2012C32;
	Fri, 26 Sep 2025 13:31:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A97BA2012C32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758918679;
	bh=P9P/f4InWltYhl7GEuj8MOhmXz1TTqYO+/a25OyYRdk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qJr+mzS9x5gzlnloM95U8M/angr9iMCsWNhkvXDIPetcQSnYKeOA2Lr0bh+uE2L5C
	 5fJIUzftMn8ep0Sd5mEX7QI0ZaxHGR528t2+TVJIozHse0PkAlDtHibOKlzDGXE12p
	 GU1c/2nDvgfzYY8+DZh42gcgNp4zEVcr9nYJNKS8=
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
Subject: [PATCH bpf-next 1/2] bpf: Add hash chain signature support for arbitrary maps
Date: Fri, 26 Sep 2025 13:30:32 -0700
Message-ID: <20250926203111.1305999-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250926203111.1305999-1-bboscaccy@linux.microsoft.com>
References: <20250926203111.1305999-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces hash chain support for signature verification of
arbitrary bpf map objects which was described here:
https://lore.kernel.org/linux-security-module/20250721211958.1881379-1-kpsingh@kernel.org/

The UAPI is extended to allow for in-kernel checking of maps passed in
via the fd_array. A hash chain is constructed from the maps, in order
specified by the signature_maps field. The hash chain is terminated
with the hash of the program itself.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/uapi/linux/bpf.h                      |  6 ++
 kernel/bpf/syscall.c                          | 73 ++++++++++++++++++-
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  7 +-
 tools/bpf/bpftool/gen.c                       | 27 ++++++-
 tools/bpf/bpftool/main.c                      |  9 ++-
 tools/bpf/bpftool/main.h                      |  1 +
 tools/bpf/bpftool/sign.c                      | 17 ++++-
 tools/include/uapi/linux/bpf.h                |  6 ++
 tools/lib/bpf/libbpf.h                        |  3 +-
 tools/lib/bpf/skel_internal.h                 |  6 +-
 10 files changed, 143 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ae83d8649ef1c..a436a2ff49437 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1621,6 +1621,12 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		/* Pointer to a buffer containing the maps used in the signature
+		 * hash chain of the BPF program.
+		 */
+		__aligned_u64   signature_maps;
+		/* Size of the signature maps buffer. */
+		__u32		signature_maps_size;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index adb05d235011f..eb5c210639ccf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2800,14 +2800,35 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+static inline int bpf_map_get_hash(int map_fd, void *buffer)
+{
+	struct bpf_map *map;
+
+	CLASS(fd, f)(map_fd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	if (!map->ops->map_get_hash)
+		return -EINVAL;
+
+	return map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, buffer);
+}
+
 static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr,
 				     bool is_kernel)
 {
 	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
-	struct bpf_dynptr_kern sig_ptr, insns_ptr;
+	bpfptr_t umaps;
+	struct bpf_dynptr_kern sig_ptr, insns_ptr, hash_ptr;
 	struct bpf_key *key = NULL;
 	void *sig;
+	int *maps;
+	int map_fd;
 	int err = 0;
+	u64 buffer[SHA256_DIGEST_SIZE * 2 / sizeof(u64)];
+	u64 hash[SHA256_DIGEST_SIZE / sizeof(u64)];
+	int n;
 
 	if (system_keyring_id_check(attr->keyring_id) == 0)
 		key = bpf_lookup_system_key(attr->keyring_id);
@@ -2828,16 +2849,60 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 	bpf_dynptr_init(&insns_ptr, prog->insnsi, BPF_DYNPTR_TYPE_LOCAL, 0,
 			prog->len * sizeof(struct bpf_insn));
 
-	err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&insns_ptr,
-					 (struct bpf_dynptr *)&sig_ptr, key);
+	if (!attr->signature_maps_size) {
+		err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&insns_ptr,
+						 (struct bpf_dynptr *)&sig_ptr, key);
+	} else {
+		bpf_dynptr_init(&hash_ptr, hash, BPF_DYNPTR_TYPE_LOCAL, 0,
+				sizeof(hash));
+		umaps = make_bpfptr(attr->signature_maps, is_kernel);
+		maps = kvmemdup_bpfptr(umaps, attr->signature_maps_size * sizeof(*maps));
+		if (!maps) {
+			err = -ENOMEM;
+			goto out;
+		}
+		/* Process the map array in reverse order to generate a hash chain
+		 * h(n) = sha256(h(n + 1), sha256(map(n)))
+		 * h(n_len) = sha256(map(n_len))
+		 */
+		for (n = attr->signature_maps_size - 1; n >= 0; n--) {
+			err = copy_from_bpfptr_offset(&map_fd,
+						      make_bpfptr(attr->fd_array, is_kernel),
+						      maps[n] * sizeof(map_fd),
+						      sizeof(map_fd));
+			if (err)
+				goto free_maps;
+
+			if (n == attr->signature_maps_size - 1)
+				err = bpf_map_get_hash(map_fd, hash);
+			else {
+				memcpy(buffer, hash, sizeof(hash));
+				err = bpf_map_get_hash(map_fd, buffer + ARRAY_SIZE(hash));
+				sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
+			}
+			if (err)
+				goto free_maps;
+		}
+		/* Calculate final hash with program instructions
+		 * f_hash = sha256(sha256(prog), h(0))
+		 */
+		sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_insn), (u8 *)&buffer);
+		memcpy(buffer + ARRAY_SIZE(hash), hash, sizeof(hash));
+		sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
+		err = bpf_verify_pkcs7_signature((struct bpf_dynptr *)&hash_ptr,
+						 (struct bpf_dynptr *)&sig_ptr, key);
 
+free_maps:
+		kvfree(maps);
+	}
+out:
 	bpf_key_put(key);
 	kvfree(sig);
 	return err;
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_PROG_LOAD_LAST_FIELD keyring_id
+#define BPF_PROG_LOAD_LAST_FIELD signature_maps_size
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
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
index b29d825bb1d41..50986c716292e 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -24,6 +24,7 @@
 #include <errno.h>
 
 #include <bpf/skel_internal.h>
+#include <bpf/libbpf_internal.h>
 
 #include "main.h"
 
@@ -131,8 +132,18 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
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
@@ -173,7 +184,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	EVP_Digest(opts->insns, opts->insns_sz, opts->excl_prog_hash,
 		   &opts->excl_prog_hash_sz, EVP_sha256(), NULL);
 
-		bd_out = BIO_new(BIO_s_mem());
+	bd_out = BIO_new(BIO_s_mem());
 	if (!bd_out) {
 		err = -ENOMEM;
 		goto cleanup;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ae83d8649ef1c..a436a2ff49437 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1621,6 +1621,12 @@ union bpf_attr {
 		 * verification.
 		 */
 		__s32		keyring_id;
+		/* Pointer to a buffer containing the maps used in the signature
+		 * hash chain of the BPF program.
+		 */
+		__aligned_u64   signature_maps;
+		/* Size of the signature maps buffer. */
+		__u32		signature_maps_size;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
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


