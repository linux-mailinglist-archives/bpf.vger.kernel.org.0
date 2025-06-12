Return-Path: <bpf+bounces-60440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F86AD6645
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 05:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB2417C8C7
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00371C7013;
	Thu, 12 Jun 2025 03:50:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF01A3A80
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 03:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700250; cv=none; b=TPUQlACHpBDpc80Y1dwU5cVuB/1PjQnOwN+uWm1ObU647AvbGXT/qWlMtGgiL9ERCQjsOULqnw3aSwH1d1mX99Wznbcz5bs4KgYKA+EkFmXONwFlT/FM2qy7XRhnmzCMCBgfHVEJ4XLOfsf3ii+ROrRIugFFKDJ3W6ZHWn+vEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700250; c=relaxed/simple;
	bh=jXaz8wbgZn548CE6oO4x/9hAeFnwzFzbktNPFUD6coU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLdqf8Nt4d45evt3vgYx+seTm+osr6ZnTszLL+sXwFGsYkrPY+yQpROqDjQIWTb303FrgV9lOhzmKJoDxCN6xRxCM+tErmhtQYbMApQAyCwvNMAzjYB9XW4kiHs7B+GG18ytLOGAaMjpAok5ZqPuEX9vqaU1KeDSnxvyr2sHCUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id ADBAD96FFDB3; Wed, 11 Jun 2025 20:50:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Fix two net related test failures with 64K page size
Date: Wed, 11 Jun 2025 20:50:37 -0700
Message-ID: <20250612035037.2207911-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250612035027.2207299-1-yonghong.song@linux.dev>
References: <20250612035027.2207299-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When running BPF selftests on arm64 with a 64K page size, I encountered
the following two test failures:
  sockmap_basic/sockmap skb_verdict change tail:FAIL
  tc_change_tail:FAIL

With further debugging, I identified the root cause in the following
kernel code within __bpf_skb_change_tail():

    u32 max_len =3D BPF_SKB_MAX_LEN;
    u32 min_len =3D __bpf_skb_min_len(skb);
    int ret;

    if (unlikely(flags || new_len > max_len || new_len < min_len))
        return -EINVAL;

With a 4K page size, new_len =3D 65535 and max_len =3D 16064, the functio=
n
returns -EINVAL. However, With a 64K page size, max_len increases to
261824, allowing execution to proceed further in the function. This is
because BPF_SKB_MAX_LEN scales with the page size and larger page sizes
result in higher max_len values.

Updating the new_len parameter in both tests based on actual kernel
page size resolved both failures.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/test_sockmap_change_tail.c |  9 +++++++--
 .../selftests/bpf/progs/test_tc_change_tail.c      | 14 +++++++-------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c=
 b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
index 2796dd8545eb..1c7941a4ad00 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 ByteDance */
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
=20
+#ifndef PAGE_SIZE
+#define PAGE_SIZE __PAGE_SIZE
+#endif
+#define BPF_SKB_MAX_LEN (PAGE_SIZE << 2)
+
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
 	__uint(max_entries, 1);
@@ -31,7 +36,7 @@ int prog_skb_verdict(struct __sk_buff *skb)
 		change_tail_ret =3D bpf_skb_change_tail(skb, skb->len + 1, 0);
 		return SK_PASS;
 	} else if (data[0] =3D=3D 'E') { /* Error */
-		change_tail_ret =3D bpf_skb_change_tail(skb, 65535, 0);
+		change_tail_ret =3D bpf_skb_change_tail(skb, BPF_SKB_MAX_LEN, 0);
 		return SK_PASS;
 	}
 	return SK_PASS;
diff --git a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c b/to=
ols/testing/selftests/bpf/progs/test_tc_change_tail.c
index 28edafe803f0..fcba8299f0bc 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
-#include <linux/if_ether.h>
-#include <linux/in.h>
-#include <linux/ip.h>
-#include <linux/udp.h>
-#include <linux/pkt_cls.h>
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE __PAGE_SIZE
+#endif
+#define BPF_SKB_MAX_LEN (PAGE_SIZE << 2)
=20
 long change_tail_ret =3D 1;
=20
@@ -94,7 +94,7 @@ int change_tail(struct __sk_buff *skb)
 			bpf_skb_change_tail(skb, len, 0);
 		return TCX_PASS;
 	} else if (payload[0] =3D=3D 'E') { /* Error */
-		change_tail_ret =3D bpf_skb_change_tail(skb, 65535, 0);
+		change_tail_ret =3D bpf_skb_change_tail(skb, BPF_SKB_MAX_LEN, 0);
 		return TCX_PASS;
 	} else if (payload[0] =3D=3D 'Z') { /* Zero */
 		change_tail_ret =3D bpf_skb_change_tail(skb, 0, 0);
--=20
2.47.1


