Return-Path: <bpf+bounces-70122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C01BB1555
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 19:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FF94A76F3
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494192D29AC;
	Wed,  1 Oct 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqoOr0+/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFA2441A0
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338825; cv=none; b=ICJdl1f8ZhRo2V3D4nU6FBlsI681JcB4KQsJS2qPR/1tIUMvOiwZdEbJNujfRPCJU0/FVkArHYPs8bmj4Aro0YRSfSWy6nfiWxqd2WKG4R3hI1UHqDNEHWOzN3Sl41rKzsaKQPwth/B6BIFhQonQvQZkwVap6PcoYRYjmY4Fd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338825; c=relaxed/simple;
	bh=T2f800xHlrxKh2IrJtp5EiKGHyYHjQxf1r9BRvkOe4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbC+7VsCpJAzckUYO+59OUq1ll9Y8ytQhSo0S0dDHZ3IeCIzrOuwSGGCxrXoJC46VDRVNjNXUZVq+jA7IgmRNvWf8T7ECw72tLy3TC5S+QUNtsoJeUdCtTCmy+IB/lCBIakEce8NmJUnO60fne4BF2p9r98Y6sgDAjkixOXgZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqoOr0+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C688C4CEF1;
	Wed,  1 Oct 2025 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759338825;
	bh=T2f800xHlrxKh2IrJtp5EiKGHyYHjQxf1r9BRvkOe4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cqoOr0+/xG+Irfe/7SH6tvycJvisSE2PndYBZUafxZp187JyzRQ5hWVMXKCkN6d3g
	 98GaLkbPMCASuwBJlufPHLO2gIdhQvJjAz8jgCGUJTbFLplTqJvQLPTI3VXPRPf8rC
	 We4ctCB2v3MqW7deixOmGZW1fxrVCKhmxnVXW6r9eUM/rcDALVlwQj8sIqOLHGyGH4
	 oOLj7WnXsUaSZvl+tG1cuVoAjnX1NIbWEMS5CjSqySv7okEIokf3KSOJTbe2WjGnUw
	 tc00BC7W/8h+NtJlffxV5VSwa0jqwmjpdzhBfvOKZIFcrOue96vGAjFP2byu4RlFwq
	 F2gko1Ps3ByLQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf 5/5] libbpf: remove linux/unaligned.h dependency for libbpf_sha256()
Date: Wed,  1 Oct 2025 10:13:26 -0700
Message-ID: <20251001171326.3883055-6-andrii@kernel.org>
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

linux/unaligned.h include dependency is causing issues for libbpf's
Github mirror due to {get,put}_unaligned_be32() usage.

So get rid of it by implementing custom variants of those macros that
will work both in kernel and Github mirror repos.

Also switch round_up() to roundup(), as the former is not available in
Github mirror (and is just a subtly more specific variant of roundup()
anyways).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf_utils.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf_utils.c b/tools/lib/bpf/libbpf_utils.c
index f8290a0b3aaf..2bae8cafc077 100644
--- a/tools/lib/bpf/libbpf_utils.c
+++ b/tools/lib/bpf/libbpf_utils.c
@@ -13,7 +13,6 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/kernel.h>
-#include <linux/unaligned.h>
 
 #include "libbpf.h"
 #include "libbpf_internal.h"
@@ -149,6 +148,16 @@ const char *libbpf_errstr(int err)
 	}
 }
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpacked"
+struct __packed_u32 { __u32 __val; } __attribute__((packed));
+#pragma GCC diagnostic pop
+
+#define get_unaligned_be32(p) be32_to_cpu((((struct __packed_u32 *)(p))->__val))
+#define put_unaligned_be32(v, p) do {							\
+	((struct __packed_u32 *)(p))->__val = cpu_to_be32(v);				\
+} while (0)
+
 #define SHA256_BLOCK_LENGTH 64
 #define Ch(x, y, z) (((x) & (y)) ^ (~(x) & (z)))
 #define Maj(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
@@ -232,7 +241,7 @@ void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH])
 
 	memcpy(final_data, data + len - final_len, final_len);
 	final_data[final_len] = 0x80;
-	final_len = round_up(final_len + 9, SHA256_BLOCK_LENGTH);
+	final_len = roundup(final_len + 9, SHA256_BLOCK_LENGTH);
 	memcpy(&final_data[final_len - 8], &bitcount, 8);
 
 	sha256_blocks(state, final_data, final_len / SHA256_BLOCK_LENGTH);
-- 
2.47.3


