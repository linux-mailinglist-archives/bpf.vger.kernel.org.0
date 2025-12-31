Return-Path: <bpf+bounces-77644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AEECEC831
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 20:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 394CF300119B
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FA930C611;
	Wed, 31 Dec 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHcmeeIM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A682D94A1
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210742; cv=none; b=q8cam40SWqlmmEwPzWokcytIXzLjw7opUbebLfzhk2NXe8ifGLBdkokj960CCwfxrD8gdmr7IEAj3uxI5/wWwEF8Zo950+RGl15LizLvMheYV2h6Zs3PvkYvNUHX8jjVrhnoXQnDMM6ngVrv/YEmwKe3ORsrx8iRSXaoVl/BnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210742; c=relaxed/simple;
	bh=8gZm8nIXzPpV3IH/xS9Tr5hg1B0HKZek9Y/c8PeXw9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flKz8DFxNawGB/BuGHO5klSGvTgFsZRYWpyQgkou8Znp5unuamm9Etm+jaGx8SJVP7g9ar1blA0Ku0zY/+O8HE/v51Jff/RmZjZSy2M5YkftqPEN5n3YsAQjzLH5ITZuBkU0H3Ha7HJl2mvC/Qx1XoOFBIA0ntILIkVMH45QZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHcmeeIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA372C113D0;
	Wed, 31 Dec 2025 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767210741;
	bh=8gZm8nIXzPpV3IH/xS9Tr5hg1B0HKZek9Y/c8PeXw9k=;
	h=From:To:Cc:Subject:Date:From;
	b=JHcmeeIM3J0YqxtG+Jkr8DrePvb+6rqzY6LaF4lRNIiBjUcCABn1lGnZCrunGzJCa
	 9cbF5a4iim0buGmG2NKxeNi6BM+cx8doYK25le+lltBJjsrCi0ywj/0b4UcsDhsUbr
	 HW6/MALjJFRrb1r9lCLtn4RdqepkifzmrB1NbFweW1Wu+u6QSQ/yx3HXZG/nim6itj
	 /0cxR7gs+9MMRqsfPKoHTZqPyhb6gJGX/hVB+BjoHaCAL10wt2JFvKZibIGGiJGKCY
	 AGKifYsWpZoKBeoDKvqjNNzCStPrLQvPtfvaT4Q2iyX+q3gK6RSHD8MOGDhJKLy9t9
	 ZEqSJeH9r9AhQ==
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
Subject: [PATCH bpf-next] selftests/bpf: veristat: fix printing order in output_stats()
Date: Wed, 31 Dec 2025 11:52:05 -0800
Message-ID: <20251231195207.2801487-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order of the variables in the printf() doesn't match the text and
therefore verfistat prints something like this:

Done. Processed 24 files, 0 programs. Skipped 62 files, 0 programs.

When it should print:

Done. Processed 24 files, 62 programs. Skipped 0 files, 0 programs.

Fix the order of variables in the printf() call.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
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
 

base-commit: 1a8fa7faf4890d201aad4f5d4943f74d840cd0ba
-- 
2.47.3


