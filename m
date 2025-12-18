Return-Path: <bpf+bounces-77037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F22CCCD7AA
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 21:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4E753021740
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 20:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735152D130B;
	Thu, 18 Dec 2025 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slqiRzgZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9083273D73;
	Thu, 18 Dec 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088658; cv=none; b=ZQWggb0ur+br71xj8lHMD/v1MVBB0AwouZS/m9SedYeAgiBL44cvQIZaoht1F9GKdOdc+64evB0Fl4ynpuioLe4bEdc1H8FkYXsqZprpzbzy5TxZ3HzZEQLrLTmtvtqOM+/fM3bpawPk35uMKgB1EhTujt+Vg95OUHQzisBQnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088658; c=relaxed/simple;
	bh=qN7Cr1arLefvsmDEuoRALF7jtMuDOI0Vi3aTiwfw7/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RdOjSL0qCIvF5VwUuDCXdcM07NJwehvHTGaLLrPN3KXdz4BxnHKU3iLqvlX+7p2SnSNAN5ZU4BYus9o2TIGoU4v2NcUILESnCHAfUSpxtBA17slY4ocaD0Rfpw91gfumzzCyerVhhnH/yjK5fNvxGVS7Au3C3MsC8k+jBT2iCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slqiRzgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1795EC4CEFB;
	Thu, 18 Dec 2025 20:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088657;
	bh=qN7Cr1arLefvsmDEuoRALF7jtMuDOI0Vi3aTiwfw7/w=;
	h=From:To:Cc:Subject:Date:From;
	b=slqiRzgZjbdrbGR+T4e0+3/c8hI3jptbTOOcBXs1rSp7yo+hQFWVwEx153nSnjCkv
	 VEEBICQFitiLY7ze8CJqZcs2rCDIeFNYGpwyn15tnCsI/ZjI9cbFLsZhe5n88+9UdU
	 /r33leT1aN/0x4QpQg4AEhh86UTfD1MgPF8QL36/wjdecq5OAV9xvOfU7eTsAa8C2q
	 TTyXwqvOTgoriQ5DKL8rGeHd/FksqJJYczXaljLDzG75aPzcT3M5wj0cpSyac6bWwq
	 TXIKTrjol76e0XHzl+u8bOGjBPYR6LfNaB19dbVZFKECFUo/VMs8eWw3oRf1Y+PLgE
	 XRasisnP08KfA==
From: Eric Biggers <ebiggers@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH iproute2-next v3] lib/bpf_legacy: Use userspace SHA-1 code instead of AF_ALG
Date: Thu, 18 Dec 2025 12:09:10 -0800
Message-ID: <20251218200910.159349-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy.c use
it to calculate SHA-1 digests instead of the previous AF_ALG-based code.

This eliminates the dependency on AF_ALG, specifically the kernel config
options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.

Over the years AF_ALG has been very problematic, and it is also not
supported on all kernels.  Escalating to the kernel's privileged
execution context merely to calculate software algorithms, which can be
done in userspace instead, is not something that should have ever been
supported.  Even on kernels that support it, the syscall overhead of
AF_ALG means that it is often slower than userspace code.

Let's do the right thing here, and allow people to disable AF_ALG
support (or not enable it) on systems where iproute2 is the only user.

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

Changed in v3:
    - Added Alexei's ack

Changed in v2:
    - Corrected error handling for when bpf_obj_hash() fails
    - Added more detail to commit message

 include/bpf_util.h          |   5 --
 include/sha1.h              |  18 ++++++
 include/uapi/linux/if_alg.h |  61 --------------------
 lib/Makefile                |   2 +-
 lib/bpf_legacy.c            | 109 +++++++++---------------------------
 lib/sha1.c                  | 108 +++++++++++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 149 deletions(-)
 create mode 100644 include/sha1.h
 delete mode 100644 include/uapi/linux/if_alg.h
 create mode 100644 lib/sha1.c

diff --git a/include/bpf_util.h b/include/bpf_util.h
index 8951a5e8..e1b8d327 100644
--- a/include/bpf_util.h
+++ b/include/bpf_util.h
@@ -12,11 +12,10 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/filter.h>
 #include <linux/magic.h>
 #include <linux/elf-em.h>
