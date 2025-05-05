Return-Path: <bpf+bounces-57426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B81AAAF70
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7963A2438
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31EC3B5B2E;
	Mon,  5 May 2025 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAgj5YuO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC72EC871;
	Mon,  5 May 2025 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486479; cv=none; b=ocHznQvWR0axIwQpYvonWZVp0kldmbwiealLll5Nyt91vT16Y/ZR2XzNvEBpjIGlOHsRzQmLrp0p1a8h8/2veA5LwAycglk3g92CUI8c5m7M66regpp+oYxeD5m6Ka3ApvTni1PhH4qCNDW1ysGCX6ZLb34VATDnVhsVYX42dnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486479; c=relaxed/simple;
	bh=vtKUXitUTPieHzZ6OsMajJLUSV/qo8vzb6BEFkHPvBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ktYdnKuJM3f4qluvyPIG/n779kxqwQb1N7+G/b4XLuxNjkXbUw1EAlPhQVgB9b3v+w7CoEVNdkIxvqKKA0wNOuf1pFWn8dPJasdb1Zfrf3tAXIjknXQCAlH0W2yIU2T1boobIewX2L3mDtlC2IFTtw55wQcH6n51/oAkyRomSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAgj5YuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DE6C4CEEF;
	Mon,  5 May 2025 23:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486478;
	bh=vtKUXitUTPieHzZ6OsMajJLUSV/qo8vzb6BEFkHPvBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAgj5YuO6jhzcB4MNSKKpz7xQnA4Ghpp01WLTH+MnjXvHSbwLLZC0oFjfqzOxm/0e
	 lk7xXJze91N45dicqSltJQqBr0OdJ+107AnOVTD439JeOLrnGoH8QRZySpGkANuXPA
	 wKmwuvxikp+x5Pz6TaSdqG/QN9LZfMjbLJcU1Vbn1wu3Tm2+UVcrGAOG1YwijRHn8U
	 5li/Jomq4lKnMdnd53yH4HvHCW3jR+u7H43lLRwk5vOku9ntB56PjCVSmnzUerC3lq
	 Ksvbva17InhPEoSmPrUknnJU9EeYpxlKBsu3JDAX1vt41u8s1M0wUesmO3n6MT3ylp
	 U4QpY+D+lDpdg==
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
Subject: [PATCH AUTOSEL 6.1 050/212] bpf: Return prog btf_id without capable check
Date: Mon,  5 May 2025 19:03:42 -0400
Message-Id: <20250505230624.2692522-50-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 27fdf1b2fc469..b145f3ef3695e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4005,6 +4005,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.recursion_misses = stats.misses;
 
 	info.verified_insns = prog->aux->verified_insns;
+	if (prog->aux->btf)
+		info.btf_id = btf_obj_id(prog->aux->btf);
 
 	if (!bpf_capable()) {
 		info.jited_prog_len = 0;
@@ -4151,8 +4153,6 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		}
 	}
 
-	if (prog->aux->btf)
-		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
-- 
2.39.5


