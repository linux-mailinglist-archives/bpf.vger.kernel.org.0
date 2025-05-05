Return-Path: <bpf+bounces-57431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BA1AAAFEC
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3B3AE708
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA9D301147;
	Mon,  5 May 2025 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvdyx/lY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CACE3A91D5;
	Mon,  5 May 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487086; cv=none; b=Ewuh9hglnBtDCkr9Y1Y95CV7EgcaATPgWLPTsQOhuMdoTuVmcBemWia9XASCCyAZQq87wElOlytmWbydoFsLx/yB6f6kKQTHdDauds2iOAXq9Bmyz0FTnDRNlQDTBRMP3JKRE173Q4E5t6ktJTsERnRg4VfzRNth4X+Am/qiA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487086; c=relaxed/simple;
	bh=sCRF0bOX0We3UPuKxBWiR1cOc+j4HkGJU7wJ+k2QiZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g8BUZ35bYwbSlO+GIak2Wjgvmb7yDa2nYJ6tWYf8dSQGtffrOSZuLLa0WguAv7gCGe8G9VF9p1t2OmCLuYLhrdWqp6JVPYzy4Ucr0qV6KaBkcEtrLrRmaixcJLPJwMUft4lfomRhLICP7Q+y+JK+IhEncEELWr7UuogTfglCjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvdyx/lY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54627C4CEEF;
	Mon,  5 May 2025 23:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487085;
	bh=sCRF0bOX0We3UPuKxBWiR1cOc+j4HkGJU7wJ+k2QiZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvdyx/lYR2+554zg6e9D3o4UkPGPRVZQjcZj81o4Aoda1Hrhh/F0eaHSw9En1dv/r
	 IbqPiwGYb4Q+LkmBiCYdex0DW2O3mRV/i0L+afuk1ZNj5cwQVJAKDfJH5yJBKUom3y
	 CEH6p/ByrlAum5PhvZcG+AbthtwaR8xyIVtV+w/BJWdbIT3aVYLgtx/7HeHS3Dgrog
	 5U3S7+NFskXsOCAO65z4q1CpYlEPxi6hAa0PBl1jwb4lw0Gssdw/gL4otZGM65hNgV
	 ZmsmTplp3Y/lu+deJPybF5n6cENA+eM7+QbVmaKOfw6TzLs0ke9ZU/+xFaC6a6R41s
	 fDgJUFQXTs6PA==
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
Subject: [PATCH AUTOSEL 5.15 146/153] bpftool: Fix readlink usage in get_fd_type
Date: Mon,  5 May 2025 19:13:13 -0400
Message-Id: <20250505231320.2695319-146-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index e4c65d34fe74f..2b4773e00ab68 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -318,10 +318,11 @@ int get_fd_type(int fd)
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


