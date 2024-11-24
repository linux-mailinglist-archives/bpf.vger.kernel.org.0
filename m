Return-Path: <bpf+bounces-45531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2399D70CD
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 14:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36A628368F
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E61CACE2;
	Sun, 24 Nov 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W10uRSUs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247E1C4A2E;
	Sun, 24 Nov 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455294; cv=none; b=ns+o2a+fEnkJu3Oft8TTEHdcPr7rnil116TlvZABCtM2hAx+VwwL1PFfTMUzhLYPhVMYNh3oPS3AqttsaFRff+WFq25K77ognzscR4x8X61YIB6wlWshB1F1oJ+kul42kqlJcwFxc54VTsS1GrMqaMLFHElMSPLhZfF1hMTgU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455294; c=relaxed/simple;
	bh=OkdHnYr9vJDGPA31YXzAqACcCEq8L7JmmfF00fkHucc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMMADWNFVhWrbPWNFhQZxUwzIsUbAfbvkNxKI16P99Wfuck8t+otgHTBcK9IivnaMDICRTU4xcb1EAIMnKsREcEKo96kMWGa8RunvdfcEa23B6jAsyUuqdsGOSN0BhvgA1yB2u7l5jDKeCy1PFn26TrHsVaVftOC0uza0IqTQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W10uRSUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A408C4CECC;
	Sun, 24 Nov 2024 13:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455294;
	bh=OkdHnYr9vJDGPA31YXzAqACcCEq8L7JmmfF00fkHucc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W10uRSUsaRNEHEwZtF6STY193eocvkXNoV1pBfPLU7u+U8gQyEO47rH8lhMJQB8dJ
	 4z9plU9DEto5T8PYVkb2UHtU6BxkuJ9A2V+mtQfA6KTkpHUafC2hyEyFmoYejBbBVH
	 7Wo3Dbetd8kSsT36rJxUerPixpXDkOMozbxukSvWPJIIUMF2B6E/RHf383WH6eMD1t
	 HQix8mm8qdrf0fItBbvJ43feOYDYcEC7cJf18SP75UJ9f04rte1ksVYYCCNSXzQC50
	 dYcjWstcVy6I0bPQ0go+mqP4+079yNTw6wimsuzfI8jpdO4NOb4ngDt562vewb7oiy
	 jmpsNbq3fOJuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 031/107] samples/bpf: Fix a resource leak
Date: Sun, 24 Nov 2024 08:28:51 -0500
Message-ID: <20241124133301.3341829-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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


