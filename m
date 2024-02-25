Return-Path: <bpf+bounces-22686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD6F862B3B
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096121C20E3D
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7E91BC35;
	Sun, 25 Feb 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+ySXoh7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064D14F90;
	Sun, 25 Feb 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874471; cv=none; b=jKSt1HU59bA88aurC9obX4VyAbX0dDlFGeHvRluM/WCb/sjuZ5RnayTuJkUlGwleH3LkWjXWy2JEpMDpS4Yi/ThdY0K/cjfhmifhsc4M/q5RI92mAL5bg6xcPb1L1n7gmHGcjklP8ZE6KeTzdZ8ixVZPb2iZ/DckaCYsjgfqHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874471; c=relaxed/simple;
	bh=AhqKrJz5NqAxQZJTxzvS35/o9mTQRDXLSjKOCvX5P6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXgdP45Lzg+WL3G3rRzbu6bCcKgXxp7hkWc1V3615Sn6GVh4x1ozFDDkgiqISsFw2huNbF1RZdp7YcwrSmXTN9ijXMCusQ4yCZu539pWjVA+YuFar+/U7cH8bgHDbeeNKBqZw2rHM4GLPCfBoA9r4t8D6G8maPUT3Wi7aMWvagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+ySXoh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33B2C433C7;
	Sun, 25 Feb 2024 15:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708874470;
	bh=AhqKrJz5NqAxQZJTxzvS35/o9mTQRDXLSjKOCvX5P6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q+ySXoh7HLvNE6hevB5iAblXR2ISEo6wUzvbtcHaXE187FKd5t4cvnVTgg4j8pX2l
	 QZHKQ7RSc04ZaIWA/gWoIrbHQhyfe7lYEm5E1RYigkD1mZk3uouMV07fQQfqv0/0Py
	 3F3Al2sxZx+9gewJo0P27JXAbt432ErqaNBD4lh+3hhiThrLL7H2B6ZAHAWBpNlMIh
	 BGXIM6lq3mhagovvdvvsvHviiQEFo+rH10ZcS00zg1pojmYV9dSMZCSjiRd0C9hWp0
	 zZ9ImQtXsih9NM0lfTzg6jcht7I1h+rsGCC5Sy4q1+sQLIMVrEE4iCBVEE4JN/qbmG
	 fUb1w+jq0Levw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH v8 33/35] selftests: ftrace: Remove obsolate maxactive syntax check
Date: Mon, 26 Feb 2024 00:21:05 +0900
Message-Id: <170887446544.564249.6300287188059065429.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170887410337.564249.6360118840946697039.stgit@devnote2>
References: <170887410337.564249.6360118840946697039.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the fprobe event does not support maxactive anymore, stop
testing the maxactive syntax error checking.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 20e42c030095..66516073ff27 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -16,9 +16,7 @@ aarch64)
   REG=%r0 ;;
 esac
 
-check_error 'f^100 vfs_read'		# MAXACT_NO_KPROBE
-check_error 'f^1a111 vfs_read'		# BAD_MAXACT
-check_error 'f^100000 vfs_read'		# MAXACT_TOO_BIG
+check_error 'f^100 vfs_read'		# BAD_MAXACT
 
 check_error 'f ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
 check_error 'f ^vfs_read+10'		# BAD_PROBE_ADDR


