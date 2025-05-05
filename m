Return-Path: <bpf+bounces-57422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE22AAAB1B
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601B33BD94F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A8138096F;
	Mon,  5 May 2025 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeY061rg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B738F182;
	Mon,  5 May 2025 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486126; cv=none; b=FV4ooqN1/f9/ecR2wJWPC699SaVhjtSHWtAb7PDcWyTh7QOcZJWnE44aNvDQ8bwOfJVx74C5o08qElKpG+HB61UkR+cGp8oem4+wW0bFYOO8jhDemYVSKTIH5UAT1AjPQ4dK6RfJeD7Rt+R/LA/bWU83LhDrdHu++6VBdO+KPfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486126; c=relaxed/simple;
	bh=ZZUXIkOSS3hS2GknXyh0OcagJMVn6bqVb1rlYQfWut0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7H79piIDDbvRSYLE7AaUoeyrkYdX5NjDIFU3UfYbWyjbzTnWm4lsq1YzfOhg5hCQAzEEvowiXhTbtOfh6u5GzeR/RCW34nZ8vdKKSJcW3g8sjhhbg+gFz7XJYxGcwByVeSJzdcViiYrqp81JnfnU4XzrlPwG+RA1popVyvJTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeY061rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44A7C4CEF1;
	Mon,  5 May 2025 23:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486125;
	bh=ZZUXIkOSS3hS2GknXyh0OcagJMVn6bqVb1rlYQfWut0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FeY061rg9/17Q27YvTvw2WzTt3ycF2HxCqhupfheopEJyS02coRmcT6f5EgFEJXsd
	 CXYF0G5YfxQVmcEq9b3d0aJVz9wa5BAY4geJbLbUdCikxC0Q52sVnB2IljFisrrOxp
	 Kw0ON0yY04z5JxEHDpVNuIWFoRtgItOuQmNq8Fsm0zny8Nwu45hs6VYlw1EZLDcUPN
	 NU3yXRbTxrsYXdOFxkDQLCzCRxzzbMfoWztxU7Pi+JIJM7BoX3zIYuSD89SZbqMq35
	 ZJ6X19TFMFUEeX3LZ4tviqW6yPWoOPHsxynKEJBiSn9WiIRSCfSJ7sDhCp3/StOayQ
	 hMT7FF95MxeQw==
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
Subject: [PATCH AUTOSEL 6.6 165/294] libbpf: Fix out-of-bound read
Date: Mon,  5 May 2025 18:54:25 -0400
Message-Id: <20250505225634.2688578-165-sashal@kernel.org>
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
index 2fad178949efe..fa2abe56e845d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1802,7 +1802,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
-- 
2.39.5


