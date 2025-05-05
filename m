Return-Path: <bpf+bounces-57445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC9AAB261
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB7179A70
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 04:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115E7428436;
	Tue,  6 May 2025 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezKPBSZB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BCA278750;
	Mon,  5 May 2025 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485743; cv=none; b=cbDLsTw5srnTz6D0Gk2H3lN0dKx8t7X0IDwtHFenpGlB3ZsST9YbhgAB8dqlg0oXAG2rATnrv2AFp4KlcyjHDpOBJRNBQpzy03ObnXZQZyJ+N1Ps4olPj3tGPChTFG5JVI+eTV/9ghclAhjbwVGFpt27G5Qe+ARDzTKrQ1rK00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485743; c=relaxed/simple;
	bh=4VF94PrXVRjvhxZctZCRwPwMl/OyynMcRvYM0Eb4v2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jAKVpl+zzgqlfYlblA6MnbP4BHwiFwtUqr1SmeeMtn0joxjwFpWvvOuSH6ZVPbhilbo+4WQVUu6Aux8B3PcgRXHTeqyY+y7DDcyfjsHQnpcVOoxseZptsn9mLRNTuVy4QZo9ZMZhtK/FwA7arpUshu/ug7OCEuriuY+QRb8n1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezKPBSZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAD3C4CEED;
	Mon,  5 May 2025 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485743;
	bh=4VF94PrXVRjvhxZctZCRwPwMl/OyynMcRvYM0Eb4v2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezKPBSZBbVwflYqVdXN/UBkXv+SGa/QsydJxoSxv3YJMcgrXZFEtxWyuKkLyXC+e4
	 S6HGxaVpaOJ6O5ayW44BDSU/R7OHAluqNw3sJS7ZplNg2kIFbxvJpacrfCtUGBHcb1
	 5A3BX2qTsMBEUT4c8/JST7YS03HpPk+YfnZl4TkN7AqNb8wFNGColYi2AVSXrkJGBZ
	 5cpj/2LFdKwQXAWd0IP7rqQrR7SK+cpfFShw0wcl276KODFMK1Qt7+uztTOlWF/zE/
	 ozDYx+K8Zhko4elH1RWwnJcIAic6cmo1PtdhzL9G4RRctJ6KOAmCTctpTtP1lgEpIc
	 jymxOqNdthezg==
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
Subject: [PATCH AUTOSEL 6.12 457/486] bpftool: Fix readlink usage in get_fd_type
Date: Mon,  5 May 2025 18:38:53 -0400
Message-Id: <20250505223922.2682012-457-sashal@kernel.org>
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
index 9b75639434b81..0a764426d9358 100644
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


