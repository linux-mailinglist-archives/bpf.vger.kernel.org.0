Return-Path: <bpf+bounces-27429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 527958ACFD7
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 16:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDBD281FE0
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1C715217C;
	Mon, 22 Apr 2024 14:46:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A622AD2D;
	Mon, 22 Apr 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797201; cv=none; b=oyAUQE8P0lUyPKtujxPrrKQ5UMqo6lkKPglommEiLGBRWJ8bBs2uMMQ05zwf+ewbZNR3J2iGC59o+4MzAMsOjBQY6uSP3bvcZOIV7jbjwqzkYnEo2UvC/o1LKu2QHw2uNf1M89+jdUEMugsXYYXa2avaZLONRLapw4xF6yDNUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797201; c=relaxed/simple;
	bh=+ccZMQEyECnDTzOEYkMu51PNfRvE6Mdi7esLtHCxzyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HP0VzpooJEvVgv0gtZLYca3tzvvPCTDblktBJSOp9FPUKWUEiH+UVnkJmHCMyGi1w6+Z39RJxWc1g5/lrutwRtu9MdDdexYmRcIijmZI83zL1APLo6rZkbPECD0U48Xlb9Z9x47HsQWT1XXtPpxeNxUovmCDMoWVQaRXQ618+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VNSj74tLfzcbZX;
	Mon, 22 Apr 2024 22:45:31 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (unknown [7.185.36.155])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CEEC180072;
	Mon, 22 Apr 2024 22:46:35 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 22:46:34 +0800
From: Xin Liu <liuxin350@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
	<zhangmingyi5@huawei.com>, <liwei883@huawei.com>, <liuxin350@huawei.com>
Subject: [PATCH] libbpf: extending BTF_KIND_INIT to accommodate some unusual types
Date: Mon, 22 Apr 2024 22:45:38 +0800
Message-ID: <20240422144538.351722-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500010.china.huawei.com (7.185.36.155)

In btf__add_int, the size of the new btf_kind_int type is limited.
When the size is greater than 16, btf__add_int fails to be added
and -EINVAL is returned. This is usually effective.

However, when the built-in type __builtin_aarch64_simd_xi in the
NEON instruction is used in the code in the arm64 system, the value
of DW_AT_byte_size is 64. This causes btf__add_int to fail to
properly add btf information to it.

like this:
  ...
   <1><cf>: Abbrev Number: 2 (DW_TAG_base_type)
    <d0>   DW_AT_byte_size   : 64              // over max size 16
    <d1>   DW_AT_encoding    : 5        (signed)
    <d2>   DW_AT_name        : (indirect string, offset: 0x53): __builtin_aarch64_simd_xi
   <1><d6>: Abbrev Number: 0
  ...

An easier way to solve this problem is to treat it as a base type
and set byte_size to 64. This patch is modified along these lines.

Fixes: 4a3b33f8579a ("libbpf: Add BTF writing APIs")
Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 2d0840ef599a..0af121293b65 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1934,7 +1934,7 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
 	if (!name || !name[0])
 		return libbpf_err(-EINVAL);
 	/* byte_sz must be power of 2 */
-	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
+	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 64)
 		return libbpf_err(-EINVAL);
 	if (encoding & ~(BTF_INT_SIGNED | BTF_INT_CHAR | BTF_INT_BOOL))
 		return libbpf_err(-EINVAL);
-- 
2.33.0


