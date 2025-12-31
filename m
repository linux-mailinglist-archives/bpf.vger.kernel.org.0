Return-Path: <bpf+bounces-77650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD16CEC9F3
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 23:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9D5301142D
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 22:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087330EF9A;
	Wed, 31 Dec 2025 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIWuiZZZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E14D8CE
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767219066; cv=none; b=TgXoXlSErZCcTcaUKJrIKYhZHyVgrZ1VH6NTtvbHfUVqKNsEgGj09SQT4TpZzcb2rTIN7Q+60UyBF7RFm64Ipd9MSbB4iVkGQtdCvMg51MKGMccsRTHnFuIlJ8o9v6nmr2+9uGv/fklLebc9yU+9JHGO/vbUIJQFKcnI+TG5zPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767219066; c=relaxed/simple;
	bh=mX3PCtvzpB7sfuSuJZrPBacVXN+3YF8hlreUXE7gyzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sq9BnBz+eAxAsG0SxRphpApB4/WSk9i+aLf0mcjSVWtb9sHkHQVaYqIreXpr0t/IO4S4TOw4mHlwKMnK5xeQiTDW4pxQEAaQPF7saZ9brQ9S7fgDJ5UStfVk6Xlk2PyzFz33YU4Vg9PAnnc6kp+fn3vL1a5UiaMBcLwaORDdLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIWuiZZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7429C113D0;
	Wed, 31 Dec 2025 22:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767219064;
	bh=mX3PCtvzpB7sfuSuJZrPBacVXN+3YF8hlreUXE7gyzI=;
	h=From:To:Cc:Subject:Date:From;
	b=VIWuiZZZKbwycvMnmYE4yjwiKARgSQSMDAaZn5M6Z7VTRQk8eT1SRPQViF2j6kz+0
	 xk+5W7CttyfFV1x9MXwkG3kL7BtSMI9ex9FWJvykj8pa5GCenb0N7wg8fJ9tR1yEx9
	 ckwX52K+m+k+1Mb90A43D8vRV9z+W7Fxe9RbL1UpywvFJdW50v8PWVlC671+I9NOlj
	 SrzSZT3K+Wn0CmdiKgAKkbi3Gh9rax02V5zjOb/hRzw2v81MCAEwXMnJ6OAPUrz1yX
	 e5yOU5XgfB9yPv2AtHvDp7wSCqgxYWKs7uHj+qAXR4kTMNN1vY5cE1y/jkz5TboH8n
	 blKbeyOxQaFqQ==
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
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2] selftests/bpf: veristat: fix printing order in output_stats()
Date: Wed, 31 Dec 2025 14:10:50 -0800
Message-ID: <20251231221052.759396-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order of the variables in the printf() doesn't match the text and
therefore veristat prints something like this:

Done. Processed 24 files, 0 programs. Skipped 62 files, 0 programs.

When it should print:

Done. Processed 24 files, 62 programs. Skipped 0 files, 0 programs.

Fix the order of variables in the printf() call.

Fixes: 518fee8bfaf2 ("selftests/bpf: make veristat skip non-BPF and failing-to-open BPF objects")
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
v1: https://lore.kernel.org/all/20251231195207.2801487-1-puranjay@kernel.org/
Changes in v1->v2:
- Fix typo in commit message.
- Add fixes tag.
---
 tools/testing/selftests/bpf/veristat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index e962f133250c..1be1e353d40a 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -2580,7 +2580,7 @@ static void output_stats(const struct verif_stats *s, enum resfmt fmt, bool last
 	if (last && fmt == RESFMT_TABLE) {
 		output_header_underlines();
 		printf("Done. Processed %d files, %d programs. Skipped %d files, %d programs.\n",
-		       env.files_processed, env.files_skipped, env.progs_processed, env.progs_skipped);
+		       env.files_processed, env.progs_processed, env.files_skipped, env.progs_skipped);
 	}
 }
 

base-commit: 17c736a7b58a18e3683df2583b60f0edeaf65070
-- 
2.47.3


