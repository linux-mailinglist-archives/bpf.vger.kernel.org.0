Return-Path: <bpf+bounces-45539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196EE9D73C9
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 15:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21D12884A1
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D8231A98;
	Sun, 24 Nov 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJn8MMXx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3E231A83;
	Sun, 24 Nov 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456212; cv=none; b=r1bOUU9FNO8E/9eCwDtaFzKuyZG/14XZipKdnlESVz/Grji8lI6E4+zc8eAm7thleb0w4OSSAM4Nt0KIdP8mOuCKNL7jgTZ5bURUQG7/i2JPIc+tOvlAL9INLlJ6WQtO5AhLDQbgynt6t1rlPyxE/iQ7+KOpkG6mTDLudfyS3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456212; c=relaxed/simple;
	bh=OkdHnYr9vJDGPA31YXzAqACcCEq8L7JmmfF00fkHucc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9WelU+WF2owbh8j5QyAEUoubrBTh5PnZkg613eBPMKReEVC9wFJjcK1MAXR5YMtzhamMIcGoxr0nYw6bVVVt1pARWfNRm+5dSFxWeDaGjYaMrKTnkOk6HXR1tEgVlavGS/e6pd+/ajCE0cH+XJPPIaRKUNsJBerpGkXaierLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJn8MMXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A60C4CECC;
	Sun, 24 Nov 2024 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456212;
	bh=OkdHnYr9vJDGPA31YXzAqACcCEq8L7JmmfF00fkHucc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJn8MMXxbBLjO2KiLEbqzdqjKR5kHJzaZgFuy+67i5EN+6f5Kalp7AeMD5ozJTyCi
	 EJF/G0EVZYGLPsBDM5W8NQZw0XKz75pGH3OwH9Jmqqut3AKG4ITgp+nOIBdgOHvBcI
	 7S/jr151yvDVPWbYjsrWnT/I287bHmRn65SSBJY4FeimG1HIpsaMeHEZ69eTf2lf/o
	 E9XFQwF1TzzETMS0FuJ/IOVBcU2zuZHtkx96B2r8R89fC+qjpgP4zqpCJXXUW4pRQv
	 I6fEIOo512EEC5pzgeer72hQaDgBIlzuwm8IEPP5anvnOg8UaJSbaCEAnhI0NOgPSR
	 7qOI3Hy0otR+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/48] samples/bpf: Fix a resource leak
Date: Sun, 24 Nov 2024 08:48:34 -0500
Message-ID: <20241124134950.3348099-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index a0811df888f45..8ca2a445ffa15 100644
--- a/samples/bpf/test_cgrp2_sock.c
+++ b/samples/bpf/test_cgrp2_sock.c
@@ -178,8 +178,10 @@ static int show_sockopts(int family)
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


