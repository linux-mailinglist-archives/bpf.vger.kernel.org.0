Return-Path: <bpf+bounces-45542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E49D770A
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 19:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1204AB84447
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AEE2471B2;
	Sun, 24 Nov 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th5U6q4W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172A2471A0;
	Sun, 24 Nov 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456557; cv=none; b=Y+yL04BulKRT57LT6279LHmy3YuyHJciLAa5hSXzpXkUJRgiHaQH+8rD2dSWFxl594u5kn+P1hMU+3sZf/lb0mStcRIUKHEUeTUOJvcSy2sU6aCt71OIjo9gSsg0gj69Pbyr0/3aHNxwD5uutOUu3b1g454BQm46QwmB1mwgaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456557; c=relaxed/simple;
	bh=UfvA3jp7HA7D1xdiFW8nzCh+DbA83drGo8aRe/3mfk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onnIdIFIH0cRcN56zCwW3H8qpJZGnB1SyW54qYRL2zhMB0dGsltPc2cjQxpdHKOVdYN1nqrykCsXkjwMZBWuzB/Ok0iPYoCzrodQgKV/zU4z+rv2MB3nnsIfPkdheHc+kwcahjsHshM7E2v2H4BuObhG8G6qh1NUjNdn9VaIm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th5U6q4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CB1C4CED8;
	Sun, 24 Nov 2024 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456556;
	bh=UfvA3jp7HA7D1xdiFW8nzCh+DbA83drGo8aRe/3mfk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Th5U6q4WERHrS/jXGuR4PhpuHKNx7EhvXXfXYPbRJAr86MNs1lVbgJo95/rRmnrds
	 Qx3JAfipky4bMd38/P9fGs3UyDN+VfBYgmOyLoug+1rbT+RSUoV/LPlWDGMbRfhoZG
	 0NNZbei6kp8EBrcWXvffu6Rzu8uNTKLyhZqqDOz+Q2Kd7ZUyAzIIOJ7nMucHjbK0sO
	 Ja74bLZWfLVGsdLWltaTI6LtRsEzXLbv0fpfOh+YBmIwlB1hE8dB/m+o3+1qJoIOr/
	 QHpfN+sWFx9BT6yjhwR5McjUhYtCryl4EVUIpEowUvXCesjz0Ci9PosOz7o9iVQD58
	 +sMJll2E2JOeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/28] samples/bpf: Fix a resource leak
Date: Sun, 24 Nov 2024 08:55:04 -0500
Message-ID: <20241124135549.3350700-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Zhu Jun <zhujun2@cmss.chinamobile.com>

[ Upstream commit f3ef53174b23246fe9bc2bbc2542f3a3856fa1e2 ]

The opened file should be closed in show_sockopts(), otherwise resource
leak will occur that this problem was discovered by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241010014126.2573-1-zhujun2@cmss.chinamobile.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/test_cgrp2_sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_sock.c b/samples/bpf/test_cgrp2_sock.c
index b0811da5a00f3..3f56519a1ccd7 100644
--- a/samples/bpf/test_cgrp2_sock.c
+++ b/samples/bpf/test_cgrp2_sock.c
@@ -174,8 +174,10 @@ static int show_sockopts(int family)
 		return 1;
 	}
 
-	if (get_bind_to_device(sd, name, sizeof(name)) < 0)
+	if (get_bind_to_device(sd, name, sizeof(name)) < 0) {
+		close(sd);
 		return 1;
+	}
 
 	mark = get_somark(sd);
 	prio = get_priority(sd);
-- 
2.43.0


