Return-Path: <bpf+bounces-60353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAC9AD5CE7
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BECB17B2B4
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F484153598;
	Wed, 11 Jun 2025 17:15:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B0137C37
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662145; cv=none; b=H1WJsmTVYK/pQCrvjiSyGJXScsH2kh3zzJFhoBu4l4Ez7VwqeePNmGMkPc4qMYe6d13tnC0uhXAY5UfuHykgA5UcOO9huji7LcDqCgHku0lcmr3CVs2hkFaHdwk2A2Gb/EdvUbXMH6girJSNofJtdgYqwCLL+pKaJKUiw4qhaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662145; c=relaxed/simple;
	bh=jLp9gVJ6J82pb2dajEsxJQ0BNmXZ932mE7BpXCb6MY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qv5p8hJPAywS1NwNCBhUoayN3awlHOs2ggVMu0kPzIkBSH14hvIaARYMb8nkEzENSjCLotoab99Q23TZ5FnukzQICrFiT/80rhuUu15sifa48WTku4pNsCjVIA6yT3TGI0iSY3iHYP0j0stnJfM6VWWDXyVFpi44GhzrLM9Hv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E0EAE9680C54; Wed, 11 Jun 2025 10:15:29 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Fix two net related test failures with 64K page size
Date: Wed, 11 Jun 2025 10:15:29 -0700
Message-ID: <20250611171529.2034330-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611171519.2033193-1-yonghong.song@linux.dev>
References: <20250611171519.2033193-1-yonghong.song@linux.dev>
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

Updating the new_len parameter in both tests from 65535 to 256K (0x40000)
resolves the failures.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c | 5 ++++-
 tools/testing/selftests/bpf/progs/test_tc_change_tail.c      | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c=
 b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
index 2796dd8545eb..e4554ef05441 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
@@ -3,6 +3,9 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
=20
+#define PAGE_SIZE 65536 /* make it work on 64K page arches */
+#define BPF_SKB_MAX_LEN (PAGE_SIZE << 2)
+
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
 	__uint(max_entries, 1);
@@ -31,7 +34,7 @@ int prog_skb_verdict(struct __sk_buff *skb)
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
index 28edafe803f0..47670bbd1766 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
@@ -7,6 +7,9 @@
 #include <linux/udp.h>
 #include <linux/pkt_cls.h>
=20
+#define PAGE_SIZE 65536 /* make it work on 64K page arches */
+#define BPF_SKB_MAX_LEN (PAGE_SIZE << 2)
+
 long change_tail_ret =3D 1;
=20
 static __always_inline struct iphdr *parse_ip_header(struct __sk_buff *s=
kb, int *ip_proto)
@@ -94,7 +97,7 @@ int change_tail(struct __sk_buff *skb)
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


