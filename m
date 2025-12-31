Return-Path: <bpf+bounces-77604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B10CEC560
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 968EC3009A9A
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F929D266;
	Wed, 31 Dec 2025 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9J4c6GT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278FD2882C5
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201106; cv=none; b=E+V2Jjp9dSjHfp7QwAvSDr3c1gk9iEnRVkjYHuwm14JZXGsHpUtcfg46Qu/fYWZeNzqs3CBqUwsZKVebrSPegy8OsxdRNelr4NuFvHW/H76Rp0IQUSmbwbPI486cMzYaIxJUmhJCohFkmtsHIi3a9CSOWZDlIsIx62WTpf5Wdb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201106; c=relaxed/simple;
	bh=GQzEv12LOXpnHCgQb9ASGYk3oo1xNAAwBT9WjWmHmQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sizQDQedMGwfghCAgMUsVZ9qPVhhbytTkh7luQ3dohCQ6yi+w7N6ZQZiBTbgcRs5GoxDsVwAZKCvgNzCswkjT7EiOKpVCMy/AWWtqzXCmEH0ZoZECxQFZIhphoYfkFky/NXWZzlVk8A+8d24GqTrBYB9DiQJsHfnCea9zz5RdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9J4c6GT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B42C113D0;
	Wed, 31 Dec 2025 17:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201105;
	bh=GQzEv12LOXpnHCgQb9ASGYk3oo1xNAAwBT9WjWmHmQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9J4c6GTfYiksAiESlmr8QOnqIga0BLp11QNmJ8PVZNPGY8b50DV7Up0JPLADjYZN
	 8WfU+3Vj7954dOf+lAHz6CURKkpxGCUVT0lt+GnEv4jyv6n4D64PWBnGWchudaLlS9
	 GHr6AWwrKXgpwxiyiDZYxPO35Difq1+W5mBPmAL64gSt2ZvqcrYBiariZfvXyQJDxd
	 HWYnn0FU5QVxwf1BQ5nV3vumnbHhtilbENZBXOno3JX1geD4IHYeKwBE9XtwoZy6+t
	 2hobK7KB1D9uhtVidMAp03Jd4PpPEt50y+9AUVB1U/PvNZ6x90VG7L6yGoHf+xvLJt
	 UhaDg4/QOMNVw==
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
Subject: [PATCH bpf-next v2 4/9] selftests: bpf: Update kfunc_param_nullable test for new error message
Date: Wed, 31 Dec 2025 09:08:50 -0800
Message-ID: <20251231171118.1174007-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231171118.1174007-1-puranjay@kernel.org>
References: <20251231171118.1174007-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With trusted args now being the default, the NULL pointer check runs
before type-specific validation. Update test3 to expect the new error
message "Possibly NULL pointer passed to trusted arg0" instead of the
old dynptr-specific error message.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
index 0ad1bf1ede8d..967081bbcfe1 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
@@ -29,7 +29,7 @@ int kfunc_dynptr_nullable_test2(struct __sk_buff *skb)
 }
 
 SEC("tc")
-__failure __msg("expected pointer to stack or const struct bpf_dynptr")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int kfunc_dynptr_nullable_test3(struct __sk_buff *skb)
 {
 	struct bpf_dynptr data;
-- 
2.47.3


