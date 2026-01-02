Return-Path: <bpf+bounces-77700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C94CEF21A
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A8C8303A972
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2B92FFF9B;
	Fri,  2 Jan 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrl/EfGw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45727F015
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376884; cv=none; b=saSVrIF+FY7OkmSVJOt9qWN+QPrS/IFcVceT9P77AI9bQp8oqlXJSlFa0LudDCX5HTC14Al5Mc/O/QcqwNxHJhZZNVWFnebYRMXIzkbtoeNsiEunHzi+gbFkv9t+Dzve3zxh3i/LS16Q5VSpiqKbY70FD8rWuaBq2WfhDMb0scM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376884; c=relaxed/simple;
	bh=ujVEInqgwBpZ87UXCi9+xDRmh2zxrnJaxxnADMTKiSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoFNB52/+y1K6W8ZyWgKf/tICTeBV/32f+AqHX8VPEAWHVLPS+HaCWimIPbNkl7/8hhgXxws0dwPp2CWjDilSkDaTAbM/nh2dOSblKCwpzMp+e/U3S8glsmFD/iXDF3f0kjKAgaEce5eKBxQN+caONI0cxTFw3hBXmv2IXI84Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xrl/EfGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4D3C116D0;
	Fri,  2 Jan 2026 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767376881;
	bh=ujVEInqgwBpZ87UXCi9+xDRmh2zxrnJaxxnADMTKiSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xrl/EfGwL9ybr/Wk1yMJFreCyGML+k0OQDgMUKO3ORc12mC8eYZ2Xy8tjR2JqHEoh
	 YsHgfeWrXu6IrlsuZJOBUwLlzG8KLcwnAwCRUFXZ5NO29sBBNQvmLa7CvcRTjp09aV
	 ZIS7Y4Q5YjM8JoSR/OnN2W7LxDsMq7feaPwrsqBlGaeDD0K4VisScX7s5IDFLQXbIu
	 0plGzBdLi+/PG4ohPvevRTWoBAHaXVn4v1OtzrIlE1TkontGetMP/ScSTyPkSIi8FP
	 3DbWAhATtTJY/8VECUENag5/KTHWzCxAfH98m1eLQKKXZXyagdGbMJq90a94mVl6rE
	 zFZ6JUo1ZGToA==
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
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 07/10] selftests: bpf: Update failure message for rbtree_fail
Date: Fri,  2 Jan 2026 10:00:33 -0800
Message-ID: <20260102180038.2708325-8-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180038.2708325-1-puranjay@kernel.org>
References: <20260102180038.2708325-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rbtree_api_use_unchecked_remove_retval() selftest passes a pointer
received from bpf_rbtree_remove() to bpf_rbtree_add() without checking
for NULL, this was earlier caught by __check_ptr_off_reg() in the
verifier. Now the verifier assumes every kfunc only takes trusted pointer
arguments, so it catches this NULL pointer earlier in the path and
provides a more accurate failure message.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/rbtree_fail.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 4acb6af2dfe3..70b7baf9304b 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -153,7 +153,7 @@ long rbtree_api_add_to_multiple_trees(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("dereference of modified ptr_or_null_ ptr R2 off=16 disallowed")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
 long rbtree_api_use_unchecked_remove_retval(void *ctx)
 {
 	struct bpf_rb_node *res;
-- 
2.47.3


