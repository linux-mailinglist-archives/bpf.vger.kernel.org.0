Return-Path: <bpf+bounces-38909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D0596C605
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788D4B2343E
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7481E2023;
	Wed,  4 Sep 2024 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TsUC6sKj"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DBC1E2010
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473345; cv=none; b=NgE6qNYe3d6QDhR1dp0XV6vrRy4xykaRmj240oijNTlb8dO9T4blkF4TtZyEmOpVoXjFz5JTHeOAmZI2/V2He8d5n60UE+wWbvbFipJXo2Q54fZgYJRgQInvWC18O62w+qEHlaQ+iiQ/eTsfEIVF7RVdMaReEaRq4jfpcXA3oYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473345; c=relaxed/simple;
	bh=F5yOdf9zTwGmebLp5gH7DHbPlLZfv3nlsNqAJBc/fWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjWp0T/gF4waMSC60e2eQsbIEnT35wkcVni5rv1PSJ98lczZ4oTUfOi5joRK+GFKp2DjKyCYH5DDGjS6gnT13i1l3TiO5wt2MGFNLMKsZPEAlk7P6Xm7UGCjNFCoLWLF2+OR8asXowdqt2Ml606g0nqPVMXBCoBJXe+DNlDljLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TsUC6sKj; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725473341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7j+FLh348YTVBARok+VzLPr4UqqfaHuShgQe8+S5cuo=;
	b=TsUC6sKjtFPmlBtqcNWds26DTreyqbh5rp6NyuTUSvnO/ottdAEHNkpb7RZFIA2/XMUf5g
	7PxUc3vJXQDs/0Vpmdpp/uCYNhFnRpXBqsADbcjis6btQO4rNLOa5GJ6mBhoTSGVRnhQAS
	4+IWgpMcW2/i2Bbmcf7S0F+bcu46zYg=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next 2/2] bpf: Fix indentation issue in epilogue_idx
Date: Wed,  4 Sep 2024 11:08:45 -0700
Message-ID: <20240904180847.56947-3-martin.lau@linux.dev>
In-Reply-To: <20240904180847.56947-1-martin.lau@linux.dev>
References: <20240904180847.56947-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

There is a report on new indentation issue in epilogue_idx.
This patch fixed it.

Fixes: 169c31761c8d ("bpf: Add gen_epilogue to bpf_verifier_ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408311622.4GzlzN33-lkp@intel.com/
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8bfb14d1eb7a..b806afeba212 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19800,7 +19800,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				 * least one ctx ptr saving insn before the
 				 * epilogue.
 				 */
-				 epilogue_idx = i + delta;
+				epilogue_idx = i + delta;
 			}
 			goto patch_insn_buf;
 		} else {
-- 
2.43.5


