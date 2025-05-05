Return-Path: <bpf+bounces-57428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F1DAAAF87
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A217B335B
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A533BE7BD;
	Mon,  5 May 2025 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPj8J++W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370002836B4;
	Mon,  5 May 2025 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486637; cv=none; b=HYmyXxGYJiBxvnKRdQATXckOX1EuM7stDmL++XJMkrSSzlfhGUt6kj4ixHiZ6CKSJRku0L/wNt2amxsALXNmsfKcdv5G8EG8tB9ufZK0uOQNhjWwl3IZcpkSUyZHhDNtpmDe2t0zNGuCm5V/Z00D4c08Vab4H7EXc6uqQOK7ehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486637; c=relaxed/simple;
	bh=V12DuPXNiRtWtQMzLPiLVqjBMCfbPhgvcS4XmvFCYQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lP3izxvKKOVwihg+U3vG9tePYtc8AZIgyb4cXkx9L+JG3FMHP9PFsgKn7bpBykVxaf7uPmBtIC2iU/abcn9Xz0kZPweIqWzc4qOKIJo37pAFxBl6SCyBHip8hKBh/1NwMGuWcE6p+rtzawKakoiPn7dZ22+ZgQ1X2nQXv1UYnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPj8J++W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FFEC4CEE4;
	Mon,  5 May 2025 23:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486636;
	bh=V12DuPXNiRtWtQMzLPiLVqjBMCfbPhgvcS4XmvFCYQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPj8J++WWS6XGeL+TP2GgHiU+eQihBeEfVuFRp90uubztY+HE4BCvbUUSkM0tRXEt
	 P00GkYmQfhbHJeyF+GHxtKSD9bniUqVU5PD2xuOiyL/T1KA+IMMaF9RGuJewSlOsrq
	 /w0y+rp3Bed8/dSrh0DQ9Rqd3F0QXjEahXsZbv4TA0nRrpgbNDhH2FrYlt5jnn2yuu
	 Kfy5rdBtnOGIYmKEUt5C7QtwAZOrkRjmz38uYtITP2HkIfx6eEAnlhQvRpRN9CEP5E
	 +9ZSNzDwoXaoMaZFCyAztlwbhlgrf2VYO+Wj+f6P5LfZJRH+vA/QBr3S4vLGulwDm0
	 VQjaquL0FNRXQ==
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
Subject: [PATCH AUTOSEL 6.1 128/212] libbpf: Fix out-of-bound read
Date: Mon,  5 May 2025 19:05:00 -0400
Message-Id: <20250505230624.2692522-128-sashal@kernel.org>
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
index a0fb50718daef..98d5e566e0582 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1751,7 +1751,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
-- 
2.39.5


