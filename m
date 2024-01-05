Return-Path: <bpf+bounces-19090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DFA824C10
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D871F230EE
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CE67F4;
	Fri,  5 Jan 2024 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN47j9L7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054121845
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 00:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A0FC433C7;
	Fri,  5 Jan 2024 00:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704413374;
	bh=vl9Y+jrmrtbuKG8DcL5i7h24+LWL2CBbxVTKegCg1DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sN47j9L721gN6IpK+OTkfxyYStUhAb/TOtwu0fIbAJ3oODA3196+dQDg/zFfaX4Da
	 p0mdhP6BPeBR+I30gaRPj4pBFHLFZAEAo9O6w84wHNSlQwGPCT/NmlBNQRsqqFnESS
	 elT8ZyCxl3s45dTLk0IjES95cIFlhIbpNPa3Fbi4R+rI9ZGAC6ZJgghK1YSzSQQGdA
	 nXiemaVTrFxqkL8xIhrS7t1ZB5sH/6cZZjHQBBewKHfvjFFh+KDzdP98Uqk0kdKDHk
	 nQRLtxNYwgew8BikWj0LlfpUi22U9cTqnyw6LU5s9ifMXb7gm+c+6MbSYVM/7lfGoi
	 1FHadxvaOeevQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next 7/8] libbpf: add bpf_core_cast() macro
Date: Thu,  4 Jan 2024 16:09:08 -0800
Message-Id: <20240105000909.2818934-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105000909.2818934-1-andrii@kernel.org>
References: <20240105000909.2818934-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_core_cast() macro that wraps bpf_rdonly_cast() kfunc. It's more
ergonomic than kfunc, as it automatically extracts btf_id with
bpf_core_type_id_kernel(), and works with type names. It also casts result
to (T *) pointer. See the definition of the macro, it's self-explanatory.

libbpf declares bpf_rdonly_cast() extern as __weak __ksym and should be
safe to not conflict with other possible declarations in user code.

But we do have a conflict with current BPF selftests that declare their
externs with first argument as `void *obj`, while libbpf opts into more
permissive `const void *obj`. This causes conflict, so we fix up BPF
selftests uses in the same patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_core_read.h                       | 13 +++++++++++++
 tools/testing/selftests/bpf/bpf_kfuncs.h            |  2 +-
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c  |  2 --
 tools/testing/selftests/bpf/progs/type_cast.c       |  4 +---
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 7325a12692a3..4fdb7a7320d6 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -2,6 +2,8 @@
 #ifndef __BPF_CORE_READ_H__
 #define __BPF_CORE_READ_H__
 
+#include <bpf/bpf_helpers.h>
+
 /*
  * enum bpf_field_info_kind is passed as a second argument into
  * __builtin_preserve_field_info() built-in to get a specific aspect of
@@ -292,6 +294,17 @@ enum bpf_enum_value_kind {
 #define bpf_core_read_user_str(dst, sz, src)				    \
 	bpf_probe_read_user_str(dst, sz, (const void *)__builtin_preserve_access_index(src))
 
+extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
+
+/*
+ * Cast provided pointer *ptr* into a pointer to a specified *type* in such
+ * a way that BPF verifier will become aware of associated kernel-side BTF
+ * type. This allows to access members of kernel types directly without the
+ * need to use BPF_CORE_READ() macros.
+ */
+#define bpf_core_cast(ptr, type)					    \
+	((typeof(type) *)bpf_rdonly_cast((ptr), bpf_core_type_id_kernel(type)))
+
 #define ___concat(a, b) a ## b
 #define ___apply(fn, n) ___concat(fn, n)
 #define ___nth(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, __11, N, ...) N
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index b4e78c1eb37b..24dafb289190 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -53,7 +53,7 @@ extern int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 
 void *bpf_cast_to_kern_ctx(void *) __ksym;
 
-void *bpf_rdonly_cast(void *obj, __u32 btf_id) __ksym;
+extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
 
 extern int bpf_get_file_xattr(struct file *file, const char *name,
 			      struct bpf_dynptr *value_ptr) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
index 3e745793b27a..934c4e5ada5b 100644
--- a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -12,8 +12,6 @@ int cookie_found = 0;
 __u64 cookie = 0;
 __u32 omem = 0;
 
-void *bpf_rdonly_cast(void *, __u32) __ksym;
-
 struct {
 	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
diff --git a/tools/testing/selftests/bpf/progs/type_cast.c b/tools/testing/selftests/bpf/progs/type_cast.c
index a9629ac230fd..98ab35893f51 100644
--- a/tools/testing/selftests/bpf/progs/type_cast.c
+++ b/tools/testing/selftests/bpf/progs/type_cast.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_kfuncs.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
@@ -19,9 +20,6 @@ char name[IFNAMSIZ];
 unsigned int inum;
 unsigned int meta_len, frag0_len, kskb_len, kskb2_len;
 
-void *bpf_cast_to_kern_ctx(void *) __ksym;
-void *bpf_rdonly_cast(void *, __u32) __ksym;
-
 SEC("?xdp")
 int md_xdp(struct xdp_md *ctx)
 {
-- 
2.34.1


