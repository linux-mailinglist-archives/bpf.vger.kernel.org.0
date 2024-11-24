Return-Path: <bpf+bounces-45534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9C9D7620
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 17:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF48B34308
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 14:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD051F9405;
	Sun, 24 Nov 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo0pzrCQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E11F8F12;
	Sun, 24 Nov 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455759; cv=none; b=dVp54rj2WLZ8EPnbKNBo1ZZnBwaiEOUmjdhrahYOJcz5fq11M1SFxEQFWhAJNRcWfELbA5KmjzfyryC0FyXZfiMn7tht0r8FdVaHuZ2kps5Xvu4tmjteG3VJatKbpJpDIvleguhmylneW49I4CLaEbEAKiCtSDlNhzXOBWdIir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455759; c=relaxed/simple;
	bh=OkdHnYr9vJDGPA31YXzAqACcCEq8L7JmmfF00fkHucc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1lZlp08TOOzO/RCj7ujjVkA24pBuzUKkM+jCf2yUEN25MHW9gr0m21Sa5qiNwLNW894ky+dl2zvjLxC2Khe+ri1qodSo9YHVjT2de9CoYwBpJdUf+1aE3X4gk/pAS6E4plIqt+EIJqgBfjhF2WIh1PIBOPDQNiECO5D4NppDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo0pzrCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D834C4CECC;
	Sun, 24 Nov 2024 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455759;
	bh=OkdHnYr9vJDGPA31YXzAqACcCEq8L7JmmfF00fkHucc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jo0pzrCQhRS/zUcbZKN+tcRYGD38FIR20EF951phrrNP9KgbES51HGc1GDDxCFjBv
	 5WfBzvMti6+cBbr0+TRTCA/trdOcP7xpFEe0qLC9C+0HDJSlZPBdCictNErYPopHQ5
	 12CQXsz8xBHwRGjADQMx7ILKTDZYSGeiAcae4e+Vi7PUvtOC4hTv9XdNuAGEHqwGvt
	 jDSNbjVjUS7v1vzMFpFZPRjs6HaeN21tED1cVv+mkQSA8akI4HbD8GY+p1leQVNasq
	 CakD4B/6ayj1IHHA2/MveMw5VFL44Az1saD3lU1x1rfVYkTH44qSFc+g7Vt99ymq4+
	 dSHOHBAi9pdCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 26/87] samples/bpf: Fix a resource leak
Date: Sun, 24 Nov 2024 08:38:04 -0500
Message-ID: <20241124134102.3344326-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


