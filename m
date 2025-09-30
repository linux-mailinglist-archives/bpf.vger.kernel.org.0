Return-Path: <bpf+bounces-70061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC2BAE9E2
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 23:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D26D1943C82
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 21:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA83229E110;
	Tue, 30 Sep 2025 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9iOsv1S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A229D281
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267616; cv=none; b=WhmbIef20lc8G6n9wNTN6S4RPKPcSGdrPJOwUAWQa+F4RdQUjqhGewYvm5Jpaoh433ahLlJHHr03p+baroNA2cg195he3fIK3lduQLImwbeXU+7cPeBy0PgE7lDofXNBB83IydvALDsPOZutKvvQGD01fejdKMj4Py30qbl5D1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267616; c=relaxed/simple;
	bh=oSQKg3fojzYq9BBjoX2Mt1mfDcgI0oNow0pVxjWJ4n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iG96wcmNzl+4wUNn658vlDPmLKX9R0qAlNOn3+NpVWkRhr7AeNS7WSd7BMgpVAxTUDwM30Ov9ooC/3i07sAms65XyLXGSqgLK2GipWwLq/5VqrSJCKklwWtXkx03hc8T3UhIpIJsWdM515F75Kng+/6xRNuHvaanMUi42w+QAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9iOsv1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D32C4CEF0;
	Tue, 30 Sep 2025 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759267615;
	bh=oSQKg3fojzYq9BBjoX2Mt1mfDcgI0oNow0pVxjWJ4n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9iOsv1SJ974wj5HPu3zJEqdrbxNuzG57C272gBjYSPzSfMHgBTO2exQqj85Ebqmo
	 irOaR3bET8ULlUm4u3I12LXS4pCpw/Ztz+zICOVoqcATZcYRWnLigUuv9s0EZQ0F5J
	 YDaVR6+5ZgjRWSbBNIKIg3FxLlVAtUHIyzhpaslhFa/X+untLYl0TwpZNSMNEMv3BT
	 2CAkumFp51/UuLe8/rrzzhQnXPnyeBEy6+RwhaiBa0AlA4hQjpH3/Weo7OEAqbZSHZ
	 2DY+ws9KWgyc0brsA0KCkdF9AFuxbPEf0xrGV+kXK6aoN2c7nD7Hycreg9m/goE4Vv
	 kKbPEYESKhLoQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 5/5] libbpf: remove linux/unaligned.h dependency for libbpf_sha256()
Date: Tue, 30 Sep 2025 14:26:19 -0700
Message-ID: <20250930212619.1645410-6-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930212619.1645410-1-andrii@kernel.org>
References: <20250930212619.1645410-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/unaligned.h include dependency is causing issues for libbpf's
Github mirror due to {get,put}_unaligned_be32() usage.

So get rid of it by implementing custom variants of those macros that
will work both in kernel repo and in Github mirror repo.

Also fix switch from round_up() to roundup(), as the former is not
available in Github mirror (and is just a subtle more specific variant
of roundup() anyways).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf_utils.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
index f8290a0b3aaf..4189504fae75 100644
--- a/tools/lib/bpf/libbpf_utils.c
+++ b/tools/lib/bpf/libbpf_utils.c
@@ -13,7 +13,6 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/kernel.h>
-#include <linux/unaligned.h>
 
 #include "libbpf.h"
 #include "libbpf_internal.h"
@@ -149,6 +148,14 @@ const char *libbpf_errstr(int err)
 	}
 }
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpacked"
+struct __packed_u32 { __u32 __val; } __attribute__((packed));
+#pragma GCC diagnostic pop
+
+#define get_unaligned_be32(p) (((struct __packed_u32 *)(p))->__val)
+#define put_unaligned_be32(v, p) do { ((struct __packed_u32 *)(p))->__val = (v); } while (0)
+
 #define SHA256_BLOCK_LENGTH 64
 #define Ch(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
 #define Maj(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
@@ -232,7 +239,7 @@ void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH])
 
 	memcpy(final_data, data + len - final_len, final_len);
 	final_data[final_len] = 0x80;
-	final_len = round_up(final_len + 9, SHA256_BLOCK_LENGTH);
+	final_len = roundup(final_len + 9, SHA256_BLOCK_LENGTH);
 	memcpy(&final_data[final_len - 8], &bitcount, 8);
 
 	sha256_blocks(state, final_data, final_len / SHA256_BLOCK_LENGTH);
-- 
2.47.3


