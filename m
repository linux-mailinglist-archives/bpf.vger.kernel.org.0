Return-Path: <bpf+bounces-57452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F7BAAB49F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 07:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DBC5004FC
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272647F9AC;
	Tue,  6 May 2025 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXpR6j6y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF538AF29;
	Mon,  5 May 2025 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486785; cv=none; b=alsVhbB337PRVu4VWUyMKzIlT/JNcH5c2uZXR5fBZFQ1A5UpN4Maw1HqeLO8gftEnhJ8zb4Ff+yIRZ4hAbyDEwGRczMOHxA4kc3H3wktIcUAIxiqgDLnYEl3o2/XGlFhDUywrY5GY08IDYmD0mCVDSpi793Xs7S1NQNjGLBK7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486785; c=relaxed/simple;
	bh=PcV2BqE+9xprFjexaTeDNloDxBNETlh/ROLdahLehJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CR0Nzp1r73JTF3rNOkc4tSxBpVy5Eu4iYl3uUdsGAt+ySCl6ACBL7zKSwPsvijm2U/7l5roepRsKNywZdlDxz6EP2y5rVrdxUUAwhdw2ixAiQ+vw+oXH1h7JGjzMQtfqR6dw2IwE7o5kxfEWj94LW3p7dbkEGN//FPnxRFoPBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXpR6j6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F196BC4CEEF;
	Mon,  5 May 2025 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486784;
	bh=PcV2BqE+9xprFjexaTeDNloDxBNETlh/ROLdahLehJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXpR6j6ySd4cByBVTbK7pqYWGuVb5Djr3Rr77CV2Xdku3Nm3Fice2n61VAMX7hOIF
	 OZ2yiD+5ZHxqb8c5E02sfZSJwxdanZy1vLq+TjJeZburIPt7Fhy01l5EFyIDi8wtUj
	 Uxodpne8d9jViA/DsfY5wQW4b1QNin3/izYQM2vbSRRiM3djiutDJtnbRyhFShvv2h
	 WLpb+85PW/9iKsmL06/QMbvLdznxAE5V1kuL8UV0zMRwbUDMB5ATJJeFVcIKc8AFha
	 SEdokU4jUMSiQkNHGLsvTrbBEiQGOWw2uQejwR5D3OPwMDq9RnKgAuDwitD/QfVb5T
	 wJ2N0o/GzIfvQ==
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
Subject: [PATCH AUTOSEL 6.1 202/212] bpftool: Fix readlink usage in get_fd_type
Date: Mon,  5 May 2025 19:06:14 -0400
Message-Id: <20250505230624.2692522-202-sashal@kernel.org>
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
index db02b000fbebd..eea00bc15b5cc 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -384,10 +384,11 @@ int get_fd_type(int fd)
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


