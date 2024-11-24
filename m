Return-Path: <bpf+bounces-45537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3199D734A
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 15:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8211A286634
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7922D233D77;
	Sun, 24 Nov 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaRrrOPL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C1233D69;
	Sun, 24 Nov 2024 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456040; cv=none; b=FxBQA6TIoX1MDFodA7/5RGgszB3CmnAM+tNsKPFRe5unIatZpaH7kMXIQFErElW2igOhMpoqHcm8YvMBFyBiZ+qoasuvb2LwqS32sHBZePte7Egqf3j9Mf9NHrUmQqx+2HrCiyLcl6IUSuE1B8/SWZhxUpX0rGbgzQOS8YpYl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456040; c=relaxed/simple;
	bh=OkdHnYr9vJDGPA31YXzAqACcCEq8L7JmmfF00fkHucc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hdpr525aMkC9WFkI0tfjwLmC4gplLLVXU7ogVx/5h1cRjxLpyHugsBY+QGgLQ06r1zRfsBuHkzq2emSmQ//qQNu1/0ok4Vp5TFhHwXJsnObmDxO9PhaAD+FNts2YWOITkjukzbvhXK6PhsBw0htTpaBP56hxUHncNNRjU/JEFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaRrrOPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50C4C4CED1;
	Sun, 24 Nov 2024 13:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456039;
	bh=OkdHnYr9vJDGPA31YXzAqACcCEq8L7JmmfF00fkHucc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZaRrrOPL1fXA/CzC/s2gDJvgvyBJmyjU5nniX4nENsWVmooWpTeoD014EpY6mGAti
	 kn3K+36pYyQupHq4jRHWpsytmYIyA4NVHB6sOkYUIlu0gdB0W3hPmK9Dkdr6xXHkp5
	 wdgbyx0XWvYFxfWSzJfiOO/fBAe4HTgTuCwFLUFnHAjOVCzVq5XJ6WGxUywnY41mdb
	 TmvFD3aqvV5PcMisRaQOv7o1maXYCIbvTw+46RK24acIKnmIpt9XafWU2+/VbhMDF/
	 m4VXzud1C2xcKG1LxUUosstiTnSeBc1Cd/BpLkQKNlF6oKCayf/ymHzxeSnkFbuiEz
	 NQFa1jD5BuAvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/61] samples/bpf: Fix a resource leak
Date: Sun, 24 Nov 2024 08:44:50 -0500
Message-ID: <20241124134637.3346391-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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


