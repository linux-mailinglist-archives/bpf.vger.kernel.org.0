Return-Path: <bpf+bounces-77538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3465DCEA8F2
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 20:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9DE230060F4
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5942E8DEA;
	Tue, 30 Dec 2025 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFTuzrfd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019521CC79
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124320; cv=none; b=AdehfBQZQ+FC4mlggn0LUSKOEsnlYBr/tZ5R9ICW1pf6lM0QpnqAmHAk1E/cKEsCXk3kGYet6xl8XBCuFwUNy/iQyBRAqT0wYtZvNe6qWjgbKKtREJQgvd9gYDtM5DZKVJ6T218eiyx2sctKM1iB/nsiAvi3UHr7TAbV/4yzkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124320; c=relaxed/simple;
	bh=mpQ/UOf+JVY7tpy6EndQEcXRQUwXeMf+uGUdhK5ZaNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0KimHGgH2/RlzRoYthPG4jgn0ICFRfSBdgC7B3+zZIpQOrgyr6Ru98m2XZweUclkihxizV/jmsg0kvRE0hr+RFBDvTqpXf7c2RYVUO5Tk9G7en9MTj1/pd36Kaywlx3Y0Rq+kL/LF4XXlWDkI+QuDhkX+izBKGr73+MBO31DrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFTuzrfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8ACC4CEFB;
	Tue, 30 Dec 2025 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767124319;
	bh=mpQ/UOf+JVY7tpy6EndQEcXRQUwXeMf+uGUdhK5ZaNM=;
	h=From:To:Cc:Subject:Date:From;
	b=NFTuzrfdZhk2ZA349k3BU0qur3PSNOq1mLrRxu7aGrzIE1SgCLiQs+cCWL/qzjQ35
	 QCCAnp27hWMR3kbN5yTpS/CILP+Mz4A5mx5RQ4Cv0I6gQ3YpXNNiz/06GkuuO22oVn
	 rTaNQi/9vI0zrsW2Ssef1KyDVf87pkTaN4qWtP2RTk53TLIVUVQhZ0qn+El+QPqRiS
	 y9iGRayon1Ua+4MRFIEUK71O4Y7d58TlVLPj5VwSrTdxQkJ99cHd4qSkbxdalS0XRc
	 DbTbz4I/DXAdo5p3BEHuCWs9Dq79jSSxgV5S3E4dpMQsBIULt3GdfLv4utYxjDe7zp
	 /spP2XKJHxFlg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests: bpf: fix verifier_arena_large: big_alloc3
Date: Tue, 30 Dec 2025 11:51:32 -0800
Message-ID: <20251230195134.599463-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The big_alloc3() test tries to allocate 2051 pages at once in
non-sleepable context and this can fail sporadically on resource
contrained systems, so skip this test in case of such failures.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_arena_large.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 4ca491cbe8d1..5f7e7afee169 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -300,7 +300,7 @@ int big_alloc3(void *ctx)
 	 */
 	pages = bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE, 0);
 	if (!pages)
-		return -1;
+		return 0;
 
 	bpf_for(i, 0, 2051)
 			pages[i * PAGE_SIZE] = 123;

base-commit: 600605853f87a4b1c3530a63f78a3541633402b0
-- 
2.47.3


