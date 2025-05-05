Return-Path: <bpf+bounces-57447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4139EAAB2DC
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECDB188AC37
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 04:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEDE444407;
	Tue,  6 May 2025 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxLWnbAR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB23372655;
	Mon,  5 May 2025 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485913; cv=none; b=G8RPDOczkP04nCGYA1SwejCnr7NLfdvjaMrfW7Nx/6FyMbKB6OuuCBrtVKrUWNen+y8q35V9WxvacOyT23lJhZbhflUXi5xPrX3j4FJ2cRYpdvyvYVObqLlQ4hImfudK6NPAORCE4l9qmwdJRztNCGUm7rSaRD23mlduV2wAmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485913; c=relaxed/simple;
	bh=oIsG9H2kDn3mNYH9FGhnDM5zfS5PZXox+7zjFRUZS/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIJjOwiz4DCmyphFqWmNEF+zkn/EGM5PzFl4l0/n5OsTByHWPZh/yNXzQt9YeJNCimKBzeiNl6lYXp6ZIhvBhSqKetKebyEVAq+e73OiEc2SL7LJX9xcjCVPRW8c63elb26lPkEQSqFL6r9BHm1z8lo2Y93DS2FsfjYe24mNA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxLWnbAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113DFC4CEEE;
	Mon,  5 May 2025 22:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485913;
	bh=oIsG9H2kDn3mNYH9FGhnDM5zfS5PZXox+7zjFRUZS/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxLWnbARmm8C7WLTAFTodYMWsf/uxK69C5SvKCzE2YaMSQ/2TrzWF5kJjW1rHjV0h
	 a9ARYMcaBzbqNGqdDLZqf2LoICoH/wRY+mMRg15wvp7eOfMauIMWh1jY+DCmtKCGeX
	 B8S169z+G4vQVJWNepRuKpVpAgQqgfhm7+6dkeGX9/rw9xeNwzsGeGhP0EAGqYs+qY
	 cuoXwPs+lyytmlTvjwGJW9zNrt45czs5twWjclwmbbSi9TJ3TwKBFBZmABWv6RcuEH
	 MrOHGSx7ZZcXAlzEQnncd6p5LUTz34KfcMSItCg7rJ0JJKUL1UK4UHNdXTjoCrfOEc
	 d0EdCribSyT4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 061/294] bpf: Return prog btf_id without capable check
Date: Mon,  5 May 2025 18:52:41 -0400
Message-Id: <20250505225634.2688578-61-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

[ Upstream commit 07651ccda9ff10a8ca427670cdd06ce2c8e4269c ]

Return prog's btf_id from bpf_prog_get_info_by_fd regardless of capable
check. This patch enables scenario, when freplace program, running
from user namespace, requires to query target prog's btf.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/bpf/20250317174039.161275-3-mykyta.yatsenko5@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f089a61630111..5a8c5a4ef1134 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4442,6 +4442,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.recursion_misses = stats.misses;
 
 	info.verified_insns = prog->aux->verified_insns;
+	if (prog->aux->btf)
+		info.btf_id = btf_obj_id(prog->aux->btf);
 
 	if (!bpf_capable()) {
 		info.jited_prog_len = 0;
@@ -4588,8 +4590,6 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		}
 	}
 
-	if (prog->aux->btf)
-		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
-- 
2.39.5


