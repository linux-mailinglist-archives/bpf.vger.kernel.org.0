Return-Path: <bpf+bounces-70120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FB2BB154F
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5D64A6654
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F692D29D7;
	Wed,  1 Oct 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjZJRUMe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5632D29CA
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338819; cv=none; b=ME9oSBGiQSkIvcK+5zi1Ufd+UuyAALQB+lyVCpXBpyu4EvYQGA5nW1IBrPuXFRQepoNdYUVOtTu6YhEzVtJYBQntAYpwytbkVbrJiDpZJ554V1wF8v9fth0tbq+2pTfdhTsCHKb22hb/ZBSm6pxe1uSpLQVmzoDMEBHDglActro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338819; c=relaxed/simple;
	bh=AYYIZdfWyPi4F8g0ZI0Fcc2/MUst6OnV79iQdwF1rrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RphdgCcP9yxnfqMVmOhVXBWL3rwXdfUtXDtbWWr5z2uC4Tjo4luPTUw9ot/LXRmgahbVgyygVMG+Wvyd0YKcWkhLU8w1ujfOI9T5NBZjYYx/g7AETo+bspqbHS90d7Cmo3jGz1L8rx4bKGCtcmweKhVC7xYMMaIcQiJhiuZiNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjZJRUMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FC8C4CEF5;
	Wed,  1 Oct 2025 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759338819;
	bh=AYYIZdfWyPi4F8g0ZI0Fcc2/MUst6OnV79iQdwF1rrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjZJRUMeEL7KS/+wZA9iCxCtOOvFICQNK09xTRqd71tjxW8u/DQvX/8mEd5H3Yx3y
	 1B3z6xfnWhGXDKfm3OEIrWNmh2p/CkiuQM13QuFEw04p9nvHf3J6t8RgVKdgOPOx2y
	 ikECgqrMcEbQyWNNHIEfGEdTJMWykKewemLrkcBF8ikl09N7lSnN8qz3rmfNRkZrVt
	 RELqmFUooOQ20q/0EvQibSqqOI9XvQWj4ZsRSy27F62QZhXx/o4l5Cq3XFvwcczOCr
	 aAKKJZjFN88aY4Qzi2G6araNan6niMc2FZR8oPDkElyvUM7qdfPB/sLtxMCcJwzM9F
	 eJLgqLiwJBHQw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf 3/5] libbpf: move libbpf_errstr() into libbpf_utils.c
Date: Wed,  1 Oct 2025 10:13:24 -0700
Message-ID: <20251001171326.3883055-4-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001171326.3883055-1-andrii@kernel.org>
References: <20251001171326.3883055-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of str_err.{c,h} by moving implementation of libbpf_errstr()
into libbpf_utils.c and declarations into libbpf_internal.h.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Build             |  2 +-
 tools/lib/bpf/btf.c             |  1 -
 tools/lib/bpf/btf_dump.c        |  1 -
 tools/lib/bpf/elf.c             |  1 -
 tools/lib/bpf/features.c        |  1 -
 tools/lib/bpf/gen_loader.c      |  3 +-
 tools/lib/bpf/libbpf.c          |  1 -
 tools/lib/bpf/libbpf_internal.h | 10 +++++
 tools/lib/bpf/libbpf_utils.c    | 72 +++++++++++++++++++++++++++++
 tools/lib/bpf/linker.c          |  1 -
 tools/lib/bpf/relo_core.c       |  1 -
 tools/lib/bpf/ringbuf.c         |  1 -
 tools/lib/bpf/str_error.c       | 80 ---------------------------------
 tools/lib/bpf/str_error.h       | 15 -------
 tools/lib/bpf/usdt.c            |  1 -
 15 files changed, 84 insertions(+), 107 deletions(-)
 delete mode 100644 tools/lib/bpf/str_error.c
 delete mode 100644 tools/lib/bpf/str_error.h

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index c30927135fd6..c80204bb72a2 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
-libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_utils.o str_error.o \
+libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_utils.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
 	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 37682908cb0f..18907f0fcf9f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -23,7 +23,6 @@
 #include "libbpf_internal.h"
 #include "hashmap.h"
 #include "strset.h"
