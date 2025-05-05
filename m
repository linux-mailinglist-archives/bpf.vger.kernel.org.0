Return-Path: <bpf+bounces-57416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E7AAA99B
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377B918872E9
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305035A768;
	Mon,  5 May 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZDp6su/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A8359DF4;
	Mon,  5 May 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484969; cv=none; b=hM16aItbwxNDcj0LocMUxa0sFI9tEnYoLVgzG/vNm1z4hvA2gEN8QOp163sSukkDtN7v5zo024Hnfkt04BGw6VNsJ/tQ8Jey8pHv0IHF0X3wevwzNj2Ta7IBGQ8bXX7fHS4D8TNIGwhFO606X3+YYwT224GOno1KWrruBmrOyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484969; c=relaxed/simple;
	bh=yVGBpTjBCfvZxXBpqe0Kw6YV/IDInWxub7cJTiGyZsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6wPmBHXoKrqa4YbvpMUCYuN9Rh7rB3aZg7iiFo6NMhATLsQSU5xIKBcx4C21r8UmSnE+4cDaVxHNpQtRqaj0Jgl7Z0ryq5tRRrOK3DxkW+lHUtU0KmU/HBzt4OxyDhEbZcmOliTXleWnQk44sko0cmcacXV7kIS2zM8Xv3GqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZDp6su/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BC1C4CEF1;
	Mon,  5 May 2025 22:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484968;
	bh=yVGBpTjBCfvZxXBpqe0Kw6YV/IDInWxub7cJTiGyZsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZDp6su/4ct4WCWsOjkgjeB0vbVGP2oDZrC8E+TQn8rmj/Mggo4nzmgEQ26tJ3Csh
	 IHdz5x2phMpXvKRBe5cBjrlydor8XpUEFW3nmpT082WRouqfTJvqfXByW2XcC/mx/L
	 RwX6zGU/A6rKpXAz7S/9h0Al+pDv9vg8mGhilhhfIU6hQjoxg2EWZtCfD6hBwoem4Z
	 /U891HtTW5IJE+XhdDCd+oYdOHvVC1MVe3953ABQ5pWbQkNvwzsoUKh7dpR4AB28b4
	 J/5On5OPEgPASAv4kWp/UOqSmfZ5E7s4tS47SGGe1myI+tss2aoMDfqydRHpIk2PPX
	 6FudB8Isp8gQA==
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
Subject: [PATCH AUTOSEL 6.12 100/486] bpf: Return prog btf_id without capable check
Date: Mon,  5 May 2025 18:32:56 -0400
Message-Id: <20250505223922.2682012-100-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 977c084577565..fc048d3c0e69f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4606,6 +4606,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.recursion_misses = stats.misses;
 
 	info.verified_insns = prog->aux->verified_insns;
+	if (prog->aux->btf)
+		info.btf_id = btf_obj_id(prog->aux->btf);
 
 	if (!bpf_capable()) {
 		info.jited_prog_len = 0;
@@ -4752,8 +4754,6 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		}
 	}
 
-	if (prog->aux->btf)
-		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
-- 
2.39.5


