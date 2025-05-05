Return-Path: <bpf+bounces-57436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B029AAB08A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84A11BA691A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69A1684A4;
	Mon,  5 May 2025 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkcDbAgm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFD3C1975;
	Mon,  5 May 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487445; cv=none; b=NmWcuNgnIG+4yleGSZ4MKIs16A89BkCmZfG42yiLX4rLQoa8FoSG/YJeE38klGlNEJ07yXn/qqLukpnHTFDCow8Csrt2+LaIkNh3uKJ4BXtxQ5VbZoGcoWeKKQ6U0LVlMDGesOmVHGlrTbYwVdU4xF7S8rjVEYnrdDgwyFdk3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487445; c=relaxed/simple;
	bh=JXp0knaPzG6xN53hQ7Z79Bnj5oEJPGq0liZqj3Zx9Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=loVFNPt2Bf5isVAZWB9FvmrsCuRayUzNykdEnQnYxTAVzVl/Yvle5onhoepkjYSH3w0KZ+HSGYCKpg9VNEh/8Btpiq/8pqzPNFgFJ5uoS1INwuFI7KNY79+n4//Y0kKWJtmwvyqYOjS/3uPuKw/39EBHPsX8ruEqyo8U6OtjLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkcDbAgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B47FC4CEF1;
	Mon,  5 May 2025 23:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487443;
	bh=JXp0knaPzG6xN53hQ7Z79Bnj5oEJPGq0liZqj3Zx9Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkcDbAgmYs5Io0dk8XrNrNtw343UwpHIDSJWyzkomJmIC4CZ46mWiglIyZQ4YjlVh
	 lE/nlwIhRY6d/q22cWuCwFRiK7v+Z51rX9ZRJae1JNxlyDjam7MGMyZBLxxR2OvypY
	 tQqlV7MFkvazpsJ8fsbgqhnEJrFXzgEvnFIFKj9MV9PSLSjXdFUa7fnNvx0jFH3Jcl
	 oy8T3++j14UepomVLqiSNUTPJip5cUeU4vzJ683ZwhoTeUITlSryFiSNAkT6xP4fpm
	 9WNyBMj1w7uNM59NcvbcIcuDHCXkm9LUC4LQJ8ITN/XyoAnjvG1Mjut5+fjC15rbDQ
	 hTCyH3m+iGftw==
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
Subject: [PATCH AUTOSEL 5.4 75/79] bpftool: Fix readlink usage in get_fd_type
Date: Mon,  5 May 2025 19:21:47 -0400
Message-Id: <20250505232151.2698893-75-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index a209f53901b8c..91bf7575493b5 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -283,10 +283,11 @@ int get_fd_type(int fd)
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