-#include "str_error.h"
 
 #define BTF_MAX_NR_TYPES 0x7fffffffU
 #define BTF_MAX_STR_OFFSET 0x7fffffffU
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index f09f25eccf3c..6388392f49a0 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -21,7 +21,6 @@
 #include "hashmap.h"
 #include "libbpf.h"
 #include "libbpf_internal.h"
-#include "str_error.h"
 
 static const char PREFIXES[] = "\t\t\t\t\t\t\t\t\t\t\t\t\t";
 static const size_t PREFIX_CNT = sizeof(PREFIXES) - 1;
diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 823f83ad819c..295dbda24580 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 
 #include "libbpf_internal.h"
-#include "str_error.h"
 
 /* A SHT_GNU_versym section holds 16-bit words. This bit is set if
  * the symbol is hidden and can only be seen when referenced using an
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 760657f5224c..b842b83e2480 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -6,7 +6,6 @@
 #include "libbpf.h"
 #include "libbpf_common.h"
 #include "libbpf_internal.h"
-#include "str_error.h"
 
 static inline __u64 ptr_to_u64(const void *ptr)
 {
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 6945dd99a846..cd5c2543f54d 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <asm/byteorder.h>
 #include <linux/filter.h>
 #include <sys/param.h>
 #include "btf.h"
@@ -13,8 +14,6 @@
 #include "hashmap.h"
 #include "bpf_gen_internal.h"
 #include "skel_internal.h"
-#include <asm/byteorder.h>
-#include "str_error.h"
 
 #define MAX_USED_MAPS	64
 #define MAX_USED_PROGS	32
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c21bc61f5ff4..6d19e0db492c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -51,7 +51,6 @@
 #include "libbpf.h"
 #include "bpf.h"
 #include "btf.h"
-#include "str_error.h"
 #include "libbpf_internal.h"
 #include "hashmap.h"
 #include "bpf_gen_internal.h"
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index c93797dcaf5b..a8f204139371 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -172,6 +172,16 @@ do {				\
 #define pr_info(fmt, ...)	__pr(LIBBPF_INFO, fmt, ##__VA_ARGS__)
 #define pr_debug(fmt, ...)	__pr(LIBBPF_DEBUG, fmt, ##__VA_ARGS__)
 
+/**
+ * @brief **libbpf_errstr()** returns string corresponding to numeric errno
+ * @param err negative numeric errno
+ * @return pointer to string representation of the errno, that is invalidated
+ * upon the next call.
+ */
+const char *libbpf_errstr(int err);
+
+#define errstr(err) libbpf_errstr(err)
+
 #ifndef __has_builtin
 #define __has_builtin(x) 0
 #endif
diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
index 6b180172ec6b..ee3013e9b77c 100644
--- a/tools/lib/bpf/libbpf_utils.c
+++ b/tools/lib/bpf/libbpf_utils.c
@@ -10,10 +10,15 @@
 #undef _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
+#include <errno.h>
 
 #include "libbpf.h"
 #include "libbpf_internal.h"
 
+#ifndef ENOTSUPP
+#define ENOTSUPP	524
+#endif
+
 /* make sure libbpf doesn't use kernel-only integer typedefs */
 #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
 
@@ -73,3 +78,70 @@ int libbpf_strerror(int err, char *buf, size_t size)
 		return libbpf_err(-ERANGE);
 	return libbpf_err(-ENOENT);
 }
