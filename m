Return-Path: <bpf+bounces-43415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FD9B5437
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 21:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8565D1F24677
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 20:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072F208239;
	Tue, 29 Oct 2024 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTbd8s/8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FF20823D
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234362; cv=none; b=q8PpLhJAH86jagL6RGFk2mfaIJ1FclR27jfL6ch2VOg91A/w490bM/MsGHd6YJ5zk7u+k24j9Dw7P1uIfCO8kHqdVKQNyjOExd0qIsPdiqof6lfi0pakfxO5H/jDnVqrOOvdMnhlZ+m85nErPwB46OaqUGW400RkWZgc8kthnRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234362; c=relaxed/simple;
	bh=4tfJ6A+QzykPWdYcE5zdmRddvo+zwvPTMXUjE/N9OTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TinrteWdTTvshzUNGreAKJ5NGYveQsSZWGO0gf+Glx7FNe3XsaiXQkqDAed3shsc6rGW6JH44ZeX/3Hsk4cpvlDCD8Xmo1xDvTaBArx3swM6LVayhX6/7luCbtmGBA1qwjIEPlHNuvuchvyY1UTGp1+WOQun+7B6f1ODwPSU3s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTbd8s/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12351C4CECD;
	Tue, 29 Oct 2024 20:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730234362;
	bh=4tfJ6A+QzykPWdYcE5zdmRddvo+zwvPTMXUjE/N9OTs=;
	h=From:To:Cc:Subject:Date:From;
	b=eTbd8s/8Pl4E3jGWD5TfBGVlp9ZwU76YCP0HBA1PIzE2S19Dfg5aNGj+RODMxnGcV
	 yK6cvJzMWHIhCWxJQeDB/1wgNwG8sgiEvSN4vNsqDOyos86+27uY38KSgW7W0wGvMi
	 EBsOIxD8Gp4VLWgmvSxFbKeSKDFDWQqJKeZf5fHatIGsGWODGvlLAnJ56tfOEvwlg2
	 GUwL+C1yAmgIL/PVy1NFAHdK8+QExztVhdYI242yr6nC1haotcgo5QH4Nd6VrTYu47
	 j8PXIR8H1xl5ui1tNqBvHJ9ICcBqPTI/vOQELfeItshGTRaufMQWZ0Iihr5gK04dY8
	 jLyPnLqQwW0sA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: drop unnecessary bpf_iter.h type duplication
Date: Tue, 29 Oct 2024 13:39:19 -0700
Message-ID: <20241029203919.1948941-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop bpf_iter.h header which uses vmlinux.h but re-defines a bunch of
iterator structures and some of BPF constants for use in BPF iterator
selftests.

None of that is necessary when fresh vmlinux.h header is generated for
vmlinux image that matches latest selftests. So drop ugly hacks and have
a nice plain vmlinux.h usage everywhere.

