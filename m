Return-Path: <bpf+bounces-57432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B30AAAD43
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 04:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568BF1883348
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93E3E8D85;
	Mon,  5 May 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCW1soBz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B928B400;
	Mon,  5 May 2025 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487230; cv=none; b=c/vFKP2VKQ6xRNfPZ8AQ7/lFejvWIzssVj84C6QGoCY0V7anHXe7fz1ECzNvWh2sEtM7OjNtdyC4LQMBe74wEEFS68tMsz/xBKWYu4AbIjqgQ2Md4LD+Fl0A0rpxSw+5V0j25wz5XbQ3ue+d3Evk90tXckCHOLCxTJgdcjzJYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487230; c=relaxed/simple;
	bh=vqnvNS9eSoUsYXNZeDhxKTBqZfo8233lKjz1aoDaY1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fadktpMguBGjoQ2Buf6VvFNph+CiReq96sdwJ2sy8Y4rA2kJpSLPfwo0TY4pSS97OFB0tosQrjtMPRhG8hsO0ZNKowvnZQBJ4PaHdc/kGUDKqldX3BF0ZKJan2BdIB7iSVr0HY7Y7/s/zIaoInw6A6ZnB8SW+orgoVBwACpTPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCW1soBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277D4C4CEE4;
	Mon,  5 May 2025 23:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487229;
	bh=vqnvNS9eSoUsYXNZeDhxKTBqZfo8233lKjz1aoDaY1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCW1soBzcLP2Y0fOS/MTVpkUL8Bea+/MJ7zam7gkINSe1okGIvB3JkxRrxaqShK2W
	 gtUw12qtZc1zIIuCUyt+lBndPR6QeiMkQBr8zYhgv4PLNazHU74j75rXHEBIKi8duK
	 94aSXmGA9jmen+5FjkCqPez1aB3DMreUp3VUoY0YKpxV35SFHxKwbcQgJRAgU5p39Y
	 vanfKK/MHQzHuacyQaF0KJVfaUeiCpLDmyaDepL/gJXTfzELwnG07nolWzcCHySaAN
	 S3RS/7XLXPa13H1yE3519IfqKAaC544G8zdWafvYhoG17pUX99KevRfPmhi4ZRhLjC
	 YGWOJt8oDLFCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nandakumar Edamana <nandakumar@nandakumar.co.in>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 067/114] libbpf: Fix out-of-bound read
Date: Mon,  5 May 2025 19:17:30 -0400
Message-Id: <20250505231817.2697367-67-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 33cdcfe106344..f65e03e7cf944 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1503,7 +1503,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
-- 
2.39.5