-#include <linux/if_alg.h>
 
 #include "utils.h"
 #include "bpf_scm.h"
 
 #define BPF_ENV_UDS	"TC_BPF_UDS"
@@ -38,14 +37,10 @@
 # define TRACEFS_MAGIC	0x74726163
 #endif
 
 #define TRACE_DIR_MNT	"/sys/kernel/tracing"
 
-#ifndef AF_ALG
-# define AF_ALG		38
-#endif
-
 #ifndef EM_BPF
 # define EM_BPF		247
 #endif
 
 struct bpf_cfg_ops {
diff --git a/include/sha1.h b/include/sha1.h
new file mode 100644
index 00000000..4a2ed513
--- /dev/null
+++ b/include/sha1.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SHA-1 message digest algorithm
+ *
+ * Copyright 2025 Google LLC
+ */
+#ifndef __SHA1_H__
+#define __SHA1_H__
+
+#include <linux/types.h>
+#include <stddef.h>
+
+#define SHA1_DIGEST_SIZE 20
+#define SHA1_BLOCK_SIZE 64
+
+void sha1(const __u8 *data, size_t len, __u8 out[SHA1_DIGEST_SIZE]);
+
+#endif /* __SHA1_H__ */
diff --git a/include/uapi/linux/if_alg.h b/include/uapi/linux/if_alg.h
deleted file mode 100644
index 0824fbc0..00000000
--- a/include/uapi/linux/if_alg.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-/*
- * if_alg: User-space algorithm interface
- *
- * Copyright (c) 2010 Herbert Xu <herbert@gondor.apana.org.au>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- */
-
-#ifndef _LINUX_IF_ALG_H
-#define _LINUX_IF_ALG_H
-
-#include <linux/types.h>
-
-struct sockaddr_alg {
-	__u16	salg_family;
-	__u8	salg_type[14];
-	__u32	salg_feat;
-	__u32	salg_mask;
-	__u8	salg_name[64];
-};
-
-/*
- * Linux v4.12 and later removed the 64-byte limit on salg_name[]; it's now an
- * arbitrary-length field.  We had to keep the original struct above for source
- * compatibility with existing userspace programs, though.  Use the new struct
- * below if support for very long algorithm names is needed.  To do this,
- * allocate 'sizeof(struct sockaddr_alg_new) + strlen(algname) + 1' bytes, and
- * copy algname (including the null terminator) into salg_name.
- */
-struct sockaddr_alg_new {
-	__u16	salg_family;
-	__u8	salg_type[14];
-	__u32	salg_feat;
-	__u32	salg_mask;
-	__u8	salg_name[];
-};
-
-struct af_alg_iv {
-	__u32	ivlen;
-	__u8	iv[];
-};
-
-/* Socket options */
-#define ALG_SET_KEY			1
-#define ALG_SET_IV			2
-#define ALG_SET_OP			3
-#define ALG_SET_AEAD_ASSOCLEN		4
-#define ALG_SET_AEAD_AUTHSIZE		5
-#define ALG_SET_DRBG_ENTROPY		6
-#define ALG_SET_KEY_BY_KEY_SERIAL	7
-
-/* Operations */
-#define ALG_OP_DECRYPT			0
-#define ALG_OP_ENCRYPT			1
-
-#endif	/* _LINUX_IF_ALG_H */
diff --git a/lib/Makefile b/lib/Makefile
index 340c37bc..cd561bc0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -4,11 +4,11 @@ include ../config.mk
 CFLAGS += -fPIC
 
 UTILOBJ = utils.o utils_math.o rt_names.o ll_map.o ll_types.o ll_proto.o ll_addr.o \
 	inet_proto.o namespace.o json_writer.o json_print.o json_print_math.o \
 	names.o color.o bpf_legacy.o bpf_glue.o exec.o fs.o cg_map.o \
-	ppp_proto.o bridge.o
+	ppp_proto.o bridge.o sha1.o
 
 ifeq ($(HAVE_ELF),y)
 ifeq ($(HAVE_LIBBPF),y)
 UTILOBJ += bpf_libbpf.o
 endif
diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
index c8da4a3e..50ca82c1 100644
--- a/lib/bpf_legacy.c
+++ b/lib/bpf_legacy.c
@@ -27,18 +27,19 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/un.h>
 #include <sys/vfs.h>
+#include <sys/mman.h>
 #include <sys/mount.h>
-#include <sys/sendfile.h>
 #include <sys/resource.h>
 
 #include <arpa/inet.h>
 
 #include "utils.h"
 #include "json_print.h"
+#include "sha1.h"
 
 #include "bpf_util.h"
 #include "bpf_elf.h"
 #include "bpf_scm.h"
 
@@ -1178,11 +1179,10 @@ struct bpf_elf_ctx {
 	int			sec_btf;
 	char			license[ELF_MAX_LICENSE_LEN];
 	enum bpf_prog_type	type;
 	__u32			ifindex;
 	bool			verbose;
-	bool			noafalg;
 	struct bpf_elf_st	stat;
 	struct bpf_hash_entry	*ht[256];
 	char			*log;
 	size_t			log_size;
 };
@@ -1306,76 +1306,32 @@ static int bpf_obj_pin(int fd, const char *pathname)
 	attr.bpf_fd = fd;
 
 	return bpf(BPF_OBJ_PIN, &attr, sizeof(attr));
 }
 
