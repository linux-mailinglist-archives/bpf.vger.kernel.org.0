Return-Path: <bpf+bounces-42896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356B49ACCCD
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC3CB2404B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213EC2003A7;
	Wed, 23 Oct 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcdX4dA7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651020012C;
	Wed, 23 Oct 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693894; cv=none; b=b5cBOtb+dzCwFNykHUZCm3WbFYwRs+Vi9tEDKa4yf8imqExGhvBahlZZcyG+d8x7N7mGZOFb7jyGGofjIZeUhBzZXIkOmHt58Hq6+jJ8/GEfX7Y2IE4FMv4O3/hFvOeL6Qx1X+vdTF6Oizv4vdH7tsZ5T0F+0kNpJvO2ZkWIkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693894; c=relaxed/simple;
	bh=c0G4kEs4xrVc2JFCoVCAk3tUI5nRxxOsfu2fCa7nh6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/7dvMox867PA7rhBcUZbd5a7CCwdaJkvH0DeqQ3Z7hZ+GQIOu1KwKCOIyF2quG8BknvVu2loZPtYgiQ2bz2Z8r5OUOsT0N0ZGFK73cu6YiqvBqWj+FBDUXi08m2QH7fizIP8aFO78sf5pbreXMHIxeCGP+KBVLUcpsbW+PgnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcdX4dA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC63C4CEE6;
	Wed, 23 Oct 2024 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693894;
	bh=c0G4kEs4xrVc2JFCoVCAk3tUI5nRxxOsfu2fCa7nh6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcdX4dA7PqpzuJB3Rzyn/VdD3BZNbgS2UDmeydMRxo14dM8fOkDv6rNLY6Nq3hpFU
	 719i9m0OLqcCDBIaeCk2dVLO7aZHR53Z5K0k8AbUVZbDeN5s/ScP4gypwkIA9dAaAX
	 tBtBcv1SRlen/PIzxSm0Qi562NDymNj50QVtuwdM4ZhuJiHgw+j8njrirGenvgXI92
	 5gMjbmkEGLHXVHrafS0vXc9bFxwgg2yEHmwaH3Xm3WU1ms6MNBf6m4K0INHn8jDTqI
	 iVbtPZ8euJEaKXEEq/5Im6ZAqmG0gVMMlzTUU3ERifYg+PWxzqYIGM9JUefC/snFss
	 /QJR5A1BWs9Zg==
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
Subject: [PATCH AUTOSEL 6.6 11/23] bpf: use kvzmalloc to allocate BPF verifier environment
Date: Wed, 23 Oct 2024 10:30:55 -0400
Message-ID: <20241023143116.2981369-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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
index 3032a464d31bb..50999c7b3b0e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20226,7 +20226,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;
 
@@ -20446,6 +20446,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
-	kfree(env);
+	kvfree(env);
 	return ret;
 }
-- 
2.43.0