+
+const char *libbpf_errstr(int err)
+{
+	static __thread char buf[12];
+
+	if (err > 0)
+		err = -err;
+
+	switch (err) {
+	case -E2BIG:		return "-E2BIG";
+	case -EACCES:		return "-EACCES";
+	case -EADDRINUSE:	return "-EADDRINUSE";
+	case -EADDRNOTAVAIL:	return "-EADDRNOTAVAIL";
+	case -EAGAIN:		return "-EAGAIN";
+	case -EALREADY:		return "-EALREADY";
+	case -EBADF:		return "-EBADF";
+	case -EBADFD:		return "-EBADFD";
+	case -EBUSY:		return "-EBUSY";
+	case -ECANCELED:	return "-ECANCELED";
+	case -ECHILD:		return "-ECHILD";
+	case -EDEADLK:		return "-EDEADLK";
+	case -EDOM:		return "-EDOM";
+	case -EEXIST:		return "-EEXIST";
+	case -EFAULT:		return "-EFAULT";
+	case -EFBIG:		return "-EFBIG";
+	case -EILSEQ:		return "-EILSEQ";
+	case -EINPROGRESS:	return "-EINPROGRESS";
+	case -EINTR:		return "-EINTR";
+	case -EINVAL:		return "-EINVAL";
+	case -EIO:		return "-EIO";
+	case -EISDIR:		return "-EISDIR";
+	case -ELOOP:		return "-ELOOP";
+	case -EMFILE:		return "-EMFILE";
+	case -EMLINK:		return "-EMLINK";
+	case -EMSGSIZE:		return "-EMSGSIZE";
+	case -ENAMETOOLONG:	return "-ENAMETOOLONG";
+	case -ENFILE:		return "-ENFILE";
+	case -ENODATA:		return "-ENODATA";
+	case -ENODEV:		return "-ENODEV";
+	case -ENOENT:		return "-ENOENT";
+	case -ENOEXEC:		return "-ENOEXEC";
+	case -ENOLINK:		return "-ENOLINK";
+	case -ENOMEM:		return "-ENOMEM";
+	case -ENOSPC:		return "-ENOSPC";
+	case -ENOTBLK:		return "-ENOTBLK";
+	case -ENOTDIR:		return "-ENOTDIR";
+	case -ENOTSUPP:		return "-ENOTSUPP";
+	case -ENOTTY:		return "-ENOTTY";
+	case -ENXIO:		return "-ENXIO";
+	case -EOPNOTSUPP:	return "-EOPNOTSUPP";
+	case -EOVERFLOW:	return "-EOVERFLOW";
+	case -EPERM:		return "-EPERM";
+	case -EPIPE:		return "-EPIPE";
+	case -EPROTO:		return "-EPROTO";
+	case -EPROTONOSUPPORT:	return "-EPROTONOSUPPORT";
+	case -ERANGE:		return "-ERANGE";
+	case -EROFS:		return "-EROFS";
+	case -ESPIPE:		return "-ESPIPE";
+	case -ESRCH:		return "-ESRCH";
+	case -ETXTBSY:		return "-ETXTBSY";
+	case -EUCLEAN:		return "-EUCLEAN";
+	case -EXDEV:		return "-EXDEV";
+	default:
+		snprintf(buf, sizeof(buf), "%d", err);
+		return buf;
+	}
+}
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index a469e5d4fee7..56ae77047bc3 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -25,7 +25,6 @@
 #include "btf.h"
 #include "libbpf_internal.h"
 #include "strset.h"
