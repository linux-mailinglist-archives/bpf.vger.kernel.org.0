Return-Path: <bpf+bounces-57417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BDBAAAA0D
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC5E7AD295
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33337C750;
	Mon,  5 May 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me/Emz+n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA235EB97;
	Mon,  5 May 2025 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485322; cv=none; b=g8uzgkRegW2XKDDLoKbHetaEY4w9kJsuUCFNoywqhNuwDk3ABFO10ZU3xuZML8NGJlKqNaDHP8XQ1p/XdgB6P2tWlClzN4hFLHYuHCWEzrSOFilD/HBFrUF2BXm4GWt9eOAsQVZQeWxNtQBSCG3Cygr2Zg/Xdi0GDYbo85Kvrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485322; c=relaxed/simple;
	bh=+kAlWFpPjvZ7Wc+Kh6SVwp/JOzpD4dwJ6NntXTUfaRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n8QHhl6ZIvGTun8xDrjKc83XqU6ANB4dPiIXolDj+3vNABd9lcLkc4VZacoBGjyDlu3LV4kWxwvCyQoCjBFzkxi4EexD8SLli/y8YKyD0iQEreb6NIdBzOJwEvgahWUjkiL7U/T9umrn4In/j/rXYFwoiHu/rRMcp2jYpqcUO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me/Emz+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF13C4CEE4;
	Mon,  5 May 2025 22:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485321;
	bh=+kAlWFpPjvZ7Wc+Kh6SVwp/JOzpD4dwJ6NntXTUfaRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=me/Emz+nmToJ9Zbu5hsHxZYgoyWrEYlM7DHUvIvq2UsrBoF9HyvMECjoYPpogzvIZ
	 u5FJjPu7FKj/1NZdfw949ieA56oxyuVRS/wElk1qQrzJi5M3J5o27YdqdDZqt6HJzY
	 FKBhiirYceJy8OGbXir82J0/dv7Sxx0bI2ETm7KQKQnBO9XVStj3ZpYwMl1c5QMb5K
	 cm9d3ztJ1E04brAbiw/3JE9gAyL5A1uTVgXOeM2AISFYsmQxmNUIPH4Iasl9WIcEe6
	 26xDSGv0HkQ5heMEPJMpa3qEidec7/n3/YDbqgRVYgwILmCdcxlMLf1X/BDmb3Wooy
	 hJtz+BkxxnVSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nandakumar Edamana <nandakumar@nandakumar.co.in>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 266/486] libbpf: Fix out-of-bound read
Date: Mon,  5 May 2025 18:35:42 -0400
Message-Id: <20250505223922.2682012-266-sashal@kernel.org>
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

From: Nandakumar Edamana <nandakumar@nandakumar.co.in>

[ Upstream commit 236d3910117e9f97ebf75e511d8bcc950f1a4e5f ]

In `set_kcfg_value_str`, an untrusted string is accessed with the assumption
that it will be at least two characters long due to the presence of checks for
opening and closing quotes. But the check for the closing quote
(value[len - 1] != '"') misses the fact that it could be checking the opening
quote itself in case of an invalid input that consists of just the opening
quote.

This commit adds an explicit check to make sure the string is at least two
characters long.

Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250221210110.3182084-1-nandakumar@nandakumar.co.in
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5b45f76059296..a6bbae1e4c6b9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2074,7 +2074,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
-- 
2.39.5


