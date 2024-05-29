Return-Path: <bpf+bounces-30882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F608D41BC
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 01:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D361C217C1
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35571CB328;
	Wed, 29 May 2024 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu9zNryQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF715D5A0
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024336; cv=none; b=butFWYkDH5nV5UIlsthYllY1E31mRFk1pYo4BRYbrn95s0DLHvwwJA0uYr+3HbKcB5gnXXSIBLZBbxf9WkHruXlEgrtz0jDFc0XMDp3MmDKW5hS9cK8uinGZfPhjVWdgYmhU/b69AItJYPXaerastIfnEt2zaAWXkYGM/zHGXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024336; c=relaxed/simple;
	bh=+32/LizoB19WdCH85ik3H1a8OlDindoWcKrSm5ggcQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMP4LqM1lhU/S+JHQQ8l3qmRn5VM6N4WRNZXq7DpcrbQsbhbXUni2XUhLT09n5kmBcB3OrWzS8gwTb1mrEIITcsIn4f9dnYRpbowvExr0nC7n9AgbOGyESyeSNOULpN7xEM8Esunh1ZyRLG9/cUrXszj12k8FaPA0mo+zhtsfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu9zNryQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0455C113CC;
	Wed, 29 May 2024 23:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717024336;
	bh=+32/LizoB19WdCH85ik3H1a8OlDindoWcKrSm5ggcQY=;
	h=From:To:Cc:Subject:Date:From;
	b=Yu9zNryQtZbcB3mYhxteoLZ5bGcjARvyJpKYdv+BlGIydiVawHOif19VmFd25M1WT
	 LaVFNZXzo7iO5VsQl+Uao/AsTyjY1G4q9QMY2ltjXlo/UPOZQ1L88Zf2s5SnoVgZQo
	 B2pJ1kODTuFYg1GXwIHkmryyKphQin0uOrkc1dR/ZjzmW4zebfHVXWkq4KcsCf+wun
	 4zUaLUhUntY5+ciUn/mqlxKeGqDcRRMkJAw2iFTploQ3/+tmK/KYVqgC5kcVBsYy3B
	 o2xQ/7NWJ8CjaPuVOvlv1ABbr9NPefMlVBq9pgbBCtqq0uTos5fwtVZ9ZQQ9DkNcn8
	 jciI9BTjL+2Gw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf] libbpf: don't close(-1) in multi-uprobe feature detector
Date: Wed, 29 May 2024 16:12:12 -0700
Message-ID: <20240529231212.768828-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guard close(link_fd) with extra link_fd >= 0 check to prevent close(-1).

Detected by Coverity static analysis.

Fixes: 04d939a2ab22 ("libbpf: detect broken PID filtering logic for multi-uprobe")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/features.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 3df0125ed5fa..50befe125ddc 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -393,7 +393,8 @@ static int probe_uprobe_multi_link(int token_fd)
 	err = -errno; /* close() can clobber errno */
 
 	if (link_fd >= 0 || err != -EBADF) {
-		close(link_fd);
+		if (link_fd >= 0)
+			close(link_fd);
 		close(prog_fd);
 		return 0;
 	}
-- 
2.43.0


