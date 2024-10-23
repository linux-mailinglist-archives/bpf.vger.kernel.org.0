Return-Path: <bpf+bounces-42899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D379D9ACD45
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD1E28091B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBE01CEEB2;
	Wed, 23 Oct 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrU8x291"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B71CEEB1;
	Wed, 23 Oct 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693982; cv=none; b=HDpljUyi7CkrUBAXAV7u4UUn7I7i8KNCnQOs2fBvSO/JP5B32sHgn+RzTEfY0id4j51/ASpTdcgfVnjqcb+2Orfjz7Ay9vSXlczzucLP7gSi8B1ryvo2ocqryHT+d2+Dxp/lfka91PbgtvJB/J01Q/Ea6j/Tgyj/mTeczIOu3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693982; c=relaxed/simple;
	bh=dc7J3GuEf3qh7zhxfdImeqiif/n6HhVVUANclwj5c+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSzslO62axhrctv+4Tfn+kIImIqBUv3+v1W+jbv7dGWcbpNO2aX4z9irYQCSAy47y5RDqUu2A2MuZ8bTRo1INNYLkYAGobvRLfgPVlcpX0WwxLawjkrnSX8nqj1XONqBTrZ3lTL66qV1AH5E+R5wntp2U6xY5x+upYKVCfZtGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrU8x291; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DECC4CEE4;
	Wed, 23 Oct 2024 14:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693982;
	bh=dc7J3GuEf3qh7zhxfdImeqiif/n6HhVVUANclwj5c+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrU8x291OAo58kNJ0IVYvAq3BwK6O6wUnKSJLT+SANiNkvKwM3R+rmKGlp5SW/uv6
	 XfK+G9HQS0FQcj/SdVGPAjG4jd1bDvtXcfN+8fc7BVJpWt+gtEUyRKhl4yCDLKevUQ
	 OYC/HMZziKpQbAyZrXoeBgx+haHgzT65kys+vn7/OG2KwsLlpf/MN+t5eac5DbiC/m
	 Aiob1VE0NGqusTWWGJHe5VcK4l6pqqrcNbJbjBh/gAA1pSJ+9EYNJMU3IJ/RYvd/GD
	 zzoPbxPTl0ypF3YDG0ajiOLmqYtz9Iyirm+dOFYtiWdDta+Sih3vY1opdFawHOicgR
	 6UCcPJlkb2v4w==
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
Subject: [PATCH AUTOSEL 5.10 3/6] bpf: use kvzmalloc to allocate BPF verifier environment
Date: Wed, 23 Oct 2024 10:32:50 -0400
Message-ID: <20241023143257.2982585-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143257.2982585-1-sashal@kernel.org>
References: <20241023143257.2982585-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.228
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
index 60db311480d0a..931611d227369 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12564,7 +12564,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;
 	log = &env->log;
@@ -12755,6 +12755,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
-	kfree(env);
+	kvfree(env);
 	return ret;
 }
-- 
2.43.0