-#include "str_error.h"
 
 #define BTF_EXTERN_SEC ".extern"
 
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 2b83c98a1137..6eea5edba58a 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -64,7 +64,6 @@ enum libbpf_print_level {
 #include "libbpf.h"
 #include "bpf.h"
 #include "btf.h"
-#include "str_error.h"
 #include "libbpf_internal.h"
 #endif
 
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 9702b70da444..00ec4837a06d 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -21,7 +21,6 @@
 #include "libbpf.h"
 #include "libbpf_internal.h"
 #include "bpf.h"
-#include "str_error.h"
 
 struct ring {
 	ring_buffer_sample_fn sample_cb;
diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
deleted file mode 100644
index 92dbd801102f..000000000000
--- a/tools/lib/bpf/str_error.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-#undef _GNU_SOURCE
-#include <string.h>
-#include <stdio.h>
-#include <errno.h>
-#include "str_error.h"
-
-#ifndef ENOTSUPP
-#define ENOTSUPP	524
-#endif
-
-/* make sure libbpf doesn't use kernel-only integer typedefs */
-#pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
-
-const char *libbpf_errstr(int err)
-{
-	static __thread char buf[12];
-
-	if (err > 0)
-		err = -err;
-
-	switch (err) {
-	case -E2BIG:		return "-E2BIG";
-	case -EACCES:		return "-EACCES";
-	case -EADDRINUSE:	return "-EADDRINUSE";
-	case -EADDRNOTAVAIL:	return "-EADDRNOTAVAIL";
-	case -EAGAIN:		return "-EAGAIN";
-	case -EALREADY:		return "-EALREADY";
-	case -EBADF:		return "-EBADF";
-	case -EBADFD:		return "-EBADFD";
-	case -EBUSY:		return "-EBUSY";
-	case -ECANCELED:	return "-ECANCELED";
-	case -ECHILD:		return "-ECHILD";
-	case -EDEADLK:		return "-EDEADLK";
-	case -EDOM:		return "-EDOM";
-	case -EEXIST:		return "-EEXIST";
-	case -EFAULT:		return "-EFAULT";
-	case -EFBIG:		return "-EFBIG";
-	case -EILSEQ:		return "-EILSEQ";
-	case -EINPROGRESS:	return "-EINPROGRESS";
-	case -EINTR:		return "-EINTR";
-	case -EINVAL:		return "-EINVAL";
-	case -EIO:		return "-EIO";
-	case -EISDIR:		return "-EISDIR";
-	case -ELOOP:		return "-ELOOP";
-	case -EMFILE:		return "-EMFILE";
-	case -EMLINK:		return "-EMLINK";
-	case -EMSGSIZE:		return "-EMSGSIZE";
-	case -ENAMETOOLONG:	return "-ENAMETOOLONG";
-	case -ENFILE:		return "-ENFILE";
-	case -ENODATA:		return "-ENODATA";
-	case -ENODEV:		return "-ENODEV";
-	case -ENOENT:		return "-ENOENT";
-	case -ENOEXEC:		return "-ENOEXEC";
-	case -ENOLINK:		return "-ENOLINK";
-	case -ENOMEM:		return "-ENOMEM";
-	case -ENOSPC:		return "-ENOSPC";
-	case -ENOTBLK:		return "-ENOTBLK";
-	case -ENOTDIR:		return "-ENOTDIR";
-	case -ENOTSUPP:		return "-ENOTSUPP";
-	case -ENOTTY:		return "-ENOTTY";
-	case -ENXIO:		return "-ENXIO";
-	case -EOPNOTSUPP:	return "-EOPNOTSUPP";
-	case -EOVERFLOW:	return "-EOVERFLOW";
-	case -EPERM:		return "-EPERM";
-	case -EPIPE:		return "-EPIPE";
-	case -EPROTO:		return "-EPROTO";
-	case -EPROTONOSUPPORT:	return "-EPROTONOSUPPORT";
-	case -ERANGE:		return "-ERANGE";
-	case -EROFS:		return "-EROFS";
-	case -ESPIPE:		return "-ESPIPE";
-	case -ESRCH:		return "-ESRCH";
-	case -ETXTBSY:		return "-ETXTBSY";
-	case -EUCLEAN:		return "-EUCLEAN";
-	case -EXDEV:		return "-EXDEV";
-	default:
-		snprintf(buf, sizeof(buf), "%d", err);
-		return buf;
-	}
-}
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
deleted file mode 100644
index d4c82eec034d..000000000000
--- a/tools/lib/bpf/str_error.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
-#ifndef __LIBBPF_STR_ERROR_H
-#define __LIBBPF_STR_ERROR_H
-
-/**
- * @brief **libbpf_errstr()** returns string corresponding to numeric errno
- * @param err negative numeric errno
- * @return pointer to string representation of the errno, that is invalidated
- * upon the next call.
- */
-const char *libbpf_errstr(int err);
-
-#define errstr(err) libbpf_errstr(err)
-
-#endif /* __LIBBPF_STR_ERROR_H */
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index fc2785eecc17..c174b4086673 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -20,7 +20,6 @@
 #include "libbpf_common.h"
 #include "libbpf_internal.h"
 #include "hashmap.h"
-#include "str_error.h"
 
 /* libbpf's USDT support consists of BPF-side state/code and user-space
  * state/code working together in concert. BPF-side parts are defined in
-- 
2.47.3


