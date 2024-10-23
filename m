Return-Path: <bpf+bounces-42893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0469ACC7E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0668284AB4
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582251CEEA4;
	Wed, 23 Oct 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxDE7Nvy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2611CEE84;
	Wed, 23 Oct 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693835; cv=none; b=Lb9k5kHDoiZ1t94bi6b3xff63panIqU4UxD9f8YqyOEVUyLswZobNyH2ZrqX49YjIcdxW/Gttew1543gcu/XB+FmdnWz2T4rEmJMYduMsBJBl6hkLvZI2hULNIb6xkuVj2HqUx8AIBrrXkKAE6RKphn/xfTtLzDhHHFddvVlk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693835; c=relaxed/simple;
	bh=bJGEI48VnTaic3qYGqN5KF/CNe6awCRJ4hMK7M77D74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MC2ci24CkJhmmjedriyXGBzWvxI6DeUx/mTeVwmFgeqxjUjKqBg06Pqjf37J0wPAa1FccLsrHe5V0O2IwMfOhx8VVNIR8Sf5gquyUF/+oN6pHIBWdUZDJliQXlXrKz7RfxSTA2rwOsHf7M2qex6e34k1YfesbQ1JFgjZItVBkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxDE7Nvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFB3C4CECD;
	Wed, 23 Oct 2024 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693835;
	bh=bJGEI48VnTaic3qYGqN5KF/CNe6awCRJ4hMK7M77D74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxDE7Nvy0bdVXnBBJzzvJq7pvE8B2L5fuIOTf6G/wAHPdHLAdn2LB46R7DgMuNZWo
	 SUqPqhL+Y6tsgDxfuDq6WR9RWn8JL6e3CMMY8bsMHaQYkeFckUp7W3hyPdydjlbua2
	 7QSKHwke2xOJbhLYL5wGNihJ3RXe/zWtuwOQRiF8kTccuqurfsbFLOX2P8oV1K4EEi
	 I5AY3pXpwsYOm9TrdSlS5LZHXqz47T99VPVU5YcEYNVzpaGwJe2aqA/zyBDSw8SKyW
	 bn/VveRck1JoCOcJZ4/ASIlIMeq7Ox6KuasCD1dqF2tmCaaOecjaNDf8guf5gtL7OK
	 FTuJDskdzLF5w==
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
Subject: [PATCH AUTOSEL 6.11 14/30] bpf: use kvzmalloc to allocate BPF verifier environment
Date: Wed, 23 Oct 2024 10:29:39 -0400
Message-ID: <20241023143012.2980728-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
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
index d5215cb1747f1..8bf91d81e4a75 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21706,7 +21706,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-	env = kzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
+	env = kvzalloc(sizeof(struct bpf_verifier_env), GFP_KERNEL);
 	if (!env)
 		return -ENOMEM;
 
@@ -21932,6 +21932,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
-	kfree(env);
+	kvfree(env);
 	return ret;
 }
-- 
2.43.0


