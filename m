Return-Path: <bpf+bounces-31434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 995038FCCD0
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 14:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1841F2527A
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F8619E7C0;
	Wed,  5 Jun 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARxAxDU7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303719D093;
	Wed,  5 Jun 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588955; cv=none; b=Bnms1vMTKRRLB5VaX+eGKjYiYjXDTSx2Kei7sg/qubj0n7nkRY4QeR/GI8pFBgifkjXC+2b6A02bs9ik8FQtsXeAccNF+YCp3Cslba4Y4GPFIph+8UyzUQPR2an/AzkRbcJNsMg3BJlA1bvjEH2BXh8Q0dpcyT5Q6ajGMbH8yEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588955; c=relaxed/simple;
	bh=COGzjn+D3LiWcArqLiFkj+7bTilYrHec01cV8/bgp4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKewBMMCHaGiF+I6vZrxZotuPAPRHpyVYa901MaWacWHGiliaP7mmCRTk70dl08uJ/+hE6tZqZ8Z7cNS0cfPKvUK3TGyfpLj+Du97oxqjcd5dl79WhJ3LBt8geKUgg5DRX04aCIfWRblIZSTXleiwdLCrLYiRbmf1tGpKDZkvS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARxAxDU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8271C3277B;
	Wed,  5 Jun 2024 12:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588955;
	bh=COGzjn+D3LiWcArqLiFkj+7bTilYrHec01cV8/bgp4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ARxAxDU7a5aTuRVPK682CpZRqXoj5JFNPVH7QnM8SejumJu8CUMn2tZMNVRtCFCBP
	 z7PGfrJbGl3smeSD8BwalWtg6826Nu9YBudCFGhCS2fn8yY/8gA2scd9kLvg9cPjWg
	 2o1uhx7NvRL+FiPjE9nZA+shcEbgFt6UwGkWmyaK7IQWAyQgqlPeJLx7tqob4UA8s7
	 Dc/8/f5IxrKLn+e/5Yi1JQlsCHu5ZloiDtc8HjGtfFXQnTr/ZsSoAdC+Er3E3h6x6w
	 Omiq0mm7cZSHPONXD5huGwESORY35x28IkfPanJAhJXQ1Asin36YjiRA/aq9QwRN9Y
	 krcqbR4TD7NKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 08/23] libbpf: detect broken PID filtering logic for multi-uprobe
Date: Wed,  5 Jun 2024 08:01:51 -0400
Message-ID: <20240605120220.2966127-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 04d939a2ab229a3821f04fc81f7c027842f501f1 ]

Libbpf is automatically (and transparently to user) detecting
multi-uprobe support in the kernel, and, if supported, uses
multi-uprobes to improve USDT attachment speed.

USDTs can be attached system-wide or for the specific process by PID. In
the latter case, we rely on correct kernel logic of not triggering USDT
for unrelated processes.

As such, on older kernels that do support multi-uprobes, but still have
broken PID filtering logic, we need to fall back to singular uprobes.

Unfortunately, whether user is using PID filtering or not is known at
the attachment time, which happens after relevant BPF programs were
loaded into the kernel. Also unfortunately, we need to make a call
whether to use multi-uprobes or singular uprobe for SEC("usdt") programs
during BPF object load time, at which point we have no information about
possible PID filtering.

The distinction between single and multi-uprobes is small, but important
for the kernel. Multi-uprobes get BPF_TRACE_UPROBE_MULTI attach type,
and kernel internally substitiute different implementation of some of
BPF helpers (e.g., bpf_get_attach_cookie()) depending on whether uprobe
is multi or singular. So, multi-uprobes and singular uprobes cannot be
intermixed.

All the above implies that we have to make an early and conservative
call about the use of multi-uprobes. And so this patch modifies libbpf's
existing feature detector for multi-uprobe support to also check correct
PID filtering. If PID filtering is not yet fixed, we fall back to
singular uprobes for USDTs.

This extension to feature detection is simple thanks to kernel's -EINVAL
addition for pid < 0.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240521163401.3005045-4-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/features.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index a336786a22a38..3df0125ed5fa7 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -392,11 +392,40 @@ static int probe_uprobe_multi_link(int token_fd)
 	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_opts);
 	err = -errno; /* close() can clobber errno */
 
+	if (link_fd >= 0 || err != -EBADF) {
+		close(link_fd);
+		close(prog_fd);
+		return 0;
+	}
+
+	/* Initial multi-uprobe support in kernel didn't handle PID filtering
+	 * correctly (it was doing thread filtering, not process filtering).
+	 * So now we'll detect if PID filtering logic was fixed, and, if not,
+	 * we'll pretend multi-uprobes are not supported, if not.
+	 * Multi-uprobes are used in USDT attachment logic, and we need to be
+	 * conservative here, because multi-uprobe selection happens early at
+	 * load time, while the use of PID filtering is known late at
+	 * attachment time, at which point it's too late to undo multi-uprobe
+	 * selection.
+	 *
+	 * Creating uprobe with pid == -1 for (invalid) '/' binary will fail
+	 * early with -EINVAL on kernels with fixed PID filtering logic;
+	 * otherwise -ESRCH would be returned if passed correct binary path
+	 * (but we'll just get -BADF, of course).
+	 */
+	link_opts.uprobe_multi.pid = -1; /* invalid PID */
+	link_opts.uprobe_multi.path = "/"; /* invalid path */
+	link_opts.uprobe_multi.offsets = &offset;
+	link_opts.uprobe_multi.cnt = 1;
+
+	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_opts);
+	err = -errno; /* close() can clobber errno */
+
 	if (link_fd >= 0)
 		close(link_fd);
 	close(prog_fd);
 
-	return link_fd < 0 && err == -EBADF;
+	return link_fd < 0 && err == -EINVAL;
 }
 
 static int probe_kern_bpf_cookie(int token_fd)
-- 
2.43.0


