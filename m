Return-Path: <bpf+bounces-57456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6660BAAB7D8
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02C71C0608A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D7934C0F3;
	Tue,  6 May 2025 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekPXbpMi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14C2797A5;
	Mon,  5 May 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487301; cv=none; b=ssuyKpztii+zZMVg1DlgYMM5+ObwTYN9Uu3doNTsblBSmmz/q7XhmYGCcI4Eovo0iP2NeYx5lE90VZnynW+APKW08lLjylKosNvwu3+L40rqO9mWBu4KQKjLXpUxDW/PsJdVoju87ypz+v7C2Qk4RIB/QRDX7OFrHEofLdrhBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487301; c=relaxed/simple;
	bh=7wa+U1T31NJK/tUCaixLIQ5iCyGeLrmTTRl81nmcU0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MLx1UJklsLrlh2sYN4cfy/8qPJjWwXUcuw/gvcuwrwIQqeZv1uxa9z4IXD48f9aWYSk7cWqS12UK8SJXHnbKpJlxsgTeaQSxxEBxKgzxnnHSF5GMZ9dTHjkBjyp42dvkccq5cYROc7z5ewPtGrQBiYMbETIKCzks4IaIXwUI9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekPXbpMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A690C4CEF1;
	Mon,  5 May 2025 23:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487301;
	bh=7wa+U1T31NJK/tUCaixLIQ5iCyGeLrmTTRl81nmcU0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekPXbpMi+82v04am7vGk8qItbPRF0Jcm4WINAmZcTJLFqB9q/5vWl7Q6StWwB6OCV
	 9II1Fenrm7NZbtdiKWH3W9Z+//pwcRbBBDNu6HjZJMOIjscCmsPlg0+fWqY3tMWRPT
	 zkK5FIZwoTT+2PMFaiz7Yl6rnAsUsB480DFJt1HQXBTmipD0saKqosxcMkc/mrd5JA
	 F8KQuz19mXczOpllk2VuP6cHXwDXdSWOI3bwIT54SJCHmhL43uNtQXLS3f0AXTGb9T
	 PSyWT2ur7MUgv/11M+EXPJt32uZygGfrlbevM230cdZo1i08jSumsAH4/uT22TwkPa
	 wM4gYvLS2AEZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viktor Malik <vmalik@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 108/114] bpftool: Fix readlink usage in get_fd_type
Date: Mon,  5 May 2025 19:18:11 -0400
Message-Id: <20250505231817.2697367-108-sashal@kernel.org>
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

From: Viktor Malik <vmalik@redhat.com>

[ Upstream commit 0053f7d39d491b6138d7c526876d13885cbb65f1 ]

The `readlink(path, buf, sizeof(buf))` call reads at most sizeof(buf)
bytes and *does not* append null-terminator to buf. With respect to
that, fix two pieces in get_fd_type:

1. Change the truncation check to contain sizeof(buf) rather than
   sizeof(path).
2. Append null-terminator to buf.

Reported by Coverity.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20250129071857.75182-1-vmalik@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index eefa2b34e641a..33065b17900fa 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -311,10 +311,11 @@ int get_fd_type(int fd)
 		p_err("can't read link type: %s", strerror(errno));
 		return -1;
 	}
-	if (n == sizeof(path)) {
+	if (n == sizeof(buf)) {
 		p_err("can't read link type: path too long!");
 		return -1;
 	}
+	buf[n] = '\0';
 
 	if (strstr(buf, "bpf-map"))
 		return BPF_OBJ_MAP;
-- 
2.39.5


