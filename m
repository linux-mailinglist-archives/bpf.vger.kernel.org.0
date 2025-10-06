Return-Path: <bpf+bounces-70413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A0BBCED8
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 03:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F1B188FFAF
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 01:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E18819E99F;
	Mon,  6 Oct 2025 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWmxpS6c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863779CD
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759713854; cv=none; b=cbc6oj6O5Iq1HfI/kYQVsi8durKZjYRwkgc6xEaaXGBPUHlHdyPZJ0N9kIW6glkH74GgXYsZ8EP+dVl21AW5McYH71rKWhn6tgfZMWKY4UCGoZjMixudrcFuOpy6LHb4wSQGVYHmFf1Shdt/ESH/Xv0EDhNYuINfPIDO9JJYeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759713854; c=relaxed/simple;
	bh=t6viZtyv2RRTRYxqABk36V8Thf+yCYN5LvuShFJ/jpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBH0EHX1Jy5RFuEapt3SHxaaB5Oi7vtIxsGjMhU3I4RFj3lMWsSP02ABLLlB63/MOKbjtNlRM/BMV9lHUYG4UtNr04vDvyoNn5ZEUQ/0Uhb3HcdoStp/rNQJihcM55qGmqLMX3BulL1PtjhXzXdHi3cIU5L2visXrJ+kXYZjNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWmxpS6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8FFC4CEF4;
	Mon,  6 Oct 2025 01:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759713854;
	bh=t6viZtyv2RRTRYxqABk36V8Thf+yCYN5LvuShFJ/jpY=;
	h=From:To:Cc:Subject:Date:From;
	b=aWmxpS6cjBnWqoRu91zyFgMJPpbArG4dX+2D7IBbBwQ+QyNqqCsx0Jj/XnSnZnS4X
	 H8FWheW7tbYbBrPbudU3iFqp5l5y8g8uTC0GOXvm9Kmf9v2s9W9dlyCCLWmqOxdtrB
	 e76qdaazh14cXShdVYwpHnSEtbtpMiFavyKO4seNnkj2D7Rbh6xVKfBI6XPDDYjGMC
	 wx8FL375KMAL6hYj24fejDchJ992yHe2l1y/fzbn9Ec1yg49+zIXHNJwdtX8CJG/jf
	 G+sBlOShbz024Yr3B5cg5nuFMGBk3YabOyPfagJbQHV+GdoKqWfHIJo++yORlcMlap
	 78SbFB04mlLiw==
From: Eric Biggers <ebiggers@kernel.org>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH bpf] libbpf: Fix undefined behavior in {get,put}_unaligned_be32()
Date: Sun,  5 Oct 2025 18:20:37 -0700
Message-ID: <20251006012037.159295-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These violate aliasing rules and may be miscompiled unless
-fno-strict-aliasing is used.  Replace them with the standard memcpy()
solution.  Note that compilers know how to optimize this properly.

Fixes: 4a1c9e544b8d ("libbpf: remove linux/unaligned.h dependency for libbpf_sha256()")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 tools/lib/bpf/libbpf_utils.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
index 5d66bc6ff0982..ac3beae54cf67 100644
--- a/tools/lib/bpf/libbpf_utils.c
+++ b/tools/lib/bpf/libbpf_utils.c
@@ -146,20 +146,24 @@ const char *libbpf_errstr(int err)
 		snprintf(buf, sizeof(buf), "%d", err);
 		return buf;
 	}
 }
 
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wpacked"
-#pragma GCC diagnostic ignored "-Wattributes"
-struct __packed_u32 { __u32 __val; } __attribute__((packed));
-#pragma GCC diagnostic pop
-
-#define get_unaligned_be32(p) be32_to_cpu((((struct __packed_u32 *)(p))->__val))
-#define put_unaligned_be32(v, p) do {							\
-	((struct __packed_u32 *)(p))->__val = cpu_to_be32(v);				\
-} while (0)
+static inline __u32 get_unaligned_be32(const void *p)
+{
+	__be32 val;
+
+	memcpy(&val, p, sizeof(val));
+	return be32_to_cpu(val);
+}
+
+static inline void put_unaligned_be32(__u32 val, void *p)
+{
+	__be32 be_val = cpu_to_be32(val);
+
+	memcpy(p, &be_val, sizeof(be_val));
+}
 
 #define SHA256_BLOCK_LENGTH 64
 #define Ch(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
 #define Maj(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
 #define Sigma_0(x) (ror32((x), 2) ^ ror32((x), 13) ^ ror32((x), 22))

base-commit: de7342228b7343774d6a9981c2ddbfb5e201044b
-- 
2.51.0


