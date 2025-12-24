Return-Path: <bpf+bounces-77430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2ECDD0AD
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 20:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653903030FD4
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27933F8D7;
	Wed, 24 Dec 2025 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n90JWn8s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B3346E63
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766604356; cv=none; b=Mo0VgnyXSb/FKPcqV4tPuqwVCLu2v58CGXxR2kiPEicdHlvVsLfdDBrsX2m8+5pLhqXdbPd4LK2JnvwdCZUdly2unbvsZEdaER7uphYqrOtq8A8+aFhalGLyVlklwC9n5mT3JkgJN3aXAQIndJEo4pw6i/TuYKLDPrFClEuVadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766604356; c=relaxed/simple;
	bh=3JV+TVAyUmvwGgR9UmSQuhyV77l5a3V/cDQh4KLyifU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsYDDsrB7l0GWOr+ZHjfelQgZ5aeskhg+aVVtTPels+nDzBaUWNXSNv8/140wg+tV5XeWGLMQ1h0vDed9giPdnqFixodebAzwrGxKlgGIl+ZKEMg7z4eqdVKyrpy7rv9KILAhij8kWwKNw7ZsbWDhTzFUcHKp9D5NsOeF5FNivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n90JWn8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A586C4CEF7;
	Wed, 24 Dec 2025 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766604355;
	bh=3JV+TVAyUmvwGgR9UmSQuhyV77l5a3V/cDQh4KLyifU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n90JWn8sxTVOSl8zxgvKk6bRI/ySUIQLX5u6YEpK2MOeNWP5qThRRwi91TRPvbbyo
	 S8ohm7CaRQB5++y0U9Q90n2rtwc1fjM8hRwQOgO8gPcHcauZOy2Csptofb6VjdiltF
	 3eWHB1tiu7eqM9UrmUA1DI+FFN01ZwQCycLLR9lk3HEgcpnZbFImDJkbDtdpCTlTyq
	 8GXKtNZGwFtWCEev9tbi0LIMOty7EAWT92XYalvCtI8Ly7ZmmQDYVJy65VuskbIylt
	 NaJr0goPsTULCGshW2ntLmwhRGa0BcJBwnNkHArrcljLmyIwwd0Xj6EkxsF6+vBhO3
	 nTVF2yMEAf7VA==
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
Subject: [PATCH bpf-next 6/7] selftests: bpf: fix test_kfunc_dynptr_param
Date: Wed, 24 Dec 2025 11:24:35 -0800
Message-ID: <20251224192448.3176531-7-puranjay@kernel.org>
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

As verifier now assumes that all kfuncs only takes trusted pointer
arguments, passing 0 (NULL) to a kfunc that doesn't mark the argument as
__nullable or __opt will be rejected with a failure message of: Possibly
NULL pointer passed to trusted arg<n>

Pass a non-null value to the kfunc to test the expected failure mode.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index 061befb004c2..11e57002ea43 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -48,7 +48,7 @@ SEC("?lsm.s/bpf")
 __failure __msg("arg#0 expected pointer to stack or const struct bpf_dynptr")
 int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
-	unsigned long val = 0;
+	unsigned long val = 1;
 
 	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
 					  (struct bpf_dynptr *)val, NULL);
-- 
2.47.3


