Return-Path: <bpf+bounces-56351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AA4A95861
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02BD3A2F84
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1911221DBD;
	Mon, 21 Apr 2025 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlscQzeQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3421ADD3;
	Mon, 21 Apr 2025 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272137; cv=none; b=KANixgSeK8sozZAaZBZKZwO17CEUxXlJ5WenSZENzIcVz0qQu7jz0tRt+carbRe5NUV42KvbVTM0VCHkM3JYAudvPNa0uUUNTBGIFvHyVtH8lCEcm7ZeKdKw2U7jRzCdwhM2b116JS0C0lSQNJYVWKvPLyfRzE1FxWO7XsbwvbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272137; c=relaxed/simple;
	bh=Hm2/jQHfF1PjQvlOfp3fNR5vNrQhuRjESWnF+NZsiho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPcwfpY8SjOj0ITLJm569mPYY9/DrSZ+K6RemJTvp1rzTnApKZvmiHS7oj89zIpfNXLNZImXZbRHl5u3UTDCqk9KeP18b6rHb2hNRcjOnJSwgJ2ruzrXvbQ1sgNcsItEGv8zlvjO+Oi67+fFqs75t1o+UtwtEw1nNuY4q+EDpF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlscQzeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A283BC4CEE4;
	Mon, 21 Apr 2025 21:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272137;
	bh=Hm2/jQHfF1PjQvlOfp3fNR5vNrQhuRjESWnF+NZsiho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KlscQzeQu3ySIJ/BL6x7+31hh4A6und8d8ZzIFN8cei/Nzqq60CsfOwoWnTwRsAWs
	 nJbywcFIrNaoyAFAUJREk0gfMG4lblS2nO2LOezRkfXXkS9GXWkf/BSDs0RZ2CdwNK
	 Xcnrv7ohxZ3CmPMIydNJLarzs76W3Z8CHO2vH/8x+GbyeICfe/YO43RrrhGcYBHTa8
	 5DVOEiE2JgRPQGBU9TY3eLQ14pz3eNEeMpJaA2MtX5PtChMowDUeK2LL5FGuZuvPUH
	 /EGC6jOhizi57k2BMCOXHVL5rJN1EBT/Cqs+VvCgBs31nevTfjR+lKaER61mMrmXLd
	 1vawBDiKEWf9A==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 22/22] man2: Add uprobe syscall page
Date: Mon, 21 Apr 2025 23:44:22 +0200
Message-ID: <20250421214423.393661-23-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421214423.393661-1-jolsa@kernel.org>
References: <20250421214423.393661-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding man page for new uprobe syscall.

Cc: Alejandro Colomar <alx@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 man/man2/uprobe.2    | 49 ++++++++++++++++++++++++++++++++++++++++++++
 man/man2/uretprobe.2 |  2 ++
 2 files changed, 51 insertions(+)
 create mode 100644 man/man2/uprobe.2

diff --git a/man/man2/uprobe.2 b/man/man2/uprobe.2
new file mode 100644
index 000000000000..2b01a5ab5f3e
--- /dev/null
+++ b/man/man2/uprobe.2
@@ -0,0 +1,49 @@
+.\" Copyright (C) 2024, Jiri Olsa <jolsa@kernel.org>
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH uprobe 2 (date) "Linux man-pages (unreleased)"
+.SH NAME
+uprobe
+\-
+execute pending entry uprobes
+.SH SYNOPSIS
+.nf
+.B int uprobe(void);
+.fi
+.SH DESCRIPTION
+.BR uprobe ()
+is an alternative to breakpoint instructions
+for triggering entry uprobe consumers.
+.P
+Calls to
+.BR uprobe ()
+are only made from the user-space trampoline provided by the kernel.
+Calls from any other place result in a
+.BR SIGILL .
+.SH RETURN VALUE
+The return value is architecture-specific.
+.SH ERRORS
+.TP
+.B SIGILL
+.BR uprobe ()
+was called by a user-space program.
+.SH VERSIONS
+The behavior varies across systems.
+.SH STANDARDS
+None.
+.SH HISTORY
+TBD
+.P
+.BR uprobe ()
+was initially introduced for the x86_64 architecture
+where it was shown to be faster than breakpoint traps.
+It might be extended to other architectures.
+.SH CAVEATS
+.BR uprobe ()
+exists only to allow the invocation of entry uprobe consumers.
+It should
+.B never
+be called directly.
+.SH SEE ALSO
+.BR uretprobe (2)
diff --git a/man/man2/uretprobe.2 b/man/man2/uretprobe.2
index bbbfb0c59335..bb8bf4e32e5d 100644
--- a/man/man2/uretprobe.2
+++ b/man/man2/uretprobe.2
@@ -45,3 +45,5 @@ exists only to allow the invocation of return uprobe consumers.
 It should
 .B never
 be called directly.
+.SH SEE ALSO
+.BR uprobe (2)
-- 
2.49.0


