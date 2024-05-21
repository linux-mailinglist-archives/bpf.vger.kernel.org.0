Return-Path: <bpf+bounces-30129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ED78CB23E
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055051C2158C
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE68148308;
	Tue, 21 May 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWwk3Cse"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239D143C60
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309254; cv=none; b=tf9NgZBjwwD8uCDjOoipj5fMfutsksoDmDMgjU5BoTSlN7a93xu0Bqs4HUJxDQ0xLkzlvAR02L9DI/WZIZ9bbSX+n5eR838lCIsKXuMU3GwFGMzDNqP7MCMpDzq8sR213+7cWBrklMtBBRYtwzj8QSZpXpcU2ISo9A5oHw4kW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309254; c=relaxed/simple;
	bh=DYO2gS09fDQpo2u4YCFEw0hE2Q7oztvr4HIeqjjNFVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkr+KJl9dqy6eqGhmOMd1Vi0Se7TWmQKpVUjogDBPa66m1oILnF29+MrE3je/Cy+vhkvYKNHB5sZl3oVXh4yJQQpy5r+g/3tk9lsDFpSldT2SepQ7guGAX38Mv9fTwy3IwApA/yH5bhUQfwa83PpF2014LS1/DSbcOgNdiPwi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWwk3Cse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4132CC2BD11;
	Tue, 21 May 2024 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716309254;
	bh=DYO2gS09fDQpo2u4YCFEw0hE2Q7oztvr4HIeqjjNFVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWwk3CseFxM1EPLPlgFiwcF3QGJoV4KBWgS/muGuDuvztPKtdaiVnf+eeyieXTeSH
	 iZGWogeSExjfCZblVLr0xAjlqxqR9AYdtHYz4SxBfmeo+APIJU2FCrgObX8Bgv8P/o
	 Jcd9SwK57NuAqpSzhS/8QPU9jNkMxbp5SmnVJ7Sem8dKpwTd4OZd1gVH3zmUdsyOiw
	 eJr1Z4iJ6ptg8PjWVAUxJsNVryB6V0XxnWS0s8w309gDN8Pdd/t4E8revVddumKoZy
	 Cxk9mgROEir54S/emHgXr+Lhtdoswnsl4wvPaEgHW61/C/59+rBIRX4syM5oiEoFSk
	 jUaPiaUDL6liA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf 3/5] libbpf: detect broken PID filtering logic for multi-uprobe
Date: Tue, 21 May 2024 09:33:59 -0700
Message-ID: <20240521163401.3005045-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521163401.3005045-1-andrii@kernel.org>
References: <20240521163401.3005045-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 tools/lib/bpf/features.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index a336786a22a3..3df0125ed5fa 100644
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


