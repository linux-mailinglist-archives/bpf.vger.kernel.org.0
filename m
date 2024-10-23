Return-Path: <bpf+bounces-42898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486E39ACD2E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690671C21BA3
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D61F213EDE;
	Wed, 23 Oct 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObBwUPT3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D72213EC9;
	Wed, 23 Oct 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693965; cv=none; b=NWc+JasosgUD9P0BDNJcE+z9ZlGnYtQHLPdlgXnHeLzlmF1qjJ2+gZkjVIRIVr81hlkewG5Zw5UuswjSryMaswuXX+UG7JvijwmZbr6u2x/yyJx7jWtwd9v5jM5R8vi7HcweIXiasyd9/usHILxery0Vnu9iVM0T9uc/sA6HEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693965; c=relaxed/simple;
	bh=lbufe4sfdzJUzIT2TlrqM6nUbqDUBi+ZlQQrZ3au26Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHFJ0YG32WtiywwdV8g1S9jXWm0G9Lsdjbx/d1y5LShxZEzYBEie6PCwfKarmw9/X4HX+oJAXvEtYrztFnsCE1J1Iel0DEKNxxRGO1dAdF1rnGWPSjiSsbDB04tNK1/1tU3HeBRYgqaXnXT9x4eFj2gcpWsxvNnvNQY/27A0U2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObBwUPT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4992C4CEEA;
	Wed, 23 Oct 2024 14:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693964;
	bh=lbufe4sfdzJUzIT2TlrqM6nUbqDUBi+ZlQQrZ3au26Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ObBwUPT34vp4AJJsI/1Qp/tlDHN8hoe0USimORQrQa13iprnf88fEiOmvXsFDGvbk
	 ZPzAzyKTtsE/jMTzOCD/GxoV2/9dX1H7Ksbq8xZZSARjtWQWbEcV+C8d4Tx4+X5slh
	 co9Upoqkx4litJnJCkpJIhkKJFl+28Pj+QLmqxngLlg9QNwgxPXG8y1M0ITwAjv7jv
	 rhjPdLyEVlnu5TgRacL95OaBgu1ejXsWSzZEth0gNLz1jXkVe1n0sWlC3ERx0Ripi1
	 N9Qfv+CfLzI5MB2mPXf0gZ1e6GbKPQQ6TQSDu35fb9UIsMdD8xgHkg/BC8x6maKDDi
	 zpZ048IGcA7mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/10] bpf: use kvzmalloc to allocate BPF verifier environment
Date: Wed, 23 Oct 2024 10:32:27 -0400
Message-ID: <20241023143235.2982363-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143235.2982363-1-sashal@kernel.org>
References: <20241023143235.2982363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.169
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

[ Upstream commit 434247637c66e1be2bc71a9987d4c3f0d8672387 ]

The kzmalloc call in bpf_check can fail when memory is very fragmented,
which in turn can lead to an OOM kill.

Use kvzmalloc to fall back to vmalloc when memory is too fragmented to
allocate an order 3 sized bpf verifier environment.

Admittedly this is not a very common case, and only happens on systems
where memory has already been squeezed close to the limit, but this does
not seem like much of a hot path, and it's a simple enough fix.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Link: https://lore.kernel.org/r/20241008170735.16766766@imladris.surriel.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 88b38db5f626d..e29c0581f93ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14013,7 +14013,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;
 	log = &env->log;
@@ -14228,6 +14228,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
-	kfree(env);
+	kvfree(env);
 	return ret;
 }
-- 
2.43.0


