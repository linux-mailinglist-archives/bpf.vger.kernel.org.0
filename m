Return-Path: <bpf+bounces-77428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C850CDD0AA
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 20:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E7D83038F7A
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 19:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D2343D86;
	Wed, 24 Dec 2025 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmEmkbSf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365D31A541
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766604346; cv=none; b=kPCL8DzEh6vkkmBsnjcaFsw+G86v1yTBjW2LdNu7aKafpgnGCYN5fBFNVL/IrG6w8QZx+aMPloSdc4TpALtKhB368bMeMFoELCBLQO/2WFnB+goF1nvn3XHIYp3xItjko+zT1ttLGBoHBCYykR6tUoNX3rr2cL/qP4v+m9q4Ags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766604346; c=relaxed/simple;
	bh=GQzEv12LOXpnHCgQb9ASGYk3oo1xNAAwBT9WjWmHmQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvjCcZmYe3NctCtIUrd3Z+yETKG21rHtu5F33wDUQS+0rllaOX7B2H9UNLDZnAclcuLJ2XkBHBFCF6RItonUy2di+fbG4LAzK1s5Eag6eHFUMJZm5tX4d08qaRpMNfWV7OOuKM55w7nuqvmUEOdfXpRZHyuuTU0nKe9487hwvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmEmkbSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F385DC4CEF7;
	Wed, 24 Dec 2025 19:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766604343;
	bh=GQzEv12LOXpnHCgQb9ASGYk3oo1xNAAwBT9WjWmHmQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmEmkbSfwdcV/v29zFeIKpqRfYpCYmgrdSW5+F2xHjk+8ltFyNBhX4fKLuQ5OLq3L
	 lmr5P8OkYnEwjJie4zE/N2YWWKYPSLh/LRcU3cm5xy9coX3HSpPrJEtuwYMZCm2emf
	 91DpRIc8NxPziXv421lB5hi56a1t6cuSNvre+JFOkUlRdFKmiUJPHNcCOdJ/1FyIcU
	 0yCdeVAjGxgqswI1OM5frjVoEeCGUDB+aOWKuhVxoT3woWq9hbopuoOR7YU8g56+T7
	 zmwjITo15aVjilRalm6n45cQr0DjMuBHmEnDFxXguy6VwFUW8BlWwT/jTAOSGR4Wwa
	 LpyLAUpC02abQ==
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
Subject: [PATCH bpf-next 4/7] selftests: bpf: Update kfunc_param_nullable test for new error message
Date: Wed, 24 Dec 2025 11:24:33 -0800
Message-ID: <20251224192448.3176531-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251224192448.3176531-1-puranjay@kernel.org>
References: <20251224192448.3176531-1-puranjay@kernel.org>
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


