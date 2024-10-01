Return-Path: <bpf+bounces-40638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E895D98B2DD
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 05:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E6A1F23988
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 03:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D341A1B0125;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB7UsrcP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388D1AFB29;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727754926; cv=none; b=hWUy2qxGXvrmHxHcC5bgkOBG2v2oVhyiAG4Gm2EJW8UYnR3HExDAVnM1CNksOzyZe96Q/swrgnSFWrtu7+1kVXykxLy7lWCszE0hy2fMrsA8yB4LdfzjyvsA/mjO+/j8Ah+vmGiWKgDSOBNo73BVLxLlHtq9Cy8Dk35JqR0d9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727754926; c=relaxed/simple;
	bh=+SL4iD42TElvYHd+Fi83SbrkqmPXI/D9XApoWLsNksM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLlMh4zGgXuVV2GKYNq3nXZgsYfQTZNKGmOphHGBghd47eplSiT5yCcYDtwpz7Fd0YYRsBXb7nCyw1BAjpUmNzciSjMZVOTcoD3eSLBNTmO4YLzhgb117CROTtVL3EPXn5mZlqlfeb0df9B0o60g7dCnnmowjslyLAdAJBrL6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB7UsrcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D23FC4CECF;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727754926;
	bh=+SL4iD42TElvYHd+Fi83SbrkqmPXI/D9XApoWLsNksM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BB7UsrcP83M9ng6GvIP0GXt8XZd4/ua3+84rCX9ynGFq+H6ByCozlWIrVIzfzfLli
	 JJ7jtrggACJRVQdzq/4p+lc/DahkzJXKjg9Fr0oUudX/0kbZJ/6DoiNES9wVU4vZwH
	 eNVwbHr6U4KShbhY57TT+iUxlGy8Pkc/ej3DZdZeLVcKoxCYfG0WpZ2clt9N5EUd3s
	 M/WK0Glv29UMBHU/mBCnk4kAtdkBQxn4gy3shQOH7z/3X9YfkE1YzGwb5Q4157Y4Lt
	 3AUMVyUhnPy/JwusJoBNJ56rzhGTImRj1SIMA6fbzP0l26sVWdSCO6Eb9QMXBlDd1m
	 ak3zqPuLIntMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DF9CEB2E4;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Date: Tue, 01 Oct 2024 11:55:22 +0800
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: test linking with duplicate
 extern functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-libbpf-dup-extern-funcs-v3-2-42f7774efbf3@hack3r.moe>
References: <20241001-libbpf-dup-extern-funcs-v3-0-42f7774efbf3@hack3r.moe>
In-Reply-To: <20241001-libbpf-dup-extern-funcs-v3-0-42f7774efbf3@hack3r.moe>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3710; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=lBW/ZkssutZzZs0+icq0x4wdMAyMMqQZLN7YcP9oJJs=;
 b=owGbwMvMwCUWYb/agfVY0D7G02pJDGm/i9b8Wm/+2/V0QO/tHyEnru/S2vh//3HOt7NnfOCcc
 07F0TWzraOUhUGMi0FWTJFly+E/agn63ZuWcM8ph5nDygQyhIGLUwAmwqTJ8FdUrfmGVK+7a2Xy
 12XbTJ5Mc1jhMO+M1+bd79+0mF8wyeNlZFjdl/TAP6z4VIPkBwUXa58ZjzdEznWfd37DTpOZZve
 u7GUCAA==
X-Developer-Key: i=i@hack3r.moe; a=openpgp;
 fpr=3A7A1F5A7257780C45A9A147E1487564916D3DF5
X-Endpoint-Received: by B4 Relay for i@hack3r.moe/default with auth_id=225
X-Original-From: Eric Long <i@hack3r.moe>
Reply-To: i@hack3r.moe

From: Eric Long <i@hack3r.moe>

Previously when multiple BPF object files referencing the same extern
function (usually kfunc) are statically linked using `bpftool gen
object`, libbpf tries to get the nonexistent size of BTF_KIND_FUNC_PROTO
and fails. This test ensures it is fixed.

Signed-off-by: Eric Long <i@hack3r.moe>
---
 tools/testing/selftests/bpf/Makefile                  |  3 ++-
 .../selftests/bpf/prog_tests/dup_extern_funcs.c       |  9 +++++++++
 tools/testing/selftests/bpf/progs/dup_extern_funcs1.c | 19 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/dup_extern_funcs2.c | 17 +++++++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e295e3df5ec6c3c21abe368038514cfb34b42f69..644c4dd6002c691a9cd94ef26ddf51f6dc84e2cc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -496,7 +496,7 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
-		test_usdt.skel.h
+		test_usdt.skel.h dup_extern_funcs.skel.h
 
 LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
@@ -520,6 +520,7 @@ test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
 xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
+dup_extern_funcs.skel.h-deps := dup_extern_funcs1.bpf.o dup_extern_funcs2.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/dup_extern_funcs.c b/tools/testing/selftests/bpf/prog_tests/dup_extern_funcs.c
new file mode 100644
index 0000000000000000000000000000000000000000..b26f855745b451f7f53e44b27d47a2f659ad1378
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dup_extern_funcs.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "dup_extern_funcs.skel.h"
+
+void test_dup_extern_funcs(void)
+{
+	RUN_TESTS(dup_extern_funcs);
+}
diff --git a/tools/testing/selftests/bpf/progs/dup_extern_funcs1.c b/tools/testing/selftests/bpf/progs/dup_extern_funcs1.c
new file mode 100644
index 0000000000000000000000000000000000000000..a5b6ea361c3d457d48bc562040f1ef946fadfc81
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dup_extern_funcs1.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+void *bpf_cast_to_kern_ctx(void *obj) __ksym;
+
+SEC("tc")
+int handler1(struct __sk_buff *skb)
+{
+	struct sk_buff *skb_kern = bpf_cast_to_kern_ctx(skb);
+
+	if (!skb_kern)
+		return -1;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/dup_extern_funcs2.c b/tools/testing/selftests/bpf/progs/dup_extern_funcs2.c
new file mode 100644
index 0000000000000000000000000000000000000000..2f9f63dcc6ed2a35e82b55da54356502cfc95c9d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dup_extern_funcs2.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+void *bpf_cast_to_kern_ctx(void *obj) __ksym;
+
+SEC("xdp")
+int handler2(struct xdp_md *xdp)
+{
+	struct xdp_buff *xdp_kern = bpf_cast_to_kern_ctx(xdp);
+
+	if (!xdp_kern)
+		return -1;
+
+	return 0;
+}

-- 
2.46.2



