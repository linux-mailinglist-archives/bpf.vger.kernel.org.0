Return-Path: <bpf+bounces-20779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D316C842E93
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 22:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D2D1C221A1
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1BB762EB;
	Tue, 30 Jan 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMjohPzf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E75D79DD4
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649632; cv=none; b=TWaWK7NHjHlfv/jULK/bylmpw0NXq6NoIyA94p4nw47e5ERhbJ60mRpE3vo5R6G9T+u6PjVBcsWew+Pu4TJn7sJaPcnATR6LZ+YAmYH5k5hSjhVi4qv5ytBILl+OYtSW9VlgYAj6Let89CDk/u5E2vsJFlhmoNx5TWVOWIUFjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649632; c=relaxed/simple;
	bh=7hixQ3nfNsMoVc3gSWwWr5Df6RW3vZbzgIn+WGy78l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwjtH33Uu5ijW31RN76gw6vXCl5QJVKSUMBrssooWz3HLYuYBUznE70379znogi7+/jtyd62OtJtz+OJwlyT9duTA3f0bOH45hGXhRTOWE220miMQvVv3WxFKrn7q0kH7Hzbzd1KGOJ7AqVsQ1ici7LDNyrPsN+xBgRjZGYrcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMjohPzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3234C433C7;
	Tue, 30 Jan 2024 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706649631;
	bh=7hixQ3nfNsMoVc3gSWwWr5Df6RW3vZbzgIn+WGy78l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMjohPzf3Bmht8hK2wbmPbENgX0xdQ0nJigmib1b6dQ/fbVrv+DjLiBBztrD0lyrP
	 Uv2DDvgMeoKqOj3FboRxdoYk+l1OD9s0XlVKx2Qm2yzKAbMp7lpdtVy8SjRBReDEXs
	 tvjNXfjLzv3WVpkYv6gCSzBlYJArSTrqk6/DhnxXtQMDhgVCAygGldOGihTjAm6Dck
	 wZ5gN6DOYHjn/w7WQgpwL76NsXTT0wTSNQqxguTEXcpOyXvTjyjC6tbmVStotGNBOH
	 ZKDg66oxGRmw8DR5z3vD1yx/Op5mgqYMmT7/nCarATwsaND/TieqNi3dGHMm4pYMF1
	 7QhlPesrP3Xdg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] libbpf: add bpf_core_cast() macro
Date: Tue, 30 Jan 2024 13:20:22 -0800
Message-Id: <20240130212023.183765-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130212023.183765-1-andrii@kernel.org>
References: <20240130212023.183765-1-andrii@kernel.org>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_core_read.h                       | 13 +++++++++++++
 tools/testing/selftests/bpf/bpf_kfuncs.h            |  2 +-
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c  |  2 --
 tools/testing/selftests/bpf/progs/type_cast.c       |  4 +---
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 5aec301e9585..0d3e88bd7d5f 100644
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
index 23c24f852f4f..0cd4111f954c 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -63,7 +63,7 @@ extern int bpf_sk_assign_tcp_reqsk(struct __sk_buff *skb, struct sock *sk,
 
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


