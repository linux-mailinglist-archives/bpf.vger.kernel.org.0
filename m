Return-Path: <bpf+bounces-57411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F31E9AAA791
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 02:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE43C188D50B
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 00:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D894933C55B;
	Mon,  5 May 2025 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMWTufbb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B733C54A;
	Mon,  5 May 2025 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484646; cv=none; b=Lltdmx1iXyuq6UCbN0cA+y43Ks/l7ZqfbJ8ZRuxJ+CA3bLJLcLw48qQqXkK3LizcuZGYhzSCieCK7PRYqGN+SmV/iPSIMsODPYXM3SDYLdHaZT5S8v9B3sxOwNBXk04iaCpXKHQMxzpR1pGEQWTj/+ck9lHnKUIn4AmNlHgELdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484646; c=relaxed/simple;
	bh=5LJNwUa06R4kZKORvykREbjT3Q5z5hRbd1bSLRbbWwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoOVAEVLSbgiwEmUzwpnS1L/NEWPyntJXxRh33zE03dAOae812UOxn4JM3/ZCxNVS4dYPlxDUBz0t2Ju9SStjXCtsTG+R2s2KQNMF1xSVnmZmfcbr+W0ABFxToKhq7OVkAnn+X2cAmqMXYeImoazlBna6hLoOjRHSfAhXI8DatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMWTufbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B24C4CEE4;
	Mon,  5 May 2025 22:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484646;
	bh=5LJNwUa06R4kZKORvykREbjT3Q5z5hRbd1bSLRbbWwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMWTufbb3onKsfOYL0jrwI/HpXk79yWMGDXENPYQQe3Ryt9t4OxWo14CxGmgElYLm
	 gCiQjrZeqzJXTtT/C996NL2oyUVvyJH4JvZyzlQ6A2bQ9QCA6uC0dwCosCg3tRI8Bz
	 PEgIWfnNxdehMq+5DBcYvDy+vpxoatn2I/nrWduWvK8a9GUtXNax3kRzXO/vn9AGT5
	 PJOnqLKy4BIMLX3Paz9HFmC/Z3MJMO1x/cUfYuKXef4FZAuSFdsDH025HMjf/+DYno
	 /mDAYtQddLaAUS2km6datgI2CKEz1DJsUJmabxXLMwGh0/bLoj4DzOYmL0zWiufNDa
	 xkkm1UzhmLDug==
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
Subject: [PATCH AUTOSEL 6.14 581/642] bpftool: Fix readlink usage in get_fd_type
Date: Mon,  5 May 2025 18:13:17 -0400
Message-Id: <20250505221419.2672473-581-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index b921231d602e4..ecfa790adc13f 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -461,10 +461,11 @@ int get_fd_type(int fd)
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


