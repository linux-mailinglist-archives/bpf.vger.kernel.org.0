Return-Path: <bpf+bounces-47445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963E29F97AD
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE70D16F6F0
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D822579E;
	Fri, 20 Dec 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2tNdzMf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69422759E;
	Fri, 20 Dec 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714737; cv=none; b=ptLn4Ng/50K9NAQ3LJUme4TRP9aNZ5LbEdf2Kwtr0kpIVotQVVGey+alaYb+5z5yTsXc7jXJ5q8zTGpwboGe29bavJ4cBhozAWJaoyxpZQo532ZhWljIse2jDbwGUEZ5Xo4J8mpcOCtAQPSlsmuTSwRz0VmqzxANpqw9Rw7kSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714737; c=relaxed/simple;
	bh=AR17esnEL4aZJMvnxtvUy6khYtt0uysY+yNyjEwO+6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smO2AiKlExG9J0p/UtnI1x+0cm+wb1BB6anU1jP7cUKT1de6nANjvYg11JbT/i9kRas9UXkglxxCJrR59d1EP6KWK+eADhUEd2IhDjSL8tVfZAWrEVqBUPYMY/yoShbcxtoaN6vzpQbo3uB0hO7AAmqFyGnQe3n2MP9XbjZlueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2tNdzMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2A3C4CED3;
	Fri, 20 Dec 2024 17:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714737;
	bh=AR17esnEL4aZJMvnxtvUy6khYtt0uysY+yNyjEwO+6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2tNdzMfM84fT34u9WYMKZ48lvWNAzCx0RNxl6Qv7hfgCyQ08TZlyY9bdWuY5Omug
	 mLt8U98p6vWeMKwnVW5zKxN1k2ML6qsnbKV+8ah6RsPpbXQKNindzAXIhwxRtwiF9S
	 uVu6FsWB7vfJv4xLfMOqkEfmJwGMI3wH8v26LJ6oZPqfY9gALswNMXNtxM497iPXf7
	 ze5o+MoS85Gb9xdGFHyf6RXjIPWMUHZ9FjH+SIbk9zs7pSV61mewmsuz1wGLxbd93i
	 rMYd0f+F1okHOmKMbSiwQ50q7g57yRCsZTiyQA15D1Ahr1VpX5PiBFlDSkSVyZDTgo
	 5D5YXKITlyXUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 19/29] ARC: bpf: Correct conditional check in 'check_jmp_32'
Date: Fri, 20 Dec 2024 12:11:20 -0500
Message-Id: <20241220171130.511389-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>

[ Upstream commit 7dd9eb6ba88964b091b89855ce7d2a12405013af ]

The original code checks 'if (ARC_CC_AL)', which is always true since
ARC_CC_AL is a constant. This makes the check redundant and likely
obscures the intention of verifying whether the jump is conditional.

Updates the code to check cond == ARC_CC_AL instead, reflecting the intent
to differentiate conditional from unconditional jumps.

Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Acked-by: Shahab Vahedi <list+bpf@vahedi.org>
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/net/bpf_jit_arcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/net/bpf_jit_arcv2.c b/arch/arc/net/bpf_jit_arcv2.c
index 4458e409ca0a..6d989b6d88c6 100644
--- a/arch/arc/net/bpf_jit_arcv2.c
+++ b/arch/arc/net/bpf_jit_arcv2.c
@@ -2916,7 +2916,7 @@ bool check_jmp_32(u32 curr_off, u32 targ_off, u8 cond)
 	addendum = (cond == ARC_CC_AL) ? 0 : INSN_len_normal;
 	disp = get_displacement(curr_off + addendum, targ_off);
 
-	if (ARC_CC_AL)
+	if (cond == ARC_CC_AL)
 		return is_valid_far_disp(disp);
 	else
 		return is_valid_near_disp(disp);
-- 
2.39.5