We could do the same with all the kfunc __ksym redefinitions, but that
has dependency on very fresh pahole, so I'm not addressing that here.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_iter.h  | 174 ------------------
 .../bpf/progs/bpf_iter_bpf_array_map.c        |   2 +-
 .../bpf/progs/bpf_iter_bpf_hash_map.c         |   2 +-
 .../selftests/bpf/progs/bpf_iter_bpf_link.c   |   2 +-
 .../selftests/bpf/progs/bpf_iter_bpf_map.c    |   2 +-
 .../bpf/progs/bpf_iter_bpf_percpu_array_map.c |   2 +-
 .../bpf/progs/bpf_iter_bpf_percpu_hash_map.c  |   2 +-
 .../progs/bpf_iter_bpf_sk_storage_helpers.c   |   2 +-
 .../bpf/progs/bpf_iter_bpf_sk_storage_map.c   |   2 +-
 .../selftests/bpf/progs/bpf_iter_ipv6_route.c |   2 +-
 .../selftests/bpf/progs/bpf_iter_ksym.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_netlink.c    |   2 +-
 .../selftests/bpf/progs/bpf_iter_setsockopt.c |   2 +-
 .../bpf/progs/bpf_iter_setsockopt_unix.c      |   2 +-
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_btf.c   |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_file.c  |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_stack.c |   2 +-
 .../selftests/bpf/progs/bpf_iter_task_vmas.c  |   2 +-
 .../selftests/bpf/progs/bpf_iter_tasks.c      |   2 +-
 .../selftests/bpf/progs/bpf_iter_tcp4.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_tcp6.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern3.c |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern4.c |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern5.c |   2 +-
 .../selftests/bpf/progs/bpf_iter_test_kern6.c |   2 +-
 .../bpf/progs/bpf_iter_test_kern_common.h     |   2 +-
 .../selftests/bpf/progs/bpf_iter_udp4.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_udp6.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_unix.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_vma_offset.c |   2 +-
 .../testing/selftests/bpf/progs/cgroup_iter.c |   3 +-
 .../selftests/bpf/progs/cgrp_ls_sleepable.c   |   3 +-
 .../selftests/bpf/progs/kmem_cache_iter.c     |   3 +-
 34 files changed, 33 insertions(+), 210 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/bpf_iter.h

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
deleted file mode 100644
index 3305dc3a74b3..000000000000
--- a/tools/testing/selftests/bpf/progs/bpf_iter.h
+++ /dev/null
@@ -1,174 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2020 Facebook */
-/* "undefine" structs in vmlinux.h, because we "override" them below */
-#define bpf_iter_meta bpf_iter_meta___not_used
-#define bpf_iter__bpf_map bpf_iter__bpf_map___not_used
-#define bpf_iter__ipv6_route bpf_iter__ipv6_route___not_used
-#define bpf_iter__netlink bpf_iter__netlink___not_used
-#define bpf_iter__task bpf_iter__task___not_used
-#define bpf_iter__task_file bpf_iter__task_file___not_used
-#define bpf_iter__task_vma bpf_iter__task_vma___not_used
-#define bpf_iter__tcp bpf_iter__tcp___not_used
-#define tcp6_sock tcp6_sock___not_used
-#define bpf_iter__udp bpf_iter__udp___not_used
-#define udp6_sock udp6_sock___not_used
-#define bpf_iter__unix bpf_iter__unix___not_used
-#define bpf_iter__bpf_map_elem bpf_iter__bpf_map_elem___not_used
-#define bpf_iter__bpf_sk_storage_map bpf_iter__bpf_sk_storage_map___not_used
-#define bpf_iter__sockmap bpf_iter__sockmap___not_used
-#define bpf_iter__bpf_link bpf_iter__bpf_link___not_used
-#define bpf_iter__cgroup bpf_iter__cgroup___not_used
-#define btf_ptr btf_ptr___not_used
-#define BTF_F_COMPACT BTF_F_COMPACT___not_used
-#define BTF_F_NONAME BTF_F_NONAME___not_used
-#define BTF_F_PTR_RAW BTF_F_PTR_RAW___not_used
-#define BTF_F_ZERO BTF_F_ZERO___not_used
-#define bpf_iter__ksym bpf_iter__ksym___not_used
-#define bpf_iter__kmem_cache bpf_iter__kmem_cache___not_used
-#include "vmlinux.h"
-#undef bpf_iter_meta
-#undef bpf_iter__bpf_map
-#undef bpf_iter__ipv6_route
-#undef bpf_iter__netlink
-#undef bpf_iter__task
-#undef bpf_iter__task_file
-#undef bpf_iter__task_vma
-#undef bpf_iter__tcp
-#undef tcp6_sock
-#undef bpf_iter__udp
-#undef udp6_sock
-#undef bpf_iter__unix
-#undef bpf_iter__bpf_map_elem
-#undef bpf_iter__bpf_sk_storage_map
-#undef bpf_iter__sockmap
-#undef bpf_iter__bpf_link
-#undef bpf_iter__cgroup
-#undef btf_ptr
-#undef BTF_F_COMPACT
-#undef BTF_F_NONAME
-#undef BTF_F_PTR_RAW
-#undef BTF_F_ZERO
-#undef bpf_iter__ksym
-#undef bpf_iter__kmem_cache
-
-struct bpf_iter_meta {
-	struct seq_file *seq;
-	__u64 session_id;
-	__u64 seq_num;
-} __attribute__((preserve_access_index));
-
-struct bpf_iter__ipv6_route {
-	struct bpf_iter_meta *meta;
-	struct fib6_info *rt;
-} __attribute__((preserve_access_index));
-
-struct bpf_iter__netlink {
-	struct bpf_iter_meta *meta;
-	struct netlink_sock *sk;
-} __attribute__((preserve_access_index));
-
-struct bpf_iter__task {
-	struct bpf_iter_meta *meta;
-	struct task_struct *task;
-} __attribute__((preserve_access_index));
-
-struct bpf_iter__task_file {
-	struct bpf_iter_meta *meta;
-	struct task_struct *task;
-	__u32 fd;
-	struct file *file;
-} __attribute__((preserve_access_index));
-
-struct bpf_iter__task_vma {
-	struct bpf_iter_meta *meta;
-	struct task_struct *task;
-	struct vm_area_struct *vma;
-} __attribute__((preserve_access_index));
-
-struct bpf_iter__bpf_map {
-	struct bpf_iter_meta *meta;
-	struct bpf_map *map;
-} __attribute__((preserve_access_index));
-
-struct bpf_iter__tcp {
-	struct bpf_iter_meta *meta;
-	struct sock_common *sk_common;
-	uid_t uid;
-} __attribute__((preserve_access_index));
-
-struct tcp6_sock {
-	struct tcp_sock	tcp;
-	struct ipv6_pinfo inet6;
-} __attribute__((preserve_access_index));
-
-struct bpf_iter__udp {
-	struct bpf_iter_meta *meta;
-	struct udp_sock *udp_sk;
-	uid_t uid __attribute__((aligned(8)));
-	int bucket __attribute__((aligned(8)));
-} __attribute__((preserve_access_index));
-
-struct udp6_sock {
-	struct udp_sock	udp;
-	struct ipv6_pinfo inet6;
-} __attribute__((preserve_access_index));
-
-struct bpf_iter__unix {
-	struct bpf_iter_meta *meta;
-	struct unix_sock *unix_sk;
-	uid_t uid;
-} __attribute__((preserve_access_index));
-
-struct bpf_iter__bpf_map_elem {
-	struct bpf_iter_meta *meta;
-	struct bpf_map *map;
-	void *key;
-	void *value;
-};
-
-struct bpf_iter__bpf_sk_storage_map {
-	struct bpf_iter_meta *meta;
-	struct bpf_map *map;
-	struct sock *sk;
-	void *value;
-};
-
-struct bpf_iter__sockmap {
-	struct bpf_iter_meta *meta;
-	struct bpf_map *map;
-	void *key;
-	struct sock *sk;
-};
-
-struct bpf_iter__bpf_link {
-	struct bpf_iter_meta *meta;
-	struct bpf_link *link;
-};
-
-struct bpf_iter__cgroup {
-	struct bpf_iter_meta *meta;
-	struct cgroup *cgroup;
-} __attribute__((preserve_access_index));
-
-struct btf_ptr {
-	void *ptr;
-	__u32 type_id;
-	__u32 flags;
-};
-
-enum {
-	BTF_F_COMPACT	=	(1ULL << 0),
-	BTF_F_NONAME	=	(1ULL << 1),
-	BTF_F_PTR_RAW	=	(1ULL << 2),
-	BTF_F_ZERO	=	(1ULL << 3),
-};
-
-struct bpf_iter__ksym {
-	struct bpf_iter_meta *meta;
-	struct kallsym_iter *ksym;
-};
-
-struct bpf_iter__kmem_cache {
-	struct bpf_iter_meta *meta;
-	struct kmem_cache *s;
-} __attribute__((preserve_access_index));
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
index 564835ba7d51..19710cc0f250 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c
index d7a69217fb68..f47da665f7e0 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
index e1af2f8f75a6..7b69e1887705 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Red Hat, Inc. */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c
index 6c39e86b666f..c868ffb8080f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
index 9f0e0705b2bf..9fdea8cd4c6f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_array_map.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_hash_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_hash_map.c
index 5014a17d6c02..aa529f76c7fc 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_hash_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_percpu_hash_map.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
index 6cecab2b32ba..e88dab196e0f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_helpers.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Google LLC. */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
index c7b8e006b171..eb9642923e1c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ipv6_route.c b/tools/testing/selftests/bpf/progs/bpf_iter_ipv6_route.c
index 784a610ce039..73a5cf3ba3d3 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_ipv6_route.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_ipv6_route.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
index 521267818f4d..3e725b1fce37 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022, Oracle and/or its affiliates. */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
index a28e51e2dcee..00b2ceae81fb 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
index ec7f91850dec..774d4dbe8189 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt_unix.c
index eafc877ea460..d92631ec6161 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt_unix.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_setsockopt_unix.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright Amazon.com Inc. or its affiliates. */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
index f3af0e30cead..317fe49760cc 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Cloudflare */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_btf.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_btf.c
index bca8b889cb10..ef2f7c8d9373 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_btf.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_btf.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020, Oracle and/or its affiliates. */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
index b0255080662d..959a8d899eaf 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
index 442f4ca39fd7..f5a309455490 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
index 423b39e60b6f..d64ba7ddaed5 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
index 6cbb3393f243..bc10c4e4b4fa 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
index 92267abb462f..d22449c69363 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
index 943f7bba180e..8b072666f9d9 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern3.c b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern3.c
index 2a4647f20c46..6b17e7e86a48 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern3.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern4.c b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern4.c
index dbf61c44acac..56177508798f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern4.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern5.c b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern5.c
index e3a7575e81d2..9d8b7310d2c2 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern5.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern5.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c
index 1c7304f56b1e..b150bd468824 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern_common.h b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern_common.h
index d5e3df66ad9a..6a4c50497c5e 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern_common.h
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern_common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
index cf0c485b1ed7..ffbd4b116d17 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
index 5031e21c433f..47ff7754f4fd 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
index e6aefae38894..fea275df9e22 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright Amazon.com Inc. or its affiliates. */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c b/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
index ee7455d2623a..174298e122d3 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter.c b/tools/testing/selftests/bpf/progs/cgroup_iter.c
index de03997322a7..f30841997a8d 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_iter.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_iter.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Google */
-
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
index 5e282c16eadc..a2de95f85648 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
-
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
diff --git a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
index 72c9dafecd98..e775d5cd99fc 100644
--- a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Google */
-
-#include "bpf_iter.h"
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-- 
2.43.5


