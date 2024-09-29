Return-Path: <bpf+bounces-40487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250F298948A
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 11:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB9BB2590D
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 09:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269914AD20;
	Sun, 29 Sep 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzKjfzaB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A9224F0;
	Sun, 29 Sep 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727602278; cv=none; b=OZQ2iuzTESYqkNUP9cVI5YQBhN3J1Nwpk4kE9bYGhsbiQsDsZ6eGvvWi1ixstCZVy987hG7MwBs27Hw7tvJZhQfL15WV6sFO919Yh0+NTZRcnrFrWZXB+brSUGVF78aJGTVTGehsdBgg8WEbf7EmyeS/qzfC22NE3SvWMtfvXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727602278; c=relaxed/simple;
	bh=uacsQ/Wk7pWbwC6Lw38VvY6F4rtZM4EvO3CycqJmmQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VefPVCWPAoJWOOX4NxiZkU41jrfE2bEAoeJADOIwTCMoEpyYNxdCx9Z9ehSuijZtUoBC8BgJhEMSZACZrXEzvwj6HRTYp5/QvzrcNA+A8+3ueEiDyrclGV0YczO+B2DoI12LRNsR8xW/AiEW/jZRrGchTPaQPCrWJtXMVUoAFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzKjfzaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E5F6C4CEC7;
	Sun, 29 Sep 2024 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727602278;
	bh=uacsQ/Wk7pWbwC6Lw38VvY6F4rtZM4EvO3CycqJmmQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OzKjfzaBqEFt+nsZ/xQQnH6V1fSFZyMp+b5tfKlNKaVysN9Q9hCn3ulwsmaZ38f6x
	 svbxHPzAA3+9JNLf9ZN0IKXUd8bBZWTPA8fQIwPDEowamS3FMf8pEsq23lr4WUACu9
	 +Chi/O+HGd3eC5IpAO9s+7ScYrvPlNX5IAHTCuG/nFYekuPT7dPZXhQY4flB0h4bSD
	 wVJa6NBUPpoNftjp99WZFiG8g/1j/cU7Y0th9m+NrwW0zt96wadk+cnVK2Fl5wnKZJ
	 GnXDlMyJp0lHbauTlAHqD305COOm4q/40n3qNpjRioNCq5CPIqpJ9gUIhHfyIOEI/Z
	 45PKki7gT2/OQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797ACF6497;
	Sun, 29 Sep 2024 09:31:18 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Date: Sun, 29 Sep 2024 17:31:15 +0800
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: make sure linking objects
 with duplicate extern functions doesn't fail
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-libbpf-dup-extern-funcs-v2-2-0cc81de3f79f@hack3r.moe>
References: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe>
In-Reply-To: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3770; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=Hww+IY99Jvgbtqt0tYLYI8/UdyT0Cd78O9SVglyM2YM=;
 b=owGbwMvMwCUWYb/agfVY0D7G02pJDGk/5VKnPdIy9koRPHK/2LZgprpRPB/vvSsr2LIk4oRay
 lL0b0l0lLIwiHExyIopsmw5/EctQb970xLuOeUwc1iZQIYwcHEKwERO72Zk+CH0WuWwFVtj+IqX
 jRcW8F2LuWr9JiRVdGfGwz2Skwv36TIyPK35xfsrnzliRrlOXOOcGjYPyZnr/xVGvE6zYf/+YKE
 CAwA=
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
 tools/testing/selftests/bpf/Makefile                 |  3 ++-
 .../selftests/bpf/prog_tests/dup_extern_funcs.c      |  9 +++++++++
 .../testing/selftests/bpf/progs/dup_extern_funcs1.c  | 20 ++++++++++++++++++++
 .../testing/selftests/bpf/progs/dup_extern_funcs2.c  | 18 ++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

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
index 0000000000000000000000000000000000000000..6850e01d1455c0a2da947ad6d5b1c5dab0187e00
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dup_extern_funcs1.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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
index 0000000000000000000000000000000000000000..66ba3620274497cc40f8dfbb8d98856d4eab707e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/dup_extern_funcs2.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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



