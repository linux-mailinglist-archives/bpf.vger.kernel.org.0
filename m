Return-Path: <bpf+bounces-45540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327789D7429
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 16:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC41B28582E
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F6C23AF91;
	Sun, 24 Nov 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeO1lZne"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F652235BE6;
	Sun, 24 Nov 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456350; cv=none; b=Fp8aooB8aiGI6h5gCM2IzUP+SXQ8OS2vdDK294kjHciMal6Yw2czHyl60na82SBmDM2MdNbfHhP+HilrYNdXud8d2FfXKMmSZnD/EFfLlf978wtm+M3ZgYzuzpIewzRCuPjxy9lPzxTp86DD4BuPTGd00mtVJ/RDwSG1kZx/hPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456350; c=relaxed/simple;
	bh=UfvA3jp7HA7D1xdiFW8nzCh+DbA83drGo8aRe/3mfk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzhRIPJeatvD4OKLZOkVMTFwZzLN+S3e7q6fsWLsjTQ+4ZG3ZIvR95+TQQu80PorQbATDoUogFjZzEsSClQJZvq8ECB5uTwkji2KwvYbmpO4UR9CigwGtdmU7QPviUFZfsLmxCsSJMV7c9n2hwI/Hy60cJvcaqtjrO7tbFk3upo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeO1lZne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5664CC4CED3;
	Sun, 24 Nov 2024 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456350;
	bh=UfvA3jp7HA7D1xdiFW8nzCh+DbA83drGo8aRe/3mfk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UeO1lZneg+8mHKTQJUttuksRHa7wceKhseSr2aWveuWT/U+j5NUm9cBbg2NBr7bqH
	 9BfiM9VW2i9lL5P7C6L39N4CA8AZGbUaZkUfEgkOvLo1LbrXDXKSr1Sy8tAf+5ztKx
	 nPKu1T1l9PhBjZlVgJBhifoXtAbkmeJpa3gFAP2nUcS5QrrAQY40CYxl2ACGNMV+7V
	 Wpg9eyQgjH2vmoJZNhBAx0nffuQ03cxAw35j9vfHR82OKnFORLJTpn7Noy4Yhlc1y5
	 +iun+9RYL6CzTxHw3P6SEBMrD6xePR9eSbo2D8ogIKaEbQrvY9utDwvLm4CtIpWdw0
	 QP2ymza2OdjUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/36] samples/bpf: Fix a resource leak
Date: Sun, 24 Nov 2024 08:51:20 -0500
Message-ID: <20241124135219.3349183-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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