-static int bpf_obj_hash(const char *object, uint8_t *out, size_t len)
+static int bpf_obj_hash(int fd, const char *object, __u8 out[SHA1_DIGEST_SIZE])
 {
-	struct sockaddr_alg alg = {
-		.salg_family	= AF_ALG,
-		.salg_type	= "hash",
-		.salg_name	= "sha1",
-	};
-	int ret, cfd, ofd, ffd;
 	struct stat stbuff;
-	ssize_t size;
-
-	if (!object || len != 20)
-		return -EINVAL;
-
-	cfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
-	if (cfd < 0)
-		return cfd;
+	void *data;
 
-	ret = bind(cfd, (struct sockaddr *)&alg, sizeof(alg));
-	if (ret < 0)
-		goto out_cfd;
-
-	ofd = accept(cfd, NULL, 0);
-	if (ofd < 0) {
-		ret = ofd;
-		goto out_cfd;
+	if (fstat(fd, &stbuff) < 0) {
+		fprintf(stderr, "Error doing fstat: %s\n", strerror(errno));
+		return -1;
 	}
-
-	ffd = open(object, O_RDONLY);
-	if (ffd < 0) {
-		fprintf(stderr, "Error opening object %s: %s\n",
-			object, strerror(errno));
-		ret = ffd;
-		goto out_ofd;
+	if ((size_t)stbuff.st_size != stbuff.st_size) {
+		fprintf(stderr, "Object %s is too big\n", object);
+		return -EFBIG;
 	}
-
-	ret = fstat(ffd, &stbuff);
-	if (ret < 0) {
-		fprintf(stderr, "Error doing fstat: %s\n",
+	data = mmap(NULL, stbuff.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (data == MAP_FAILED) {
+		fprintf(stderr, "Error mapping object %s: %s\n", object,
 			strerror(errno));
-		goto out_ffd;
-	}
-
-	size = sendfile(ofd, ffd, NULL, stbuff.st_size);
-	if (size != stbuff.st_size) {
-		fprintf(stderr, "Error from sendfile (%zd vs %zu bytes): %s\n",
-			size, stbuff.st_size, strerror(errno));
-		ret = -1;
-		goto out_ffd;
+		return -1;
 	}
-
-	size = read(ofd, out, len);
-	if (size != len) {
-		fprintf(stderr, "Error from read (%zd vs %zu bytes): %s\n",
-			size, len, strerror(errno));
-		ret = -1;
-	} else {
-		ret = 0;
-	}
-out_ffd:
-	close(ffd);
-out_ofd:
-	close(ofd);
-out_cfd:
-	close(cfd);
-	return ret;
+	sha1(data, stbuff.st_size, out);
+	munmap(data, stbuff.st_size);
+	return 0;
 }
 
 static void bpf_init_env(void)
 {
 	struct rlimit limit = {
@@ -1812,16 +1768,10 @@ static int bpf_maps_attach_all(struct bpf_elf_ctx *ctx)
 {
 	int i, j, ret, fd, inner_fd, inner_idx, have_map_in_map = 0;
 	const char *map_name;
 
 	for (i = 0; i < ctx->map_num; i++) {
-		if (ctx->maps[i].pinning == PIN_OBJECT_NS &&
-		    ctx->noafalg) {
-			fprintf(stderr, "Missing kernel AF_ALG support for PIN_OBJECT_NS!\n");
-			return -ENOTSUP;
-		}
-
 		map_name = bpf_map_fetch_name(ctx, i);
 		if (!map_name)
 			return -EIO;
 
 		fd = bpf_map_attach(map_name, ctx, &ctx->maps[i],
@@ -2867,35 +2817,36 @@ static void bpf_get_cfg(struct bpf_elf_ctx *ctx)
 
 static int bpf_elf_ctx_init(struct bpf_elf_ctx *ctx, const char *pathname,
 			    enum bpf_prog_type type, __u32 ifindex,
 			    bool verbose)
 {
-	uint8_t tmp[20];
+	__u8 tmp[SHA1_DIGEST_SIZE];
 	int ret;
 
 	if (elf_version(EV_CURRENT) == EV_NONE)
 		return -EINVAL;
 
 	bpf_init_env();
 
 	memset(ctx, 0, sizeof(*ctx));
 	bpf_get_cfg(ctx);
 
-	ret = bpf_obj_hash(pathname, tmp, sizeof(tmp));
-	if (ret)
-		ctx->noafalg = true;
-	else
-		hexstring_n2a(tmp, sizeof(tmp), ctx->obj_uid,
-			      sizeof(ctx->obj_uid));
-
 	ctx->verbose = verbose;
 	ctx->type    = type;
 	ctx->ifindex = ifindex;
 
 	ctx->obj_fd = open(pathname, O_RDONLY);
-	if (ctx->obj_fd < 0)
+	if (ctx->obj_fd < 0) {
+		fprintf(stderr, "Error opening object %s: %s\n", pathname,
+			strerror(errno));
 		return ctx->obj_fd;
+	}
+
+	ret = bpf_obj_hash(ctx->obj_fd, pathname, tmp);
+	if (ret)
+		goto out_fd;
+	hexstring_n2a(tmp, sizeof(tmp), ctx->obj_uid, sizeof(ctx->obj_uid));
 
 	ctx->elf_fd = elf_begin(ctx->obj_fd, ELF_C_READ, NULL);
 	if (!ctx->elf_fd) {
 		ret = -EINVAL;
 		goto out_fd;
@@ -3257,16 +3208,10 @@ bool iproute2_is_pin_map(const char *libbpf_map_name, char *pathname)
 	const char *map_name, *tmp;
 	unsigned int pinning;
 	int i, ret = 0;
 
 	for (i = 0; i < ctx->map_num; i++) {
-		if (ctx->maps[i].pinning == PIN_OBJECT_NS &&
-		    ctx->noafalg) {
-			fprintf(stderr, "Missing kernel AF_ALG support for PIN_OBJECT_NS!\n");
-			return false;
-		}
-
 		map_name = bpf_map_fetch_name(ctx, i);
 		if (!map_name) {
 			return false;
 		}
 
diff --git a/lib/sha1.c b/lib/sha1.c
new file mode 100644
index 00000000..1aa8fd83
--- /dev/null
+++ b/lib/sha1.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-1 message digest algorithm
+ *
+ * Copyright 2025 Google LLC
+ */
+
+#include <arpa/inet.h>
+#include <string.h>
+
+#include "sha1.h"
+#include "utils.h"
+
+static const __u32 sha1_K[4] = { 0x5A827999, 0x6ED9EBA1, 0x8F1BBCDC,
+				 0xCA62C1D6 };
+
+static inline __u32 rol32(__u32 v, int bits)
+{
+	return (v << bits) | (v >> (32 - bits));
+}
+
+#define round_up(a, b) (((a) + (b) - 1) & ~((b) - 1))
+
+#define SHA1_ROUND(i, a, b, c, d, e)                                           \
+	do {                                                                   \
+		if ((i) >= 16)                                                 \
+			w[i] = rol32(w[(i) - 16] ^ w[(i) - 14] ^ w[(i) - 8] ^  \
+					     w[(i) - 3],                       \
+				     1);                                       \
+		e += w[i] + rol32(a, 5) + sha1_K[(i) / 20];                    \
+		if ((i) < 20)                                                  \
+			e += (b & (c ^ d)) ^ d;                                \
+		else if ((i) < 40 || (i) >= 60)                                \
+			e += b ^ c ^ d;                                        \
+		else                                                           \
+			e += (c & d) ^ (b & (c ^ d));                          \
+		b = rol32(b, 30);                                              \
+		/* The new (a, b, c, d, e) is the old (e, a, b, c, d). */      \
+	} while (0)
+
+#define SHA1_5ROUNDS(i)                                                        \
+	do {                                                                   \
+		SHA1_ROUND((i) + 0, a, b, c, d, e);                            \
+		SHA1_ROUND((i) + 1, e, a, b, c, d);                            \
+		SHA1_ROUND((i) + 2, d, e, a, b, c);                            \
+		SHA1_ROUND((i) + 3, c, d, e, a, b);                            \
+		SHA1_ROUND((i) + 4, b, c, d, e, a);                            \
+	} while (0)
+
+#define SHA1_20ROUNDS(i)                                                       \
+	do {                                                                   \
+		SHA1_5ROUNDS((i) + 0);                                         \
+		SHA1_5ROUNDS((i) + 5);                                         \
+		SHA1_5ROUNDS((i) + 10);                                        \
+		SHA1_5ROUNDS((i) + 15);                                        \
+	} while (0)
+
+static void sha1_blocks(__u32 h[5], const __u8 *data, size_t nblocks)
+{
+	while (nblocks--) {
+		__u32 a = h[0];
+		__u32 b = h[1];
+		__u32 c = h[2];
+		__u32 d = h[3];
+		__u32 e = h[4];
+		__u32 w[80];
+		int i;
+
+		memcpy(w, data, SHA1_BLOCK_SIZE);
+		for (i = 0; i < 16; i++)
+			w[i] = ntohl(w[i]);
+		SHA1_20ROUNDS(0);
+		SHA1_20ROUNDS(20);
+		SHA1_20ROUNDS(40);
+		SHA1_20ROUNDS(60);
+
+		h[0] += a;
+		h[1] += b;
+		h[2] += c;
+		h[3] += d;
+		h[4] += e;
+		data += SHA1_BLOCK_SIZE;
+	}
+}
+
+/* Calculate the SHA-1 message digest of the given data. */
+void sha1(const __u8 *data, size_t len, __u8 out[SHA1_DIGEST_SIZE])
+{
+	__u32 h[5] = { 0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476,
+		       0xC3D2E1F0 };
+	const __be64 bitcount = htonll((__u64)len * 8);
+	__u8 final_data[2 * SHA1_BLOCK_SIZE] = { 0 };
+	size_t final_len = len % SHA1_BLOCK_SIZE;
+	int i;
+
+	sha1_blocks(h, data, len / SHA1_BLOCK_SIZE);
+
+	memcpy(final_data, data + len - final_len, final_len);
+	final_data[final_len] = 0x80;
+	final_len = round_up(final_len + 9, SHA1_BLOCK_SIZE);
+	memcpy(&final_data[final_len - 8], &bitcount, 8);
+
+	sha1_blocks(h, final_data, final_len / SHA1_BLOCK_SIZE);
+
+	for (i = 0; i < ARRAY_SIZE(h); i++)
+		h[i] = htonl(h[i]);
+	memcpy(out, h, SHA1_DIGEST_SIZE);
+}

base-commit: e570876032359a388636fddd9197d4f852eba94f
-- 
2.52.0


